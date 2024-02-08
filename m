Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053743714C
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 19:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420784; cv=none; b=Ntyb6BvrSV7tuUlHhXQOoKB8xYkRli1HPQi2dyx7wThCzNtowropVNlawWXIh1iUl8lUJWnvClb4ZSb4Y0S9gAUNt9TP3es9Tji37fg1c53a/FiFsG6nzOBM0pYtCuY6lrKc2nfaQyUY9unG4qP3gmlAqJKTlVqNtbzGdjCh+J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420784; c=relaxed/simple;
	bh=dGW+h86aKEH3kqWsuccVNT6E62xrn3f38EZPH4HFrrc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XynqcUp2nJW9DwA4tlxmIBP8Y7re2GeMQ1//tuDKB5ZqOT5BOh+74ZwwY0DbA0qRi8/rrlAaBOKbSdlS1B5eH6samfvAHNTg757IJD64/x55AZDjFzy0JMh895AUUpiOzgLdQCFKU1iOs5+ZW8ewp0F6GkPxAVKFEasoQgW3MWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ixl.com; spf=pass smtp.mailfrom=ixl.com; dkim=pass (1024-bit key) header.d=ixl.com header.i=@ixl.com header.b=DYDu8f8F; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ixl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixl.com header.i=@ixl.com header.b="DYDu8f8F"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a30f7c9574eso18057866b.0
        for <git@vger.kernel.org>; Thu, 08 Feb 2024 11:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixl.com; s=google; t=1707420780; x=1708025580; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dGW+h86aKEH3kqWsuccVNT6E62xrn3f38EZPH4HFrrc=;
        b=DYDu8f8F0yWkSWneMDqlGVc4Mpls/Kc6KGpOm1Rdj4/DNLJduGeDHW1BVpyA/j5SD0
         urNRBR9optCHzAmtPYHuw1uXYHbKF0MaYr2SK2wydySvns6JeiiKDQZBNxAvT5ZhVeGT
         YQz56R33pp6VN3BeQxC6Gt9OBPBA9APO76ndQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420780; x=1708025580;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGW+h86aKEH3kqWsuccVNT6E62xrn3f38EZPH4HFrrc=;
        b=Mfo/UsSWGcC5VW+TS5Wv7ddTmtWfrVRSu+zucwbxsCyNLRflLAlYynbDxqNLFRkF3K
         GqQAOYd1/PY9D+rIFOSozyK2tskUcDAGgNwMPU6LDjPQ2FVODNwUq2L7i6sZhBXojcf7
         UtEOvKFNIn5r6Wdm9afoSI+7+m7DIYz7aE35rFmJmySXPrGlAoyz5Le3YfLsw9EfO4uv
         67QWBCQBZ+LSyHPqGqU0LozAXYZ8+ljgwbEN6UKrNgGh0oYd9pl5iVVzET0wW2S7R6QE
         uQae8hRPOObmdAde5DLjQwYiNjrzLdFvxE1EgrqrcQNmFvfKBjSHauRFtMNF6JkNIiM+
         ue+A==
X-Gm-Message-State: AOJu0YzC0D6myFrirZYAYWLkAE/DgKaM1xixR7SYnL+MqnyYvFNVORqP
	lF9TOKicPRwhYdlkX/lbOeCeFa04cH16c++QWZtEDKQoMK6Ihffk+N8JwiRbM01y6ORUWZsKh+j
	HY6pWXpMOVSiT18Nko1vEppFZYhLh4y/kjQaC1lPvGTvi47Zkfg==
X-Google-Smtp-Source: AGHT+IFHVMHrQgI4sUGZj1aBh9X5LRwj7YOZRw6O1m4WhAx+aA4jWp6OmfzmicPRC4CH+ubhayAfAnXLG1eoC6csK5g=
X-Received: by 2002:a17:906:6ce:b0:a38:1938:3d41 with SMTP id
 v14-20020a17090606ce00b00a3819383d41mr224624ejb.10.1707420779948; Thu, 08 Feb
 2024 11:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Justin Tang <jutang@ixl.com>
Date: Thu, 8 Feb 2024 11:32:48 -0800
Message-ID: <CAO18WYyQas36PNz20+pRt0usGqZwrhVYDbQfPZnHEVD8esfoyQ@mail.gmail.com>
Subject: git bug
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!

Please answer the following questions to help us understand your issue.


What did you do before the bug happened? (Steps to reproduce your issue)


add a new file to the git directory, untracked. with some path path/to/file


I wanted to use git diff on untracked files, so I added the file as an

empty file to git, with:


git add --intent-to-add path/to/file


Then I wanted to stash my changes, with:


git stash save


What did you expect to happen? (Expected behavior)


My changes to be stashed.


What happened instead? (Actual behavior)


I can't stash my changes, git stash save or git stash save --include-untracked.

I was getting this error:


error: Entry 'path/to/file' not uptodate. Cannot merge. Cannot save
the current worktree state


What's different between what you expected and what actually happened?


umm


Anything else you want to add:

Anything else you want to add:


I 'fixed' this by removing the empty file with git rm -r --cached path/to/file


Please review the rest of the bug report below.

You can delete any lines you don't wish to share.



[System Info]

git version:

git version 2.38.4

cpu: x86_64

no commit associated with this build

sizeof-long: 8

sizeof-size_t: 8

shell-path: /bin/sh

uname: Linux 3.10.0-1127.13.1.el7.x86_64 #1 SMP Tue Jun 23 15:46:38
UTC 2020 x86_64

compiler info: gnuc: 10.2

libc info: glibc: 2.17

$SHELL (typically, interactive shell): /bin/bash



[Enabled Hooks]

commit-msg

post-commit

post-rewrite

pre-commit

pre-push

prepare-commit-msg
