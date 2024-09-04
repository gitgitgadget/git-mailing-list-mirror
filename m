Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE983D6B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423005; cv=none; b=izDIENURmMkZoM0jZmhm4bwzmYBLjNHKDx+PIRsdE9Ht3fQG3tFUPzZIyws9B3TIn7GBz0SYkJSLWUVwL0qmF2Iu2fVb1Ekqoo0ovcST/feHw4lSyZKms6IG+uEg1we/+REeqcFiq4WEgVFUv3rk+pPTL5+ewk0NjtdTwWfqFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423005; c=relaxed/simple;
	bh=5Ye9xGt6ca5mkJLo08Y7HiPqF0GEkotQ7alueX9cdmQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L52ZUIQsj/ZP/A3H2DAQ9ZXOhy4+ciK4ZwTA+208dgjP9RM5vcgrsydAnN7THI6/PSqwHV/8m6O+BsL8LTztc1uuYRer61bYorFz8vbygV69R9pg2PGDJy6gNJ2NwbA1WOoyFc+oF6WPAEKEJIzef37uvm1aIgGkysMh+3W9RaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2311OpR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2311OpR"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso10601609e87.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 21:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725423002; x=1726027802; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Ye9xGt6ca5mkJLo08Y7HiPqF0GEkotQ7alueX9cdmQ=;
        b=U2311OpRc9aXJiMYdfMxDz0UbvNsYHY6iLlxwkuVEX1DmeWDGP9Wmf7S9avi5nGW1G
         CBwidw/8Xy4M3fe8gFimKJ7IWvrRJlctoqERzWiBT64S7Nf9BDuFNefSZB0hOkiXMaa1
         U0Z5IWVy7CNirzfxMCYntxUngLLhCabo0Rqnyi+VGAhZkqrbC+DxlerE26N/vC9CChzX
         58kbsKkPFvFmkjf7PJ9NWGAucSs7Bqb9SHAsIqMHxFPNW/7aRl8HQeIYpdMFWzx1hgd2
         4gjRQ8pVVXxC32Lw52C1Q8rTeiKjui65h/T55IyCMEHl6HCsfV5nJdpgxfDvqH/9/v4b
         MiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725423002; x=1726027802;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ye9xGt6ca5mkJLo08Y7HiPqF0GEkotQ7alueX9cdmQ=;
        b=WGKTqBw/o0K6b0CwqQz988O8xGcWmiMqXAyg+KlsreKxfckbJ3IxxpiMwsM2Nus8Cu
         vKA6dQKKedeiSNdq9VXitilROCNSFWoXNeqnGuwdavvyUi4l23XkR68fqdzLMDr5/cxz
         Nx4QFF+oIsE2gm+GDNk9x+DiPN2du9BHlzGbf+GBHwiHYsmazEQ6FvW7aoClCeLnSg1N
         kYP6Dy1p3p31sBtNXpP+u/S0cy67X07F/aCBnxMqd+tqZrSWnwYwKjIrGR00u8SSnNJd
         EByIzvNLS/wMwMuamoIan70Z1Hgi0Ge3fpvLo3NR7cBsKOC81tLDZV5h6U18itQOVpF3
         wjcw==
X-Gm-Message-State: AOJu0YwkjJE2KSjq3GZ8dfsmhy6JAdbJN8tapOQGGZy8nXhtNfOfgN6C
	SVRB9FSAhNnwdQxgG5dOTFlw0EfXZF2oXS5ADWKJmhGL8YI5Ql0V74f61VnS1mSdtzhizsJmos9
	3wrBWCnyL0Su/75x3KlOu0Hky1wvdmKGL
X-Google-Smtp-Source: AGHT+IFUBuGBkxB5AmhkJpMmcoDWjJCGD9otnmVI4maxJA15pUeSMe/T2LH9BbEB++cJs4VnBHfAlUo2ozcfSiXD4p0=
X-Received: by 2002:a05:6512:3b23:b0:52f:d128:bd13 with SMTP id
 2adb3069b0e04-53546b8d8admr9810713e87.39.1725423001746; Tue, 03 Sep 2024
 21:10:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 16:09:51 +1200
Message-ID: <CANrWfmSe0ekbRR9VsX8jALWQQVdhDv-2WTSm47jHTiV9-Z7-pg@mail.gmail.com>
Subject: =?UTF-8?Q?=60git_fetch_=2D=2Drefmap=3D=3Crefspec=3E=E2=80=A6_=3Crepository=3E_=3Crefsp?=
	=?UTF-8?Q?ec=3E=E2=80=A6=E2=80=8B=60_providing_NON=2Dempty_=3Crefspec=3E_to_the_=2D=2Drefmap_ALS?=
	=?UTF-8?Q?O_causes_Git_to_ignore_the_configured_refspecs?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"
git -C './server/repo.git' branch branch1; git -C './server/repo.git'
branch branch2

git -C './client' init './repo'
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' fetch --dry-run
git -C './client/repo' fetch --dry-run
--refmap='+refs/heads/*:refs/remotes/server/*' server branch1 branch2
git -C './client/repo' fetch --dry-run
--refmap='+refs/heads/branch*:refs/remotes/server/branch*' server
branch1 branch2
git -C './client/repo' fetch --dry-run
--refmap='+refs/heads/branch1:refs/remotes/server/branch1' server
branch1 branch2
git -C './client/repo' fetch
--refmap='+refs/heads/branch1:refs/remotes/server/branch1' server
branch1 branch2
git -C './client/repo' branch --list --all --verbose --verbose

What did you expect to happen? (Expected behavior)

In `git fetch --refmap='+refs/heads/branch1:refs/remotes/server/branch1'
server branch1 branch2`,
`remote.server.fetch=+refs/heads/*:refs/remotes/server/*` merges with
`--refmap='+refs/heads/branch1:refs/remotes/server/branch1'`,
so these should be what would be done:
branch1 -> server/branch1
branch2 -> server/branch2

What happened instead? (Actual behavior)

In `git fetch --refmap='+refs/heads/branch1:refs/remotes/server/branch1'
server branch1 branch2`,
`remote.server.fetch=+refs/heads/*:refs/remotes/server/*` is replaced
by `--refmap='+refs/heads/branch1:refs/remotes/server/branch1'`,
so these are what would be done:
branch1 -> server/branch1

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.windows.1
cpu: x86_64
built from commit: 2e6a859ffc0471f60f79c1256f766042b0d5d17d
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
feature: fsmonitor--daemon
libcurl: 8.9.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1
uname: Windows 10.0 22631
compiler info: gnuc: 14.1
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
