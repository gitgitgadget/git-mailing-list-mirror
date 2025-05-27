Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6A27876E
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354682; cv=none; b=CCoW40bgKHU2gN/wJNtC1XFBkdo4z9MOIcpZHSSDdpO8in8K1RM0uZT9Vm3q/1Ebs9Circ5ZUThkicIqLknK4hy21As61SZfTQSvSAid6ZwTHjuKEWCnoaNqQOUSIkSEvWtGXDGlxEWBsB36WXrvm30SCnHuK+7eC2T11wCkjCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354682; c=relaxed/simple;
	bh=gyR2NztrU1rOzCiKmJ6ZlvtCg6MRag6KAwqDKsgCmQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jXXhaVGTH5v5m2B9d/TW4jO2v4aiW7RSSjFEpk0iZYcoo8gaYMs5H10e+BtxFYfOPpqfI/O2vLPNwl7FXGAmuF5vltQSzMsAdARLRnXGgJxr/D/gsUJfnfK/tVuaRS8A9HjH303GSipO7mv+vp/qrKr7+ouNttBfJuNUS1tinLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfgio4GY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F7DrqQYV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfgio4GY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F7DrqQYV"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 24984138046E;
	Tue, 27 May 2025 10:04:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 May 2025 10:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354676;
	 x=1748441076; bh=eldUjm3RGgGQ0xSZQbY1eBwi51sQtgY38HjRsHMaVVQ=; b=
	rfgio4GYkDgSihuKhPlStMvUFk0ZwKqaVmb8U/ZqZIi941GVCzj7KT/D3f9EzqEj
	y8FhEb7LasiKH9cW2q7UsWHoBAOiuJemneX0A00yTmI6ZD2FlOC5Ar3lDZESP5Pu
	cx2E1T7vAcyZy2dxF8SXOtAOQsHD1mMH0ncgd2wl1pFg5EsHkYpHIY8PlTM+9MrP
	7RTKOgXfqpx8V3KFI7808ujTCT++iqs7akP3CQS/0G3I44C30zgFVtwAAvXbc6A8
	5L4VcIYveS7DOIbx8RydVvDrpTule292ydOa4iX6kFaZlTPlBIb83oXH6QO7ksid
	SMnraLAAQ0qXqDoXLXkUDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354676; x=
	1748441076; bh=eldUjm3RGgGQ0xSZQbY1eBwi51sQtgY38HjRsHMaVVQ=; b=F
	7DrqQYVGH93ebtMvH97zokQopw0AuWqRptI8SfLtxMdc1rsoTze1gXIi0Ua1Jrid
	ZBuMJR7zP0LY2LrFaiB6IwHrKmv0XvFpu/h/kI5dr/kLxn0cdnc9nDGru8RQdI8j
	MeWHp/rToIE5EkPaagK+fHNJZze6n2Q1052mrEg3tdD7mmIXZMWMoYXCaSshHw9K
	DSH5B9EprDmiFkPQ92ApIFsIj9dmSVLj4mfXiIT7FPUBgTlcHbQ1lMzxUAv6nOkX
	EV9tsdSCp8Wt825NZGQHVZmd7snChxwZBHghhIh/SKGZCymjPB/Gg7qIhvKG7+5V
	AUvW17e6pFMxw1HxRfQLA==
X-ME-Sender: <xms:c8Y1aL-sxM42ZepRFXpcW13nmoQCu8zpdiZuNb-4zxZhPl12k_Sgrw>
    <xme:c8Y1aHtD--bneQcPcjxOM-ZG0WkeaRDpVln5MCFKPtJAJIaDGf2DMf_F5DIz-uDLb
    -dSUfZMpANqpyytnQ>
X-ME-Received: <xmr:c8Y1aJCVYO7_tFSz9r1Fv1WzcLM_RCS48Tgww9KpiA2whml-27nb8YLQtv1mQpdhUT6LQZudninRYfxbdoHqA_rwUpIOiob0KpxccxIYsp88ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hm
X-ME-Proxy: <xmx:c8Y1aHd6Ikuuci2uveJ2qsxNi7uXIRp493dCVXMwtw0D_Igyjwr6Rg>
    <xmx:dMY1aAPTrEv3QwN6IJavLP62R_bdhK4wMAPzNgCNR2HD1K9g5lGzug>
    <xmx:dMY1aJkm1R_w9JvXdsnwwGnKv3Vje8zAGpGPjvIKb_n8n69Jj24NnA>
    <xmx:dMY1aKt2GMTsHedSY2VksKwF54A_fDZPxrCbz2VVfksFCo3uWhCotQ>
    <xmx:dMY1aFnk8xBj_WMhkxO932grXuNVqCYsk40mFAmdlzRwD-_t_AkqdHmR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3562f5e2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:31 +0200
Subject: [PATCH 05/11] builtin/maintenance: stop modifying global array of
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-5-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

When configuring maintenance tasks run by git-maintenance(1) we do so by
modifying the global array of tasks directly. This is already quite bad
on its own, as global state makes for logic that is hard to follow.

Even more importantly though we use multiple different fields to track
whether or not a task should be run:

  - "enabled" tracks the "maintenance.*.enabled" config key. This field
    disables execution of a task, unless the user has explicitly asked
    for the task.

  - "selected_order" tracks the order in which jobs have been asked for
    by the user via the "--task=" command line option. It overrides
    everything else, but only has an effect if at least one job has been
    selected.

  - "schedule" tracks the schedule priority for a job, that is how often
    it should run. This field only plays a role when the user has passed
    the "--schedule=" command line option.

All of this makes it non-trivial to figure out which job really should
be running right now. The logic to configure these fields and the logic
that interprets them is distributed across multiple functions, making it
even harder to follow it.

Refactor the logic so that we stop modifying global state. Instead, we
now compute which jobs should be run in `initialize_task_config()`,
represented as an array of jobs to run that is stored in the options
structure. Like this, all logic becomes self-contained and any users of
this array only need to iterate through the tasks and execute them one
by one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 206 ++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 112 insertions(+), 94 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 57d7602596a..4d636237cac 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -251,7 +251,24 @@ static enum schedule_priority parse_schedule(const char *value)
 	return SCHEDULE_NONE;
 }
 
+enum maintenance_task_label {
+	TASK_PREFETCH,
+	TASK_LOOSE_OBJECTS,
+	TASK_INCREMENTAL_REPACK,
+	TASK_GC,
+	TASK_COMMIT_GRAPH,
+	TASK_PACK_REFS,
+	TASK_REFLOG_EXPIRE,
+	TASK_WORKTREE_PRUNE,
+	TASK_RERERE_GC,
+
+	/* Leave as final value */
+	TASK__COUNT
+};
+
 struct maintenance_run_opts {
+	enum maintenance_task_label *tasks;
+	size_t tasks_nr, tasks_alloc;
 	int auto_flag;
 	int detach;
 	int quiet;
@@ -261,6 +278,11 @@ struct maintenance_run_opts {
 	.detach = -1, \
 }
 
+static void maintenance_run_opts_release(struct maintenance_run_opts *opts)
+{
+	free(opts->tasks);
+}
+
 static int pack_refs_condition(UNUSED struct gc_config *cfg)
 {
 	/*
@@ -1032,6 +1054,7 @@ int cmd_gc(int argc,
 	}
 
 out:
+	maintenance_run_opts_release(&opts);
 	gc_config_release(&cfg);
 	return 0;
 }
@@ -1524,30 +1547,9 @@ struct maintenance_task {
 	const char *name;
 	maintenance_task_fn *fn;
 	maintenance_auto_fn *auto_condition;
-	unsigned enabled:1;
-
-	enum schedule_priority schedule;
-
-	/* -1 if not selected. */
-	int selected_order;
-};
-
-enum maintenance_task_label {
-	TASK_PREFETCH,
-	TASK_LOOSE_OBJECTS,
-	TASK_INCREMENTAL_REPACK,
-	TASK_GC,
-	TASK_COMMIT_GRAPH,
-	TASK_PACK_REFS,
-	TASK_REFLOG_EXPIRE,
-	TASK_WORKTREE_PRUNE,
-	TASK_RERERE_GC,
-
-	/* Leave as final value */
-	TASK__COUNT
 };
 
-static struct maintenance_task tasks[] = {
+static const struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
 		.name = "prefetch",
 		.fn = maintenance_task_prefetch,
@@ -1566,7 +1568,6 @@ static struct maintenance_task tasks[] = {
 		.name = "gc",
 		.fn = maintenance_task_gc,
 		.auto_condition = need_to_gc,
-		.enabled = 1,
 	},
 	[TASK_COMMIT_GRAPH] = {
 		.name = "commit-graph",
@@ -1595,18 +1596,9 @@ static struct maintenance_task tasks[] = {
 	},
 };
 
-static int compare_tasks_by_selection(const void *a_, const void *b_)
-{
-	const struct maintenance_task *a = a_;
-	const struct maintenance_task *b = b_;
-
-	return b->selected_order - a->selected_order;
-}
-
 static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 				 struct gc_config *cfg)
 {
-	int i, found_selected = 0;
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
@@ -1635,95 +1627,120 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		trace2_region_leave("maintenance", "detach", the_repository);
 	}
 
-	for (i = 0; !found_selected && i < TASK__COUNT; i++)
-		found_selected = tasks[i].selected_order >= 0;
-
-	if (found_selected)
-		QSORT(tasks, TASK__COUNT, compare_tasks_by_selection);
-
-	for (i = 0; i < TASK__COUNT; i++) {
-		if (found_selected && tasks[i].selected_order < 0)
-			continue;
-
-		if (!found_selected && !tasks[i].enabled)
-			continue;
-
+	for (size_t i = 0; i < opts->tasks_nr; i++) {
 		if (opts->auto_flag &&
-		    (!tasks[i].auto_condition ||
-		     !tasks[i].auto_condition(cfg)))
-			continue;
-
-		if (opts->schedule && tasks[i].schedule < opts->schedule)
+		    (!tasks[opts->tasks[i]].auto_condition ||
+		     !tasks[opts->tasks[i]].auto_condition(cfg)))
 			continue;
 
-		trace2_region_enter("maintenance", tasks[i].name, r);
-		if (tasks[i].fn(opts, cfg)) {
-			error(_("task '%s' failed"), tasks[i].name);
+		trace2_region_enter("maintenance", tasks[opts->tasks[i]].name, r);
+		if (tasks[opts->tasks[i]].fn(opts, cfg)) {
+			error(_("task '%s' failed"), tasks[opts->tasks[i]].name);
 			result = 1;
 		}
-		trace2_region_leave("maintenance", tasks[i].name, r);
+		trace2_region_leave("maintenance", tasks[opts->tasks[i]].name, r);
 	}
 
 	rollback_lock_file(&lk);
 	return result;
 }
 
-static void initialize_maintenance_strategy(void)
+struct maintenance_strategy {
+	struct {
+		int enabled;
+		enum schedule_priority schedule;
+	} tasks[TASK__COUNT];
+};
+
+static const struct maintenance_strategy none_strategy = { 0 };
+static const struct maintenance_strategy default_strategy = {
+	.tasks = {
+		[TASK_GC].enabled = 1,
+	},
+};
+static const struct maintenance_strategy incremental_strategy = {
+	.tasks = {
+		[TASK_COMMIT_GRAPH].enabled = 1,
+		[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY,
+		[TASK_PREFETCH].enabled = 1,
+		[TASK_PREFETCH].schedule = SCHEDULE_HOURLY,
+		[TASK_INCREMENTAL_REPACK].enabled = 1,
+		[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY,
+		[TASK_LOOSE_OBJECTS].enabled = 1,
+		[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY,
+		[TASK_PACK_REFS].enabled = 1,
+		[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY,
+	},
+};
+
+static void initialize_task_config(struct maintenance_run_opts *opts,
+				   const struct string_list *selected_tasks)
 {
+	struct strbuf config_name = STRBUF_INIT;
+	struct maintenance_strategy strategy;
 	const char *config_str;
 
-	if (git_config_get_string_tmp("maintenance.strategy", &config_str))
-		return;
+	/*
+	 * In case the user has asked us to run tasks explicitly we only use
+	 * those specified tasks. Specifically, we do _not_ want to consult the
+	 * config or maintenance strategy.
+	 */
+	if (selected_tasks->nr) {
+		for (size_t i = 0; i < selected_tasks->nr; i++) {
+			enum maintenance_task_label label = (intptr_t)selected_tasks->items[i].util;;
+			ALLOC_GROW(opts->tasks, opts->tasks_nr + 1, opts->tasks_alloc);
+			opts->tasks[opts->tasks_nr++] = label;
+		}
 
-	if (!strcasecmp(config_str, "incremental")) {
-		tasks[TASK_GC].schedule = SCHEDULE_NONE;
-		tasks[TASK_COMMIT_GRAPH].enabled = 1;
-		tasks[TASK_COMMIT_GRAPH].schedule = SCHEDULE_HOURLY;
-		tasks[TASK_PREFETCH].enabled = 1;
-		tasks[TASK_PREFETCH].schedule = SCHEDULE_HOURLY;
-		tasks[TASK_INCREMENTAL_REPACK].enabled = 1;
-		tasks[TASK_INCREMENTAL_REPACK].schedule = SCHEDULE_DAILY;
-		tasks[TASK_LOOSE_OBJECTS].enabled = 1;
-		tasks[TASK_LOOSE_OBJECTS].schedule = SCHEDULE_DAILY;
-		tasks[TASK_PACK_REFS].enabled = 1;
-		tasks[TASK_PACK_REFS].schedule = SCHEDULE_WEEKLY;
+		return;
 	}
-}
 
-static void initialize_task_config(const struct string_list *selected_tasks,
-				   int schedule)
-{
-	struct strbuf config_name = STRBUF_INIT;
+	/*
+	 * Otherwise, the strategy depends on whether we run as part of a
+	 * scheduled job or not:
+	 *
+	 *   - Scheduled maintenance does not perform any housekeeping by
+	 *     default, but requires the user to pick a maintenance strategy.
+	 *
+	 *   - Unscheduled maintenance uses our default strategy.
+	 *
+	 * Both of these are affected by the gitconfig though, which may
+	 * override specific aspects of our strategy.
+	 */
+	if (opts->schedule) {
+		strategy = none_strategy;
 
-	for (size_t i = 0; i < TASK__COUNT; i++)
-		tasks[i].selected_order = -1;
-	for (size_t i = 0; i < selected_tasks->nr; i++) {
-		struct maintenance_task *task = selected_tasks->items[i].util;
-		task->selected_order = i;
+		if (!git_config_get_string_tmp("maintenance.strategy", &config_str)) {
+			if (!strcasecmp(config_str, "incremental"))
+				strategy = incremental_strategy;
+		}
+	} else {
+		strategy = default_strategy;
 	}
 
-	if (schedule)
-		initialize_maintenance_strategy();
-
 	for (size_t i = 0; i < TASK__COUNT; i++) {
 		int config_value;
-		char *config_str;
 
 		strbuf_reset(&config_name);
 		strbuf_addf(&config_name, "maintenance.%s.enabled",
 			    tasks[i].name);
-
 		if (!git_config_get_bool(config_name.buf, &config_value))
-			tasks[i].enabled = config_value;
-
-		strbuf_reset(&config_name);
-		strbuf_addf(&config_name, "maintenance.%s.schedule",
-			    tasks[i].name);
+			strategy.tasks[i].enabled = config_value;
+		if (!strategy.tasks[i].enabled)
+			continue;
 
-		if (!git_config_get_string(config_name.buf, &config_str)) {
-			tasks[i].schedule = parse_schedule(config_str);
-			free(config_str);
+		if (opts->schedule) {
+			strbuf_reset(&config_name);
+			strbuf_addf(&config_name, "maintenance.%s.schedule",
+				    tasks[i].name);
+			if (!git_config_get_string_tmp(config_name.buf, &config_str))
+				strategy.tasks[i].schedule = parse_schedule(config_str);
+			if (strategy.tasks[i].schedule < opts->schedule)
+				continue;
 		}
+
+		ALLOC_GROW(opts->tasks, opts->tasks_nr + 1, opts->tasks_alloc);
+		opts->tasks[opts->tasks_nr++] = i;
 	}
 
 	strbuf_release(&config_name);
@@ -1750,7 +1767,7 @@ static int task_option_parse(const struct option *opt,
 		return 1;
 	}
 
-	string_list_append(selected_tasks, arg)->util = &tasks[i];
+	string_list_append(selected_tasks, arg)->util = (void *)(intptr_t)i;
 
 	return 0;
 }
@@ -1791,7 +1808,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 				  opts.schedule, "--schedule=");
 
 	gc_config(&cfg);
-	initialize_task_config(&selected_tasks, opts.schedule);
+	initialize_task_config(&opts, &selected_tasks);
 
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
@@ -1800,6 +1817,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 	ret = maintenance_run_tasks(&opts, &cfg);
 
 	string_list_clear(&selected_tasks, 0);
+	maintenance_run_opts_release(&opts);
 	gc_config_release(&cfg);
 	return ret;
 }

-- 
2.49.0.1266.g31b7d2e469.dirty

