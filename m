Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936A237F8AF
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 13:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776345892; cv=none; b=uagBfftt6/2I9tLqz/PMBJsfcFwKWrcNwO/KZssZVwwu3xfcIb+wRDSs8scQmiNUkCwny9EOZbW50vt/7FB4oiHh2v8GQwiEUKjVq4UZui80xR5wwqiH6wumNfOH083EvNrYVucwIvIp5ugDUQFYL7zGzMxtz4zvLJ7m6qD91xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776345892; c=relaxed/simple;
	bh=B/l1BVAMie8zP8xbtjV9xPxsRmBunXnR9E16+pXai6s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BXXZZZ0u2Sq1VAyazZmmcM5G8pWKdsziAnIYraghM9MLI68hXzJBd67jFj02PWiH62EMcu17GsqCz4uGBRmcKQBb2mAZ4atPXgsEOmkPRsfzOBkPy/88n6biMQfWrJN1Lx6Nd5J1kXqougJApAtxDBUq3vVWAg/R6GN0ZNL0MJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eIxR+P1+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FKVQMUtS; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eIxR+P1+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FKVQMUtS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 56A6E1D001ED
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:24:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 09:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1776345885; x=1776432285; bh=Srp4MYbaE6
	8TmPTJabIPBBBvW/xd19cb1EzXgs1p3qA=; b=eIxR+P1+daiSWpMLSC8EfhguRG
	uA04GQAGhzv0R2VMa5Np73iCX2U7H8fco7bXVQZV20lh5XTTsM2Mj/qJMyfXZzNB
	aQZuHI3D2PA1tdYNQIXqJBlBm8JBGmhO7dHNmq+LnurVu+xzK6YXjZnCJsT6yTEW
	cfHXLL/Q/9dUiTkY0fTCSUOswEOFlhzEzb+d4oxuSThDmnH+yKcW6zvDlJxxAGLe
	BW9WaCR9EKLFyYYrzHSrY6Q8WAIm1baU4pdlV70lF8CqSjY0s3t2vT0KY4FBfFPn
	1dnjeqkg/ivhy9BWHHe0SAtDnkH0YH1zvUUKJJmiA1d3vUQJafw4LozhQ1yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776345885; x=1776432285; bh=Srp4MYbaE68TmPTJabIPBBBvW/xd
	19cb1EzXgs1p3qA=; b=FKVQMUtSx3cm3i211aJ4sBN7ebbbPXFTSJxsHHuf2ojp
	D7PQuNfWiF5BrSuCREMgolCKmSjXg5Eczk9KQXcQdUAY2P+U1EPuTEp+n9jHSo4c
	9Hv0l0x89lXUC2eG71uZM5EAVHZerTM2e3+vW6YxeIO81NtCOwMqXbuYqrcDlKEG
	znwSh6KYF3SMt/OogFPeqtCuRHaEndkMAfxPAzzbnu/cPYj+UqgoMcaF8MblStY5
	BIlvDskiTODQws4lORiqCqVxs6o63XQ8Of/C9bsMu2plKk5m5z8aHDAWYVgHTsnH
	4azChHTUjNzQvg/JFylCGpMwl6Pgve5aYwS4ltCdxw==
X-ME-Sender: <xms:HePgaX41laDLoA3qE2I3eKpP33fZ6_hs3YZnWFRdgDNAUyKj0Hvlnw>
    <xme:HePgaT0PX6j4xEysPf2JCFpgf363okKPL0ENBjbBd10llghVW-qbddjHVtgE_Tcsq
    kYjI32hsScI23KLHJJJc5QW6iK9uUH4eWjaUyUBUMxK_LQqLkJ9XA>
X-ME-Received: <xmr:HePgaUG2iIa3vw-8SAt8ItXSwFckqCiCWatU7z0mDGRGwZBEdAI9qQ2bUOYBPeADl0Lh6qcchVUnjtMtGHnbOwU75jYwqsHv-qQ1rsZdGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffufffkgggtgffvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeettddtvdeguefftddtvefhkefggfetveefvedtud
    etjedujedvudefudegffevtdenucffohhmrghinhepghhithhlrggsrdgtohhmpdhgihht
    hhhusgdrtghomhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:HePgadSAVeYRYVJHKfNmgj8eCBs-q6hr6oZHuTjguAhBdWrnQecdIw>
    <xmx:HePgabBHuyB2EYha6XjQhOHH2MRYLYizQRhHrWy7DY8ryhS7THFwHQ>
    <xmx:HePgad2SEKoUApLe9xSWtjvGq58km8svUxVQ4X7rcIvflFiZAqZBkA>
    <xmx:HePgaZUfvGUWPhhE2StRYF9OTQpgSL8vkJMZZ_rcM0gLD2yDwGWMXw>
    <xmx:HePgaUatu2jOpN_zDDCGb0WqIiCjDAC4fiosv3KP1cBUZhsicNauIpvN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Apr 2026 09:24:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9fff9fce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Apr 2026 13:24:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC 0/2] Move libgit.a sources into separate "lib/"
 directory
Date: Thu, 16 Apr 2026 15:24:29 +0200
Message-Id: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA7j4GkC/yWMQQrCMBREr1Jm7Ye2RIluBQ/gVlzY5FtHJZb8K
 kLp3Y26fMO8N8E0Uw2bakLWF42PVKBZVAiXU+pVGAujrdtV7ZqlDDeTO7ueozCJPbvILNGrBu/
 WITqPog5Zz3z/sgfsd1sc/2O5XzWM3yDm+QPH5L8KfQAAAA==
X-Change-ID: 20260415-pks-libgit-in-subdir-d8eec849cd48
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

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
 Makefile                                           | 762 ++++++++++-----------
 config.mak.uname                                   |  52 +-
 contrib/buildsystems/CMakeLists.txt                | 107 +--
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
 .../compat}/fsmonitor/fsm-health-win32.c           |   0
 {compat => lib/compat}/fsmonitor/fsm-health.h      |   0
 {compat => lib/compat}/fsmonitor/fsm-ipc-darwin.c  |   0
 {compat => lib/compat}/fsmonitor/fsm-ipc-win32.c   |   0
 .../compat}/fsmonitor/fsm-listen-darwin.c          |   0
 .../compat}/fsmonitor/fsm-listen-win32.c           |   0
 {compat => lib/compat}/fsmonitor/fsm-listen.h      |   0
 .../compat}/fsmonitor/fsm-path-utils-darwin.c      |   0
 .../compat}/fsmonitor/fsm-path-utils-win32.c       |   0
 .../compat}/fsmonitor/fsm-settings-darwin.c        |   0
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
 {compat => lib/compat}/nedmalloc/License.txt       |   0
 {compat => lib/compat}/nedmalloc/Readme.txt        |   0
 {compat => lib/compat}/nedmalloc/malloc.c.h        |   0
 {compat => lib/compat}/nedmalloc/nedmalloc.c       |   0
 {compat => lib/compat}/nedmalloc/nedmalloc.h       |   0
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
 {odb => lib/odb}/source.c                          |   0
 {odb => lib/odb}/source.h                          |   0
 {odb => lib/odb}/streaming.c                       |   0
 {odb => lib/odb}/streaming.h                       |   0
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
 meson.build                                        | 684 +++++++++---------
 t/helper/test-example-tap.c                        |   2 +-
 695 files changed, 820 insertions(+), 819 deletions(-)


---
base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
change-id: 20260415-pks-libgit-in-subdir-d8eec849cd48

