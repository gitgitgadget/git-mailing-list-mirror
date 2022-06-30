Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA8FC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbiF3Xrh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbiF3Xrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08BB599FE
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so2681505wmp.3
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bEGaRRoLhfszn6F0tBI8IsWjhQyJ+8ZcS4DBiDuxneg=;
        b=WMn/ZHisw5NsGhAgbpCyxivtoYvsaEXiNPgwf1engJsACf/xpq6EJXq85j4EOnDmNa
         wDw5FQpPK2fBEmqzuTqvmTYfdM0EsrZ4rchnmOMZmRHVwLfxhnjUPs8Xts4agFxp4U+Z
         +Qy5Bi9Spkzh+w7aHnOFItVUicCTKvUicqZOFpBYJbwjb4RmuEqFPGLhyGRXtfMqUuzZ
         KqMb/s6yD/FU5ESlG2Yzw7it5nKSJFBN/4UmxNvQRkOdu8ibVfNWPfrXsuDSEPifbtYa
         ZPLt4mbxDfhDS0OwX3M0KYCn4dcXv3ch3HwWVPyIXqRSrHjnLCusdAs131fLghzuqEx0
         XEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bEGaRRoLhfszn6F0tBI8IsWjhQyJ+8ZcS4DBiDuxneg=;
        b=NohCmgLhIcZCX9n5Mylb1DTgqTa4gFwDqcapsrO9wqRy2wsrSTDhDQIUWWOB8tPtP2
         BfYYplJQylbOJXcrVdJxwtr04IxPEI9CXsp6DUkDRpjik+iR/d5OI8y+nWFiC0ilu4f8
         NPq8efg+e8v5xAIEBozn+jn8n1oylfxvBxp3Fdr0spFzeIzOzLrVhXrZ31HXqcuxC5De
         yxAjmWuhH728LsbDW4uQA3aWrjeYnm6vRvcRia71XUS6qdWmXyeS+h7T1og+T/JoFRGa
         0PbP5QFApdl2kH/vLDIkE1hF/g8u79yMHYRgJziFVn6PLOu4ZH5K7y7kYN+U7RT9aA7L
         EPow==
X-Gm-Message-State: AJIora++mFvpRtxGNmTA/8VsXSqP+8bHm0+1aL4TN+7UiYL983mKdmcV
        oQZSHgWFnuJgm36TnN2RYBQYi+nnxs1shQ==
X-Google-Smtp-Source: AGRyM1vNZ+L5fghqeyji/bdnM82lYF82h8kd5Uftrtv0957s9sKIdaJaksRRqFKMYHdR5OhkqFXOVw==
X-Received: by 2002:a1c:cc1a:0:b0:3a0:39b1:3408 with SMTP id h26-20020a1ccc1a000000b003a039b13408mr12575429wmb.157.1656632840006;
        Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/9] test-tool urlmatch-normalization: fix a memory leak
Date:   Fri,  1 Jul 2022 01:47:04 +0200
Message-Id: <patch-4.9-a450aff8904-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in "test-tool urlmatch-normalization", as a result
we can mark the corresponding test as passing with SANITIZE=leak using
"TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-urlmatch-normalization.c | 11 ++++++++---
 t/t0110-urlmatch-normalization.sh      |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/helper/test-urlmatch-normalization.c b/t/helper/test-urlmatch-normalization.c
index 8f4d67e6469..86edd454f5c 100644
--- a/t/helper/test-urlmatch-normalization.c
+++ b/t/helper/test-urlmatch-normalization.c
@@ -5,8 +5,9 @@
 int cmd__urlmatch_normalization(int argc, const char **argv)
 {
 	const char usage[] = "test-tool urlmatch-normalization [-p | -l] <url1> | <url1> <url2>";
-	char *url1, *url2;
+	char *url1 = NULL, *url2 = NULL;
 	int opt_p = 0, opt_l = 0;
+	int ret = 0;
 
 	/*
 	 * For one url, succeed if url_normalize succeeds on it, fail otherwise.
@@ -39,7 +40,7 @@ int cmd__urlmatch_normalization(int argc, const char **argv)
 			printf("%s\n", url1);
 		if (opt_l)
 			printf("%u\n", (unsigned)info.url_len);
-		return 0;
+		goto cleanup;
 	}
 
 	if (opt_p || opt_l)
@@ -47,5 +48,9 @@ int cmd__urlmatch_normalization(int argc, const char **argv)
 
 	url1 = url_normalize(argv[1], NULL);
 	url2 = url_normalize(argv[2], NULL);
-	return (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+	ret = (url1 && url2 && !strcmp(url1, url2)) ? 0 : 1;
+cleanup:
+	free(url1);
+	free(url2);
+	return ret;
 }
diff --git a/t/t0110-urlmatch-normalization.sh b/t/t0110-urlmatch-normalization.sh
index 4dc9fecf724..12d817fbd34 100755
--- a/t/t0110-urlmatch-normalization.sh
+++ b/t/t0110-urlmatch-normalization.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='urlmatch URL normalization'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # The base name of the test url files
-- 
2.37.0.874.g7d3439f13c4

