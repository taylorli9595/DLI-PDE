clear all
close all
clc
% addpath('datanoise')
addpath('Set12','noiseimage')

image_sp = {'01','02','03','04','05','06','07','08','09','10','11','12'};
%image_sp = {'08','09','10','11','12'};
p = load('M1_50.txt');
sigma=[50]
randn('seed', 0);
reset(RandStream.getGlobalStream);
for i=1:length(image_sp)
    for j=1:length(sigma)  
     sig       =   sigma(j);  
     path1 = sprintf('%s_In_sig%d.mat',image_sp{i},sigma(j))
     data = load(path1);
     In      =   data.In;
     Io     =    data.Io;   
     img_path1 = sprintf('%s_In_sig%dDnCNN.txt',image_sp{i},sigma(j))
     Us1 = load(img_path1);
        tau=0.2;
%         N=80;
%         K = 8.5;
%         K1 = K + 0.1*m;
p(i,2)
p(i,3)
%        [Imssim,ImMAE,PSNRR,J_proposed]=diffusion_PM(Io,In,p(i,2),tau,p(i,3));
        %[Imssim,ImMAE,PSNR,J]=diffusion_OPM(I0,In,N,tau,K1);
        [ImSSIM,ImMAE,PSNRR,J_proposed]=modle_1(Io,In,Us1,p(i,2),tau,p(i,3));

        SSIM1(:,i) = cal_ssim( J_proposed, Io ,3, 3);

        PSNR1(:,i) = max(PSNRR);


        fprintf('Denoising image %3d\tPSNR: %.3f\n',i,PSNR1);
        image_M1=sprintf('%s_sig%d_M1.png',image_sp{i},sigma(j));
        imwrite(uint8(J_proposed),image_M1);


    end
end
% mean(psnrmax(:,1));
save('psnr_ssim.mat','PSNR1', 'SSIM1')


