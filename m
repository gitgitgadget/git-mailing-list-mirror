Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21061925A2
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729925; cv=none; b=kHVPM1Ae0ACGadt3Y8W37DT+E0x3ccVOVVNx/ixXPu0IgC83gQTgS7h0k+AaOHRNGGNr9GQ6jnUndrsKqUWBtfzfAACX2sucdU6n1t14UFrEPTtDi898RX+n2Uhza58x4sNP0/0VhP12HrvnXjU7L92Bm/vKM0Mec3p54aHSSFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729925; c=relaxed/simple;
	bh=rO0zXRWW4UqEkM4ws9mF0sj00n5rV++g7tfdfgSJWOA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=YaHFOMSPC4vZRPNvSDkevBIakWYLQvWucbZ9kwvpqsq+8uMRChB7Gi4uhjzIYnc65kMo1VH6UTOWNI5hFl0VhG73Ac2KFnutIi1Br4mNjjxhdZbkNnqk0Ia+OE5QgWCXGVEXKCYpYjgXvE7giA22e3qp3zNMaOitZxSAFdJkqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0/PHyix; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0/PHyix"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ddd138e0d0so43540857b3.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2024 13:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729922; x=1728334722; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prLijeeZkfx8gCw+DLQD2Pph1ioIOEbybpD4YPSNX2A=;
        b=S0/PHyixxwN2caRD5vI1Knvbt3tpGDcoDg0oGA6OjhbQj/T+oW9Wob8yQZaIxtXcQj
         knEPet9dFEB4lN611NE6kd1tNV3C95uXY7VHUDmnhXocr+R/2Yo9yDOVMUS9BTJsAMCz
         5Nn4KA/Tu3Am+b+1mkYxAggbYUtf7qz0NErGCnm1p8vY9XXO6Kc8K+b9ylfglz4jgbcL
         LQ6t19GXYFaosEm/bSHmF/HKYAtUTQV4KkdydmGs+G/pv1QI+dlOB/YLI47NrFCmoUSD
         kZ90uFltL2EP2VqkZUShOWxuMS/TedpL6NMt36xSPJucg4KkyIzy9v9OO36WF+fsIZXA
         +PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729922; x=1728334722;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prLijeeZkfx8gCw+DLQD2Pph1ioIOEbybpD4YPSNX2A=;
        b=N/X5oIfYjIW9tgex4q+Hx2dXDLRLduTyr6+jP6n5e+09b5fi0+P9w7m6xEzpLHOgFt
         iO82G8FF60IFWvzj8u+NRO9aFWaODJ3SLyHo04Ytxnw1ieZUN3Z1IVumJWNSk8noJ/k9
         8oHtEuzfWro1f1ulIawfCzHGYbi5pj2RaEUW8VpSC3E2bPi6A2153UsI2xKNO/wDkSCE
         Woa1rHCtDicmMafWTtu971N3cZdDYGH2kC3/kn4DgP2moocxlCbL2ixRTcI55Gqr+On6
         G+v5j9rW0K/sTFzy54L3DDEOo3kwh9undWLZ+yxDkZZJ7dxogJcdJMpvMe5Xn94ZpPee
         sJJw==
X-Gm-Message-State: AOJu0YzcrRJWIdUIyVOPc5Bo8qzlscTr4VulsbJ/poZ+uwQxq69H7Z2M
	LF+cj98lQKd7yRCS3VBgSycH/F2rwnnvRSzacXup5kPuTlcKuGq4tbVdubkIv/62YNmWgjl+xmQ
	u1KSvIRttlJm1iWUFd0Q1t27GFWZKnw8f
X-Google-Smtp-Source: AGHT+IHjwKgZHyiL02U8jnvPbzNWdzHsr27+FHo9IaMeTFKHEHsgK+KcazjcXNcnK/9TrQgENQbbo5qYUtRQxzW8W/s=
X-Received: by 2002:a05:690c:ec9:b0:6dd:cdd7:ce49 with SMTP id
 00721157ae682-6e247500cabmr118700247b3.6.1727729922471; Mon, 30 Sep 2024
 13:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bennet Huber <bennet.huber@gmail.com>
Date: Mon, 30 Sep 2024 13:58:16 -0700
Message-ID: <CAJ7FMP0RqfUc0TKxJWn+tGq6tRhhABmbpd+xJMc7SRL6F5=JgA@mail.gmail.com>
Subject: git commit hangs when run concurrently on macos
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

Ran several "git commit" commands in parallel on separate repos.
Here's a simple test that does that.

```bash
dir-foreach-parallel () {
    subdirs=("${(@f)$(find ./ -maxdepth 1 -mindepth 1 -type d)}")
    for d in $subdirs
    do
        echo "$d"
        pushd "$d" >/dev/null
        $@ &
        popd >/dev/null
    done
}

mkdir -p /tmp/gitTest
cd /tmp/gitTest
for ((i=0;i<100;i++)) do mkdir git_$i; done

runTest() {
    git init
    USE_FS_MONITOR=true
    echo -e "[user]\n\tname = Gopher\n\temail =
gopher@example.com\n[core]\n\tfsmonitor = $USE_FS_MONITOR\n"
>.git/config
    GIT_TRACE=1 git commit --allow-empty -m `pwd` &>gitci.log
}

dir-foreach-parallel runTest
```

After running this, wait for output to subside, then run `jobs`.
On my machine, I usually see 5-10 hung "git commit" jobs.
Running `ps -efww | grep "git commit"` will show the repos they belong
to, which you can then use to
examine the corresponding gitci.log files.  The last line of all the
files I examined for hung "git
commit" commands is:

> 3:39:04.020533 run-command.c:758       trace: start_command: /opt/homebrew/opt/git/libexec/git-core/git fsmonitor--daemon run --detach --ipc-threads=8

Setting `USE_FS_MONITOR=false` in the code above consistently results
in no hung "git commit" commands, which leads me to suspect the
problem has to do with the fsmonitor feature.  It's also a decent,
though difficult to discover, workaround.


What did you expect to happen? (Expected behavior)
Concurrent git commands in separate repos shouldn't interfere with each other.

What happened instead? (Actual behavior)
Several "git commit" commands hung and failed to complete due to
fsmonitor not starting.

What's different between what you expected and what actually happened?
Success

Anything else you want to add:
* I tried to repro this on a linux box and failed. It seems to have
something to do with the macos
fsmonitor implementation.
  * `uname -a` of linux box that succeeds: Linux <hostname>
6.8.0-1016-aws #17-Ubuntu SMP Mon Sep  2 13:48:07 UTC 2024 x86_64
x86_64 x86_64 GNU/Linux
* I'm running an ARM Apple M3 Pro chip, so maybe ARM specific?
* The only mac I have access to is a corporate one, which has a ton of
security monitoring software running on it in the background.  It's
conceivable this could be interfering with fsmonitor somehow.  I
unfortunately can't test this on a clean mac.
* This use case may seem contrived, but I actually lost a lot of time
because of it.  I was trying
  to run some unit tests in parallel which involved running "git
commit" commands.  It took me
a long time to figure out why they were randomly hanging.  In
addition, I've previously used the `dir-foreach-parallel git
commit...` pattern for actual development, when working on software
which requires changes across several dependent git repos.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.2
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.4.0
zlib: 1.2.12
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Mon Jul 29 21:14:30
PDT 2024; root:xnu-10063.141.2~1/RELEASE_ARM64_T6030 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show
