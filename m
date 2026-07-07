Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C02423796
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438391; cv=none; b=bB0u+VPmRPSLt6gijRrt7xx9RA6EAZZAKpCSARlGtss/vr31sV1QJlg12YkhgxBQSevWiPRQ1He+ErPXTrDAcVmoFf5fhcw7BfSmQjdiXf+suzoElzFrAhlvcO7JTzwsi0ChFR2VUbcaV4MNJ9ImpZxeyNGW5jvw/0an1A4Xw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438391; c=relaxed/simple;
	bh=qdqCTrTwE7F0UbgrHrLKLdsCJJzF1dW2tIAKNIo3B9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1GQUeAFiBVyfEthhqg7Xa/E3XofV2mlQMMWcoFVDM2Klt0hzk6X/Eej0qVpmwP+ssj70eomF2cANSPAQzWuyC3E5ofGkdpIXGpS8cB+6hKuOqy8qRds/TNaG/n6j1o8FDm1C6oniddNw89zgukNt+r34VVbv5zDM8pT4jhw2+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a+G184wC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m751wNoJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a+G184wC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m751wNoJ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A7110EC023A
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 11:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438388;
	 x=1783524788; bh=lNSy/+d5a3OswhfIq57tn9oOrYpZO5x2Oeiam2eCL7A=; b=
	a+G184wCxj9Ir86AO6g/9wlZyRmSoJ4v3ILuHlXAUkA4o1crAw0Wgtjl1pT2AxUi
	9CcquiOAmPDjKl8z6cKzihTL8r9J09XzfHGXLyUJogGshR/RlU7xBGdkW+9EI7HU
	R6ZTAgUcYMbg6V7mvqlRJgAJnPdj/ZCJhJ4dyBJy4omzu0MHblSaRlbQcMqefvjy
	vfl46K+gH9w0o/2pZjtzv9yg3faVDkziMb8HFBrfY1SwvU/jiD66ZVI9b39F8tKz
	gRxQhlcAH6hSHebL7b6HDE6f7J5r1E9ysOMy1SaLAvGOJNnOOnAmbh3BaisX0v0+
	TTP6NmXmiN0VoUmrNTXirg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438388; x=
	1783524788; bh=lNSy/+d5a3OswhfIq57tn9oOrYpZO5x2Oeiam2eCL7A=; b=m
	751wNoJRwSGi3VE2vFtqAVktCET67JUIpcyjUQ1sxTCBQlaNnJKFgRX1CcRIaz8+
	C0JDnGP9Ds3VkZ9uhjcPSuhNpMOu+odh6aaxRhx4NkVA9eRXS5ybeg1nxhR58w2i
	SZepqrzoHFPKa7yKTqUhH+6/1dVyM/gQ+pV28b5usEM/5NqKOaA789Lbrm0yV69B
	fjA+a+OvYzv15lNFoXKWXDJ+3M3bduDuTHi17M6I43CEiH3tHuI1IWhXiwqZ3M8O
	WkZoSA6aMWZn+kZs8a5Yr+3wG5SFrxt0VgeiY2U3G8el1i3tgR7PDV3e67sox/qJ
	/EQ2buzAfcoNxS3dfRBtg==
X-ME-Sender: <xms:NBxNalkccdJifTtQH1SiQ9O-JyGZGO-cbUfB2KksYOzrUswZp_zjAA>
    <xme:NBxNanwcTTAgmKbFCJ6Y4Le7mrju6XN5-swhviHKlvVXYpMqidEIV4Ffwg-wyl6VS
    WOop7vyrLN0Fuve7HtchA-l50uIkMCb4GA0UV8PNp66_21NX5uK>
X-ME-Received: <xmr:NBxNahT03h5GLdHRG3WofbAoY88GtQkixnoSK3G-d-cUHUQLyM8OsRmhSHDKPJHI69RA6tndTSz4qwXOzweAcHSUaWahtZ9LmfNJmrrREw>
X-ME-Proxy-Cause: dmFkZTFk2JGQwOYnChEFqdclV2ZJMxJ73ylXwyH7UIoWlhJPy4XEbpbFbKv69wxPMuN+s+
    8t41LiovFF0dl4ukvLwNim4o+toIpIHw2Gn02EUXlBLBTkfWkkBWHpO5HJ4aiovA1N2Piu
    0AnDX2OAb6nltR70lSkYugW/mOlZGiPu2gyV2v2h8qwE0Y8AZj23BK7mVoDWaomBEPmH49
    vnW2IyP4hLEj7sKeYINuaMDnCOfaTuIW1H+/pT4/Ummwe1xQrNTU3FefZzzz7Rg0uXiFNn
    DY9R3wyj7SfdPSYBfJ8El0+YSRdYz0F8Y4zufxRqZdQBksKZbG6Dp27t+YRaxpMWOuzyc/
    NTk6lmOUWC+mTSh5t10OuGc9P2xr/8eum2cJB1atxMOSRLk5hosmrcdZddUQPgt0rqTitm
    7J1d5sOC8D8Iu00qAOwYmWeAxvue5GJ9JxrpkcycYQzEGdTQTZPmtaM4qoHOmx+kdKMM5q
    uNcMPS0ebQc7yEUIOtWiDxfty6c5fWJLav0gFwFOEsZAk8bxXXdpp40FLB2uAnOp/BTxZ0
    FDVctrDd6vZuvhG/BbQNMhwnqCDjsQROblRnCAOf3B23aCO3Q3wE5DfevENi8KgqEPEEav
    n3RgmaXIV30mrMmG70ombQkX1je2Evx2HQPxZolSm8p8mwLEay9vsMEUYrBA
X-ME-Proxy: <xmx:NBxNaqtlHTdNEl33o44uE8HljeBEi0wuo2iADHC1KBknY3kleTfV_g>
    <xmx:NBxNajvhpIUxbTn9bcWBWVjfgRzsuUf7WO9ByLJbQ1QT9230PcAnfQ>
    <xmx:NBxNagzVnZcw5TkSEyAXdzLkGAQ60sEvJYlKg-c30Z0cvE8_9ptNPQ>
    <xmx:NBxNapiHqzmpZlfU4R0xtiWDTEyqDD-P-2eXiKIOq0TGeo0YzfQIpQ>
    <xmx:NBxNat11sszTfx3y8ZdMP1-tmIlhflggofKbnVb0avhRV2efBNoOIBKj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10434c3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:37 +0200
Subject: [PATCH 05/11] builtin/gc: inline config values specific to the
 "files" backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-5-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The `struct gc_config` contains a set of values that we read via the Git
repository's configuration. Several of those values that are consumed by
the object database optimization logic are inherently specific to the
"files" config.

In a later commit we'll make the logic to optimize object databases
pluggable. So by carrying these "files"-backend specific values in the
generic config struct means that other backends would have to worry
about these values, too. This feels somewhat dirty, as implementation-
specific details should live with the backends themselves.

Inline these values directly at the call sites that need them instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 115 +++++++++++++++++++++++++++--------------------------------
 1 file changed, 53 insertions(+), 62 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 25a59caea6..5d445edaa0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -130,22 +130,11 @@ struct gc_config {
 	unsigned long max_cruft_size;
 	int aggressive_depth;
 	int aggressive_window;
-	int gc_auto_threshold;
-	int gc_auto_pack_limit;
 	int detach_auto;
 	char *gc_log_expire;
 	char *prune_expire;
 	char *prune_worktrees_expire;
-	char *repack_filter;
-	char *repack_filter_to;
 	char *repack_expire_to;
-	unsigned long big_pack_threshold;
-	unsigned long max_delta_cache_size;
-	/*
-	 * Remove this member from gc_config once repo_settings is passed
-	 * through the callchain.
-	 */
-	size_t delta_base_cache_limit;
 };
 
 #define GC_CONFIG_INIT { \
@@ -154,14 +143,10 @@ struct gc_config {
 	.cruft_packs = 1, \
 	.aggressive_depth = 50, \
 	.aggressive_window = 250, \
-	.gc_auto_threshold = 6700, \
-	.gc_auto_pack_limit = 50, \
 	.detach_auto = 1, \
 	.gc_log_expire = xstrdup("1.day.ago"), \
 	.prune_expire = xstrdup("2.weeks.ago"), \
 	.prune_worktrees_expire = xstrdup("3.months.ago"), \
-	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
-	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 }
 
 static void gc_config_release(struct gc_config *cfg)
@@ -169,15 +154,12 @@ static void gc_config_release(struct gc_config *cfg)
 	free(cfg->gc_log_expire);
 	free(cfg->prune_expire);
 	free(cfg->prune_worktrees_expire);
-	free(cfg->repack_filter);
-	free(cfg->repack_filter_to);
 }
 
 static void gc_config(struct gc_config *cfg)
 {
 	const char *value;
 	char *owned = NULL;
-	unsigned long ulongval;
 
 	if (!repo_config_get_value(the_repository, "gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
@@ -192,8 +174,6 @@ static void gc_config(struct gc_config *cfg)
 
 	repo_config_get_int(the_repository, "gc.aggressivewindow", &cfg->aggressive_window);
 	repo_config_get_int(the_repository, "gc.aggressivedepth", &cfg->aggressive_depth);
-	repo_config_get_int(the_repository, "gc.auto", &cfg->gc_auto_threshold);
-	repo_config_get_int(the_repository, "gc.autopacklimit", &cfg->gc_auto_pack_limit);
 	repo_config_get_bool(the_repository, "gc.autodetach", &cfg->detach_auto);
 	repo_config_get_bool(the_repository, "gc.cruftpacks", &cfg->cruft_packs);
 	repo_config_get_ulong(the_repository, "gc.maxcruftsize", &cfg->max_cruft_size);
@@ -213,22 +193,6 @@ static void gc_config(struct gc_config *cfg)
 		cfg->gc_log_expire = owned;
 	}
 
-	repo_config_get_ulong(the_repository, "gc.bigpackthreshold", &cfg->big_pack_threshold);
-	repo_config_get_ulong(the_repository, "pack.deltacachesize", &cfg->max_delta_cache_size);
-
-	if (!repo_config_get_ulong(the_repository, "core.deltabasecachelimit", &ulongval))
-		cfg->delta_base_cache_limit = ulongval;
-
-	if (!repo_config_get_string(the_repository, "gc.repackfilter", &owned)) {
-		free(cfg->repack_filter);
-		cfg->repack_filter = owned;
-	}
-
-	if (!repo_config_get_string(the_repository, "gc.repackfilterto", &owned)) {
-		free(cfg->repack_filter_to);
-		cfg->repack_filter_to = owned;
-	}
-
 	repo_config(the_repository, git_default_config, NULL);
 }
 
@@ -504,12 +468,12 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	return base;
 }
 
-static int too_many_packs(struct gc_config *cfg)
+static int too_many_packs(int gc_auto_pack_limit)
 {
 	struct packed_git *p;
 	int cnt = 0;
 
-	if (cfg->gc_auto_pack_limit <= 0)
+	if (gc_auto_pack_limit <= 0)
 		return 0;
 
 	repo_for_each_pack(the_repository, p) {
@@ -523,7 +487,7 @@ static int too_many_packs(struct gc_config *cfg)
 		 */
 		cnt++;
 	}
-	return cfg->gc_auto_pack_limit < cnt;
+	return gc_auto_pack_limit < cnt;
 }
 
 static uint64_t total_ram(void)
@@ -571,9 +535,10 @@ static uint64_t total_ram(void)
 	return 0;
 }
 
-static uint64_t estimate_repack_memory(struct gc_config *cfg,
-				       struct packed_git *pack)
+static uint64_t estimate_repack_memory(struct packed_git *pack)
 {
+	unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
 	unsigned long nr_objects;
 	size_t os_cache, heap;
 
@@ -584,6 +549,9 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
 	if (!pack || !nr_objects)
 		return 0;
 
+	repo_config_get_ulong(the_repository, "pack.deltacachesize", &max_delta_cache_size);
+	repo_config_get_ulong(the_repository, "core.deltabasecachelimit", &delta_base_cache_limit);
+
 	/*
 	 * First we have to scan through at least one pack.
 	 * Assume enough room in OS file cache to keep the entire pack
@@ -611,9 +579,9 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
 	 * read_sha1_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
 	 */
-	heap += cfg->delta_base_cache_limit;
+	heap += delta_base_cache_limit;
 	/* and of course pack-objects has its own delta cache */
-	heap += cfg->max_delta_cache_size;
+	heap += max_delta_cache_size;
 
 	return os_cache + heap;
 }
@@ -629,6 +597,12 @@ static void add_repack_all_option(struct gc_config *cfg,
 				  struct string_list *keep_pack,
 				  struct strvec *args)
 {
+	char *repack_filter = NULL;
+	char *repack_filter_to = NULL;
+
+	repo_config_get_string(the_repository, "gc.repackfilter", &repack_filter);
+	repo_config_get_string(the_repository, "gc.repackfilterto", &repack_filter_to);
+
 	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
 		&& !(cfg->cruft_packs && cfg->repack_expire_to))
 		strvec_push(args, "-a");
@@ -650,10 +624,13 @@ static void add_repack_all_option(struct gc_config *cfg,
 	if (keep_pack)
 		for_each_string_list(keep_pack, keep_one_pack, args);
 
-	if (cfg->repack_filter && *cfg->repack_filter)
-		strvec_pushf(args, "--filter=%s", cfg->repack_filter);
-	if (cfg->repack_filter_to && *cfg->repack_filter_to)
-		strvec_pushf(args, "--filter-to=%s", cfg->repack_filter_to);
+	if (repack_filter && *repack_filter)
+		strvec_pushf(args, "--filter=%s", repack_filter);
+	if (repack_filter_to && *repack_filter_to)
+		strvec_pushf(args, "--filter-to=%s", repack_filter_to);
+
+	free(repack_filter);
+	free(repack_filter_to);
 }
 
 static void add_repack_incremental_option(struct strvec *args)
@@ -661,16 +638,24 @@ static void add_repack_incremental_option(struct strvec *args)
 	strvec_push(args, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(struct gc_config *cfg)
+static int need_to_gc(struct repository *repo)
 {
+	int gc_auto_threshold = 6700;
+	int gc_auto_pack_limit = 50;
+
+	repo_config_get_int(repo, "gc.auto", &gc_auto_threshold);
+	repo_config_get_int(repo, "gc.autopacklimit", &gc_auto_pack_limit);
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
 	 */
-	if (cfg->gc_auto_threshold <= 0)
+	if (gc_auto_threshold <= 0)
 		return 0;
-	if (!too_many_packs(cfg) && !too_many_loose_objects(cfg->gc_auto_threshold))
+	if (!too_many_packs(gc_auto_pack_limit) &&
+	    !too_many_loose_objects(gc_auto_threshold))
 		return 0;
+
 	return 1;
 }
 
@@ -807,8 +792,15 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 				int aggressive)
 {
 	struct child_process repack_cmd = CHILD_PROCESS_INIT;
+	unsigned long big_pack_threshold = 0;
+	int gc_auto_threshold = 6700;
+	int gc_auto_pack_limit = 50;
 	int ret;
 
+	repo_config_get_int(the_repository, "gc.auto", &gc_auto_threshold);
+	repo_config_get_int(the_repository, "gc.autopacklimit", &gc_auto_pack_limit);
+	repo_config_get_ulong(the_repository, "gc.bigpackthreshold", &big_pack_threshold);
+
 	if (the_repository->repository_format_precious_objects)
 		return 0;
 
@@ -843,19 +835,18 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 		if (keep_largest_pack != -1) {
 			if (keep_largest_pack)
 				find_base_packs(&keep_pack, 0);
-		} else if (cfg->big_pack_threshold) {
-			find_base_packs(&keep_pack, cfg->big_pack_threshold);
+		} else if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
 		}
 
 		add_repack_all_option(cfg, &keep_pack, &repack_cmd.args);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_packs(cfg)) {
+	} else if (too_many_packs(gc_auto_pack_limit)) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (cfg->big_pack_threshold) {
-			find_base_packs(&keep_pack, cfg->big_pack_threshold);
-			if (keep_pack.nr >= cfg->gc_auto_pack_limit) {
-				cfg->big_pack_threshold = 0;
+		if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
+			if (keep_pack.nr >= gc_auto_pack_limit) {
 				string_list_clear(&keep_pack, 0);
 				find_base_packs(&keep_pack, 0);
 			}
@@ -864,7 +855,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 			uint64_t mem_have, mem_want;
 
 			mem_have = total_ram();
-			mem_want = estimate_repack_memory(cfg, p);
+			mem_want = estimate_repack_memory(p);
 
 			/*
 			 * Only allow 1/2 of memory for pack-objects, leave
@@ -905,7 +896,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 		}
 	}
 
-	if (opts->auto_flag && too_many_loose_objects(cfg->gc_auto_threshold))
+	if (opts->auto_flag && too_many_loose_objects(gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
@@ -994,7 +985,7 @@ int cmd_gc(int argc,
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(&cfg) || run_hooks(the_repository, "pre-auto-gc")) {
+		if (!need_to_gc(the_repository) || run_hooks(the_repository, "pre-auto-gc")) {
 			ret = 0;
 			goto out;
 		}
@@ -1291,9 +1282,9 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
 	return run_command(&child);
 }
 
-static int gc_condition(struct gc_config *cfg)
+static int gc_condition(struct gc_config *cfg UNUSED)
 {
-	return need_to_gc(cfg);
+	return need_to_gc(the_repository);
 }
 
 static int prune_packed(struct maintenance_run_opts *opts)

-- 
2.55.0.141.g00534a21ce.dirty

