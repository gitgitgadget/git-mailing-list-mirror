Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919542F711
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438396; cv=none; b=fCl3BtLf/l6X7DoScRuef+0Zh3Ds8HAik87H+lES7FXPuMa17dDmhMnbEf86bqWwQErmChm2Nfu2LQsKFzTGCgbKTUMb86ey4AhVt3GQ/Z8ymBecMmiw3MpaGYIakG3/tWffY/OgtxSarhdZIi1DEGx1eKtMuHNppF66K2UsRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438396; c=relaxed/simple;
	bh=dJ1rueWjms4JOZu2a0pmH9LfaFH33QeHq3QbUy0NeQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6lk34ymhOAUVAo2FSy9amnIImgMLsNHENhxjoxzzAM/SPjccbmTWODjuPcxpbE9cgOrPFsLoXkx3miBXr7o+zqFt53D3lY8kiflGai+JnA7GNU0FX24Bs3uXVCtKJ7p/tAEaObpQlF1s2KssmOcdUD8XV0omofS3r/65C5R9vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=az0RZIwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GFdZaRb3; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="az0RZIwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GFdZaRb3"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26C401400122
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 07 Jul 2026 11:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438393;
	 x=1783524793; bh=WDv13gJs24RprvBECb1P7JIBcLT9YTub0eepc30GVBY=; b=
	az0RZIwudwQvmNnPrsuS/GGSrk+phQFnCt+5NNVNJjhF7IpQpSQARddl03mTtjjj
	euUhlA9UnTyHadllcZLN+byQ7B7aah05QmzXmTUcDP0l4q446ozQVzxNIi6ZZhYJ
	URP60eU8zA/sse11ONHoY60q5RQRF/rplP/Fm517d/XNlbXn+xD/rTm/0oRbDPLE
	jndjYV1r4mxWiaeajvq5fz7B2Q/iVtkEA6KeBQfqiTE/3Vb1Z23C74LBA3UCHLbE
	MUCYMoTpRIqGC8Ke5tv7/7O7JdojQUA22sezKifRXQJk/jS/hSTp2gAOaE5ler8F
	t5eSXTxI+IV1ub08HukkCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438393; x=
	1783524793; bh=WDv13gJs24RprvBECb1P7JIBcLT9YTub0eepc30GVBY=; b=G
	FdZaRb3s8152jl3OtM5o4GaTx97wBPdCO3aJEWPYGDBExxKsUxyNR9DBFvl2+fqi
	rKXeYUpcUcxxyOyG8KA2xDZsp1vNErqPfp1HvgCnqvCRKkqHy3V5rX7W34hYwFOR
	XT8UHMIcBCmGa+BoK5TZl1P5SD76ta49/TQHxbNPmpfyZCNkQ7u/RNqS6XbBsOtF
	EwZzSMPUTk0UgvjWAEYf7ISQN3lp1Pd5rQ43HBVRXGQfcyl0q7K36jWfxG842IfG
	9IzzwAgez+OONwNl27nloSwVh0PvvfkpCwEtbbo5GrOuofcksuvjrj/ZkQ3FGId4
	FX2ymYFmQjWr6Sc3tOFwA==
X-ME-Sender: <xms:ORxNapGNku2QAwQ0drp16WL4NY5EanxtrFevuBE-LsVmMSet6DG_WQ>
    <xme:ORxNalSh4rjerB_W6ralxPXpuWzcBSpWuuWP4yQ4C89sBComYh01n9LcMAyNWzduE
    P6uHIHoqaqkfC11YEs5uIU-u3CTRLsYZgyRo0RA68fuvPFn7Db8qQ>
X-ME-Received: <xmr:ORxNagyUAmNpVmHeKZghycwWaTct-60frRXOFe0E4IWaE_vIJzJJ5_TprICiWf29MnxlEgaxsnSNoJlwS1noH8QelQCELArLz41bIDBKNg>
X-ME-Proxy-Cause: dmFkZTEJsHBfpO0PYEe5AorOfHcazVp/tBbkPBeEyBKukAxlTkshoZ2/gbuXJescdgLEDk
    2G/3VKtvJlc5njlYrPCxkg9j00cHK7EbceH5LxXeH6PWEH2F+oepzAb9SewsjRo/KIW0lU
    1lQE5NNhIb7f+4g+C5KCZPv4MqEkNsifUe5QUQNQKxPxqlLS2wxm0+oRvJw1AQX0T0+0UM
    M9QSGRn0kaVEjf9V7cMY2jYCFqjaWroOsmMwIqvkSpUhAyQDxnLPwdCWG3jz/2YPCd808h
    PkY/4hDSR4JLrxsPxxXC41eGPaToRv5DPX2LX50SXBrynI5VER33qWb84HYOTOnZBOy4Hx
    oQaHOLA1B/ji707YPpqFB9aZgb1ClCjmPpcxryL5rrUdjDvn9vS7zEysJFnxiBRMlM1qD6
    tKmrHYItL4P4MjN25ZiLB/rTeGAWlNk9yWuGB/lGuNo3rxcfhNTSdtN5Sud2OA9Z5mxVnZ
    viaoKkkrLK3S9QxCGAF2RfqIIow3nHAOphhcMT7PpBIY8ZMd65cxBrg9T5p9NTUWg26IVI
    Aq1HJ3rDzUdzZyLTqWsITrLeuj/XLgRnjaD9YIiob3AKZH7Bilki1/WA6vuBVNCP0MpccA
    pNrz9cQMuVnjxR16IR3vm45w52RBc1uEbVJgLy5H1pmeq2XBGiigth8iGNew
X-ME-Proxy: <xmx:ORxNakNSocRScKXc5MZUAX3pvAsA8RvegCj3MKhzkqXqVhsmQjusQA>
    <xmx:ORxNavMtgTkllrkNPhtFn6Z1DD7kkxDgXz9441PTRzh7py0qfNWTKw>
    <xmx:ORxNamTP92IGwk2gQ8j6FF7nRNsGr6nPekOJZ061SqJp2vGc5QsbnA>
    <xmx:ORxNahAvBr8_mAGIwwswsNq0BaThgl6y9obOyjxiy21rSM2vVh9FOg>
    <xmx:ORxNanW46vd8KtDcVoF-u-c2QdoznOUKF7DHc42p6AAZ7xXTIrzPGZ9a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b3e262ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:39 +0200
Subject: [PATCH 07/11] builtin/gc: move geometric repacking into
 `odb_optimize()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-7-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have two major object database optimization strategies:

  - The legacy strategy used by git-gc(1), which absorbs loose objects
    into packfiles, and eventually merges all packfiles once we have too
    many of them.

  - The more recent "geometric" strategy used by git-maintenance(1),
    which merges packfiles using a geometric sequence.

These two strategies are still using completely separate code paths. In
a subsequent commit we'll want to make both strategies pluggable though.

Prepare for this change by merging the "geometric" strategy into
`odb_optimize()`. This also allows us to reuse some of the logic we have
in that function.

Note that this change requires us to adapt tests because we're now using
"-q" instead of "--quiet". Naturally though, these invocations are of
course equivalent to one another.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 171 +++++++++++++++++++++++++------------------------
 t/t7900-maintenance.sh |  22 +++----
 2 files changed, 98 insertions(+), 95 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 17490106fc..c8504f4456 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -593,6 +593,11 @@ static int keep_one_pack(struct string_list_item *item, void *data)
 	return 0;
 }
 
+enum odb_optimize_strategy {
+	ODB_OPTIMIZE_INCREMENTAL,
+	ODB_OPTIMIZE_GEOMETRIC,
+};
+
 enum odb_optimize_flags {
 	/* Enable verbose logging and progress reporting. */
 	ODB_OPTIMIZE_VERBOSE = (1 << 0),
@@ -605,6 +610,7 @@ enum odb_optimize_flags {
 };
 
 struct odb_optimize_options {
+	enum odb_optimize_strategy strategy;
 	enum odb_optimize_flags flags;
 	const char *prune_expire;
 	const char *expire_to;
@@ -858,49 +864,87 @@ static int odb_optimize(struct object_database *odb,
 	 *
 	 *   - Otherwise we perform an incremental repack.
 	 */
-	if (!(opts->flags & ODB_OPTIMIZE_AUTO)) {
-		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-		if (opts->keep_largest_pack != -1) {
-			if (opts->keep_largest_pack)
-				find_base_packs(&keep_pack, 0);
-		} else if (big_pack_threshold) {
-			find_base_packs(&keep_pack, big_pack_threshold);
-		}
-
-		add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
-		string_list_clear(&keep_pack, 0);
-	} else {
-		if (too_many_packs(gc_auto_pack_limit)) {
+	switch (opts->strategy) {
+	case ODB_OPTIMIZE_INCREMENTAL:
+		if (!(opts->flags & ODB_OPTIMIZE_AUTO)) {
 			struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-			if (big_pack_threshold) {
-				find_base_packs(&keep_pack, big_pack_threshold);
-				if (keep_pack.nr >= gc_auto_pack_limit) {
-					string_list_clear(&keep_pack, 0);
+			if (opts->keep_largest_pack != -1) {
+				if (opts->keep_largest_pack)
 					find_base_packs(&keep_pack, 0);
-				}
-			} else {
-				struct packed_git *p = find_base_packs(&keep_pack, 0);
-				uint64_t mem_have, mem_want;
-
-				mem_have = total_ram();
-				mem_want = estimate_repack_memory(p);
-
-				/*
-				 * Only allow 1/2 of memory for pack-objects, leave
-				 * the rest for the OS and other processes in the
-				 * system.
-				 */
-				if (!mem_have || mem_want < mem_have / 2)
-					string_list_clear(&keep_pack, 0);
+			} else if (big_pack_threshold) {
+				find_base_packs(&keep_pack, big_pack_threshold);
 			}
 
 			add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
 			string_list_clear(&keep_pack, 0);
 		} else {
-			add_repack_incremental_option(&repack_cmd.args);
+			if (too_many_packs(gc_auto_pack_limit)) {
+				struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+				if (big_pack_threshold) {
+					find_base_packs(&keep_pack, big_pack_threshold);
+					if (keep_pack.nr >= gc_auto_pack_limit) {
+						string_list_clear(&keep_pack, 0);
+						find_base_packs(&keep_pack, 0);
+					}
+				} else {
+					struct packed_git *p = find_base_packs(&keep_pack, 0);
+					uint64_t mem_have, mem_want;
+
+					mem_have = total_ram();
+					mem_want = estimate_repack_memory(p);
+
+					/*
+					 * Only allow 1/2 of memory for pack-objects, leave
+					 * the rest for the OS and other processes in the
+					 * system.
+					 */
+					if (!mem_have || mem_want < mem_have / 2)
+						string_list_clear(&keep_pack, 0);
+				}
+
+				add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
+				string_list_clear(&keep_pack, 0);
+			} else {
+				add_repack_incremental_option(&repack_cmd.args);
+			}
 		}
+
+		break;
+	case ODB_OPTIMIZE_GEOMETRIC: {
+		struct pack_geometry geometry = {
+			.split_factor = 2,
+		};
+		struct pack_objects_args po_args = {
+			.local = 1,
+		};
+		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
+		struct string_list kept_packs = STRING_LIST_INIT_DUP;
+
+		repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+				    &geometry.split_factor);
+
+		existing_packs.repo = the_repository;
+		existing_packs_collect(&existing_packs, &kept_packs);
+		pack_geometry_init(&geometry, &existing_packs, &po_args);
+		pack_geometry_split(&geometry);
+
+		if (geometry.split < geometry.pack_nr) {
+			strvec_pushf(&repack_cmd.args, "--geometric=%d",
+				     geometry.split_factor);
+		} else {
+			add_repack_all_option(opts, NULL, &repack_cmd.args);
+		}
+		if (the_repository->settings.core_multi_pack_index)
+			strvec_push(&repack_cmd.args, "--write-midx");
+
+		existing_packs_release(&existing_packs);
+		pack_geometry_release(&geometry);
+		break;
+	}
+	default:
+		die("unknown maintenance strategy '%d'", opts->strategy);
 	}
 
 	if (run_command(&repack_cmd)) {
@@ -908,7 +952,8 @@ static int odb_optimize(struct object_database *odb,
 		goto out;
 	}
 
-	if (opts->prune_expire) {
+	/* Geometric repacking uses cruft packs, so we don't have to prune separately. */
+	if (opts->strategy != ODB_OPTIMIZE_GEOMETRIC && opts->prune_expire) {
 		struct child_process prune_cmd = CHILD_PROCESS_INIT;
 
 		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
@@ -943,6 +988,7 @@ static int maintenance_task_odb(struct maintenance_run_opts *opts,
 				int aggressive)
 {
 	struct odb_optimize_options odb_opts = {
+		.strategy = ODB_OPTIMIZE_INCREMENTAL,
 		.keep_largest_pack = keep_largest_pack,
 		OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive),
 	};
@@ -1624,58 +1670,15 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 static int maintenance_task_geometric_repack(struct maintenance_run_opts *opts,
 					     struct gc_config *cfg)
 {
-	struct pack_geometry geometry = {
-		.split_factor = 2,
-	};
-	struct pack_objects_args po_args = {
-		.local = 1,
+	struct odb_optimize_options odb_opts = {
+		.strategy = ODB_OPTIMIZE_GEOMETRIC,
+		OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, 0),
 	};
-	struct existing_packs existing_packs = EXISTING_PACKS_INIT;
-	struct string_list kept_packs = STRING_LIST_INIT_DUP;
-	struct child_process child = CHILD_PROCESS_INIT;
-	int ret;
-
-	repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
-			    &geometry.split_factor);
-
-	existing_packs.repo = the_repository;
-	existing_packs_collect(&existing_packs, &kept_packs);
-	pack_geometry_init(&geometry, &existing_packs, &po_args);
-	pack_geometry_split(&geometry);
-
-	child.git_cmd = 1;
-	child.odb_to_close = the_repository->objects;
-
-	strvec_pushl(&child.args, "repack", "-d", "-l", NULL);
-	if (geometry.split < geometry.pack_nr) {
-		strvec_pushf(&child.args, "--geometric=%d",
-			     geometry.split_factor);
-	} else {
-		struct odb_optimize_options odb_opts = {
-			OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, 0),
-		};
 
-		if (!opts->quiet)
-			odb_opts.flags |= ODB_OPTIMIZE_VERBOSE;
-
-		add_repack_all_option(&odb_opts, NULL, &child.args);
-	}
-	if (opts->quiet)
-		strvec_push(&child.args, "--quiet");
-	if (the_repository->settings.core_multi_pack_index)
-		strvec_push(&child.args, "--write-midx");
-
-	if (run_command(&child)) {
-		ret = error(_("failed to perform geometric repack"));
-		goto out;
-	}
-
-	ret = 0;
+	if (!opts->quiet)
+		odb_opts.flags |= ODB_OPTIMIZE_VERBOSE;
 
-out:
-	existing_packs_release(&existing_packs);
-	pack_geometry_release(&geometry);
-	return ret;
+	return odb_optimize(the_repository->objects, &odb_opts);
 }
 
 static int geometric_repack_auto_condition(struct gc_config *cfg UNUSED)
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 1212b306b6..e0251064c7 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -556,8 +556,8 @@ run_and_verify_geometric_pack () {
 	rm -f "trace2.txt" &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git maintenance run --task=geometric-repack 2>/dev/null &&
-	test_subcommand git repack -d -l --geometric=2 \
-		--quiet --write-midx <trace2.txt &&
+	test_subcommand git repack -d -l -q --geometric=2 \
+		--write-midx <trace2.txt &&
 
 	# Verify that the number of packfiles matches our expectation.
 	ls -l .git/objects/pack/*.pack >packfiles &&
@@ -588,8 +588,8 @@ test_expect_success 'geometric repacking task' '
 		# The initial repack causes an all-into-one repack.
 		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
 			git maintenance run --task=geometric-repack 2>/dev/null &&
-		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
-			--quiet --write-midx <initial-repack.txt &&
+		test_subcommand git repack -d -l -q --cruft --cruft-expiration=2.weeks.ago \
+			--write-midx <initial-repack.txt &&
 
 		# Repacking should now cause a no-op geometric repack because
 		# no packfiles need to be combined.
@@ -609,8 +609,8 @@ test_expect_success 'geometric repacking task' '
 		# an all-into-one-repack.
 		GIT_TRACE2_EVENT="$(pwd)/all-into-one-repack.txt" \
 			git maintenance run --task=geometric-repack 2>/dev/null &&
-		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
-			--quiet --write-midx <all-into-one-repack.txt &&
+		test_subcommand git repack -d -l -q --cruft --cruft-expiration=2.weeks.ago \
+			--write-midx <all-into-one-repack.txt &&
 
 		# The geometric repack soaks up unreachable objects.
 		echo blob-1 | git hash-object -w --stdin -t blob &&
@@ -644,8 +644,8 @@ test_expect_success 'geometric repacking task' '
 		run_and_verify_geometric_pack 3 &&
 		GIT_TRACE2_EVENT="$(pwd)/cruft-repack.txt" \
 			git maintenance run --task=geometric-repack 2>/dev/null &&
-		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
-			--quiet --write-midx <cruft-repack.txt &&
+		test_subcommand git repack -d -l -q --cruft --cruft-expiration=2.weeks.ago \
+			--write-midx <cruft-repack.txt &&
 		ls .git/objects/pack/*.pack >packs &&
 		test_line_count = 2 packs &&
 		ls .git/objects/pack/*.mtimes >cruft &&
@@ -736,7 +736,7 @@ test_expect_success 'geometric repacking honors configured split factor' '
 
 		test_geometric_repack_needed false splitFactor=2 &&
 		test_geometric_repack_needed true splitFactor=3 &&
-		test_subcommand git repack -d -l --geometric=3 --quiet --write-midx <trace2.txt
+		test_subcommand git repack -d -l -q --geometric=3 --write-midx <trace2.txt
 	)
 '
 
@@ -1167,7 +1167,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		test_strategy geometric <<-\EOF &&
 		git pack-refs --all --prune
 		git reflog expire --all
-		git repack -d -l --geometric=2 --quiet --write-midx
+		git repack -d -l -q --geometric=2 --write-midx
 		git commit-graph write --split --reachable --no-progress
 		git worktree prune --expire 3.months.ago
 		git rerere gc
@@ -1176,7 +1176,7 @@ test_expect_success 'maintenance.strategy is respected' '
 		test_strategy geometric --schedule=weekly <<-\EOF
 		git pack-refs --all --prune
 		git reflog expire --all
-		git repack -d -l --geometric=2 --quiet --write-midx
+		git repack -d -l -q --geometric=2 --write-midx
 		git commit-graph write --split --reachable --no-progress
 		git worktree prune --expire 3.months.ago
 		git rerere gc

-- 
2.55.0.141.g00534a21ce.dirty

