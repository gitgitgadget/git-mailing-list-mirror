Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF454302E1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438392; cv=none; b=Pa85AL2Ttsd9T2L1PMjQmAAIiDZ5oIFJdMhhWFUDjJsAFh4giqWljyW1VPVxt0WGQyqq83Vxq+NLlYhyNYXcY4ieo6Qhp//YFauAm5MNFsiLDyyPVBN5bM4FEFXvnzGH0P/3fIKoGPl6xfr4QvPKYufw6fVucrquWkieSBYpkuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438392; c=relaxed/simple;
	bh=kTWBfs6qSixPgb3mI0OIuwToPV10Iy1P8U0KT2n+wTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HMukWD4tnlJl9bSgYPylufNQ2EiWgpJNtijfgIu4L8DfF6dwUMwoHAhikQ203YV6qHXaQH12l+/NTewBNUFVfbMcAoRaK4CW4RLPZv9t7rQutWtvhjZ8oD0vwFeG7E/TQyr7i+17Omok+vIE1ZP5uYlpEIw09mBdPAqBu8VqSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dvwfpDbc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F5MZNEDZ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dvwfpDbc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5MZNEDZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 674E1EC023B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 11:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438390;
	 x=1783524790; bh=HoSjhlTPxAbxhqS5wYvy3rdL1UJyMBEs2xWOipCvRw8=; b=
	dvwfpDbcdBMFX/muhEKIHw5aP7sw+UbyhsTrBpItBBnB4Uy6gXawUMIsrQaIg/YH
	3cg1PDxMqrCgSjguv0IuEZGkF0bL7BUx9GiQow1Jr9zN5YxiRU44LumBHqxbL3jK
	7vMPJNyVbaYHyssmCoGZ2FURUd46SoOa8GpjXJVRotVpa2+JYkbMiZ5O4XfCcY6m
	3EE3RbiNF39JjMIOPEkG0+2wwtCyuVdfbNRekSZO/sC4iHKFtiALYvtksnVblowd
	ZrRTv1+meLjN5+yZuRSa2yv8cPsv/O6khniCmhHaB2NDSBEawyE5+4iR9ZWwaVHz
	YFlwPZvI8+lLkllYgTuQug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438390; x=
	1783524790; bh=HoSjhlTPxAbxhqS5wYvy3rdL1UJyMBEs2xWOipCvRw8=; b=F
	5MZNEDZ4YskYc+6SUjHo9W8PQyyruLDUJlIvl1y5JNcMxauc2EBow6uHNzObiBuh
	T7rm2Xnma4O4awA4i0pmhlJQz4eeZmD5vNNkfUE1C4WpHsAK+AW532zrr/Svruor
	OfwybAkfUhLUIpfxGqCIEI7lvFDtnhQ3xSUfXOq5WtsgVR5OJ4Wkq5uE7/Guq77J
	cmEgr127fmu5hXHN+vL8LRLFGCuBQy4QUQaVxt+BaNWYGRMzdQv45o3jo7h1e20e
	HiisY+yKCOnSScFdPIhSsS3KhWWhkS0p3dddWFrgcHzYsh2Al4aq+WMfQgSJdhdC
	+SQkgPmeff5qpljUrVM9w==
X-ME-Sender: <xms:NhxNavQeIF8ei-nUWZ1Yv1_rU-odYBrcP4MQ7Z9we0ICMqZWdvur7g>
    <xme:NhxNant6DCQLHoTLpDrALh4HkffUA8Wr6urNxvtylhwsX0dMucdoJNdhMKuI_ib4U
    -HbKBLSkQVMuQqR0dbqNR_1x1CS9mInQwz3O2hcm0vyDQ7Py_Cs>
X-ME-Received: <xmr:NhxNaqcT4Z6r7GBwgEkqpztTrwgLp9441b2P1rIIqLfm80i4ruPoeMKWRyCkRaYgonCatKq1CNw67iBQFZRoZmkV6V8QpZeH7bsfpc2Oig>
X-ME-Proxy-Cause: dmFkZTFk/euIDQWZpR+rFOCPq0Fejhawz+YZngliUmhxCKKHLnEBBPkpNC0E9CeKnn7IBw
    PU544u7Jlpxah01Um8RcYp+UmlPquDFW2wwWiV9G7gATnOgj34dqgTk6at5vd1UVUzGS37
    FiIPEJwJOgEmPtZkVh8XNZY2bC+SC9rfBO5ZgVSzrBk38zO4CKJYaxS3NB+LrtEnfibGY3
    KtRwVKcY3lGpxNtff3MzS2XolCurYNMW2gQ3Xgm+PKX8RbCNB4BLvPGjIHpSm3k1WGr9Ze
    gGJGxhSm+WEexuMkB4OmGCxLj4OlouF4I5Y/XdeEyjXGxb1X7YX7FvvZEpeGA8yKxuaJDO
    K1mgric2+ikOCGLNLcLZLMpDqmDX49E6xPQiUPkOs8JP+OqeD2p1mmb5IL0sGM4dcK9cwM
    Fwqz9UR+QggRnMiTMsCwTx9WcfYkgPhf1UhhR4mcsxaTC1vl0tBNHprC5XYwrRqb7vrJQe
    g7gZcqp8UNVi75t/lvptpZj7fVtjEJFy7ZiAor0TGGccvead6NzMt2i93U8leaEoxVcI8N
    /TGQ64Fvt+AnLOviXbvjirjbG0bh3tufGg/GGptgZsitshjfxxvF6vmJjIYT6Od2Ti2IJ3
    sBacrDt1wD4A8FQz5UJso6+qrBbyxz6YCpKJw2J+e7UdmVJwNCOd8nvdnkIQ
X-ME-Proxy: <xmx:NhxNakLp5jWFfZ6dWNFAIVBxzaoesXxXkNaGcxhgG2JbVUTZGi01pQ>
    <xmx:NhxNaoaS307Z1hh8c-2mBdI1gp3awES_qGW-O45yH4_QnjEYNZay8g>
    <xmx:NhxNavuzCHz1zioa8OD_-6Uplu9Zopo6HsP2gBs38Kpvl3V3rwDcfA>
    <xmx:NhxNalsty0Ww0b5qf9VlaFH-snTsKSqNUETFjuJQ86EppI7yrevr7A>
    <xmx:NhxNajQNUFHuSWtT0n8PghTagUdYLAwsk81qylPBK9U9tmovBQmOcpdX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fde4be1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:38 +0200
Subject: [PATCH 06/11] builtin/gc: introduce object database optimization
 options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-6-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Introduce `struct odb_optimize_options` to decouple the options that are
specific to optimizing the object database from `struct gc_config`. This
structure will be moved into the object database layer in a subsequent
commit.

Note that there are a small set of backend-specific options in this
structure. In an ideal world those of course wouldn't exist, but as
we're introducing the object database abstractions retroactively we are
somewhat forced to keep them.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 181 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 120 insertions(+), 61 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5d445edaa0..17490106fc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -593,7 +593,39 @@ static int keep_one_pack(struct string_list_item *item, void *data)
 	return 0;
 }
 
-static void add_repack_all_option(struct gc_config *cfg,
+enum odb_optimize_flags {
+	/* Enable verbose logging and progress reporting. */
+	ODB_OPTIMIZE_VERBOSE = (1 << 0),
+
+	/* Perform auto-maintenance, only optimizing objects as required. */
+	ODB_OPTIMIZE_AUTO = (1 << 1),
+
+	/* Recompute existing deltas. */
+	ODB_OPTIMIZE_NO_REUSE_DELTAS = (1 << 2),
+};
+
+struct odb_optimize_options {
+	enum odb_optimize_flags flags;
+	const char *prune_expire;
+	const char *expire_to;
+	int depth;
+	int window;
+
+	/* Backend-specific options. */
+	int keep_largest_pack;
+	int cruft_packs;
+	unsigned long max_cruft_size;
+};
+
+#define OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive) \
+	.prune_expire = (cfg)->prune_expire, \
+	.expire_to = (cfg)->repack_expire_to, \
+	.cruft_packs = (cfg)->cruft_packs, \
+	.max_cruft_size = (cfg)->max_cruft_size, \
+	.window = (aggressive) ? (cfg)->aggressive_window : 0, \
+	.depth = (aggressive) ? (cfg)->aggressive_depth : 0
+
+static void add_repack_all_option(const struct odb_optimize_options *opts,
 				  struct string_list *keep_pack,
 				  struct strvec *args)
 {
@@ -603,22 +635,22 @@ static void add_repack_all_option(struct gc_config *cfg,
 	repo_config_get_string(the_repository, "gc.repackfilter", &repack_filter);
 	repo_config_get_string(the_repository, "gc.repackfilterto", &repack_filter_to);
 
-	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
-		&& !(cfg->cruft_packs && cfg->repack_expire_to))
+	if (opts->prune_expire && !strcmp(opts->prune_expire, "now") &&
+	    !(opts->cruft_packs && opts->expire_to))
 		strvec_push(args, "-a");
-	else if (cfg->cruft_packs) {
+	else if (opts->cruft_packs) {
 		strvec_push(args, "--cruft");
-		if (cfg->prune_expire)
-			strvec_pushf(args, "--cruft-expiration=%s", cfg->prune_expire);
-		if (cfg->max_cruft_size)
+		if (opts->prune_expire)
+			strvec_pushf(args, "--cruft-expiration=%s", opts->prune_expire);
+		if (opts->max_cruft_size)
 			strvec_pushf(args, "--max-cruft-size=%lu",
-				     cfg->max_cruft_size);
-		if (cfg->repack_expire_to)
-			strvec_pushf(args, "--expire-to=%s", cfg->repack_expire_to);
+				     opts->max_cruft_size);
+		if (opts->expire_to)
+			strvec_pushf(args, "--expire-to=%s", opts->expire_to);
 	} else {
 		strvec_push(args, "-A");
-		if (cfg->prune_expire)
-			strvec_pushf(args, "--unpack-unreachable=%s", cfg->prune_expire);
+		if (opts->prune_expire)
+			strvec_pushf(args, "--unpack-unreachable=%s", opts->prune_expire);
 	}
 
 	if (keep_pack)
@@ -786,10 +818,8 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
 	return 0;
 }
 
-static int maintenance_task_odb(struct maintenance_run_opts *opts,
-				struct gc_config *cfg,
-				int keep_largest_pack,
-				int aggressive)
+static int odb_optimize(struct object_database *odb,
+			const struct odb_optimize_options *opts)
 {
 	struct child_process repack_cmd = CHILD_PROCESS_INIT;
 	unsigned long big_pack_threshold = 0;
@@ -801,21 +831,20 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 	repo_config_get_int(the_repository, "gc.autopacklimit", &gc_auto_pack_limit);
 	repo_config_get_ulong(the_repository, "gc.bigpackthreshold", &big_pack_threshold);
 
-	if (the_repository->repository_format_precious_objects)
+	if (odb->repo->repository_format_precious_objects)
 		return 0;
 
 	repack_cmd.git_cmd = 1;
 	repack_cmd.odb_to_close = the_repository->objects;
 
 	strvec_pushl(&repack_cmd.args, "repack", "-d", "-l", NULL);
-	if (aggressive) {
+	if (opts->flags & ODB_OPTIMIZE_NO_REUSE_DELTAS)
 		strvec_push(&repack_cmd.args, "-f");
-		if (cfg->aggressive_depth > 0)
-			strvec_pushf(&repack_cmd.args, "--depth=%d", cfg->aggressive_depth);
-		if (cfg->aggressive_window > 0)
-			strvec_pushf(&repack_cmd.args, "--window=%d", cfg->aggressive_window);
-	}
-	if (opts->quiet)
+	if (opts->depth > 0)
+		strvec_pushf(&repack_cmd.args, "--depth=%d", opts->depth);
+	if (opts->window > 0)
+		strvec_pushf(&repack_cmd.args, "--window=%d", opts->window);
+	if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
 		strvec_push(&repack_cmd.args, "-q");
 
 	/*
@@ -829,47 +858,49 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 	 *
 	 *   - Otherwise we perform an incremental repack.
 	 */
-	if (!opts->auto_flag) {
+	if (!(opts->flags & ODB_OPTIMIZE_AUTO)) {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (keep_largest_pack != -1) {
-			if (keep_largest_pack)
+		if (opts->keep_largest_pack != -1) {
+			if (opts->keep_largest_pack)
 				find_base_packs(&keep_pack, 0);
 		} else if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
 		}
 
-		add_repack_all_option(cfg, &keep_pack, &repack_cmd.args);
+		add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
 		string_list_clear(&keep_pack, 0);
-	} else if (too_many_packs(gc_auto_pack_limit)) {
-		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-		if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
-			if (keep_pack.nr >= gc_auto_pack_limit) {
-				string_list_clear(&keep_pack, 0);
-				find_base_packs(&keep_pack, 0);
+	} else {
+		if (too_many_packs(gc_auto_pack_limit)) {
+			struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+			if (big_pack_threshold) {
+				find_base_packs(&keep_pack, big_pack_threshold);
+				if (keep_pack.nr >= gc_auto_pack_limit) {
+					string_list_clear(&keep_pack, 0);
+					find_base_packs(&keep_pack, 0);
+				}
+			} else {
+				struct packed_git *p = find_base_packs(&keep_pack, 0);
+				uint64_t mem_have, mem_want;
+
+				mem_have = total_ram();
+				mem_want = estimate_repack_memory(p);
+
+				/*
+				 * Only allow 1/2 of memory for pack-objects, leave
+				 * the rest for the OS and other processes in the
+				 * system.
+				 */
+				if (!mem_have || mem_want < mem_have / 2)
+					string_list_clear(&keep_pack, 0);
 			}
-		} else {
-			struct packed_git *p = find_base_packs(&keep_pack, 0);
-			uint64_t mem_have, mem_want;
-
-			mem_have = total_ram();
-			mem_want = estimate_repack_memory(p);
 
-			/*
-			 * Only allow 1/2 of memory for pack-objects, leave
-			 * the rest for the OS and other processes in the
-			 * system.
-			 */
-			if (!mem_have || mem_want < mem_have / 2)
-				string_list_clear(&keep_pack, 0);
+			add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
+			string_list_clear(&keep_pack, 0);
+		} else {
+			add_repack_incremental_option(&repack_cmd.args);
 		}
-
-		add_repack_all_option(cfg, &keep_pack, &repack_cmd.args);
-		string_list_clear(&keep_pack, 0);
-	} else {
-		add_repack_incremental_option(&repack_cmd.args);
 	}
 
 	if (run_command(&repack_cmd)) {
@@ -877,13 +908,13 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 		goto out;
 	}
 
-	if (cfg->prune_expire) {
+	if (opts->prune_expire) {
 		struct child_process prune_cmd = CHILD_PROCESS_INIT;
 
 		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
 		/* run `git prune` even if using cruft packs */
-		strvec_push(&prune_cmd.args, cfg->prune_expire);
-		if (opts->quiet)
+		strvec_push(&prune_cmd.args, opts->prune_expire);
+		if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
 			strvec_push(&prune_cmd.args, "--no-progress");
 		if (repo_has_promisor_remote(the_repository))
 			strvec_push(&prune_cmd.args,
@@ -896,7 +927,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 		}
 	}
 
-	if (opts->auto_flag && too_many_loose_objects(gc_auto_threshold))
+	if (opts->flags & ODB_OPTIMIZE_AUTO && too_many_loose_objects(gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
@@ -906,6 +937,26 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 	return ret;
 }
 
+static int maintenance_task_odb(struct maintenance_run_opts *opts,
+				struct gc_config *cfg,
+				int keep_largest_pack,
+				int aggressive)
+{
+	struct odb_optimize_options odb_opts = {
+		.keep_largest_pack = keep_largest_pack,
+		OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive),
+	};
+
+	if (opts->auto_flag)
+		odb_opts.flags |= ODB_OPTIMIZE_AUTO;
+	if (!opts->quiet)
+		odb_opts.flags |= ODB_OPTIMIZE_VERBOSE;
+	if (aggressive)
+		odb_opts.flags |= ODB_OPTIMIZE_NO_REUSE_DELTAS;
+
+	return odb_optimize(the_repository->objects, &odb_opts);
+}
+
 int cmd_gc(int argc,
 	   const char **argv,
 	   const char *prefix,
@@ -1596,11 +1647,19 @@ static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 	child.odb_to_close = the_repository->objects;
 
 	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
-	if (geometry.split < geometry.pack_nr)
+	if (geometry.split < geometry.pack_nr) {
 		strvec_pushf(&child.args, "--geometric=%d",
 			     geometry.split_factor);
-	else
-		add_repack_all_option(cfg, NULL, &child.args);
+	} else {
+		struct odb_optimize_options odb_opts = {
+			OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, 0),
+		};
+
+		if (!opts->quiet)
+			odb_opts.flags |= ODB_OPTIMIZE_VERBOSE;
+
+		add_repack_all_option(&odb_opts, NULL, &child.args);
+	}
 	if (opts->quiet)
 		strvec_push(&child.args, "--quiet");
 	if (the_repository->settings.core_multi_pack_index)

-- 
2.55.0.141.g00534a21ce.dirty

