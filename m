Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8E8125DF
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751765361; cv=none; b=dTueHe3si14XqXB6m20awGmO/oKY1gc//MW6bppdjNQruV/z3CnPWU7BArl8IKGXAKe0PIQ68U3ysac0+Rd2eMKTA+FlsH2CFn739zJE1YwRFV76ozzzqmf4GTGaQpUvPS6JgAUuVIPJU8i6vLbtJIwXmwIpioQPi1yMwasqkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751765361; c=relaxed/simple;
	bh=gremM6Q0cR/LefHEsR9mLTDxDm2QxFK71MYDDZ4ME40=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IOqQVDtup4w4ZLAu3PGBxc1NVIOhDk43FOGDuoKFEeVtUqLjS+6TvzMohGhaTWe+q9ciAUJhC2e7lDoAr8vgnHG2yWy0PhC0uWmSfaW56I5uI96xqOdsSJVgWTfJ/UQMQts3oXoy/nmJPOkElEoRyeg91787CKMPjtHWs+BSV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfY9nP6T; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfY9nP6T"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso3136149a12.2
        for <git@vger.kernel.org>; Sat, 05 Jul 2025 18:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751765354; x=1752370154; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97knQsyN5BnZSYMKRus8FYTpsimR4CXY+iPBU8/GmAU=;
        b=OfY9nP6TQ0aPvbbWW9duAaqpQPFU9ryedkvIQ8T/U4cSL0lSkl+7zFV9w6QV+I6dEF
         ucqy5JTum9Iq/DHqis76VTIH/vEICpYocywG0rh5v2KHFP9Svt7AYwvBIpevDKhgbGl9
         JY53dLvJAulkDtII4BjkHhiwT9e7ev4Zu9tl7Oeg+PEyJx2o3UWOPcGEEEFIJ0nrcLge
         79OFR2fbBVX3Fr0f/dunMksTJYTHY+i4PbNObFtWXg9t7v8pGRY9Esx5dITvkB78UVgP
         N9KRDBhnweuc9LHrr4cvMnLTGv7ucOhFET9SV21g+8/evUmISYDpcRXEeyuXRXlae1tO
         Cmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751765354; x=1752370154;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97knQsyN5BnZSYMKRus8FYTpsimR4CXY+iPBU8/GmAU=;
        b=QApS2ckBcd1BlYbwld7oIk9GSiqMYz2R9zYkP2Ta8HwI4ejc7HCWTZnJ3t1K8v7kI3
         PDibARufZ1jSOGAJUJlKqMgNlBtaGbeLN6QW0zw4JQG02f1HPE2mnQYDUm4fzhzg4g32
         nO5nB9rD4PY9dy3QCb8nRzxGXJLKXq8Hi7m8dy5/GDvl4pozPudfZi2Q7ZumwEwfbvhO
         puiDhyD1/vOC50pBncW9LAvbBboOwt2Jro/r4O7OYXXrHLArDIWSyAoF7IPJxJyekM2t
         sDfwzgzltKCYOUU48XAJRo4NrjTVODZkSdZ70XXrmNUqnsr+4KO4PWCl9wTWdFCZa871
         cP7w==
X-Gm-Message-State: AOJu0YyAamZq9lqJaS6vy54Qtw7fd9lf1WDkCgLPmyggXIoLCk+xB5Ti
	hZUSR/RxeYVvzGOHrgsia4BJPNmgiAHBU35+wy4jAf2znXR6dQzRBOL+RrJqQJlWF/bGgUCQmnG
	dR+4LhHbMvFm+kamI0SWKQoeNu3tQ9nZAtFDB
X-Gm-Gg: ASbGnctO5oNwEvr6CcejDD6paDOvnd1W7PPbFtldR7zh7nzXY2W+xRBJZuZDTiP5oHZ
	ttDCsUhJ3DmX+QvYiWKfwRc7Wk78zx+FixYa9CVNpdVA5T7I6kktqgsD3QM19U5c3oiTxpYZJ7J
	9lRELbSns4BgKrm+faYGW06nmj6cSj/hlFPyNDgSsKNN8=
X-Google-Smtp-Source: AGHT+IHt1jks9JNgbcem0N1Ja3yuMktkjAqVdMG+2YRvCASPtGD3/8L1SAPR8UlBQQBZsIa3nHqrSj4NfAdCRxdvx0Q=
X-Received: by 2002:a05:6402:3489:b0:60c:40bd:8843 with SMTP id
 4fb4d7f45d1cf-60fd6511a99mr6865071a12.11.1751765354182; Sat, 05 Jul 2025
 18:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jos=C3=A9_Miguel_Armijo_Fidalgo?= <jm.armijo.f@gmail.com>
Date: Sun, 6 Jul 2025 11:28:46 +1000
X-Gm-Features: Ac12FXzNMuf5U7q5D35HwycUTWS7njdL94tFu5E2YKfQ46syk58uguNx2Tmca5I
Message-ID: <CAKMuBmSeFh63212_GhBHfOTbW5VaqvQjo7jz4aowm8bntCXkVw@mail.gmail.com>
Subject: Bug: "git stash create" ignores "message" argument
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
    $ git stash create "example message"
    1e9b483d1f9477de5c99a708f4aa512ba
    $ git stash store 1e9b483d1f9477de5c99a708f4aa512ba
    $ git stash list

What did you expect to happen? (Expected behavior)
     stash@{0}: example message

What happened instead? (Actual behavior)
     stash@{0}: Created via "git stash store".

What's different between what you expected and what actually happened?
    The documentation does not explain what the message "argument" is used for.
    I would have expected that the message would be used by the store command.

Anything else you want to add:
    If the message argument is not used at all, I would expect to
remove the argument, or
    alternatively, that the documentation explains why the argument
exists and what it does/doesn't do.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.50.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:33
PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T8122 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh
