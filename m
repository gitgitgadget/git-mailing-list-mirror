Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FC2E3366
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827976; cv=none; b=OiVPnmNF7d4Yqq45qlQ8A/yodIfDe7uzZL3rLuIP/hHvNB1vwyiFXHMhGYGe/W922RNKBhri418P8tWXlqTrfXmb/Pk4k1WidlZdmYlJ5r9T2t/k5jyVxCm2a49Q/IWMmaWucJY+Ufam56VrycGtvOlYZVzmejZ7OzeFIsPoR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827976; c=relaxed/simple;
	bh=R4YEmMfJswdqmc44ENE7g7m/qaH2hGsbUI77cX8pies=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qpPoH1yKylJYroW/Th2DllXMhnmAMYOcmeSWbUrl1zLM9SnF5RHsWob4j6z93J4brwEzo+g2s76r/YQNq4YvrNTH4aaiyrX/41/JnFLJFGbjsNnlkNZ4rYO3PVLHIZFtH2vo+fo0smjmBx5DTDJ/9Lt4Ca/PDEHergPbJSAxEf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlCi2Lie; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlCi2Lie"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-549644ae382so5645991e87.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742827972; x=1743432772; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXpTjNZcG7FZXaB33vKgClpk3n1LriBNPGsxzYFwksc=;
        b=DlCi2LiehsfSHwDa+uGSiO6CqhwUFLE7QoJp34Ok8USy0Uc32/F7t2cIKdy/aTs/ia
         yaTRx+L6h8KtiTdA6MtLvwmAsqaIeMTTwmnarqOq9kLftDxCwZQ0W53amzFiHh8sALUO
         ndGMi8tbwfQcBH84QGm9y/kdNXyprDEQa62i2zQe9OD02eVhgZKXHfpDHkaaR20TH8LQ
         CrJZFGw8sqTq3YDSUPcdRvhy6JYpbbaVS/pI6bElJpk/yfI1WDDK4E4c/bSVuXLiSaYE
         6V9seKwhXMt01lXuWL9KgMKGQrvCrR3KJZznK8ciRWEuIXzper65bc5wKLl9aDQCKrpp
         6BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827972; x=1743432772;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXpTjNZcG7FZXaB33vKgClpk3n1LriBNPGsxzYFwksc=;
        b=sI1/GZFb35c88+adEJ/OTKuiuOIxsKJEb5cNxvnzrQyxKB53f6E1ngHz42JFGFOCmr
         8kD4JGpX8sq1LoPzThwZS9h7Pdh0/Dl8ZPItNNMGmSfiaRRErJPQmRk5fdz4LSoDGjmr
         8WIXCWJybkHQDxYQKE8ZvFOz+0jccs/lnjg/l3X2v+49gniESdXJS5uPsevw3Cgg5sz9
         KEV9J0BIxmMTu1eAsrtIVAtesAY28MsWOBpEIowItL6S4joZTzl43nx7XP/+Ngk1yxA7
         HeGSUqHranO/IX2HUuZ81RZSfxcYkmwurqWLGtHqxJlUFKF7Bf4wQEsZtPo5ntwG67dF
         spBQ==
X-Gm-Message-State: AOJu0YxrH39YZ9b4wv7KB1MeB+5qJBvYPkt8fkcaNDTbkaeNn7qPGTcN
	1HPgRJhclY83k3aD0yu/mG41itxDrN96IHhtcp1XSMmK8uTmf0IAfkzm7HjLxQNkAx6LWrII6ia
	uVx4z8LAs4K0SwOD1bYKI0eUO3H4C3qui
X-Gm-Gg: ASbGncsfKZeiiw/b/9A6jY6XZIIgStd0I0mlyPhQNjbaqohT99vmkgC5TqQnE58phgY
	Hjt36uCIdvWOg4rpE1Wy9nnd061yCJQ44qvg/J3Ka/z8g0S2TMY4LQq3IvoiaWPLVp00aTPf5dt
	m+iwWEJ1Q6iARDb2w3uOCBrWxOOjZnfD4s7RBNMtH4qjzsE0rIj0KFdw==
X-Google-Smtp-Source: AGHT+IGAbcodt19L6UBgsDwFEaqla0OANobAenIyXGtM2Cehs7YU/emv/5engdazbma1AdRIl3/+3UdhGRUDgAQr4yU=
X-Received: by 2002:a05:6512:b03:b0:545:c7d:1796 with SMTP id
 2adb3069b0e04-54ad64fbe26mr5245897e87.43.1742827971878; Mon, 24 Mar 2025
 07:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: kawarimidoll <kawarimidoll+git@gmail.com>
Date: Mon, 24 Mar 2025 23:52:40 +0900
X-Gm-Features: AQ5f1JrC62e4p9JX8CdOxBC1xJ7ZyppVLPaAdowlVv1DD1jy8Tl3orjMDUunzME
Message-ID: <CAC6paJg19ue7W0VxTnGH-1ra3Zkk+pRnj6McEC755RD54xDzCA@mail.gmail.com>
Subject: mergetool.vimdiff.layout behavior differs from documentation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This is my first time reporting an issue with Git. I am not a native
English speaker, so I apologize if there are any translation mistakes.

Below is my response to `git bugreport`:

> What did you do before the bug happened? (Steps to reproduce your issue)
1. I checked the `git mergetool --help` documentation and configured
`$ git config --global mergetool.vimdiff.layout "@REMOTE"`.
2. In a repository with merge conflicts, I opened vimdiff using `git
mergetool`, updated the REMOTE buffer, and saved the changes.

> What did you expect to happen? (Expected behavior)
I expected the changes made to the REMOTE buffer to be reflected in the fil=
e.

> What happened instead? (Actual behavior)
The changes made to the REMOTE buffer were **not** reflected in the file.

> What=E2=80=99s different between what you expected and what actually happ=
ened?
The documentation states:
=E2=80=9D@ is used to indicate the file containing the final version after
solving the conflicts. If not present, MERGED will be used by
default.=E2=80=9D
So I thought that the changes made to the REMOTE buffer will be
reflected in the file if I use @REMOTE.
However, in my tests, @LOCAL and @MERGED worked as expected, but @BASE
and @REMOTE did not behave correctly.

> Anything else you want to add:
I=E2=80=99ve uploaded a video reproducing this issue to a GitHub Gist.
Please check here:
https://gist.github.com/kawarimidoll/3e603664432702e434c27f343fb35f85

[System Info]
git version:
git version 2.48.1
cpu: aarch64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/3z1jypscq2ld48kl089ywgwd8ri2rjxq-bash-5.2p37/bin/bas=
h
feature: fsmonitor--daemon
libcurl: 8.12.1
OpenSSL: OpenSSL 3.4.1 11 Feb 2025
zlib: 1.3.1
uname: Darwin 24.3.0 Darwin Kernel Version 24.3.0: Thu Jan  2 20:24:23
PST 2025; root:xnu-11215.81.4~3/RELEASE_ARM64_T8122 arm64
compiler info: clang: 19.1.7
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


I appreciate your time in reviewing this. Thank you!

kawarimidoll
GitHub: https://github.com/kawarimidoll
