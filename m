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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0FC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B2D600D3
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhIUQxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhIUQw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE2BC061764
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:25 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id m26-20020a62a21a000000b0041361973ba7so16362583pff.15
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QxVqJLdL9x7T+9x1SfsbuzHBfmYKfIpr6EbDbIq6+vI=;
        b=IWSEAQjQLcpDUH3H01UeDPcWTw53spfYKiAnSHqcM2w3qqZegZqhS54AJJ/Xcpny3F
         FyAViMM5YSrRlcw7mJJjjCZZukBtfBeIx/nA58vqnmONXl7uGb7+SfkjcxLSfrd1oQ2Z
         a+9lahfHSSL2UkXabR54Aj1ohpiNvTtC517/yZwfdD2mtzpAFLpmbMVYZi7hp30YuKEJ
         2cjlFnUkqyzV6nv8rNtbvqLn09gGHFrYTOnvUA4d7uHgt0z1y97ZkycqQaiDSebbH2ig
         /wjmyiIQaBhlH3tYkwps7ysKoOZafLoVTETX3uD86JW8py5AC/HxbjOPwwHoGw/5Fvwy
         T5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QxVqJLdL9x7T+9x1SfsbuzHBfmYKfIpr6EbDbIq6+vI=;
        b=ylRiV194JN4OKRBKcXoqHt9xmtTIkrC5/sk04NV5+KIUY7WJljcdNGsUb9JIFhZmbw
         R2CsdQgpaqmbLZMFjpnVmcSfIuVtklIluPcPBK5ozU8sswj7GRcTuLlb8Fh4UkT39QE7
         t3qXG//YuDaW3u4dFLY+Mc9CndGzDHaB2FOqh00Dx0/CBmz+NEq8qZaIpPga4iWYJTNB
         wGjpGhTc3JKjQjSBuwXLXIknkWGNLKTTC0fWy8C9UCXh22x9T8i87M+IrOzioE/I3I9q
         n6BJ5yuDVOwLsgBOn7X3s1mULyDRQ4YUg52DnbTvaur/OOaTRvdvFRBPzyxvjAjtr8p4
         /k2w==
X-Gm-Message-State: AOAM533uFhAxc2IynM76rgsQwUYs1NgBA+vj3pLyglgfmwmv13SAUBLp
        FUxgPImQZwUxf9n8nrnIT6/eJTcDjWwoLga0W6oqTmSqeb3h26I8UPRpOldUdvCCMHSZDIebOL9
        kjCK/gRansoKPZ0Zjvx5ZaD+3FGRMG/PAjfms3TBccjMMm4RXpmhBIOhwgLWmlm+zXe6qJ1/Rd8
        Gh
X-Google-Smtp-Source: ABdhPJwQKk8OyxAIaJ04GyL7kleTly+mOb84lyzwzWrlw/BIaE7shvrOEEZmdZFxPe3eIFqS9Ic+BYnYb+OaC+1NIsI1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:7613:b0:13d:b35f:b4d7 with
 SMTP id k19-20020a170902761300b0013db35fb4d7mr9144462pll.8.1632243084778;
 Tue, 21 Sep 2021 09:51:24 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:09 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <20adc937b736df67edf9533edcf96070b7724774.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 7/9] submodule: pass repo to check_has_commit()
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
index bdaeb72e08..e9757376c2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -917,23 +917,33 @@ struct has_commit_data {
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
2.33.0.464.g1972c5931b-goog

