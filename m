Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF2174EFA
	for <git@vger.kernel.org>; Thu,  2 May 2024 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674558; cv=none; b=QvfRQ3OnJ4CwSSJi0kyh2wP49HXfboc/qMKPCic+mfx3jtBz2uJRZSiqSwHBqIrb+gfMkdg0MQZLBRIjVrnN4hMj8DYtBhAB7Yy1qHn1dC0FMC1CJFZRaeg2BHbvETwj/PN+/YnqW1nbmTXAjhZKrQsjJwMzZ11499nGZTpQfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674558; c=relaxed/simple;
	bh=7J3RaicuNDyXaXNFU3RSspUlrDYlwdOO4/E374/WyFo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=g0UVq5aev+ckQ2q1xNTP3jcMBjCFawiR2DuaHK5oydxlVT2XWdJCVNJPyh/UfBrUuWjr0Q4PxWY8ZjArmHkfyXuWLMSiYj4xZ1gYjT2VAZC7RuhnB7DO2jN17lhX5ywIrK1n7pDwJQn5ocOrrExxF5D+B2iwPdxsnD/B8aPAUbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUWB6yLs; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUWB6yLs"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da3ec3e044so378550439f.2
        for <git@vger.kernel.org>; Thu, 02 May 2024 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714674555; x=1715279355; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eictyvFZ9/J8syckGOBATz1wrMpZPvFtht6la9foGKk=;
        b=EUWB6yLsPiR4e6GJ4u83hS3e2xXthvpFHyDjAdcCkJi4/o5Vjo4tMza3J06RiZxz8a
         3k8SkWw0ooYa/gdj8pxDSEEtlP+4X40/Fy081kc+VRPqB1pfwU66ajI2yPcqScwMZ+cC
         3Hci3UJKnouWQkz/m07DYSnww7ov1ar9Zgo1yPqdUOgj7uFDnKEbgaRu/9A4VMvjboje
         7GB6M1fmPqrAikEBDCOpKWHPw9ERSrB9iQZjyo796y+j/zVvNAp0Ouk7JR8UNtRVSgFn
         xlpr9CDJ1DV1NsACSy4K8nU3G8SgjfdvE9NsmpRPNUrRWZlKRUWA5KzvHm2Kt0O9aDZc
         N7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674555; x=1715279355;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eictyvFZ9/J8syckGOBATz1wrMpZPvFtht6la9foGKk=;
        b=i13w0MybgvErxdWoW3WY8O2uczup0mlvfy4LurfF8mw1n8su510tnZSKrc8V31s/J/
         FdP1CWG5FVuIxbGVvP34AqfVo79TIMsu3yIAQBqba8NbjX7mZ4UU4k2AZvf2yoC4uzcN
         PF4P/np7WORcyNeGo7SUktbxQ1c6QTpc438LTmHYfPJxS09N54L8XkItTYl+MstCZTs7
         kZPAfigy3Etiaiy8Y8zEsQgZAiMa19gVONvqwhPDweJYjKHBhgT7Jd2jE5GRNcEiLvlx
         I/aWKT+03EqMksKH5xdy/eHwA793rz5JyHJ7kKQGkthpXGNXbf/WQ528knVdoF795s2+
         Brsw==
X-Gm-Message-State: AOJu0YwTs380GWqvQ39P5gEq03hOgHBHduNGGjstzAaSGybjEpMC1I/E
	A1HBYMDeJyGuboMmOmsUx9Te5lhb5WMuEqfs70sWkmWsLgklCFigV1IkpbpeTEPgvsizqEIG30M
	QlyBGQtAlLcRcbdxi43Ye4lZXBfGhi31e
X-Google-Smtp-Source: AGHT+IEKcwbs6Tx/2HC3Qx2PJec5mLrsjlPqSs5GBZFaEp7r+alaTI4AL4eqNo20qEPyy0DcBJ2oLH9op/qsejBlDks=
X-Received: by 2002:a5e:db42:0:b0:7de:9669:7f75 with SMTP id
 r2-20020a5edb42000000b007de96697f75mr613297iop.14.1714674555598; Thu, 02 May
 2024 11:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>
Date: Thu, 2 May 2024 21:29:04 +0300
Message-ID: <CAP9Eqm1PsYBdjoVKgomJZe79_ZCOAtP4p7uvprUOerdjrcUjmQ@mail.gmail.com>
Subject: [bug report] `git log` with several `-L` might produce error
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a bug report as per https://git-scm.com/community

# What did you do before the bug happened? (Steps to reproduce your issue)

Calling `git log` with several `-L` flags can result in an error.

Steps to reproduce (on Linux):
- Set up repo with a history:
    - `mkdir log-line-assert`
    - `cd log-line-assert`
    - `git init`
    - `echo "Line 1\nLine 2" > file`
    - `git add .`
    - `git commit -m 'Commit 1'`
    - `echo "Line 3\nLine 4\nLine 5" >> file`
    - `git add .`
    - `git commit -m 'Commit 2'`
- Execute the following command: `git log -L2,2:file -L4,4:file`

# What did you expect to happen? (Expected behavior)

Show log with evolution of lines 2 and 4.

# What happened instead? (Actual behavior)

An error with the following text:

```
git: line-log.c:73: range_set_append: Assertion `rs->nr == 0 ||
rs->ranges[rs->nr-1].end <= a' failed.
zsh: IOT instruction (core dumped)  git log -L2,2:file -L4,4:file
```

# What's different between what you expected and what actually happened?

An error for what looks like a valid command (as some other similar
commands work as expected, like `git log -L2,2:file -L3,3:file` or
`git log -L1,1:file -L4,4:file`).

# Anything else you want to add:

-

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.44.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.8.7-arch1-2 #1 SMP PREEMPT_DYNAMIC Fri, 19 Apr 2024
09:51:31 +0000 x86_64
compiler info: gnuc: 13.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
