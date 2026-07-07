Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050CF414A00
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438391; cv=none; b=NxTI1jI1TED+HNi/ATuKSfqJ0G4uKJy1gSUkLr3DLO8eZFxT4J74iBasvG5WgHTR7We4Hjw89Yabn18dRs+Gd8dtIIfImLTCvTFVXTTevlJjvR+2iSq2UfhJaYZ97sUoW9nyGBm9QnAuQ8LoW2/05Iuh/v0sY1NxRfMTmW93Vhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438391; c=relaxed/simple;
	bh=sh5mJBvlrFlnhWJdsMw0MI5ppmO/JSfGc9uRwHfR+vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=To3tHaaCikpKS9otsFAckeQ1X+Q5S/xSSqCDNQGhnfsg5IrHG6HnOEvfkoHc3EHxpaqIEWznNbWq6fG102kj9ql3hH1ceHQDqlzZ6zqn9hcoZpnBD4YLoRRXoulEKSXVQOccODtm2Wh7YXqxZsepflMB5kgwVZoFRQ+fi2iXhpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KDiokcRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRevAT/r; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KDiokcRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRevAT/r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 365D014000B8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 11:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438388;
	 x=1783524788; bh=BxZejjCsZnmxOokAZlco2PKDx8Hh36ETiaEHh5nEw3E=; b=
	KDiokcRovFl5PwmYQiL3wsxv7xIdxv9Szr+jcU5st76G8C9j5jI1kAfYl7DsABMV
	jSYCtSQNsbmmk5c01zzNxNn0a/qn/+IOX0uM2MghQyFmNVPNNH4OQTXPC5dd4kMS
	uwtqI/bCEs/33CUYQwWQ9YQDe3jGsy3SV0CpF6D+Vcnh8ADBd5U64BprvdpLVZ4S
	9Sg+/4vcXPhQ3dU9hQigXOmvXNJj5eZ8f4Pg8uZ0tn9ZFPEexiuWIj5BlhwznNGc
	yAJ1i+yoznyhknWe0Geh+oqDn4ZtMqDcsxmQb6OODqmIpb4uSTXOP23IuRgU96HJ
	65rlSeY/Sf9cdQ5PP+hdCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438388; x=
	1783524788; bh=BxZejjCsZnmxOokAZlco2PKDx8Hh36ETiaEHh5nEw3E=; b=L
	RevAT/rgXEMHKgt9bZPG9VXHQIqhTpKLeMD0Kg/G+a/F1QDPHWKniEl6D5xFQMjh
	zCeKJOm+lunpSiB5bqwOKWL67EZZ5d4uEdZffRi7AfZglAIcD3TmAoMBqiPEpMcd
	lINmOqayxm5i1SUVVKPDGMlM6ZO/TXJf23xqCVNPRg8+9w17dEfChz+fFmYohvwk
	RHo2+vAdG505EmkRmtlrieLjUU4/VX5ejT5TZIKS4JAnikVXy8aG1YZNTn4VFFVG
	jyPKft0vzytuk/LeCWAFPNLga7wANjaSKotFcPoJtKU7DeqGbHNUn1ruD1T9eeo4
	Bu/4zQRvDX00FWCIo5liA==
X-ME-Sender: <xms:NBxNarr5ImhHzOeDnkCd1p-0mzQkwXjiO-umNaTsSiOI11tm6cigpA>
    <xme:NBxNasmEWe1e_eSfQF7aP1EPuWG5ZoQCxYmG7OSa35BZber7lRquLJso2yWdF1XVH
    vLNBUNqJAs3O_Pbj7QaiKk6DjyaTC4AXvmSNyQL_NZShMNw5qD8pg>
X-ME-Received: <xmr:NBxNat2K2K_fD3c8sz1ySwBYLtXFL9LZkt4htuAO0nQ-po1zraQPvL8CkATgcQQde9kc5nL3hjJLCuJe6OSE_45T6EFtaIn-GAvt2vlKmA>
X-ME-Proxy-Cause: dmFkZTEJsHBfpO0PYEe5AorOfHcazVp/tBbkPBeEyBKukAxlTkshoZ2/gbuXJescdgLEDk
    2G/3VKtvJlc5njlYrPCxkg9j00cHK7EbceH5LxXeH6PWEH2F+oepzAb9SewsjRo/KIW0lU
    1lQE5NNhIb7f+4g+C5KCZPv4MqEkNsifUe5QUQNQKxPxqlLS2wxm0+oRvJw1AQX0T0+0UM
    M9QSGRn0kaVEjf9V7cMY2jYCFqjaWroOsmMwIqvkSpUhAyQDxnLPwdCWG3jz/2YPCd808h
    PkY/4hDSR4JLrxsPxxXC41eGPaToRv5DPX2LX50SXBrynI5VER33qWb84HYOTOnZBOy4c/
    NTk6lmOUWC+mTSh5t10OuGc9P2xr/8eum2cJB1atxMOSRLk5hosmrcdZddUQPgt0rqTitm
    7J1d5sOC8D8Iu00qAOwYmWeAxvue5GJ9JxrpkcycYQzEGdTQTZPmtaM4qoHOmx+kdKMM5q
    uNcMPS0ebQc7yEUIOtWiDxfty6c5fWJLav0gFwFOEsZAk8bxXXdpp40FLB2uAnOp/BTxZ0
    FDVctrDd6vZuvhG/BbQNMhwnqCDjsQROblRnCAOf3B23aCO3Q3wE5DfevENi8KgqEPEEav
    n3RgmaXIV30mrMmG70ombQkX1je2Evx2HQPxZolSm8p8mwLEay9vsMEUYrBA
X-ME-Proxy: <xmx:NBxNakAvJ35sN9Jm8LWhjVyxW9UQCe8e-nak7XE6MyjcIIbbkdWd9w>
    <xmx:NBxNaqyTR5uoDbV1wkSOQpJlzEcuC1VNpm3fhjTpNiC0clX2o_x6yg>
    <xmx:NBxNailVYXh8YZM3bkOLxSkYmLLrvCI6BHkTM_GaIZTK5oMsqoMEfg>
    <xmx:NBxNavEhv9KVThWNfi8Oliy_DxXhYr1LPfAnRO_bVNsO_brxmlOfNg>
    <xmx:NBxNarLORSGPJrvA7CSnNshhQOWvsPsNHwD301Hqn9QVV-cd_fUcVquQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c3469bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:36 +0200
Subject: [PATCH 04/11] builtin/gc: make repack arguments self-contained
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-4-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.141.g00534a21ce.dirty

