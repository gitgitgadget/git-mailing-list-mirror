Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF85723A578
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959289; cv=none; b=IACFcm4lezXjOEM2KSSnLkz+5LWbH7qPNZjUGpMfFIlVV5h0+zMspYnuPWAPsOhi0CBdy2o7n6sBGUoZfj/ngu4vh8TEAfzE7/kNQde+HZwMcSB8hV0PaCQ0lqAN9bsCiURxw6qZKhdU0svtd4GsJhwRShC77v9ce16Ex0wRPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959289; c=relaxed/simple;
	bh=rrFmKRHs5f77xS6jB9TiBXRTZrlYZNNib0p4TDVbsfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RksEmTdg/z7vGZGjgZVCHP2Bj6e6lsAKOwtvD+KHJZaPfuYbekWv3tZsuCuBI5IJmPV/fKeh8boqR++Pcnju7t8jPjXygnHs37TvM8jKRSCHXDWSVjHNey+F4Lf99ujJS/QzQlSl4uRvwQRiNr5sJbyAhU2TjPto0nnjJ4IWdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N8PzWAxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bywbT8zV; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N8PzWAxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bywbT8zV"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F244C2540102;
	Tue,  3 Jun 2025 10:01:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 03 Jun 2025 10:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959286;
	 x=1749045686; bh=ZFh0ucnLMCxWqehg+e4QED6WsXXdlErsKyF2dHDh8cA=; b=
	N8PzWAxyu8Gu/ef4R2rxvjs57J7KbjZsHv70uW7Ib6AWpeCjQgebLdupLD+xL7dR
	ToukwuPgOQWYT/dp6FuuGu58jRm8MuddvIEE6NEP+bVG8nwappzlCYUWu+VSmwO5
	hd+KvoYgBI3TNvPGxOMAVkQTcGr2yVtyFqOKLp17DiiNamJ/vUszXtJshuuWaqay
	3YBUbqcu2rqlxDlR/ST7DPQpY1gQh0qDahKXlJ2hx/eDhhFuIbWMYRW2mUMhyWpB
	yRvDAcjalCkVftsiYajU/vA8rVOJHRYgh4rFL892Ltvgyv0rworipK9OM0Dv+iM+
	O+wCKytdSDhOohpk2hEhBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959286; x=
	1749045686; bh=ZFh0ucnLMCxWqehg+e4QED6WsXXdlErsKyF2dHDh8cA=; b=b
	ywbT8zVq+lWjCfsdQPcN9jn3n4c/dDfYhd57qSzLNtjS+/MAm7Vwxtb5nG08scyj
	urscKuCNJcPl6modNqKypBQX4VR8XanxBiP6l5QFUBEHR1AkuF4+CceDQ/v684Fq
	4xRHZIZtQW/Fj7moipk7sEXigE2OwyuWND34FlVdyZaYKO+ITdZ5PfAFOGrQLJJ7
	UIsQozixW1RGyO14/npAKiFrrVDxc0uR0ejgpHv4AOxx1ANQKb/8QHZBe5scymak
	v8NrCrGL0zKyoOHyNlrWDG4U2Dy6GeM3iW8Y8Jns0HR9ruFcL2rEWGQ0nLMeR3qt
	7nVesK7ZWC0ZEMNE6K4Rg==
X-ME-Sender: <xms:NgA_aLLFzEuwYLj_eRGnfWw-d0g8NY4qQYxmwqHpw0IYEZ5HtDCgEg>
    <xme:NgA_aPI03CMqbHDBAOX_vGp3pOB07MGDw0B4SG2Y62dJUxp2uzTsnHQr5N7qW70OB
    EwPuxd8QsujWhW2iw>
X-ME-Received: <xmr:NgA_aDtPzL7inA6u1vxi1vnfMuKGX0Co74S9yfKwA0Z9f5IdNNwiW86eFInlMrUwSUrnlknlGGzK_YM6ufOIIF-OIiGNuabylS3Zhgvzpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfi
    horhhkshdrtghomh
X-ME-Proxy: <xmx:NgA_aEYqdEXadui0fwEBmz8W20oAf9G4JwK52W5OaSoPmIJx0CmULw>
    <xmx:NgA_aCaoPNm0MjwtFUV4XLgOwkdt0lzYSL-WO3bBs8fLOOIPNT6Scg>
    <xmx:NgA_aIBY1HXKS4VQnqcMOj5lFG89QVLdoWdQNNsAzmOiUvEQ6b-b9g>
    <xmx:NgA_aAZAivscLGFm1RQ0kngKJ1b5ItgDM3CRmzjToFEDQMBmhVlrig>
    <xmx:NgA_aBaRJV3zBd1IkuGDaGm8h3IaNFXRqU2wBqbhhT9ezxYzBml2CECi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e058336 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:16 +0200
Subject: [PATCH v4 08/12] builtin/maintenance: split into foreground and
 background tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-8-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

