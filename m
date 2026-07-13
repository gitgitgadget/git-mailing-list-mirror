Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D414360EF6
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921969; cv=none; b=tYK+MwXWFZh6Dghzol/+DGxNXkBOpra4i0yIvlm5lVdw/AuPkh/hHMQYLPCXUd67vGWprxPZhAYtOVjZV+H76gwRXswim4pDHxC7q1lnFdORlacaQ+VLGLeLe94B7W4vDkd9tpMdFBWXNUU76mXByYjFyohWz5nzGiqbHJnNOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921969; c=relaxed/simple;
	bh=0LxQn5Ix0L64IGVcR0QYIxydE08W1J3vPJ8guHjYpHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DKAvS2byKgCumXCfkil/XfgyiuQGD8V9rnIxBYkFBbGTKjzc1qyQevaoYfF+pW82NV3OZo7e3g0ToYTNOd5q4P32XyQ7e18g8A8W+tBJbf+Z8ikvA33PZdDjJwcl0WKqIx95Ya//qOSsU01lscDpP/71K9doMEL7GPohuDxlxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/o05kMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTpSdbGO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/o05kMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTpSdbGO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 22C1C140005B;
	Mon, 13 Jul 2026 01:52:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 01:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921966;
	 x=1784008366; bh=98iK47pNhIIkYgqmV6F1eq8CnfyqEPnz/s5ufP42qBU=; b=
	M/o05kMAQ01j2EhtWPuRAkfi0wE6gAZ4geP7gpCYyoG5bBCulVlokrS1PLedBdko
	IwwwasfVGRo3qEEEpVO7NQJPTP+W7lAJLJQW4L6s4yxwnd8OR1lhjMPTXJ6fl5FF
	arKUBb4Re6AbJoaHMR6lfDVhudT8JhFWRzDLphhHb1sBVafk3P07AU1msebiMg6F
	MmRuykVQYfDgiSzkjLrzw4nBtnDhKKgCl5e6OTdC+86GA3mfUO56ye+B4fuY+CMm
	HnVzmyWMeAx1Z01pCcEECb1UDJ0eS1++VFjFVIybPJTffP5p7r00VTLu8z5toY1I
	PgwJ6Jh/nnbHpITLyMFobQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921966; x=
	1784008366; bh=98iK47pNhIIkYgqmV6F1eq8CnfyqEPnz/s5ufP42qBU=; b=r
	TpSdbGObIdyESZvzXBxdEBCwPR4E2DxoyrCZmMMpkRtXRzYP6Mq4KkCnfsdES3uy
	Lp6kJ1Ab1dJQHrYbAdwzY/TAQ/lzk2wvR7Ep76ROcz/rMOZD5HGtkhGDqULtzrFM
	CMzj8EZ4kuQA7dALCEnjA1u0XOYsPRhI26x4PLhy393KmjFFhuA10YKmiNaOnqiB
	bMvOiMiph+Dd4EwRFTxnAfGaLxVohwaeEXrHEIv3t1wmOGaOI7IpJ3DD21yNEVre
	cTXDRPAqAxbgLGQPJDsEbCp+Pf3idhVR9nKXCOIrPzDHK9rT1eWuDlLfzoUK6Kf7
	41PRd9cUD/auPjDiI5YCw==
X-ME-Sender: <xms:LX1UapbVbRsjw6QB51Cbl1TU6uWbtkkpjC-kfVLsW4ddqHKKz0IP9A>
    <xme:LX1UamZUhC48YT-iu_i5-dJL_6XZ3yXrLrBS1saVqHNjD-gY7VbttpJcjQYxVrVUO
    2ytIJbrtcDSeUFk93w6rDkfHfpnj1g6sUZdcOljgXMp70PpRF_w_IA>
X-ME-Received: <xmr:LX1UapmJfChUkiH2mRTFuztldweskzV4DBooX31deJnm1XjFX9AlNwOv4R79Diux923WQa_hD2Pm6B_81IoB61eFPF_eIoz9F8yKwgj8>
X-ME-Proxy-Cause: dmFkZTFpRZHzFF0cadud3kQ7W1YCQBWUhBAdvmPgDT1hhW+kCzY5uaMFg66xdsMBvwnOEi
    M5+tgKwnf6y7czN9dg56aykoi1q5020ya+mZCgZp4MpdIPhjwjIdr0NN+xGxVfV1DxQ4m5
    jNQT2IRbG0t2yp7XiH+5P/dgMS0yRmNxpvuHUazTLfugHNtbpxDxIaupFYBy/UDYzXf4ae
    UhiW0WldhvQmqsGC7zQchWBuaLfzGWD3Yw0TqEKnBjQlhT2KQAD7b36yIdzna3KSyPXbZF
    TFedA855HmeLI+2HIRU0Zg22vUinQiLXJy6ERPoUt2lp++ysoIt5bcgXsMKycb7XxwPOG/
    sS3G/nFhHKulZUkIvW/0/titvOkc4E+M+JpQwMZsRYPpnBD/RJgsu+h81BLsIZBUPUWbVO
    Faj2SPaszcAPuZeMZtHyt/624kkydvPJjAiJUxrVudYAvy9IzZxMMaMdqpy5OB1NpFiEYu
    9Jah8prZ9H3AiCwdzsbOZU5KwNIQ7ALRKxOb5td+NF0EXM0ywpNgvRfv5TwacFhvjhF7Pe
    6FWlg5ufqgynfR6z1cDmjZOf+T+Dn5bjSzaI8AGrj2A9nEYkQKhmqCkA35KkVr83KamFLt
    mCwPDsFBW3CDOocYZaeEfnhK3e92trKUXJbCAR425/Ulc03gFMWyAoS6o7tA
X-ME-Proxy: <xmx:Ln1UaixVjM87UOzy7flH_WQlKTzk04iqd5jV0Dij0VWr4ilvPx2Exg>
    <xmx:Ln1UanNJnAntiDlkoKIlreSuZYKqelTD-PSL-6Hi63yY5VGjAL0dBQ>
    <xmx:Ln1UamSDJI9D8tu4BNnT9ZSluQBirAWsW1ppKcRkf_72qhU_wC72sQ>
    <xmx:Ln1UalZ8XHS5211E9Kj4gwNJq6cw1-j1uyCRvssG2UMk9WSYFtPqCQ>
    <xmx:Ln1UasxmOyVPX0F9u5pPaFLwdjySU4Kqs0x3Eb7ZTFgW6GR0pA3D4FjQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e163542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:15 +0200
Subject: [PATCH v2 12/12] odb: make optimizations pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-12-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_optimize()` and `odb_optimize_required()` from "builtin/gc.c"
into the "files" source and wire them up via newly introduced vtable
pointers for the object database sources. This makes the logic pluggable
and thus allows other backends to have their own, custom implementation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c       | 490 +----------------------------------------------------
 odb.c              |  12 ++
 odb.h              |  45 +++++
 odb/source-files.c | 470 ++++++++++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.h |  15 ++
 odb/source.h       |  36 ++++
 6 files changed, 579 insertions(+), 489 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8cf3781313..ac1a21e912 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -30,16 +30,11 @@
 #include "commit-graph.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "pack.h"
-#include "pack-objects.h"
+#include "odb.h"
 #include "path.h"
 #include "reflog.h"
-#include "repack.h"
 #include "rerere.h"
 #include "revision.h"
-#include "blob.h"
-#include "tree.h"
-#include "promisor-remote.h"
 #include "refs.h"
 #include "remote.h"
 #include "exec-cmd.h"
@@ -428,203 +423,6 @@ static int rerere_gc_condition(struct gc_config *cfg UNUSED)
 	return should_gc;
 }
 
-static int too_many_loose_objects(struct odb_source_files *files, int limit)
-{
-	unsigned long loose_count;
-
-	if (limit <= 0)
-		return 0;
-
-	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
-				     &loose_count) < 0)
-		return 0;
-
-	/*
-	 * This is weird, but stems from legacy behaviour: the GC auto
-	 * threshold was always essentially interpreted as if it was rounded up
-	 * to the next multiple 256 of, so we retain this behaviour for now.
-	 */
-	return loose_count > (DIV_ROUND_UP(((unsigned long) limit), 256) * 256);
-}
-
-static struct packed_git *find_base_packs(struct odb_source_files *files,
-					  struct string_list *packs,
-					  unsigned long limit)
-{
-	struct packfile_list_entry *e;
-	struct packed_git *base = NULL;
-
-	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
-		if (e->pack->is_cruft)
-			continue;
-		if (limit) {
-			if ((uintmax_t) e->pack->pack_size >= limit)
-				string_list_append(packs, e->pack->pack_name);
-		} else if (!base || base->pack_size < e->pack->pack_size) {
-			base = e->pack;
-		}
-	}
-
-	if (base)
-		string_list_append(packs, base->pack_name);
-
-	return base;
-}
-
-static int too_many_packs(struct odb_source_files *files, int gc_auto_pack_limit)
-{
-	struct packfile_list_entry *e;
-	int cnt = 0;
-
-	if (gc_auto_pack_limit <= 0)
-		return 0;
-
-	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
-		if (e->pack->pack_keep)
-			continue;
-		/*
-		 * Perhaps check the size of the pack and count only
-		 * very small ones here?
-		 */
-		cnt++;
-	}
-	return gc_auto_pack_limit < cnt;
-}
-
-static uint64_t total_ram(void)
-{
-#if defined(HAVE_SYSINFO)
-	struct sysinfo si;
-
-	if (!sysinfo(&si)) {
-		uint64_t total = si.totalram;
-
-		if (si.mem_unit > 1)
-			total *= (uint64_t)si.mem_unit;
-		return total;
-	}
-#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	uint64_t physical_memory;
-	int mib[2];
-	size_t length;
-
-	mib[0] = CTL_HW;
-# if defined(HW_MEMSIZE)
-	mib[1] = HW_MEMSIZE;
-# elif defined(HW_PHYSMEM64)
-	mib[1] = HW_PHYSMEM64;
-# else
-	mib[1] = HW_PHYSMEM;
-# endif
-	length = sizeof(physical_memory);
-	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
-		if (length == 4) {
-			uint32_t mem;
-
-			if (!sysctl(mib, 2, &mem, &length, NULL, 0))
-				physical_memory = mem;
-		}
-		return physical_memory;
-	}
-#elif defined(GIT_WINDOWS_NATIVE)
-	MEMORYSTATUSEX memInfo;
-
-	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
-	if (GlobalMemoryStatusEx(&memInfo))
-		return memInfo.ullTotalPhys;
-#endif
-	return 0;
-}
-
-static uint64_t estimate_repack_memory(struct odb_source_files *files,
-				       struct packed_git *pack)
-{
-	unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
-	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
-	unsigned long nr_objects;
-	size_t os_cache, heap;
-
-	if (odb_source_count_objects(&files->base, ODB_COUNT_OBJECTS_APPROXIMATE,
-				     &nr_objects) < 0)
-		return 0;
-
-	if (!pack || !nr_objects)
-		return 0;
-
-	repo_config_get_ulong(the_repository, "pack.deltacachesize", &max_delta_cache_size);
-	repo_config_get_ulong(the_repository, "core.deltabasecachelimit", &delta_base_cache_limit);
-
-	/*
-	 * First we have to scan through at least one pack.
-	 * Assume enough room in OS file cache to keep the entire pack
-	 * or we may accidentally evict data of other processes from
-	 * the cache.
-	 */
-	os_cache = pack->pack_size + pack->index_size;
-	/* then pack-objects needs lots more for book keeping */
-	heap = sizeof(struct object_entry) * nr_objects;
-	/*
-	 * internal rev-list --all --objects takes up some memory too,
-	 * let's say half of it is for blobs
-	 */
-	heap += sizeof(struct blob) * nr_objects / 2;
-	/*
-	 * and the other half is for trees (commits and tags are
-	 * usually insignificant)
-	 */
-	heap += sizeof(struct tree) * nr_objects / 2;
-	/* and then obj_hash[], underestimated in fact */
-	heap += sizeof(struct object *) * nr_objects;
-	/* revindex is used also */
-	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
-	/*
-	 * read_sha1_file() (either at delta calculation phase, or
-	 * writing phase) also fills up the delta base cache
-	 */
-	heap += delta_base_cache_limit;
-	/* and of course pack-objects has its own delta cache */
-	heap += max_delta_cache_size;
-
-	return os_cache + heap;
-}
-
-static int keep_one_pack(struct string_list_item *item, void *data)
-{
-	struct strvec *args = data;
-	strvec_pushf(args, "--keep-pack=%s", basename(item->string));
-	return 0;
-}
-
-enum odb_optimize_strategy {
-	ODB_OPTIMIZE_INCREMENTAL,
-	ODB_OPTIMIZE_GEOMETRIC,
-};
-
-enum odb_optimize_flags {
-	/* Enable verbose logging and progress reporting. */
-	ODB_OPTIMIZE_VERBOSE = (1 << 0),
-
-	/* Perform auto-maintenance, only optimizing objects as required. */
-	ODB_OPTIMIZE_AUTO = (1 << 1),
-
-	/* Recompute existing deltas. */
-	ODB_OPTIMIZE_NO_REUSE_DELTAS = (1 << 2),
-};
-
-struct odb_optimize_options {
-	enum odb_optimize_strategy strategy;
-	enum odb_optimize_flags flags;
-	const char *prune_expire;
-	const char *expire_to;
-	int depth;
-	int window;
-
-	/* Backend-specific options. */
-	int keep_largest_pack;
-	int cruft_packs;
-	unsigned long max_cruft_size;
-};
-
 #define OPTIMIZE_FIELDS_FROM_GC_CONFIG(cfg, aggressive) \
 	.prune_expire = (cfg)->prune_expire, \
 	.expire_to = (cfg)->repack_expire_to, \
@@ -633,133 +431,6 @@ struct odb_optimize_options {
 	.window = (aggressive) ? (cfg)->aggressive_window : 0, \
 	.depth = (aggressive) ? (cfg)->aggressive_depth : 0
 
-static void add_repack_all_option(const struct odb_optimize_options *opts,
-				  struct string_list *keep_pack,
-				  struct strvec *args)
-{
-	char *repack_filter = NULL;
-	char *repack_filter_to = NULL;
-
-	repo_config_get_string(the_repository, "gc.repackfilter", &repack_filter);
-	repo_config_get_string(the_repository, "gc.repackfilterto", &repack_filter_to);
-
-	if (opts->prune_expire && !strcmp(opts->prune_expire, "now") &&
-	    !(opts->cruft_packs && opts->expire_to))
-		strvec_push(args, "-a");
-	else if (opts->cruft_packs) {
-		strvec_push(args, "--cruft");
-		if (opts->prune_expire)
-			strvec_pushf(args, "--cruft-expiration=%s", opts->prune_expire);
-		if (opts->max_cruft_size)
-			strvec_pushf(args, "--max-cruft-size=%lu",
-				     opts->max_cruft_size);
-		if (opts->expire_to)
-			strvec_pushf(args, "--expire-to=%s", opts->expire_to);
-	} else {
-		strvec_push(args, "-A");
-		if (opts->prune_expire)
-			strvec_pushf(args, "--unpack-unreachable=%s", opts->prune_expire);
-	}
-
-	if (keep_pack)
-		for_each_string_list(keep_pack, keep_one_pack, args);
-
-	if (repack_filter && *repack_filter)
-		strvec_pushf(args, "--filter=%s", repack_filter);
-	if (repack_filter_to && *repack_filter_to)
-		strvec_pushf(args, "--filter-to=%s", repack_filter_to);
-
-	free(repack_filter);
-	free(repack_filter_to);
-}
-
-static void add_repack_incremental_option(struct strvec *args)
-{
-	strvec_push(args, "--no-write-bitmap-index");
-}
-
-static bool odb_optimize_required(struct object_database *odb,
-				  const struct odb_optimize_options *opts)
-{
-	struct odb_source_files *files = odb_source_files_downcast(odb->sources);
-
-	switch (opts->strategy) {
-	case ODB_OPTIMIZE_INCREMENTAL: {
-		int gc_auto_threshold = 6700;
-		int gc_auto_pack_limit = 50;
-
-		repo_config_get_int(odb->repo, "gc.auto", &gc_auto_threshold);
-		repo_config_get_int(odb->repo, "gc.autopacklimit", &gc_auto_pack_limit);
-
-		/*
-		 * Setting gc.auto to 0 or negative can disable the
-		 * automatic gc.
-		 */
-		if (gc_auto_threshold <= 0)
-			return false;
-		if (!too_many_packs(files, gc_auto_pack_limit) &&
-		    !too_many_loose_objects(files, gc_auto_threshold))
-			return false;
-
-		return true;
-	}
-	case ODB_OPTIMIZE_GEOMETRIC: {
-		struct pack_geometry geometry = {
-			.split_factor = 2,
-		};
-		struct pack_objects_args po_args = {
-			.local = 1,
-		};
-		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
-		struct string_list kept_packs = STRING_LIST_INIT_DUP;
-		int auto_value = 100;
-		bool ret;
-
-		repo_config_get_int(odb->repo, "maintenance.geometric-repack.auto",
-				    &auto_value);
-		if (!auto_value)
-			return false;
-		if (auto_value < 0)
-			return true;
-
-		repo_config_get_int(odb->repo, "maintenance.geometric-repack.splitFactor",
-				    &geometry.split_factor);
-
-		existing_packs.repo = odb->repo;
-		existing_packs_collect(&existing_packs, &kept_packs);
-		pack_geometry_init(&geometry, &existing_packs, &po_args);
-		pack_geometry_split(&geometry);
-
-		/*
-		 * When we'd merge at least two packs with one another we always
-		 * perform the repack.
-		 */
-		if (geometry.split) {
-			ret = true;
-			goto out;
-		}
-
-		/*
-		 * Otherwise, we estimate the number of loose objects to determine
-		 * whether we want to create a new packfile or not.
-		 */
-		if (too_many_loose_objects(files, auto_value)) {
-			ret = true;
-			goto out;
-		}
-
-		ret = false;
-
-	out:
-		existing_packs_release(&existing_packs);
-		pack_geometry_release(&geometry);
-		return ret;
-	}
-	default:
-		BUG("unknown maintenance strategy '%d'", opts->strategy);
-	}
-}
-
 /* return NULL on success, else hostname running the gc */
 static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 {
@@ -887,165 +558,6 @@ static int gc_foreground_tasks(struct maintenance_run_opts *opts,
 	return 0;
 }
 
-static int odb_optimize(struct object_database *odb,
-			const struct odb_optimize_options *opts)
-{
-	struct odb_source_files *files = odb_source_files_downcast(odb->sources);
-	struct child_process repack_cmd = CHILD_PROCESS_INIT;
-	unsigned long big_pack_threshold = 0;
-	int gc_auto_threshold = 6700;
-	int gc_auto_pack_limit = 50;
-	int ret;
-
-	repo_config_get_int(odb->repo, "gc.auto", &gc_auto_threshold);
-	repo_config_get_int(odb->repo, "gc.autopacklimit", &gc_auto_pack_limit);
-	repo_config_get_ulong(odb->repo, "gc.bigpackthreshold", &big_pack_threshold);
-
-	if (odb->repo->repository_format_precious_objects)
-		return 0;
-
-	repack_cmd.git_cmd = 1;
-	repack_cmd.odb_to_close = odb->repo->objects;
-
-	strvec_pushl(&repack_cmd.args, "repack", "-d", "-l", NULL);
-	if (opts->flags & ODB_OPTIMIZE_NO_REUSE_DELTAS)
-		strvec_push(&repack_cmd.args, "-f");
-	if (opts->depth > 0)
-		strvec_pushf(&repack_cmd.args, "--depth=%d", opts->depth);
-	if (opts->window > 0)
-		strvec_pushf(&repack_cmd.args, "--window=%d", opts->window);
-	if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
-		strvec_push(&repack_cmd.args, "-q");
-
-	/*
-	 * There's three cases we need to consider:
-	 *
-	 *   - If we're invoked without `--auto` we'll need to perform a full
-	 *     repack.
-	 *
-	 *   - If we're invoked with `--auto` and there's too many packs, then
-	 *     we perform a full repack, as well.
-	 *
-	 *   - Otherwise we perform an incremental repack.
-	 */
-	switch (opts->strategy) {
-	case ODB_OPTIMIZE_INCREMENTAL:
-		if (!(opts->flags & ODB_OPTIMIZE_AUTO)) {
-			struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-			if (opts->keep_largest_pack != -1) {
-				if (opts->keep_largest_pack)
-					find_base_packs(files, &keep_pack, 0);
-			} else if (big_pack_threshold) {
-				find_base_packs(files, &keep_pack, big_pack_threshold);
-			}
-
-			add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
-			string_list_clear(&keep_pack, 0);
-		} else {
-			if (too_many_packs(files, gc_auto_pack_limit)) {
-				struct string_list keep_pack = STRING_LIST_INIT_NODUP;
-
-				if (big_pack_threshold) {
-					find_base_packs(files, &keep_pack, big_pack_threshold);
-					if (keep_pack.nr >= (unsigned long) gc_auto_pack_limit) {
-						string_list_clear(&keep_pack, 0);
-						find_base_packs(files, &keep_pack, 0);
-					}
-				} else {
-					struct packed_git *p = find_base_packs(files, &keep_pack, 0);
-					uint64_t mem_have, mem_want;
-
-					mem_have = total_ram();
-					mem_want = estimate_repack_memory(files, p);
-
-					/*
-					 * Only allow 1/2 of memory for pack-objects, leave
-					 * the rest for the OS and other processes in the
-					 * system.
-					 */
-					if (!mem_have || mem_want < mem_have / 2)
-						string_list_clear(&keep_pack, 0);
-				}
-
-				add_repack_all_option(opts, &keep_pack, &repack_cmd.args);
-				string_list_clear(&keep_pack, 0);
-			} else {
-				add_repack_incremental_option(&repack_cmd.args);
-			}
-		}
-
-		break;
-	case ODB_OPTIMIZE_GEOMETRIC: {
-		struct pack_geometry geometry = {
-			.split_factor = 2,
-		};
-		struct pack_objects_args po_args = {
-			.local = 1,
-		};
-		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
-		struct string_list kept_packs = STRING_LIST_INIT_DUP;
-
-		repo_config_get_int(odb->repo, "maintenance.geometric-repack.splitFactor",
-				    &geometry.split_factor);
-
-		existing_packs.repo = odb->repo;
-		existing_packs_collect(&existing_packs, &kept_packs);
-		pack_geometry_init(&geometry, &existing_packs, &po_args);
-		pack_geometry_split(&geometry);
-
-		if (geometry.split < geometry.pack_nr) {
-			strvec_pushf(&repack_cmd.args, "--geometric=%d",
-				     geometry.split_factor);
-		} else {
-			add_repack_all_option(opts, NULL, &repack_cmd.args);
-		}
-		if (odb->repo->settings.core_multi_pack_index)
-			strvec_push(&repack_cmd.args, "--write-midx");
-
-		existing_packs_release(&existing_packs);
-		pack_geometry_release(&geometry);
-		break;
-	}
-	default:
-		die("unknown maintenance strategy '%d'", opts->strategy);
-	}
-
-	if (run_command(&repack_cmd)) {
-		ret = error(FAILED_RUN, repack_cmd.args.v[0]);
-		goto out;
-	}
-
-	/* Geometric repacking uses cruft packs, so we don't have to prune separately. */
-	if (opts->strategy != ODB_OPTIMIZE_GEOMETRIC && opts->prune_expire) {
-		struct child_process prune_cmd = CHILD_PROCESS_INIT;
-
-		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
-		/* run `git prune` even if using cruft packs */
-		strvec_push(&prune_cmd.args, opts->prune_expire);
-		if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
-			strvec_push(&prune_cmd.args, "--no-progress");
-		if (repo_has_promisor_remote(odb->repo))
-			strvec_push(&prune_cmd.args,
-				    "--exclude-promisor-objects");
-		prune_cmd.git_cmd = 1;
-
-		if (run_command(&prune_cmd)) {
-			ret = error(FAILED_RUN, prune_cmd.args.v[0]);
-			goto out;
-		}
-	}
-
-	if (opts->flags & ODB_OPTIMIZE_AUTO && too_many_loose_objects(files, gc_auto_threshold))
-		warning(_("There are too many unreachable loose objects; "
-			"run 'git prune' to remove them."));
-
-	ret = 0;
-
-out:
-	return ret;
-}
-
 static int maintenance_task_odb(struct maintenance_run_opts *opts,
 				struct gc_config *cfg,
 				int keep_largest_pack,
diff --git a/odb.c b/odb.c
index 7d555be09f..89660981fe 100644
--- a/odb.c
+++ b/odb.c
@@ -1003,6 +1003,18 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_write_object_stream(odb->sources, stream, len, oid);
 }
 
+int odb_optimize(struct object_database *odb,
+		 const struct odb_optimize_options *opts)
+{
+	return odb_source_optimize(odb->sources, opts);
+}
+
+bool odb_optimize_required(struct object_database *odb,
+			   const struct odb_optimize_options *opts)
+{
+	return odb_source_optimize_required(odb->sources, opts);
+}
+
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
diff --git a/odb.h b/odb.h
index 3834a0dcbf..7e1c85c22e 100644
--- a/odb.h
+++ b/odb.h
@@ -117,6 +117,51 @@ struct object_database *odb_new(struct repository *repo,
 /* Free the object database and release all resources. */
 void odb_free(struct object_database *o);
 
+enum odb_optimize_strategy {
+	ODB_OPTIMIZE_INCREMENTAL,
+	ODB_OPTIMIZE_GEOMETRIC,
+};
+
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
+	enum odb_optimize_strategy strategy;
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
+/*
+ * Optimize the object database. Returns 0 on success, a negative error code
+ * otherwise.
+ */
+int odb_optimize(struct object_database *odb,
+		 const struct odb_optimize_options *opts);
+
+/*
+ * Check whether optimization of the object database is required given the
+ * provided options. Returns true if optimization should be performed, false
+ * otherwise.
+ */
+bool odb_optimize_required(struct object_database *odb,
+			   const struct odb_optimize_options *opts);
+
 /*
  * Close the object database and all of its sources so that any held resources
  * will be released. The database can still be used after closing it, in which
diff --git a/odb/source-files.c b/odb/source-files.c
index bbd1784b33..82cf61da4a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -1,6 +1,8 @@
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "blob.h"
 #include "chdir-notify.h"
+#include "config.h"
 #include "gettext.h"
 #include "lockfile.h"
 #include "object-file.h"
@@ -8,8 +10,16 @@
 #include "odb/source.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
+#include "pack-objects.h"
 #include "packfile.h"
+#include "path.h"
+#include "promisor-remote.h"
+#include "repack.h"
+#include "run-command.h"
 #include "strbuf.h"
+#include "string-list.h"
+#include "strvec.h"
+#include "tree.h"
 #include "write-or-die.h"
 
 static void odb_source_files_reparent(const char *name UNUSED,
@@ -260,6 +270,464 @@ static int odb_source_files_write_alternate(struct odb_source *source,
 	return ret;
 }
 
+static int too_many_loose_objects(struct odb_source_files *files, int limit)
+{
+	unsigned long loose_count;
+
+	if (limit <= 0)
+		return 0;
+
+	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
+				     &loose_count) < 0)
+		return 0;
+
+	/*
+	 * This is weird, but stems from legacy behaviour: the GC auto
+	 * threshold was always essentially interpreted as if it was rounded up
+	 * to the next multiple 256 of, so we retain this behaviour for now.
+	 */
+	return loose_count > (DIV_ROUND_UP(((unsigned long) limit), 256) * 256);
+}
+
+static struct packed_git *find_base_packs(struct odb_source_files *files,
+					  struct string_list *packs,
+					  unsigned long limit)
+{
+	struct packfile_list_entry *e;
+	struct packed_git *base = NULL;
+
+	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+		if (e->pack->is_cruft)
+			continue;
+		if (limit) {
+			if ((uintmax_t) e->pack->pack_size >= limit)
+				string_list_append(packs, e->pack->pack_name);
+		} else if (!base || base->pack_size < e->pack->pack_size) {
+			base = e->pack;
+		}
+	}
+
+	if (base)
+		string_list_append(packs, base->pack_name);
+
+	return base;
+}
+
+static int too_many_packs(struct odb_source_files *files, int gc_auto_pack_limit)
+{
+	struct packfile_list_entry *e;
+	int cnt = 0;
+
+	if (gc_auto_pack_limit <= 0)
+		return 0;
+
+	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+		if (e->pack->pack_keep)
+			continue;
+		/*
+		 * Perhaps check the size of the pack and count only
+		 * very small ones here?
+		 */
+		cnt++;
+	}
+	return gc_auto_pack_limit < cnt;
+}
+
+static uint64_t total_ram(void)
+{
+#if defined(HAVE_SYSINFO)
+	struct sysinfo si;
+
+	if (!sysinfo(&si)) {
+		uint64_t total = si.totalram;
+
+		if (si.mem_unit > 1)
+			total *= (uint64_t)si.mem_unit;
+		return total;
+	}
+#elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
+	uint64_t physical_memory;
+	int mib[2];
+	size_t length;
+
+	mib[0] = CTL_HW;
+# if defined(HW_MEMSIZE)
+	mib[1] = HW_MEMSIZE;
+# elif defined(HW_PHYSMEM64)
+	mib[1] = HW_PHYSMEM64;
+# else
+	mib[1] = HW_PHYSMEM;
+# endif
+	length = sizeof(physical_memory);
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0)) {
+		if (length == 4) {
+			uint32_t mem;
+
+			if (!sysctl(mib, 2, &mem, &length, NULL, 0))
+				physical_memory = mem;
+		}
+		return physical_memory;
+	}
+#elif defined(GIT_WINDOWS_NATIVE)
+	MEMORYSTATUSEX memInfo;
+
+	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
+	if (GlobalMemoryStatusEx(&memInfo))
+		return memInfo.ullTotalPhys;
+#endif
+	return 0;
+}
+
+static uint64_t estimate_repack_memory(struct odb_source_files *files,
+				       struct packed_git *pack)
+{
+	unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
+	unsigned long nr_objects;
+	size_t os_cache, heap;
+
+	if (odb_source_count_objects(&files->base, ODB_COUNT_OBJECTS_APPROXIMATE,
+				     &nr_objects) < 0)
+		return 0;
+
+	if (!pack || !nr_objects)
+		return 0;
+
+	repo_config_get_ulong(files->base.odb->repo, "pack.deltacachesize",
+			      &max_delta_cache_size);
+	repo_config_get_ulong(files->base.odb->repo, "core.deltabasecachelimit",
+			      &delta_base_cache_limit);
+
+	/*
+	 * First we have to scan through at least one pack.
+	 * Assume enough room in OS file cache to keep the entire pack
+	 * or we may accidentally evict data of other processes from
+	 * the cache.
+	 */
+	os_cache = pack->pack_size + pack->index_size;
+	/* then pack-objects needs lots more for book keeping */
+	heap = sizeof(struct object_entry) * nr_objects;
+	/*
+	 * internal rev-list --all --objects takes up some memory too,
+	 * let's say half of it is for blobs
+	 */
+	heap += sizeof(struct blob) * nr_objects / 2;
+	/*
+	 * and the other half is for trees (commits and tags are
+	 * usually insignificant)
+	 */
+	heap += sizeof(struct tree) * nr_objects / 2;
+	/* and then obj_hash[], underestimated in fact */
+	heap += sizeof(struct object *) * nr_objects;
+	/* revindex is used also */
+	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
+	/*
+	 * read_sha1_file() (either at delta calculation phase, or
+	 * writing phase) also fills up the delta base cache
+	 */
+	heap += delta_base_cache_limit;
+	/* and of course pack-objects has its own delta cache */
+	heap += max_delta_cache_size;
+
+	return os_cache + heap;
+}
+
+static int keep_one_pack(struct string_list_item *item, void *data)
+{
+	struct strvec *args = data;
+	strvec_pushf(args, "--keep-pack=%s", basename(item->string));
+	return 0;
+}
+
+static void add_repack_all_option(struct repository *repo,
+				  const struct odb_optimize_options *opts,
+				  struct string_list *keep_pack,
+				  struct strvec *args)
+{
+	char *repack_filter = NULL;
+	char *repack_filter_to = NULL;
+
+	repo_config_get_string(repo, "gc.repackfilter", &repack_filter);
+	repo_config_get_string(repo, "gc.repackfilterto", &repack_filter_to);
+
+	if (opts->prune_expire && !strcmp(opts->prune_expire, "now") &&
+	    !(opts->cruft_packs && opts->expire_to))
+		strvec_push(args, "-a");
+	else if (opts->cruft_packs) {
+		strvec_push(args, "--cruft");
+		if (opts->prune_expire)
+			strvec_pushf(args, "--cruft-expiration=%s", opts->prune_expire);
+		if (opts->max_cruft_size)
+			strvec_pushf(args, "--max-cruft-size=%lu",
+				     opts->max_cruft_size);
+		if (opts->expire_to)
+			strvec_pushf(args, "--expire-to=%s", opts->expire_to);
+	} else {
+		strvec_push(args, "-A");
+		if (opts->prune_expire)
+			strvec_pushf(args, "--unpack-unreachable=%s", opts->prune_expire);
+	}
+
+	if (keep_pack)
+		for_each_string_list(keep_pack, keep_one_pack, args);
+
+	if (repack_filter && *repack_filter)
+		strvec_pushf(args, "--filter=%s", repack_filter);
+	if (repack_filter_to && *repack_filter_to)
+		strvec_pushf(args, "--filter-to=%s", repack_filter_to);
+
+	free(repack_filter);
+	free(repack_filter_to);
+}
+
+static void add_repack_incremental_option(struct strvec *args)
+{
+	strvec_push(args, "--no-write-bitmap-index");
+}
+
+bool odb_source_files_optimize_required(struct odb_source *source,
+					const struct odb_optimize_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct repository *repo = source->odb->repo;
+
+	switch (opts->strategy) {
+	case ODB_OPTIMIZE_INCREMENTAL: {
+		int gc_auto_threshold = 6700;
+		int gc_auto_pack_limit = 50;
+
+		repo_config_get_int(repo, "gc.auto", &gc_auto_threshold);
+		repo_config_get_int(repo, "gc.autopacklimit", &gc_auto_pack_limit);
+
+		/*
+		 * Setting gc.auto to 0 or negative can disable the
+		 * automatic gc.
+		 */
+		if (gc_auto_threshold <= 0)
+			return false;
+		if (!too_many_packs(files, gc_auto_pack_limit) &&
+		    !too_many_loose_objects(files, gc_auto_threshold))
+			return false;
+
+		return true;
+	}
+	case ODB_OPTIMIZE_GEOMETRIC: {
+		struct pack_geometry geometry = {
+			.split_factor = 2,
+		};
+		struct pack_objects_args po_args = {
+			.local = 1,
+		};
+		struct existing_packs existing_packs = EXISTING_PACKS_INIT;
+		struct string_list kept_packs = STRING_LIST_INIT_DUP;
+		int auto_value = 100;
+		bool ret;
+
+		repo_config_get_int(repo, "maintenance.geometric-repack.auto",
+				    &auto_value);
+		if (!auto_value)
+			return false;
+		if (auto_value < 0)
+			return true;
+
+		repo_config_get_int(repo, "maintenance.geometric-repack.splitFactor",
+				    &geometry.split_factor);
+
+		existing_packs.repo = repo;
+		existing_packs_collect(&existing_packs, &kept_packs);
+		pack_geometry_init(&geometry, &existing_packs, &po_args);
+		pack_geometry_split(&geometry);
+
+		/*
+		 * When we'd merge at least two packs with one another we always
+		 * perform the repack.
+		 */
+		if (geometry.split) {
+			ret = true;
+			goto out;
+		}
+
+		/*
+		 * Otherwise, we estimate the number of loose objects to determine
+		 * whether we want to create a new packfile or not.
+		 */
+		if (too_many_loose_objects(files, auto_value)) {
+			ret = true;
+			goto out;
+		}
+
+		ret = false;
+
+	out:
+		existing_packs_release(&existing_packs);
+		pack_geometry_release(&geometry);
+		return ret;
+	}
+	default:
+		BUG("unknown maintenance strategy '%d'", opts->strategy);
+	}
+}
+
+int odb_source_files_optimize(struct odb_source *source,
+			      const struct odb_optimize_options *opts)
+{
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	struct repository *repo = source->odb->repo;
+	struct child_process repack_cmd = CHILD_PROCESS_INIT;
+	unsigned long big_pack_threshold = 0;
+	int gc_auto_threshold = 6700;
+	int gc_auto_pack_limit = 50;
+	int ret;
+
+	repo_config_get_int(repo, "gc.auto", &gc_auto_threshold);
+	repo_config_get_int(repo, "gc.autopacklimit", &gc_auto_pack_limit);
+	repo_config_get_ulong(repo, "gc.bigpackthreshold", &big_pack_threshold);
+
+	if (repo->repository_format_precious_objects)
+		return 0;
+
+	repack_cmd.git_cmd = 1;
+	repack_cmd.odb_to_close = repo->objects;
+
+	strvec_pushl(&repack_cmd.args, "repack", "-d", "-l", NULL);
+	if (opts->flags & ODB_OPTIMIZE_NO_REUSE_DELTAS)
+		strvec_push(&repack_cmd.args, "-f");
+	if (opts->depth > 0)
+		strvec_pushf(&repack_cmd.args, "--depth=%d", opts->depth);
+	if (opts->window > 0)
+		strvec_pushf(&repack_cmd.args, "--window=%d", opts->window);
+	if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
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
+	switch (opts->strategy) {
+	case ODB_OPTIMIZE_INCREMENTAL:
+		if (!(opts->flags & ODB_OPTIMIZE_AUTO)) {
+			struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+			if (opts->keep_largest_pack != -1) {
+				if (opts->keep_largest_pack)
+					find_base_packs(files, &keep_pack, 0);
+			} else if (big_pack_threshold) {
+				find_base_packs(files, &keep_pack, big_pack_threshold);
+			}
+
+			add_repack_all_option(repo, opts, &keep_pack, &repack_cmd.args);
+			string_list_clear(&keep_pack, 0);
+		} else {
+			if (too_many_packs(files, gc_auto_pack_limit)) {
+				struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+				if (big_pack_threshold) {
+					find_base_packs(files, &keep_pack, big_pack_threshold);
+					if (keep_pack.nr >= (unsigned long) gc_auto_pack_limit) {
+						string_list_clear(&keep_pack, 0);
+						find_base_packs(files, &keep_pack, 0);
+					}
+				} else {
+					struct packed_git *p = find_base_packs(files, &keep_pack, 0);
+					uint64_t mem_have, mem_want;
+
+					mem_have = total_ram();
+					mem_want = estimate_repack_memory(files, p);
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
+				add_repack_all_option(repo, opts, &keep_pack, &repack_cmd.args);
+				string_list_clear(&keep_pack, 0);
+			} else {
+				add_repack_incremental_option(&repack_cmd.args);
+			}
+		}
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
+		repo_config_get_int(repo, "maintenance.geometric-repack.splitFactor",
+				    &geometry.split_factor);
+
+		existing_packs.repo = repo;
+		existing_packs_collect(&existing_packs, &kept_packs);
+		pack_geometry_init(&geometry, &existing_packs, &po_args);
+		pack_geometry_split(&geometry);
+
+		if (geometry.split < geometry.pack_nr) {
+			strvec_pushf(&repack_cmd.args, "--geometric=%d",
+				     geometry.split_factor);
+		} else {
+			add_repack_all_option(repo, opts, NULL, &repack_cmd.args);
+		}
+		if (repo->settings.core_multi_pack_index)
+			strvec_push(&repack_cmd.args, "--write-midx");
+
+		existing_packs_release(&existing_packs);
+		pack_geometry_release(&geometry);
+		break;
+	}
+	default:
+		die("unknown maintenance strategy '%d'", opts->strategy);
+	}
+
+	if (run_command(&repack_cmd)) {
+		ret = error("failed to run %s", repack_cmd.args.v[0]);
+		goto out;
+	}
+
+	/* Geometric repacking uses cruft packs, so we don't have to prune separately. */
+	if (opts->strategy != ODB_OPTIMIZE_GEOMETRIC && opts->prune_expire) {
+		struct child_process prune_cmd = CHILD_PROCESS_INIT;
+
+		strvec_pushl(&prune_cmd.args, "prune", "--expire", NULL);
+		/* run `git prune` even if using cruft packs */
+		strvec_push(&prune_cmd.args, opts->prune_expire);
+		if (!(opts->flags & ODB_OPTIMIZE_VERBOSE))
+			strvec_push(&prune_cmd.args, "--no-progress");
+		if (repo_has_promisor_remote(repo))
+			strvec_push(&prune_cmd.args,
+				    "--exclude-promisor-objects");
+		prune_cmd.git_cmd = 1;
+
+		if (run_command(&prune_cmd)) {
+			ret = error("failed to run %s", prune_cmd.args.v[0]);
+			goto out;
+		}
+	}
+
+	if (opts->flags & ODB_OPTIMIZE_AUTO && too_many_loose_objects(files, gc_auto_threshold))
+		warning(_("There are too many unreachable loose objects; "
+			"run 'git prune' to remove them."));
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -285,6 +753,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.begin_transaction = odb_source_files_begin_transaction;
 	files->base.read_alternates = odb_source_files_read_alternates;
 	files->base.write_alternate = odb_source_files_write_alternate;
+	files->base.optimize = odb_source_files_optimize;
+	files->base.optimize_required = odb_source_files_optimize_required;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source-files.h b/odb/source-files.h
index d7ac3c1c81..044242bc36 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -21,6 +21,21 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local);
 
+/*
+ * Optimize the files object database source by repacking loose objects and
+ * packfiles as needed. Returns 0 on success, a negative error code otherwise.
+ */
+int odb_source_files_optimize(struct odb_source *source,
+			      const struct odb_optimize_options *opts);
+
+/*
+ * Check whether optimization of the files object database source is required
+ * given the provided options. Returns true if optimization should be
+ * performed, false otherwise.
+ */
+bool odb_source_files_optimize_required(struct odb_source *source,
+					const struct odb_optimize_options *opts);
+
 /*
  * Cast the given object database source to the files backend. This will cause
  * a BUG in case the source doesn't use this backend.
diff --git a/odb/source.h b/odb/source.h
index 8767708c9c..88a48ba3c3 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -258,6 +258,21 @@ struct odb_source {
 	 */
 	int (*write_alternate)(struct odb_source *source,
 			       const char *alternate);
+
+	/*
+	 * This callback is expected to optimize the object database source.
+	 * Returns 0 on success, a negative error code otherwise.
+	 */
+	int (*optimize)(struct odb_source *source,
+			const struct odb_optimize_options *opts);
+
+	/*
+	 * This callback is expected to check whether optimization of the
+	 * object database source is required given the provided options.
+	 * Returns true if optimization should be performed, false otherwise.
+	 */
+	bool (*optimize_required)(struct odb_source *source,
+				  const struct odb_optimize_options *opts);
 };
 
 /*
@@ -475,4 +490,25 @@ static inline int odb_source_begin_transaction(struct odb_source *source,
 	return source->begin_transaction(source, out);
 }
 
+/*
+ * Optimize the object database source. Returns 0 on success, a negative error
+ * code otherwise.
+ */
+static inline int odb_source_optimize(struct odb_source *source,
+				      const struct odb_optimize_options *opts)
+{
+	return source->optimize(source, opts);
+}
+
+/*
+ * Check whether optimization of the object database source is required given
+ * the provided options. Returns true if optimization should be performed,
+ * false otherwise.
+ */
+static inline bool odb_source_optimize_required(struct odb_source *source,
+						const struct odb_optimize_options *opts)
+{
+	return source->optimize_required(source, opts);
+}
+
 #endif

-- 
2.55.0.313.g8d093f411d.dirty

