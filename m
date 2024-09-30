Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9BF15F3F9
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687596; cv=none; b=smlwI3tAsuIN/8G/K2KgH1/tFClNEtXlZErgVTjFbur37VxheFKGUzSe2V5z2cVfwtmSIQ1HAfgzCl9aotAosLBjBOX2jqPSbtlWZoYVUd/dr5DXDaB6Zdi6J7Mx444MUCvHey8yA+oWnYZm0Qd0ENFqcW7ie1vdmCOTbP10paw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687596; c=relaxed/simple;
	bh=v4H3fk25DI8b1ZDjrCDdDJACywwUneDPp9BK29SyOgI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Js6EY5BrU2t8+q0JlKOGAKUqV+1+WFpkpqkHGPzDOmiJ8Lb3gxq29cua9/wnVhhA4ZAkrRgLNwE3kix/6NLNhZD1nd9XzAsCdlXh2mRTMHDTVBT/r2tbVdOiVtnS13z5jlRyD5+gzKAhBkfkTL8glm+V1wqhSUiV6UAOIjW64ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeucYqxc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8emyUcY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeucYqxc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8emyUcY"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E0A2B1380398
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1727687592; x=1727773992; bh=ZXFFFNGnLOhjs+TJ6401+tJFw3QN6NCg
	1Y0SCDrceVk=; b=eeucYqxc+DGXU7KyWVdiuKmTzzEsvfjBxpk7sZd44MciXyGc
	nKWe6gXx9EpfpwrIlhjO6ToL0wr2+hv0xhKeBYbkXOD3go50bCKA4R5ZVppF7TdM
	yEgw4Fr03DObM+GeqzfPVPzMfLlfTWJkRvqrg8v9v44pRyB9A9/TVhJT964rLF22
	DDUL5biwP2g/Xv3PG/EiXUaRE2KpknyBSgg454mcdX/oYBH+M9tQg0LQbvs2uwBm
	2Hm7Rg0n8ON+r7oawCLGiYbmYzWw1pvF0jHNl3/bO51QwkRNGwqeAuW+SO//emmE
	QmW2iju/v1z7IhrxdxT1a4RS2dpxbT3mbArT2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1727687592; x=1727773992; bh=ZXFFFNGnLOhjs+TJ6401+tJFw3QN6NCg1Y0
	SCDrceVk=; b=P8emyUcYqr9bFdzBXYdgdl/fn+hA8/NGLFMIXDIYuKJOYYWsvzq
	/6cg0pkP24FDZsH4STSwwVdffg2R4KDv707pqWgmnwOuOAlW1YarjaAEdFDxkkWO
	LVFGaX4Ld4885kKX7XwTZ7WUcjdE8aA+JSqArIDsuYk1e+R3oy6aetNOECfWWIkj
	xF0P1J5sJIeh/I6wuXQwGdNWJs+f4FOReD0FyOCPVkVwTBhnWPrxXf4cACuMK0aU
	m5tvFk3oEWECQBnTkdTILvlbEIsX/ix1PSUusXSmzEnzRrnZWSIAjddEfPvrBiz7
	BkCaAejbwMukbbXlzYsOCt/kr8seCyKzu4w==
X-ME-Sender: <xms:qGv6ZmPZDpB1cPuGYTB7ino3bAoO4qOBuCuzNsitK8gZsqxKBwvcKw>
    <xme:qGv6Zk-d2zaj7Ypy80G8YpnEhdVmLzmeE67hebUeZke9UYDADI2qEZKbUHKFb0nXa
    OxevY5HM5IqEf6NHw>
X-ME-Received: <xmr:qGv6ZtRMCynDe8Gc8k5ba6MMns_rXbp1w4o2YVKe7PAnldbH5ZsvfEmkeKX0qBrmuADFA7wlSFvXm6mN4xCvbEZhRg_dVAXKt6YQPLuYTsQnpg8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkgggtugesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghr
    ughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepleehkedtieetfeeiff
    egieevkeejhfdvkeetjeefkeetgeejleelffeftdffgeeunecuffhomhgrihhnpehhthht
    phdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qGv6ZmuaKZHh9WzLM9u1doHI-_BKcMfHnBKm_yxTp98izOr1E2NIgQ>
    <xmx:qGv6ZuelWpCXlQ4uz3VFmbuTWozSKRCZZBxFPzFumWPcHLbaiOwJiQ>
    <xmx:qGv6Zq3JgKsV1eFkt6OHALD77t2KOfto4Js3lvuDpYh4_X7ChuVM7Q>
    <xmx:qGv6Zi_eIB98sZQybpRoKdwKRIaUYPP0P9wStnEqRwZ6D07wQ6B97w>
    <xmx:qGv6ZiFoE2_FNFMIRaQweekkr4govVWNa7KGzknmbK-99Gztg-9p3fir>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fbad9b23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:24 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 00/23] Memory leak fixes (pt.8)
Message-ID: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this is the 8th series of memory leak fixes. As usual, it fixes memory
leaks all over the place. Once applied, we're down to 35 test suites
that do not pass with the memory leak sanitizer.

This series is built on top of 3857aae53f (Git 2.47-rc0, 2024-09-25)
with the following two topisc merged into it:

  - ps/leakfixes-part-7 at 12dfc2475c (diffcore-break: fix leaking
    filespecs when merging broken pairs, 2024-09-26).

  - jk/http-leakfixes at f4c768c639 (http-push: clean up local_refs at
    exit, 2024-09-24).

Both of these topics are part of `next`.

Thanks!

Patrick

Patrick Steinhardt (23):
  builtin/annotate: fix leaking args vector
  read-cache: fix leaking hash context in `do_write_index()`
  scalar: fix leaking repositories
  shell: fix leaking strings
  wt-status: fix leaking buffer with sparse directories
  submodule: fix leaking submodule entry list
  builtin/stash: fix leaking `pathspec_from_file`
  builtin/pack-redundant: fix various memory leaks
  builtin/clone: fix leaking repo state when cloning with bundle URIs
  t/helper: fix leaking repository in partial-clone helper
  builtin/revert: fix leaking `gpg_sign` and `strategy` config
  diff: improve lifecycle management of diff queues
  line-log: fix several memory leaks
  pseudo-merge: fix various memory leaks
  pseudo-merge: fix leaking strmap keys
  pack-bitmap-write: fix leaking OID array
  midx-write: fix leaking buffer
  revision: fix memory leaks when rewriting parents
  revision: fix leaking saved parents
  pack-write: fix return parameter of `write_rev_file_order()`
  t/helper: fix leaks in proc-receive helper
  remote: fix leaking push reports
  builtin/send-pack: fix leaking list of push options

 bloom.c                                    |  8 +--
 branch.c                                   |  8 ++-
 builtin/annotate.c                         | 20 +++++--
 builtin/clone.c                            | 27 +++++++++
 builtin/index-pack.c                       |  7 +--
 builtin/pack-redundant.c                   | 40 +++++++++++--
 builtin/receive-pack.c                     |  5 +-
 builtin/revert.c                           | 17 ++++--
 builtin/send-pack.c                        |  1 +
 builtin/stash.c                            |  4 +-
 diff.c                                     | 22 +++----
 diffcore-break.c                           |  8 +--
 diffcore-pickaxe.c                         |  4 +-
 diffcore-rename.c                          |  3 +-
 diffcore-rotate.c                          |  3 +-
 diffcore.h                                 | 10 ++--
 line-log.c                                 | 69 +++++++++++++---------
 log-tree.c                                 |  4 +-
 merge-ort.c                                |  2 +-
 midx-write.c                               |  5 +-
 pack-bitmap-write.c                        |  9 +++
 pack-bitmap.c                              |  4 +-
 pack-write.c                               | 42 +++++++------
 pack.h                                     |  4 +-
 pseudo-merge.c                             | 23 +++++++-
 pseudo-merge.h                             |  2 +
 read-cache.c                               |  1 +
 remote.c                                   | 15 +++++
 remote.h                                   |  4 +-
 revision.c                                 | 14 ++++-
 scalar.c                                   |  1 +
 shell.c                                    |  6 +-
 submodule-config.c                         | 15 ++++-
 submodule-config.h                         |  3 +
 t/helper/test-partial-clone.c              |  2 +
 t/helper/test-proc-receive.c               |  7 +++
 t/t0410-partial-clone.sh                   |  1 +
 t/t1092-sparse-checkout-compatibility.sh   |  1 +
 t/t3207-branch-submodule.sh                |  1 +
 t/t3427-rebase-subtree.sh                  |  1 +
 t/t3514-cherry-pick-revert-gpg.sh          |  1 +
 t/t3909-stash-pathspec-file.sh             |  1 +
 t/t5323-pack-redundant.sh                  |  1 +
 t/t5327-multi-pack-bitmaps-rev.sh          |  1 +
 t/t5333-pseudo-merge-bitmaps.sh            |  1 +
 t/t5334-incremental-multi-pack-index.sh    |  2 +
 t/t5411-proc-receive-hook.sh               |  1 +
 t/t5545-push-options.sh                    |  1 +
 t/t5730-protocol-v2-bundle-uri-file.sh     |  1 +
 t/t5731-protocol-v2-bundle-uri-git.sh      |  1 +
 t/t5732-protocol-v2-bundle-uri-http.sh     |  1 +
 t/t6012-rev-list-simplify.sh               |  1 +
 t/t6016-rev-list-graph-simplify-history.sh |  1 +
 t/t7003-filter-branch.sh                   |  1 +
 t/t8001-annotate.sh                        |  1 +
 t/t9210-scalar.sh                          |  1 +
 t/t9211-scalar-clone.sh                    |  1 +
 t/t9350-fast-export.sh                     |  1 +
 t/t9400-git-cvsserver-server.sh            |  1 +
 t/t9402-git-cvsserver-refs.sh              |  1 +
 t/t9850-shell.sh                           |  2 +
 wt-status.c                                |  6 +-
 62 files changed, 329 insertions(+), 123 deletions(-)

-- 
2.46.2.852.g229c0bf0e5.dirty

