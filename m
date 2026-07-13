Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47C361DBF
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921956; cv=none; b=C/tmo4CWijZhOyFDt0qW1jtiBHF28IZnNVkmUhYJDR/jr4Xa4Aw4gM1JSYDGwv2nfstU7aRob8JKnqr9Lm4LBc1ZSviMe0/kbisKTLMfc7EiQ/2RA37qh/pBjO6Gy8gq09S3iaLVfOufe4Hnapu2rOY9vppUwxegyvHpuUgT2BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921956; c=relaxed/simple;
	bh=f5mOp8jr6z55iYMYT0h8/Zq+RcadazgkLCNHoJ41Lts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfvR+uY9an73FjOYi1D7fAKBh+9KsZD6jwt/Jp4uryDiqdzWFRKIv8wDwRtsotsqeNs0s6jzvt2FwJ9UV/BYNvNL+HQby/2O/J78dOjmy6AD55bQaf9Fd84EB1QpRx2P7KC1vbEty+BUpP1qrQLYC1bea6qVcGQDMYBKN5k0/EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgg+S0+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgHXygsN; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgg+S0+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgHXygsN"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B56071400060;
	Mon, 13 Jul 2026 01:52:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 01:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921953;
	 x=1784008353; bh=8Nd0SoCxLHGWFy+2kMbqhnBNS9yktPsrLBSq20j8e6Q=; b=
	fgg+S0+TTeYxUgiikmzv2h8EFz6VfaxECMk68OzQ+Rek+hWpYTcOKPeNifVAOzGl
	Ov+AArTmOvGJvKDt1h0iGqeveXGnm6Zdd5NlIJlXRJkYdHMAAFSeCJ9spcly7pD+
	nHfEBeYUaUmecDJAvXUSuBN6p+wEu1zJHywNMjct6HrHeDFJCajVuMnF+8ldlOV2
	xZy2DB5VpB1VXB5fk2a3/VxI+pohhK4bCM11irbCutE/N3/Z53ZpSw01qu702ju7
	Fpm1QkfHfBhdB9Zih8VPVfjG8d3eLUSDZQti6M/ZavF0zCKVkLPb0PwLZl6V8EPP
	FaLutq9NFd2HHXe4cjBuOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921953; x=
	1784008353; bh=8Nd0SoCxLHGWFy+2kMbqhnBNS9yktPsrLBSq20j8e6Q=; b=H
	gHXygsNl3T4/z+5FvO8b2waoB4ofxcLe6kopBuz4eD6hJ0t9gJNqIIbMOTANT54L
	QMgQUOAxeFajpGH1rG77Ny9Wqcd7TFclqGeTXKou52U3b8YeaFTwWUhSoyhEH2B6
	lip2rq1lu2ZfqhKWnEPjfNOKkPtwxisFd4QYtF18sJbanxysBaHX4osQpQp6A/ZH
	U3V3Ny2z1XbXfdd0w+d4MHyT0GppNT3HVo72HLt2RdhSUr4uwWdk3wtcfETqDtnm
	zxzUIDbpxbZD01ZLpe2dDaUl06x9Hi3PvIu98w8AnJZ8N9HUT1TjClJBbX3UuQTK
	qfoKOtnaF96x1ME4CUCeA==
X-ME-Sender: <xms:IX1UaovxtSShvBYOTHP3M3WdRTBd5sMtWDQchaeY_N7d4SaiXvr_8Q>
    <xme:IX1UardZMiclXHqTPBZda-TDQCtqN7feR6UoYGxD8buabGJPHyR8xxKO1Ff9FchBd
    P4rKjEZqsA434omkfIviEUFjIiXfARnZs1VyuO8D2b113J76hMRSA>
X-ME-Received: <xmr:IX1UahaTB4ig8vlD6e_42GDaVUhWB_vBH6Ypzp08LZ0UpENzugsJDKLCLmOPvc-MTyqZytzhrsWZ5AwaAMM1W9tLZkD2BHFv6geVHH6V>
X-ME-Proxy-Cause: dmFkZTFIUDY26jRG21zJjIfGPrl8ENW9/+ypYCPCvFU4QHtOfI7UPub9FlJD34Vs3MaRzO
    h5/c3T8KOTl1Xbj91ua5LE7BfX1rBRJPkwEkX+/9uhvqAn2l7TudJc86Atx/hIF9IaaKGJ
    NjtSuT7dLkw5AGaHKSocwZSlFgzjCetRhHG8DyIGIW7riGN0pUe3my1kpZEAmrGpRZ3naY
    fORDegOxYt8ZyHLuECcutn04mkRgNUblCZOFp6ymK6fcUDKt7PFEbvUThW3ulelCTdfYfm
    TUOL+6hwmiSGLCra1DYOiz0Unrb9wzTVAX8acy8UebX45tscALMqp8/pMz7uaMgSVC8JDc
    q0P85nrRVDvI/gzMnkqKP6YGQfWk6uK2gvKphZGtT18gVE3zMwg1OCxw+gF7n4CKGnEacj
    RFkg5034ikIy6/JPXPvBdArbNZkTaWkX2WiO5zIeh+ccbBbaS4q+t5f3A4/YZ982MKbYjk
    3WHFQryfg8jIFiiwd10nsm+7tMljNT5Hq2Zb6Jliocr1uPXXzs/NnusPbdr3ZWBrVqqMiq
    huNa/E7NXLq1VMxE8Rt881bpSSpF9aThflidFwlr7EVi+/VT2GURew+DXFi4GoOxjv2MIX
    5EfsqOYxLVIMYTk3pcOrLW1mJCToUp78aXjtc6AvvLpeqNHj0ZVTj7TRfmqQ
X-ME-Proxy: <xmx:IX1UamWtgY0gDQMySnePICmcDR-JRL1rYkCzOzp5D7XGMTUl01EUEA>
    <xmx:IX1UargP4hpe8vyhEOrOLCJ8VpaO69MuRDETKRY8a9m0d59do-JmfQ>
    <xmx:IX1UasXslzdcs1vYukxmJ3Zj00tpBPVUvAE_NH3ZxIyQT4mM9yGuKw>
    <xmx:IX1UaqOAmSG6OIcnyVo6InyYEc6C66gYOoMfFsZLtdURnOMaUkHNBQ>
    <xmx:IX1UakGhkah9GCtEcsJ8qwlRdJ1PVvaPGnx67VwzmHhqx4B96ymYqYnc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 31e3f98d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:10 +0200
Subject: [PATCH v2 07/12] builtin/gc: introduce object database
 optimization options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-7-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

