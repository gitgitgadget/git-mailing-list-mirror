Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED71B3957
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720522; cv=none; b=nB+ujF2TzULBDVHar8+vilk1Y5iHTIPB9CprLsVQIgjTJV9/w8pIGRSY8ugJd+3Vf1heRhygsx3+BKEnHI+fSSdNBaevz6hFnpoEDeHDtLoJea2VvybeiwpW5gbyjGGOiIbveuOjv7nmm2e20Yy0jlgVZUYmjItULl2KUYoIzcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720522; c=relaxed/simple;
	bh=H/uH1dn6Gk4Loko4g1RWzhP4FjO/1Us9BM+Am3iNJ4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2cuJDU/erlI7kW7Z/2KR5dP1rV4yG6pD1MgORufKrzlIg3EVPB+VuWXG29kVsyKmM5FCVVHIkeTGcTCfv6fj8VMdSExs0aK7o+/bkqlyZaTp2Oq9p5PrUK0yC7SNzy7u4q8nGGSoRUdS+mwxs8+v+gv4f3h931/euB7Fd1fxko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZEUBOQ4v; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZEUBOQ4v"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso1487601a12.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720519; x=1731325319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XI5jQItF2+ZOudzi6gooQ9rRoLGaXhp7FSWOy/KYOJo=;
        b=ZEUBOQ4vNTCHdrm+vJWhlda6HifAjBGiyBvS8myCBJC275j8WMIiwT41Pj9bXTaLn8
         NOpThs9tQzfzIEAyLVEYHpDaHjrHZ2iVhrYEaUU+HzGR4k2gHueRLp9rL94jmUH7nlPF
         j6tfX6bmWwCZEua0UDJHiSvPJXVmr/eV9ytjdaOBNJoJb+J0vOKHvwvNSbcUhtxPKSoS
         bLZyzYmU7r6pWvC3Q3iy3dcM3mlMfUhqA7svPRReTqzmcX9EoVtmkscbi49aLMmT2WLf
         DQIYgYeKiVs9xpAjW/sg8LIbj0hK9hjgQwB751LetY2J6TKYRn7Qk+cyGCxdumab88mW
         M1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720519; x=1731325319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XI5jQItF2+ZOudzi6gooQ9rRoLGaXhp7FSWOy/KYOJo=;
        b=vhvEBklPSXAJ3Fn9uvFLSyOERPg/pxCc5374bxAxKxmD5SYPe+A/Ml6uT9ijKAS/Mw
         e7/D05hm6mpaXV1rD3tuOorVR6ZDDqGxeBsvcIckO/HZwCOAHZudHIKrPzm1PQYz+ELT
         DNqewdl2rC0u1+2vjHwbaJhQIYBd8tOkby9bYPlAU3DLpUpHsbInYLEMS1eD3qvv+mMm
         owH6YbpvEAbsIicUhh4e7lS5LYwxWxo0S1eOrSqRkdT9Ymy+Sz12qv0CnFy8uqcgq2g1
         /F59bQFiC+fnH0hsheTMN45GLRv3XC5ufNLxDqBCzHAEsHiHIMg1idRkehMsr7MTYA+i
         pQrw==
X-Gm-Message-State: AOJu0Yysp71UseVihHe3hP+HIWiELMFAg2S6NEN+PwtyC3T/sfvF3hzG
	VmIbxdqte9XtxKTrk/GGW7BVjW5vLosOZ1VmO3oLo/GdMPpZX/84
X-Google-Smtp-Source: AGHT+IHdEiAAcVrKViDia2Q9H78e5mAiINUBd5p4C7OKJl/R8uL79SZPCftU5QjtPCIEbwd8ngsBIg==
X-Received: by 2002:a05:6402:4305:b0:5ce:dead:2fb with SMTP id 4fb4d7f45d1cf-5cedead0483mr1043657a12.15.1730720518910;
        Mon, 04 Nov 2024 03:41:58 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e97f2sm4157219a12.87.2024.11.04.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:41:58 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v5 7/9] config: make `delta_base_cache_limit` a non-global variable
Date: Mon,  4 Nov 2024 12:41:45 +0100
Message-ID: <7654bf5e7e44e0a1125db3984e702095a8a3ac4f.1730714298.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730714298.git.karthik.188@gmail.com>
References: <cover.1730714298.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `delta_base_cache_limit` variable is a global config variable used
by multiple subsystems. Let's make this non-global, by adding this
variable to the stack of each of the subsystems where it is used.

In `gc.c` we add it to the `gc_config` struct and also the constructor
function. In `index-pack.c` we add it to the `pack_idx_option` struct
and its constructor. Finally, in `packfile.c` we dynamically retrieve
this value from the repository config, since the value is only used once
in the entire subsystem.

The type of the value is changed from `size_t` to an `unsigned long`
since the default value is small enough to fit inside the latter on all
platforms.

These changes are made to remove the usage of `delta_base_cache_limit`
as a global variable in `packfile.c`. This brings us one step closer to
removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
which we complete in the next patch.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/gc.c         |  5 ++++-
 builtin/index-pack.c | 10 +++++++---
 config.c             |  5 -----
 environment.c        |  1 -
 environment.h        |  1 -
 pack-objects.h       |  3 ++-
 pack-write.c         |  1 +
 pack.h               |  1 +
 packfile.c           | 13 +++++++++++--
 9 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c..9a10eb58bc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -138,6 +138,7 @@ struct gc_config {
 	char *repack_filter_to;
 	unsigned long big_pack_threshold;
 	unsigned long max_delta_cache_size;
+	unsigned long delta_base_cache_limit;
 };
 
 #define GC_CONFIG_INIT { \
@@ -153,6 +154,7 @@ struct gc_config {
 	.prune_expire = xstrdup("2.weeks.ago"), \
 	.prune_worktrees_expire = xstrdup("3.months.ago"), \
 	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
+	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 }
 
 static void gc_config_release(struct gc_config *cfg)
@@ -205,6 +207,7 @@ static void gc_config(struct gc_config *cfg)
 
 	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
+	git_config_get_ulong("core.deltabasecachelimit", &cfg->delta_base_cache_limit);
 
 	if (!git_config_get_string("gc.repackfilter", &owned)) {
 		free(cfg->repack_filter);
@@ -416,7 +419,7 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
 	 * read_sha1_file() (either at delta calculation phase, or
 	 * writing phase) also fills up the delta base cache
 	 */
-	heap += delta_base_cache_limit;
+	heap += cfg->delta_base_cache_limit;
 	/* and of course pack-objects has its own delta cache */
 	heap += cfg->max_delta_cache_size;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index eaefb41761..23bfa45403 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1238,7 +1238,7 @@ static void parse_pack_objects(unsigned char *hash)
  *   recursively checking if the resulting object is used as a base
  *   for some more deltas.
  */
-static void resolve_deltas(void)
+static void resolve_deltas(struct pack_idx_option *opts)
 {
 	int i;
 
@@ -1254,7 +1254,7 @@ static void resolve_deltas(void)
 					  nr_ref_deltas + nr_ofs_deltas);
 
 	nr_dispatched = 0;
-	base_cache_limit = delta_base_cache_limit * nr_threads;
+	base_cache_limit = opts->delta_base_cache_limit * nr_threads;
 	if (nr_threads > 1 || getenv("GIT_FORCE_THREADS")) {
 		init_thread();
 		work_lock();
@@ -1604,6 +1604,10 @@ static int git_index_pack_config(const char *k, const char *v,
 		else
 			opts->flags &= ~WRITE_REV;
 	}
+	if (!strcmp(k, "core.deltabasecachelimit")) {
+		opts->delta_base_cache_limit = git_config_ulong(k, v, ctx->kvi);
+		return 0;
+	}
 	return git_default_config(k, v, ctx, cb);
 }
 
@@ -1930,7 +1934,7 @@ int cmd_index_pack(int argc,
 	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
-	resolve_deltas();
+	resolve_deltas(&opts);
 	conclude_pack(fix_thin_pack, curr_pack, pack_hash);
 	free(ofs_deltas);
 	free(ref_deltas);
diff --git a/config.c b/config.c
index a11bb85da3..728ef98e42 100644
--- a/config.c
+++ b/config.c
@@ -1515,11 +1515,6 @@ static int git_default_core_config(const char *var, const char *value,
 		return 0;
 	}
 
-	if (!strcmp(var, "core.deltabasecachelimit")) {
-		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.autocrlf")) {
 		if (value && !strcasecmp(value, "input")) {
 			auto_crlf = AUTO_CRLF_INPUT;
diff --git a/environment.c b/environment.c
index a2ce998081..8e5022c282 100644
--- a/environment.c
+++ b/environment.c
@@ -51,7 +51,6 @@ enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
 size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
-size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 char *editor_program;
 char *askpass_program;
diff --git a/environment.h b/environment.h
index 923e12661e..2f43340f0b 100644
--- a/environment.h
+++ b/environment.h
@@ -165,7 +165,6 @@ extern int zlib_compression_level;
 extern int pack_compression_level;
 extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
-extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
 extern int max_allowed_tree_depth;
diff --git a/pack-objects.h b/pack-objects.h
index b9898a4e64..3f6f504203 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -7,7 +7,8 @@
 
 struct repository;
 
-#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
+#define DEFAULT_DELTA_CACHE_SIZE       (256 * 1024 * 1024)
+#define DEFAULT_DELTA_BASE_CACHE_LIMIT (96 * 1024 * 1024)
 
 #define OE_DFS_STATE_BITS	2
 #define OE_DEPTH_BITS		12
diff --git a/pack-write.c b/pack-write.c
index 8c7dfddc5a..98a8c0e785 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -21,6 +21,7 @@ void reset_pack_idx_option(struct pack_idx_option *opts)
 	memset(opts, 0, sizeof(*opts));
 	opts->version = 2;
 	opts->off32_limit = 0x7fffffff;
+	opts->delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
 }
 
 static int sha1_compare(const void *_a, const void *_b)
diff --git a/pack.h b/pack.h
index 02bbdfb19c..1a33751565 100644
--- a/pack.h
+++ b/pack.h
@@ -58,6 +58,7 @@ struct pack_idx_option {
 	 */
 	int anomaly_alloc, anomaly_nr;
 	uint32_t *anomaly;
+	unsigned long delta_base_cache_limit;
 };
 
 void reset_pack_idx_option(struct pack_idx_option *);
diff --git a/packfile.c b/packfile.c
index 5e8019b1fe..2ae35dd03f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,6 +24,8 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
+#include "config.h"
+#include "pack-objects.h"
 
 char *odb_pack_name(struct repository *r, struct strbuf *buf,
 		    const unsigned char *hash, const char *ext)
@@ -1496,7 +1498,9 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+				 void *base, unsigned long base_size,
+				 unsigned long delta_base_cache_limit,
+				 enum object_type type)
 {
 	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
@@ -1697,6 +1701,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
 	int base_from_cache = 0;
+	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
+
+	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
 
 	write_pack_access_log(p, obj_offset);
 
@@ -1878,7 +1885,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		 * before we are done using it.
 		 */
 		if (!external_base)
-			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
+			add_delta_base_cache(p, base_obj_offset, base,
+					     base_size, delta_base_cache_limit,
+					     type);
 
 		free(delta_data);
 		free(external_base);
-- 
2.47.0

