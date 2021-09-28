Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A667EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A39961157
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242676AbhI1UMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242636AbhI1UMu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E4CC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y134-20020a25dc8c000000b0059f0301df0fso125835ybe.21
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xAdwh07H3YlOWaAh1TOVRQyYoBNTR4+AQbg29FSVGHI=;
        b=Lk1PlfFkvefHdacV8wRE/821AwluWMXJlHxBXwNiLUBJIfod/qCMsaQl6eGa+8MQxT
         s4eU+h10w6FUdzHKzpnEYwnFWMCUqJ5fE9ao5pPVd4zs5pn1DUmZrm5RSZO1Srqq+5pN
         d5OkzDx/IB5J0oAWuQ9Iwk8hiyTEu2PBSby5Q4FuCtklBZKFhpB5LK4+rfq+pjS9s0CU
         ankDwe5Zz3m0WE151NIMb8awImt+qw/QkXnwVzQ9yIoFxZwkKKAELDgqNN/RwBEx2bUD
         jkh2E/PDZ77mwbhc5VO84xE/+epfQKd4a00pxBw29QllShsABX4156n795urtvet1u1K
         ggpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xAdwh07H3YlOWaAh1TOVRQyYoBNTR4+AQbg29FSVGHI=;
        b=GG6OxEBnI+fE915+JuYQLEK97pg1f99fWwbDkTrfeHbGBYrKRsM8kUJiGbX2xXZlfU
         0tMUzj46DodwEiTC6gXRLVQqM/8ugSeV36I4/p++iwtDsnmEQFEdUSmvKfW03Gf4wJB7
         MzJCrEiv7CewacxolDrgREMRrDGZ+w/kE6EZwS8z5YbT7D+VnlbATbSQWk7wzwoeTW/6
         H5uK27SIV5WCHdZbhlzi45OSNBfLuAA5PPLmJ0txfccOLVUAV6fKPiKuRDgygFVSi++l
         HY+06JKEeNJ0TTNHH0LN1ygsDGc1YsIs7lrUywdJVgZhbjxEByodrKUoDmlzBCkpg8Ye
         bIwQ==
X-Gm-Message-State: AOAM532e8FhYnrhjDeO8e/gjbx+KHr4KPlvyztkqn0wEDYzdZm9DKtsS
        k0mGngqzbCRKoVfLFhKRmGkcGGxke1/a1AwM0ooAIgynU0HMQQJ+b7kMCtIMxkjI+58G5pYYGYc
        2kR99dU2QRUOz0FBAWIwzRkCC7pQbaTdZ7gkRhMa1Q+XDy65EuU05tzlgTRyh6SZcUMMltC1ZyR
        Vt
X-Google-Smtp-Source: ABdhPJyicaJ7yyAlexgAtFxcMFc0PIUo72wzyao9ATkKle3hZVrr1PQ3RzMY100cczQBrVeagfbc8TFz9vy+8ihRFjjf
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:9941:: with SMTP id
 n1mr8409685ybo.247.1632859869850; Tue, 28 Sep 2021 13:11:09 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:50 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <da0c9c2d44da40e25c2c5b68697e3461cefd63a5.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 4/9] refs: teach refs_for_each_ref() arbitrary repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
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
 builtin/submodule--helper.c | 16 +++++++-----
 object-name.c               |  4 +--
 refs.c                      | 49 ++++++++++++++++++++-----------------
 refs.h                      | 10 ++++----
 revision.c                  | 12 ++++-----
 submodule.c                 | 10 ++++++--
 6 files changed, 57 insertions(+), 44 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 88ce6be69c..d951b7acc5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -801,15 +801,16 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
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
@@ -1018,9 +1019,12 @@ static void generate_submodule_summary(struct summary_cb *info,
 
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
index fdff4601b2..f3012b5ec3 100644
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
index 5163e064ae..15a3aa47cf 100644
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
@@ -1489,6 +1489,7 @@ static int do_for_each_ref_helper(struct repository *r,
 
 static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 			   each_ref_fn fn, int trim,
+			   struct repository *repo,
 			   enum do_for_each_ref_flags flags, void *cb_data)
 {
 	struct ref_iterator *iter;
@@ -1497,26 +1498,26 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs_ref_iterator_begin(refs, prefix, trim, the_repository, flags);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, repo, flags);
 
-	return do_for_each_repo_ref_iterator(the_repository, iter,
+	return do_for_each_repo_ref_iterator(repo, iter,
 					do_for_each_ref_helper, &hp);
 }
 
-int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
+int refs_for_each_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(repo), "", fn, 0, repo, 0, cb_data);
 }
 
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref(get_main_ref_store(the_repository), fn, cb_data);
+	return refs_for_each_ref(the_repository, fn, cb_data);
 }
 
 int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
+	return do_for_each_ref(refs, prefix, fn, strlen(prefix), the_repository, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
@@ -1527,13 +1528,13 @@ int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref(get_main_ref_store(the_repository),
-			       prefix, fn, 0, 0, cb_data);
+			       prefix, fn, 0, the_repository, 0, cb_data);
 }
 
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, 0, 0, cb_data);
+	return do_for_each_ref(refs, prefix, fn, 0, the_repository, 0, cb_data);
 }
 
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
@@ -1549,14 +1550,14 @@ int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
 	int ret;
 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
 	ret = do_for_each_ref(get_main_ref_store(the_repository),
-			      buf.buf, fn, 0, 0, cb_data);
+			      buf.buf, fn, 0, the_repository, 0, cb_data);
 	strbuf_release(&buf);
 	return ret;
 }
 
 int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, "", fn, 0,
+	return do_for_each_ref(refs, "", fn, 0, the_repository,
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
@@ -1891,13 +1892,15 @@ static struct ref_store *ref_store_init(const char *gitdir,
 
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
index 10e7696a64..e9ecb5e54e 100644
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
index 3ad217f2ff..cd34e12b2e 100644
--- a/revision.c
+++ b/revision.c
@@ -1565,7 +1565,7 @@ void add_ref_exclusion(struct string_list **ref_excludes_p, const char *exclude)
 
 static void handle_refs(struct ref_store *refs,
 			struct rev_info *revs, unsigned flags,
-			int (*for_each)(struct ref_store *, each_ref_fn, void *))
+			int (*for_each)(struct repository *, each_ref_fn, void *))
 {
 	struct all_refs_cb cb;
 
@@ -1575,7 +1575,7 @@ static void handle_refs(struct ref_store *refs,
 	}
 
 	init_all_refs_cb(&cb, revs, flags);
-	for_each(refs, handle_one_ref, &cb);
+	for_each(revs->repo, handle_one_ref, &cb);
 }
 
 static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
@@ -2553,14 +2553,14 @@ static int for_each_bisect_ref(struct ref_store *refs, each_ref_fn fn,
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
index 62beb8fd5f..bc3ec4a242 100644
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
2.33.0.685.g46640cef36-goog

