Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C295C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiGAKiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbiGAKhy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:37:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1776EBB
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:37:53 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so2613512wrc.2
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcpJmFhI+N/Xz8CBdRX/OWs83d1pRrP0wMNLYYn6I/U=;
        b=IqM039YZCUV8ZVfPU1orp16fs5ylTYgXsvc1LX6fz6EYFLH6MI/wuIo/vsEhz827Ug
         52RUQ4JQitK9ENZeyZy1VC3+AdCgyJeWMnbkSfkFC60oTTX2f+DjTJT8sJY2xOQ/Cf8r
         X3eU/HboDw9VhvlqHUrgVj56rS+6MgP72ykhySrxFdDsyoGMf2av8GcDy2QIpEHPVqDf
         NvU2Mo943XsehXhdEq2oTyNlhW3uVWa2rgc31I3Ycq+36JywmnEb1P3lhiBQ5xuuabi3
         MAkBImHUpecncjE0TMBNDJMAl8v30xQg5ZBDEbrTas41IdcyOtSomT0kpzkPtys7u6d1
         xA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcpJmFhI+N/Xz8CBdRX/OWs83d1pRrP0wMNLYYn6I/U=;
        b=u5bMJhRUfFLImQH/gIxnXS8VOqebQH7gtly5g7LUGtIu+Xh7L+8enUPBuDWUsaYnk5
         OAhI+E84GgOhZVRoGSF4SYdzCpoKzqMa2M0ytzlOdK5VQcLBOLQNAWZ5I4R2vQAEeWkk
         W9jWliDK+148TPVDZYwFIeH/tFngTZwL0Q+nY+Tt8CquAr+RufIIVAjgL5qhCs+2soiC
         PD2xdTdRNtmOhiqOuBzydyRg5lErJj3ZUUWvmUKgI5KmoMLUM2R2DnEmH/Eibw5IDlo0
         YK4uCFyb/sUIcqiQ/WtZCLH1hmk4yTq/bFpJKfn+vyII8U6nDfLV2b42QJsVUMgCD2vE
         ATJQ==
X-Gm-Message-State: AJIora8zAZijmBqFpC/8WpiGjeLLnqnETPUct8g3mGIPhfWRnmemu0rA
        PibhnUMzkJe/b5/GBWBfcbZe0gVsyiEBDA==
X-Google-Smtp-Source: AGRyM1s05s7XONLQBBIujhsoFg+I6Exzgkbqkql5IhDhqZXGgeV/OFmXpsAwyoVOeNN63LV215xnzw==
X-Received: by 2002:a5d:470a:0:b0:21b:87a0:42e2 with SMTP id y10-20020a5d470a000000b0021b87a042e2mr12873685wrq.55.1656671871525;
        Fri, 01 Jul 2022 03:37:51 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b00397393419e3sm6229871wmq.28.2022.07.01.03.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:37:50 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/9] test-tool urlmatch-normalization: fix a memory leak
Date:   Fri,  1 Jul 2022 12:37:35 +0200
Message-Id: <patch-v2-4.9-3f9f7bbdeb2-20220701T103503Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220701T103503Z-avarab@gmail.com>
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
2.37.0.900.g4d0de1cceb2

