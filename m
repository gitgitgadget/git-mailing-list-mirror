Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F311465BD
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938819; cv=none; b=V2YyP2ug5uVyAT5gl7CKBVMlMnkZhnWrNKKBv9enz5onf3lm7UKiFxvWq+MrrYQbavsZqq4ovlYEP1xrtW0Sxsvh+ikqeM3Adp98juwgpCHxEd6gqp51NKTCjfZ7+MwqLCyPa2dyr/E0XwzTl8lQnxgenRh7tfsTmSy+SBKdW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938819; c=relaxed/simple;
	bh=Ua6UIycxh14iBIGELLigheFp/I5g7lxFnxREp89n1s8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=reIoCzq4SOmSBMPCnjQsXevgcSjJXoFoqBQgzGGu+yn3OKIqV6N19Aic/NuiQvoKizZOXvxHXZP+wS0yS8U1P0xvqYlLmNBoYtHrvkiIW0mp/C0vVe1/pK+qihkzLMQj0U0zNdOleCCf/71JmaY2Yi8NwCrmBJcXh2SgcsMg3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyG5r1U4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyG5r1U4"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a11e7so2763342a12.3
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728938817; x=1729543617; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4/S9Rfp7yxwICssTxTqp30YaMQvFzQvjVKWQFnQ8+M=;
        b=FyG5r1U46NF5C9VXCQTjgPKYds8uM5V1Bzpqn4jIIsM7vVrtGDz5e/KQZC0Pjc2Jri
         u30vK6hTdqEX6cPBO/fFb2iSNI1oP1o0DfI2fRcaFTK5dlC+GYByVMVOIDF7yAUrlrBM
         c84GPqMWxnK71yGalK85BARPyq9RC3CA7CLDbsNANqN9EB7sVZZ+X9kGYhHyEpEg1maW
         Y35rjq4GoavbbIs0goD9Yd5pKD5eygVHWPgKjfMDfFdGXseZMSh3d6vYCe1EoEihOEyH
         tMW/fphk6V2DSa8WN4HeIRuWHH/5tkD/phj7uW2P0tVBFuOJMBNluBPfY95aJGVFGKdV
         llew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728938817; x=1729543617;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/4/S9Rfp7yxwICssTxTqp30YaMQvFzQvjVKWQFnQ8+M=;
        b=XHT7K0xHp+mOvP1vVHICdaCwqY7kqIsbuBavN1DFnFLfwwuop3YfT6Z7FfuYRQ8rSe
         hSE6RagnrLHkJ0AYk7x9+hp2FF2/FpsaW+B6ELlLlg9YadfjFWNfMuMRoVVsJ8jq1mEF
         OAX84rus6D1RaZgCtn00J13IF22G2Udh+lqpwrKy4jSTk7fLCgMAHsymEHa3uejqyANi
         SoKam7CWOE76AHzxBLfd/lNnFt6hsXHWTBHgNGlGtKXqKoyf/v4Xkz/YJxJXKP9UEiPk
         FWG0SoHGMyzdpoIu1CleKD9q3r+pPP9xynMD8u0i9V2tiKhCmxB4BE/+km1pYeDvp/dy
         ZZPA==
X-Gm-Message-State: AOJu0Yw1Sr+VCGL/e6EpeRSQv4Ehr7s/hJhXHNvUOrmYmeuHOwANPlrI
	/fRt3kqh9YWlBSFqEiVwKe5sK9JtUvLfof9OmuWpcw91Hle3q2FrkWD1nRQ5r+Du/cs+zCAxI5H
	fTGfeHGh/irSsctZdJvDrDbPqErfVn752WmY=
X-Google-Smtp-Source: AGHT+IFZ9XUNpB/BGF5b4OSC4o037hVlxNLD5bwjd0V1ic9BByo1paSKBrQjFBeO0jW34aMYZkK3i0ggUFUg3ru+vA0=
X-Received: by 2002:a05:6402:40c5:b0:5c8:9f3e:1419 with SMTP id
 4fb4d7f45d1cf-5c95ac098bfmr7024845a12.5.1728938816599; Mon, 14 Oct 2024
 13:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Moberg <kaddkaka@gmail.com>
Date: Mon, 14 Oct 2024 22:46:45 +0200
Message-ID: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
Subject: git rebase exec make -C in worktree confuses repo root dir
To: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi, I tried to minimize this but I haven't been able to come to a much
smaller example.

/David "kaddkaka" Moberg

What did you do before the bug happened? (Steps to reproduce your issue)

When doing `git rebase --exec` in a "secondary" worktree, it seems
that there is confusion about
where the repo root dir is. This sequence of commands can be run to reproduce:

  mktemp -d /tmp/git_bugreport_rebase_exec_worktree_root.XXXXXX
  cd /tmp/git_bugreport_rebase_exec_worktree_root.*
  mkdir repo
  cd repo/
  mkdir dir
  echo -e 'lint:' > dir/Makefile
  echo -e '\tgit rev-parse --show-toplevel' >> dir/Makefile
  echo -e '\tgit grep "banana" -- "$$BANANA"' >> dir/Makefile
  git init
  git add dir
  git commit -m"Intial commit"
  git worktree add ../repo2
  cd ../repo2/
  BANANA=$PWD GIT_EDITOR='sed -i "1s/noop/exec make -C dir\/ lint/"'
git rebase -i HEAD

What did you expect to happen? (Expected behavior)

1. This command should return the worktree toplevel, not a subdirectory
  $ git rev-parse --show-toplevel
  /tmp/tmp.DUUAVQCIKe/repo2

2. And the git grep command should return the match from dir/Makefile,
not Fatal Error
  $ git grep banana
  Makefile:       git grep "banana" -- "$$BANANA"

What happened instead? (Actual behavior)

1. --show-toplevel reports a subdirectory instead of toplevel:
  $ git rev-parse --show-toplevel
  /tmp/tmp.DUUAVQCIKe/repo2/dir
2. git grep complains that the pathspec is outside the repository with
fatal error:
  $ git grep "banana" -- "$BANANA"
  fatal: /tmp/tmp.DUUAVQCIKe/repo2: '/tmp/tmp.DUUAVQCIKe/repo2' is
outside repository at '/tmp/tmp.DUUAVQCIKe/repo2/dir'
  make: *** [Makefile:3: lint] Error 128
  make: Leaving directory '/tmp/tmp.DUUAVQCIKe/repo2/dir'
  warning: execution failed: make -C dir/ lint

What's different between what you expected and what actually happened?

See above.

[System Info]
git version:
git version 2.43.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.0-45-generic #45-Ubuntu SMP PREEMPT_DYNAMIC Fri Aug
30 12:02:04 UTC 2024 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /usr/bin/bash


[Enabled Hooks]
