Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14520405855
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184337; cv=none; b=Bft3aVqBlVTJ48fCUuLqwCbFjjvhbiD7ZAT/9Mlwr0JfXbbrM8KFmsOd08tGU7sem2tFh83SH2JTLSDHNpbvJECkIom6jTNOB96WGX6aEyFV1PlV+1gVPMN5j+ne79mKx7o04/CKdieTYjU+SXtTa+ldurcEmIQJlgkL31n+ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184337; c=relaxed/simple;
	bh=5HhzUDRbktkTM4vZz4EH/lyqHcuuzI2x3YH2q7a4rSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Yl7ogPVE9HT8nBs/nsQxolR1cnuYiiG39X/V3XR3p5YhMNzsxi6qBt/+okupMYJZ7pmes1E0K7hY5TXYXY95Ii/gaKtGByq5zoV/OHEtNjss3g+PFrX8siPBRx9HQA/d1Rh8FyX0JDv2KQqeZ7qq2KgnfbsnQNB0kjaV4bQ++S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JX5Ag/Fm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ufDnPneS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JX5Ag/Fm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ufDnPneS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D5F31D000B8;
	Tue, 19 May 2026 05:52:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 19 May 2026 05:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184334;
	 x=1779270734; bh=TkDkqII8zw6FtbYibVJCdB/OQbR84bKWcLMtpOOofcI=; b=
	JX5Ag/FmVF6rpY4ZcqrbMf9Hn517qYO9+jYqKVdLaG4ar5hdkpTbe8ix6cW1cyux
	40E61NDmGs0jpT3mKqcw0gC5Wo2+P7pdI23LP6gGisOdMjK1L6bHLxdyE/Rt+/d7
	/NRGrjW1ZA+qJ9NVsBHFpDqxbllObZ5YKRBPWVkxtHrfXCNOfJOJzAPwFvqCNnhY
	arZkxek69iSrvwANzA86Xek2U4ff732Topk59qBcpT90qaNQ/PepGrwN+jxPKddJ
	jDfdrHYeQpcg/ez7tU4Wf0lzDhdLVq1PRVf6aeqYRzzmXpHF+gUidKxNXyvN3RJP
	j0gfcW6iFXy+lS/4TadIDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184334; x=
	1779270734; bh=TkDkqII8zw6FtbYibVJCdB/OQbR84bKWcLMtpOOofcI=; b=u
	fDnPneST+LVNRdg3Kg/KerwApwOCOC2FRfaAeK/hEECHqrjDkRMUHv7iChRmbalQ
	tOfTxvP08i+mI66dTm2thIaJg8VpEPd2l3W6NlMQv7q4hC08u78SI+VYuef2rJhv
	575KXyolElpqLbJu0UJ7+ka160wadxAfH3QkHgD2eITZwW4NbeJxPYmf2iSmoXhX
	JRRLqJPwyhBtulfABytQVdL+T3YErh0lgSOXUBMo83JJlLKcpZeQ9biqj7k54ACU
	LGrDn6xWLaENF+VBH0EqWxwVPczzUiW+babgvAYjsI+e8cFibJF6Y04APg60d4T6
	LFuqreER6sQQAnR9FL1rg==
X-ME-Sender: <xms:zjIMar1taH6xhQTEyEB7wgCL7Qq8Xgw_SQj1Y-km79KbjhDTOwYEZw>
    <xme:zjIMag9ud9Aq3j5NdMmBRcCyuWFuRZA1DJD4geeyv0oZ0PXItsbu3WwXng1bUZiOo
    ZllGZxMB1tlHRM4FEMFKNNpNJqtbAj7ZdXlbxx1puJhhQZcb1Yk>
X-ME-Received: <xmr:zjIMakPpoSp5z_MM9itjO2G_qwtMXR3AtMAaSKTBzYDwObabPenbLJMOkbB90oasAbO4arrdMJkrOQG5SeGUHiL4TN06gWadGKP_WeoE8BE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeltefggeehveevtefgledutdffleehjeeijeevvddugeethfeitedtheetgefgtden
    ucffohhmrghinhepmhhsghhiugdrlhhinhhkpdhkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrg
    htsehmrghlohhnrdguvghvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:zjIMaset50cSSINWAetAS4q1gs0elDuaDpde8Vjn64SclD6aUeEbrQ>
    <xmx:zjIMarWET75nA4rNchJeKHKeNvVE_5Tss1_A88jLCfYxruNwVazIsw>
    <xmx:zjIMash47skBKibkcV__3YttAYVideNESWzjJusZsvqbeojbQmkmDA>
    <xmx:zjIMai9lpllejCfXxHB4dwRH4uBC-w49qNupeDoPFbBZ4ql2zpiO7A>
    <xmx:zjIMauPnVp5wkXCUjHz2m6uRdCCuxGUanjRfWyQHx8sLvyqjNWyS4bjR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 13f252df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/18] setup: drop uses of `the_repository`
Date: Tue, 19 May 2026 11:52:04 +0200
Message-Id: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQyDGoC/32Nyw6CMBQFf4V07TV9UFJc+R/GBZSLVCOQtlQN4
 d9tYcGO5UnmzMzEoTXoyCWbicVgnBn6OMQpI7qr+geCaeImnPKCCkFhfDlw6KcRPgP4DsHiODj
 jB/sDxVCyWktZl4xEw2ixNd/Vfrtv2031E7VPykR0xqXnmg8scVsp58elwIBCm1eK6bxUCtU10
 mfzJikT+C6STB2LeBQVpRCatqyRxS5aluUPl8AgJx4BAAA=
X-Change-ID: 20260330-pks-setup-wo-the-repository-81e51bc55b91
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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

Changes in v3:
  - Reverse the order of the commits that refactor `is_inside_gitdir()`
    and `is_inside_work_tree()` and clarify the logic around why we do
    (or do not) have to use realpath(3p). The code is ultimately not
    changed though, we still resolve the realpath for both even though
    it's not strictly necessary to do so for the working tree.
  - Link to v2: https://patch.msgid.link/20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im

Changes in v2:
  - Drop some static variables.
  - Rebase on top of origin/master at 59ff4886a5 (Merge branch
    'ps/clang-w-glibc-2.43-and-_Generic', 2026-05-13). This resolves a
    single conflict, but more importantly the rebase fixes CI.
  - Link to v1: https://patch.msgid.link/20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im

Changes in v1 (relative to the botched-up [1]):
  - Remove static `initialized` variable in `setup_work_tree()`.
  - Use enum values to initialize fields.
  - Fix up a comment.
  - Link to v1: https://lore.kernel.org/all/20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im/

Thanks!

Patrick

[1]: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>

---
Patrick Steinhardt (18):
      setup: replace use of `the_repository` in static functions
      setup: stop using `the_repository` in `is_inside_git_dir()`
      setup: stop using `the_repository` in `is_inside_work_tree()`
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
 setup.c                                      | 451 ++++++++++++++-------------
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
 83 files changed, 402 insertions(+), 383 deletions(-)

Range-diff versus v2:

 1:  55bee14899 =  1:  2ebdbac05f setup: replace use of `the_repository` in static functions
 3:  eaedc9e0d6 !  2:  23ab6d8d17 setup: stop using `the_repository` in `is_inside_git_dir()`
    @@ Metadata
      ## Commit message ##
         setup: stop using `the_repository` in `is_inside_git_dir()`
     
    -    Similar as with the preceding commit, `is_inside_git_dir()` determines
    -    whether the current working directory is located inside the gitdir of
    -    `the_repository`. Perform the same refactoring by dropping the caching
    -    mechanism and injecting the repository that shall be checked.
    +    The function `is_inside_git_dir()` verifies whether or not the current
    +    working directory is located inside the gitdir of `the_repository`. This
    +    is done by taking the gitdir path and verifying that it's a prefix of
    +    the current working directory.
    +
    +    This information is cached so that we don't have to re-do this change
    +    multiple times. Furthermore, we proactively set the value in multiple
    +    locations so that we don't even have to perform the check when we have
    +    discovered the repository.
    +
    +    While we could simply move the caching variable into the repository, the
    +    current layout doesn't really feel sensible in the first place:
    +
    +      - It can easily lead to false positives or negatives if at any point
    +        in time we may switch the current working directory.
    +
    +      - We don't call the function in a hot loop, and neither is it overly
    +        expensive to compute.
    +
    +    Drop the caching infrastructure and instead compute the property ad-hoc
    +    via an injected repository.
    +
    +    Note that there is one small gotcha: we often end up with relative
    +    gitdir paths, and if so `is_inside_dir()` might fail. This wasn't an
    +    issue before because of how we proactively set the cached value during
    +    repository discovery. Now that we stop doing that it becomes a problem
    +    though, which we work around by resolving the gitdir via `realpath()`.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ setup.c
      #include "worktree.h"
      
     -static int inside_git_dir = -1;
    + static int inside_work_tree = -1;
      static int work_tree_config_is_bogus;
      enum allowed_bare_repo {
    - 	ALLOWED_BARE_REPO_EXPLICIT = 0,
     @@ setup.c: void verify_filename(const char *prefix,
       */
      void verify_non_filename(const char *prefix, const char *arg)
      {
    --	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
    -+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
    +-	if (!is_inside_work_tree() || is_inside_git_dir())
    ++	if (!is_inside_work_tree() || is_inside_git_dir(the_repository))
      		return;
      	if (*arg == '-')
      		return; /* flag */
    @@ setup.c: int is_nonbare_repository_dir(struct strbuf *path)
     +	return ret;
      }
      
    - int is_inside_work_tree(struct repository *repo)
    + int is_inside_work_tree(void)
     @@ setup.c: static const char *setup_discovered_git_dir(struct repository *repo,
      	set_git_work_tree(".");
      	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
      		set_git_dir(repo, gitdir, 0);
     -	inside_git_dir = 0;
    + 	inside_work_tree = 1;
      	if (offset >= cwd->len)
      		return NULL;
    - 
     @@ setup.c: static const char *setup_bare_git_dir(struct repository *repo,
      		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
      	}
      
     -	inside_git_dir = 1;
    + 	inside_work_tree = 0;
      	if (offset != cwd->len) {
      		if (chdir(cwd->buf))
    - 			die_errno(_("cannot come back to cwd"));
     
      ## setup.h ##
     @@
    @@ setup.h
      
     -int is_inside_git_dir(void);
     +int is_inside_git_dir(struct repository *repo);
    - int is_inside_work_tree(struct repository *repo);
    + int is_inside_work_tree(void);
      int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
      int get_common_dir(struct strbuf *sb, const char *gitdir);
 2:  b9aef04ffe !  3:  9f9aa3869d setup: stop using `the_repository` in `is_inside_worktree()`
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    setup: stop using `the_repository` in `is_inside_worktree()`
    +    setup: stop using `the_repository` in `is_inside_work_tree()`
     
    -    The function `is_inside_worktree()` verifies whether or not the current
    -    working directory is located inside the worktree of `the_repository`.
    -    This is done by taking the worktree path and verifying that it's a
    -    prefix of the current working directory.
    +    Similar as with the preceding commit, `is_inside_work_tree()` determines
    +    whether the current working directory is located inside the worktree of
    +    `the_repository`. Perform the same refactoring by dropping the caching
    +    mechanism and injecting the repository that shall be checked.
     
    -    This information is cached so that we don't have to re-do this change
    -    multiple times. Furthermore, we proactively set the value in multiple
    -    locations so that we don't even have to perform the check when we have
    -    discovered the repository.
    -
    -    While we could simply move the caching variable into the repository, the
    -    current layout doesn't really feel sensible in the first place:
    -
    -      - It can easily lead to false positives or negatives if at any point
    -        in time we may switch the current working directory.
    -
    -      - We don't call the function in a hot loop, and neither is it overly
    -        expensive to compute.
    -
    -    Drop the caching infrastructure and instead compute the property ad-hoc
    -    via an injected repository.
    -
    -    Note that there is one small gotcha: we sometimes may end up with
    -    relative directory paths, and if so `is_inside_dir()` might fail. This
    -    wasn't an issue before because of how we proactively set the cached
    -    value during repository discovery. Now that we stop doing that it
    -    becomes a problem though, but it is worked around by resolving the
    -    repository directory via `realpath()`.
    +    Note that, same as in the preceding commit, we're also resolving the
    +    worktree path via `realpath()`. In theory this step is not necessary as
    +    we always set the worktree path via `repo_set_worktree()`, and that
    +    function already resolves the path for us. But resolving the path a
    +    second time is unlikely to matter performance-wise, and it feels fragile
    +    to rely on the repository's worktree path being absolute. We thus
    +    perform the same extra step even though it's ultimately not required.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ object-name.c: static char *resolve_relative_path(struct repository *r, const ch
     
      ## setup.c ##
     @@
    + #include "trace2.h"
      #include "worktree.h"
      
    - static int inside_git_dir = -1;
     -static int inside_work_tree = -1;
      static int work_tree_config_is_bogus;
      enum allowed_bare_repo {
    @@ setup.c: void verify_filename(const char *prefix,
       */
      void verify_non_filename(const char *prefix, const char *arg)
      {
    --	if (!is_inside_work_tree() || is_inside_git_dir())
    -+	if (!is_inside_work_tree(the_repository) || is_inside_git_dir())
    +-	if (!is_inside_work_tree() || is_inside_git_dir(the_repository))
    ++	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
      		return;
      	if (*arg == '-')
      		return; /* flag */
    -@@ setup.c: int is_inside_git_dir(void)
    - 	return inside_git_dir;
    +@@ setup.c: int is_inside_git_dir(struct repository *repo)
    + 	return ret;
      }
      
     -int is_inside_work_tree(void)
    @@ setup.c: static int check_repository_format_gently(struct repository *repo,
      	}
      
     @@ setup.c: static const char *setup_discovered_git_dir(struct repository *repo,
    + 	set_git_work_tree(".");
      	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
      		set_git_dir(repo, gitdir, 0);
    - 	inside_git_dir = 0;
     -	inside_work_tree = 1;
      	if (offset >= cwd->len)
      		return NULL;
      
     @@ setup.c: static const char *setup_bare_git_dir(struct repository *repo,
    + 		return setup_explicit_git_dir(repo, gitdir, cwd, repo_fmt, nongit_ok);
      	}
      
    - 	inside_git_dir = 1;
     -	inside_work_tree = 0;
      	if (offset != cwd->len) {
      		if (chdir(cwd->buf))
    @@ setup.h
     @@
      #include "string-list.h"
      
    - int is_inside_git_dir(void);
    + int is_inside_git_dir(struct repository *repo);
     -int is_inside_work_tree(void);
     +int is_inside_work_tree(struct repository *repo);
      int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
 4:  60accc2ec9 =  4:  ce095cefaa setup: stop using `the_repository` in `prefix_path()`
 5:  ced765c68e =  5:  dd21e47a5c setup: stop using `the_repository` in `path_inside_repo()`
 6:  2d119a5570 =  6:  ba8b6bfe0d setup: stop using `the_repository` in `verify_filename()`
 7:  1867994202 =  7:  f6bf7e5477 setup: stop using `the_repository` in `verify_non_filename()`
 8:  c17b96c516 =  8:  886c1a6e20 setup: stop using `the_repository` in `enter_repo()`
 9:  e3ce4b5056 =  9:  a127018412 setup: stop using `the_repository` in `setup_work_tree()`
10:  e26be95df8 = 10:  8f9a63b82f setup: stop using `the_repository` in `set_git_work_tree()`
11:  83c38c45d2 = 11:  35a9857ef0 setup: stop using `the_repository` in `setup_git_env()`
12:  153ce789de = 12:  2873901d89 setup: stop using `the_repository` in `setup_git_directory_gently()`
13:  1f10dd9c99 = 13:  7e63ec5f01 setup: stop using `the_repository` in `setup_git_directory()`
14:  9f19eba3df = 14:  c227ac83dd setup: stop using `the_repository` in `upgrade_repository_format()`
15:  ff19c1691d = 15:  70bff29c9a setup: stop using `the_repository` in `check_repository_format()`
16:  dc8072eaf7 = 16:  31e794edc3 setup: stop using `the_repository` in `initialize_repository_version()`
17:  e9c035694e = 17:  4bbab827ab setup: stop using `the_repository` in `create_reference_database()`
18:  0fde37999c = 18:  74c9379b28 setup: stop using `the_repository` in `init_db()`

---
base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
change-id: 20260330-pks-setup-wo-the-repository-81e51bc55b91

