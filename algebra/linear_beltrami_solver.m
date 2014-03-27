function [uv_new,mu_new] = linear_beltrami_solver(face,uv,mu,landmark,target)
A = generalized_laplacian(face,uv,mu);
b = -A(:,landmark)*target;
b(landmark,:) = target;
A(landmark,:) = 0; 
A(:,landmark) = 0;
A = A + sparse(landmark,landmark,ones(length(landmark),1), size(A,1), size(A,2));
uv_new = A\b;
mu_new = compute_bc(face,uv,uv_new);
