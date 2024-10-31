Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078A41991CB
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367606; cv=none; b=GgTJlSDnqjDJDOzqqvKVk4jjnm6OK/CUykPHy+EIMKlsSSXfvKCDw5q14P8VMxi3imUpVR1l5QrBeVPwXe/kVDnfthAnHVX2ndNHzMQpLcG2u8GlNwvLqS3FA4xbMLeQMTBg+ABn0AEODfKfS+0Ln4ihTBJHpDV7KLwcEyoZmKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367606; c=relaxed/simple;
	bh=6Hz+zcEouW+oeynL/qkAQB9utrYhAk7Brc+SnNfPJKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JboMyA9xX9KPH2mc/QRrxJJh8md7pkOmII+yAPkIVio2QUZmbuXaZlqrylKhO+TgBX2Q4W3cP5eGMIIgSs797ed5drop+ZRFFFZxloGOVJG5A213vgQsr/GWNVA3Pkf6w/PiwAJRrFVql/+RwYA9Z2feNv++XyTzZZb+SRsOLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyHOaegH; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyHOaegH"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso104486266b.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367602; x=1730972402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw7Kvu7QiHPa/b/tI9u/mBfZj1N3LC2tqqypKiTJahQ=;
        b=AyHOaegHdkQ3t4Wo1riw7SxcDAfzL8J44+T6zYkg5a4PzX2+RZBt7pmm4A+8E4Ia8G
         MNxMGnOoRXduwX/82dekP1iyZa5PSfN8uWanLuXjAP/1t8xkfD+1O3W99+Ifssex1ua/
         V5QkbqN5iMoiBsc484Z0IN0tJ2WCePFSJ67/nlVbE7gqHSY6NClXJeHvKFXPm8By/Rcw
         lPdwgaBpDozxY28qtUMIrZv+DZ9SMzi3S/Pm9OXRhwei8yBMYnJ9sSb6Bu8pr++if5kH
         g2+OaRrQlC2jhRPM5ttEY7XkI9KdMnnuucJQ9GQjT7ZAriwYkQxZb2hcB5ObUcpJQvhw
         ezCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367602; x=1730972402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rw7Kvu7QiHPa/b/tI9u/mBfZj1N3LC2tqqypKiTJahQ=;
        b=BqS+4va2Tt9kYWGxyVM0mVwBSiY96FHjkw03AYCEHWA5aThlzhOYf4JIGDmTVLG348
         LO2ts4FXfhUyfgnIiA8jzvQLPcD+GQVN+4Ne3A13HTHfnfAQlo3k1yoUq4r1ZDjvkHWh
         LYtoruDuF+QNEXJ1N6RM38f5m5MVux3P5AXm8iNCGrH8fQKXbJOeVby1iIITCT+14rgU
         6Q97sk6yNIjW50OWp+20p5OMP4SYRUQphBTbVGpDGtoPBse1NU3Iavs5fCd7Rpu/uEMc
         HQZI5tBMaOO+WbzD84rISKqKWdX+gdzs82cHQX1qhEpsW8MO+FqCM/m67sMIZ+a+L2iL
         WSEg==
X-Gm-Message-State: AOJu0Yw/sUW9tEDOENDhJxkeNXanshpXRgJFiCXMmIG8tlnC+30snWPw
	t9YRBR4eB8wQgEimckRJRe/ViHSVdiXnS3bSTy5AcY+DYw4RS9m7SY0Z/3LV
X-Google-Smtp-Source: AGHT+IHFIJLjaVSjxqBfaCICsRYNPKa/YlUUgNCW0TvIuykPGau/zZ6Aq6ynrE46QSfWR3Cj9RcokQ==
X-Received: by 2002:a17:907:86a2:b0:a9a:134:9887 with SMTP id a640c23a62f3a-a9de6167ad2mr1676925866b.41.1730367602152;
        Thu, 31 Oct 2024 02:40:02 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm46399566b.26.2024.10.31.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:40:01 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v4 7/9] config: make `delta_base_cache_limit` a non-global variable
Date: Thu, 31 Oct 2024 10:39:50 +0100
Message-ID: <84b89c8a0e5e74e731397bdaaa6ccca82b9c2d8d.1730366765.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730366765.git.karthik.188@gmail.com>
References: <cover.1730366765.git.karthik.188@gmail.com>
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

