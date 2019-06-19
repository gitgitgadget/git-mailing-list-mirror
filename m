Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EB51F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFSJ7M (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:59:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44431 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfFSJ7L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:59:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so6997671plr.11
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EuAzPTbZZ9wCM7N6hdnFh/BQ5osCJc8bWfGheJCyw3Y=;
        b=cCy99+h4K/1+qfJwiekqcnHSFcqdfKfBY0fgluoNuahaaIyXRrivb+7KcGwEAJIBBD
         hiYAbWg91qq7CL46SOPivsfvshISr+CWFKrmdg00hZSyu+RlB1+vjQrL6EwQUw1vlBq9
         EHX05dVTgs9bhBCtw/zAxD8of/6+OICu3/HvL2WhtjVWECUXYfoO2Lct/20ndn2lWx0F
         j6DyXZ9cw6GpRd/iY/QVkItaD3Rvdqlk6WRizKifl/opvQtx9Nx/fSfrtXeatzW1jsmB
         csSu4vvr9//3UIvcsKDEZZ8xtEEayU1UdeYeX3hgqT20ILd0dHs7PeeZJ4mQejshrHdu
         3w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EuAzPTbZZ9wCM7N6hdnFh/BQ5osCJc8bWfGheJCyw3Y=;
        b=Rj0J5xgDIxvq93NhaqM7/bQxvB5GU1iAr6An1OS+XG2Jd+CedzpdH/E9Z0Fq2QAoSi
         11OZTnQgIiEheQRNCJqaJWpyurAoVb186xRKGrB7FQ87a4FjswlBqMxSGAKed0qmw5nR
         RgAaU2mA63PMmSrr98GZtoP0EN28QDgLs69Syw8YKqWuj+ELs+w7IPQscLOqJVAPyOLz
         89IqcBvm1vuJxM17F3cHT9dizh7W7XaZjn4BLR2tRiWVmxEAeKKQNYhfDFggAdIHZukz
         LF5uPPICvdGXAQ9KBrGwloBJgUsaajeWjgidGJGDgh3KlJQI0IzsfqrYIyE7lWgpTWHQ
         DZCA==
X-Gm-Message-State: APjAAAWBKaHsaBbHGP5oli1AVgGmz+pdW4NtaN2lFsQ9gSN+XGUrSz9y
        RcsrjwAOE8qaUaWYKy6D7Vk0O3Cr
X-Google-Smtp-Source: APXvYqyqe9FAY3RkhU29cEL7WXn+MZ8jHaCj/XQCYXH89yuj1OuGf9gwUnbNLd+9jkNqdZVuTOQhrQ==
X-Received: by 2002:a17:902:4c88:: with SMTP id b8mr7698087ple.29.1560938350812;
        Wed, 19 Jun 2019 02:59:10 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id k22sm17971790pfg.77.2019.06.19.02.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:59:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:59:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/8] ls-files: add --json to dump the index
Date:   Wed, 19 Jun 2019 16:58:51 +0700
Message-Id: <20190619095858.30124-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
In-Reply-To: <20190619095858.30124-1-pclouds@gmail.com>
References: <20190619095858.30124-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So far we don't have a command to basically dump the index file out,
with all its glory details. Checking some info, for example, stat
time, usually involves either writing new code or firing up "xxd" and
decoding values by yourself.

This --json is supposed to help that. It dumps the index in a human
readable format but also easy to be processed with tools. And it will
print almost enough info to reconstruct the index later.

In this patch we only dump the main part, not extensions. But at the
end of the series, the entire index is dumped. The end result could be
very verbose even on a small repository such as git.git.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-ls-files.txt |  5 +++
 builtin/ls-files.c             | 30 +++++++++++---
 cache.h                        |  2 +
 json-writer.c                  | 16 ++++++++
 json-writer.h                  | 21 ++++++++++
 read-cache.c                   | 73 +++++++++++++++++++++++++++++++++-
 6 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 8461c0e83e..54011c8f65 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -60,6 +60,11 @@ OPTIONS
 --stage::
 	Show staged contents' mode bits, object name and stage number in the output.
 
+--json::
+	Dump the entire index content in JSON format. This is for
+	debugging purposes and the JSON structure may change from time
+	to time.
+
 --directory::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f83c9a6f2..d00f6d3074 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "repository.h"
 #include "config.h"
+#include "json-writer.h"
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
@@ -31,6 +32,7 @@ static int show_modified;
 static int show_killed;
 static int show_valid_bit;
 static int show_fsmonitor_bit;
+static int show_json;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
@@ -543,6 +545,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("show staged contents' object name in the output")),
 		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
+		OPT_BOOL(0, "json", &show_json,
+			N_("dump index content in json format")),
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' names only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
@@ -660,8 +664,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 
 	/* With no flags, we default to showing the cached files */
 	if (!(show_stage || show_deleted || show_others || show_unmerged ||
-	      show_killed || show_modified || show_resolve_undo))
+	      show_killed || show_modified || show_resolve_undo || show_json))
 		show_cached = 1;
+	if (show_json && (show_stage || show_deleted || show_others ||
+			  show_unmerged || show_killed || show_modified ||
+			  show_cached || show_resolve_undo || with_tree))
+		die(_("--show-json cannot be used with other --show- options, or --with-tree"));
 
 	if (with_tree) {
 		/*
@@ -673,10 +681,22 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
 	}
 
-	show_files(the_repository, &dir);
-
-	if (show_resolve_undo)
-		show_ru_info(the_repository->index);
+	if (!show_json) {
+		show_files(the_repository, &dir);
+
+		if (show_resolve_undo)
+			show_ru_info(the_repository->index);
+	} else {
+		struct json_writer jw = JSON_WRITER_INIT;
+
+		discard_index(the_repository->index);
+		the_repository->index->jw = &jw;
+		if (repo_read_index(the_repository) < 0)
+			die("index file corrupt");
+		puts(jw.json.buf);
+		the_repository->index->jw = NULL;
+		jw_release(&jw);
+	}
 
 	if (ps_matched) {
 		int bad;
diff --git a/cache.h b/cache.h
index bf20337ef4..84d0aeed20 100644
--- a/cache.h
+++ b/cache.h
@@ -326,6 +326,7 @@ static inline unsigned int canon_mode(unsigned int mode)
 #define UNTRACKED_CHANGED	(1 << 7)
 #define FSMONITOR_CHANGED	(1 << 8)
 
+struct json_writer;
 struct split_index;
 struct untracked_cache;
 
@@ -350,6 +351,7 @@ struct index_state {
 	uint64_t fsmonitor_last_update;
 	struct ewah_bitmap *fsmonitor_dirty;
 	struct mem_pool *ce_mem_pool;
+	struct json_writer *jw;
 };
 
 /* Name hashing */
diff --git a/json-writer.c b/json-writer.c
index aadb9dbddc..281bc50b39 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -202,6 +202,22 @@ void jw_object_null(struct json_writer *jw, const char *key)
 	strbuf_addstr(&jw->json, "null");
 }
 
+void jw_object_stat_data(struct json_writer *jw, const char *name,
+			 const struct stat_data *sd)
+{
+	jw_object_inline_begin_object(jw, name);
+	jw_object_intmax(jw, "st_ctime.sec", sd->sd_ctime.sec);
+	jw_object_intmax(jw, "st_ctime.nsec", sd->sd_ctime.nsec);
+	jw_object_intmax(jw, "st_mtime.sec", sd->sd_mtime.sec);
+	jw_object_intmax(jw, "st_mtime.nsec", sd->sd_mtime.nsec);
+	jw_object_intmax(jw, "st_dev", sd->sd_dev);
+	jw_object_intmax(jw, "st_ino", sd->sd_ino);
+	jw_object_intmax(jw, "st_uid", sd->sd_uid);
+	jw_object_intmax(jw, "st_gid", sd->sd_gid);
+	jw_object_intmax(jw, "st_size", sd->sd_size);
+	jw_end(jw);
+}
+
 static void increase_indent(struct strbuf *sb,
 			    const struct json_writer *jw,
 			    int indent)
diff --git a/json-writer.h b/json-writer.h
index 83906b09c1..38f9c9bf68 100644
--- a/json-writer.h
+++ b/json-writer.h
@@ -44,6 +44,8 @@
 
 #include "strbuf.h"
 
+struct stat_data;
+
 struct json_writer
 {
 	/*
@@ -81,6 +83,8 @@ void jw_object_true(struct json_writer *jw, const char *key);
 void jw_object_false(struct json_writer *jw, const char *key);
 void jw_object_bool(struct json_writer *jw, const char *key, int value);
 void jw_object_null(struct json_writer *jw, const char *key);
+void jw_object_stat_data(struct json_writer *jw, const char *key,
+			 const struct stat_data *sd);
 void jw_object_sub_jw(struct json_writer *jw, const char *key,
 		      const struct json_writer *value);
 
@@ -104,4 +108,21 @@ void jw_array_inline_begin_array(struct json_writer *jw);
 int jw_is_terminated(const struct json_writer *jw);
 void jw_end(struct json_writer *jw);
 
+/*
+ * These _gently versions accept NULL json_writer to reduce too much
+ * branching at the call site.
+ */
+static inline void jw_object_inline_begin_array_gently(struct json_writer *jw,
+						       const char *name)
+{
+	if (jw)
+		jw_object_inline_begin_array(jw, name);
+}
+
+static inline void jw_end_gently(struct json_writer *jw)
+{
+	if (jw)
+		jw_end(jw);
+}
+
 #endif /* JSON_WRITER_H */
diff --git a/read-cache.c b/read-cache.c
index 4dd22f4f6e..eec030b3bb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "json-writer.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1952,6 +1953,50 @@ static void *load_index_extensions(void *_data)
 	return NULL;
 }
 
+static void dump_cache_entry(struct index_state *istate,
+			     int index,
+			     unsigned long offset,
+			     const struct cache_entry *ce)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct json_writer *jw = istate->jw;
+
+	jw_array_inline_begin_object(jw);
+
+	/*
+	 * this is technically redundant, but it's for easier
+	 * navigation when there hundreds of entries
+	 */
+	jw_object_intmax(jw, "id", index);
+
+	jw_object_string(jw, "name", ce->name);
+
+	strbuf_addf(&sb, "%06o", ce->ce_mode);
+	jw_object_string(jw, "mode", sb.buf);
+	strbuf_release(&sb);
+
+	jw_object_intmax(jw, "flags", ce->ce_flags);
+	/*
+	 * again redundant info, just so you don't have to decode
+	 * flags values manually
+	 */
+	if (ce->ce_flags & CE_VALID)
+		jw_object_true(jw, "assume-unchanged");
+	if (ce->ce_flags & CE_INTENT_TO_ADD)
+		jw_object_true(jw, "intent-to-add");
+	if (ce->ce_flags & CE_SKIP_WORKTREE)
+		jw_object_true(jw, "skip-worktree");
+	if (ce_stage(ce))
+		jw_object_intmax(jw, "stage", ce_stage(ce));
+
+	jw_object_string(jw, "oid", oid_to_hex(&ce->oid));
+
+	jw_object_stat_data(jw, "stat", &ce->ce_stat_data);
+	jw_object_intmax(jw, "file-offset", offset);
+
+	jw_end(jw);
+}
+
 /*
  * A helper function that will load the specified range of cache entries
  * from the memory mapped file and add them to the given index.
@@ -1972,6 +2017,9 @@ static unsigned long load_cache_entry_block(struct index_state *istate,
 		ce = create_from_disk(ce_mem_pool, istate->version, disk_ce, &consumed, previous_ce);
 		set_index_entry(istate, i, ce);
 
+		if (istate->jw)
+			dump_cache_entry(istate, i, src_offset, ce);
+
 		src_offset += consumed;
 		previous_ce = ce;
 	}
@@ -1983,6 +2031,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 {
 	unsigned long consumed;
 
+	jw_object_inline_begin_array_gently(istate->jw, "entries");
+
 	if (istate->version == 4) {
 		mem_pool_init(&istate->ce_mem_pool,
 				estimate_cache_size_from_compressed(istate->cache_nr));
@@ -1993,6 +2043,8 @@ static unsigned long load_all_cache_entries(struct index_state *istate,
 
 	consumed = load_cache_entry_block(istate, istate->ce_mem_pool,
 					0, istate->cache_nr, mmap, src_offset, NULL);
+
+	jw_end_gently(istate->jw);
 	return consumed;
 }
 
@@ -2120,6 +2172,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	size_t extension_offset = 0;
 	int nr_threads, cpus;
 	struct index_entry_offset_table *ieot = NULL;
+	int jw_pretty = 1;
 
 	if (istate->initialized)
 		return istate->cache_nr;
@@ -2154,6 +2207,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->cache_nr = ntohl(hdr->hdr_entries);
 	istate->cache_alloc = alloc_nr(istate->cache_nr);
 	istate->cache = xcalloc(istate->cache_alloc, sizeof(*istate->cache));
+	istate->timestamp.sec = st.st_mtime;
+	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 	istate->initialized = 1;
 
 	p.istate = istate;
@@ -2176,6 +2231,20 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (!HAVE_THREADS)
 		nr_threads = 1;
 
+	if (istate->jw) {
+		jw_object_begin(istate->jw, jw_pretty);
+		jw_object_intmax(istate->jw, "version", istate->version);
+		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
+		jw_object_intmax(istate->jw, "st_mtime.sec", istate->timestamp.sec);
+		jw_object_intmax(istate->jw, "st_mtime.nsec", istate->timestamp.nsec);
+
+		/*
+		 * Threading may mess up json writing. This is for
+		 * debugging only, so performance is not a concern.
+		 */
+		nr_threads = 1;
+	}
+
 	if (nr_threads > 1) {
 		extension_offset = read_eoie_extension(mmap, mmap_size);
 		if (extension_offset) {
@@ -2204,8 +2273,6 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		src_offset += load_all_cache_entries(istate, mmap, mmap_size, src_offset);
 	}
 
-	istate->timestamp.sec = st.st_mtime;
-	istate->timestamp.nsec = ST_MTIME_NSEC(st);
 
 	/* if we created a thread, join it otherwise load the extensions on the primary thread */
 	if (extension_offset) {
@@ -2216,6 +2283,8 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		p.src_offset = src_offset;
 		load_index_extensions(&p);
 	}
+	jw_end_gently(istate->jw);
+
 	munmap((void *)mmap, mmap_size);
 
 	/*
-- 
2.22.0.rc0.322.g2b0371e29a

