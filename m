Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604015667D
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638933; cv=none; b=knU3nAO9OPNZQUn+EvYcsA8ax/cHf+VWGQKYfgEslq46G4lfp0M+oN2in9Duv7Kaawl73I2NkNf1x0CSPyv6XiTB8M6qgkNmvOYf4zUD65kTxmT7MjQffbJEWvkzoUqfBm420+HsoGVpbJo7Idvr5Fr41PgwaTDKshfcSmX2lTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638933; c=relaxed/simple;
	bh=a5oqxiAdP1C4ZsUPHhUf9d5Kj7/8t4yqcNx9Rkry5JI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Wo3NX3S7/uQtsgIcsIZeVzfX650AHT1lDOafw72CwHrx+vmepRC5PQakiWOT/czIKrcCbJlKm6wYXYP4VAWHSqKzYIgCFkc8lusLPgD0SBt0wiu4tRlbaNL8zsEMPtZJMrzZpEIBIrizcdxIOz46os1qp7fY1zQwjfxsvzwfqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lostinrecursion.net; spf=pass smtp.mailfrom=lostinrecursion.net; dkim=pass (2048-bit key) header.d=lostinrecursion.net header.i=@lostinrecursion.net header.b=AqiyYyUa; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lostinrecursion.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lostinrecursion.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lostinrecursion.net header.i=@lostinrecursion.net header.b="AqiyYyUa"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65366485678so915072eaf.2
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lostinrecursion.net; s=google; t=1762638931; x=1763243731; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vrKkf2g/uN1VvG5Txtc/If5uk+yf7AgtxtWPfYh+4no=;
        b=AqiyYyUaT7CTlgojIOH6YxPdtrxQDITkVaJXaahrz9b02/We+T9e13OCcTsPfGe1AZ
         umEgeBH6hspw17C5j1M9RdzgIVBRTyT5SGLARGYs0ITlzZUyvsJPej91C3SAmqX/neas
         Zxw1JV+ANvpvnl4+rd+DQSaHvnOIL/MelyVWujabVYJ8stpiBsyCqGt8ZTHeJ35Leupe
         QEyYQrnk6id8nCXa1SgYkPGCW/qzwZ4ntT7git/RUe49uIXjyknFxaLGktogfyXhA6RA
         0/d59giagYrLt5rY46L/JTv/Y+qA9KNEBlMbLV8S0NC8X3zYpSY6Ai3lXElKtPayfQUl
         my7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638931; x=1763243731;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrKkf2g/uN1VvG5Txtc/If5uk+yf7AgtxtWPfYh+4no=;
        b=N8HRCADecBhyyRB26+X+qjcRr+9ARMp0PdS17g/LVax83im57ZEewTEDaBrRmvp+Ot
         R+AoV1ts0MUBmCDd9NynAVfdTLVtAgvgDhzpXr3gJ2pS1kDR3K3egyO9UeOfGaU2a3jk
         tdlx93D3l+XVyzgUMf95q/5K7MOrbCjP54CXLWP4G+ghR2LSWYGs+G230LFo1ZxF4ewz
         38KyHc3OccxSwnZjQM/ISa8f3zfPtOXegNTkHwEyEQyNKD57YF32yufiCurjL9Y/4gdu
         cZKFfFGUrn+Pmipz7/JBJHh9v8cHF644WnWk/R7puD4Mpf2Sfu04MDUQ05Ips8NgQxI4
         hZhQ==
X-Gm-Message-State: AOJu0YwNq7XYOJu5EVSZBgVzm0AKb9XY6VDVfw5Gwg0rsVaGP2sJLr7U
	G7zD3Q5cENOSXEG3XZ0SZxxRekDlYwa0eWpQ1nUVSnRpL+Zs5yA9m3AYvYexFsl6cCab6nvScoC
	9Hhzw4Rs/FYETTleeX+kTYYNqvlKgT0zBEFjsmUWoa2F9qZVMfIUbd/H2Iw==
X-Gm-Gg: ASbGncsLGAJ+NtCrNbqYTr6gG40sNIRg4a8Y1uD46AbQDYZD357ujPGTi6qzg5axEFE
	94Io6FRy6J2iOYPO45tFYpMv2c6GwhG97R51YI+UdpajjkYqA7Fbp2V/ek/CLl0WwA1QKaeZyKx
	vypXlHzyaE7jMCur61J1q1JFWp3P14WVrBjsEl8xKEvkvQ74ST//vOR1JB2rpF/TOL3LFzY1Fa/
	pljyCeOgUoglxwwFyJs8EJ3xg+rVsiNaF1FyoZ/+aIqMhYIfdUo9AAnw0de21Y21VydPLGEDUtc
	5lYtLQa+4F45pLk5FTu++IonmrHi
X-Google-Smtp-Source: AGHT+IEl+kCVMA0FGsDxJlIl04g3swqzM0YruA8s05nn/zVSnod83NTwhZ2vFnQHZdOHrVGGwTlVsS+OGl+hv/NATME=
X-Received: by 2002:a05:6870:8197:b0:343:13e4:9d3 with SMTP id
 586e51a60fabf-3e7c2879544mr2004368fac.49.1762638930835; Sat, 08 Nov 2025
 13:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jono Spiro <jono@lostinrecursion.net>
Date: Sat, 8 Nov 2025 13:55:20 -0800
X-Gm-Features: AWmQ_bkk2KEjz_Cl754kykBqYTxCy8wOCqnlLypBcG73L0gdTm0Boz3KlortTzA
Message-ID: <CAMqCmsYb409G0CuL+4xZit4V4wqOzD8DtNBe9hmRquBm0Xuevg@mail.gmail.com>
Subject: Git fsmonitor daemon processes spawn detached on macOS 26 Tahoe and
 never terminate
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Enabled git fsmonitor: git config --global core.fsmonitor true
2. Used git applications (Xcode, VS Code, GitX, terminal with Starship)
3. Performed normal git operations (open repository, stage files,
navigate directories)
4. Quit applications

What did you expect to happen? (Expected behavior)

fsmonitor--daemon processes should terminate when no longer needed, or
at minimum when
parent applications quit. Expected one daemon per active repository or
so. I am seeing dozens and some users of gitx (which I am a maintainer
on) are seeing thousands of orphaned git processes pile up after
upgrading to Tahoe.

What happened instead? (Actual behavior)

fsmonitor--daemon processes spawn detached (not as children of parent
application) and
never terminate. They accumulate indefinitely (dozens to hundreds over
time). All show:
  git fsmonitor--daemon run --detach --ipc-threads=8

Processes must be manually killed: pkill -f fsmonitor-daemon

What's different between what you expected and what actually happened?

Daemons are spawning detached with no parent-child relationship. They
never receive
termination signals when parent applications quit, causing accumulation and git
index.lock files to remain locked, blocking further git operations.

Anything else you want to add:

- Only occurs on macOS 26.0+ (Tahoe) - not present on earlier macOS versions
- Affects ALL git builds: /usr/bin/git, Homebrew 2.51.2, Xcode Command
Line Tools
- Affects ALL git applications: Xcode, VS Code, GitX, Starship, any git client
- Side effects: system resource exhaustion, locked repositories
- Workaround: git config --global core.fsmonitor false
- Related issue: https://github.com/gitx/gitx/issues/485
- Apple Feedback: FB20956467

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.51.2
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Darwin 25.2.0 Darwin Kernel Version 25.2.0: Sat Nov  1 18:04:14
PDT 2025; root:xnu-12377.60.50.0.2~95/RELEASE_ARM64_T6000 arm64
compiler info: clang: 17.0.0 (clang-1700.3.19.1)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
