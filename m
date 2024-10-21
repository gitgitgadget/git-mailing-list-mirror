Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9221EE037
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529946; cv=none; b=jmbbkt+hMgICyRysPx+krrV4cwCmMHOpalhXXgPNtPzTEdoxqwv1ceaSzoajg1iLehzTaWKewDXkcty5YBzpePf/85o3+21SkpqGzWufCEKpS/8o0JBV/VndzB/oYss+/EuZDDdKgyZz5CbNQArPvIU0ERGU6myChE1RVEJUGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529946; c=relaxed/simple;
	bh=+QB5gVwFbfowyWzdP/xczDDGBAs0O0nuo428Ju546gs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UrnsM/YGUKFz5ArYRUd+El3TAh+hDBXzZwAhw/lIAzagG/NrOY8zVxVEa2sCOjG6NAJO90gLSEVK41dYna2usRFzs11ALLQah9WcreS0HvuGvPjk6SLDFdsnsEktXi8hKmBBJJw7ONwoZGvOGuPuTCPTNa0Oe95nL1YflMOXygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io; spf=pass smtp.mailfrom=island.io; dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b=kkNzjxHv; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=island.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=island.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=island.io header.i=@island.io header.b="kkNzjxHv"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so642651366b.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=island.io; s=google; t=1729529942; x=1730134742; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0ycEUFb80Jb2CCJaGco1Qh8P3eHfPHr4RCkSsTIOVNE=;
        b=kkNzjxHv5+pkzyWABIPttAEw2B0EG9Bp0uI8aPOkVWU8rsGsOV8QqZlfKs4OQOp7vz
         aWN+mdv1DzjG+450nzQ8ORz2j2SzhuTD7Fb1FsO7UPL+/I60Qq4c1FIPLWa4rBModnQa
         tnciki7NzNTiyck5X/d8UbcWtSk4YBTzQZSp8AMwWRwPeuMmdH5ffc/kU+avRHzUHSNK
         2edMPG3skV7REYmrGoSzIXXsPd1uaMFIm4+PhFgE4r0CclOSPuBTlmWdng12pWttT9Aa
         vgj0+Kh9EQza4uHVJrc2XAyKBx8ejRzsmPE+x7GW/BkammhvGmJ1SXzmL3HbEbXlned0
         GTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729529942; x=1730134742;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ycEUFb80Jb2CCJaGco1Qh8P3eHfPHr4RCkSsTIOVNE=;
        b=hYB1Dk/wrQJfOL/qkqY4iVVboPaffHQ9C+u5fJZpobBVT7F4xsitPc8fmeo+M49k1a
         EEOxQqbQ+5M6qTW8aNwbDrG7ZSzxcPgGYtv1I1EPqUHg7IOspoostHbHcyTq2m49Oixp
         Jl8mVQN9XuB5AJNpHKMstmZGFXLd1uj2mcLK+UAlaFuvO/hLntt15/og6ZRyllhMR3lI
         2MLwEljpN6sFLVMKii2P3O9S6UStlpNzXxqCRDGcdT/EtcTMmB8AnMXoGE1/pzdO3hGd
         i8D2HgYF1ejOJ9EYPJbT5aDBnlD2givrdBFYsCA0+Hvdm69kzSoIQScM48tp8Ix9W1Fs
         R5bw==
X-Gm-Message-State: AOJu0Yx/IR77VpfLuvlaArpa7k5DRUy0wb8C1soF8A8QodtEBPvHaHHV
	ZPbKm2itwf9O3zD4MagY0X0b8H0liOq3vxcFOvvkLxziuRiM5AFDm+8G9kGFA477SA+9kZ9wlxS
	EuWzQQbJwR43jffKdxwo05ZcORDcZqO+R31Z4lYb2O7tHFgAoL/I=
X-Google-Smtp-Source: AGHT+IFcNTUfgfJcIDwWk/+BXMr0HGxpaTQ+UNzSTXSLLk8NI7lRI0mGZMrvTOxJ7qieHPFALChYxPOXXGcxJQX4HFY=
X-Received: by 2002:a17:907:7d8e:b0:a9a:2afc:e4d9 with SMTP id
 a640c23a62f3a-a9a69ba5848mr1309241666b.29.1729529942280; Mon, 21 Oct 2024
 09:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikita Leshenko <nikita@island.io>
Date: Mon, 21 Oct 2024 19:58:51 +0300
Message-ID: <CAEXts1vjiFsMCL9ANsqnz-mwFCZQyM6S5u_qXz8v1P=z1o3gsQ@mail.gmail.com>
Subject: Empty directory showing as untracked with untrackedCache (with
 reproduction script)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary: Enabling untrackedCache sometimes causes an empty directory to show as
untracked (as if the directory contains content). This is racy but there's a
script to reproduce it deterministically.

What did you do before the bug happened? (Steps to reproduce your issue)

- Create repo with some content
- Enable untrackedCache
- git status, shows nothing
- create aa/bb
- git status, shows '?? aa/'
- rm aa/bb (leaving aa/ empty)
- git status

What did you expect to happen? (Expected behavior)

git status should show nothing.

What happened instead? (Actual behavior)

git status shows aa/ as having untracked content.

Anything else you want to add:

Here's a Python script to reproduce:
------------------------ >8 ------------------------
import os
from subprocess import check_output, check_call

check_call(['git', 'init'])

# Populate directory for some load, makes reproduction faster.
for a in range(40):
  os.mkdir(f'z_{a}')
  for b in range(40):
    os.mkdir(f'z_{a}/{b}')
    for c in range(40):
      with open(f'z_{a}/{b}/{c}', 'w') as f:
        pass
check_call(['git', 'add', '.'])
check_call(['git', 'commit', '-m', '.', '-q'])

# Enable untracked cache.
check_call(['git', 'update-index', '--test-untracked-cache'])
check_call(['git', 'config', 'core.untrackedCache', 'true'])

# Repeatedly create/delete same file.
for i in range(1, 1000):

  s = check_output(['git', 'status', '--porcelain'])
  assert not s, "Expected clean git status"

  os.mkdir(f'aa')
  with open('aa/bb', 'w') as f:
    pass
  s = check_output(['git', 'status', '--porcelain'])
  assert s == b'?? aa/\n', "Expected aa dir to show up"

  os.unlink('aa/bb')

  s = check_output(['git', 'status', '--porcelain'])
  if s:
    print("\n\n=============== REPRODUCED! ===============\n")
    print(f'Reproduced in {i} attempts')

    print(f'\n$ ls -la aa/')
    check_call(['ls', '-la', 'aa/'])

    print(f'\n$ git status')
    check_call(['git', 'status'])

    print(f'\n$ git --version')
    check_call(['git', '--version'])
    break

  os.rmdir(f'aa')

else:
  print('Failed to reproduce')
------------------------ >8 ------------------------

Example output of this script:
------------------------ >8 ------------------------
Initialized empty Git repository in /home/user/tmp/repro/.git/
Testing mtime in '/home/user/tmp/repro' ...... OK


=============== REPRODUCED! ===============

Reproduced in 90 attempts

$ ls -la aa/
total 8
drwxr-xr-x.  2 user user 4096 Oct 21 19:46 .
drwxr-xr-x. 44 user user 4096 Oct 21 19:46 ..

$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)
aa/

nothing added to commit but untracked files present (use "git add" to track)

$ git --version
git version 2.47.0.107.g34b6ce9b30
------------------------ >8 ------------------------

This reproduced in the following Git versions:
- Latest master (34b6ce9b30)
- Latest shipping in Fedora (2.47.0)
- Ubuntu 22 LTS (2.34.1)

[System Info]
git version:
git version 2.47.0.107.g34b6ce9b30
cpu: x86_64
built from commit: 34b6ce9b30747131b6e781ff718a45328aa887d0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.6.0
OpenSSL: OpenSSL 3.2.2 4 Jun 2024
zlib: 1.3.1.zlib-ng
uname: Linux 6.11.3-200.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Oct 10
22:31:19 UTC 2024 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.39
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
