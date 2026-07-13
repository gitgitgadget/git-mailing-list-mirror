Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FD3361DC3
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921959; cv=none; b=Z82hcKr2zug2NHVJcYPwDW9FNfHgM6H5hfceCjVyy5AgkcTAb1qjWf/ADasuZ37XnopKeWZQViTgmHDn+KIcqRKdnLG0m/H5j956PgBdaBV1HBIx59esDIGuUm4Xa8pXuZlJNavCGi6GweelxRDtpr3HS7wKygWONoo7smQwdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921959; c=relaxed/simple;
	bh=80467lrP+iPJg07xUasgSGcvZDghtIEJzeiN9pEczuY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5WxrNposazIKuAZCRyXoA+peg4KOKQoFFotKokRg92WZqyPdYSoOIFBQMhKeTMpAjVzP6mNQxbwc02Ed0rFrlbWO+OjUq8B/00ndTnnK6ieeyXQBVdpZhczzNpxlA89XsX7rS/85Ge048kpExw3ozzcikjR/UCEyoECCHtaix4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=degw/2uW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eIxez268; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="degw/2uW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eIxez268"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F66CEC013B;
	Mon, 13 Jul 2026 01:52:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 01:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921956;
	 x=1784008356; bh=s/37lP2cOO3D0W2VRP3TcOISQRYBXOM/YvGjS6encyE=; b=
	degw/2uWbtRo3gdymbkUlX2sZXHX5xMo4/TVqs90r7oj7ZIgWNlnksoOdzQ9/prq
	PpPX99j8LnjllIq+b+bNa+xblpzBVox0xg8JzqcfHwcbaqVQcrvVXB2oSpl2EB9d
	tj6S5tFhQ8yV623n/0F6oPxRDTZjvKmRS51jrFEgXhXlOrbSVz/MMTod8ylHoBdG
	/tlwSASYLUgUkkVrRBhmpy5tdtrgtoZr/7+TnUEyt6VZdJa3KT/erNy5/6k+QfEs
	rqxvKGxPF9NYZGcGD5BGolwWL7X9XYPdgcQE7CWQ6JPu46todjGeAjZb1CPNmUmg
	+pFs9U6+7cKRAtlqIFw0/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921956; x=
	1784008356; bh=s/37lP2cOO3D0W2VRP3TcOISQRYBXOM/YvGjS6encyE=; b=e
	Ixez268zaQkwn7WlSrCSVIQ1WW7qChmebyl/xNQk8KedOlWse5yy0pvX9ucZGNMV
	5SdcnxsSlPABF0coMqRQbCknpH9EHAL7pOkiwM2I2hyZgOq9yUF79sktSeHxH8ww
	O85gbg+/hG3icJODHs9AR5EF0OGuWdSwWmPWpfBgjgNDArxcPKvqBbNz1TYE8XuV
	0HEwqcVyQ6v5e/fD+h+NA4rrOncosYREShzqjldhrvj8fWSRro6OivcyZXELc4vH
	YZIgk3MhQTDX4xgXvxFmIaKVQV/rw56WGRKGBdq3rfpUbvueWbwMBYue16KpdkB9
	/U7icaHXgD93VnVTXYjQg==
X-ME-Sender: <xms:JH1UateESCNQ3rScMsuDyjYZBK9MJ7Z5c6UutUG_R62qZSmjEI07tA>
    <xme:JH1UahNZAe4-E_uYwwepR1I9GL0TPogai19BOyiY1l51GqxErQNJL_5oIM5NzBlGK
    EN5DfpHZtcbOP98YfELR_Vz1S-mO6yefZ1K7wBtui9x2W2_3aiUlvk>
X-ME-Received: <xmr:JH1UakL1ZljB6eshuPpMsIpOLSxN6ZGkj9ViBMQX-bNhDyWRXAmtRkAUVQbSsRlFtk2iQI5aRgDVX8BSywGD-e1JRfgQJdCoTuPykJEv>
X-ME-Proxy-Cause: dmFkZTFIUDY26jRG21zJjIfGPrl8ENW9/+ypYCPCvFU4QHtOfI7UPub9FlJD34Vs3MaRzO
    h5/c3T8KOTl1Xbj91ua5LE7BfX1rBRJPkwEkX+/9uhvqAn2l7TudJc86Atx/hIF9IaaKGJ
    NjtSuT7dLkw5AGaHKSocwZSlFgzjCetRhHG8DyIGIW7riGN0pUe3my1kpZEAmrGpRZ3naY
    fORDegOxYt8ZyHLuECcutn04mkRgNUblCZOFp6ymK6fcUDKt7PFEbvUThW3ulelCTdfYfm
    TUOL+6hwmiSGLCra1DYOiz0Unrb9wzTVAX8acy8UebX45tscALMqp8/pMz7uaMgSVC8JWU
    1m+pcF826ngWppK9mL/5CGU6UcmwWR+asQCgL3fWOLTmZx/tIspRdMLWekdV2mw3SxVq7u
    1ZQNhuTJ0lv8CQ8RZ+uOjAQWZuguEMxm5pQyidaarszeetI2DeF7XwPn1uvk87N0QR0miN
    ZL6zS64lhkZrv6S6htgwL+49IvIEVSIKpDwbfC9U3VUmHXbjhVrvMmMKDe1zdaIRPQfdam
    XBUApyXmD2Q1tZMbaA4r78Dca5xlBkwVcgOxAYJsYnDvB+WsMLmZCBJZS4mHIyRAsaMPsA
    wAk0exc/q4FRtQsQ1nxd+9yLxxjp7q/1o4xE3XB5aROVkBXn5d3KPC97YjlA
X-ME-Proxy: <xmx:JH1UaiEC4qBOS6tRgmyXqOsGpPaaqODKYRbAdQDju1cqQKtgtU9BBw>
    <xmx:JH1UasQLVwzdFFGIPjNIyNaeluyVmnAcyPRPciatjiuufTNcg-zzxQ>
    <xmx:JH1UauEF6uPxG5qnLLxIdG96x8vyA166dM55Lt72o0__zaAm7h1Log>
    <xmx:JH1Uao9Z7bDk7CWUgRvgmUZuuXgLP2bYZYqfHReiQmCcnF8lko7JtA>
    <xmx:JH1Uao3KS7mWiAO6CqnEs-NXSoEVczs4V8mb-NlYWuWjH4MVcau6Dm2q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id efe3c290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:11 +0200
Subject: [PATCH v2 08/12] builtin/gc: move geometric repacking into
 `odb_optimize()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-8-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
 t/t7900-maintenance.sh |  18 +++---
 2 files changed, 96 insertions(+), 93 deletions(-)

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
index 2d52e7918a..6d87da2ae4 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -574,8 +574,8 @@ run_and_verify_geometric_pack () {
 	rm -f "trace2.txt" &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" \
 		git maintenance run --task=geometric-repack 2>/dev/null &&
-	test_subcommand git repack -d -l --geometric=2 \
-		--quiet --write-midx <trace2.txt &&
+	test_subcommand git repack -d -l -q --geometric=2 \
+		--write-midx <trace2.txt &&
 
 	# Verify that the number of packfiles matches our expectation.
 	ls -l .git/objects/pack/*.pack >packfiles &&
@@ -606,8 +606,8 @@ test_expect_success 'geometric repacking task' '
 		# The initial repack causes an all-into-one repack.
 		GIT_TRACE2_EVENT="$(pwd)/initial-repack.txt" \
 			git maintenance run --task=geometric-repack 2>/dev/null &&
-		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
-			--quiet --write-midx <initial-repack.txt &&
+		test_subcommand git repack -d -l -q --cruft --cruft-expiration=2.weeks.ago \
+			--write-midx <initial-repack.txt &&
 
 		# Repacking should now cause a no-op geometric repack because
 		# no packfiles need to be combined.
@@ -627,8 +627,8 @@ test_expect_success 'geometric repacking task' '
 		# an all-into-one-repack.
 		GIT_TRACE2_EVENT="$(pwd)/all-into-one-repack.txt" \
 			git maintenance run --task=geometric-repack 2>/dev/null &&
-		test_subcommand git repack -d -l --cruft --cruft-expiration=2.weeks.ago \
-			--quiet --write-midx <all-into-one-repack.txt &&
+		test_subcommand git repack -d -l -q --cruft --cruft-expiration=2.weeks.ago \
+			--write-midx <all-into-one-repack.txt &&
 
 		# The geometric repack soaks up unreachable objects.
 		echo blob-1 | git hash-object -w --stdin -t blob &&
@@ -662,8 +662,8 @@ test_expect_success 'geometric repacking task' '
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
@@ -754,7 +754,7 @@ test_expect_success 'geometric repacking honors configured split factor' '
 
 		test_geometric_repack_needed false splitFactor=2 &&
 		test_geometric_repack_needed true splitFactor=3 &&
-		test_subcommand git repack -d -l --geometric=3 --quiet --write-midx <trace2.txt
+		test_subcommand git repack -d -l -q --geometric=3 --write-midx <trace2.txt
 	)
 '
 

-- 
2.55.0.313.g8d093f411d.dirty

