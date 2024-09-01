Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5D142E70
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725188542; cv=none; b=nAkJwUKdj+825r33l4I1RwRs2q6iCUoQANdfPXy4lWpHO0iPmE5HKpn6D19qCwHlD86Bb22Jj/J7Uf6vkS9e8sZDTpuaQWH45TKTWCHDsPfYPMxK2KhciN+rqV9rFrTAIe+qjmWrXmj2boyc/A2ziIcev/TIdCVEyQpkxdnc9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725188542; c=relaxed/simple;
	bh=oAlSCWdg1PCvHeGQxG55N3cuR9BqKCp3L2eNDZGxd9g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TVfjXByoCZDeay/bxlWUMJtJHUaN7dmWN5KQa/yESmuGpXl4nABNuTxM5rs2rt9f96xZf7hNv26ubzh4HdDZq51oNZqCMLyt6EDY/nwjsysZ0QgDCf5fWi16PHExxttRyPJw6/l/qX1pgrdVAlcPTUn1BqeXicXkvj08BdfREJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKx5hdLt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKx5hdLt"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86e9db75b9so341517166b.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725188538; x=1725793338; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oAlSCWdg1PCvHeGQxG55N3cuR9BqKCp3L2eNDZGxd9g=;
        b=QKx5hdLtYTQ0p9e01QUJ3PG99yZA0Ah08/DkbqoexsUrRqi/Ha3hfDsxpYbkOiPyfx
         zaOhPHPbDorKMUfd5uO3/onyvRhlg44T01EuX1uzogsWW+QZ9AqRMKnD7LeWUhgcLfSk
         fYLijVjWOy4G74vpA0+QqjuULYgGElnVrDyfSxOseSj7Qz9RwGXCgpWq0gSqStQjqoA6
         tjY6iEoFiykgBUPLesELbbSjaUOlzH8qsO4c31C9LlGaL1pKIhaGnYELnF0qTpZiTMd6
         OcLyIS381/xSrXxSDzEashLNRjRnrcz85/Zu6Hayjv2tva5E/f2tvKd5UKW0q66cOZjU
         4Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725188538; x=1725793338;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAlSCWdg1PCvHeGQxG55N3cuR9BqKCp3L2eNDZGxd9g=;
        b=loh+2ZYG/TjuEq+TbF6dqQJaTZOoKZiIwbssco84ZgEDb06Jmu+bmj483b/NztOEmG
         hmY+ZbNyxxIJ81TqWqtpFc8394SRie4NJm5WBq+sE5nS71E9JepQ9qUqePi5gnx0xNmw
         8F1V2q74SvqszN9HIXPIU/MjaKziM7vUvf3dx23JKTFB7AwTZ5Qnd/fN8RhSwX3OqdGr
         ZCjxOi0DE7LofneEaUh+IW+kWcmTaeL9bNxRZqEDSJn+h4dU8Z4y58tQWn/4uo/u5AfD
         bloIUricHuKV4SLXq0jDqiyjbPPQOm/9C58i3F9vK7TWq1q3x/oR02T3WlHNj0IgJcte
         Cd2A==
X-Gm-Message-State: AOJu0YxnL0MdoJuGDfQsRCOUzs/PDSZuaBfsw5qq/Awl36yt+/MLfzmY
	7Np8397rCAkibq1OEgJtVtsk4qOkH7yxjmuuEGhPySf7vU/GAAakFqwixbBMsXZFWaaeiaMGqN/
	OadyLKtsMqhaqdbFglAqZXBvOkyM6HIfw
X-Google-Smtp-Source: AGHT+IGYZMimdlgTVFwmoKC0cmWSS3ZaqeVYa8yzSlKZtMq1gvxxDGU5421GmHMBcBRHJEWfs/bDifCnY3v5C2htCQc=
X-Received: by 2002:a17:907:3ea6:b0:a86:78ef:d4ad with SMTP id
 a640c23a62f3a-a897f84d328mr831105466b.20.1725188538356; Sun, 01 Sep 2024
 04:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sun, 1 Sep 2024 23:02:07 +1200
Message-ID: <CANrWfmSY1F4UB2QSjN8XKY7Kwx6FL8SOrz_OadZ4u8XYDpZfBg@mail.gmail.com>
Subject: `git rebase (--no-fork-point) --onto=<newbase> [<upstream>
 [<branch>]]` leaves HEAD detached and *HEAD not moved when <branch> is
 exactly `HEAD`
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
echo '1' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
echo '2' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
git -C './server/repo.git' log --graph --all --patch

git -C './client' clone '../server/repo.git' './repo'
branch_default_path="$(git -C './client/repo' symbolic-ref HEAD)"
branch_default_name="${branch_default_path#'refs/heads/'}"
echo '3' >'./client/repo/file'; git -C './client/repo' add './file';
git -C './client/repo' commit -m "$((++number))"
git -C './client/repo' log --graph --all --patch

git -C './server/repo.git' reset --soft HEAD~1
echo '4' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
git -C './server/repo.git' log --graph --all --patch

git -C './client/repo' fetch --all
git -C './client/repo' log --graph --all --patch
git -C './client/repo' -c 'core.editor=cat' rebase
--onto=HEAD@{upstream} --interactive "$(git -C './client/repo'
merge-base --fork-point HEAD@{upstream} HEAD)" HEAD
git -C './client/repo' log --graph --all --patch
echo '5' >'./client/repo/file'; git -C './client/repo' add './file';
git -C './client/repo' -c 'core.editor=:' rebase --continue
git -C './client/repo' log --graph --all --patch
git -C './client/repo' checkout -B "$branch_default_name"
git -C './client/repo' log --graph --all --patch

What did you expect to happen? (Expected behavior)

HEAD points to GIT_DEFAULT_BRANCH and GIT_DEFAULT_BRANCH points to tip
of origin's GIT_DEFAULT_BRANCH when rebase completes.

What happened instead? (Actual behavior)

HEAD is detached and *HEAD is not moved when rebase completes, so `git
checkout -B` is needed.

What's different between what you expected and what actually happened?

Anything else you want to add:

Replacing `HEAD` with branch name (`"$(git -C './client/repo' branch
--show-current)"`) works around the problem.
cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_";
mkdir --parents -- './server' './client';
git -C './server' init --bare './repo.git'
echo '1' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
echo '2' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
git -C './server/repo.git' log --graph --all --patch

git -C './client' clone '../server/repo.git' './repo'
echo '3' >'./client/repo/file'; git -C './client/repo' add './file';
git -C './client/repo' commit -m "$((++number))"
git -C './client/repo' log --graph --all --patch

git -C './server/repo.git' reset --soft HEAD~1
echo '4' >'./file'; git --git-dir='./server/repo.git' --work-tree='.'
add './file'; git --git-dir='./server/repo.git' --work-tree='.' commit
-m "$((++number))"
git -C './server/repo.git' log --graph --all --patch

git -C './client/repo' fetch --all
git -C './client/repo' log --graph --all --patch
git -C './client/repo' -c 'core.editor=cat' rebase
--onto=HEAD@{upstream} --interactive "$(git -C './client/repo'
merge-base --fork-point HEAD@{upstream} HEAD)" "$(git -C
'./client/repo' branch --show-current)"
git -C './client/repo' log --graph --all --patch
echo '5' >'./client/repo/file'; git -C './client/repo' add './file';
git -C './client/repo' -c 'core.editor=:' rebase --continue
git -C './client/repo' log --graph --all --patch

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
