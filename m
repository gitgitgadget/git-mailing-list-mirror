Received: from mx0b-00169c01.pphosted.com (mx0b-00169c01.pphosted.com [67.231.156.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6584683
	for <git@vger.kernel.org>; Sun, 25 May 2025 14:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748184372; cv=none; b=jl5FuaxbziRqnWuWQQCzJ65ArnHS7ohMFchHmbY5SXFl29H06jDEFVliraVpiNw+TBDX+kKoGDIwvzcT4uhwlzw3gfA+WEEMi49V9eOlgU+iWUgaW8ltU5H5nGkgq5FgXVJItW3NBmIaVkkqfQ8XtZdOSl3gtt18ZvD5xUkPJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748184372; c=relaxed/simple;
	bh=PSGfCq91nTFwxVzaViDZA9kas4BkG4d+3MaPywNPbJI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JjloQE1LOySe/6s5MBEiRA2ztf6eEx/jlHGN2uVWT7klkXvJy7nlmRxWWOgDlPk9iBgdlteO0t6ecWRj2FdkgD1H9pzVAWyMtwjK7aPrrYPW1z02JFm6FrzyONj3DIyg67vSNmvQ92XyyAUPPTKqYta2G0r3wKJJx+AYuZGfNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com; spf=pass smtp.mailfrom=paloaltonetworks.com; dkim=pass (2048-bit key) header.d=gtest.emaildlpdev.com header.i=@gtest.emaildlpdev.com header.b=Z4UlO63Q; dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b=mZxZV0cq; dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b=cDwlQ4+n; arc=none smtp.client-ip=67.231.156.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paloaltonetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paloaltonetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gtest.emaildlpdev.com header.i=@gtest.emaildlpdev.com header.b="Z4UlO63Q";
	dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="mZxZV0cq";
	dkim=pass (2048-bit key) header.d=paloaltonetworks.com header.i=@paloaltonetworks.com header.b="cDwlQ4+n"
Received: from pps.filterd (m0048189.ppops.net [127.0.0.1])
	by mx0b-00169c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54P9Ubk5032605
	for <git@vger.kernel.org>; Sun, 25 May 2025 07:13:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	gtest.emaildlpdev.com; h=content-type:date:from:message-id
	:mime-version:subject:to; s=panwdlp; bh=PSGfCq91nTFwxVzaViDZA9ka
	s4BkG4d+3MaPywNPbJI=; b=Z4UlO63QgFLVOMXP2A9VHEM4nsMqbNEHJwwWNOvA
	GMM5YcgXX70HX8Di3hKCORA7ZNWGUvYMw8EklScxg9rJPfWzZo04bzkNcvQmCepC
	mspR5FgXIPTiBEp2mrX14zdwc3aWJ2LZ5aN3YM+04spi9BlZ5vhNQYO3HH1cMYXr
	4pM+1g2JrbajPW+h/zA2jSSQHUkxvMzVo2qQ2Xm59LujpemafWasFcPAfGiZ17j1
	KhTy1xfs53Hr+q5xeQV4ejBy+9lcbIV4bPkURvorO25eZ9SJI50YhTeFLDiRcN2w
	L3PBxfPv+YePzlJ46wtBHfMeGWFUhvy8BvdJDb4xZyKdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	paloaltonetworks.com; h=content-type:date:from:message-id
	:mime-version:subject:to; s=PPS12012017; bh=PSGfCq91nTFwxVzaViDZ
	A9kas4BkG4d+3MaPywNPbJI=; b=mZxZV0cq3cofB8h4c9Py8D7f0Xy9YckF7jWr
	fWtCnHzVIZDICsMMG1vwrgNT1JvhUBKZD2wE1FctsxVe9zjJNutvo+cTJBgiw8/y
	CkHqLQRdMmH10wg1AXraCyrIqqqWW56vkxCEhN3HnGYY9LzVjzgg0r6/ZudHYab9
	4Tz3ESNsyVDuxEBF8pGTJYOyVO8f8D/5LcVnv1eeIn/CpakHET2LgA8ZhCwAd4SX
	2D2QwhbY1FWQixMY0fLJmPG+4Jr871lHhcurXvipe+3OqWM1TPG3WNCDUcEhsKdS
	XLVm25R2q72dK3FahNDPCb+BWMIchUyzZ5xflvURtMthMDkbrw==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0b-00169c01.pphosted.com (PPS) with ESMTPS id 46udm6k680-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Sun, 25 May 2025 07:13:43 -0700 (PDT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70df446e876so24927907b3.0
        for <git@vger.kernel.org>; Sun, 25 May 2025 07:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paloaltonetworks.com; s=google.paloaltonetworks.com; t=1748182422; x=1748787222; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PSGfCq91nTFwxVzaViDZA9kas4BkG4d+3MaPywNPbJI=;
        b=cDwlQ4+nTKT3WTjxgOAyYpDglglDyyi9HZhsceXwtkPibu7PF1/DPttFLHtrcnqjpP
         RV6b6oR7y3SUrIATq8Z4L3GCPzFV8KkhYRPHKqGO8v1mpnP6f+cnlnes+ESWiniwU9xt
         2UveBfeAy+OthE1clUpjL0sTZRWZYeG6JZDfBLM5KKZfIc5qKS7uypeXWzGcyxLiE9p+
         n3MLVn1/X5WkA1IognDWE5o29HApDxOzwxCVtnuJGziMmZMRvJ/y7c31grpAli2Cd1wq
         444p6rK9S+nd1sLwgdQVDWkMgTShO5XhwWpZqVhoH7SwcATxuYWdJf7KMBo3nY2BWR5Q
         XDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748182422; x=1748787222;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSGfCq91nTFwxVzaViDZA9kas4BkG4d+3MaPywNPbJI=;
        b=o7UAnAFn+u1u1ZjqMbMhl0wiHPN5bA6LsIrRiv5pP6q1iXfZW9PnjqY87s4ZO7Kbah
         H0sFDRSdiOTIewpwiQFNfBEgvcanJdcxWbMASEmCix9GGtCtI5aM7obPvzHuoyG/nzaI
         fu62CdFcgaH5fWay1pK6KfM2W44NOPY9+nz2YOXDK3bdYfEpgBJBwrN3fvL90on6yGfU
         w81tQhh+qX76+92EGKuHw3qAQrHGVmUhe5GXzTZAKavfI8/kcyBKUqXrN8wvu1W0aIYy
         44q5lLukTRx7IQ9OEZNViz1BEJwew4GFhlKQ8QpeD9yfXHu5e0B7P0hAVcrw2trySuuC
         AAVQ==
X-Gm-Message-State: AOJu0YyV3YMhS+obfLlo9Vow7JrZGorm6G+nDBtV4Im98N6t0hK+SVFn
	xb7vTG/0SvOe1N2c3OxH9XvKLg0lY2CAvgtSpeMla7Ei0N/OLUETn/nsTv2P9dkesT76iyeNMln
	PpYRHJBgsYpRGOVG8Xy9v/aINMRR/RbqdAATUeHee5UobZDzd1QeXoWDpVbR9PjYu0eKN8SuRz4
	37zQkf3+oLvwJ3BhbOxGxnrlIml0mv/FdMISOCI8U=
X-Gm-Gg: ASbGncsAdeYmqnfgoPhRuqzuwQyaAlL9J1wGa4JoAUnbfgt8krwyWa1EJ7ZEWOwNWgF
	Hl3T2mb8js8CzsKM6SBtK6dY2/kBMXAqiHlCJdd3bOvfo4bOCbDoPNrIJVKRiktLw5KXWoA==
X-Received: by 2002:a05:690c:6288:b0:703:b47a:7312 with SMTP id 00721157ae682-70e2cc54c90mr61550857b3.15.1748182422229;
        Sun, 25 May 2025 07:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCUEWoLha8q9G/w+MCc5A5e9rG3Dqzbf5p1W34bVqARN/DoZ2C351MPCC/sWU+wcwp4lKVJsK2Ya9RIwTqoho=
X-Received: by 2002:a05:690c:6288:b0:703:b47a:7312 with SMTP id
 00721157ae682-70e2cc54c90mr61550627b3.15.1748182421870; Sun, 25 May 2025
 07:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yonatan Roth <yroth@paloaltonetworks.com>
Date: Sun, 25 May 2025 17:13:30 +0300
X-Gm-Features: AX0GCFv-XaUU6fw0Gix1lySS0O2tshwkgoEd_37jGsh1lVK6LIjE1qUWTsjqXUg
Message-ID: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
Subject: ISSUE - Sequential execution failure - Lock auto created between git commands
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000431ea00635f6700b"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI1MDEzMSBTYWx0ZWRfXx6PbD1omgH1g gAVAvmQOMGw/mLj0EHgCgaKMVNYihdot3BCVUNjEOiVLcDV2+Ula8YroIJTtHipfAjFI56vpSUN /JWLcdEX9jQeTJdUQ1+6Cj49V/c5bddY2XI8i7z0e4c+4DADXigQ3RZpymMqt7vkj+KEIkzeCb4
 bGXu0OzuDMlk8qoG/P0r7k5bEUL5NaV9G+Wvuz86WF0wcbWKxxtqD0d/1Wm3T64U27A59hMYlDx VlEWtt9rm5nIj6ruIK8CXaVOAk/NsCHUlvXnmnLXkU0DURT6/KfFCTR+G1+N0u/qw4vqejxNQqF n0fsareJ9zaoPDUzB0csw4XuA5oLh/EFnS/7HSBZYMKXiHWmvDFtXGKgFnC89T5tBZ7u7eDtHsh
 XsSghoA71MfmI2og0r4zUzUKgCQyvelv38ngGM5qgIlyDeS5cNZ8ToNpqtG1Hs2MTZEemxbK
X-Proofpoint-ORIG-GUID: PqQvGUu6xN6GiwQ6__pN1RSgF4YRXZXM
X-Authority-Analysis: v=2.4 cv=Zp3tK87G c=1 sm=1 tr=0 ts=68332597 cx=c_pps a=0mLRTIufkjop4KoA/9S1MA==:117 a=dt9VzEwgFbYA:10 a=bx0yk3aoy5EA:10 a=BroVbnHxh2rjp3QAcLIA:9 a=QEXdDO2ut3YA:10 a=F_lHtKWMV5agRiRyRgsA:9 a=5ravA__WFRVXFabt:21 a=XRzbzrBOJSnW-ypgALEA:9
 a=CjuIK1q_8ugA:10 a=m-Z_27IZkzAA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-GUID: PqQvGUu6xN6GiwQ6__pN1RSgF4YRXZXM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-25_05,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505250131

--000000000000431ea00635f6700b
Content-Type: multipart/alternative; boundary="000000000000431e9f0635f67009"

--000000000000431e9f0635f67009
Content-Type: text/plain; charset="UTF-8"

Hi,


Using a script we run the following set of git commands:

git branch -a

git remote -v

git stash push --all --include-untracked

git checkout test_git_ver

git remote -v

git fetch

git status --branch --porcelain=v1 -u

git checkout test_git_ver_workspace




After upgrading the git version to - *2.47.2*, we started getting the
following error:

error: cannot lock ref 'HEAD': Unable to create '.../.git/*HEAD.lock*':
File exists.


Another git process seems to be running in this repository, e.g.

an editor opened by 'git commit'. Please make sure all processes

are terminated then try again. If it still fails, a git process

may have crashed in this repository earlier:

remove the file manually to continue.

fatal: unable to update HEAD




Investigating the issue on our side, we found that the failure occurs when
running the last command -
git checkout test_git_ver_workspace.

As well, we noticed that after the "git fetch" command there is an *auto *
*maintenance* execution, it looks like there was a change between git
versions and now there is an additional flag *--detach *added to
maintenance.
Therefore, we suspect that as a result of git fetch a maintenance detached
(background) process is created, running in parallel to the general script,
creating a lock file that fails the script.


Attached trace logs.


This script was running for multiple versions without any issue, it looks
like the changes introduce a *regression*.

Please assist in resolving the issue.




Best regards,
Yonatan Roth
Palo Alto Networks

--000000000000431e9f0635f67009
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div><br></div><div><font col=
or=3D"#000000">Using a script we run the following=C2=A0set of git commands=
</font>:</div><div><br></div><div><p style=3D"margin:0px;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-variant-alternates:normal;fon=
t-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stre=
tch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Ne=
ue&quot;">git branch -a</p><p style=3D"margin:0px;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-=
adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:nor=
mal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot=
;">git remote -v</p><p style=3D"margin:0px;font-variant-numeric:normal;font=
-variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:=
none;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;fon=
t-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">git =
stash push --all --include-untracked</p><p style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;fon=
t-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvet=
ica Neue&quot;">git checkout test_git_ver</p><p style=3D"margin:0px;font-va=
riant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates=
:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:norma=
l;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;H=
elvetica Neue&quot;">git remote -v</p><p style=3D"margin:0px;font-variant-n=
umeric:normal;font-variant-east-asian:normal;font-variant-alternates:normal=
;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-=
stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetic=
a Neue&quot;">git fetch</p><p style=3D"margin:0px;font-variant-numeric:norm=
al;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-=
adjust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:nor=
mal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot=
;">git status --branch --porcelain=3Dv1 -u</p><p style=3D"margin:0px;font-v=
ariant-numeric:normal;font-variant-east-asian:normal;font-variant-alternate=
s:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings:norm=
al;font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;=
Helvetica Neue&quot;">git checkout test_git_ver_workspace</p><p style=3D"ma=
rgin:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-va=
riant-alternates:normal;font-size-adjust:none;font-kerning:auto;font-featur=
e-settings:normal;font-stretch:normal;font-size:13px;line-height:normal;fon=
t-family:&quot;Helvetica Neue&quot;"><br></p></div><div><div><br></div></di=
v><div><br></div><div>After upgrading=C2=A0the git version to -=C2=A0<span =
style=3D"font-size:13px;font-family:&quot;Helvetica Neue&quot;"><b>2.47.2</=
b>, we started getting the following error:</span></div><div><span style=3D=
"font-family:&quot;Helvetica Neue&quot;;font-size:13px"><br></span></div><d=
iv><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asi=
an:normal;font-variant-alternates:normal;font-size-adjust:none;font-kerning=
:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-=
height:normal;font-family:&quot;Helvetica Neue&quot;">error: cannot lock re=
f &#39;HEAD&#39;: Unable to create &#39;.../.git/<b>HEAD.lock</b>&#39;: Fil=
e exists.</p><p style=3D"margin:0px;font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-variant-alternates:normal;font-size-adjust:none;fo=
nt-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-size:=
13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;;min-height:1=
5px"><br></p><p style=3D"margin:0px;font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-variant-alternates:normal;font-size-adjust:none;fo=
nt-kerning:auto;font-feature-settings:normal;font-stretch:normal;font-size:=
13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;">Another git=
 process seems to be running in this repository, e.g.</p><p style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;font-size-adjust:none;font-kerning:auto;font-feature-se=
ttings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-fa=
mily:&quot;Helvetica Neue&quot;">an editor opened by &#39;git commit&#39;. =
Please make sure all processes</p><p style=3D"margin:0px;font-variant-numer=
ic:normal;font-variant-east-asian:normal;font-variant-alternates:normal;fon=
t-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-stre=
tch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvetica Ne=
ue&quot;">are terminated then try again. If it still fails, a git process</=
p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asia=
n:normal;font-variant-alternates:normal;font-size-adjust:none;font-kerning:=
auto;font-feature-settings:normal;font-stretch:normal;font-size:13px;line-h=
eight:normal;font-family:&quot;Helvetica Neue&quot;">may have crashed in th=
is repository earlier:</p><p style=3D"margin:0px;font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-a=
djust:none;font-kerning:auto;font-feature-settings:normal;font-stretch:norm=
al;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;=
">remove the file manually to continue.</p><p style=3D"margin:0px;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:n=
ormal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;=
font-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Hel=
vetica Neue&quot;">fatal: unable to update HEAD</p><p style=3D"margin:0px;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;font-variant-alte=
rnates:normal;font-size-adjust:none;font-kerning:auto;font-feature-settings=
:normal;font-stretch:normal;font-size:13px;line-height:normal;font-family:&=
quot;Helvetica Neue&quot;"><br></p><div><br></div><div><br></div><div>Inves=
tigating the issue on our side, we found that the failure occurs when runni=
ng the last command -=C2=A0</div><div><span style=3D"font-family:&quot;Helv=
etica Neue&quot;;font-size:13px">git checkout test_git_ver_workspace.</span=
></div><div><br></div><div>As well, we noticed that after the &quot;git fet=
ch&quot; command there is an=C2=A0<b>auto=C2=A0</b><span style=3D"font-size=
:13px;font-family:&quot;Helvetica Neue&quot;"><b>maintenance</b>=C2=A0execu=
tion, it looks like there was a change between git versions and now there i=
s an additional flag=C2=A0</span><b><span style=3D"font-family:&quot;Helvet=
ica Neue&quot;;font-size:13px">--detach=C2=A0</span></b><span style=3D"font=
-size:13px;font-family:&quot;Helvetica Neue&quot;">added to=C2=A0</span><sp=
an style=3D"font-size:13px;font-family:&quot;Helvetica Neue&quot;">maintena=
nce.</span></div><div><font face=3D"Helvetica Neue">Therefore, we suspect t=
hat as a result of git fetch a=C2=A0</font><span style=3D"font-family:&quot=
;Helvetica Neue&quot;;font-size:13px">maintenance detached (background) pro=
cess is created, running in parallel to the general script, creating a lock=
 file that fails the script.</span></div><div><span style=3D"font-family:&q=
uot;Helvetica Neue&quot;;font-size:13px"><br></span></div><div><span style=
=3D"font-family:&quot;Helvetica Neue&quot;;font-size:13px"><br></span></div=
><div><div>Attached trace logs.</div></div></div><div><br></div><div><br></=
div><div><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;font-size-adjust:none;font-k=
erning:auto;font-feature-settings:normal;font-stretch:normal;font-size:13px=
;line-height:normal;font-family:&quot;Helvetica Neue&quot;">This script was=
 running for multiple versions without any issue, it looks like the changes=
 introduce a=C2=A0<b>regression</b>.</p><p style=3D"margin:0px;font-variant=
-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:norm=
al;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;fon=
t-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helvet=
ica Neue&quot;">Please assist in resolving the issue.</p><p style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-varian=
t-alternates:normal;font-size-adjust:none;font-kerning:auto;font-feature-se=
ttings:normal;font-stretch:normal;font-size:13px;line-height:normal;font-fa=
mily:&quot;Helvetica Neue&quot;"><br></p><p style=3D"margin:0px;font-varian=
t-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:nor=
mal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;fo=
nt-stretch:normal;font-size:13px;line-height:normal;font-family:&quot;Helve=
tica Neue&quot;"><br></p><p style=3D"margin:0px;font-variant-numeric:normal=
;font-variant-east-asian:normal;font-variant-alternates:normal;font-size-ad=
just:none;font-kerning:auto;font-feature-settings:normal;font-stretch:norma=
l;font-size:13px;line-height:normal;font-family:&quot;Helvetica Neue&quot;"=
><br></p><p style=3D"margin:0px;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-variant-alternates:normal;font-size-adjust:none;font-k=
erning:auto;font-feature-settings:normal;font-stretch:normal;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;">Best regards,<br>Yonatan Roth<=
br>Palo Alto Networks</p></div></div>

--000000000000431e9f0635f67009--
--000000000000431ea00635f6700b
Content-Type: text/plain; charset="US-ASCII"; name="trace.txt"
Content-Disposition: attachment; filename="trace.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mb3qn6h40>
X-Attachment-Id: f_mb3qn6h40

VHJhY2UgbG9nczoKCgoxMjo1NDo1Mi40MDA4NjkgcnVuLWNvbW1hbmQuYzo2NjYgICAgICAgdHJh
Y2U6IHJ1bl9jb21tYW5kOiBnaXQgcmV2LWxpc3QgLS1vYmplY3RzIC0tc3RkaW4gLS1ub3QgLS1l
eGNsdWRlLWhpZGRlbj1mZXRjaCAtLWFsbCAtLXF1aWV0IC0tYWx0ZXJuYXRlLXJlZnMKCjEyOjU0
OjUyLjQwMDkzNiBydW4tY29tbWFuZC5jOjc1OCAgICAgICB0cmFjZTogc3RhcnRfY29tbWFuZDog
L3Vzci9sb2NhbC9saWJleGVjL2dpdC1jb3JlL2dpdCByZXYtbGlzdCAtLW9iamVjdHMgLS1zdGRp
biAtLW5vdCAtLWV4Y2x1ZGUtaGlkZGVuPWZldGNoIC0tYWxsIC0tcXVpZXQgLS1hbHRlcm5hdGUt
cmVmcwoKMTI6NTQ6NTIuNDgzMzI5IHJ1bi1jb21tYW5kLmM6MTUzNCAgICAgIHJ1bl9wcm9jZXNz
ZXNfcGFyYWxsZWw6IHByZXBhcmluZyB0byBydW4gdXAgdG8gMSB0YXNrcwoKMTI6NTQ6NTIuNDgz
Mzg0IHJ1bi1jb21tYW5kLmM6MTU2MSAgICAgIHJ1bl9wcm9jZXNzZXNfcGFyYWxsZWw6IGRvbmUK
CjEyOjU0OjUyLjQ4MzM5NSBydW4tY29tbWFuZC5jOjY2NiAgICAgICB0cmFjZTogcnVuX2NvbW1h
bmQ6IGdpdCBtYWludGVuYW5jZSBydW4gLS1hdXRvIC0tbm8tcXVpZXQgLS1kZXRhY2gKCjEyOjU0
OjUyLjQ4MzQ3NSBydW4tY29tbWFuZC5jOjc1OCAgICAgICB0cmFjZTogc3RhcnRfY29tbWFuZDog
L3Vzci9sb2NhbC9saWJleGVjL2dpdC1jb3JlL2dpdCBtYWludGVuYW5jZSBydW4gLS1hdXRvIC0t
bm8tcXVpZXQgLS1kZXRhY2gKCjEyOjU0OjUyLjQ5NDgyNiBnaXQuYzo0NzkgICAgICAgICAgICAg
ICB0cmFjZTogYnVpbHQtaW46IGdpdCBtYWludGVuYW5jZSBydW4gLS1hdXRvIC0tbm8tcXVpZXQg
LS1kZXRhY2g=
--000000000000431ea00635f6700b--
