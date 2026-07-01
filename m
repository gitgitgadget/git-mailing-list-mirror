Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6B3B14C1
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889182; cv=none; b=ibNRRq52xmsRMItDmxXdVGNCH+TrsLqwomjLDHkJ0XXUqsLaFKKZaGIy5rsrtkksGXWBw8CwRAUiLUJdWI68/STj30OhTXytoHZejLgEXMo67QD1Qwzm08poRBC1fycNpsne9/0yTx5T3kaZ63b51hDTyt9KGTsMoCU5cEXtZiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889182; c=relaxed/simple;
	bh=yPT2xxn1561e2CC5IHfsyMkygxo+rI1ysTAB+85bvWY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cw+oD7qpCQSuBUvgHMySzCDQd1TvRRwqh5OUMZs5cwmKOS0VdJrCcYzjeoQnOag8VA1NSP4eah3qR4PeEfwEq9/nsUE3ZhtRJ8igFglSDNF1cQbdiKvpr0nY57tfP6iWQpGDIAkjT+xr3jud+yixuCVZH9aO08Lws7UIuIq82MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DFQ30m24; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g0FXNen+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DFQ30m24";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g0FXNen+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 795441400164;
	Wed,  1 Jul 2026 02:59:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 02:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782889179;
	 x=1782975579; bh=XEQ0vh6JUMHQPLeqf75188wz0Yx1bYRlZM2L10+nTe8=; b=
	DFQ30m24NLBJf4j6gnwKJ6xPoTE9rVmWilCnp468WEVbT8wo1nN7mhWX641Ua56U
	gZVChYp2xzKlEWhl0RIhbhOPbILYZ9ZO0/vFIDXvZspVCdKdlm2dM7ucb2RW6xgU
	utJ/QYDtPUpEPy4tFiSMyxC/jBmi89+Ju3zJkjjweAmEaAF34yka5LcLrIEWGvc0
	ArHn5rWHKy0ImiPo27TlxIf9e/pib0oJ5QFO1XSM5KnWjMITdDXXYxlq4nsL1T/r
	kSuNDQBKWmKgB4nEGAi8U55+nne350f9qneetJk5F1XRrIo6nfpVedrpece+rpF6
	SzU4A3QVcaqGmq+k5W3YCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782889179; x=
	1782975579; bh=XEQ0vh6JUMHQPLeqf75188wz0Yx1bYRlZM2L10+nTe8=; b=g
	0FXNen+WqQ5NKAd813S0b1WRFO7GCJWzF3KK/pUoqUnCbGoAaMgE5/bkso2/odG0
	eN2BKBaAxbxfEsySD6/UMHwPktf9GR/Ipn1yOfB1/ufR6QjnF4byBvz75//DUO16
	sjSyfqZfzGsHOWR0YqFAtA3QwehYohzflokozqmWhwMs7coIReeo+ilqlYzd3qGE
	QRuIBbSQq43SKglk93bUQGOFivIZPgSqmD24r06btvo7e9NOvXcryImpZ/tI/4vV
	W0Wphkh0mAYXUH0q6JxMXQOYOqzvdnDOeF1NYETj5004UPE5+SSaGv/YYs/7NM52
	r4Bzd+AQU6ZIlPvJyfQyg==
X-ME-Sender: <xms:27pEaqHmr57wHV0wZoQuBJ1MxHhnMYZpPRHZDb-NZcYPOLHBKIJX2g>
    <xme:27pEalX2bknY3KmlmcvFjP4n-9FkuiQTRZjSe_k_epkCsCnT2dKiijLuaP9ymasTk
    VLRy7e7kY1sTvkDJWNssFFTVnFPnzU59vVcDbMGpOWBnffMaLoEfw>
X-ME-Received: <xmr:27pEaqzOKeoPr9-gc-eLE4BApbs9hQTdYDpU68ac-ScK_f_dhp0zeKXmZSUMClPnMSk6jWuM0FNo49icOSsIyrhyEmI-0YhrP6JCvvUL5mA>
X-ME-Proxy-Cause: dmFkZTGEyLX14Gr+1klP0i+3zUAJ6NDu0cqnWANN4Icj+b0tfHzkszjJvSJAvdve0djk9u
    BJEnuOVI38bqWbkfYqR8Il5iYueKeefX3Rf2rQut8bR+8D973Xn0OEzHgaKCH81qvZnv/T
    vUngzXTeIgqaZuKxmkk341K72LvOev7QRWMEl29YvBbSMhtNYlLsz7aBOK6Gu5dAEGYx+T
    +xHlprKqK74MgZ6W6I5rcQndTJjPjMwQvUumB4+PFhf0dsFph9h1/E8Gur5VBrFod94GgM
    sRqPNRuwTrhG41Ttbk2dmSfDJ3sRLPkK0bIhJJRHgS3Ggtz0rfUJowfStzDdSpzzQ1U+Am
    yl6AjETGqFL8cRC+REEqHcqqMT5cOZpELejY1LOKAkgKhX3Nn0pDSo7KLhWIx5xNS7PkhY
    dL7763XNMbSdnD3leMYz4SI2kte5niMZ38sCAmMpqER43qQO29uz7rFEufarsdl6XlgbXz
    3qNvirnbJHfVRZhpJ7plcizfFhbkU6WVdpFVEhpOgBsftBzv+34NNgD/2LBnc1XKDAWtHH
    JFqsfQ8aTDjd85REawWF8H4/+wSOK+gpm9qDWjhUxx9zyRS5vg+Q0FnpiiBT1yAlIDCWH5
    MfsZUfntbF+bPeaQ3MnzDbSHcmeE71jim/RnKOFzmeIceZv1wLyHXPp8DB4Q
X-ME-Proxy: <xmx:27pEaiSFw9J9vyIRCa-aGsMsDNG5PXOD0SuwXZsdnXZb-T01iHhFQA>
    <xmx:27pEauhY0d6_fT9-0VCSvBxLAvWz4M_iBgv4PB0sAjJFMiH84HCUIA>
    <xmx:27pEahkrl038Y2CP_4f920fu_bu1ZBEZzxI5wFO2UHgC_rn1ZMGmrA>
    <xmx:27pEapukP8pGCQcOqg4d54f9K25tgQqATroEXA0jDfJZgB2VXlFLvg>
    <xmx:27pEahZadPHoIPXz2ThBMMbCqEcBkqMzrirDl6O1Z-8JnkAy_UiQq9i8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 02:59:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4591f207 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 06:59:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v3 0/2] Move libgit.a sources into separate "lib/"
 directory
Date: Wed, 01 Jul 2026 08:59:25 +0200
Message-Id: <20260701-pks-libgit-in-subdir-v3-0-5e4860056094@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM66RGoC/3WNzQ6CMBAGX4X0bA0tpaAnExMfwKvxQNsF1h8gL
 TYawrtb0OhFj99mdmYgDiyCI+toIBY8OmybMJJFRHRdNBVQNGETHnMZC5bS7uzoBVWFPcWGups
 yaKnJAXQuVtqInITXzkKJ91l7IPvdlhxfx4CfQPeTcMJqdH1rH3Pcsxl+d+Tvjmc0pnFSlDpLm
 CnTdBOwJV5nv+dfg+T8j4EHg1YrIXXKADL1MYzj+ASrkqhqDgEAAA==
X-Change-ID: 20260415-pks-libgit-in-subdir-d8eec849cd48
In-Reply-To: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
References: <20260416-pks-libgit-in-subdir-v1-0-03afc731df55@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
 Derrick Stolee <stolee@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
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

Changes in v3:
  - Explicitly point out the downsides of doing this mass-rename. Please
    let me know in case any arguments are missing there.
  - Apply Dscho's fixup patch.
  - Link to v2: https://patch.msgid.link/20260622-pks-libgit-in-subdir-v2-0-cb946c51ee7b@pks.im

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

 .github/workflows/main.yml                         |   9 +-
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
 704 files changed, 824 insertions(+), 822 deletions(-)

Range-diff versus v2:

1:  67b5b03240 = 1:  d0f7d75054 t/helper: prepare "test-example-tap.c" for introduction of "lib/"
2:  77512405b6 ! 2:  ae1aba0a5b Move libgit.a sources into separate "lib/" directory
    @@ Commit message
     
         These are problems that we're aware of, and there have been and still
         are efforts to clean up some of the technical debt that is natural to
    -    exist an a project that is more than 20 years old. Furthermore, we
    +    exist in a project that is more than 20 years old. Furthermore, we
         provide resources to newcomers that help them out like our coding
         guidelines, code of conduct or "MyFirstContribution.adoc".
     
    @@ Commit message
         already. Furthermore, we can further iterate after this step and think
         about introducing a better structure for remaining files, as well.
     
    +    This move does not come for free though:
    +
    +      - The mass rename introduces a cutoff point in the history of every
    +        moved file, as tools like git-log(1) do not follow renames by
    +        default.
    +
    +      - Any in-flight or not-yet-submitted topic that touches the moved
    +        files will have to be rebased, and backporting fixes across the
    +        boundary becomes more cumbersome as a patch can no longer apply
    +        cleanly to both the old and the new layout.
    +
    +    My own (obviously subjective and biased) take is that the tradeoff is
    +    worth it, as these issues are a one-time cost while the benefits to
    +    discoverability will be permanent.
    +
    +    Furthermore, especially the first downside is a limitation in Git
    +    itself. We're not the first or last project to do such a mass rename. So
    +    if our provided tools are insufficient, then we should improve them to
    +    make the experience better for other projects, as well. Subjecting
    +    ourselves to the same pain may even give us more incentive to eventually
    +    improve rename following for everyone.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .github/workflows/main.yml ##
    @@ .github/workflows/main.yml: jobs:
          - name: download vcpkg artifacts
            uses: git-for-windows/get-azure-pipelines-artifact@v0
            with:
    -@@ .github/workflows/main.yml: jobs:
    +         repository: git/git
    +         definitionId: 9
    ++        path: lib/compat
    +     - name: add msbuild to PATH
            uses: microsoft/setup-msbuild@v3
          - name: copy dlls to root
            shell: cmd

---
base-commit: 0309c6da48e2f94a72c9cee6e95ac6a1d0d2c965
change-id: 20260415-pks-libgit-in-subdir-d8eec849cd48

