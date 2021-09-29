Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A538C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FFF613D1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbhI2XIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347491AbhI2XIT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:19 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F608C06176A
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:37 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i16-20020a05620a249000b004558dcb5663so11404793qkn.9
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=smbPE0TA5LqvS+QpmW53LXNmH1qb8vXzeQqdphCFYc0=;
        b=iQNtoBbNvrm7UObUitteRY22u5UaxMO9T2vFG9Vjpx7j7HcZNY99ZnTyQolfaHolVF
         J554N0+7bEMmtZ57wYGuzyBTbM3gps9O7RQeZjPh+/PRnt7401lbRO/SKHgrKf9cy6X/
         Rh7io5nnD23nyGLwxs4eMtDxDDyTpWxUbT0JmiIdrmXHMhuLNEmeOUyXM3CsklhY6Ag4
         Em+ZIQS+DxQYDIy9dDWEQb6+jP8YyfDNvFElHCPJx7arSQyICLTsjHVhYtl1eBbwRq9I
         eCH3f8dTsRXrl7vNfqNE2CQiy9KCR2PNMMv+03ZZdbNTY9KrATDlHmlibZtXhKL3Avxn
         l+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=smbPE0TA5LqvS+QpmW53LXNmH1qb8vXzeQqdphCFYc0=;
        b=kAELQp9Qi9HRJrD3BrthEbij/fCxU/sWH7hNjEJBmG/PM28TVBHWxKkWzhU0qxQAiI
         H7arLOXSFaEw0tDT3wU2/PumzUMFiJnPtwL8d3QjM0LEMlPfr7XDg9d7OHW7ikN6vLq8
         eqOo8IGOeVj3oU3iLZY6ni1O8TlzNHjubGdJM97DtZe+MZmc9QMEfMX7yDtYxvW+OnxL
         A5YSZ9Kf8kXFQvBWo7igLPJX+ZxJ30wncA7VzqNXzSmaH/ayEq2zaSeNjW5HxB8dMGgj
         +Q1KPsBTA9UAJVNF79JTO2yDUdY7R5ZF3A/qzD6zJTdoclBnVV/BLF8/907+c+1/2fkO
         PDig==
X-Gm-Message-State: AOAM533hdNZC2LuVQM0JZxrpSC+q05RCwj7Zz3o4E5d2iaX9e7ne3lGG
        KEdO5pyrws7C3aHY8nPbtnuYX7obNw3q7roVeQKrp00Gc/8lfKWTqRC0wsfwGXo3nf17f/G44f4
        XsAFd/CzC1oYrUZuFjJXNN0GyGQw0aDEegu+g0PFy5Fr7NwQHKpEB32AOaChJtoaEUmchgvWI3d
        AO
X-Google-Smtp-Source: ABdhPJwyMwFc3ZzTSO1ntCZkXGWOi//AmAJ74YMuwprXo8pPx47furkyfsILMsjwTcyjyxmBcdOjL4lNiA/TH19PWhnm
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:914:: with SMTP id
 dj20mr998653qvb.50.1632956796664; Wed, 29 Sep 2021 16:06:36 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:22 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <7a6a1ee5f93456897fb333551f6769a6b9127c63.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 6/7] submodule: pass repo to check_has_commit()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the repo explicitly when calling check_has_commit() to avoid
relying on add_submodule_odb(). With this commit and the parent commit,
the last remaining tests no longer rely on add_submodule_odb(), so mark
these tests accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c                            | 16 +++++++++++++---
 t/t5526-fetch-submodules.sh            |  3 +++
 t/t5531-deep-submodule-push.sh         |  3 +++
 t/t5545-push-options.sh                |  3 +++
 t/t5572-pull-submodule.sh              |  3 +++
 t/t7418-submodule-sparse-gitmodules.sh |  3 +++
 6 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 62beb8fd5f..4bf552b0e5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -928,23 +928,33 @@ struct has_commit_data {
 static int check_has_commit(const struct object_id *oid, void *data)
 {
 	struct has_commit_data *cb = data;
+	struct repository subrepo;
+	enum object_type type;
 
-	enum object_type type = oid_object_info(cb->repo, oid, NULL);
+	if (repo_submodule_init(&subrepo, cb->repo, cb->path, null_oid())) {
+		cb->result = 0;
+		goto cleanup;
+	}
+
+	type = oid_object_info(&subrepo, oid, NULL);
 
 	switch (type) {
 	case OBJ_COMMIT:
-		return 0;
+		goto cleanup;
 	case OBJ_BAD:
 		/*
 		 * Object is missing or invalid. If invalid, an error message
 		 * has already been printed.
 		 */
 		cb->result = 0;
-		return 0;
+		goto cleanup;
 	default:
 		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
 		    cb->path, oid_to_hex(oid), type_name(type));
 	}
+cleanup:
+	repo_clear(&subrepo);
+	return 0;
 }
 
 static int submodule_has_commits(struct repository *r,
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ed11569d8d..2dc75b80db 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -6,6 +6,9 @@ test_description='Recursive "git fetch" for submodules'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 
 pwd=$(pwd)
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
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 4f92a116e1..fa6b4cca65 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -2,6 +2,9 @@
 
 test_description='pull can handle submodules'
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
 
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-sparse-gitmodules.sh
index 3f7f271883..f87e524d6d 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -12,6 +12,9 @@ The test setup uses a sparse checkout, however the same scenario can be set up
 also by committing .gitmodules and then just removing it from the filesystem.
 '
 
+GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
+export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
+
 . ./test-lib.sh
 
 test_expect_success 'sparse checkout setup which hides .gitmodules' '
-- 
2.33.0.685.g46640cef36-goog

