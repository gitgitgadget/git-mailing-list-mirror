Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA2C43219
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 14:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbhLFOOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 09:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245682AbhLFOOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 09:14:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A2FC061359
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 06:10:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so22646817wrr.8
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 06:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gQ0ypipIOhDEidSqnzGSV2bK/YJ6VXsd7/PALHaW+mw=;
        b=WfZScUjONRy2z6Bzl4odfucv95lrhP5MLU/gDy4hGBVt+TCOlYs6efsJk5Wf/J79NW
         ASAo32zJMIodHeV2Mf5xeEtO96SXhpb55QhiinX9PnTlkr+5mnlsAJdoD03+KZ7D6FkU
         bXSnrPzlOXFy6drSBmsMr2T0tEd5ej+vbZ/98LRUdzgJ/2liH1lpEFwQIM/MTurE8JKK
         qIczO7gCf0UKSaxAvJEf+PuHv2oeeQsZ3PBQ8IrD0tsBPFyl2d5YYAgVUmL0WxurSizA
         zs1xwqBza1/FBU3H3SixWOZsTwggzimuSEZEHG8znH/W3MkcyqZrPZpy/nYKe6xVzUuJ
         F1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gQ0ypipIOhDEidSqnzGSV2bK/YJ6VXsd7/PALHaW+mw=;
        b=S/V1McwowfeiggSc78prUS+fOKZztIDW4v3M3qpIe+W0ADa56De3miJFv5twiw1R5e
         Su9u+K3aNBc4+RqAOklQZ50ykFqO33TlUKaaCYoq/ZRsNSIzDFjkzWNMLruM60oCsuvd
         qVILk9IlMUw3uPxfwb+GA8uOnsSxYguyMdcG0dH+ycHKRbH7r61BSTn08qUdVzbE0Osy
         S90LAFZzYC0kuAXAvr1Vom8hs/HtDZ1nHnVZ1tDu2X4QirmPYn3k/ki5eppFUtyWh7Gn
         bZKIhj3ExH/MXOtp5wnStRa2lk4vkl3+VQIvVApIQRxhc7sn2D7IzUIHd/NK6vtVN//7
         pFkw==
X-Gm-Message-State: AOAM532+Z0IS+UrPw26+JNv7Yr94zpvSXZf8k8oRW6emN+uA2MJtwrBe
        fL0mj150u8mfZWP0jElSt1gOm6D/kG4=
X-Google-Smtp-Source: ABdhPJwG2xw32Vq8XS0zXaiw+STEs6sbH7bSYpm5Af68YH2+OYxRFhpa24VqUCRutfNLnj+4TyaPwQ==
X-Received: by 2002:adf:d4c2:: with SMTP id w2mr43489604wrk.225.1638799839065;
        Mon, 06 Dec 2021 06:10:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm11605856wrs.4.2021.12.06.06.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 06:10:38 -0800 (PST)
Message-Id: <ba05d7d4149bc4e9e931aa225cd1fc013796d7b3.1638799837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1092.v2.git.1638799837.gitgitgadget@gmail.com>
References: <pull.1092.git.1638586534.gitgitgadget@gmail.com>
        <pull.1092.v2.git.1638799837.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 14:10:36 +0000
Subject: [PATCH v2 1/2] t1092: add deeper changes during a checkout
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, vdye@github.com, gitster@pobox.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Extend the repository data in the setup of t1092 to include more
directories within two parent directories. This reproduces a bug found
by users of the sparse index feature with suitably-complicated
sparse-checkout definitions.

Add a failing test that fails in its first 'git checkout deepest' run in
the sparse index case with this error:

  error: Your local changes to the following files would be overwritten by checkout:
          deep/deeper1/deepest2/a
          deep/deeper1/deepest3/a
  Please commit your changes or stash them before you switch branches.
  Aborting

The next change will fix this error, and that fix will make it clear why
the extra depth is necessary for revealing this bug. The assignment of
the sparse-checkout definition to include deep/deeper1/deepest as a
sibling directory is important to ensure that deep/deeper1 is not a
sparse directory entry, but deep/deeper1/deepest2 is.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 16fbd2c6db9..e6aef40e9b3 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -19,6 +19,8 @@ test_expect_success 'setup' '
 		mkdir folder1 folder2 deep x &&
 		mkdir deep/deeper1 deep/deeper2 deep/before deep/later &&
 		mkdir deep/deeper1/deepest &&
+		mkdir deep/deeper1/deepest2 &&
+		mkdir deep/deeper1/deepest3 &&
 		echo "after deeper1" >deep/e &&
 		echo "after deepest" >deep/deeper1/e &&
 		cp a folder1 &&
@@ -30,7 +32,9 @@ test_expect_success 'setup' '
 		cp a deep/deeper2 &&
 		cp a deep/later &&
 		cp a deep/deeper1/deepest &&
-		cp -r deep/deeper1/deepest deep/deeper2 &&
+		cp a deep/deeper1/deepest2 &&
+		cp a deep/deeper1/deepest3 &&
+		cp -r deep/deeper1/ deep/deeper2 &&
 		mkdir deep/deeper1/0 &&
 		mkdir deep/deeper1/0/0 &&
 		touch deep/deeper1/0/1 &&
@@ -126,6 +130,8 @@ test_expect_success 'setup' '
 
 		git checkout -b deepest base &&
 		echo "updated deepest" >deep/deeper1/deepest/a &&
+		echo "updated deepest2" >deep/deeper1/deepest2/a &&
+		echo "updated deepest3" >deep/deeper1/deepest3/a &&
 		git commit -a -m "update deepest" &&
 
 		git checkout -f base &&
@@ -301,6 +307,14 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_failure 'deep changes during checkout' '
+	init_repos &&
+
+	test_sparse_match git sparse-checkout set deep/deeper1/deepest &&
+	test_all_match git checkout deepest &&
+	test_all_match git checkout base
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
-- 
gitgitgadget

