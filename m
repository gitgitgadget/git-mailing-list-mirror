Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56B173
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725408514; cv=none; b=kgtdgVUvjOmw11ocVkblzbrFhALDg69bvicWtIUMkuf+M3uASJQiSziSsmvzTwNc/skr4Q0SAnUH62o7LVYIfo0rCDzJWbJ7KRc3wThVudB5vuZO9RlAgNBFmK16UU/1V71+UWGE0WpodMdq5imkkKoBqNjr7Ev1LgvAfjwKKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725408514; c=relaxed/simple;
	bh=SKfLy6Dbqdayp91cRYaqkr2BH8bcjR0U3cVmwg+iIhM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SWzNi8GlhIGMJUfFPgbSqjlQa/to1WChhnyxOLLSvL2JOJfybuAvNA5PNJ170ZYubGXF4Uz3qk+Rzl1jM9r4kjgc/pSFcDcSweisUg3uy7rP6/X3EBxV1rhYHsRFYcztGFuN5bzt9bZYhh3gAgRet6JvfYKE16Za/hDW2w/X3f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIWQcmUS; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIWQcmUS"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8695cc91c8so600344166b.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 17:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725408510; x=1726013310; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKfLy6Dbqdayp91cRYaqkr2BH8bcjR0U3cVmwg+iIhM=;
        b=jIWQcmUSNrEWOUGz+px34WEmB67e/JhRQklkTyGHPtQlXKE7FY0YISCvgDIWzcDUKT
         nOAOj+bYva6Tw2tyUTKV8WbNRLcvu9FTbUtx6m5VDlatLktFBtaHyCvEumvwMX0hpLxQ
         QyLY0A+k2odvMbe8jGPQKQZ+HPbYLFJT4Ui55QLoaFtN4kWLMY8B7s4zJw2uCnpnRIsp
         gQiPhkS6iBKOSB19LNQlv1baR49orbUlK926zobvgNmqh+yq+Xc4Sx+woanB8WubE8Q9
         Fwt+CZycouVJ2Ma/UPA078KOhRQxvt79wS4O0oSVaRRFHvF+4/vf35iLmp1RoYW/Wu34
         NNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725408510; x=1726013310;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKfLy6Dbqdayp91cRYaqkr2BH8bcjR0U3cVmwg+iIhM=;
        b=CB4XHqG69Ub+R5P6h+n2BRl1OVpBrUuzCJatsprWoQPo5IMXXZM2HBD44krYH+yPCy
         Dyj6YJKj9pcEeF4WNYcsd2TDJYzMptUMSuktDM8PoDjJ6Qt6yyA477InvBVhiv8M/f31
         6Nr9Ml+1xNSo8Rynq3tn5tf4FVOraSWGamfR/s25MX5PQDde/aAJSLRL+vfrcZsKh+QU
         Dqs+6dsD4mKOG/3IPt/zUiWZIkek5sVCO1oYLNzclFFfxb4DimnXk93AnM4I7v2IB5ba
         1It3ObMqm/p7Yzj70ZDuygEQKFMt7nTB+5AHmJZ2GVTR1quFgV4xFZSpM1qZlejwwi9N
         G2Sw==
X-Gm-Message-State: AOJu0YzrOKWvwDHfD41KimsOb39+N66JJZTYOAQB3ASp+K5VFQNcYlVj
	6DmObh+v0kLaBu371iXkfabsEESP6HdI3QuuQaJAZclrukzhL9IPY/8dgr2tW8YXlMcySabssRd
	jMwOU0Q5i89cCVKrD7fYQW6jFW9t/YMER
X-Google-Smtp-Source: AGHT+IEA9OJCX1mukGBPEe/TAnB6Gt+nyMfz+L/gjbIO6WnK0zOFtlWGoKHZjd5OZMzl9okzI0ts74JaR8aMiAHPlNQ=
X-Received: by 2002:a17:907:7e9a:b0:a86:8524:2558 with SMTP id
 a640c23a62f3a-a897f7895d4mr1696983166b.12.1725408509590; Tue, 03 Sep 2024
 17:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 4 Sep 2024 12:08:19 +1200
Message-ID: <CANrWfmR1nTDF-ts3n2PpH2C+uvBzDm7ZEXh0StuwPZRmm80T1A@mail.gmail.com>
Subject: =?UTF-8?Q?=60git_remote_prune_=3Cremote=3E=E2=80=A6=E2=80=8B=60_=28equivalent_to_git?=
	=?UTF-8?Q?_fetch_=2D=2Dprune_=3Cremote=3E_except_that_no_new_references_will_b?=
	=?UTF-8?Q?e_fetched=29_ignores_=60fetch=2EpruneTags=60_=28and_=60git_fetch_=2D=2Ddry=2Dr?=
	=?UTF-8?Q?un=60_prints_same_tag_twice=29?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_"=
;
mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
git -C './server/repo.git' branch branch1; git -C './server/repo.git'
branch branch2; git -C './server/repo.git' tag tag1; git -C
'./server/repo.git' tag tag2

git -C './client' init './repo'
git -C './client/repo' remote add server 'file://'"$(realpath
'./server/repo.git')"
git -C './client/repo' remote --verbose
git -C './client/repo' config list --local --show-scope --show-origin
git -C './client/repo' branch --list --all --verbose --verbose
git -C './client/repo' tag --list

git -C './client/repo' fetch --all
git -C './client/repo' branch --list --all --verbose --verbose
git -C './client/repo' tag --list

git -C './server/repo.git' branch --delete branch1; git -C
'./server/repo.git' branch branch3; git -C './server/repo.git' tag
--delete tag1; git -C './server/repo.git' tag tag3
git -C './client/repo' remote prune --dry-run server
git -C './client/repo' fetch --prune --dry-run server
git -C './client/repo' config set --local 'fetch.pruneTags' 'true'
git -C './client/repo' remote prune --dry-run server
git -C './client/repo' fetch --prune --dry-run server
git -C './client/repo' config unset --local 'fetch.pruneTags'
git -C './client/repo' config set --local --append
'remote.server.fetch' '+refs/tags/*:refs/tags/*'
git -C './client/repo' remote prune --dry-run server
git -C './client/repo' fetch --prune --dry-run server

git -C './client/repo' remote prune server
git -C './client/repo' branch --list --all --verbose --verbose
git -C './client/repo' tag --list

What did you expect to happen? (Expected behavior)

https://git-scm.com/docs/git-remote says:
`git remote prune <remote>=E2=80=A6` is equivalent to `git fetch --prune
<remote>`, except that no new references will be fetched.
so:
`git remote prune <remote>=E2=80=A6` should prune tags when `fetch.pruneTag=
s` is `true`.
(`git remote prune <remote>=E2=80=A6` should prune tags when
`remote.server.fetch` has `+refs/tags/*:refs/tags/*`.)

`git fetch --dry-run` should print same tag once.

What happened instead? (Actual behavior)

Setting `fetch.pruneTags` to `true` does not make `git remote prune
<remote>=E2=80=A6` prune tags.
(`git remote prune <remote>=E2=80=A6` prunes tags when `remote.server.fetch=
`
has `+refs/tags/*:refs/tags/*`.)

`git fetch --dry-run` prints same tag twice.

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
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e


[Enabled Hooks]
not run from a git repository - no hooks to show
