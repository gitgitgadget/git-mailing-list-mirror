Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A11DE2A2
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123041; cv=none; b=dkfzT1pNvwSTULUWQJAjz/DnFJts1ei+KVp1g4bkJim/s77GmDyRGcVgsKwoGWNYMJDjFKWBZvO7EkdaQnvAWQdpXakA7JHFSFS/3QYn3d4t3SxJrPmvXLlyHw/Gdu61aG++RSQiWcWIAUqDNwGtPm3pXFfFa87yYkGhIWak2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123041; c=relaxed/simple;
	bh=4jsu2avaWsAOhlNRBCPJxT5dxsP7+A5hMtC4yVPBTI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hsNHp3/fdG2cvM9LxFGnkBV6keMl3i6SwK7R7LlsuaoykoOcEV9SvjT9CaLfIa85V98wbMwMD3wUAhM1jMc8VVmqv3AYiTgmuD0WDwMjXsmKJ3ydkHNOCx4Y92erJKAdXfcF0Zvk5MQy2UNhczb40eyBTHuSw8sYUb44lYfOhOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBGXK9KL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBGXK9KL"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso654633666b.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730123037; x=1730727837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwy5rCwOCC4gSFH82M192kCV5wclpRjQ6TNQvLmYnaE=;
        b=VBGXK9KL9l5rP+c2EkdniQtfvG8bNn1orsaYzoINbngwWx87dzQZnTSkzF0kvey76P
         QdApMiTqJY0UeMNnkZzfxeVWaohGLULhcJt9pZ08Uias+j7eSKoijvIPgRDuxvqyMi04
         d9ZmDfo2sVsEF0DPE3+pMkoghIyYqW26eGq6PJcYRYGFHSJ0dvcooOhSbL0HHiEO7T/X
         S3NuLfT+1F7shK6iqH3EQ5RKjl2B5D1CDNDdb9R/cKB+k2lLH2iQMzvEcyVkAzzFk473
         +jGRs4lV3FkLnkjkSdr/PnrkN4+otUx/rvma1/+tJDv40ZmOq+u8Ffwy0yG3O4Kc6AJE
         uJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123037; x=1730727837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwy5rCwOCC4gSFH82M192kCV5wclpRjQ6TNQvLmYnaE=;
        b=rF+Om58cW+C6bD5pKGqM0wRmcF6kKzk4T+VcF6Xz+iGIldIBY2DvcDySHXYFPGyTGd
         AkSoLk5fqeow7IMXwNZdQUEKCd0gDFxR/YcG3YPt6bsNNh11O7QNJImPCYsJIf/m5CA7
         weimL5Hjx+aLO8Do9eEy1yTEaIi2lX3mRlleCaML4IqyBcssaqiUa2BLKVot4jBjwf17
         OBhvnjD8HB+Y672AYloq4M9X+6mxlzKFVPPi4IGRqQG6k+nxoiixqmAxqVPs+SffRaO3
         HZp2++4kclD75nj8DYurAX8hUZvRpxrazWenVDN4OEN+NMiXryjsFHeEujql0FrPc6hC
         b0Lg==
X-Gm-Message-State: AOJu0Yz++cvnifT0+R8q1Ad35MjwtYzukxva0d7ZVPXpr1de2hzRLK5d
	1UGxZgbnFXJc1Q4snWUTd7ppoAyRBNG/9I6G5PoNWwzTk7a7qo4d
X-Google-Smtp-Source: AGHT+IEShkCvfXVAep0kHdyPOQYYTTlXqXlnsFczZXxEZOxRvWF2a4ESXO89M5J7uufC1Bt02Q3S+w==
X-Received: by 2002:a17:907:9449:b0:a99:f92a:7a66 with SMTP id a640c23a62f3a-a9de5d783e5mr789917066b.30.1730123036449;
        Mon, 28 Oct 2024 06:43:56 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2971e8sm376647466b.125.2024.10.28.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com
Subject: [PATCH v2 7/8] config: make `delta_base_cache_limit` a non-global variable
Date: Mon, 28 Oct 2024 14:43:45 +0100
Message-ID: <89ee3f48ce982236dd7841fa1a5cb15aa256b901.1730122499.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730122499.git.karthik.188@gmail.com>
References: <cover.1730122499.git.karthik.188@gmail.com>
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
index 74ac6d793b..93b0d6af31 100644
--- a/packfile.c
+++ b/packfile.c
@@ -24,6 +24,8 @@
 #include "commit-graph.h"
 #include "pack-revindex.h"
 #include "promisor-remote.h"
+#include "config.h"
+#include "pack-objects.h"
 
 char *odb_pack_name(struct repository *repo, struct strbuf *buf,
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

