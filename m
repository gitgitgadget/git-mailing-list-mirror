Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDA9CD8CB6
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 19:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343689AbjJJTtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343602AbjJJTtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2023 15:49:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6193
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-317c3ac7339so5500737f8f.0
        for <git@vger.kernel.org>; Tue, 10 Oct 2023 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696967382; x=1697572182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=154bE9KJoUCTrw59JYmt2NXfs8pHTYjA8vr/gihdLDM=;
        b=HCJZAfYHCh10rv8cbYpdqFKuG/I9mayIb2jW6bD2hRs5enla3//21xzEdxQfgvQd7i
         e2cN5iSJZZbBWCrJ9vAiA8V26OYThBF9MZ7mU1i+JGVtNuPgDrsGco95Ah2eSTD1fFlO
         NX9lWqGcVmPzlO/JyOx88j6JUo63kNOp0XTL4xuPA11FCI1nET/m0KAvLBHGUjg4uK/3
         Y6D5st+Fr+76Gjy+nbOGJdm7+bDdI7RcsfX8H7mJ+XDySHQ0nDUTZ7oHk7+mcj4r25AZ
         oPyBmkNXPYfbhJmJqbNEYVELgl3UJoTZqxZz057WxIxzbEBbHjwXxtewJ5bt+1sO9DBv
         Yc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696967382; x=1697572182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=154bE9KJoUCTrw59JYmt2NXfs8pHTYjA8vr/gihdLDM=;
        b=poSw7N2a3kiMrgdLAH1sEDz58nFvJwEMtVI8EpJDqLqlzqN+0udjCnptL7NQtCCtJh
         Ujjg3UxhZJ56bDUxs7zaWphnt8vro3lXZvHRbz4i/Hcbx+AWWKsceptQsnm4lkGUz1Oz
         FUEVAe0E8LNSaPEjw8Q0jLLn4svokFLgiM+mqgVGBCgxCy+lXFs4IyrQt/v3az3qUVi5
         VETmRZjuCxZjHN5l/K3aRAg9dXuMMKjO97YeBeL/uyZnSpeUdiZHbI64JHRFu0lJzKks
         biyvncCKPgzcUk8GczwfCLZLJtWNhWXazAidIm57vAHpBEAAISZ6QtpY0LWMBUG8mKMK
         i5+g==
X-Gm-Message-State: AOJu0Yxfdvz9WT36JrcUXzvDF7IzYUQMrswhFU2HhFR6kvhDNFDMW/3W
        ONYxmcK0Ocfrqx9p+N77VK3YS4gmCrs=
X-Google-Smtp-Source: AGHT+IENeZd0JnS4xC3sq1lDv3AMsZ4o3U2e50PCgb85eru9BHWI/+7zxjIjcyuy6BETCDpOsvATgw==
X-Received: by 2002:a05:6000:1046:b0:31f:f9fe:e739 with SMTP id c6-20020a056000104600b0031ff9fee739mr17130649wrx.59.1696967382327;
        Tue, 10 Oct 2023 12:49:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020a5d6345000000b0032326908972sm13347957wrw.17.2023.10.10.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:49:42 -0700 (PDT)
Message-ID: <cef206d47c724f54220b0b915e5405b48f5eb2cb.1696967380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
References: <pull.1577.v2.git.git.1696443502.gitgitgadget@gmail.com>
        <pull.1577.v3.git.git.1696967380.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Oct 2023 19:49:39 +0000
Subject: [PATCH v3 1/2] attr: read attributes from HEAD when bare repo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The motivation for 44451a2e5e (attr: teach "--attr-source=<tree>" global
option to "git" , 2023-05-06), was to make it possible to use
gitattributes with bare repositories.

To make it easier to read gitattributes in bare repositories however,
let's just make HEAD:.gitattributes the default. This is in line with
how mailmap works, 8c473cecfd (mailmap: default mailmap.blob in bare
repositories, 2012-12-13).

Signed-off-by: John Cai <johncai86@gmail.com>
---
 attr.c                  | 12 +++++++++++-
 t/t0003-attributes.sh   | 14 ++++++++++++++
 t/t5001-archive-attr.sh |  2 +-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index 71c84fbcf86..bf2ea1626a6 100644
--- a/attr.c
+++ b/attr.c
@@ -1194,6 +1194,7 @@ static void collect_some_attrs(struct index_state *istate,
 }
 
 static const char *default_attr_source_tree_object_name;
+static int ignore_bad_attr_tree;
 
 void set_git_attr_source(const char *tree_object_name)
 {
@@ -1205,10 +1206,19 @@ static void compute_default_attr_source(struct object_id *attr_source)
 	if (!default_attr_source_tree_object_name)
 		default_attr_source_tree_object_name = getenv(GIT_ATTR_SOURCE_ENVIRONMENT);
 
+	if (!default_attr_source_tree_object_name &&
+	    startup_info->have_repository &&
+	    is_bare_repository()) {
+		default_attr_source_tree_object_name = "HEAD";
+		ignore_bad_attr_tree = 1;
+	}
+
 	if (!default_attr_source_tree_object_name || !is_null_oid(attr_source))
 		return;
 
-	if (repo_get_oid_treeish(the_repository, default_attr_source_tree_object_name, attr_source))
+	if (repo_get_oid_treeish(the_repository,
+				 default_attr_source_tree_object_name,
+				 attr_source) && !ignore_bad_attr_tree)
 		die(_("bad --attr-source or GIT_ATTR_SOURCE"));
 }
 
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 26e082f05b4..e6b1a117228 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -342,6 +342,20 @@ test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	)
 '
 
+
+test_expect_success 'bare repo defaults to reading .gitattributes from HEAD' '
+	test_when_finished rm -rf test bare_with_gitattribute &&
+	git init test &&
+	(
+		cd test &&
+		test_commit gitattributes .gitattributes "f/path test=val"
+	) &&
+	git clone --bare test bare_with_gitattribute &&
+	echo "f/path: test: val" >expect &&
+	git -C bare_with_gitattribute check-attr test -- f/path >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare repository: with --source' '
 	(
 		cd bare.git &&
diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
index 0ff47a239db..eaf959d8f63 100755
--- a/t/t5001-archive-attr.sh
+++ b/t/t5001-archive-attr.sh
@@ -138,7 +138,7 @@ test_expect_success 'git archive with worktree attributes, bare' '
 '
 
 test_expect_missing	bare-worktree/ignored
-test_expect_exists	bare-worktree/ignored-by-tree
+test_expect_missing	bare-worktree/ignored-by-tree
 test_expect_exists	bare-worktree/ignored-by-worktree
 
 test_expect_success 'export-subst' '
-- 
gitgitgadget

