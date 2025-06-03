Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073872397AA
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959286; cv=none; b=Au4uOMeZtSbC68gFA8yRLshjEYgBhH5sf2a+TQTQQuaaDBPVNNF8YHj/zRWPupUL4c7HINLuyRnvPdjC846+ycKGDr36zDOa21BVbZGCvC7ipiyIo4nQpoKknl7/FZyCf6pSsqLjpKYFHwIZInkKn1I85JSSXuiVQ3q9NDQlRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959286; c=relaxed/simple;
	bh=sqTYdPN8weVWfpZw6wwovNCzXsqqBkDFHHsyQWvtdG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TomWxDjRgJytA3sjX9HXpBZfUBSA+0Drx8iiDVWrum+8MOg3pavD/1ljkDFxlOlabnbuGGf3ee2ndWBLALkbJ9rgh5cp/6AMWPI/zjf7fXwU8BKw9EaEm9wfhIzeTLTUISRycEBrKyaY45Hjcl73620m3F1pgCeAbM1LrBfoZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AWZEmeW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKrV9EPL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AWZEmeW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKrV9EPL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E53B425400D4;
	Tue,  3 Jun 2025 10:01:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 10:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959283;
	 x=1749045683; bh=M55H5v+2c7bOeWHUWap7xegTM3DkcfOPUm1nftBKTc8=; b=
	AWZEmeW3xOA8JEVq/OPDDSyOJptisbgNfaDVsvz5rZ5No2GXvOcAmJqHSj4uftLf
	/OdRK/kW/TiA+/0gWIxfXp/d9SrEstTdQNihvjYQa3olyf+TFTG0x2GFNBVT5yrX
	KUoT5GK2lPX1C4QOZ+I/VgU5AMvZQzsI8IfgOReU5zA4HTcD8zV1Hz3F9/b4IVp8
	rPG+94ZD+Xb+dpHAdnk3+u0LdAkttSWNAY3WcJqmGnpsNc3XmfXG//SaeDqq9SER
	hKTCsSVOjUvYUxg2vC87mJxVPUUR53mJwshyn0s39VhydrH0XwMvV2WYQSsfvubH
	r6byjqZDkSCekxgQxFF/Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959283; x=
	1749045683; bh=M55H5v+2c7bOeWHUWap7xegTM3DkcfOPUm1nftBKTc8=; b=h
	KrV9EPL6y2bFsMygtz0ahM2avpu7R1JwGVwVl1/YKw1Zpbda8xEd4nwR6aLOzIhs
	KDgqMXhbJmM6htDG4wwuevaJ1GvNIWpb8gZmTNQHaWprFeD+G3Ofwdj7bw82hLHC
	PivTi8hvld+7zXCbybzIKMCWQ9yrUnNJuzIJkEvNxgQXvsgzx6Jt3HHPpf4Cl4L7
	QRtATcReHVaKRcQXKvEkZbZ2m4xutMhrWk9qyLP+/cLXcQKwPRtMBPF0/epV5A1M
	kur84W6Tn+2L91Fr/L8IyAnEZr+DgCwmOxEcUJb4urHVJiCqeuWhfTp4Ea+NvCvT
	VeEfRIMdDaMwpNLAeZ1nA==
X-ME-Sender: <xms:MwA_aA9a4S1lzCjt2QKHdhNMvNZiSu3EesgAl89f0FSbwnzCHz1-Lg>
    <xme:MwA_aIvupk_1cUMk7hi-vZN44paeysHdPH0z8HswmxatAmWZiSSZOpLwr46dFaIKd
    gRHXn3OfYKZZoNWlg>
X-ME-Received: <xmr:MwA_aGDL6E1eJl7Jqstd_f5WRsijjZDwAiEbKCNviu3XDEtpwHUljVvm4pFSxAy-kHfKbIfKnx7wcvhIoNcTVBK4qFflQTp4vB1D09vwpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsth
    hofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrh
    grmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohephihrohhthhesphgr
    lhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:MwA_aAdEOlTEAGZKahGHoAHqJS-ZdxDf0BVdPJ1kjsa4-xil6-GAWw>
    <xmx:MwA_aFMFpTot5mAfPBiPZAPjf5f6CJxtgTg2zPKsib9I8H_VsDSqfw>
    <xmx:MwA_aKlydp7K0uas1XqtDAvUJqqQuRRl-WjWzU260ah9-QBUTts_FQ>
    <xmx:MwA_aHs53JdFiv_UbaQaXl8DXJKXOK0oRMHujCdCrjwSvqnByFeERg>
    <xmx:MwA_aAODAUhXJZI0mBL6p2SuyV8N9xihYTf9ITUi0fmeotE1MQzfggzY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 88c61e6b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:11 +0200
Subject: [PATCH v4 03/12] builtin/maintenance: centralize configuration of
 explicit tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-3-52f5cf7b7e99@pks.im>
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

