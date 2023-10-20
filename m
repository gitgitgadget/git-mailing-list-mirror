Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF832230A
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="T13vx0bl"
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695DC112
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-27d0acd0903so848068a91.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 11:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1697827197; x=1698431997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sod9M6iu41DhYV1VjaGV23OczvduFxd20PUI5amSiXU=;
        b=T13vx0bl2hxxC0Q5Pt6t9aeQXjXJmhHMU/mV16IGEHMjnuWbJAoPbwLR92srAi58Ap
         6CPjvg9uR1+YxQ28mJbR7QA8/V5bQThuJkBCvGUzTEOJT9iTJr4zrkvv4YTbLEXR1MoC
         YBS9aCBJ61tBpprP04uA6w6d+PkcMLl9OQpjvlrIpuod+xXgNbxwpF0xKv4U5LKCgNmA
         Nb1EaSDGrA5+a2vtlR+f6VKK3Agjw+9QSM9GA3ZU7Yqz0C6VhriiB9omJQnP/6OUBWSy
         poyKajy2+ahUcEH9/dJHAmY33D4++VOgK9yp9ZIyV0nY6cExBluXmjUC5GkXevHdCaH9
         yjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697827197; x=1698431997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sod9M6iu41DhYV1VjaGV23OczvduFxd20PUI5amSiXU=;
        b=bn9ivFhyfor9AdnCA/KdBs31ZDp9H3Ar57rUrXBE6UXm35L1nPJ6cSAo7gHkm59xUV
         SX6oTh1Uk2wGol5cBERCqAfirz2FqGVpiH1hB64p9vahie9nrWkCzP0ebBET8kx6OoK+
         MZgdI5TePFMehkeiaidFD+zNqtS9aVcnG83prrmiGUZnovvvFxp8d+XjRYKOcjp60/Xu
         nJcwG4oZ6rDwGn1PsK3Wxrw45D5JOiPM9MmPOnZoyNtNjzl82mcqDmmGdT9OLdLkAaxa
         wUNKedFpC/+aJIK5PYjM3wHwDVUH3+naqRD0CzieXMEBX+LZXT7uIvy3/ljNrFdDc+UB
         OG3Q==
X-Gm-Message-State: AOJu0YwzZOdETCCDzCoukIFXK12ybss6bAsdaXgI34Joij+gU+Fepfs/
	WZviaeW+D0TxPbb8LRHw8kWK4Ray6gum3FgQrKXT6DVyh5fGBg==
X-Google-Smtp-Source: AGHT+IH/N0NVd+3LdF8U+39Gk/0Ek+Xx9L4tY9ioQwiJU1k1ujla0U7jOynkzmkoke3wWwQ/zVjO3A==
X-Received: by 2002:a17:90b:4cd0:b0:27d:2054:27b1 with SMTP id nd16-20020a17090b4cd000b0027d205427b1mr2601829pjb.32.1697827196576;
        Fri, 20 Oct 2023 11:39:56 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-170-46-176.mycingular.net. [166.170.46.176])
        by smtp.gmail.com with ESMTPSA id s15-20020a17090a5d0f00b0027e022bd62fsm2994353pji.5.2023.10.20.11.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:39:56 -0700 (PDT)
From: Jacob Stopak <jacob@initialcommit.io>
To: git@vger.kernel.org
Cc: Jacob Stopak <jacob@initialcommit.io>
Subject: [RFC PATCH 4/5] add: add -t, --table flag for visual dry runs
Date: Fri, 20 Oct 2023 11:39:46 -0700
Message-ID: <20231020183947.463882-5-jacob@initialcommit.io>
X-Mailer: git-send-email 2.42.0.402.gbe8243af7b.dirty
In-Reply-To: <20231020183947.463882-1-jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jacob Stopak <jacob@initialcommit.io>
---
 builtin/add.c    | 46 ++++++++++++++++++------
 builtin/commit.c |  2 +-
 read-cache-ll.h  |  9 ++++-
 read-cache.c     | 32 ++++++++++++++---
 table.c          | 92 +++++++++++++++++++++++++++++++++++++++++++-----
 wt-status.c      |  1 +
 wt-status.h      |  1 +
 7 files changed, 157 insertions(+), 26 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index c27254a5cd..35ea1deda5 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -27,6 +27,7 @@
 #include "strvec.h"
 #include "submodule.h"
 #include "add-interactive.h"
+#include "wt-status.h"
 
 static const char * const builtin_add_usage[] = {
 	N_("git add [<options>] [--] <pathspec>..."),
@@ -221,7 +222,7 @@ N_("The following paths are ignored by one of your .gitignore files:\n");
 
 static int verbose, show_only, ignored_too, refresh_only;
 static int ignore_add_errors, intent_to_add, ignore_missing;
-static int warn_on_embedded_repo = 1;
+static int table_format, warn_on_embedded_repo = 1;
 
 #define ADDREMOVE_DEFAULT 1
 static int addremove = ADDREMOVE_DEFAULT;
@@ -264,6 +265,8 @@ static struct option builtin_add_options[] = {
 			N_("warn when adding an embedded repository")),
 	OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
 	OPT_PATHSPEC_FILE_NUL(&pathspec_file_nul),
+	OPT_SET_INT('t', "table", &table_format,
+		    N_("show status in table format"), STATUS_FORMAT_TABLE),
 	OPT_END(),
 };
 
@@ -322,7 +325,7 @@ static void check_embedded_repo(const char *path)
 	strbuf_release(&name);
 }
 
-static int add_files(struct dir_struct *dir, int flags)
+static int add_files(struct dir_struct *dir, int flags, struct wt_status *status)
 {
 	int i, exit_status = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
@@ -345,7 +348,7 @@ static int add_files(struct dir_struct *dir, int flags)
 					   dir->entries[i]->name);
 			continue;
 		}
-		if (add_file_to_index(&the_index, dir->entries[i]->name, flags)) {
+		if (add_file_to_index_with_status(&the_index, dir->entries[i]->name, flags, status)) {
 			if (!ignore_add_errors)
 				die(_("adding files failed"));
 			exit_status = 1;
@@ -374,6 +377,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int require_pathspec;
 	char *seen = NULL;
 	struct lock_file lock_file = LOCK_INIT;
+	struct wt_status status;
+	unsigned int progress_flag = 0;
 
 	git_config(add_config, NULL);
 
@@ -459,7 +464,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 		 (intent_to_add ? ADD_CACHE_INTENT : 0) |
 		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
 		 (!(addremove || take_worktree_changes)
-		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0) |
+		 (table_format ? ADD_CACHE_FORMAT_TABLE : 0));
 
 	if (repo_read_index_preload(the_repository, &pathspec, 0) < 0)
 		die(_("index file corrupt"));
@@ -551,15 +557,35 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	begin_odb_transaction();
 
-	if (add_renormalize)
+	if (show_only && table_format) {
+		/* Prepare index and populate status */
+		wt_status_prepare(the_repository, &status);
+		git_config(git_default_config, &status);
+		repo_read_index(the_repository);
+		refresh_index(&the_index,
+			      REFRESH_QUIET|REFRESH_UNMERGED|progress_flag,
+			      &status.pathspec, NULL, NULL);
+		status.status_format = STATUS_FORMAT_TABLE;
+		status.show_branch = 0;
+	}
+
+	if (add_renormalize) {
 		exit_status |= renormalize_tracked_files(&pathspec, flags);
-	else
-		exit_status |= add_files_to_cache(the_repository, prefix,
+	} else {
+		exit_status |= add_files_to_cache_with_status(the_repository, prefix,
 						  &pathspec, include_sparse,
-						  flags);
+						  flags, &status);
+	}
 
-	if (add_new_files)
-		exit_status |= add_files(&dir, flags);
+	if (add_new_files) {
+		exit_status |= add_files(&dir, flags, &status);
+	}
+
+	if (show_only && table_format) {
+		wt_status_collect(&status);
+		wt_status_print(&status);
+		wt_status_collect_free_buffers(&status);
+	}
 
 	if (chmod_arg && pathspec.nr)
 		exit_status |= chmod_pathspec(&pathspec, chmod_arg[0], show_only);
diff --git a/builtin/commit.c b/builtin/commit.c
index 4338896dbf..33b15ef96e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -310,7 +310,7 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_index(&the_index, p->string, &st, 0))
+			if (add_file_to_index(&the_index, p->string, 0))
 				die(_("updating files failed"));
 		} else
 			remove_file_from_index(&the_index, p->string);
diff --git a/read-cache-ll.h b/read-cache-ll.h
index 9a1a7edc5a..b1cee2c7ee 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -4,6 +4,7 @@
 #include "hash-ll.h"
 #include "hashmap.h"
 #include "statinfo.h"
+#include "wt-status.h"
 
 /*
  * Basic data structures for the directory cache
@@ -395,6 +396,7 @@ int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_IGNORE_ERRORS	4
 #define ADD_CACHE_IGNORE_REMOVAL 8
 #define ADD_CACHE_INTENT 16
+#define ADD_CACHE_FORMAT_TABLE 32
 /*
  * These two are used to add the contents of the file at path
  * to the index, marking the working tree up-to-date by storing
@@ -404,7 +406,8 @@ int remove_file_from_index(struct index_state *, const char *path);
  * the latter will do necessary lstat(2) internally before
  * calling the former.
  */
-int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+int add_to_index(struct index_state *, const char *path, struct stat *, int flags, struct wt_status *status);
+int add_file_to_index_with_status(struct index_state *, const char *path, int flags, struct wt_status *status);
 int add_file_to_index(struct index_state *, const char *path, int flags);
 
 int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
@@ -475,6 +478,10 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags);
 
+int add_files_to_cache_with_status(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags, struct wt_status *status);
+
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
 
diff --git a/read-cache.c b/read-cache.c
index 080bd39713..e777cdb210 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -45,6 +45,8 @@
 #include "csum-file.h"
 #include "promisor-remote.h"
 #include "hook.h"
+#include "wt-status.h"
+#include "string-list.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -664,7 +666,7 @@ void set_object_name_for_intent_to_add_entry(struct cache_entry *ce)
 	oidcpy(&ce->oid, &oid);
 }
 
-int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags)
+int add_to_index(struct index_state *istate, const char *path, struct stat *st, int flags, struct wt_status *status)
 {
 	int namelen, was_same;
 	mode_t st_mode = st->st_mode;
@@ -672,6 +674,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	unsigned ce_option = CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE|CE_MATCH_RACY_IS_DIRTY;
 	int verbose = flags & (ADD_CACHE_VERBOSE | ADD_CACHE_PRETEND);
 	int pretend = flags & ADD_CACHE_PRETEND;
+	int table = flags & ADD_CACHE_FORMAT_TABLE;
 	int intent_only = flags & ADD_CACHE_INTENT;
 	int add_option = (ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE|
 			  (intent_only ? ADD_CACHE_NEW_ONLY : 0));
@@ -760,17 +763,26 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 		discard_cache_entry(ce);
 		return error(_("unable to add '%s' to index"), path);
 	}
-	if (verbose && !was_same)
+	if (verbose && !was_same && !table)
 		printf("add '%s'\n", path);
+	if (table && pretend && !was_same) {
+		string_list_insert(&status->dry_run_added, path);
+	}
 	return 0;
 }
 
-int add_file_to_index(struct index_state *istate, const char *path, int flags)
+int add_file_to_index_with_status(struct index_state *istate, const char *path, int flags, struct wt_status *status)
 {
 	struct stat st;
 	if (lstat(path, &st))
 		die_errno(_("unable to stat '%s'"), path);
-	return add_to_index(istate, path, &st, flags);
+	return add_to_index(istate, path, &st, flags, status);
+}
+
+int add_file_to_index(struct index_state *istate, const char *path, int flags)
+{
+	struct wt_status status;
+	return add_file_to_index_with_status(istate, path, flags, &status);
 }
 
 struct cache_entry *make_empty_cache_entry(struct index_state *istate, size_t len)
@@ -3872,6 +3884,7 @@ struct update_callback_data {
 	int include_sparse;
 	int flags;
 	int add_errors;
+	struct wt_status *status;
 };
 
 static int fix_unmerged_status(struct diff_filepair *p,
@@ -3914,7 +3927,7 @@ static void update_callback(struct diff_queue_struct *q,
 			die(_("unexpected diff status %c"), p->status);
 		case DIFF_STATUS_MODIFIED:
 		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(data->index, path, data->flags)) {
+			if (add_file_to_index_with_status(data->index, path, data->flags, data->status)) {
 				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
 					die(_("updating files failed"));
 				data->add_errors++;
@@ -3935,6 +3948,14 @@ static void update_callback(struct diff_queue_struct *q,
 int add_files_to_cache(struct repository *repo, const char *prefix,
 		       const struct pathspec *pathspec, int include_sparse,
 		       int flags)
+{
+	struct wt_status status;
+	return add_files_to_cache_with_status(repo, prefix, pathspec, include_sparse, flags, &status);
+}
+
+int add_files_to_cache_with_status(struct repository *repo, const char *prefix,
+		       const struct pathspec *pathspec, int include_sparse,
+		       int flags, struct wt_status *status)
 {
 	struct update_callback_data data;
 	struct rev_info rev;
@@ -3943,6 +3964,7 @@ int add_files_to_cache(struct repository *repo, const char *prefix,
 	data.index = repo->index;
 	data.include_sparse = include_sparse;
 	data.flags = flags;
+	data.status = status;
 
 	repo_init_revisions(repo, &rev, prefix);
 	setup_revisions(0, NULL, &rev, NULL);
diff --git a/table.c b/table.c
index 73751339da..a6fc660fec 100644
--- a/table.c
+++ b/table.c
@@ -65,18 +65,53 @@ static void build_table_entry(struct strbuf *buf, char *entry, int cols)
 		strbuf_addchars(buf, ' ', (cols / 3 - len - 1) / 2);
 }
 
-static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+static void add_arrow_to_entry(struct strbuf *buf, int add_after_entry)
+{
+	struct strbuf empty = STRBUF_INIT;
+	struct strbuf trimmed = STRBUF_INIT;
+	struct strbuf holder = STRBUF_INIT;
+	int len = strlen(buf->buf);
+
+	strbuf_addstr(&trimmed, buf->buf);
+	strbuf_trim(&trimmed);
+
+	if (!strbuf_cmp(&trimmed, &empty) && !add_after_entry) {
+		strbuf_reset(buf);
+		strbuf_addchars(buf, '-', len + 1);
+	} else if (add_after_entry) {
+		strbuf_rtrim(buf);
+		strbuf_addchars(buf, ' ', 1);
+		strbuf_addchars(buf, '-', len - strlen(buf->buf) + 1);
+	} else if (!add_after_entry) {
+		strbuf_ltrim(buf);
+		strbuf_addchars(&holder, '-', len - strlen(buf->buf) - 2);
+		strbuf_addchars(&holder, '>', 1);
+		strbuf_addchars(&holder, ' ', 1);
+		strbuf_addstr(&holder, buf->buf);
+		strbuf_reset(buf);
+		strbuf_addstr(buf, holder.buf);
+	}
+}
+
+static void print_table_body_line(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s, int hide_pipe)
 {
 	printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", buf1->buf);
-	printf(_("|"));
+	if (hide_pipe != 1 && hide_pipe != 3)
+		printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_CHANGED, s), "%s", buf2->buf);
-	printf(_("|"));
+	if (hide_pipe != 2 && hide_pipe != 3)
+		printf(_("|"));
 	color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%s", buf3->buf);
 	printf(_("|\n"));
 }
 
-void build_and_draw_status_table(struct wt_status *s, int add_advice)
+static void print_table_body_line_(struct strbuf *buf1, struct strbuf *buf2, struct strbuf *buf3, struct wt_status *s)
+{
+	print_table_body_line(buf1, buf2, buf3, s, 0);
+}
+
+void build_and_draw_status_table(struct wt_status *s, int advice)
 {
 	struct winsize w;
 	int cols;
@@ -84,7 +119,7 @@ void build_and_draw_status_table(struct wt_status *s, int add_advice)
 	struct strbuf table_col_entry_1 = STRBUF_INIT;
 	struct strbuf table_col_entry_2 = STRBUF_INIT;
 	struct strbuf table_col_entry_3 = STRBUF_INIT;
-	struct string_list_item *item;
+	struct string_list_item *item, *item2;
 
 	/* Get terminal width */
 	ioctl(STDOUT_FILENO, TIOCGWINSZ, &w);
@@ -104,7 +139,7 @@ void build_and_draw_status_table(struct wt_status *s, int add_advice)
 	printf(_("%s\n"), table_border.buf);
 	printf(_("|%s|%s|%s|\n"), table_col_entry_1.buf, table_col_entry_2.buf, table_col_entry_3.buf);
 
-	if (add_advice) {
+	if (advice) {
 		build_table_entry(&table_col_entry_1, "(stage: git add <file>)", cols);
 		build_table_entry(&table_col_entry_2, "(stage: git add <file>)", cols);
 		build_table_entry(&table_col_entry_3, "(unstage: git restore --staged <file>)", cols);
@@ -122,14 +157,38 @@ void build_and_draw_status_table(struct wt_status *s, int add_advice)
 
 	/* Draw table body */
 	for_each_string_list_item(item, &s->untracked) {
-		build_table_entry(&table_col_entry_1, item->string, cols);
+		struct strbuf buf_1 = STRBUF_INIT;
+		struct strbuf buf_2 = STRBUF_INIT;
+		int is_arrow = 0;
+		strbuf_addstr(&buf_1, item->string);
+		build_table_entry(&table_col_entry_1, buf_1.buf, cols);
 		build_table_entry(&table_col_entry_2, "", cols);
 		build_table_entry(&table_col_entry_3, "", cols);
-		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+
+		for_each_string_list_item(item2, &s->dry_run_added) {
+			strbuf_reset(&buf_2);
+			strbuf_addstr(&buf_2, item2->string);
+			if (!strbuf_cmp(&buf_1, &buf_2)) {
+				build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+				add_arrow_to_entry(&table_col_entry_1, 1);
+				add_arrow_to_entry(&table_col_entry_2, 0);
+				add_arrow_to_entry(&table_col_entry_3, 0);
+				is_arrow = 1;
+			}
+		}
+
+		if (!is_arrow)
+			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+		else
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 3);
 	}
 
 	for_each_string_list_item(item, &s->change) {
 		struct wt_status_change_data *d = item->util;
+		struct strbuf buf_1 = STRBUF_INIT;
+		struct strbuf buf_2 = STRBUF_INIT;
+		int is_arrow = 0;
+		strbuf_addstr(&buf_1, item->string);
 		if (d->worktree_status && d->index_status) {
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, item->string, cols);
@@ -138,12 +197,27 @@ void build_and_draw_status_table(struct wt_status *s, int add_advice)
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, item->string, cols);
 			build_table_entry(&table_col_entry_3, "", cols);
+
+			for_each_string_list_item(item2, &s->dry_run_added) {
+				strbuf_reset(&buf_2);
+				strbuf_addstr(&buf_2, item2->string);
+				if (!strbuf_cmp(&buf_1, &buf_2)) {
+					build_table_entry(&table_col_entry_3, buf_1.buf, cols);
+					add_arrow_to_entry(&table_col_entry_2, 1);
+					add_arrow_to_entry(&table_col_entry_3, 0);
+					is_arrow = 1;
+				}
+			}
 		} else if (d->index_status) {
 			build_table_entry(&table_col_entry_1, "", cols);
 			build_table_entry(&table_col_entry_2, "", cols);
 			build_table_entry(&table_col_entry_3, item->string, cols);
 		}
-		print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+
+		if (!is_arrow)
+			print_table_body_line_(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s);
+		else
+			print_table_body_line(&table_col_entry_1, &table_col_entry_2, &table_col_entry_3, s, 2);
 	}
 	
 	if (!s->untracked.nr && !s->change.nr) {
diff --git a/wt-status.c b/wt-status.c
index 62731859fe..975cfc01a5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -153,6 +153,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
+	s->dry_run_added.strdup_strings = 1;
 	s->show_branch = -1;  /* unspecified */
 	s->show_stash = 0;
 	s->ahead_behind_flags = AHEAD_BEHIND_UNSPECIFIED;
diff --git a/wt-status.h b/wt-status.h
index 70a3b7a2e4..5d29c058c1 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -142,6 +142,7 @@ struct wt_status {
 	struct string_list change;
 	struct string_list untracked;
 	struct string_list ignored;
+	struct string_list dry_run_added;
 	uint32_t untracked_in_ms;
 };
 
-- 
2.42.0.402.gbe8243af7b.dirty

