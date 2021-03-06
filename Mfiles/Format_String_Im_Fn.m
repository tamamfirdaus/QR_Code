%%%%%%%%%% Amirsina Torfi ######################
%%%%%%%%%%% University of Maryland, Colledge Park %%%%%%%%%%%%%%
%%%%%%%%%% Digital Image and Video Processing %%%%%%%%%%%%%%%%%
%%% function [ Mask_pat_Num,Error_Recov_Type ] = Format_String_Im_Fn( img )
% Inputs :
% img: Input is the QR exact matrix(for example which is 41by41 for version6)


% Outputs :
% Mask_pat_Num: The number of mask pattern(it is necessarry for demasking)
% Error_Recov_Type: Error recovery level which is necessarry for
% decoding and error correction procedure

function [ Mask_pat_Num,Error_Recov_Type ] = Format_String_Im_Fn( img )
global module
%% Find Format String
%% Format string place in two parts of the QR(one of them behind the upper-left finder pattern)
% First
for j=1:9
    F(1,j) = img(9,j);
end
for i=1:8
    F(1,j+i) = img(9-i,9);     % F becomes pattern [14 13 12 11 ...] of the format string
end
% Second place(half top of the down-left finder pattern and other half behinf of the top-right finder pattern)
for i=1:8
    H(1,i) = img(module-i+1,9);
end
for j=1:8
    H(1,j+i) = img(9,module-8+j);     % F becomes pattern [14 13 12 11 ...] of the format string
end

F(isnan(F))=[];
H(isnan(H))=[];
st1 = mod(F+1,2);       % Because according to standard black is binary 1!! and white is binary zero !! but from the beginning our assumptions were different
st2 = mod(H+1,2);


% different formati string sequences(after XOR with 15-bit standard sequence)
TB1= [1 1 1 0 1 1 1 1 1 0 0 0 1 0 0;
    1 1 1 0 0 1 0 1 1 1 1 0 0 1 1;
    1 1 1 1 1 0 1 1 0 1 0 1 0 1 0;
    1 1 1 1 0 0 0 1 0 0 1 1 1 0 1;
    1 1 0 0 1 1 0 0 0 1 0 1 1 1 1;
    1 1 0 0 0 1 1 0 0 0 1 1 0 0 0;
    1 1 0 1 1 0 0 0 1 0 0 0 0 0 1;
    1 1 0 1 0 0 1 0 1 1 1 0 1 1 0;
    1 0 1 0 1 0 0 0 0 0 1 0 0 1 0;
    1 0 1 0 0 0 1 0 0 1 0 0 1 0 1;
    1 0 1 1 1 1 0 0 1 1 1 1 1 0 0;
    1 0 1 1 0 1 1 0 1 0 0 1 0 1 1;
    1 0 0 0 1 0 1 1 1 1 1 1 0 0 1;
    1 0 0 0 0 0 0 1 1 0 0 1 1 1 0;
    1 0 0 1 1 1 1 1 0 0 1 0 1 1 1;
    1 0 0 1 0 1 0 1 0 1 0 0 0 0 0;
    0 1 1 0 1 0 1 0 1 0 1 1 1 1 1;
    0 1 1 0 0 0 0 0 1 1 0 1 0 0 0;
    0 1 1 1 1 1 1 0 0 1 1 0 0 0 1;
    0 1 1 1 0 1 0 0 0 0 0 0 1 1 0;
    0 1 0 0 1 0 0 1 0 1 1 0 1 0 0;
    0 1 0 0 0 0 1 1 0 0 0 0 0 1 1;
    0 1 0 1 1 1 0 1 1 0 1 1 0 1 0;
    0 1 0 1 0 1 1 1 1 1 0 1 1 0 1;
    0 0 1 0 1 1 0 1 0 0 0 1 0 0 1;
    0 0 1 0 0 1 1 1 0 1 1 1 1 1 0;
    0 0 1 1 1 0 0 1 1 1 0 0 1 1 1;
    0 0 1 1 0 0 1 1 1 0 1 0 0 0 0;
    0 0 0 0 1 1 1 0 1 1 0 0 0 1 0;
    0 0 0 0 0 1 0 0 1 0 1 0 1 0 1;
    0 0 0 1 1 0 1 0 0 0 0 1 1 0 0;
    0 0 0 1 0 0 0 0 0 1 1 1 0 1 1];
%% Format string place in two parts of the QR(one of them behind the upper-left finder pattern)
h1=0;       
for k=1:size(TB1,1)
    m=0;
    for j=1:size(TB1,2)
        if TB1(k,j) == st1(1,j)
            m=m+1;
        end
    end
    if m == 15
        h1=k;
    end
end
% Second place(half top of the down-left finder pattern and other half behinf of the top-right finder pattern)
h2=0;
for k=1:size(TB1,1)
    m=0;
    for j=1:size(TB1,2)
        if TB1(k,j) == st2(1,j)
            m=m+1;
        end
    end
    if m == 15
        h2=k;
    end
end

TB2= ['L';
    'L';
    'L';
    'L';
    'L';
    'L';
    'L';
    'L';
    'M';
    'M';
    'M';
    'M';
    'M';
    'M';
    'M';
    'M';
    'Q';
    'Q';
    'Q';
    'Q';
    'Q';
    'Q';
    'Q';
    'Q';
    'H';
    'H';
    'H';
    'H';
    'H';
    'H';
    'H';
    'H'];


TB3= [0;
    1;
    2;
    3;
    4;
    5;
    6;
    7;
    0;
    1;
    2;
    3;
    4;
    5;
    6;
    7;
    0;
    1;
    2;
    3;
    4;
    5;
    6;
    7;
    0;
    1;
    2;
    3;
    4;
    5;
    6;
    7];


%% Extract from one of the locations(both should be equal if not on of them might be corrupted and the healthy one would be choose by the following algorithm)
if h2~=0
    Error_Recov_Type=TB2(h2,1);
    Mask_pat_Num = TB3(h2,1);
    
elseif h1~=0
    Error_Recov_Type=TB2(h1,1);
    Mask_pat_Num = TB3(h1,1);
    
else
    Error_Recov_Type = nan;
    Mask_pat_Num = nan;
end

end


