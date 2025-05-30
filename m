Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B661235065
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617728; cv=none; b=pJ4J6SIiCzLP9miCy9z102uVTqgYRvKKMmLjHztXgbkij1G8qyXwHlWAAhpWxlGhMesBQ839VS6UElkmwS7wdVVr4B4EJtMX7/4EG9eplNfNelmNyfjBb2vmU+LGSdTj1n7L4AprA4GCe50zbtJpTH+skM86XxScvgN8bU9nkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617728; c=relaxed/simple;
	bh=zGKDNRLQGYrx1iMHT+c8YbgkK8XEB8dbRJSb2UYcX5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l4PXAPGXUVBtAYoxeI7EWeOqlgSN8hmqIZ7y8e8b9eiwNZRAUzBvYQgHqORnv4D1ZgsU5b4FzogIC39nKk/lJvITnfHtyljXICBO6fGiJtuJmpLDSlOPwQJTpJLynZ5v5j+RN1bBXiuqPykQJeBe4RXxbwqTRqcsKdjwQiHlEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pf/pnLeG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kMhD9zBJ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pf/pnLeG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMhD9zBJ"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 34F551140165;
	Fri, 30 May 2025 11:08:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 30 May 2025 11:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617724;
	 x=1748704124; bh=pctpZ+/DmxS5tfjU7JzDVXDVJg6iGryeY9HJ1UQrY8k=; b=
	pf/pnLeGBxZj34gclhECPJ5Vyz4ZtpKtJnxdQlX4aREWz4+MzoYBV3mrr+BDT2dl
	sTRfMljJwU4vbYRpY17ycXGDrulkGv8q44xKJPuUc1XUXFQ/RB3vaU9JEM/ydLlj
	niA+7CbdfbJYlmp0FG3ku1vtOiFp/yn5Rv6aC8lOQQ+l+eozTPWvpmJ9Cm9V0xps
	DFxMRiA2k4w1FtLNzImZvPUSsTK5kFG/rsq4U+w99f69TIZYx/A6YEIP+76Q8fPS
	aY5cPcexhdSNV+bszywpMhkTtIIxI8aIhIzYIzeCKU82loEGNXaCuF0V4yhM0cic
	cJFjzZ0qStOm1WqJP8N0tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617724; x=
	1748704124; bh=pctpZ+/DmxS5tfjU7JzDVXDVJg6iGryeY9HJ1UQrY8k=; b=k
	MhD9zBJmPoF8S02FEv4VAwg1TNmQyOgLlq1cS3MrBdwQoxFAUO80m3hvGLGJvKbE
	S7bI8uSP+WgM8r1j9YbQtABPxHgxafu2nH/YUM3ekmXPD0i/1ATCWbozkF8iA3yH
	DQWgXGh6V7nwaiIQli88PL0YD+aFyARV97GPYQXiT6WyO8cKslAjUHaUBNUn4sF3
	cslLxOy0BxDs/2blOWR/hNzTb9yD4joohm3Wj7830urLMwrb6jl9RQp322jAFIoF
	b5wTPjY+SG1936xJ/L3sJqrMnZepUMsgYx2umUyDnEDJbwot6Mk8B61hNdoi90sY
	FN8c2ERdd0pDYVCte4YEg==
X-ME-Sender: <xms:-8k5aAGPDEAQ5IxteAYu_TIZv6jyYpDaJDgcbNwsjwk7qm0jCazJug>
    <xme:-8k5aJXltYj9urAVzVGDDU0zaGsge9lCrOhe-jJR9JdSPx05gbAYnYxaV0h-znX-Q
    aLqU9p13tMToCw6qA>
X-ME-Received: <xmr:-8k5aKL2cnSzrdogzio_jwNfh_gIgHQ2KaBSQRMM-4KZMhg8lrKrFxNEcQGKIf61RhBT6pk_wC2MhBOWacrHtQnVUdrWq9A3pVCLSdCMsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthho
    nhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhs
    rdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtghomhdprhgtphhtth
    hopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:-8k5aCH7w_zkFoHI0IxIYg6a2uTb9T9dPy1st7-ZGANA7Suxx6ug0g>
    <xmx:_Mk5aGVXwQ8WgxN_lJgyyNacyJe4eNfReXKYrsWQucwC11ZkWbAIuQ>
    <xmx:_Mk5aFOQ2REAF3jyKcXtrdKVpqdrvW7SudNgEt9OH5Enc_eCIzE1-A>
    <xmx:_Mk5aN2WboqX5_B-DxAhZvisqJ5taSSoL830TeINP5LU-OSJ82SJIA>
    <xmx:_Mk5aNpRS8MT8dBLpI0KgXWkerl8MFrptl2e5t4kTC3xy739qXf0hEMP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 187072b5 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:29 +0200
Subject: [PATCH v2 03/12] builtin/maintenance: centralize configuration of
 explicit tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-3-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

