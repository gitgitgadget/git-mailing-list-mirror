Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46FA2F44
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 04:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725510364; cv=none; b=iKwrcz33ZrCku4H0mt2sDmkBQH6xxkEdU1eCMltzxJAPN9SO6qUv5g0ySCn3KQpznhRx0nZ2s86WyKWN7YZN/iPP36QWcI6Kc/4JMiV7SK6IcryZQOBsBaeSjkFZB09aavE8oCPZABgCHj3h+Oh9IHTst42Cd/o7WISDZ0P1Ph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725510364; c=relaxed/simple;
	bh=FBGRAzIYh938qBaZlap2KLyYp9EQCmp79RAG+7Jzgj4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lKCDT2lleTnYVodH7a5MzoMgETYeYrnnzJ02vnJMCOZBqaQwQhbQ7TbWBqdlfMGt5gm1jPNjJGFIarr0MNMVk99kd0yeMbDhq8AWGBxM465bKhNd2NGE+30fITadnVfkribO/43/xZVqyPT8sDmCwPS/uaTgfMgffMAlHmaK5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hu/1u22Z; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hu/1u22Z"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86e9db75b9so49974766b.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 21:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725510361; x=1726115161; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FBGRAzIYh938qBaZlap2KLyYp9EQCmp79RAG+7Jzgj4=;
        b=hu/1u22ZM+YYjFNQe7mEduwuu8lf5yAimDUpfhGtp9DowirooEMzAWYfO2vq9GKv5p
         P/0T/7eGVgHhlOXitgvw1LlcCY+4cstpM/BvgqQ1ZsvGUZjqRSDcqXlCwGdhLYgGk/QL
         ulg4ElDwdRel25gSV6+VfGc0cry5nHkwg45/+Ck+iAub7ja0FsMmbCeG5Mw+ChE3Bpbo
         Qvu1m3z2QIIZ83xl+aGMi+/dzonTNFJG2tIaHpHPycnupWunEIhlLtbM5Q2ocx6g3xZm
         tku7L7nnyDWLcqBqAe007YCF2HvV0Il1WSRaG/M+MMtgvtSkAwwI289cehnNHQzfJ6F6
         xDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725510361; x=1726115161;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBGRAzIYh938qBaZlap2KLyYp9EQCmp79RAG+7Jzgj4=;
        b=Zako7I9bQ+aQ0lS2DjQKo4+FZj4FnVTM5BiXX5e7dycg+/wwkRSZr+TfKOtsM9JQT/
         cVpyOpI0DlfcETO2wL/M87GR834wOs6ZE3uYcaqV6X4mMgQy69WE6MfmDu94K9gBkETl
         qxaBmWvBAqwpuG8PvI/5y3v79+5Tb6V+iX1CZhbanqnDOsp8Yo9GSe1B6G+1pcmj37ZY
         U6101NHnqW3R+VoD2SkTpwNmBlg2AW9qXYaWSf0YuUCf7+rYNDtJjMBLDGPR7uXE9Rgd
         G5vQmZba2NNDUk7I2u7McqwsFQqzU2sT1HaT27NhxE6UGAOz/RrkQrUEVVtXEIvshZUj
         s5BQ==
X-Gm-Message-State: AOJu0Yx1QneCpZ3+WOPdXY8cIY5GUU4jS7/9jQeAuWYKkiKg2qtS8SSy
	ocyNKnP3F855a030XwnW5QWi6610o8X7Rw+vy40+sFZbz+rKFSbz52OHlxvUJIpvRUSK/sgGa6j
	mQMt+rMPq1gKrtkgq0tTLCOupeDdLey6a
X-Google-Smtp-Source: AGHT+IHcrqVBoeOb7nac/XPihZkXpuUiFsoZ0y6zpaosddcODM3F7hPxK96AXLvU37CkUaLGCH/xwU0yk/fQAO9sGw8=
X-Received: by 2002:a17:907:97c9:b0:a86:a30f:4b0d with SMTP id
 a640c23a62f3a-a8a1d327763mr687030666b.38.1725510360718; Wed, 04 Sep 2024
 21:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 5 Sep 2024 16:25:50 +1200
Message-ID: <CANrWfmSMbR+8oGsCzOygBA0sFSmMwUmCy=qQEsa16RWcztYaQA@mail.gmail.com>
Subject: `git log FETCH_HEAD` only logs whatever happens to be the first among
 the fetched refs (instead of all the fetched refs)
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git2'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'
branch_default_path="$(git -C './server/repo.git' symbolic-ref HEAD)"
branch_default_name="${branch_default_path#'refs/heads/'}"
git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"
git --git-dir='./server/repo.git' --work-tree='.' checkout -b branch1

git -C './client' init './repo'

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"
git -C './client/repo' fetch 'file://'"$(realpath
'./server/repo.git')" "$branch_default_name" 'branch1'
cat './client/repo/.git/FETCH_HEAD'
git -C './client/repo' log --all
git -C './client/repo' log --all FETCH_HEAD
awk 'BEGIN { ORS = "\0"; } { print $1; }'
<'./client/repo/.git/FETCH_HEAD' | xargs --null git -C './client/repo'
log --all

git --git-dir='./server/repo.git' --work-tree='.' commit --allow-empty
-m "$((++number))"
git -C './client/repo' fetch 'file://'"$(realpath
'./server/repo.git')" 'branch1' "$branch_default_name"
cat './client/repo/.git/FETCH_HEAD'
git -C './client/repo' log --all
git -C './client/repo' log --all FETCH_HEAD
awk 'BEGIN { ORS = "\0"; } { print $1; }'
<'./client/repo/.git/FETCH_HEAD' | xargs --null git -C './client/repo'
log --all

What did you expect to happen? (Expected behavior)

`git -C './client/repo' log --all FETCH_HEAD` logs all commits.

What happened instead? (Actual behavior)

`git -C './client/repo' log --all FETCH_HEAD` logs $GIT_DEFAULT_BRANCH
when $GIT_DEFAULT_BRANCH is listed first in `git fetch`, logs branch1
when branch1 is listed first in `git fetch`.

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
