Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08A218828
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401347; cv=none; b=WtC5xuJQAk8WAt8SLaDz7ArcxZGRQrGpMbY+WhM7VMgz2JzTRosilEVuAOW+8eqG/HYwtDseGvsUK53eRLroarIf4moPCjo/QlOR9uj5pwp2fRjFquCjWuxyydqZdOPwMZTdlb/nnvzGNGKVtjrra/I0vMHdmaWNe71Gb8GTdUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401347; c=relaxed/simple;
	bh=1uozTr5ZhSkYGhvvGGt6vAqWCt9KFMZvk/XMT461V08=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=e7iWoD/Hdvrx82IIzd//9q/2tqSjj8soFRrWzB3IZ+/zMSy5GnTIIAzlfc22Ui2iqPhCPsVIGLpqpSFeVIFA9Tuwtj81ERBc3+nDNaf4kQqdd4XAIYFQZjBwcSb8gMkNVTxh8HloLkXbGnLkaFgJaQDvlNdD+XG0v71WVba9NGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valohai.com; spf=pass smtp.mailfrom=valohai.com; dkim=pass (1024-bit key) header.d=valohai.com header.i=@valohai.com header.b=Pgn2FaEr; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valohai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valohai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valohai.com header.i=@valohai.com header.b="Pgn2FaEr"
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e39885e1925so113269276.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=valohai.com; s=google; t=1733401344; x=1734006144; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1uozTr5ZhSkYGhvvGGt6vAqWCt9KFMZvk/XMT461V08=;
        b=Pgn2FaEroANoYg2npMxiMoJTxN3zglFyaFmANy4GCmnw/H7kgMzicEjpxRHQCw+K9m
         bW0RctRddI91wFhCb6xUga/TI8rHURMivGLv9LnWuGrk/yOvLOSYUa5Anhpocu7zK2nE
         l8d1aXjsziiuOGuPrGDcT9aqfFdTXpeP/xYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733401344; x=1734006144;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uozTr5ZhSkYGhvvGGt6vAqWCt9KFMZvk/XMT461V08=;
        b=gBxk989eTTCWoiF+0Asll9B2cJtmHgDcMPNwWEXy/8dsgQl2AqU2nswpcbtAiDCir9
         LOxkuNgfl7Fv69AfFf7cOC7RvGHv7+6mpcd4iym67MxcQCa8F+9surPGHCzK+uSjj2wd
         Cit9Ega7QlXEnIYrxIIPx9sOKLv9X0FWxEz1Vb7mBv6g1bivbUPlKWicjejD5qROup/S
         pjd4LEPAx9eCg3gSaUjzDzQE8UZFGW+jFI+ZYX6s53XMd1NDT11XVsQpo+KXsQiZYDTw
         68LoniLnQBZNbIFjOYm5qdDP+59QNjQ8XrpWYgp3DaWvlj40t/TnezM/z11/Xrwdpc4c
         vTPw==
X-Gm-Message-State: AOJu0Yx0VMpBZ7pR4Kt8OIUDKnR32w9KesoAUMsA8MAKXvXpLRZKJ8Zv
	smc5Az6bEpE5Hxf//ns+cRPmrlJJUXMmj2xMKdhH0v88Zzr6saOBqVyaJdhd33QCQwabw5hZI45
	B4JCBzoARJBe2wnEJARlhbdL4cvfKctD8opNP6ZqjrWPt99pjb/nk7aSg
X-Gm-Gg: ASbGncv3d/GrL2eFGn57fOv2Z/T3pBdrg3HL2soDoe76/JHn0/A7kF3P14/mbd0EKgb
	N7nmUfcQ+4ntzVUD/NE3JYuaXs7Vz4Q==
X-Google-Smtp-Source: AGHT+IF4kzYhV+uudW+dZFVdQc7qoMtXJsIT3Q7fDbmDzRNiPASW1DFzmV8R2V+kIu0c1gmi4m3uPTJ8ct3y9AU1MKw=
X-Received: by 2002:a05:6902:250d:b0:e38:2041:e9c4 with SMTP id
 3f1490d57ef6-e39d4ada8c0mr3975101276.4.1733401344435; Thu, 05 Dec 2024
 04:22:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aarni Koskela <aarni@valohai.com>
Date: Thu, 5 Dec 2024 14:22:13 +0200
Message-ID: <CAKOEJdcPYn3O01p29rVa+xv=Qr504FQyKJeSB-Moze04ViCGGg@mail.gmail.com>
Subject: Regression in :/ commit selection between 2.43.0 and 2.47.1
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The behavior of the `:/` notation to select commits seems to have
changed to no longer
prioritize younger commits on the current `HEAD`. Instead, if an older
commit is reachable
from a named ref (e.g. a tag), it will be selected instead of the
younger commit.

See below for a reproduction:

* Initialize a repository
* Create a commit with message "mystery commit 1"
* Tag the commit with `git tag -a a-tag -m a-tag`
* Create another commit with message "mystery commit 2" (which should
be found from HEAD with `:/mystery`)
* Show the commit with `git show :/mystery` =E2=80=93 it shows the older co=
mmit!
* Delete the tag with `git tag -d a-tag`
* Show the commit with `git show :/mystery` =E2=80=93 it now shows the newe=
r commit.

```
$ git init
$ git commit -m "mystery commit 1" -m "this is old" --allow-empty
[master (root-commit) 2613e98] mystery commit 1
$ git tag -a a-tag -m a-tag
$ git commit -m "mystery commit 2" -m "this is newer" --allow-empty
[master 705a642] mystery commit 2
$ git show :/mystery --oneline
2613e98 mystery commit 1
```

If one deletes the tag, the younger commit is prioritized.

```
$ git tag -d a-tag
Deleted tag 'a-tag' (was 652eb72)
$ git show :/mystery --oneline
705a642 (HEAD -> master) mystery commit 2
```

https://git-scm.com/docs/gitrevisions documents `:/` to find
"the youngest matching commit which is reachable from any ref, including HE=
AD",
which is how has worked before.

This seems to have regressed somewhere between Git 2.43.0 and 2.47.1.
Accessing the same repository with 2.43.0 (in a Docker container) shows
the expected behavior:

```
root@db58673dabff:/w# git version
git version 2.43.0
root@db58673dabff:/w# git log --oneline
705a642 (HEAD -> master) mystery commit 2
2613e98 (tag: a-tag) mystery commit 1
root@db58673dabff:/w# git show :/mystery --oneline
705a642 (HEAD -> master) mystery commit 2
```

I can also verify the same buggy behavior with 2.47.1 in an Arch Linux
environment, so it's not specific to a macOS Homebrew build:

```
sh-5.2# git version
git version 2.47.1
sh-5.2# git log --oneline
705a642 (HEAD -> master) mystery commit 2
2613e98 (tag: a-tag) mystery commit 1
sh-5.2# git show :/mystery --oneline
2613e98 (tag: a-tag) mystery commit 1
```

(This can also be reproduced with a fresh repository created within
that Arch Linux box with 2.47.1, so it's not e.g. a quirk of a given
repository.)

This breaks my usual `git commit --fixup :/something` workflow, as a
`something` commit I know I've committed just recently is no longer selecte=
d
as the fixup target :-)

Best regards,

Aarni Koskela

[System Info]
git version: git version 2.47.1 (from Homebrew)
cpu: arm64
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.6.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Thu Sep 12 23:36:12
PDT 2024; root:xnu-10063.141.1.701.1~1/RELEASE_ARM64_T6020 arm64
compiler info: clang: 16.0.0 (clang-1600.0.26.4)
