Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5061C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjEITnD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEITnC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:43:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF34498
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:42:58 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3eef63eff7eso32859661cf.3
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683661377; x=1686253377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BhmS0DQpdxLYQYGrDvexPj8YtMDIfD0OnR1kObWcBM=;
        b=iebBf3B6KydVStqTMIeKKcAsNPPy+h6i2EmvO3oQPUSMg17FUNoa9+TWovrlQ65mIr
         nyL6Jk9zSx7y6aSeaUJ4ai+hxobH0qzk94cOffyuU6d2kvUK2QITP090z8UVOPS41RdZ
         KxQI/sXxB2zaBpSU7x6EEpcY45tl94qvh5IrgSik75gxLTGJUcE6oSzttHsEbA+gQUvT
         n/rGMT8K7DtX0vDu38esOwQguSdWz3WNYY+n7Qd1kx0ceOLKhopWQCuS67voLMgrr+CJ
         fepYcwCOrcS71//CgZcgSqYwdk+mB0D9hzV1MVGLVZBqgAYv8hxCudrs+hePtL5cG/Zo
         x26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661377; x=1686253377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BhmS0DQpdxLYQYGrDvexPj8YtMDIfD0OnR1kObWcBM=;
        b=kk75YwewHxyWaMbIZPthIhpMr7ofNdVMTEUsarqrHtq2HzUd05eOijZp3f9V4XRLKT
         z13vUAF+GdKh6TLdG7pXgUJysfO2h4JeVzZfrhE0tjZkDCvT6sOVaKZUkq0teylU58Na
         59KENpBLzlVmm3i3v569MBcMhDx3BppaI6fnwYdDr/kYAi+EJf76iXKnwks1LqqkGTEL
         50ydOoU//MBPg3urKF0UxOTvGeQkt/QJmyBeYwEn1/PoOd+WETKh4r1pA0KacWOz52D0
         KtTwEWu5w/U13cM4gYqoRJ1wJVsi0Bm03ItrWUUSMLDaFBgIG+3GB8iLYSBsCNWR9R8I
         3j4A==
X-Gm-Message-State: AC+VfDy+zdg9FgRJIfNkUQskdhm/mDUTEmPx9Y6yrKE4BlMymXnk5nNe
        VbnD5yURuUrxJZJWHnWYxftq06cE17zDVw==
X-Google-Smtp-Source: ACHHUZ4QMMt6vm2YmsgtlwdKLfVl0+g6Tue1t5zBVzbnTueZuju1RsjP3DLP1NuuOHOIwQGqkR4PdA==
X-Received: by 2002:a05:622a:591:b0:3e4:df94:34fa with SMTP id c17-20020a05622a059100b003e4df9434famr22477147qtb.37.1683661377243;
        Tue, 09 May 2023 12:42:57 -0700 (PDT)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id j11-20020ac8550b000000b003f1f26bbb50sm756038qtq.35.2023.05.09.12.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:42:56 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v12 1/2] t1092: add tests for `git diff-files`
Date:   Tue,  9 May 2023 15:42:40 -0400
Message-Id: <20230509194241.469477-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230509194241.469477-1-cheskaqiqi@gmail.com>
References: <20230508184652.4283-1-cheskaqiqi@gmail.com>
 <20230509194241.469477-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating the 'git diff-files' builtin with the sparse index
feature, add tests to t1092-sparse-checkout-compatibility.sh to ensure
it currently works with sparse-checkout and will still work with sparse
index after that integration.

When adding tests against a sparse-checkout definition, we test two
modes: all changes are within the sparse-checkout cone and some changes
are outside the sparse-checkout cone.

In order to have staged changes outside of the sparse-checkout cone,
make a directory called 'folder1' and copy `a` into 'folder1/a'.
'folder1/a' is identical to `a` in the base commit. These make
'folder1/a' in the index, while leaving it outside of the
sparse-checkout definition. Change content inside 'folder1/a' in order
to test 'folder1/a' being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 39 ++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..b06b522030 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2108,4 +2108,43 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
 	ensure_not_expanded write-tree
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files &&
+
+	test_all_match git diff-files -- deep/a &&
+
+	# test wildcard
+	test_all_match git diff-files -- "deep/*"
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_sparse_match git diff-files -- folder2/a &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# The directory "folder1" is outside the cone of interest
+	# and will not exist in the sparse checkout repositories.
+	# Create it as needed, add file "folder1/a" there with
+	# contents that is different from the staged version.
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git diff-files &&
+	test_all_match git diff-files -- folder1/a &&
+	test_all_match git diff-files -- "folder*/a"
+'
+
 test_done
-- 
2.39.0

