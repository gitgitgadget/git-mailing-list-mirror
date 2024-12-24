Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD618EFDE
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042053; cv=none; b=s00ectomSh1vHLaHKdpJ2Wd9xvCOeeMFWXF7UdeLmpaOBGrEjRoEj0OkexWzJIA+OQdvJBdGael5kI/LjZYIqyfbzSx4/s9TNgRjSoaLcwMq28hbqoE1Zdl84sXRo6TQL7ittmgzv5ZWn9ny7lvn8FyBKVEIN1pMWqoMh5KTniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042053; c=relaxed/simple;
	bh=GjCC5xYbQ1WMTP/lGYcQ1xjPhwTGK5b7F2BJMRIJIdw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZKlR6J5Oo55XMs12FGY34kk9Sz8qjbEmWL7EE6oIraEvMk4NRLtnM6N32XpoByrGqW1nQ8Kx8d+TnWIsffSdoEbLKaa+xuXGA5H53p+K1yIXiau0qHvLWAeJGPHL/492noYbEDgShxmaBlwZf0lelZXfjvmERWQG1oihBmSz+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ki3DzSwc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ki3DzSwc"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d437235769so2348729a12.2
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 04:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735042049; x=1735646849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hwc8fgm8/iIFiR1nw+OuyAs4uP7kfcdz0PhpqtY7TLY=;
        b=ki3DzSwcZ6HUmkSks9l2aV2QelKNh+I5/XRkedIB/cnxU5t6lyN65/Y+/mk7HCZZ6D
         LiRm27N6JrZsD/CRx+ayY73LCfGshVq5lgrwC3W3abtYzRFctuln3pxVQdwvxN6BApuS
         eaV/bOxlP80JcVjjUSttjD+h6+Su150YNPER/kvNlSH2KRHEfmCHrinlU9ySOF0jRa+G
         89CXZoCSt7gfMb39nlL/iTCF1Yc8MnExtsROP35OeQVv7B2FD2DlMMqBYAocSpUxFrNT
         1CieO4OF4usFWNOKl/tQH0OodVwf08NrCJeLdyhk2p/a+f1aKHFjmKwnKjqC1PQ5TanJ
         tVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735042049; x=1735646849;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hwc8fgm8/iIFiR1nw+OuyAs4uP7kfcdz0PhpqtY7TLY=;
        b=JER5nR2VBBsNdLDb5YxxYQS1lQYuPa7+6z31JpmFownRbbajhAc2ryj19xV7dN4TXK
         v95GftOP+t5P83V0u4YP8aFkgPsvMI+g/2LH7j+wZkd1crrbS562XdN3Jn4tqRAEEhs1
         BB8hwbZnEZaYi+u13lhJ1Q3Ak13PEps6ViGk0bSa0r227xyFaPRQOhjdo4vbnHO+qIMm
         /cZ2xZ75cucKzR0sN6TsFqD04ZnAo9RUK9GWsmx5I0ez2CAu1546QSq4bK8iY1Yie5jI
         aGTMv2hKcqikOORC5Sf9rmXQv7APRXo2GCyQlh+ZYiMB0QhQO4/s3Z/0+F+ncswXSL3D
         6ObQ==
X-Gm-Message-State: AOJu0Yzx84oHoRreGPDuGFyV2cY+yJ9dHTTI2Y+WfuuN6h9ztrj1Xz1e
	o67Oa7lkU4Brx2xu36ec7JyaoEpaTpgPBhqbM9aNyQP1R9WU6gDl/b4VuQw+XEWraBi17kbqZWF
	TGvKcZcbHSriMeSsN8iBDKKKv1yI2J2fVP+0=
X-Gm-Gg: ASbGnctBom/YGTt+/cfwBQ1y9sMPFzpgbfrTGEQR5WEB6t6+JxPavKbRRkNV0rck2JL
	KLIjCt3DidYKg2UYbpkfLpW2/LOpZZFb7yhkqgQ==
X-Google-Smtp-Source: AGHT+IERh35G1uHuwuwvRU6cF8ueawhVFaY8Vsx5GODNOm66qQWiurphWs06/F2pcOefyqnxYmSB2S1ZCs455h5XAq8=
X-Received: by 2002:a05:6402:5193:b0:5d0:b455:36ad with SMTP id
 4fb4d7f45d1cf-5d81ddf7fc1mr16577608a12.27.1735042048956; Tue, 24 Dec 2024
 04:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZheNing Hu <adlternative@gmail.com>
Date: Tue, 24 Dec 2024 20:07:16 +0800
Message-ID: <CAOLTT8Q0cH3Q=yPnTYKAwn8bC+iDW7onibsLF=bzVr8tGw5J0Q@mail.gmail.com>
Subject: [Possible Bug] --cruft option not work with git gc --prune=now
To: Git List <git@vger.kernel.org>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

I am trying to use the --cruft feature of git gc, and everything works
well, but when I combine it with --prune=now, I notice that no cruft
package is generated, which is very strange. So I turned on trace and
checked: instead of executing `git repack --cruft`, it executed `git
repack -d -l -a`. Is this normal? If `git gc --cruft --prune=now`
doesn't work as expected, it won't be safe to further execute `git gc
--cruft --expire-to=<dir> --prune=now`(in my another patch).


I checked the code, and it appears that add_repack_all_option() first
processes `--prune=now` before handling `--cruft` option.

If this is a bug, I am willing to propose a patch to fix it.

```shell
GIT_TRACE=1 git gc --prune=now --cruft
19:56:54.132263 git.c:479               trace: built-in: git gc
--prune=now --cruft
19:56:54.137004 run-command.c:666       trace: run_command: git
pack-refs --all --prune
19:56:54.137087 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git pack-refs --all --prune
19:56:54.152233 git.c:479               trace: built-in: git pack-refs
--all --prune
19:56:54.166598 run-command.c:666       trace: run_command: git reflog
expire --all
19:56:54.166705 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git reflog expire --all
19:56:54.181965 git.c:479               trace: built-in: git reflog expire --all
19:56:54.184495 run-command.c:666       trace: run_command: git repack -d -l -a
19:56:54.184571 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git repack -d -l -a
19:56:54.196211 git.c:479               trace: built-in: git repack -d -l -a
19:56:54.198260 run-command.c:666       trace: run_command: git
pack-objects --local --delta-base-offset objects/pack/.tmp-59391-pack
--keep-true-parents --honor-pack-keep --non-empty --all --reflog
--indexed-objects --write-bitmap-index-quiet
19:56:54.198304 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git pack-objects --local
--delta-base-offset objects/pack/.tmp-59391-pack --keep-true-parents
--honor-pack-keep --non-empty --all --reflog --indexed-objects
--write-bitmap-index-quiet
19:56:54.209384 git.c:479               trace: built-in: git
pack-objects --local --delta-base-offset objects/pack/.tmp-59391-pack
--keep-true-parents --honor-pack-keep --non-empty --all --reflog
--indexed-objects --write-bitmap-index-quiet
Enumerating objects: 512819, done.
Counting objects: 100% (512819/512819), done.
Delta compression using up to 12 threads
Compressing objects: 100% (237575/237575), done.
Writing objects: 100% (512819/512819), done.
Selecting bitmap commits: 23999, done.
Building bitmaps: 100% (309/309), done.
Total 512819 (delta 116078), reused 512819 (delta 116078), pack-reused
0 (from 0)
19:57:12.783287 run-command.c:666       trace: run_command: git prune
--expire now
19:57:12.783887 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git prune --expire now
19:57:12.799337 git.c:479               trace: built-in: git prune --expire now
19:57:12.802050 run-command.c:666       trace: run_command: git
worktree prune --expire 3.months.ago
19:57:12.802115 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git worktree prune --expire 3.months.ago
19:57:12.812977 git.c:479               trace: built-in: git worktree
prune --expire 3.months.ago
19:57:12.814412 run-command.c:666       trace: run_command: git rerere gc
19:57:12.814476 run-command.c:758       trace: start_command:
/Users/adl/libexec/git-core/git rerere gc
19:57:12.825732 git.c:479               trace: built-in: git rerere gc
```

--
ZheNing Hu
