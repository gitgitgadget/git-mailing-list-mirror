Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968641DEE8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438399; cv=none; b=bdcKcpqlaOBkUu8zLg5wB5rG26TKIhv17muUciOCR4Csittc02YZ6krrwFUZWaQRqA0GW9OSc8UPx1BJVtNGDfJRrs4KYMRWmTv5sQNkdW1tVwGKeGMY2gy7gJMsAWTfMuTjTvpe1r/mjafwShFM9CykyPjiOgw7WyRoPufLNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438399; c=relaxed/simple;
	bh=rgEM2skmCJQc46n9AN+YGRpdHkoLHufanIyTDaPiNdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbTxwQbOL/CEIe5Rf6hcuNIu2CrnQ8C1zxWI3r1krlCi4iVUw1q5pyaVpSS7hksAgc2k9cl8kMQjmBP6TWl/5ptP/BVkhl5cyAYbwLTkFCvsr2pM6FqKh9SWixXalH0Zk+kBdYA6o3UO9VkAnFgdjSvs3dmy9hFmu+Yt2cLuSRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fGRrjm8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cbv9zdDt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fGRrjm8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cbv9zdDt"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A58CDEC023C
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 11:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438397;
	 x=1783524797; bh=I4phaE+UrpN7ror6UeqT2UtaPreVQp/Tvnjv27o3GlI=; b=
	fGRrjm8VDb7JPz6FiTFhAcNoj1eWqj6vDKfL3ggKCSl9Btq4CHf3TXfSk3GREf4C
	xIDTzINSdX8sB/xnYA2RGRquXNG+ugcJ9EPqybIGvohP4l3eVV0jsjET2eIwoTwN
	MQIJN6Nf4xGWz86XKD5eg9Ct128JSZM+WJQKi02v+FH0mjKjfMmmbsu7TBO9qMD/
	xBu2Ty8PzkEvAzCWqKbiLkB8N3XH5YIfYpXaeqCo2YlqD19XEXeyDdtf1W/splOR
	80kUnANTsT7K7SBR+lEE6qGNpZexitigxEFovxk5AvAUujOPERClsxMM0zOCN0FK
	5rJjkafDdEQeCne7/R+1Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438397; x=
	1783524797; bh=I4phaE+UrpN7ror6UeqT2UtaPreVQp/Tvnjv27o3GlI=; b=C
	bv9zdDtXiI3uK3VrkbV1Ea1V2qPhe7x4oCP+TVatxvLdOjICKsAFr7WvWPOspUQB
	Q6ZxN7lQGBN8ojC6TTqlJN34N8XIW3mUiA78+/o3AFs16CslSAD5Mhhm8X0L9Hvb
	348f+7njptU9Zc+0Lg4Kffy281p7rU746ELlC+3KBBw3SbWSiI6QPKjj5mOnCJNQ
	fnbE7yI9os/6G3TV2S0tFSv6YtH/bNjKy7J940jjvjwHa4KvKWWteMmkQZm+BfDL
	RABM4sOlO7COk9cmJC/aAAd833XmbhoovelRJWzLggqM1MgZBXFcbyYAul25FhNu
	hHie7LHq8AlwiBocDT52A==
X-ME-Sender: <xms:PRxNavGNHqf_hR7KQ6IoFZxshuhT_pnZqqmDzbxaYcZRC82iuOOmfg>
    <xme:PRxNajQKVRqNmh3FPsHXNA239OehxEAZDfGmWn0PHUlWRKjjJU97YnaBYkAuMvQJ_
    5G5Su2yZEh0b6xG1Wy9YBzG1plhObAjt-3btQTEmBI5izMX51Az>
X-ME-Received: <xmr:PRxNamx7cpnPoUmZ_AwTzNTUa2CU7LGcj31Ngj2jzhjRxbH6XCNZJiobSKlKG-f7Sokr9Afrz6pvXMagmPbI5mclKkir7XyOXFwi-S3SnQ>
X-ME-Proxy-Cause: dmFkZTEGBnR5TPlrZI6lnnnh9TW4ipKymtElkjqZqs/n2sMKHQgpDeigwka92puJdbJRlQ
    1sQCXBBE4CKdq0TnnMWH0QzG6NvaxbjsMZtgbE6QbpjjTmLyhPPGhoohjPmDGr9zLs4iDl
    eM+4MGEcEKuVLNx9t0rSPKCYh1JCh+BHE0RCP8gF7eQ/1bpu8Vh7O3lceFqU03y/fDaylM
    mXrGkTsaQvJs0rNC2LMjbM5TqOdESsCuHk1XvNScWuWbZpnNEM5WVjCzOhKk/LxbaL7EID
    be+fD1nBgtsIoJyzR62fWro7YY08bjGwW/HiCeAHG7XN0HOh+G8X2MdCj9GZRcDheds/Kv
    NYjMZOPuS+ofzv9eZRLsxYb1OWt+NtIM3f94A5L0C4GTu7BChlLOJK2iCh2STYEPxM5Cas
    2EtQFEGlHAzB4N435oipDVtFqvF04w8o5MW0fE3giW1Eq9tkXuu8TndLdRQ4t30VJqlXJm
    BhZfgTzw3ihbddJIvk9ve5pntyWxDJZvw1VoUZrUCy4rOzV2MeP6SRGQvsfIHDskj4nVHJ
    5qPbUJXyarQVWpaeKLbAsxX0W4et+GEMZ1b5H9aLxNJY5u5PylIYjxJ+Gb05KVFbHEZ/Tt
    vXHLuIrgXaBcZ0cYZWBTGT65Ti4IhBibDzy7jMoGKdOLMjsISp+H2UafD9Dg
X-ME-Proxy: <xmx:PRxNaiMWpwhs2GwFHXg2PqU9ukWrr2KBKqSIZV-lkVRIuDNwUWWggQ>
    <xmx:PRxNalPUcDAM2ZHLMzfJctXYMGvEKsgQkwsL4EtdG5ZuHbfqn16Tnw>
    <xmx:PRxNakTm-3ba-j_qsa8ZaO31NAYH3_r6cg8j4dVT1ZsYUAR3HR7new>
    <xmx:PRxNanAs0UcMcZMw9a275zmT7rZ_WC0aHkKM666ZGzUZmDKvgSvlFQ>
    <xmx:PRxNalU0aQqLPxx26ujsDSvq7bDEvlN6bJcSVjp0Em8DJ5msdxh4f49o>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e719e9d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:41 +0200
Subject: [PATCH 09/11] builtin/gc: refactor ODB optimizations to operate on
 "files" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-9-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

We have a couple of functions that are implementation details of how the
"files" object database source performs optimizations. These functions
often use global state like `the_repository` and implicitly derive the
source they are supposed to optimize.

Refactor these interfaces to accept a "files" source directly. This will
make it easier to move around the whole logic into "odb/source-files.c"
in a subsequent step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 79 +++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e119930adc..3207182488 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -428,9 +428,8 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	return should_gc;
 }
 
-static int too_many_loose_objects(int limit)
+static int too_many_loose_objects(struct odb_source_files *files, int limit)
 {
-	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	/*
 	 * This is weird, but stems from legacy behaviour: the GC auto
 	 * threshold was always essentially interpreted as if it was rounded up
@@ -446,19 +445,21 @@ static int too_many_loose_objects(int limit)
 	return loose_count > auto_threshold;
 }
 
-static struct packed_git *find_base_packs(struct string_list *packs,
+static struct packed_git *find_base_packs(struct odb_source_files *files,
+					  struct string_list *packs,
 					  unsigned long limit)
 {
-	struct packed_git *p, *base = NULL;
+	struct packfile_list_entry *e;
+	struct packed_git *base = NULL;
 
-	repo_for_each_pack(the_repository, p) {
-		if (!p->pack_local || p->is_cruft)
+	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+		if (e->pack->is_cruft)
 			continue;
 		if (limit) {
-			if (p->pack_size >= limit)
-				string_list_append(packs, p->pack_name);
-		} else if (!base || base->pack_size < p->pack_size) {
-			base = p;
+			if (e->pack->pack_size >= limit)
+				string_list_append(packs, e->pack->pack_name);
+		} else if (!base || base->pack_size < e->pack->pack_size) {
+			base = e->pack;
 		}
 	}
 
@@ -468,18 +469,16 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	return base;
 }
 
-static int too_many_packs(int gc_auto_pack_limit)
+static int too_many_packs(struct odb_source_files *files, int gc_auto_pack_limit)
 {
-	struct packed_git *p;
+	struct packfile_list_entry *e;
 	int cnt = 0;
 
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	repo_for_each_pack(the_repository, p) {
-		if (!p->pack_local)
-			continue;
-		if (p->pack_keep)
+	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+		if (e->pack->pack_keep)
 			continue;
 		/*
 		 * Perhaps check the size of the pack and count only
@@ -535,15 +534,16 @@ static uint64_t total_ram(void)
 	return 0;
 }
 
-static uint64_t estimate_repack_memory(struct packed_git *pack)
+static uint64_t estimate_repack_memory(struct odb_source_files *files,
+				       struct packed_git *pack)
 {
 	unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
 	unsigned long nr_objects;
 	size_t os_cache, heap;
 
-	if (odb_count_objects(the_repository->objects,
-			      ODB_COUNT_OBJECTS_APPROXIMATE, &nr_objects) < 0)
+	if (odb_source_count_objects(&files->base, ODB_COUNT_OBJECTS_APPROXIMATE,
+				     &nr_objects) < 0)
 		return 0;
 
 	if (!pack || !nr_objects)
@@ -679,6 +679,8 @@ static void add_repack_incremental_option(struct strvec *args)
 static bool odb_optimize_required(struct object_database *odb,
 				  const struct odb_optimize_options *opts)
 {
+	struct odb_source_files *files = odb_source_files_downcast(odb->sources);
+
 	switch (opts->strategy) {
 	case ODB_OPTIMIZE_INCREMENTAL: {
 		int gc_auto_threshold = 6700;
@@ -693,8 +695,8 @@ static bool odb_optimize_required(struct object_database *odb,
 		 */
 		if (gc_auto_threshold <= 0)
 			return false;
-		if (!too_many_packs(gc_auto_pack_limit) &&
-		    !too_many_loose_objects(gc_auto_threshold))
+		if (!too_many_packs(files, gc_auto_pack_limit) &&
+		    !too_many_loose_objects(files, gc_auto_threshold))
 			return false;
 
 		return true;
@@ -739,7 +741,7 @@ static bool odb_optimize_required(struct object_database *odb,
 		 * Otherwise, we estimate the number of loose objects to determine
 		 * whether we want to create a new packfile or not.
 		 */
-		if (too_many_loose_objects(auto_value)) {
+		if (too_many_loose_objects(files, auto_value)) {
 			ret = true;
 			goto out;
 		}
@@ -886,21 +888,22 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
 static int odb_optimize(struct object_database *odb,
 			const struct odb_optimize_options *opts)
 {
+	struct odb_source_files *files = odb_source_files_downcast(odb->sources);
 	struct child_process repack_cmd = CHILD_PROCESS_INIT;
 	unsigned long big_pack_threshold = 0;
 	int gc_auto_threshold = 6700;
 	int gc_auto_pack_limit = 50;
 	int ret;
 
-	repo_config_get_int(the_repository, "gc.auto", &gc_auto_threshold);
-	repo_config_get_int(the_repository, "gc.autopacklimit", &gc_auto_pack_limit);
-	repo_config_get_ulong(the_repository, "gc.bigpackthreshold", &big_pack_threshold);
+	repo_config_get_int(odb->repo, "gc.auto", &gc_auto_threshold);
+	repo_config_get_int(odb->repo, "gc.autopacklimit", &gc_auto_pack_limit);
+	repo_config_get_ulong(odb->repo, "gc.bigpackthreshold", &big_pack_threshold);
 
 	if (odb->repo->repository_format_precious_objects)
 		return 0;
 
 	repack_cmd.git_cmd = 1;
-	repack_cmd.odb_to_close = the_repository->objects;
+	repack_cmd.odb_to_close = odb->repo->objects;
 
 	strvec_pushl(&repack_cmd.args, "repack", "-d", "-l", NULL);
 	if (opts->flags & ODB_OPTIMIZE_NO_REUSE_DELTAS)
@@ -930,29 +933,29 @@ static int odb_optimize(struct object_database *odb,
 
 			if (opts->keep_largest_pack != -1) {
 				if (opts->keep_largest_pack)
-					find_base_packs(&keep_pack, 0);
+					find_base_packs(files, &keep_pack, 0);
 			} else if (big_pack_threshold) {
-				find_base_packs(&keep_pack, big_pack_threshold);
+				find_base_packs(files, &keep_pack, big_pack_threshold);
 			}
 
 			add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
 			string_list_clear(&keep_pack, 0);
 		} else {
-			if (too_many_packs(gc_auto_pack_limit)) {
+			if (too_many_packs(files, gc_auto_pack_limit)) {
 				struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
 				if (big_pack_threshold) {
-					find_base_packs(&keep_pack, big_pack_threshold);
+					find_base_packs(files, &keep_pack, big_pack_threshold);
 					if (keep_pack.nr >= gc_auto_pack_limit) {
 						string_list_clear(&keep_pack, 0);
-						find_base_packs(&keep_pack, 0);
+						find_base_packs(files, &keep_pack, 0);
 					}
 				} else {
-					struct packed_git *p = find_base_packs(&keep_pack, 0);
+					struct packed_git *p = find_base_packs(files, &keep_pack, 0);
 					uint64_t mem_have, mem_want;
 
 					mem_have = total_ram();
-					mem_want = estimate_repack_memory(p);
+					mem_want = estimate_repack_memory(files, p);
 
 					/*
 					 * Only allow 1/2 of memory for pack-objects, leave
@@ -981,10 +984,10 @@ static int odb_optimize(struct object_database *odb,
 		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
 		struct string_list kept_packs = STRING_LIST_INIT_DUP;
 
-		repo_config_get_int(the_repository, "maintenance.geometric-repack.splitFactor",
+		repo_config_get_int(odb->repo, "maintenance.geometric-repack.splitFactor",
 				    &geometry.split_factor);
 
-		existing_packs.repo = the_repository;
+		existing_packs.repo = odb->repo;
 		existing_packs_collect(&existing_packs, &kept_packs);
 		pack_geometry_init(&geometry, &existing_packs, &po_args);
 		pack_geometry_split(&geometry);
@@ -995,7 +998,7 @@ static int odb_optimize(struct object_database *odb,
 		} else {
 			add_repack_all_option(opts, NULL, &repack_cmd.args);
 		}
-		if (the_repository->settings.core_multi_pack_index)
+		if (odb->repo->settings.core_multi_pack_index)
 			strvec_push(&repack_cmd.args, "--write-midx");
 
 		existing_packs_release(&existing_packs);
@@ -1020,7 +1023,7 @@ static int odb_optimize(struct object_database *odb,
 		strvec_push(&prune_cmd.args, opts->prune_expire);
 		if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
 			strvec_push(&prune_cmd.args, "--no-progress");
-		if (repo_has_promisor_remote(the_repository))
+		if (repo_has_promisor_remote(odb->repo))
 			strvec_push(&prune_cmd.args,
 				    "--exclude-promisor-objects");
 		prune_cmd.git_cmd = 1;
@@ -1031,7 +1034,7 @@ static int odb_optimize(struct object_database *odb,
 		}
 	}
 
-	if (opts->flags & ODB_OPTIMIZE_AUTO && too_many_loose_objects(gc_auto_threshold))
+	if (opts->flags & ODB_OPTIMIZE_AUTO && too_many_loose_objects(files, gc_auto_threshold))
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 

-- 
2.55.0.141.g00534a21ce.dirty

