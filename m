Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371D1F7562
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237057; cv=none; b=lE6l9RYJxNzSxKKwVZOSkE6Bss5rmMCVIKFp/9bAlqrV4NmLLzzuGHTzQaTyZNnJ+TwjtTNOldQWJDjIZAFdheIjuSNbrKpk09tIaEhy4V6HW67/Xgc3DOhbxueNlic9qXC9qAwj8lbV3TMK9RyqNl2PQaYnbreVXi+YmgW4mvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237057; c=relaxed/simple;
	bh=74WoZ3zC2WhUeJpXlgYDHYsHVnQuCy7o309oZ/Iw2gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/hEGKQQXZpLJ3ACJjL121AzPHVp4hxA610RVynviEQEXl5fTyN+JGOasRztOj23f+t8LU6Wo5jYBV0aDjuHJZIpfU6FMWKBLQfnTH3y3+vu7LBfQ34yAUnQ4pqPfcLW5UB/C+dMWoGbrhEllDCtmRWPy5CNQmVngsyzjOsZEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXcApavd; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXcApavd"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso291468866b.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733237053; x=1733841853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf/j77/LLCsYW5g8E9cLFRLoltKgJfobrn+GgkzNKcI=;
        b=DXcApavd1Qh1NjSiWzDIT0uebBP44T0CwaAzWTs+1c6+SYPnbEL1frjbXszwUjslNJ
         YEQqBZEsfQH3VeWeL928jhH/dYaqSUETeJHWLB2N1RSCK76O3N97lxoOmWLsi0YTXb3/
         lZOxnJx+Szw0iTYRAQeY5/zfDIGjqguvf6myhDLgdq1KSHdSDKufVIUOWjHXxemipn9G
         FNuN11KWVqL8+cZQVeQ0B6WvL7AFGQ9eIzg+U/NGUaax5RjzU5NbttrMOgSBDzF120Av
         Cw/gEWkgAokkIEXpNnuQ5oDSWQojbYRM04NsV7OjAsdbcXU6pyImckds+iY8vUFfNamJ
         6d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733237053; x=1733841853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf/j77/LLCsYW5g8E9cLFRLoltKgJfobrn+GgkzNKcI=;
        b=sLCZmsStsDSVIG3IY7RZXKippriOsyDcXYH3bpBepl4vbhDTEUdgonsc16QB5iny0t
         ENsJHeWJx9CcrHp6pxVqB3oqYW1iTjoouIWH+cHtECwEbkwXCGn5F/W9m/kHMG7xogDV
         rGKC6PRh/z7GlqMaFDCP/v3oiI3/Y9D5h668X8o7rKLFHEYcORn5THmQpPqLpzH2pIdS
         awqxsrmXiXBtXHqtBc8oASU/XD3FLh85iIAnC9Io2zPXrcAnRA+rI9hEkLFTXgPiLZdV
         09QJLkzt0U2zsYt+/NV8SHIDSjxEB2fg9+3n5AQVPlefW1xi2s8M6OhZTVe97sfs3UA9
         t31g==
X-Gm-Message-State: AOJu0Yws2qbmCJwwkEykShmtbfYE7dXVTamnmIrbof2mR0DPXRlHTP1w
	u9sGcvOOvS4IWQGtIwDEaQVqzwi+Rprsn6Va3rkZK8+vV7evy6n+
X-Gm-Gg: ASbGncvUAmTCVVS672wSwPrPuSe3aKSU29BRjxo+XxcCWafQF2L9mCQtah9q04838lZ
	WgLJMgC4U0JJy55qLfGKKOrVnOr7bCG0SmUicszXfdIsdYh6OcrbYAXzMt9DCZCvkgBK5F97ROC
	tjUOPsruOLWW9D37lyuxRPgu1AiAJasHhTwGepilfD6mZgFDTLjdCjMTCp6it5WGEKjRIa3m15f
	IzZe/CaAml9rr0aqkuGp9MIMUbua5dTq6Bbby1YBfUgwUtZUQFYYy87mtrjRU3zNKBV
X-Google-Smtp-Source: AGHT+IFKa9U2wFjKh5OmDXi/bjFPZxNi3JGyGaEEGDSNX384NoF0SqFRy5qhPeVoF3axI/w55wqRRg==
X-Received: by 2002:a17:906:ee88:b0:aa5:199f:2bf2 with SMTP id a640c23a62f3a-aa601819730mr65945566b.29.1733237052630;
        Tue, 03 Dec 2024 06:44:12 -0800 (PST)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996de782sm619021466b.56.2024.12.03.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:44:12 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v10 07/10] config: make `delta_base_cache_limit` a non-global variable
Date: Tue,  3 Dec 2024 15:44:01 +0100
Message-ID: <342a26572d6372d40ba563d73242e0d18a481d2a.1733236936.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733236936.git.karthik.188@gmail.com>
References: <cover.1733236936.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `delta_base_cache_limit` variable is a global config variable used
by multiple subsystems. Let's make this non-global, by adding this
variable independently to the subsystems where it is used.

First, add the setting to the `repo_settings` struct, this provides
access to the config in places where the repository is available. Use
this in `packfile.c`.

In `index-pack.c` we add it to the `pack_idx_option` struct and its
constructor. While the repository struct is available here, it may not
be set  because `git index-pack` can be used without a repository.

In `gc.c` add it to the `gc_config` struct and also the constructor
function. The gc functions currently do not have direct access to a
repository struct.

These changes are made to remove the usage of `delta_base_cache_limit`
as a global variable in `packfile.c`. This brings us one step closer to
removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
which we complete in the next patch.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/gc.c         | 12 +++++++++++-
 builtin/index-pack.c | 10 +++++++---
 config.c             |  5 -----
 environment.c        |  1 -
 environment.h        |  1 -
 pack-objects.h       |  3 ++-
 pack-write.c         |  1 +
 pack.h               |  2 ++
 packfile.c           | 10 ++++++++--
 repo-settings.c      |  5 +++++
 repo-settings.h      |  3 +++
 11 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c..efb6162fb0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -138,6 +138,11 @@ struct gc_config {
 	char *repack_filter_to;
 	unsigned long big_pack_threshold;
 	unsigned long max_delta_cache_size;
+	/*
+	 * Remove this member from gc_config once repo_settings is passed
+	 * through the callchain.
+	 */
+	size_t delta_base_cache_limit;
 };
 
 #define GC_CONFIG_INIT { \
@@ -153,6 +158,7 @@ struct gc_config {
 	.prune_expire = xstrdup("2.weeks.ago"), \
 	.prune_worktrees_expire = xstrdup("3.months.ago"), \
 	.max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE, \
+	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 }
 
 static void gc_config_release(struct gc_config *cfg)
@@ -168,6 +174,7 @@ static void gc_config(struct gc_config *cfg)
 {
 	const char *value;
 	char *owned = NULL;
+	unsigned long ulongval;
 
 	if (!git_config_get_value("gc.packrefs", &value)) {
 		if (value && !strcmp(value, "notbare"))
@@ -206,6 +213,9 @@ static void gc_config(struct gc_config *cfg)
 	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
 	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
 
+	if (!git_config_get_ulong("core.deltabasecachelimit", &ulongval))
+		cfg->delta_base_cache_limit = ulongval;
+
 	if (!git_config_get_string("gc.repackfilter", &owned)) {
 		free(cfg->repack_filter);
 		cfg->repack_filter = owned;
@@ -416,7 +426,7 @@ static uint64_t estimate_repack_memory(struct gc_config *cfg,
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
index 02bbdfb19c..a8da040629 100644
--- a/pack.h
+++ b/pack.h
@@ -58,6 +58,8 @@ struct pack_idx_option {
 	 */
 	int anomaly_alloc, anomaly_nr;
 	uint32_t *anomaly;
+
+	size_t delta_base_cache_limit;
 };
 
 void reset_pack_idx_option(struct pack_idx_option *);
diff --git a/packfile.c b/packfile.c
index 5e8019b1fe..64248ca664 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1496,7 +1496,9 @@ void clear_delta_base_cache(void)
 }
 
 static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
-	void *base, unsigned long base_size, enum object_type type)
+				 void *base, unsigned long base_size,
+				 unsigned long delta_base_cache_limit,
+				 enum object_type type)
 {
 	struct delta_base_cache_entry *ent;
 	struct list_head *lru, *tmp;
@@ -1698,6 +1700,8 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
 	int base_from_cache = 0;
 
+	prepare_repo_settings(p->repo);
+
 	write_pack_access_log(p, obj_offset);
 
 	/* PHASE 1: drill down to the innermost base object */
@@ -1878,7 +1882,9 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 		 * before we are done using it.
 		 */
 		if (!external_base)
-			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
+			add_delta_base_cache(p, base_obj_offset, base, base_size,
+					     p->repo->settings.delta_base_cache_limit,
+					     type);
 
 		free(delta_data);
 		free(external_base);
diff --git a/repo-settings.c b/repo-settings.c
index 4699b4b365..acc27eb8fe 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -3,6 +3,7 @@
 #include "repo-settings.h"
 #include "repository.h"
 #include "midx.h"
+#include "pack-objects.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
@@ -26,6 +27,7 @@ void prepare_repo_settings(struct repository *r)
 	const char *strval;
 	int manyfiles;
 	int read_changed_paths;
+	unsigned long ulongval;
 
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
@@ -123,6 +125,9 @@ void prepare_repo_settings(struct repository *r)
 	 * removed.
 	 */
 	r->settings.command_requires_full_index = 1;
+
+	if (!repo_config_get_ulong(r, "core.deltabasecachelimit", &ulongval))
+		r->settings.delta_base_cache_limit = ulongval;
 }
 
 enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
diff --git a/repo-settings.h b/repo-settings.h
index 51d6156a11..10a6f7ed64 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -57,12 +57,15 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 	int warn_ambiguous_refs; /* lazily loaded via accessor */
+
+	size_t delta_base_cache_limit;
 };
 #define REPO_SETTINGS_INIT { \
 	.index_version = -1, \
 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
 	.warn_ambiguous_refs = -1, \
+	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
 }
 
 void prepare_repo_settings(struct repository *r);
-- 
2.47.1

