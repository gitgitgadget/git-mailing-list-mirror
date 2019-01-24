Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8BCF1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 08:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfAXI3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 03:29:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41500 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfAXI3h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 03:29:37 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so2344471pgq.8
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 00:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nNP3NEP9DTFIbx8YoGHv7b9Z+MSv50eiY4bO19UXsA=;
        b=PBzlQHiRRo68pB+0DbALhkZrcsNGH1gQfKAxTQi0CATBzGzOGbq457ifrnc0e1wPCe
         AeQ50xYXL/1w7SEd15riWxJ8eJLmj9TqPE8JzViQ+5Iv+O+osR5LrkZcvStRo/yEgBfk
         6YTb7HTqOm54Q9ezC1LozoMT7UJYoP99oiESgBwP8ARIOcwNogfxputixw72xwxUqjwG
         Atp9OaexoNNEQ0/PwQvmpSClGmWqzzxsb3ASxdAerYT//4wDlSS1k07390mhfSy1F3+j
         92eLFxml8IIYM4YGXeTLFBPh9JuqskZkesttHlH4LZiIdZsfEa8RkaxjWrzDFYAgnigz
         T6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nNP3NEP9DTFIbx8YoGHv7b9Z+MSv50eiY4bO19UXsA=;
        b=AgpJMB+veR+sS8sKzXJ5kMXMwefQfcZMAJCEEnKa0ilYQUrcLy0P0cP/RG5yXfykLC
         bI2URrtL8rr12lj2lFIYDVhTXog+4RbGaxI9qxeG5EbbUqMxg99esF6XISvJchWwKs42
         HlLQtsFAKJRQSLlyokbnGJUBUCoD9jTBliiOaWBZFHqNhVbv8WJRY5zvw2NlW2jEV6mh
         +UNvG3umSVdopa+R4ntYIpH0U+yuBBxhHIBFjfegEe73qTMDBeGBzNT5cUnRfeAzXcqO
         HrAdY8cj1XXmPP01BWl3+roWfqJJYQmwN+xfnBcFxb3QSloEY5iQkgGqE/BN4/iBiIh0
         Q5Dg==
X-Gm-Message-State: AJcUukfd5a0WK9tYzgqVgVhbiuYeHnWJrgAm8sQa5sPTuKQfnXTzZfBj
        MBaOtg/cyFDWNOr+yGi9Zm+AxPQHA34=
X-Google-Smtp-Source: ALg8bN7UqM5GCFrUmcYyJKe05ty0p7n2stfdm0GBRAxjUUuH8zy57EeCMfiv9pWtQDVxSS3FPOh5jQ==
X-Received: by 2002:a63:680a:: with SMTP id d10mr5144132pgc.396.1548318576510;
        Thu, 24 Jan 2019 00:29:36 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r187sm71845297pfc.63.2019.01.24.00.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 00:29:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 24 Jan 2019 15:29:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/11] repository.c: replace hold_locked_index() with repo_hold_locked_index()
Date:   Thu, 24 Jan 2019 15:29:04 +0700
Message-Id: <20190124082912.24401-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190124082912.24401-1-pclouds@gmail.com>
References: <20190124082912.24401-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hold_locked_index() assumes the index path at $GIT_DIR/index. This is
not good for places that take an arbitrary index_state instead of
the_index, which is basically everywhere except builtin/.

Replace it with repo_hold_locked_index(). hold_locked_index() remains
as a wrapper around repo_hold_locked_index() to reduce changes in builtin/

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c           |  3 ++-
 cache.h           |  2 +-
 merge-recursive.c |  2 +-
 merge.c           |  2 +-
 read-cache.c      |  5 -----
 repository.c      | 10 ++++++++++
 repository.h      |  4 ++++
 rerere.c          |  2 +-
 sequencer.c       | 10 +++++-----
 wt-status.c       |  2 +-
 10 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/apply.c b/apply.c
index 01793d6126..08cde3c4bf 100644
--- a/apply.c
+++ b/apply.c
@@ -4712,7 +4712,8 @@ static int apply_patch(struct apply_state *state,
 						  state->index_file,
 						  LOCK_DIE_ON_ERROR);
 		else
-			hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
+			repo_hold_locked_index(state->repo, &state->lock_file,
+					       LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
diff --git a/cache.h b/cache.h
index ca36b44ee0..634c9ce325 100644
--- a/cache.h
+++ b/cache.h
@@ -433,6 +433,7 @@ void validate_cache_entries(const struct index_state *istate);
 #define unmerge_cache_entry_at(at) unmerge_index_entry_at(&the_index, at)
 #define unmerge_cache(pathspec) unmerge_index(&the_index, pathspec)
 #define read_blob_data_from_cache(path, sz) read_blob_data_from_index(&the_index, (path), (sz))
+#define hold_locked_index(lock_file, flags) repo_hold_locked_index(the_repository, (lock_file), (flags))
 #endif
 
 #define TYPE_BITS 3
@@ -833,7 +834,6 @@ extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cach
  */
 extern void update_index_if_able(struct index_state *, struct lock_file *);
 
-extern int hold_locked_index(struct lock_file *, int);
 extern void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
diff --git a/merge-recursive.c b/merge-recursive.c
index ecf8db0b71..8dba939d8f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3643,7 +3643,7 @@ int merge_recursive_generic(struct merge_options *o,
 		}
 	}
 
-	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(the_repository, &lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 				result);
 	if (clean < 0) {
diff --git a/merge.c b/merge.c
index 91008f7602..dbbc9d9f80 100644
--- a/merge.c
+++ b/merge.c
@@ -58,7 +58,7 @@ int checkout_fast_forward(struct repository *r,
 
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 
-	if (hold_locked_index(&lock_file, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &lock_file, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	memset(&trees, 0, sizeof(trees));
diff --git a/read-cache.c b/read-cache.c
index 48c1797a4a..1030e11051 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1733,11 +1733,6 @@ static int read_index_extension(struct index_state *istate,
 	return 0;
 }
 
-int hold_locked_index(struct lock_file *lk, int lock_flags)
-{
-	return hold_lock_file_for_update(lk, get_index_file(), lock_flags);
-}
-
 int read_index(struct index_state *istate)
 {
 	return read_index_from(istate, get_index_file(), get_git_dir());
diff --git a/repository.c b/repository.c
index 7b02e1dffa..9411c4baee 100644
--- a/repository.c
+++ b/repository.c
@@ -3,6 +3,7 @@
 #include "object-store.h"
 #include "config.h"
 #include "object.h"
+#include "lockfile.h"
 #include "submodule-config.h"
 
 /* The main repository */
@@ -263,3 +264,12 @@ int repo_read_index(struct repository *repo)
 
 	return read_index_from(repo->index, repo->index_file, repo->gitdir);
 }
+
+int repo_hold_locked_index(struct repository *repo,
+			   struct lock_file *lf,
+			   int flags)
+{
+	if (!repo->index_file)
+		BUG("the repo hasn't been setup");
+	return hold_lock_file_for_update(lf, repo->index_file, flags);
+}
diff --git a/repository.h b/repository.h
index 9f16c42c1e..968330218f 100644
--- a/repository.h
+++ b/repository.h
@@ -6,6 +6,7 @@
 struct config_set;
 struct git_hash_algo;
 struct index_state;
+struct lock_file;
 struct raw_object_store;
 struct submodule_cache;
 
@@ -130,5 +131,8 @@ void repo_clear(struct repository *repo);
  * populated then the number of entries will simply be returned.
  */
 int repo_read_index(struct repository *repo);
+int repo_hold_locked_index(struct repository *repo,
+			   struct lock_file *lf,
+			   int flags);
 
 #endif /* REPOSITORY_H */
diff --git a/rerere.c b/rerere.c
index 13624038e6..fb0fdb2392 100644
--- a/rerere.c
+++ b/rerere.c
@@ -705,7 +705,7 @@ static void update_paths(struct repository *r, struct string_list *update)
 	struct lock_file index_lock = LOCK_INIT;
 	int i;
 
-	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
+	repo_hold_locked_index(r, &index_lock, LOCK_DIE_ON_ERROR);
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
diff --git a/sequencer.c b/sequencer.c
index 1a92a5d678..668c232b05 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -540,7 +540,7 @@ static int do_recursive_merge(struct repository *r,
 	char **xopt;
 	struct lock_file index_lock = LOCK_INIT;
 
-	if (hold_locked_index(&index_lock, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &index_lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	read_index(r->index);
@@ -1992,8 +1992,8 @@ static int read_and_refresh_cache(struct repository *r,
 				  struct replay_opts *opts)
 {
 	struct lock_file index_lock = LOCK_INIT;
-	int index_fd = hold_locked_index(&index_lock, 0);
-	if (read_index(r->index) < 0) {
+	int index_fd = repo_hold_locked_index(r, &index_lock, 0);
+	if (repo_read_index(r) < 0) {
 		rollback_lock_file(&index_lock);
 		return error(_("git %s: failed to read the index"),
 			_(action_name(opts)));
@@ -2978,7 +2978,7 @@ static int do_reset(struct repository *r,
 	struct unpack_trees_options unpack_tree_opts;
 	int ret = 0;
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
+	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
 		return -1;
 
 	if (len == 10 && !strncmp("[new root]", name, len)) {
@@ -3096,7 +3096,7 @@ static int do_merge(struct repository *r,
 	static struct lock_file lock;
 	const char *p;
 
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_merge;
 	}
diff --git a/wt-status.c b/wt-status.c
index 0fe3bcd4cd..becf78b04f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2375,7 +2375,7 @@ int require_clean_work_tree(struct repository *r,
 	struct lock_file lock_file = LOCK_INIT;
 	int err = 0, fd;
 
-	fd = hold_locked_index(&lock_file, 0);
+	fd = repo_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <= fd)
 		update_index_if_able(r->index, &lock_file);
-- 
2.20.1.560.g70ca8b83ee

