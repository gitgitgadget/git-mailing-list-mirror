Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE718CC1A
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924306; cv=none; b=EXozVJ9mZgF5f5m0vFn/l+/5BGcgp+zTcGTF5hZ4XwaZQqzX7iz4hsNI2G7RxcAtuZ7T3rfJUAcdQCKcgy9iQJ4CTfnSiIRR0siTTsVdaYWcmoeImEdL1P0L0dwAoS26FZV9Nn2gHrPRKQXwGjZjHxswvJ4MN7nN7MCGwzBhizo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924306; c=relaxed/simple;
	bh=Issc2fsskAoWec52qEbsJKRXJiSJb/FlQLMNJwqjWEY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bta0eTGvcRn5WaARUegy99LPrtMfbc4EAqwA0+0rdd0vt50jiBfu4boc1SKCKh+sht1JUwoYdm6r/8wLorb/fY6LQ0CbG+ojXQddIrurW960q06EUrXnvLJBwR9/sPCU3WFfjU1LlDc4m+xBii3n1stfmSfuwFAW+Z6QBKXJx7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E7cG3WBF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QahiJn4V; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E7cG3WBF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QahiJn4V"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C86BA1151C9B;
	Thu, 29 Aug 2024 05:38:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 29 Aug 2024 05:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1724924302; x=1725010702; bh=YhkbQu7R4c9/1HgOfTDY/xcbSPgC9tXv
	oHD2qWjpCRQ=; b=E7cG3WBFw2POgCl2Ov0zNjy2ZT+UGv4XxRPizcoAc/yoXsPC
	cBwBOl/skne23emjzsHFhG8CdDvW7UeiyCo/kTl/Xc73wPhyPEdWWPR8hzYVG1ab
	aaVW4bKxE7LnbSQ9C6aB9MKd9QVslho210Uk2RF9xfTrSg68nCwkC2b3c0dEzbMb
	8qnzXxXUl5PG0sHcsfaIAy54EXypJ9Qa/UjJN7hqHJVTxVeX4zRESe9xhpS0JjMO
	jMA3UwD1sYEHjxEUBSzaSWL7s1g1gKq/H4BpAauIdsO413IuG0E6bR3cZysk/ZAz
	o67+3iQmI2+MNVFuO+aQSt/SeAbrxQZRs08vUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1724924302; x=1725010702; bh=YhkbQu7R4c9/1HgOfTDY/xcbSPgC9tXvoHD
	2qWjpCRQ=; b=QahiJn4V+XSRdfcHudaTevEZhfAkTcLbBCW8/7gw6zOhwRpWZlj
	X8FxMDt/3gsdezRYeowLJULqrQbQ79DXtQjK4Uvx/pq0CBR0MSyWaxg+ivzIuPDf
	1JxMHqTkpWkqx6vfdN9bFj9T3vfUhMCsintKYm0TVoV2cYE3awUsFNXRt8Jl9C8+
	3xkkl6muGO36LX92l27JiolztMKrXqwn4MKlk6efam4HXznDzkHx0Dkklvm1nsKF
	PBF7dQOFXrKed7ZrnRxJzHImGmatKD2lzo6gQActByV3LTjIG+UNVaGC+npCSYpn
	8Dy+XQuWbdHNMx3PqhE/NsaEdqvXRPfSe9g==
X-ME-Sender: <xms:jkHQZl-bzcZXL9KHixZjfNzJLXUUl7l3l43qMzqxoRAYcHLp2zjPKA>
    <xme:jkHQZpudrES9Z_pwGud6mJMCavJaAFFr52zY1w3FQAtWgm9xmkcDUsudDRT7hKAUO
    5NVIOCF9qyvImtRqw>
X-ME-Received: <xmr:jkHQZjC1XP_KmNy1-qu-D5Zc3Q80i6i0h3iLOhzNAt9bdIbLedA2lj04O5Re2MQKSDutYxB4WWlNL9z6qRzyA3vIcNG4KmAacEdT4cqoAouZl7M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepieeuvdfhteetlefghfehtddvheelhfdtfffhhffgleejfedv
    teefveeltdeuiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jkHQZpexZfLKPjkNefqh_Pi78pVCk0uGdFCqs1oAobpA0DToSlkf6A>
    <xmx:jkHQZqMLUnjsEfgCq9Bo0zB1jws0XFkf5jEsUhrqu4HyNc-Eh5v7Aw>
    <xmx:jkHQZrkCjoajzxTp9VFO3XfNMUl6ldFvtps92X7ZsgfZiP4zXc2OWA>
    <xmx:jkHQZkvwEkSPboh3IxxfdYWElD7qpZNGybs4H9nb20lNH51r_ku72w>
    <xmx:jkHQZjbKJyAy8ZFlHcPHU4pjg8-UaB58pVsb4F7mVfYQHqiXQfM--HVB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c812052 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:12 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 00/21] environment: guard reliance on `the_repository`
Message-ID: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

this patch series is the next part in the epic to get rid of
`the_repository`. This time around I focussed on the environment
subsystem, which relies on `the_repository` both implicitly and
explicitly.

The series is structured as follows:

  - Patches 1 to 6 moves functions that belong to the repository
    subsystem.

  - Patches 7 and 8 adapt the config subsystem to stop depending on the
    `the_repository` again, which had to be added by the preceding
    patches.

  - Patches 9 to 11 move various functionality that is misplaced and
    that depends on `the_repository`.

  - Patches 12 and 13 guard functionality that relies on global state
    in the environment subsystem via `USE_THE_REPOSITORY_VARIBABLE`.

  - Patches 14 to 21 demonstrate how to get rid of global config
    variables part of the environment subsystem for a subset of them.
    Overall, I think that our reliance on global variables is broken
    because those variables may or may not point to the actual config of
    a specific repository we currently hold. They may not even hold
    state of `the_repository`, but might've been changed by subsequent
    logic where we parse another repository's config.

I'm a bit unhappy that I wasn't able to adapt `is_bare_repository()` to
take a `struct repository` yet, and as a consequence a bunch of code
needs to declare `USE_THE_REPOSITORY_VARIBABLE` again. But it depends on
another global variable `is_bare_repository_cfg` which is being modified
quite heavily in multiple subsystems, and the resulting semantics are...
confusing. I guess we'll need another biggish patch series to clean up
this mess by making the setup subsystem not rely on such global state
anymore.

The series is built on top of 17d4b10aea (The tenth batch, 2024-08-28).
It merges with `next` rather cleanish, except for a single merge
conflict with headers.

Thanks!

Patrick

Patrick Steinhardt (21):
  environment: make `get_git_dir()` accept a repository
  environment: make `get_git_common_dir()` accept a repository
  environment: make `get_object_directory()` accept a repository
  environment: make `get_index_file()` accept a repository
  environment: make `get_graft_file()` accept a repository
  environment: make `get_git_work_tree()` accept a repository
  config: document `read_early_config()` and `read_very_early_config()`
  config: make dependency on repo in `read_early_config()` explicit
  environment: move `odb_mkstemp()` into object layer
  environment: make `get_git_namespace()` self-contained
  environment: move `set_git_dir()` and related into setup layer
  environment: reorder header to split out `the_repository`-free section
  environment: guard state depending on a repository
  repo-settings: split out declarations into a standalone header
  branch: stop modifying `log_all_ref_updates` variable
  refs: stop modifying global `log_all_ref_updates` variable
  repo-settings: track defaults close to `struct repo_settings`
  environment: stop storing "core.logAllRefUpdates" globally
  environment: stop storing "core.preferSymlinkRefs" globally
  environment: stop storing "core.warnAmbiguousRefs" globally
  environment: stop storing "core.notesRef" globally

 alias.c                     |   6 +-
 apply.c                     |   2 +-
 branch.c                    |   5 +-
 builtin/am.c                |  13 +-
 builtin/blame.c             |   2 +-
 builtin/checkout.c          |   4 +-
 builtin/commit-graph.c      |   4 +-
 builtin/commit.c            |  12 +-
 builtin/config.c            |   4 +-
 builtin/count-objects.c     |   2 +-
 builtin/difftool.c          |   8 +-
 builtin/fsmonitor--daemon.c |   6 +-
 builtin/gc.c                |   2 +-
 builtin/init-db.c           |   4 +-
 builtin/merge.c             |  17 +--
 builtin/multi-pack-index.c  |   2 +-
 builtin/notes.c             |  22 ++--
 builtin/pack-objects.c      |   2 +-
 builtin/prune.c             |   8 +-
 builtin/repack.c            |   7 +-
 builtin/replace.c           |   2 +-
 builtin/reset.c             |   4 +-
 builtin/rev-parse.c         |   9 +-
 builtin/stash.c             |  16 +--
 builtin/submodule--helper.c |   2 +-
 builtin/update-index.c      |   4 +-
 builtin/worktree.c          |   4 +-
 builtin/write-tree.c        |   3 +-
 bulk-checkin.c              |   4 +-
 bundle-uri.c                |   1 +
 cache-tree.c                |   3 +-
 commit.c                    |   4 +-
 config.c                    |  42 +------
 config.h                    |  13 +-
 dir.c                       |   2 +-
 environment.c               | 237 +++++-------------------------------
 environment.h               | 142 ++++++++++-----------
 fetch-pack.c                |   2 +-
 fsmonitor.c                 |   2 +-
 help.c                      |   2 +-
 http-backend.c              |   2 +-
 name-hash.c                 |   3 +
 notes.c                     |  21 ++--
 notes.h                     |   3 +-
 object-file.c               |  37 +++++-
 object-name.c               |   4 +-
 object-store-ll.h           |  15 +++
 pack-write.c                |   2 +-
 packfile.c                  |   2 +-
 pager.c                     |   7 +-
 path.c                      |   2 +
 pathspec.c                  |   4 +-
 preload-index.c             |   3 +
 prompt.c                    |   2 +
 prune-packed.c              |   4 +-
 read-cache.c                |   5 +-
 ref-filter.c                |   2 +-
 refs.c                      |   7 +-
 refs.h                      |   4 +-
 refs/files-backend.c        |  31 +++--
 refs/reftable-backend.c     |  22 ++--
 repo-settings.c             |  35 +++++-
 repo-settings.h             |  75 ++++++++++++
 repository.c                |  40 ++++++
 repository.h                |  58 ++-------
 server-info.c               |   3 +-
 setup.c                     | 152 +++++++++++++++++++----
 setup.h                     |   5 +-
 sparse-index.c              |   2 +
 statinfo.c                  |   2 +
 submodule.c                 |   2 +-
 t/helper/test-config.c      |   3 +-
 t/helper/test-path-utils.c  |   2 +
 tmp-objdir.c                |   7 +-
 trace.c                     |   8 +-
 trace2/tr2_cfg.c            |   4 +-
 transport-helper.c          |   2 +-
 tree-diff.c                 |   3 +
 userdiff.c                  |   2 +
 worktree.c                  |  12 +-
 wt-status.c                 |   2 +-
 81 files changed, 677 insertions(+), 554 deletions(-)
 create mode 100644 repo-settings.h

-- 
2.46.0.421.g159f2d50e7.dirty

