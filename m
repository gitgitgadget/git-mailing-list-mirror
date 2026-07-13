Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B27F362153
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921950; cv=none; b=iAi6yZdZTz/pgPoGPw+ftPW2fY8YHD0EMXGQljvf6PQRuEObG9N0M/P3fmyj0WrXkJ5hukAon4K9jyjI4ehnOS+EHOR9m7yF5E/biQYXBm8wDPqUApScyD9KHCWv2TBjKf/aSxbuQnEgqSC2KZa3q04SliQRklIypARYPf60XNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921950; c=relaxed/simple;
	bh=aSjZaH9FKx/C3PCGjn6KcMhXg2EVoUfrntG4Wtv7Bqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FenFLXdp6sZQNrT0KA2OOFjBhCykgK40UPvvlaQbfA7qTZh0uO4Q0YluKfOECNc4+ebxXYEUUdENWEUqAOhF59iS7DxOPMNSGAuJ4s01DLFuhKH+jqu4DGEKPoUrEJ831yS2nPGinvgz7R+wOyo1kqyCsOmK8ddA1dDv173jiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gArI0OmC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KNHZY3t6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gArI0OmC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KNHZY3t6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F1971400071;
	Mon, 13 Jul 2026 01:52:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921948;
	 x=1784008348; bh=8rMtpfCwYDqpYu6t4pCq3fVWFkUhIpg3jIF7YrzdxwA=; b=
	gArI0OmC8hqlt58iEFvKUbjHxcMP3ky54ewOUrcia3h/KUSy/I/XnQzKPtCEzjat
	e6pL2/A8HdoBTr29ZAPUqRIArrfVzIaD/CtYZUZIPS9LGuWDktBsK56kK9dqQnGq
	Td00IZ+0ilfhaELhmiVm8kMYymvNBvqfC/ByheoPNeLqOQKeufB50/aPbYLsATYH
	pj0dMLwdsVK56hbVrW08PT9xIMdu1fFI29qLRAFmezcBhb8VkdovI0pB5I9JR00O
	kcZd5B4TK26Qfybi+GM+NATc1ougUR7/1PTAj/tHxTLR1Wo0SvVOlRqKOpqjHnpZ
	9S4mcpVoNDnKZt88ITm2IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921948; x=
	1784008348; bh=8rMtpfCwYDqpYu6t4pCq3fVWFkUhIpg3jIF7YrzdxwA=; b=K
	NHZY3t6v6dbQGIaj4uolJaRB00Kul6cdRYSn0C8S0VwKj3RxzCA52Dvv2z2EiEnV
	b8+0ggsxAQxNC9q/ErI+udv1rUZsbODvz5A3iF7OhqunJr2KRNwtyDBzprd7HFQb
	GjexmM7g/sLP3PvY2W/D849XM6hWiLPa4EAkMFq1VgWPZ+9VHVrNziHAYXJWDyKd
	7RzxC+3KQwi2eSa3ZRf/Fh2rj5DNb3Fyp78J/3++3fmi9fzrdhxncLGLKgOs8SKA
	iFU2s+W47W3iOlAvO9QhoOWN87/cxAYuI/+AciQcGMpNGMhL38VyXLkD25tcPito
	L1kikxyNiHTHNnAk+dsmw==
X-ME-Sender: <xms:G31UagP5YDRomyjQGfZkQAFaX6BV6JMEkPV5c1AIL1GNqste3uSn-g>
    <xme:G31Uas9XWm5m4ddyIwuR8POPvMPhTxU68PYLuh7qTlGQlCZYwuytI9DUKVUr4yOUF
    RUqb1JmFyYAkCrzq65hL0B9j7pWGCCpRvZ9gPJTrIC0aEWnMh4oVg>
X-ME-Received: <xmr:G31Uak5TeNB22MZJXRerjto4hTOsgdoz27q_VjJ3CLP2aeKnjLpi_FFc0Vr3epdVAH1eyJN3kNwqTXhM4-8s3AO6xxyDXvRargji1d_C>
X-ME-Proxy-Cause: dmFkZTE2DwhiZeVd7s4BnOPVbBPXP1kZFTu6+TvJ2QfwCaPIfyeEJyQFod28bhJlHOLJFP
    nAxQLb9PyOO9WVRa0i1G4bQ7dN8ngY1INL+0iXLC5+UJ0NuVeK2EeEXubgho5kIiQKgwPD
    JabziqXomO03uQOEO12TgFiGlVlkIpLppS8snC/PmmXtFgM/sab6L7D5RPZS6GbJ1No3/6
    buMEU3X2Y9352yqKjFjBzD1THQoyUyJS+xnXCQzTukbErdh0mTxzV0KhTGfuuFWgqPqU6c
    0XJGk/CB1ffydb4y2My9Bbz//9Ylvn5KE8OIP3L7iVlloga1alcLHwg7BNDbyp1ynMoOUi
    mREVnVZLePNlf1FR/p8od2Yk+CFDzRb7G/HO6E7PxYF0Fpw/BN+FtQ3yc+9+hSHgRzQcu5
    h4TB+/87wlPysJa3HR5ikJLEQaqK1A68smQNMpDD/iX3p1ee7zqgtPbaEsbjOXLzhL72T6
    R0HyXkbA+Ixag7VwM7iEKywVlW4HF0Xz4bSroHsO4linO8Qj7omlPUiyD5fsyTapswhwZ7
    Ws80gNG0/KGzEjSvoa7BleHtRlTDJJuGOSydZCJUS9991108e6cQq9+R2MR6iseNCQ7JTG
    I2qAQi6R58lxH6d84kU3/beGNWsNhCiAvQ1kjoF3upDP/sLZOV/rnrIisRgQ
X-ME-Proxy: <xmx:G31Uaj3V1XUmtBIZFU71J-o5b4QFtzuiSw2RpZUMa1ymL5frNr-2Jw>
    <xmx:HH1UarAWo62u7BNcvof2TGOchrlAfmQXAveMy_pmFGfRjrPDCb7xhA>
    <xmx:HH1Ual20qpxtTIe06hSGIThqfwuNWexojZ48E4L2QChvczqJQtZl9g>
    <xmx:HH1UalsMC9pZYtt0M-mw8IJGeUy7DhdNBbSywokmE06aFUuv-7hwlA>
    <xmx:HH1UarnEbYRK0TTnRLVwo2ZTwscdv3uIGObCNr_rybNS_Pw8oazslQtb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3a52a5c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:08 +0200
Subject: [PATCH v2 05/12] builtin/gc: make repack arguments self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-5-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

When optimizing the object database most of the heavy-lifting is done by
git-repack(1). The arguments we pass to this function are assembled in
global scope, which is hard to follow.

Refactor the logic by moving the vector into `maintenance_task_odb()`.
While that means we have to pass more arguments to this function, it has
the upside that the logic becomes self-contained without any kind of
global interdependencies.

This is a pure refactoring with no intended functional change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 156 ++++++++++++++++++++++++++++-------------------------------
 1 file changed, 75 insertions(+), 81 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2ff98fa727..25a59caea6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -661,7 +661,7 @@ static void add_repack_incremental_option(struct strvec *args)
 	strvec_push(args, "--no-write-bitmap-index");
 }
 
-static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
+static int need_to_gc(struct gc_config *cfg)
 {
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
@@ -669,46 +669,8 @@ static int need_to_gc(struct gc_config *cfg, struct strvec *repack_args)
 	 */
 	if (cfg->gc_auto_threshold <= 0)
 		return 0;
-
-	/*
-	 * If there are too many loose objects, but not too many
-	 * packs, we run "repack -d -l".  If there are too many packs,
-	 * we run "repack -A -d -l".  Otherwise we tell the caller
-	 * there is no need.
-	 */
-	if (too_many_packs(cfg)) {
-		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-		if (cfg->big_pack_threshold) {
-			find_base_packs(&keep_pack, cfg->big_pack_threshold);
-			if (keep_pack.nr >= cfg->gc_auto_pack_limit) {
-				cfg->big_pack_threshold = 0;
-				string_list_clear(&keep_pack, 0);
-				find_base_packs(&keep_pack, 0);
-			}
-		} else {
-			struct packed_git *p = find_base_packs(&keep_pack, 0);
-			uint64_t mem_have, mem_want;
-
-			mem_have = total_ram();
-			mem_want = estimate_repack_memory(cfg, p);
-
-			/*
-			 * Only allow 1/2 of memory for pack-objects, leave
-			 * the rest for the OS and other processes in the
-			 * system.
-			 */
-			if (!mem_have || mem_want < mem_have / 2)
-				string_list_clear(&keep_pack, 0);
-		}
-
-		add_repack_all_option(cfg, &keep_pack, repack_args);
-		string_list_clear(&keep_pack, 0);
-	} else if (too_many_loose_objects(cfg->gc_auto_threshold))
-		add_repack_incremental_option(repack_args);
-	else
+	if (!too_many_packs(cfg) && !too_many_loose_objects(cfg->gc_auto_threshold))
 		return 0;
-
 	return 1;
 }
 
@@ -841,7 +803,8 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
 
 static int maintenance_task_odb(struct maintenance_run_opts *opts,
 				struct gc_config *cfg,
-				struct strvec *repack_args)
+				int keep_largest_pack,
+				int aggressive)
 {
 	struct child_process repack_cmd = CHILD_PROCESS_INIT;
 	int ret;
@@ -851,9 +814,75 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 
 	repack_cmd.git_cmd = 1;
 	repack_cmd.odb_to_close = the_repository->objects;
-	strvec_pushv(&repack_cmd.args, repack_args->v);
+
+	strvec_pushl(&repack_cmd.args, "repack", "-d", "-l", NULL);
+	if (aggressive) {
+		strvec_push(&repack_cmd.args, "-f");
+		if (cfg->aggressive_depth > 0)
+			strvec_pushf(&repack_cmd.args, "--depth=%d", cfg->aggressive_depth);
+		if (cfg->aggressive_window > 0)
+			strvec_pushf(&repack_cmd.args, "--window=%d", cfg->aggressive_window);
+	}
+	if (opts->quiet)
+		strvec_push(&repack_cmd.args, "-q");
+
+	/*
+	 * There's three cases we need to consider:
+	 *
+	 *   - If we're invoked without `--auto` we'll need to perform a full
+	 *     repack.
+	 *
+	 *   - If we're invoked with `--auto` and there's too many packs, then
+	 *     we perform a full repack, as well.
+	 *
+	 *   - Otherwise we perform an incremental repack.
+	 */
+	if (!opts->auto_flag) {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (keep_largest_pack != -1) {
+			if (keep_largest_pack)
+				find_base_packs(&keep_pack, 0);
+		} else if (cfg->big_pack_threshold) {
+			find_base_packs(&keep_pack, cfg->big_pack_threshold);
+		}
+
+		add_repack_all_option(cfg, &keep_pack, &repack_cmd.args);
+		string_list_clear(&keep_pack, 0);
+	} else if (too_many_packs(cfg)) {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (cfg->big_pack_threshold) {
+			find_base_packs(&keep_pack, cfg->big_pack_threshold);
+			if (keep_pack.nr >= cfg->gc_auto_pack_limit) {
+				cfg->big_pack_threshold = 0;
+				string_list_clear(&keep_pack, 0);
+				find_base_packs(&keep_pack, 0);
+			}
+		} else {
+			struct packed_git *p = find_base_packs(&keep_pack, 0);
+			uint64_t mem_have, mem_want;
+
+			mem_have = total_ram();
+			mem_want = estimate_repack_memory(cfg, p);
+
+			/*
+			 * Only allow 1/2 of memory for pack-objects, leave
+			 * the rest for the OS and other processes in the
+			 * system.
+			 */
+			if (!mem_have || mem_want < mem_have / 2)
+				string_list_clear(&keep_pack, 0);
+		}
+
+		add_repack_all_option(cfg, &keep_pack, &repack_cmd.args);
+		string_list_clear(&keep_pack, 0);
+	} else {
+		add_repack_incremental_option(&repack_cmd.args);
+	}
+
 	if (run_command(&repack_cmd)) {
-		ret = error(FAILED_RUN, repack_args->v[0]);
+		ret = error(FAILED_RUN, repack_cmd.args.v[0]);
 		goto out;
 	}
 
@@ -899,7 +928,6 @@ int cmd_gc(int argc,
 	int keep_largest_pack = -1;
 	int skip_foreground_tasks = 0;
 	timestamp_t dummy;
-	struct strvec repack_args = STRVEC_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -939,8 +967,6 @@ int cmd_gc(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 builtin_gc_usage, builtin_gc_options);
 
-	strvec_pushl(&repack_args, "repack", "-d", "-l", NULL);
-
 	gc_config(&cfg);
 
 	if (parse_expiry_date(cfg.gc_log_expire, &gc_log_expire_time))
@@ -961,16 +987,6 @@ int cmd_gc(int argc,
 	if (cfg.prune_expire && parse_expiry_date(cfg.prune_expire, &dummy))
 		die(_("failed to parse prune expiry value %s"), cfg.prune_expire);
 
-	if (aggressive) {
-		strvec_push(&repack_args, "-f");
-		if (cfg.aggressive_depth > 0)
-			strvec_pushf(&repack_args, "--depth=%d", cfg.aggressive_depth);
-		if (cfg.aggressive_window > 0)
-			strvec_pushf(&repack_args, "--window=%d", cfg.aggressive_window);
-	}
-	if (opts.quiet)
-		strvec_push(&repack_args, "-q");
-
 	if (opts.auto_flag) {
 		if (cfg.detach_auto && opts.detach < 0)
 			opts.detach = 1;
@@ -978,8 +994,7 @@ int cmd_gc(int argc,
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		if (!need_to_gc(&cfg, &repack_args) ||
-		    run_hooks(the_repository, "pre-auto-gc")) {
+		if (!need_to_gc(&cfg) || run_hooks(the_repository, "pre-auto-gc")) {
 			ret = 0;
 			goto out;
 		}
@@ -991,18 +1006,6 @@ int cmd_gc(int argc,
 				fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
 			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
 		}
-	} else {
-		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-		if (keep_largest_pack != -1) {
-			if (keep_largest_pack)
-				find_base_packs(&keep_pack, 0);
-		} else if (cfg.big_pack_threshold) {
-			find_base_packs(&keep_pack, cfg.big_pack_threshold);
-		}
-
-		add_repack_all_option(&cfg, &keep_pack, &repack_args);
-		string_list_clear(&keep_pack, 0);
 	}
 
 	if (opts.detach > 0) {
@@ -1065,7 +1068,7 @@ int cmd_gc(int argc,
 	if (maintenance_task_rerere_gc(&opts, &cfg))
 		die(FAILED_RUN, "rerere");
 
-	if (maintenance_task_odb(&opts, &cfg, &repack_args))
+	if (maintenance_task_odb(&opts, &cfg, keep_largest_pack, aggressive))
 		die(NULL);
 
 	report_garbage = report_pack_garbage;
@@ -1088,7 +1091,6 @@ int cmd_gc(int argc,
 
 out:
 	maintenance_run_opts_release(&opts);
-	strvec_clear(&repack_args);
 	gc_config_release(&cfg);
 	return 0;
 }
@@ -1291,15 +1293,7 @@ static int maintenance_task_gc_background(struct maintenance_run_opts *opts,
 
 static int gc_condition(struct gc_config *cfg)
 {
-	/*
-	 * Note that it's fine to drop the repack arguments here, as we execute
-	 * git-gc(1) as a separate child process anyway. So it knows to compute
-	 * these arguments again.
-	 */
-	struct strvec repack_args = STRVEC_INIT;
-	int ret = need_to_gc(cfg, &repack_args);
-	strvec_clear(&repack_args);
-	return ret;
+	return need_to_gc(cfg);
 }
 
 static int prune_packed(struct maintenance_run_opts *opts)

-- 
2.55.0.313.g8d093f411d.dirty

