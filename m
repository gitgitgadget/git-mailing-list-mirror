Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC733277813
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354676; cv=none; b=Joq/d0yLUiF6XiUgVK2NSMLUGl6fXPvS6XMYa/j2Bf80vBtwQeZiPEhpDhoeLJMBOOUnWYtB/b8s7TiA0C8ReXNZa7jxUrhm84YvGiLlU6q6yVk3OljcC6HnocWxjcKA3RWiUn9RRz0f+NgYGlbUcEnR4VtT/K1MxqVz1adZT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354676; c=relaxed/simple;
	bh=uPTvnaLnOURkQX24iqW117qXqnFjG5OYIFg6+l7QSrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJNhffZ0B1fs0YqXZ2WWBIT1LUqiYYt84xNrmYxeHyqrd8ShOSIWiunrxYrnc65/W+DvQ9SicNLvn1Jh+WOIesJyfbY9E0ANJMwVkNaljjBC56tvAWOv1QxEJI7rVVK9qBR8iymtFB5koBivDub+IfFmn2J7oAQLTJA82utqA9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RupAX9Yz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UkWr88T1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RupAX9Yz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UkWr88T1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id F12A11383AB3;
	Tue, 27 May 2025 10:04:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 10:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354673;
	 x=1748441073; bh=TVWSbqCqRslDlz9mXQdMmUHRV1TXzS0lJW8hlkZJ3+8=; b=
	RupAX9YzAJ9XrgiqMmTMTYreHieyIoPAAKAJlBpywpOh3BuGPiyPnvJz+wQVAVOZ
	Swz9sB7Id3Uo/rfmfJIJZwxOgPPoISO5vTA5xyN7xxKdIrJ+TAFe65Xn5ZDeFSoD
	6KBWKNiul3eE3Vb6aRsNaGNp00ReNzUr8WCHjQNgqxUKdT0S00r8dQk/rYXMsW6z
	jLqfThBoJElnPjEStlyVW7aLPun8OOQB4sZuO7IZqF+TfJ8ZzMahUDK0tlaGARAF
	7qfi2/96LAA+SfInNjFpGUc3fo86TGK7mwLr0beFRUq5ohyV/MLGjD1q62xzlJ8f
	7MaB0DA34b/XJG7kRvF/gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354673; x=
	1748441073; bh=TVWSbqCqRslDlz9mXQdMmUHRV1TXzS0lJW8hlkZJ3+8=; b=U
	kWr88T1nvBO5sKn0HIdafhljJCq+whQSjR1eh5QcleeqzW5TztyTrV+0MHorvsQ6
	rgGETft5PQ19M4L8BJnNf2eHkTuxM8C9jTAlyXM0XMkTmZWxEAhayjDPQtHK/5q2
	9V632otR7S/8K/gSUwL/qyqWYA7xbEKge43QBEkZz4W3BWW3HjuXSoo2Br8qyIOY
	dzcwIg2JdR87ozp1P+2Vlwpb7sMqE9t8PUaFEf3g3K8++PMBkMQFTUDB8iEKT7c1
	5E8hBvBiHnMxk+cbJLEjqV7pFedfPpTKIuDyWPBno1y+9XerYc6Gna/eX4Bt0N00
	bkaSDtRem1Ua/c/bJxTow==
X-ME-Sender: <xms:ccY1aPDAL-7WabEUj0fX8jW2WU5L0LOp86WtbD8VJwr9eQpMHiScSA>
    <xme:ccY1aFji4pbTd34wN1wl3jmcxE7UBtdlhHXFB-v99GM1ErcZVUOSibpq9Nj-ar6Z-
    D02CxrGsYD4RSB5zw>
X-ME-Received: <xmr:ccY1aKnHdQZ-uNdYYQpiKEZM7Hph9W7lBoJ2W7FYFv4YhCv7u9eQsMX0Qlr_SXh1ZrHgInEGGi6vzMpj5Ci4F1HN1Tk2OGQcB8SrkPn4jeo74Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrshhrrghfle
    esghhmrghilhdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvght
    fihorhhkshdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ccY1aBxFN3RUJZbQILETjNJe_xbqPFVUrRmt7LQ7DdGjXDs_DPuFTA>
    <xmx:ccY1aERZs12rp8or6YzFpK5ygsHl6KMyrPWsCardcUlWNBezp4cKDA>
    <xmx:ccY1aEa2Jsv_BO-d_pbHnutlxnctPvJpZyvZYWF4EfvI6hDSLEuJaQ>
    <xmx:ccY1aFQRZHaw2iaSaTi3VOQtTMXpq3EVBNYdIifskcLkymQ8OTGVdQ>
    <xmx:ccY1aPtcSDQrruxP9qxyt1iBgkrj81lD1LJYcWnBbxcfYGYrIRWOq_Zp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9dd5f524 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:29 +0200
Subject: [PATCH 03/11] builtin/maintenance: centralize configuration of
 explicit tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-3-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
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
2.49.0.1266.g31b7d2e469.dirty

