Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CFEC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239844AbiEIR7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbiEIR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:59:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2923A2D9EC0
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:55:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g23so17197702edy.13
        for <git@vger.kernel.org>; Mon, 09 May 2022 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXf18GmAuUojDaz/FRXUDw4J6qbGPyRDnJDyEGsvd0w=;
        b=RjClN69jvjdvvYiouj1OnpBE45MXxxoyQs0VAvobtQbdzxMGnXiZ3uuj+vgM5BBuKU
         eU5wjGb547biF3y8jCBrlpfxsF+DVYhEUYm7+uDV0pHa28N6NATSB5GgUUkSPllkrk3I
         RMDGquGhuNiO1YYZWLCm+VkGwaBJS0K2BS/DKJ4BQ3oGjJri+gUgR/KooEdgTHikHFMG
         j5097alcnPLUbDKDoTwUI/9yMgrItNDui6VF9OoOZFA+/lCEc7mwTjprRYQesUVhUJ6Q
         5J6lb8kWATbpfbJy1M02X6olj3x7GOjBglCTpU62FrnAbRx8X2IiMqq/92D+jkRyVxp5
         3Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXf18GmAuUojDaz/FRXUDw4J6qbGPyRDnJDyEGsvd0w=;
        b=pcvhnG8LdnLEi97FjVZQK1yyJyloS+6/YTRwKY3Yz0G3FJLa0x234DJftoLghSzL0B
         oi1QdSOYMQ8UsYESih9pDaaBSsZxrcSNv8qRIslIsWLzC7jNiFWjIGkzsyl+9DbaXdY0
         1Ov79h4B2j46JbN/TcVm6bsDdhW5xV9Wwho26xUsyOarUq45gXhhbzrK2D68KjGmAbe8
         RrF3Wgi7cjT0rk5SGX3qvHphNaK+u/KBvb1v8W7k10OHaut74xSKNfAmaYVyLKPL+2RY
         5O0t3DLLiqhZkMnWvwpmAmXabmkQtnq58dkDDEdQpyN3KCzKqSyTqi6FdJChg1jH3l2P
         tdyA==
X-Gm-Message-State: AOAM533R3rLfs2fq3dZB8uq1LCSWMmBHUgKydT3FbgDAffdwTKOvmkRr
        XGxFucBdJh2xi4VmANGrUC0KxuPchdM=
X-Google-Smtp-Source: ABdhPJyhO8YnegNPkKvttnCZNTY7OodyMakgWZN1dw3W9OI9Lh2YKGOSzLRzY4SFGwce8ObLFQQjSg==
X-Received: by 2002:a05:6402:5109:b0:428:1f56:d149 with SMTP id m9-20020a056402510900b004281f56d149mr18577789edd.293.1652118906778;
        Mon, 09 May 2022 10:55:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2149:8a7c:1900:a49c:b216:27f2:528a])
        by smtp.gmail.com with ESMTPSA id l17-20020aa7cad1000000b0042617ba63bfsm6552883edt.73.2022.05.09.10.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:55:06 -0700 (PDT)
From:   Plato Kiorpelidis <kioplato@gmail.com>
To:     git@vger.kernel.org
Cc:     phillip.wood123@gmail.com, avarab@gmail.com,
        Plato Kiorpelidis <kioplato@gmail.com>
Subject: [PATCH v2 08/15] t0066: reorder tests from simple to more complex
Date:   Mon,  9 May 2022 20:51:52 +0300
Message-Id: <20220509175159.2948802-9-kioplato@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com>
References: <20220509175159.2948802-1-kioplato@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gradually increase the complexity of the tests. This reordering helps
when testing dir-iterator, explicitly or by running the full test suite.
In case a test fails it provides additional aid searching for and finding
the part of dir-iterator that causes the test to fail, making it easier.

Signed-off-by: Plato Kiorpelidis <kioplato@gmail.com>
---
 t/t0066-dir-iterator.sh | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
index 932b1f291c..9b3ce99382 100755
--- a/t/t0066-dir-iterator.sh
+++ b/t/t0066-dir-iterator.sh
@@ -96,37 +96,6 @@ test_expect_success 'iteration of dir w/ dir w/ a file' '
 	test_cmp expected-out actual-out
 '
 
-test_expect_success 'setup -- dir w/ complex structure' '
-	mkdir -p dir &&
-	mkdir -p dir/a/b/c/ &&
-	>dir/b &&
-	>dir/c &&
-	mkdir -p dir/d/e/d/ &&
-	>dir/a/b/c/d &&
-	>dir/a/e &&
-	>dir/d/e/d/a
-'
-test_expect_success 'dir-iterator should iterate through all files' '
-	cat >expected-sorted-out <<-EOF &&
-	[d] (a) [a] ./dir/a
-	[d] (a/b) [b] ./dir/a/b
-	[d] (a/b/c) [c] ./dir/a/b/c
-	[d] (d) [d] ./dir/d
-	[d] (d/e) [e] ./dir/d/e
-	[d] (d/e/d) [d] ./dir/d/e/d
-	[f] (a/b/c/d) [d] ./dir/a/b/c/d
-	[f] (a/e) [e] ./dir/a/e
-	[f] (b) [b] ./dir/b
-	[f] (c) [c] ./dir/c
-	[f] (d/e/d/a) [a] ./dir/d/e/d/a
-	EOF
-
-	test-tool dir-iterator ./dir >actual-out &&
-	sort actual-out >actual-sorted-out &&
-
-	test_cmp expected-sorted-out actual-sorted-out
-'
-
 test_expect_success 'setup -- dir w/ three nested dirs w/ file' '
 	mkdir -p dir2/a/b/c &&
 	>dir2/a/b/c/d
@@ -283,6 +252,37 @@ test_expect_success 'iteration of dir w/ two nested dirs, each w/ file' '
 	)
 '
 
+test_expect_success 'setup -- dir w/ complex structure' '
+	mkdir -p dir &&
+	mkdir -p dir/a/b/c/ &&
+	>dir/b &&
+	>dir/c &&
+	mkdir -p dir/d/e/d/ &&
+	>dir/a/b/c/d &&
+	>dir/a/e &&
+	>dir/d/e/d/a
+'
+test_expect_success 'dir-iterator should iterate through all files' '
+	cat >expected-sorted-out <<-EOF &&
+	[d] (a) [a] ./dir/a
+	[d] (a/b) [b] ./dir/a/b
+	[d] (a/b/c) [c] ./dir/a/b/c
+	[d] (d) [d] ./dir/d
+	[d] (d/e) [e] ./dir/d/e
+	[d] (d/e/d) [d] ./dir/d/e/d
+	[f] (a/b/c/d) [d] ./dir/a/b/c/d
+	[f] (a/e) [e] ./dir/a/e
+	[f] (b) [b] ./dir/b
+	[f] (c) [c] ./dir/c
+	[f] (d/e/d/a) [a] ./dir/d/e/d/a
+	EOF
+
+	test-tool dir-iterator ./dir >actual-out &&
+	sort actual-out >actual-sorted-out &&
+
+	test_cmp expected-sorted-out actual-sorted-out
+'
+
 test_expect_success POSIXPERM,SANITY 'setup -- dir w/o perms' '
 	mkdir -p dir12/a &&
 	>dir12/a/b
-- 
2.36.1

