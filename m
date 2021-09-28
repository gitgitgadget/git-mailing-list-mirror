Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098C9C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E784061157
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242701AbhI1UM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242704AbhI1UM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEDDC061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso273480ybn.2
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9xyF0CgCOMC2vT/7bwiznBEaq3BRY7cRpKzeixQeiUI=;
        b=bA/kArt+yvHNVxZJ23NUyN/p9JGpG+Neu59iaOb992v5rJb88b0L1nbADUptBL7XtJ
         bFKLiJWbs18pTH6Xvf3ha+8aA4mau/1Jmkt1FmAhNQ42l3erkO8SP960vtOQgfQEzEAu
         btPOXXvAzTDD16bonRjJqBVPTCOTD1DhfJ2+8Z6zkPuuFWk2XviV6e5MbrVCMi4VqzGx
         zYufgqatlc4d5OYYxcomGnbFjeFYnOMC0hJgFUKSoVgr+VqHhibMf3twRZeC1a+SSSZl
         fTMIquoIgtckn7g1hUkyMhjLiPc/+67oh0lOJFTskgw7tZz1QxLnumqTIg0Tof5yb3Jd
         SK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9xyF0CgCOMC2vT/7bwiznBEaq3BRY7cRpKzeixQeiUI=;
        b=FpDeomf2nJ81HeokVDaYs8uwIFr1vbmdTGLrZNtdfhxNaNzQEDbyKf580bLTKjSmKx
         nA8kVwgfOzC/7tmWwg2sLA3Vdoo+2L9CVIS/qknOjzHPwUPws1FZrNib0Fq8qnByWJY9
         nvsk5Mp4yu/3JDgzzOaWaLH0xsFgpWbM551wrmM/iUUcngFgv5/j30zFHinITR94acFv
         7piqm6hRUj0CvRFziyHcP6C/utLsDO2KBa5xYzqbcMj73yzLpntNtT8jAINwGExngxAO
         pJkR1Mc63ZdvxJmDr4qPhlpK/MFIWU5i1YgM9iyWwB8GG906+PWfD0UCPq18+AsRBAqi
         /S4Q==
X-Gm-Message-State: AOAM530XA5BTGqtoPPTZCDIAYoxUOkbUE4mofH/xDiR12D93+97qOQua
        6rOH0TSVawIm5lfTvbs68tqOKcue4Sq7pTvzk61xXGOlWL24cWRhqX50MQVD/Z+Mi01n/o/922i
        7cPe9gTTmNqHog7mtmw/RBKQu7KOEF3iujIaQEt/dfzNVIBADPynV/vNQHEuGKvzSfgVfptIg0V
        B6
X-Google-Smtp-Source: ABdhPJzUnAxEcodyJKBY4UDeWxfvQIqWkd7l5RKnBImkjcOejmqUy5xJEbEF+2DadgnLsCHaHKM5HrNPCBNZ6q/JezsN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:1989:: with SMTP id
 131mr9209444ybz.429.1632859875951; Tue, 28 Sep 2021 13:11:15 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:54 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <7b5087a14d8e2c5b3cbd837bc95bcea96dded8b9.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 8/9] refs: change refs_for_each_ref_in() to take repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass a repository to refs_for_each_ref_in() so that object accesses
during iteration (done to skip over invalid refs) are made with the
correct repository instead of relying on add_submodule_odb(). With this,
the last remaining tests no longer rely on add_submodule_odb(), so mark
them accordingly.

The test-ref-store test helper needed to be changed to reflect the new
API. For now, just pass the repository through a global variable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs.c                         | 12 ++++++------
 refs.h                         |  2 +-
 t/helper/test-ref-store.c      | 20 +++++++++-----------
 t/t5531-deep-submodule-push.sh |  3 +++
 t/t5545-push-options.sh        |  3 +++
 5 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/refs.c b/refs.c
index 15a3aa47cf..5b0937ac20 100644
--- a/refs.c
+++ b/refs.c
@@ -410,7 +410,7 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_li
 
 int refs_for_each_tag_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/tags/", fn, cb_data);
+	return refs_for_each_ref_in(repo, "refs/tags/", fn, cb_data);
 }
 
 int for_each_tag_ref(each_ref_fn fn, void *cb_data)
@@ -420,7 +420,7 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_branch_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/heads/", fn, cb_data);
+	return refs_for_each_ref_in(repo, "refs/heads/", fn, cb_data);
 }
 
 int for_each_branch_ref(each_ref_fn fn, void *cb_data)
@@ -430,7 +430,7 @@ int for_each_branch_ref(each_ref_fn fn, void *cb_data)
 
 int refs_for_each_remote_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(repo), "refs/remotes/", fn, cb_data);
+	return refs_for_each_ref_in(repo, "refs/remotes/", fn, cb_data);
 }
 
 int for_each_remote_ref(each_ref_fn fn, void *cb_data)
@@ -1514,15 +1514,15 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_ref(the_repository, fn, cb_data);
 }
 
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+int refs_for_each_ref_in(struct repository *repo, const char *prefix,
 			 each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), the_repository, 0, cb_data);
+	return do_for_each_ref(get_main_ref_store(repo), prefix, fn, strlen(prefix), repo, 0, cb_data);
 }
 
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
 {
-	return refs_for_each_ref_in(get_main_ref_store(the_repository), prefix, fn, cb_data);
+	return refs_for_each_ref_in(the_repository, prefix, fn, cb_data);
 }
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
diff --git a/refs.h b/refs.h
index e9ecb5e54e..458d8eddde 100644
--- a/refs.h
+++ b/refs.h
@@ -320,7 +320,7 @@ int refs_head_ref(struct repository *repo,
 		  each_ref_fn fn, void *cb_data);
 int refs_for_each_ref(struct repository *repo,
 		      each_ref_fn fn, void *cb_data);
-int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
+int refs_for_each_ref_in(struct repository *repo, const char *prefix,
 			 each_ref_fn fn, void *cb_data);
 int refs_for_each_tag_ref(struct repository *repo,
 			  each_ref_fn fn, void *cb_data);
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index b314b81a45..1964cb349e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,6 +5,8 @@
 #include "object-store.h"
 #include "repository.h"
 
+static struct repository *repo;
+
 static const char *notnull(const char *arg, const char *name)
 {
 	if (!arg)
@@ -24,18 +26,13 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	if (!argv[0]) {
 		die("ref store required");
 	} else if (!strcmp(argv[0], "main")) {
+		repo = the_repository;
 		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
-		struct strbuf sb = STRBUF_INIT;
-		int ret;
-
-		ret = strbuf_git_path_submodule(&sb, gitdir, "objects/");
-		if (ret)
-			die("strbuf_git_path_submodule failed: %d", ret);
-		add_to_alternates_memory(sb.buf);
-		strbuf_release(&sb);
-
-		*refs = get_submodule_ref_store(gitdir);
+		repo = xmalloc(sizeof(*repo));
+		if (repo_submodule_init(repo, the_repository, gitdir, null_oid()))
+			die("repo_submodule_init failed");
+		*refs = get_main_ref_store(repo);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
 		struct worktree **p, **worktrees = get_worktrees();
 
@@ -52,6 +49,7 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 		if (!*p)
 			die("no such worktree: %s", gitdir);
 
+		repo = the_repository;
 		*refs = get_worktree_ref_store(*p);
 	} else
 		die("unknown backend %s", argv[0]);
@@ -113,7 +111,7 @@ static int cmd_for_each_ref(struct ref_store *refs, const char **argv)
 {
 	const char *prefix = notnull(*argv++, "prefix");
 
-	return refs_for_each_ref_in(refs, prefix, each_ref, NULL);
+	return refs_for_each_ref_in(repo, prefix, each_ref, NULL);
 }
 
 static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index d573ca496a..3f58b515ce 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -5,6 +5,9 @@ test_description='test push with submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
index 58c7add7ee..214228349a 100755
--- a/t/t5545-push-options.sh
+++ b/t/t5545-push-options.sh
@@ -5,6 +5,9 @@ test_description='pushing to a repository using push options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 
 mk_repo_pair () {
-- 
2.33.0.685.g46640cef36-goog

