Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4551F5F6
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 09:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736070504; cv=none; b=otdtaonMAA8oXGysc2ShlWc3h41nR1zVzc19f25PSMYogDJQKh4ty/nCDibQVq8EnNEHIJYslMbybUROeK54poO8P0Qk25w7DrzG+HikWTxiALBfC4UIZPTFLwT4NP5+y/uCdcQP2wBC3lBDRVIIA4HV5UUJz2NDGxV5q8B+uiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736070504; c=relaxed/simple;
	bh=EerIZ3D4NVrl+eqg7v7W4qzSxpUulf/pp+b2wDIT/So=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=KCbn7SyQe/rONOd/nTy4rAw+6YYxGczCKxySoe549Dpn3QJMA65CARz5pO5BcVVV6+WWmFMdxTHbJwAYRfquHXErQKix4ZgN9T+JNoFEu6LplRcm651RtwUwGkevolPBwnNWkvSLUci/+4v2ls/8iA/rZDQ0JyW56zz3eOWEjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNvtZuSb; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNvtZuSb"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3043e84c687so118066811fa.1
        for <git@vger.kernel.org>; Sun, 05 Jan 2025 01:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736070500; x=1736675300; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EerIZ3D4NVrl+eqg7v7W4qzSxpUulf/pp+b2wDIT/So=;
        b=LNvtZuSbvDx4/Idr/rM+N2eRKS8tcrDJUl5i4Zu5R+iYE+sYW9JrEMKE0Z83CLjwh2
         RCtIxNJa1+b3HzzIh1+ZcdsISfgObwCbt4Yf3bPybf9lRsHT/39mrc48y5OYZzUyvtym
         dVtUGWpTWDFEwMqWW0UbNn7uW2Oif0WG4AWgPfi5FT92vfqMTipbdlmClDbMudkykXSb
         WbwzUFPxEmHV2Hm12SFsdbJBGTC1E8lzI/RsMwpZewqyJxeZouadaEhutuVPWUXFCCjm
         ycYBWFZf+gwo0VZ2y+iZeYiyKZC9sx7aZeFk3GVh5kqoT+YnbJxu4n0lletXlq3jKcSx
         az0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736070500; x=1736675300;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EerIZ3D4NVrl+eqg7v7W4qzSxpUulf/pp+b2wDIT/So=;
        b=m0m0mygCcviMimoeW9Nha0WhL/PiZeDb5SBNFNMfF9PeJatoVyaKBMbeG2C2nLahSP
         u+oOmsnh75zMzCJJePMaW83pLdegDIxzs2wThq6UoleyBYGZUbj3Vafs+KQ8OLC5zdjF
         yAFXBRF5wpAj/NAiqN8kuVdwnT2IUbIIgEG8tR9BNbplv0u3RjQirwUiMIbvnrUw96wM
         ZgtuV0SXQkRqKeyBNHJS1mjccwRRkbNFfRcCghLKeg/kcG3p3ren4IuRa1mLdd5rhfEW
         9xjOXrlKhA5Eb8duCHuRI1EczNlx/dGvA8pArTWOoaXPeS2a4eFBgB6fEpMQruWgKQRU
         /48w==
X-Gm-Message-State: AOJu0YzzfyZuTA/1x842oDlch0Dy/d1Z7jszVNU+2aVLZ9C/ZIXiLpgS
	uakV58VDYzNIgcc+dx2AR8XfZz3HSIBNBbgnM4mvAfItHXw11OVJ1KSSvjVKivt4KZ+TaIzxEs2
	UtHPMg5gSfyHS1qMUuiDoVCOMAoYTjLTD
X-Gm-Gg: ASbGncuCiJNB9AVZEe/LX53OMM7hvducQrW2fXjTNA+ovlSC8dWs/bwIlGbNPSF+ELA
	j2HjiPlmgZZozZE4sul33q+qVOmRtfVVWS54R
X-Google-Smtp-Source: AGHT+IFXAAa9/yr+76ADPSZX8OU9nFxnNbJ5ipOH2bYURQbjGOabyza272+z41y9GQxQrVz4yPMaRAr9b0fp7qsuUU8=
X-Received: by 2002:a05:651c:4007:b0:2ff:d7cf:a6cb with SMTP id
 38308e7fff4ca-304685506f3mr146535321fa.11.1736070499721; Sun, 05 Jan 2025
 01:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ross Goldberg <ross.goldberg@gmail.com>
Date: Sun, 5 Jan 2025 04:48:07 -0500
X-Gm-Features: AbW1kvammuYaAH1gZrtWX3WIuV3xucgHgEL7SxHfZyU22F-XP6UxfZBan7EO_Ko
Message-ID: <CAAEcvMovcZucuq4H70ouQzKS=_wHnBi1DqJ-4MMFVXX9XLEciw@mail.gmail.com>
Subject: Bug sorting git branch output by ahead-behind:HEAD
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Bug sorting git branch output by ahead-behind:HEAD

What did you do before the bug happened? (Steps to reproduce your issue)

$ git branch --format '%(refname:short) %(ahead-behind:HEAD)'
(HEAD detached at 6aab6bfe) 0 0
190-json 1 6
560-swupd 3 6
667-reset-no-process 2 6
678-completions 2 0
693-readme-accordions 3 6
705-branch-in-version 2 6
main 0 6

$ git branch --format '%(refname:short) %(ahead-behind:HEAD)' --sort
'ahead-behind:HEAD'
(HEAD detached at 6aab6bfe)
190-json
560-swupd
667-reset-no-process
678-completions
693-readme-accordions
705-branch-in-version
main

What did you expect to happen? (Expected behavior)

I expected the second command's output to:

- include the value of `ahead-behind:HEAD` on each line
- have been sorted by each line's value of `ahead-behind:HEAD`

What happened instead? (Actual behavior)

Second command's output missing `ahead-behind:HEAD` & sorted by `refname`

What's different between what you expected and what actually happened?

Fields missing from second command's output

Incorrect sorting of second command's output lines

Anything else you want to add:

If I sort by the `objectsize` field:

- all requested fields are output
- sorting works (except `(HEAD detached at 6aab6bfe)` is always listed first)

If I do not include `%(ahead-behind:HEAD)` in the format string,
sorting by `ahead-behind:HEAD` still doesn't work.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.47.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 7.79.1
zlib: 1.2.11
uname: Darwin 21.6.0 Darwin Kernel Version 21.6.0: Mon Jun 24 00:56:10
PDT 2024; root:xnu-8020.240.18.709.2~1/RELEASE_X86_64 x86_64
compiler info: clang: 14.0.0 (clang-1400.0.29.202)
libc info: no libc information available
$SHELL (typically, interactive shell): /usr/local/bin/zsh


[Enabled Hooks]
