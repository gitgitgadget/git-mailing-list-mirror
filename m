From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH] Refactor structures in the form of *_struct.
Date: Wed, 4 Aug 2010 17:38:12 -0400
Message-ID: <c34445d9822bd9fd120902e80ed3637eacc818e3.1280956717.git.jaredhance@gmail.com>
References: <7vaap2fafm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 23:38:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OglfR-0004I7-LQ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726Ab0HDViY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 17:38:24 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45420 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235Ab0HDViW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 17:38:22 -0400
Received: by qyk7 with SMTP id 7so1629429qyk.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3Wt+jUPIuSnbk/JQUydS+TZ8uUoaeeEBqYqjG44DcVY=;
        b=mRjm0ecmIl7Ac/tMjfb4NOdGNhEWg0eKDJxkbsf6ZVY0WjAolwX364P9Q1fBd26elf
         ox6xRkyKMjKjHtRsNWY0cpkA2mLWvvY/OT3jwmEgelxY+8N3/bRVQ7bUVrRPT4SZVxYq
         BP34Dznkp1bDKjGDeU7MSK/VMZMpFVoELefwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ba6b3/nyezFHihd+RciuNtsOezALGTGsrnKk6WXo9O6LwqF86hCGJPHSmsR3yM+Oth
         GmJOjTHCtIj3GuJ0tiTBV3RbRet58l+BrfF6LKibIqLza1lreX3UyZe91fLashNbUz9d
         L9vGpeqhsrT8PXWm7Qq63BfCd4SD51Woq6F2I=
Received: by 10.229.51.215 with SMTP id e23mr2746147qcg.231.1280957899795;
        Wed, 04 Aug 2010 14:38:19 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id t4sm3470704qcs.4.2010.08.04.14.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 14:38:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vaap2fafm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152604>

Having a structure suffixed with _struct is extremely verbose,
especially since using the structure requires prefixing with the keyword
struct. Rename the following structures:

diff_queue_struct => diff_queue
dir_struct        => dir_table
cmd_struct        => cmd_desc

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---

Hopefully dir_table is a good name for dir_struct - I haven't done
much with that area of the code.

 builtin/add.c         |    8 ++++----
 builtin/clean.c       |    2 +-
 builtin/fast-export.c |    2 +-
 builtin/grep.c        |    2 +-
 builtin/ls-files.c    |   12 ++++++------
 builtin/merge.c       |    4 ++--
 builtin/read-tree.c   |    2 +-
 builtin/reset.c       |    2 +-
 combine-diff.c        |    2 +-
 diff.c                |   32 ++++++++++++++++----------------
 diff.h                |    4 ++--
 diffcore-break.c      |   10 +++++-----
 diffcore-order.c      |    2 +-
 diffcore-pickaxe.c    |    4 ++--
 diffcore-rename.c     |    4 ++--
 diffcore.h            |   10 +++++-----
 dir.c                 |   28 ++++++++++++++--------------
 dir.h                 |   14 +++++++-------
 git.c                 |    8 ++++----
 tree-diff.c           |    2 +-
 unpack-trees.c        |    2 +-
 unpack-trees.h        |    2 +-
 wt-status.c           |    6 +++---
 23 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 56a4e0a..40772dc 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -27,7 +27,7 @@ struct update_callback_data
 	int add_errors;
 };
 
-static void update_callback(struct diff_queue_struct *q,
+static void update_callback(struct diff_queue *q,
 			    struct diff_options *opt, void *cbdata)
 {
 	int i;
@@ -129,7 +129,7 @@ static char *find_used_pathspec(const char **pathspec)
 	return seen;
 }
 
-static char *prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
+static char *prune_directory(struct dir_table *dir, const char **pathspec, int prefix)
 {
 	char *seen;
 	int i, specs;
@@ -338,7 +338,7 @@ static int add_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int add_files(struct dir_struct *dir, int flags)
+static int add_files(struct dir_table *dir, int flags)
 {
 	int i, exit_status = 0;
 
@@ -364,7 +364,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	int exit_status = 0;
 	int newfd;
 	const char **pathspec;
-	struct dir_struct dir;
+	struct dir_table dir;
 	int flags;
 	int add_new_files;
 	int require_pathspec;
diff --git a/builtin/clean.c b/builtin/clean.c
index fac64e6..e632ff5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -33,7 +33,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	int ignored_only = 0, baselen = 0, config_set = 0, errors = 0;
 	int rm_flags = REMOVE_DIR_KEEP_NESTED_GIT;
 	struct strbuf directory = STRBUF_INIT;
-	struct dir_struct dir;
+	struct dir_table dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	const char *qname;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9fe25ff..8f26380 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -147,7 +147,7 @@ static void handle_object(const unsigned char *sha1)
 	free(buf);
 }
 
-static void show_filemodify(struct diff_queue_struct *q,
+static void show_filemodify(struct diff_queue *q,
 			    struct diff_options *options, void *data)
 {
 	int i;
diff --git a/builtin/grep.c b/builtin/grep.c
index 597f76b..1f8d3c5 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -724,7 +724,7 @@ static int grep_objects(struct grep_opt *opt, const char **paths,
 
 static int grep_directory(struct grep_opt *opt, const char **paths)
 {
-	struct dir_struct dir;
+	struct dir_table dir;
 	int i, hit = 0;
 
 	memset(&dir, 0, sizeof(dir));
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index cc202c5..81949f8 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -65,7 +65,7 @@ static void show_dir_entry(const char *tag, struct dir_entry *ent)
 	write_name(ent->name, ent->len);
 }
 
-static void show_other_files(struct dir_struct *dir)
+static void show_other_files(struct dir_table *dir)
 {
 	int i;
 
@@ -77,7 +77,7 @@ static void show_other_files(struct dir_struct *dir)
 	}
 }
 
-static void show_killed_files(struct dir_struct *dir)
+static void show_killed_files(struct dir_table *dir)
 {
 	int i;
 	for (i = 0; i < dir->nr; i++) {
@@ -201,7 +201,7 @@ static void show_ru_info(void)
 	for_each_string_list(the_index.resolve_undo, show_one_ru, NULL);
 }
 
-static void show_files(struct dir_struct *dir)
+static void show_files(struct dir_table *dir)
 {
 	int i;
 
@@ -451,7 +451,7 @@ static int option_parse_exclude(const struct option *opt,
 static int option_parse_exclude_from(const struct option *opt,
 				     const char *arg, int unset)
 {
-	struct dir_struct *dir = opt->value;
+	struct dir_table *dir = opt->value;
 
 	exc_given = 1;
 	add_excludes_from_file(dir, arg);
@@ -462,7 +462,7 @@ static int option_parse_exclude_from(const struct option *opt,
 static int option_parse_exclude_standard(const struct option *opt,
 					 const char *arg, int unset)
 {
-	struct dir_struct *dir = opt->value;
+	struct dir_table *dir = opt->value;
 
 	exc_given = 1;
 	setup_standard_excludes(dir);
@@ -474,7 +474,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
 	int require_work_tree = 0, show_tag = 0;
 	const char *max_prefix;
-	struct dir_struct dir;
+	struct dir_table dir;
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			"paths are separated with NUL character",
diff --git a/builtin/merge.c b/builtin/merge.c
index 37ce4f5..9ec2a81 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -657,7 +657,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	}
 }
 
-static void count_diff_files(struct diff_queue_struct *q,
+static void count_diff_files(struct diff_queue *q,
 			     struct diff_options *opt, void *data)
 {
 	int *count = data;
@@ -682,7 +682,7 @@ int checkout_fast_forward(const unsigned char *head, const unsigned char *remote
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
 	int i, fd, nr_trees = 0;
-	struct dir_struct dir;
+	struct dir_table dir;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
 	refresh_cache(REFRESH_QUIET);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 9ad1e66..f46ebcb 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -46,7 +46,7 @@ static int index_output_cb(const struct option *opt, const char *arg,
 static int exclude_per_directory_cb(const struct option *opt, const char *arg,
 				    int unset)
 {
-	struct dir_struct *dir;
+	struct dir_table *dir;
 	struct unpack_trees_options *opts;
 
 	opts = (struct unpack_trees_options *)opt->value;
diff --git a/builtin/reset.c b/builtin/reset.c
index 1283068..22abb49 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -149,7 +149,7 @@ static int update_index_refresh(int fd, struct lock_file *index_lock, int flags)
 	return result;
 }
 
-static void update_index_from_diff(struct diff_queue_struct *q,
+static void update_index_from_diff(struct diff_queue *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..bd1b0d9 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -10,7 +10,7 @@
 
 static struct combine_diff_path *intersect_paths(struct combine_diff_path *curr, int n, int num_parent)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	struct combine_diff_path *p;
 	int i;
 
diff --git a/diff.c b/diff.c
index 17873f3..cf92ce4 100644
--- a/diff.c
+++ b/diff.c
@@ -1509,7 +1509,7 @@ static void show_dirstat(struct diff_options *options)
 	int i;
 	unsigned long changed;
 	struct dirstat_dir dir;
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 
 	dir.files = NULL;
 	dir.alloc = 0;
@@ -3284,9 +3284,9 @@ static int diff_scoreopt_parse(const char *opt)
 	return opt1 | (opt2 << 16);
 }
 
-struct diff_queue_struct diff_queued_diff;
+struct diff_queue diff_queued_diff;
 
-void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
+void diff_q(struct diff_queue *queue, struct diff_filepair *dp)
 {
 	if (queue->alloc <= queue->nr) {
 		queue->alloc = alloc_nr(queue->alloc);
@@ -3296,7 +3296,7 @@ void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
 	queue->queue[queue->nr++] = dp;
 }
 
-struct diff_filepair *diff_queue(struct diff_queue_struct *queue,
+struct diff_filepair *diff_queue(struct diff_queue *queue,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
@@ -3449,7 +3449,7 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 
 int diff_queue_is_empty(void)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	int i;
 	for (i = 0; i < q->nr; i++)
 		if (!diff_unmodified_pair(q->queue[i]))
@@ -3480,7 +3480,7 @@ void diff_debug_filepair(const struct diff_filepair *p, int i)
 		p->one->rename_used, p->broken_pair);
 }
 
-void diff_debug_queue(const char *msg, struct diff_queue_struct *q)
+void diff_debug_queue(const char *msg, struct diff_queue *q)
 {
 	int i;
 	if (msg)
@@ -3497,7 +3497,7 @@ static void diff_resolve_rename_copy(void)
 {
 	int i;
 	struct diff_filepair *p;
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 
 	diff_debug_queue("resolve-rename-copy", q);
 
@@ -3688,7 +3688,7 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 /* returns 0 upon success, and writes result into sha1 */
 static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	int i;
 	git_SHA_CTX ctx;
 	struct patch_id_t data;
@@ -3771,7 +3771,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
 int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	int i;
 	int result = diff_get_patch_id(options, sha1);
 
@@ -3784,7 +3784,7 @@ int diff_flush_patch_id(struct diff_options *options, unsigned char *sha1)
 	return result;
 }
 
-static int is_summary_empty(const struct diff_queue_struct *q)
+static int is_summary_empty(const struct diff_queue *q)
 {
 	int i;
 
@@ -3811,7 +3811,7 @@ static int is_summary_empty(const struct diff_queue_struct *q)
 
 void diff_flush(struct diff_options *options)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	int i, output_format = options->output_format;
 	int separator = 0;
 
@@ -3928,8 +3928,8 @@ free_queue:
 static void diffcore_apply_filter(const char *filter)
 {
 	int i;
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue *q = &diff_queued_diff;
+	struct diff_queue outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
 	if (!filter)
@@ -3996,8 +3996,8 @@ static int diff_filespec_is_identical(struct diff_filespec *one,
 static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 {
 	int i;
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue *q = &diff_queued_diff;
+	struct diff_queue outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
 	for (i = 0; i < q->nr; i++) {
@@ -4053,7 +4053,7 @@ static int diffnamecmp(const void *a_, const void *b_)
 
 void diffcore_fix_diff_index(struct diff_options *options)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	qsort(q->queue, q->nr, sizeof(q->queue[0]), diffnamecmp);
 }
 
diff --git a/diff.h b/diff.h
index 063d10a..62aca85 100644
--- a/diff.h
+++ b/diff.h
@@ -8,7 +8,7 @@
 
 struct rev_info;
 struct diff_options;
-struct diff_queue_struct;
+struct diff_queue;
 struct strbuf;
 struct diff_filespec;
 struct userdiff_driver;
@@ -25,7 +25,7 @@ typedef void (*add_remove_fn_t)(struct diff_options *options,
 		    const unsigned char *sha1,
 		    const char *fullpath, unsigned dirty_submodule);
 
-typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
+typedef void (*diff_format_fn_t)(struct diff_queue *q,
 		struct diff_options *options, void *data);
 
 typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
diff --git a/diffcore-break.c b/diffcore-break.c
index 44f8678..ffda61f 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -114,8 +114,8 @@ static int should_break(struct diff_filespec *src,
 
 void diffcore_break(int break_score)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue *q = &diff_queued_diff;
+	struct diff_queue outq;
 
 	/* When the filepair has this much edit (insert and delete),
 	 * it is first considered to be a rewrite and broken into a
@@ -223,7 +223,7 @@ void diffcore_break(int break_score)
 
 static void merge_broken(struct diff_filepair *p,
 			 struct diff_filepair *pp,
-			 struct diff_queue_struct *outq)
+			 struct diff_queue *outq)
 {
 	/* p and pp are broken pairs we want to merge */
 	struct diff_filepair *c = p, *d = pp, *dp;
@@ -251,8 +251,8 @@ static void merge_broken(struct diff_filepair *p,
 
 void diffcore_merge_broken(void)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue *q = &diff_queued_diff;
+	struct diff_queue outq;
 	int i, j;
 
 	DIFF_QUEUE_CLEAR(&outq);
diff --git a/diffcore-order.c b/diffcore-order.c
index 23e9385..9e69f67 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -102,7 +102,7 @@ static int compare_pair_order(const void *a_, const void *b_)
 
 void diffcore_order(const char *orderfile)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	struct pair_order *o;
 	int i;
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 929de15..4b5865b 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -50,11 +50,11 @@ static unsigned int contains(struct diff_filespec *one,
 
 void diffcore_pickaxe(const char *needle, int opts)
 {
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	unsigned long len = strlen(needle);
 	int i, has_changes;
 	regex_t regex, *regexp = NULL;
-	struct diff_queue_struct outq;
+	struct diff_queue outq;
 	DIFF_QUEUE_CLEAR(&outq);
 
 	if (opts & DIFF_PICKAXE_REGEX) {
diff --git a/diffcore-rename.c b/diffcore-rename.c
index df41be5..a2a9f19 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -419,8 +419,8 @@ void diffcore_rename(struct diff_options *options)
 	int detect_rename = options->detect_rename;
 	int minimum_score = options->rename_score;
 	int rename_limit = options->rename_limit;
-	struct diff_queue_struct *q = &diff_queued_diff;
-	struct diff_queue_struct outq;
+	struct diff_queue *q = &diff_queued_diff;
+	struct diff_queue outq;
 	struct diff_score *mx;
 	int i, j, rename_count;
 	int num_create, num_src, dst_cnt;
diff --git a/diffcore.h b/diffcore.h
index 491bea0..12cb8f7 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -87,7 +87,7 @@ extern void diff_free_filepair(struct diff_filepair *);
 
 extern int diff_unmodified_pair(struct diff_filepair *);
 
-struct diff_queue_struct {
+struct diff_queue {
 	struct diff_filepair **queue;
 	int alloc;
 	int nr;
@@ -100,11 +100,11 @@ struct diff_queue_struct {
 		(q)->run = 0; \
 	} while(0);
 
-extern struct diff_queue_struct diff_queued_diff;
-extern struct diff_filepair *diff_queue(struct diff_queue_struct *,
+extern struct diff_queue diff_queued_diff;
+extern struct diff_filepair *diff_queue(struct diff_queue *,
 					struct diff_filespec *,
 					struct diff_filespec *);
-extern void diff_q(struct diff_queue_struct *, struct diff_filepair *);
+extern void diff_q(struct diff_queue *, struct diff_filepair *);
 
 extern void diffcore_break(int);
 extern void diffcore_rename(struct diff_options *);
@@ -116,7 +116,7 @@ extern void diffcore_order(const char *orderfile);
 #if DIFF_DEBUG
 void diff_debug_filespec(struct diff_filespec *, int, const char *);
 void diff_debug_filepair(const struct diff_filepair *, int);
-void diff_debug_queue(const char *, struct diff_queue_struct *);
+void diff_debug_queue(const char *, struct diff_queue *);
 #else
 #define diff_debug_filespec(a,b,c) do {} while(0)
 #define diff_debug_filepair(a,b) do {} while(0)
diff --git a/dir.c b/dir.c
index 133f472..21539aa 100644
--- a/dir.c
+++ b/dir.c
@@ -14,7 +14,7 @@ struct path_simplify {
 	const char *path;
 };
 
-static int read_directory_recursive(struct dir_struct *dir, const char *path, int len,
+static int read_directory_recursive(struct dir_table *dir, const char *path, int len,
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
@@ -51,7 +51,7 @@ static int common_prefix(const char **pathspec)
 	return prefix;
 }
 
-int fill_directory(struct dir_struct *dir, const char **pathspec)
+int fill_directory(struct dir_table *dir, const char **pathspec)
 {
 	const char *path;
 	int len;
@@ -282,14 +282,14 @@ int add_excludes_from_file_to_list(const char *fname,
 	return 0;
 }
 
-void add_excludes_from_file(struct dir_struct *dir, const char *fname)
+void add_excludes_from_file(struct dir_table *dir, const char *fname)
 {
 	if (add_excludes_from_file_to_list(fname, "", 0, NULL,
 					   &dir->exclude_list[EXC_FILE], 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
-static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
+static void prep_exclude(struct dir_table *dir, const char *base, int baselen)
 {
 	struct exclude_list *el;
 	struct exclude_stack *stk = NULL;
@@ -413,7 +413,7 @@ int excluded_from_list(const char *pathname,
 	return -1; /* undecided */
 }
 
-int excluded(struct dir_struct *dir, const char *pathname, int *dtype_p)
+int excluded(struct dir_table *dir, const char *pathname, int *dtype_p)
 {
 	int pathlen = strlen(pathname);
 	int st;
@@ -444,7 +444,7 @@ static struct dir_entry *dir_entry_new(const char *pathname, int len)
 	return ent;
 }
 
-static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathname, int len)
+static struct dir_entry *dir_add_name(struct dir_table *dir, const char *pathname, int len)
 {
 	if (cache_name_exists(pathname, len, ignore_case))
 		return NULL;
@@ -453,7 +453,7 @@ static struct dir_entry *dir_add_name(struct dir_struct *dir, const char *pathna
 	return dir->entries[dir->nr++] = dir_entry_new(pathname, len);
 }
 
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len)
+struct dir_entry *dir_add_ignored(struct dir_table *dir, const char *pathname, int len)
 {
 	if (!cache_name_is_other(pathname, len))
 		return NULL;
@@ -536,7 +536,7 @@ enum directory_treatment {
 	recurse_into_directory
 };
 
-static enum directory_treatment treat_directory(struct dir_struct *dir,
+static enum directory_treatment treat_directory(struct dir_table *dir,
 	const char *dirname, int len,
 	const struct path_simplify *simplify)
 {
@@ -687,7 +687,7 @@ enum path_treatment {
 	path_recurse
 };
 
-static enum path_treatment treat_one_path(struct dir_struct *dir,
+static enum path_treatment treat_one_path(struct dir_table *dir,
 					  char *path, int *len,
 					  const struct path_simplify *simplify,
 					  int dtype, struct dirent *de)
@@ -743,7 +743,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	return path_handled;
 }
 
-static enum path_treatment treat_path(struct dir_struct *dir,
+static enum path_treatment treat_path(struct dir_table *dir,
 				      struct dirent *de,
 				      char *path, int path_max,
 				      int baselen,
@@ -776,7 +776,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir,
+static int read_directory_recursive(struct dir_table *dir,
 				    const char *base, int baselen,
 				    int check_only,
 				    const struct path_simplify *simplify)
@@ -869,7 +869,7 @@ static void free_simplify(struct path_simplify *simplify)
 	free(simplify);
 }
 
-static int treat_leading_path(struct dir_struct *dir,
+static int treat_leading_path(struct dir_table *dir,
 			      const char *path, int len,
 			      const struct path_simplify *simplify)
 {
@@ -904,7 +904,7 @@ static int treat_leading_path(struct dir_struct *dir,
 	}
 }
 
-int read_directory(struct dir_struct *dir, const char *path, int len, const char **pathspec)
+int read_directory(struct dir_table *dir, const char *path, int len, const char **pathspec)
 {
 	struct path_simplify *simplify;
 
@@ -1040,7 +1040,7 @@ int remove_dir_recursively(struct strbuf *path, int flag)
 	return ret;
 }
 
-void setup_standard_excludes(struct dir_struct *dir)
+void setup_standard_excludes(struct dir_table *dir)
 {
 	const char *path;
 
diff --git a/dir.h b/dir.h
index 278d84c..f2a02a0 100644
--- a/dir.h
+++ b/dir.h
@@ -31,7 +31,7 @@ struct exclude_stack {
 	int exclude_ix;
 };
 
-struct dir_struct {
+struct dir_table {
 	int nr, alloc;
 	int ignored_nr, ignored_alloc;
 	enum {
@@ -66,16 +66,16 @@ struct dir_struct {
 #define MATCHED_EXACTLY 3
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 
-extern int fill_directory(struct dir_struct *dir, const char **pathspec);
-extern int read_directory(struct dir_struct *, const char *path, int len, const char **pathspec);
+extern int fill_directory(struct dir_table *dir, const char **pathspec);
+extern int read_directory(struct dir_table *, const char *path, int len, const char **pathspec);
 
 extern int excluded_from_list(const char *pathname, int pathlen, const char *basename,
 			      int *dtype, struct exclude_list *el);
-extern int excluded(struct dir_struct *, const char *, int *);
-struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pathname, int len);
+extern int excluded(struct dir_table *, const char *, int *);
+struct dir_entry *dir_add_ignored(struct dir_table *dir, const char *pathname, int len);
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  char **buf_p, struct exclude_list *which, int check_index);
-extern void add_excludes_from_file(struct dir_struct *, const char *fname);
+extern void add_excludes_from_file(struct dir_table *, const char *fname);
 extern void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *which);
 extern int file_exists(const char *);
@@ -92,7 +92,7 @@ static inline int is_dot_or_dotdot(const char *name)
 
 extern int is_empty_dir(const char *dir);
 
-extern void setup_standard_excludes(struct dir_struct *dir);
+extern void setup_standard_excludes(struct dir_table *dir);
 
 #define REMOVE_DIR_EMPTY_ONLY 01
 #define REMOVE_DIR_KEEP_NESTED_GIT 02
diff --git a/git.c b/git.c
index f37028b..6d80171 100644
--- a/git.c
+++ b/git.c
@@ -237,13 +237,13 @@ const char git_version_string[] = GIT_VERSION;
  */
 #define NEED_WORK_TREE	(1<<2)
 
-struct cmd_struct {
+struct cmd_desc {
 	const char *cmd;
 	int (*fn)(int, const char **, const char *);
 	int option;
 };
 
-static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
+static int run_builtin(struct cmd_desc *p, int argc, const char **argv)
 {
 	int status, help;
 	struct stat st;
@@ -291,7 +291,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 static void handle_internal_command(int argc, const char **argv)
 {
 	const char *cmd = argv[0];
-	static struct cmd_struct commands[] = {
+	static struct cmd_desc commands[] = {
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
@@ -420,7 +420,7 @@ static void handle_internal_command(int argc, const char **argv)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
-		struct cmd_struct *p = commands+i;
+		struct cmd_desc *p = commands+i;
 		if (strcmp(p->cmd, cmd))
 			continue;
 		exit(run_builtin(p, argc, argv));
diff --git a/tree-diff.c b/tree-diff.c
index 1fb3e94..d4f07ee 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -335,7 +335,7 @@ static inline int diff_might_be_rename(void)
 static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, const char *base, struct diff_options *opt)
 {
 	struct diff_options diff_opts;
-	struct diff_queue_struct *q = &diff_queued_diff;
+	struct diff_queue *q = &diff_queued_diff;
 	struct diff_filepair *choice;
 	const char *paths[1];
 	int i;
diff --git a/unpack-trees.c b/unpack-trees.c
index 8cf0da3..7845b84 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -930,7 +930,7 @@ static int verify_clean_subdirectory(struct cache_entry *ce, const char *action,
 	 */
 	int namelen;
 	int i;
-	struct dir_struct d;
+	struct dir_table d;
 	char *pathbuf;
 	int cnt = 0;
 	unsigned char sha1[20];
diff --git a/unpack-trees.h b/unpack-trees.h
index ef70eab..9eb9007 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -36,7 +36,7 @@ struct unpack_trees_options {
 		     gently;
 	const char *prefix;
 	int cache_bottom;
-	struct dir_struct *dir;
+	struct dir_table *dir;
 	merge_fn_t fn;
 	struct unpack_trees_error_msgs msgs;
 
diff --git a/wt-status.c b/wt-status.c
index 2f9e33c..34a402b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -220,7 +220,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	strbuf_release(&twobuf);
 }
 
-static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
+static void wt_status_collect_changed_cb(struct diff_queue *q,
 					 struct diff_options *options,
 					 void *data)
 {
@@ -270,7 +270,7 @@ static int unmerged_mask(const char *path)
 	return mask;
 }
 
-static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
+static void wt_status_collect_updated_cb(struct diff_queue *q,
 					 struct diff_options *options,
 					 void *data)
 {
@@ -373,7 +373,7 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
 static void wt_status_collect_untracked(struct wt_status *s)
 {
 	int i;
-	struct dir_struct dir;
+	struct dir_table dir;
 
 	if (!s->show_untracked_files)
 		return;
-- 
1.7.2
