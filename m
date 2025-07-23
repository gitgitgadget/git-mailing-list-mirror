Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9F290BA2
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279718; cv=none; b=AVyvmG7l8LG7OIgKRI9PAmYflMsGVVPbhFHRP8i/F5XgQKx5nbPfgl4jFHCDVENSbtegeyMJuIrEO7QcI/KVRcmApITnVW0Pl5xlEWRcEBejoYVKCJjS37cSnjhPN6vx9H3mQMfFLvKtkI3Rbw4k/ROFz3DJAml21e7zV8gcT6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279718; c=relaxed/simple;
	bh=QemnKG3K6W9+0Ecjekf5sy5/xAD3TOtWeUPDiwAfzpI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=I0htlLyWcS93AQBZsUjQb/LSzQ6/Xf21iJVdZiV9MpuYyWEBLIQ9/dOGFPNvHj9rXmi+8lKinxuPRRCr2NxNXLvve4TwqIXwtE7u5TCfhUvQAjkHyZe64mY/dWOpAkkZhvy9TU4Xstou6JrVj4+KIE6yXm0PigBkZcDPEtXm1xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IcyEPRXo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3gifmCe; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IcyEPRXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3gifmCe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7583EEC19E3;
	Wed, 23 Jul 2025 10:08:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 23 Jul 2025 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279711;
	 x=1753366111; bh=d0+R/aeBcefNRiEcYzHyfgkaiehXzh2cJxbZqAf65VY=; b=
	IcyEPRXoN8X7mXj697MhSOw6zNdsr98+IS5Abv4kfoY5nlpGMmTLOI3+u6bsrTli
	7qM3qD+Mh5423I9KNuHDlQaYtKL9/3ppCJbdg8m/GZZTs+GgW++3CIx6JQyS6+R2
	6iERjpGTliLRE0Ye0JMTIWenGPVsS0VRZcO7Sdh3Z5V7bPg2MdYjTQzsNI0Z5zAj
	jAGwjaEwvS9Vsqo1SSlOwfk3TjlnTMLfs3GUwGLX1j7TvouPBZE8y4h13enRXoFl
	tnO8zeKgPIuTeLQsSCE0oChKPcuut5ZZAjYsfkB38Q98FEspDM0NeUD5XlOTMs0M
	DLlbbSTCw3Szx8/dGcoiZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279711; x=
	1753366111; bh=d0+R/aeBcefNRiEcYzHyfgkaiehXzh2cJxbZqAf65VY=; b=k
	3gifmCe5H3Gb18zHUq4Y4KEFHu+eJR9dgzyj+46AhlRS2/LEjeKwnhruZ6M/psJe
	lcNvtNbsAS67YxKmypVwetuIQ8ZGXjwDbgj8kcO/wVjSp6ydFXZ8RY6ZT3yTn7Yn
	s7BTSBrxLdlh1z7S6MQcRFSb3sBA7r8QsBcV0VVTuoEd6kHzKJg7frBd6N/CaySH
	wOjQhhU65q2iQo1WSUfl/cK0ZyqxJc4qoKMbRr7tYlei+DtjB3Q7pWvJQmwyV2BS
	KmgHIsmID8XTIBfrM7r10/GthHCx2GLGtHNTWa2aJftRwCYvqmLY75tK7RxMBRzh
	PvXfQcL9e4ZPqlclV9iiA==
X-ME-Sender: <xms:3-yAaJfCZ5Yrb5e1mB5UJ7bYA52UTKxMfXS-ItBBbStabeIqN0obag>
    <xme:3-yAaHZ6fswloJKuiWPgNGJ4sGC5ONeloCw6OyYAIEiPWwXtM-NUoWhDgNTJpy8P7
    1Frk4zLlc51M4fpFA>
X-ME-Received: <xmr:3-yAaEVxghTkV0KByQnMGJxnLY2_L1Sf-xNiuJTu2dyGsBgGqu91suEJIFvY0jUTCB2hvz2ep1VakFyZ7IO_3-4DGLe3ZXZI-_weCZaGGX4N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgjghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteeuueehhffhiedtueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdr
    tghomh
X-ME-Proxy: <xmx:3-yAaBi2sBij8O2wSkyZAROQdTcReIcusSSwb-f7k-MYOtsNl4JPVA>
    <xmx:3-yAaKUDj5I6V2p-7E1iaz68uidbG0PQkXpd955VKeXPcWZnfKog2A>
    <xmx:3-yAaAN-2zFc_OLDK4Yt372MBsnDKv9hFEGKRbuVWEl47-rBgDiLcg>
    <xmx:3-yAaOZQQeSKQ7zTpmEpjCuyTsMKGnHMXXW8vG7i95GE-XkufwPiaw>
    <xmx:3-yAaNtgIBNuTiJPOEa2Jn3ftdtSS225hN9wHUQSIEq7G8Ru_AVvXQCt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3027c9a4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/21] config: remove use of `the_repository`
Date: Wed, 23 Jul 2025 16:08:21 +0200
Message-Id: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANbsgGgC/32NywqDMBBFf0Vm3Skm+Ihd+R/FhZiJGUoTScS2S
 P69Uei2y3M5nLtDpMAU4VbsEGjjyN5lkJcCJju6mZB1ZpClrMtWNLg8Ik7eGZ7x5XG1hIEWH3n
 14YNSaOoq1ZmuqSEnlkCG32f+PmS2HA/vfNvEsf7C7f/wJrBErZSiahStJtFn/cpPGFJKXzy4K
 5HFAAAA
X-Change-ID: 20250716-pks-config-wo-the-repository-21de9489f965
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series removes uses of `the_repository` in "config.c". It
does this via two things:

  - By removing all the wrapper functions `git_config_get()` et al that
    implicitly rely on `the_repository`.

  - By moving the Git-specific config parsing (that is, the non-business
    logic like parsing "core.sharedRepository") into "environment.c".

This series is inspired by my painful tries yesterday to start parsing
repo settings early in the Git process lifecycle. The changes should
make it easier to eventually achieve that.

The patch series is long, but almost all of the patches are trivial as
they simply replace code like `git_config_foo(...)` with its equivalent
`repo_config_foo(the_repository, ...)`.

The series is based on top of 90c0775e972 (The eleventh batch,
2025-07-16) with bc/use-sha256-by-default-in-3.0 at c79bb70a2e7 (Enable
SHA-256 by default in breaking changes mode, 2025-07-01) merged into it
to fix a conflict with "next". There are a couple of merge conflicts
with "seen", but they are trivial to solve.

Changes in v2:
  - Fix `prepare_include_condition_pattern()`.
  - Link to v1: https://lore.kernel.org/r/20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (21):
      config: drop `git_config()` wrapper
      config: drop `git_config_clear()` wrapper
      config: drop `git_config_get()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_value()` wrapper
      config: drop `git_config_get_string_multi()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_string()` wrapper
      config: drop `git_config_get_int()` wrapper
      config: drop `git_config_get_ulong()` wrapper
      config: drop `git_config_get_bool()` wrapper
      config: drop `git_config_set_in_file()` wrapper
      config: drop `git_config_set_gently()` wrapper
      config: drop `git_config_set()` wrapper
      config: drop `git_config_set_in_file_gently()` wrapper
      config: drop `git_config_set_multivar_in_file_gently()` wrapper
      config: drop `git_config_get_multivar_gently()` wrapper
      config: drop `git_config_set_multivar()` wrapper
      config: remove unused `the_repository` wrappers
      config: move Git config parsing into "environment.c"
      config: fix sign comparison warnings

 Documentation/user-manual.adoc                 |   2 +-
 apply.c                                        |   6 +-
 archive-tar.c                                  |   2 +-
 archive-zip.c                                  |   2 +-
 archive.c                                      |   4 +-
 branch.c                                       |  10 +-
 builtin/add.c                                  |   1 +
 builtin/am.c                                   |  10 +-
 builtin/blame.c                                |   2 +-
 builtin/branch.c                               |   8 +-
 builtin/cat-file.c                             |   2 +-
 builtin/check-attr.c                           |   2 +-
 builtin/check-ignore.c                         |   3 +-
 builtin/check-mailmap.c                        |   3 +-
 builtin/checkout--worker.c                     |   3 +-
 builtin/checkout-index.c                       |   1 +
 builtin/checkout.c                             |   4 +-
 builtin/clean.c                                |   3 +-
 builtin/clone.c                                |  26 +-
 builtin/column.c                               |   4 +-
 builtin/commit-graph.c                         |   5 +-
 builtin/commit-tree.c                          |   3 +-
 builtin/commit.c                               |   4 +-
 builtin/config.c                               |  60 +--
 builtin/count-objects.c                        |   3 +-
 builtin/credential-cache--daemon.c             |   2 +-
 builtin/credential-store.c                     |   2 +-
 builtin/credential.c                           |   3 +-
 builtin/describe.c                             |   2 +-
 builtin/diff-files.c                           |   2 +-
 builtin/diff-index.c                           |   2 +-
 builtin/diff-tree.c                            |   2 +-
 builtin/diff.c                                 |   2 +-
 builtin/fast-export.c                          |   3 +-
 builtin/fast-import.c                          |  12 +-
 builtin/fetch.c                                |  10 +-
 builtin/fmt-merge-msg.c                        |   2 +-
 builtin/for-each-ref.c                         |   1 +
 builtin/fsck.c                                 |   2 +-
 builtin/fsmonitor--daemon.c                    |   3 +-
 builtin/gc.c                                   |  70 ++--
 builtin/grep.c                                 |   5 +-
 builtin/hash-object.c                          |   3 +-
 builtin/help.c                                 |   5 +-
 builtin/hook.c                                 |   3 +-
 builtin/index-pack.c                           |   2 +-
 builtin/interpret-trailers.c                   |   3 +-
 builtin/log.c                                  |  24 +-
 builtin/ls-files.c                             |   1 +
 builtin/ls-tree.c                              |   3 +-
 builtin/merge-base.c                           |   3 +-
 builtin/merge-file.c                           |   2 +-
 builtin/merge-tree.c                           |   3 +-
 builtin/merge.c                                |   2 +-
 builtin/mktag.c                                |   2 +-
 builtin/multi-pack-index.c                     |   5 +-
 builtin/mv.c                                   |   2 +-
 builtin/name-rev.c                             |   2 +-
 builtin/notes.c                                |   4 +-
 builtin/pack-objects.c                         |   2 +-
 builtin/pack-refs.c                            |   1 +
 builtin/patch-id.c                             |   3 +-
 builtin/pull.c                                 |   9 +-
 builtin/push.c                                 |   2 +-
 builtin/range-diff.c                           |   2 +-
 builtin/read-tree.c                            |   3 +-
 builtin/rebase.c                               |   4 +-
 builtin/receive-pack.c                         |   2 +-
 builtin/reflog.c                               |   2 +-
 builtin/refs.c                                 |   2 +-
 builtin/remote.c                               |  56 +--
 builtin/repack.c                               |   2 +-
 builtin/replace.c                              |   3 +-
 builtin/rerere.c                               |   2 +-
 builtin/reset.c                                |   2 +-
 builtin/rev-list.c                             |   2 +-
 builtin/rev-parse.c                            |   4 +-
 builtin/rm.c                                   |   3 +-
 builtin/send-pack.c                            |   1 +
 builtin/shortlog.c                             |   2 +-
 builtin/show-branch.c                          |   2 +-
 builtin/show-ref.c                             |   3 +-
 builtin/sparse-checkout.c                      |   2 +-
 builtin/stash.c                                |   4 +-
 builtin/stripspace.c                           |   2 +-
 builtin/submodule--helper.c                    |  56 +--
 builtin/symbolic-ref.c                         |   3 +-
 builtin/tag.c                                  |   2 +-
 builtin/unpack-file.c                          |   3 +-
 builtin/unpack-objects.c                       |   2 +-
 builtin/update-index.c                         |   2 +-
 builtin/update-ref.c                           |   3 +-
 builtin/update-server-info.c                   |   1 +
 builtin/var.c                                  |   5 +-
 builtin/verify-commit.c                        |   1 +
 builtin/verify-pack.c                          |   3 +-
 builtin/verify-tag.c                           |   1 +
 builtin/worktree.c                             |   8 +-
 builtin/write-tree.c                           |   3 +-
 checkout.c                                     |   2 +-
 commit-graph.c                                 |   1 +
 compat/precompose_utf8.c                       |   6 +-
 config.c                                       | 553 +------------------------
 config.h                                       | 139 -------
 connect.c                                      |   6 +-
 contrib/coccinelle/config_fn_ctx.pending.cocci |   2 +-
 convert.c                                      |   2 +-
 daemon.c                                       |   2 +-
 dir.c                                          |   4 +-
 editor.c                                       |   2 +-
 environment.c                                  | 512 +++++++++++++++++++++++
 environment.h                                  |   3 +
 fetch-pack.c                                   |  16 +-
 fsck.c                                         |   1 +
 fsck.h                                         |   2 +-
 fsmonitor.c                                    |   2 +-
 gpg-interface.c                                |   2 +-
 help.c                                         |   6 +-
 http-backend.c                                 |   6 +-
 http-fetch.c                                   |   3 +-
 http.c                                         |   3 +-
 imap-send.c                                    |   3 +-
 list-objects-filter-options.c                  |   6 +-
 ls-refs.c                                      |   2 +-
 mailinfo.c                                     |   1 +
 merge-ll.c                                     |   2 +-
 merge-ort.c                                    |  18 +-
 notes-utils.c                                  |   2 +-
 notes.c                                        |   2 +-
 parallel-checkout.c                            |   4 +-
 pretty.c                                       |   2 +-
 promisor-remote.c                              |   8 +-
 protocol.c                                     |   2 +-
 reachable.c                                    |   2 +-
 read-cache.c                                   |   4 +-
 rebase-interactive.c                           |   2 +-
 reflog.c                                       |   1 +
 refs.c                                         |   2 +-
 refs/packed-backend.c                          |   2 +-
 refs/reftable-backend.c                        |   2 +-
 remote.c                                       |   2 +-
 rerere.c                                       |   9 +-
 revision.c                                     |   2 +-
 run-command.c                                  |   6 +-
 scalar.c                                       |  18 +-
 sequencer.c                                    |  36 +-
 setup.c                                        |  44 +-
 sideband.c                                     |   6 +-
 submodule-config.c                             |   2 +-
 submodule.c                                    |   2 +-
 t/helper/test-advise.c                         |   3 +-
 t/helper/test-config.c                         |  20 +-
 t/helper/test-read-cache.c                     |   3 +-
 t/helper/test-userdiff.c                       |   2 +-
 t/t4256/1/mailinfo.c                           |   2 +-
 t/t4256/1/mailinfo.c.orig                      |   2 +-
 trailer.c                                      |   4 +-
 transport.c                                    |  12 +-
 versioncmp.c                                   |   4 +-
 worktree.c                                     |   8 +-
 xdiff-interface.c                              |   1 +
 161 files changed, 1015 insertions(+), 1097 deletions(-)

Range-diff versus v1:

 1:  1caf1bc3c2b =  1:  44ad8fd172e config: drop `git_config()` wrapper
 2:  e9c1afb5307 =  2:  392db3dad1a config: drop `git_config_clear()` wrapper
 3:  8beb9c49e86 =  3:  31ee448c82f config: drop `git_config_get()` wrapper
 4:  defb931ab24 =  4:  0540beca321 config: drop `git_config_get_value()` wrapper
 5:  e0f662adf59 =  5:  0fd69dac496 config: drop `git_config_get_value()` wrapper
 6:  16e10b9fcff =  6:  9d2aff44bf5 config: drop `git_config_get_string_multi()` wrapper
 7:  a4022b64c8f =  7:  34e8b394683 config: drop `git_config_get_string()` wrapper
 8:  0d8ebc40ce3 =  8:  9a374f91689 config: drop `git_config_get_string()` wrapper
 9:  5c06c8e2cc5 =  9:  5dd2f4682f7 config: drop `git_config_get_int()` wrapper
10:  522ff9be738 = 10:  30a338834a9 config: drop `git_config_get_ulong()` wrapper
11:  6b1a8c902d2 = 11:  3a723697ac3 config: drop `git_config_get_bool()` wrapper
12:  ee9e8479b40 = 12:  176d71ab70e config: drop `git_config_set_in_file()` wrapper
13:  d69766a5087 = 13:  f00c8048a9a config: drop `git_config_set_gently()` wrapper
14:  25f6c2dde6d = 14:  5db30c36fca config: drop `git_config_set()` wrapper
15:  3554ad9d8bc = 15:  33a3b8ae60f config: drop `git_config_set_in_file_gently()` wrapper
16:  deb51a25357 = 16:  d24ab4b79e5 config: drop `git_config_set_multivar_in_file_gently()` wrapper
17:  a919f54c0ec = 17:  b947eb22a27 config: drop `git_config_get_multivar_gently()` wrapper
18:  c8f314bdca3 = 18:  e69c6d8de77 config: drop `git_config_set_multivar()` wrapper
19:  3f96884550b = 19:  ff3af8ad687 config: remove unused `the_repository` wrappers
20:  a21206a973d = 20:  d9da8cdfd18 config: move Git config parsing into "environment.c"
21:  4630929ebca ! 21:  fff5f00184c config: fix sign comparison warnings
    @@ Commit message
     
         There are a couple of -Wsign-compare warnings in "config.c":
     
    -      - `prepare_include_condition_pattern()` is declared to return a signed
    -        int, but it either returns 0 or the index of the last dir separator
    -        in a path. That index will always be positive, so the return type of
    -        the function is changed to `size_t`, which allows us to drop a check
    -        for `prefix < 0` at the only callsite. Furthermore, this fixes a
    -        sign comparison warning when comparing `text.len < prefix`,
    +      - `prepare_include_condition_pattern()` is returns a signed integer,
    +        where it either returns a negative error code or the index of the
    +        last dir separator in a path. That index will always be a
    +        non-negative number, but we cannot just change the return type to a
    +        `size_t` due to it being re-used as error code. This is fixed by
    +        splitting up concerns: the return value is only used as error code,
    +        and the prefix is now returned via an out-pointer. This fixes a sign
    +        comparison warning when comparing `text.len < prefix`,
     
           - We treat `struct config_store_data::seen` as signed integer in
             several places even though it's unsigned.
    @@ config.c
      #include "abspath.h"
      #include "date.h"
     @@ config.c: static void add_trailing_starstar_for_dir(struct strbuf *pat)
    - 		strbuf_addstr(pat, "**");
      }
      
    --static int prepare_include_condition_pattern(const struct key_value_info *kvi,
    + static int prepare_include_condition_pattern(const struct key_value_info *kvi,
     -					     struct strbuf *pat)
    -+static size_t prepare_include_condition_pattern(const struct key_value_info *kvi,
    -+						struct strbuf *pat)
    ++					     struct strbuf *pat,
    ++					     size_t *out)
      {
      	struct strbuf path = STRBUF_INIT;
      	char *expanded;
    @@ config.c: static void add_trailing_starstar_for_dir(struct strbuf *pat)
      
      	expanded = interpolate_path(pat->buf, 1);
      	if (expanded) {
    +@@ config.c: static int prepare_include_condition_pattern(const struct key_value_info *kvi,
    + 
    + 	add_trailing_starstar_for_dir(pat);
    + 
    ++	*out = prefix;
    ++
    + 	strbuf_release(&path);
    +-	return prefix;
    ++	return 0;
    + }
    + 
    + static int include_by_gitdir(const struct key_value_info *kvi,
     @@ config.c: static int include_by_gitdir(const struct key_value_info *kvi,
      {
      	struct strbuf text = STRBUF_INIT;
    @@ config.c: static int include_by_gitdir(const struct key_value_info *kvi,
      	int already_tried_absolute = 0;
      
     @@ config.c: static int include_by_gitdir(const struct key_value_info *kvi,
    - 	prefix = prepare_include_condition_pattern(kvi, &pattern);
      
    - again:
    --	if (prefix < 0)
    --		goto done;
    + 	strbuf_realpath(&text, git_dir, 1);
    + 	strbuf_add(&pattern, cond, cond_len);
    +-	prefix = prepare_include_condition_pattern(kvi, &pattern);
     -
    +-again:
    +-	if (prefix < 0)
    ++	ret = prepare_include_condition_pattern(kvi, &pattern, &prefix);
    ++	if (ret < 0)
    + 		goto done;
    + 
    ++again:
      	if (prefix > 0) {
      		/*
      		 * perform literal matching on the prefix part so that

---
base-commit: 592f97530d99d182d69c66e08279e189d006b410
change-id: 20250716-pks-config-wo-the-repository-21de9489f965

