Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E9186295
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848658; cv=none; b=mwragnGE4p0aMvpCNwZEp4hA2M7OJpgXoD1GfmnKJsSqFPUtjMPzyIMzYMXiaYFyuZ17424BkUu3tGqxkR3t7Ni0BrYrjSWeZ2AAaEiCJzr1ifFNJb4TmSY5TPtrCymm6T/utxI9Gq7juZIYT1XK4tk56vnc8Hy7z9XWF/Y8tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848658; c=relaxed/simple;
	bh=sqTYdPN8weVWfpZw6wwovNCzXsqqBkDFHHsyQWvtdG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRihjXIjXcTD7svEeumaTUUoKq7ZitK47hARHdo3MVxdP/A4WOKtfYwvKR+bUtEBnh7a2giJB4OHmzeiMl5xh8bOz2ZPCwvG9wDK8S2mRut2g7Aqw0QE4Dd3BbN0hcnMthDrhdOAYDP4ZVSaJKBxEd4O+s5KoPI8MeulGVahVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i0ByUKl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OE3P+4q/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i0ByUKl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OE3P+4q/"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id F1F5B114011F;
	Mon,  2 Jun 2025 03:17:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Jun 2025 03:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848655;
	 x=1748935055; bh=M55H5v+2c7bOeWHUWap7xegTM3DkcfOPUm1nftBKTc8=; b=
	i0ByUKl1Lct7Ke7LpApizn5HPvOr2uzfvIAnabgk4oJ+eF4tjxy+2bz8ruizNYCI
	XzeKBl31YJkphAFAHiQnj2rSKikniSvjZLkf3iYtEnZXbMiKhp+FsptEOL6u1rdR
	p8eoJT8FVcbPxQQCAqh50E7cS6chGOUPKJVRNsBybLfvhoZBTAfmftc6WoSloc6N
	4kC9pbfyQSmsPtBVXbMaeGeJgJR1inlS8JtWbl9o2IuIOkVXn/WItBcRS/XJ3DK+
	pqtpVhqKL8U+eXzf7qRHx1jEOsBbNyPzSnvb2zzIqjBk2XvNFtPBpLxQoKKnuQLJ
	A0DA4RjlC5KHAHUikrOQ7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848655; x=
	1748935055; bh=M55H5v+2c7bOeWHUWap7xegTM3DkcfOPUm1nftBKTc8=; b=O
	E3P+4q/JQmggE80CN6rwJHEI0yxMW9pUSsFfnYBD3+pQous7KtS5nQUoqW6aADfl
	A04Gf146aq2Qu2/WbADILbQNdUJBbB7iaOTn5wGni3HdVf22lfDBPZfuVAgEzo3M
	QCPnAgjwBJfM1+Z6BpvM9wwBUsO1mvazS9ZpUqZfWOvAM2vTUI3od3EMMQh0OcVo
	UIirlmNAr6c3nXYqlpFEC+0bzZmdOc5OSo9M6/awQbn6oH942Sdrug+AMhfyvTrf
	2THk7o67fIM9tUsomZt5S4OT+1AVjB44Vd63wsYvy6pA3TLvsKe22xkNkJxsQ9b8
	2I6ZgRiMcP/E8lJRggmuw==
X-ME-Sender: <xms:D1A9aDRFUbvPiH4IdAgYHWAilCsdFsDR3VY3tkx2x5UDiBYKQPEHHw>
    <xme:D1A9aExLrfHp5M8_-g0WUapq2mev29GzyAUXLZz7js8K48Z__up97UJUOeG9vCBk4
    57OHP6H99xY8SgLmA>
X-ME-Received: <xmr:D1A9aI2v3-HrabjtVpjC9VD-my1SpsPoon9-F2LABRlJlykMiFbCDX8IzUzPPtC2WriX_GiRDdg29Pzk2zeT952zAhti5VABya45H-u-Jv8r2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhho
    nhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonh
    gvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtgho
    mhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:D1A9aDDZ1YT_3-puXAbbEvjhf3o8ZnnRNblASHpimG836mRLul53Vg>
    <xmx:D1A9aMhdssRSrNbxVpEr_04DyzxQ8fnKcfOTFlt71yDzdgd1x6AiVQ>
    <xmx:D1A9aHo6emXpPvtSy-WI6FY2Tx2Ju54owr4kh81P2nNpuEc_FJiJ7g>
    <xmx:D1A9aHgTqizPaD952VLUTA2eL03A7M8YaG0dKQokAAyzP5gGHnzslw>
    <xmx:D1A9aPVKK4pttGV9kFIpXVPD5XAglkPKfbz3NiikA4hjDNLSMLHcFY0b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 661b2a20 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:29 +0200
Subject: [PATCH v3 03/12] builtin/maintenance: centralize configuration of
 explicit tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-3-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Users of git-maintenance(1) can explicitly ask it to run specific tasks
by passing the `--task=` command line option. This option can be passed
multiple times, which causes us to execute tasks in the same order as
the tasks have been provided by the user.

The order in which tasks are run is computed in `task_option_parse()`:
every time we parse such a command line argument, we modify the global
array of tasks by seting the selected index for that specific task.
This has two downsides:

  - We modify global state, which makes it hard to follow the logic.

  - The configuration of tasks is split across multiple different
    functions, so it is not easy to figure out the different factors
    that play a role in selecting tasks.

Refactor the logic so that `task_option_parse()` does not modify global
state anymore. Instead, this function now only collects the list of
configured tasks. The logic to configure ordering of the respective
tasks is then deferred to `initialize_task_config()`.

This refactoring solves the second problem, that the configuration of
tasks is spread across multiple different locations. The first problem,
that we modify global state, will be fixed in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 47 ++++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7adda8d2d0d..c4af9b11287 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1690,15 +1690,22 @@ static void initialize_maintenance_strategy(void)
 	}
 }
 
-static void initialize_task_config(int schedule)
+static void initialize_task_config(const struct string_list *selected_tasks,
+				   int schedule)
 {
-	int i;
 	struct strbuf config_name = STRBUF_INIT;
 
+	for (size_t i = 0; i < TASK__COUNT; i++)
+		tasks[i].selected_order = -1;
+	for (size_t i = 0; i < selected_tasks->nr; i++) {
+		struct maintenance_task *task = selected_tasks->items[i].util;
+		task->selected_order = i;
+	}
+
 	if (schedule)
 		initialize_maintenance_strategy();
 
-	for (i = 0; i < TASK__COUNT; i++) {
+	for (size_t i = 0; i < TASK__COUNT; i++) {
 		int config_value;
 		char *config_str;
 
@@ -1722,33 +1729,28 @@ static void initialize_task_config(int schedule)
 	strbuf_release(&config_name);
 }
 
-static int task_option_parse(const struct option *opt UNUSED,
+static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
-	int i, num_selected = 0;
-	struct maintenance_task *task = NULL;
+	struct string_list *selected_tasks = opt->value;
+	size_t i;
 
 	BUG_ON_OPT_NEG(unset);
 
-	for (i = 0; i < TASK__COUNT; i++) {
-		if (tasks[i].selected_order >= 0)
-			num_selected++;
-		if (!strcasecmp(tasks[i].name, arg)) {
-			task = &tasks[i];
-		}
-	}
-
-	if (!task) {
+	for (i = 0; i < TASK__COUNT; i++)
+		if (!strcasecmp(tasks[i].name, arg))
+			break;
+	if (i >= TASK__COUNT) {
 		error(_("'%s' is not a valid task"), arg);
 		return 1;
 	}
 
-	if (task->selected_order >= 0) {
+	if (unsorted_string_list_has_string(selected_tasks, arg)) {
 		error(_("task '%s' cannot be selected multiple times"), arg);
 		return 1;
 	}
 
-	task->selected_order = num_selected + 1;
+	string_list_append(selected_tasks, arg)->util = &tasks[i];
 
 	return 0;
 }
@@ -1756,8 +1758,8 @@ static int task_option_parse(const struct option *opt UNUSED,
 static int maintenance_run(int argc, const char **argv, const char *prefix,
 			   struct repository *repo UNUSED)
 {
-	int i;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
+	struct string_list selected_tasks = STRING_LIST_INIT_DUP;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
@@ -1769,7 +1771,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 			     maintenance_opt_schedule),
 		OPT_BOOL(0, "quiet", &opts.quiet,
 			 N_("do not report progress or other information over stderr")),
-		OPT_CALLBACK_F(0, "task", NULL, N_("task"),
+		OPT_CALLBACK_F(0, "task", &selected_tasks, N_("task"),
 			N_("run a specific task"),
 			PARSE_OPT_NONEG, task_option_parse),
 		OPT_END()
@@ -1778,9 +1780,6 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 
 	opts.quiet = !isatty(2);
 
-	for (i = 0; i < TASK__COUNT; i++)
-		tasks[i].selected_order = -1;
-
 	argc = parse_options(argc, argv, prefix,
 			     builtin_maintenance_run_options,
 			     builtin_maintenance_run_usage,
@@ -1790,13 +1789,15 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 		die(_("use at most one of --auto and --schedule=<frequency>"));
 
 	gc_config(&cfg);
-	initialize_task_config(opts.schedule);
+	initialize_task_config(&selected_tasks, opts.schedule);
 
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
 
 	ret = maintenance_run_tasks(&opts, &cfg);
+
+	string_list_clear(&selected_tasks, 0);
 	gc_config_release(&cfg);
 	return ret;
 }

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

