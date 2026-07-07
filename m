Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC7641DEE8
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438406; cv=none; b=ciuxN0sa0Fz5Q6hf5CURl7devnm6HPD/A5TBLwhds6Up0Z2taDRcvuRGTPf82u5CpUEFqLxVgco6LxwOT0CVDhfYV9RNPn3oY1LcFtqkkpoizccgFPj14zQiDUYCJVqkVctJUUaJFEgA1O2BqEdltIa8vENo90XY5lZi2KXyFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438406; c=relaxed/simple;
	bh=ig+6KzyGL7ZRj4Lj3nZPaEsnGLbXQ2MtZqU60Afcl7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv5A7oOHZXbGUTo49aTCWm1aVuHte80iLftJk5IKF78oyJNNWQJrMsSJZSWSRd7fWne0ciub6B8tkY0sgsZFfaC2yqX4DiyA0I+dy8U/PajJU/SLKlvgxH5rntexLeeoblCrulKES9cc+tO//Euuqc7zRzPeS/bczLKwpQZYbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C3/4f3rb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SQsa3Nna; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C3/4f3rb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SQsa3Nna"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8558D1400108
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438403;
	 x=1783524803; bh=irTr4BQFgfk8mHelS1SFL2zee758iZS4gWcr+x7/pQo=; b=
	C3/4f3rbe/3jaAGM/tL3BYi11canzCJkMhRTSnV4oPuPyCnqxCvURUZzb8PpQ+2f
	nH8rL3kuofpX1J8ME2yvAUDt7WGfOlOhuUF7OCkUAmP/8xzp0XSoSWs5TXl7vDRL
	4vtobrV3k3qKdzChorSyUPfkrgORpEAzixAvCaIzBcQJZzRiMFnP+JrZWOn+zXGy
	GFUkdD7LMGQxrnOI861AYw2+BTQ4SECfGSLSYDgiGGOCdXH3Vv3odBa+6NXJ8cGj
	D04vMHOhjeEAXUAGaJcITsWk/sByHFysLXvquLYxrgch6LAhiGvU7JdSZeiP1CAP
	3jWLWxWStZSfzXcSw9VAmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438403; x=
	1783524803; bh=irTr4BQFgfk8mHelS1SFL2zee758iZS4gWcr+x7/pQo=; b=S
	Qsa3NnaDLtXio1mthGddEIDdRAY19YMRyiknZGW7ded1hNnXnIFpH2plr8Bo9ARU
	aBJvb+8kkMIx3pOPjjtsfLL2elbsSoTDSg9LcnRhpwAwjYwpvLl51MlP3mycpauy
	eJ+YFh5BIvoK0GJ1A+G7iEiJnIUkg8mi55a2i2Bs8EZWdhoJx63FFYoTPvQxfTGY
	+cgiqwthGKNlueXDUBwWQEJWmKcf5h35VtW3u9DEavMqH2NXmVIcy2WJXJG1Sozg
	Wy6ECWQwCEr/T0RLHVUTE3JyzoIY46lvTqLqNQrjpNK38mlN85j8pqPeK/2TRv5M
	lFn6hfdSWPRJrD60e2f/Q==
X-ME-Sender: <xms:QxxNakIboKQYhcLPYJyEi2djhWFgnmbKgfN0oy3axRs9MXFgifnHrg>
    <xme:QxxNarH7IPRnRRltUPg09wznGSrl6dsh8q01MMQfG72NBgGO3GP4YGGttgwOst0Pd
    SNGkjwGv14Ghi2x4Bn5X4GEiiv-O-PR4ev_75ObHtVj8UKIaH2g>
X-ME-Received: <xmr:QxxNaqWbepUDyEVJdTEJ-CF-QbnUHhHXCihwQaHewOtM9yqoCv1324f9eprrWzJWzhYB8A2RAgNTR1ZlonX8HkIvojP1L3Pz-r0OACsytQ>
X-ME-Proxy-Cause: dmFkZTE6/iD3iHEuKBNru2cNsbN07kG+Ccd2z4KEMYhG2RvUCd+cOj2SmvRaPW6JdQJxYg
    yIYZJCovWU1j7v3nEEWcH2j/Wq2UWDCGC2XEGJ5SCvILUi8Rz9tCTiiZ51Icbkoyae9CJ8
    HA8uVCKObebcEoJ5TV2ivYrxy86qhazOGtYwH3j6uB5bc16miFoGFC2lxYTBbwQoWDP8w7
    Lah7PP1UuH619unN5/HqL3nPvgy44p1ofkS+7wWIRtYeq/lSVpeXB8M8nm5c7cDYw5zp91
    a1JFX+mSXwg6Bda7Ouf5RKV965olucpDrzFt45zWO9w5zYNzijwyqnCRczzOvzF6BX93j4
    ap9828t1Cpxfx6VtzoM6gCCko9KBiURT2L+zkHB2LvZbOfjYOYPKc10d+GZNivtwJKKra7
    PRggv3DvwSWakCJ8sCVzL8R5rD7OPdxEJrcKYxPSr8LPwbfwyg5QbTbrC09AkV6EztUaxa
    SAAjR698a/sufZ0zAfnDm3Qz5kYm4JCif9PPupd2CJkJamXXwD1gBiPv/5a+gi8+onVbM4
    WYE3JXwIQ8k3yo4dGrvmW8OfYTWMTU7UkDqBnFGrEMADXAo7aBq9zx/5GZF58yLnjxCTv4
    mOoOuzfkJi1Fytst6mkzLquzIKeONG/qS6VDiBnrAK1uyMQTYU3M6VZXtNPQ
X-ME-Proxy: <xmx:QxxNamgEnMeOYP5Q_4H1smzdGuO7_WAgtFV9ZhBHeyfpAQ68IvoP1w>
    <xmx:QxxNarRFaApYFaTjODjrAwHFg3DdIlTaJyzzvWOws0mrrdLpoWKBaw>
    <xmx:QxxNapFSoDidRlC2U9awn3GDYGT4shLq9AIw_ehJJNlGl6liZSkvLw>
    <xmx:QxxNajl3HBFASvTECRetMLZ_dIVMjvRg5DaQ_3gxjZ8aabqrwsgddg>
    <xmx:QxxNato9ukclCGRsq7lKaa4A6opwCufjd5bOrexOFLicU5KGH6b7Tuul>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e31b5ca0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:33:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:43 +0200
Subject: [PATCH 11/11] odb: make optimizations pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-11-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.55.0.141.g00534a21ce.dirty

