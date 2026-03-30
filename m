Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E52248A3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876669; cv=none; b=NletoVi2BQCCc1TEVIJODkOvLf1zaZkSpUCtMP4Y4mbnWR7tcwaXeQUpDc/psVu/KtvW6cWk8Ei1JiAQsjSh89JuNb3q8HfEprBOvT/GYvUEIaYaf0FZ1AytFSWkJBAbGJQwIQJkC94JS4laS9X8y1CLqGwD4idj0h/4sTUklx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876669; c=relaxed/simple;
	bh=bBLu1vx39yzKMpaV4rDdxfxNBXgQE3hiklctt0aStx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W8r6jkrddcJQtcoLHROUCyjUlrcZlcLk14c2DpsKdUIqx/1hM872PZMj8QY+rOXGvUgAiwYURGhYe3SjAnr/I2CGSgibCAavqWBMv2FrM1oUnp2j9CLJQuP87b+GYnt5jfnwsQc44m25IJMBUa3F28WFXttbVuj+SMZBR/xmiUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RCvOEg5B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lp1PEK7q; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RCvOEg5B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lp1PEK7q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 055881D00056
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 09:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1774876666; x=1774963066; bh=8xwDee0xdo
	2EpX6k8n7w49uCphxCq/nzcaKEn2BftAw=; b=RCvOEg5ByeJc9lVxnjgh/LQl3V
	Fgmm0hqCVgDuAgpE/4huaI7ABPRaLqeZXt07e2ATrXLUCg7snbHOjz1DXw8rQ/GD
	Pn7RnlxcIqbgxjEeDBigqRfVOKYpsCqAhbVx6g7oMvXUEhfJ5cCzAvK3vysR9ZzR
	fSbGnsx6EnMDa/6JXtabQtkM6qoQ978f6L0tSfboANptW5wBQ4jgBqzng8L1Dm59
	+PpxZbuPV5Uv8YJwoFJGUMiGhiKhyqf4xG10q4quML54h38LLTV4YBtCZ7iozp5m
	ihhkqiE1hzxfIi9Be7rHsh9qUrzXL0Ix0nujZNLIMiIAOSLJxryx71zUvpGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774876666; x=1774963066; bh=8xwDee0xdo2EpX6k8n7w49uCphxC
	q/nzcaKEn2BftAw=; b=Lp1PEK7qzAdTF6v7irv7ln27vIwazw/uB44hTsSxa2OE
	neBvXvyP+ieyT5ebbjCm+SrOXUOkowb11K30NfWyiTDuFfFjPgW9c/oQlHK/HtM/
	qJGb7F6k7Ou1W+kUpWXIbsR/qfL3LWo4qBpa97RzDcP1YhvqoDf3byBdYPOlV/3N
	6nI5RafTTVNbSIRkwn75xur8A69b0bUmvCv+1oIObX5rnHZkJ5KeoMH/yM8fUIDQ
	TgmSejw3PaAGRCSrmUf2Cy4k/RQfu1pdbqINOitbqgViJEAoimyMFRlbAD1W0H3c
	+SNiCvQzAquMOXXKUnpUITYnEIgJiceImkzlMmlwpg==
X-ME-Sender: <xms:-nfKaSJdJBpsIbxjJli-w6nfxmYggThMUKE5ny6YSj34LxgPtq5x_w>
    <xme:-nfKaRFIIMsE3pGfObIftqmQcno1RAFFXZZpjnVGLCUvSTypxrMd4aH0qZXSaqW9e
    uOFyFaaI-F3bK2d68ZjCYOI6iiT-ykft7hHhIcu4wb028iJIJ3m>
X-ME-Received: <xmr:-nfKaYVgTCe1FzhRUN2pZqlSSEuNvTdjOh8RE9DbM41MTgHFYRODv9X6nGMz1U3oDrh_hSJvY_Tyxjc9UzCXN5SQhzThg2OPbbVxkHB6RXi8qQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetieegjeeuheeuudfgveelfeevhe
    euhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:-nfKacgXThNMRXfqn4YFnpdi_MXJAzUfVyUKR_Zo40lqIUeMMS2quw>
    <xmx:-nfKaZTFIl_sY0f2CgWUJ-8NkWcAKpTSpzXqzE4AoJRg0VNYQghyMg>
    <xmx:-nfKafEEbP3pK2Uu9151Ld2GP45NGIs2LDHTJyZbWWENiUCKJ7pPJQ>
    <xmx:-nfKaRmqmY7rdoJwlh82sZzN15viCmDFJNEOR7NOy1UeBTm8tAN71w>
    <xmx:-nfKaTrpl6smgW-ZwRilahQadT5hssZKgloCXhNdwovjz91DqY9NJ8kT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:17:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fded9d24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:17:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/18] setup: drop uses of `the_repository`
Date: Mon, 30 Mar 2026 15:17:22 +0200
Message-Id: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJ3ymkC/yXMQQ6CMBAF0KuQWTtJC6lRr2Jc0PqV0YQ2naIQw
 t2tunybt5IiC5ROzUoZL1GJY4XdNRSGfryD5VpNrWn3pusMp6eyokyJ35HLAM5IUaXEvPDBwlk
 fnPNHS3VIGTeZf/v58rdO/oFQviVt2wdqRE2/fwAAAA==
X-Change-ID: 20260330-pks-setup-wo-the-repository-81e51bc55b91
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
 setup.c                                      | 436 ++++++++++++++-------------
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
 83 files changed, 393 insertions(+), 377 deletions(-)


---
base-commit: 5361983c075154725be47b65cca9a2421789e410
change-id: 20260330-pks-setup-wo-the-repository-81e51bc55b91

