Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34493C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE561168
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhIUQw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhIUQwt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:49 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092F9C061757
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:21 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ci14-20020a056214054e00b0037a75ff56f9so229460580qvb.23
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4n59XsA58rLCFYF6p+fHqDOHSxl+NBLEiF3PDDsOGo0=;
        b=BOW5Y5myZv9gT8NGA32XQABE5/RqgD3Ca/WjCRDqUR0uXotgG1DUV/Jxw4w6tr8lqT
         jQq8AHxZKyYcGAF7ifSsjeHJj61sHxXUhAucz6bGZ9caAtslGfHGJvcJMwyQACcBOalM
         p67D20AFGBrbTcu2hm/UsQMEJ1lg0OyH61h+AChrqcazHxGpOu3JAvtTAzlaTf5y9T0o
         k7pGBrcji+nNHEOUOuBIlJ6NL6U+C+BzWplXe+QCqkmBQgP2Np4dIOufMdfhQNz9NNW+
         iRYhX6HFpy3dR2YFubuIaIxYUkvigiKaua7imC+B1IGdGZ3UJts442IDKangJx2KkfsP
         TjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4n59XsA58rLCFYF6p+fHqDOHSxl+NBLEiF3PDDsOGo0=;
        b=g5w71AR8GzGi8wtaJY/atqSbxKY39NxyxyISwXsaEddZ3D1OcDGRyDHzYhXnXJev4s
         v4unpuOUpRbwx8M7GydU6kscZQYYOIlq7h0FzI5skDuEamNRGliDapQ1PLPZ12/DKzYs
         ZXBz7d+0KU4jodURPtYoZ+W0wgKiCZfnyX2tRZrh7oKS/H2Bd+IxGDuTcxDNo711T2NH
         qrC2mb4V9bdOnLY7n8XaJINT5G+HAVK2SfCjzeGGRY5s8EwzB519KVLkaXlQpycms6Xa
         z/KYRiqSDjygEdzL8n9zdOu4Ju0Mrl8csujiIhhrWL9pUUIKk0ds1AgWkJyX9RTb0C2/
         7Cgg==
X-Gm-Message-State: AOAM533waRH+sEbqQgKwUPxhlutacCxxn4qBFU40hsm4ncue559cB6rd
        4Xh1BOU3R3sFgDw2/judPDRRVkEHfrTjG+uQb2Ccf/iLaLb+3Wop1GCeGzTVrGD7FEXpj0GglPA
        InZJcNnmztbZlT7K4ywQTLugRMNpLayp1NWa5/kCLjhyJEFt4EztGB7+2UFwedRFtLmXmlY0db6
        BU
X-Google-Smtp-Source: ABdhPJyHQ/J4HNhmsxs/BsB4Kp7UNeqho6z7SknmHNmhVSMPHOor3hBRbo+RPMWPtyv5o+fErxGxujKtbqo5cGm3MZ3U
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:153:: with SMTP id
 x19mr31489938qvs.18.1632243080072; Tue, 21 Sep 2021 09:51:20 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:06 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <f3a45fba84292ed677fbdf3bc060915bf019fd66.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 4/9] refs: teach refs_for_each_ref() arbitrary repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A subsequent patch needs to perform a revision walk with --all. As seen
from handle_revision_pseudo_opt() in revision.c, refs_for_each_ref()
needs to be updated to take a repository struct and pass it to the
underlying ref iterator mechanism. This is so that refs can be checked
if they resolve to an existing object and in doing so, non-resolving
refs can be skipped over. (refs_head_ref() doesn't seem to read any
objects and doesn't need this treatment.) Update refs_for_each_ref()
accordingly.

Now that get_main_ref_store() can take repositories other than
the_repository, ensure that it sets the correct flags according to the
repository passed as an argument.

The signatures of some other functions need to be changed too for
consistency (because of handle_refs() in revision.c), so do that in this
patch too.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/submodule--helper.c | 16 ++++++++++------
 object-name.c               |  4 ++--
 refs.c                      | 34 ++++++++++++++++++----------------
 refs.h                      | 10 +++++-----
 revision.c                  | 12 ++++++------
 submodule.c                 | 10 ++++++++--
 6 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6718f202db..1cc43adfd1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -827,15 +827,16 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
-		struct ref_store *refs = get_submodule_ref_store(path);
+		struct repository subrepo;
 
-		if (!refs) {
+		if (repo_submodule_init(&subrepo, the_repository, path, null_oid())) {
 			print_status(flags, '-', path, ce_oid, displaypath);
 			goto cleanup;
 		}
-		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
+		if (refs_head_ref(&subrepo, handle_submodule_head_ref, &oid))
 			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
+		repo_clear(&subrepo);
 
 		print_status(flags, '+', path, &oid, displaypath);
 	} else {
@@ -1044,9 +1045,12 @@ static void generate_submodule_summary(struct summary_cb *info,
 
 	if (!info->cached && oideq(&p->oid_dst, null_oid())) {
 		if (S_ISGITLINK(p->mod_dst)) {
-			struct ref_store *refs = get_submodule_ref_store(p->sm_path);
-			if (refs)
-				refs_head_ref(refs, handle_submodule_head_ref, &p->oid_dst);
+			struct repository subrepo;
+
+			if (!repo_submodule_init(&subrepo, the_repository, p->sm_path, null_oid())) {
+				refs_head_ref(&subrepo, handle_submodule_head_ref, &p->oid_dst);
+				repo_clear(&subrepo);
+			}
 		} else if (S_ISLNK(p->mod_dst) || S_ISREG(p->mod_dst)) {
 			struct stat st;
 			int fd = open(p->sm_path, O_RDONLY);
diff --git a/object-name.c b/object-name.c
index 3263c19457..00df1c8ddb 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1822,8 +1822,8 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 
 			cb.repo = repo;
 			cb.list = &list;
-			refs_for_each_ref(get_main_ref_store(repo), handle_one_ref, &cb);
-			refs_head_ref(get_main_ref_store(repo), handle_one_ref, &cb);
+			refs_for_each_ref(repo, handle_one_ref, &cb);
+			refs_head_ref(repo, handle_one_ref, &cb);
 			commit_list_sort_by_date(&list);
 			return get_oid_oneline(repo, name + 2, oid, list);
 		}
diff --git a/refs.c b/refs.c
index 6ed64bee1b..c04b2c1462 100644
--- a/refs.c
+++ b/refs.c
@@ -408,34 +408,34 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 	for_each_rawref(warn_if_dangling_symref, &data);
 }
 
-int refs_for_each_tag_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_tag_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/tags/", fn, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/tags/", fn, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_tag_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_tag_ref(the_repository, fn, cb_data);
 }
 
-int refs_for_each_branch_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_branch_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/heads/", fn, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/heads/", fn, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_branch_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_branch_ref(the_repository, fn, cb_data);
 }
 
-int refs_for_each_remote_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_remote_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(refs, "refs/remotes/", fn, cb_data);
+	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/remotes/", fn, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_remote_ref(the_repository, fn, cb_data);
 }
 
 int head_ref_namespaced(each_ref_fn fn, void *cb_data)
@@ -1395,12 +1395,12 @@ int refs_rename_ref_available(struct ref_store *refs,
 	return ok;
 }
 
-int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_head_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
 
-	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
+	if (!refs_read_ref_full(get_main_ref_store(repo), "HEAD", RESOLVE_REF_READING,
 				&oid, &flag))
 		return fn("HEAD", &oid, flag, cb_data);
 
@@ -1409,7 +1409,7 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 
 int head_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_head_ref(the_repository, fn, cb_data);
 }
 
 struct ref_iterator *refs_ref_iterator_begin(
@@ -1498,14 +1498,14 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 					do_for_each_ref_helper, &hp);
 }
 
-int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, the_repository, 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(repo), "", fn, 0, repo, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_ref(the_repository, fn, cb_data);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
@@ -1896,13 +1896,15 @@ static struct ref_store *ref_store_init(const char *gitdir,
 
 struct ref_store *get_main_ref_store(struct repository *r)
 {
+	unsigned flags = r == the_repository ?
+		REF_STORE_ALL_CAPS : REF_STORE_READ | REF_STORE_ODB;
 	if (r->refs_private)
 		return r->refs_private;
 
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r->gitdir, flags);
 	r->refs_private = maybe_debug_wrap_ref_store(r->gitdir, r->refs_private);
 	return r->refs_private;
 }
diff --git a/refs.h b/refs.h
index 48970dfc7e..b53cae717d 100644
--- a/refs.h
+++ b/refs.h
@@ -316,17 +316,17 @@ typedef int each_repo_ref_fn(struct repository *r,
  * modifies the reference also returns a nonzero value to immediately
  * stop the iteration. Returned references are sorted.
  */
-int refs_head_ref(struct ref_store *refs,
+int refs_head_ref(struct repository *repo,
 		  each_ref_fn fn, void *cb_data);
-int refs_for_each_ref(struct ref_store *refs,
+int refs_for_each_ref(struct repository *repo,
 		      each_ref_fn fn, void *cb_data);
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data);
-int refs_for_each_tag_ref(struct ref_store *refs,
+int refs_for_each_tag_ref(struct repository *repo,
 			  each_ref_fn fn, void *cb_data);
-int refs_for_each_branch_ref(struct ref_store *refs,
+int refs_for_each_branch_ref(struct repository *repo,
 			     each_ref_fn fn, void *cb_data);
-int refs_for_each_remote_ref(struct ref_store *refs,
+int refs_for_each_remote_ref(struct repository *repo,
 			     each_ref_fn fn, void *cb_data);
 
 /* just iterates the head ref. */
diff --git a/revision.c b/revision.c
index 31fc1884d2..ec9baf9508 100644
--- a/revision.c
+++ b/revision.c
@@ -1567,7 +1567,7 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 
 static void handle_refs(struct ref_store *refs,
 			struct rev_info *revs, unsigned flags,
-			int (*for_each)(struct ref_store *, each_ref_fn, void *))
+			int (*for_each)(struct repository *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 
@@ -1577,7 +1577,7 @@ static void handle_refs(struct ref_store *refs,
 	}
 
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(refs, handle_one_ref, &cb);
+	for_each(revs->repo, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
@@ -2551,14 +2551,14 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
 	return status;
 }
 
-static int for_each_bad_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+static int for_each_bad_bisect_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(refs, fn, cb_data, term_bad);
+	return for_each_bisect_ref(get_main_ref_store(repo), fn, cb_data, term_bad);
 }
 
-static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+static int for_each_good_bisect_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return for_each_bisect_ref(refs, fn, cb_data, term_good);
+	return for_each_bisect_ref(get_main_ref_store(repo), fn, cb_data, term_good);
 }
 
 static int handle_revision_pseudo_opt(struct rev_info *revs,
diff --git a/submodule.c b/submodule.c
index ecda0229af..bdaeb72e08 100644
--- a/submodule.c
+++ b/submodule.c
@@ -92,8 +92,14 @@ int is_staging_gitmodules_ok(struct index_state *istate)
 static int for_each_remote_ref_submodule(const char *submodule,
 					 each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_remote_ref(get_submodule_ref_store(submodule),
-					fn, cb_data);
+	struct repository subrepo;
+	int ret;
+
+	if (repo_submodule_init(&subrepo, the_repository, submodule, null_oid()))
+		return 0;
+	ret = refs_for_each_remote_ref(&subrepo, fn, cb_data);
+	repo_clear(&subrepo);
+	return ret;
 }
 
 /*
-- 
2.33.0.464.g1972c5931b-goog

