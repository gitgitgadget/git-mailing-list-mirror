Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568431AC8AE
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720277; cv=none; b=iMlhSmglDtS4maI8Ks8wjDVQ3lXHzLksryYb5RXOTKKnuE6P10hf/+1ucef8PUYXRfnaD5qFuDC98NZ6aEoGJVYe5nnb40eujBdPBYhx0chlJqaZmOS+h1u8Q1TsABRLdXGrFJAD1l3PvyeZ4tsBvVZiCJWA6C5RBwJWQCNYVrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720277; c=relaxed/simple;
	bh=7oVC+fJ4YyTKYG94rfjADQoTrNgBR4nUnPS33bxvvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP9SL8QLg4ku8YOizalitsoagg499xaLiKn9pub1udanocNumQ7z5/6Z2w1ZR3TmMf72tfyKxMSm2W7/M6BAZ/+81HzggB865LuDtfEkLOAKFQ0t2amnIQ95JXdWlGZ+CvFfv1B15jjYrx5enAEAVOIZsQm6vwEqxrRUoB/4J0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cwjEVaWK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ly6Kbv+z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cwjEVaWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ly6Kbv+z"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F16EA138DD84;
	Thu, 15 Aug 2024 05:12:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 05:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713159; x=1723799559; bh=p9CwnAe3yB
	IO3CTb23KgLYHWq940TsLWUFKqGQhtdtw=; b=cwjEVaWK+8QSgktENMrW4LZZio
	DK0RbRewZPXLobyApmbY9xcOjF7QlF2zF1Iq6mJ/rjGM8DMPLbmYn1SswFHXVdW4
	GFvlDKKGnHExL6d1ChCfhC0WNYK9o7uAP8dD5/NaO4JjAj0/0s7fXeUYXOurab/6
	qNBnCov1OkXQv4O01PbuKwCYzHCoIeJ3ysz8Wo4KWgzX9wOryCDGxpclmYX9aV7j
	HK3CnNPouCfDeLxOQwOWl/DbPGoYj5MqOHeXbHJCOiVfUYz323J6vXFV/aTwQcOb
	aH2axLpb6klRM+OHglYKTV31at1yVJcTWGnV/kakRhf8jkgNfiuxiQPJJVgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713159; x=1723799559; bh=p9CwnAe3yBIO3CTb23KgLYHWq940
	TsLWUFKqGQhtdtw=; b=Ly6Kbv+zkLC5hNw4AcZWj3oHRq4ym0dZsX+vdx1zEUQ/
	EXLnOFuQU3hOyoyig5xpdWeVYwH6P2dIT2dE32g9eq0vxcfYqahQGVg1rzmeabvr
	kql6I38fq89eL2a0x8vs0GkxzcPniNEtKrHu9qU6xzXdC5c4VBUuRuurFJ+K2hXO
	uEDcUo+BK1pAXdgVG1gNUW6cn/WjB58lIcO1c2n3HY0yakz8zeK3V7s82xKKvQWz
	K+eJlErkskuK2Tp95/g6FFMHe1jItGbtAStlod+is7hR1liQtAPVRZfY79hFH7ck
	Gb5d5LQ3qPPKZN23BKreDFL7FTt1pa7GaISKEW5brg==
X-ME-Sender: <xms:h8a9ZsVng--_qPmnSozGsShAeo5vwBgPSedJ5yQoJn6FCrphp7-aPw>
    <xme:h8a9ZglJwNGNlvdG_kO0mDmWbxBzOopc2f85gBMU8IXGcJAehHgfPURxFYJcXfALE
    qcuPah7PcsbEEhLEg>
X-ME-Received: <xmr:h8a9ZgaHKSp91CoKiY6K83hw4tXI4j0ZynNUOuhKGYLr8vdHl6YEiye2LsBS_O3tvq1YulT32GBEjhSDYGe_ilRNnYJhBNp3kG7fUdFugNCtGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h8a9ZrVNaTVwUhSgiiNcqNuQuxg8WKIIgKB37Rm_hs0dVTTJL4q3aw>
    <xmx:h8a9Zml4xi4W6Ak1UB5jzVFC6npcNol1xkTWOTKBbBkPa-g7g8TjMA>
    <xmx:h8a9Zgc3Ysq9bJAlIdPGB7MwLu8DgMK43DMdMfsJdw6x4AkNToN8Uw>
    <xmx:h8a9ZoFJU6jJC9OPOak37YxTNNbv5KN9AtztxabnpHcVuUwKaqAlOA>
    <xmx:h8a9ZnAn-oDkILnOzzmH878oylUjwSCHhWSgw2-97PbCGltffooeMYoD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2f5f7db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:12 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 2/7] builtin/gc: refactor to read config into structure
Message-ID: <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

The git-gc(1) command knows to read a bunch of config keys to tweak its
own behaviour. The values are parsed into global variables, which makes
it hard to correctly manage the lifecycle of values that may require a
memory allocation.

Refactor the code to use a `struct gc_config` that gets populated and
passed around. For one, this makes previously-implicit dependencies on
these config values clear. Second, it will allow us to properly manage
the lifecycle in the next commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 255 +++++++++++++++++++++++++++++----------------------
 1 file changed, 143 insertions(+), 112 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e7406bf667..eee7401647 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -49,23 +49,7 @@ static const char * const builtin_gc_usage[] = {
 	NULL
 };
 
-static int pack_refs = 1;
-static int prune_reflogs = 1;
-static int cruft_packs = 1;
-static unsigned long max_cruft_size;
-static int aggressive_depth = 50;
-static int aggressive_window = 250;
-static int gc_auto_threshold = 6700;
-static int gc_auto_pack_limit = 50;
-static int detach_auto = 1;
 static timestamp_t gc_log_expire_time;
-static const char *gc_log_expire = "1.day.ago";
-static const char *prune_expire = "2.weeks.ago";
-static const char *prune_worktrees_expire = "3.months.ago";
-static char *repack_filter;
-static char *repack_filter_to;
-static unsigned long big_pack_threshold;
-static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 
 static struct strvec reflog = STRVEC_INIT;
 static struct strvec repack = STRVEC_INIT;
@@ -145,37 +129,71 @@ static int gc_config_is_timestamp_never(const char *var)
 	return 0;
 }
 
-static void gc_config(void)
+struct gc_config {
+	int pack_refs;
+	int prune_reflogs;
+	int cruft_packs;
+	unsigned long max_cruft_size;
+	int aggressive_depth;
+	int aggressive_window;
+	int gc_auto_threshold;
+	int gc_auto_pack_limit;
+	int detach_auto;
+	const char *gc_log_expire;
+	const char *prune_expire;
+	const char *prune_worktrees_expire;
+	char *repack_filter;
+	char *repack_filter_to;
+	unsigned long big_pack_threshold;
+	unsigned long max_delta_cache_size;
+};
+
+#define GC_CONFIG_INIT { \
+	.pack_refs = 1, \
+	.prune_reflogs = 1, \
+	.cruft_packs = 1, \
+	.aggressive_depth = 50, \
+	.aggressive_window = 250, \
+	.gc_auto_threshold = 6700, \
+	.gc_auto_pack_limit = 50, \
+	.detach_auto = 1, \
+	.gc_log_expire = "1.day.ago", \
+	.prune_expire = "2.weeks.ago", \
+	.prune_worktrees_expire = "3.months.ago", \
+	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
+}
+
+static void gc_config(struct gc_config *cfg)
 {
 	const char *value;
 
 	if (!git_config_get_value("gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
-			pack_refs = -1;
+			cfg->pack_refs = -1;
 		else
-			pack_refs = git_config_bool("gc.packrefs", value);
+			cfg->pack_refs = git_config_bool("gc.packrefs", value);
 	}
 
 	if (gc_config_is_timestamp_never("gc.reflogexpire") &&
 	    gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
-		prune_reflogs = 0;
+		cfg->prune_reflogs = 0;
 
-	git_config_get_int("gc.aggressivewindow", &aggressive_window);
-	git_config_get_int("gc.aggressivedepth", &aggressive_depth);
-	git_config_get_int("gc.auto", &gc_auto_threshold);
-	git_config_get_int("gc.autopacklimit", &gc_auto_pack_limit);
-	git_config_get_bool("gc.autodetach", &detach_auto);
-	git_config_get_bool("gc.cruftpacks", &cruft_packs);
-	git_config_get_ulong("gc.maxcruftsize", &max_cruft_size);
-	git_config_get_expiry("gc.pruneexpire", (char **) &prune_expire);
-	git_config_get_expiry("gc.worktreepruneexpire", (char **) &prune_worktrees_expire);
-	git_config_get_expiry("gc.logexpiry", (char **) &gc_log_expire);
+	git_config_get_int("gc.aggressivewindow", &cfg->aggressive_window);
+	git_config_get_int("gc.aggressivedepth", &cfg->aggressive_depth);
+	git_config_get_int("gc.auto", &cfg->gc_auto_threshold);
+	git_config_get_int("gc.autopacklimit", &cfg->gc_auto_pack_limit);
+	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
+	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
+	git_config_get_ulong("gc.maxcruftsize", &cfg->max_cruft_size);
+	git_config_get_expiry("gc.pruneexpire", (char **) &cfg->prune_expire);
+	git_config_get_expiry("gc.worktreepruneexpire", (char **) &cfg->prune_worktrees_expire);
+	git_config_get_expiry("gc.logexpiry", (char **) &cfg->gc_log_expire);
 
-	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
-	git_config_get_ulong("pack.deltacachesize", &max_delta_cache_size);
+	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
+	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
 
-	git_config_get_string("gc.repackfilter", &repack_filter);
-	git_config_get_string("gc.repackfilterto", &repack_filter_to);
+	git_config_get_string("gc.repackfilter", &cfg->repack_filter);
+	git_config_get_string("gc.repackfilterto", &cfg->repack_filter_to);
 
 	git_config(git_default_config, NULL);
 }
@@ -206,7 +224,7 @@ struct maintenance_run_opts {
 	enum schedule_priority schedule;
 };
 
-static int pack_refs_condition(void)
+static int pack_refs_condition(UNUSED struct gc_config *cfg)
 {
 	/*
 	 * The auto-repacking logic for refs is handled by the ref backends and
@@ -216,7 +234,8 @@ static int pack_refs_condition(void)
 	return 1;
 }
 
-static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
+static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts,
+				      UNUSED struct gc_config *cfg)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
@@ -228,7 +247,7 @@ static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *
 	return run_command(&cmd);
 }
 
-static int too_many_loose_objects(void)
+static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
 	 * Quickly check if a "gc" is needed, by estimating how
@@ -247,7 +266,7 @@ static int too_many_loose_objects(void)
 	if (!dir)
 		return 0;
 
-	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);
+	auto_threshold = DIV_ROUND_UP(cfg->gc_auto_threshold, 256);
 	while ((ent = readdir(dir)) != NULL) {
 		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
 		    ent->d_name[hexsz_loose] != '\0')
@@ -283,12 +302,12 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	return base;
 }
 
-static int too_many_packs(void)
+static int too_many_packs(struct gc_config *cfg)
 {
 	struct packed_git *p;
 	int cnt;
 
-	if (gc_auto_pack_limit <= 0)
+	if (cfg->gc_auto_pack_limit <= 0)
 		return 0;
 
 	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
@@ -302,7 +321,7 @@ static int too_many_packs(void)
 		 */
 		cnt++;
 	}
-	return gc_auto_pack_limit < cnt;
+	return cfg->gc_auto_pack_limit < cnt;
 }
 
 static uint64_t total_ram(void)
@@ -336,7 +355,8 @@ static uint64_t total_ram(void)
 	return 0;
 }
 
-static uint64_t estimate_repack_memory(struct packed_git *pack)
+static uint64_t estimate_repack_memory(struct gc_config *cfg,
+				       struct packed_git *pack)
 {
 	unsigned long nr_objects = repo_approximate_object_count(the_repository);
 	size_t os_cache, heap;
@@ -373,7 +393,7 @@ static uint64_t estimate_repack_memory(struct packed_git *pack)
 	 */
 	heap += delta_base_cache_limit;
 	/* and of course pack-objects has its own delta cache */
-	heap += max_delta_cache_size;
+	heap += cfg->max_delta_cache_size;
 
 	return os_cache + heap;
 }
@@ -384,30 +404,31 @@ static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
 	return 0;
 }
 
-static void add_repack_all_option(struct string_list *keep_pack)
+static void add_repack_all_option(struct gc_config *cfg,
+				  struct string_list *keep_pack)
 {
-	if (prune_expire && !strcmp(prune_expire, "now"))
+	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
 		strvec_push(&repack, "-a");
-	else if (cruft_packs) {
+	else if (cfg->cruft_packs) {
 		strvec_push(&repack, "--cruft");
-		if (prune_expire)
-			strvec_pushf(&repack, "--cruft-expiration=%s", prune_expire);
-		if (max_cruft_size)
+		if (cfg->prune_expire)
+			strvec_pushf(&repack, "--cruft-expiration=%s", cfg->prune_expire);
+		if (cfg->max_cruft_size)
 			strvec_pushf(&repack, "--max-cruft-size=%lu",
-				     max_cruft_size);
+				     cfg->max_cruft_size);
 	} else {
 		strvec_push(&repack, "-A");
-		if (prune_expire)
-			strvec_pushf(&repack, "--unpack-unreachable=%s", prune_expire);
+		if (cfg->prune_expire)
+			strvec_pushf(&repack, "--unpack-unreachable=%s", cfg->prune_expire);
 	}
 
 	if (keep_pack)
 		for_each_string_list(keep_pack, keep_one_pack, NULL);
 
-	if (repack_filter && *repack_filter)
-		strvec_pushf(&repack, "--filter=%s", repack_filter);
-	if (repack_filter_to && *repack_filter_to)
-		strvec_pushf(&repack, "--filter-to=%s", repack_filter_to);
+	if (cfg->repack_filter && *cfg->repack_filter)
+		strvec_pushf(&repack, "--filter=%s", cfg->repack_filter);
+	if (cfg->repack_filter_to && *cfg->repack_filter_to)
+		strvec_pushf(&repack, "--filter-to=%s", cfg->repack_filter_to);
 }
 
 static void add_repack_incremental_option(void)
@@ -415,13 +436,13 @@ static void add_repack_incremental_option(void)
 	strvec_push(&repack, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(void)
+static int need_to_gc(struct gc_config *cfg)
 {
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
 	 */
-	if (gc_auto_threshold <= 0)
+	if (cfg->gc_auto_threshold <= 0)
 		return 0;
 
 	/*
@@ -430,13 +451,13 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs()) {
+	if (too_many_packs(cfg)) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
-			if (keep_pack.nr >= gc_auto_pack_limit) {
-				big_pack_threshold = 0;
+		if (cfg->big_pack_threshold) {
+			find_base_packs(&keep_pack, cfg->big_pack_threshold);
+			if (keep_pack.nr >= cfg->gc_auto_pack_limit) {
+				cfg->big_pack_threshold = 0;
 				string_list_clear(&keep_pack, 0);
 				find_base_packs(&keep_pack, 0);
 			}
@@ -445,7 +466,7 @@ static int need_to_gc(void)
 			uint64_t mem_have, mem_want;
 
 			mem_have = total_ram();
-			mem_want = estimate_repack_memory(p);
+			mem_want = estimate_repack_memory(cfg, p);
 
 			/*
 			 * Only allow 1/2 of memory for pack-objects, leave
@@ -456,9 +477,9 @@ static int need_to_gc(void)
 				string_list_clear(&keep_pack, 0);
 		}
 
-		add_repack_all_option(&keep_pack);
+		add_repack_all_option(cfg, &keep_pack);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects())
+	} else if (too_many_loose_objects(cfg))
 		add_repack_incremental_option();
 	else
 		return 0;
@@ -585,7 +606,8 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static void gc_before_repack(struct maintenance_run_opts *opts)
+static void gc_before_repack(struct maintenance_run_opts *opts,
+			     struct gc_config *cfg)
 {
 	/*
 	 * We may be called twice, as both the pre- and
@@ -596,10 +618,10 @@ static void gc_before_repack(struct maintenance_run_opts *opts)
 	if (done++)
 		return;
 
-	if (pack_refs && maintenance_task_pack_refs(opts))
+	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
 		die(FAILED_RUN, "pack-refs");
 
-	if (prune_reflogs) {
+	if (cfg->prune_reflogs) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
 		cmd.git_cmd = 1;
@@ -621,14 +643,15 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	timestamp_t dummy;
 	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = {0};
+	struct gc_config cfg = GC_CONFIG_INIT;
 
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
-		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
+		{ OPTION_STRING, 0, "prune", &cfg.prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
-		OPT_BOOL(0, "cruft", &cruft_packs, N_("pack unreferenced objects separately")),
-		OPT_MAGNITUDE(0, "max-cruft-size", &max_cruft_size,
+			PARSE_OPT_OPTARG, NULL, (intptr_t)cfg.prune_expire },
+		OPT_BOOL(0, "cruft", &cfg.cruft_packs, N_("pack unreferenced objects separately")),
+		OPT_MAGNITUDE(0, "max-cruft-size", &cfg.max_cruft_size,
 			      N_("with --cruft, limit the size of new cruft packs")),
 		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
 		OPT_BOOL_F(0, "auto", &opts.auto_flag, N_("enable auto-gc mode"),
@@ -651,27 +674,27 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	strvec_pushl(&rerere, "rerere", "gc", NULL);
 
 	/* default expiry time, overwritten in gc_config */
-	gc_config();
-	if (parse_expiry_date(gc_log_expire, &gc_log_expire_time))
-		die(_("failed to parse gc.logExpiry value %s"), gc_log_expire);
+	gc_config(&cfg);
+	if (parse_expiry_date(cfg.gc_log_expire, &gc_log_expire_time))
+		die(_("failed to parse gc.logExpiry value %s"), cfg.gc_log_expire);
 
-	if (pack_refs < 0)
-		pack_refs = !is_bare_repository();
+	if (cfg.pack_refs < 0)
+		cfg.pack_refs = !is_bare_repository();
 
 	argc = parse_options(argc, argv, prefix, builtin_gc_options,
 			     builtin_gc_usage, 0);
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
-	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
-		die(_("failed to parse prune expiry value %s"), prune_expire);
+	if (cfg.prune_expire && parse_expiry_date(cfg.prune_expire, &dummy))
+		die(_("failed to parse prune expiry value %s"), cfg.prune_expire);
 
 	if (aggressive) {
 		strvec_push(&repack, "-f");
-		if (aggressive_depth > 0)
-			strvec_pushf(&repack, "--depth=%d", aggressive_depth);
-		if (aggressive_window > 0)
-			strvec_pushf(&repack, "--window=%d", aggressive_window);
+		if (cfg.aggressive_depth > 0)
+			strvec_pushf(&repack, "--depth=%d", cfg.aggressive_depth);
+		if (cfg.aggressive_window > 0)
+			strvec_pushf(&repack, "--window=%d", cfg.aggressive_window);
 	}
 	if (quiet)
 		strvec_push(&repack, "-q");
@@ -680,16 +703,16 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc())
+		if (!need_to_gc(&cfg))
 			return 0;
 		if (!quiet) {
-			if (detach_auto)
+			if (cfg.detach_auto)
 				fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
 			else
 				fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
-		if (detach_auto) {
+		if (cfg.detach_auto) {
 			int ret = report_last_gc_error();
 
 			if (ret == 1)
@@ -701,7 +724,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 			if (lock_repo_for_gc(force, &pid))
 				return 0;
-			gc_before_repack(&opts); /* dies on failure */
+			gc_before_repack(&opts, &cfg); /* dies on failure */
 			delete_tempfile(&pidfile);
 
 			/*
@@ -716,11 +739,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (keep_largest_pack != -1) {
 			if (keep_largest_pack)
 				find_base_packs(&keep_pack, 0);
-		} else if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
+		} else if (cfg.big_pack_threshold) {
+			find_base_packs(&keep_pack, cfg.big_pack_threshold);
 		}
 
-		add_repack_all_option(&keep_pack);
+		add_repack_all_option(&cfg, &keep_pack);
 		string_list_clear(&keep_pack, 0);
 	}
 
@@ -741,7 +764,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		atexit(process_log_file_at_exit);
 	}
 
-	gc_before_repack(&opts);
+	gc_before_repack(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
@@ -752,11 +775,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		if (run_command(&repack_cmd))
 			die(FAILED_RUN, repack.v[0]);
 
-		if (prune_expire) {
+		if (cfg.prune_expire) {
 			struct child_process prune_cmd = CHILD_PROCESS_INIT;
 
 			/* run `git prune` even if using cruft packs */
-			strvec_push(&prune, prune_expire);
+			strvec_push(&prune, cfg.prune_expire);
 			if (quiet)
 				strvec_push(&prune, "--no-progress");
 			if (repo_has_promisor_remote(the_repository))
@@ -769,10 +792,10 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (prune_worktrees_expire) {
+	if (cfg.prune_worktrees_expire) {
 		struct child_process prune_worktrees_cmd = CHILD_PROCESS_INIT;
 
-		strvec_push(&prune_worktrees, prune_worktrees_expire);
+		strvec_push(&prune_worktrees, cfg.prune_worktrees_expire);
 		prune_worktrees_cmd.git_cmd = 1;
 		strvec_pushv(&prune_worktrees_cmd.args, prune_worktrees.v);
 		if (run_command(&prune_worktrees_cmd))
@@ -796,7 +819,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 					     !quiet && !daemonized ? COMMIT_GRAPH_WRITE_PROGRESS : 0,
 					     NULL);
 
-	if (opts.auto_flag && too_many_loose_objects())
+	if (opts.auto_flag && too_many_loose_objects(&cfg))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
@@ -892,7 +915,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 	return result;
 }
 
-static int should_write_commit_graph(void)
+static int should_write_commit_graph(struct gc_config *cfg)
 {
 	int result;
 	struct cg_auto_data data;
@@ -929,7 +952,8 @@ static int run_write_commit_graph(struct maintenance_run_opts *opts)
 	return !!run_command(&child);
 }
 
-static int maintenance_task_commit_graph(struct maintenance_run_opts *opts)
+static int maintenance_task_commit_graph(struct maintenance_run_opts *opts,
+					 struct gc_config *cfg)
 {
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_commit_graph)
@@ -963,7 +987,8 @@ static int fetch_remote(struct remote *remote, void *cbdata)
 	return !!run_command(&child);
 }
 
-static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
+static int maintenance_task_prefetch(struct maintenance_run_opts *opts,
+				     struct gc_config *cfg)
 {
 	if (for_each_remote(fetch_remote, opts)) {
 		error(_("failed to prefetch remotes"));
@@ -973,7 +998,8 @@ static int maintenance_task_prefetch(struct maintenance_run_opts *opts)
 	return 0;
 }
 
-static int maintenance_task_gc(struct maintenance_run_opts *opts)
+static int maintenance_task_gc(struct maintenance_run_opts *opts,
+			       struct gc_config *cfg)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
@@ -1021,7 +1047,7 @@ static int loose_object_count(const struct object_id *oid UNUSED,
 	return 0;
 }
 
-static int loose_object_auto_condition(void)
+static int loose_object_auto_condition(struct gc_config *cfg)
 {
 	int count = 0;
 
@@ -1106,12 +1132,13 @@ static int pack_loose(struct maintenance_run_opts *opts)
 	return result;
 }
 
-static int maintenance_task_loose_objects(struct maintenance_run_opts *opts)
+static int maintenance_task_loose_objects(struct maintenance_run_opts *opts,
+					  struct gc_config *cfg)
 {
 	return prune_packed(opts) || pack_loose(opts);
 }
 
-static int incremental_repack_auto_condition(void)
+static int incremental_repack_auto_condition(struct gc_config *cfg)
 {
 	struct packed_git *p;
 	int incremental_repack_auto_limit = 10;
@@ -1230,7 +1257,8 @@ static int multi_pack_index_repack(struct maintenance_run_opts *opts)
 	return 0;
 }
 
-static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts)
+static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts,
+					       struct gc_config *cfg)
 {
 	prepare_repo_settings(the_repository);
 	if (!the_repository->settings.core_multi_pack_index) {
@@ -1247,14 +1275,15 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
-typedef int maintenance_task_fn(struct maintenance_run_opts *opts);
+typedef int maintenance_task_fn(struct maintenance_run_opts *opts,
+				struct gc_config *cfg);
 
 /*
  * An auto condition function returns 1 if the task should run
  * and 0 if the task should NOT run. See needs_to_gc() for an
  * example.
  */
-typedef int maintenance_auto_fn(void);
+typedef int maintenance_auto_fn(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
@@ -1321,7 +1350,8 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 	return b->selected_order - a->selected_order;
 }
 
-static int maintenance_run_tasks(struct maintenance_run_opts *opts)
+static int maintenance_run_tasks(struct maintenance_run_opts *opts,
+				 struct gc_config *cfg)
 {
 	int i, found_selected = 0;
 	int result = 0;
@@ -1360,14 +1390,14 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 
 		if (opts->auto_flag &&
 		    (!tasks[i].auto_condition ||
-		     !tasks[i].auto_condition()))
+		     !tasks[i].auto_condition(cfg)))
 			continue;
 
 		if (opts->schedule && tasks[i].schedule < opts->schedule)
 			continue;
 
 		trace2_region_enter("maintenance", tasks[i].name, r);
-		if (tasks[i].fn(opts)) {
+		if (tasks[i].fn(opts, cfg)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
@@ -1404,7 +1434,6 @@ static void initialize_task_config(int schedule)
 {
 	int i;
 	struct strbuf config_name = STRBUF_INIT;
-	gc_config();
 
 	if (schedule)
 		initialize_maintenance_strategy();
@@ -1468,6 +1497,7 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
 	int i;
 	struct maintenance_run_opts opts;
+	struct gc_config cfg = GC_CONFIG_INIT;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
@@ -1496,12 +1526,13 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	if (opts.auto_flag && opts.schedule)
 		die(_("use at most one of --auto and --schedule=<frequency>"));
 
+	gc_config(&cfg);
 	initialize_task_config(opts.schedule);
 
 	if (argc != 0)
 		usage_with_options(builtin_maintenance_run_usage,
 				   builtin_maintenance_run_options);
-	return maintenance_run_tasks(&opts);
+	return maintenance_run_tasks(&opts, &cfg);
 }
 
 static char *get_maintpath(void)
-- 
2.46.0.46.g406f326d27.dirty

