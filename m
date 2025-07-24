Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B323BCF7
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396681; cv=none; b=WDIX27OAq8rgo89PkX8zPHMFY+4SGdggWiVBxUFc2IUFH0U0u5Bw5ZrnJVOD4XIg//+NGnuvhWdJHa5mHfk4rMGhO4ar8oZkYFvTk3mOood8lEwHpKZbnhPn2SmL8+Uxy8CMbhVy+OWbWsCFxuPZfshMxNSmD+RvC7+sgvb8/CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396681; c=relaxed/simple;
	bh=v68/rc+AoJ3IhtqMyheG5bLH9eri/5o0iXEwyzNAas4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HfO9kMBl/+t+LrD0BLjfog0PaVg2M+5Gq/MbJWsb9dJ55tLK/B+mW4di1MBVm5Yeh1qbYK++2un3DkZsyzrLg7j42L3zfkoPbzX2CYCgtOwH9z8wddqk36wAKW8C8KC9Zk860NQhCiIfgX1k7RhXuA7hEzHkS2rYp7MfqtAa3gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0pH+zk1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0pH+zk1"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8db886dab8so1182310276.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 15:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753396678; x=1754001478; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v68/rc+AoJ3IhtqMyheG5bLH9eri/5o0iXEwyzNAas4=;
        b=S0pH+zk1+r2ITimkrXbKr9vkomIoiOmqqTyr8zU+C12XAOx6ClDxPE/cOupApQW0gN
         dIzeGUKbHi/+1vnNb+bTd44rdwVYUThnsNktlysRtRhjrTshlz07qXFwMGQx1CnwsQzs
         Lv19cHS9dULK0J6CSnLQ2lKCBwOH4PR93bWpN0xmtJ7a749pk4FPvuATRCQlZuCfM45+
         OvXM9WTCBDlsi4Ji9dXIJrbICJCYk0mNHOLwbNTsVgQC/DQyWMUbXC2Px5hslZRBXI9u
         6t/boafhsPO9N4KwP5tS7cU4s3Vv9WdTyYHGGxeZEzZNE5D7bSVaGWiutKPEdiMKpvmR
         e71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753396678; x=1754001478;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v68/rc+AoJ3IhtqMyheG5bLH9eri/5o0iXEwyzNAas4=;
        b=JVfT8e0wTg3RovV7T4i1hAdtOU2XJLxaQ6DchV56YbCYoSo0V+NJj8ccC8easSNSZi
         Y6Qe03y3Sl9Pwhw4CATGb7UKueSNFnuCAdStFRpqPleE6h57VacTvq+BGtfIsl5yaNoA
         VV16RR1bu2T3oSlU8NC8hepAGgk4w1SmwCBEpHO8iGn4zHf+PEh/b1pqp8vdNBG5KVSd
         9ZGizY4CywAFB0VSNe8gEsn+LtTo3T19QQoSm8aQaIzWsD1NE3c9fdZdVgcGJCPrWnoj
         m/crrPQEvBuSq3CvZ5TyoA0GtCbBCaPMLw58VOEDyZ1BlZI+Wp1C4Bxa66AwhaCOukpK
         U0sw==
X-Gm-Message-State: AOJu0YxLCfHSrJwPJDmTGMal8wSdww1aDmnSG5BiJZ5dxEIqggICfm/O
	M8JP9hlNl2ODwoRANsUgRL0AlurxoYiXa6YqBAh/2AQclylKajmsl1+5scEjqjHrTMPRfeMqy5k
	dP8o8mciRXvbUvS2oxZXNkryXO5WNkF+SstsKLbU=
X-Gm-Gg: ASbGncsjKOVSYljsbh7d9jbFN3LFmjHHNMwkXUniZOoWiLxXiKOBkb3/DORYoij6Ro5
	lTO4HhNoDeBWbceQ79jG7RuzJPgCanbXa5Yol5hf9YdcUHg1abzUyAWqUaYdaRqZocdwzBZIUeH
	QJdID02XI/xIp/eG5LAhmvWNEqAL4Mo+ipVtLZXz9GHacWIFUeGQRmE2oR8RRGL+hl9orU8N4aq
	4wYb54XWqisNzfqzqJC0tjpGv4XfnALD2zr3CA=
X-Google-Smtp-Source: AGHT+IE0ogVNb2jBJbwIrpUDWMBdyayy/6o2ZHKdPkuRwXFKKlye4TK0MKNKH+Krn7LPglZ/IQmCccBcXOtHCUDAcT8=
X-Received: by 2002:a05:6902:2405:b0:e8c:940f:39f4 with SMTP id
 3f1490d57ef6-e8decfdda93mr1111184276.47.1753396678276; Thu, 24 Jul 2025
 15:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Fri, 25 Jul 2025 10:37:48 +1200
X-Gm-Features: Ac12FXyJl8e-mZklbYRp-9NnhEsx6ihgMcCV-zm8l-kUc6QZiPHx9y5L2FAjEpI
Message-ID: <CANrWfmR2992eD_5qoqHMCr3NzasuT=pgYqd6UGRSUhFeFS1v=g@mail.gmail.com>
Subject: `git remote get-url --push`: `url.<base>.pushInsteadOf` is ignored
 (while `url.<base>.insteadOf` is not)
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

mkdir --parents -- './server1' './server2' './server3' './server4' './client';
git -C './client' init './repo'
cd './client/repo'
git remote add server 'file://'"$(realpath '../../server1/repo.git')"
git config set --local --append 'remote.server.url'
'file://'"$(realpath '../../server2/repo.git')"
git config set --local --append 'remote.server.pushurl'
'file://'"$(realpath '../../server3/repo.git')"
git config set --local --append 'remote.server.pushurl'
'file://'"$(realpath '../../server4/repo.git')"
git config set --local --append
'url.scheme1://authority1/path1/.insteadOf' 'file://'"$(realpath
'../..')"'/'
git config set --local --append
'url.scheme2://authority2/path2/.pushInsteadOf' 'file://'"$(realpath
'../..')"'/'
git config list --local --show-scope --show-origin
git remote --verbose
git remote get-url server
git remote get-url --all server
git remote get-url --push server
git remote get-url --push --all server


What did you expect to happen? (Expected behavior)

`git remote get-url --push server` outputs:
scheme2://authority2/path2/server3/repo.git

`git remote get-url --push --all server` outputs:
scheme2://authority2/path2/server3/repo.git
scheme2://authority2/path2/server4/repo.git


What happened instead? (Actual behavior)

`git remote get-url --push server` outputs:
scheme1://authority1/path1/server3/repo.git

`git remote get-url --push --all server` outputs:
scheme1://authority1/path1/server3/repo.git
scheme1://authority1/path1/server4/repo.git


What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.50.1.windows.1
cpu: x86_64
built from commit: 4d32d83913170b86f9753fca10e75cdb2223d1cc
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.14.1
OpenSSL: OpenSSL 3.2.4 11 Feb 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
uname: Windows 10.0 26100
compiler info: gnuc: 15.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
