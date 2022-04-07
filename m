Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F928C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345771AbiDGQja (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345764AbiDGQj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:28 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FA917E340
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:37:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so4608365wms.1
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DzmUocZ4iuz9olzctKUfnjsf3/S6kuVMOEw1uEfYFOA=;
        b=aksUgH0vUkebEX+5Aguszj9/CTmqb23wV7dcoZPK5iEOMU0BotDk/aPolNSIO1EgB0
         m+uDNWbQPFytpkriQrWZiBOIbZ4R6jQlgZO+R04HPQwRm+3wxX7aiVMQdxCnVUwRhN6t
         pWuXEODawGoFbUPKw9XY4KE66vLY/1Csbnzt98m1fISak0anka3U5Yp9IbrcJlUWOMKn
         C6Bon0yDp3hUdhWmoPlCUZYQPyw1WnqYGBZWD+XY+8bjeEOMu2dkU/s4OSFrFZhHDBjq
         L0MjOfHnQuVq9JQ7NC3Lb1gV7fKGqdG2bu6Q8bweH/Olp5qvlQkHQIIwpYaQh/onvJSw
         cu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DzmUocZ4iuz9olzctKUfnjsf3/S6kuVMOEw1uEfYFOA=;
        b=I64Szm6qOOmhgEvteT/ExEMKyHY2p6htyMH/xcDal6Xp9k2qtsok7CtK0lA8C6icB5
         qoR1s6egWOmFDZaL+GArO44jATkY4XOp3lUp6bfJ07L6Lj+YDy9/2fyyoJlsTlSfn0EL
         akpoDU1YAYeXSEq4yTzqnuS9oYWWVaTfyRA9qBkws+/BPQHEW7ORhUty39dg2iSV22i3
         KAOBgy7L/Arr8rHTbY64C2U7X7bYEl+GnBfDQliNX+13FJIE12GDKjLTJHGSTkE3pxz6
         BnbIttcprFcTzFaStovBYJ1RX+Tigcdeetfdw4uic1kwEoG2oYxLnDH0cRJDdvUQLf0A
         sVew==
X-Gm-Message-State: AOAM533JqG/DHkwkXlIV+eetFqlD9qpeTDvf7uM+uxxBuo4mo8DJw7Wh
        m6Sp4FHO4COOa1RzxsUirwSpOBj3lB8=
X-Google-Smtp-Source: ABdhPJwbG/NDvxCoGrgGZG/nfY50naCIt6MDj4qr4HR6CdVbmaqt5RBV2rm41vdzyzSIVAAf+1ziKg==
X-Received: by 2002:a1c:7411:0:b0:38c:b51e:8d7b with SMTP id p17-20020a1c7411000000b0038cb51e8d7bmr12991414wmc.148.1649349445865;
        Thu, 07 Apr 2022 09:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d6488000000b002051f1028f6sm20766167wri.111.2022.04.07.09.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:37:25 -0700 (PDT)
Message-Id: <27ab853a9b4f0a50880c92dd8949d6fe9b7f00ba.1649349442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Apr 2022 16:37:20 +0000
Subject: [PATCH 2/4] show: integrate with the sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git show' command can take an input to request the state of an
object in the index. This can lead to parsing the index in order to load
a specific file entry. Without the change presented here, a sparse index
would expand to a full one, taking much longer than usual to access a
simple file.

There is one behavioral change that happens here, though: we now can
find a sparse directory entry within the index! Commands that previously
failed because we could not find an entry in the worktree or index now
succeed because we _do_ find an entry in the index.

There might be more work to do to make other situations succeed when
looking for an indexed tree, perhaps by looking at or updating the
cache-tree extension as needed. These situations include having a full
index or asking for a directory that is within the sparse-checkout cone
(and hence is not a sparse directory entry in the index).

For now, we demonstrate how the sparse index integration is extremely
simple for files outside of the cone as well as directories within the
cone. A later change will resolve this behavior around sparse
directories.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/log.c                            |  5 +++++
 t/t1092-sparse-checkout-compatibility.sh | 23 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c211d66d1d0..8e2e9912ab9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -661,6 +661,11 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	init_log_defaults();
 	git_config(git_log_config, NULL);
 
+	if (the_repository->gitdir) {
+		prepare_repo_settings(the_repository);
+		the_repository->settings.command_requires_full_index = 0;
+	}
+
 	memset(&match_all, 0, sizeof(match_all));
 	repo_init_revisions(the_repository, &rev, prefix);
 	git_config(grep_config, &rev.grep_filter);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 74792b5ebbc..f6a14e08b81 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1159,12 +1159,20 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_sparse_match git show :folder1/a &&
 
 	# Asking "git show" for directories in the index
-	# does not work as implemented. The error message is
-	# different for a full checkout and a sparse checkout
-	# when the directory is outside of the cone.
+	# changes depending on the existence of a sparse index.
 	test_all_match test_must_fail git show :deep/ &&
 	test_must_fail git -C full-checkout show :folder1/ &&
-	test_sparse_match test_must_fail git show :folder1/
+	test_must_fail git -C sparse-checkout show :folder1/ &&
+
+	git -C sparse-index show :folder1/ >actual &&
+	git -C full-checkout show HEAD:folder1 >expect &&
+
+	# The output of "git show" includes the way we referenced the
+	# objects, so strip that out.
+	test_line_count = 4 actual &&
+	tail -n 2 actual >actual-trunc &&
+	tail -n 2 expect >expect-trunc &&
+	test_cmp expect-trunc actual-trunc
 '
 
 test_expect_success 'submodule handling' '
@@ -1388,6 +1396,13 @@ test_expect_success 'sparse index is not expanded: diff' '
 	ensure_not_expanded diff --cached
 '
 
+test_expect_success 'sparse index is not expanded: show' '
+	init_repos &&
+
+	ensure_not_expanded show :a &&
+	ensure_not_expanded show :deep/a
+'
+
 test_expect_success 'sparse index is not expanded: update-index' '
 	init_repos &&
 
-- 
gitgitgadget

