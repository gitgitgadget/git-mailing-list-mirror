Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5024C361666
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921845; cv=none; b=MBLhnwFnedHh8x9Dm1vu86oSjyPRR9q0NY4mWABaxFeEXJDvvNtTs8mgHkDKC7U3caD26QSWzl3rtAXqcEBxEI6KRZwhwiG6y4SD+K86IXrYThcOGMuZA8hQlb90oQ+yKJ/zBITSi9C5cUdIK+OHP2TAJqAhs/NBG3niCGCmDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921845; c=relaxed/simple;
	bh=86IFBRdimzAgqFWyYvza6TUz9YW3lLQlVlyA/sx7fdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ncIFmOinIpRZZljbqngqIXXe4cgRA3z6MN8AC0yf2ljiEjrk+oyb5vXif7cguJowNcWp+hwTc6WM1V3m6UIRiVBxb+9g0HCEGMYVurHsrFmnossVvi/irlLqbP8q7TBVd6JTdeZrk3GVWz6HTQ8kpk65ajXUeh+o7DBOTLy6nbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f6a5QR+V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW6CQ66i; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f6a5QR+V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW6CQ66i"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 7913FEC010E;
	Mon, 13 Jul 2026 01:50:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:50:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921835;
	 x=1784008235; bh=mvQ7nZ+AqvYefibfWibSCm2Pgs877QMCqelaa4tjwIk=; b=
	f6a5QR+VQW8WQ7KxXWf+eEYsOyxTaDcbLgUGhRywdUDp3O18WW+xbxWZNYVEMc5L
	OT4VhmGjPJaEHRbZhZFjEcbo+nqZWPd3RxgQJwuwsHZbRD6JgtglDHQyXY6d0HMG
	mR09AQn/GwfqtLuUTVMCa3DRuh+1wwxENurLBI0lZMtzqhpZTp7iqymYE/vPq+Cl
	kc/+k+itDcnJnuqIreR7ZyAsWNIvJHl86S95T/TXSmLM1eTveE+gl3TebsJGO55N
	BZIHNkYDI6ELTjs7jwaipVDxEqVnfpJaDkkTdefRCbjRi1CXULfMdreTtizTAbzn
	EXSCIfxjPDu24zM8arYFMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921835; x=
	1784008235; bh=mvQ7nZ+AqvYefibfWibSCm2Pgs877QMCqelaa4tjwIk=; b=d
	W6CQ66iu56oq804dc+7m4JTagEQADqlrlZVpNSaUGfeKQN6RSDqzBjuCVDaRO+vZ
	sD1Gb5A8BxVuAcSyrVuOrPjavjnuNso7ZU0RXE39CNekGREI1X+tjDzYHkX095Qc
	jPEMuORQzNN2jPQCGiv35hjpWGqy8FRkiMmmxY4RPUgjVyfK4Qq+MLE6MIlzY9ZS
	8BSARCJzQ7r+lvNp4jjdvXi4VO/isJLm73qcjgGkove5PSaxTWFD4dzsmkvC4v3p
	lAvp4yPCu0tce/lm/UAsztfen+tEcsy/6S9eKXwzqUxMHg/QwlPZNPBJXkw8Pxkp
	EnoMibqCwg1grUgaMF7GQ==
X-ME-Sender: <xms:q3xUaqhzfo5scrGWJ9Sc4yqEnC8h6tTDE1GMD2Tlk1YXRKdjcUbBrg>
    <xme:q3xUarfkQajjqbA0NO3fDBWbVEY4c1BoC3KpQ-YpovkQrE4ONlzTWY-ZGO8R7b2LS
    rP3_wKVlEJ38XrmakMWbdJ5YYJsxPV4_xWdyO43y4zqm48CDbRae9s>
X-ME-Received: <xmr:q3xUaizIRSvugBdQVq4JI3sBzFDq7jc3KlWzToZaP1CHq-NQUVAxR40ZJ7QWkSJE700gG5oOBroPxRnLTjpvfPlbQBKplvRvT10SY2Md>
X-ME-Proxy-Cause: dmFkZTEL84QdCIY5Jgy3qIU/c4ms1S0tl+2f5a/rlgjjFDgv7RMidvodPbcbi19rilF09W
    Cct0nu+qwdxX9C53sjSbcdnt6T0bM1VlsBbYPwqZFxVSZF2UDtHdR3S+4rpVITYpL9aBHB
    zxLYp19HlwjMMljP+aCHN4r4k49FwDP16WI/es60X6kzMlpqZSQgAtARK5+D27E7t8hA1t
    9JBAZ/4SQoYKgpcpQJCZTr0qqmlq5B6fTZ6O1te9w9JGvgPJdA4qlQTS5CdosfYCSB6cCk
    mbdJKC0SV84rxh9dB7LodVRmQ8QZiTvwJc/3YL8QoSlWwbGI/XJRwJuN1JjyviL0j4+ZID
    5ijqPJiewhvypXP2NiN8qDX7ka1jRoEXcpaJJUTS4EcbVx0TXvndCvbnFXXqGCxM6Xl6J+
    cv/8lzXmAoTwigJr+VDEDBBtTw3q+YV+CvNwYmXXqPdV9BqjkD8/q/UHMmaiSGQoKF4PAn
    3EYnLZ8SjGkLGLo88pczSSKV6Z738KgbaPOIpy1+mYJ4faNolqWsvQTwMfdgsyeFPLVW9K
    VpDrChtykzHoCyR5tNo3hTcwFSqD8rg+8trPKi/15RTDriUl8CQkkvP2yjnoRfKCVlvNJH
    PSNQZ9yAAkmtR7gaYybf9wuI7m6SWtCCLGKSzdVrto2Sa5dqrp9Nff0vVVJw
X-ME-Proxy: <xmx:q3xUaq2p6UYCx8Zqv9h3IrE57OXMO_5ta47jKH8MQQ-RouPmoKFBSw>
    <xmx:q3xUaozlEAVl15v4IBsbIXgzj4vN0ry8bzDEOJGV2ceVJrq6VrWIvw>
    <xmx:q3xUavWF8osSH2nA2cU0qlWT5NyAW2JyBZoL8qWTEL89iIWG1bY8jA>
    <xmx:q3xUak__lsojViJ8wNubBU5N1lNsMP7xSI11dYB6ybl7tI2J_wqXQw>
    <xmx:q3xUas2gLd1Ix_ckjR_XxJ8N4iX4XZh6bdov4rMaAZIUgscUiU_hxNd4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:50:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 206fa34d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:50:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:50:16 +0200
Subject: [PATCH RFC v4 2/2] Move libgit.a sources into separate "lib/"
 directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-libgit-in-subdir-v4-2-696240876eb1@pks.im>
References: <20260713-pks-libgit-in-subdir-v4-0-696240876eb1@pks.im>
In-Reply-To: <20260713-pks-libgit-in-subdir-v4-0-696240876eb1@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
X-Mailer: b4 0.15.2

The Git project is not exactly the easiest project to get started in:
it's written in C and POSIX shell, with bits of Perl, Rust and other
languages sprinkled into it. On top of that, the project has grown
somewhat organically over time, making the codebase hard to navigate.

These are problems that we're aware of, and there have been and still
are efforts to clean up some of the technical debt that is natural to
exist in a project that is more than 20 years old. Furthermore, we
provide resources to newcomers that help them out like our coding
guidelines, code of conduct or "MyFirstContribution.adoc".

But there is a rather practical problem: finding your way around in our
project's tree is not easy. Doing a directory listing in the top-level
directory will present you with more than 550 files, which makes it
extremely hard for a newcomer to figure out what files they are even
supposed to look at. This makes the onboarding experience somewhat
harder than it really needs to be. This isn't only a problem for
newcomers though, as I myself struggle to find the files I am looking
for because of the sheer number of files.

Besides the problem of discoverability it also creates a problem of
structure. It is not obvious at all which files are part of "libgit.a"
and which files are only linked into our final executables. So while we
have this split in our build systems, that split is not evident at all
in our tree.

Introduce a new "lib/" directory and move all of our sources for
"libgit.a" into it to fix these issues. It makes the split we have
evident and reduces the number of files in our top-level tree from 550
files to ~80 files.

This is still a lot of files, but it's significantly easier to navigate
already. Furthermore, we can further iterate after this step and think
about introducing a better structure for remaining files, as well.

This move does not come for free though:

  - The mass rename introduces a cutoff point in the history of every
    moved file, as tools like git-log(1) do not follow renames by
    default.

  - Any in-flight or not-yet-submitted topic that touches the moved
    files will have to be rebased, and backporting fixes across the
    boundary becomes more cumbersome as a patch can no longer apply
    cleanly to both the old and the new layout.

My own (obviously subjective and biased) take is that the tradeoff is
worth it, as these issues are a one-time cost while the benefits to
discoverability will be permanent.

Furthermore, especially the first downside is a limitation in Git
itself. We're not the first or last project to do such a mass rename. So
if our provided tools are insufficient, then we should improve them to
make the experience better for other projects, as well. Subjecting
ourselves to the same pain may even give us more incentive to eventually
improve rename following for everyone.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml                         |   9 +-
 .gitmodules                                        |   2 +-
 Documentation/Makefile                             |   4 +-
 Makefile                                           | 766 ++++++++++-----------
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
 703 files changed, 824 insertions(+), 822 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index cf341d74db..accf456945 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -179,21 +179,22 @@ jobs:
       uses: actions/checkout@v6
       with:
         repository: 'microsoft/vcpkg'
-        path: 'compat/vcbuild/vcpkg'
+        path: 'lib/compat/vcbuild/vcpkg'
     - name: download vcpkg artifacts
       uses: git-for-windows/get-azure-pipelines-artifact@v0
       with:
         repository: git/git
         definitionId: 9
+        path: lib/compat
     - name: add msbuild to PATH
       uses: microsoft/setup-msbuild@v3
     - name: copy dlls to root
       shell: cmd
-      run: compat\vcbuild\vcpkg_copy_dlls.bat release
+      run: lib\compat\vcbuild\vcpkg_copy_dlls.bat release
     - name: generate Visual Studio solution
       shell: bash
       run: |
-        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/compat/vcbuild/vcpkg/installed/x64-windows \
+        cmake `pwd`/contrib/buildsystems/ -DCMAKE_PREFIX_PATH=`pwd`/lib/compat/vcbuild/vcpkg/installed/x64-windows \
         -DNO_GETTEXT=YesPlease -DPERL_TESTS=OFF -DPYTHON_TESTS=OFF -DCURL_NO_CURL_CMAKE=ON
     - name: MSBuild
       run: msbuild git.sln -property:Configuration=Release -property:Platform=x64 -maxCpuCount:4 -property:PlatformToolset=v142
@@ -201,7 +202,7 @@ jobs:
       shell: bash
       env:
         MSVC: 1
-        VCPKG_ROOT: ${{github.workspace}}\compat\vcbuild\vcpkg
+        VCPKG_ROOT: ${{github.workspace}}\lib\compat\vcbuild\vcpkg
       run: |
         mkdir -p artifacts &&
         eval "$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts NO_GETTEXT=YesPlease 2>&1 | grep ^tar)"
diff --git a/.gitmodules b/.gitmodules
index cbeebdab7a..8bafb8bb49 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,4 +1,4 @@
 [submodule "sha1collisiondetection"]
-	path = sha1collisiondetection
+	path = lib/sha1collisiondetection
 	url = https://github.com/cr-marcstevens/sha1collisiondetection.git
 	branch = master
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..c4fd5a5c87 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -505,10 +505,10 @@ lint-docs-man-section-order: $(LINT_DOCS_MAN_SECTION_ORDER)
 .PHONY: lint-docs-fsck-msgids
 LINT_DOCS_FSCK_MSGIDS = .build/lint-docs/fsck-msgids.ok
 $(LINT_DOCS_FSCK_MSGIDS): lint-fsck-msgids.perl
-$(LINT_DOCS_FSCK_MSGIDS): ../fsck.h fsck-msgids.adoc
+$(LINT_DOCS_FSCK_MSGIDS): ../lib/fsck.h fsck-msgids.adoc
 	$(call mkdir_p_parent_template)
 	$(QUIET_GEN)$(PERL_PATH) lint-fsck-msgids.perl \
-		../fsck.h fsck-msgids.adoc $@
+		../lib/fsck.h fsck-msgids.adoc $@
 lint-docs-fsck-msgids: $(LINT_DOCS_FSCK_MSGIDS)
 
 ## Lint: delimited sections
diff --git a/Makefile b/Makefile
index 1f3f099f5c..706252558f 100644
--- a/Makefile
+++ b/Makefile
@@ -967,7 +967,7 @@ endif
 CFLAGS = -g -O2 -Wall
 LDFLAGS =
 CC_LD_DYNPATH = -Wl,-rpath,
-BASIC_CFLAGS = -I.
+BASIC_CFLAGS = -I. -Ilib
 BASIC_LDFLAGS =
 
 # library flags
@@ -992,7 +992,7 @@ SANITIZE_LEAK =
 SANITIZE_ADDRESS =
 
 # For the 'coccicheck' target
-SPATCH_INCLUDE_FLAGS = --all-includes $(addprefix -I ,compat ewah refs sha256 trace2 win32 xdiff)
+SPATCH_INCLUDE_FLAGS = --all-includes $(addprefix -I lib/,compat ewah refs sha256 trace2 win32 xdiff)
 SPATCH_FLAGS =
 SPATCH_TEST_FLAGS =
 
@@ -1083,297 +1083,297 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) lib/reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 
-LIB_OBJS += abspath.o
-LIB_OBJS += add-interactive.o
-LIB_OBJS += add-patch.o
-LIB_OBJS += advice.o
-LIB_OBJS += alias.o
-LIB_OBJS += alloc.o
-LIB_OBJS += apply.o
-LIB_OBJS += archive-tar.o
-LIB_OBJS += archive-zip.o
-LIB_OBJS += archive.o
-LIB_OBJS += attr.o
-LIB_OBJS += base85.o
-LIB_OBJS += bisect.o
-LIB_OBJS += blame.o
-LIB_OBJS += blob.o
-LIB_OBJS += bloom.o
-LIB_OBJS += branch.o
-LIB_OBJS += bundle-uri.o
-LIB_OBJS += bundle.o
-LIB_OBJS += cache-tree.o
-LIB_OBJS += cbtree.o
-LIB_OBJS += chdir-notify.o
-LIB_OBJS += checkout.o
-LIB_OBJS += chunk-format.o
-LIB_OBJS += color.o
-LIB_OBJS += column.o
-LIB_OBJS += combine-diff.o
-LIB_OBJS += commit-graph.o
-LIB_OBJS += commit-reach.o
-LIB_OBJS += commit.o
-LIB_OBJS += common-exit.o
-LIB_OBJS += common-init.o
-LIB_OBJS += compat/nonblock.o
-LIB_OBJS += compat/obstack.o
-LIB_OBJS += compat/open.o
-LIB_OBJS += compat/terminal.o
-LIB_OBJS += compiler-tricks/not-constant.o
-LIB_OBJS += config.o
-LIB_OBJS += connect.o
-LIB_OBJS += connected.o
-LIB_OBJS += convert.o
-LIB_OBJS += copy.o
-LIB_OBJS += credential.o
-LIB_OBJS += csum-file.o
-LIB_OBJS += ctype.o
-LIB_OBJS += date.o
-LIB_OBJS += decorate.o
-LIB_OBJS += delta-islands.o
-LIB_OBJS += diagnose.o
-LIB_OBJS += diff-delta.o
-LIB_OBJS += diff-merges.o
-LIB_OBJS += diff-lib.o
-LIB_OBJS += diff-no-index.o
-LIB_OBJS += diff.o
-LIB_OBJS += diffcore-break.o
-LIB_OBJS += diffcore-delta.o
-LIB_OBJS += diffcore-order.o
-LIB_OBJS += diffcore-pickaxe.o
-LIB_OBJS += diffcore-rename.o
-LIB_OBJS += diffcore-rotate.o
-LIB_OBJS += dir-iterator.o
-LIB_OBJS += dir.o
-LIB_OBJS += editor.o
-LIB_OBJS += entry.o
-LIB_OBJS += environment.o
-LIB_OBJS += ewah/bitmap.o
-LIB_OBJS += ewah/ewah_bitmap.o
-LIB_OBJS += ewah/ewah_io.o
-LIB_OBJS += ewah/ewah_rlw.o
-LIB_OBJS += exec-cmd.o
-LIB_OBJS += fetch-negotiator.o
-LIB_OBJS += fetch-pack.o
-LIB_OBJS += fmt-merge-msg.o
-LIB_OBJS += fsck.o
-LIB_OBJS += fsmonitor.o
-LIB_OBJS += fsmonitor-ipc.o
-LIB_OBJS += fsmonitor-settings.o
-LIB_OBJS += gettext.o
-LIB_OBJS += git-zlib.o
-LIB_OBJS += gpg-interface.o
-LIB_OBJS += graph.o
-LIB_OBJS += grep.o
-LIB_OBJS += hash-lookup.o
-LIB_OBJS += hash.o
-LIB_OBJS += hashmap.o
-LIB_OBJS += help.o
-LIB_OBJS += hex.o
-LIB_OBJS += hex-ll.o
-LIB_OBJS += hook.o
-LIB_OBJS += ident.o
-LIB_OBJS += json-writer.o
-LIB_OBJS += kwset.o
-LIB_OBJS += levenshtein.o
-LIB_OBJS += line-log.o
-LIB_OBJS += line-range.o
-LIB_OBJS += linear-assignment.o
-LIB_OBJS += list-objects-filter-options.o
-LIB_OBJS += list-objects-filter.o
-LIB_OBJS += list-objects.o
-LIB_OBJS += lockfile.o
-LIB_OBJS += log-tree.o
-LIB_OBJS += loose.o
-LIB_OBJS += ls-refs.o
-LIB_OBJS += mailinfo.o
-LIB_OBJS += mailmap.o
-LIB_OBJS += match-trees.o
-LIB_OBJS += mem-pool.o
-LIB_OBJS += merge-blobs.o
-LIB_OBJS += merge-ll.o
-LIB_OBJS += merge-ort.o
-LIB_OBJS += merge-ort-wrappers.o
-LIB_OBJS += merge.o
-LIB_OBJS += midx.o
-LIB_OBJS += midx-write.o
-LIB_OBJS += name-hash.o
-LIB_OBJS += negotiator/default.o
-LIB_OBJS += negotiator/noop.o
-LIB_OBJS += negotiator/skipping.o
-LIB_OBJS += notes-cache.o
-LIB_OBJS += notes-merge.o
-LIB_OBJS += notes-utils.o
-LIB_OBJS += notes.o
-LIB_OBJS += object-file-convert.o
-LIB_OBJS += object-file.o
-LIB_OBJS += object-name.o
-LIB_OBJS += object.o
-LIB_OBJS += odb.o
-LIB_OBJS += odb/source.o
-LIB_OBJS += odb/source-files.o
-LIB_OBJS += odb/source-inmemory.o
-LIB_OBJS += odb/source-loose.o
-LIB_OBJS += odb/source-packed.o
-LIB_OBJS += odb/streaming.o
-LIB_OBJS += odb/transaction.o
-LIB_OBJS += oid-array.o
-LIB_OBJS += oidmap.o
-LIB_OBJS += oidset.o
-LIB_OBJS += oidtree.o
-LIB_OBJS += pack-bitmap-write.o
-LIB_OBJS += pack-bitmap.o
-LIB_OBJS += pack-check.o
-LIB_OBJS += pack-mtimes.o
-LIB_OBJS += pack-objects.o
-LIB_OBJS += pack-refs.o
-LIB_OBJS += pack-revindex.o
-LIB_OBJS += pack-write.o
-LIB_OBJS += packfile.o
-LIB_OBJS += packfile-list.o
-LIB_OBJS += pager.o
-LIB_OBJS += parallel-checkout.o
-LIB_OBJS += parse.o
-LIB_OBJS += parse-options-cb.o
-LIB_OBJS += parse-options.o
-LIB_OBJS += patch-delta.o
-LIB_OBJS += patch-ids.o
-LIB_OBJS += path.o
-LIB_OBJS += path-walk.o
-LIB_OBJS += pathspec.o
-LIB_OBJS += pkt-line.o
-LIB_OBJS += preload-index.o
-LIB_OBJS += pretty.o
-LIB_OBJS += prio-queue.o
-LIB_OBJS += progress.o
-LIB_OBJS += promisor-remote.o
-LIB_OBJS += prompt.o
-LIB_OBJS += protocol.o
-LIB_OBJS += protocol-caps.o
-LIB_OBJS += prune-packed.o
-LIB_OBJS += pseudo-merge.o
-LIB_OBJS += quote.o
-LIB_OBJS += range-diff.o
-LIB_OBJS += reachable.o
-LIB_OBJS += read-cache.o
-LIB_OBJS += rebase-interactive.o
-LIB_OBJS += rebase.o
-LIB_OBJS += ref-filter.o
-LIB_OBJS += reflog-walk.o
-LIB_OBJS += reflog.o
-LIB_OBJS += refs.o
-LIB_OBJS += refs/debug.o
-LIB_OBJS += refs/files-backend.o
-LIB_OBJS += refs/reftable-backend.o
-LIB_OBJS += refs/iterator.o
-LIB_OBJS += refs/packed-backend.o
-LIB_OBJS += refs/ref-cache.o
-LIB_OBJS += refspec.o
-LIB_OBJS += reftable/basics.o
-LIB_OBJS += reftable/block.o
-LIB_OBJS += reftable/blocksource.o
-LIB_OBJS += reftable/error.o
-LIB_OBJS += reftable/fsck.o
-LIB_OBJS += reftable/iter.o
-LIB_OBJS += reftable/merged.o
-LIB_OBJS += reftable/pq.o
-LIB_OBJS += reftable/record.o
-LIB_OBJS += reftable/stack.o
-LIB_OBJS += reftable/system.o
-LIB_OBJS += reftable/table.o
-LIB_OBJS += reftable/tree.o
-LIB_OBJS += reftable/writer.o
-LIB_OBJS += remote.o
-LIB_OBJS += repack.o
-LIB_OBJS += repack-cruft.o
-LIB_OBJS += repack-filtered.o
-LIB_OBJS += repack-geometry.o
-LIB_OBJS += repack-midx.o
-LIB_OBJS += repack-promisor.o
-LIB_OBJS += replace-object.o
-LIB_OBJS += replay.o
-LIB_OBJS += repo-settings.o
-LIB_OBJS += repository.o
-LIB_OBJS += rerere.o
-LIB_OBJS += reset.o
-LIB_OBJS += resolve-undo.o
-LIB_OBJS += revision.o
-LIB_OBJS += run-command.o
-LIB_OBJS += send-pack.o
-LIB_OBJS += sequencer.o
-LIB_OBJS += serve.o
-LIB_OBJS += server-info.o
-LIB_OBJS += setup.o
-LIB_OBJS += shallow.o
-LIB_OBJS += sideband.o
-LIB_OBJS += sigchain.o
-LIB_OBJS += sparse-index.o
-LIB_OBJS += split-index.o
-LIB_OBJS += stable-qsort.o
-LIB_OBJS += statinfo.o
-LIB_OBJS += strbuf.o
-LIB_OBJS += string-list.o
-LIB_OBJS += strmap.o
-LIB_OBJS += strvec.o
-LIB_OBJS += sub-process.o
-LIB_OBJS += submodule-config.o
-LIB_OBJS += submodule.o
-LIB_OBJS += symlinks.o
-LIB_OBJS += tag.o
-LIB_OBJS += tempfile.o
-LIB_OBJS += thread-utils.o
-LIB_OBJS += tmp-objdir.o
-LIB_OBJS += trace.o
-LIB_OBJS += trace2.o
-LIB_OBJS += trace2/tr2_cfg.o
-LIB_OBJS += trace2/tr2_cmd_name.o
-LIB_OBJS += trace2/tr2_ctr.o
-LIB_OBJS += trace2/tr2_dst.o
-LIB_OBJS += trace2/tr2_sid.o
-LIB_OBJS += trace2/tr2_sysenv.o
-LIB_OBJS += trace2/tr2_tbuf.o
-LIB_OBJS += trace2/tr2_tgt_event.o
-LIB_OBJS += trace2/tr2_tgt_normal.o
-LIB_OBJS += trace2/tr2_tgt_perf.o
-LIB_OBJS += trace2/tr2_tls.o
-LIB_OBJS += trace2/tr2_tmr.o
-LIB_OBJS += trailer.o
-LIB_OBJS += transport-helper.o
-LIB_OBJS += transport.o
-LIB_OBJS += tree-diff.o
-LIB_OBJS += tree-walk.o
-LIB_OBJS += tree.o
-LIB_OBJS += unpack-trees.o
-LIB_OBJS += upload-pack.o
-LIB_OBJS += url.o
-LIB_OBJS += urlmatch.o
-LIB_OBJS += usage.o
-LIB_OBJS += userdiff.o
-LIB_OBJS += utf8.o
+LIB_OBJS += lib/abspath.o
+LIB_OBJS += lib/add-interactive.o
+LIB_OBJS += lib/add-patch.o
+LIB_OBJS += lib/advice.o
+LIB_OBJS += lib/alias.o
+LIB_OBJS += lib/alloc.o
+LIB_OBJS += lib/apply.o
+LIB_OBJS += lib/archive-tar.o
+LIB_OBJS += lib/archive-zip.o
+LIB_OBJS += lib/archive.o
+LIB_OBJS += lib/attr.o
+LIB_OBJS += lib/base85.o
+LIB_OBJS += lib/bisect.o
+LIB_OBJS += lib/blame.o
+LIB_OBJS += lib/blob.o
+LIB_OBJS += lib/bloom.o
+LIB_OBJS += lib/branch.o
+LIB_OBJS += lib/bundle-uri.o
+LIB_OBJS += lib/bundle.o
+LIB_OBJS += lib/cache-tree.o
+LIB_OBJS += lib/cbtree.o
+LIB_OBJS += lib/chdir-notify.o
+LIB_OBJS += lib/checkout.o
+LIB_OBJS += lib/chunk-format.o
+LIB_OBJS += lib/color.o
+LIB_OBJS += lib/column.o
+LIB_OBJS += lib/combine-diff.o
+LIB_OBJS += lib/commit-graph.o
+LIB_OBJS += lib/commit-reach.o
+LIB_OBJS += lib/commit.o
+LIB_OBJS += lib/common-exit.o
+LIB_OBJS += lib/common-init.o
+LIB_OBJS += lib/compat/nonblock.o
+LIB_OBJS += lib/compat/obstack.o
+LIB_OBJS += lib/compat/open.o
+LIB_OBJS += lib/compat/terminal.o
+LIB_OBJS += lib/compiler-tricks/not-constant.o
+LIB_OBJS += lib/config.o
+LIB_OBJS += lib/connect.o
+LIB_OBJS += lib/connected.o
+LIB_OBJS += lib/convert.o
+LIB_OBJS += lib/copy.o
+LIB_OBJS += lib/credential.o
+LIB_OBJS += lib/csum-file.o
+LIB_OBJS += lib/ctype.o
+LIB_OBJS += lib/date.o
+LIB_OBJS += lib/decorate.o
+LIB_OBJS += lib/delta-islands.o
+LIB_OBJS += lib/diagnose.o
+LIB_OBJS += lib/diff-delta.o
+LIB_OBJS += lib/diff-merges.o
+LIB_OBJS += lib/diff-lib.o
+LIB_OBJS += lib/diff-no-index.o
+LIB_OBJS += lib/diff.o
+LIB_OBJS += lib/diffcore-break.o
+LIB_OBJS += lib/diffcore-delta.o
+LIB_OBJS += lib/diffcore-order.o
+LIB_OBJS += lib/diffcore-pickaxe.o
+LIB_OBJS += lib/diffcore-rename.o
+LIB_OBJS += lib/diffcore-rotate.o
+LIB_OBJS += lib/dir-iterator.o
+LIB_OBJS += lib/dir.o
+LIB_OBJS += lib/editor.o
+LIB_OBJS += lib/entry.o
+LIB_OBJS += lib/environment.o
+LIB_OBJS += lib/ewah/bitmap.o
+LIB_OBJS += lib/ewah/ewah_bitmap.o
+LIB_OBJS += lib/ewah/ewah_io.o
+LIB_OBJS += lib/ewah/ewah_rlw.o
+LIB_OBJS += lib/exec-cmd.o
+LIB_OBJS += lib/fetch-negotiator.o
+LIB_OBJS += lib/fetch-pack.o
+LIB_OBJS += lib/fmt-merge-msg.o
+LIB_OBJS += lib/fsck.o
+LIB_OBJS += lib/fsmonitor.o
+LIB_OBJS += lib/fsmonitor-ipc.o
+LIB_OBJS += lib/fsmonitor-settings.o
+LIB_OBJS += lib/gettext.o
+LIB_OBJS += lib/git-zlib.o
+LIB_OBJS += lib/gpg-interface.o
+LIB_OBJS += lib/graph.o
+LIB_OBJS += lib/grep.o
+LIB_OBJS += lib/hash-lookup.o
+LIB_OBJS += lib/hash.o
+LIB_OBJS += lib/hashmap.o
+LIB_OBJS += lib/help.o
+LIB_OBJS += lib/hex.o
+LIB_OBJS += lib/hex-ll.o
+LIB_OBJS += lib/hook.o
+LIB_OBJS += lib/ident.o
+LIB_OBJS += lib/json-writer.o
+LIB_OBJS += lib/kwset.o
+LIB_OBJS += lib/levenshtein.o
+LIB_OBJS += lib/line-log.o
+LIB_OBJS += lib/line-range.o
+LIB_OBJS += lib/linear-assignment.o
+LIB_OBJS += lib/list-objects-filter-options.o
+LIB_OBJS += lib/list-objects-filter.o
+LIB_OBJS += lib/list-objects.o
+LIB_OBJS += lib/lockfile.o
+LIB_OBJS += lib/log-tree.o
+LIB_OBJS += lib/loose.o
+LIB_OBJS += lib/ls-refs.o
+LIB_OBJS += lib/mailinfo.o
+LIB_OBJS += lib/mailmap.o
+LIB_OBJS += lib/match-trees.o
+LIB_OBJS += lib/mem-pool.o
+LIB_OBJS += lib/merge-blobs.o
+LIB_OBJS += lib/merge-ll.o
+LIB_OBJS += lib/merge-ort.o
+LIB_OBJS += lib/merge-ort-wrappers.o
+LIB_OBJS += lib/merge.o
+LIB_OBJS += lib/midx.o
+LIB_OBJS += lib/midx-write.o
+LIB_OBJS += lib/name-hash.o
+LIB_OBJS += lib/negotiator/default.o
+LIB_OBJS += lib/negotiator/noop.o
+LIB_OBJS += lib/negotiator/skipping.o
+LIB_OBJS += lib/notes-cache.o
+LIB_OBJS += lib/notes-merge.o
+LIB_OBJS += lib/notes-utils.o
+LIB_OBJS += lib/notes.o
+LIB_OBJS += lib/object-file-convert.o
+LIB_OBJS += lib/object-file.o
+LIB_OBJS += lib/object-name.o
+LIB_OBJS += lib/object.o
+LIB_OBJS += lib/odb.o
+LIB_OBJS += lib/odb/source.o
+LIB_OBJS += lib/odb/source-files.o
+LIB_OBJS += lib/odb/source-inmemory.o
+LIB_OBJS += lib/odb/source-loose.o
+LIB_OBJS += lib/odb/source-packed.o
+LIB_OBJS += lib/odb/streaming.o
+LIB_OBJS += lib/odb/transaction.o
+LIB_OBJS += lib/oid-array.o
+LIB_OBJS += lib/oidmap.o
+LIB_OBJS += lib/oidset.o
+LIB_OBJS += lib/oidtree.o
+LIB_OBJS += lib/pack-bitmap-write.o
+LIB_OBJS += lib/pack-bitmap.o
+LIB_OBJS += lib/pack-check.o
+LIB_OBJS += lib/pack-mtimes.o
+LIB_OBJS += lib/pack-objects.o
+LIB_OBJS += lib/pack-refs.o
+LIB_OBJS += lib/pack-revindex.o
+LIB_OBJS += lib/pack-write.o
+LIB_OBJS += lib/packfile.o
+LIB_OBJS += lib/packfile-list.o
+LIB_OBJS += lib/pager.o
+LIB_OBJS += lib/parallel-checkout.o
+LIB_OBJS += lib/parse.o
+LIB_OBJS += lib/parse-options-cb.o
+LIB_OBJS += lib/parse-options.o
+LIB_OBJS += lib/patch-delta.o
+LIB_OBJS += lib/patch-ids.o
+LIB_OBJS += lib/path.o
+LIB_OBJS += lib/path-walk.o
+LIB_OBJS += lib/pathspec.o
+LIB_OBJS += lib/pkt-line.o
+LIB_OBJS += lib/preload-index.o
+LIB_OBJS += lib/pretty.o
+LIB_OBJS += lib/prio-queue.o
+LIB_OBJS += lib/progress.o
+LIB_OBJS += lib/promisor-remote.o
+LIB_OBJS += lib/prompt.o
+LIB_OBJS += lib/protocol.o
+LIB_OBJS += lib/protocol-caps.o
+LIB_OBJS += lib/prune-packed.o
+LIB_OBJS += lib/pseudo-merge.o
+LIB_OBJS += lib/quote.o
+LIB_OBJS += lib/range-diff.o
+LIB_OBJS += lib/reachable.o
+LIB_OBJS += lib/read-cache.o
+LIB_OBJS += lib/rebase-interactive.o
+LIB_OBJS += lib/rebase.o
+LIB_OBJS += lib/ref-filter.o
+LIB_OBJS += lib/reflog-walk.o
+LIB_OBJS += lib/reflog.o
+LIB_OBJS += lib/refs.o
+LIB_OBJS += lib/refs/debug.o
+LIB_OBJS += lib/refs/files-backend.o
+LIB_OBJS += lib/refs/reftable-backend.o
+LIB_OBJS += lib/refs/iterator.o
+LIB_OBJS += lib/refs/packed-backend.o
+LIB_OBJS += lib/refs/ref-cache.o
+LIB_OBJS += lib/refspec.o
+LIB_OBJS += lib/reftable/basics.o
+LIB_OBJS += lib/reftable/block.o
+LIB_OBJS += lib/reftable/blocksource.o
+LIB_OBJS += lib/reftable/error.o
+LIB_OBJS += lib/reftable/fsck.o
+LIB_OBJS += lib/reftable/iter.o
+LIB_OBJS += lib/reftable/merged.o
+LIB_OBJS += lib/reftable/pq.o
+LIB_OBJS += lib/reftable/record.o
+LIB_OBJS += lib/reftable/stack.o
+LIB_OBJS += lib/reftable/system.o
+LIB_OBJS += lib/reftable/table.o
+LIB_OBJS += lib/reftable/tree.o
+LIB_OBJS += lib/reftable/writer.o
+LIB_OBJS += lib/remote.o
+LIB_OBJS += lib/repack.o
+LIB_OBJS += lib/repack-cruft.o
+LIB_OBJS += lib/repack-filtered.o
+LIB_OBJS += lib/repack-geometry.o
+LIB_OBJS += lib/repack-midx.o
+LIB_OBJS += lib/repack-promisor.o
+LIB_OBJS += lib/replace-object.o
+LIB_OBJS += lib/replay.o
+LIB_OBJS += lib/repo-settings.o
+LIB_OBJS += lib/repository.o
+LIB_OBJS += lib/rerere.o
+LIB_OBJS += lib/reset.o
+LIB_OBJS += lib/resolve-undo.o
+LIB_OBJS += lib/revision.o
+LIB_OBJS += lib/run-command.o
+LIB_OBJS += lib/send-pack.o
+LIB_OBJS += lib/sequencer.o
+LIB_OBJS += lib/serve.o
+LIB_OBJS += lib/server-info.o
+LIB_OBJS += lib/setup.o
+LIB_OBJS += lib/shallow.o
+LIB_OBJS += lib/sideband.o
+LIB_OBJS += lib/sigchain.o
+LIB_OBJS += lib/sparse-index.o
+LIB_OBJS += lib/split-index.o
+LIB_OBJS += lib/stable-qsort.o
+LIB_OBJS += lib/statinfo.o
+LIB_OBJS += lib/strbuf.o
+LIB_OBJS += lib/string-list.o
+LIB_OBJS += lib/strmap.o
+LIB_OBJS += lib/strvec.o
+LIB_OBJS += lib/sub-process.o
+LIB_OBJS += lib/submodule-config.o
+LIB_OBJS += lib/submodule.o
+LIB_OBJS += lib/symlinks.o
+LIB_OBJS += lib/tag.o
+LIB_OBJS += lib/tempfile.o
+LIB_OBJS += lib/thread-utils.o
+LIB_OBJS += lib/tmp-objdir.o
+LIB_OBJS += lib/trace.o
+LIB_OBJS += lib/trace2.o
+LIB_OBJS += lib/trace2/tr2_cfg.o
+LIB_OBJS += lib/trace2/tr2_cmd_name.o
+LIB_OBJS += lib/trace2/tr2_ctr.o
+LIB_OBJS += lib/trace2/tr2_dst.o
+LIB_OBJS += lib/trace2/tr2_sid.o
+LIB_OBJS += lib/trace2/tr2_sysenv.o
+LIB_OBJS += lib/trace2/tr2_tbuf.o
+LIB_OBJS += lib/trace2/tr2_tgt_event.o
+LIB_OBJS += lib/trace2/tr2_tgt_normal.o
+LIB_OBJS += lib/trace2/tr2_tgt_perf.o
+LIB_OBJS += lib/trace2/tr2_tls.o
+LIB_OBJS += lib/trace2/tr2_tmr.o
+LIB_OBJS += lib/trailer.o
+LIB_OBJS += lib/transport-helper.o
+LIB_OBJS += lib/transport.o
+LIB_OBJS += lib/tree-diff.o
+LIB_OBJS += lib/tree-walk.o
+LIB_OBJS += lib/tree.o
+LIB_OBJS += lib/unpack-trees.o
+LIB_OBJS += lib/upload-pack.o
+LIB_OBJS += lib/url.o
+LIB_OBJS += lib/urlmatch.o
+LIB_OBJS += lib/usage.o
+LIB_OBJS += lib/userdiff.o
+LIB_OBJS += lib/utf8.o
 ifdef NO_RUST
-LIB_OBJS += varint.o
-endif
-LIB_OBJS += version.o
-LIB_OBJS += versioncmp.o
-LIB_OBJS += walker.o
-LIB_OBJS += wildmatch.o
-LIB_OBJS += worktree.o
-LIB_OBJS += wrapper.o
-LIB_OBJS += write-or-die.o
-LIB_OBJS += ws.o
-LIB_OBJS += wt-status.o
-LIB_OBJS += xdiff-interface.o
-LIB_OBJS += xdiff/xdiffi.o
-LIB_OBJS += xdiff/xemit.o
-LIB_OBJS += xdiff/xhistogram.o
-LIB_OBJS += xdiff/xmerge.o
-LIB_OBJS += xdiff/xpatience.o
-LIB_OBJS += xdiff/xprepare.o
-LIB_OBJS += xdiff/xutils.o
+LIB_OBJS += lib/varint.o
+endif
+LIB_OBJS += lib/version.o
+LIB_OBJS += lib/versioncmp.o
+LIB_OBJS += lib/walker.o
+LIB_OBJS += lib/wildmatch.o
+LIB_OBJS += lib/worktree.o
+LIB_OBJS += lib/wrapper.o
+LIB_OBJS += lib/write-or-die.o
+LIB_OBJS += lib/ws.o
+LIB_OBJS += lib/wt-status.o
+LIB_OBJS += lib/xdiff-interface.o
+LIB_OBJS += lib/xdiff/xdiffi.o
+LIB_OBJS += lib/xdiff/xemit.o
+LIB_OBJS += lib/xdiff/xhistogram.o
+LIB_OBJS += lib/xdiff/xmerge.o
+LIB_OBJS += lib/xdiff/xpatience.o
+LIB_OBJS += lib/xdiff/xprepare.o
+LIB_OBJS += lib/xdiff/xutils.o
 
 BUILTIN_OBJS += builtin/add.o
 BUILTIN_OBJS += builtin/am.o
@@ -1513,13 +1513,13 @@ BUILTIN_OBJS += builtin/write-tree.o
 # files which are taken from some third-party source where we want to be
 # less strict about issues such as coding style so we don't diverge from
 # upstream unnecessarily (making merging in future changes easier).
-THIRD_PARTY_SOURCES += compat/inet_ntop.c
-THIRD_PARTY_SOURCES += compat/inet_pton.c
-THIRD_PARTY_SOURCES += compat/obstack.%
-THIRD_PARTY_SOURCES += compat/poll/%
-THIRD_PARTY_SOURCES += compat/regex/%
-THIRD_PARTY_SOURCES += sha1collisiondetection/%
-THIRD_PARTY_SOURCES += sha1dc/%
+THIRD_PARTY_SOURCES += lib/compat/inet_ntop.c
+THIRD_PARTY_SOURCES += lib/compat/inet_pton.c
+THIRD_PARTY_SOURCES += lib/compat/obstack.%
+THIRD_PARTY_SOURCES += lib/compat/poll/%
+THIRD_PARTY_SOURCES += lib/compat/regex/%
+THIRD_PARTY_SOURCES += lib/sha1collisiondetection/%
+THIRD_PARTY_SOURCES += lib/sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
@@ -1750,7 +1750,7 @@ endif
 
 ifdef NO_LIBGEN_H
 	COMPAT_CFLAGS += -DNO_LIBGEN_H
-	COMPAT_OBJS += compat/basename.o
+	COMPAT_OBJS += lib/compat/basename.o
 endif
 
 ifdef USE_LIBPCRE1
@@ -1816,7 +1816,7 @@ else
         endif
         ifdef USE_CURL_FOR_IMAP_SEND
 		BASIC_CFLAGS += -DUSE_CURL_FOR_IMAP_SEND
-		IMAP_SEND_BUILDDEPS = http.o
+		IMAP_SEND_BUILDDEPS = lib/http.o
 		IMAP_SEND_LDFLAGS += $(CURL_LIBCURL)
         endif
         ifndef NO_EXPAT
@@ -1937,11 +1937,11 @@ ifdef NO_NSEC
 endif
 ifdef SNPRINTF_RETURNS_BOGUS
 	COMPAT_CFLAGS += -DSNPRINTF_RETURNS_BOGUS
-	COMPAT_OBJS += compat/snprintf.o
+	COMPAT_OBJS += lib/compat/snprintf.o
 endif
 ifdef FREAD_READS_DIRECTORIES
 	COMPAT_CFLAGS += -DFREAD_READS_DIRECTORIES
-	COMPAT_OBJS += compat/fopen.o
+	COMPAT_OBJS += lib/compat/fopen.o
 endif
 ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
@@ -1956,38 +1956,38 @@ endif
 ifdef NO_POLL
 	NO_POLL_H = YesPlease
 	NO_SYS_POLL_H = YesPlease
-	COMPAT_CFLAGS += -DNO_POLL -Icompat/poll
-	COMPAT_OBJS += compat/poll/poll.o
+	COMPAT_CFLAGS += -DNO_POLL -Ilib/compat/poll
+	COMPAT_OBJS += lib/compat/poll/poll.o
 endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
-	COMPAT_OBJS += compat/strcasestr.o
+	COMPAT_OBJS += lib/compat/strcasestr.o
 endif
 ifdef NO_STRLCPY
 	COMPAT_CFLAGS += -DNO_STRLCPY
-	COMPAT_OBJS += compat/strlcpy.o
+	COMPAT_OBJS += lib/compat/strlcpy.o
 endif
 ifdef NO_STRTOUMAX
 	COMPAT_CFLAGS += -DNO_STRTOUMAX
-	COMPAT_OBJS += compat/strtoumax.o compat/strtoimax.o
+	COMPAT_OBJS += lib/compat/strtoumax.o lib/compat/strtoimax.o
 endif
 ifdef NO_STRTOULL
 	COMPAT_CFLAGS += -DNO_STRTOULL
 endif
 ifdef NO_SETENV
 	COMPAT_CFLAGS += -DNO_SETENV
-	COMPAT_OBJS += compat/setenv.o
+	COMPAT_OBJS += lib/compat/setenv.o
 endif
 ifdef NO_MKDTEMP
 	COMPAT_CFLAGS += -DNO_MKDTEMP
 endif
 ifdef MKDIR_WO_TRAILING_SLASH
 	COMPAT_CFLAGS += -DMKDIR_WO_TRAILING_SLASH
-	COMPAT_OBJS += compat/mkdir.o
+	COMPAT_OBJS += lib/compat/mkdir.o
 endif
 ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
-	COMPAT_OBJS += compat/unsetenv.o
+	COMPAT_OBJS += lib/compat/unsetenv.o
 endif
 ifdef NO_SYS_SELECT_H
 	BASIC_CFLAGS += -DNO_SYS_SELECT_H
@@ -2009,11 +2009,11 @@ ifdef NO_INITGROUPS
 endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
-	COMPAT_OBJS += compat/mmap.o
+	COMPAT_OBJS += lib/compat/mmap.o
 else
         ifdef USE_WIN32_MMAP
 		COMPAT_CFLAGS += -DUSE_WIN32_MMAP
-		COMPAT_OBJS += compat/win32mmap.o
+		COMPAT_OBJS += lib/compat/win32mmap.o
         endif
 endif
 ifdef MMAP_PREVENTS_DELETE
@@ -2031,7 +2031,7 @@ ifdef NO_SETITIMER
 endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
-	COMPAT_OBJS += compat/pread.o
+	COMPAT_OBJS += lib/compat/pread.o
 endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
@@ -2041,7 +2041,7 @@ ifdef NO_TRUSTABLE_FILEMODE
 endif
 ifdef NEEDS_MODE_TRANSLATION
 	COMPAT_CFLAGS += -DNEEDS_MODE_TRANSLATION
-	COMPAT_OBJS += compat/stat.o
+	COMPAT_OBJS += lib/compat/stat.o
 endif
 ifdef NO_IPV6
 	BASIC_CFLAGS += -DNO_IPV6
@@ -2057,18 +2057,18 @@ else
 endif
 endif
 ifdef NO_INET_NTOP
-	LIB_OBJS += compat/inet_ntop.o
+	LIB_OBJS += lib/compat/inet_ntop.o
 	BASIC_CFLAGS += -DNO_INET_NTOP
 endif
 ifdef NO_INET_PTON
-	LIB_OBJS += compat/inet_pton.o
+	LIB_OBJS += lib/compat/inet_pton.o
 	BASIC_CFLAGS += -DNO_INET_PTON
 endif
 ifdef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DNO_UNIX_SOCKETS
 else
-	LIB_OBJS += unix-socket.o
-	LIB_OBJS += unix-stream-server.o
+	LIB_OBJS += lib/unix-socket.o
+	LIB_OBJS += lib/unix-stream-server.o
 endif
 
 # Simple IPC requires threads and platform-specific IPC support.
@@ -2084,14 +2084,14 @@ endif
 #
 ifdef USE_WIN32_IPC
 	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
-	LIB_OBJS += compat/simple-ipc/ipc-shared.o
-	LIB_OBJS += compat/simple-ipc/ipc-win32.o
+	LIB_OBJS += lib/compat/simple-ipc/ipc-shared.o
+	LIB_OBJS += lib/compat/simple-ipc/ipc-win32.o
 else
 ifndef NO_PTHREADS
 ifndef NO_UNIX_SOCKETS
 	BASIC_CFLAGS += -DSUPPORTS_SIMPLE_IPC
-	LIB_OBJS += compat/simple-ipc/ipc-shared.o
-	LIB_OBJS += compat/simple-ipc/ipc-unix-socket.o
+	LIB_OBJS += lib/compat/simple-ipc/ipc-shared.o
+	LIB_OBJS += lib/compat/simple-ipc/ipc-unix-socket.o
 endif
 endif
 endif
@@ -2126,7 +2126,7 @@ ifdef OPENSSL_SHA1
 	BASIC_CFLAGS += -DSHA1_OPENSSL
 else
 ifdef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
+	LIB_OBJS += lib/block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK
 else
 ifdef APPLE_COMMON_CRYPTO_SHA1
@@ -2134,7 +2134,7 @@ ifdef APPLE_COMMON_CRYPTO_SHA1
 	BASIC_CFLAGS += -DSHA1_APPLE
 else
 	BASIC_CFLAGS += -DSHA1_DC
-	LIB_OBJS += sha1dc_git.o
+	LIB_OBJS += lib/sha1dc_git.o
 ifdef DC_SHA1_EXTERNAL
         ifdef DC_SHA1_SUBMODULE
                 ifneq ($(DC_SHA1_SUBMODULE),auto)
@@ -2145,12 +2145,12 @@ $(error Only set DC_SHA1_EXTERNAL or DC_SHA1_SUBMODULE, not both)
 	EXTLIBS += -lsha1detectcoll
 else
 ifdef DC_SHA1_SUBMODULE
-	LIB_OBJS += sha1collisiondetection/lib/sha1.o
-	LIB_OBJS += sha1collisiondetection/lib/ubc_check.o
+	LIB_OBJS += lib/sha1collisiondetection/lib/sha1.o
+	LIB_OBJS += lib/sha1collisiondetection/lib/ubc_check.o
 	BASIC_CFLAGS += -DDC_SHA1_SUBMODULE
 else
-	LIB_OBJS += sha1dc/sha1.o
-	LIB_OBJS += sha1dc/ubc_check.o
+	LIB_OBJS += lib/sha1dc/sha1.o
+	LIB_OBJS += lib/sha1dc/ubc_check.o
 endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
@@ -2170,7 +2170,7 @@ endif
 else
 ifdef BLK_SHA1_UNSAFE
 ifndef BLK_SHA1
-	LIB_OBJS += block-sha1/sha1.o
+	LIB_OBJS += lib/block-sha1/sha1.o
 	BASIC_CFLAGS += -DSHA1_BLK_UNSAFE
 endif
 else
@@ -2195,23 +2195,23 @@ ifdef GCRYPT_SHA256
 	BASIC_CFLAGS += -DSHA256_GCRYPT
 	EXTLIBS += -lgcrypt
 else
-	LIB_OBJS += sha256/block/sha256.o
+	LIB_OBJS += lib/sha256/block/sha256.o
 	BASIC_CFLAGS += -DSHA256_BLK
 endif
 endif
 endif
 
 ifdef SHA1_MAX_BLOCK_SIZE
-	LIB_OBJS += compat/sha1-chunked.o
+	LIB_OBJS += lib/compat/sha1-chunked.o
 	BASIC_CFLAGS += -DSHA1_MAX_BLOCK_SIZE="$(SHA1_MAX_BLOCK_SIZE)"
 endif
 ifdef NO_HSTRERROR
 	COMPAT_CFLAGS += -DNO_HSTRERROR
-	COMPAT_OBJS += compat/hstrerror.o
+	COMPAT_OBJS += lib/compat/hstrerror.o
 endif
 ifdef NO_MEMMEM
 	COMPAT_CFLAGS += -DNO_MEMMEM
-	COMPAT_OBJS += compat/memmem.o
+	COMPAT_OBJS += lib/compat/memmem.o
 endif
 ifdef NO_GETPAGESIZE
 	COMPAT_CFLAGS += -DNO_GETPAGESIZE
@@ -2222,7 +2222,7 @@ endif
 ifdef HAVE_ISO_QSORT_S
 	COMPAT_CFLAGS += -DHAVE_ISO_QSORT_S
 else
-	COMPAT_OBJS += compat/qsort_s.o
+	COMPAT_OBJS += lib/compat/qsort_s.o
 endif
 ifdef RUNTIME_PREFIX
 	COMPAT_CFLAGS += -DRUNTIME_PREFIX
@@ -2259,12 +2259,12 @@ ifdef UNRELIABLE_FSTAT
 	BASIC_CFLAGS += -DUNRELIABLE_FSTAT
 endif
 ifdef NO_REGEX
-	COMPAT_CFLAGS += -Icompat/regex
-	COMPAT_OBJS += compat/regex/regex.o
+	COMPAT_CFLAGS += -Ilib/compat/regex
+	COMPAT_OBJS += lib/compat/regex/regex.o
 else
 ifdef USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
 	COMPAT_CFLAGS += -DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS
-	COMPAT_OBJS += compat/regcomp_enhanced.o
+	COMPAT_OBJS += lib/compat/regcomp_enhanced.o
 endif
 endif
 ifdef NATIVE_CRLF
@@ -2273,7 +2273,7 @@ endif
 
 ifdef OVERRIDE_STRDUP
 	COMPAT_CFLAGS += -DOVERRIDE_STRDUP
-	COMPAT_OBJS += compat/strdup.o
+	COMPAT_OBJS += lib/compat/strdup.o
 endif
 
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
@@ -2335,7 +2335,7 @@ ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
 endif
 
 ifndef HAVE_PLATFORM_PROCINFO
-	COMPAT_OBJS += compat/stub/procinfo.o
+	COMPAT_OBJS += lib/compat/stub/procinfo.o
 endif
 
 ifdef RUNTIME_PREFIX
@@ -2365,25 +2365,25 @@ endif
 
 ifdef FILENO_IS_A_MACRO
 	COMPAT_CFLAGS += -DFILENO_IS_A_MACRO
-	COMPAT_OBJS += compat/fileno.o
+	COMPAT_OBJS += lib/compat/fileno.o
 endif
 
 ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_CFLAGS += -DNEED_ACCESS_ROOT_HANDLER
-	COMPAT_OBJS += compat/access.o
+	COMPAT_OBJS += lib/compat/access.o
 endif
 
 ifdef FSMONITOR_DAEMON_BACKEND
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
-	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef FSMONITOR_OS_SETTINGS
 	COMPAT_CFLAGS += -DHAVE_FSMONITOR_OS_SETTINGS
-	COMPAT_OBJS += compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
-	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-ipc-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-settings-$(FSMONITOR_OS_SETTINGS).o
+	COMPAT_OBJS += lib/compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_BACKEND).o
 endif
 
 ifdef WITH_BREAKING_CHANGES
@@ -2667,9 +2667,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
-help.sp help.s help.o: command-list.h
+lib/help.sp lib/help.s lib/help.o: command-list.h
 builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
-hook.sp hook.s hook.o: hook-list.h
+lib/hook.sp lib/hook.s lib/hook.o: hook-list.h
 
 builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
@@ -2680,13 +2680,13 @@ builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 PAGER_ENV_SQ = $(subst ','\'',$(PAGER_ENV))
 PAGER_ENV_CQ = "$(subst ",\",$(subst \,\\,$(PAGER_ENV)))"
 PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
-pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
+lib/pager.sp lib/pager.s lib/pager.o: EXTRA_CPPFLAGS = \
 	-DPAGER_ENV='$(PAGER_ENV_CQ_SQ)'
 
-version-def.h: version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
+version-def.h: lib/version-def.h.in GIT-VERSION-GEN GIT-VERSION-FILE GIT-USER-AGENT
 	$(QUIET_GEN)$(call version_gen,"$(shell pwd)",$<,$@)
 
-version.sp version.s version.o: version-def.h
+lib/version.sp lib/version.s lib/version.o: version-def.h
 
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && \
@@ -2879,7 +2879,7 @@ ifdef INCLUDE_LIBGIT_RS
 endif
 
 ifndef NO_CURL
-	OBJECTS += http.o http-walker.o remote-curl.o
+	OBJECTS += lib/http.o lib/http-walker.o remote-curl.o
 endif
 
 .PHONY: objects
@@ -2944,44 +2944,44 @@ compile_commands.json:
 	@if test -s $@+; then mv $@+ $@; else $(RM) $@+; fi
 endif
 
-exec-cmd.sp exec-cmd.s exec-cmd.o: GIT-PREFIX
-exec-cmd.sp exec-cmd.s exec-cmd.o: EXTRA_CPPFLAGS = \
+lib/exec-cmd.sp lib/exec-cmd.s lib/exec-cmd.o: GIT-PREFIX
+lib/exec-cmd.sp lib/exec-cmd.s lib/exec-cmd.o: EXTRA_CPPFLAGS = \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DGIT_LOCALE_PATH="$(localedir_relative_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DFALLBACK_RUNTIME_PREFIX="$(prefix_SQ)"'
 
-setup.sp setup.s setup.o: GIT-PREFIX
-setup.sp setup.s setup.o: EXTRA_CPPFLAGS = \
+lib/setup.sp lib/setup.s lib/setup.o: GIT-PREFIX
+lib/setup.sp lib/setup.s lib/setup.o: EXTRA_CPPFLAGS = \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.sp config.s config.o: GIT-PREFIX
-config.sp config.s config.o: EXTRA_CPPFLAGS = \
+lib/config.sp lib/config.s lib/config.o: GIT-PREFIX
+lib/config.sp lib/config.s lib/config.o: EXTRA_CPPFLAGS = \
 	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-attr.sp attr.s attr.o: GIT-PREFIX
-attr.sp attr.s attr.o: EXTRA_CPPFLAGS = \
+lib/attr.sp lib/attr.s lib/attr.o: GIT-PREFIX
+lib/attr.sp lib/attr.s lib/attr.o: EXTRA_CPPFLAGS = \
 	-DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'
 
-gettext.sp gettext.s gettext.o: GIT-PREFIX
-gettext.sp gettext.s gettext.o: EXTRA_CPPFLAGS = \
+lib/gettext.sp lib/gettext.s lib/gettext.o: GIT-PREFIX
+lib/gettext.sp lib/gettext.s lib/gettext.o: EXTRA_CPPFLAGS = \
 	-DGIT_LOCALE_PATH='"$(localedir_relative_SQ)"'
 
-http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
+http-push.sp lib/http.sp lib/http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
 	-DCURL_DISABLE_TYPECHECK
 
-pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
+lib/pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
 
 ifdef NO_EXPAT
-http-walker.sp http-walker.s http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
+lib/http-walker.sp lib/http-walker.s lib/http-walker.o: EXTRA_CPPFLAGS = -DNO_EXPAT
 endif
 
 ifdef NO_REGEX
-compat/regex/regex.sp compat/regex/regex.o: EXTRA_CPPFLAGS = \
+lib/compat/regex/regex.sp lib/compat/regex/regex.o: EXTRA_CPPFLAGS = \
 	-DGAWK -DNO_MBSUPPORT
 endif
 
-headless-git.o: compat/win32/headless.c GIT-CFLAGS
+headless-git.o: lib/compat/win32/headless.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) $(ALL_CFLAGS) $(COMPAT_CFLAGS) \
 		-fno-stack-protector -o $@ -c -Wall -Wwrite-strings $<
 
@@ -2995,10 +2995,10 @@ git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
-git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
+git-http-fetch$X: lib/http.o lib/http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
-git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
+git-http-push$X: lib/http.o http-push.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -3008,7 +3008,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-$(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
+$(REMOTE_CURL_PRIMARY): remote-curl.o lib/http.o lib/http-walker.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
@@ -3172,8 +3172,8 @@ LOCALIZED_C_CORE += builtin/clone.c
 LOCALIZED_C_CORE += builtin/index-pack.c
 LOCALIZED_C_CORE += builtin/push.c
 LOCALIZED_C_CORE += builtin/reset.c
-LOCALIZED_C_CORE += remote.c
-LOCALIZED_C_CORE += wt-status.c
+LOCALIZED_C_CORE += lib/remote.c
+LOCALIZED_C_CORE += lib/wt-status.c
 
 LOCALIZED_C_CORE_GEN_PO = $(LOCALIZED_C_CORE:%=.build/pot/po/%.po)
 
@@ -3412,18 +3412,18 @@ $(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
 .PHONY: sparse
 sparse: $(SP_OBJ)
 
-EXCEPT_HDRS := $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UNIT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
+EXCEPT_HDRS := $(GENERATED_H) lib/unicode-width.h lib/compat/% lib/xdiff/% $(UNIT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
 ifndef OPENSSL_SHA1
-	EXCEPT_HDRS += sha1/openssl.h
+	EXCEPT_HDRS += lib/sha1/openssl.h
 endif
 ifndef OPENSSL_SHA256
-	EXCEPT_HDRS += sha256/openssl.h
+	EXCEPT_HDRS += lib/sha256/openssl.h
 endif
 ifndef NETTLE_SHA256
-	EXCEPT_HDRS += sha256/nettle.h
+	EXCEPT_HDRS += lib/sha256/nettle.h
 endif
 ifndef GCRYPT_SHA256
-	EXCEPT_HDRS += sha256/gcrypt.h
+	EXCEPT_HDRS += lib/sha256/gcrypt.h
 endif
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
@@ -3775,13 +3775,13 @@ GIT_ARCHIVE_EXTRA_FILES = \
 	--add-file=.dist-tmp-dir/git-gui/version
 ifdef DC_SHA1_SUBMODULE
 GIT_ARCHIVE_EXTRA_FILES += \
-	--prefix=$(GIT_TARNAME)/sha1collisiondetection/ \
-	--add-file=sha1collisiondetection/LICENSE.txt \
-	--prefix=$(GIT_TARNAME)/sha1collisiondetection/lib/ \
-	--add-file=sha1collisiondetection/lib/sha1.c \
-	--add-file=sha1collisiondetection/lib/sha1.h \
-	--add-file=sha1collisiondetection/lib/ubc_check.c \
-	--add-file=sha1collisiondetection/lib/ubc_check.h
+	--prefix=$(GIT_TARNAME)/lib/sha1collisiondetection/ \
+	--add-file=lib/sha1collisiondetection/LICENSE.txt \
+	--prefix=$(GIT_TARNAME)/lib/sha1collisiondetection/lib/ \
+	--add-file=lib/sha1collisiondetection/lib/sha1.c \
+	--add-file=lib/sha1collisiondetection/lib/sha1.h \
+	--add-file=lib/sha1collisiondetection/lib/ubc_check.c \
+	--add-file=lib/sha1collisiondetection/lib/ubc_check.h
 endif
 dist: git-archive$(X) configure
 	@$(RM) -r .dist-tmp-dir
@@ -3911,7 +3911,7 @@ ifdef MSVC
 	$(RM) $(patsubst %.exe,%.pdb,$(TEST_PROGRAMS))
 	$(RM) $(patsubst %.exe,%.iobj,$(TEST_PROGRAMS))
 	$(RM) $(patsubst %.exe,%.ipdb,$(TEST_PROGRAMS))
-	$(RM) compat/vcbuild/MSVC-DEFS-GEN
+	$(RM) lib/compat/vcbuild/MSVC-DEFS-GEN
 endif
 
 .PHONY: all install profile-clean cocciclean clean strip
diff --git a/config.mak.uname b/config.mak.uname
index 8719e09f66..7af406439e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -21,17 +21,17 @@ ifdef MSVC
 
 	# Generate and include makefile variables that point to the
 	# currently installed set of MSVC command line tools.
-compat/vcbuild/MSVC-DEFS-GEN: compat/vcbuild/find_vs_env.bat
+lib/compat/vcbuild/MSVC-DEFS-GEN: lib/compat/vcbuild/find_vs_env.bat
 	@"$<" | tr '\\' / >"$@"
-include compat/vcbuild/MSVC-DEFS-GEN
+include lib/compat/vcbuild/MSVC-DEFS-GEN
 
 	# See if vcpkg and the vcpkg-build versions of the third-party
 	# libraries that we use are installed.  We include the result
 	# to get $(vcpkg_*) variables defined for the Makefile.
 ifeq (,$(SKIP_VCPKG))
-compat/vcbuild/VCPKG-DEFS: compat/vcbuild/vcpkg_install.bat
+lib/compat/vcbuild/VCPKG-DEFS: lib/compat/vcbuild/vcpkg_install.bat
 	@"$<"
-include compat/vcbuild/VCPKG-DEFS
+include lib/compat/vcbuild/VCPKG-DEFS
 endif
 endif
 
@@ -62,7 +62,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_SYSINFO = YesPlease
 	PROCFS_EXECUTABLE_PATH = /proc/self/exe
 	HAVE_PLATFORM_PROCINFO = YesPlease
-	COMPAT_OBJS += compat/linux/procinfo.o
+	COMPAT_OBJS += lib/compat/linux/procinfo.o
 	EXTLIBS += -ldl
 	# centos7/rhel7 provides gcc 4.8.5 and zlib 1.2.7.
         ifneq ($(findstring .el7.,$(uname_R)),)
@@ -152,7 +152,7 @@ ifeq ($(uname_S),Darwin)
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	HAVE_DEV_TTY = YesPlease
-	COMPAT_OBJS += compat/precompose_utf8.o
+	COMPAT_OBJS += lib/compat/precompose_utf8.o
 	BASIC_CFLAGS += -DPRECOMPOSE_UNICODE
 	BASIC_CFLAGS += -DPROTECT_HFS_DEFAULT=1
 	HAVE_BSD_SYSCTL = YesPlease
@@ -161,7 +161,7 @@ ifeq ($(uname_S),Darwin)
 	CSPRNG_METHOD = arc4random
 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease
 	HAVE_PLATFORM_PROCINFO = YesPlease
-	COMPAT_OBJS += compat/darwin/procinfo.o
+	COMPAT_OBJS += lib/compat/darwin/procinfo.o
 
         ifeq ($(uname_M),arm64)
 		HOMEBREW_PREFIX = /opt/homebrew
@@ -292,7 +292,7 @@ ifeq ($(uname_O),Cygwin)
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	MMAP_PREVENTS_DELETE = UnfortunatelyYes
-	COMPAT_OBJS += compat/win32/path-utils.o
+	COMPAT_OBJS += lib/compat/win32/path-utils.o
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
@@ -523,17 +523,17 @@ ifeq (/mingw64,$(subst 32,64,$(subst clangarm,mingw,$(prefix))))
 	ETC_GITATTRIBUTES = ../etc/gitattributes
 endif
 
-	CC = compat/vcbuild/scripts/clink.pl
-	AR = compat/vcbuild/scripts/lib.pl
+	CC = lib/compat/vcbuild/scripts/clink.pl
+	AR = lib/compat/vcbuild/scripts/lib.pl
 	CFLAGS =
-	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
-	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
-		compat/win32/flush.o \
-		compat/win32/path-utils.o \
-		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/trace2_win32_process_info.o \
-		compat/win32/dirent.o
-	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
+	BASIC_CFLAGS = -nologo -I. -Ilib/compat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	COMPAT_OBJS = lib/compat/msvc.o lib/compat/winansi.o \
+		lib/compat/win32/flush.o \
+		lib/compat/win32/path-utils.o \
+		lib/compat/win32/pthread.o lib/compat/win32/syslog.o \
+		lib/compat/win32/trace2_win32_process_info.o \
+		lib/compat/win32/dirent.o
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DDETECT_MSYS_TTY -DNOGDI -DHAVE_STRING_H -Ilib/compat -Ilib/compat/regex -Ilib/compat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -ENTRY:wmainCRTStartup -SUBSYSTEM:CONSOLE
 	# invalidcontinue.obj allows Git's source code to close the same file
 	# handle twice, or to access the osfhandle of an already-closed stdout
@@ -573,7 +573,7 @@ endif
 
 	EXTRA_PROGRAMS += headless-git$X
 
-compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
+lib/compat/msvc.o: lib/compat/msvc.c lib/compat/mingw.c GIT-CFLAGS
 endif
 ifeq ($(uname_S),Interix)
 	NO_INITGROUPS = YesPlease
@@ -724,14 +724,14 @@ ifeq ($(uname_S),MINGW)
 	HAVE_PLATFORM_PROCINFO = YesPlease
 	CSPRNG_METHOD = rtlgenrandom
 	BASIC_LDFLAGS += -municode
-	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
+	COMPAT_CFLAGS += -DNOGDI -Ilib/compat -Ilib/compat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
-		compat/win32/trace2_win32_process_info.o \
-		compat/win32/flush.o \
-		compat/win32/path-utils.o \
-		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/dirent.o
+	COMPAT_OBJS += lib/compat/mingw.o lib/compat/winansi.o \
+		lib/compat/win32/trace2_win32_process_info.o \
+		lib/compat/win32/flush.o \
+		lib/compat/win32/path-utils.o \
+		lib/compat/win32/pthread.o lib/compat/win32/syslog.o \
+		lib/compat/win32/dirent.o
 	BASIC_CFLAGS += -DWIN32
 	EXTLIBS += -lws2_32
 	GITLIBS += git.res
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b464f..446a6c889f 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -62,10 +62,10 @@ if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
 endif()
 
 if(USE_VCPKG)
-	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg")
+	set(VCPKG_DIR "${CMAKE_SOURCE_DIR}/lib/compat/vcbuild/vcpkg")
 	if(NOT EXISTS ${VCPKG_DIR})
 		message("Initializing vcpkg and building the Git's dependencies (this will take a while...)")
-		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg_install.bat)
+		execute_process(COMMAND ${CMAKE_SOURCE_DIR}/lib/compat/vcbuild/vcpkg_install.bat)
 	endif()
 	list(APPEND CMAKE_PREFIX_PATH "${VCPKG_DIR}/installed/x64-windows")
 
@@ -194,7 +194,7 @@ else()
 	find_program(MSGFMT_EXE msgfmt)
 	if(NOT MSGFMT_EXE)
 		if(USE_VCPKG)
-			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+			set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/lib/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
 		endif()
 		if(NOT EXISTS ${MSGFMT_EXE})
 			message(WARNING "Text Translations won't be built")
@@ -212,13 +212,14 @@ endif()
 
 #default behaviour
 include_directories(${CMAKE_SOURCE_DIR})
+include_directories(${CMAKE_SOURCE_DIR}/lib)
 add_compile_definitions(GIT_HOST_CPU="${CMAKE_SYSTEM_PROCESSOR}")
 add_compile_definitions(SHA256_BLK INTERNAL_QSORT RUNTIME_PREFIX)
 add_compile_definitions(NO_OPENSSL SHA1_DC SHA1DC_NO_STANDARD_INCLUDES
 			SHA1DC_INIT_SAFE_HASH_DEFAULT=0
 			SHA1DC_CUSTOM_INCLUDE_SHA1_C="git-compat-util.h"
 			SHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h" )
-list(APPEND compat_SOURCES sha1dc_git.c sha1dc/sha1.c sha1dc/ubc_check.c block-sha1/sha1.c sha256/block/sha256.c compat/qsort_s.c)
+list(APPEND compat_SOURCES lib/sha1dc_git.c lib/sha1dc/sha1.c lib/sha1dc/ubc_check.c lib/block-sha1/sha1.c lib/sha256/block/sha256.c lib/compat/qsort_s.c)
 
 
 add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
@@ -248,43 +249,43 @@ endif()
 #Platform Specific
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 	if(CMAKE_C_COMPILER_ID STREQUAL "MSVC" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
-		include_directories(${CMAKE_SOURCE_DIR}/compat/vcbuild/include)
+		include_directories(${CMAKE_SOURCE_DIR}/lib/compat/vcbuild/include)
 		add_compile_definitions(_CRT_SECURE_NO_WARNINGS _CRT_NONSTDC_NO_DEPRECATE)
 	endif()
-	include_directories(${CMAKE_SOURCE_DIR}/compat/win32)
+	include_directories(${CMAKE_SOURCE_DIR}/lib/compat/win32)
 	add_compile_definitions(HAVE_ALLOCA_H NO_POSIX_GOODIES NATIVE_CRLF NO_UNIX_SOCKETS WIN32
 				_CONSOLE DETECT_MSYS_TTY STRIP_EXTENSION=".exe"  NO_SYMLINK_HEAD UNRELIABLE_FSTAT
 				NOGDI OBJECT_CREATION_MODE=1 __USE_MINGW_ANSI_STDIO=0
 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				HAVE_WPGMPTR ENSURE_MSYSTEM_IS_SET HAVE_RTLGENRANDOM)
 	list(APPEND compat_SOURCES
-		compat/mingw.c
-		compat/winansi.c
-		compat/win32/flush.c
-		compat/win32/path-utils.c
-		compat/win32/pthread.c
-		compat/win32mmap.c
-		compat/win32/syslog.c
-		compat/win32/trace2_win32_process_info.c
-		compat/win32/dirent.c
-		compat/strdup.c)
+		lib/compat/mingw.c
+		lib/compat/winansi.c
+		lib/compat/win32/flush.c
+		lib/compat/win32/path-utils.c
+		lib/compat/win32/pthread.c
+		lib/compat/win32mmap.c
+		lib/compat/win32/syslog.c
+		lib/compat/win32/trace2_win32_process_info.c
+		lib/compat/win32/dirent.c
+		lib/compat/strdup.c)
 	set(NO_UNIX_SOCKETS 1)
 
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
 	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
-	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
+	list(APPEND compat_SOURCES lib/unix-socket.c lib/unix-stream-server.c lib/compat/linux/procinfo.c)
 elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
-	list(APPEND compat_SOURCES compat/darwin/procinfo.c)
+	list(APPEND compat_SOURCES lib/compat/darwin/procinfo.c)
 endif()
 
 if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
-	list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-win32.c)
+	list(APPEND compat_SOURCES lib/compat/simple-ipc/ipc-shared.c lib/compat/simple-ipc/ipc-win32.c)
 	add_compile_definitions(SUPPORTS_SIMPLE_IPC)
 	set(SUPPORTS_SIMPLE_IPC 1)
 else()
 	# Simple IPC requires both Unix sockets and pthreads on Unix-based systems.
 	if(NOT NO_UNIX_SOCKETS AND NOT NO_PTHREADS)
-		list(APPEND compat_SOURCES compat/simple-ipc/ipc-shared.c compat/simple-ipc/ipc-unix-socket.c)
+		list(APPEND compat_SOURCES lib/compat/simple-ipc/ipc-shared.c lib/compat/simple-ipc/ipc-unix-socket.c)
 		add_compile_definitions(SUPPORTS_SIMPLE_IPC)
 		set(SUPPORTS_SIMPLE_IPC 1)
 	endif()
@@ -305,13 +306,13 @@ if(SUPPORTS_SIMPLE_IPC)
 
 	if(FSMONITOR_DAEMON_BACKEND)
 		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-listen-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-health-${FSMONITOR_DAEMON_BACKEND}.c)
+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-ipc-${FSMONITOR_OS_SETTINGS}.c)
+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-path-utils-${FSMONITOR_DAEMON_BACKEND}.c)
 
 		add_compile_definitions(HAVE_FSMONITOR_OS_SETTINGS)
-		list(APPEND compat_SOURCES compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
+		list(APPEND compat_SOURCES lib/compat/fsmonitor/fsm-settings-${FSMONITOR_OS_SETTINGS}.c)
 	endif()
 endif()
 
@@ -321,7 +322,7 @@ set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 check_include_file(libgen.h HAVE_LIBGEN_H)
 if(NOT HAVE_LIBGEN_H)
 	add_compile_definitions(NO_LIBGEN_H)
-	list(APPEND compat_SOURCES compat/basename.c)
+	list(APPEND compat_SOURCES lib/compat/basename.c)
 endif()
 
 check_include_file(sys/sysinfo.h HAVE_SYSINFO)
@@ -394,42 +395,42 @@ foreach(f ${function_checks})
 endforeach()
 
 if(NOT HAVE_POLL_H OR NOT HAVE_SYS_POLL_H OR NOT HAVE_POLL)
-	include_directories(${CMAKE_SOURCE_DIR}/compat/poll)
+	include_directories(${CMAKE_SOURCE_DIR}/lib/compat/poll)
 	add_compile_definitions(NO_POLL)
-	list(APPEND compat_SOURCES compat/poll/poll.c)
+	list(APPEND compat_SOURCES lib/compat/poll/poll.c)
 endif()
 
 if(NOT HAVE_STRCASESTR)
-	list(APPEND compat_SOURCES compat/strcasestr.c)
+	list(APPEND compat_SOURCES lib/compat/strcasestr.c)
 endif()
 
 if(NOT HAVE_STRLCPY)
-	list(APPEND compat_SOURCES compat/strlcpy.c)
+	list(APPEND compat_SOURCES lib/compat/strlcpy.c)
 endif()
 
 if(NOT HAVE_STRTOUMAX)
-	list(APPEND compat_SOURCES compat/strtoumax.c compat/strtoimax.c)
+	list(APPEND compat_SOURCES lib/compat/strtoumax.c lib/compat/strtoimax.c)
 endif()
 
 if(NOT HAVE_SETENV)
-	list(APPEND compat_SOURCES compat/setenv.c)
+	list(APPEND compat_SOURCES lib/compat/setenv.c)
 endif()
 
 if(NOT HAVE_PREAD)
-	list(APPEND compat_SOURCES compat/pread.c)
+	list(APPEND compat_SOURCES lib/compat/pread.c)
 endif()
 
 if(NOT HAVE_MEMMEM)
-	list(APPEND compat_SOURCES compat/memmem.c)
+	list(APPEND compat_SOURCES lib/compat/memmem.c)
 endif()
 
 if(NOT WIN32)
 	if(NOT HAVE_UNSETENV)
-		list(APPEND compat_SOURCES compat/unsetenv.c)
+		list(APPEND compat_SOURCES lib/compat/unsetenv.c)
 	endif()
 
 	if(NOT HAVE_HSTRERROR)
-		list(APPEND compat_SOURCES compat/hstrerror.c)
+		list(APPEND compat_SOURCES lib/compat/hstrerror.c)
 	endif()
 endif()
 
@@ -486,7 +487,7 @@ int main(void)
 SNPRINTF_OK)
 if(NOT SNPRINTF_OK)
 	add_compile_definitions(SNPRINTF_RETURNS_BOGUS)
-	list(APPEND compat_SOURCES compat/snprintf.c)
+	list(APPEND compat_SOURCES lib/compat/snprintf.c)
 endif()
 
 check_c_source_runs("
@@ -501,7 +502,7 @@ int main(void)
 FREAD_READS_DIRECTORIES_NO)
 if(NOT FREAD_READS_DIRECTORIES_NO)
 	add_compile_definitions(FREAD_READS_DIRECTORIES)
-	list(APPEND compat_SOURCES compat/fopen.c)
+	list(APPEND compat_SOURCES lib/compat/fopen.c)
 endif()
 
 check_c_source_compiles("
@@ -516,8 +517,8 @@ int main(void)
 }"
 HAVE_REGEX)
 if(NOT HAVE_REGEX)
-	include_directories(${CMAKE_SOURCE_DIR}/compat/regex)
-	list(APPEND compat_SOURCES compat/regex/regex.c )
+	include_directories(${CMAKE_SOURCE_DIR}/lib/compat/regex)
+	list(APPEND compat_SOURCES lib/compat/regex/regex.c )
 	add_compile_definitions(NO_REGEX NO_MBSUPPORT GAWK)
 endif()
 
@@ -670,10 +671,10 @@ list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/version-def.h"
 	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
 		"${CMAKE_SOURCE_DIR}"
-		"${CMAKE_SOURCE_DIR}/version-def.h.in"
+		"${CMAKE_SOURCE_DIR}/lib/version-def.h.in"
 		"${CMAKE_BINARY_DIR}/version-def.h"
 	DEPENDS "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
-		"${CMAKE_SOURCE_DIR}/version-def.h.in"
+		"${CMAKE_SOURCE_DIR}/lib/version-def.h.in"
 	VERBATIM)
 list(APPEND libgit_SOURCES "${CMAKE_BINARY_DIR}/version-def.h")
 
@@ -732,7 +733,7 @@ if(WIN32)
 		message(FATAL_ERROR "Unhandled compiler: ${CMAKE_C_COMPILER_ID}")
 	endif()
 
-	add_executable(headless-git ${CMAKE_SOURCE_DIR}/compat/win32/headless.c)
+	add_executable(headless-git ${CMAKE_SOURCE_DIR}/lib/compat/win32/headless.c)
 	if(CMAKE_C_COMPILER_ID STREQUAL "GNU" OR CMAKE_C_COMPILER_ID STREQUAL "Clang")
 		target_link_options(headless-git PUBLIC -municode -Wl,-subsystem,windows)
 	elseif(CMAKE_C_COMPILER_ID STREQUAL "MSVC")
@@ -767,15 +768,15 @@ add_executable(scalar ${CMAKE_SOURCE_DIR}/scalar.c)
 target_link_libraries(scalar common-main)
 
 if(CURL_FOUND)
-	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/http.c)
+	add_library(http_obj OBJECT ${CMAKE_SOURCE_DIR}/lib/http.c)
 
 	add_executable(git-imap-send ${CMAKE_SOURCE_DIR}/imap-send.c)
 	target_link_libraries(git-imap-send http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
+	add_executable(git-http-fetch ${CMAKE_SOURCE_DIR}/lib/http-walker.c ${CMAKE_SOURCE_DIR}/http-fetch.c)
 	target_link_libraries(git-http-fetch http_obj common-main ${CURL_LIBRARIES})
 
-	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
+	add_executable(git-remote-http ${CMAKE_SOURCE_DIR}/lib/http-walker.c ${CMAKE_SOURCE_DIR}/remote-curl.c)
 	target_link_libraries(git-remote-http http_obj common-main ${CURL_LIBRARIES} )
 
 	if(EXPAT_FOUND)
@@ -1201,7 +1202,7 @@ string(REPLACE "@USE_LIBPCRE2@" "" git_build_options "${git_build_options}")
 string(REPLACE "@WITH_BREAKING_CHANGES@" "" git_build_options "${git_build_options}")
 string(REPLACE "@X@" "${EXE_EXTENSION}" git_build_options "${git_build_options}")
 if(USE_VCPKG)
-	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
+	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../lib/compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 endif()
 file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS ${git_build_options})
 
diff --git a/git.rc.in b/git.rc.in
index e69444eef3..87cdefd50b 100644
--- a/git.rc.in
+++ b/git.rc.in
@@ -21,4 +21,4 @@ BEGIN
   END
 END
 
-1 RT_MANIFEST "compat/win32/git.manifest"
+1 RT_MANIFEST "lib/compat/win32/git.manifest"
diff --git a/abspath.c b/lib/abspath.c
similarity index 100%
rename from abspath.c
rename to lib/abspath.c
diff --git a/abspath.h b/lib/abspath.h
similarity index 100%
rename from abspath.h
rename to lib/abspath.h
diff --git a/add-interactive.c b/lib/add-interactive.c
similarity index 100%
rename from add-interactive.c
rename to lib/add-interactive.c
diff --git a/add-interactive.h b/lib/add-interactive.h
similarity index 100%
rename from add-interactive.h
rename to lib/add-interactive.h
diff --git a/add-patch.c b/lib/add-patch.c
similarity index 100%
rename from add-patch.c
rename to lib/add-patch.c
diff --git a/add-patch.h b/lib/add-patch.h
similarity index 100%
rename from add-patch.h
rename to lib/add-patch.h
diff --git a/advice.c b/lib/advice.c
similarity index 100%
rename from advice.c
rename to lib/advice.c
diff --git a/advice.h b/lib/advice.h
similarity index 100%
rename from advice.h
rename to lib/advice.h
diff --git a/alias.c b/lib/alias.c
similarity index 100%
rename from alias.c
rename to lib/alias.c
diff --git a/alias.h b/lib/alias.h
similarity index 100%
rename from alias.h
rename to lib/alias.h
diff --git a/alloc.c b/lib/alloc.c
similarity index 100%
rename from alloc.c
rename to lib/alloc.c
diff --git a/alloc.h b/lib/alloc.h
similarity index 100%
rename from alloc.h
rename to lib/alloc.h
diff --git a/apply.c b/lib/apply.c
similarity index 100%
rename from apply.c
rename to lib/apply.c
diff --git a/apply.h b/lib/apply.h
similarity index 100%
rename from apply.h
rename to lib/apply.h
diff --git a/archive-tar.c b/lib/archive-tar.c
similarity index 100%
rename from archive-tar.c
rename to lib/archive-tar.c
diff --git a/archive-zip.c b/lib/archive-zip.c
similarity index 100%
rename from archive-zip.c
rename to lib/archive-zip.c
diff --git a/archive.c b/lib/archive.c
similarity index 100%
rename from archive.c
rename to lib/archive.c
diff --git a/archive.h b/lib/archive.h
similarity index 100%
rename from archive.h
rename to lib/archive.h
diff --git a/attr.c b/lib/attr.c
similarity index 100%
rename from attr.c
rename to lib/attr.c
diff --git a/attr.h b/lib/attr.h
similarity index 100%
rename from attr.h
rename to lib/attr.h
diff --git a/banned.h b/lib/banned.h
similarity index 100%
rename from banned.h
rename to lib/banned.h
diff --git a/base85.c b/lib/base85.c
similarity index 100%
rename from base85.c
rename to lib/base85.c
diff --git a/base85.h b/lib/base85.h
similarity index 100%
rename from base85.h
rename to lib/base85.h
diff --git a/bisect.c b/lib/bisect.c
similarity index 100%
rename from bisect.c
rename to lib/bisect.c
diff --git a/bisect.h b/lib/bisect.h
similarity index 100%
rename from bisect.h
rename to lib/bisect.h
diff --git a/blame.c b/lib/blame.c
similarity index 100%
rename from blame.c
rename to lib/blame.c
diff --git a/blame.h b/lib/blame.h
similarity index 100%
rename from blame.h
rename to lib/blame.h
diff --git a/blob.c b/lib/blob.c
similarity index 100%
rename from blob.c
rename to lib/blob.c
diff --git a/blob.h b/lib/blob.h
similarity index 100%
rename from blob.h
rename to lib/blob.h
diff --git a/block-sha1/sha1.c b/lib/block-sha1/sha1.c
similarity index 100%
rename from block-sha1/sha1.c
rename to lib/block-sha1/sha1.c
diff --git a/block-sha1/sha1.h b/lib/block-sha1/sha1.h
similarity index 100%
rename from block-sha1/sha1.h
rename to lib/block-sha1/sha1.h
diff --git a/bloom.c b/lib/bloom.c
similarity index 100%
rename from bloom.c
rename to lib/bloom.c
diff --git a/bloom.h b/lib/bloom.h
similarity index 100%
rename from bloom.h
rename to lib/bloom.h
diff --git a/branch.c b/lib/branch.c
similarity index 100%
rename from branch.c
rename to lib/branch.c
diff --git a/branch.h b/lib/branch.h
similarity index 100%
rename from branch.h
rename to lib/branch.h
diff --git a/builtin.h b/lib/builtin.h
similarity index 100%
rename from builtin.h
rename to lib/builtin.h
diff --git a/bundle-uri.c b/lib/bundle-uri.c
similarity index 100%
rename from bundle-uri.c
rename to lib/bundle-uri.c
diff --git a/bundle-uri.h b/lib/bundle-uri.h
similarity index 100%
rename from bundle-uri.h
rename to lib/bundle-uri.h
diff --git a/bundle.c b/lib/bundle.c
similarity index 100%
rename from bundle.c
rename to lib/bundle.c
diff --git a/bundle.h b/lib/bundle.h
similarity index 100%
rename from bundle.h
rename to lib/bundle.h
diff --git a/cache-tree.c b/lib/cache-tree.c
similarity index 100%
rename from cache-tree.c
rename to lib/cache-tree.c
diff --git a/cache-tree.h b/lib/cache-tree.h
similarity index 100%
rename from cache-tree.h
rename to lib/cache-tree.h
diff --git a/cbtree.c b/lib/cbtree.c
similarity index 100%
rename from cbtree.c
rename to lib/cbtree.c
diff --git a/cbtree.h b/lib/cbtree.h
similarity index 100%
rename from cbtree.h
rename to lib/cbtree.h
diff --git a/chdir-notify.c b/lib/chdir-notify.c
similarity index 100%
rename from chdir-notify.c
rename to lib/chdir-notify.c
diff --git a/chdir-notify.h b/lib/chdir-notify.h
similarity index 100%
rename from chdir-notify.h
rename to lib/chdir-notify.h
diff --git a/checkout.c b/lib/checkout.c
similarity index 100%
rename from checkout.c
rename to lib/checkout.c
diff --git a/checkout.h b/lib/checkout.h
similarity index 100%
rename from checkout.h
rename to lib/checkout.h
diff --git a/chunk-format.c b/lib/chunk-format.c
similarity index 100%
rename from chunk-format.c
rename to lib/chunk-format.c
diff --git a/chunk-format.h b/lib/chunk-format.h
similarity index 100%
rename from chunk-format.h
rename to lib/chunk-format.h
diff --git a/color.c b/lib/color.c
similarity index 100%
rename from color.c
rename to lib/color.c
diff --git a/color.h b/lib/color.h
similarity index 100%
rename from color.h
rename to lib/color.h
diff --git a/column.c b/lib/column.c
similarity index 100%
rename from column.c
rename to lib/column.c
diff --git a/column.h b/lib/column.h
similarity index 100%
rename from column.h
rename to lib/column.h
diff --git a/combine-diff.c b/lib/combine-diff.c
similarity index 100%
rename from combine-diff.c
rename to lib/combine-diff.c
diff --git a/commit-graph.c b/lib/commit-graph.c
similarity index 100%
rename from commit-graph.c
rename to lib/commit-graph.c
diff --git a/commit-graph.h b/lib/commit-graph.h
similarity index 100%
rename from commit-graph.h
rename to lib/commit-graph.h
diff --git a/commit-reach.c b/lib/commit-reach.c
similarity index 100%
rename from commit-reach.c
rename to lib/commit-reach.c
diff --git a/commit-reach.h b/lib/commit-reach.h
similarity index 100%
rename from commit-reach.h
rename to lib/commit-reach.h
diff --git a/commit-slab-decl.h b/lib/commit-slab-decl.h
similarity index 100%
rename from commit-slab-decl.h
rename to lib/commit-slab-decl.h
diff --git a/commit-slab-impl.h b/lib/commit-slab-impl.h
similarity index 100%
rename from commit-slab-impl.h
rename to lib/commit-slab-impl.h
diff --git a/commit-slab.h b/lib/commit-slab.h
similarity index 100%
rename from commit-slab.h
rename to lib/commit-slab.h
diff --git a/commit.c b/lib/commit.c
similarity index 100%
rename from commit.c
rename to lib/commit.c
diff --git a/commit.h b/lib/commit.h
similarity index 100%
rename from commit.h
rename to lib/commit.h
diff --git a/common-exit.c b/lib/common-exit.c
similarity index 100%
rename from common-exit.c
rename to lib/common-exit.c
diff --git a/common-init.c b/lib/common-init.c
similarity index 100%
rename from common-init.c
rename to lib/common-init.c
diff --git a/common-init.h b/lib/common-init.h
similarity index 100%
rename from common-init.h
rename to lib/common-init.h
diff --git a/compat/.gitattributes b/lib/compat/.gitattributes
similarity index 100%
rename from compat/.gitattributes
rename to lib/compat/.gitattributes
diff --git a/compat/access.c b/lib/compat/access.c
similarity index 100%
rename from compat/access.c
rename to lib/compat/access.c
diff --git a/compat/apple-common-crypto.h b/lib/compat/apple-common-crypto.h
similarity index 100%
rename from compat/apple-common-crypto.h
rename to lib/compat/apple-common-crypto.h
diff --git a/compat/basename.c b/lib/compat/basename.c
similarity index 100%
rename from compat/basename.c
rename to lib/compat/basename.c
diff --git a/compat/bswap.h b/lib/compat/bswap.h
similarity index 100%
rename from compat/bswap.h
rename to lib/compat/bswap.h
diff --git a/compat/compiler.h b/lib/compat/compiler.h
similarity index 100%
rename from compat/compiler.h
rename to lib/compat/compiler.h
diff --git a/compat/darwin/procinfo.c b/lib/compat/darwin/procinfo.c
similarity index 100%
rename from compat/darwin/procinfo.c
rename to lib/compat/darwin/procinfo.c
diff --git a/compat/disk.h b/lib/compat/disk.h
similarity index 100%
rename from compat/disk.h
rename to lib/compat/disk.h
diff --git a/compat/fileno.c b/lib/compat/fileno.c
similarity index 100%
rename from compat/fileno.c
rename to lib/compat/fileno.c
diff --git a/compat/fopen.c b/lib/compat/fopen.c
similarity index 100%
rename from compat/fopen.c
rename to lib/compat/fopen.c
diff --git a/compat/fsmonitor/fsm-darwin-gcc.h b/lib/compat/fsmonitor/fsm-darwin-gcc.h
similarity index 100%
rename from compat/fsmonitor/fsm-darwin-gcc.h
rename to lib/compat/fsmonitor/fsm-darwin-gcc.h
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/lib/compat/fsmonitor/fsm-health-darwin.c
similarity index 100%
rename from compat/fsmonitor/fsm-health-darwin.c
rename to lib/compat/fsmonitor/fsm-health-darwin.c
diff --git a/compat/fsmonitor/fsm-health-linux.c b/lib/compat/fsmonitor/fsm-health-linux.c
similarity index 100%
rename from compat/fsmonitor/fsm-health-linux.c
rename to lib/compat/fsmonitor/fsm-health-linux.c
diff --git a/compat/fsmonitor/fsm-health-win32.c b/lib/compat/fsmonitor/fsm-health-win32.c
similarity index 100%
rename from compat/fsmonitor/fsm-health-win32.c
rename to lib/compat/fsmonitor/fsm-health-win32.c
diff --git a/compat/fsmonitor/fsm-health.h b/lib/compat/fsmonitor/fsm-health.h
similarity index 100%
rename from compat/fsmonitor/fsm-health.h
rename to lib/compat/fsmonitor/fsm-health.h
diff --git a/compat/fsmonitor/fsm-ipc-unix.c b/lib/compat/fsmonitor/fsm-ipc-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-ipc-unix.c
rename to lib/compat/fsmonitor/fsm-ipc-unix.c
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/lib/compat/fsmonitor/fsm-ipc-win32.c
similarity index 100%
rename from compat/fsmonitor/fsm-ipc-win32.c
rename to lib/compat/fsmonitor/fsm-ipc-win32.c
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/lib/compat/fsmonitor/fsm-listen-darwin.c
similarity index 100%
rename from compat/fsmonitor/fsm-listen-darwin.c
rename to lib/compat/fsmonitor/fsm-listen-darwin.c
diff --git a/compat/fsmonitor/fsm-listen-linux.c b/lib/compat/fsmonitor/fsm-listen-linux.c
similarity index 100%
rename from compat/fsmonitor/fsm-listen-linux.c
rename to lib/compat/fsmonitor/fsm-listen-linux.c
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/lib/compat/fsmonitor/fsm-listen-win32.c
similarity index 100%
rename from compat/fsmonitor/fsm-listen-win32.c
rename to lib/compat/fsmonitor/fsm-listen-win32.c
diff --git a/compat/fsmonitor/fsm-listen.h b/lib/compat/fsmonitor/fsm-listen.h
similarity index 100%
rename from compat/fsmonitor/fsm-listen.h
rename to lib/compat/fsmonitor/fsm-listen.h
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/lib/compat/fsmonitor/fsm-path-utils-darwin.c
similarity index 100%
rename from compat/fsmonitor/fsm-path-utils-darwin.c
rename to lib/compat/fsmonitor/fsm-path-utils-darwin.c
diff --git a/compat/fsmonitor/fsm-path-utils-linux.c b/lib/compat/fsmonitor/fsm-path-utils-linux.c
similarity index 100%
rename from compat/fsmonitor/fsm-path-utils-linux.c
rename to lib/compat/fsmonitor/fsm-path-utils-linux.c
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/lib/compat/fsmonitor/fsm-path-utils-win32.c
similarity index 100%
rename from compat/fsmonitor/fsm-path-utils-win32.c
rename to lib/compat/fsmonitor/fsm-path-utils-win32.c
diff --git a/compat/fsmonitor/fsm-settings-unix.c b/lib/compat/fsmonitor/fsm-settings-unix.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-unix.c
rename to lib/compat/fsmonitor/fsm-settings-unix.c
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/lib/compat/fsmonitor/fsm-settings-win32.c
similarity index 100%
rename from compat/fsmonitor/fsm-settings-win32.c
rename to lib/compat/fsmonitor/fsm-settings-win32.c
diff --git a/compat/hstrerror.c b/lib/compat/hstrerror.c
similarity index 100%
rename from compat/hstrerror.c
rename to lib/compat/hstrerror.c
diff --git a/compat/inet_ntop.c b/lib/compat/inet_ntop.c
similarity index 100%
rename from compat/inet_ntop.c
rename to lib/compat/inet_ntop.c
diff --git a/compat/inet_pton.c b/lib/compat/inet_pton.c
similarity index 100%
rename from compat/inet_pton.c
rename to lib/compat/inet_pton.c
diff --git a/compat/linux/procinfo.c b/lib/compat/linux/procinfo.c
similarity index 100%
rename from compat/linux/procinfo.c
rename to lib/compat/linux/procinfo.c
diff --git a/compat/memmem.c b/lib/compat/memmem.c
similarity index 100%
rename from compat/memmem.c
rename to lib/compat/memmem.c
diff --git a/compat/mingw-posix.h b/lib/compat/mingw-posix.h
similarity index 100%
rename from compat/mingw-posix.h
rename to lib/compat/mingw-posix.h
diff --git a/compat/mingw.c b/lib/compat/mingw.c
similarity index 100%
rename from compat/mingw.c
rename to lib/compat/mingw.c
diff --git a/compat/mingw.h b/lib/compat/mingw.h
similarity index 100%
rename from compat/mingw.h
rename to lib/compat/mingw.h
diff --git a/compat/mkdir.c b/lib/compat/mkdir.c
similarity index 100%
rename from compat/mkdir.c
rename to lib/compat/mkdir.c
diff --git a/compat/mmap.c b/lib/compat/mmap.c
similarity index 100%
rename from compat/mmap.c
rename to lib/compat/mmap.c
diff --git a/compat/msvc-posix.h b/lib/compat/msvc-posix.h
similarity index 100%
rename from compat/msvc-posix.h
rename to lib/compat/msvc-posix.h
diff --git a/compat/msvc.c b/lib/compat/msvc.c
similarity index 100%
rename from compat/msvc.c
rename to lib/compat/msvc.c
diff --git a/compat/msvc.h b/lib/compat/msvc.h
similarity index 100%
rename from compat/msvc.h
rename to lib/compat/msvc.h
diff --git a/compat/nonblock.c b/lib/compat/nonblock.c
similarity index 100%
rename from compat/nonblock.c
rename to lib/compat/nonblock.c
diff --git a/compat/nonblock.h b/lib/compat/nonblock.h
similarity index 100%
rename from compat/nonblock.h
rename to lib/compat/nonblock.h
diff --git a/compat/obstack.c b/lib/compat/obstack.c
similarity index 100%
rename from compat/obstack.c
rename to lib/compat/obstack.c
diff --git a/compat/obstack.h b/lib/compat/obstack.h
similarity index 100%
rename from compat/obstack.h
rename to lib/compat/obstack.h
diff --git a/compat/open.c b/lib/compat/open.c
similarity index 100%
rename from compat/open.c
rename to lib/compat/open.c
diff --git a/compat/poll/poll.c b/lib/compat/poll/poll.c
similarity index 100%
rename from compat/poll/poll.c
rename to lib/compat/poll/poll.c
diff --git a/compat/poll/poll.h b/lib/compat/poll/poll.h
similarity index 100%
rename from compat/poll/poll.h
rename to lib/compat/poll/poll.h
diff --git a/compat/posix.h b/lib/compat/posix.h
similarity index 100%
rename from compat/posix.h
rename to lib/compat/posix.h
diff --git a/compat/pread.c b/lib/compat/pread.c
similarity index 100%
rename from compat/pread.c
rename to lib/compat/pread.c
diff --git a/compat/precompose_utf8.c b/lib/compat/precompose_utf8.c
similarity index 100%
rename from compat/precompose_utf8.c
rename to lib/compat/precompose_utf8.c
diff --git a/compat/precompose_utf8.h b/lib/compat/precompose_utf8.h
similarity index 100%
rename from compat/precompose_utf8.h
rename to lib/compat/precompose_utf8.h
diff --git a/compat/qsort_s.c b/lib/compat/qsort_s.c
similarity index 100%
rename from compat/qsort_s.c
rename to lib/compat/qsort_s.c
diff --git a/compat/regcomp_enhanced.c b/lib/compat/regcomp_enhanced.c
similarity index 100%
rename from compat/regcomp_enhanced.c
rename to lib/compat/regcomp_enhanced.c
diff --git a/compat/regex/regcomp.c b/lib/compat/regex/regcomp.c
similarity index 100%
rename from compat/regex/regcomp.c
rename to lib/compat/regex/regcomp.c
diff --git a/compat/regex/regex.c b/lib/compat/regex/regex.c
similarity index 100%
rename from compat/regex/regex.c
rename to lib/compat/regex/regex.c
diff --git a/compat/regex/regex.h b/lib/compat/regex/regex.h
similarity index 100%
rename from compat/regex/regex.h
rename to lib/compat/regex/regex.h
diff --git a/compat/regex/regex_internal.c b/lib/compat/regex/regex_internal.c
similarity index 100%
rename from compat/regex/regex_internal.c
rename to lib/compat/regex/regex_internal.c
diff --git a/compat/regex/regex_internal.h b/lib/compat/regex/regex_internal.h
similarity index 100%
rename from compat/regex/regex_internal.h
rename to lib/compat/regex/regex_internal.h
diff --git a/compat/regex/regexec.c b/lib/compat/regex/regexec.c
similarity index 100%
rename from compat/regex/regexec.c
rename to lib/compat/regex/regexec.c
diff --git a/compat/setenv.c b/lib/compat/setenv.c
similarity index 100%
rename from compat/setenv.c
rename to lib/compat/setenv.c
diff --git a/compat/sha1-chunked.c b/lib/compat/sha1-chunked.c
similarity index 100%
rename from compat/sha1-chunked.c
rename to lib/compat/sha1-chunked.c
diff --git a/compat/sha1-chunked.h b/lib/compat/sha1-chunked.h
similarity index 100%
rename from compat/sha1-chunked.h
rename to lib/compat/sha1-chunked.h
diff --git a/compat/simple-ipc/ipc-shared.c b/lib/compat/simple-ipc/ipc-shared.c
similarity index 100%
rename from compat/simple-ipc/ipc-shared.c
rename to lib/compat/simple-ipc/ipc-shared.c
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/lib/compat/simple-ipc/ipc-unix-socket.c
similarity index 100%
rename from compat/simple-ipc/ipc-unix-socket.c
rename to lib/compat/simple-ipc/ipc-unix-socket.c
diff --git a/compat/simple-ipc/ipc-win32.c b/lib/compat/simple-ipc/ipc-win32.c
similarity index 100%
rename from compat/simple-ipc/ipc-win32.c
rename to lib/compat/simple-ipc/ipc-win32.c
diff --git a/compat/snprintf.c b/lib/compat/snprintf.c
similarity index 100%
rename from compat/snprintf.c
rename to lib/compat/snprintf.c
diff --git a/compat/stat.c b/lib/compat/stat.c
similarity index 100%
rename from compat/stat.c
rename to lib/compat/stat.c
diff --git a/compat/strcasestr.c b/lib/compat/strcasestr.c
similarity index 100%
rename from compat/strcasestr.c
rename to lib/compat/strcasestr.c
diff --git a/compat/strdup.c b/lib/compat/strdup.c
similarity index 100%
rename from compat/strdup.c
rename to lib/compat/strdup.c
diff --git a/compat/strlcpy.c b/lib/compat/strlcpy.c
similarity index 100%
rename from compat/strlcpy.c
rename to lib/compat/strlcpy.c
diff --git a/compat/strtoimax.c b/lib/compat/strtoimax.c
similarity index 100%
rename from compat/strtoimax.c
rename to lib/compat/strtoimax.c
diff --git a/compat/strtoumax.c b/lib/compat/strtoumax.c
similarity index 100%
rename from compat/strtoumax.c
rename to lib/compat/strtoumax.c
diff --git a/compat/stub/procinfo.c b/lib/compat/stub/procinfo.c
similarity index 100%
rename from compat/stub/procinfo.c
rename to lib/compat/stub/procinfo.c
diff --git a/compat/terminal.c b/lib/compat/terminal.c
similarity index 100%
rename from compat/terminal.c
rename to lib/compat/terminal.c
diff --git a/compat/terminal.h b/lib/compat/terminal.h
similarity index 100%
rename from compat/terminal.h
rename to lib/compat/terminal.h
diff --git a/compat/unsetenv.c b/lib/compat/unsetenv.c
similarity index 100%
rename from compat/unsetenv.c
rename to lib/compat/unsetenv.c
diff --git a/compat/vcbuild/.gitignore b/lib/compat/vcbuild/.gitignore
similarity index 100%
rename from compat/vcbuild/.gitignore
rename to lib/compat/vcbuild/.gitignore
diff --git a/compat/vcbuild/README b/lib/compat/vcbuild/README
similarity index 94%
rename from compat/vcbuild/README
rename to lib/compat/vcbuild/README
index 29ec1d0f10..63ee00a4ef 100644
--- a/compat/vcbuild/README
+++ b/lib/compat/vcbuild/README
@@ -6,17 +6,17 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
    Prompt or from an SDK bash window:
 
    $ cd <repo_root>
-   $ ./compat/vcbuild/vcpkg_install.bat
+   $ ./lib/compat/vcbuild/vcpkg_install.bat
 
    The vcpkg tools and all of the third-party sources will be installed
    in this folder:
-      <repo_root>/compat/vcbuild/vcpkg/
+      <repo_root>/lib/compat/vcbuild/vcpkg/
 
    A file will be created with a set of Makefile macros pointing to a
    unified "include", "lib", and "bin" directory (release and debug) for
    all of the required packages.  This file will be included by the main
    Makefile:
-      <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
+      <repo_root>/lib/compat/vcbuild/MSVC-DEFS-GEN
 
 2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
    root to make it easier to run and debug git.exe without having to
@@ -26,8 +26,8 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
    Use ONE of the following forms which should match how you want to
    compile git.exe.
 
-   $ ./compat/vcbuild/vcpkg_copy_dlls.bat debug
-   $ ./compat/vcbuild/vcpkg_copy_dlls.bat release
+   $ ./lib/compat/vcbuild/vcpkg_copy_dlls.bat debug
+   $ ./lib/compat/vcbuild/vcpkg_copy_dlls.bat release
 
 3. Build git using MSVC from an SDK bash window using one of the
    following commands:
diff --git a/compat/vcbuild/find_vs_env.bat b/lib/compat/vcbuild/find_vs_env.bat
similarity index 98%
rename from compat/vcbuild/find_vs_env.bat
rename to lib/compat/vcbuild/find_vs_env.bat
index b35d264c0e..30e884b3d7 100644
--- a/compat/vcbuild/find_vs_env.bat
+++ b/lib/compat/vcbuild/find_vs_env.bat
@@ -25,7 +25,7 @@ REM
 REM The output of this script should be written to a make "include
 REM file" and referenced by the top-level Makefile.
 REM
-REM See "config.mak.uname" (look for compat/vcbuild/MSVC-DEFS-GEN).
+REM See "config.mak.uname" (look for lib/compat/vcbuild/MSVC-DEFS-GEN).
 REM ================================================================
 REM The provided command prompts are custom to each VS release and
 REM filled with lots of internal knowledge (such as Registry settings);
diff --git a/compat/vcbuild/include/sys/param.h b/lib/compat/vcbuild/include/sys/param.h
similarity index 100%
rename from compat/vcbuild/include/sys/param.h
rename to lib/compat/vcbuild/include/sys/param.h
diff --git a/compat/vcbuild/include/sys/time.h b/lib/compat/vcbuild/include/sys/time.h
similarity index 100%
rename from compat/vcbuild/include/sys/time.h
rename to lib/compat/vcbuild/include/sys/time.h
diff --git a/compat/vcbuild/include/sys/utime.h b/lib/compat/vcbuild/include/sys/utime.h
similarity index 100%
rename from compat/vcbuild/include/sys/utime.h
rename to lib/compat/vcbuild/include/sys/utime.h
diff --git a/compat/vcbuild/include/unistd.h b/lib/compat/vcbuild/include/unistd.h
similarity index 100%
rename from compat/vcbuild/include/unistd.h
rename to lib/compat/vcbuild/include/unistd.h
diff --git a/compat/vcbuild/include/utime.h b/lib/compat/vcbuild/include/utime.h
similarity index 100%
rename from compat/vcbuild/include/utime.h
rename to lib/compat/vcbuild/include/utime.h
diff --git a/compat/vcbuild/scripts/clink.pl b/lib/compat/vcbuild/scripts/clink.pl
similarity index 100%
rename from compat/vcbuild/scripts/clink.pl
rename to lib/compat/vcbuild/scripts/clink.pl
diff --git a/compat/vcbuild/scripts/lib.pl b/lib/compat/vcbuild/scripts/lib.pl
similarity index 100%
rename from compat/vcbuild/scripts/lib.pl
rename to lib/compat/vcbuild/scripts/lib.pl
diff --git a/compat/vcbuild/vcpkg_copy_dlls.bat b/lib/compat/vcbuild/vcpkg_copy_dlls.bat
similarity index 100%
rename from compat/vcbuild/vcpkg_copy_dlls.bat
rename to lib/compat/vcbuild/vcpkg_copy_dlls.bat
diff --git a/compat/vcbuild/vcpkg_install.bat b/lib/compat/vcbuild/vcpkg_install.bat
similarity index 95%
rename from compat/vcbuild/vcpkg_install.bat
rename to lib/compat/vcbuild/vcpkg_install.bat
index ebd0bad242..64c1b199e0 100644
--- a/compat/vcbuild/vcpkg_install.bat
+++ b/lib/compat/vcbuild/vcpkg_install.bat
@@ -5,10 +5,10 @@ REM it to build the third-party libraries that git requires when it
 REM is built using MSVC.
 REM
 REM [1] Install VCPKG.
-REM     [a] Create <root>/compat/vcbuild/vcpkg/
+REM     [a] Create <root>/lib/compat/vcbuild/vcpkg/
 REM     [b] Download "vcpkg".
 REM     [c] Compile using the currently installed version of VS.
-REM     [d] Create <root>/compat/vcbuild/vcpkg/vcpkg.exe
+REM     [d] Create <root>/lib/compat/vcbuild/vcpkg/vcpkg.exe
 REM
 REM [2] Install third-party libraries.
 REM     [a] Download each (which may also install CMAKE).
diff --git a/compat/win32.h b/lib/compat/win32.h
similarity index 100%
rename from compat/win32.h
rename to lib/compat/win32.h
diff --git a/compat/win32/alloca.h b/lib/compat/win32/alloca.h
similarity index 100%
rename from compat/win32/alloca.h
rename to lib/compat/win32/alloca.h
diff --git a/compat/win32/dirent.c b/lib/compat/win32/dirent.c
similarity index 100%
rename from compat/win32/dirent.c
rename to lib/compat/win32/dirent.c
diff --git a/compat/win32/dirent.h b/lib/compat/win32/dirent.h
similarity index 100%
rename from compat/win32/dirent.h
rename to lib/compat/win32/dirent.h
diff --git a/compat/win32/exit-process.h b/lib/compat/win32/exit-process.h
similarity index 100%
rename from compat/win32/exit-process.h
rename to lib/compat/win32/exit-process.h
diff --git a/compat/win32/flush.c b/lib/compat/win32/flush.c
similarity index 100%
rename from compat/win32/flush.c
rename to lib/compat/win32/flush.c
diff --git a/compat/win32/git.manifest b/lib/compat/win32/git.manifest
similarity index 100%
rename from compat/win32/git.manifest
rename to lib/compat/win32/git.manifest
diff --git a/compat/win32/headless.c b/lib/compat/win32/headless.c
similarity index 100%
rename from compat/win32/headless.c
rename to lib/compat/win32/headless.c
diff --git a/compat/win32/lazyload.h b/lib/compat/win32/lazyload.h
similarity index 100%
rename from compat/win32/lazyload.h
rename to lib/compat/win32/lazyload.h
diff --git a/compat/win32/path-utils.c b/lib/compat/win32/path-utils.c
similarity index 100%
rename from compat/win32/path-utils.c
rename to lib/compat/win32/path-utils.c
diff --git a/compat/win32/path-utils.h b/lib/compat/win32/path-utils.h
similarity index 100%
rename from compat/win32/path-utils.h
rename to lib/compat/win32/path-utils.h
diff --git a/compat/win32/pthread.c b/lib/compat/win32/pthread.c
similarity index 100%
rename from compat/win32/pthread.c
rename to lib/compat/win32/pthread.c
diff --git a/compat/win32/pthread.h b/lib/compat/win32/pthread.h
similarity index 100%
rename from compat/win32/pthread.h
rename to lib/compat/win32/pthread.h
diff --git a/compat/win32/syslog.c b/lib/compat/win32/syslog.c
similarity index 100%
rename from compat/win32/syslog.c
rename to lib/compat/win32/syslog.c
diff --git a/compat/win32/syslog.h b/lib/compat/win32/syslog.h
similarity index 100%
rename from compat/win32/syslog.h
rename to lib/compat/win32/syslog.h
diff --git a/compat/win32/trace2_win32_process_info.c b/lib/compat/win32/trace2_win32_process_info.c
similarity index 100%
rename from compat/win32/trace2_win32_process_info.c
rename to lib/compat/win32/trace2_win32_process_info.c
diff --git a/compat/win32mmap.c b/lib/compat/win32mmap.c
similarity index 100%
rename from compat/win32mmap.c
rename to lib/compat/win32mmap.c
diff --git a/compat/winansi.c b/lib/compat/winansi.c
similarity index 100%
rename from compat/winansi.c
rename to lib/compat/winansi.c
diff --git a/compat/zlib-compat.h b/lib/compat/zlib-compat.h
similarity index 100%
rename from compat/zlib-compat.h
rename to lib/compat/zlib-compat.h
diff --git a/compiler-tricks/not-constant.c b/lib/compiler-tricks/not-constant.c
similarity index 100%
rename from compiler-tricks/not-constant.c
rename to lib/compiler-tricks/not-constant.c
diff --git a/config.c b/lib/config.c
similarity index 100%
rename from config.c
rename to lib/config.c
diff --git a/config.h b/lib/config.h
similarity index 100%
rename from config.h
rename to lib/config.h
diff --git a/connect.c b/lib/connect.c
similarity index 100%
rename from connect.c
rename to lib/connect.c
diff --git a/connect.h b/lib/connect.h
similarity index 100%
rename from connect.h
rename to lib/connect.h
diff --git a/connected.c b/lib/connected.c
similarity index 100%
rename from connected.c
rename to lib/connected.c
diff --git a/connected.h b/lib/connected.h
similarity index 100%
rename from connected.h
rename to lib/connected.h
diff --git a/convert.c b/lib/convert.c
similarity index 100%
rename from convert.c
rename to lib/convert.c
diff --git a/convert.h b/lib/convert.h
similarity index 100%
rename from convert.h
rename to lib/convert.h
diff --git a/copy.c b/lib/copy.c
similarity index 100%
rename from copy.c
rename to lib/copy.c
diff --git a/copy.h b/lib/copy.h
similarity index 100%
rename from copy.h
rename to lib/copy.h
diff --git a/credential.c b/lib/credential.c
similarity index 100%
rename from credential.c
rename to lib/credential.c
diff --git a/credential.h b/lib/credential.h
similarity index 100%
rename from credential.h
rename to lib/credential.h
diff --git a/csum-file.c b/lib/csum-file.c
similarity index 100%
rename from csum-file.c
rename to lib/csum-file.c
diff --git a/csum-file.h b/lib/csum-file.h
similarity index 100%
rename from csum-file.h
rename to lib/csum-file.h
diff --git a/ctype.c b/lib/ctype.c
similarity index 100%
rename from ctype.c
rename to lib/ctype.c
diff --git a/date.c b/lib/date.c
similarity index 100%
rename from date.c
rename to lib/date.c
diff --git a/date.h b/lib/date.h
similarity index 100%
rename from date.h
rename to lib/date.h
diff --git a/decorate.c b/lib/decorate.c
similarity index 100%
rename from decorate.c
rename to lib/decorate.c
diff --git a/decorate.h b/lib/decorate.h
similarity index 100%
rename from decorate.h
rename to lib/decorate.h
diff --git a/delta-islands.c b/lib/delta-islands.c
similarity index 100%
rename from delta-islands.c
rename to lib/delta-islands.c
diff --git a/delta-islands.h b/lib/delta-islands.h
similarity index 100%
rename from delta-islands.h
rename to lib/delta-islands.h
diff --git a/delta.h b/lib/delta.h
similarity index 100%
rename from delta.h
rename to lib/delta.h
diff --git a/diagnose.c b/lib/diagnose.c
similarity index 100%
rename from diagnose.c
rename to lib/diagnose.c
diff --git a/diagnose.h b/lib/diagnose.h
similarity index 100%
rename from diagnose.h
rename to lib/diagnose.h
diff --git a/diff-delta.c b/lib/diff-delta.c
similarity index 100%
rename from diff-delta.c
rename to lib/diff-delta.c
diff --git a/diff-lib.c b/lib/diff-lib.c
similarity index 100%
rename from diff-lib.c
rename to lib/diff-lib.c
diff --git a/diff-merges.c b/lib/diff-merges.c
similarity index 100%
rename from diff-merges.c
rename to lib/diff-merges.c
diff --git a/diff-merges.h b/lib/diff-merges.h
similarity index 100%
rename from diff-merges.h
rename to lib/diff-merges.h
diff --git a/diff-no-index.c b/lib/diff-no-index.c
similarity index 100%
rename from diff-no-index.c
rename to lib/diff-no-index.c
diff --git a/diff.c b/lib/diff.c
similarity index 100%
rename from diff.c
rename to lib/diff.c
diff --git a/diff.h b/lib/diff.h
similarity index 100%
rename from diff.h
rename to lib/diff.h
diff --git a/diffcore-break.c b/lib/diffcore-break.c
similarity index 100%
rename from diffcore-break.c
rename to lib/diffcore-break.c
diff --git a/diffcore-delta.c b/lib/diffcore-delta.c
similarity index 100%
rename from diffcore-delta.c
rename to lib/diffcore-delta.c
diff --git a/diffcore-order.c b/lib/diffcore-order.c
similarity index 100%
rename from diffcore-order.c
rename to lib/diffcore-order.c
diff --git a/diffcore-pickaxe.c b/lib/diffcore-pickaxe.c
similarity index 100%
rename from diffcore-pickaxe.c
rename to lib/diffcore-pickaxe.c
diff --git a/diffcore-rename.c b/lib/diffcore-rename.c
similarity index 100%
rename from diffcore-rename.c
rename to lib/diffcore-rename.c
diff --git a/diffcore-rotate.c b/lib/diffcore-rotate.c
similarity index 100%
rename from diffcore-rotate.c
rename to lib/diffcore-rotate.c
diff --git a/diffcore.h b/lib/diffcore.h
similarity index 100%
rename from diffcore.h
rename to lib/diffcore.h
diff --git a/dir-iterator.c b/lib/dir-iterator.c
similarity index 100%
rename from dir-iterator.c
rename to lib/dir-iterator.c
diff --git a/dir-iterator.h b/lib/dir-iterator.h
similarity index 100%
rename from dir-iterator.h
rename to lib/dir-iterator.h
diff --git a/dir.c b/lib/dir.c
similarity index 100%
rename from dir.c
rename to lib/dir.c
diff --git a/dir.h b/lib/dir.h
similarity index 100%
rename from dir.h
rename to lib/dir.h
diff --git a/editor.c b/lib/editor.c
similarity index 100%
rename from editor.c
rename to lib/editor.c
diff --git a/editor.h b/lib/editor.h
similarity index 100%
rename from editor.h
rename to lib/editor.h
diff --git a/entry.c b/lib/entry.c
similarity index 100%
rename from entry.c
rename to lib/entry.c
diff --git a/entry.h b/lib/entry.h
similarity index 100%
rename from entry.h
rename to lib/entry.h
diff --git a/environment.c b/lib/environment.c
similarity index 100%
rename from environment.c
rename to lib/environment.c
diff --git a/environment.h b/lib/environment.h
similarity index 100%
rename from environment.h
rename to lib/environment.h
diff --git a/ewah/bitmap.c b/lib/ewah/bitmap.c
similarity index 100%
rename from ewah/bitmap.c
rename to lib/ewah/bitmap.c
diff --git a/ewah/ewah_bitmap.c b/lib/ewah/ewah_bitmap.c
similarity index 100%
rename from ewah/ewah_bitmap.c
rename to lib/ewah/ewah_bitmap.c
diff --git a/ewah/ewah_io.c b/lib/ewah/ewah_io.c
similarity index 100%
rename from ewah/ewah_io.c
rename to lib/ewah/ewah_io.c
diff --git a/ewah/ewah_rlw.c b/lib/ewah/ewah_rlw.c
similarity index 100%
rename from ewah/ewah_rlw.c
rename to lib/ewah/ewah_rlw.c
diff --git a/ewah/ewok.h b/lib/ewah/ewok.h
similarity index 100%
rename from ewah/ewok.h
rename to lib/ewah/ewok.h
diff --git a/ewah/ewok_rlw.h b/lib/ewah/ewok_rlw.h
similarity index 100%
rename from ewah/ewok_rlw.h
rename to lib/ewah/ewok_rlw.h
diff --git a/exec-cmd.c b/lib/exec-cmd.c
similarity index 100%
rename from exec-cmd.c
rename to lib/exec-cmd.c
diff --git a/exec-cmd.h b/lib/exec-cmd.h
similarity index 100%
rename from exec-cmd.h
rename to lib/exec-cmd.h
diff --git a/fetch-negotiator.c b/lib/fetch-negotiator.c
similarity index 100%
rename from fetch-negotiator.c
rename to lib/fetch-negotiator.c
diff --git a/fetch-negotiator.h b/lib/fetch-negotiator.h
similarity index 100%
rename from fetch-negotiator.h
rename to lib/fetch-negotiator.h
diff --git a/fetch-pack.c b/lib/fetch-pack.c
similarity index 100%
rename from fetch-pack.c
rename to lib/fetch-pack.c
diff --git a/fetch-pack.h b/lib/fetch-pack.h
similarity index 100%
rename from fetch-pack.h
rename to lib/fetch-pack.h
diff --git a/fmt-merge-msg.c b/lib/fmt-merge-msg.c
similarity index 100%
rename from fmt-merge-msg.c
rename to lib/fmt-merge-msg.c
diff --git a/fmt-merge-msg.h b/lib/fmt-merge-msg.h
similarity index 100%
rename from fmt-merge-msg.h
rename to lib/fmt-merge-msg.h
diff --git a/for-each-ref.h b/lib/for-each-ref.h
similarity index 100%
rename from for-each-ref.h
rename to lib/for-each-ref.h
diff --git a/fsck.c b/lib/fsck.c
similarity index 100%
rename from fsck.c
rename to lib/fsck.c
diff --git a/fsck.h b/lib/fsck.h
similarity index 100%
rename from fsck.h
rename to lib/fsck.h
diff --git a/fsmonitor--daemon.h b/lib/fsmonitor--daemon.h
similarity index 100%
rename from fsmonitor--daemon.h
rename to lib/fsmonitor--daemon.h
diff --git a/fsmonitor-ipc.c b/lib/fsmonitor-ipc.c
similarity index 100%
rename from fsmonitor-ipc.c
rename to lib/fsmonitor-ipc.c
diff --git a/fsmonitor-ipc.h b/lib/fsmonitor-ipc.h
similarity index 100%
rename from fsmonitor-ipc.h
rename to lib/fsmonitor-ipc.h
diff --git a/fsmonitor-ll.h b/lib/fsmonitor-ll.h
similarity index 100%
rename from fsmonitor-ll.h
rename to lib/fsmonitor-ll.h
diff --git a/fsmonitor-path-utils.h b/lib/fsmonitor-path-utils.h
similarity index 100%
rename from fsmonitor-path-utils.h
rename to lib/fsmonitor-path-utils.h
diff --git a/fsmonitor-settings.c b/lib/fsmonitor-settings.c
similarity index 100%
rename from fsmonitor-settings.c
rename to lib/fsmonitor-settings.c
diff --git a/fsmonitor-settings.h b/lib/fsmonitor-settings.h
similarity index 100%
rename from fsmonitor-settings.h
rename to lib/fsmonitor-settings.h
diff --git a/fsmonitor.c b/lib/fsmonitor.c
similarity index 100%
rename from fsmonitor.c
rename to lib/fsmonitor.c
diff --git a/fsmonitor.h b/lib/fsmonitor.h
similarity index 100%
rename from fsmonitor.h
rename to lib/fsmonitor.h
diff --git a/gettext.c b/lib/gettext.c
similarity index 100%
rename from gettext.c
rename to lib/gettext.c
diff --git a/gettext.h b/lib/gettext.h
similarity index 100%
rename from gettext.h
rename to lib/gettext.h
diff --git a/git-compat-util.h b/lib/git-compat-util.h
similarity index 100%
rename from git-compat-util.h
rename to lib/git-compat-util.h
diff --git a/git-curl-compat.h b/lib/git-curl-compat.h
similarity index 100%
rename from git-curl-compat.h
rename to lib/git-curl-compat.h
diff --git a/git-zlib.c b/lib/git-zlib.c
similarity index 100%
rename from git-zlib.c
rename to lib/git-zlib.c
diff --git a/git-zlib.h b/lib/git-zlib.h
similarity index 100%
rename from git-zlib.h
rename to lib/git-zlib.h
diff --git a/gpg-interface.c b/lib/gpg-interface.c
similarity index 100%
rename from gpg-interface.c
rename to lib/gpg-interface.c
diff --git a/gpg-interface.h b/lib/gpg-interface.h
similarity index 100%
rename from gpg-interface.h
rename to lib/gpg-interface.h
diff --git a/graph.c b/lib/graph.c
similarity index 100%
rename from graph.c
rename to lib/graph.c
diff --git a/graph.h b/lib/graph.h
similarity index 100%
rename from graph.h
rename to lib/graph.h
diff --git a/grep.c b/lib/grep.c
similarity index 100%
rename from grep.c
rename to lib/grep.c
diff --git a/grep.h b/lib/grep.h
similarity index 100%
rename from grep.h
rename to lib/grep.h
diff --git a/hash-lookup.c b/lib/hash-lookup.c
similarity index 100%
rename from hash-lookup.c
rename to lib/hash-lookup.c
diff --git a/hash-lookup.h b/lib/hash-lookup.h
similarity index 100%
rename from hash-lookup.h
rename to lib/hash-lookup.h
diff --git a/hash.c b/lib/hash.c
similarity index 100%
rename from hash.c
rename to lib/hash.c
diff --git a/hash.h b/lib/hash.h
similarity index 100%
rename from hash.h
rename to lib/hash.h
diff --git a/hashmap.c b/lib/hashmap.c
similarity index 100%
rename from hashmap.c
rename to lib/hashmap.c
diff --git a/hashmap.h b/lib/hashmap.h
similarity index 100%
rename from hashmap.h
rename to lib/hashmap.h
diff --git a/help.c b/lib/help.c
similarity index 100%
rename from help.c
rename to lib/help.c
diff --git a/help.h b/lib/help.h
similarity index 100%
rename from help.h
rename to lib/help.h
diff --git a/hex-ll.c b/lib/hex-ll.c
similarity index 100%
rename from hex-ll.c
rename to lib/hex-ll.c
diff --git a/hex-ll.h b/lib/hex-ll.h
similarity index 100%
rename from hex-ll.h
rename to lib/hex-ll.h
diff --git a/hex.c b/lib/hex.c
similarity index 100%
rename from hex.c
rename to lib/hex.c
diff --git a/hex.h b/lib/hex.h
similarity index 100%
rename from hex.h
rename to lib/hex.h
diff --git a/hook.c b/lib/hook.c
similarity index 100%
rename from hook.c
rename to lib/hook.c
diff --git a/hook.h b/lib/hook.h
similarity index 100%
rename from hook.h
rename to lib/hook.h
diff --git a/http-walker.c b/lib/http-walker.c
similarity index 100%
rename from http-walker.c
rename to lib/http-walker.c
diff --git a/http.c b/lib/http.c
similarity index 100%
rename from http.c
rename to lib/http.c
diff --git a/http.h b/lib/http.h
similarity index 100%
rename from http.h
rename to lib/http.h
diff --git a/ident.c b/lib/ident.c
similarity index 100%
rename from ident.c
rename to lib/ident.c
diff --git a/ident.h b/lib/ident.h
similarity index 100%
rename from ident.h
rename to lib/ident.h
diff --git a/iterator.h b/lib/iterator.h
similarity index 100%
rename from iterator.h
rename to lib/iterator.h
diff --git a/json-writer.c b/lib/json-writer.c
similarity index 100%
rename from json-writer.c
rename to lib/json-writer.c
diff --git a/json-writer.h b/lib/json-writer.h
similarity index 100%
rename from json-writer.h
rename to lib/json-writer.h
diff --git a/khash.h b/lib/khash.h
similarity index 100%
rename from khash.h
rename to lib/khash.h
diff --git a/kwset.c b/lib/kwset.c
similarity index 100%
rename from kwset.c
rename to lib/kwset.c
diff --git a/kwset.h b/lib/kwset.h
similarity index 100%
rename from kwset.h
rename to lib/kwset.h
diff --git a/levenshtein.c b/lib/levenshtein.c
similarity index 100%
rename from levenshtein.c
rename to lib/levenshtein.c
diff --git a/levenshtein.h b/lib/levenshtein.h
similarity index 100%
rename from levenshtein.h
rename to lib/levenshtein.h
diff --git a/line-log.c b/lib/line-log.c
similarity index 100%
rename from line-log.c
rename to lib/line-log.c
diff --git a/line-log.h b/lib/line-log.h
similarity index 100%
rename from line-log.h
rename to lib/line-log.h
diff --git a/line-range.c b/lib/line-range.c
similarity index 100%
rename from line-range.c
rename to lib/line-range.c
diff --git a/line-range.h b/lib/line-range.h
similarity index 100%
rename from line-range.h
rename to lib/line-range.h
diff --git a/linear-assignment.c b/lib/linear-assignment.c
similarity index 100%
rename from linear-assignment.c
rename to lib/linear-assignment.c
diff --git a/linear-assignment.h b/lib/linear-assignment.h
similarity index 100%
rename from linear-assignment.h
rename to lib/linear-assignment.h
diff --git a/list-objects-filter-options.c b/lib/list-objects-filter-options.c
similarity index 100%
rename from list-objects-filter-options.c
rename to lib/list-objects-filter-options.c
diff --git a/list-objects-filter-options.h b/lib/list-objects-filter-options.h
similarity index 100%
rename from list-objects-filter-options.h
rename to lib/list-objects-filter-options.h
diff --git a/list-objects-filter.c b/lib/list-objects-filter.c
similarity index 100%
rename from list-objects-filter.c
rename to lib/list-objects-filter.c
diff --git a/list-objects-filter.h b/lib/list-objects-filter.h
similarity index 100%
rename from list-objects-filter.h
rename to lib/list-objects-filter.h
diff --git a/list-objects.c b/lib/list-objects.c
similarity index 100%
rename from list-objects.c
rename to lib/list-objects.c
diff --git a/list-objects.h b/lib/list-objects.h
similarity index 100%
rename from list-objects.h
rename to lib/list-objects.h
diff --git a/list.h b/lib/list.h
similarity index 100%
rename from list.h
rename to lib/list.h
diff --git a/lockfile.c b/lib/lockfile.c
similarity index 100%
rename from lockfile.c
rename to lib/lockfile.c
diff --git a/lockfile.h b/lib/lockfile.h
similarity index 100%
rename from lockfile.h
rename to lib/lockfile.h
diff --git a/log-tree.c b/lib/log-tree.c
similarity index 100%
rename from log-tree.c
rename to lib/log-tree.c
diff --git a/log-tree.h b/lib/log-tree.h
similarity index 100%
rename from log-tree.h
rename to lib/log-tree.h
diff --git a/loose.c b/lib/loose.c
similarity index 100%
rename from loose.c
rename to lib/loose.c
diff --git a/loose.h b/lib/loose.h
similarity index 100%
rename from loose.h
rename to lib/loose.h
diff --git a/ls-refs.c b/lib/ls-refs.c
similarity index 100%
rename from ls-refs.c
rename to lib/ls-refs.c
diff --git a/ls-refs.h b/lib/ls-refs.h
similarity index 100%
rename from ls-refs.h
rename to lib/ls-refs.h
diff --git a/mailinfo.c b/lib/mailinfo.c
similarity index 100%
rename from mailinfo.c
rename to lib/mailinfo.c
diff --git a/mailinfo.h b/lib/mailinfo.h
similarity index 100%
rename from mailinfo.h
rename to lib/mailinfo.h
diff --git a/mailmap.c b/lib/mailmap.c
similarity index 100%
rename from mailmap.c
rename to lib/mailmap.c
diff --git a/mailmap.h b/lib/mailmap.h
similarity index 100%
rename from mailmap.h
rename to lib/mailmap.h
diff --git a/match-trees.c b/lib/match-trees.c
similarity index 100%
rename from match-trees.c
rename to lib/match-trees.c
diff --git a/match-trees.h b/lib/match-trees.h
similarity index 100%
rename from match-trees.h
rename to lib/match-trees.h
diff --git a/mem-pool.c b/lib/mem-pool.c
similarity index 100%
rename from mem-pool.c
rename to lib/mem-pool.c
diff --git a/mem-pool.h b/lib/mem-pool.h
similarity index 100%
rename from mem-pool.h
rename to lib/mem-pool.h
diff --git a/merge-blobs.c b/lib/merge-blobs.c
similarity index 100%
rename from merge-blobs.c
rename to lib/merge-blobs.c
diff --git a/merge-blobs.h b/lib/merge-blobs.h
similarity index 100%
rename from merge-blobs.h
rename to lib/merge-blobs.h
diff --git a/merge-ll.c b/lib/merge-ll.c
similarity index 100%
rename from merge-ll.c
rename to lib/merge-ll.c
diff --git a/merge-ll.h b/lib/merge-ll.h
similarity index 100%
rename from merge-ll.h
rename to lib/merge-ll.h
diff --git a/merge-ort-wrappers.c b/lib/merge-ort-wrappers.c
similarity index 100%
rename from merge-ort-wrappers.c
rename to lib/merge-ort-wrappers.c
diff --git a/merge-ort-wrappers.h b/lib/merge-ort-wrappers.h
similarity index 100%
rename from merge-ort-wrappers.h
rename to lib/merge-ort-wrappers.h
diff --git a/merge-ort.c b/lib/merge-ort.c
similarity index 100%
rename from merge-ort.c
rename to lib/merge-ort.c
diff --git a/merge-ort.h b/lib/merge-ort.h
similarity index 100%
rename from merge-ort.h
rename to lib/merge-ort.h
diff --git a/merge.c b/lib/merge.c
similarity index 100%
rename from merge.c
rename to lib/merge.c
diff --git a/merge.h b/lib/merge.h
similarity index 100%
rename from merge.h
rename to lib/merge.h
diff --git a/mergesort.h b/lib/mergesort.h
similarity index 100%
rename from mergesort.h
rename to lib/mergesort.h
diff --git a/midx-write.c b/lib/midx-write.c
similarity index 100%
rename from midx-write.c
rename to lib/midx-write.c
diff --git a/midx.c b/lib/midx.c
similarity index 100%
rename from midx.c
rename to lib/midx.c
diff --git a/midx.h b/lib/midx.h
similarity index 100%
rename from midx.h
rename to lib/midx.h
diff --git a/name-hash.c b/lib/name-hash.c
similarity index 100%
rename from name-hash.c
rename to lib/name-hash.c
diff --git a/name-hash.h b/lib/name-hash.h
similarity index 100%
rename from name-hash.h
rename to lib/name-hash.h
diff --git a/negotiator/default.c b/lib/negotiator/default.c
similarity index 100%
rename from negotiator/default.c
rename to lib/negotiator/default.c
diff --git a/negotiator/default.h b/lib/negotiator/default.h
similarity index 100%
rename from negotiator/default.h
rename to lib/negotiator/default.h
diff --git a/negotiator/noop.c b/lib/negotiator/noop.c
similarity index 100%
rename from negotiator/noop.c
rename to lib/negotiator/noop.c
diff --git a/negotiator/noop.h b/lib/negotiator/noop.h
similarity index 100%
rename from negotiator/noop.h
rename to lib/negotiator/noop.h
diff --git a/negotiator/skipping.c b/lib/negotiator/skipping.c
similarity index 100%
rename from negotiator/skipping.c
rename to lib/negotiator/skipping.c
diff --git a/negotiator/skipping.h b/lib/negotiator/skipping.h
similarity index 100%
rename from negotiator/skipping.h
rename to lib/negotiator/skipping.h
diff --git a/notes-cache.c b/lib/notes-cache.c
similarity index 100%
rename from notes-cache.c
rename to lib/notes-cache.c
diff --git a/notes-cache.h b/lib/notes-cache.h
similarity index 100%
rename from notes-cache.h
rename to lib/notes-cache.h
diff --git a/notes-merge.c b/lib/notes-merge.c
similarity index 100%
rename from notes-merge.c
rename to lib/notes-merge.c
diff --git a/notes-merge.h b/lib/notes-merge.h
similarity index 100%
rename from notes-merge.h
rename to lib/notes-merge.h
diff --git a/notes-utils.c b/lib/notes-utils.c
similarity index 100%
rename from notes-utils.c
rename to lib/notes-utils.c
diff --git a/notes-utils.h b/lib/notes-utils.h
similarity index 100%
rename from notes-utils.h
rename to lib/notes-utils.h
diff --git a/notes.c b/lib/notes.c
similarity index 100%
rename from notes.c
rename to lib/notes.c
diff --git a/notes.h b/lib/notes.h
similarity index 100%
rename from notes.h
rename to lib/notes.h
diff --git a/object-file-convert.c b/lib/object-file-convert.c
similarity index 100%
rename from object-file-convert.c
rename to lib/object-file-convert.c
diff --git a/object-file-convert.h b/lib/object-file-convert.h
similarity index 100%
rename from object-file-convert.h
rename to lib/object-file-convert.h
diff --git a/object-file.c b/lib/object-file.c
similarity index 100%
rename from object-file.c
rename to lib/object-file.c
diff --git a/object-file.h b/lib/object-file.h
similarity index 100%
rename from object-file.h
rename to lib/object-file.h
diff --git a/object-name.c b/lib/object-name.c
similarity index 100%
rename from object-name.c
rename to lib/object-name.c
diff --git a/object-name.h b/lib/object-name.h
similarity index 100%
rename from object-name.h
rename to lib/object-name.h
diff --git a/object.c b/lib/object.c
similarity index 100%
rename from object.c
rename to lib/object.c
diff --git a/object.h b/lib/object.h
similarity index 100%
rename from object.h
rename to lib/object.h
diff --git a/odb.c b/lib/odb.c
similarity index 100%
rename from odb.c
rename to lib/odb.c
diff --git a/odb.h b/lib/odb.h
similarity index 100%
rename from odb.h
rename to lib/odb.h
diff --git a/odb/source-files.c b/lib/odb/source-files.c
similarity index 100%
rename from odb/source-files.c
rename to lib/odb/source-files.c
diff --git a/odb/source-files.h b/lib/odb/source-files.h
similarity index 100%
rename from odb/source-files.h
rename to lib/odb/source-files.h
diff --git a/odb/source-inmemory.c b/lib/odb/source-inmemory.c
similarity index 100%
rename from odb/source-inmemory.c
rename to lib/odb/source-inmemory.c
diff --git a/odb/source-inmemory.h b/lib/odb/source-inmemory.h
similarity index 100%
rename from odb/source-inmemory.h
rename to lib/odb/source-inmemory.h
diff --git a/odb/source-loose.c b/lib/odb/source-loose.c
similarity index 100%
rename from odb/source-loose.c
rename to lib/odb/source-loose.c
diff --git a/odb/source-loose.h b/lib/odb/source-loose.h
similarity index 100%
rename from odb/source-loose.h
rename to lib/odb/source-loose.h
diff --git a/odb/source-packed.c b/lib/odb/source-packed.c
similarity index 100%
rename from odb/source-packed.c
rename to lib/odb/source-packed.c
diff --git a/odb/source-packed.h b/lib/odb/source-packed.h
similarity index 100%
rename from odb/source-packed.h
rename to lib/odb/source-packed.h
diff --git a/odb/source.c b/lib/odb/source.c
similarity index 100%
rename from odb/source.c
rename to lib/odb/source.c
diff --git a/odb/source.h b/lib/odb/source.h
similarity index 100%
rename from odb/source.h
rename to lib/odb/source.h
diff --git a/odb/streaming.c b/lib/odb/streaming.c
similarity index 100%
rename from odb/streaming.c
rename to lib/odb/streaming.c
diff --git a/odb/streaming.h b/lib/odb/streaming.h
similarity index 100%
rename from odb/streaming.h
rename to lib/odb/streaming.h
diff --git a/odb/transaction.c b/lib/odb/transaction.c
similarity index 100%
rename from odb/transaction.c
rename to lib/odb/transaction.c
diff --git a/odb/transaction.h b/lib/odb/transaction.h
similarity index 100%
rename from odb/transaction.h
rename to lib/odb/transaction.h
diff --git a/oid-array.c b/lib/oid-array.c
similarity index 100%
rename from oid-array.c
rename to lib/oid-array.c
diff --git a/oid-array.h b/lib/oid-array.h
similarity index 100%
rename from oid-array.h
rename to lib/oid-array.h
diff --git a/oidmap.c b/lib/oidmap.c
similarity index 100%
rename from oidmap.c
rename to lib/oidmap.c
diff --git a/oidmap.h b/lib/oidmap.h
similarity index 100%
rename from oidmap.h
rename to lib/oidmap.h
diff --git a/oidset.c b/lib/oidset.c
similarity index 100%
rename from oidset.c
rename to lib/oidset.c
diff --git a/oidset.h b/lib/oidset.h
similarity index 100%
rename from oidset.h
rename to lib/oidset.h
diff --git a/oidtree.c b/lib/oidtree.c
similarity index 100%
rename from oidtree.c
rename to lib/oidtree.c
diff --git a/oidtree.h b/lib/oidtree.h
similarity index 100%
rename from oidtree.h
rename to lib/oidtree.h
diff --git a/pack-bitmap-write.c b/lib/pack-bitmap-write.c
similarity index 100%
rename from pack-bitmap-write.c
rename to lib/pack-bitmap-write.c
diff --git a/pack-bitmap.c b/lib/pack-bitmap.c
similarity index 100%
rename from pack-bitmap.c
rename to lib/pack-bitmap.c
diff --git a/pack-bitmap.h b/lib/pack-bitmap.h
similarity index 100%
rename from pack-bitmap.h
rename to lib/pack-bitmap.h
diff --git a/pack-check.c b/lib/pack-check.c
similarity index 100%
rename from pack-check.c
rename to lib/pack-check.c
diff --git a/pack-mtimes.c b/lib/pack-mtimes.c
similarity index 100%
rename from pack-mtimes.c
rename to lib/pack-mtimes.c
diff --git a/pack-mtimes.h b/lib/pack-mtimes.h
similarity index 100%
rename from pack-mtimes.h
rename to lib/pack-mtimes.h
diff --git a/pack-objects.c b/lib/pack-objects.c
similarity index 100%
rename from pack-objects.c
rename to lib/pack-objects.c
diff --git a/pack-objects.h b/lib/pack-objects.h
similarity index 100%
rename from pack-objects.h
rename to lib/pack-objects.h
diff --git a/pack-refs.c b/lib/pack-refs.c
similarity index 100%
rename from pack-refs.c
rename to lib/pack-refs.c
diff --git a/pack-refs.h b/lib/pack-refs.h
similarity index 100%
rename from pack-refs.h
rename to lib/pack-refs.h
diff --git a/pack-revindex.c b/lib/pack-revindex.c
similarity index 100%
rename from pack-revindex.c
rename to lib/pack-revindex.c
diff --git a/pack-revindex.h b/lib/pack-revindex.h
similarity index 100%
rename from pack-revindex.h
rename to lib/pack-revindex.h
diff --git a/pack-write.c b/lib/pack-write.c
similarity index 100%
rename from pack-write.c
rename to lib/pack-write.c
diff --git a/pack.h b/lib/pack.h
similarity index 100%
rename from pack.h
rename to lib/pack.h
diff --git a/packfile-list.c b/lib/packfile-list.c
similarity index 100%
rename from packfile-list.c
rename to lib/packfile-list.c
diff --git a/packfile-list.h b/lib/packfile-list.h
similarity index 100%
rename from packfile-list.h
rename to lib/packfile-list.h
diff --git a/packfile.c b/lib/packfile.c
similarity index 100%
rename from packfile.c
rename to lib/packfile.c
diff --git a/packfile.h b/lib/packfile.h
similarity index 100%
rename from packfile.h
rename to lib/packfile.h
diff --git a/pager.c b/lib/pager.c
similarity index 100%
rename from pager.c
rename to lib/pager.c
diff --git a/pager.h b/lib/pager.h
similarity index 100%
rename from pager.h
rename to lib/pager.h
diff --git a/parallel-checkout.c b/lib/parallel-checkout.c
similarity index 100%
rename from parallel-checkout.c
rename to lib/parallel-checkout.c
diff --git a/parallel-checkout.h b/lib/parallel-checkout.h
similarity index 100%
rename from parallel-checkout.h
rename to lib/parallel-checkout.h
diff --git a/parse-options-cb.c b/lib/parse-options-cb.c
similarity index 100%
rename from parse-options-cb.c
rename to lib/parse-options-cb.c
diff --git a/parse-options.c b/lib/parse-options.c
similarity index 100%
rename from parse-options.c
rename to lib/parse-options.c
diff --git a/parse-options.h b/lib/parse-options.h
similarity index 100%
rename from parse-options.h
rename to lib/parse-options.h
diff --git a/parse.c b/lib/parse.c
similarity index 100%
rename from parse.c
rename to lib/parse.c
diff --git a/parse.h b/lib/parse.h
similarity index 100%
rename from parse.h
rename to lib/parse.h
diff --git a/patch-delta.c b/lib/patch-delta.c
similarity index 100%
rename from patch-delta.c
rename to lib/patch-delta.c
diff --git a/patch-ids.c b/lib/patch-ids.c
similarity index 100%
rename from patch-ids.c
rename to lib/patch-ids.c
diff --git a/patch-ids.h b/lib/patch-ids.h
similarity index 100%
rename from patch-ids.h
rename to lib/patch-ids.h
diff --git a/path-walk.c b/lib/path-walk.c
similarity index 100%
rename from path-walk.c
rename to lib/path-walk.c
diff --git a/path-walk.h b/lib/path-walk.h
similarity index 100%
rename from path-walk.h
rename to lib/path-walk.h
diff --git a/path.c b/lib/path.c
similarity index 100%
rename from path.c
rename to lib/path.c
diff --git a/path.h b/lib/path.h
similarity index 100%
rename from path.h
rename to lib/path.h
diff --git a/pathspec.c b/lib/pathspec.c
similarity index 100%
rename from pathspec.c
rename to lib/pathspec.c
diff --git a/pathspec.h b/lib/pathspec.h
similarity index 100%
rename from pathspec.h
rename to lib/pathspec.h
diff --git a/pkt-line.c b/lib/pkt-line.c
similarity index 100%
rename from pkt-line.c
rename to lib/pkt-line.c
diff --git a/pkt-line.h b/lib/pkt-line.h
similarity index 100%
rename from pkt-line.h
rename to lib/pkt-line.h
diff --git a/preload-index.c b/lib/preload-index.c
similarity index 100%
rename from preload-index.c
rename to lib/preload-index.c
diff --git a/preload-index.h b/lib/preload-index.h
similarity index 100%
rename from preload-index.h
rename to lib/preload-index.h
diff --git a/pretty.c b/lib/pretty.c
similarity index 100%
rename from pretty.c
rename to lib/pretty.c
diff --git a/pretty.h b/lib/pretty.h
similarity index 100%
rename from pretty.h
rename to lib/pretty.h
diff --git a/prio-queue.c b/lib/prio-queue.c
similarity index 100%
rename from prio-queue.c
rename to lib/prio-queue.c
diff --git a/prio-queue.h b/lib/prio-queue.h
similarity index 100%
rename from prio-queue.h
rename to lib/prio-queue.h
diff --git a/progress.c b/lib/progress.c
similarity index 100%
rename from progress.c
rename to lib/progress.c
diff --git a/progress.h b/lib/progress.h
similarity index 100%
rename from progress.h
rename to lib/progress.h
diff --git a/promisor-remote.c b/lib/promisor-remote.c
similarity index 100%
rename from promisor-remote.c
rename to lib/promisor-remote.c
diff --git a/promisor-remote.h b/lib/promisor-remote.h
similarity index 100%
rename from promisor-remote.h
rename to lib/promisor-remote.h
diff --git a/prompt.c b/lib/prompt.c
similarity index 100%
rename from prompt.c
rename to lib/prompt.c
diff --git a/prompt.h b/lib/prompt.h
similarity index 100%
rename from prompt.h
rename to lib/prompt.h
diff --git a/protocol-caps.c b/lib/protocol-caps.c
similarity index 100%
rename from protocol-caps.c
rename to lib/protocol-caps.c
diff --git a/protocol-caps.h b/lib/protocol-caps.h
similarity index 100%
rename from protocol-caps.h
rename to lib/protocol-caps.h
diff --git a/protocol.c b/lib/protocol.c
similarity index 100%
rename from protocol.c
rename to lib/protocol.c
diff --git a/protocol.h b/lib/protocol.h
similarity index 100%
rename from protocol.h
rename to lib/protocol.h
diff --git a/prune-packed.c b/lib/prune-packed.c
similarity index 100%
rename from prune-packed.c
rename to lib/prune-packed.c
diff --git a/prune-packed.h b/lib/prune-packed.h
similarity index 100%
rename from prune-packed.h
rename to lib/prune-packed.h
diff --git a/pseudo-merge.c b/lib/pseudo-merge.c
similarity index 100%
rename from pseudo-merge.c
rename to lib/pseudo-merge.c
diff --git a/pseudo-merge.h b/lib/pseudo-merge.h
similarity index 100%
rename from pseudo-merge.h
rename to lib/pseudo-merge.h
diff --git a/quote.c b/lib/quote.c
similarity index 100%
rename from quote.c
rename to lib/quote.c
diff --git a/quote.h b/lib/quote.h
similarity index 100%
rename from quote.h
rename to lib/quote.h
diff --git a/range-diff.c b/lib/range-diff.c
similarity index 100%
rename from range-diff.c
rename to lib/range-diff.c
diff --git a/range-diff.h b/lib/range-diff.h
similarity index 100%
rename from range-diff.h
rename to lib/range-diff.h
diff --git a/reachable.c b/lib/reachable.c
similarity index 100%
rename from reachable.c
rename to lib/reachable.c
diff --git a/reachable.h b/lib/reachable.h
similarity index 100%
rename from reachable.h
rename to lib/reachable.h
diff --git a/read-cache-ll.h b/lib/read-cache-ll.h
similarity index 100%
rename from read-cache-ll.h
rename to lib/read-cache-ll.h
diff --git a/read-cache.c b/lib/read-cache.c
similarity index 100%
rename from read-cache.c
rename to lib/read-cache.c
diff --git a/read-cache.h b/lib/read-cache.h
similarity index 100%
rename from read-cache.h
rename to lib/read-cache.h
diff --git a/rebase-interactive.c b/lib/rebase-interactive.c
similarity index 100%
rename from rebase-interactive.c
rename to lib/rebase-interactive.c
diff --git a/rebase-interactive.h b/lib/rebase-interactive.h
similarity index 100%
rename from rebase-interactive.h
rename to lib/rebase-interactive.h
diff --git a/rebase.c b/lib/rebase.c
similarity index 100%
rename from rebase.c
rename to lib/rebase.c
diff --git a/rebase.h b/lib/rebase.h
similarity index 100%
rename from rebase.h
rename to lib/rebase.h
diff --git a/ref-filter.c b/lib/ref-filter.c
similarity index 100%
rename from ref-filter.c
rename to lib/ref-filter.c
diff --git a/ref-filter.h b/lib/ref-filter.h
similarity index 100%
rename from ref-filter.h
rename to lib/ref-filter.h
diff --git a/reflog-walk.c b/lib/reflog-walk.c
similarity index 100%
rename from reflog-walk.c
rename to lib/reflog-walk.c
diff --git a/reflog-walk.h b/lib/reflog-walk.h
similarity index 100%
rename from reflog-walk.h
rename to lib/reflog-walk.h
diff --git a/reflog.c b/lib/reflog.c
similarity index 100%
rename from reflog.c
rename to lib/reflog.c
diff --git a/reflog.h b/lib/reflog.h
similarity index 100%
rename from reflog.h
rename to lib/reflog.h
diff --git a/refs.c b/lib/refs.c
similarity index 100%
rename from refs.c
rename to lib/refs.c
diff --git a/refs.h b/lib/refs.h
similarity index 100%
rename from refs.h
rename to lib/refs.h
diff --git a/refs/debug.c b/lib/refs/debug.c
similarity index 100%
rename from refs/debug.c
rename to lib/refs/debug.c
diff --git a/refs/files-backend.c b/lib/refs/files-backend.c
similarity index 100%
rename from refs/files-backend.c
rename to lib/refs/files-backend.c
diff --git a/refs/iterator.c b/lib/refs/iterator.c
similarity index 100%
rename from refs/iterator.c
rename to lib/refs/iterator.c
diff --git a/refs/packed-backend.c b/lib/refs/packed-backend.c
similarity index 100%
rename from refs/packed-backend.c
rename to lib/refs/packed-backend.c
diff --git a/refs/packed-backend.h b/lib/refs/packed-backend.h
similarity index 100%
rename from refs/packed-backend.h
rename to lib/refs/packed-backend.h
diff --git a/refs/ref-cache.c b/lib/refs/ref-cache.c
similarity index 100%
rename from refs/ref-cache.c
rename to lib/refs/ref-cache.c
diff --git a/refs/ref-cache.h b/lib/refs/ref-cache.h
similarity index 100%
rename from refs/ref-cache.h
rename to lib/refs/ref-cache.h
diff --git a/refs/refs-internal.h b/lib/refs/refs-internal.h
similarity index 100%
rename from refs/refs-internal.h
rename to lib/refs/refs-internal.h
diff --git a/refs/reftable-backend.c b/lib/refs/reftable-backend.c
similarity index 100%
rename from refs/reftable-backend.c
rename to lib/refs/reftable-backend.c
diff --git a/refspec.c b/lib/refspec.c
similarity index 100%
rename from refspec.c
rename to lib/refspec.c
diff --git a/refspec.h b/lib/refspec.h
similarity index 100%
rename from refspec.h
rename to lib/refspec.h
diff --git a/reftable/LICENSE b/lib/reftable/LICENSE
similarity index 100%
rename from reftable/LICENSE
rename to lib/reftable/LICENSE
diff --git a/reftable/basics.c b/lib/reftable/basics.c
similarity index 100%
rename from reftable/basics.c
rename to lib/reftable/basics.c
diff --git a/reftable/basics.h b/lib/reftable/basics.h
similarity index 100%
rename from reftable/basics.h
rename to lib/reftable/basics.h
diff --git a/reftable/block.c b/lib/reftable/block.c
similarity index 100%
rename from reftable/block.c
rename to lib/reftable/block.c
diff --git a/reftable/block.h b/lib/reftable/block.h
similarity index 100%
rename from reftable/block.h
rename to lib/reftable/block.h
diff --git a/reftable/blocksource.c b/lib/reftable/blocksource.c
similarity index 100%
rename from reftable/blocksource.c
rename to lib/reftable/blocksource.c
diff --git a/reftable/blocksource.h b/lib/reftable/blocksource.h
similarity index 100%
rename from reftable/blocksource.h
rename to lib/reftable/blocksource.h
diff --git a/reftable/constants.h b/lib/reftable/constants.h
similarity index 100%
rename from reftable/constants.h
rename to lib/reftable/constants.h
diff --git a/reftable/error.c b/lib/reftable/error.c
similarity index 100%
rename from reftable/error.c
rename to lib/reftable/error.c
diff --git a/reftable/fsck.c b/lib/reftable/fsck.c
similarity index 100%
rename from reftable/fsck.c
rename to lib/reftable/fsck.c
diff --git a/reftable/iter.c b/lib/reftable/iter.c
similarity index 100%
rename from reftable/iter.c
rename to lib/reftable/iter.c
diff --git a/reftable/iter.h b/lib/reftable/iter.h
similarity index 100%
rename from reftable/iter.h
rename to lib/reftable/iter.h
diff --git a/reftable/merged.c b/lib/reftable/merged.c
similarity index 100%
rename from reftable/merged.c
rename to lib/reftable/merged.c
diff --git a/reftable/merged.h b/lib/reftable/merged.h
similarity index 100%
rename from reftable/merged.h
rename to lib/reftable/merged.h
diff --git a/reftable/pq.c b/lib/reftable/pq.c
similarity index 100%
rename from reftable/pq.c
rename to lib/reftable/pq.c
diff --git a/reftable/pq.h b/lib/reftable/pq.h
similarity index 100%
rename from reftable/pq.h
rename to lib/reftable/pq.h
diff --git a/reftable/record.c b/lib/reftable/record.c
similarity index 100%
rename from reftable/record.c
rename to lib/reftable/record.c
diff --git a/reftable/record.h b/lib/reftable/record.h
similarity index 100%
rename from reftable/record.h
rename to lib/reftable/record.h
diff --git a/reftable/reftable-basics.h b/lib/reftable/reftable-basics.h
similarity index 100%
rename from reftable/reftable-basics.h
rename to lib/reftable/reftable-basics.h
diff --git a/reftable/reftable-block.h b/lib/reftable/reftable-block.h
similarity index 100%
rename from reftable/reftable-block.h
rename to lib/reftable/reftable-block.h
diff --git a/reftable/reftable-blocksource.h b/lib/reftable/reftable-blocksource.h
similarity index 100%
rename from reftable/reftable-blocksource.h
rename to lib/reftable/reftable-blocksource.h
diff --git a/reftable/reftable-constants.h b/lib/reftable/reftable-constants.h
similarity index 100%
rename from reftable/reftable-constants.h
rename to lib/reftable/reftable-constants.h
diff --git a/reftable/reftable-error.h b/lib/reftable/reftable-error.h
similarity index 100%
rename from reftable/reftable-error.h
rename to lib/reftable/reftable-error.h
diff --git a/reftable/reftable-fsck.h b/lib/reftable/reftable-fsck.h
similarity index 100%
rename from reftable/reftable-fsck.h
rename to lib/reftable/reftable-fsck.h
diff --git a/reftable/reftable-iterator.h b/lib/reftable/reftable-iterator.h
similarity index 100%
rename from reftable/reftable-iterator.h
rename to lib/reftable/reftable-iterator.h
diff --git a/reftable/reftable-merged.h b/lib/reftable/reftable-merged.h
similarity index 100%
rename from reftable/reftable-merged.h
rename to lib/reftable/reftable-merged.h
diff --git a/reftable/reftable-record.h b/lib/reftable/reftable-record.h
similarity index 100%
rename from reftable/reftable-record.h
rename to lib/reftable/reftable-record.h
diff --git a/reftable/reftable-stack.h b/lib/reftable/reftable-stack.h
similarity index 100%
rename from reftable/reftable-stack.h
rename to lib/reftable/reftable-stack.h
diff --git a/reftable/reftable-system.h b/lib/reftable/reftable-system.h
similarity index 100%
rename from reftable/reftable-system.h
rename to lib/reftable/reftable-system.h
diff --git a/reftable/reftable-table.h b/lib/reftable/reftable-table.h
similarity index 100%
rename from reftable/reftable-table.h
rename to lib/reftable/reftable-table.h
diff --git a/reftable/reftable-writer.h b/lib/reftable/reftable-writer.h
similarity index 100%
rename from reftable/reftable-writer.h
rename to lib/reftable/reftable-writer.h
diff --git a/reftable/stack.c b/lib/reftable/stack.c
similarity index 100%
rename from reftable/stack.c
rename to lib/reftable/stack.c
diff --git a/reftable/stack.h b/lib/reftable/stack.h
similarity index 100%
rename from reftable/stack.h
rename to lib/reftable/stack.h
diff --git a/reftable/system.c b/lib/reftable/system.c
similarity index 100%
rename from reftable/system.c
rename to lib/reftable/system.c
diff --git a/reftable/system.h b/lib/reftable/system.h
similarity index 100%
rename from reftable/system.h
rename to lib/reftable/system.h
diff --git a/reftable/table.c b/lib/reftable/table.c
similarity index 100%
rename from reftable/table.c
rename to lib/reftable/table.c
diff --git a/reftable/table.h b/lib/reftable/table.h
similarity index 100%
rename from reftable/table.h
rename to lib/reftable/table.h
diff --git a/reftable/tree.c b/lib/reftable/tree.c
similarity index 100%
rename from reftable/tree.c
rename to lib/reftable/tree.c
diff --git a/reftable/tree.h b/lib/reftable/tree.h
similarity index 100%
rename from reftable/tree.h
rename to lib/reftable/tree.h
diff --git a/reftable/writer.c b/lib/reftable/writer.c
similarity index 100%
rename from reftable/writer.c
rename to lib/reftable/writer.c
diff --git a/reftable/writer.h b/lib/reftable/writer.h
similarity index 100%
rename from reftable/writer.h
rename to lib/reftable/writer.h
diff --git a/remote.c b/lib/remote.c
similarity index 100%
rename from remote.c
rename to lib/remote.c
diff --git a/remote.h b/lib/remote.h
similarity index 100%
rename from remote.h
rename to lib/remote.h
diff --git a/repack-cruft.c b/lib/repack-cruft.c
similarity index 100%
rename from repack-cruft.c
rename to lib/repack-cruft.c
diff --git a/repack-filtered.c b/lib/repack-filtered.c
similarity index 100%
rename from repack-filtered.c
rename to lib/repack-filtered.c
diff --git a/repack-geometry.c b/lib/repack-geometry.c
similarity index 100%
rename from repack-geometry.c
rename to lib/repack-geometry.c
diff --git a/repack-midx.c b/lib/repack-midx.c
similarity index 100%
rename from repack-midx.c
rename to lib/repack-midx.c
diff --git a/repack-promisor.c b/lib/repack-promisor.c
similarity index 100%
rename from repack-promisor.c
rename to lib/repack-promisor.c
diff --git a/repack.c b/lib/repack.c
similarity index 100%
rename from repack.c
rename to lib/repack.c
diff --git a/repack.h b/lib/repack.h
similarity index 100%
rename from repack.h
rename to lib/repack.h
diff --git a/replace-object.c b/lib/replace-object.c
similarity index 100%
rename from replace-object.c
rename to lib/replace-object.c
diff --git a/replace-object.h b/lib/replace-object.h
similarity index 100%
rename from replace-object.h
rename to lib/replace-object.h
diff --git a/replay.c b/lib/replay.c
similarity index 100%
rename from replay.c
rename to lib/replay.c
diff --git a/replay.h b/lib/replay.h
similarity index 100%
rename from replay.h
rename to lib/replay.h
diff --git a/repo-settings.c b/lib/repo-settings.c
similarity index 100%
rename from repo-settings.c
rename to lib/repo-settings.c
diff --git a/repo-settings.h b/lib/repo-settings.h
similarity index 100%
rename from repo-settings.h
rename to lib/repo-settings.h
diff --git a/repository.c b/lib/repository.c
similarity index 100%
rename from repository.c
rename to lib/repository.c
diff --git a/repository.h b/lib/repository.h
similarity index 100%
rename from repository.h
rename to lib/repository.h
diff --git a/rerere.c b/lib/rerere.c
similarity index 100%
rename from rerere.c
rename to lib/rerere.c
diff --git a/rerere.h b/lib/rerere.h
similarity index 100%
rename from rerere.h
rename to lib/rerere.h
diff --git a/reset.c b/lib/reset.c
similarity index 100%
rename from reset.c
rename to lib/reset.c
diff --git a/reset.h b/lib/reset.h
similarity index 100%
rename from reset.h
rename to lib/reset.h
diff --git a/resolve-undo.c b/lib/resolve-undo.c
similarity index 100%
rename from resolve-undo.c
rename to lib/resolve-undo.c
diff --git a/resolve-undo.h b/lib/resolve-undo.h
similarity index 100%
rename from resolve-undo.h
rename to lib/resolve-undo.h
diff --git a/revision.c b/lib/revision.c
similarity index 100%
rename from revision.c
rename to lib/revision.c
diff --git a/revision.h b/lib/revision.h
similarity index 100%
rename from revision.h
rename to lib/revision.h
diff --git a/run-command.c b/lib/run-command.c
similarity index 100%
rename from run-command.c
rename to lib/run-command.c
diff --git a/run-command.h b/lib/run-command.h
similarity index 100%
rename from run-command.h
rename to lib/run-command.h
diff --git a/sane-ctype.h b/lib/sane-ctype.h
similarity index 100%
rename from sane-ctype.h
rename to lib/sane-ctype.h
diff --git a/send-pack.c b/lib/send-pack.c
similarity index 100%
rename from send-pack.c
rename to lib/send-pack.c
diff --git a/send-pack.h b/lib/send-pack.h
similarity index 100%
rename from send-pack.h
rename to lib/send-pack.h
diff --git a/sequencer.c b/lib/sequencer.c
similarity index 100%
rename from sequencer.c
rename to lib/sequencer.c
diff --git a/sequencer.h b/lib/sequencer.h
similarity index 100%
rename from sequencer.h
rename to lib/sequencer.h
diff --git a/serve.c b/lib/serve.c
similarity index 100%
rename from serve.c
rename to lib/serve.c
diff --git a/serve.h b/lib/serve.h
similarity index 100%
rename from serve.h
rename to lib/serve.h
diff --git a/server-info.c b/lib/server-info.c
similarity index 100%
rename from server-info.c
rename to lib/server-info.c
diff --git a/server-info.h b/lib/server-info.h
similarity index 100%
rename from server-info.h
rename to lib/server-info.h
diff --git a/setup.c b/lib/setup.c
similarity index 100%
rename from setup.c
rename to lib/setup.c
diff --git a/setup.h b/lib/setup.h
similarity index 100%
rename from setup.h
rename to lib/setup.h
diff --git a/sha1/openssl.h b/lib/sha1/openssl.h
similarity index 100%
rename from sha1/openssl.h
rename to lib/sha1/openssl.h
diff --git a/sha1collisiondetection b/lib/sha1collisiondetection
similarity index 100%
rename from sha1collisiondetection
rename to lib/sha1collisiondetection
diff --git a/sha1dc/.gitattributes b/lib/sha1dc/.gitattributes
similarity index 100%
rename from sha1dc/.gitattributes
rename to lib/sha1dc/.gitattributes
diff --git a/sha1dc/LICENSE.txt b/lib/sha1dc/LICENSE.txt
similarity index 100%
rename from sha1dc/LICENSE.txt
rename to lib/sha1dc/LICENSE.txt
diff --git a/sha1dc/sha1.c b/lib/sha1dc/sha1.c
similarity index 100%
rename from sha1dc/sha1.c
rename to lib/sha1dc/sha1.c
diff --git a/sha1dc/sha1.h b/lib/sha1dc/sha1.h
similarity index 100%
rename from sha1dc/sha1.h
rename to lib/sha1dc/sha1.h
diff --git a/sha1dc/ubc_check.c b/lib/sha1dc/ubc_check.c
similarity index 100%
rename from sha1dc/ubc_check.c
rename to lib/sha1dc/ubc_check.c
diff --git a/sha1dc/ubc_check.h b/lib/sha1dc/ubc_check.h
similarity index 100%
rename from sha1dc/ubc_check.h
rename to lib/sha1dc/ubc_check.h
diff --git a/sha1dc_git.c b/lib/sha1dc_git.c
similarity index 100%
rename from sha1dc_git.c
rename to lib/sha1dc_git.c
diff --git a/sha1dc_git.h b/lib/sha1dc_git.h
similarity index 100%
rename from sha1dc_git.h
rename to lib/sha1dc_git.h
diff --git a/sha256/block/sha256.c b/lib/sha256/block/sha256.c
similarity index 100%
rename from sha256/block/sha256.c
rename to lib/sha256/block/sha256.c
diff --git a/sha256/block/sha256.h b/lib/sha256/block/sha256.h
similarity index 100%
rename from sha256/block/sha256.h
rename to lib/sha256/block/sha256.h
diff --git a/sha256/gcrypt.h b/lib/sha256/gcrypt.h
similarity index 100%
rename from sha256/gcrypt.h
rename to lib/sha256/gcrypt.h
diff --git a/sha256/nettle.h b/lib/sha256/nettle.h
similarity index 100%
rename from sha256/nettle.h
rename to lib/sha256/nettle.h
diff --git a/sha256/openssl.h b/lib/sha256/openssl.h
similarity index 100%
rename from sha256/openssl.h
rename to lib/sha256/openssl.h
diff --git a/shallow.c b/lib/shallow.c
similarity index 100%
rename from shallow.c
rename to lib/shallow.c
diff --git a/shallow.h b/lib/shallow.h
similarity index 100%
rename from shallow.h
rename to lib/shallow.h
diff --git a/shortlog.h b/lib/shortlog.h
similarity index 100%
rename from shortlog.h
rename to lib/shortlog.h
diff --git a/sideband.c b/lib/sideband.c
similarity index 100%
rename from sideband.c
rename to lib/sideband.c
diff --git a/sideband.h b/lib/sideband.h
similarity index 100%
rename from sideband.h
rename to lib/sideband.h
diff --git a/sigchain.c b/lib/sigchain.c
similarity index 100%
rename from sigchain.c
rename to lib/sigchain.c
diff --git a/sigchain.h b/lib/sigchain.h
similarity index 100%
rename from sigchain.h
rename to lib/sigchain.h
diff --git a/simple-ipc.h b/lib/simple-ipc.h
similarity index 100%
rename from simple-ipc.h
rename to lib/simple-ipc.h
diff --git a/sparse-index.c b/lib/sparse-index.c
similarity index 100%
rename from sparse-index.c
rename to lib/sparse-index.c
diff --git a/sparse-index.h b/lib/sparse-index.h
similarity index 100%
rename from sparse-index.h
rename to lib/sparse-index.h
diff --git a/split-index.c b/lib/split-index.c
similarity index 100%
rename from split-index.c
rename to lib/split-index.c
diff --git a/split-index.h b/lib/split-index.h
similarity index 100%
rename from split-index.h
rename to lib/split-index.h
diff --git a/stable-qsort.c b/lib/stable-qsort.c
similarity index 100%
rename from stable-qsort.c
rename to lib/stable-qsort.c
diff --git a/statinfo.c b/lib/statinfo.c
similarity index 100%
rename from statinfo.c
rename to lib/statinfo.c
diff --git a/statinfo.h b/lib/statinfo.h
similarity index 100%
rename from statinfo.h
rename to lib/statinfo.h
diff --git a/strbuf.c b/lib/strbuf.c
similarity index 100%
rename from strbuf.c
rename to lib/strbuf.c
diff --git a/strbuf.h b/lib/strbuf.h
similarity index 100%
rename from strbuf.h
rename to lib/strbuf.h
diff --git a/string-list.c b/lib/string-list.c
similarity index 100%
rename from string-list.c
rename to lib/string-list.c
diff --git a/string-list.h b/lib/string-list.h
similarity index 100%
rename from string-list.h
rename to lib/string-list.h
diff --git a/strmap.c b/lib/strmap.c
similarity index 100%
rename from strmap.c
rename to lib/strmap.c
diff --git a/strmap.h b/lib/strmap.h
similarity index 100%
rename from strmap.h
rename to lib/strmap.h
diff --git a/strvec.c b/lib/strvec.c
similarity index 100%
rename from strvec.c
rename to lib/strvec.c
diff --git a/strvec.h b/lib/strvec.h
similarity index 100%
rename from strvec.h
rename to lib/strvec.h
diff --git a/sub-process.c b/lib/sub-process.c
similarity index 100%
rename from sub-process.c
rename to lib/sub-process.c
diff --git a/sub-process.h b/lib/sub-process.h
similarity index 100%
rename from sub-process.h
rename to lib/sub-process.h
diff --git a/submodule-config.c b/lib/submodule-config.c
similarity index 100%
rename from submodule-config.c
rename to lib/submodule-config.c
diff --git a/submodule-config.h b/lib/submodule-config.h
similarity index 100%
rename from submodule-config.h
rename to lib/submodule-config.h
diff --git a/submodule.c b/lib/submodule.c
similarity index 100%
rename from submodule.c
rename to lib/submodule.c
diff --git a/submodule.h b/lib/submodule.h
similarity index 100%
rename from submodule.h
rename to lib/submodule.h
diff --git a/symlinks.c b/lib/symlinks.c
similarity index 100%
rename from symlinks.c
rename to lib/symlinks.c
diff --git a/symlinks.h b/lib/symlinks.h
similarity index 100%
rename from symlinks.h
rename to lib/symlinks.h
diff --git a/tag.c b/lib/tag.c
similarity index 100%
rename from tag.c
rename to lib/tag.c
diff --git a/tag.h b/lib/tag.h
similarity index 100%
rename from tag.h
rename to lib/tag.h
diff --git a/tar.h b/lib/tar.h
similarity index 100%
rename from tar.h
rename to lib/tar.h
diff --git a/tempfile.c b/lib/tempfile.c
similarity index 100%
rename from tempfile.c
rename to lib/tempfile.c
diff --git a/tempfile.h b/lib/tempfile.h
similarity index 100%
rename from tempfile.h
rename to lib/tempfile.h
diff --git a/thread-utils.c b/lib/thread-utils.c
similarity index 100%
rename from thread-utils.c
rename to lib/thread-utils.c
diff --git a/thread-utils.h b/lib/thread-utils.h
similarity index 100%
rename from thread-utils.h
rename to lib/thread-utils.h
diff --git a/tmp-objdir.c b/lib/tmp-objdir.c
similarity index 100%
rename from tmp-objdir.c
rename to lib/tmp-objdir.c
diff --git a/tmp-objdir.h b/lib/tmp-objdir.h
similarity index 100%
rename from tmp-objdir.h
rename to lib/tmp-objdir.h
diff --git a/trace.c b/lib/trace.c
similarity index 100%
rename from trace.c
rename to lib/trace.c
diff --git a/trace.h b/lib/trace.h
similarity index 100%
rename from trace.h
rename to lib/trace.h
diff --git a/trace2.c b/lib/trace2.c
similarity index 100%
rename from trace2.c
rename to lib/trace2.c
diff --git a/trace2.h b/lib/trace2.h
similarity index 100%
rename from trace2.h
rename to lib/trace2.h
diff --git a/trace2/tr2_cfg.c b/lib/trace2/tr2_cfg.c
similarity index 100%
rename from trace2/tr2_cfg.c
rename to lib/trace2/tr2_cfg.c
diff --git a/trace2/tr2_cfg.h b/lib/trace2/tr2_cfg.h
similarity index 100%
rename from trace2/tr2_cfg.h
rename to lib/trace2/tr2_cfg.h
diff --git a/trace2/tr2_cmd_name.c b/lib/trace2/tr2_cmd_name.c
similarity index 100%
rename from trace2/tr2_cmd_name.c
rename to lib/trace2/tr2_cmd_name.c
diff --git a/trace2/tr2_cmd_name.h b/lib/trace2/tr2_cmd_name.h
similarity index 100%
rename from trace2/tr2_cmd_name.h
rename to lib/trace2/tr2_cmd_name.h
diff --git a/trace2/tr2_ctr.c b/lib/trace2/tr2_ctr.c
similarity index 100%
rename from trace2/tr2_ctr.c
rename to lib/trace2/tr2_ctr.c
diff --git a/trace2/tr2_ctr.h b/lib/trace2/tr2_ctr.h
similarity index 100%
rename from trace2/tr2_ctr.h
rename to lib/trace2/tr2_ctr.h
diff --git a/trace2/tr2_dst.c b/lib/trace2/tr2_dst.c
similarity index 100%
rename from trace2/tr2_dst.c
rename to lib/trace2/tr2_dst.c
diff --git a/trace2/tr2_dst.h b/lib/trace2/tr2_dst.h
similarity index 100%
rename from trace2/tr2_dst.h
rename to lib/trace2/tr2_dst.h
diff --git a/trace2/tr2_sid.c b/lib/trace2/tr2_sid.c
similarity index 100%
rename from trace2/tr2_sid.c
rename to lib/trace2/tr2_sid.c
diff --git a/trace2/tr2_sid.h b/lib/trace2/tr2_sid.h
similarity index 100%
rename from trace2/tr2_sid.h
rename to lib/trace2/tr2_sid.h
diff --git a/trace2/tr2_sysenv.c b/lib/trace2/tr2_sysenv.c
similarity index 100%
rename from trace2/tr2_sysenv.c
rename to lib/trace2/tr2_sysenv.c
diff --git a/trace2/tr2_sysenv.h b/lib/trace2/tr2_sysenv.h
similarity index 100%
rename from trace2/tr2_sysenv.h
rename to lib/trace2/tr2_sysenv.h
diff --git a/trace2/tr2_tbuf.c b/lib/trace2/tr2_tbuf.c
similarity index 100%
rename from trace2/tr2_tbuf.c
rename to lib/trace2/tr2_tbuf.c
diff --git a/trace2/tr2_tbuf.h b/lib/trace2/tr2_tbuf.h
similarity index 100%
rename from trace2/tr2_tbuf.h
rename to lib/trace2/tr2_tbuf.h
diff --git a/trace2/tr2_tgt.h b/lib/trace2/tr2_tgt.h
similarity index 100%
rename from trace2/tr2_tgt.h
rename to lib/trace2/tr2_tgt.h
diff --git a/trace2/tr2_tgt_event.c b/lib/trace2/tr2_tgt_event.c
similarity index 100%
rename from trace2/tr2_tgt_event.c
rename to lib/trace2/tr2_tgt_event.c
diff --git a/trace2/tr2_tgt_normal.c b/lib/trace2/tr2_tgt_normal.c
similarity index 100%
rename from trace2/tr2_tgt_normal.c
rename to lib/trace2/tr2_tgt_normal.c
diff --git a/trace2/tr2_tgt_perf.c b/lib/trace2/tr2_tgt_perf.c
similarity index 100%
rename from trace2/tr2_tgt_perf.c
rename to lib/trace2/tr2_tgt_perf.c
diff --git a/trace2/tr2_tls.c b/lib/trace2/tr2_tls.c
similarity index 100%
rename from trace2/tr2_tls.c
rename to lib/trace2/tr2_tls.c
diff --git a/trace2/tr2_tls.h b/lib/trace2/tr2_tls.h
similarity index 100%
rename from trace2/tr2_tls.h
rename to lib/trace2/tr2_tls.h
diff --git a/trace2/tr2_tmr.c b/lib/trace2/tr2_tmr.c
similarity index 100%
rename from trace2/tr2_tmr.c
rename to lib/trace2/tr2_tmr.c
diff --git a/trace2/tr2_tmr.h b/lib/trace2/tr2_tmr.h
similarity index 100%
rename from trace2/tr2_tmr.h
rename to lib/trace2/tr2_tmr.h
diff --git a/trailer.c b/lib/trailer.c
similarity index 100%
rename from trailer.c
rename to lib/trailer.c
diff --git a/trailer.h b/lib/trailer.h
similarity index 100%
rename from trailer.h
rename to lib/trailer.h
diff --git a/transport-helper.c b/lib/transport-helper.c
similarity index 100%
rename from transport-helper.c
rename to lib/transport-helper.c
diff --git a/transport-internal.h b/lib/transport-internal.h
similarity index 100%
rename from transport-internal.h
rename to lib/transport-internal.h
diff --git a/transport.c b/lib/transport.c
similarity index 100%
rename from transport.c
rename to lib/transport.c
diff --git a/transport.h b/lib/transport.h
similarity index 100%
rename from transport.h
rename to lib/transport.h
diff --git a/tree-diff.c b/lib/tree-diff.c
similarity index 100%
rename from tree-diff.c
rename to lib/tree-diff.c
diff --git a/tree-walk.c b/lib/tree-walk.c
similarity index 100%
rename from tree-walk.c
rename to lib/tree-walk.c
diff --git a/tree-walk.h b/lib/tree-walk.h
similarity index 100%
rename from tree-walk.h
rename to lib/tree-walk.h
diff --git a/tree.c b/lib/tree.c
similarity index 100%
rename from tree.c
rename to lib/tree.c
diff --git a/tree.h b/lib/tree.h
similarity index 100%
rename from tree.h
rename to lib/tree.h
diff --git a/unicode-width.h b/lib/unicode-width.h
similarity index 100%
rename from unicode-width.h
rename to lib/unicode-width.h
diff --git a/unix-socket.c b/lib/unix-socket.c
similarity index 100%
rename from unix-socket.c
rename to lib/unix-socket.c
diff --git a/unix-socket.h b/lib/unix-socket.h
similarity index 100%
rename from unix-socket.h
rename to lib/unix-socket.h
diff --git a/unix-stream-server.c b/lib/unix-stream-server.c
similarity index 100%
rename from unix-stream-server.c
rename to lib/unix-stream-server.c
diff --git a/unix-stream-server.h b/lib/unix-stream-server.h
similarity index 100%
rename from unix-stream-server.h
rename to lib/unix-stream-server.h
diff --git a/unpack-trees.c b/lib/unpack-trees.c
similarity index 100%
rename from unpack-trees.c
rename to lib/unpack-trees.c
diff --git a/unpack-trees.h b/lib/unpack-trees.h
similarity index 100%
rename from unpack-trees.h
rename to lib/unpack-trees.h
diff --git a/upload-pack.c b/lib/upload-pack.c
similarity index 100%
rename from upload-pack.c
rename to lib/upload-pack.c
diff --git a/upload-pack.h b/lib/upload-pack.h
similarity index 100%
rename from upload-pack.h
rename to lib/upload-pack.h
diff --git a/url.c b/lib/url.c
similarity index 100%
rename from url.c
rename to lib/url.c
diff --git a/url.h b/lib/url.h
similarity index 100%
rename from url.h
rename to lib/url.h
diff --git a/urlmatch.c b/lib/urlmatch.c
similarity index 100%
rename from urlmatch.c
rename to lib/urlmatch.c
diff --git a/urlmatch.h b/lib/urlmatch.h
similarity index 100%
rename from urlmatch.h
rename to lib/urlmatch.h
diff --git a/usage.c b/lib/usage.c
similarity index 100%
rename from usage.c
rename to lib/usage.c
diff --git a/userdiff.c b/lib/userdiff.c
similarity index 100%
rename from userdiff.c
rename to lib/userdiff.c
diff --git a/userdiff.h b/lib/userdiff.h
similarity index 100%
rename from userdiff.h
rename to lib/userdiff.h
diff --git a/utf8.c b/lib/utf8.c
similarity index 100%
rename from utf8.c
rename to lib/utf8.c
diff --git a/utf8.h b/lib/utf8.h
similarity index 100%
rename from utf8.h
rename to lib/utf8.h
diff --git a/varint.c b/lib/varint.c
similarity index 100%
rename from varint.c
rename to lib/varint.c
diff --git a/varint.h b/lib/varint.h
similarity index 100%
rename from varint.h
rename to lib/varint.h
diff --git a/version-def.h.in b/lib/version-def.h.in
similarity index 100%
rename from version-def.h.in
rename to lib/version-def.h.in
diff --git a/version.c b/lib/version.c
similarity index 100%
rename from version.c
rename to lib/version.c
diff --git a/version.h b/lib/version.h
similarity index 100%
rename from version.h
rename to lib/version.h
diff --git a/versioncmp.c b/lib/versioncmp.c
similarity index 100%
rename from versioncmp.c
rename to lib/versioncmp.c
diff --git a/versioncmp.h b/lib/versioncmp.h
similarity index 100%
rename from versioncmp.h
rename to lib/versioncmp.h
diff --git a/walker.c b/lib/walker.c
similarity index 100%
rename from walker.c
rename to lib/walker.c
diff --git a/walker.h b/lib/walker.h
similarity index 100%
rename from walker.h
rename to lib/walker.h
diff --git a/wildmatch.c b/lib/wildmatch.c
similarity index 100%
rename from wildmatch.c
rename to lib/wildmatch.c
diff --git a/wildmatch.h b/lib/wildmatch.h
similarity index 100%
rename from wildmatch.h
rename to lib/wildmatch.h
diff --git a/worktree.c b/lib/worktree.c
similarity index 100%
rename from worktree.c
rename to lib/worktree.c
diff --git a/worktree.h b/lib/worktree.h
similarity index 100%
rename from worktree.h
rename to lib/worktree.h
diff --git a/wrapper.c b/lib/wrapper.c
similarity index 100%
rename from wrapper.c
rename to lib/wrapper.c
diff --git a/wrapper.h b/lib/wrapper.h
similarity index 100%
rename from wrapper.h
rename to lib/wrapper.h
diff --git a/write-or-die.c b/lib/write-or-die.c
similarity index 100%
rename from write-or-die.c
rename to lib/write-or-die.c
diff --git a/write-or-die.h b/lib/write-or-die.h
similarity index 100%
rename from write-or-die.h
rename to lib/write-or-die.h
diff --git a/ws.c b/lib/ws.c
similarity index 100%
rename from ws.c
rename to lib/ws.c
diff --git a/ws.h b/lib/ws.h
similarity index 100%
rename from ws.h
rename to lib/ws.h
diff --git a/wt-status.c b/lib/wt-status.c
similarity index 100%
rename from wt-status.c
rename to lib/wt-status.c
diff --git a/wt-status.h b/lib/wt-status.h
similarity index 100%
rename from wt-status.h
rename to lib/wt-status.h
diff --git a/xdiff-interface.c b/lib/xdiff-interface.c
similarity index 100%
rename from xdiff-interface.c
rename to lib/xdiff-interface.c
diff --git a/xdiff-interface.h b/lib/xdiff-interface.h
similarity index 100%
rename from xdiff-interface.h
rename to lib/xdiff-interface.h
diff --git a/xdiff/xdiff.h b/lib/xdiff/xdiff.h
similarity index 100%
rename from xdiff/xdiff.h
rename to lib/xdiff/xdiff.h
diff --git a/xdiff/xdiffi.c b/lib/xdiff/xdiffi.c
similarity index 100%
rename from xdiff/xdiffi.c
rename to lib/xdiff/xdiffi.c
diff --git a/xdiff/xdiffi.h b/lib/xdiff/xdiffi.h
similarity index 100%
rename from xdiff/xdiffi.h
rename to lib/xdiff/xdiffi.h
diff --git a/xdiff/xemit.c b/lib/xdiff/xemit.c
similarity index 100%
rename from xdiff/xemit.c
rename to lib/xdiff/xemit.c
diff --git a/xdiff/xemit.h b/lib/xdiff/xemit.h
similarity index 100%
rename from xdiff/xemit.h
rename to lib/xdiff/xemit.h
diff --git a/xdiff/xhistogram.c b/lib/xdiff/xhistogram.c
similarity index 100%
rename from xdiff/xhistogram.c
rename to lib/xdiff/xhistogram.c
diff --git a/xdiff/xinclude.h b/lib/xdiff/xinclude.h
similarity index 100%
rename from xdiff/xinclude.h
rename to lib/xdiff/xinclude.h
diff --git a/xdiff/xmacros.h b/lib/xdiff/xmacros.h
similarity index 100%
rename from xdiff/xmacros.h
rename to lib/xdiff/xmacros.h
diff --git a/xdiff/xmerge.c b/lib/xdiff/xmerge.c
similarity index 100%
rename from xdiff/xmerge.c
rename to lib/xdiff/xmerge.c
diff --git a/xdiff/xpatience.c b/lib/xdiff/xpatience.c
similarity index 100%
rename from xdiff/xpatience.c
rename to lib/xdiff/xpatience.c
diff --git a/xdiff/xprepare.c b/lib/xdiff/xprepare.c
similarity index 100%
rename from xdiff/xprepare.c
rename to lib/xdiff/xprepare.c
diff --git a/xdiff/xprepare.h b/lib/xdiff/xprepare.h
similarity index 100%
rename from xdiff/xprepare.h
rename to lib/xdiff/xprepare.h
diff --git a/xdiff/xtypes.h b/lib/xdiff/xtypes.h
similarity index 100%
rename from xdiff/xtypes.h
rename to lib/xdiff/xtypes.h
diff --git a/xdiff/xutils.c b/lib/xdiff/xutils.c
similarity index 100%
rename from xdiff/xutils.c
rename to lib/xdiff/xutils.c
diff --git a/xdiff/xutils.h b/lib/xdiff/xutils.h
similarity index 100%
rename from xdiff/xutils.h
rename to lib/xdiff/xutils.h
diff --git a/meson.build b/meson.build
index ca235801cf..2f90bed441 100644
--- a/meson.build
+++ b/meson.build
@@ -272,293 +272,293 @@ version_gen_environment.set('GIT_VERSION', get_option('version'))
 compiler = meson.get_compiler('c')
 
 compat_sources = [
-  'compat/nonblock.c',
-  'compat/obstack.c',
-  'compat/open.c',
-  'compat/terminal.c',
+  'lib/compat/nonblock.c',
+  'lib/compat/obstack.c',
+  'lib/compat/open.c',
+  'lib/compat/terminal.c',
 ]
 
 libgit_sources = [
-  'abspath.c',
-  'add-interactive.c',
-  'add-patch.c',
-  'advice.c',
-  'alias.c',
-  'alloc.c',
-  'apply.c',
-  'archive-tar.c',
-  'archive-zip.c',
-  'archive.c',
-  'attr.c',
-  'base85.c',
-  'bisect.c',
-  'blame.c',
-  'blob.c',
-  'bloom.c',
-  'branch.c',
-  'bundle-uri.c',
-  'bundle.c',
-  'cache-tree.c',
-  'cbtree.c',
-  'chdir-notify.c',
-  'checkout.c',
-  'chunk-format.c',
-  'color.c',
-  'column.c',
-  'combine-diff.c',
-  'commit-graph.c',
-  'commit-reach.c',
-  'commit.c',
-  'common-exit.c',
-  'common-init.c',
-  'compiler-tricks/not-constant.c',
-  'config.c',
-  'connect.c',
-  'connected.c',
-  'convert.c',
-  'copy.c',
-  'credential.c',
-  'csum-file.c',
-  'ctype.c',
-  'date.c',
-  'decorate.c',
-  'delta-islands.c',
-  'diagnose.c',
-  'diff-delta.c',
-  'diff-merges.c',
-  'diff-lib.c',
-  'diff-no-index.c',
-  'diff.c',
-  'diffcore-break.c',
-  'diffcore-delta.c',
-  'diffcore-order.c',
-  'diffcore-pickaxe.c',
-  'diffcore-rename.c',
-  'diffcore-rotate.c',
-  'dir-iterator.c',
-  'dir.c',
-  'editor.c',
-  'entry.c',
-  'environment.c',
-  'ewah/bitmap.c',
-  'ewah/ewah_bitmap.c',
-  'ewah/ewah_io.c',
-  'ewah/ewah_rlw.c',
-  'exec-cmd.c',
-  'fetch-negotiator.c',
-  'fetch-pack.c',
-  'fmt-merge-msg.c',
-  'fsck.c',
-  'fsmonitor.c',
-  'fsmonitor-ipc.c',
-  'fsmonitor-settings.c',
-  'gettext.c',
-  'git-zlib.c',
-  'gpg-interface.c',
-  'graph.c',
-  'grep.c',
-  'hash-lookup.c',
-  'hash.c',
-  'hashmap.c',
-  'help.c',
-  'hex.c',
-  'hex-ll.c',
-  'hook.c',
-  'ident.c',
-  'json-writer.c',
-  'kwset.c',
-  'levenshtein.c',
-  'line-log.c',
-  'line-range.c',
-  'linear-assignment.c',
-  'list-objects-filter-options.c',
-  'list-objects-filter.c',
-  'list-objects.c',
-  'lockfile.c',
-  'log-tree.c',
-  'loose.c',
-  'ls-refs.c',
-  'mailinfo.c',
-  'mailmap.c',
-  'match-trees.c',
-  'mem-pool.c',
-  'merge-blobs.c',
-  'merge-ll.c',
-  'merge-ort.c',
-  'merge-ort-wrappers.c',
-  'merge.c',
-  'midx.c',
-  'midx-write.c',
-  'name-hash.c',
-  'negotiator/default.c',
-  'negotiator/noop.c',
-  'negotiator/skipping.c',
-  'notes-cache.c',
-  'notes-merge.c',
-  'notes-utils.c',
-  'notes.c',
-  'object-file-convert.c',
-  'object-file.c',
-  'object-name.c',
-  'object.c',
-  'odb.c',
-  'odb/source.c',
-  'odb/source-files.c',
-  'odb/source-inmemory.c',
-  'odb/source-loose.c',
-  'odb/source-packed.c',
-  'odb/streaming.c',
-  'odb/transaction.c',
-  'oid-array.c',
-  'oidmap.c',
-  'oidset.c',
-  'oidtree.c',
-  'pack-bitmap-write.c',
-  'pack-bitmap.c',
-  'pack-check.c',
-  'pack-mtimes.c',
-  'pack-objects.c',
-  'pack-refs.c',
-  'pack-revindex.c',
-  'pack-write.c',
-  'packfile.c',
-  'packfile-list.c',
-  'pager.c',
-  'parallel-checkout.c',
-  'parse.c',
-  'parse-options-cb.c',
-  'parse-options.c',
-  'patch-delta.c',
-  'patch-ids.c',
-  'path.c',
-  'path-walk.c',
-  'pathspec.c',
-  'pkt-line.c',
-  'preload-index.c',
-  'pretty.c',
-  'prio-queue.c',
-  'progress.c',
-  'promisor-remote.c',
-  'prompt.c',
-  'protocol.c',
-  'protocol-caps.c',
-  'prune-packed.c',
-  'pseudo-merge.c',
-  'quote.c',
-  'range-diff.c',
-  'reachable.c',
-  'read-cache.c',
-  'rebase-interactive.c',
-  'rebase.c',
-  'ref-filter.c',
-  'reflog-walk.c',
-  'reflog.c',
-  'refs.c',
-  'refs/debug.c',
-  'refs/files-backend.c',
-  'refs/reftable-backend.c',
-  'refs/iterator.c',
-  'refs/packed-backend.c',
-  'refs/ref-cache.c',
-  'refspec.c',
-  'reftable/basics.c',
-  'reftable/error.c',
-  'reftable/block.c',
-  'reftable/blocksource.c',
-  'reftable/fsck.c',
-  'reftable/iter.c',
-  'reftable/merged.c',
-  'reftable/pq.c',
-  'reftable/record.c',
-  'reftable/stack.c',
-  'reftable/system.c',
-  'reftable/table.c',
-  'reftable/tree.c',
-  'reftable/writer.c',
-  'remote.c',
-  'repack.c',
-  'repack-cruft.c',
-  'repack-filtered.c',
-  'repack-geometry.c',
-  'repack-midx.c',
-  'repack-promisor.c',
-  'replace-object.c',
-  'replay.c',
-  'repo-settings.c',
-  'repository.c',
-  'rerere.c',
-  'reset.c',
-  'resolve-undo.c',
-  'revision.c',
-  'run-command.c',
-  'send-pack.c',
-  'sequencer.c',
-  'serve.c',
-  'server-info.c',
-  'setup.c',
-  'shallow.c',
-  'sideband.c',
-  'sigchain.c',
-  'sparse-index.c',
-  'split-index.c',
-  'stable-qsort.c',
-  'statinfo.c',
-  'strbuf.c',
-  'string-list.c',
-  'strmap.c',
-  'strvec.c',
-  'sub-process.c',
-  'submodule-config.c',
-  'submodule.c',
-  'symlinks.c',
-  'tag.c',
-  'tempfile.c',
-  'thread-utils.c',
-  'tmp-objdir.c',
-  'trace.c',
-  'trace2.c',
-  'trace2/tr2_cfg.c',
-  'trace2/tr2_cmd_name.c',
-  'trace2/tr2_ctr.c',
-  'trace2/tr2_dst.c',
-  'trace2/tr2_sid.c',
-  'trace2/tr2_sysenv.c',
-  'trace2/tr2_tbuf.c',
-  'trace2/tr2_tgt_event.c',
-  'trace2/tr2_tgt_normal.c',
-  'trace2/tr2_tgt_perf.c',
-  'trace2/tr2_tls.c',
-  'trace2/tr2_tmr.c',
-  'trailer.c',
-  'transport-helper.c',
-  'transport.c',
-  'tree-diff.c',
-  'tree-walk.c',
-  'tree.c',
-  'unpack-trees.c',
-  'upload-pack.c',
-  'url.c',
-  'urlmatch.c',
-  'usage.c',
-  'userdiff.c',
-  'utf8.c',
-  'version.c',
-  'versioncmp.c',
-  'walker.c',
-  'wildmatch.c',
-  'worktree.c',
-  'wrapper.c',
-  'write-or-die.c',
-  'ws.c',
-  'wt-status.c',
-  'xdiff-interface.c',
-  'xdiff/xdiffi.c',
-  'xdiff/xemit.c',
-  'xdiff/xhistogram.c',
-  'xdiff/xmerge.c',
-  'xdiff/xpatience.c',
-  'xdiff/xprepare.c',
-  'xdiff/xutils.c',
+  'lib/abspath.c',
+  'lib/add-interactive.c',
+  'lib/add-patch.c',
+  'lib/advice.c',
+  'lib/alias.c',
+  'lib/alloc.c',
+  'lib/apply.c',
+  'lib/archive-tar.c',
+  'lib/archive-zip.c',
+  'lib/archive.c',
+  'lib/attr.c',
+  'lib/base85.c',
+  'lib/bisect.c',
+  'lib/blame.c',
+  'lib/blob.c',
+  'lib/bloom.c',
+  'lib/branch.c',
+  'lib/bundle-uri.c',
+  'lib/bundle.c',
+  'lib/cache-tree.c',
+  'lib/cbtree.c',
+  'lib/chdir-notify.c',
+  'lib/checkout.c',
+  'lib/chunk-format.c',
+  'lib/color.c',
+  'lib/column.c',
+  'lib/combine-diff.c',
+  'lib/commit-graph.c',
+  'lib/commit-reach.c',
+  'lib/commit.c',
+  'lib/common-exit.c',
+  'lib/common-init.c',
+  'lib/compiler-tricks/not-constant.c',
+  'lib/config.c',
+  'lib/connect.c',
+  'lib/connected.c',
+  'lib/convert.c',
+  'lib/copy.c',
+  'lib/credential.c',
+  'lib/csum-file.c',
+  'lib/ctype.c',
+  'lib/date.c',
+  'lib/decorate.c',
+  'lib/delta-islands.c',
+  'lib/diagnose.c',
+  'lib/diff-delta.c',
+  'lib/diff-merges.c',
+  'lib/diff-lib.c',
+  'lib/diff-no-index.c',
+  'lib/diff.c',
+  'lib/diffcore-break.c',
+  'lib/diffcore-delta.c',
+  'lib/diffcore-order.c',
+  'lib/diffcore-pickaxe.c',
+  'lib/diffcore-rename.c',
+  'lib/diffcore-rotate.c',
+  'lib/dir-iterator.c',
+  'lib/dir.c',
+  'lib/editor.c',
+  'lib/entry.c',
+  'lib/environment.c',
+  'lib/ewah/bitmap.c',
+  'lib/ewah/ewah_bitmap.c',
+  'lib/ewah/ewah_io.c',
+  'lib/ewah/ewah_rlw.c',
+  'lib/exec-cmd.c',
+  'lib/fetch-negotiator.c',
+  'lib/fetch-pack.c',
+  'lib/fmt-merge-msg.c',
+  'lib/fsck.c',
+  'lib/fsmonitor.c',
+  'lib/fsmonitor-ipc.c',
+  'lib/fsmonitor-settings.c',
+  'lib/gettext.c',
+  'lib/git-zlib.c',
+  'lib/gpg-interface.c',
+  'lib/graph.c',
+  'lib/grep.c',
+  'lib/hash-lookup.c',
+  'lib/hash.c',
+  'lib/hashmap.c',
+  'lib/help.c',
+  'lib/hex.c',
+  'lib/hex-ll.c',
+  'lib/hook.c',
+  'lib/ident.c',
+  'lib/json-writer.c',
+  'lib/kwset.c',
+  'lib/levenshtein.c',
+  'lib/line-log.c',
+  'lib/line-range.c',
+  'lib/linear-assignment.c',
+  'lib/list-objects-filter-options.c',
+  'lib/list-objects-filter.c',
+  'lib/list-objects.c',
+  'lib/lockfile.c',
+  'lib/log-tree.c',
+  'lib/loose.c',
+  'lib/ls-refs.c',
+  'lib/mailinfo.c',
+  'lib/mailmap.c',
+  'lib/match-trees.c',
+  'lib/mem-pool.c',
+  'lib/merge-blobs.c',
+  'lib/merge-ll.c',
+  'lib/merge-ort.c',
+  'lib/merge-ort-wrappers.c',
+  'lib/merge.c',
+  'lib/midx.c',
+  'lib/midx-write.c',
+  'lib/name-hash.c',
+  'lib/negotiator/default.c',
+  'lib/negotiator/noop.c',
+  'lib/negotiator/skipping.c',
+  'lib/notes-cache.c',
+  'lib/notes-merge.c',
+  'lib/notes-utils.c',
+  'lib/notes.c',
+  'lib/object-file-convert.c',
+  'lib/object-file.c',
+  'lib/object-name.c',
+  'lib/object.c',
+  'lib/odb.c',
+  'lib/odb/source.c',
+  'lib/odb/source-files.c',
+  'lib/odb/source-inmemory.c',
+  'lib/odb/source-loose.c',
+  'lib/odb/source-packed.c',
+  'lib/odb/streaming.c',
+  'lib/odb/transaction.c',
+  'lib/oid-array.c',
+  'lib/oidmap.c',
+  'lib/oidset.c',
+  'lib/oidtree.c',
+  'lib/pack-bitmap-write.c',
+  'lib/pack-bitmap.c',
+  'lib/pack-check.c',
+  'lib/pack-mtimes.c',
+  'lib/pack-objects.c',
+  'lib/pack-refs.c',
+  'lib/pack-revindex.c',
+  'lib/pack-write.c',
+  'lib/packfile.c',
+  'lib/packfile-list.c',
+  'lib/pager.c',
+  'lib/parallel-checkout.c',
+  'lib/parse.c',
+  'lib/parse-options-cb.c',
+  'lib/parse-options.c',
+  'lib/patch-delta.c',
+  'lib/patch-ids.c',
+  'lib/path.c',
+  'lib/path-walk.c',
+  'lib/pathspec.c',
+  'lib/pkt-line.c',
+  'lib/preload-index.c',
+  'lib/pretty.c',
+  'lib/prio-queue.c',
+  'lib/progress.c',
+  'lib/promisor-remote.c',
+  'lib/prompt.c',
+  'lib/protocol.c',
+  'lib/protocol-caps.c',
+  'lib/prune-packed.c',
+  'lib/pseudo-merge.c',
+  'lib/quote.c',
+  'lib/range-diff.c',
+  'lib/reachable.c',
+  'lib/read-cache.c',
+  'lib/rebase-interactive.c',
+  'lib/rebase.c',
+  'lib/ref-filter.c',
+  'lib/reflog-walk.c',
+  'lib/reflog.c',
+  'lib/refs.c',
+  'lib/refs/debug.c',
+  'lib/refs/files-backend.c',
+  'lib/refs/reftable-backend.c',
+  'lib/refs/iterator.c',
+  'lib/refs/packed-backend.c',
+  'lib/refs/ref-cache.c',
+  'lib/refspec.c',
+  'lib/reftable/basics.c',
+  'lib/reftable/error.c',
+  'lib/reftable/block.c',
+  'lib/reftable/blocksource.c',
+  'lib/reftable/fsck.c',
+  'lib/reftable/iter.c',
+  'lib/reftable/merged.c',
+  'lib/reftable/pq.c',
+  'lib/reftable/record.c',
+  'lib/reftable/stack.c',
+  'lib/reftable/system.c',
+  'lib/reftable/table.c',
+  'lib/reftable/tree.c',
+  'lib/reftable/writer.c',
+  'lib/remote.c',
+  'lib/repack.c',
+  'lib/repack-cruft.c',
+  'lib/repack-filtered.c',
+  'lib/repack-geometry.c',
+  'lib/repack-midx.c',
+  'lib/repack-promisor.c',
+  'lib/replace-object.c',
+  'lib/replay.c',
+  'lib/repo-settings.c',
+  'lib/repository.c',
+  'lib/rerere.c',
+  'lib/reset.c',
+  'lib/resolve-undo.c',
+  'lib/revision.c',
+  'lib/run-command.c',
+  'lib/send-pack.c',
+  'lib/sequencer.c',
+  'lib/serve.c',
+  'lib/server-info.c',
+  'lib/setup.c',
+  'lib/shallow.c',
+  'lib/sideband.c',
+  'lib/sigchain.c',
+  'lib/sparse-index.c',
+  'lib/split-index.c',
+  'lib/stable-qsort.c',
+  'lib/statinfo.c',
+  'lib/strbuf.c',
+  'lib/string-list.c',
+  'lib/strmap.c',
+  'lib/strvec.c',
+  'lib/sub-process.c',
+  'lib/submodule-config.c',
+  'lib/submodule.c',
+  'lib/symlinks.c',
+  'lib/tag.c',
+  'lib/tempfile.c',
+  'lib/thread-utils.c',
+  'lib/tmp-objdir.c',
+  'lib/trace.c',
+  'lib/trace2.c',
+  'lib/trace2/tr2_cfg.c',
+  'lib/trace2/tr2_cmd_name.c',
+  'lib/trace2/tr2_ctr.c',
+  'lib/trace2/tr2_dst.c',
+  'lib/trace2/tr2_sid.c',
+  'lib/trace2/tr2_sysenv.c',
+  'lib/trace2/tr2_tbuf.c',
+  'lib/trace2/tr2_tgt_event.c',
+  'lib/trace2/tr2_tgt_normal.c',
+  'lib/trace2/tr2_tgt_perf.c',
+  'lib/trace2/tr2_tls.c',
+  'lib/trace2/tr2_tmr.c',
+  'lib/trailer.c',
+  'lib/transport-helper.c',
+  'lib/transport.c',
+  'lib/tree-diff.c',
+  'lib/tree-walk.c',
+  'lib/tree.c',
+  'lib/unpack-trees.c',
+  'lib/upload-pack.c',
+  'lib/url.c',
+  'lib/urlmatch.c',
+  'lib/usage.c',
+  'lib/userdiff.c',
+  'lib/utf8.c',
+  'lib/version.c',
+  'lib/versioncmp.c',
+  'lib/walker.c',
+  'lib/wildmatch.c',
+  'lib/worktree.c',
+  'lib/wrapper.c',
+  'lib/write-or-die.c',
+  'lib/ws.c',
+  'lib/wt-status.c',
+  'lib/xdiff-interface.c',
+  'lib/xdiff/xdiffi.c',
+  'lib/xdiff/xemit.c',
+  'lib/xdiff/xhistogram.c',
+  'lib/xdiff/xmerge.c',
+  'lib/xdiff/xpatience.c',
+  'lib/xdiff/xprepare.c',
+  'lib/xdiff/xutils.c',
 ]
 
 libgit_sources += custom_target(
@@ -713,17 +713,16 @@ builtin_sources = [
 ]
 
 third_party_excludes = [
-  ':!contrib',
-  ':!compat/inet_ntop.c',
-  ':!compat/inet_pton.c',
-  ':!compat/obstack.*',
-  ':!compat/poll',
-  ':!compat/regex',
-  ':!sha1collisiondetection',
-  ':!sha1dc',
+  ':!lib/contrib',
+  ':!lib/compat/inet_ntop.c',
+  ':!lib/compat/inet_pton.c',
+  ':!lib/compat/obstack.*',
+  ':!lib/compat/poll',
+  ':!lib/compat/regex',
+  ':!lib/sha1collisiondetection',
+  ':!lib/sha1dc',
   ':!t/unit-tests/clar',
   ':!t/t[0-9][0-9][0-9][0-9]*',
-  ':!xdiff',
 ]
 
 headers_to_check = []
@@ -840,7 +839,7 @@ if help_format_opt != 'man'
     libgit_c_args += '-DDEFAULT_HELP_FORMAT="' + help_format_opt + '"'
 endif
 
-libgit_include_directories = [ '.' ]
+libgit_include_directories = [ 'lib' ]
 libgit_dependencies = [ ]
 
 # Treat any warning level above 1 the same as we treat DEVELOPER=1 in our
@@ -1189,8 +1188,8 @@ endif
 
 if not has_poll_h and not has_sys_poll_h
   libgit_c_args += '-DNO_POLL'
-  compat_sources += 'compat/poll/poll.c'
-  libgit_include_directories += 'compat/poll'
+  compat_sources += 'lib/compat/poll/poll.c'
+  libgit_include_directories += 'lib/compat/poll'
 endif
 
 if not compiler.has_header('inttypes.h')
@@ -1205,7 +1204,7 @@ endif
 # implementation to threat things like drive prefixes specially.
 if host_machine.system() == 'windows' or not compiler.has_header('libgen.h')
   libgit_c_args += '-DNO_LIBGEN_H'
-  compat_sources += 'compat/basename.c'
+  compat_sources += 'lib/compat/basename.c'
 endif
 
 if compiler.has_header('paths.h')
@@ -1235,7 +1234,7 @@ if host_machine.system() != 'windows'
   foreach symbol : ['inet_ntop', 'inet_pton', 'hstrerror']
     if not compiler.has_function(symbol, dependencies: networking_dependencies)
       libgit_c_args += '-DNO_' + symbol.to_upper()
-      compat_sources += 'compat/' + symbol + '.c'
+      compat_sources += 'lib/compat/' + symbol + '.c'
     endif
   endforeach
 endif
@@ -1267,8 +1266,8 @@ endif
 
 if compiler.has_function('socket', dependencies: networking_dependencies)
   libgit_sources += [
-    'unix-socket.c',
-    'unix-stream-server.c',
+    'lib/unix-socket.c',
+    'lib/unix-stream-server.c',
   ]
   build_options_config.set('NO_UNIX_SOCKETS', '')
 else
@@ -1277,7 +1276,7 @@ else
 endif
 
 if host_machine.system() == 'darwin'
-  compat_sources += 'compat/precompose_utf8.c'
+  compat_sources += 'lib/compat/precompose_utf8.c'
   libgit_c_args += '-DPRECOMPOSE_UNICODE'
   libgit_c_args += '-DPROTECT_HFS_DEFAULT'
 endif
@@ -1285,17 +1284,17 @@ endif
 # Configure general compatibility wrappers.
 if host_machine.system() == 'cygwin'
   compat_sources += [
-    'compat/win32/path-utils.c',
+    'lib/compat/win32/path-utils.c',
   ]
 elif host_machine.system() == 'windows'
   compat_sources += [
-    'compat/winansi.c',
-    'compat/win32/dirent.c',
-    'compat/win32/flush.c',
-    'compat/win32/path-utils.c',
-    'compat/win32/pthread.c',
-    'compat/win32/syslog.c',
-    'compat/win32mmap.c',
+    'lib/compat/winansi.c',
+    'lib/compat/win32/dirent.c',
+    'lib/compat/win32/flush.c',
+    'lib/compat/win32/path-utils.c',
+    'lib/compat/win32/pthread.c',
+    'lib/compat/win32/syslog.c',
+    'lib/compat/win32mmap.c',
   ]
 
   libgit_c_args += [
@@ -1311,23 +1310,23 @@ elif host_machine.system() == 'windows'
   ]
 
   libgit_dependencies += compiler.find_library('ntdll')
-  libgit_include_directories += 'compat/win32'
+  libgit_include_directories += 'lib/compat/win32'
   if compiler.get_id() == 'msvc'
-    libgit_include_directories += 'compat/vcbuild/include'
-    compat_sources += 'compat/msvc.c'
+    libgit_include_directories += 'lib/compat/vcbuild/include'
+    compat_sources += 'lib/compat/msvc.c'
   else
-    compat_sources += 'compat/mingw.c'
+    compat_sources += 'lib/compat/mingw.c'
   endif
 endif
 
 if host_machine.system() == 'linux'
-  compat_sources += 'compat/linux/procinfo.c'
+  compat_sources += 'lib/compat/linux/procinfo.c'
 elif host_machine.system() == 'windows'
-  compat_sources += 'compat/win32/trace2_win32_process_info.c'
+  compat_sources += 'lib/compat/win32/trace2_win32_process_info.c'
 elif host_machine.system() == 'darwin'
-  compat_sources += 'compat/darwin/procinfo.c'
+  compat_sources += 'lib/compat/darwin/procinfo.c'
 else
-  compat_sources += 'compat/stub/procinfo.c'
+  compat_sources += 'lib/compat/stub/procinfo.c'
 endif
 
 if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
@@ -1341,14 +1340,14 @@ endif
 # Configure the simple-ipc subsystem required fro the fsmonitor.
 if host_machine.system() == 'windows'
   compat_sources += [
-    'compat/simple-ipc/ipc-shared.c',
-    'compat/simple-ipc/ipc-win32.c',
+    'lib/compat/simple-ipc/ipc-shared.c',
+    'lib/compat/simple-ipc/ipc-win32.c',
   ]
   libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
 else
   compat_sources += [
-    'compat/simple-ipc/ipc-shared.c',
-    'compat/simple-ipc/ipc-unix-socket.c',
+    'lib/compat/simple-ipc/ipc-shared.c',
+    'lib/compat/simple-ipc/ipc-unix-socket.c',
   ]
   libgit_c_args += '-DSUPPORTS_SIMPLE_IPC'
 endif
@@ -1372,11 +1371,11 @@ if fsmonitor_backend != ''
   libgit_c_args += '-DHAVE_FSMONITOR_OS_SETTINGS'
 
   compat_sources += [
-    'compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
-    'compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
-    'compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
+    'lib/compat/fsmonitor/fsm-health-' + fsmonitor_backend + '.c',
+    'lib/compat/fsmonitor/fsm-ipc-' + fsmonitor_os + '.c',
+    'lib/compat/fsmonitor/fsm-listen-' + fsmonitor_backend + '.c',
+    'lib/compat/fsmonitor/fsm-path-utils-' + fsmonitor_backend + '.c',
+    'lib/compat/fsmonitor/fsm-settings-' + fsmonitor_os + '.c',
   ]
 endif
 build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
@@ -1387,7 +1386,7 @@ if not get_option('b_sanitize').contains('address') and get_option('regex').allo
 
   if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
     libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
-    compat_sources += 'compat/regcomp_enhanced.c'
+    compat_sources += 'lib/compat/regcomp_enhanced.c'
   endif
 elif not get_option('regex').enabled()
   libgit_c_args += [
@@ -1396,13 +1395,13 @@ elif not get_option('regex').enabled()
     '-DNO_MBSUPPORT',
   ]
   build_options_config.set('NO_REGEX', '1')
-  compat_sources += 'compat/regex/regex.c'
-  libgit_include_directories += 'compat/regex'
+  compat_sources += 'lib/compat/regex/regex.c'
+  libgit_include_directories += 'lib/compat/regex'
 else
     error('Native regex support requested but not found')
 endif
 
-# setitimer and friends are provided by compat/mingw.c.
+# setitimer and friends are provided by lib/compat/mingw.c.
 if host_machine.system() != 'windows'
   if not compiler.compiles('''
     #include <sys/time.h>
@@ -1460,7 +1459,7 @@ else
 
   if get_option('b_sanitize').contains('address') or get_option('b_sanitize').contains('leak')
     libgit_c_args += '-DNO_MMAP'
-    compat_sources += 'compat/mmap.c'
+    compat_sources += 'lib/compat/mmap.c'
   else
     checkfuncs += { 'mmap': ['mmap.c'] }
   endif
@@ -1470,7 +1469,7 @@ foreach func, impls : checkfuncs
   if not compiler.has_function(func)
     libgit_c_args += '-DNO_' + func.to_upper()
     foreach impl : impls
-      compat_sources += 'compat/' + impl
+      compat_sources += 'lib/compat/' + impl
     endforeach
   endif
 endforeach
@@ -1481,13 +1480,13 @@ endif
 
 if not compiler.has_function('strdup')
   libgit_c_args += '-DOVERRIDE_STRDUP'
-  compat_sources += 'compat/strdup.c'
+  compat_sources += 'lib/compat/strdup.c'
 endif
 
 if not compiler.has_function('qsort')
   libgit_c_args += '-DINTERNAL_QSORT'
 endif
-compat_sources += 'compat/qsort_s.c'
+compat_sources += 'lib/compat/qsort_s.c'
 
 if compiler.has_function('getdelim')
   libgit_c_args += '-DHAVE_GETDELIM'
@@ -1543,7 +1542,7 @@ if meson.can_run_host_binaries() and compiler.run('''
   }
 ''', name: 'fread reads directories').returncode() == 0
   libgit_c_args += '-DFREAD_READS_DIRECTORIES'
-  compat_sources += 'compat/fopen.c'
+  compat_sources += 'lib/compat/fopen.c'
 endif
 
 if not meson.is_cross_build() and fs.exists('/dev/tty')
@@ -1596,9 +1595,9 @@ if sha1_backend == 'sha1dc'
   libgit_c_args += '-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="git-compat-util.h"'
 
   libgit_sources += [
-    'sha1dc_git.c',
-    'sha1dc/sha1.c',
-    'sha1dc/ubc_check.c',
+    'lib/sha1dc_git.c',
+    'lib/sha1dc/sha1.c',
+    'lib/sha1dc/ubc_check.c',
   ]
 endif
 if sha1_backend == 'CommonCrypto' or sha1_unsafe_backend == 'CommonCrypto'
@@ -1631,7 +1630,7 @@ if sha1_backend == 'block' or sha1_unsafe_backend == 'block'
     libgit_c_args += '-DSHA1_BLK_UNSAFE'
   endif
 
-  libgit_sources += 'block-sha1/sha1.c'
+  libgit_sources += 'lib/block-sha1/sha1.c'
 endif
 
 if sha256_backend == 'openssl'
@@ -1647,7 +1646,7 @@ elif sha256_backend == 'gcrypt'
   libgit_c_args += '-DSHA256_GCRYPT'
 elif sha256_backend == 'block'
   libgit_c_args += '-DSHA256_BLK'
-  libgit_sources += 'sha256/block/sha256.c'
+  libgit_sources += 'lib/sha256/block/sha256.c'
 else
   error('Unhandled SHA256 backend ' + sha256_backend)
 endif
@@ -1752,7 +1751,7 @@ version_def_h = custom_target(
     '@INPUT@',
     '@OUTPUT@',
   ],
-  input: meson.current_source_dir() / 'version-def.h.in',
+  input: meson.current_source_dir() / 'lib/version-def.h.in',
   output: 'version-def.h',
   # Depend on GIT-VERSION-FILE so that we don't always try to rebuild this
   # target for the same commit.
@@ -1771,7 +1770,7 @@ if rust_option.allowed()
   endif
 else
   libgit_sources += [
-    'varint.c',
+    'lib/varint.c',
   ]
 endif
 
@@ -1894,8 +1893,8 @@ bin_wrappers += executable('scalar',
 if curl.found()
   libgit_curl = declare_dependency(
     sources: [
-      'http.c',
-      'http-walker.c',
+      'lib/http.c',
+      'lib/http-walker.c',
     ],
     dependencies: [libgit_commonmain, curl],
   )
@@ -2199,21 +2198,21 @@ if get_option('docs') != []
 endif
 
 exclude_from_check_headers = [
-  'compat/',
-  'unicode-width.h',
+  'lib/compat/',
+  'lib/unicode-width.h',
 ]
 
 if sha1_backend != 'openssl'
-  exclude_from_check_headers += 'sha1/openssl.h'
+  exclude_from_check_headers += 'lib/sha1/openssl.h'
 endif
 if sha256_backend != 'openssl'
-  exclude_from_check_headers += 'sha256/openssl.h'
+  exclude_from_check_headers += 'lib/sha256/openssl.h'
 endif
 if sha256_backend != 'nettle'
-  exclude_from_check_headers += 'sha256/nettle.h'
+  exclude_from_check_headers += 'lib/sha256/nettle.h'
 endif
 if sha256_backend != 'gcrypt'
-  exclude_from_check_headers += 'sha256/gcrypt.h'
+  exclude_from_check_headers += 'lib/sha256/gcrypt.h'
 endif
 
 if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
@@ -2248,6 +2247,7 @@ if headers_to_check.length() != 0 and compiler.get_argument_syntax() == 'gcc'
         compiler.cmd_array(),
         libgit_c_args,
         '-I', meson.project_source_root(),
+        '-I', meson.project_source_root() / 'lib',
         '-I', meson.project_source_root() / 't/unit-tests',
         '-o', '/dev/null',
         '-c', '-xc',

-- 
2.55.0.313.g8d093f411d.dirty

