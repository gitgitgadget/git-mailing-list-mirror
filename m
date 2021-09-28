Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0019CC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD95C611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhI1UM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242694AbhI1UMz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:55 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E8FC061746
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:15 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q10-20020a05620a0d8a00b0045de482ae16so55588947qkl.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FMo5m71X/pOjr4FDnJntl6CMsU98+1MECDqIZbL7WCs=;
        b=YMzmeavS6cF19MYJB3dvvk0cMJtZmS3rNu88nquvpR9wncXtxbFbWwJv4Dv1kMHafR
         xFKHJ5WTDsCB9Cpa4DSZfXNLet/LxGOfeIcA5UCBV7YBOF40MkIjb2fVPSugjpMSWs24
         +dC+2pVqky8wa53f++O2hqbHunvekJobVi4GyqZvUXxTSvzGmAegxD/39QA54B79HoCX
         O1yTScytK4c4UJnuJTk8X2RvH1LeTNqLSEEQYeQMIqtXX1Y2mLfF0TrQFOT08KZu5inq
         pjjXczLGTvYQk3qi86y2tpIvZ+7DKCiDq2iYzp87pbVIGJI/Bg/im5sGbyy51jt1yl/j
         FAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FMo5m71X/pOjr4FDnJntl6CMsU98+1MECDqIZbL7WCs=;
        b=Bhi9/xNeTwdnMK+Mtym89Pf+L73CabnYohMN8UQJZixsRojDUyeSL2NA9rdPPP5KNp
         x1Lf/cNskBKyPhF77dAMWW6U0SElZy2KIjLHowRq9GtL2xUbvdHkrQ/Kp+emgYzKHvvi
         GHiNCUa/sUeRnBsoiQqFyKdDD3Uvbq9Ux7HJYD/UZA5waceMxC/b6RnOQpDsrvC3TrpG
         P2/upHFcP06KVD9sDGo8Ea+qnE2l5uP18YA6CWQIWa3yyBsPo4IJHfwR8BEgdCtybL6O
         cWlECcgNNhyuGfe0a5WqwdHg4o4YBHnRq9FEN3C0yoDHXE1Ghs8OCDK7PCAoPaifn9DS
         FLrw==
X-Gm-Message-State: AOAM531MQtLA1/uS+u2D5mD9DIAREfHUsKn3DHXkdQXZQ1p0IzJKzh3L
        nOeXsYVOS0BG+v8YGcTGt7HpyONitHZ8+BzJhymRSdGlStky9sPwUn2UmW1G6J3YlJULcUZKhAV
        y02OHqJ+gR+AOQHuZcYss3ykFExrNpPTB8hf/jOiswb6+suO9kvZs8SjgLH3oK51E9ZNoZOgbvq
        9W
X-Google-Smtp-Source: ABdhPJxgNVRxMDrDpeMS8pCoafpiyesKLZU7hm0dpup3O1sxq/qvZ0x5Ey5XmLMn28Yti4gLlMAom5G10+0FE/GAVfmG
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:e1cf:: with SMTP id
 v15mr1678836qvl.32.1632859874369; Tue, 28 Sep 2021 13:11:14 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:53 -0700
In-Reply-To: <cover.1632859147.git.jonathantanmy@google.com>
Message-Id: <1fca3b1a2582e86fdc16b5f9db0f3c446b94a56f.1632859148.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632859147.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 7/9] submodule: pass repo to check_has_commit()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the repo explicitly when calling check_has_commit() to avoid
relying on add_submodule_odb(). With this commit and the parent commit,
several tests no longer rely on add_submodule_odb(), so mark these tests
accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c                            | 16 +++++++++++++---
 t/t5526-fetch-submodules.sh            |  3 +++
 t/t5572-pull-submodule.sh              |  3 +++
 t/t7418-submodule-sparse-gitmodules.sh |  3 +++
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index bc3ec4a242..992890321a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -934,23 +934,33 @@ struct has_commit_data {
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

