Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431561C173F
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848663; cv=none; b=hewJaBcI74Q413to3x9COs5Q6/GrrUzMS8Lop2Iw3P+GmiVR82jVF8vxAMo/V5IA3Y6HSOeAwYB/8P3Ct6xjbyRTD6PEtcOggXOS6z6WRVQDbvYhGqb4M9CMExQqxIGPzQuzz9PbjIw9OgpSIrY84VG3awFOmHdjuCL7SgrVCtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848663; c=relaxed/simple;
	bh=rrFmKRHs5f77xS6jB9TiBXRTZrlYZNNib0p4TDVbsfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tCXiQUYpcmC6o1Zz8IYLxJpc5cSzBW9dPKNSjqRZCtbx0j8c4SSV5ircNEKy3g55ArmHfVILbrXzRWhwp/CeiLSt25rNK7YqNzf8zj7Y3g7zuB+/8RwC5jQnWbc61UEwiUKwPt5qocwNVpO6r41dBUkbXFVMscDArnpG20BHP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M3M7KNCQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WTB9RkG9; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M3M7KNCQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WTB9RkG9"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4512C114010B;
	Mon,  2 Jun 2025 03:17:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 02 Jun 2025 03:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848660;
	 x=1748935060; bh=ZFh0ucnLMCxWqehg+e4QED6WsXXdlErsKyF2dHDh8cA=; b=
	M3M7KNCQMt4XiaNM52feZHOAmYLAk5zCj0UuYVCL/1uTkipabt32mW3NPyE/V4o0
	VU0c/dxgbhcdxvYFTKTBe7X3517LUEwlzr99eqb/80K7/JKOCOaJoYgp7hBHNDkC
	3aD3FvctE7Iwco4O9CpSBHsWUE1CAy0opQ+nteCgrizd/b5lUJw84ImDAX2sjaQ+
	3PIf1CeiDahgbaRuI2TXYQh/SDfC82zBCinaYPHrs9gz2ZzigrpeP4o5VCP1v+YM
	QQEyZ/GejLp2Ci5J3guMXXipoT6+JdiDYZpvSN1SC8cjWiJjvmiEaUzs317DCF4d
	k6mhtkMSAnw/LKFM9Wd2PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848660; x=
	1748935060; bh=ZFh0ucnLMCxWqehg+e4QED6WsXXdlErsKyF2dHDh8cA=; b=W
	TB9RkG9eeLv4l195AvDufOLbJ+JXUsGxEBgZvKMoSN3cbqCBlNhvlAhMb7DDGQZh
	Eph48t+T91TyVKoHMehwTHUK/Yvy8NNCvqGgtb0XimXmhhJEOh9J1wj/OOnk8BGG
	mdCC0gxAwnvw9D4odJwFKQjKVGo3GR2a3wh7VADDRu1q8m7ITjrKzqf6Tu0WjVe5
	bKNe/zrfGt3AYYfdd9d8Zszuw5Mdnm1kqKx/GPLBGGlCVnzmukhyfE7iMNSp0qYe
	yFAimwNYj2aP5kbFIIUdZC7xRjl7UEK/MKKzmwEHqA2STusa42cv4qXDZE73GKCX
	L8I1/tmwr+yIqNp6/PxSw==
X-ME-Sender: <xms:E1A9aDSkiSI28xI6myJcIvFWAB3elHisIwiQXJ1BSOmdqaWx85Htlg>
    <xme:E1A9aEy-Bx4sGjwEzg_Vpo2iCUmoawDfj77HIujotTpV35bC6JHF9AfH4_HIRGDHF
    iMjK9p2gLZ0nkfwGw>
X-ME-Received: <xmr:E1A9aI2mtAujveLZrZSLMfg7S4geqqdnWwIioeI_hlERIYZ1vwbE63qcM_febSfjPEpx7iJ-my65pW5Kb0PGbA8S5-cwfXrcbRXB3qMS0Ooa7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtoh
    hnvghtfihorhhkshdrtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:E1A9aDAEbV6xnxAN5CDH7_TPf2vQy94qH1yyWCg77rBa98T6RRcWAQ>
    <xmx:E1A9aMissd7SKYdZ7pG91jUO4BqBslNDYKk03yduDB1GWB4Lr8Yh6g>
    <xmx:E1A9aHrdKKyg3FzSbdMjOQOiiXyFp7yVOi5GHGUZaD-JruQV22OvTQ>
    <xmx:E1A9aHh6d2_zF4NQotwWtInQqIKAFKspNelVRd3ZYll0fcd3xjYjtw>
    <xmx:FFA9aPUxdxf81mb1u2M5aMChSHFC8373wlVlh4lAA7TBN_dIJYOm91cc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4a023fe0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:34 +0200
Subject: [PATCH v3 08/12] builtin/maintenance: split into foreground and
 background tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-8-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Both git-gc(1) and git-maintenance(1) have logic to daemonize so that
the maintenance tasks are performed in the background. git-gc(1) has
some special logic though to not perform _all_ housekeeping tasks in the
background: both references and reflogs are still handled synchronously
in the foreground.

This split exists because otherwise it may easily happen that git-gc(1)
keeps the "packed-refs" file locked for an extended amount of time,
where the next Git command that wants to modify any reference could now
fail. This was especially important in the past, where git-gc(1) was
still executed directly as part of our automatic maintenance: git-gc(1)
was invoked via `git gc --auto --detach`, so we knew to handle most of
the maintenance tasks in the background while doing those parts that may
cause locking issues in the foreground.

We have since moved to git-maintenance(1), which is a more flexible
replacement for git-gc(1). By default this command runs git-gc(1), only,
but it can be configured to run different tasks, as well. This command
does not know about the split between maintenance tasks that should run
before and after detach though, and this has led to several bug reports
about spurious locking errors for the "packed-refs" file.

Prepare for a fix by introducing this split for maintenance tasks. Note
that this commit does not yet change any of the tasks, so there should
not (yet) be a change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 70 ++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 447e5800846..72a695853e5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1535,84 +1535,106 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 
 typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
 				   struct gc_config *cfg);
-
-/*
- * An auto condition function returns 1 if the task should run
- * and 0 if the task should NOT run. See needs_to_gc() for an
- * example.
- */
 typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn fn;
+
+	/*
+	 * Work that will be executed before detaching. This should not include
+	 * tasks that may run for an extended amount of time as it does cause
+	 * auto-maintenance to block until foreground tasks have been run.
+	 */
+	maintenance_task_fn foreground;
+
+	/*
+	 * Work that will be executed after detaching. When not detaching the
+	 * work will be run in the foreground, as well.
+	 */
+	maintenance_task_fn background;
+
+	/*
+	 * An auto condition function returns 1 if the task should run and 0 if
+	 * the task should NOT run. See needs_to_gc() for an example.
+	 */
 	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
 		.name = "prefetch",
-		.fn = maintenance_task_prefetch,
+		.background = maintenance_task_prefetch,
 	},
 	[TASK_LOOSE_OBJECTS] = {
 		.name = "loose-objects",
-		.fn = maintenance_task_loose_objects,
+		.background = maintenance_task_loose_objects,
 		.auto_condition = loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
 		.name = "incremental-repack",
-		.fn = maintenance_task_incremental_repack,
+		.background = maintenance_task_incremental_repack,
 		.auto_condition = incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
 		.name = "gc",
-		.fn = maintenance_task_gc,
+		.background = maintenance_task_gc,
 		.auto_condition = need_to_gc,
 	},
 	[TASK_COMMIT_GRAPH] = {
 		.name = "commit-graph",
-		.fn = maintenance_task_commit_graph,
+		.background = maintenance_task_commit_graph,
 		.auto_condition = should_write_commit_graph,
 	},
 	[TASK_PACK_REFS] = {
 		.name = "pack-refs",
-		.fn = maintenance_task_pack_refs,
+		.background = maintenance_task_pack_refs,
 		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
 		.name = "reflog-expire",
-		.fn = maintenance_task_reflog_expire,
+		.background = maintenance_task_reflog_expire,
 		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {
 		.name = "worktree-prune",
-		.fn = maintenance_task_worktree_prune,
+		.background = maintenance_task_worktree_prune,
 		.auto_condition = worktree_prune_condition,
 	},
 	[TASK_RERERE_GC] = {
 		.name = "rerere-gc",
-		.fn = maintenance_task_rerere_gc,
+		.background = maintenance_task_rerere_gc,
 		.auto_condition = rerere_gc_condition,
 	},
 };
 
+enum task_phase {
+	TASK_PHASE_FOREGROUND,
+	TASK_PHASE_BACKGROUND,
+};
+
 static int maybe_run_task(const struct maintenance_task *task,
 			  struct repository *repo,
 			  struct maintenance_run_opts *opts,
-			  struct gc_config *cfg)
+			  struct gc_config *cfg,
+			  enum task_phase phase)
 {
+	int foreground = (phase == TASK_PHASE_FOREGROUND);
+	maintenance_task_fn fn = foreground ? task->foreground : task->background;
+	const char *region = foreground ? "maintenance foreground" : "maintenance";
 	int ret = 0;
 
+	if (!fn)
+		return 0;
 	if (opts->auto_flag &&
 	    (!task->auto_condition || !task->auto_condition(cfg)))
 		return 0;
 
-	trace2_region_enter("maintenance", task->name, repo);
-	if (task->fn(opts, cfg)) {
+	trace2_region_enter(region, task->name, repo);
+	if (fn(opts, cfg)) {
 		error(_("task '%s' failed"), task->name);
 		ret = 1;
 	}
-	trace2_region_leave("maintenance", task->name, repo);
+	trace2_region_leave(region, task->name, repo);
 
 	return ret;
 }
@@ -1641,6 +1663,11 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	for (size_t i = 0; i < opts->tasks_nr; i++)
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
+				   TASK_PHASE_FOREGROUND))
+			result = 1;
+
 	/* Failure to daemonize is ok, we'll continue in foreground. */
 	if (opts->detach > 0) {
 		trace2_region_enter("maintenance", "detach", the_repository);
@@ -1649,7 +1676,8 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 
 	for (size_t i = 0; i < opts->tasks_nr; i++)
-		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg,
+				   TASK_PHASE_BACKGROUND))
 			result = 1;
 
 	rollback_lock_file(&lk);

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

