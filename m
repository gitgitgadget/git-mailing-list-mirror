Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E586726560B
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 06:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289045; cv=none; b=bplR8lYhIhfigIng58m3YcvUNPz01L8/571++GwdAtF+7+TUJb7nOH3hPxVoan+Et97apPqpYVHOOaKIJ+V4OmGnHm+mF0reBQ/r2u/Ml64cLM/m1n3V18H5Cj2iB0MxpZu7+DaELdr0VaAQu/sUgEmm9xSqwkj/XFT5hZTMJdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289045; c=relaxed/simple;
	bh=Olro75VoW9kAvfs95AMuRQ8mMGue71EUm7Z21AEIpbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMCKmftWsGj5VHCNEyWI0/+TYBDf0XISf9YgxPK9l3WFLxvXOnHiKNFqgIdsiuYZQDeYriFCKKJ/5KkgWHaCj2Wc0sVDPYgGB35A1sQvivp1lT9hFCehd7LRu4YgXURZG3aU9KJoLxZL/iDJX69KkkojkQpGEbx2yGzq8XeAjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=od+JcgS3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crDqP9t2; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="od+JcgS3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crDqP9t2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 12D02EC021F;
	Fri, 24 Oct 2025 02:57:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 24 Oct 2025 02:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761289043;
	 x=1761375443; bh=j+iXQy89onZ9XYXNXJ3ANZ584hNsdViy5+jihltXYqE=; b=
	od+JcgS3JS0Ihmo6dRhLH+2s/phM/koBW55Liz96Y+eHxiGV6Yb3ymofDa1xSe3r
	LZII7mNZFCQ44j/+pS74FLxDHYEwXL1GC9XijeAqcMb0mb6FU7BBjuBIV/zeDMby
	JXQGl6qAPG5YMVt52vzord77x+NMid8Hd9v4tYazDLw6ULvNAd6MZbbuiItFTYWQ
	EvtX63mTn9Sd8GhPgjV26FDqpsHj4/sTN8HzzsuG1MZrVlcy7khX7RfiHmafqF4F
	YczXVRL+jCdxrSQ8S1eCtGM4dF0BvOP2ULJsaDLwFc8utJC3NI0+BkwdXZbzyxkr
	hSFmBDhpIM2bm1pHkijr5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761289043; x=
	1761375443; bh=j+iXQy89onZ9XYXNXJ3ANZ584hNsdViy5+jihltXYqE=; b=c
	rDqP9t22FzvUIjnP0MVfDbOp9BcTJ7LXoMKScVZ1KO7fDT9JUBgIPfZAHQYgueFB
	KMevyjrjZKPTyQPPZcPrGqQKRzX4a9uXH0lLhCSvmcjsohvOR8wYbZTHMTptv3bY
	wMsF8QLvw6eeX6dQHUOrZJhgZ9jZlh8UrIuWgdSmuRtpeADYlTpBcv63OdMeQ6RX
	Twg+qNHC4Apuj17bK7vB1FQzOGi/7+J3+okNOmMLnfm4Z9QEuss/lyhUHldhOhen
	TweP38pwAG9GQFQ8OX7TiOMo3ayM/LahtG8P5NcT0fUkP40PQ50RGNYbh//G/G8Z
	EkukaYqn5MSlVovgEvyeA==
X-ME-Sender: <xms:UiP7aJnmuD_JNPwgjLqrX49B5rKghegL1ZgqUYmsXVdeJ7ZSv7ZbPA>
    <xme:UiP7aAU4BidRhea2JEDQi9NMFKdhieYecXuNacIogjIh_jWHWt4jQTR9xovvAj0yU
    mvcKCdctnEpRMFQbIyOR_pCQ0JDwXQIAzZjyTVTZln1wnAd66EKTw>
X-ME-Received: <xmr:UiP7aGGCN7S8mhlaeWMLVxo6OagaAeuaIqZSJFfK1_UuvRGyoODUtFBC8spSdBbq3zSrFTz-Kr1oQVMXXSBGL8sJo_86HrLLK69sMJAEtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:UiP7aEdmRx_o5pRp_0k4ktsRKJPoIzZff2nTWgfN428v_2UCbkWEBg>
    <xmx:UiP7aPKvulZqbUZKah2P8LEZ3BIPn-PFTwW5ZybMT3GnPnbd0aNhGA>
    <xmx:UiP7aBGe4Qxp1QeqGOAB4uAw4LdxB-qO5_ggAyTLV3t89tXzthxyrA>
    <xmx:UiP7aKDUMJ2RsOOUmWJv7TbGuuhqIHyF_6BBa685u3NV1WkNvXWRaA>
    <xmx:UyP7aKZCbWgeiAKeF6r07R0boUDZ2eV_GYnyf7Jp8a-vC6dD8ynth4LH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 02:57:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5fb839ee (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 06:57:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 08:57:14 +0200
Subject: [PATCH v3 01/10] builtin/gc: remove global `repack` variable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-pks-maintenance-geometric-strategy-v3-1-9b5b3bdb4387@pks.im>
References: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
In-Reply-To: <20251024-pks-maintenance-geometric-strategy-v3-0-9b5b3bdb4387@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

The global `repack` variable is used to store all command line arguments
that we eventually want to pass to git-repack(1). It is being appended
to from multiple different functions, which makes it hard to follow the
logic. Besides being hard to follow, it also makes it unnecessarily hard
to reuse this infrastructure in new code.

Refactor the code so that we store this variable on the stack and pass
a pointer to it around as needed. This is done so that we can reuse
`add_repack_all_options()` in a subsequent commit.

The refactoring itself is straight-forward. One function that deserves
attention though is `need_to_gc()`: this function determines whether or
not we need to execute garbage collection for `git gc --auto`, but also
for `git maintenance run --auto`. But besides figuring out whether we
have to perform GC, the function also sets up the `repack` arguments.

For `git gc --auto` it's trivial to adapt, as we already have the
on-stack variable at our fingertips. But for the maintenance condition
it's less obvious what to do.

As it turns out, we can just use another temporary variable there that
we then immediately discard. If we need to perform GC we execute a child
git-gc(1) process to repack objects for us, and that process will have
to recompute the arguments anyway.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 74 ++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 29 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e19e13d9788..e9772eb3a30 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -55,7 +55,6 @@ static const char * const builtin_gc_usage[] = {
 };
 
 static timestamp_t gc_log_expire_time;
-static struct strvec repack = STRVEC_INIT;
 static struct tempfile *pidfile;
 static struct lock_file log_lock;
 static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
@@ -618,48 +617,50 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
 	return os_cache + heap;
 }
 
-static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
+static int keep_one_pack(struct string_list_item *item, void *data)
 {
-	strvec_pushf(&repack, "--keep-pack=%s", basename(item->string));
+	struct strvec *args = data;
+	strvec_pushf(args, "--keep-pack=%s", basename(item->string));
 	return 0;
 }
 
 static void add_repack_all_option(struct gc_config *cfg,
-				  struct string_list *keep_pack)
+				  struct string_list *keep_pack,
+				  struct strvec *args)
 {
 	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
 		&& !(cfg->cruft_packs && cfg->repack_expire_to))
-		strvec_push(&repack, "-a");
+		strvec_push(args, "-a");
 	else if (cfg->cruft_packs) {
-		strvec_push(&repack, "--cruft");
+		strvec_push(args, "--cruft");
 		if (cfg->prune_expire)
-			strvec_pushf(&repack, "--cruft-expiration=%s", cfg->prune_expire);
+			strvec_pushf(args, "--cruft-expiration=%s", cfg->prune_expire);
 		if (cfg->max_cruft_size)
-			strvec_pushf(&repack, "--max-cruft-size=%lu",
+			strvec_pushf(args, "--max-cruft-size=%lu",
 				     cfg->max_cruft_size);
 		if (cfg->repack_expire_to)
-			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);
+			strvec_pushf(args, "--expire-to=%s", cfg->repack_expire_to);
 	} else {
-		strvec_push(&repack, "-A");
+		strvec_push(args, "-A");
 		if (cfg->prune_expire)
-			strvec_pushf(&repack, "--unpack-unreachable=%s", cfg->prune_expire);
+			strvec_pushf(args, "--unpack-unreachable=%s", cfg->prune_expire);
 	}
 
 	if (keep_pack)
-		for_each_string_list(keep_pack, keep_one_pack, NULL);
+		for_each_string_list(keep_pack, keep_one_pack, args);
 
 	if (cfg->repack_filter && *cfg->repack_filter)
-		strvec_pushf(&repack, "--filter=%s", cfg->repack_filter);
+		strvec_pushf(args, "--filter=%s", cfg->repack_filter);
 	if (cfg->repack_filter_to && *cfg->repack_filter_to)
-		strvec_pushf(&repack, "--filter-to=%s", cfg->repack_filter_to);
+		strvec_pushf(args, "--filter-to=%s", cfg->repack_filter_to);
 }
 
-static void add_repack_incremental_option(void)
+static void add_repack_incremental_option(struct strvec *args)
 {
-	strvec_push(&repack, "--no-write-bitmap-index");
+	strvec_push(args, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(struct gc_config *cfg)
+static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 {
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
@@ -700,10 +701,10 @@ static int need_to_gc(struct gc_config *cfg)
 				string_list_clear(&keep_pack, 0);
 		}
 
-		add_repack_all_option(cfg, &keep_pack);
+		add_repack_all_option(cfg, &keep_pack, repack_args);
 		string_list_clear(&keep_pack, 0);
 	} else if (too_many_loose_objects(cfg))
-		add_repack_incremental_option();
+		add_repack_incremental_option(repack_args);
 	else
 		return 0;
 
@@ -852,6 +853,7 @@ int cmd_gc(int argc,
 	int keep_largest_pack = -1;
 	int skip_foreground_tasks = 0;
 	timestamp_t dummy;
+	struct strvec repack_args = STRVEC_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -891,7 +893,7 @@ int cmd_gc(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_gc_usage, builtin_gc_options);
 
-	strvec_pushl(&repack, "repack", "-d", "-l", NULL);
+	strvec_pushl(&repack_args, "repack", "-d", "-l", NULL);
 
 	gc_config(&cfg);
 
@@ -914,14 +916,14 @@ int cmd_gc(int argc,
 		die(_("failed to parse prune expiry value %s"), cfg.prune_expire);
 
 	if (aggressive) {
-		strvec_push(&repack, "-f");
+		strvec_push(&repack_args, "-f");
 		if (cfg.aggressive_depth > 0)
-			strvec_pushf(&repack, "--depth=%d", cfg.aggressive_depth);
+			strvec_pushf(&repack_args, "--depth=%d", cfg.aggressive_depth);
 		if (cfg.aggressive_window > 0)
-			strvec_pushf(&repack, "--window=%d", cfg.aggressive_window);
+			strvec_pushf(&repack_args, "--window=%d", cfg.aggressive_window);
 	}
 	if (opts.quiet)
-		strvec_push(&repack, "-q");
+		strvec_push(&repack_args, "-q");
 
 	if (opts.auto_flag) {
 		if (cfg.detach_auto && opts.detach < 0)
@@ -930,7 +932,7 @@ int cmd_gc(int argc,
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(&cfg)) {
+		if (!need_to_gc(&cfg, &repack_args)) {
 			ret = 0;
 			goto out;
 		}
@@ -952,7 +954,7 @@ int cmd_gc(int argc,
 			find_base_packs(&keep_pack, cfg.big_pack_threshold);
 		}
 
-		add_repack_all_option(&cfg, &keep_pack);
+		add_repack_all_option(&cfg, &keep_pack, &repack_args);
 		string_list_clear(&keep_pack, 0);
 	}
 
@@ -1014,9 +1016,9 @@ int cmd_gc(int argc,
 
 		repack_cmd.git_cmd = 1;
 		repack_cmd.close_object_store = 1;
-		strvec_pushv(&repack_cmd.args, repack.v);
+		strvec_pushv(&repack_cmd.args, repack_args.v);
 		if (run_command(&repack_cmd))
-			die(FAILED_RUN, repack.v[0]);
+			die(FAILED_RUN, repack_args.v[0]);
 
 		if (cfg.prune_expire) {
 			struct child_process prune_cmd = CHILD_PROCESS_INIT;
@@ -1067,6 +1069,7 @@ int cmd_gc(int argc,
 
 out:
 	maintenance_run_opts_release(&opts);
+	strvec_clear(&repack_args);
 	gc_config_release(&cfg);
 	return 0;
 }
@@ -1269,6 +1272,19 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
 	return run_command(&child);
 }
 
+static int gc_condition(struct gc_config *cfg)
+{
+	/*
+	 * Note that it's fine to drop the repack arguments here, as we execute
+	 * git-gc(1) as a separate child process anyway. So it knows to compute
+	 * these arguments again.
+	 */
+	struct strvec repack_args = STRVEC_INIT;
+	int ret = need_to_gc(cfg, &repack_args);
+	strvec_clear(&repack_args);
+	return ret;
+}
+
 static int prune_packed(struct maintenance_run_opts *opts)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
@@ -1596,7 +1612,7 @@ static const struct maintenance_task tasks[] = {
 		.name = "gc",
 		.foreground = maintenance_task_gc_foreground,
 		.background = maintenance_task_gc_background,
-		.auto_condition = need_to_gc,
+		.auto_condition = gc_condition,
 	},
 	[TASK_COMMIT_GRAPH] = {
 		.name = "commit-graph",

-- 
2.51.1.930.gacf6e81ea2.dirty

