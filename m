Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B439E312825
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673367; cv=none; b=LfsnvlY28Sq20LvoXKWtuA8Jy7YJHAQ6Xdfy6YdhIAsB5GEBJXPhTeq/VMs64V68tdRjZsBescV4g5Sm7eIPo08EfhUvHwOi1PXIW6PpzE7mFPSwGJpypLH07ea/uPqi+wWRC/2c+mpILO+gB3H59WHxvDsvXwN0JvfXn2hKhTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673367; c=relaxed/simple;
	bh=54wHSl6M7D0p/MAzfBPInsOIc8rASjlrRF7lTwVL6SI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0UkOv/tnQri3jY+Yoz3shN5k7agx7zftD08e+Q4Y+4sjCCVozNNw6jTOhZzaebGRLwY397KnqVHt/+ODEVUdE4nMwUZDJ+vfHsMcQ88zuVWT096i4afM2HlDpWfpI4iLWuHZTRc4k9+Ylu2JqhSfimRaU1dEk5d/4zubtrW8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lpo1WaAS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SkQgp3x9; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lpo1WaAS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SkQgp3x9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E6152EC019B;
	Mon, 20 Apr 2026 04:22:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 20 Apr 2026 04:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1776673364; x=1776759764; bh=QWwfS0KYks
	gvgzLwxxzqYyK3VdMMWJ5/S0RsqrkNWnc=; b=lpo1WaASQwwRqI5M75PVAuwaie
	sne9unqs0MCCZVHctLTHLhrE652YnATQQwx7Jh+MHd215RIfHU9ixd5pMMmg79sY
	rH2YOJFxKymyY/i3Ns3y4KVN5rJG5zr51ZCl1gCRzQNXCU3UMjTVZ0Tvxc9vaj3n
	iLjJsu0s5yUqjhG4XllE0QBlXm6wUTxvaK7I+RK+f5KvpAs1OgdyLcJBR903B9EJ
	wykCUvuDti62r+KhKsOqbE0cGjaMQ67pJY35oPtdRTPkWha/HVnbbrwkU2rYl0g3
	9cfYhQ3BMfKV8eneE9vnstlgRWYjWrMaLZL5syZEcraaW6d7HaJj5RYDWIRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776673364; x=1776759764; bh=QWwfS0KYksgvgzLwxxzqYyK3VdMM
	WJ5/S0RsqrkNWnc=; b=SkQgp3x9e6cP+mA1kzY2m1D738kdAC6pJuzsUreqYJOp
	A/47Kr4ysR6EZBTZw89LjayUWxX5bGYOHgzz6qE8fDpm/WsjQzY/Lc2+jEVoorvO
	Ow9JZZqtNrMP5jauY9BwkDV5p/QW8mKyK5J7qb0Ub4neyi5g+RnY7Lz2UNSl+p7r
	aH5viHYupVuMvIX16ZHuAlhT/ojRcBt1KV8RnIh8Q20YS3YrxIVTN7H6tleIJLqR
	YdXQmE+/eW5x3mISTx7mMm9ctWkJQQWO3ISJI4QJs4nQbaCjJcpPJITGm3hCdfk9
	aBpwiDeOL2e/Anfk1DVFDS94ryW7U7x9MEkoOjcw6Q==
X-ME-Sender: <xms:VOLlaYjl6ZcMwdrl6hPsWCabr9Vck-7zykoWQnI5fWM_gIoptmUKhQ>
    <xme:VOLlabn4GMq_QMjYJ79AEoUKSEFKubiS-cWWhf6yhShKV16vMcoUy376dXRboopK1
    0FTZ0pNJuH1DdUwt0giXHSIfq3P9Rj2jMwcUANawwZn_SDNGzTGsg>
X-ME-Received: <xmr:VOLlacoqxA0Lu93Xsj_ao8CQFI9RtiD7gDJ87BRieqm-uYLHHh70ZIknpRt-UD3eOv6uou1BMeS-XYNBPzzW5UYPUXRt23dc4fkIZ4aSTyb1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepke
    eutdegtdeifeefveejffelgfdugeelueetffelvefgleefudeihffhieffkedvnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VOLlacHpcGaz8PIPBiobX7BWW1dwGn4xCIE1c2_NsI20B6WozemmdA>
    <xmx:VOLlaQw7mTpDGPXzQTtX5q_HbF7O4WBaCyPOCAMUsialk_-JUivlcg>
    <xmx:VOLlaZr_Rf3_TZawSWp5XXXWxE40T55RNE-EsO0DA3-i5ZJ_BG-ETQ>
    <xmx:VOLlaSgXlwMCDJAIclypqAvutAGT9XRVpGwHDmTabah8XIsDHZgxZQ>
    <xmx:VOLlaRT53pGNZrZ7jcW6axxbGnma1rNvbquEwo8aa2h2mdGMS01LuT9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:22:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33d91523 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:22:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/18] setup: drop uses of `the_repository`
Date: Mon, 20 Apr 2026 10:22:30 +0200
Message-Id: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEbi5WkC/yXMQQ6CMBAF0KuQWTtJC6lRr2Jc0PqV0YQ2naIQw
 t2tunybt5IiC5ROzUoZL1GJY4XdNRSGfryD5VpNrWn3pusMp6eyokyJ35HLAM5IUaXEvPDBwlk
 fnPNHS3VIGTeZf/v58rdO/oFQviVt2wdqRE2/fwAAAA==
X-Change-ID: 20260330-pks-setup-wo-the-repository-81e51bc55b91
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Hi,

I've had enough of "setup.c" and its complexities, so I finally decided
to take the bullet and start refactoring this subsystem. This here is
the first out of the following three steps:

  1. Drop all uses of `the_repository`. This doesn't yet allow us to get
     rid of `USE_THE_REPOSITORY_VARIABLE`.

  2. Convert a couple of global variables and drop
     `is_bare_repository_cfg`, which then allows us to drop
     `USE_THE_REPOSITORY_VARIABLE`.

  3. Refactor the subsystem a bit so that we stop intermixing repository
     discovery and repository initialization. This is my original
     motivation as I want to get rid of `odb_prepare_alternates()`, but
     due to the way we initialize the repository it has proven to be
     extremely tedious.

Most of the patches in this series here are rather mechanical. There's
only a handful of patches that warrant more attention:

  -  2/18: setup: stop using `the_repository` in `is_inside_worktree()`
  -  3/18: setup: stop using `the_repository` in `is_inside_git_dir()`
  -  9/18: setup: stop using `the_repository` in `setup_work_tree()`
  - 10/18: setup: stop using `the_repository` in `set_git_work_tree()`

Those patches don't only mechanical move stuff around, but also change
some logic to make it work.

The series is based on 5361983c07 (The 22nd batch, 2026-03-27). There is
a single merge commit with "seen", but it's trivial to resolve.

Changes in v2:
  - Remove static `initialized` variable in `setup_work_tree()`.
  - Use enum values to initialize fields.
  - Fix up a comment.
  - Link to v1: https://lore.kernel.org/all/20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im/

Thanks!

Patrick

---
Patrick Steinhardt (18):
      setup: replace use of `the_repository` in static functions
      setup: stop using `the_repository` in `is_inside_worktree()`
      setup: stop using `the_repository` in `is_inside_git_dir()`
      setup: stop using `the_repository` in `prefix_path()`
      setup: stop using `the_repository` in `path_inside_repo()`
      setup: stop using `the_repository` in `verify_filename()`
      setup: stop using `the_repository` in `verify_non_filename()`
      setup: stop using `the_repository` in `enter_repo()`
      setup: stop using `the_repository` in `setup_work_tree()`
      setup: stop using `the_repository` in `set_git_work_tree()`
      setup: stop using `the_repository` in `setup_git_env()`
      setup: stop using `the_repository` in `setup_git_directory_gently()`
      setup: stop using `the_repository` in `setup_git_directory()`
      setup: stop using `the_repository` in `upgrade_repository_format()`
      setup: stop using `the_repository` in `check_repository_format()`
      setup: stop using `the_repository` in `initialize_repository_version()`
      setup: stop using `the_repository` in `create_reference_database()`
      setup: stop using `the_repository` in `init_db()`

 archive.c                                    |   2 +-
 blame.c                                      |   2 +-
 builtin/blame.c                              |   2 +-
 builtin/check-attr.c                         |   4 +-
 builtin/check-ref-format.c                   |   5 +-
 builtin/checkout-index.c                     |   4 +-
 builtin/checkout.c                           |   2 +-
 builtin/clone.c                              |  12 +-
 builtin/describe.c                           |   2 +-
 builtin/diff-index.c                         |   2 +-
 builtin/diff.c                               |  10 +-
 builtin/difftool.c                           |   2 +-
 builtin/grep.c                               |   8 +-
 builtin/hash-object.c                        |   4 +-
 builtin/help.c                               |   2 +-
 builtin/init-db.c                            |   8 +-
 builtin/ls-files.c                           |   4 +-
 builtin/merge-file.c                         |   2 +-
 builtin/mv.c                                 |   5 +-
 builtin/read-tree.c                          |   2 +-
 builtin/receive-pack.c                       |   2 +-
 builtin/reset.c                              |   6 +-
 builtin/rev-parse.c                          |  14 +-
 builtin/rm.c                                 |   2 +-
 builtin/sparse-checkout.c                    |  19 +-
 builtin/stripspace.c                         |   2 +-
 builtin/submodule--helper.c                  |   2 +-
 builtin/update-index.c                       |  16 +-
 builtin/upload-archive.c                     |   2 +-
 builtin/upload-pack.c                        |   2 +-
 daemon.c                                     |   4 +-
 environment.h                                |   2 -
 git.c                                        |  10 +-
 http-backend.c                               |   2 +-
 http-fetch.c                                 |   2 +-
 http-push.c                                  |   2 +-
 imap-send.c                                  |   2 +-
 line-log.c                                   |   2 +-
 list-objects-filter-options.c                |   2 +-
 object-name.c                                |   4 +-
 pathspec.c                                   |   2 +-
 refs.c                                       |   2 +-
 remote-curl.c                                |   4 +-
 repository.h                                 |   4 +-
 revision.c                                   |   6 +-
 scalar.c                                     |   4 +-
 setup.c                                      | 442 ++++++++++++++-------------
 setup.h                                      |  43 ++-
 submodule.c                                  |   2 +-
 t/helper/test-advise.c                       |   2 +-
 t/helper/test-bitmap.c                       |   2 +-
 t/helper/test-bloom.c                        |   2 +-
 t/helper/test-cache-tree.c                   |   2 +-
 t/helper/test-config.c                       |   2 +-
 t/helper/test-dump-cache-tree.c              |   2 +-
 t/helper/test-dump-fsmonitor.c               |   2 +-
 t/helper/test-dump-split-index.c             |   2 +-
 t/helper/test-dump-untracked-cache.c         |   2 +-
 t/helper/test-find-pack.c                    |   2 +-
 t/helper/test-fsmonitor-client.c             |   2 +-
 t/helper/test-lazy-init-name-hash.c          |   2 +-
 t/helper/test-match-trees.c                  |   2 +-
 t/helper/test-pack-deltas.c                  |   2 +-
 t/helper/test-pack-mtimes.c                  |   2 +-
 t/helper/test-partial-clone.c                |   4 +-
 t/helper/test-path-utils.c                   |   4 +-
 t/helper/test-path-walk.c                    |   2 +-
 t/helper/test-reach.c                        |   2 +-
 t/helper/test-read-cache.c                   |   2 +-
 t/helper/test-read-graph.c                   |   2 +-
 t/helper/test-read-midx.c                    |   2 +-
 t/helper/test-ref-store.c                    |   2 +-
 t/helper/test-revision-walking.c             |   2 +-
 t/helper/test-scrap-cache-tree.c             |   2 +-
 t/helper/test-serve-v2.c                     |   2 +-
 t/helper/test-submodule-config.c             |   2 +-
 t/helper/test-submodule-nested-repo-config.c |   2 +-
 t/helper/test-submodule.c                    |  10 +-
 t/helper/test-subprocess.c                   |   6 +-
 t/helper/test-userdiff.c                     |   2 +-
 t/helper/test-write-cache.c                  |   2 +-
 worktree.c                                   |   2 +-
 wt-status.c                                  |   2 +-
 83 files changed, 393 insertions(+), 383 deletions(-)


---
base-commit: 5361983c075154725be47b65cca9a2421789e410
change-id: 20260330-pks-setup-wo-the-repository-81e51bc55b91

