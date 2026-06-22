Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBC2367B6F
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 10:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124718; cv=none; b=c2DVvliuIzJ0R8ZcwtXB4L/LxrNxJfCOMTnFP+Sk0nwOzuqfWpwYRsEe70y5pcdoG9O+4x+dUUNSoVv6dilRq57D4rPtAw0hpOtTSClFCpwU+5PqxMO2QUIrprnroOnNheLCpa5P+A0HyzIQY+gTWCUdwNbB0l5pMHfNGP8LuZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124718; c=relaxed/simple;
	bh=tTuJEWr1jmHKe39MhSkvyArUIrs5aO6RlDwVbYo/aoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=H26O9KW2V2mUdnKOjnPDy6jB+ryMRjgJ3rFqXEfEeZjh1RsEam4NEerkQjtqjUU2o3yuvCxK3JGtK6NrSVHOIXvcLzYbkukXNuvvxyW7OoU1XyckwjUtEee8gl5vBuYHYL6zGF9XGTeRII5A8HcQP9fCFLkx8D4f2vnTwqmr1VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tlwk/kRs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Aj0gcsIF; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tlwk/kRs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Aj0gcsIF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B8ACC7A017C;
	Mon, 22 Jun 2026 06:38:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 06:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782124714;
	 x=1782211114; bh=e9S8Jzo0Lf0ZUUmpIbpPPcFHTOtKp6GiCF/V9TJKMPQ=; b=
	Tlwk/kRs2cSfovYd2jzM1TJ/TMoMkMED6l4qOKL3ixLlcKcvtOqKvUOrtWXk0KjM
	yxj//1ghnHU7Hvjj7zs4U5fKQs4BEysOJVSpyTYZGD6V3GQKZOnW24/T4YdG+tFn
	9AEBsPnfxN0J0zauvyEblnuxMxXaExYvKgika6oOUWhs3VE9ZjNgmsmkvmjwuuyo
	qam4VHZ832BYEdaNRCi3U0kF3UbfM4rMjEzXBbdft9sPuSTM4kwjTU3wyk0kAx/s
	R9i0sdniaDhyYyJDLxSRD86iwkl8x83sF3YSkk2KX2jWlq913d1FPpbBQHnxEDeh
	/6pAjAkHweN7ZCv5Cksoew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782124714; x=
	1782211114; bh=e9S8Jzo0Lf0ZUUmpIbpPPcFHTOtKp6GiCF/V9TJKMPQ=; b=A
	j0gcsIFbOcmIV1AfNwFSqJbEyZEMp1y4Oq4zJCktvRD3LmTvOa7qze5twpn9RxeB
	yYH5Im2L4AqwKHXCZDiR3OrzM+jBPeI/2sFC4u9dJoorZ4HW1uiYO2h2AETQyCu0
	IVc2tJTmEt5HqQ5EwAcI1+Ia6HcvafbRcST09n2x5ssWhlKU5Z7JU+++LeB0tsRZ
	ax05T7mWw6hLVBlTToBfsvDf2K+o7Fea/JRv0fUhNWoIF4Oohi56QFScjDuA1cAj
	4sx4iMEPeSh3ENbu/R3DBkgKxXOhRgQx9wgUSLSTepPV6qbDRNXWxRrpBkrRf8Xi
	pS205EzUu87Po2T+7oZnw==
X-ME-Sender: <xms:qRA5aoSXIvUrFCc21S8HbzpRx9-j5P_R3eC3Y42zFqfEiIyNAbnk1A>
    <xme:qRA5amjqAAAM8LKM9JvhMnpAbxqQTMURrH_5p_AaBu51hkkpuBrLUx1-ezaZ1VHGj
    muW6CWcVPNZqGtyWa4RUeLBoGy2Bvp1qAgJXAcVkZ6xKXqfyf4P4Q>
X-ME-Received: <xmr:qRA5ah9dDap1eZcHUjwjDszm8cLehz0kO1fVF3RiRlAhzB0zx7VRoViLtRkJBQsxUMCRnEbGMbC1jNYrrIEnCCRyPFSeU0gZcs2aFjAv_Q>
X-ME-Proxy-Cause: dmFkZTEJANxODayPgF36/nws8ArLoijuWquQhQE10lDP0Yf+t7SjvyoSqlDb1+ZhF4+V7F
    OQgpSsIoJPW9JWBlb91OlhIz+doKj7fhxq6F6wKka2m1GVu4HbjNcOkcNuike6WOu3L9D7
    ig9wMyIvSjV00n784ojW+gln5dfConuFPvhAY5bDvQptyUHN/G0uAApBrokzKDCjcgSA85
    8wXsRXQus/KpFOGtswYLgectlV6oK56q/9u0VhiYEToi5c+l6BZD8FJUPYVyc1ptQoa0mV
    /lGV1Wwypph9bc1/36WZ48w31csFzxItlhcz/c9WklhU3qVWammQmGxb7pBIgJC+valGqm
    f2T6xpbhH3FvFVj/lT6C4q3RKqLPtsEHjwFW17v07Mnau1HqWQCjvZdG4csYB2lZGEoiK6
    /Tu9AFFoh13bnnj+H9mt5P9/G3JyyAIDKB3LiWPJXLwNNgpEMftSt0dzyBBrPCEN3GUTnt
    1sYDYX+mha6cb/X1UcxD4Hhx1keHg9chWmRWFeHwOedjwWrdQpfsJIMTOVjA3HYz/Bf1z7
    EwiRKs2aovLpioCBXlVlz/Jy+vcX2ToXQn07Xx3CdFOqtrV++FbSenhlcTdvLWzQGJRoDp
    laYPgMlzp7VkSEHBMgw89MU6KuwTxvk6dCbKgYR6upq2IUf15Tye6x7FlcQg
X-ME-Proxy: <xmx:qRA5atH29jEyBpCJtjLEUuZQWb3bOvdYeK1JHqhYcB9JNDyfeblBpQ>
    <xmx:qRA5aknhYO0-SKD8Zb1p_uR0PkVNPAAumnWGrmjmkQeKpxHsML1fCw>
    <xmx:qRA5ahZeNwW9rIA-d-KeBbfsPCLyqbt7ZkoDdeuOMy7pdf3JI-Z5Og>
    <xmx:qRA5apFBElb23Wo1iXLtbYFzo0FCG0wfM0JuO014C7AQdm-lqKA2mQ>
    <xmx:qhA5atW-qBGEDtturv_zmFtb5MW0t8u38YmYxDJe5gYKEdtciDwRTtpn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 06:38:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42566dea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 10:38:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v2 0/2] Move libgit.a sources into separate "lib/"
 directory
Date: Mon, 22 Jun 2026 12:38:20 +0200
Message-Id: <20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ0QOWoC/22NzQ6CMBCEX4Xs2TUtf6InExMfwKvhAO0CiwqkR
 aIhvLulevQ4k2/mm8GSYbJwCGYwNLHlvnMh3ASgmqKrCVm7DKEIUxHLBIebxTuXNY/IHdpnqdm
 gzohUFu+VjjNw08FQxS9/e4XL+QT5t3R4S2pcD1esYTv25u3lk/Twz5P+90wSBYqoqNQukrpKk
 qPDtvyAfFmWD1rFWjzMAAAA
X-Change-ID: 20260415-pks-libgit-in-subdir-d8eec849cd48
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

Hi,

this small patch series follows up on a discussion we had two years ago
during the Git Contributor's Summit in Berlin.

I'm fully aware that this will likely result in some discussion, which
is why I have labelled this as RFC. I'd be fine with a result of "let's
not do it" if we cannot agree on this step, but I think that the current
layout hurts discoverability quite a bit. Not only for newcomers, but
I'm also struggling with it quite frequently.

I also intentionally decided to send this close to the upcoming release
so that the series can be merged early in the next release cycle if we
were to agree on it.

I've tested this patch series with both GitLab [1] and GitHub [2].

Changes in v2:
  - Feedback on v1 was generally positive, and we're close to the next
    release again. So I've decided to rebase the patch series and send
    v2 out before the quiet pre-release phase kicks off. The series is
    thus built on top of 8d96f09e92 (Merge branch
    'js/objects-larger-than-4gb-on-windows', 2026-06-19) with
    ps/odb-source-packed at 1bba3c035d (odb/source-packed: drop pointer
    to "files" parent source, 2026-06-17) merged into it.
  - Fix a couple of instances I missed to update in Meson.
  - Link to v1: https://patch.msgid.link/20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/544
[2]: https://github.com/git/git/pull/2271

---
Patrick Steinhardt (2):
      t/helper: prepare "test-example-tap.c" for introduction of "lib/"
      Move libgit.a sources into separate "lib/" directory

 .github/workflows/main.yml                         |   8 +-
 .gitmodules                                        |   2 +-
 Documentation/Makefile                             |   4 +-
 Makefile                                           | 764 ++++++++++-----------
 config.mak.uname                                   |  52 +-
 contrib/buildsystems/CMakeLists.txt                |  95 +--
 git.rc.in                                          |   2 +-
 abspath.c => lib/abspath.c                         |   0
 abspath.h => lib/abspath.h                         |   0
 add-interactive.c => lib/add-interactive.c         |   0
 add-interactive.h => lib/add-interactive.h         |   0
 add-patch.c => lib/add-patch.c                     |   0
 add-patch.h => lib/add-patch.h                     |   0
 advice.c => lib/advice.c                           |   0
 advice.h => lib/advice.h                           |   0
 alias.c => lib/alias.c                             |   0
 alias.h => lib/alias.h                             |   0
 alloc.c => lib/alloc.c                             |   0
 alloc.h => lib/alloc.h                             |   0
 apply.c => lib/apply.c                             |   0
 apply.h => lib/apply.h                             |   0
 archive-tar.c => lib/archive-tar.c                 |   0
 archive-zip.c => lib/archive-zip.c                 |   0
 archive.c => lib/archive.c                         |   0
 archive.h => lib/archive.h                         |   0
 attr.c => lib/attr.c                               |   0
 attr.h => lib/attr.h                               |   0
 banned.h => lib/banned.h                           |   0
 base85.c => lib/base85.c                           |   0
 base85.h => lib/base85.h                           |   0
 bisect.c => lib/bisect.c                           |   0
 bisect.h => lib/bisect.h                           |   0
 blame.c => lib/blame.c                             |   0
 blame.h => lib/blame.h                             |   0
 blob.c => lib/blob.c                               |   0
 blob.h => lib/blob.h                               |   0
 {block-sha1 => lib/block-sha1}/sha1.c              |   0
 {block-sha1 => lib/block-sha1}/sha1.h              |   0
 bloom.c => lib/bloom.c                             |   0
 bloom.h => lib/bloom.h                             |   0
 branch.c => lib/branch.c                           |   0
 branch.h => lib/branch.h                           |   0
 builtin.h => lib/builtin.h                         |   0
 bundle-uri.c => lib/bundle-uri.c                   |   0
 bundle-uri.h => lib/bundle-uri.h                   |   0
 bundle.c => lib/bundle.c                           |   0
 bundle.h => lib/bundle.h                           |   0
 cache-tree.c => lib/cache-tree.c                   |   0
 cache-tree.h => lib/cache-tree.h                   |   0
 cbtree.c => lib/cbtree.c                           |   0
 cbtree.h => lib/cbtree.h                           |   0
 chdir-notify.c => lib/chdir-notify.c               |   0
 chdir-notify.h => lib/chdir-notify.h               |   0
 checkout.c => lib/checkout.c                       |   0
 checkout.h => lib/checkout.h                       |   0
 chunk-format.c => lib/chunk-format.c               |   0
 chunk-format.h => lib/chunk-format.h               |   0
 color.c => lib/color.c                             |   0
 color.h => lib/color.h                             |   0
 column.c => lib/column.c                           |   0
 column.h => lib/column.h                           |   0
 combine-diff.c => lib/combine-diff.c               |   0
 commit-graph.c => lib/commit-graph.c               |   0
 commit-graph.h => lib/commit-graph.h               |   0
 commit-reach.c => lib/commit-reach.c               |   0
 commit-reach.h => lib/commit-reach.h               |   0
 commit-slab-decl.h => lib/commit-slab-decl.h       |   0
 commit-slab-impl.h => lib/commit-slab-impl.h       |   0
 commit-slab.h => lib/commit-slab.h                 |   0
 commit.c => lib/commit.c                           |   0
 commit.h => lib/commit.h                           |   0
 common-exit.c => lib/common-exit.c                 |   0
 common-init.c => lib/common-init.c                 |   0
 common-init.h => lib/common-init.h                 |   0
 {compat => lib/compat}/.gitattributes              |   0
 {compat => lib/compat}/access.c                    |   0
 {compat => lib/compat}/apple-common-crypto.h       |   0
 {compat => lib/compat}/basename.c                  |   0
 {compat => lib/compat}/bswap.h                     |   0
 {compat => lib/compat}/compiler.h                  |   0
 {compat => lib/compat}/darwin/procinfo.c           |   0
 {compat => lib/compat}/disk.h                      |   0
 {compat => lib/compat}/fileno.c                    |   0
 {compat => lib/compat}/fopen.c                     |   0
 {compat => lib/compat}/fsmonitor/fsm-darwin-gcc.h  |   0
 .../compat}/fsmonitor/fsm-health-darwin.c          |   0
 .../compat}/fsmonitor/fsm-health-linux.c           |   0
 .../compat}/fsmonitor/fsm-health-win32.c           |   0
 {compat => lib/compat}/fsmonitor/fsm-health.h      |   0
 {compat => lib/compat}/fsmonitor/fsm-ipc-unix.c    |   0
 {compat => lib/compat}/fsmonitor/fsm-ipc-win32.c   |   0
 .../compat}/fsmonitor/fsm-listen-darwin.c          |   0
 .../compat}/fsmonitor/fsm-listen-linux.c           |   0
 .../compat}/fsmonitor/fsm-listen-win32.c           |   0
 {compat => lib/compat}/fsmonitor/fsm-listen.h      |   0
 .../compat}/fsmonitor/fsm-path-utils-darwin.c      |   0
 .../compat}/fsmonitor/fsm-path-utils-linux.c       |   0
 .../compat}/fsmonitor/fsm-path-utils-win32.c       |   0
 .../compat}/fsmonitor/fsm-settings-unix.c          |   0
 .../compat}/fsmonitor/fsm-settings-win32.c         |   0
 {compat => lib/compat}/hstrerror.c                 |   0
 {compat => lib/compat}/inet_ntop.c                 |   0
 {compat => lib/compat}/inet_pton.c                 |   0
 {compat => lib/compat}/linux/procinfo.c            |   0
 {compat => lib/compat}/memmem.c                    |   0
 {compat => lib/compat}/mingw-posix.h               |   0
 {compat => lib/compat}/mingw.c                     |   0
 {compat => lib/compat}/mingw.h                     |   0
 {compat => lib/compat}/mkdir.c                     |   0
 {compat => lib/compat}/mmap.c                      |   0
 {compat => lib/compat}/msvc-posix.h                |   0
 {compat => lib/compat}/msvc.c                      |   0
 {compat => lib/compat}/msvc.h                      |   0
 {compat => lib/compat}/nonblock.c                  |   0
 {compat => lib/compat}/nonblock.h                  |   0
 {compat => lib/compat}/obstack.c                   |   0
 {compat => lib/compat}/obstack.h                   |   0
 {compat => lib/compat}/open.c                      |   0
 {compat => lib/compat}/poll/poll.c                 |   0
 {compat => lib/compat}/poll/poll.h                 |   0
 {compat => lib/compat}/posix.h                     |   0
 {compat => lib/compat}/pread.c                     |   0
 {compat => lib/compat}/precompose_utf8.c           |   0
 {compat => lib/compat}/precompose_utf8.h           |   0
 {compat => lib/compat}/qsort_s.c                   |   0
 {compat => lib/compat}/regcomp_enhanced.c          |   0
 {compat => lib/compat}/regex/regcomp.c             |   0
 {compat => lib/compat}/regex/regex.c               |   0
 {compat => lib/compat}/regex/regex.h               |   0
 {compat => lib/compat}/regex/regex_internal.c      |   0
 {compat => lib/compat}/regex/regex_internal.h      |   0
 {compat => lib/compat}/regex/regexec.c             |   0
 {compat => lib/compat}/setenv.c                    |   0
 {compat => lib/compat}/sha1-chunked.c              |   0
 {compat => lib/compat}/sha1-chunked.h              |   0
 {compat => lib/compat}/simple-ipc/ipc-shared.c     |   0
 .../compat}/simple-ipc/ipc-unix-socket.c           |   0
 {compat => lib/compat}/simple-ipc/ipc-win32.c      |   0
 {compat => lib/compat}/snprintf.c                  |   0
 {compat => lib/compat}/stat.c                      |   0
 {compat => lib/compat}/strcasestr.c                |   0
 {compat => lib/compat}/strdup.c                    |   0
 {compat => lib/compat}/strlcpy.c                   |   0
 {compat => lib/compat}/strtoimax.c                 |   0
 {compat => lib/compat}/strtoumax.c                 |   0
 {compat => lib/compat}/stub/procinfo.c             |   0
 {compat => lib/compat}/terminal.c                  |   0
 {compat => lib/compat}/terminal.h                  |   0
 {compat => lib/compat}/unsetenv.c                  |   0
 {compat => lib/compat}/vcbuild/.gitignore          |   0
 {compat => lib/compat}/vcbuild/README              |  10 +-
 {compat => lib/compat}/vcbuild/find_vs_env.bat     |   2 +-
 {compat => lib/compat}/vcbuild/include/sys/param.h |   0
 {compat => lib/compat}/vcbuild/include/sys/time.h  |   0
 {compat => lib/compat}/vcbuild/include/sys/utime.h |   0
 {compat => lib/compat}/vcbuild/include/unistd.h    |   0
 {compat => lib/compat}/vcbuild/include/utime.h     |   0
 {compat => lib/compat}/vcbuild/scripts/clink.pl    |   0
 {compat => lib/compat}/vcbuild/scripts/lib.pl      |   0
 {compat => lib/compat}/vcbuild/vcpkg_copy_dlls.bat |   0
 {compat => lib/compat}/vcbuild/vcpkg_install.bat   |   4 +-
 {compat => lib/compat}/win32.h                     |   0
 {compat => lib/compat}/win32/alloca.h              |   0
 {compat => lib/compat}/win32/dirent.c              |   0
 {compat => lib/compat}/win32/dirent.h              |   0
 {compat => lib/compat}/win32/exit-process.h        |   0
 {compat => lib/compat}/win32/flush.c               |   0
 {compat => lib/compat}/win32/git.manifest          |   0
 {compat => lib/compat}/win32/headless.c            |   0
 {compat => lib/compat}/win32/lazyload.h            |   0
 {compat => lib/compat}/win32/path-utils.c          |   0
 {compat => lib/compat}/win32/path-utils.h          |   0
 {compat => lib/compat}/win32/pthread.c             |   0
 {compat => lib/compat}/win32/pthread.h             |   0
 {compat => lib/compat}/win32/syslog.c              |   0
 {compat => lib/compat}/win32/syslog.h              |   0
 .../compat}/win32/trace2_win32_process_info.c      |   0
 {compat => lib/compat}/win32mmap.c                 |   0
 {compat => lib/compat}/winansi.c                   |   0
 {compat => lib/compat}/zlib-compat.h               |   0
 .../compiler-tricks}/not-constant.c                |   0
 config.c => lib/config.c                           |   0
 config.h => lib/config.h                           |   0
 connect.c => lib/connect.c                         |   0
 connect.h => lib/connect.h                         |   0
 connected.c => lib/connected.c                     |   0
 connected.h => lib/connected.h                     |   0
 convert.c => lib/convert.c                         |   0
 convert.h => lib/convert.h                         |   0
 copy.c => lib/copy.c                               |   0
 copy.h => lib/copy.h                               |   0
 credential.c => lib/credential.c                   |   0
 credential.h => lib/credential.h                   |   0
 csum-file.c => lib/csum-file.c                     |   0
 csum-file.h => lib/csum-file.h                     |   0
 ctype.c => lib/ctype.c                             |   0
 date.c => lib/date.c                               |   0
 date.h => lib/date.h                               |   0
 decorate.c => lib/decorate.c                       |   0
 decorate.h => lib/decorate.h                       |   0
 delta-islands.c => lib/delta-islands.c             |   0
 delta-islands.h => lib/delta-islands.h             |   0
 delta.h => lib/delta.h                             |   0
 diagnose.c => lib/diagnose.c                       |   0
 diagnose.h => lib/diagnose.h                       |   0
 diff-delta.c => lib/diff-delta.c                   |   0
 diff-lib.c => lib/diff-lib.c                       |   0
 diff-merges.c => lib/diff-merges.c                 |   0
 diff-merges.h => lib/diff-merges.h                 |   0
 diff-no-index.c => lib/diff-no-index.c             |   0
 diff.c => lib/diff.c                               |   0
 diff.h => lib/diff.h                               |   0
 diffcore-break.c => lib/diffcore-break.c           |   0
 diffcore-delta.c => lib/diffcore-delta.c           |   0
 diffcore-order.c => lib/diffcore-order.c           |   0
 diffcore-pickaxe.c => lib/diffcore-pickaxe.c       |   0
 diffcore-rename.c => lib/diffcore-rename.c         |   0
 diffcore-rotate.c => lib/diffcore-rotate.c         |   0
 diffcore.h => lib/diffcore.h                       |   0
 dir-iterator.c => lib/dir-iterator.c               |   0
 dir-iterator.h => lib/dir-iterator.h               |   0
 dir.c => lib/dir.c                                 |   0
 dir.h => lib/dir.h                                 |   0
 editor.c => lib/editor.c                           |   0
 editor.h => lib/editor.h                           |   0
 entry.c => lib/entry.c                             |   0
 entry.h => lib/entry.h                             |   0
 environment.c => lib/environment.c                 |   0
 environment.h => lib/environment.h                 |   0
 {ewah => lib/ewah}/bitmap.c                        |   0
 {ewah => lib/ewah}/ewah_bitmap.c                   |   0
 {ewah => lib/ewah}/ewah_io.c                       |   0
 {ewah => lib/ewah}/ewah_rlw.c                      |   0
 {ewah => lib/ewah}/ewok.h                          |   0
 {ewah => lib/ewah}/ewok_rlw.h                      |   0
 exec-cmd.c => lib/exec-cmd.c                       |   0
 exec-cmd.h => lib/exec-cmd.h                       |   0
 fetch-negotiator.c => lib/fetch-negotiator.c       |   0
 fetch-negotiator.h => lib/fetch-negotiator.h       |   0
 fetch-pack.c => lib/fetch-pack.c                   |   0
 fetch-pack.h => lib/fetch-pack.h                   |   0
 fmt-merge-msg.c => lib/fmt-merge-msg.c             |   0
 fmt-merge-msg.h => lib/fmt-merge-msg.h             |   0
 for-each-ref.h => lib/for-each-ref.h               |   0
 fsck.c => lib/fsck.c                               |   0
 fsck.h => lib/fsck.h                               |   0
 fsmonitor--daemon.h => lib/fsmonitor--daemon.h     |   0
 fsmonitor-ipc.c => lib/fsmonitor-ipc.c             |   0
 fsmonitor-ipc.h => lib/fsmonitor-ipc.h             |   0
 fsmonitor-ll.h => lib/fsmonitor-ll.h               |   0
 .../fsmonitor-path-utils.h                         |   0
 fsmonitor-settings.c => lib/fsmonitor-settings.c   |   0
 fsmonitor-settings.h => lib/fsmonitor-settings.h   |   0
 fsmonitor.c => lib/fsmonitor.c                     |   0
 fsmonitor.h => lib/fsmonitor.h                     |   0
 gettext.c => lib/gettext.c                         |   0
 gettext.h => lib/gettext.h                         |   0
 git-compat-util.h => lib/git-compat-util.h         |   0
 git-curl-compat.h => lib/git-curl-compat.h         |   0
 git-zlib.c => lib/git-zlib.c                       |   0
 git-zlib.h => lib/git-zlib.h                       |   0
 gpg-interface.c => lib/gpg-interface.c             |   0
 gpg-interface.h => lib/gpg-interface.h             |   0
 graph.c => lib/graph.c                             |   0
 graph.h => lib/graph.h                             |   0
 grep.c => lib/grep.c                               |   0
 grep.h => lib/grep.h                               |   0
 hash-lookup.c => lib/hash-lookup.c                 |   0
 hash-lookup.h => lib/hash-lookup.h                 |   0
 hash.c => lib/hash.c                               |   0
 hash.h => lib/hash.h                               |   0
 hashmap.c => lib/hashmap.c                         |   0
 hashmap.h => lib/hashmap.h                         |   0
 help.c => lib/help.c                               |   0
 help.h => lib/help.h                               |   0
 hex-ll.c => lib/hex-ll.c                           |   0
 hex-ll.h => lib/hex-ll.h                           |   0
 hex.c => lib/hex.c                                 |   0
 hex.h => lib/hex.h                                 |   0
 hook.c => lib/hook.c                               |   0
 hook.h => lib/hook.h                               |   0
 http-walker.c => lib/http-walker.c                 |   0
 http.c => lib/http.c                               |   0
 http.h => lib/http.h                               |   0
 ident.c => lib/ident.c                             |   0
 ident.h => lib/ident.h                             |   0
 iterator.h => lib/iterator.h                       |   0
 json-writer.c => lib/json-writer.c                 |   0
 json-writer.h => lib/json-writer.h                 |   0
 khash.h => lib/khash.h                             |   0
 kwset.c => lib/kwset.c                             |   0
 kwset.h => lib/kwset.h                             |   0
 levenshtein.c => lib/levenshtein.c                 |   0
 levenshtein.h => lib/levenshtein.h                 |   0
 line-log.c => lib/line-log.c                       |   0
 line-log.h => lib/line-log.h                       |   0
 line-range.c => lib/line-range.c                   |   0
 line-range.h => lib/line-range.h                   |   0
 linear-assignment.c => lib/linear-assignment.c     |   0
 linear-assignment.h => lib/linear-assignment.h     |   0
 .../list-objects-filter-options.c                  |   0
 .../list-objects-filter-options.h                  |   0
 list-objects-filter.c => lib/list-objects-filter.c |   0
 list-objects-filter.h => lib/list-objects-filter.h |   0
 list-objects.c => lib/list-objects.c               |   0
 list-objects.h => lib/list-objects.h               |   0
 list.h => lib/list.h                               |   0
 lockfile.c => lib/lockfile.c                       |   0
 lockfile.h => lib/lockfile.h                       |   0
 log-tree.c => lib/log-tree.c                       |   0
 log-tree.h => lib/log-tree.h                       |   0
 loose.c => lib/loose.c                             |   0
 loose.h => lib/loose.h                             |   0
 ls-refs.c => lib/ls-refs.c                         |   0
 ls-refs.h => lib/ls-refs.h                         |   0
 mailinfo.c => lib/mailinfo.c                       |   0
 mailinfo.h => lib/mailinfo.h                       |   0
 mailmap.c => lib/mailmap.c                         |   0
 mailmap.h => lib/mailmap.h                         |   0
 match-trees.c => lib/match-trees.c                 |   0
 match-trees.h => lib/match-trees.h                 |   0
 mem-pool.c => lib/mem-pool.c                       |   0
 mem-pool.h => lib/mem-pool.h                       |   0
 merge-blobs.c => lib/merge-blobs.c                 |   0
 merge-blobs.h => lib/merge-blobs.h                 |   0
 merge-ll.c => lib/merge-ll.c                       |   0
 merge-ll.h => lib/merge-ll.h                       |   0
 merge-ort-wrappers.c => lib/merge-ort-wrappers.c   |   0
 merge-ort-wrappers.h => lib/merge-ort-wrappers.h   |   0
 merge-ort.c => lib/merge-ort.c                     |   0
 merge-ort.h => lib/merge-ort.h                     |   0
 merge.c => lib/merge.c                             |   0
 merge.h => lib/merge.h                             |   0
 mergesort.h => lib/mergesort.h                     |   0
 midx-write.c => lib/midx-write.c                   |   0
 midx.c => lib/midx.c                               |   0
 midx.h => lib/midx.h                               |   0
 name-hash.c => lib/name-hash.c                     |   0
 name-hash.h => lib/name-hash.h                     |   0
 {negotiator => lib/negotiator}/default.c           |   0
 {negotiator => lib/negotiator}/default.h           |   0
 {negotiator => lib/negotiator}/noop.c              |   0
 {negotiator => lib/negotiator}/noop.h              |   0
 {negotiator => lib/negotiator}/skipping.c          |   0
 {negotiator => lib/negotiator}/skipping.h          |   0
 notes-cache.c => lib/notes-cache.c                 |   0
 notes-cache.h => lib/notes-cache.h                 |   0
 notes-merge.c => lib/notes-merge.c                 |   0
 notes-merge.h => lib/notes-merge.h                 |   0
 notes-utils.c => lib/notes-utils.c                 |   0
 notes-utils.h => lib/notes-utils.h                 |   0
 notes.c => lib/notes.c                             |   0
 notes.h => lib/notes.h                             |   0
 object-file-convert.c => lib/object-file-convert.c |   0
 object-file-convert.h => lib/object-file-convert.h |   0
 object-file.c => lib/object-file.c                 |   0
 object-file.h => lib/object-file.h                 |   0
 object-name.c => lib/object-name.c                 |   0
 object-name.h => lib/object-name.h                 |   0
 object.c => lib/object.c                           |   0
 object.h => lib/object.h                           |   0
 odb.c => lib/odb.c                                 |   0
 odb.h => lib/odb.h                                 |   0
 {odb => lib/odb}/source-files.c                    |   0
 {odb => lib/odb}/source-files.h                    |   0
 {odb => lib/odb}/source-inmemory.c                 |   0
 {odb => lib/odb}/source-inmemory.h                 |   0
 {odb => lib/odb}/source-loose.c                    |   0
 {odb => lib/odb}/source-loose.h                    |   0
 {odb => lib/odb}/source-packed.c                   |   0
 {odb => lib/odb}/source-packed.h                   |   0
 {odb => lib/odb}/source.c                          |   0
 {odb => lib/odb}/source.h                          |   0
 {odb => lib/odb}/streaming.c                       |   0
 {odb => lib/odb}/streaming.h                       |   0
 {odb => lib/odb}/transaction.c                     |   0
 {odb => lib/odb}/transaction.h                     |   0
 oid-array.c => lib/oid-array.c                     |   0
 oid-array.h => lib/oid-array.h                     |   0
 oidmap.c => lib/oidmap.c                           |   0
 oidmap.h => lib/oidmap.h                           |   0
 oidset.c => lib/oidset.c                           |   0
 oidset.h => lib/oidset.h                           |   0
 oidtree.c => lib/oidtree.c                         |   0
 oidtree.h => lib/oidtree.h                         |   0
 pack-bitmap-write.c => lib/pack-bitmap-write.c     |   0
 pack-bitmap.c => lib/pack-bitmap.c                 |   0
 pack-bitmap.h => lib/pack-bitmap.h                 |   0
 pack-check.c => lib/pack-check.c                   |   0
 pack-mtimes.c => lib/pack-mtimes.c                 |   0
 pack-mtimes.h => lib/pack-mtimes.h                 |   0
 pack-objects.c => lib/pack-objects.c               |   0
 pack-objects.h => lib/pack-objects.h               |   0
 pack-refs.c => lib/pack-refs.c                     |   0
 pack-refs.h => lib/pack-refs.h                     |   0
 pack-revindex.c => lib/pack-revindex.c             |   0
 pack-revindex.h => lib/pack-revindex.h             |   0
 pack-write.c => lib/pack-write.c                   |   0
 pack.h => lib/pack.h                               |   0
 packfile-list.c => lib/packfile-list.c             |   0
 packfile-list.h => lib/packfile-list.h             |   0
 packfile.c => lib/packfile.c                       |   0
 packfile.h => lib/packfile.h                       |   0
 pager.c => lib/pager.c                             |   0
 pager.h => lib/pager.h                             |   0
 parallel-checkout.c => lib/parallel-checkout.c     |   0
 parallel-checkout.h => lib/parallel-checkout.h     |   0
 parse-options-cb.c => lib/parse-options-cb.c       |   0
 parse-options.c => lib/parse-options.c             |   0
 parse-options.h => lib/parse-options.h             |   0
 parse.c => lib/parse.c                             |   0
 parse.h => lib/parse.h                             |   0
 patch-delta.c => lib/patch-delta.c                 |   0
 patch-ids.c => lib/patch-ids.c                     |   0
 patch-ids.h => lib/patch-ids.h                     |   0
 path-walk.c => lib/path-walk.c                     |   0
 path-walk.h => lib/path-walk.h                     |   0
 path.c => lib/path.c                               |   0
 path.h => lib/path.h                               |   0
 pathspec.c => lib/pathspec.c                       |   0
 pathspec.h => lib/pathspec.h                       |   0
 pkt-line.c => lib/pkt-line.c                       |   0
 pkt-line.h => lib/pkt-line.h                       |   0
 preload-index.c => lib/preload-index.c             |   0
 preload-index.h => lib/preload-index.h             |   0
 pretty.c => lib/pretty.c                           |   0
 pretty.h => lib/pretty.h                           |   0
 prio-queue.c => lib/prio-queue.c                   |   0
 prio-queue.h => lib/prio-queue.h                   |   0
 progress.c => lib/progress.c                       |   0
 progress.h => lib/progress.h                       |   0
 promisor-remote.c => lib/promisor-remote.c         |   0
 promisor-remote.h => lib/promisor-remote.h         |   0
 prompt.c => lib/prompt.c                           |   0
 prompt.h => lib/prompt.h                           |   0
 protocol-caps.c => lib/protocol-caps.c             |   0
 protocol-caps.h => lib/protocol-caps.h             |   0
 protocol.c => lib/protocol.c                       |   0
 protocol.h => lib/protocol.h                       |   0
 prune-packed.c => lib/prune-packed.c               |   0
 prune-packed.h => lib/prune-packed.h               |   0
 pseudo-merge.c => lib/pseudo-merge.c               |   0
 pseudo-merge.h => lib/pseudo-merge.h               |   0
 quote.c => lib/quote.c                             |   0
 quote.h => lib/quote.h                             |   0
 range-diff.c => lib/range-diff.c                   |   0
 range-diff.h => lib/range-diff.h                   |   0
 reachable.c => lib/reachable.c                     |   0
 reachable.h => lib/reachable.h                     |   0
 read-cache-ll.h => lib/read-cache-ll.h             |   0
 read-cache.c => lib/read-cache.c                   |   0
 read-cache.h => lib/read-cache.h                   |   0
 rebase-interactive.c => lib/rebase-interactive.c   |   0
 rebase-interactive.h => lib/rebase-interactive.h   |   0
 rebase.c => lib/rebase.c                           |   0
 rebase.h => lib/rebase.h                           |   0
 ref-filter.c => lib/ref-filter.c                   |   0
 ref-filter.h => lib/ref-filter.h                   |   0
 reflog-walk.c => lib/reflog-walk.c                 |   0
 reflog-walk.h => lib/reflog-walk.h                 |   0
 reflog.c => lib/reflog.c                           |   0
 reflog.h => lib/reflog.h                           |   0
 refs.c => lib/refs.c                               |   0
 refs.h => lib/refs.h                               |   0
 {refs => lib/refs}/debug.c                         |   0
 {refs => lib/refs}/files-backend.c                 |   0
 {refs => lib/refs}/iterator.c                      |   0
 {refs => lib/refs}/packed-backend.c                |   0
 {refs => lib/refs}/packed-backend.h                |   0
 {refs => lib/refs}/ref-cache.c                     |   0
 {refs => lib/refs}/ref-cache.h                     |   0
 {refs => lib/refs}/refs-internal.h                 |   0
 {refs => lib/refs}/reftable-backend.c              |   0
 refspec.c => lib/refspec.c                         |   0
 refspec.h => lib/refspec.h                         |   0
 {reftable => lib/reftable}/LICENSE                 |   0
 {reftable => lib/reftable}/basics.c                |   0
 {reftable => lib/reftable}/basics.h                |   0
 {reftable => lib/reftable}/block.c                 |   0
 {reftable => lib/reftable}/block.h                 |   0
 {reftable => lib/reftable}/blocksource.c           |   0
 {reftable => lib/reftable}/blocksource.h           |   0
 {reftable => lib/reftable}/constants.h             |   0
 {reftable => lib/reftable}/error.c                 |   0
 {reftable => lib/reftable}/fsck.c                  |   0
 {reftable => lib/reftable}/iter.c                  |   0
 {reftable => lib/reftable}/iter.h                  |   0
 {reftable => lib/reftable}/merged.c                |   0
 {reftable => lib/reftable}/merged.h                |   0
 {reftable => lib/reftable}/pq.c                    |   0
 {reftable => lib/reftable}/pq.h                    |   0
 {reftable => lib/reftable}/record.c                |   0
 {reftable => lib/reftable}/record.h                |   0
 {reftable => lib/reftable}/reftable-basics.h       |   0
 {reftable => lib/reftable}/reftable-block.h        |   0
 {reftable => lib/reftable}/reftable-blocksource.h  |   0
 {reftable => lib/reftable}/reftable-constants.h    |   0
 {reftable => lib/reftable}/reftable-error.h        |   0
 {reftable => lib/reftable}/reftable-fsck.h         |   0
 {reftable => lib/reftable}/reftable-iterator.h     |   0
 {reftable => lib/reftable}/reftable-merged.h       |   0
 {reftable => lib/reftable}/reftable-record.h       |   0
 {reftable => lib/reftable}/reftable-stack.h        |   0
 {reftable => lib/reftable}/reftable-system.h       |   0
 {reftable => lib/reftable}/reftable-table.h        |   0
 {reftable => lib/reftable}/reftable-writer.h       |   0
 {reftable => lib/reftable}/stack.c                 |   0
 {reftable => lib/reftable}/stack.h                 |   0
 {reftable => lib/reftable}/system.c                |   0
 {reftable => lib/reftable}/system.h                |   0
 {reftable => lib/reftable}/table.c                 |   0
 {reftable => lib/reftable}/table.h                 |   0
 {reftable => lib/reftable}/tree.c                  |   0
 {reftable => lib/reftable}/tree.h                  |   0
 {reftable => lib/reftable}/writer.c                |   0
 {reftable => lib/reftable}/writer.h                |   0
 remote.c => lib/remote.c                           |   0
 remote.h => lib/remote.h                           |   0
 repack-cruft.c => lib/repack-cruft.c               |   0
 repack-filtered.c => lib/repack-filtered.c         |   0
 repack-geometry.c => lib/repack-geometry.c         |   0
 repack-midx.c => lib/repack-midx.c                 |   0
 repack-promisor.c => lib/repack-promisor.c         |   0
 repack.c => lib/repack.c                           |   0
 repack.h => lib/repack.h                           |   0
 replace-object.c => lib/replace-object.c           |   0
 replace-object.h => lib/replace-object.h           |   0
 replay.c => lib/replay.c                           |   0
 replay.h => lib/replay.h                           |   0
 repo-settings.c => lib/repo-settings.c             |   0
 repo-settings.h => lib/repo-settings.h             |   0
 repository.c => lib/repository.c                   |   0
 repository.h => lib/repository.h                   |   0
 rerere.c => lib/rerere.c                           |   0
 rerere.h => lib/rerere.h                           |   0
 reset.c => lib/reset.c                             |   0
 reset.h => lib/reset.h                             |   0
 resolve-undo.c => lib/resolve-undo.c               |   0
 resolve-undo.h => lib/resolve-undo.h               |   0
 revision.c => lib/revision.c                       |   0
 revision.h => lib/revision.h                       |   0
 run-command.c => lib/run-command.c                 |   0
 run-command.h => lib/run-command.h                 |   0
 sane-ctype.h => lib/sane-ctype.h                   |   0
 send-pack.c => lib/send-pack.c                     |   0
 send-pack.h => lib/send-pack.h                     |   0
 sequencer.c => lib/sequencer.c                     |   0
 sequencer.h => lib/sequencer.h                     |   0
 serve.c => lib/serve.c                             |   0
 serve.h => lib/serve.h                             |   0
 server-info.c => lib/server-info.c                 |   0
 server-info.h => lib/server-info.h                 |   0
 setup.c => lib/setup.c                             |   0
 setup.h => lib/setup.h                             |   0
 {sha1 => lib/sha1}/openssl.h                       |   0
 .../sha1collisiondetection                         |   0
 {sha1dc => lib/sha1dc}/.gitattributes              |   0
 {sha1dc => lib/sha1dc}/LICENSE.txt                 |   0
 {sha1dc => lib/sha1dc}/sha1.c                      |   0
 {sha1dc => lib/sha1dc}/sha1.h                      |   0
 {sha1dc => lib/sha1dc}/ubc_check.c                 |   0
 {sha1dc => lib/sha1dc}/ubc_check.h                 |   0
 sha1dc_git.c => lib/sha1dc_git.c                   |   0
 sha1dc_git.h => lib/sha1dc_git.h                   |   0
 {sha256 => lib/sha256}/block/sha256.c              |   0
 {sha256 => lib/sha256}/block/sha256.h              |   0
 {sha256 => lib/sha256}/gcrypt.h                    |   0
 {sha256 => lib/sha256}/nettle.h                    |   0
 {sha256 => lib/sha256}/openssl.h                   |   0
 shallow.c => lib/shallow.c                         |   0
 shallow.h => lib/shallow.h                         |   0
 shortlog.h => lib/shortlog.h                       |   0
 sideband.c => lib/sideband.c                       |   0
 sideband.h => lib/sideband.h                       |   0
 sigchain.c => lib/sigchain.c                       |   0
 sigchain.h => lib/sigchain.h                       |   0
 simple-ipc.h => lib/simple-ipc.h                   |   0
 sparse-index.c => lib/sparse-index.c               |   0
 sparse-index.h => lib/sparse-index.h               |   0
 split-index.c => lib/split-index.c                 |   0
 split-index.h => lib/split-index.h                 |   0
 stable-qsort.c => lib/stable-qsort.c               |   0
 statinfo.c => lib/statinfo.c                       |   0
 statinfo.h => lib/statinfo.h                       |   0
 strbuf.c => lib/strbuf.c                           |   0
 strbuf.h => lib/strbuf.h                           |   0
 string-list.c => lib/string-list.c                 |   0
 string-list.h => lib/string-list.h                 |   0
 strmap.c => lib/strmap.c                           |   0
 strmap.h => lib/strmap.h                           |   0
 strvec.c => lib/strvec.c                           |   0
 strvec.h => lib/strvec.h                           |   0
 sub-process.c => lib/sub-process.c                 |   0
 sub-process.h => lib/sub-process.h                 |   0
 submodule-config.c => lib/submodule-config.c       |   0
 submodule-config.h => lib/submodule-config.h       |   0
 submodule.c => lib/submodule.c                     |   0
 submodule.h => lib/submodule.h                     |   0
 symlinks.c => lib/symlinks.c                       |   0
 symlinks.h => lib/symlinks.h                       |   0
 tag.c => lib/tag.c                                 |   0
 tag.h => lib/tag.h                                 |   0
 tar.h => lib/tar.h                                 |   0
 tempfile.c => lib/tempfile.c                       |   0
 tempfile.h => lib/tempfile.h                       |   0
 thread-utils.c => lib/thread-utils.c               |   0
 thread-utils.h => lib/thread-utils.h               |   0
 tmp-objdir.c => lib/tmp-objdir.c                   |   0
 tmp-objdir.h => lib/tmp-objdir.h                   |   0
 trace.c => lib/trace.c                             |   0
 trace.h => lib/trace.h                             |   0
 trace2.c => lib/trace2.c                           |   0
 trace2.h => lib/trace2.h                           |   0
 {trace2 => lib/trace2}/tr2_cfg.c                   |   0
 {trace2 => lib/trace2}/tr2_cfg.h                   |   0
 {trace2 => lib/trace2}/tr2_cmd_name.c              |   0
 {trace2 => lib/trace2}/tr2_cmd_name.h              |   0
 {trace2 => lib/trace2}/tr2_ctr.c                   |   0
 {trace2 => lib/trace2}/tr2_ctr.h                   |   0
 {trace2 => lib/trace2}/tr2_dst.c                   |   0
 {trace2 => lib/trace2}/tr2_dst.h                   |   0
 {trace2 => lib/trace2}/tr2_sid.c                   |   0
 {trace2 => lib/trace2}/tr2_sid.h                   |   0
 {trace2 => lib/trace2}/tr2_sysenv.c                |   0
 {trace2 => lib/trace2}/tr2_sysenv.h                |   0
 {trace2 => lib/trace2}/tr2_tbuf.c                  |   0
 {trace2 => lib/trace2}/tr2_tbuf.h                  |   0
 {trace2 => lib/trace2}/tr2_tgt.h                   |   0
 {trace2 => lib/trace2}/tr2_tgt_event.c             |   0
 {trace2 => lib/trace2}/tr2_tgt_normal.c            |   0
 {trace2 => lib/trace2}/tr2_tgt_perf.c              |   0
 {trace2 => lib/trace2}/tr2_tls.c                   |   0
 {trace2 => lib/trace2}/tr2_tls.h                   |   0
 {trace2 => lib/trace2}/tr2_tmr.c                   |   0
 {trace2 => lib/trace2}/tr2_tmr.h                   |   0
 trailer.c => lib/trailer.c                         |   0
 trailer.h => lib/trailer.h                         |   0
 transport-helper.c => lib/transport-helper.c       |   0
 transport-internal.h => lib/transport-internal.h   |   0
 transport.c => lib/transport.c                     |   0
 transport.h => lib/transport.h                     |   0
 tree-diff.c => lib/tree-diff.c                     |   0
 tree-walk.c => lib/tree-walk.c                     |   0
 tree-walk.h => lib/tree-walk.h                     |   0
 tree.c => lib/tree.c                               |   0
 tree.h => lib/tree.h                               |   0
 unicode-width.h => lib/unicode-width.h             |   0
 unix-socket.c => lib/unix-socket.c                 |   0
 unix-socket.h => lib/unix-socket.h                 |   0
 unix-stream-server.c => lib/unix-stream-server.c   |   0
 unix-stream-server.h => lib/unix-stream-server.h   |   0
 unpack-trees.c => lib/unpack-trees.c               |   0
 unpack-trees.h => lib/unpack-trees.h               |   0
 upload-pack.c => lib/upload-pack.c                 |   0
 upload-pack.h => lib/upload-pack.h                 |   0
 url.c => lib/url.c                                 |   0
 url.h => lib/url.h                                 |   0
 urlmatch.c => lib/urlmatch.c                       |   0
 urlmatch.h => lib/urlmatch.h                       |   0
 usage.c => lib/usage.c                             |   0
 userdiff.c => lib/userdiff.c                       |   0
 userdiff.h => lib/userdiff.h                       |   0
 utf8.c => lib/utf8.c                               |   0
 utf8.h => lib/utf8.h                               |   0
 varint.c => lib/varint.c                           |   0
 varint.h => lib/varint.h                           |   0
 version-def.h.in => lib/version-def.h.in           |   0
 version.c => lib/version.c                         |   0
 version.h => lib/version.h                         |   0
 versioncmp.c => lib/versioncmp.c                   |   0
 versioncmp.h => lib/versioncmp.h                   |   0
 walker.c => lib/walker.c                           |   0
 walker.h => lib/walker.h                           |   0
 wildmatch.c => lib/wildmatch.c                     |   0
 wildmatch.h => lib/wildmatch.h                     |   0
 worktree.c => lib/worktree.c                       |   0
 worktree.h => lib/worktree.h                       |   0
 wrapper.c => lib/wrapper.c                         |   0
 wrapper.h => lib/wrapper.h                         |   0
 write-or-die.c => lib/write-or-die.c               |   0
 write-or-die.h => lib/write-or-die.h               |   0
 ws.c => lib/ws.c                                   |   0
 ws.h => lib/ws.h                                   |   0
 wt-status.c => lib/wt-status.c                     |   0
 wt-status.h => lib/wt-status.h                     |   0
 xdiff-interface.c => lib/xdiff-interface.c         |   0
 xdiff-interface.h => lib/xdiff-interface.h         |   0
 {xdiff => lib/xdiff}/xdiff.h                       |   0
 {xdiff => lib/xdiff}/xdiffi.c                      |   0
 {xdiff => lib/xdiff}/xdiffi.h                      |   0
 {xdiff => lib/xdiff}/xemit.c                       |   0
 {xdiff => lib/xdiff}/xemit.h                       |   0
 {xdiff => lib/xdiff}/xhistogram.c                  |   0
 {xdiff => lib/xdiff}/xinclude.h                    |   0
 {xdiff => lib/xdiff}/xmacros.h                     |   0
 {xdiff => lib/xdiff}/xmerge.c                      |   0
 {xdiff => lib/xdiff}/xpatience.c                   |   0
 {xdiff => lib/xdiff}/xprepare.c                    |   0
 {xdiff => lib/xdiff}/xprepare.h                    |   0
 {xdiff => lib/xdiff}/xtypes.h                      |   0
 {xdiff => lib/xdiff}/xutils.c                      |   0
 {xdiff => lib/xdiff}/xutils.h                      |   0
 meson.build                                        | 700 +++++++++----------
 t/helper/test-example-tap.c                        |   2 +-
 704 files changed, 823 insertions(+), 822 deletions(-)

Range-diff versus v1:

1:  906517b4f1 = 1:  12f6dbd779 t/helper: prepare "test-example-tap.c" for introduction of "lib/"
2:  b0fd01d713 ! 2:  7aa7c50a4e Move libgit.a sources into separate "lib/" directory
    @@ Commit message
     
      ## .github/workflows/main.yml ##
     @@ .github/workflows/main.yml: jobs:
    -       uses: actions/checkout@v5
    +       uses: actions/checkout@v6
            with:
              repository: 'microsoft/vcpkg'
     -        path: 'compat/vcbuild/vcpkg'
    @@ .github/workflows/main.yml: jobs:
            uses: git-for-windows/get-azure-pipelines-artifact@v0
            with:
     @@ .github/workflows/main.yml: jobs:
    -       uses: microsoft/setup-msbuild@v2
    +       uses: microsoft/setup-msbuild@v3
          - name: copy dlls to root
            shell: cmd
     -      run: compat\vcbuild\vcpkg_copy_dlls.bat release
    @@ Makefile: FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CM
     -LIB_OBJS += odb.o
     -LIB_OBJS += odb/source.o
     -LIB_OBJS += odb/source-files.o
    +-LIB_OBJS += odb/source-inmemory.o
    +-LIB_OBJS += odb/source-loose.o
    +-LIB_OBJS += odb/source-packed.o
     -LIB_OBJS += odb/streaming.o
    +-LIB_OBJS += odb/transaction.o
     -LIB_OBJS += oid-array.o
     -LIB_OBJS += oidmap.o
     -LIB_OBJS += oidset.o
    @@ Makefile: FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CM
     -LIB_OBJS += pack-revindex.o
     -LIB_OBJS += pack-write.o
     -LIB_OBJS += packfile.o
    +-LIB_OBJS += packfile-list.o
     -LIB_OBJS += pager.o
     -LIB_OBJS += parallel-checkout.o
     -LIB_OBJS += parse.o
    @@ Makefile: FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CM
     +LIB_OBJS += lib/odb.o
     +LIB_OBJS += lib/odb/source.o
     +LIB_OBJS += lib/odb/source-files.o
    ++LIB_OBJS += lib/odb/source-inmemory.o
    ++LIB_OBJS += lib/odb/source-loose.o
    ++LIB_OBJS += lib/odb/source-packed.o
     +LIB_OBJS += lib/odb/streaming.o
    ++LIB_OBJS += lib/odb/transaction.o
     +LIB_OBJS += lib/oid-array.o
     +LIB_OBJS += lib/oidmap.o
     +LIB_OBJS += lib/oidset.o
    @@ Makefile: FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CM
     +LIB_OBJS += lib/pack-revindex.o
     +LIB_OBJS += lib/pack-write.o
     +LIB_OBJS += lib/packfile.o
    ++LIB_OBJS += lib/packfile-list.o
     +LIB_OBJS += lib/pager.o
     +LIB_OBJS += lib/parallel-checkout.o
     +LIB_OBJS += lib/parse.o
    @@ Makefile: FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CM
     +LIB_OBJS += lib/usage.o
     +LIB_OBJS += lib/userdiff.o
     +LIB_OBJS += lib/utf8.o
    - ifndef WITH_RUST
    + ifdef NO_RUST
     -LIB_OBJS += varint.o
     -endif
     -LIB_OBJS += version.o
    @@ Makefile: BUILTIN_OBJS += builtin/write-tree.o
      # upstream unnecessarily (making merging in future changes easier).
     -THIRD_PARTY_SOURCES += compat/inet_ntop.c
     -THIRD_PARTY_SOURCES += compat/inet_pton.c
    --THIRD_PARTY_SOURCES += compat/nedmalloc/%
     -THIRD_PARTY_SOURCES += compat/obstack.%
     -THIRD_PARTY_SOURCES += compat/poll/%
     -THIRD_PARTY_SOURCES += compat/regex/%
    @@ Makefile: BUILTIN_OBJS += builtin/write-tree.o
     -THIRD_PARTY_SOURCES += sha1dc/%
     +THIRD_PARTY_SOURCES += lib/compat/inet_ntop.c
     +THIRD_PARTY_SOURCES += lib/compat/inet_pton.c
    -+THIRD_PARTY_SOURCES += lib/compat/nedmalloc/%
     +THIRD_PARTY_SOURCES += lib/compat/obstack.%
     +THIRD_PARTY_SOURCES += lib/compat/poll/%
     +THIRD_PARTY_SOURCES += lib/compat/regex/%
    @@ Makefile: ifdef UNRELIABLE_FSTAT
      endif
      endif
      ifdef NATIVE_CRLF
    -@@ Makefile: ifdef NATIVE_CRLF
    - endif
    - 
    - ifdef USE_NED_ALLOCATOR
    --	COMPAT_CFLAGS += -Icompat/nedmalloc
    --	COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
    -+	COMPAT_CFLAGS += -Ilib/compat/nedmalloc
    -+	COMPAT_OBJS += lib/compat/nedmalloc/nedmalloc.o
    - 	OVERRIDE_STRDUP = YesPlease
    - endif
    +@@ Makefile: endif
      
      ifdef OVERRIDE_STRDUP
      	COMPAT_CFLAGS += -DOVERRIDE_STRDUP
    @@ Makefile: endif
      	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
     -	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     -	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
    --	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
     +	COMPAT_OBJS += lib/compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
     +	COMPAT_OBJS += lib/compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
    -+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND).o
      endif
      
      ifdef FSMONITOR_OS_SETTINGS
      	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
    +-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
     -	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
    --	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
    +-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
    ++	COMPAT_OBJS += lib/compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
     +	COMPAT_OBJS += lib/compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
    -+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
    ++	COMPAT_OBJS += lib/compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
      endif
      
      ifdef WITH_BREAKING_CHANGES
    @@ Makefile: git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
     -help.sp help.s help.o: command-list.h
     +lib/help.sp lib/help.s lib/help.o: command-list.h
      builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
    - builtin/hook.sp builtin/hook.s builtin/hook.o: hook-list.h
    +-hook.sp hook.s hook.o: hook-list.h
    ++lib/hook.sp lib/hook.s lib/hook.o: hook-list.h
      
    + builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
    + builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
     @@ Makefile: builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
      PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
      PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
    @@ Makefile: compile_commands.json:
      	-DGAWK -DNO_MBSUPPORT
      endif
      
    - ifdef USE_NED_ALLOCATOR
    --compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
    -+lib/compat/nedmalloc/nedmalloc.sp lib/compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
    - 	-DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR
    --compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
    -+lib/compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
    - endif
    - 
     -headless-git.o: compat/win32/headless.c GIT-CFLAGS
     +headless-git.o: lib/compat/win32/headless.c GIT-CFLAGS
      	$(QUIET_CC)$(CC) $(ALL_CFLAGS) $(COMPAT_CFLAGS) \
    @@ config.mak.uname: ifeq ($(uname_S),Linux)
      	HAVE_PLATFORM_PROCINFO = YesPlease
     -	COMPAT_OBJS += compat/linux/procinfo.o
     +	COMPAT_OBJS += lib/compat/linux/procinfo.o
    + 	EXTLIBS += -ldl
      	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
              ifneq ($(findstring .el7.,$(uname_R)),)
    - 		BASIC_CFLAGS += -std=c99
     @@ config.mak.uname: ifeq ($(uname_S),Darwin)
      	NO_MEMMEM = YesPlease
      	USE_ST_TIMESPEC = YesPlease
    @@ contrib/buildsystems/CMakeLists.txt: endif()
      	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
      				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
      				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
    - 				USE_NED_ALLOCATOR OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
    + 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
      				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
      	list(APPEND compat_SOURCES
     -		compat/mingw.c
    @@ contrib/buildsystems/CMakeLists.txt: endif()
     -		compat/win32/syslog.c
     -		compat/win32/trace2_win32_process_info.c
     -		compat/win32/dirent.c
    --		compat/nedmalloc/nedmalloc.c
     -		compat/strdup.c)
     +		lib/compat/mingw.c
     +		lib/compat/winansi.c
    @@ contrib/buildsystems/CMakeLists.txt: endif()
     +		lib/compat/win32/syslog.c
     +		lib/compat/win32/trace2_win32_process_info.c
     +		lib/compat/win32/dirent.c
    -+		lib/compat/nedmalloc/nedmalloc.c
     +		lib/compat/strdup.c)
      	set(NO_UNIX_SOCKETS 1)
      
    @@ contrib/buildsystems/CMakeLists.txt: endif()
      		add_compile_definitions(SUPPORTS_SIMPLE_IPC)
      		set(SUPPORTS_SIMPLE_IPC 1)
      	endif()
    -@@ contrib/buildsystems/CMakeLists.txt: endif()
    - if(SUPPORTS_SIMPLE_IPC)
    - 	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    - 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-win32.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-win32.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-win32.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-listen-win32.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-health-win32.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-ipc-win32.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-path-utils-win32.c)
    +@@ contrib/buildsystems/CMakeLists.txt: if(SUPPORTS_SIMPLE_IPC)
      
    - 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-win32.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-settings-win32.c)
    - 	elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    + 	if(FSMONITOR_DAEMON_BACKEND)
      		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-darwin.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-darwin.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-darwin.c)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-darwin.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-listen-darwin.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-health-darwin.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-ipc-darwin.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-path-utils-darwin.c)
    +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
    +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
    +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
    +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
    ++		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
    ++		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
    ++		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
    ++		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
      
      		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
    --		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-darwin.c)
    -+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-settings-darwin.c)
    +-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
    ++		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
      	endif()
      endif()
      
    @@ compat/fsmonitor/fsm-darwin-gcc.h => lib/compat/fsmonitor/fsm-darwin-gcc.h
     
      ## compat/fsmonitor/fsm-health-darwin.c => lib/compat/fsmonitor/fsm-health-darwin.c ##
     
    + ## compat/fsmonitor/fsm-health-linux.c => lib/compat/fsmonitor/fsm-health-linux.c ##
    +
      ## compat/fsmonitor/fsm-health-win32.c => lib/compat/fsmonitor/fsm-health-win32.c ##
     
      ## compat/fsmonitor/fsm-health.h => lib/compat/fsmonitor/fsm-health.h ##
     
    - ## compat/fsmonitor/fsm-ipc-darwin.c => lib/compat/fsmonitor/fsm-ipc-darwin.c ##
    + ## compat/fsmonitor/fsm-ipc-unix.c => lib/compat/fsmonitor/fsm-ipc-unix.c ##
     
      ## compat/fsmonitor/fsm-ipc-win32.c => lib/compat/fsmonitor/fsm-ipc-win32.c ##
     
      ## compat/fsmonitor/fsm-listen-darwin.c => lib/compat/fsmonitor/fsm-listen-darwin.c ##
     
    + ## compat/fsmonitor/fsm-listen-linux.c => lib/compat/fsmonitor/fsm-listen-linux.c ##
    +
      ## compat/fsmonitor/fsm-listen-win32.c => lib/compat/fsmonitor/fsm-listen-win32.c ##
     
      ## compat/fsmonitor/fsm-listen.h => lib/compat/fsmonitor/fsm-listen.h ##
     
      ## compat/fsmonitor/fsm-path-utils-darwin.c => lib/compat/fsmonitor/fsm-path-utils-darwin.c ##
     
    + ## compat/fsmonitor/fsm-path-utils-linux.c => lib/compat/fsmonitor/fsm-path-utils-linux.c ##
    +
      ## compat/fsmonitor/fsm-path-utils-win32.c => lib/compat/fsmonitor/fsm-path-utils-win32.c ##
     
    - ## compat/fsmonitor/fsm-settings-darwin.c => lib/compat/fsmonitor/fsm-settings-darwin.c ##
    + ## compat/fsmonitor/fsm-settings-unix.c => lib/compat/fsmonitor/fsm-settings-unix.c ##
     
      ## compat/fsmonitor/fsm-settings-win32.c => lib/compat/fsmonitor/fsm-settings-win32.c ##
     
    @@ compat/msvc.c => lib/compat/msvc.c
     
      ## compat/msvc.h => lib/compat/msvc.h ##
     
    - ## compat/nedmalloc/License.txt => lib/compat/nedmalloc/License.txt ##
    -
    - ## compat/nedmalloc/Readme.txt => lib/compat/nedmalloc/Readme.txt ##
    -
    - ## compat/nedmalloc/malloc.c.h => lib/compat/nedmalloc/malloc.c.h ##
    -
    - ## compat/nedmalloc/nedmalloc.c => lib/compat/nedmalloc/nedmalloc.c ##
    -
    - ## compat/nedmalloc/nedmalloc.h => lib/compat/nedmalloc/nedmalloc.h ##
    -
      ## compat/nonblock.c => lib/compat/nonblock.c ##
     
      ## compat/nonblock.h => lib/compat/nonblock.h ##
    @@ compat/win32/dirent.c => lib/compat/win32/dirent.c
     
      ## compat/win32/dirent.h => lib/compat/win32/dirent.h ##
     
    + ## compat/win32/exit-process.h => lib/compat/win32/exit-process.h ##
    +
      ## compat/win32/flush.c => lib/compat/win32/flush.c ##
     
      ## compat/win32/git.manifest => lib/compat/win32/git.manifest ##
    @@ odb/source-files.c => lib/odb/source-files.c
     
      ## odb/source-files.h => lib/odb/source-files.h ##
     
    + ## odb/source-inmemory.c => lib/odb/source-inmemory.c ##
    +
    + ## odb/source-inmemory.h => lib/odb/source-inmemory.h ##
    +
    + ## odb/source-loose.c => lib/odb/source-loose.c ##
    +
    + ## odb/source-loose.h => lib/odb/source-loose.h ##
    +
    + ## odb/source-packed.c => lib/odb/source-packed.c ##
    +
    + ## odb/source-packed.h => lib/odb/source-packed.h ##
    +
      ## odb/source.c => lib/odb/source.c ##
     
      ## odb/source.h => lib/odb/source.h ##
    @@ odb/streaming.c => lib/odb/streaming.c
     
      ## odb/streaming.h => lib/odb/streaming.h ##
     
    + ## odb/transaction.c => lib/odb/transaction.c ##
    +
    + ## odb/transaction.h => lib/odb/transaction.h ##
    +
      ## oid-array.c => lib/oid-array.c ##
     
      ## oid-array.h => lib/oid-array.h ##
    @@ pack-write.c => lib/pack-write.c
     
      ## pack.h => lib/pack.h ##
     
    + ## packfile-list.c => lib/packfile-list.c ##
    +
    + ## packfile-list.h => lib/packfile-list.h ##
    +
      ## packfile.c => lib/packfile.c ##
     
      ## packfile.h => lib/packfile.h ##
    @@ meson.build: version_gen_environment.set('GIT_VERSION', get_option('version'))
     -  'odb.c',
     -  'odb/source.c',
     -  'odb/source-files.c',
    +-  'odb/source-inmemory.c',
    +-  'odb/source-loose.c',
    +-  'odb/source-packed.c',
     -  'odb/streaming.c',
    +-  'odb/transaction.c',
     -  'oid-array.c',
     -  'oidmap.c',
     -  'oidset.c',
    @@ meson.build: version_gen_environment.set('GIT_VERSION', get_option('version'))
     -  'pack-revindex.c',
     -  'pack-write.c',
     -  'packfile.c',
    +-  'packfile-list.c',
     -  'pager.c',
     -  'parallel-checkout.c',
     -  'parse.c',
    @@ meson.build: version_gen_environment.set('GIT_VERSION', get_option('version'))
     +  'lib/odb.c',
     +  'lib/odb/source.c',
     +  'lib/odb/source-files.c',
    ++  'lib/odb/source-inmemory.c',
    ++  'lib/odb/source-loose.c',
    ++  'lib/odb/source-packed.c',
     +  'lib/odb/streaming.c',
    ++  'lib/odb/transaction.c',
     +  'lib/oid-array.c',
     +  'lib/oidmap.c',
     +  'lib/oidset.c',
    @@ meson.build: version_gen_environment.set('GIT_VERSION', get_option('version'))
     +  'lib/pack-revindex.c',
     +  'lib/pack-write.c',
     +  'lib/packfile.c',
    ++  'lib/packfile-list.c',
     +  'lib/pager.c',
     +  'lib/parallel-checkout.c',
     +  'lib/parse.c',
    @@ meson.build: version_gen_environment.set('GIT_VERSION', get_option('version'))
      
      libgit_sources += custom_target(
     @@ meson.build: builtin_sources = [
    + ]
      
      third_party_excludes = [
    -   ':!contrib',
    +-  ':!contrib',
     -  ':!compat/inet_ntop.c',
     -  ':!compat/inet_pton.c',
    --  ':!compat/nedmalloc',
     -  ':!compat/obstack.*',
     -  ':!compat/poll',
     -  ':!compat/regex',
     -  ':!sha1collisiondetection',
     -  ':!sha1dc',
    ++  ':!lib/contrib',
     +  ':!lib/compat/inet_ntop.c',
     +  ':!lib/compat/inet_pton.c',
    -+  ':!lib/compat/nedmalloc',
     +  ':!lib/compat/obstack.*',
     +  ':!lib/compat/poll',
     +  ':!lib/compat/regex',
     +  ':!lib/sha1collisiondetection',
     +  ':!lib/sha1dc',
    -+  ':!lib/xdiff',
        ':!t/unit-tests/clar',
        ':!t/t[0-9][0-9][0-9][0-9]*',
     -  ':!xdiff',
    @@ meson.build: endif
     -    'compat/win32/pthread.c',
     -    'compat/win32/syslog.c',
     -    'compat/win32mmap.c',
    --    'compat/nedmalloc/nedmalloc.c',
     +    'lib/compat/winansi.c',
     +    'lib/compat/win32/dirent.c',
     +    'lib/compat/win32/flush.c',
    @@ meson.build: endif
     +    'lib/compat/win32/pthread.c',
     +    'lib/compat/win32/syslog.c',
     +    'lib/compat/win32mmap.c',
    -+    'lib/compat/nedmalloc/nedmalloc.c',
        ]
      
        libgit_c_args += [
    @@ meson.build: if fsmonitor_backend != ''
      
        compat_sources += [
     -    'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
    --    'compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
    +-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     -    'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     -    'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
    --    'compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
    +-    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
     +    'lib/compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
    -+    'lib/compat/fsmonitor/fsm-ipc-' + fsmonitor_backend + '.c',
    ++    'lib/compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
     +    'lib/compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
     +    'lib/compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
    -+    'lib/compat/fsmonitor/fsm-settings-' + fsmonitor_backend + '.c',
    ++    'lib/compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
        ]
      endif
      build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
    @@ meson.build: if get_option('docs') != []
      ]
      
      if sha1_backend != 'openssl'
    +-  exclude_from_check_headers += 'sha1/openssl.h'
    ++  exclude_from_check_headers += 'lib/sha1/openssl.h'
    + endif
    + if sha256_backend != 'openssl'
    +-  exclude_from_check_headers += 'sha256/openssl.h'
    ++  exclude_from_check_headers += 'lib/sha256/openssl.h'
    + endif
    + if sha256_backend != 'nettle'
    +-  exclude_from_check_headers += 'sha256/nettle.h'
    ++  exclude_from_check_headers += 'lib/sha256/nettle.h'
    + endif
    + if sha256_backend != 'gcrypt'
    +-  exclude_from_check_headers += 'sha256/gcrypt.h'
    ++  exclude_from_check_headers += 'lib/sha256/gcrypt.h'
    + endif
    + 
    + if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
    +@@ meson.build: if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
    +         compiler.cmd_array(),
    +         libgit_c_args,
    +         '-I', meson.project_source_root(),
    ++        '-I', meson.project_source_root() / 'lib',
    +         '-I', meson.project_source_root() / 't/unit-tests',
    +         '-o', '/dev/null',
    +         '-c', '-xc',

---
base-commit: 0309c6da48e2f94a72c9cee6e95ac6a1d0d2c965
change-id: 20260415-pks-libgit-in-subdir-d8eec849cd48

