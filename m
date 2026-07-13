Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB653612E7
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921963; cv=none; b=gMhS5HMnekVtvuVSCE9t67JoXuiUdUkbKSPoE7+a1Z6u78iJShv/zouqJqXPKAnykqqI8SciICb7TENtJMgoPfLU1RcwS491EvAN7KZIoSf4ZGZ/3Ixgnl/aTwfODFREmRIq2GawRAPgR7TxIAISLKRGzg1HyhpSj4lwQy3sC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921963; c=relaxed/simple;
	bh=5JkGElOu68veJFpIN1JaQZHqDql8/XfyREb7qQFjHoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=seSYL7yOpYendey3qqEx9yDd8vG+8sN9MNOSxADQQQCRs865IQXShVweUrl+XOhqOBG1YuY4tgk9/nSiAf4fecLcpEaOO6b7lsEWQITSPQnWobtEAWLQpgm2TB95OQGthSQ5ljOMUluXa8nV8EINl8z86bS5Mc2qerxDNxdFGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7eajIC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1oI+Wp2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7eajIC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1oI+Wp2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 46719EC013B;
	Mon, 13 Jul 2026 01:52:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 01:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921961;
	 x=1784008361; bh=OSh5psztk6xKqlgahXdotg92v7Wu+bP3NBoyTn3l7hw=; b=
	M7eajIC4w+TEAXh+D3iP8zFRPjwbCwCNqLhWBZeHKz8FIJEpi7TfUmAHKThRYTLR
	KlAUdf1vnCVCTwgymR0vnyCbnQLTSqfyO80ynA8d5PFyEiDnbEKED9Way9nqEuOQ
	mtI1d0y3IfNdR8we3KZWq0H5oWXvS5qUr9fC5UAasKq5g7YUjaHxlKqxOkw/sGmm
	KtRg3miIxRTzKD/XILN73zrF37MIVMtfHzWeAtGBBn3qqPH7D866cSVxszmwkvtk
	FahPx8pcJZbChjAKOCsMq+anth09YJMUcysB0ePeaA4zFRbTTiEkxJABEZYv8hcA
	FvD6OI0LASBLWHEtotv4Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921961; x=
	1784008361; bh=OSh5psztk6xKqlgahXdotg92v7Wu+bP3NBoyTn3l7hw=; b=F
	1oI+Wp2MnmspSutUBZc107UQ4gDBmxcCR8aaJi5IDNDoa3XlB0zKwC9k3TWKEt+s
	JXxiVWIl06SlPSMDQqqyDb/29Q1PTArpczbsGdqIuwt8GhepRdxiiNGzWO5d+GVF
	9I6+Iy+wl4k1GWe5s8XtTsQZxA5C4Kjr4YI/8xf5JZQR0/c55kRCaL8wU91NK4zT
	VGiNfm/lRJnnbHtgjrigdMkonmTYnUQHAvuTWBwsgvZ/UvuKUPGMFcBOB8mpkTL0
	l2lQrj4I/Ygp1weG845Rz/RrCoolPcCP2XXHTOBPbhAAy+OEMFkQPizitQ4a1Zw4
	v0XgUi6Q+Zl9d1ghG9WYw==
X-ME-Sender: <xms:KX1Uauawvos4pZ1Id5j845qbsV7SxQpbPfrYKYD2MUpIxm3BLjFvqA>
    <xme:KX1UanaVuzO75tG5Zf6STZXMJMiHRCGvJBy_tvauUPK7C0NUeSE3O3tEmJXg1mfxL
    vEaeV1ZWBgwtmOCxheOM3D6LAomj6Q-Ux0ejBwhaUDdWrbIlu83O9A>
X-ME-Received: <xmr:KX1UammdN-BXzCHlBZR31o2UrDUA7B_SrYfnLpyU-v_plRgeXMi-_-7oM6a2APIGBNwaEvo1p3ceeh_PEUD2z3KKzt07zvgDEubzmc5Q>
X-ME-Proxy-Cause: dmFkZTE2DwhiZeVd7s4BnOPVbBPXP1kZFTu6+TvJ2QfwCaPIfyeEJyQFod28bhJlHOLJFP
    nAxQLb9PyOO9WVRa0i1G4bQ7dN8ngY1INL+0iXLC5+UJ0NuVeK2EeEXubgho5kIiQKgwPD
    JabziqXomO03uQOEO12TgFiGlVlkIpLppS8snC/PmmXtFgM/sab6L7D5RPZS6GbJ1No3/6
    buMEU3X2Y9352yqKjFjBzD1THQoyUyJS+xnXCQzTukbErdh0mTxzV0KhTGfuuFWgqPqU6c
    0XJGk/CB1ffydb4y2My9Bbz//9Ylvn5KE8OIP3L7iVlloga1alcLHwg7BNDbyp1ynMoOjR
    7ZxeAs3Angua8BOIUpl0ci3eLwQUo6TRQK54Hpdh5gvfApNsCu6XM57EkBADYcMHTEK6x+
    iK8E3+8NWw406rO443cdXYQIwByzFLhD7qID/jTCX1H8kk8X4pr2sxU4Gc9NSfeAolUBft
    zsESgEB3jquhJBEQw+wSTAl/WGrwtQi6AmV100Wg1BEPtGP7OBarpNU+y5YLXRuYS8EhEr
    oX+pEQXICQwqkknRWS7UapEYMA3A9oZN2OeqFn9HAUKq+6rqPm++v7Nqh/ZN54h00fOpvZ
    aKsSVEGYHtFaAVIVIqVUqP0yWhpNLipbBjQTWbCcItrNG87pOulnSrUX32NA
X-ME-Proxy: <xmx:KX1UarykwMFGaFBuNqefSgVeTaMAe8WYN3YvM7Twx3qfAA29uHq6KQ>
    <xmx:KX1UasOJHWK5DsIftrCPdehrewixWMlfHg39e2bT-YPyAYh0f92nqQ>
    <xmx:KX1UanTFtAedQGlTWVfkRM1VNbDWOpUD5mksxemaCfM-zsERc4TYRw>
    <xmx:KX1Uaib94ivf8x9OWnVA5du4jOQFHblZgQn56hYnl8qNP5yUNLd5aA>
    <xmx:KX1UahwqLDgKTj7dXJbFBJE8kt3B4OYAdLww9yLhdI936nW6Oi1jSOdR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 65a5555a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:13 +0200
Subject: [PATCH v2 10/12] builtin/gc: refactor ODB optimizations to operate
 on "files" source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-10-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

