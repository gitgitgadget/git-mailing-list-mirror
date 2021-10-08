Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C4BC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769C960F5E
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243417AbhJHVKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243392AbhJHVKb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:10:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A9AC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:08:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q7-20020a170902edc700b0013f15c17dd0so1726361plk.23
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5OOpp9SlmF7Gf3zVAe4BgqXPK4NbP23bfkkhNrj9N1A=;
        b=C8OHummbJM67YL0Xrr+9jLvL/IlIPjcPSJUCePbj4suDunjV0nXlz2iyWs9Q9XEEk6
         L+9piimCm/ck5pS0LNzkUATxQuyScKQxMwgwTi+WXOCFmovxOO91mh7X9QKz9pGryAmT
         LVAUheLik5YdcVLw5XiQK6S4NZ4DDvj37JkCWisgdr3ILtVftMIFsrcCn+o15icAplKF
         oHn0cut7toYJVhzu+E3JF/BjLVTfDK2jV34bvxDA34HlsoVRDV0UwBmpe2B9dPJSc7fC
         tC+QhNHXdGoMXPVglhFLei/vbYKUCM9KhSLIe7kiYQSjXN8L7VV52LXmnpI2sL+g1v8z
         3QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5OOpp9SlmF7Gf3zVAe4BgqXPK4NbP23bfkkhNrj9N1A=;
        b=pAhbjbNLHXT4EpMdSp2RHGjwyVO+wD2HS8dE0sTNqW9PoPOyGzG6cwibWE0tQoiEKm
         L6bnDXiOtW6ZGimaoq4xf8HgGsXxrnAdcYYIGFfU7OJYfd5pQw7ewoXh+tRH1iQvsdA+
         gRd3t8+iCqtPI4kMjVwf4xpT0nrtYRdVP5AGr0vmFA1INnEWnYPap+SgDo51AI/98LL0
         IU8LMU/HcQGCYwADqGodwDERDS+obnBwCxtWPiyIyCVyZ444Lpup2oBAKaCTdso0nrFC
         42XHHOgJmWSd65v57NObuYhQgzhjO1MfpMAoyS0jC8JNBciLsLZ/sX1aW/q9Ez5ffU1v
         l8Rw==
X-Gm-Message-State: AOAM5303UDQisQOwMbPMRfEjwr4g00QWdaOXZDvX5KTWabcIAkMnuJCi
        JLaSuOztay00oapjWu35Uh0FfWI1rIjdn0vvYvzOHsOnKgxmJPFLeJKIqDp3L796qAzRMRk/Lsl
        1kKmALEWacCnwaZ7jsGsP9gWK1GXqZiK1uMD1AZtveymwRJzYK+eIDr/kNkKG5FZryoYPsVgUoM
        s4
X-Google-Smtp-Source: ABdhPJxbcuwiF34zqACHVes91gNND0tR0iu0rG7/Lgy/At2fgGb1/qjs23Pcve5JIh9KPcOrIYcax+Q+KnaQGtleq6WL
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:8891:0:b0:44c:255d:391f with
 SMTP id z17-20020aa78891000000b0044c255d391fmr12700229pfe.26.1633727314596;
 Fri, 08 Oct 2021 14:08:34 -0700 (PDT)
Date:   Fri,  8 Oct 2021 14:08:19 -0700
In-Reply-To: <cover.1633727270.git.jonathantanmy@google.com>
Message-Id: <f4241ea2e76c44fb5befd7c265dc0395ffbf95c8.1633727270.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1633727270.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 6/7] submodule: pass repo to check_has_commit()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, carenas@gmail.com,
        chooglen@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the repo explicitly when calling check_has_commit() to avoid
relying on add_submodule_odb(). With this commit and the parent commit,
the last remaining tests no longer rely on add_submodule_odb(), so mark
these tests accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.33.0.882.g93a45727a2-goog

