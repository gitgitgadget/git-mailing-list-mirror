Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE025C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71326115A
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhIUQxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhIUQw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0FC0613D5
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d2-20020a17090a2a4200b001994a2b5092so3379191pjg.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a1fuzx4gkeES1caU7MU1V9eOWhufggwMC/r9KdiNK58=;
        b=Paz7F5kUI0hyYS1+CBSA9Fzo+7uWhc+hdmY4YPYs6ZEAeP0LY2cUnhAFyaAjPE9J3n
         i9VowIcUUg7wIJC8xIezke+zbUutTh9uP3YJmrXApNAAJhcmYrWw4wfm5k8ERFd51t3+
         dYMpswuKdAaeXrdM4yQFWljGyZrSS7PAWval3thuuAre1G4UG+5DmlaxOekxYxv6Eaxf
         MxERZG3xZ7oex3nJarauDrUmySmk5uQSZ/de16OXbQq0EKd24xHuTAlvGBo0YU0j774g
         Fyg7WflkbNHFGENFYEDYpJx9x9PPaKl6+T9cHkgpkRm3W0oMqe6CW8CoF0n8tFs3I7rZ
         mfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a1fuzx4gkeES1caU7MU1V9eOWhufggwMC/r9KdiNK58=;
        b=GMSndgKTGg1C9k+CdthMJIOYKhXynuugE5Mll1SuWvNXFHeewNnbEVS9FraIONutNB
         8S/6A33NCYhqc+Th+W0hytDmr2h++9L6UylaOxkEZdX8xZNy0761n8M2/v5hM1L0ms77
         FLW7DeUN+n53iWw9XuC1fXerksUO+12FFRr55YVrQQhShTJQY0pTkcXPOjtQAKlfvBw1
         D6Cxe/XIzumMhiX+U3gfGqcjHzLA0V0Tde1YoaHGwjhRN2teSHkueCjub/nJuqr37q7G
         Jvnx1FyEuTT8bWsyb4kT8JnbxlGW7HswKq7ubf4NhF8vfJf2TvRwofGfCpWBCp7x/2EN
         N6GQ==
X-Gm-Message-State: AOAM531KJX+uVNk+1k3DdPPW03RLhExBzjl+CV5KN+TC4USMUYtONr9z
        vrLxoh95H1f1gXuOUSdjiyawWBI6iiDLDLlxL68ZCmhHNU45QyOUTGtXlHiuNqeB3xV4zZP6HXp
        ZGE7wgZKrsuWx411be4NjA4cYZiMg29QDEuxdk8Rv3CHkXA1RV1yB/I3ni/i5Dm5tVyD4YKbw8c
        ps
X-Google-Smtp-Source: ABdhPJw9K9hPlH2YTqxRM4lO+72Q6JGyHz1dTr9SGi1Fyh3evg42CUADRvH4QX+qvFGskFIcThvBFNcrJTJaP59ET5fh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c184:b0:13c:957d:63f1 with
 SMTP id d4-20020a170902c18400b0013c957d63f1mr4091002pld.32.1632243086082;
 Tue, 21 Sep 2021 09:51:26 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:10 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <efebc4e97ddf02cf3f1f6173e6edb42241aaf230.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 8/9] refs: change refs_for_each_ref_in() to take repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index c04b2c1462..b011953e32 100644
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
@@ -1508,15 +1508,15 @@ int for_each_ref(each_ref_fn fn, void *cb_data)
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
 
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
diff --git a/refs.h b/refs.h
index b53cae717d..fe290317ae 100644
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
2.33.0.464.g1972c5931b-goog

