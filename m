Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBA15575C
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 03:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738985664; cv=none; b=nMMuTfDsGwjpcE3QctFLN+ybud5Krrs3Hf9NDOo9iMIhUwxF+a2dy6l4LDHZziWB1P5bskSEbjTz96/kSFIRcfip3UKsWu9pqijvoeltLlW6c9TFs5PK4MH1KsxrAM/ZXQMS43QNMrpTScN24KYCJGzXaRb9z4sIvnI4NvtclAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738985664; c=relaxed/simple;
	bh=nh/J2jZiDtjSmGh3cII1khpT2pPR4wvoCE5DV46g2qw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ts1FAYwmLflAgqllvfcxLeJJSb8DAKOHgOnTcL8b3IGV92u+qHPSk4CZOjo/os4PBhlWa4+nHGDuUrrs+U6Xo8+Fhsx53As4hPtb7nB6a4pEmpCK4H4+mS0LDwDQdTfCpGF2/Ac6G3BBMyej2FvdUZQP/gUErnHvtABmjwsZtPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gITTWogZ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gITTWogZ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fa19e1d027so2924017a91.0
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 19:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738985662; x=1739590462; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8MBWZujSIc4Lz6oB+mgt33O30A8MhIAbOO2CMJaRU5U=;
        b=gITTWogZGGs3BbJkkrumO+96GgxrB8ik39UQC86ej4PCjoYnTIdKMK2fvlJqOH51im
         iQdRusHz6Z+aXWKgd8JsootfbeKmEtodhxmTgQoekWjZDyggqQqEQy6LIe44EknjJBrd
         V1d0jhGkZfLc1bghxBUBPfdU8ps7ghPGVZdDRsvtyOt8dgEwhH+fgYq8y9Oe4725df4y
         BRkDLEG20mZ2zdMsdgcfSjgsH0NXGArtFknk6YkxtsB1kVT+zNQeZeJwhm4KtQRnZ18i
         Yi4DGGp0nXiSwMD9LC/mslUJQueRA5Tnscf4lAy1KBAhYrtfWcw68hBxhAFjnfYmiHd3
         G+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738985662; x=1739590462;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MBWZujSIc4Lz6oB+mgt33O30A8MhIAbOO2CMJaRU5U=;
        b=sdP50p842Gpiyi0lhLHXgW+sCLyQ8WzHt1NdvYC4smiJvMsY690Yi5CcOl/cYc+VyA
         ps6JUJtyQHc/EmFL1NWjbC3nLzNizcx+UbA2xuC5IO2D4pQBPav9b4csWjUphqUakPlj
         VVxjjGWIw+RyuumeQk5lI3l/FWB4RGfJCsEShmHve5TEnS31m/H05oupR0Dc8VPUid8U
         iqVrXnsBmZhZqePNt9nrhI92U4ZBdRvZqSMJXwAbInVqShA44hwBEBjzmDIgQMx1QmIb
         6KTz4c9s01wZcq2XO7ovSlzsc/9PKWevQJFcZj38ayxgFRJw9ynYUhw4G6bBGflCDOaz
         bP9Q==
X-Gm-Message-State: AOJu0YxqTbaKPPWMUL7tJGSB4Qdxu3POn9oOXMJKfxBSxcE8lWVkIN+G
	poODJfj6YOQITCqTNO/RbiWt8LEYqV1RPmdQdiEnWgefabbpZWPmZZCihHT3wBevhnFuGFU4/bC
	rJsO6OzbtutPgaLcEiYa/R1hh+sGVmu3i
X-Gm-Gg: ASbGncsbOBbeWMhRKhDw+WYTapMqtwUKVRbtDRomlZQ+wtbzZPx4HKFH4S8Z4l0i/lU
	HX24dNNI/5oWY9XIpYP1N1UujBv38tH5msseMCd/Er/JMXIhwAb8Bv8/hhfaxXSIXJRi9zrWs3m
	jUXkaGTnt3EuxFJR+bnrYqAA6NDVMh
X-Google-Smtp-Source: AGHT+IEfMxTAUPfcygszbzgvNFhM0tl119EYCY+YWek25hFNKiMGNPhvfCWR/WJP6GAmOAL0hJuw8HNLT/haPWOUUpo=
X-Received: by 2002:a17:90a:f94e:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2fa23f436d6mr8749066a91.7.1738985662285; Fri, 07 Feb 2025
 19:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emily Klassen <forivall@gmail.com>
Date: Fri, 7 Feb 2025 19:34:11 -0800
X-Gm-Features: AWEUYZlGbKfCNW7SO5GyPuP3REmLNLRjV-Ok7W81Ho42RcLozNn8V35viVksD0s
Message-ID: <CADY4h_qagYhSP2kz=zNSjfskN1ODxLf1DjEME6BdYw6j-JEAhA@mail.gmail.com>
Subject: git log --graph --no-graph can cause segfault
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> What did you do before the bug happened? (Steps to reproduce your issue)

$ git config --get alias.l
log --pretty=oneline --abbrev-commit --decorate --graph

$ git --no-pager l --reverse --no-graph --name-status
e83c516331 Initial revision of "git", the information manager from hell
error: git died of signal 11

> What did you expect to happen? (Expected behavior)

I expect the commit listing to display successfully.

> What happened instead? (Actual behavior)

Git seems to have crashed. My best guess is that some state gets set with the
first `--graph` flag which is not cleared with the `--no-graph` flag.

> What's different between what you expected and what actually happened?

Git crashed.

> Anything else you want to add:

I also tried to manually expand the alias with

$ git --no-pager log --pretty=oneline --abbrev-commit --decorate
--graph HEAD --reverse --no-graph --name-status
e83c516331 Initial revision of "git", the information manager from hell

$ echo $?
139

Which indicates a segfault.

The below command works properly

$ git log --pretty=oneline --abbrev-commit --decorate HEAD --reverse
--name-status

but obviously, the intent is to be able to use my `l` alias with the
`--reverse` flag by disabling `--graph`. My workaround is to create a `lr`
alias which replaces `--graph` with `--reverse`.

I also tested "git log --graph --no-graph --name-only" and "--patch"
and "--name-status", and all of those failed, without even specifying
"--reverse"

Also verified by building `git` from the `next` branch.

> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.48.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
uname: Darwin 24.3.0 Darwin Kernel Version 24.3.0: Thu Jan  2 20:24:16
PST 2025; root:xnu-11215.81.4~3/RELEASE_ARM64_T6000 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.6)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

~ Emily Marigold Klassen
