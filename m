Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25218C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 13:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCON07 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 09:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjCON0z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 09:26:55 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F026BD
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:26:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j42-20020a05600c1c2a00b003ed363619ddso540243wms.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 06:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678886807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA9Lob7SXLMZGbxIo1I/NHys78jN+jYhK2uOj0z3j2I=;
        b=pM2moJnx3fBNAJ0qq2KpXT8dFOY06FCSa9j7jmQOjV7E51x+JFCErPWZUbVyDj0PbY
         l0A+Qr/lAthdk4S+SKMYllvDr/qGNCl7dgFCbf8wa6cIHpO2BzdWPwlPztfwkKgkdHpk
         gaGmpSHXtY8b3buP0XXpwLbw0t5KuyPaB8rlJV/yc8GW8zrG4TvdBC6Po9LsOTtnUbuW
         VgZnVwPSQ8C6Gm7eFvcxkuXNwkkpbB42yuhwulPVR3Ys4U+CLahWysbcBkIxU0Iu+O86
         GonLpWQxDs/827O/H+RsNnfyce26xPUXDmFfwlQNBAIG/pAFUFsMJIrG9xSzX+jhfr3B
         VE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GA9Lob7SXLMZGbxIo1I/NHys78jN+jYhK2uOj0z3j2I=;
        b=0o6ekfCnNVhsltA0mwnmdSvk6tn7/jyIEW/cU4SrZpmsX9zkz8uuCNWcW2ujIVT4z4
         IS+7/RVMsnPqYLCanYk1Nc5O0PDxTiCDvyOlRzoNH6C9mYP72wtEGFPxUsrgOZQHOAec
         L0wQGRsVWpnf34eC3KpxRbCqq02DyknIl7T3zHqBUXtYwNLytLVP+iggeb99d1CKRL/r
         PFTUdoVjpHjAwIncdwmsnVCAc1GI9yLaSRCU9vbpOsa4DLkSQCiPIDi+yOBXO4Q58KET
         lnJ5uWxWRi3deTMaHTq31dduaiPHjZ0vnF6JyzzZRKww3LiEtOOT33q/LkjKpEgtj2KY
         u0Fg==
X-Gm-Message-State: AO0yUKUKWYc7U/f6lso6KkIrdBMHtJkqHrT+4duo70C8ylnqr1vAorub
        h02HTTHUJtuZp8YYix4+QJownBrRmmM=
X-Google-Smtp-Source: AK7set8Senxn5yaae+Bkm7H6JSx+X2Tm9DWjBLLTLDQEe0+t8+prbgkTKXBF7A/C7lco6kxJJR+v6A==
X-Received: by 2002:a05:600c:538b:b0:3eb:2b88:5af2 with SMTP id hg11-20020a05600c538b00b003eb2b885af2mr17705310wmb.20.1678886806118;
        Wed, 15 Mar 2023 06:26:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc009000000b003ed3084669asm1936123wmb.14.2023.03.15.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:26:45 -0700 (PDT)
Message-Id: <pull.1399.v17.git.git.1678886803276.gitgitgadget@gmail.com>
In-Reply-To: <pull.1399.v16.git.git.1678886439331.gitgitgadget@gmail.com>
References: <pull.1399.v16.git.git.1678886439331.gitgitgadget@gmail.com>
From:   "Rose via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Mar 2023 13:26:42 +0000
Subject: [PATCH v17] git: change variable types to match what is assigned to
 them
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Rose <83477269+AtariDreams@users.noreply.github.com>,
        Seija Kijin <doremylover123@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Seija Kijin <doremylover123@gmail.com>

There are many places where "int len = strlen(foo);" is written,
just for len to be passed as a parameter of size_t.

This causes truncation and then expansion
back from int to size_t. This is poor logic.

As of right now, the current set of changes
is too large to keep going, so future changes
should be in future patches. However, the codebase
works perfectly even if only these changes
were ever to be accepted. I just do not want
to change too much at a time.

Signed-off-by: Seija Kijin <doremylover123@gmail.com>
---
    git: change variable types to match what is assigned to them
    
    There are many places where "int len = strlen(foo);" is written, just
    for len to be passed as a parameter of size_t. This causes truncation
    and then expansion back from int to size_t. Not to mention this is poor
    logic and needless truncations can add extra unneeded instructions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1399%2FAtariDreams%2Ffix-type-v17
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1399/AtariDreams/fix-type-v17
Pull-Request: https://github.com/git/git/pull/1399

Range-diff vs v16:

 1:  8b4008fd55d ! 1:  e85f9787279 git: change variable types to match what is assigned to them
     @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
       
       int init_db(const char *git_dir, const char *real_git_dir,
      -	    const char *template_dir, int hash_algo,
     -+	    const char *template_dir, unsigned int hash_algo,
     ++	    const char *template_dir, int hash,
       	    const char *initial_branch, unsigned int flags);
      -void initialize_repository_version(int hash_algo, int reinit);
     -+void initialize_repository_version(unsigned int hash_algo, int reinit);
     ++void initialize_repository_version(unsigned int hash, int reinit);
       
       void sanitize_stdfds(void);
       int daemonize(void);


 add-interactive.c             | 29 ++++++-----
 add-patch.c                   |  3 +-
 advice.c                      |  4 +-
 apply.c                       | 64 +++++++++++-------------
 apply.h                       |  8 +--
 archive-tar.c                 |  8 +--
 archive.c                     |  2 +-
 attr.c                        | 10 ++--
 base85.c                      | 11 +++--
 bisect.c                      |  8 +--
 blame.c                       | 20 ++++----
 block-sha1/sha1.c             |  2 +-
 bloom.c                       | 10 ++--
 branch.c                      |  4 +-
 builtin/add.c                 |  3 +-
 builtin/clone.c               |  2 +-
 builtin/commit.c              |  2 +-
 builtin/fast-export.c         |  4 +-
 builtin/fast-import.c         |  2 +-
 builtin/fetch-pack.c          |  2 +-
 builtin/fetch.c               |  7 +--
 builtin/for-each-repo.c       |  3 +-
 builtin/fsck.c                |  2 +-
 builtin/gc.c                  | 43 +++++++++-------
 builtin/grep.c                |  5 +-
 builtin/help.c                |  2 +-
 builtin/index-pack.c          |  2 +-
 builtin/init-db.c             | 10 ++--
 builtin/log.c                 |  4 +-
 builtin/ls-files.c            | 24 ++++-----
 builtin/ls-remote.c           |  1 -
 builtin/mailsplit.c           |  2 +-
 builtin/merge-file.c          |  3 +-
 builtin/merge.c               |  3 +-
 builtin/name-rev.c            |  4 +-
 builtin/pack-objects.c        |  4 +-
 builtin/pack-redundant.c      |  6 +--
 builtin/patch-id.c            | 14 +++---
 builtin/pull.c                |  2 +-
 builtin/read-tree.c           |  6 +--
 builtin/rebase.c              |  6 +--
 builtin/receive-pack.c        | 12 +++--
 builtin/remote.c              | 12 +++--
 builtin/repack.c              |  7 +--
 builtin/rerere.c              |  3 +-
 builtin/reset.c               |  2 +-
 builtin/rev-parse.c           |  2 +-
 builtin/rm.c                  | 10 ++--
 builtin/show-branch.c         | 34 ++++++-------
 builtin/show-index.c          |  4 +-
 builtin/sparse-checkout.c     |  7 +--
 builtin/stash.c               |  4 +-
 builtin/submodule--helper.c   |  7 +--
 builtin/unpack-objects.c      |  2 +-
 builtin/update-ref.c          |  4 +-
 builtin/worktree.c            |  7 +--
 bulk-checkin.c                |  4 +-
 bundle.c                      | 15 +++---
 cache-tree.c                  | 10 ++--
 cache.h                       | 16 +++---
 chunk-format.c                |  7 +--
 color.c                       | 34 +++++++------
 color.h                       |  2 +-
 column.c                      |  9 ++--
 combine-diff.c                | 19 ++++---
 commit-graph.c                | 19 +++----
 commit-reach.c                | 11 +++--
 commit.c                      | 10 ++--
 compat/compiler.h             |  9 ++--
 compat/strcasestr.c           | 10 ++--
 compat/unsetenv.c             |  2 +-
 compat/winansi.c              |  7 +--
 config.c                      | 31 +++++++-----
 config.h                      |  2 +-
 connect.c                     | 22 ++++-----
 convert.c                     | 16 +++---
 credential.c                  |  6 +--
 daemon.c                      | 14 +++---
 date.c                        |  4 +-
 decorate.c                    |  6 +--
 delta-islands.c               | 10 ++--
 diagnose.c                    |  2 +-
 diff-lib.c                    |  4 +-
 diff-no-index.c               |  3 +-
 diff.c                        | 35 ++++++-------
 dir.c                         |  3 +-
 dir.h                         |  2 +-
 fetch-pack.c                  |  4 +-
 fsck.c                        |  4 +-
 git.c                         |  2 +-
 hash.h                        |  8 +--
 help.c                        | 10 ++--
 help.h                        |  4 +-
 hex.c                         |  4 +-
 http-backend.c                |  4 +-
 http-push.c                   |  8 +--
 http-walker.c                 |  8 +--
 http.c                        | 16 +++---
 line-log.c                    |  4 +-
 list-objects-filter-options.c |  2 +-
 list-objects.c                |  4 +-
 ll-merge.c                    |  5 +-
 lockfile.c                    |  2 +-
 log-tree.c                    |  2 +-
 ls-refs.c                     |  2 +-
 mailinfo.c                    |  8 +--
 merge-ort.c                   | 93 ++++++++++++++++++-----------------
 merge-recursive.c             | 27 +++++-----
 merge-recursive.h             |  2 +-
 merge.c                       |  5 +-
 mergesort.h                   |  2 +-
 name-hash.c                   |  6 +--
 notes-utils.c                 |  4 +-
 notes.c                       |  4 +-
 object-file.c                 | 12 ++---
 object-name.c                 |  6 +--
 path.c                        |  4 +-
 pathspec.c                    | 22 +++++----
 pathspec.h                    |  4 +-
 pkt-line.c                    |  2 +-
 pretty.c                      | 28 +++++------
 range-diff.c                  | 15 +++---
 read-cache.c                  | 45 +++++++++--------
 remote-curl.c                 |  2 +-
 repository.c                  |  2 +-
 repository.h                  |  2 +-
 run-command.c                 |  5 +-
 shallow.c                     |  2 +-
 shallow.h                     |  2 +-
 strbuf.c                      |  4 +-
 string-list.c                 |  3 +-
 string-list.h                 |  3 +-
 sub-process.c                 |  4 +-
 submodule.c                   | 16 +++---
 submodule.h                   |  2 +-
 trailer.c                     |  2 +-
 transport-helper.c            | 10 ++--
 transport.c                   |  8 +--
 unpack-trees.c                | 16 +++---
 unpack-trees.h                |  2 +-
 wt-status.c                   | 29 +++++------
 xdiff-interface.c             |  6 +--
 142 files changed, 687 insertions(+), 627 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 00a0f6f96f3..5ece4dab996 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -218,7 +218,8 @@ static ssize_t find_unique(const char *string, struct prefix_item_list *list)
 struct list_options {
 	int columns;
 	const char *header;
-	void (*print_item)(int i, int selected, struct string_list_item *item,
+	void (*print_item)(size_t i, int selected,
+			   struct string_list_item *item,
 			   void *print_item_data);
 	void *print_item_data;
 };
@@ -226,7 +227,8 @@ struct list_options {
 static void list(struct add_i_state *s, struct string_list *list, int *selected,
 		 struct list_options *opts)
 {
-	int i, last_lf = 0;
+	size_t i;
+	int last_lf = 0;
 
 	if (!list->nr)
 		return;
@@ -469,7 +471,7 @@ static void collect_changes_cb(struct diff_queue_struct *q,
 
 	for (i = 0; i < stat.nr; i++) {
 		const char *name = stat.files[i]->name;
-		int hash = strhash(name);
+		unsigned int hash = strhash(name);
 		struct pathname_entry *entry;
 		struct file_item *file_item;
 		struct adddel *adddel, *other_adddel;
@@ -528,7 +530,7 @@ static int get_modified_files(struct repository *r,
 	int is_initial = !resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 					     &head_oid, NULL);
 	struct collection_status s = { 0 };
-	int i;
+	unsigned int i;
 
 	discard_index(r->index);
 	if (repo_read_index_preload(r, ps, 0) < 0)
@@ -617,12 +619,14 @@ struct print_file_item_data {
 	unsigned only_names:1;
 };
 
-static void print_file_item(int i, int selected, struct string_list_item *item,
+static void print_file_item(size_t i, int selected,
+			    struct string_list_item *item,
 			    void *print_file_item_data)
 {
 	struct file_item *c = item->util;
 	struct print_file_item_data *d = print_file_item_data;
 	const char *highlighted = NULL;
+	unsigned int e = (unsigned int)i + 1;
 
 	strbuf_reset(&d->index);
 	strbuf_reset(&d->worktree);
@@ -639,7 +643,7 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 	}
 
 	if (d->only_names) {
-		printf("%c%2d: %s", selected ? '*' : ' ', i + 1,
+		printf("%c%2u: %s", selected ? '*' : ' ', e,
 		       highlighted ? highlighted : item->string);
 		return;
 	}
@@ -650,7 +654,7 @@ static void print_file_item(int i, int selected, struct string_list_item *item,
 	strbuf_addf(&d->buf, d->modified_fmt, d->index.buf, d->worktree.buf,
 		    highlighted ? highlighted : item->string);
 
-	printf("%c%2d: %s", selected ? '*' : ' ', i + 1, d->buf.buf);
+	printf("%c%2u: %s", selected ? '*' : ' ', e, d->buf.buf);
 }
 
 static int run_status(struct add_i_state *s, const struct pathspec *ps,
@@ -1067,20 +1071,21 @@ struct print_command_item_data {
 	const char *color, *reset;
 };
 
-static void print_command_item(int i, int selected,
+static void print_command_item(size_t i, int selected,
 			       struct string_list_item *item,
 			       void *print_command_item_data)
 {
+	unsigned int e = (unsigned int)(i + 1);
 	struct print_command_item_data *d = print_command_item_data;
 	struct command_item *util = item->util;
 
 	if (!util->prefix_length ||
 	    !is_valid_prefix(item->string, util->prefix_length))
-		printf(" %2d: %s", i + 1, item->string);
+		printf(" %2u: %s", e, item->string);
 	else
-		printf(" %2d: %s%.*s%s%s", i + 1,
-		       d->color, (int)util->prefix_length, item->string,
-		       d->reset, item->string + util->prefix_length);
+		printf(" %2u: %s%.*s%s%s", e, d->color,
+		       (int)util->prefix_length, item->string, d->reset,
+		       item->string + util->prefix_length);
 }
 
 static void command_prompt_help(struct add_i_state *s)
diff --git a/add-patch.c b/add-patch.c
index a86a92e1646..be049301bb1 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -377,9 +377,10 @@ static int is_octal(const char *p, size_t len)
 	if (!len)
 		return 0;
 
-	while (len--)
+	do {
 		if (*p < '0' || *(p++) > '7')
 			return 0;
+	} while (--len);
 	return 1;
 }
 
diff --git a/advice.c b/advice.c
index fd189689437..74ae3020dab 100644
--- a/advice.c
+++ b/advice.c
@@ -138,7 +138,7 @@ void advise_if_enabled(enum advice_type type, const char *advice, ...)
 int git_default_advice_config(const char *var, const char *value)
 {
 	const char *k, *slot_name;
-	int i;
+	size_t i;
 
 	if (!strcmp(var, "color.advice")) {
 		advice_use_color = git_config_colorbool(var, value);
@@ -169,7 +169,7 @@ int git_default_advice_config(const char *var, const char *value)
 
 void list_config_advices(struct string_list *list, const char *prefix)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(advice_setting); i++)
 		list_config_item(list, prefix, advice_setting[i].key);
diff --git a/apply.c b/apply.c
index 5cc5479c9c3..0881bda6f50 100644
--- a/apply.c
+++ b/apply.c
@@ -443,7 +443,7 @@ static int name_terminate(int c, int terminate)
 /* remove double slashes to make --index work with such filenames */
 static char *squash_slash(char *name)
 {
-	int i = 0, j = 0;
+	size_t i = 0, j = 0;
 
 	if (!name)
 		return NULL;
@@ -654,7 +654,7 @@ static char *find_name_common(struct strbuf *root,
 			      const char *end,
 			      int terminate)
 {
-	int len;
+	size_t len;
 	const char *start = NULL;
 
 	if (p_value == 0)
@@ -685,13 +685,13 @@ static char *find_name_common(struct strbuf *root,
 	 * or "file~").
 	 */
 	if (def) {
-		int deflen = strlen(def);
+		size_t deflen = strlen(def);
 		if (deflen < len && !strncmp(start, def, deflen))
 			return squash_slash(xstrdup(def));
 	}
 
 	if (root->len) {
-		char *ret = xstrfmt("%s%.*s", root->buf, len, start);
+		char *ret = xstrfmt("%s%.*s", root->buf, (int)len, start);
 		return squash_slash(ret);
 	}
 
@@ -790,7 +790,7 @@ static int has_epoch_timestamp(const char *nameline)
 	const char *timestamp = NULL, *cp, *colon;
 	static regex_t *stamp;
 	regmatch_t m[10];
-	int zoneoffset, epoch_hour, hour, minute;
+	long zoneoffset, epoch_hour, hour, minute;
 	int status;
 
 	for (cp = nameline; *cp != '\n'; cp++) {
@@ -1068,7 +1068,7 @@ static int gitdiff_dissimilarity(struct gitdiff_data *state UNUSED,
 				 const char *line,
 				 struct patch *patch)
 {
-	unsigned long val = strtoul(line, NULL, 10);
+	int val = atoi(line);
 	if (val <= 100)
 		patch->score = val;
 	return 0;
@@ -1083,7 +1083,7 @@ static int gitdiff_index(struct gitdiff_data *state,
 	 * and optional space with octal mode.
 	 */
 	const char *ptr, *eol;
-	int len;
+	size_t len;
 	const unsigned hexsz = the_hash_algo->hexsz;
 
 	ptr = strchr(line, '.');
@@ -1125,12 +1125,10 @@ static int gitdiff_unrecognized(struct gitdiff_data *state UNUSED,
  * Skip p_value leading components from "line"; as we do not accept
  * absolute paths, return NULL in that case.
  */
-static const char *skip_tree_prefix(int p_value,
-				    const char *line,
-				    int llen)
+static const char *skip_tree_prefix(int p_value, const char *line, size_t llen)
 {
 	int nslash;
-	int i;
+	size_t i;
 
 	if (!p_value)
 		return (llen && line[0] == '/') ? NULL : line;
@@ -1152,9 +1150,7 @@ static const char *skip_tree_prefix(int p_value,
  * creation or deletion of an empty file.  In any of these cases,
  * both sides are the same name under a/ and b/ respectively.
  */
-static char *git_header_name(int p_value,
-			     const char *line,
-			     int llen)
+static char *git_header_name(int p_value, const char *line, size_t llen)
 {
 	const char *name;
 	const char *second = NULL;
@@ -1302,12 +1298,8 @@ static int check_header_line(int linenr, struct patch *patch)
 	return 0;
 }
 
-int parse_git_diff_header(struct strbuf *root,
-			  int *linenr,
-			  int p_value,
-			  const char *line,
-			  int len,
-			  unsigned int size,
+int parse_git_diff_header(struct strbuf *root, int *linenr, int p_value,
+			  const char *line, size_t len, unsigned int size,
 			  struct patch *patch)
 {
 	unsigned long offset;
@@ -1360,14 +1352,14 @@ int parse_git_diff_header(struct strbuf *root,
 			{ "index ", gitdiff_index },
 			{ "", gitdiff_unrecognized },
 		};
-		int i;
+		size_t i;
 
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			break;
 		for (i = 0; i < ARRAY_SIZE(optable); i++) {
 			const struct opentry *p = optable + i;
-			int oplen = strlen(p->str);
+			size_t oplen = strlen(p->str);
 			int res;
 			if (len < oplen || memcmp(p->str, line, oplen))
 				continue;
@@ -1391,7 +1383,7 @@ done:
 				 "%d leading pathname components (line %d)",
 				 parse_hdr_state.p_value),
 			      parse_hdr_state.p_value, *linenr);
-			return -128;
+			return -1;
 		}
 		patch->old_name = xstrdup(patch->def_name);
 		patch->new_name = xstrdup(patch->def_name);
@@ -1400,7 +1392,7 @@ done:
 	    (!patch->old_name && !patch->is_new)) {
 		error(_("git diff header lacks filename information "
 			"(line %d)"), *linenr);
-		return -128;
+		return -1;
 	}
 	patch->is_toplevel_relative = 1;
 	return offset;
@@ -1454,22 +1446,23 @@ static int parse_range(const char *line, int len, int offset, const char *expect
 	return offset + ex;
 }
 
-static void recount_diff(const char *line, int size, struct fragment *fragment)
+static void recount_diff(const char *line, size_t size,
+			 struct fragment *fragment)
 {
 	int oldlines = 0, newlines = 0, ret = 0;
 
-	if (size < 1) {
+	if (size == 0) {
 		warning("recount: ignore empty hunk");
 		return;
 	}
 
 	for (;;) {
-		int len = linelen(line, size);
-		size -= len;
-		line += len;
+		size_t len = linelen(line, size);
 
-		if (size < 1)
+		if (size <= len)
 			break;
+		size -= len;
+		line += len;
 
 		switch (*line) {
 		case ' ': case '\n':
@@ -2086,7 +2079,7 @@ static void add_name_limit(struct apply_state *state,
 static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
-	int i;
+	size_t i;
 
 	/* Paths outside are not touched regardless of "--include" */
 	if (state->prefix && *state->prefix) {
@@ -2172,9 +2165,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				"Files ",
 				NULL,
 			};
-			int i;
+			size_t i;
 			for (i = 0; binhdr[i]; i++) {
-				int len = strlen(binhdr[i]);
+				size_t len = strlen(binhdr[i]);
 				if (len < size - hd &&
 				    !memcmp(binhdr[i], buffer + hd, len)) {
 					state->linenr++;
@@ -2384,8 +2377,9 @@ static void update_pre_post_images(struct image *preimage,
 	if (postlen
 	    ? postlen < new_buf - postimage->buf
 	    : postimage->len < new_buf - postimage->buf)
-		BUG("caller miscounted postlen: asked %d, orig = %d, used = %d",
-		    (int)postlen, (int) postimage->len, (int)(new_buf - postimage->buf));
+		BUG("caller miscounted postlen: asked %u, orig = %u, used = %u",
+		    (unsigned int)postlen, (unsigned int)postimage->len,
+		    (unsigned int)(new_buf - postimage->buf));
 
 	/* Fix the length of the whole thing */
 	postimage->len = new_buf - postimage->buf;
diff --git a/apply.h b/apply.h
index b9f18ce87d1..7e6b6eb5d2d 100644
--- a/apply.h
+++ b/apply.h
@@ -165,12 +165,8 @@ int check_apply_state(struct apply_state *state, int force_apply);
  *
  * Returns -1 on failure, the length of the parsed header otherwise.
  */
-int parse_git_diff_header(struct strbuf *root,
-			  int *linenr,
-			  int p_value,
-			  const char *line,
-			  int len,
-			  unsigned int size,
+int parse_git_diff_header(struct strbuf *root, int *linenr, int p_value,
+			  const char *line, size_t len, unsigned int size,
 			  struct patch *patch);
 
 void release_patch(struct patch *patch);
diff --git a/archive-tar.c b/archive-tar.c
index f8fad2946ef..6d91eb01157 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -352,12 +352,12 @@ static void write_global_extended_header(struct archiver_args *args)
 }
 
 static struct archiver **tar_filters;
-static int nr_tar_filters;
-static int alloc_tar_filters;
+static size_t nr_tar_filters;
+static size_t alloc_tar_filters;
 
 static struct archiver *find_tar_filter(const char *name, size_t len)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < nr_tar_filters; i++) {
 		struct archiver *ar = tar_filters[i];
 		if (!strncmp(ar->name, name, len) && !ar->name[len])
@@ -525,7 +525,7 @@ static struct archiver tar_archiver = {
 
 void init_tar_archiver(void)
 {
-	int i;
+	size_t i;
 	register_archiver(&tar_archiver);
 
 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
diff --git a/archive.c b/archive.c
index 9aeaf2bd87d..2db9b0b56eb 100644
--- a/archive.c
+++ b/archive.c
@@ -275,7 +275,7 @@ int write_archive_entries(struct archiver_args *args,
 	struct strbuf path_in_archive = STRBUF_INIT;
 	struct strbuf content = STRBUF_INIT;
 	struct object_id fake_oid;
-	int i;
+	size_t i;
 
 	oidcpy(&fake_oid, null_oid());
 
diff --git a/attr.c b/attr.c
index 1053dfcd4b6..acdd74775f6 100644
--- a/attr.c
+++ b/attr.c
@@ -180,16 +180,16 @@ static int attr_name_valid(const char *name, size_t namelen)
 	 * Attribute name cannot begin with '-' and must consist of
 	 * characters from [-A-Za-z0-9_.].
 	 */
-	if (namelen <= 0 || *name == '-')
+	if (namelen == 0 || *name == '-')
 		return 0;
-	while (namelen--) {
+	do {
 		char ch = *name++;
 		if (! (ch == '-' || ch == '.' || ch == '_' ||
 		       ('0' <= ch && ch <= '9') ||
 		       ('a' <= ch && ch <= 'z') ||
 		       ('A' <= ch && ch <= 'Z')) )
 			return 0;
-	}
+	} while (--namelen);
 	return 1;
 }
 
@@ -515,7 +515,7 @@ static void check_vector_add(struct attr_check *c)
 
 static void check_vector_remove(struct attr_check *check)
 {
-	int i;
+	size_t i;
 
 	vector_lock();
 
@@ -539,7 +539,7 @@ static void check_vector_remove(struct attr_check *check)
 /* Iterate through all attr_check instances and drop their stacks */
 static void drop_all_attr_stacks(void)
 {
-	int i;
+	size_t i;
 
 	vector_lock();
 
diff --git a/base85.c b/base85.c
index 5ca601ee14f..ad32ba1411a 100644
--- a/base85.c
+++ b/base85.c
@@ -37,14 +37,15 @@ static void prep_base85(void)
 	}
 }
 
-int decode_85(char *dst, const char *buffer, int len)
+int decode_85(char *dst, const char *buffer, size_t len)
 {
 	prep_base85();
 
-	say2("decode 85 <%.*s>", len / 4 * 5, buffer);
+	say2("decode 85 <%.*s>", (int)(len / 4 * 5), buffer);
 	while (len) {
 		unsigned acc = 0;
-		int de, cnt = 4;
+		int de;
+		size_t cnt = 4;
 		unsigned char ch;
 		do {
 			ch = *buffer++;
@@ -76,7 +77,7 @@ int decode_85(char *dst, const char *buffer, int len)
 	return 0;
 }
 
-void encode_85(char *buf, const unsigned char *data, int bytes)
+void encode_85(char *buf, const unsigned char *data, size_t bytes)
 {
 	say("encode 85");
 	while (bytes) {
@@ -90,7 +91,7 @@ void encode_85(char *buf, const unsigned char *data, int bytes)
 		}
 		say1(" %08x", acc);
 		for (cnt = 4; cnt >= 0; cnt--) {
-			int val = acc % 85;
+			unsigned val = acc % 85;
 			acc /= 85;
 			buf[cnt] = en85[val];
 		}
diff --git a/bisect.c b/bisect.c
index ef5ee5a6436..618739689fc 100644
--- a/bisect.c
+++ b/bisect.c
@@ -218,7 +218,7 @@ static struct commit_list *best_bisection_sorted(struct commit_list *list, int n
 	struct commit_list *p;
 	struct commit_dist *array = xcalloc(nr, sizeof(*array));
 	struct strbuf buf = STRBUF_INIT;
-	int cnt, i;
+	size_t cnt, i;
 
 	for (p = list, cnt = 0; p; p = p->next) {
 		int distance;
@@ -493,7 +493,7 @@ static void read_bisect_paths(struct strvec *array)
 static char *join_oid_array_hex(struct oid_array *array, char delim)
 {
 	struct strbuf joined_hexs = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	for (i = 0; i < array->nr; i++) {
 		strbuf_addstr(&joined_hexs, oid_to_hex(array->oid + i));
@@ -653,7 +653,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 	struct setup_revision_opt opt = {
 		.free_removed_argv_elements = 1,
 	};
-	int i;
+	size_t i;
 
 	repo_init_revisions(r, revs, prefix);
 	revs->abbrev = 0;
@@ -771,7 +771,7 @@ static struct commit **get_bad_and_good_commits(struct repository *r,
 						int *rev_nr)
 {
 	struct commit **rev;
-	int i, n = 0;
+	size_t i, n = 0;
 
 	ALLOC_ARRAY(rev, 1 + good_revs.nr);
 	rev[n++] = get_commit_reference(r, current_bad_oid);
diff --git a/blame.c b/blame.c
index 8bfeaa1c63a..b050ba7f893 100644
--- a/blame.c
+++ b/blame.c
@@ -493,7 +493,7 @@ static void get_line_fingerprints(struct fingerprint *fingerprints,
 				  const char *content, const int *line_starts,
 				  long first_line, long line_count)
 {
-	int i;
+	long i;
 	const char *linestart, *lineend;
 
 	line_starts += first_line;
@@ -1496,7 +1496,7 @@ static void split_overlap(struct blame_entry *split,
 			  struct blame_origin *parent)
 {
 	int chunk_end_lno;
-	int i;
+	unsigned int i;
 	memset(split, 0, sizeof(struct blame_entry [3]));
 
 	for (i = 0; i < 3; i++) {
@@ -1583,7 +1583,7 @@ static void split_blame(struct blame_entry ***blamed,
  */
 static void decref_split(struct blame_entry *split)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < 3; i++)
 		blame_origin_decref(split[i].suspect);
@@ -2001,7 +2001,7 @@ static void copy_split_if_better(struct blame_scoreboard *sb,
 				 struct blame_entry *best_so_far,
 				 struct blame_entry *potential)
 {
-	int i;
+	unsigned int i;
 
 	if (!potential[1].suspect)
 		return;
@@ -2193,10 +2193,10 @@ struct blame_list {
  * and prepare a list of entry and the best split.
  */
 static struct blame_list *setup_blame_list(struct blame_entry *unblamed,
-					   int *num_ents_p)
+					   size_t *num_ents_p)
 {
 	struct blame_entry *e;
-	int num_ents, i;
+	size_t num_ents, i;
 	struct blame_list *blame_list = NULL;
 
 	for (e = unblamed, num_ents = 0; e; e = e->next)
@@ -2224,9 +2224,9 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 				int opt)
 {
 	struct diff_options diff_opts;
-	int i, j;
+	size_t i, j;
 	struct blame_list *blame_list;
-	int num_ents;
+	size_t num_ents;
 	struct blame_entry *unblamed = target->suspects;
 	struct blame_entry *leftover = NULL;
 
@@ -2645,7 +2645,7 @@ static int prepare_lines(struct blame_scoreboard *sb)
 static struct commit *find_single_final(struct rev_info *revs,
 					const char **name_p)
 {
-	int i;
+	unsigned int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
@@ -2708,7 +2708,7 @@ static struct commit *dwim_reverse_initial(struct rev_info *revs,
 static struct commit *find_single_initial(struct rev_info *revs,
 					  const char **name_p)
 {
-	int i;
+	unsigned int i;
 	struct commit *found = NULL;
 	const char *name = NULL;
 
diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
index 80cebd27564..a08be63bc63 100644
--- a/block-sha1/sha1.c
+++ b/block-sha1/sha1.c
@@ -214,7 +214,7 @@ void blk_SHA1_Final(unsigned char hashout[20], blk_SHA_CTX *ctx)
 {
 	static const unsigned char pad[64] = { 0x80 };
 	unsigned int padlen[2];
-	int i;
+	size_t i;
 
 	/* Pad with a binary 1 (ie 0x80), then zeroes, then length */
 	padlen[0] = htonl((uint32_t)(ctx->size >> 29));
diff --git a/bloom.c b/bloom.c
index d0730525da5..d38064e257f 100644
--- a/bloom.c
+++ b/bloom.c
@@ -73,11 +73,11 @@ uint32_t murmur3_seeded(uint32_t seed, const char *data, size_t len)
 	const uint32_t r2 = 13;
 	const uint32_t m = 5;
 	const uint32_t n = 0xe6546b64;
-	int i;
+	size_t i;
 	uint32_t k1 = 0;
 	const char *tail;
 
-	int len4 = len / sizeof(uint32_t);
+	size_t len4 = len / sizeof(uint32_t);
 
 	uint32_t k;
 	for (i = 0; i < len4; i++) {
@@ -127,7 +127,7 @@ void fill_bloom_key(const char *data,
 		    struct bloom_key *key,
 		    const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	const uint32_t seed0 = 0x293ae76f;
 	const uint32_t seed1 = 0x7e646e2c;
 	const uint32_t hash0 = murmur3_seeded(seed0, data, len);
@@ -147,7 +147,7 @@ void add_key_to_filter(const struct bloom_key *key,
 		       struct bloom_filter *filter,
 		       const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
 	for (i = 0; i < settings->num_hashes; i++) {
@@ -310,7 +310,7 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings)
 {
-	int i;
+	uint32_t i;
 	uint64_t mod = filter->len * BITS_PER_WORD;
 
 	if (!mod)
diff --git a/branch.c b/branch.c
index e5614b53b36..f8193de41be 100644
--- a/branch.c
+++ b/branch.c
@@ -375,7 +375,7 @@ static struct strmap current_checked_out_branches = STRMAP_INIT;
 
 static void prepare_checked_out_branches(void)
 {
-	int i = 0;
+	size_t i = 0;
 	struct worktree **worktrees;
 
 	if (initialized_checked_out_branches)
@@ -836,7 +836,7 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 {
 	int ret = 0;
 	struct worktree **worktrees = get_worktrees();
-	int i;
+	size_t i;
 
 	for (i = 0; worktrees[i]; i++) {
 		struct ref_store *refs;
diff --git a/builtin/add.c b/builtin/add.c
index 61dd386d109..124ecf1001c 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -40,7 +40,8 @@ struct update_callback_data {
 
 static int chmod_pathspec(struct pathspec *pathspec, char flip, int show_only)
 {
-	int i, ret = 0;
+	unsigned int i;
+	int ret = 0;
 
 	for (i = 0; i < the_index.cache_nr; i++) {
 		struct cache_entry *ce = the_index.cache[i];
diff --git a/builtin/clone.c b/builtin/clone.c
index 65b5b7db6de..b55962692a5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1298,7 +1298,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	if (mapped_refs) {
-		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
+		unsigned hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
 		/*
 		 * Now that we know what algorithm the remote side is using,
diff --git a/builtin/commit.c b/builtin/commit.c
index 985a0445b78..bcf55081d1e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -292,7 +292,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 
 static void add_remove_files(struct string_list *list)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < list->nr; i++) {
 		struct stat st;
 		struct string_list_item *p = &(list->items[i]);
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 39a890fc005..43da493eb4b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -906,7 +906,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
 
 static void get_tags_and_duplicates(struct rev_cmdline_info *info)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < info->nr; i++) {
 		struct rev_cmdline_entry *e = info->rev + i;
@@ -1230,7 +1230,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die(_("the option '%s' requires '%s'"), "--anonymize-map", "--anonymize");
 
 	if (refspecs_list.nr) {
-		int i;
+		size_t i;
 
 		for (i = 0; i < refspecs_list.nr; i++)
 			refspec_append(&refspecs, refspecs_list.items[i].string);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 7134683ab93..068c218ca61 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -860,7 +860,7 @@ static void end_packfile(void)
 		struct packed_git *new_p;
 		struct object_id cur_pack_oid;
 		char *idx_name;
-		int i;
+		unsigned long i;
 		struct branch *b;
 		struct tag *t;
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index afe679368de..9758d067b73 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -239,7 +239,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	ref = fetch_pack(&args, fd, ref, sought, nr_sought,
 			 &shallow, pack_lockfiles_ptr, version);
 	if (pack_lockfiles.nr) {
-		int i;
+		size_t i;
 
 		printf("lock %s\n", pack_lockfiles.items[0].string);
 		fflush(stdout);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a09606b4726..12d7a067d36 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1480,11 +1480,11 @@ static int add_oid(const char *refname UNUSED,
 static void add_negotiation_tips(struct git_transport_options *smart_options)
 {
 	struct oid_array *oids = xcalloc(1, sizeof(*oids));
-	int i;
+	size_t i;
 
 	for (i = 0; i < negotiation_tip.nr; i++) {
 		const char *s = negotiation_tip.items[i].string;
-		int old_nr;
+		size_t old_nr;
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
 			if (get_oid(s, &oid))
@@ -1939,7 +1939,8 @@ static int fetch_finished(int result, struct strbuf *out,
 
 static int fetch_multiple(struct string_list *list, int max_children)
 {
-	int i, result = 0;
+	size_t i;
+	int result = 0;
 	struct strvec argv = STRVEC_INIT;
 
 	if (!append && write_fetch_head) {
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 6aeac371488..ababcbef101 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -30,7 +30,8 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
-	int i, result = 0;
+	int result = 0;
+	size_t i;
 	const struct string_list *values;
 
 	const struct option options[] = {
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d207bd909b4..3b411735a58 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -359,7 +359,7 @@ static void check_object(struct object *obj)
 
 static void check_connectivity(void)
 {
-	int i, max;
+	unsigned int i, max;
 
 	/* Traverse the pending reachable objects */
 	traverse_reachable();
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..511419ba417 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -68,7 +68,7 @@ static struct string_list pack_garbage = STRING_LIST_INIT_DUP;
 
 static void clean_pack_garbage(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < pack_garbage.nr; i++)
 		unlink_or_warn(pack_garbage.items[i].string);
 	string_list_clear(&pack_garbage, 0);
@@ -1288,7 +1288,8 @@ static int compare_tasks_by_selection(const void *a_, const void *b_)
 
 static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
-	int i, found_selected = 0;
+	unsigned int i;
+	int found_selected = 0;
 	int result = 0;
 	struct lock_file lk;
 	struct repository *r = the_repository;
@@ -1367,7 +1368,7 @@ static void initialize_maintenance_strategy(void)
 
 static void initialize_task_config(int schedule)
 {
-	int i;
+	unsigned int i;
 	struct strbuf config_name = STRBUF_INIT;
 	gc_config();
 
@@ -1401,7 +1402,8 @@ static void initialize_task_config(int schedule)
 static int task_option_parse(const struct option *opt,
 			     const char *arg, int unset)
 {
-	int i, num_selected = 0;
+	unsigned int i;
+	int num_selected = 0;
 	struct maintenance_task *task = NULL;
 
 	BUG_ON_OPT_NEG(unset);
@@ -1431,7 +1433,7 @@ static int task_option_parse(const struct option *opt,
 
 static int maintenance_run(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	unsigned int i;
 	struct maintenance_run_opts opts;
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
@@ -1810,8 +1812,9 @@ static int launchctl_list_contains_plist(const char *name, const char *cmd)
 
 static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
 {
-	int i, fd;
-	const char *preamble, *repeat;
+	unsigned int i;
+	int fd;
+	const char *preamble;
 	const char *frequency = get_frequency(schedule);
 	char *name = launchctl_service_name(frequency);
 	char *filename = launchctl_service_filename(name);
@@ -1843,22 +1846,24 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 
 	switch (schedule) {
 	case SCHEDULE_HOURLY:
-		repeat = "<dict>\n"
-			 "<key>Hour</key><integer>%d</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
-			 "</dict>\n";
 		for (i = 1; i <= 23; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist,
+				    "<dict>\n"
+				    "<key>Hour</key><integer>%u</integer>\n"
+				    "<key>Minute</key><integer>0</integer>\n"
+				    "</dict>\n",
+				    i);
 		break;
 
 	case SCHEDULE_DAILY:
-		repeat = "<dict>\n"
-			 "<key>Day</key><integer>%d</integer>\n"
-			 "<key>Hour</key><integer>0</integer>\n"
-			 "<key>Minute</key><integer>0</integer>\n"
-			 "</dict>\n";
 		for (i = 1; i <= 6; i++)
-			strbuf_addf(&plist, repeat, i);
+			strbuf_addf(&plist,
+				    "<dict>\n"
+				    "<key>Day</key><integer>%u</integer>\n"
+				    "<key>Hour</key><integer>0</integer>\n"
+				    "<key>Minute</key><integer>0</integer>\n"
+				    "</dict>\n",
+				    i);
 		break;
 
 	case SCHEDULE_WEEKLY:
@@ -2553,7 +2558,7 @@ static void validate_scheduler(enum scheduler scheduler)
 static int update_background_schedule(const struct maintenance_start_opts *opts,
 				      int enable)
 {
-	unsigned int i;
+	size_t i;
 	int result = 0;
 	struct lock_file lk;
 	char *lock_path = xstrfmt("%s/schedule", the_repository->objects->odb->path);
diff --git a/builtin/grep.c b/builtin/grep.c
index f7821c5fbba..75cc21f632e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -174,7 +174,7 @@ static void work_done(struct work_item *w)
 
 static void free_repos(void)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < repos_to_free_nr; i++) {
 		repo_clear(repos_to_free[i]);
@@ -409,7 +409,8 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 {
 	struct string_list *path_list = opt->output_priv;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int i, status;
+	size_t i;
+	int status;
 
 	for (i = 0; i < path_list->nr; i++)
 		strvec_push(&child.args, path_list->items[i].string);
diff --git a/builtin/help.c b/builtin/help.c
index 53f2812dfb1..fd227be20f1 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -124,7 +124,7 @@ static void list_config_help(enum show_config_type type)
 	struct string_list keys = STRING_LIST_INIT_DUP;
 	struct string_list keys_uniq = STRING_LIST_INIT_DUP;
 	struct string_list_item *item;
-	int i;
+	size_t i;
 
 	for (p = config_name_list; *p; p++) {
 		const char *var = *p;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6648f2daef5..eb383e2fe75 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1726,7 +1726,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	unsigned char pack_hash[GIT_MAX_RAWSZ];
 	unsigned foreign_nr = 1;	/* zero is a "good" value, assume bad */
 	int report_end_of_input = 0;
-	int hash_algo = 0;
+	unsigned hash_algo = 0;
 
 	/*
 	 * index-pack never needs to fetch missing objects except when
diff --git a/builtin/init-db.c b/builtin/init-db.c
index dcaaf102eaf..6431c8855f4 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -167,17 +167,17 @@ static int needs_work_tree_config(const char *git_dir, const char *work_tree)
 	return 1;
 }
 
-void initialize_repository_version(int hash_algo, int reinit)
+void initialize_repository_version(unsigned hash_algo, int reinit)
 {
 	char repo_version_string[10];
-	int repo_version = GIT_REPO_VERSION;
+	unsigned repo_version = GIT_REPO_VERSION;
 
 	if (hash_algo != GIT_HASH_SHA1)
 		repo_version = GIT_REPO_VERSION_READ;
 
 	/* This forces creation of new config file */
 	xsnprintf(repo_version_string, sizeof(repo_version_string),
-		  "%d", repo_version);
+		  "%u", repo_version);
 	git_config_set("core.repositoryformatversion", repo_version_string);
 
 	if (hash_algo != GIT_HASH_SHA1)
@@ -374,7 +374,7 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
 	else if (hash != GIT_HASH_UNKNOWN)
 		repo_fmt->hash_algo = hash;
 	else if (env) {
-		int env_algo = hash_algo_by_name(env);
+		unsigned env_algo = hash_algo_by_name(env);
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
 		repo_fmt->hash_algo = env_algo;
@@ -537,7 +537,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	unsigned int flags = 0;
 	const char *object_format = NULL;
 	const char *initial_branch = NULL;
-	int hash_algo = GIT_HASH_UNKNOWN;
+	unsigned hash_algo = GIT_HASH_UNKNOWN;
 	const struct option init_db_options[] = {
 		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
 				N_("directory from which templates will be used")),
diff --git a/builtin/log.c b/builtin/log.c
index a70fba198f9..db640058328 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -179,7 +179,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
-	int i;
+	size_t i;
 	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude =
@@ -386,7 +386,7 @@ static struct itimerval early_output_timer;
 
 static void log_show_early(struct rev_info *revs, struct commit_list *list)
 {
-	int i = revs->early_output;
+	unsigned int i = revs->early_output;
 	int show_header = 1;
 	int no_free = revs->diffopt.no_free;
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a03b559ecaa..c369e95c30e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -348,7 +348,8 @@ static void show_ru_info(struct index_state *istate)
 	for_each_string_list_item(item, istate->resolve_undo) {
 		const char *path = item->string;
 		struct resolve_undo_info *ui = item->util;
-		int i, len;
+		unsigned int i;
+		int len;
 
 		len = strlen(path);
 		if (len < max_prefix_len)
@@ -359,9 +360,8 @@ static void show_ru_info(struct index_state *istate)
 		for (i = 0; i < 3; i++) {
 			if (!ui->mode[i])
 				continue;
-			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       find_unique_abbrev(&ui->oid[i], abbrev),
-			       i + 1);
+			printf("%s%06o %s %u\t", tag_resolve_undo, ui->mode[i],
+			       find_unique_abbrev(&ui->oid[i], abbrev), i + 1);
 			write_name(path);
 		}
 	}
@@ -385,7 +385,7 @@ static void construct_fullname(struct strbuf *out, const struct repository *repo
 
 static void show_files(struct repository *repo, struct dir_struct *dir)
 {
-	int i;
+	unsigned int i;
 	struct strbuf fullname = STRBUF_INIT;
 
 	/* For cached/deleted files we don't need to even do the readdir */
@@ -449,12 +449,12 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
 
 skip_to_next_name:
 		{
-			int j;
-			struct cache_entry **cache = repo->index->cache;
-			for (j = i + 1; j < repo->index->cache_nr; j++)
-				if (strcmp(ce->name, cache[j]->name))
-					break;
-			i = j - 1; /* compensate for the for loop */
+		unsigned int j;
+		struct cache_entry **cache = repo->index->cache;
+		for (j = i + 1; j < repo->index->cache_nr; j++)
+			if (strcmp(ce->name, cache[j]->name))
+				break;
+		i = j - 1; /* compensate for the for loop */
 		}
 	}
 
@@ -571,7 +571,7 @@ void overlay_tree_on_index(struct index_state *istate,
 	struct object_id oid;
 	struct pathspec pathspec;
 	struct cache_entry *last_stage0 = NULL;
-	int i;
+	unsigned int i;
 	read_tree_fn_t fn = NULL;
 	int err;
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 65161773489..0e72f28b53a 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -87,7 +87,6 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	packet_trace_identity("ls-remote");
 
 	if (argc > 1) {
-		int i;
 		CALLOC_ARRAY(pattern, argc);
 		for (i = 1; i < argc; i++) {
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 73509f651bd..053c9eecb30 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -172,7 +172,7 @@ static int split_maildir(const char *maildir, const char *dir,
 	char *file = NULL;
 	FILE *f = NULL;
 	int ret = -1;
-	int i;
+	size_t i;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
 	list.cmp = maildir_filename_cmp;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c923bbf2abb..e4655e8541c 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -29,7 +29,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	mmfile_t mmfs[3] = { 0 };
 	mmbuffer_t result = { 0 };
 	xmparam_t xmp = { 0 };
-	int ret = 0, i = 0, to_stdout = 0;
+	int ret = 0, to_stdout = 0;
+	size_t i = 0;
 	int quiet = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
diff --git a/builtin/merge.c b/builtin/merge.c
index 0a3c10a0966..7b42e7440f8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -186,7 +186,8 @@ static struct strategy *get_strategy(const char *name)
 		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		load_command_list("git-merge-", &main_cmds, &other_cmds);
 		for (i = 0; i < main_cmds.cnt; i++) {
-			int j, found = 0;
+			size_t j;
+			int found = 0;
 			struct cmdname *ent = main_cmds.names[i];
 			for (j = 0; !found && j < ARRAY_SIZE(all_strategy); j++)
 				if (!strncmp(ent->name, all_strategy[j].name, ent->len)
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 97959bfaf9e..c5a9fe74448 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -653,7 +653,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&sb);
 	} else if (all) {
-		int i, max;
+		unsigned int i, max;
 
 		max = get_max_object_index();
 		for (i = 0; i < max; i++) {
@@ -664,7 +664,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 				  always, allow_undefined, data.name_only);
 		}
 	} else {
-		int i;
+		unsigned int i;
 		for (i = 0; i < revs.nr; i++)
 			show_name(revs.objects[i].item, revs.objects[i].name,
 				  always, allow_undefined, data.name_only);
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74a167a180c..a939b89cd30 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1511,7 +1511,7 @@ static int want_object_in_pack(const struct object_id *oid,
 	if (uri_protocols.nr) {
 		struct configured_exclusion *ex =
 			oidmap_get(&configured_exclusions, oid);
-		int i;
+		size_t i;
 		const char *p;
 
 		if (ex) {
@@ -4084,7 +4084,7 @@ static void add_extra_kept_packs(const struct string_list *names)
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		const char *name = basename(p->pack_name);
-		int i;
+		size_t i;
 
 		if (!p->pack_local)
 			continue;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index ecd49ca268f..0f6c827faca 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -51,9 +51,9 @@ static inline struct llist_item *llist_item_get(void)
 		new_item = free_nodes;
 		free_nodes = free_nodes->next;
 	} else {
-		int i = 1;
+		size_t i;
 		ALLOC_ARRAY(new_item, BLKSIZE);
-		for (; i < BLKSIZE; i++)
+		for (i = 1; i < BLKSIZE; i++)
 			llist_item_put(&new_item[i]);
 	}
 	return new_item;
@@ -366,7 +366,7 @@ static int cmp_remaining_objects(const void *a, const void *b)
 static void sort_pack_list(struct pack_list **pl)
 {
 	struct pack_list **ary, *p;
-	int i;
+	size_t i;
 	size_t n = pack_list_size(*pl);
 
 	if (n < 2)
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index f840fbf1c7e..8fed7935e9a 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -10,7 +10,7 @@ static void flush_current_id(int patchlen, struct object_id *id, struct object_i
 		printf("%s %s\n", oid_to_hex(result), oid_to_hex(id));
 }
 
-static int remove_space(char *line)
+static size_t remove_space(char *line)
 {
 	char *src = line;
 	char *dst = line;
@@ -57,10 +57,12 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 	return 1;
 }
 
-static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
-			   struct strbuf *line_buf, int stable, int verbatim)
+static size_t get_one_patchid(struct object_id *next_oid,
+			      struct object_id *result, struct strbuf *line_buf,
+			      int stable, int verbatim)
 {
-	int patchlen = 0, found_next = 0;
+	size_t patchlen = 0;
+	int found_next = 0;
 	int before = -1, after = -1;
 	int diff_is_binary = 0;
 	char pre_oid_str[GIT_MAX_HEXSZ + 1], post_oid_str[GIT_MAX_HEXSZ + 1];
@@ -72,7 +74,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 	while (strbuf_getwholeline(line_buf, stdin, '\n') != EOF) {
 		char *line = line_buf->buf;
 		const char *p = line;
-		int len;
+		size_t len;
 
 		/* Possibly skip over the prefix added by "log" or "format-patch" */
 		if (!skip_prefix(line, "commit ", &p) &&
@@ -173,7 +175,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 static void generate_id_list(int stable, int verbatim)
 {
 	struct object_id oid, n, result;
-	int patchlen;
+	size_t patchlen;
 	struct strbuf line_buf = STRBUF_INIT;
 
 	oidclr(&oid);
diff --git a/builtin/pull.c b/builtin/pull.c
index 1ab4de0005d..115b4bd8819 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -941,7 +941,7 @@ static int get_can_ff(struct object_id *orig_head,
 static int already_up_to_date(struct object_id *orig_head,
 			      struct oid_array *merge_heads)
 {
-	int i;
+	size_t i;
 	struct commit *ours;
 
 	ours = lookup_commit_reference(the_repository, orig_head);
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 3ce75417833..444939c70dc 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -85,13 +85,13 @@ static void debug_stage(const char *label, const struct cache_entry *ce,
 static int debug_merge(const struct cache_entry * const *stages,
 		       struct unpack_trees_options *o)
 {
-	int i;
+	unsigned int i;
 
-	printf("* %d-way merge\n", o->merge_size);
+	printf("* %u-way merge\n", o->merge_size);
 	debug_stage("index", stages[0], o);
 	for (i = 1; i <= o->merge_size; i++) {
 		char buf[24];
-		xsnprintf(buf, sizeof(buf), "ent#%d", i);
+		xsnprintf(buf, sizeof(buf), "ent#%u", i);
 		debug_stage(buf, stages[i], o);
 	}
 	return 0;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d529..e12edfa84af 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1465,15 +1465,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (strategy_options.nr) {
-		int i;
+		size_t j;
 
 		if (!options.strategy)
 			options.strategy = "ort";
 
 		strbuf_reset(&buf);
-		for (i = 0; i < strategy_options.nr; i++)
+		for (j = 0; j < strategy_options.nr; j++)
 			strbuf_addf(&buf, " --%s",
-				    strategy_options.items[i].string);
+				    strategy_options.items[j].string);
 		options.strategy_opts = xstrdup(buf.buf);
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cd5c7a28eff..5ff421061c7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -536,7 +536,7 @@ static void hmac_hash(unsigned char *out,
 	unsigned char key[GIT_MAX_BLKSZ];
 	unsigned char k_ipad[GIT_MAX_BLKSZ];
 	unsigned char k_opad[GIT_MAX_BLKSZ];
-	int i;
+	size_t i;
 	git_hash_ctx ctx;
 
 	/* RFC 2104 2. (1) */
@@ -1302,7 +1302,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	struct oid_array extra = OID_ARRAY_INIT;
 	struct check_connected_options opt = CHECK_CONNECTED_INIT;
 	uint32_t mask = 1 << (cmd->index % 32);
-	int i;
+	size_t i;
 
 	trace_printf_key(&trace_shallow,
 			 "shallow: update_shallow_ref %s\n", cmd->ref_name);
@@ -2313,7 +2313,9 @@ static const char *unpack_with_sideband(struct shallow_info *si)
 
 static void prepare_shallow_update(struct shallow_info *si)
 {
-	int i, j, k, bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
+	size_t i, j, k;
+	size_t bitmap_size = DIV_ROUND_UP(si->ref->nr, 32);
+	int l;
 
 	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
 	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
@@ -2322,8 +2324,8 @@ static void prepare_shallow_update(struct shallow_info *si)
 	CALLOC_ARRAY(si->reachable, si->shallow->nr);
 	CALLOC_ARRAY(si->shallow_ref, si->ref->nr);
 
-	for (i = 0; i < si->nr_ours; i++)
-		si->need_reachability_test[si->ours[i]] = 1;
+	for (l = 0; l < si->nr_ours; l++)
+		si->need_reachability_test[si->ours[l]] = 1;
 
 	for (i = 0; i < si->shallow->nr; i++) {
 		if (!si->used_shallow[i])
diff --git a/builtin/remote.c b/builtin/remote.c
index 729f6f3643a..93f8c9a2fad 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -161,7 +161,7 @@ static int add(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	const char *name, *url;
-	int i;
+	size_t i;
 
 	struct option options[] = {
 		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
@@ -862,7 +862,8 @@ static int rm(int argc, const char **argv, const char *prefix)
 	struct string_list branches = STRING_LIST_INIT_DUP;
 	struct string_list skipped = STRING_LIST_INIT_DUP;
 	struct branches_for_remote cb_data;
-	int i, result;
+	size_t i;
+	int result;
 
 	memset(&cb_data, 0, sizeof(cb_data));
 	cb_data.branches = &branches;
@@ -1093,7 +1094,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
 	int width = show_info->width + 4;
-	int i;
+	size_t i;
 
 	if (branch_info->rebase >= REBASE_TRUE && branch_info->merge.nr > 1) {
 		error(_("invalid branch.%s.merge; cannot rebase onto > 1 branch"),
@@ -1245,7 +1246,7 @@ static int show_all(void)
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
-		int i;
+		size_t i;
 
 		string_list_sort(&list);
 		for (i = 0; i < list.nr; i++) {
@@ -1370,7 +1371,7 @@ static int show(int argc, const char **argv, const char *prefix)
 
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
+	int opt_a = 0, opt_d = 0, result = 0;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
 	char *head_name = NULL;
 
@@ -1394,6 +1395,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
 		if (!states.heads.nr)
 			result |= error(_("Cannot determine remote HEAD"));
 		else if (states.heads.nr > 1) {
+			size_t i;
 			result |= error(_("Multiple remote HEAD branches. "
 					  "Please choose one explicitly with:"));
 			for (i = 0; i < states.heads.nr; i++)
diff --git a/builtin/repack.c b/builtin/repack.c
index f6493795318..7d2031506de 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -109,7 +109,7 @@ static void collect_pack_filenames(struct string_list *fname_nonkept_list,
 
 	while ((e = readdir(dir)) != NULL) {
 		size_t len;
-		int i;
+		size_t i;
 
 		if (!strip_suffix(e->d_name, ".pack", &len))
 			continue;
@@ -218,7 +218,7 @@ static struct generated_pack_data *populate_pack_exts(const char *name)
 	struct stat statbuf;
 	struct strbuf path = STRBUF_INIT;
 	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_reset(&path);
@@ -744,7 +744,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct pack_geometry *geometry = NULL;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *refs_snapshot = NULL;
-	int i, ext, ret;
+	size_t i;
+	int ext, ret;
 	FILE *out;
 	int show_progress;
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 94ffb8c21ab..7a0aeed3323 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -51,7 +51,8 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int i, autoupdate = -1, flags = 0;
+	size_t i;
+	int autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
diff --git a/builtin/reset.c b/builtin/reset.c
index 0697fa89de2..580fbfea217 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -50,7 +50,7 @@ static inline int is_merge(void)
 
 static int reset_index(const char *ref, const struct object_id *oid, int reset_type, int quiet)
 {
-	int i, nr = 0;
+	unsigned int i, nr = 0;
 	struct tree_desc desc[2];
 	struct tree *tree;
 	struct unpack_trees_options opts;
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e67999e5ebc..c235e67a099 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -707,7 +707,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 
 		if (!seen_end_of_options) {
 			if (!strcmp(arg, "--local-env-vars")) {
-				int i;
+				size_t i;
 				for (i = 0; local_repo_env[i]; i++)
 					printf("%s\n", local_repo_env[i]);
 				continue;
diff --git a/builtin/rm.c b/builtin/rm.c
index 8844f906557..d70610a3faf 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -49,7 +49,7 @@ static void print_error_files(struct string_list *files_list,
 			      int *errs)
 {
 	if (files_list->nr) {
-		int i;
+		size_t i;
 		struct strbuf err_msg = STRBUF_INIT;
 
 		strbuf_addstr(&err_msg, main_msg);
@@ -258,7 +258,9 @@ static struct option builtin_rm_options[] = {
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	struct lock_file lock_file = LOCK_INIT;
-	int i, ret = 0;
+	int i;
+	unsigned int j;
+	int ret = 0;
 	struct pathspec pathspec;
 	char *seen;
 
@@ -302,8 +304,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (pathspec_needs_expanded_index(&the_index, &pathspec))
 		ensure_full_index(&the_index);
 
-	for (i = 0; i < the_index.cache_nr; i++) {
-		const struct cache_entry *ce = the_index.cache[i];
+	for (j = 0; j < the_index.cache_nr; j++) {
+		const struct cache_entry *ce = the_index.cache[j];
 
 		if (!include_sparse &&
 		    (ce_skip_worktree(ce) ||
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 358ac3e519a..470927ed4d3 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -109,9 +109,9 @@ static void name_parent(struct commit *commit, struct commit *parent)
 			    commit_name->generation + 1);
 }
 
-static int name_first_parent_chain(struct commit *c)
+static size_t name_first_parent_chain(struct commit *c)
 {
-	int i = 0;
+	size_t i = 0;
 	while (c) {
 		struct commit *p;
 		if (!commit_to_name(c))
@@ -130,14 +130,12 @@ static int name_first_parent_chain(struct commit *c)
 	return i;
 }
 
-static void name_commits(struct commit_list *list,
-			 struct commit **rev,
-			 char **ref_name,
-			 int num_rev)
+static void name_commits(struct commit_list *list, struct commit **rev,
+			 char **ref_name, size_t num_rev)
 {
 	struct commit_list *cl;
 	struct commit *c;
-	int i;
+	size_t i;
 
 	/* First give names to the given heads */
 	for (cl = list; cl; cl = cl->next) {
@@ -213,18 +211,17 @@ static int mark_seen(struct commit *commit, struct commit_list **seen_p)
 	return 0;
 }
 
-static void join_revs(struct commit_list **list_p,
-		      struct commit_list **seen_p,
-		      int num_rev, int extra)
+static void join_revs(struct commit_list **list_p, struct commit_list **seen_p,
+		      size_t num_rev, int extra)
 {
-	int all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
-	int all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
+	size_t all_mask = ((1u << (REV_SHIFT + num_rev)) - 1);
+	size_t all_revs = all_mask & ~((1u << REV_SHIFT) - 1);
 
 	while (*list_p) {
 		struct commit_list *parents;
 		int still_interesting = !!interesting(*list_p);
 		struct commit *commit = pop_commit(list_p);
-		int flags = commit->object.flags & all_mask;
+		unsigned int flags = commit->object.flags & all_mask;
 
 		if (!still_interesting && extra <= 0)
 			break;
@@ -513,11 +510,10 @@ static int show_merge_base(struct commit_list *seen, int num_rev)
 	return exit_status;
 }
 
-static int show_independent(struct commit **rev,
-			    int num_rev,
+static int show_independent(struct commit **rev, size_t num_rev,
 			    unsigned int *rev_mask)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < num_rev; i++) {
 		struct commit *commit = rev[i];
@@ -625,7 +621,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	char *reflog_msg[MAX_REVS];
 	struct commit_list *list = NULL, *seen = NULL;
 	unsigned int rev_mask[MAX_REVS];
-	int num_rev, i, extra = 0;
+	size_t num_rev, i;
+	int extra = 0;
 	int all_heads = 0, all_remotes = 0;
 	int all_mask, all_revs;
 	enum rev_sort_order sort_order = REV_SORT_IN_GRAPH_ORDER;
@@ -789,7 +786,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 						msg);
 			free(logmsg);
 
-			nth_desc = xstrfmt("%s@{%d}", *av, base+i);
+			nth_desc = xstrfmt("%s@{%lu}", *av,
+					   (unsigned long)(base + i));
 			append_ref(nth_desc, &oid, 1);
 			free(nth_desc);
 		}
diff --git a/builtin/show-index.c b/builtin/show-index.c
index 0e0b9fb95bc..608d0908c98 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -10,13 +10,13 @@ static const char *const show_index_usage[] = {
 
 int cmd_show_index(int argc, const char **argv, const char *prefix)
 {
-	int i;
+	unsigned int i;
 	unsigned nr;
 	unsigned int version;
 	static unsigned int top_index[256];
 	unsigned hashsz;
 	const char *hash_name = NULL;
-	int hash_algo;
+	unsigned hash_algo;
 	const struct option show_index_options[] = {
 		OPT_STRING(0, "object-format", &hash_name, N_("hash-algorithm"),
 			   N_("specify the hash algorithm to use")),
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index c3738154918..89b86d933af 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -78,7 +78,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (pl.use_cone_patterns) {
-		int i;
+		size_t i;
 		struct pattern_entry *pe;
 		struct hashmap_iter iter;
 		struct string_list sl = STRING_LIST_INIT_DUP;
@@ -106,7 +106,8 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 
 static void clean_tracked_sparse_directories(struct repository *r)
 {
-	int i, was_full = 0;
+	unsigned int i;
+	int was_full = 0;
 	struct strbuf path = STRBUF_INIT;
 	size_t pathlen;
 	struct string_list_item *item;
@@ -264,7 +265,7 @@ static char *escaped_pattern(char *pattern)
 
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
-	int i;
+	size_t i;
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
diff --git a/builtin/stash.c b/builtin/stash.c
index 3a4f9fd566d..855076a287e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -853,7 +853,7 @@ static void diff_include_untracked(const struct stash_info *info, struct diff_op
 	struct tree *tree[ARRAY_SIZE(oid)];
 	struct tree_desc tree_desc[ARRAY_SIZE(oid)];
 	struct unpack_trees_options unpack_tree_opt = { 0 };
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(oid); i++) {
 		tree[i] = parse_tree_indirect(oid[i]);
@@ -1521,7 +1521,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	repo_read_index_preload(the_repository, NULL, 0);
 	if (!include_untracked && ps->nr) {
-		int i;
+		unsigned int i;
 		char *ps_matched = xcalloc(ps->nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c173d8b37a..664edde6517 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -185,7 +185,8 @@ static int module_list_compute(const char **argv,
 			       struct pathspec *pathspec,
 			       struct module_list *list)
 {
-	int i, result = 0;
+	unsigned int i;
+	int result = 0;
 	char *ps_matched = NULL;
 
 	parse_pathspec(pathspec, 0,
@@ -251,7 +252,7 @@ static char *get_up_path(const char *path)
 	int i;
 	struct strbuf sb = STRBUF_INIT;
 
-	for (i = count_slashes(path); i; i--)
+	for (i = count_slashes(path); i > 0; i--)
 		strbuf_addstr(&sb, "../");
 
 	/*
@@ -3212,7 +3213,7 @@ static void die_on_index_match(const char *path, int force)
 		die(_("index file corrupt"));
 
 	if (ps.nr) {
-		int i;
+		unsigned int i;
 		char *ps_matched = xcalloc(ps.nr, 1);
 
 		/* TODO: audit for interaction with sparse-index. */
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef29..e337ca4129e 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -571,7 +571,7 @@ static void unpack_one(unsigned nr)
 
 static void unpack_all(void)
 {
-	int i;
+	unsigned int i;
 	struct pack_header *hdr = fill(sizeof(struct pack_header));
 
 	nr_objects = ntohl(hdr->hdr_entries);
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a84e7b47a20..ded6a67a07f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -393,7 +393,7 @@ static void update_refs_stdin(void)
 	struct strbuf input = STRBUF_INIT, err = STRBUF_INIT;
 	enum update_refs_state state = UPDATE_REFS_OPEN;
 	struct ref_transaction *transaction;
-	int i, j;
+	size_t i;
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction)
@@ -435,7 +435,7 @@ static void update_refs_stdin(void)
 		 * error in case there is an early EOF to let the command
 		 * handle missing arguments with a proper error message.
 		 */
-		for (j = 1; line_termination == '\0' && j < cmd->args; j++)
+		for (i = 1; line_termination == '\0' && i < cmd->args; i++)
 			if (strbuf_appendwholeline(&input, stdin, line_termination))
 				break;
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 254283aa6f5..0f05fa7df20 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -160,7 +160,7 @@ static int prune_cmp(const void *a, const void *b)
 
 static void prune_dups(struct string_list *l)
 {
-	int i;
+	size_t i;
 
 	QSORT(l->items, l->nr, prune_cmp);
 	for (i = 1; i < l->nr; i++) {
@@ -785,7 +785,7 @@ static void show_worktree(struct worktree *wt, int path_maxlen, int abbrev_len)
 
 static void measure_widths(struct worktree **wt, int *abbrev, int *maxlen)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; wt[i]; i++) {
 		int sha1_len;
@@ -925,7 +925,8 @@ static void validate_no_submodules(const struct worktree *wt)
 {
 	struct index_state istate = INDEX_STATE_INIT(the_repository);
 	struct strbuf path = STRBUF_INIT;
-	int i, found_submodules = 0;
+	unsigned int i;
+	int found_submodules = 0;
 
 	if (is_directory(worktree_git_path(wt, "modules"))) {
 		/*
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 855b68ec23b..6bd0a15b671 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -48,7 +48,7 @@ static void flush_bulk_checkin_packfile(struct bulk_checkin_packfile *state)
 {
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct strbuf packname = STRBUF_INIT;
-	int i;
+	uint32_t i;
 
 	if (!state->f)
 		return;
@@ -121,7 +121,7 @@ static void flush_batch_fsync(void)
 
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
-	int i;
+	uint32_t i;
 
 	/* The object may already exist in the repository */
 	if (has_object_file(oid))
diff --git a/bundle.c b/bundle.c
index 6ab6cd7378d..cc3c820de67 100644
--- a/bundle.c
+++ b/bundle.c
@@ -41,7 +41,7 @@ static int parse_capability(struct bundle_header *header, const char *capability
 {
 	const char *arg;
 	if (skip_prefix(capability, "object-format=", &arg)) {
-		int algo = hash_algo_by_name(arg);
+		unsigned algo = hash_algo_by_name(arg);
 		if (algo == GIT_HASH_UNKNOWN)
 			return error(_("unrecognized bundle hash algorithm: %s"), arg);
 		header->hash_algo = &hash_algos[algo];
@@ -56,7 +56,7 @@ static int parse_capability(struct bundle_header *header, const char *capability
 
 static int parse_bundle_signature(struct bundle_header *header, const char *line)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(bundle_sigs); i++) {
 		if (!strcmp(line, bundle_sigs[i].signature)) {
@@ -163,7 +163,7 @@ int is_bundle(const char *path, int quiet)
 
 static int list_refs(struct string_list *r, int argc, const char **argv)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < r->nr; i++) {
 		struct object_id *oid;
@@ -212,7 +212,8 @@ int verify_bundle(struct repository *r,
 	 * to be verbose about the errors
 	 */
 	struct string_list *p = &header->prerequisites;
-	int i, ret = 0;
+	size_t i;
+	int ret = 0;
 	const char *message = _("Repository lacks these prerequisite commits:");
 	struct string_list_iterator iter = {
 		.list = p,
@@ -316,7 +317,7 @@ out:
 static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *pack_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
-	int i;
+	unsigned int i;
 
 	strvec_pushl(&pack_objects.args,
 		     "pack-objects",
@@ -370,7 +371,7 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs, struct strvec *
  */
 static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
 {
-	int i;
+	unsigned int i;
 	int ref_count = 0;
 
 	for (i = 0; i < revs->pending.nr; i++) {
@@ -495,7 +496,7 @@ int create_bundle(struct repository *r, const char *path,
 	struct rev_info revs, revs_copy;
 	int min_version = 2;
 	struct bundle_prerequisites_info bpi;
-	int i;
+	unsigned int i;
 
 	/* init revs to list objects for pack-objects later */
 	save_commit_buffer = 0;
diff --git a/cache-tree.c b/cache-tree.c
index 88c2c04f87f..5b03a036fbb 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -694,7 +694,7 @@ struct tree* write_in_core_index_as_tree(struct repository *repo) {
 
 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
-		int i;
+		unsigned int i;
 		bug("there are unmerged index entries:");
 		for (i = 0; i < index_state->cache_nr; i++) {
 			const struct cache_entry *ce = index_state->cache[i];
@@ -879,7 +879,8 @@ static int verify_one(struct repository *r,
 		      struct cache_tree *it,
 		      struct strbuf *path)
 {
-	int i, pos, len = path->len;
+	int i, pos;
+	size_t len = path->len;
 	struct strbuf tree_buf = STRBUF_INIT;
 	struct object_id new_oid;
 
@@ -952,8 +953,9 @@ static int verify_one(struct repository *r,
 			 &new_oid);
 	if (!oideq(&new_oid, &it->oid))
 		BUG("cache-tree for path %.*s does not match. "
-		    "Expected %s got %s", len, path->buf,
-		    oid_to_hex(&new_oid), oid_to_hex(&it->oid));
+		    "Expected %s got %s",
+		    (int)len, path->buf, oid_to_hex(&new_oid),
+		    oid_to_hex(&it->oid));
 	strbuf_setlen(path, len);
 	strbuf_release(&tree_buf);
 	return 0;
diff --git a/cache.h b/cache.h
index 12789903e88..bbfd0ac8255 100644
--- a/cache.h
+++ b/cache.h
@@ -649,9 +649,9 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-	    const char *template_dir, int hash_algo,
+	    const char *template_dir, int hash,
 	    const char *initial_branch, unsigned int flags);
-void initialize_repository_version(int hash_algo, int reinit);
+void initialize_repository_version(unsigned int hash, int reinit);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -1132,7 +1132,7 @@ struct repository_format {
 	char *partial_clone; /* value of extensions.partialclone */
 	int worktree_config;
 	int is_bare;
-	int hash_algo;
+	unsigned hash_algo;
 	int sparse_index;
 	char *work_tree;
 	struct string_list unknown_extensions;
@@ -1212,7 +1212,8 @@ void check_repository_format(struct repository_format *fmt);
  */
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
 #define find_unique_abbrev(oid, len) repo_find_unique_abbrev(the_repository, oid, len)
-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+				       const struct object_id *oid, int len);
 #define find_unique_abbrev_r(hex, oid, len) repo_find_unique_abbrev_r(the_repository, hex, oid, len)
 
 /* set default permissions by passing mode arguments to open(2) */
@@ -1618,7 +1619,8 @@ int base_name_compare(const char *name1, size_t len1, int mode1,
 int df_name_compare(const char *name1, size_t len1, int mode1,
 		    const char *name2, size_t len2, int mode2);
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2);
 
 void *read_object_with_reference(struct repository *r,
 				 const struct object_id *oid,
@@ -1828,8 +1830,8 @@ extern const char *askpass_program;
 extern const char *excludes_file;
 
 /* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
+int decode_85(char *dst, const char *line, size_t linelen);
+void encode_85(char *buf, const unsigned char *data, size_t bytes);
 
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
diff --git a/chunk-format.c b/chunk-format.c
index 0275b74a895..6981c2afd57 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -58,7 +58,8 @@ void add_chunk(struct chunkfile *cf,
 
 int write_chunkfile(struct chunkfile *cf, void *data)
 {
-	int i, result = 0;
+	size_t i;
+	int result = 0;
 	uint64_t cur_offset = hashfile_total(cf->f);
 
 	trace2_region_enter("chunkfile", "write", the_repository);
@@ -101,7 +102,7 @@ int read_table_of_contents(struct chunkfile *cf,
 			   uint64_t toc_offset,
 			   int toc_length)
 {
-	int i;
+	size_t i;
 	uint32_t chunk_id;
 	const unsigned char *table_of_contents = mfile + toc_offset;
 
@@ -172,7 +173,7 @@ int read_chunk(struct chunkfile *cf,
 	       chunk_read_fn fn,
 	       void *data)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < cf->chunks_nr; i++) {
 		if (cf->chunks[i].id == chunk_id)
diff --git a/color.c b/color.c
index f05d8a81d72..e3e1d3a04a6 100644
--- a/color.c
+++ b/color.c
@@ -54,7 +54,7 @@ struct color {
  * "word" is a buffer of length "len"; does it match the NUL-terminated
  * "match" exactly?
  */
-static int match_word(const char *word, int len, const char *match)
+static int match_word(const char *word, size_t len, const char *match)
 {
 	return !strncasecmp(word, match, len) && !match[len];
 }
@@ -73,15 +73,15 @@ static int get_hex_color(const char *in, unsigned char *out)
  * If an ANSI color is recognized in "name", fill "out" and return 0.
  * Otherwise, leave out unchanged and return -1.
  */
-static int parse_ansi_color(struct color *out, const char *name, int len)
+static int parse_ansi_color(struct color *out, const char *name, size_t len)
 {
 	/* Positions in array must match ANSI color codes */
 	static const char * const color_names[] = {
 		"black", "red", "green", "yellow",
 		"blue", "magenta", "cyan", "white"
 	};
-	int i;
-	int color_offset = COLOR_FOREGROUND_ANSI;
+	unsigned int i;
+	unsigned int color_offset = COLOR_FOREGROUND_ANSI;
 
 	if (match_word(name, len, "default")) {
 		/*
@@ -119,7 +119,7 @@ static int parse_ansi_color(struct color *out, const char *name, int len)
 	return -1;
 }
 
-static int parse_color(struct color *out, const char *name, int len)
+static int parse_color(struct color *out, const char *name, size_t len)
 {
 	char *end;
 	long val;
@@ -195,7 +195,7 @@ static int parse_attr(const char *name, size_t len)
 #undef ATTR
 	};
 	int negate = 0;
-	int i;
+	size_t i;
 
 	if (skip_prefix_mem(name, len, "no", &name, &len)) {
 		skip_prefix_mem(name, len, "-", &name, &len);
@@ -219,7 +219,8 @@ int color_parse(const char *value, char *dst)
  * already have the ANSI escape code in it. "out" should have enough
  * space in it to fit any color.
  */
-static char *color_output(char *out, int len, const struct color *c, int background)
+static char *color_output(char *out, size_t len, const struct color *c,
+			  int background)
 {
 	int offset = 0;
 
@@ -250,17 +251,17 @@ static int color_empty(const struct color *c)
 	return c->type <= COLOR_NORMAL;
 }
 
-int color_parse_mem(const char *value, int value_len, char *dst)
+int color_parse_mem(const char *value, size_t value_len, char *dst)
 {
 	const char *ptr = value;
-	int len = value_len;
+	size_t len = value_len;
 	char *end = dst + COLOR_MAXLEN;
-	unsigned int has_reset = 0;
+	int has_reset = 0;
 	unsigned int attr = 0;
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
-	while (len > 0 && isspace(*ptr)) {
+	while (len && isspace(*ptr)) {
 		ptr++;
 		len--;
 	}
@@ -271,10 +272,11 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	}
 
 	/* [reset] [fg [bg]] [attr]... */
-	while (len > 0) {
+	while (len) {
 		const char *word = ptr;
 		struct color c = { COLOR_UNSPECIFIED };
-		int val, wordlen = 0;
+		int val;
+		size_t wordlen = 0;
 
 		while (len > 0 && !isspace(word[wordlen])) {
 			wordlen++;
@@ -319,7 +321,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 
 	if (has_reset || attr || !color_empty(&fg) || !color_empty(&bg)) {
 		int sep = 0;
-		int i;
+		unsigned int i;
 
 		OUT('\033');
 		OUT('[');
@@ -334,7 +336,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 			attr &= ~bit;
 			if (sep++)
 				OUT(';');
-			dst += xsnprintf(dst, end - dst, "%d", i);
+			dst += xsnprintf(dst, end - dst, "%u", i);
 		}
 		if (!color_empty(&fg)) {
 			if (sep++)
@@ -351,7 +353,7 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	OUT(0);
 	return 0;
 bad:
-	return error(_("invalid color value: %.*s"), value_len, value);
+	return error(_("invalid color value: %.*s"), (int)value_len, value);
 #undef OUT
 }
 
diff --git a/color.h b/color.h
index cfc8f841b23..35c0cf09d08 100644
--- a/color.h
+++ b/color.h
@@ -119,7 +119,7 @@ int want_color_fd(int fd, int var);
  * name ("red"), a RGB code (#0xFF0000) or a 256-color-mode from the terminal.
  */
 int color_parse(const char *value, char *dst);
-int color_parse_mem(const char *value, int len, char *dst);
+int color_parse_mem(const char *value, size_t len, char *dst);
 
 /*
  * Output the formatted string in the specified color (and then reset to normal
diff --git a/column.c b/column.c
index fbf88639aae..01db21d535c 100644
--- a/column.c
+++ b/column.c
@@ -32,7 +32,7 @@ static int item_length(const char *s)
  */
 static void layout(struct column_data *data, int *width)
 {
-	int i;
+	size_t i;
 
 	*width = 0;
 	for (i = 0; i < data->list->nr; i++)
@@ -101,7 +101,7 @@ static void shrink_columns(struct column_data *data)
 static void display_plain(const struct string_list *list,
 			  const char *indent, const char *nl)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < list->nr; i++)
 		printf("%s%s%s", indent, list->items[i].string, nl);
@@ -146,7 +146,8 @@ static void display_table(const struct string_list *list,
 			  const struct column_options *opts)
 {
 	struct column_data data;
-	int x, y, i, initial_width;
+	int x, y, initial_width;
+	size_t i;
 	char *empty_cell;
 
 	memset(&data, 0, sizeof(data));
@@ -240,7 +241,7 @@ static int parse_option(const char *arg, int len, unsigned int *colopts,
 		{ "row",    COL_ROW,      COL_LAYOUT_MASK },
 		{ "dense",  COL_DENSE,    0 },
 	};
-	int i;
+	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(opts); i++) {
 		int set = 1, arg_len = len, name_len;
diff --git a/combine-diff.c b/combine-diff.c
index 1a39b5dde09..ae0073472bb 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -30,8 +30,8 @@ static int filename_changed(char status)
 
 static struct combine_diff_path *intersect_paths(
 	struct combine_diff_path *curr,
-	int n,
-	int num_parent,
+	size_t n,
+	size_t num_parent,
 	int combined_all_paths)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
@@ -40,7 +40,7 @@ static struct combine_diff_path *intersect_paths(
 
 	if (!n) {
 		for (i = 0; i < q->nr; i++) {
-			int len;
+			size_t len;
 			const char *path;
 			if (diff_unmodified_pair(q->queue[i]))
 				continue;
@@ -251,7 +251,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	/* At this point, baseend and newend point to the end of each lists */
 	i--;
 	j--;
-	while (i != 0 || j != 0) {
+	while (i > 0 || j > 0) {
 		if (directions[i][j] == MATCH) {
 			baseend->parent_map |= 1<<parent;
 			baseend = baseend->prev;
@@ -836,14 +836,13 @@ static void dump_sline(struct sline *sline, const char *line_prefix,
 		printf("%s\n", c_reset);
 		while (lno < hunk_end) {
 			struct lline *ll;
-			int j;
 			unsigned long p_mask;
 			struct sline *sl = &sline[lno++];
 			ll = (sl->flag & no_pre_delete) ? NULL : sl->lost;
 			while (ll) {
 				printf("%s%s", line_prefix, c_old);
-				for (j = 0; j < num_parent; j++) {
-					if (ll->parent_map & (1UL<<j))
+				for (i = 0; i < num_parent; i++) {
+					if (ll->parent_map & (1UL<<i))
 						putchar('-');
 					else
 						putchar(' ');
@@ -866,7 +865,7 @@ static void dump_sline(struct sline *sline, const char *line_prefix,
 			}
 			else
 				fputs(c_new, stdout);
-			for (j = 0; j < num_parent; j++) {
+			for (i = 0; i < num_parent; i++) {
 				if (p_mask & sl->flag)
 					putchar('+');
 				else
@@ -1383,7 +1382,7 @@ static struct combine_diff_path *find_paths_generic(const struct object_id *oid,
 	int combined_all_paths)
 {
 	struct combine_diff_path *paths = NULL;
-	int i, num_parent = parents->nr;
+	size_t i, num_parent = parents->nr;
 
 	int output_format = opt->output_format;
 	const char *orderfile = opt->orderfile;
@@ -1431,7 +1430,7 @@ static struct combine_diff_path *find_paths_multitree(
 	const struct object_id *oid, const struct oid_array *parents,
 	struct diff_options *opt)
 {
-	int i, nparent = parents->nr;
+	size_t i, nparent = parents->nr;
 	const struct object_id **parents_oid;
 	struct combine_diff_path paths_head;
 	struct strbuf base;
diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b3..9683618d3ef 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -501,7 +501,7 @@ static struct commit_graph *load_commit_graph_chain(struct repository *r,
 	struct strbuf line = STRBUF_INIT;
 	struct stat st;
 	struct object_id *oids;
-	int i = 0, valid = 1, count;
+	int i, valid = 1, count;
 	char *chain_name = get_commit_graph_chain_filename(odb);
 	FILE *fp;
 	int stat_res;
@@ -1045,7 +1045,8 @@ static int write_graph_chunk_fanout(struct hashfile *f,
 				    void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, count = 0;
+	unsigned int i;
+	uint32_t count = 0;
 	struct commit **list = ctx->commits.list;
 
 	/*
@@ -1195,7 +1196,7 @@ static int write_graph_chunk_generation_data(struct hashfile *f,
 					     void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i, num_generation_data_overflows = 0;
+	size_t i, num_generation_data_overflows = 0;
 
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
@@ -1219,7 +1220,7 @@ static int write_graph_chunk_generation_data_overflow(struct hashfile *f,
 						      void *data)
 {
 	struct write_commit_graph_context *ctx = data;
-	int i;
+	size_t i;
 	for (i = 0; i < ctx->commits.nr; i++) {
 		struct commit *c = ctx->commits.list[i];
 		timestamp_t offset = commit_graph_data_at(c)->generation - c->date;
@@ -1390,7 +1391,7 @@ static void add_missing_parents(struct write_commit_graph_context *ctx, struct c
 
 static void close_reachable(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit *commit;
 	enum commit_graph_split_flags flags = ctx->opts ?
 		ctx->opts->split_flags : COMMIT_GRAPH_SPLIT_UNSPECIFIED;
@@ -1448,7 +1449,7 @@ static void close_reachable(struct write_commit_graph_context *ctx)
 
 static void compute_topological_levels(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
@@ -1501,7 +1502,7 @@ static void compute_topological_levels(struct write_commit_graph_context *ctx)
 
 static void compute_generation_numbers(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct commit_list *list = NULL;
 
 	if (ctx->report_progress)
@@ -1582,10 +1583,10 @@ static void trace2_bloom_filter_write_statistics(struct write_commit_graph_conte
 
 static void compute_bloom_filters(struct write_commit_graph_context *ctx)
 {
-	int i;
+	size_t i;
 	struct progress *progress = NULL;
 	struct commit **sorted_commits;
-	int max_new_filters;
+	size_t max_new_filters;
 
 	init_bloom_filters();
 
diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..9220c5753cf 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -722,7 +722,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				 timestamp_t min_generation)
 {
 	struct commit **list = NULL;
-	int i;
+	unsigned int i;
+	int j;
 	int nr_commits;
 	int result = 1;
 
@@ -759,12 +760,12 @@ int can_all_from_reach_with_flag(struct object_array *from,
 
 	QSORT(list, nr_commits, compare_commits_by_gen);
 
-	for (i = 0; i < nr_commits; i++) {
+	for (j = 0; j < nr_commits; j++) {
 		/* DFS from list[i] */
 		struct commit_list *stack = NULL;
 
-		list[i]->object.flags |= assign_flag;
-		commit_list_insert(list[i], &stack);
+		list[j]->object.flags |= assign_flag;
+		commit_list_insert(list[j], &stack);
 
 		while (stack) {
 			struct commit_list *parent;
@@ -797,7 +798,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				pop_commit(&stack);
 		}
 
-		if (!(list[i]->object.flags & (with_flag | RESULT))) {
+		if (!(list[j]->object.flags & (with_flag | RESULT))) {
 			result = 0;
 			goto cleanup;
 		}
diff --git a/commit.c b/commit.c
index e433c33bb01..fde358d75ce 100644
--- a/commit.c
+++ b/commit.c
@@ -423,8 +423,8 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
-	const int tree_entry_len = the_hash_algo->hexsz + 5;
-	const int parent_entry_len = the_hash_algo->hexsz + 7;
+	const size_t tree_entry_len = the_hash_algo->hexsz + 5;
+	const size_t parent_entry_len = the_hash_algo->hexsz + 7;
 	struct tree *tree;
 
 	if (item->object.parsed)
@@ -1168,10 +1168,10 @@ int remove_signature(struct strbuf *buf)
 		if (in_signature && line[0] == ' ')
 			sigp->end = next;
 		else if (starts_with(line, "gpgsig")) {
-			int i;
-			for (i = 1; i < GIT_HASH_NALGOS; i++) {
+			unsigned int j;
+			for (j = 1; j < GIT_HASH_NALGOS; j++) {
 				const char *p;
-				if (skip_prefix(line, gpg_sig_headers[i], &p) &&
+				if (skip_prefix(line, gpg_sig_headers[j], &p) &&
 				    *p == ' ') {
 					sigp->start = line;
 					sigp->end = next;
diff --git a/compat/compiler.h b/compat/compiler.h
index 10dbb65937d..33d51f461c9 100644
--- a/compat/compiler.h
+++ b/compat/compiler.h
@@ -10,7 +10,8 @@
 
 static inline void get_compiler_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
+
 #ifdef __clang__
 	strbuf_addf(info, "clang: %s\n", __clang_version__);
 #elif defined(__GNUC__)
@@ -18,8 +19,8 @@ static inline void get_compiler_info(struct strbuf *info)
 #endif
 
 #ifdef _MSC_VER
-	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n",
-		    _MSC_VER / 100, _MSC_VER % 100, _MSC_FULL_VER % 100000);
+	strbuf_addf(info, "MSVC version: %02d.%02d.%05d\n", _MSC_VER / 100,
+		    _MSC_VER % 100, _MSC_FULL_VER % 100000);
 #endif
 
 	if (len == info->len)
@@ -28,7 +29,7 @@ static inline void get_compiler_info(struct strbuf *info)
 
 static inline void get_libc_info(struct strbuf *info)
 {
-	int len = info->len;
+	size_t len = info->len;
 
 #ifdef __GLIBC__
 	strbuf_addf(info, "glibc: %s\n", gnu_get_libc_version());
diff --git a/compat/strcasestr.c b/compat/strcasestr.c
index 26896deca64..a5e69e06ba7 100644
--- a/compat/strcasestr.c
+++ b/compat/strcasestr.c
@@ -2,16 +2,16 @@
 
 char *gitstrcasestr(const char *haystack, const char *needle)
 {
-	int nlen = strlen(needle);
-	int hlen = strlen(haystack) - nlen + 1;
-	int i;
+	size_t nlen = strlen(needle);
+	size_t hlen = strlen(haystack) - nlen + 1;
+	size_t i;
 
 	for (i = 0; i < hlen; i++) {
-		int j;
+		size_t j;
 		for (j = 0; j < nlen; j++) {
 			unsigned char c1 = haystack[i+j];
 			unsigned char c2 = needle[j];
-			if (toupper(c1) != toupper(c2))
+			if (tolower(c1) != tolower(c2))
 				goto next;
 		}
 		return (char *) haystack + i;
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index b9d34af6136..8a7daff2699 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -5,7 +5,7 @@ int gitunsetenv(const char *name)
 #if !defined(__MINGW32__)
      extern char **environ;
 #endif
-     int src, dst;
+     size_t src, dst;
      size_t nmln;
 
      nmln = strlen(name);
diff --git a/compat/winansi.c b/compat/winansi.c
index f83610f684d..5aec44a94e6 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -195,9 +195,9 @@ static void erase_in_line(void)
 		&dummy);
 }
 
-static void set_attr(char func, const int *params, int paramlen)
+static void set_attr(char func, const int *params, size_t paramlen)
 {
-	int i;
+	size_t i;
 	switch (func) {
 	case 'm':
 		for (i = 0; i < paramlen; i++) {
@@ -344,7 +344,8 @@ static DWORD WINAPI console_thread(LPVOID unused)
 {
 	unsigned char buffer[BUFFER_SIZE];
 	DWORD bytes;
-	int start, end = 0, c, parampos = 0, state = TEXT;
+	int start, end = 0, c, state = TEXT;
+	size_t parampos = 0;
 	int params[MAX_PARAMS];
 
 	while (1) {
diff --git a/config.c b/config.c
index 00090a32fc3..7e7efb5cbbc 100644
--- a/config.c
+++ b/config.c
@@ -721,7 +721,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 	if (env) {
 		unsigned long count;
 		char *endp;
-		int i;
+		unsigned long i;
 
 		count = strtoul(env, &endp, 10);
 		if (*endp) {
@@ -736,7 +736,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 		for (i = 0; i < count; i++) {
 			const char *key, *value;
 
-			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%lu", i);
 			key = getenv_safe(&to_free, envvar.buf);
 			if (!key) {
 				ret = error(_("missing config key %s"), envvar.buf);
@@ -744,7 +744,7 @@ int git_config_from_parameters(config_fn_t fn, void *data)
 			}
 			strbuf_reset(&envvar);
 
-			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%lu", i);
 			value = getenv_safe(&to_free, envvar.buf);
 			if (!value) {
 				ret = error(_("missing config value %s"), envvar.buf);
@@ -1372,7 +1372,7 @@ static enum fsync_component parse_fsync_components(const char *var, const char *
 	enum fsync_component positive = 0, negative = 0;
 
 	while (string) {
-		int i;
+		size_t i;
 		size_t len;
 		const char *ep;
 		int negated = 0;
@@ -2221,7 +2221,8 @@ int config_with_options(config_fn_t fn, void *data,
 
 static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 {
-	int i, value_index;
+	unsigned int i;
+	size_t value_index;
 	struct string_list *values;
 	struct config_set_element *entry;
 	struct configset_list *list = &cs->list;
@@ -3008,7 +3009,7 @@ static ssize_t write_section(int fd, const char *key,
 static ssize_t write_pair(int fd, const char *key, const char *value,
 			  const struct config_store_data *store)
 {
-	int i;
+	size_t i;
 	ssize_t ret;
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
@@ -3065,17 +3066,19 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
  */
 static void maybe_remove_section(struct config_store_data *store,
 				 size_t *begin_offset, size_t *end_offset,
-				 int *seen_ptr)
+				 unsigned int *seen_ptr)
 {
 	size_t begin;
-	int i, seen, section_seen = 0;
+	unsigned int i;
+	unsigned int seen;
+	int section_seen = 0;
 
 	/*
 	 * First, ensure that this is the first key, and that there are no
 	 * comments before the entry nor before the section header.
 	 */
 	seen = *seen_ptr;
-	for (i = store->seen[seen]; i > 0; i--) {
+	for (i = store->seen[seen]; i; i--) {
 		enum config_event_t type = store->parsed[i - 1].type;
 
 		if (type == CONFIG_EVENT_COMMENT)
@@ -3257,7 +3260,8 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 	} else {
 		struct stat st;
 		size_t copy_begin, copy_end;
-		int i, new_line = 0;
+		unsigned int i;
+		int new_line = 0;
 		struct config_options opts;
 
 		if (!value_pattern)
@@ -3352,7 +3356,7 @@ int git_config_set_multivar_in_file_gently(const char *config_filename,
 
 		for (i = 0, copy_begin = 0; i < store.seen_nr; i++) {
 			size_t replace_end;
-			int j = store.seen[i];
+			unsigned int j = store.seen[i];
 
 			new_line = 0;
 			if (!store.key_seen) {
@@ -3487,9 +3491,10 @@ void git_config_set_multivar(const char *key, const char *value,
 					flags);
 }
 
-static int section_name_match (const char *buf, const char *name)
+static unsigned int section_name_match(const char *buf, const char *name)
 {
-	int i = 0, j = 0, dot = 0;
+	unsigned int i = 0, j = 0;
+	int dot = 0;
 	if (buf[i] != '[')
 		return 0;
 	for (i = 1; buf[i] && buf[i] != ']'; i++) {
diff --git a/config.h b/config.h
index 7606246531a..d420035f5cb 100644
--- a/config.h
+++ b/config.h
@@ -413,7 +413,7 @@ struct config_set_element {
 
 struct configset_list_item {
 	struct config_set_element *e;
-	int value_index;
+	size_t value_index;
 };
 
 /*
diff --git a/connect.c b/connect.c
index 63e59641c0d..858fa2f891c 100644
--- a/connect.c
+++ b/connect.c
@@ -238,7 +238,7 @@ static void process_capabilities(struct packet_reader *reader, int *linelen)
 	feat_val = server_feature_value("object-format", &feat_len);
 	if (feat_val) {
 		char *hash_name = xstrndup(feat_val, feat_len);
-		int hash_algo = hash_algo_by_name(hash_name);
+		unsigned hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo != GIT_HASH_UNKNOWN)
 			reader->hash_algo = &hash_algos[hash_algo];
 		free(hash_name);
@@ -385,7 +385,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 			  const char **unborn_head_target)
 {
 	int ret = 1;
-	int i = 0;
+	size_t i;
 	struct object_id old_oid;
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
@@ -403,15 +403,14 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 		goto out;
 	}
 
-	if (!strcmp("unborn", line_sections.items[i].string)) {
-		i++;
+	if (!strcmp("unborn", line_sections.items[0].string)) {
 		if (unborn_head_target &&
-		    !strcmp("HEAD", line_sections.items[i++].string)) {
+		    !strcmp("HEAD", line_sections.items[1].string)) {
 			/*
 			 * Look for the symref target (if any). If found,
 			 * return it to the caller.
 			 */
-			for (; i < line_sections.nr; i++) {
+			for (i = 2; i < line_sections.nr; i++) {
 				const char *arg = line_sections.items[i].string;
 
 				if (skip_prefix(arg, "symref-target:", &arg)) {
@@ -422,19 +421,20 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 		}
 		goto out;
 	}
-	if (parse_oid_hex_algop(line_sections.items[i++].string, &old_oid, &end, reader->hash_algo) ||
+	if (parse_oid_hex_algop(line_sections.items[0].string, &old_oid, &end,
+				reader->hash_algo) ||
 	    *end) {
 		ret = 0;
 		goto out;
 	}
 
-	ref = alloc_ref(line_sections.items[i++].string);
+	ref = alloc_ref(line_sections.items[1].string);
 
 	memcpy(ref->old_oid.hash, old_oid.hash, reader->hash_algo->rawsz);
 	**list = ref;
 	*list = &ref->next;
 
-	for (; i < line_sections.nr; i++) {
+	for (i = 2; i < line_sections.nr; i++) {
 		const char *arg = line_sections.items[i].string;
 		if (skip_prefix(arg, "symref-target:", &arg))
 			ref->symref = xstrdup(arg);
@@ -484,7 +484,7 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 		packet_write_fmt(fd_out, "agent=%s", git_user_agent_sanitized());
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		unsigned hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown object format '%s' specified by server"), hash_name);
 		reader->hash_algo = &hash_algos[hash_algo];
@@ -543,7 +543,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
-	int i;
+	size_t i;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
diff --git a/convert.c b/convert.c
index a54d1690c08..8820b1301e0 100644
--- a/convert.c
+++ b/convert.c
@@ -313,17 +313,15 @@ static void trace_encoding(const char *context, const char *path,
 {
 	static struct trace_key coe = TRACE_KEY_INIT(WORKING_TREE_ENCODING);
 	struct strbuf trace = STRBUF_INIT;
-	int i;
+	size_t i;
 
 	strbuf_addf(&trace, "%s (%s, considered %s):\n", context, path, encoding);
 	for (i = 0; i < len && buf; ++i) {
-		strbuf_addf(
-			&trace, "| \033[2m%2i:\033[0m %2x \033[2m%c\033[0m%c",
-			i,
-			(unsigned char) buf[i],
-			(buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
-			((i+1) % 8 && (i+1) < len ? ' ' : '\n')
-		);
+		strbuf_addf(&trace,
+			    "| \033[2m%2u:\033[0m %2x \033[2m%c\033[0m%c",
+			    (unsigned int)i, (unsigned char)buf[i],
+			    (buf[i] > 32 && buf[i] < 127 ? buf[i] : ' '),
+			    ((i + 1) % 8 && (i + 1) < len ? ' ' : '\n'));
 	}
 	strbuf_addchars(&trace, '\n', 1);
 
@@ -1815,7 +1813,7 @@ struct ident_filter {
 
 static int is_foreign_ident(const char *str)
 {
-	int i;
+	size_t i;
 
 	if (!skip_prefix(str, "$Id: ", &str))
 		return 0;
diff --git a/credential.c b/credential.c
index f32011343f9..e25ebbc52e9 100644
--- a/credential.c
+++ b/credential.c
@@ -344,7 +344,7 @@ static int credential_do(struct credential *c, const char *helper,
 
 void credential_fill(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	if (c->username && c->password)
 		return;
@@ -373,7 +373,7 @@ void credential_fill(struct credential *c)
 
 void credential_approve(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	if (c->approved)
 		return;
@@ -389,7 +389,7 @@ void credential_approve(struct credential *c)
 
 void credential_reject(struct credential *c)
 {
-	int i;
+	size_t i;
 
 	credential_apply_config(c);
 
diff --git a/daemon.c b/daemon.c
index 0ae7d12b5c1..aa5ee229bd1 100644
--- a/daemon.c
+++ b/daemon.c
@@ -517,7 +517,7 @@ static struct daemon_service daemon_service[] = {
 
 static void enable_service(const char *name, int ena)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].enabled = ena;
@@ -529,7 +529,7 @@ static void enable_service(const char *name, int ena)
 
 static void make_service_overridable(const char *name, int ena)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
 			daemon_service[i].overridable = ena;
@@ -605,7 +605,7 @@ static void canonicalize_client(struct strbuf *out, const char *in)
 static char *parse_host_arg(struct hostinfo *hi, char *extra_args, int buflen)
 {
 	char *val;
-	int vallen;
+	size_t vallen;
 	char *end = extra_args + buflen;
 
 	if (extra_args < end && *extra_args) {
@@ -751,7 +751,8 @@ static void set_keep_alive(int sockfd)
 static int execute(void)
 {
 	char *line = packet_buffer;
-	int pktlen, len, i;
+	int pktlen, len;
+	size_t i;
 	char *addr = getenv("REMOTE_ADDR"), *port = getenv("REMOTE_PORT");
 	struct hostinfo hi = HOSTINFO_INIT;
 	struct strvec env = STRVEC_INIT;
@@ -1122,7 +1123,8 @@ static void socksetup(struct string_list *listen_addr, int listen_port, struct s
 	if (!listen_addr->nr)
 		setup_named_sock(NULL, listen_port, socklist);
 	else {
-		int i, socknum;
+		size_t i;
+		int socknum;
 		for (i = 0; i < listen_addr->nr; i++) {
 			socknum = setup_named_sock(listen_addr->items[i].string,
 						   listen_port, socklist);
@@ -1149,7 +1151,7 @@ static int service_loop(struct socketlist *socklist)
 	signal(SIGCHLD, child_handler);
 
 	for (;;) {
-		int i;
+		size_t i;
 
 		check_dead_children();
 
diff --git a/date.c b/date.c
index 6f45eeb3568..fd4b686b7e0 100644
--- a/date.c
+++ b/date.c
@@ -421,12 +421,12 @@ static const struct {
 
 static int match_string(const char *date, const char *str)
 {
-	int i = 0;
+	int i;
 
 	for (i = 0; *date; date++, str++, i++) {
 		if (*date == *str)
 			continue;
-		if (toupper(*date) == toupper(*str))
+		if (tolower(*date) == tolower(*str))
 			continue;
 		if (!isalnum(*date))
 			break;
diff --git a/decorate.c b/decorate.c
index 2036d159671..5654dd435d2 100644
--- a/decorate.c
+++ b/decorate.c
@@ -34,8 +34,8 @@ static void *insert_decoration(struct decoration *n, const struct object *base,
 
 static void grow_decoration(struct decoration *n)
 {
-	int i;
-	int old_size = n->size;
+	unsigned int i;
+	unsigned int old_size = n->size;
 	struct decoration_entry *old_entries = n->entries;
 
 	n->size = (old_size + 1000) * 3 / 2;
@@ -56,7 +56,7 @@ static void grow_decoration(struct decoration *n)
 void *add_decoration(struct decoration *n, const struct object *obj,
 		void *decoration)
 {
-	int nr = n->nr + 1;
+	unsigned int nr = n->nr + 1;
 
 	if (nr > n->size * 2 / 3)
 		grow_decoration(n);
diff --git a/delta-islands.c b/delta-islands.c
index afdec0a878d..d4a7bce70ab 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -243,8 +243,8 @@ void resolve_tree_islands(struct repository *r,
 {
 	struct progress *progress_state = NULL;
 	struct tree_islands_todo *todo;
-	int nr = 0;
-	int i;
+	uint32_t nr = 0;
+	uint32_t i;
 
 	if (!island_marks)
 		return;
@@ -320,7 +320,8 @@ static const char *core_island_name;
 
 static void free_config_regexes(struct island_load_data *ild)
 {
-	for (size_t i = 0; i < ild->nr; i++)
+	size_t i;
+	for (i = 0; i < ild->nr; i++)
 		regfree(&ild->rx[i]);
 	free(ild->rx);
 }
@@ -400,7 +401,8 @@ static int find_island_for_ref(const char *refname, const struct object_id *oid,
 	 * than we support.
 	 */
 	regmatch_t matches[16];
-	int i, m;
+	int i;
+	size_t m;
 	struct strbuf island_name = STRBUF_INIT;
 
 	/* walk backwards to get last-one-wins ordering */
diff --git a/diagnose.c b/diagnose.c
index 8f265698966..9206c271663 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -25,7 +25,7 @@ static struct diagnose_option diagnose_options[] = {
 
 int option_parse_diagnose(const struct option *opt, const char *arg, int unset)
 {
-	int i;
+	size_t i;
 	enum diagnose_mode *diagnose = opt->value;
 
 	if (!arg) {
diff --git a/diff-lib.c b/diff-lib.c
index dec040c366c..03088f668b1 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -90,7 +90,7 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 
 int run_diff_files(struct rev_info *revs, unsigned int option)
 {
-	int entries, i;
+	unsigned int entries, i;
 	int diff_unmerged_stage = revs->max_count;
 	unsigned ce_option = ((option & DIFF_RACY_IS_MODIFIED)
 			      ? CE_MATCH_RACY_IS_DIRTY : 0);
@@ -556,7 +556,7 @@ static int diff_cache(struct rev_info *revs,
 
 void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 {
-	int i;
+	unsigned int i;
 	struct commit *mb_child[2] = {0};
 	struct commit_list *merge_bases;
 
diff --git a/diff-no-index.c b/diff-no-index.c
index 05fafd0019b..2019db4a350 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -242,7 +242,8 @@ int diff_no_index(struct rev_info *revs,
 		  int implicit_no_index,
 		  int argc, const char **argv)
 {
-	int i, no_index;
+	unsigned int i;
+	int no_index;
 	int ret = 1;
 	const char *paths[2];
 	char *to_free[ARRAY_SIZE(paths)] = { 0 };
diff --git a/diff.c b/diff.c
index 469e18aed20..62422361bb5 100644
--- a/diff.c
+++ b/diff.c
@@ -124,7 +124,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	char *params_copy = xstrdup(params_string);
 	struct string_list params = STRING_LIST_INIT_NODUP;
 	int ret = 0;
-	int i;
+	size_t i;
 
 	if (*params_copy)
 		string_list_split_in_place(&params, params_copy, ',', -1);
@@ -1678,7 +1678,7 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 static struct diff_tempfile *claim_diff_tempfile(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++)
 		if (!diff_temp[i].name)
 			return diff_temp + i;
@@ -1687,7 +1687,7 @@ static struct diff_tempfile *claim_diff_tempfile(void)
 
 static void remove_tempfile(void)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(diff_temp); i++) {
 		if (is_tempfile_active(diff_temp[i].tempfile))
 			delete_tempfile(&diff_temp[i].tempfile);
@@ -2006,7 +2006,7 @@ static void fn_out_diff_words_aux(void *priv,
 
 /* This function starts looking at *begin, and returns 0 iff a word was found. */
 static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
-		int *begin, int *end)
+				long *begin, long *end)
 {
 	while (word_regex && *begin < buffer->size) {
 		regmatch_t match[1];
@@ -2047,7 +2047,7 @@ static int find_word_boundaries(mmfile_t *buffer, regex_t *word_regex,
 static void diff_words_fill(struct diff_words_buffer *buffer, mmfile_t *out,
 		regex_t *word_regex)
 {
-	int i, j;
+	long i, j;
 	long alloc = 0;
 
 	out->size = 0;
@@ -2188,7 +2188,7 @@ static void init_diff_words_data(struct emit_callback *ecbdata,
 				 struct diff_filespec *one,
 				 struct diff_filespec *two)
 {
-	int i;
+	size_t i;
 	struct diff_options *o = xmalloc(sizeof(struct diff_options));
 	memcpy(o, orig_opts, sizeof(struct diff_options));
 
@@ -3305,8 +3305,8 @@ static void emit_binary_diff_body(struct diff_options *o,
 	/* emit data encoded in base85 */
 	cp = data;
 	while (data_size) {
-		int len;
-		int bytes = (52 < data_size) ? 52 : data_size;
+		size_t len;
+		size_t bytes = (52 < data_size) ? 52 : data_size;
 		char line[71];
 		data_size -= bytes;
 		if (bytes <= 26)
@@ -3415,7 +3415,7 @@ static void add_formatted_headers(struct strbuf *msg,
 				  const char *meta,
 				  const char *reset)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < more_headers->nr; i++)
 		add_formatted_header(msg, more_headers->items[i].string,
@@ -4702,7 +4702,7 @@ static unsigned int filter_bit['Z' + 1];
 
 static void prepare_filter_bits(void)
 {
-	int i;
+	unsigned int i;
 
 	if (!filter_bit[DIFF_STATUS_ADDED]) {
 		for (i = 0; diff_status_letters[i]; i++)
@@ -4933,7 +4933,8 @@ static int diff_opt_diff_filter(const struct option *option,
 				const char *optarg, int unset)
 {
 	struct diff_options *opt = option->value;
-	int i, optch;
+	size_t i;
+	int optch;
 
 	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
@@ -5287,7 +5288,7 @@ static int diff_opt_patience(const struct option *opt,
 			     const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	int i;
+	size_t i;
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
@@ -6213,12 +6214,12 @@ static void diff_summary(struct diff_options *opt, struct diff_filepair *p)
 
 struct patch_id_t {
 	git_hash_ctx *ctx;
-	int patchlen;
+	size_t patchlen;
 };
 
-static int remove_space(char *line, int len)
+static size_t remove_space(char *line, unsigned long len)
 {
-	int i;
+	unsigned long i;
 	char *dst = line;
 	unsigned char c;
 
@@ -6248,7 +6249,7 @@ void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx)
 static int patch_id_consume(void *priv, char *line, unsigned long len)
 {
 	struct patch_id_t *data = priv;
-	int new_len;
+	size_t new_len;
 
 	if (len > 12 && starts_with(line, "\\ "))
 		return 0;
@@ -6290,7 +6291,7 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 		xdemitconf_t xecfg;
 		mmfile_t mf1, mf2;
 		struct diff_filepair *p = q->queue[i];
-		int len1, len2;
+		size_t len1, len2;
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
diff --git a/dir.c b/dir.c
index 4e99f0c868f..e9fd064a433 100644
--- a/dir.c
+++ b/dir.c
@@ -2988,7 +2988,8 @@ static void emit_traversal_statistics(struct dir_struct *dir,
 }
 
 int read_directory(struct dir_struct *dir, struct index_state *istate,
-		   const char *path, int len, const struct pathspec *pathspec)
+		   const char *path, unsigned int len,
+		   const struct pathspec *pathspec)
 {
 	struct untracked_cache_dir *untracked;
 
diff --git a/dir.h b/dir.h
index 8acfc044181..73cdff47c9e 100644
--- a/dir.h
+++ b/dir.h
@@ -374,7 +374,7 @@ int fill_directory(struct dir_struct *dir,
 		   struct index_state *istate,
 		   const struct pathspec *pathspec);
 int read_directory(struct dir_struct *, struct index_state *istate,
-		   const char *path, int len,
+		   const char *path, unsigned int len,
 		   const struct pathspec *pathspec);
 
 enum pattern_match_result {
diff --git a/fetch-pack.c b/fetch-pack.c
index 04016d1e325..83a92df7055 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1324,7 +1324,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	if (advertise_sid && server_supports_v2("session-id"))
 		packet_buf_write(req_buf, "session-id=%s", trace2_session_id());
 	if (server_options && server_options->nr) {
-		int i;
+		size_t i;
 		ensure_server_supports_v2("server-option");
 		for (i = 0; i < server_options->nr; i++)
 			packet_buf_write(req_buf, "server-option=%s",
@@ -1332,7 +1332,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		unsigned hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);
diff --git a/fsck.c b/fsck.c
index 2b18717ee80..ce0efac3b27 100644
--- a/fsck.c
+++ b/fsck.c
@@ -36,7 +36,7 @@ static struct {
 
 static void prepare_msg_ids(void)
 {
-	int i;
+	size_t i;
 
 	if (msg_id_info[0].downcased)
 		return;
@@ -44,7 +44,7 @@ static void prepare_msg_ids(void)
 	/* convert id_string to lower case, without underscores. */
 	for (i = 0; i < FSCK_MSG_MAX; i++) {
 		const char *p = msg_id_info[i].id_string;
-		int len = strlen(p);
+		size_t len = strlen(p);
 		char *q = xmalloc(len);
 
 		msg_id_info[i].downcased = q;
diff --git a/git.c b/git.c
index 6171fd6769d..f227d083c66 100644
--- a/git.c
+++ b/git.c
@@ -42,7 +42,7 @@ static void list_builtins(struct string_list *list, unsigned int exclude_option)
 
 static void exclude_helpers_from_list(struct string_list *list)
 {
-	int i = 0;
+	size_t i = 0;
 
 	while (i < list->nr) {
 		if (strstr(list->items[i].string, "--"))
diff --git a/hash.h b/hash.h
index 36b64165fc9..8e72b5a5930 100644
--- a/hash.h
+++ b/hash.h
@@ -186,13 +186,13 @@ extern const struct git_hash_algo hash_algos[GIT_HASH_NALGOS];
  * Return a GIT_HASH_* constant based on the name.  Returns GIT_HASH_UNKNOWN if
  * the name doesn't match a known algorithm.
  */
-int hash_algo_by_name(const char *name);
+unsigned hash_algo_by_name(const char *name);
 /* Identical, except based on the format ID. */
-int hash_algo_by_id(uint32_t format_id);
+unsigned hash_algo_by_id(uint32_t format_id);
 /* Identical, except based on the length. */
-int hash_algo_by_length(int len);
+unsigned hash_algo_by_length(size_t len);
 /* Identical, except for a pointer to struct git_hash_algo. */
-static inline int hash_algo_by_ptr(const struct git_hash_algo *p)
+static inline unsigned hash_algo_by_ptr(const struct git_hash_algo *p)
 {
 	return p - hash_algos;
 }
diff --git a/help.c b/help.c
index 812af4cdea6..90e2d41d514 100644
--- a/help.c
+++ b/help.c
@@ -92,7 +92,7 @@ static void extract_cmds(struct cmdname_help **p_cmds, uint32_t mask)
 static void print_command_list(const struct cmdname_help *cmds,
 			       uint32_t mask, int longest)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; cmds[i].name; i++) {
 		if (cmds[i].category & mask) {
@@ -380,7 +380,7 @@ void list_all_other_cmds(struct string_list *list)
 void list_cmds_by_category(struct string_list *list,
 			   const char *cat)
 {
-	int i, n = ARRAY_SIZE(command_list);
+	size_t i, n = ARRAY_SIZE(command_list);
 	uint32_t cat_id = 0;
 
 	for (i = 0; category_names[i]; i++) {
@@ -470,7 +470,7 @@ static int get_alias(const char *var, const char *value, void *data)
 static void list_all_cmds_help_external_commands(void)
 {
 	struct string_list others = STRING_LIST_INIT_DUP;
-	int i;
+	size_t i;
 
 	list_all_other_cmds(&others);
 	if (others.nr)
@@ -484,7 +484,7 @@ static void list_all_cmds_help_aliases(int longest)
 {
 	struct string_list alias_list = STRING_LIST_INIT_DUP;
 	struct cmdname_help *aliases;
-	int i;
+	size_t i;
 
 	git_config(get_alias, &alias_list);
 	string_list_sort(&alias_list);
@@ -810,7 +810,7 @@ static struct string_list guess_refs(const char *ref)
 NORETURN void help_unknown_ref(const char *ref, const char *cmd,
 			       const char *error)
 {
-	int i;
+	size_t i;
 	struct string_list suggested_refs = guess_refs(ref);
 
 	fprintf_ln(stderr, _("%s: %s - %s"), cmd, ref, error);
diff --git a/help.h b/help.h
index af073a7a026..3a7940b32a0 100644
--- a/help.h
+++ b/help.h
@@ -58,7 +58,7 @@ static inline void list_config_item(struct string_list *list,
 #define define_list_config_array(array)					\
 void list_config_##array(struct string_list *list, const char *prefix)	\
 {									\
-	int i;								\
+	size_t i;								\
 	for (i = 0; i < ARRAY_SIZE(array); i++)				\
 		if (array[i])						\
 			list_config_item(list, prefix, array[i]);	\
@@ -68,7 +68,7 @@ struct string_list
 #define define_list_config_array_extra(array, values)			\
 void list_config_##array(struct string_list *list, const char *prefix)	\
 {									\
-	int i;								\
+	size_t i;								\
 	static const char *extra[] = values;				\
 	for (i = 0; i < ARRAY_SIZE(extra); i++)				\
 		list_config_item(list, prefix, extra[i]);		\
diff --git a/hex.c b/hex.c
index 4f64d346963..9337f4572e4 100644
--- a/hex.c
+++ b/hex.c
@@ -50,7 +50,7 @@ int hex_to_bytes(unsigned char *binary, const char *hex, size_t len)
 static int get_hash_hex_algop(const char *hex, unsigned char *hash,
 			      const struct git_hash_algo *algop)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < algop->rawsz; i++) {
 		int val = hex2chr(hex);
 		if (val < 0)
@@ -122,7 +122,7 @@ char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash,
 {
 	static const char hex[] = "0123456789abcdef";
 	char *buf = buffer;
-	int i;
+	size_t i;
 
 	/*
 	 * Our struct object_id has been memset to 0, so default to printing
diff --git a/http-backend.c b/http-backend.c
index 8ab58e55f85..1a4e9eb632d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -255,7 +255,7 @@ static struct rpc_service *select_service(struct strbuf *hdr, const char *name)
 {
 	const char *svc_name;
 	struct rpc_service *svc = NULL;
-	int i;
+	size_t i;
 
 	if (!skip_prefix(name, "git-", &svc_name))
 		forbidden(hdr, "Unsupported service: '%s'", name);
@@ -743,7 +743,7 @@ int cmd_main(int argc, const char **argv)
 	char *dir;
 	struct service_cmd *cmd = NULL;
 	char *cmd_arg = NULL;
-	int i;
+	size_t i;
 	struct strbuf hdr = STRBUF_INIT;
 
 	set_die_routine(die_webcgi);
diff --git a/http-push.c b/http-push.c
index 7f71316456c..a5d460bdf18 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1325,7 +1325,7 @@ static struct object_list **process_tree(struct tree *tree,
 
 static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 {
-	int i;
+	unsigned int i;
 	struct commit *commit;
 	struct object_list **p = &objects;
 	int count = 0;
@@ -1580,8 +1580,8 @@ static int delete_remote_branch(const char *pattern, int force)
 	struct object_id head_oid;
 	char *symref = NULL;
 	int match;
-	int patlen = strlen(pattern);
-	int i;
+	size_t patlen = strlen(pattern);
+	size_t i;
 	struct active_request_slot *slot;
 	struct slot_results results;
 	char *url;
@@ -1589,7 +1589,7 @@ static int delete_remote_branch(const char *pattern, int force)
 	/* Find the remote branch(es) matching the specified branch name */
 	for (match = 0; refs; refs = refs->next) {
 		char *name = refs->name;
-		int namelen = strlen(name);
+		size_t namelen = strlen(name);
 		if (namelen < patlen ||
 		    memcmp(name + namelen - patlen, pattern, patlen))
 			continue;
diff --git a/http-walker.c b/http-walker.c
index b8f0f98ae14..e42fe8d6be0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -170,7 +170,7 @@ static int is_alternate_allowed(const char *url)
 	const char *protocols[] = {
 		"http", "https", "ftp", "ftps"
 	};
-	int i;
+	size_t i;
 
 	if (http_follow_config != HTTP_FOLLOW_ALWAYS) {
 		warning("alternate disabled by http.followRedirects: %s", url);
@@ -207,7 +207,7 @@ static void process_alternates_response(void *callback_data)
 	const char *base = alt_req->base;
 	const char null_byte = '\0';
 	char *data;
-	int i = 0;
+	size_t i = 0;
 
 	normalize_curl_result(&slot->curl_result, slot->http_code,
 			      curl_errorstr, sizeof(curl_errorstr));
@@ -247,12 +247,12 @@ static void process_alternates_response(void *callback_data)
 	data = alt_req->buffer->buf;
 
 	while (i < alt_req->buffer->len) {
-		int posn = i;
+		size_t posn = i;
 		while (posn < alt_req->buffer->len && data[posn] != '\n')
 			posn++;
 		if (data[posn] == '\n') {
 			int okay = 0;
-			int serverlen = 0;
+			size_t serverlen = 0;
 			struct alt_base *newalt;
 			if (data[i] == '/') {
 				/*
diff --git a/http.c b/http.c
index c4b6ddef287..671af68fff4 100644
--- a/http.c
+++ b/http.c
@@ -481,7 +481,7 @@ static void init_curl_proxy_auth(CURL *result)
 	var_override(&http_proxy_authmethod, getenv("GIT_HTTP_PROXY_AUTHMETHOD"));
 
 	if (http_proxy_authmethod) {
-		int i;
+		size_t i;
 		for (i = 0; i < ARRAY_SIZE(proxy_authmethods); i++) {
 			if (!strcmp(http_proxy_authmethod, proxy_authmethods[i].name)) {
 				curl_easy_setopt(result, CURLOPT_PROXYAUTH,
@@ -800,7 +800,7 @@ static long get_curl_allowed_protocols(int from_user, struct strbuf *list)
 #ifdef GIT_CURL_HAVE_CURL_HTTP_VERSION_2
 static int get_curl_http_version_opt(const char *version_string, long *opt)
 {
-	int i;
+	size_t i;
 	static struct {
 		const char *name;
 		long opt_token;
@@ -854,7 +854,7 @@ static CURL *get_curl_handle(void)
 
 #ifdef CURLGSSAPI_DELEGATION_FLAG
 	if (curl_deleg) {
-		int i;
+		size_t i;
 		for (i = 0; i < ARRAY_SIZE(curl_deleg_levels); i++) {
 			if (!strcmp(curl_deleg, curl_deleg_levels[i].name)) {
 				curl_easy_setopt(result, CURLOPT_GSSAPI_DELEGATION,
@@ -883,7 +883,7 @@ static CURL *get_curl_handle(void)
 	if (getenv("GIT_SSL_VERSION"))
 		ssl_version = getenv("GIT_SSL_VERSION");
 	if (ssl_version && *ssl_version) {
-		int i;
+		size_t i;
 		for (i = 0; i < ARRAY_SIZE(sslversions); i++) {
 			if (!strcmp(ssl_version, sslversions[i].name)) {
 				curl_easy_setopt(result, CURLOPT_SSLVERSION,
@@ -1089,7 +1089,7 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	if (http_ssl_backend) {
 		const curl_ssl_backend **backends;
 		struct strbuf buf = STRBUF_INIT;
-		int i;
+		size_t i;
 
 		switch (curl_global_sslset(-1, http_ssl_backend, &backends)) {
 		case CURLSSLSET_UNKNOWN_BACKEND:
@@ -1754,9 +1754,9 @@ static void write_accept_language(struct strbuf *buf)
 	const int MAX_LANGUAGE_TAGS = 1000;
 	const int MAX_ACCEPT_LANGUAGE_HEADER_SIZE = 4000;
 	char **language_tags = NULL;
-	int num_langs = 0;
+	unsigned int num_langs = 0;
 	const char *s = get_preferred_languages();
-	int i;
+	unsigned int i;
 	struct strbuf tag = STRBUF_INIT;
 
 	/* Don't add Accept-Language header if no language is preferred. */
@@ -1802,7 +1802,7 @@ static void write_accept_language(struct strbuf *buf)
 		     decimal_places++, max_q *= 10)
 			;
 
-		xsnprintf(q_format, sizeof(q_format), ";q=0.%%0%dd", decimal_places);
+		xsnprintf(q_format, sizeof(q_format), ";q=0.%%0%ud", decimal_places);
 
 		strbuf_addstr(buf, "Accept-Language: ");
 
diff --git a/line-log.c b/line-log.c
index a7f3e7f6ce4..7a87eb27ef7 100644
--- a/line-log.c
+++ b/line-log.c
@@ -473,8 +473,8 @@ static void range_set_map_across_diff(struct range_set *out,
 static struct commit *check_single_commit(struct rev_info *revs)
 {
 	struct object *commit = NULL;
-	int found = -1;
-	int i;
+	unsigned found = 0;
+	unsigned i;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ee01bcd2cc3..dcb84ee81e9 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -397,7 +397,7 @@ void list_objects_filter_copy(
 	struct list_objects_filter_options *dest,
 	const struct list_objects_filter_options *src)
 {
-	int i;
+	size_t i;
 
 	/* Copy everything. We will overwrite the pointers shortly. */
 	memcpy(dest, src, sizeof(struct list_objects_filter_options));
diff --git a/list-objects.c b/list-objects.c
index 7528fe1db2c..23f1b0963ea 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -267,7 +267,7 @@ void mark_edges_uninteresting(struct rev_info *revs,
 			      int sparse)
 {
 	struct commit_list *list;
-	int i;
+	unsigned int i;
 
 	if (sparse) {
 		struct oidset set;
@@ -326,7 +326,7 @@ static void add_pending_tree(struct rev_info *revs, struct tree *tree)
 static void traverse_non_commits(struct traversal_context *ctx,
 				 struct strbuf *base)
 {
-	int i;
+	unsigned int i;
 
 	assert(base->len == 0);
 
diff --git a/ll-merge.c b/ll-merge.c
index 130d26501c6..4643c8c2f65 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -194,7 +194,8 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	struct strbuf_expand_dict_entry dict[6];
 	struct strbuf path_sq = STRBUF_INIT;
 	struct child_process child = CHILD_PROCESS_INIT;
-	int status, fd, i;
+	int status, fd;
+	unsigned int i;
 	struct stat st;
 	enum ll_merge_result ret;
 	assert(opts);
@@ -329,7 +330,7 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 {
 	struct ll_merge_driver *fn;
 	const char *name;
-	int i;
+	size_t i;
 
 	initialize_ll_merge();
 
diff --git a/lockfile.c b/lockfile.c
index cc9a4b84283..5468a642654 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -14,7 +14,7 @@
  */
 static void trim_last_path_component(struct strbuf *path)
 {
-	int i = path->len;
+	size_t i = path->len;
 
 	/* back up past trailing slashes, if any */
 	while (i && path->buf[i - 1] == '/')
diff --git a/log-tree.c b/log-tree.c
index 1dd5fcbf7be..5db3fcede2c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -138,7 +138,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags UNUSED,
 			      void *cb_data)
 {
-	int i;
+	size_t i;
 	struct object *obj;
 	enum object_type objtype;
 	enum decoration_type deco_type = DECORATION_NONE;
diff --git a/ls-refs.c b/ls-refs.c
index 697d4beb8de..b40f902648f 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -54,7 +54,7 @@ static void ensure_config_read(void)
  */
 static int ref_match(const struct strvec *prefixes, const char *refname)
 {
-	int i;
+	size_t i;
 
 	if (!prefixes->nr)
 		return 1; /* no restriction */
diff --git a/mailinfo.c b/mailinfo.c
index 833d28612f7..963ad2e7794 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -617,7 +617,7 @@ check_header_out:
 static int is_inbody_header(const struct mailinfo *mi,
 			    const struct strbuf *line)
 {
-	int i;
+	size_t i;
 	const char *val;
 	for (i = 0; header[i]; i++)
 		if (!mi->s_hdr_data[i] && skip_header(line, header[i], &val))
@@ -765,7 +765,7 @@ static int check_inbody_header(struct mailinfo *mi, const struct strbuf *line)
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5]))
 		return is_format_patch_separator(line->buf + 1, line->len - 1);
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
-		int i;
+		size_t i;
 		for (i = 0; header[i]; i++)
 			if (!strcmp("Subject", header[i])) {
 				handle_header(&mi->s_hdr_data[i], line);
@@ -809,7 +809,7 @@ static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 		return 0; /* mi->input_error already set */
 
 	if (mi->use_scissors && is_scissors_line(line->buf)) {
-		int i;
+		size_t i;
 
 		strbuf_setlen(&mi->log_message, 0);
 		mi->header_stage = 1;
@@ -1147,7 +1147,7 @@ static void output_header_lines(FILE *fout, const char *hdr, const struct strbuf
 static void handle_info(struct mailinfo *mi)
 {
 	struct strbuf *hdr;
-	int i;
+	size_t i;
 
 	for (i = 0; header[i]; i++) {
 		/* only print inbody headers if we output a patch file */
diff --git a/merge-ort.c b/merge-ort.c
index d1611ca400a..a57dacaa080 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -681,9 +681,9 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		/* Release and free each strbuf found in output */
 		strmap_for_each_entry(&opti->conflicts, &iter, e) {
 			struct string_list *list = e->value;
-			for (int i = 0; i < list->nr; i++) {
+			for (size_t j = 0; j < list->nr; j++) {
 				struct logical_conflict_info *info =
-					list->items[i].util;
+					list->items[j].util;
 				strvec_clear(&info->paths);
 			}
 			/*
@@ -793,7 +793,7 @@ static void path_msg(struct merge_options *opt,
 	if (other_path_2)
 		strvec_push(&info->paths, other_path_2);
 	if (other_paths)
-		for (int i = 0; i < other_paths->nr; i++)
+		for (size_t i = 0; i < other_paths->nr; i++)
 		strvec_push(&info->paths, other_paths->items[i].string);
 
 	/* Handle message and its format, in normal case */
@@ -810,7 +810,7 @@ static void path_msg(struct merge_options *opt,
 
 	/* Handle specialized formatting of message under --remerge-diff */
 	if (opt->record_conflict_msgs_as_headers) {
-		int i_sb = 0, i_tmp = 0;
+		size_t i_sb = 0, i_tmp = 0;
 
 		/* Start with the specified prefix */
 		if (opt->msg_header_prefix)
@@ -1011,7 +1011,7 @@ static void setup_path_info(struct merge_options *opt,
 		oidcpy(&mi->result.oid, &merged_version->oid);
 		mi->is_null = !!is_null;
 	} else {
-		int i;
+		unsigned i;
 		struct conflict_info *ci;
 
 		ASSIGN_AND_VERIFY_CI(ci, mi);
@@ -1380,7 +1380,8 @@ static int collect_merge_info_callback(int n,
 		struct tree_desc t[3];
 		void *buf[3] = {NULL, NULL, NULL};
 		const char *original_dir_name;
-		int i, ret, side;
+		unsigned int i, side;
+		int ret;
 
 		/*
 		 * Check for whether we can avoid recursing due to one side
@@ -1553,12 +1554,12 @@ static int handle_deferred_entries(struct merge_options *opt,
 					    0);
 		strintmap_for_each_entry(&copy, &iter, entry) {
 			const char *path = entry->key;
-			unsigned dir_rename_mask = (intptr_t)entry->value;
+			unsigned dir_rename_mask = (uintptr_t)entry->value;
 			struct conflict_info *ci;
 			unsigned dirmask;
 			struct tree_desc t[3];
 			void *buf[3] = {NULL,};
-			int i;
+			unsigned i;
 
 			ci = strmap_get(&opt->priv->paths, path);
 			VERIFY_CI(ci);
@@ -1683,13 +1684,13 @@ static int collect_merge_info(struct merge_options *opt,
 
 /*** Function Grouping: functions related to threeway content merges ***/
 
-static int find_first_merges(struct repository *repo,
+static unsigned find_first_merges(struct repository *repo,
 			     const char *path,
 			     struct commit *a,
 			     struct commit *b,
 			     struct object_array *result)
 {
-	int i, j;
+	unsigned i, j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
@@ -1757,10 +1758,10 @@ static int merge_submodule(struct merge_options *opt,
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 	struct commit *commit_o, *commit_a, *commit_b;
-	int parent_count;
+	unsigned parent_count;
 	struct object_array merges;
 
-	int i;
+	unsigned i;
 	int search = !opt->priv->call_depth;
 	int sub_not_initialized = 1;
 	int sub_flag = CONFLICT_SUBMODULE_FAILED_TO_MERGE;
@@ -2357,7 +2358,7 @@ static void handle_directory_level_conflicts(struct merge_options *opt)
 	struct rename_info *renames = &opt->priv->renames;
 	struct strmap *side1_dir_renames = &renames->dir_renames[MERGE_SIDE1];
 	struct strmap *side2_dir_renames = &renames->dir_renames[MERGE_SIDE2];
-	int i;
+	size_t i;
 
 	strmap_for_each_entry(side1_dir_renames, &iter, entry) {
 		if (strmap_contains(side2_dir_renames, entry->key))
@@ -3339,8 +3340,9 @@ static int detect_and_process_renames(struct merge_options *opt,
 	struct diff_queue_struct combined = { 0 };
 	struct rename_info *renames = &opt->priv->renames;
 	struct strmap collisions[3];
-	int need_dir_renames, s, i, clean = 1;
-	unsigned detection_run = 0;
+	int need_dir_renames, s, clean = 1;
+	unsigned i;
+	int detection_run = 0;
 
 	if (!possible_renames(renames))
 		goto cleanup;
@@ -3353,13 +3355,13 @@ static int detect_and_process_renames(struct merge_options *opt,
 		renames->redo_after_renames = 0;
 	}
 	if (renames->redo_after_renames && detection_run) {
-		int i, side;
+		int side;
 		struct diff_filepair *p;
 
 		/* Cache the renames, we found */
 		for (side = MERGE_SIDE1; side <= MERGE_SIDE2; side++) {
-			for (i = 0; i < renames->pairs[side].nr; ++i) {
-				p = renames->pairs[side].queue[i];
+			for (s = 0; s < renames->pairs[side].nr; ++s) {
+				p = renames->pairs[side].queue[s];
 				possibly_cache_new_pair(renames, p, side, NULL);
 			}
 		}
@@ -3389,7 +3391,7 @@ static int detect_and_process_renames(struct merge_options *opt,
 		   renames->pairs[1].nr + renames->pairs[2].nr,
 		   combined.alloc);
 	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
-		int other_side = 3 - i;
+		unsigned other_side = 3 - i;
 		compute_collisions(&collisions[i],
 				   &renames->dir_renames[other_side],
 				   &renames->pairs[i]);
@@ -3418,25 +3420,24 @@ cleanup:
 	 * Free now unneeded filepairs, which would have been handled
 	 * in collect_renames() normally but we skipped that code.
 	 */
-	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
 		struct diff_queue_struct *side_pairs;
-		int i;
 
-		side_pairs = &renames->pairs[s];
-		for (i = 0; i < side_pairs->nr; ++i) {
-			struct diff_filepair *p = side_pairs->queue[i];
+		side_pairs = &renames->pairs[i];
+		for (s = 0; s < side_pairs->nr; ++s) {
+			struct diff_filepair *p = side_pairs->queue[s];
 			pool_diff_free_filepair(&opt->priv->pool, p);
 		}
 	}
 
 simple_cleanup:
 	/* Free memory for renames->pairs[] and combined */
-	for (s = MERGE_SIDE1; s <= MERGE_SIDE2; s++) {
-		free(renames->pairs[s].queue);
-		DIFF_QUEUE_CLEAR(&renames->pairs[s]);
+	for (i = MERGE_SIDE1; i <= MERGE_SIDE2; i++) {
+		free(renames->pairs[i].queue);
+		DIFF_QUEUE_CLEAR(&renames->pairs[i]);
 	}
-	for (i = 0; i < combined.nr; i++)
-		pool_diff_free_filepair(&opt->priv->pool, combined.queue[i]);
+	for (s = 0; i < combined.nr; s++)
+		pool_diff_free_filepair(&opt->priv->pool, combined.queue[s]);
 	free(combined.queue);
 
 	return clean;
@@ -3609,13 +3610,14 @@ static int tree_entry_order(const void *a_, const void *b_)
 
 static int write_tree(struct object_id *result_oid,
 		      struct string_list *versions,
-		      unsigned int offset,
+		      size_t offset,
 		      size_t hash_size)
 {
 	size_t maxlen = 0, extra;
-	unsigned int nr;
+	size_t nr;
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	size_t i;
+	int ret = 0;
 
 	assert(offset <= versions->nr);
 	nr = versions->nr - offset;
@@ -3669,7 +3671,8 @@ static int write_completed_directory(struct merge_options *opt,
 {
 	const char *prev_dir;
 	struct merged_info *dir_info = NULL;
-	unsigned int offset, ret = 0;
+	size_t offset;
+	int ret = 0;
 
 	/*
 	 * Some explanation of info->versions and info->offsets...
@@ -3766,7 +3769,7 @@ static int write_completed_directory(struct merge_options *opt,
 	if (info->last_directory == NULL ||
 	    !strncmp(new_directory_name, info->last_directory,
 		     info->last_directory_len)) {
-		uintptr_t offset = info->versions.nr;
+		offset = (uintptr_t)info->versions.nr;
 
 		info->last_directory = new_directory_name;
 		info->last_directory_len = strlen(info->last_directory);
@@ -3864,7 +3867,7 @@ static int process_entry(struct merge_options *opt,
 	}
 
 	if (ci->df_conflict && ci->merged.result.mode == 0) {
-		int i;
+		unsigned i;
 
 		/*
 		 * directory no longer in the way, but we do have a file we
@@ -3894,7 +3897,7 @@ static int process_entry(struct merge_options *opt,
 		struct conflict_info *new_ci;
 		const char *branch;
 		const char *old_path = path;
-		int i;
+		unsigned i;
 
 		assert(ci->merged.result.mode == S_IFDIR);
 
@@ -3977,7 +3980,7 @@ static int process_entry(struct merge_options *opt,
 		} else {
 			/* determine the mask of the side that didn't match */
 			unsigned int othermask = 7 & ~ci->match_mask;
-			int side = (othermask == 4) ? 2 : 1;
+			unsigned int side = (othermask == 4) ? 2 : 1;
 
 			ci->merged.result.mode = ci->stages[side].mode;
 			ci->merged.is_null = !ci->merged.result.mode;
@@ -4137,8 +4140,8 @@ static int process_entry(struct merge_options *opt,
 	} else if (ci->filemask == 3 || ci->filemask == 5) {
 		/* Modify/delete */
 		const char *modify_branch, *delete_branch;
-		int side = (ci->filemask == 5) ? 2 : 1;
-		int index = opt->priv->call_depth ? 0 : side;
+		unsigned side = (ci->filemask == 5) ? 2 : 1;
+		unsigned index = opt->priv->call_depth ? 0 : side;
 
 		ci->merged.result.mode = ci->stages[index].mode;
 		oidcpy(&ci->merged.result.oid, &ci->stages[index].oid);
@@ -4184,7 +4187,7 @@ static int process_entry(struct merge_options *opt,
 		}
 	} else if (ci->filemask == 2 || ci->filemask == 4) {
 		/* Added on one side */
-		int side = (ci->filemask == 4) ? 2 : 1;
+		unsigned side = (ci->filemask == 4) ? 2 : 1;
 		ci->merged.result.mode = ci->stages[side].mode;
 		oidcpy(&ci->merged.result.oid, &ci->stages[side].oid);
 		ci->merged.clean = !ci->df_conflict && !ci->path_conflict;
@@ -4222,7 +4225,7 @@ static void prefetch_for_content_merges(struct merge_options *opt,
 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
 		/* char *path = e->string; */
 		struct conflict_info *ci = e->util;
-		int i;
+		unsigned i;
 
 		/* Ignore clean entries */
 		if (ci->merged.clean)
@@ -4600,16 +4603,16 @@ void merge_display_update_messages(struct merge_options *opt,
 	string_list_sort(&olist);
 
 	/* Iterate over the items, printing them */
-	for (int path_nr = 0; path_nr < olist.nr; ++path_nr) {
+	for (size_t path_nr = 0; path_nr < olist.nr; ++path_nr) {
 		struct string_list *conflicts = olist.items[path_nr].util;
-		for (int i = 0; i < conflicts->nr; i++) {
+		for (size_t i = 0; i < conflicts->nr; i++) {
 			struct logical_conflict_info *info =
 				conflicts->items[i].util;
 
 			if (detailed) {
 				printf("%lu", (unsigned long)info->paths.nr);
 				putchar('\0');
-				for (int n = 0; n < info->paths.nr; n++) {
+				for (size_t n = 0; n < info->paths.nr; n++) {
 					fputs(info->paths.v[n], stdout);
 					putchar('\0');
 				}
@@ -4764,7 +4767,7 @@ static struct commit *make_virtual_commit(struct repository *repo,
 static void merge_start(struct merge_options *opt, struct merge_result *result)
 {
 	struct rename_info *renames;
-	int i;
+	unsigned i;
 	struct mem_pool *pool = NULL;
 
 	/* Sanity checks on opt */
diff --git a/merge-recursive.c b/merge-recursive.c
index ae469f8cc81..bafa986fc60 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -523,7 +523,7 @@ static struct stage_data *insert_stage_data(struct repository *r,
 static struct string_list *get_unmerged(struct index_state *istate)
 {
 	struct string_list *unmerged = xmalloc(sizeof(struct string_list));
-	int i;
+	unsigned i;
 
 	string_list_init_dup(unmerged);
 
@@ -594,8 +594,8 @@ static void record_df_conflict_files(struct merge_options *opt,
 	 */
 	struct string_list df_sorted_entries = STRING_LIST_INIT_NODUP;
 	const char *last_file = NULL;
-	int last_len = 0;
-	int i;
+	size_t last_len = 0;
+	size_t i;
 
 	/*
 	 * If we're merging merge-bases, we don't want to bother with
@@ -616,7 +616,7 @@ static void record_df_conflict_files(struct merge_options *opt,
 	string_list_clear(&opt->priv->df_conflict_file_set, 1);
 	for (i = 0; i < df_sorted_entries.nr; i++) {
 		const char *path = df_sorted_entries.items[i].string;
-		int len = strlen(path);
+		size_t len = strlen(path);
 		struct stage_data *e = df_sorted_entries.items[i].util;
 
 		/*
@@ -877,7 +877,8 @@ static int was_dirty(struct merge_options *opt, const char *path)
 
 static int make_room_for_path(struct merge_options *opt, const char *path)
 {
-	int status, i;
+	int status;
+	size_t i;
 	const char *msg = _("failed to create path '%s'%s");
 
 	/* Unlink any D/F conflict files that are in the way */
@@ -1103,11 +1104,11 @@ static int merge_3way(struct merge_options *opt,
 	return merge_status;
 }
 
-static int find_first_merges(struct repository *repo,
+static unsigned find_first_merges(struct repository *repo,
 			     struct object_array *result, const char *path,
 			     struct commit *a, struct commit *b)
 {
-	int i, j;
+	unsigned i, j;
 	struct object_array merges = OBJECT_ARRAY_INIT;
 	struct commit *commit;
 	int contains_another;
@@ -1189,10 +1190,10 @@ static int merge_submodule(struct merge_options *opt,
 	struct repository subrepo;
 	int ret = 0;
 	struct commit *commit_base, *commit_a, *commit_b;
-	int parent_count;
+	unsigned parent_count;
 	struct object_array merges;
 
-	int i;
+	unsigned i;
 	int search = !opt->priv->call_depth;
 
 	/* store a in result in case we fail */
@@ -2065,7 +2066,7 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
 static void remove_hashmap_entries(struct hashmap *dir_renames,
 				   struct string_list *items_to_remove)
 {
-	int i;
+	size_t i;
 	struct dir_rename_entry *entry;
 
 	for (i = 0; i < items_to_remove->nr; i++) {
@@ -2995,7 +2996,7 @@ cleanup:
 static void final_cleanup_rename(struct string_list *rename)
 {
 	const struct rename *re;
-	int i;
+	size_t i;
 
 	if (!rename)
 		return;
@@ -3805,7 +3806,7 @@ static struct commit *get_ref(struct repository *repo,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result)
 {
@@ -3816,7 +3817,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	struct commit_list *ca = NULL;
 
 	if (merge_bases) {
-		int i;
+		unsigned int i;
 		for (i = 0; i < num_merge_bases; ++i) {
 			struct commit *base;
 			if (!(base = get_ref(opt->repo, merge_bases[i],
diff --git a/merge-recursive.h b/merge-recursive.h
index b88000e3c25..f8d7517dc50 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -118,7 +118,7 @@ int merge_recursive(struct merge_options *opt,
 int merge_recursive_generic(struct merge_options *opt,
 			    const struct object_id *head,
 			    const struct object_id *merge,
-			    int num_merge_bases,
+			    unsigned int num_merge_bases,
 			    const struct object_id **merge_bases,
 			    struct commit **result);
 
diff --git a/merge.c b/merge.c
index 445b4f19aa8..7755ed9b4b5 100644
--- a/merge.c
+++ b/merge.c
@@ -20,7 +20,8 @@ int try_merge_command(struct repository *r,
 		      const char *head_arg, struct commit_list *remotes)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i, ret;
+	size_t i;
+	int ret;
 	struct commit_list *j;
 
 	strvec_pushf(&cmd.args, "merge-%s", strategy);
@@ -52,7 +53,7 @@ int checkout_fast_forward(struct repository *r,
 	struct tree *trees[MAX_UNPACK_TREES];
 	struct unpack_trees_options opts;
 	struct tree_desc t[MAX_UNPACK_TREES];
-	int i, nr_trees = 0;
+	unsigned int i, nr_trees = 0;
 	struct lock_file lock_file = LOCK_INIT;
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
diff --git a/mergesort.h b/mergesort.h
index 7c36f08bd5f..123e4cf3036 100644
--- a/mergesort.h
+++ b/mergesort.h
@@ -54,7 +54,7 @@ scope void name(type **listp,						\
 		return;							\
 									\
 	for (;;) {							\
-		int i;							\
+		size_t i;							\
 		size_t m;						\
 		type *next = name##__get_next(list);			\
 		if (next)						\
diff --git a/name-hash.c b/name-hash.c
index cd009c7c8ae..ec5f12f9d4c 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -13,7 +13,7 @@
 struct dir_entry {
 	struct hashmap_entry ent;
 	struct dir_entry *parent;
-	int nr;
+	unsigned int nr;
 	unsigned int namelen;
 	char name[FLEX_ARRAY];
 };
@@ -477,7 +477,7 @@ struct lazy_name_thread_data {
 static void *lazy_name_thread_proc(void *_data)
 {
 	struct lazy_name_thread_data *d = _data;
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
@@ -493,7 +493,7 @@ static inline void lazy_update_dir_ref_counts(
 	struct index_state *istate,
 	struct lazy_entry *lazy_entries)
 {
-	int k;
+	unsigned int k;
 
 	for (k = 0; k < istate->cache_nr; k++) {
 		if (lazy_entries[k].dir)
diff --git a/notes-utils.c b/notes-utils.c
index d7d18e30f5a..479c180904f 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -166,7 +166,7 @@ int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
 			  const struct object_id *from_obj, const struct object_id *to_obj)
 {
 	int ret = 0;
-	int i;
+	size_t i;
 	for (i = 0; c->trees[i]; i++)
 		ret = copy_note(c->trees[i], from_obj, to_obj, 1, c->combine) || ret;
 	return ret;
@@ -176,7 +176,7 @@ void finish_copy_notes_for_rewrite(struct repository *r,
 				   struct notes_rewrite_cfg *c,
 				   const char *msg)
 {
-	int i;
+	size_t i;
 	for (i = 0; c->trees[i]; i++) {
 		commit_notes(r, c->trees[i], msg);
 		free_notes(c->trees[i]);
diff --git a/notes.c b/notes.c
index f2805d51bb1..47a6529b9fc 100644
--- a/notes.c
+++ b/notes.c
@@ -956,7 +956,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 {
 	struct string_list split = STRING_LIST_INIT_NODUP;
 	char *globs_copy = xstrdup(globs);
-	int i;
+	size_t i;
 
 	string_list_split_in_place(&split, globs_copy, ':', -1);
 	string_list_remove_empty_items(&split, 0);
@@ -1309,7 +1309,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 void format_display_notes(const struct object_id *object_oid,
 			  struct strbuf *sb, const char *output_encoding, int raw)
 {
-	int i;
+	size_t i;
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
 		format_note(display_notes_trees[i], object_oid, sb,
diff --git a/object-file.c b/object-file.c
index 939865c1ae0..36ff98b611f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -236,9 +236,9 @@ const char *empty_blob_oid_hex(void)
 	return oid_to_hex_r(buf, the_hash_algo->empty_blob);
 }
 
-int hash_algo_by_name(const char *name)
+unsigned hash_algo_by_name(const char *name)
 {
-	int i;
+	unsigned i;
 	if (!name)
 		return GIT_HASH_UNKNOWN;
 	for (i = 1; i < GIT_HASH_NALGOS; i++)
@@ -247,18 +247,18 @@ int hash_algo_by_name(const char *name)
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_id(uint32_t format_id)
+unsigned hash_algo_by_id(uint32_t format_id)
 {
-	int i;
+	unsigned i;
 	for (i = 1; i < GIT_HASH_NALGOS; i++)
 		if (format_id == hash_algos[i].format_id)
 			return i;
 	return GIT_HASH_UNKNOWN;
 }
 
-int hash_algo_by_length(int len)
+unsigned hash_algo_by_length(size_t len)
 {
-	int i;
+	unsigned i;
 	for (i = 1; i < GIT_HASH_NALGOS; i++)
 		if (len == hash_algos[i].rawsz)
 			return i;
diff --git a/object-name.c b/object-name.c
index 2dd1a0f56e1..7aa105f69b4 100644
--- a/object-name.c
+++ b/object-name.c
@@ -758,8 +758,8 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
-int repo_find_unique_abbrev_r(struct repository *r, char *hex,
-			      const struct object_id *oid, int len)
+unsigned int repo_find_unique_abbrev_r(struct repository *r, char *hex,
+				       const struct object_id *oid, int len)
 {
 	struct disambiguate_state ds;
 	struct min_abbrev_data mad;
@@ -818,7 +818,7 @@ const char *repo_find_unique_abbrev(struct repository *r,
 				    const struct object_id *oid,
 				    int len)
 {
-	static int bufno;
+	static unsigned int bufno;
 	static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
 	char *hex = hexbuffer[bufno];
 	bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
diff --git a/path.c b/path.c
index 492e17ad121..0868be56610 100644
--- a/path.c
+++ b/path.c
@@ -801,8 +801,8 @@ const char *enter_repo(const char *path, int strict)
 			"/.git", "", ".git/.git", ".git", NULL,
 		};
 		const char *gitfile;
-		int len = strlen(path);
-		int i;
+		size_t len = strlen(path);
+		size_t i;
 		while ((1 < len) && (path[len-1] == '/'))
 			len--;
 
diff --git a/pathspec.c b/pathspec.c
index ab70fcbe613..2256b57c655 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -67,7 +67,7 @@ char *find_pathspecs_matching_skip_worktree(const struct pathspec *pathspec)
 {
 	struct index_state *istate = the_repository->index;
 	char *seen = xcalloc(pathspec->nr, 1);
-	int i;
+	unsigned i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -103,7 +103,7 @@ static struct pathspec_magic {
 
 static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
 {
-	int i;
+	size_t i;
 	strbuf_addstr(sb, ":(");
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
 		if (magic & pathspec_magic[i].bit) {
@@ -309,7 +309,7 @@ static const char *parse_long_magic(unsigned *magic, int *prefix_len,
 
 	for (pos = elem + 2; *pos && *pos != ')'; pos = nextat) {
 		size_t len = strcspn_escaped(pos, ",)");
-		int i;
+		size_t i;
 
 		if (pos[len] == ',')
 			nextat = pos + len + 1; /* handle ',' */
@@ -368,7 +368,7 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 
 	for (pos = elem + 1; *pos && *pos != ':'; pos++) {
 		char ch = *pos;
-		int i;
+		size_t i;
 
 		/* Special case alias for '!' */
 		if (ch == '^') {
@@ -529,7 +529,7 @@ static void NORETURN unsupported_magic(const char *pattern,
 				       unsigned magic)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int i;
+	size_t i;
 	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
 		const struct pathspec_magic *m = pathspec_magic + i;
 		if (!(magic & m->bit))
@@ -558,7 +558,8 @@ void parse_pathspec(struct pathspec *pathspec,
 {
 	struct pathspec_item *item;
 	const char *entry = argv ? *argv : NULL;
-	int i, n, prefixlen, nr_exclude = 0;
+	size_t i, n;
+	int prefixlen, nr_exclude = 0;
 
 	memset(pathspec, 0, sizeof(*pathspec));
 
@@ -678,7 +679,7 @@ void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
 
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
-	int i, j;
+	size_t i, j;
 
 	*dst = *src;
 	DUP_ARRAY(dst->items, src->items, dst->nr);
@@ -702,7 +703,7 @@ void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 
 void clear_pathspec(struct pathspec *pathspec)
 {
-	int i, j;
+	size_t i, j;
 
 	for (i = 0; i < pathspec->nr; i++) {
 		free(pathspec->items[i].match);
@@ -724,7 +725,7 @@ int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item)
 {
-	int i;
+	size_t i;
 	char *to_free = NULL;
 
 	if (name[namelen])
@@ -761,7 +762,8 @@ int match_pathspec_attrs(struct index_state *istate,
 int pathspec_needs_expanded_index(struct index_state *istate,
 				  const struct pathspec *pathspec)
 {
-	unsigned int i, pos;
+	size_t i;
+	unsigned int pos;
 	int res = 0;
 	char *skip_worktree_seen = NULL;
 
diff --git a/pathspec.h b/pathspec.h
index 41f6adfbb42..e466f56981f 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -28,7 +28,7 @@ struct index_state;
  * prepared by parse_pathspec().
  */
 struct pathspec {
-	int nr;
+	size_t nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
 	unsigned int recurse_submodules:1;
@@ -41,7 +41,7 @@ struct pathspec {
 		int len, prefix;
 		int nowildcard_len;
 		int flags;
-		int attr_match_nr;
+		size_t attr_match_nr;
 		struct attr_match {
 			char *value;
 			enum attr_match_mode {
diff --git a/pkt-line.c b/pkt-line.c
index ce4e73b6833..06cb8ff4fc1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -33,7 +33,7 @@ static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
 
 static void packet_trace(const char *buf, unsigned int len, int write)
 {
-	int i;
+	unsigned i;
 	struct strbuf out;
 	static int in_pack, sideband;
 
diff --git a/pretty.c b/pretty.c
index 1e1e21878c8..8debf6ef2a6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -56,7 +56,7 @@ static int git_pretty_formats_config(const char *var, const char *value,
 	struct cmt_fmt_map *commit_format = NULL;
 	const char *name;
 	const char *fmt;
-	int i;
+	size_t i;
 
 	if (!skip_prefix(var, "pretty.", &name))
 		return 0;
@@ -130,7 +130,7 @@ static struct cmt_fmt_map *find_commit_format_recursive(const char *sought,
 {
 	struct cmt_fmt_map *found = NULL;
 	size_t found_match_len = 0;
-	int i;
+	size_t i;
 
 	if (num_redirections >= commit_formats_len)
 		die("invalid --pretty format: "
@@ -259,9 +259,9 @@ static int is_rfc822_special(char ch)
 	}
 }
 
-static int needs_rfc822_quoting(const char *s, int len)
+static int needs_rfc822_quoting(const char *s, size_t len)
 {
-	int i;
+	size_t i;
 	for (i = 0; i < len; i++)
 		if (is_rfc822_special(s[i]))
 			return 1;
@@ -279,9 +279,9 @@ static int last_line_length(struct strbuf *sb)
 	return sb->len - (i + 1);
 }
 
-static void add_rfc822_quoted(struct strbuf *out, const char *s, int len)
+static void add_rfc822_quoted(struct strbuf *out, const char *s, size_t len)
 {
-	int i;
+	size_t i;
 
 	/* just a guess, we may have to also backslash-quote */
 	strbuf_grow(out, len + 2);
@@ -357,9 +357,9 @@ static int is_rfc2047_special(char ch, enum rfc2047_type type)
 	return !(isalnum(ch) || ch == '!' || ch == '*' || ch == '+' || ch == '-' || ch == '/');
 }
 
-static int needs_rfc2047_encoding(const char *line, int len)
+static int needs_rfc2047_encoding(const char *line, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++) {
 		int ch = line[i];
@@ -896,11 +896,11 @@ struct format_commit_context {
 static void parse_commit_header(struct format_commit_context *context)
 {
 	const char *msg = context->message;
-	int i;
+	size_t i;
 
 	for (i = 0; msg[i]; i++) {
 		const char *name;
-		int eol;
+		size_t eol;
 		for (eol = i; msg[eol] && msg[eol] != '\n'; eol++)
 			; /* do nothing */
 
@@ -930,7 +930,7 @@ void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
 	size_t trimlen;
 	size_t start_len = sb->len;
 	int space = 2;
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++) {
 		if (istitlechar(msg[i])) {
@@ -1324,7 +1324,7 @@ static size_t parse_describe_args(const char *start, struct strvec *args)
 		const char *argval;
 		size_t arglen = 0;
 		int optval = 0;
-		int i;
+		size_t i;
 
 		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
 			switch (option[i].type) {
@@ -2022,7 +2022,7 @@ void pp_title_line(struct pretty_print_context *pp,
 	strbuf_addch(sb, '\n');
 
 	if (need_8bit_cte == 0) {
-		int i;
+		size_t i;
 		for (i = 0; i < pp->in_body_headers.nr; i++) {
 			if (has_non_ascii(pp->in_body_headers.items[i].string)) {
 				need_8bit_cte = 1;
@@ -2046,7 +2046,7 @@ void pp_title_line(struct pretty_print_context *pp,
 	}
 
 	if (pp->in_body_headers.nr) {
-		int i;
+		size_t i;
 		for (i = 0; i < pp->in_body_headers.nr; i++) {
 			strbuf_addstr(sb, pp->in_body_headers.items[i].string);
 			free(pp->in_body_headers.items[i].string);
diff --git a/range-diff.c b/range-diff.c
index 4bd65ab7496..1545d42615b 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -38,7 +38,7 @@ static int read_patches(const char *range, struct string_list *list,
 	struct patch_util *util = NULL;
 	int in_header = 1;
 	char *line, *current_filename = NULL;
-	ssize_t len;
+	size_t len;
 	size_t size;
 	int ret = -1;
 
@@ -117,7 +117,7 @@ static int read_patches(const char *range, struct string_list *list,
 			struct patch patch = { 0 };
 			struct strbuf root = STRBUF_INIT;
 			int linenr = 0;
-			int orig_len;
+			int orig_len, output;
 
 			in_header = 0;
 			strbuf_addch(&buf, '\n');
@@ -126,15 +126,16 @@ static int read_patches(const char *range, struct string_list *list,
 			if (eol)
 				*eol = '\n';
 			orig_len = len;
-			len = parse_git_diff_header(&root, &linenr, 0, line,
-						    len, size, &patch);
-			if (len < 0) {
+			output = parse_git_diff_header(&root, &linenr, 0, line,
+						       len, size, &patch);
+			if (output < 0) {
 				error(_("could not parse git header '%.*s'"),
 				      orig_len, line);
 				FREE_AND_NULL(util);
 				string_list_clear(list, 1);
 				goto cleanup;
 			}
+			len = output;
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
 				strbuf_addf(&buf, "%s (new)", patch.new_name);
@@ -585,7 +586,7 @@ int is_range_diff_range(const char *arg)
 {
 	char *copy = xstrdup(arg); /* setup_revisions() modifies it */
 	const char *argv[] = { "", copy, "--", NULL };
-	int i, positive = 0, negative = 0;
+	unsigned int i, positive = 0, negative = 0;
 	struct rev_info revs;
 
 	init_revisions(&revs, NULL);
@@ -606,5 +607,5 @@ int is_range_diff_range(const char *arg)
 
 	free(copy);
 	release_revisions(&revs);
-	return negative > 0 && positive > 0;
+	return negative != 0 && positive != 0;
 }
diff --git a/read-cache.c b/read-cache.c
index 35e5657877c..1f7ff97ca6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -109,7 +109,8 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 
 static const char *alternate_index_output;
 
-static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void set_index_entry(struct index_state *istate, unsigned int nr,
+			    struct cache_entry *ce)
 {
 	if (S_ISSPARSEDIR(ce->ce_mode))
 		istate->sparse_index = INDEX_COLLAPSED;
@@ -118,7 +119,8 @@ static void set_index_entry(struct index_state *istate, int nr, struct cache_ent
 	add_name_hash(istate, ce);
 }
 
-static void replace_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
+static void replace_index_entry(struct index_state *istate, unsigned int nr,
+				struct cache_entry *ce)
 {
 	struct cache_entry *old = istate->cache[nr];
 
@@ -556,7 +558,8 @@ int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 	return 0;
 }
 
-int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2)
+int cache_name_stage_compare(const char *name1, size_t len1, int stage1,
+			     const char *name2, size_t len2, int stage2)
 {
 	int cmp;
 
@@ -704,7 +707,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 		return pos;
 
 	/* maybe unmerged? */
-	pos = -1 - pos;
+	pos = -pos - 1;
 	if (pos >= istate->cache_nr ||
 			compare_name((ce = istate->cache[pos]), path, namelen))
 		return -1;
@@ -719,7 +722,7 @@ static int index_name_pos_also_unmerged(struct index_state *istate,
 
 static int different_name(struct cache_entry *ce, struct cache_entry *alias)
 {
-	int len = ce_namelen(ce);
+	unsigned int len = ce_namelen(ce);
 	return ce_namelen(alias) != len || memcmp(ce->name, alias->name, len);
 }
 
@@ -736,7 +739,7 @@ static struct cache_entry *create_alias_ce(struct index_state *istate,
 					   struct cache_entry *ce,
 					   struct cache_entry *alias)
 {
-	int len;
+	unsigned int len;
 	struct cache_entry *new_entry;
 
 	if (alias->ce_flags & CE_ADDED)
@@ -903,7 +906,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 				     unsigned int refresh_options)
 {
 	struct cache_entry *ce, *ret;
-	int len;
+	size_t len;
 
 	if (verify_path_internal(path, mode) == PATH_INVALID) {
 		error(_("invalid path '%s'"), path);
@@ -932,7 +935,7 @@ struct cache_entry *make_transient_cache_entry(unsigned int mode,
 					       struct mem_pool *ce_mem_pool)
 {
 	struct cache_entry *ce;
-	int len;
+	size_t len;
 
 	if (!verify_path(path, mode)) {
 		error(_("invalid path '%s'"), path);
@@ -983,7 +986,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
 
 int ce_same_name(const struct cache_entry *a, const struct cache_entry *b)
 {
-	int len = ce_namelen(a);
+	unsigned int len = ce_namelen(a);
 	return ce_namelen(b) == len && !memcmp(a->name, b->name, len);
 }
 
@@ -1110,8 +1113,8 @@ static int has_file_name(struct index_state *istate,
 			 const struct cache_entry *ce, int pos, int ok_to_replace)
 {
 	int retval = 0;
-	int len = ce_namelen(ce);
-	int stage = ce_stage(ce);
+	unsigned int len = ce_namelen(ce);
+	unsigned int stage = ce_stage(ce);
 	const char *name = ce->name;
 
 	while (pos < istate->cache_nr) {
@@ -1152,7 +1155,7 @@ int strcmp_offset(const char *s1, const char *s2, size_t *first_change)
 			break;
 
 	*first_change = k;
-	return (unsigned char)s1[k] - (unsigned char)s2[k];
+	return (const unsigned char)s1[k] - (const unsigned char)s2[k];
 }
 
 /*
@@ -1599,7 +1602,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		  const struct pathspec *pathspec,
 		  char *seen, const char *header_msg)
 {
-	int i;
+	unsigned int i;
 	int has_errors = 0;
 	int really = (flags & REFRESH_REALLY) != 0;
 	int allow_unmerged = (flags & REFRESH_UNMERGED) != 0;
@@ -2585,7 +2588,7 @@ void discard_index(struct index_state *istate)
  */
 void validate_cache_entries(const struct index_state *istate)
 {
-	int i;
+	unsigned i;
 
 	if (!should_validate_cache_entries() ||!istate || !istate->initialized)
 		return;
@@ -2610,7 +2613,7 @@ void validate_cache_entries(const struct index_state *istate)
 
 int unmerged_index(const struct index_state *istate)
 {
-	int i;
+	unsigned i;
 	for (i = 0; i < istate->cache_nr; i++) {
 		if (ce_stage(istate->cache[i]))
 			return 1;
@@ -2769,7 +2772,7 @@ static int ce_write_entry(struct hashfile *f, struct cache_entry *ce,
 	size = offsetof(struct ondisk_cache_entry,data) + ondisk_data_size(ce->ce_flags, 0);
 
 	if (!previous_name) {
-		int len = ce_namelen(ce);
+		unsigned int len = ce_namelen(ce);
 		copy_cache_entry_to_ondisk(ondisk, ce);
 		hashwrite(f, ondisk, size);
 		hashwrite(f, ce->name, len);
@@ -2849,8 +2852,8 @@ static int repo_verify_index(struct repository *repo)
 
 int has_racy_timestamp(struct index_state *istate)
 {
-	int entries = istate->cache_nr;
-	int i;
+	unsigned int entries = istate->cache_nr;
+	unsigned int i;
 
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -3474,7 +3477,7 @@ out:
 int repo_read_index_unmerged(struct repository *repo)
 {
 	struct index_state *istate;
-	int i;
+	unsigned i;
 	int unmerged = 0;
 
 	repo_read_index(repo);
@@ -3482,7 +3485,7 @@ int repo_read_index_unmerged(struct repository *repo)
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
 		struct cache_entry *new_ce;
-		int len;
+		unsigned int len;
 
 		if (!ce_stage(ce))
 			continue;
@@ -3817,7 +3820,7 @@ static void write_ieot_extension(struct strbuf *sb, struct index_entry_offset_ta
 void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch)
 {
-	int i;
+	unsigned i;
 	struct oid_array to_fetch = OID_ARRAY_INIT;
 
 	for (i = 0; i < istate->cache_nr; i++) {
diff --git a/remote-curl.c b/remote-curl.c
index a76b6405eb2..78292f348f4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -206,7 +206,7 @@ static int set_option(const char *name, const char *value)
 		options.filter = xstrdup(value);
 		return 0;
 	} else if (!strcmp(name, "object-format")) {
-		int algo;
+		unsigned algo;
 		options.object_format = 1;
 		if (strcmp(value, "true")) {
 			algo = hash_algo_by_name(value);
diff --git a/repository.c b/repository.c
index 937fa974b38..b283b95eb06 100644
--- a/repository.c
+++ b/repository.c
@@ -94,7 +94,7 @@ void repo_set_gitdir(struct repository *repo,
 			repo->gitdir, "index");
 }
 
-void repo_set_hash_algo(struct repository *repo, int hash_algo)
+void repo_set_hash_algo(struct repository *repo, unsigned hash_algo)
 {
 	repo->hash_algo = &hash_algos[hash_algo];
 }
diff --git a/repository.h b/repository.h
index e8c67ffe165..dda7cbdc94b 100644
--- a/repository.h
+++ b/repository.h
@@ -187,7 +187,7 @@ struct set_gitdir_args {
 void repo_set_gitdir(struct repository *repo, const char *root,
 		     const struct set_gitdir_args *extra_args);
 void repo_set_worktree(struct repository *repo, const char *path);
-void repo_set_hash_algo(struct repository *repo, int algo);
+void repo_set_hash_algo(struct repository *repo, unsigned algo);
 void initialize_the_repository(void);
 RESULT_MUST_BE_USED
 int repo_init(struct repository *r, const char *gitdir, const char *worktree);
diff --git a/run-command.c b/run-command.c
index 6bd16acb060..706b3d8e0f6 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1650,8 +1650,9 @@ static void pp_buffer_stderr(struct parallel_processes *pp,
 	for (size_t i = 0; i < opts->processes; i++) {
 		if (pp->children[i].state == GIT_CP_WORKING &&
 		    pp->pfd[i].revents & (POLLIN | POLLHUP)) {
-			int n = strbuf_read_once(&pp->children[i].err,
-						 pp->children[i].process.err, 0);
+			ssize_t n = strbuf_read_once(
+				&pp->children[i].err,
+				pp->children[i].process.err, 0);
 			if (n == 0) {
 				close(pp->children[i].process.err);
 				pp->children[i].state = GIT_CP_WAIT_CLEANUP;
diff --git a/shallow.c b/shallow.c
index 17f9bcdb5f3..e791c8160a8 100644
--- a/shallow.c
+++ b/shallow.c
@@ -803,7 +803,7 @@ static void post_assign_shallow(struct shallow_info *info,
 }
 
 /* (Delayed) step 7, reachability test at commit level */
-int delayed_reachability_test(struct shallow_info *si, int c)
+int delayed_reachability_test(struct shallow_info *si, size_t c)
 {
 	if (si->need_reachability_test[c]) {
 		struct commit *commit = lookup_commit(the_repository,
diff --git a/shallow.h b/shallow.h
index aba6ff58294..be77c0db079 100644
--- a/shallow.h
+++ b/shallow.h
@@ -76,7 +76,7 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *);
 void assign_shallow_commits_to_refs(struct shallow_info *info,
 				    uint32_t **used,
 				    int *ref_status);
-int delayed_reachability_test(struct shallow_info *si, int c);
+int delayed_reachability_test(struct shallow_info *si, size_t c);
 
 extern struct trace_key trace_shallow;
 
diff --git a/strbuf.c b/strbuf.c
index c383f41a3c5..a6eca686b6d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -172,7 +172,7 @@ struct strbuf **strbuf_split_buf(const char *str, size_t slen,
 	struct strbuf *t;
 
 	while (slen) {
-		int len = slen;
+		size_t len = slen;
 		if (max <= 0 || nr + 1 < max) {
 			const char *end = memchr(str, terminator, slen);
 			if (end)
@@ -1075,7 +1075,7 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len)
 {
-	int r;
+	unsigned int r;
 	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
 	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
diff --git a/string-list.c b/string-list.c
index 42bacaec55b..29208b2f51b 100644
--- a/string-list.c
+++ b/string-list.c
@@ -263,7 +263,8 @@ int unsorted_string_list_has_string(struct string_list *list,
 	return unsorted_string_list_lookup(list, string) != NULL;
 }
 
-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util)
+void unsorted_string_list_delete_item(struct string_list *list, size_t i,
+				      int free_util)
 {
 	if (list->strdup_strings)
 		free(list->items[i].string);
diff --git a/string-list.h b/string-list.h
index c7b0d5d0008..401d0bc1052 100644
--- a/string-list.h
+++ b/string-list.h
@@ -241,7 +241,8 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
  * string_list is set. The third parameter controls if the `util`
  * pointer of the items should be freed or not.
  */
-void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
+void unsorted_string_list_delete_item(struct string_list *list, size_t i,
+				      int free_util);
 
 /**
  * Split string into substrings on character `delim` and append the
diff --git a/sub-process.c b/sub-process.c
index 6d4232294db..1d380ef0405 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -116,7 +116,7 @@ static int handshake_version(struct child_process *process,
 			     int *chosen_version)
 {
 	int version_scratch;
-	int i;
+	size_t i;
 	char *line;
 	const char *p;
 
@@ -162,7 +162,7 @@ static int handshake_capabilities(struct child_process *process,
 				  struct subprocess_capability *capabilities,
 				  unsigned int *supported_capabilities)
 {
-	int i;
+	size_t i;
 	char *line;
 
 	for (i = 0; capabilities[i].name; i++) {
diff --git a/submodule.c b/submodule.c
index 3a0dfc417c0..65937c1eaf1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -173,10 +173,10 @@ void add_submodule_odb_by_path(const char *path)
 	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
 }
 
-int register_all_submodule_odb_as_alternates(void)
+size_t register_all_submodule_odb_as_alternates(void)
 {
-	int i;
-	int ret = added_submodule_odb_paths.nr;
+	size_t i;
+	size_t ret = added_submodule_odb_paths.nr;
 
 	for (i = 0; i < added_submodule_odb_paths.nr; i++)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
@@ -324,7 +324,7 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 void die_in_unpopulated_submodule(struct index_state *istate,
 				  const char *prefix)
 {
-	int i, prefixlen;
+	size_t i, prefixlen;
 
 	if (!prefix)
 		return;
@@ -333,7 +333,7 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
-		int ce_len = ce_namelen(ce);
+		size_t ce_len = ce_namelen(ce);
 
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
@@ -354,7 +354,8 @@ void die_in_unpopulated_submodule(struct index_state *istate,
 void die_path_inside_submodule(struct index_state *istate,
 			       const struct pathspec *ps)
 {
-	int i, j;
+	unsigned int i;
+	int j;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce = istate->cache[i];
@@ -1206,7 +1207,8 @@ int push_unpushed_submodules(struct repository *r,
 			     const struct string_list *push_options,
 			     int dry_run)
 {
-	int i, ret = 1;
+	size_t i;
+	int ret = 1;
 	struct string_list needs_pushing = STRING_LIST_INIT_DUP;
 
 	if (!find_unpushed_submodules(r, commits,
diff --git a/submodule.h b/submodule.h
index c55a25ca37d..a62af231e59 100644
--- a/submodule.h
+++ b/submodule.h
@@ -109,7 +109,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
  * added as alternates in the_repository.
  */
 void add_submodule_odb_by_path(const char *path);
-int register_all_submodule_odb_as_alternates(void);
+size_t register_all_submodule_odb_as_alternates(void);
 
 /*
  * Checks if there are submodule changes in a..b. If a is the null OID,
diff --git a/trailer.c b/trailer.c
index 0fd5b142a37..be42417fe04 100644
--- a/trailer.c
+++ b/trailer.c
@@ -518,7 +518,7 @@ static int git_trailer_config(const char *conf_key, const char *value,
 	struct conf_info *conf;
 	char *name = NULL;
 	enum trailer_info_type type;
-	int i;
+	size_t i;
 
 	if (!skip_prefix(conf_key, "trailer.", &trailer_item))
 		return 0;
diff --git a/transport-helper.c b/transport-helper.c
index 3ea7c2bb5ad..7afd785ca05 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -295,7 +295,8 @@ static int string_list_set_helper_option(struct helper_data *data,
 					 struct string_list *list)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret = 0;
+	int ret = 0;
+	size_t i;
 
 	for (i = 0; i < list->nr; i++) {
 		strbuf_addf(&buf, "option %s ", name);
@@ -315,7 +316,8 @@ static int set_helper_option(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct strbuf buf = STRBUF_INIT;
-	int i, ret, is_bool = 0;
+	size_t i;
+	int ret, is_bool = 0;
 
 	get_helper(transport);
 
@@ -459,7 +461,7 @@ static int get_exporter(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
-	int i;
+	size_t i;
 
 	child_process_init(fastexport);
 
@@ -1226,7 +1228,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 		else if (buf.buf[0] == ':') {
 			const char *value;
 			if (skip_prefix(buf.buf, ":object-format ", &value)) {
-				int algo = hash_algo_by_name(value);
+				unsigned algo = hash_algo_by_name(value);
 				if (algo == GIT_HASH_UNKNOWN)
 					die(_("unsupported object format '%s'"),
 					    value);
diff --git a/transport.c b/transport.c
index 77a61a9d7bb..8d949a9bdb5 100644
--- a/transport.c
+++ b/transport.c
@@ -42,7 +42,7 @@ static int transport_color_config(void)
 		"color.transport.rejected"
 	}, *key = "color.transport";
 	char *value;
-	int i;
+	size_t i;
 	static int initialized;
 
 	if (initialized)
@@ -147,7 +147,7 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 {
 	struct bundle_transport_data *data = transport->data;
 	struct ref *result = NULL;
-	int i;
+	size_t i;
 
 	if (for_push)
 		return NULL;
@@ -1233,7 +1233,7 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
-	int i;
+	size_t i;
 
 	fprintf(stderr, _("The following submodule paths contain changes that can\n"
 			"not be found on any remote:\n"));
@@ -1552,7 +1552,7 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
-	int i;
+	size_t i;
 
 	for (i = 0; i < transport->pack_lockfiles.nr; i++)
 		if (in_signal_handler)
diff --git a/unpack-trees.c b/unpack-trees.c
index 3d05e45a279..6290e4535d0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2285,8 +2285,8 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	 * we are about to extract "ce->name"; we would not want to lose
 	 * anything in the existing directory there.
 	 */
-	int namelen;
-	int i;
+	unsigned int namelen;
+	unsigned int i;
 	struct dir_struct d;
 	char *pathbuf;
 	int cnt = 0;
@@ -2313,7 +2313,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	     i < o->src_index->cache_nr;
 	     i++) {
 		struct cache_entry *ce2 = o->src_index->cache[i];
-		int len = ce_namelen(ce2);
+		unsigned int len = ce_namelen(ce2);
 		if (len < namelen ||
 		    strncmp(ce->name, ce2->name, namelen) ||
 		    ce2->name[namelen] != '/')
@@ -2333,7 +2333,7 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	}
 
 	/* Do not lose a locally present file that is not ignored. */
-	pathbuf = xstrfmt("%.*s/", namelen, ce->name);
+	pathbuf = xstrfmt("%.*s/", (int)namelen, ce->name);
 
 	memset(&d, 0, sizeof(d));
 	if (o->dir)
@@ -2876,7 +2876,7 @@ int twoway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *newtree = src[2];
 
 	if (o->merge_size != 2)
-		return error("Cannot do a twoway merge of %d trees",
+		return error("Cannot do a twoway merge of %u trees",
 			     o->merge_size);
 
 	if (oldtree == o->df_conflict_entry)
@@ -2958,7 +2958,7 @@ int bind_merge(const struct cache_entry * const *src,
 	const struct cache_entry *a = src[1];
 
 	if (o->merge_size != 1)
-		return error("Cannot do a bind merge of %d trees",
+		return error("Cannot do a bind merge of %u trees",
 			     o->merge_size);
 	if (a && old)
 		return o->quiet ? -1 :
@@ -2984,7 +2984,7 @@ int oneway_merge(const struct cache_entry * const *src,
 	const struct cache_entry *a = src[1];
 
 	if (o->merge_size != 1)
-		return error("Cannot do a oneway merge of %d trees",
+		return error("Cannot do a oneway merge of %u trees",
 			     o->merge_size);
 
 	if (!a || a == o->df_conflict_entry)
@@ -3021,7 +3021,7 @@ int stash_worktree_untracked_merge(const struct cache_entry * const *src,
 	const struct cache_entry *untracked = src[2];
 
 	if (o->merge_size != 2)
-		BUG("invalid merge_size: %d", o->merge_size);
+		BUG("invalid merge_size: %u", o->merge_size);
 
 	if (worktree && untracked)
 		return error(_("worktree and untracked commit have duplicate entries: %s"),
diff --git a/unpack-trees.h b/unpack-trees.h
index 3a7b3e5f007..f2d87900c9d 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -88,7 +88,7 @@ struct unpack_trees_options {
 	struct string_list unpack_rejects[NB_UNPACK_TREES_WARNING_TYPES];
 
 	int head_idx;
-	int merge_size;
+	unsigned merge_size;
 
 	struct cache_entry *df_conflict_entry;
 	void *unpack_data;
diff --git a/wt-status.c b/wt-status.c
index 3162241a570..d58fd61bf6d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -151,7 +151,7 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 
 static void wt_longstatus_print_unmerged_header(struct wt_status *s)
 {
-	int i;
+	size_t i;
 	int del_mod_conflict = 0;
 	int both_deleted = 0;
 	int not_deleted = 0;
@@ -700,7 +700,7 @@ static int add_file_to_list(const struct object_id *oid,
 static void wt_status_collect_changes_initial(struct wt_status *s)
 {
 	struct index_state *istate = s->repo->index;
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		struct string_list_item *it;
@@ -803,7 +803,7 @@ static void wt_status_collect_untracked(struct wt_status *s)
 
 static int has_unmerged(struct wt_status *s)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -854,7 +854,7 @@ void wt_status_state_free_buffers(struct wt_status_state *state)
 static void wt_longstatus_print_unmerged(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -877,7 +877,7 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
 static void wt_longstatus_print_updated(struct wt_status *s)
 {
 	int shown_header = 0;
-	int i;
+	size_t i;
 
 	for (i = 0; i < s->change.nr; i++) {
 		struct wt_status_change_data *d;
@@ -905,7 +905,7 @@ static void wt_longstatus_print_updated(struct wt_status *s)
 static int wt_status_check_worktree_changes(struct wt_status *s,
 					     int *dirty_submodules)
 {
-	int i;
+	size_t i;
 	int changes = 0;
 
 	*dirty_submodules = 0;
@@ -928,7 +928,8 @@ static int wt_status_check_worktree_changes(struct wt_status *s,
 
 static void wt_longstatus_print_changed(struct wt_status *s)
 {
-	int i, dirty_submodules;
+	size_t i;
+	int dirty_submodules;
 	int worktree_changes = wt_status_check_worktree_changes(s, &dirty_submodules);
 
 	if (!worktree_changes)
@@ -1028,7 +1029,7 @@ static void wt_longstatus_print_other(struct wt_status *s,
 				      const char *what,
 				      const char *how)
 {
-	int i;
+	size_t i;
 	struct strbuf buf = STRBUF_INIT;
 	static struct string_list output = STRING_LIST_INIT_DUP;
 	struct column_options copts;
@@ -1164,7 +1165,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 	const char *cp, *ep, *branch_name;
 	struct branch *branch;
 	char comment_line_string[3];
-	int i;
+	unsigned int i;
 	uint64_t t_begin = 0;
 
 	assert(s->branch && !s->is_initial);
@@ -1320,7 +1321,7 @@ static int split_commit_in_progress(struct wt_status *s)
 static void abbrev_oid_in_line(struct strbuf *line)
 {
 	struct strbuf **split;
-	int i;
+	size_t i;
 
 	if (starts_with(line->buf, "exec ") ||
 	    starts_with(line->buf, "x ") ||
@@ -1379,8 +1380,8 @@ static void show_rebase_information(struct wt_status *s,
 				    const char *color)
 {
 	if (s->state.rebase_interactive_in_progress) {
-		int i;
-		int nr_lines_to_show = 2;
+		size_t i;
+		const size_t nr_lines_to_show = 2;
 
 		struct string_list have_done = STRING_LIST_INIT_DUP;
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
@@ -1729,7 +1730,7 @@ static void wt_status_check_sparse_checkout(struct repository *r,
 					    struct wt_status_state *state)
 {
 	int skip_worktree = 0;
-	int i;
+	unsigned int i;
 
 	if (!core_apply_sparse_checkout || r->index->cache_nr == 0) {
 		/*
@@ -2487,7 +2488,7 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 {
 	struct wt_status_change_data *d;
 	struct string_list_item *it;
-	int i;
+	size_t i;
 
 	if (s->show_branch)
 		wt_porcelain_v2_print_tracking(s);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index e87950de32e..d4bec9905ff 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -210,8 +210,8 @@ static long ff_regexp(const char *line, long len,
 {
 	struct ff_regs *regs = priv;
 	regmatch_t pmatch[2];
-	int i;
-	int result;
+	size_t i;
+	long result;
 
 	/* Exclude terminating newline (and cr) from matching */
 	if (len > 0 && line[len-1] == '\n') {
@@ -244,7 +244,7 @@ static long ff_regexp(const char *line, long len,
 
 void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 {
-	int i;
+	size_t i;
 	struct ff_regs *regs;
 
 	xecfg->find_func = ff_regexp;

base-commit: 73876f4861cd3d187a4682290ab75c9dccadbc56
-- 
gitgitgadget
