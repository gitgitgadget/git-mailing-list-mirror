Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93164CB5B
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848656; cv=none; b=W9COSKOwbMiu5GgltwVz8N7yO9VmkkSYKW6EfNVpz7jWh8vlaVyAIEQYYYO55O0CUJ0qaaubRYn1Lx+xqwK4OFUw2pxSSrw+SZtP2l2CHu1S4dyjm0TxbVIGfOXx0o53z+Xc1/SSxEHXqm158SRnCBgwDMlTvtUn5yVnkR7ZTW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848656; c=relaxed/simple;
	bh=nZQB7okrikWeOBNFbH5I3QuPjzqO42L01j8/CSzODDM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=s7/jKWA/LWeLVSidrS6Mbyo19bMxBfJYyT5MVn0lbWQlG7RkIZAuf2e1VRZLM76XGDgg6/VvaD2s6Lcbt+1WRWu5Xd+qFHVn5VvVVqo4lDE/2qOiuaGHob+HO6ItRz3ncsGMPivwhg1edh9muu/+4CAUzeCd0baFMLeK+Wu0wlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S2oGObFb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixHZpmyN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S2oGObFb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixHZpmyN"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id B08C6114010B;
	Mon,  2 Jun 2025 03:17:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 03:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848652;
	 x=1748935052; bh=fr6xkcr3i4/47iXU4+G7FIKZFET5hxKXfG1tMJyNjcQ=; b=
	S2oGObFb8jczq9Ok2FMcDkoDg+zZ9cx0/Hmhz6BHq7pp9iffKWUAzCBPlm6K25rC
	/0eB12QBc8NvBrVL+x5wgNkmsTpn7JcFoVqRqJP0nRokHjfXT8iis3MkFbUqubHY
	t7u9BNnh6rJpSKHeFN1TmRyWWuTtj7YFf1wrx5mnFV+nhnFysJLWiHDjJeQvNv4K
	Vy+k26kwLRspPCOUoQMxzazwidx4NIxXOvRrV0MzJg3QMOkh3PR7bQj/60X2rsUH
	NlAh32MdcgcVTTFtpG/E3c3uOn1O846s/ffSgsMErXFXiLEmgHwdIlkJ6SCXtVIk
	89yRbqjop35ChHLclVxbMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848652; x=
	1748935052; bh=fr6xkcr3i4/47iXU4+G7FIKZFET5hxKXfG1tMJyNjcQ=; b=i
	xHZpmyNim/aNo/wCDiOhTqkyJZi6hkHz69AR7C6YArGQENXZ0FpLVfDM/OgCe5oc
	tOlRGkhRZ+VDFAfGefJ9DPtOLCidCfC+lr0lymEXmn5BF5MvyrxVhmPB5BNJOAHS
	F1fDN6TcZcSS41rvbq6+rklxeoMgluhM+Y7ka0NzsoONFHIm+g5X517IT5feMJ+j
	oqPKQu4x5l0DsYPWit24cv9tsIndIfzVvhA+lceV3xMUNcP9O2HMTBVokWd4fIZc
	BjfdQXkTTqjAUPD0j0qUGhDmZDnGK39roG1U4tTM+TWdxv1pyVivjNJBB+OhbqCg
	OKQO/J+dTkvli+t/vIbxA==
X-ME-Sender: <xms:DFA9aPcgWeMJu_p1RCGdmjqhLicPmTzuToBHAo2x3uwoXtYa3DGX1g>
    <xme:DFA9aFMPO74jyUxijlnJ0TPCKcLxWFjg2xEtdNFecUwck_gWobZJmr50FG6GGXSNt
    UuVnk8dj6_bXep-3Q>
X-ME-Received: <xmr:DFA9aIhwziC8nilp9bCbDRYNgGVxB4nSa06w7Ux6gPjJVvxcQtn2yfIwtQLBG_RSdABENEPQ3G7H7leo3Q53-Z14oJ6XygiT4WPssY_D_tn6wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfg
    jghfvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedt
    ueehtddtieekfedtudehtdehfefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhs
    rdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlh
    horghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:DFA9aA-GQ2N5XlH1lmxwUvxmiOF0ZLpFpY-cMkh8P9zDslWldbtkBw>
    <xmx:DFA9aLtSScKEBmBPpoaqxCcH4Dc_xORbSgxF5Tudyw4sTkZd0tC7HQ>
    <xmx:DFA9aPHX1oj9KPfCkQGBrrg6Yo-1YTnYjeF6ndHTxO6suIvxGmynOA>
    <xmx:DFA9aCMJRsyiNpd8ShYM_X0WP8feRukoC0rxoEUvIIrbw1gmWHWbqQ>
    <xmx:DFA9aCAVfc6ZNf3PFmDiRERjdTUwLKCfIxzZ8uqO9Q4z1FXFNW8v3cuo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 03223c1c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/12] builtin/maintenance: fix ref lock races when
 detaching
Date: Mon, 02 Jun 2025 09:17:26 +0200
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAZQPWgC/5XNzQ6CMAzA8VchO1uzDZgfJ9/DeBhbJwsyyEYWD
 eHdLRyMRz3+2+bXmSWMHhM7FzOLmH3yQ6AodwUzrQ53BG+pmeSy5rU8QFPB2CXotQ8TBh0MQkQ
 Hj8F0EDWVEBprq47IlWPEjLT2z+3F9Ubd+jQN8bV9zGKd/oFnARxQGGykRa0UXuh+73u2yll+a
 SX/QZOkWV6hdKcSa+E+2rIsb1a8HXobAQAA
X-Change-ID: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series fixes races around locking the "packed-refs" file when
auto-maintenance decides to repack it. This issue has been reported e.g.
via [1] and [2].

The root cause is that git-gc(1) used to know to detach _after_ having
repacked references. As such, callers wouldn't continue with their thing
until we have already packed refs, and thus the race does not exist
there. git-maintenance(1) didn't have the same split though, so this
patch series retrofits that logic.

The series is structured as follows:

  - Patches 1 and 2 do some light refactorings.

  - Patches 3 to 5 refactor how we set up the list of tasks to not rely
    on globals anymore. Instead, we now have a single source of truth
    for which tasks exactly will be run.

  - The remaining patches introduce the split of before/after-detach
    tasks and wire them up for "pack-refs", "reflog-expire" and "gc"
    tasks.

Changes in v2:
  - A couple of commit message improvements.
  - Introduce `die(NULL)` to die with the correct exit code but no error
    message. This gets rid of some magic numbers.
  - Introduce an enum to discern the phases before and after detach.
  - Link to v1: https://lore.kernel.org/r/20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im

Changes in v3:
  - Rework logic to talk about foreground/background tasks instead of
    before/after detach.
  - Link to v2: https://lore.kernel.org/r/20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im

Thanks!

Patrick

[1]: <CAJR-fbZ4X1+gN75m2dUvocR6NkowLOZ9F26cjBy8w1qd181OoQ@mail.gmail.com>
[2]: <CANi7bVAkNc+gY1NoXfJuDRjxjZLTgL8Lfn8_ZmWsvLAoiLPkNg@mail.gmail.com>

---
Patrick Steinhardt (12):
      builtin/gc: use designated field initializers for maintenance tasks
      builtin/gc: drop redundant local variable
      builtin/maintenance: centralize configuration of explicit tasks
      builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
      builtin/maintenance: stop modifying global array of tasks
      builtin/maintenance: extract function to run tasks
      builtin/maintenance: fix typedef for function pointers
      builtin/maintenance: split into foreground and background tasks
      builtin/maintenance: fix locking race when packing refs and reflogs
      usage: allow dying without writing an error message
      builtin/gc: avoid global state in `gc_before_repack()`
      builtin/maintenance: fix locking race when handling "gc" task

 builtin/am.c                |   4 +-
 builtin/checkout.c          |   4 +-
 builtin/fetch.c             |   2 +-
 builtin/gc.c                | 410 +++++++++++++++++++++++++-------------------
 builtin/submodule--helper.c |  12 +-
 t/t7900-maintenance.sh      |  19 +-
 usage.c                     |   2 +
 7 files changed, 263 insertions(+), 190 deletions(-)

Range-diff versus v2:

 1:  2c90fadd640 =  1:  00fa348fb9c builtin/gc: use designated field initializers for maintenance tasks
 2:  ebd37a92895 =  2:  d7a2072da28 builtin/gc: drop redundant local variable
 3:  90863ae9957 =  3:  2eef35388e1 builtin/maintenance: centralize configuration of explicit tasks
 4:  f0c05004ea3 =  4:  372efcf7fec builtin/maintenance: mark "--task=" and "--schedule=" as incompatible
 5:  85c8273d4f4 =  5:  979f27b19ce builtin/maintenance: stop modifying global array of tasks
 6:  a9d49980f8a =  6:  b89c8d237ed builtin/maintenance: extract function to run tasks
 7:  35a78300572 =  7:  96554899fd9 builtin/maintenance: fix typedef for function pointers
 8:  b5fe34348aa !  8:  b79befc82be builtin/maintenance: let tasks do maintenance before and after detach
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    builtin/maintenance: let tasks do maintenance before and after detach
    +    builtin/maintenance: split into foreground and background tasks
     
         Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
         the maintenance tasks are performed in the background. git-gc(1) has
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## builtin/gc.c ##
    -@@ builtin/gc.c: typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
    +@@ builtin/gc.c: static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
    + 
    + typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
    + 				   struct gc_config *cfg);
    +-
    +-/*
    +- * An auto condition function returns 1 if the task should run
    +- * and 0 if the task should NOT run. See needs_to_gc() for an
    +- * example.
    +- */
    + typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
      
      struct maintenance_task {
      	const char *name;
     -	maintenance_task_fn fn;
    -+	maintenance_task_fn before_detach;
    -+	maintenance_task_fn after_detach;
    ++
    ++	/*
    ++	 * Work that will be executed before detaching. This should not include
    ++	 * tasks that may run for an extended amount of time as it does cause
    ++	 * auto-maintenance to block until foreground tasks have been run.
    ++	 */
    ++	maintenance_task_fn foreground;
    ++
    ++	/*
    ++	 * Work that will be executed after detaching. When not detaching the
    ++	 * work will be run in the foreground, as well.
    ++	 */
    ++	maintenance_task_fn background;
    ++
    ++	/*
    ++	 * An auto condition function returns 1 if the task should run and 0 if
    ++	 * the task should NOT run. See needs_to_gc() for an example.
    ++	 */
      	maintenance_auto_fn auto_condition;
      };
      
    @@ builtin/gc.c: typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
      	[TASK_PREFETCH] = {
      		.name = "prefetch",
     -		.fn = maintenance_task_prefetch,
    -+		.after_detach = maintenance_task_prefetch,
    ++		.background = maintenance_task_prefetch,
      	},
      	[TASK_LOOSE_OBJECTS] = {
      		.name = "loose-objects",
     -		.fn = maintenance_task_loose_objects,
    -+		.after_detach = maintenance_task_loose_objects,
    ++		.background = maintenance_task_loose_objects,
      		.auto_condition = loose_object_auto_condition,
      	},
      	[TASK_INCREMENTAL_REPACK] = {
      		.name = "incremental-repack",
     -		.fn = maintenance_task_incremental_repack,
    -+		.after_detach = maintenance_task_incremental_repack,
    ++		.background = maintenance_task_incremental_repack,
      		.auto_condition = incremental_repack_auto_condition,
      	},
      	[TASK_GC] = {
      		.name = "gc",
     -		.fn = maintenance_task_gc,
    -+		.after_detach = maintenance_task_gc,
    ++		.background = maintenance_task_gc,
      		.auto_condition = need_to_gc,
      	},
      	[TASK_COMMIT_GRAPH] = {
      		.name = "commit-graph",
     -		.fn = maintenance_task_commit_graph,
    -+		.after_detach = maintenance_task_commit_graph,
    ++		.background = maintenance_task_commit_graph,
      		.auto_condition = should_write_commit_graph,
      	},
      	[TASK_PACK_REFS] = {
      		.name = "pack-refs",
     -		.fn = maintenance_task_pack_refs,
    -+		.after_detach = maintenance_task_pack_refs,
    ++		.background = maintenance_task_pack_refs,
      		.auto_condition = pack_refs_condition,
      	},
      	[TASK_REFLOG_EXPIRE] = {
      		.name = "reflog-expire",
     -		.fn = maintenance_task_reflog_expire,
    -+		.after_detach = maintenance_task_reflog_expire,
    ++		.background = maintenance_task_reflog_expire,
      		.auto_condition = reflog_expire_condition,
      	},
      	[TASK_WORKTREE_PRUNE] = {
      		.name = "worktree-prune",
     -		.fn = maintenance_task_worktree_prune,
    -+		.after_detach = maintenance_task_worktree_prune,
    ++		.background = maintenance_task_worktree_prune,
      		.auto_condition = worktree_prune_condition,
      	},
      	[TASK_RERERE_GC] = {
      		.name = "rerere-gc",
     -		.fn = maintenance_task_rerere_gc,
    -+		.after_detach = maintenance_task_rerere_gc,
    ++		.background = maintenance_task_rerere_gc,
      		.auto_condition = rerere_gc_condition,
      	},
      };
      
     +enum task_phase {
    -+	TASK_PHASE_BEFORE_DETACH,
    -+	TASK_PHASE_AFTER_DETACH,
    ++	TASK_PHASE_FOREGROUND,
    ++	TASK_PHASE_BACKGROUND,
     +};
     +
      static int maybe_run_task(const struct maintenance_task *task,
    @@ builtin/gc.c: typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
     +			  struct gc_config *cfg,
     +			  enum task_phase phase)
      {
    -+	int before = (phase == TASK_PHASE_BEFORE_DETACH);
    -+	maintenance_task_fn fn = before ? task->before_detach : task->after_detach;
    -+	const char *region = before ? "maintenance before" : "maintenance";
    ++	int foreground = (phase == TASK_PHASE_FOREGROUND);
    ++	maintenance_task_fn fn = foreground ? task->foreground : task->background;
    ++	const char *region = foreground ? "maintenance foreground" : "maintenance";
      	int ret = 0;
      
     +	if (!fn)
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      
     +	for (size_t i = 0; i < opts->tasks_nr; i++)
     +		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
    -+				   TASK_PHASE_BEFORE_DETACH))
    ++				   TASK_PHASE_FOREGROUND))
     +			result = 1;
     +
      	/* Failure to daemonize is ok, we'll continue in foreground. */
    @@ builtin/gc.c: static int maintenance_run_tasks(struct maintenance_run_opts *opts
      	for (size_t i = 0; i < opts->tasks_nr; i++)
     -		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
     +		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
    -+				   TASK_PHASE_AFTER_DETACH))
    ++				   TASK_PHASE_BACKGROUND))
      			result = 1;
      
      	rollback_lock_file(&lk);
 9:  79766b0afa0 <  -:  ----------- builtin/maintenance: fix locking race when packing refs and reflogs
 -:  ----------- >  9:  8b3f82b871d builtin/maintenance: fix locking race when packing refs and reflogs
10:  d74a6a3fe7f = 10:  7c61970f4aa usage: allow dying without writing an error message
11:  f8e77819f6e = 11:  39a1aa9dcb0 builtin/gc: avoid global state in `gc_before_repack()`
12:  31007c209cb ! 12:  8b263d0fc2b builtin/maintenance: fix locking race when handling "gc" task
    @@ Commit message
         for the "pack-refs" and "reflog-expire" tasks in preceding commits. Fix
         this by splitting up the logic of the "gc" task:
     
    -      - Before detaching we execute `gc_before_repack()`, which contains the
    -        logic that git-gc(1) itself would execute before detaching.
    +      - We execute `gc_before_repack()` in the foreground, which contains
    +        the logic that git-gc(1) itself would execute in the foreground, as
    +        well.
     
    -      - After detaching we spawn git-gc(1), but with a new hidden flag that
    +      - We spawn git-gc(1) after detaching, but with a new hidden flag that
             suppresses calling `gc_before_repack()`.
     
         Like this we have roughly the same logic as git-gc(1) itself and know to
         repack refs and reflogs before detaching, thus fixing the race.
     
    -    Note that `gc_before_repack()` is renamed to `gc_before_detach()` to
    +    Note that `gc_before_repack()` is renamed to `gc_foreground_tasks()` to
         better reflect what this function does.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ builtin/gc.c: static int report_last_gc_error(void)
      }
      
     -static int gc_before_repack(struct maintenance_run_opts *opts,
    -+static int gc_before_detach(struct maintenance_run_opts *opts,
    - 			    struct gc_config *cfg)
    +-			    struct gc_config *cfg)
    ++static int gc_foreground_tasks(struct maintenance_run_opts *opts,
    ++			       struct gc_config *cfg)
      {
      	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
    + 		return error(FAILED_RUN, "pack-refs");
     @@ builtin/gc.c: int cmd_gc(int argc,
      	pid_t pid;
      	int daemonized = 0;
      	int keep_largest_pack = -1;
    -+	int skip_maintenance_before_detach = 0;
    ++	int skip_foreground_tasks = 0;
      	timestamp_t dummy;
      	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
      	struct gc_config cfg = GC_CONFIG_INIT;
    @@ builtin/gc.c: int cmd_gc(int argc,
      			 N_("repack all other packs except the largest pack")),
      		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
      			   N_("pack prefix to store a pack containing pruned objects")),
    -+		OPT_HIDDEN_BOOL(0, "skip-maintenance-before-detach", &skip_maintenance_before_detach,
    -+			   N_("skip maintenance steps typically done before detaching")),
    ++		OPT_HIDDEN_BOOL(0, "skip-foreground-tasks", &skip_foreground_tasks,
    ++			   N_("skip maintenance tasks typically done in the foreground")),
      		OPT_END()
      	};
      
    @@ builtin/gc.c: int cmd_gc(int argc,
     -			ret = 0;
     -			goto out;
     -		}
    -+		if (!skip_maintenance_before_detach) {
    ++		if (!skip_foreground_tasks) {
     +			if (lock_repo_for_gc(force, &pid)) {
     +				ret = 0;
     +				goto out;
    @@ builtin/gc.c: int cmd_gc(int argc,
     -		if (gc_before_repack(&opts, &cfg) < 0)
     -			die(NULL);
     -		delete_tempfile(&pidfile);
    -+			if (gc_before_detach(&opts, &cfg) < 0)
    ++			if (gc_foreground_tasks(&opts, &cfg) < 0)
     +				die(NULL);
     +			delete_tempfile(&pidfile);
     +		}
    @@ builtin/gc.c: int cmd_gc(int argc,
      
     -	if (opts.detach <= 0)
     -		gc_before_repack(&opts, &cfg);
    -+	if (opts.detach <= 0 && !skip_maintenance_before_detach)
    -+		gc_before_detach(&opts, &cfg);
    ++	if (opts.detach <= 0 && !skip_foreground_tasks)
    ++		gc_foreground_tasks(&opts, &cfg);
      
      	if (!repository_format_precious_objects) {
      		struct child_process repack_cmd = CHILD_PROCESS_INIT;
    @@ builtin/gc.c: static int maintenance_task_prefetch(struct maintenance_run_opts *
      
     -static int maintenance_task_gc(struct maintenance_run_opts *opts,
     -			       struct gc_config *cfg UNUSED)
    -+static int maintenance_task_gc_before_detach(struct maintenance_run_opts *opts,
    -+					     struct gc_config *cfg)
    ++static int maintenance_task_gc_foreground(struct maintenance_run_opts *opts,
    ++					  struct gc_config *cfg)
     +{
    -+	return gc_before_detach(opts, cfg);
    ++	return gc_foreground_tasks(opts, cfg);
     +}
     +
    -+static int maintenance_task_gc_after_detach(struct maintenance_run_opts *opts,
    -+					    struct gc_config *cfg UNUSED)
    ++static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
    ++					  struct gc_config *cfg UNUSED)
      {
      	struct child_process child = CHILD_PROCESS_INIT;
      
    @@ builtin/gc.c: static int maintenance_task_gc(struct maintenance_run_opts *opts,
      	else
      		strvec_push(&child.args, "--no-quiet");
      	strvec_push(&child.args, "--no-detach");
    -+	strvec_push(&child.args, "--skip-maintenance-before-detach");
    ++	strvec_push(&child.args, "--skip-foreground-tasks");
      
      	return run_command(&child);
      }
    @@ builtin/gc.c: static const struct maintenance_task tasks[] = {
      	},
      	[TASK_GC] = {
      		.name = "gc",
    --		.after_detach = maintenance_task_gc,
    -+		.before_detach = maintenance_task_gc_before_detach,
    -+		.after_detach = maintenance_task_gc_after_detach,
    +-		.background = maintenance_task_gc,
    ++		.foreground = maintenance_task_gc_foreground,
    ++		.background = maintenance_task_gc_background,
      		.auto_condition = need_to_gc,
      	},
      	[TASK_COMMIT_GRAPH] = {
    @@ t/t7900-maintenance.sh: test_expect_success 'run [--auto|--quiet]' '
     -	test_subcommand git gc --quiet --no-detach <run-no-auto.txt &&
     -	test_subcommand ! git gc --auto --quiet --no-detach <run-auto.txt &&
     -	test_subcommand git gc --no-quiet --no-detach <run-no-quiet.txt
    -+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-no-auto.txt &&
    -+	test_subcommand ! git gc --auto --quiet --no-detach --skip-maintenance-before-detach <run-auto.txt &&
    -+	test_subcommand git gc --no-quiet --no-detach --skip-maintenance-before-detach <run-no-quiet.txt
    ++	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-no-auto.txt &&
    ++	test_subcommand ! git gc --auto --quiet --no-detach --skip-foreground-tasks <run-auto.txt &&
    ++	test_subcommand git gc --no-quiet --no-detach --skip-foreground-tasks <run-no-quiet.txt
      '
      
      test_expect_success 'maintenance.auto config option' '
    @@ t/t7900-maintenance.sh: test_expect_success 'run --task=<task>' '
     -	test_subcommand ! git gc --quiet --no-detach <run-commit-graph.txt &&
     -	test_subcommand git gc --quiet --no-detach <run-gc.txt &&
     -	test_subcommand git gc --quiet --no-detach <run-both.txt &&
    -+	test_subcommand ! git gc --quiet --no-detach --skip-maintenance-before-detach <run-commit-graph.txt &&
    -+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-gc.txt &&
    -+	test_subcommand git gc --quiet --no-detach --skip-maintenance-before-detach <run-both.txt &&
    ++	test_subcommand ! git gc --quiet --no-detach --skip-foreground-tasks <run-commit-graph.txt &&
    ++	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-gc.txt &&
    ++	test_subcommand git gc --quiet --no-detach --skip-foreground-tasks <run-both.txt &&
      	test_subcommand git commit-graph write --split --reachable --no-progress <run-commit-graph.txt &&
      	test_subcommand ! git commit-graph write --split --reachable --no-progress <run-gc.txt &&
      	test_subcommand git commit-graph write --split --reachable --no-progress <run-both.txt

---
base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
change-id: 20250527-b4-pks-maintenance-ref-lock-race-11ae5d68e06f

