Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78591DFFC
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805101; cv=none; b=SB8WuWJpJ+27DsH8+l4YeUubyS7/wvblv3MVJcAptv4dpldR2cUo1ZXx4v8/CbP94GlohuejudulXIhNfg23UV2MyDqWpRaENXoZZ69VE3x/GTwJ46iC7XlFuvKDLEoqIS+WR5qyoctlhpYM90BFoYYbB2zNT1RqqUUcK2efZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805101; c=relaxed/simple;
	bh=5+Fbxjm66u6v9/EMjRLSSlFVOMKPZlG9PcAf8y9RNTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svu4P/0PfG8rnQtIFNcIX1KsL9ZTQcvBwkpFWzzUqnRGICV7xoUnXZKJChBkmHjiq//WbedyKyfBtNCtIey0AU91bls+Mj/1pfrc8OdsuGuhmsrQznRksEFYEEC+Hx74O3HCGX/uGtoC6e39dwmGpmJU/KMXLTpZsgSsXKHJYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HoplxkxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fh3LZF+w; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HoplxkxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fh3LZF+w"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 080F71151BE0;
	Fri, 16 Aug 2024 06:44:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 06:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723805099; x=1723891499; bh=QfKs6VvRJL
	DjB8P2yfhq9w/iNpr/UF8y7DTvVbJ891w=; b=HoplxkxYUqQqqOKN3K/4mWfqWW
	AShNu5V7DTIsxQg7r4yt9/HSlpe6FDiaz7x8es1nAOGEJI+dwJ2fTOMXFE/C1ImN
	vnU8gNGLw/0lpDcP7TbXQGLDOAPjhFb+wYspryyxYuuWRt1tyC55HvJTWRvNJ4jl
	iLLLTPsNoUY6T/O7OvgcCagVayBxllmJknQWHg6eqPOw8iPAHHjqxW2YiXsME/Q+
	ndZYoc7n+VjCSyDAPaXuc2qOHlx7ZpcM9YDMvnjG8KiNcRekw90LMWhqMrSK0ztb
	JtlMAkWNeBkuaCVPQMFzg3jB15Q9Gk91TVO/+BELcyTSHLbWEcaxlRpEgFRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723805099; x=1723891499; bh=QfKs6VvRJLDjB8P2yfhq9w/iNpr/
	UF8y7DTvVbJ891w=; b=fh3LZF+wSEuBaOVh06ZV0DageIXlvYz7Qd59SeypgJbC
	pxxKFSUWBeg/U/QKukzR5sFB1eCTSUim3ajrH421BUCfTQEt/rKMTPwYL1rLc9Ru
	IqohgbJ/FkQrdZXT0+o+WlY0CmvYH1i67YMYsEIQjSscT3zxslwOn24Zoywnd9Pg
	gS3aDqkIzcQ5mHV0VKxl0HF5Bi8yacuixsB7WDAmwh7hB9TrmvMpOk+a3gBeSsUY
	EBuQTbhqr05MYJHIIq3bMEo0j6pTPIssGlgTAJoa3vqsBQxG8t5nBKFP188ZXc4n
	jWIBmNrUD7XdSj7HzMgAV14b8chSQ0u3ei96e0bNKg==
X-ME-Sender: <xms:qi2_ZpRFYcw69qGQz_rjQdocdncw-rIz5_ySfx_WY2RCvdq-nYQCHw>
    <xme:qi2_Ziy0Uy5Kf8LtK7-1C4DMiDTvYbngbMknNK55iw2eE8d45xMwrG6aJVBacsuQf
    f0FJQFrpLoTSvxyZg>
X-ME-Received: <xmr:qi2_Zu2WcyVCqNnE1Dzm56iaYZ9DFsijy633y3okf9KO57n2tZMeBR77CVRAm72BIYln-AGw1gvpQKjc--f6t4DieUFlV9BsHPP7wfpZ4soVBlo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtkedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qi2_ZhCdL7kAmwlZDXgWIYRDeGcEgqJyKqZvSnPbzYc_fEX4DUOh5w>
    <xmx:qi2_ZigEZof_ADtxjTNHwtUKJNpXXy14DDiPErnF3Hg2k2EjPWJCwA>
    <xmx:qi2_ZlpR8lMPsl3w9Xm6pgsbg7PXksguz18dRgzTy8L38gCgbdLdzQ>
    <xmx:qi2_ZtgQ2fDWN6FOQVycrGzUrDV4C0DeDT26xocM6np4qz_b16dd6A>
    <xmx:qi2_ZtU3u1kfj0AVZEaduVq06JhaBd9vGvEjwnPKJffZ-ILB3zR67i-X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 06:44:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 284fb2db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 10:44:32 +0000 (UTC)
Date: Fri, 16 Aug 2024 12:44:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/7] builtin/maintenance: fix auto-detach with
 non-standard tasks
Message-ID: <cover.1723804990.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723533091.git.ps@pks.im>

Hi,

this is the second version of my patch series that fixes how
git-maintenance(1) detaches: instead of letting its child process
git-gc(1) detach, we now optionally ask git-maintenance(1) itself to
detach when running via our auto maintenance mechanism. This fixes
behaviour of git-maintenance(1) when configured to run non-standard
tasks like the "incremental" task.

Changes compared to v2:

  - Fix leaking git-gc(1) process in t6500.

  - Add missing documentation for `maintenance.autoDetach`.

Thanks!

Patrick

Patrick Steinhardt (7):
  config: fix constness of out parameter for `git_config_get_expiry()`
  builtin/gc: refactor to read config into structure
  builtin/gc: fix leaking config values
  builtin/gc: stop processing log file on signal
  builtin/gc: add a `--detach` flag
  builtin/maintenance: add a `--detach` flag
  run-command: fix detaching when running auto maintenance

 Documentation/config/gc.txt          |   3 +-
 Documentation/config/maintenance.txt |  11 +
 Documentation/git-gc.txt             |   5 +-
 builtin/gc.c                         | 384 +++++++++++++++++----------
 config.c                             |   4 +-
 config.h                             |   2 +-
 read-cache.c                         |  12 +-
 run-command.c                        |  12 +-
 t/t5304-prune.sh                     |   1 +
 t/t5616-partial-clone.sh             |   6 +-
 t/t6500-gc.sh                        |  45 +++-
 t/t7900-maintenance.sh               |  82 +++++-
 12 files changed, 396 insertions(+), 171 deletions(-)

Range-diff against v2:
1:  040453f27f = 1:  040453f27f config: fix constness of out parameter for `git_config_get_expiry()`
2:  ff6aa9d7ba = 2:  ff6aa9d7ba builtin/gc: refactor to read config into structure
3:  310e361371 = 3:  310e361371 builtin/gc: fix leaking config values
4:  812c61c9b6 = 4:  812c61c9b6 builtin/gc: stop processing log file on signal
5:  ca78d3dc7c ! 5:  b934b23889 builtin/gc: add a `--detach` flag
    @@ builtin/gc.c: static int maintenance_run(int argc, const char **argv, const char
      	for (i = 0; i < TASK__COUNT; i++)
     
      ## t/t6500-gc.sh ##
    +@@ t/t6500-gc.sh: test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
    + 	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
    + '
    + 
    +-run_and_wait_for_auto_gc () {
    ++run_and_wait_for_gc () {
    + 	# We read stdout from gc for the side effect of waiting until the
    + 	# background gc process exits, closing its fd 9.  Furthermore, the
    + 	# variable assignment from a command substitution preserves the
    + 	# exit status of the main gc process.
    + 	# Note: this fd trickery doesn't work on Windows, but there is no
    + 	# need to, because on Win the auto gc always runs in the foreground.
    +-	doesnt_matter=$(git gc --auto 9>&1)
    ++	doesnt_matter=$(git gc "$@" 9>&1)
    + }
    + 
    + test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
    +@@ t/t6500-gc.sh: test_expect_success 'background auto gc does not run if gc.log is present and re
    + 	test-tool chmtime =-345600 .git/gc.log &&
    + 	git gc --auto &&
    + 	test_config gc.logexpiry 2.days &&
    +-	run_and_wait_for_auto_gc &&
    ++	run_and_wait_for_gc --auto &&
    + 	ls .git/objects/pack/pack-*.pack >packs &&
    + 	test_line_count = 1 packs
    + '
     @@ t/t6500-gc.sh: test_expect_success 'background auto gc respects lock for all operations' '
    + 	printf "%d %s" "$shell_pid" "$hostname" >.git/gc.pid &&
    + 
    + 	# our gc should exit zero without doing anything
    +-	run_and_wait_for_auto_gc &&
    ++	run_and_wait_for_gc --auto &&
    + 	(ls -1 .git/refs/heads .git/reftable >actual || true) &&
      	test_cmp expect actual
      '
      
    @@ t/t6500-gc.sh: test_expect_success 'background auto gc respects lock for all ope
     +		git config gc.autodetach false &&
     +		git config gc.auto 2 &&
     +
    -+		cat >expect <<-EOF &&
    -+		Auto packing the repository in background for optimum performance.
    -+		See "git help gc" for manual housekeeping.
    -+		EOF
    -+		GIT_PROGRESS_DELAY=0 git gc --auto --detach 2>actual &&
    -+		test_cmp expect actual
    ++		# Note that we cannot use `test_cmp` here to compare stderr
    ++		# because it may contain output from `set -x`.
    ++		run_and_wait_for_gc --auto --detach 2>actual &&
    ++		test_grep "Auto packing the repository in background for optimum performance." actual
     +	)
     +'
     +
6:  06dbb73425 = 6:  347d0a2002 builtin/maintenance: add a `--detach` flag
7:  6bc170ff05 ! 7:  9befef7c1f run-command: fix detaching when running auto maintenance
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/config/gc.txt ##
    +@@ Documentation/config/gc.txt: use, it'll affect how the auto pack limit works.
    + 
    + gc.autoDetach::
    + 	Make `git gc --auto` return immediately and run in the background
    +-	if the system supports it. Default is true.
    ++	if the system supports it. Default is true. This config variable acts
    ++	as a fallback in case `maintenance.autoDetach` is not set.
    + 
    + gc.bigPackThreshold::
    + 	If non-zero, all non-cruft packs larger than this limit are kept
    +
    + ## Documentation/config/maintenance.txt ##
    +@@ Documentation/config/maintenance.txt: maintenance.auto::
    + 	`git maintenance run --auto` after doing their normal work. Defaults
    + 	to true.
    + 
    ++maintenance.autoDetach::
    ++	Many Git commands trigger automatic maintenance after they have
    ++	written data into the repository. This boolean config option
    ++	controls whether this automatic maintenance shall happen in the
    ++	foreground or whether the maintenance process shall detach and
    ++	continue to run in the background.
    +++
    ++If unset, the value of `gc.autoDetach` is used as a fallback. Defaults
    ++to true if both are unset, meaning that the maintenance process will
    ++detach.
    ++
    + maintenance.strategy::
    + 	This string config option provides a way to specify one of a few
    + 	recommended schedules for background maintenance. This only affects
    +
      ## builtin/gc.c ##
     @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts,
      		strvec_push(&child.args, "--quiet");
-- 
2.46.0.46.g406f326d27.dirty

