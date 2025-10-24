Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0427F4E7
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289044; cv=none; b=IyEu/FHXsjekvJNL7+WjtFdxtULtYUshMSAnITDMuK6JMj13SOO3whIUcXM7A1sBGvfbWX7tblrokFBehvIcPmO61SvjR4uvewwjYbBJewHLHxhYckbcgDoekwhRe1td3elKvEzS7lzxcdptK8yG1+4796DSr2KGklic4ss2l1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289044; c=relaxed/simple;
	bh=FE2+t5rrgHabcodxtT1rottX98wLdvBr0XghaD+7gwM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rydfZ8wBFSJf8uZcvT64lx4VdsUIRi0zyE3txjVIiHQg2S+diyfeouMeghZJd0kt4c4y5zQ4yJJiyQl2LmFePx8K3WajOSbnpdSoblJhB2cTWP+EKgPpXiztjSwaczja5Tet02sif/4K9ARTGdExpZf7PfEEGayGF9GH/3498G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T3VatAEB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kh7lja8I; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T3VatAEB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kh7lja8I"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD7FA1400157;
	Fri, 24 Oct 2025 02:57:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 02:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289040;
	 x=1761375440; bh=Ffp+10Fk+B/FDOuJrq3n1xuvVh8r+9oOPilNTYHfVg4=; b=
	T3VatAEBHkbhjRZqaszYdvhFmJp0zvuslePLt+G/wg9g/DWMqz67i5smUB87isDs
	ZE5aix3Fe7aKEbagCIWBJ4EU0mwQAxP3hJII89Wm++EXLVe1Wjphpq81BC32LJP8
	Vsg9zfqBb/xGcVMBZdIOoG/swEkk9ZtsCLGWFmWSufBJ4Z7kxAKvl+ykF1K2s2Kc
	X5Xe7RcQvW2ge3/NcoZ3ED6Y5RtbgF1vSpwCMOIIgC3GPKZFl+Ww65rW3CpEypAT
	RsTA4rZqHxJjw7OMx9aCbsd11wlMW7aiEgO1o/vWd3Jiri4xg3AE5JXyLQk9ZMUl
	27aD+mnwgyw4rYkPf55xYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289040; x=
	1761375440; bh=Ffp+10Fk+B/FDOuJrq3n1xuvVh8r+9oOPilNTYHfVg4=; b=k
	h7lja8Im1QZVyG9LpMuGcKl2RQE/x7B+BBtooQ6SPD05yXV5F6v4c8ix/nqbx2Zr
	sHHOhy1anrPvDML/lPB3Eu0+gpZSyegUbs1KAcnQop9iyGuJGkDjVnuvuecRvv5M
	AcIQmrtG30708CkqUCJe3fB1BRpoU3QMdgaqdgOrK6W1nhFEPUmLnpoNupt5YJmi
	z9yDYM5DIPC6e56TqdEZNzFYtxIUJmlGOxIXiO9bgZHwSgBHc04Gmj0wIlm7qsdP
	q/K2gTgtYyoH3vyaEEuguOndJ8W2CBj40oczystl7e6U4kyhGAUVuSYvXQTwhtbH
	WK14pQxp3EL5ixi/k811Q==
X-ME-Sender: <xms:UCP7aPYfaePQWQsxfL0e_GHlUXnTUXu4HYD5wLxOExBOzBmmFGS1dA>
    <xme:UCP7aFSGbiyAh6AR5k4BUAENlc3vGJkJv2-lK_RH3y9Wx1vmeUzS5akblF-ISSeoO
    toBz6Ns-lzOE7_xjbuY_Ojg5aceLCTxTHctLXefEdTY4qxenAqK>
X-ME-Received: <xmr:UCP7aKQ8QYgiObFwZJSnrO_mTyphY0XtZTp5cPO149Yco02i83mBGHiZXWhvNACR3BK1_IruknlnzU6DPtQIGYA2zosnIGY9MTXh3bY2vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetjedvtdduhedvvdeiueeiieduveejffeiieduhfdufeffffdtfeeuffefhfffffen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhinhgtrhgvmhgvnhhtrghlqdhrvghprg
    gtkhdrrghuthhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:UCP7aBRUE0VBv0Xp6tZsQKP9zEBUyuqVNbN2V0ogqxmjNWXe2mjHYg>
    <xmx:UCP7aH6BStaWiPdneLzSOUICWcDwd6pBlQMwxXourDEhjBs_IuVRfg>
    <xmx:UCP7aF2wNNYE1ZcKf5r4z6y9uExdh-Ntlc2F9NULpTD9PC7q_rjnew>
    <xmx:UCP7aKDt1xzvWMygLdHMENDt0g8FXJGuFBYMtF_GRRG5wu2GK_uOSQ>
    <xmx:UCP7aFpfXhsox6fpeSSYo6jR8-Nj6BLyMu95gXm-ml_QFBTIj4yAJ8lh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c507aa1e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/10] builtin/maintenance: introduce "geometric"
 strategy
Date: Fri, 24 Oct 2025 08:57:13 +0200
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEkj+2gC/43NTQqDMBCG4atI1k3Jj6lpV71H6SLGUYdilCSEi
 nj3RqGlS5fvwDzfQgJ4hEBuxUI8JAw4uhzyVBDbG9cBxSY3EUwozrii0yvQwaCL4IyzQDsYB4g
 eLQ3RmwjdTJVmVmmlec04ydDkocX3PvJ45u4xxNHP+2bi2/XLX47wiVNGub6WsimrUjB5z09nH
 MhmJ/HnCX7IE9lrWVOJSktRa/bz1nX9ALfjDjYhAQAA
X-Change-ID: 20251015-pks-maintenance-geometric-strategy-580c58581b01
In-Reply-To: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
References: <20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

by default, git-maintenance(1) uses git-gc(1) to perform repository
housekeeping. This tool has a couple of shortcomings, most importantly
that it regularly does all-into-one repacks. This doesn't really work
all that well in the context of monorepos, where you really want to
avoid repacking all objects regularly.

An alternative maintenance strategy is the "incremental" strategy, but
this strategy has two downsides:

  - Strategies in general only apply to scheduled maintenance. So if you
    run git-maintenance(1), you still end up with git-gc(1).

  - The strategy is designed to not ever delete any data, but a full
    replacment for git-gc(1) needs to also prune reflogs, rereree caches
    and vanished worktrees.

This patch series aims to fix both of these issues.

First, the series introduces a new "geometric" maintenance task, which
makes use of geometric repacking as exposed by git-repack(1) in the
general case. In the case where a geometric repack ends up merging all
packfiles into one we instead do an all-into-one repack with cruft packs
so that we can still phase out objects over time.

Second, the series extends maintenance strategies to also cover normal
maintenance. If the user has configured the "geometric" strategy, we'll
thus use it for both manual and scheduled maintenance. For backwards
compatibility, the "incremental" strategy is changed so that it uses
git-gc(1) for manual maintenance and the other tasks for scheduled
maintenance.

The series is built on top of b660e2dcb9 (Sync with 'maint', 2025-10-14)
with tb/incremental-midx-part-3.1 at c886af90f8 (SQUASH??? play well
with other topics by preemptively including "repository.h", 2025-09-29)
merged into it.

Changes in v3:
  - More line wrapping.
  - Improve readability of maintenance strategies by using nested
    designated initializers.
  - Use git-count-object(1) to count loose objects.
  - Link to v2: https://lore.kernel.org/r/20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im

Changes in v2:
  - Make the geometric factor configurable via
    "maintenance.geometric-repack.splitFactor".
  - Wrap some overly long lines in our tests.
  - Link to v1: https://lore.kernel.org/r/20251016-pks-maintenance-geometric-strategy-v1-0-18943d474203@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (10):
      builtin/gc: remove global `repack` variable
      builtin/gc: make `too_many_loose_objects()` reusable without GC config
      builtin/maintenance: introduce "geometric-repack" task
      builtin/maintenance: make the geometric factor configurable
      builtin/maintenance: don't silently ignore invalid strategy
      builtin/maintenance: improve readability of strategies
      builtin/maintenance: run maintenance tasks depending on type
      builtin/maintenance: extend "maintenance.strategy" to manual maintenance
      builtin/maintenance: make "gc" strategy accessible
      builtin/maintenance: introduce "geometric" strategy

 Documentation/config/maintenance.adoc |  49 +++++-
 builtin/gc.c                          | 313 ++++++++++++++++++++++++++++------
 t/t7900-maintenance.sh                | 245 ++++++++++++++++++++++++++
 3 files changed, 544 insertions(+), 63 deletions(-)

Range-diff versus v2:

 1:  b853ba54dca =  1:  c35408a33d0 builtin/gc: remove global `repack` variable
 2:  9bbdfe1b9e5 =  2:  be572fe1542 builtin/gc: make `too_many_loose_objects()` reusable without GC config
 3:  bcd82ad038e !  3:  5290f6d3e0f builtin/maintenance: introduce "geometric-repack" task
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +	test_line_count = "$EXPECTED_PACKS" packfiles &&
     +
     +	# And verify that there are no loose objects anymore.
    -+	cat >expect <<-\EOF &&
    -+	info
    -+	pack
    -+	EOF
    -+	ls .git/objects >actual &&
    -+	test_cmp expect actual
    ++	git count-objects -v >count &&
    ++	test_grep '^count: 0$' count
     +}
     +
     +test_expect_success 'geometric repacking task' '
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		# The initial repack causes an all-into-one repack.
     +		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
     +			git maintenance run --task=geometric-repack 2>/dev/null &&
    -+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <initial-repack.txt &&
    ++		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
    ++			--quiet --write-midx <initial-repack.txt &&
     +
     +		# Repacking should now cause a no-op geometric repack because
     +		# no packfiles need to be combined.
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		# an all-into-one-repack.
     +		GIT_TRACE2_EVENT="$(pwd)/all-into-one-repack.txt" \
     +			git maintenance run --task=geometric-repack 2>/dev/null &&
    -+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <all-into-one-repack.txt &&
    ++		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
    ++			--quiet --write-midx <all-into-one-repack.txt &&
     +
     +		# The geometric repack soaks up unreachable objects.
     +		echo blob-1 | git hash-object -w --stdin -t blob &&
    @@ t/t7900-maintenance.sh: test_expect_success 'maintenance.incremental-repack.auto
     +		run_and_verify_geometric_pack 3 &&
     +		GIT_TRACE2_EVENT="$(pwd)/cruft-repack.txt" \
     +			git maintenance run --task=geometric-repack 2>/dev/null &&
    -+		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago --quiet --write-midx <cruft-repack.txt &&
    ++		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
    ++			--quiet --write-midx <cruft-repack.txt &&
     +		ls .git/objects/pack/*.pack >packs &&
     +		test_line_count = 2 packs &&
     +		ls .git/objects/pack/*.mtimes >cruft &&
 4:  cb10031cc7c =  4:  7f2067fa4ec builtin/maintenance: make the geometric factor configurable
 5:  7e8f83d4753 =  5:  7a76003215e builtin/maintenance: don't silently ignore invalid strategy
 -:  ----------- >  6:  a6383d121b2 builtin/maintenance: improve readability of strategies
 6:  4217c37c0bf !  7:  e25c878a3ff builtin/maintenance: run maintenance tasks depending on type
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      		enum schedule_priority schedule;
      	} tasks[TASK__COUNT];
      };
    - 
    - static const struct maintenance_strategy none_strategy = { 0 };
    -+
    +@@ builtin/gc.c: static const struct maintenance_strategy none_strategy = { 0 };
      static const struct maintenance_strategy default_strategy = {
      	.tasks = {
    --		[TASK_GC].enabled = 1,
    -+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
    + 		[TASK_GC] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_MANUAL,
    + 		},
      	},
      };
    -+
    +@@ builtin/gc.c: static const struct maintenance_strategy default_strategy = {
      static const struct maintenance_strategy incremental_strategy = {
      	.tasks = {
    --		[TASK_COMMIT_GRAPH].enabled = 1,
    -+		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
    --		[TASK_PREFETCH].enabled = 1,
    -+		[TASK_PREFETCH].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_PREFETCH].schedule = SCHEDULE_HOURLY,
    --		[TASK_INCREMENTAL_REPACK].enabled = 1,
    -+		[TASK_INCREMENTAL_REPACK].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY,
    --		[TASK_LOOSE_OBJECTS].enabled = 1,
    -+		[TASK_LOOSE_OBJECTS].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
    --		[TASK_PACK_REFS].enabled = 1,
    -+		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
    + 		[TASK_COMMIT_GRAPH] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_HOURLY,
    + 		},
    + 		[TASK_PREFETCH] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_HOURLY,
    + 		},
    + 		[TASK_INCREMENTAL_REPACK] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_DAILY,
    + 		},
    + 		[TASK_LOOSE_OBJECTS] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_DAILY,
    + 		},
    + 		[TASK_PACK_REFS] = {
    +-			.enabled = 1,
    ++			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_WEEKLY,
    + 		},
      	},
    - };
     @@ builtin/gc.c: static void initialize_task_config(struct maintenance_run_opts *opts,
      {
      	struct strbuf config_name = STRBUF_INIT;
 7:  422b16a62a2 !  8:  ba147c3bf33 builtin/maintenance: extend "maintenance.strategy" to manual maintenance
    @@ Documentation/config/maintenance.adoc: detach.
     
      ## builtin/gc.c ##
     @@ builtin/gc.c: static const struct maintenance_strategy incremental_strategy = {
    - 		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
    - 		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED,
    - 		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
    -+
    + 			.type = MAINTENANCE_TYPE_SCHEDULED,
    + 			.schedule = SCHEDULE_WEEKLY,
    + 		},
     +		/*
     +		 * Historically, the "incremental" strategy was only available
     +		 * in the context of scheduled maintenance when set up via
    @@ builtin/gc.c: static const struct maintenance_strategy incremental_strategy = {
     +		 * requested. This is the same as the default strategy, which
     +		 * would have been in use beforehand.
     +		 */
    -+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
    ++		[TASK_GC] = {
    ++			.type = MAINTENANCE_TYPE_MANUAL,
    ++		},
      	},
      };
      
 8:  07f5b32a22e !  9:  eebfab4acda builtin/maintenance: make "gc" strategy accessible
    @@ builtin/gc.c: struct maintenance_strategy {
     -static const struct maintenance_strategy default_strategy = {
     +static const struct maintenance_strategy gc_strategy = {
      	.tasks = {
    --		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_GC].type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
    -+		[TASK_GC].schedule = SCHEDULE_DAILY,
    + 		[TASK_GC] = {
    +-			.type = MAINTENANCE_TYPE_MANUAL,
    ++			.type = MAINTENANCE_TYPE_MANUAL | MAINTENANCE_TYPE_SCHEDULED,
    ++			.schedule = SCHEDULE_DAILY,
    + 		},
      	},
      };
    - 
     @@ builtin/gc.c: static struct maintenance_strategy parse_maintenance_strategy(const char *name)
      {
      	if (!strcasecmp(name, "incremental"))
 9:  c597ae7f94a ! 10:  936358736f3 builtin/maintenance: introduce "geometric" strategy
    @@ builtin/gc.c: static const struct maintenance_strategy incremental_strategy = {
      
     +static const struct maintenance_strategy geometric_strategy = {
     +	.tasks = {
    -+		[TASK_COMMIT_GRAPH].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
    -+		[TASK_GEOMETRIC_REPACK].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_GEOMETRIC_REPACK].schedule = SCHEDULE_DAILY,
    -+		[TASK_PACK_REFS].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_PACK_REFS].schedule = SCHEDULE_DAILY,
    -+		[TASK_RERERE_GC].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_RERERE_GC].schedule = SCHEDULE_WEEKLY,
    -+		[TASK_REFLOG_EXPIRE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_REFLOG_EXPIRE].schedule = SCHEDULE_WEEKLY,
    -+		[TASK_WORKTREE_PRUNE].type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    -+		[TASK_WORKTREE_PRUNE].schedule = SCHEDULE_WEEKLY,
    ++		[TASK_COMMIT_GRAPH] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_HOURLY,
    ++		},
    ++		[TASK_GEOMETRIC_REPACK] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_DAILY,
    ++		},
    ++		[TASK_PACK_REFS] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_DAILY,
    ++		},
    ++		[TASK_RERERE_GC] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_WEEKLY,
    ++		},
    ++		[TASK_REFLOG_EXPIRE] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_WEEKLY,
    ++		},
    ++		[TASK_WORKTREE_PRUNE] = {
    ++			.type = MAINTENANCE_TYPE_SCHEDULED | MAINTENANCE_TYPE_MANUAL,
    ++			.schedule = SCHEDULE_WEEKLY,
    ++		},
     +	},
     +};
     +

---
base-commit: 0bb2c786c2349dd6700727153c13d81cbfb41710
change-id: 20251015-pks-maintenance-geometric-strategy-580c58581b01

