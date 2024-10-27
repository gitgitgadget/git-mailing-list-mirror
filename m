Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA418EBF
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730067415; cv=none; b=oRRb0Fy431po6ex/tRO/qy2yW82bSA2akNAN8NhMqmN2xvy7mIhbgsIY6GbgNqjg8tf9/QjNsj860DK1ejY9O4KE4WpFW7ZVhR537/LnCnMT5TJYCY3xLA722t7vrF2NWjXGfN6/4I5kAtZ/Pg3bh63GMH5nwIStv8oBeK7l2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730067415; c=relaxed/simple;
	bh=+gPURVqoayLVRhW2GKKTgMc1mEIUea0xkR/CPi7YNgU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=McAp59nSCfuRPRUT+TtUarE23tAsb8Hn1bs72xBUizs8QuBMcwY+licJ9w5STeBeC7YD8JERzq1UK5rkdbLkZUiaeXyX+f58NaDUHKm4ZDzfmNqYob3Ouk/UpJeHHQcLW0xfuhWuDWgK5vu0izS5fNgI7MPxyyGXgWf61ZGg3q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjJXJURK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjJXJURK"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c913aso4590100e87.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730067411; x=1730672211; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+gPURVqoayLVRhW2GKKTgMc1mEIUea0xkR/CPi7YNgU=;
        b=CjJXJURKm6Zd5LZyU8YkAWR8JNnvTGiygODv+me5xlTtVCm+XUrbw7nzTBa3t+ZaOy
         8q0UbrUXMx16SAm1SQuU1W65Tm7Qc6oKjOBjmHe+JTFVrHJ3jNMqzlAF9b3wmW2Jkrgb
         F40f6kXEHudXBBVWJfeY/ap8+7hV14MfAi9hZyWWsVg5Xu65fS4S6nug2Qnn8ph6QmPn
         DXkkGiirauWsyLT41CrSQxg9y1Sz67G6E2cqGjd26Z8f0jf1gMjeA2nxeKlzrrQ3otCM
         n0z87aVEtHDb/VsD7xP8izrCDFFFq3qqAZqqsntSNSNMmR7+xhzqC9s47AkfkYpFoSUY
         J4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730067411; x=1730672211;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gPURVqoayLVRhW2GKKTgMc1mEIUea0xkR/CPi7YNgU=;
        b=HkDKnLMPp7ISWtWccRwZhle3HlcmFj4T96Hs2qjnPSDoUzPYDv9+cWloknYJ8nVVZJ
         s3ABdJOc95xrYne6LwmJUGApcgtBgKTB9YKfEDZ5PhYra2H8JlkAGiPgezNZl7IiKjUM
         UgS2sN0Dqx4FBFNp1evIwS4S/IWaYidwPNB6SDIaD569tYRJ2X2qHT8lYTjZo/X3Cl0C
         cwiBzqg5WORZkgYgvB8T3rRMXUMofwXXHuJEjbhqsQyFmcs/y1wpEZuKax5N5eNlKb3N
         WeSSOT6YAcCMzg6QjK8aFzs6/5K6fvlJLyX5oscXUeoIh2AfEB3xAZ6xvvMOd6aiEEEY
         s+8Q==
X-Gm-Message-State: AOJu0Yx7gYWyCsq5UFANjRlbM5QicawkQwqr1aXOBPIUB7MJx9yN4HNx
	49oKS7adAOjhAyQ5s05ic9hROVyGh3pFyEmCnYwNyAKZR3uhQ0pY76Cpy/6wGaJeVxlur56SR95
	6YHzkVDsxTEXP3NN5qA5afuUjSsiuvy0p
X-Google-Smtp-Source: AGHT+IHVCkEVYvNLLiLmb8pAM7TP6mqlCiDOYvg5u1wBwGsf0wm/fuzeorvp0szPmapX2pFxDLov/zi+1S0oSTmwTG0=
X-Received: by 2002:a05:651c:1989:b0:2fb:b8a:7abb with SMTP id
 38308e7fff4ca-2fcbdff7529mr19272981fa.21.1730067410885; Sun, 27 Oct 2024
 15:16:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Sun, 27 Oct 2024 23:16:39 +0100
Message-ID: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
Subject: 2.43+ git checkout --theirs on stash error - no alternative?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
git checkout 'stash@{0}' --theirs -- "some-file.txt"

What did you expect to happen? (Expected behavior)
Checking out the file exactly as it is in the stash with any conflicts
resolved using the stash's data

What happened instead? (Actual behavior)
fatal: '--merge', '--ours', or '--theirs' cannot be used when checking
out of a tree

What's different between what you expected and what actually happened?
Error and unresolved conflicts

Anything else you want to add:
This behavior was changed in 2.43
https://www.spinics.net/lists/git/msg463600.html
However, I think this change is wrong. Since using --theirs still
makes sense, if you want to restore a file to the exact state it was
in the stash.
While the change probably had in mind that this should be used: git
cherry-pick --no-commit --mainline 1 --strategy-option=theirs
'stash@{0}'
This leads to different results than git checkout --theirs, since it
tries to resolve the conflicts and is not correctly using "theirs" to
automatically resolve them
How can the pre 2.43 behavior be achieved?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.0-162.23.1.el9_1.x86_64 #1 SMP PREEMPT_DYNAMIC Tue
Apr 11 19:09:37 UTC 2023 x86_64
compiler info: gnuc: 11.4
libc info: glibc: 2.34
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
