Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED02C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 14:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbjFBOdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 10:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjFBOds (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 10:33:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095519B
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 07:33:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f601c57d8dso16737805e9.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685716425; x=1688308425;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtKtbhK/H+B/IlZ9T23/LcLdywVqfB8/X9M6QlNOzbQ=;
        b=Tz+OtS/wtcrxUzpfQT1YjtwM34B4hFQKsYGTpDjYml5A4Z0QaCSAQ53oFkn14X+IJX
         gGcR8qpF/Zf9zRSfUybbqDm2XmfXw4aeiojHpLXfISt8xEb55gZEiqJ4Cx5U4TH/bhHP
         iQwUjgKol4Vck1sqPJEJpJgQ5FnX7mrrG+SO2ZUcS11J1dkuBs+CNGKRPn74WgU9T9y7
         q/xN1I1QtQuj8Emy13QoXnWt99ylW5RqWYx5aBrADvXW7gEV//sCrvAgAEzAi1NsGKhI
         RbBj6XsoOr4es72xSWBSwNt44mIsq89JZAcJzTFnRYWyZGERvksyDELwRY+8vULtybV+
         iXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716425; x=1688308425;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtKtbhK/H+B/IlZ9T23/LcLdywVqfB8/X9M6QlNOzbQ=;
        b=UOwjyoZ1c7DDB0UG6P442pvBNJ96lzNVNAuqhpApjqG2QumpcNqtywSY4OBWY3tv5M
         Ex6g/85xPRVRIV4w+Xr+QfDfSuXXYkdhaCRHFgIM+DxmqA6/OIy+Gasr7S6kU9M0wXN0
         l2WoRF9P3u5P5n+0iHehNRG/w3I+OPVWLl810vGABe2uVcTV35RtxxRA6xvA77SkMzd/
         /wVcBKSCmQIXUiyx+dbA7r1oZxJPWLT8lIZTtP7w4JvbfafUbgXolDxgEW6s768kRm/P
         zucioq5AykiqK+vhGgqQtiS5CLUANN58er5/6ihQ8vkuQf+FqMHzFHAM6YbL8ymubpJA
         dKuw==
X-Gm-Message-State: AC+VfDxRHf91UuU4mn+Q+EUIRN3YJ2I58Ejl6svlqsTWs8iocom3yozF
        /D45v/CMdrd+LFxkmzR9KpwE/iShbnU=
X-Google-Smtp-Source: ACHHUZ7FJUql5EzuVQI7v65H91WEPR7nVKEgoByfYLCyJWz/8uaKwwbahm7VU944PXYG/B/NLJ/SXQ==
X-Received: by 2002:a05:600c:2c4b:b0:3f6:8ba:6ea2 with SMTP id r11-20020a05600c2c4b00b003f608ba6ea2mr2167629wmg.15.1685716425249;
        Fri, 02 Jun 2023 07:33:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a7bc044000000b003f70a7b4537sm5684198wmc.36.2023.06.02.07.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:33:44 -0700 (PDT)
Message-Id: <15d65d3e05d11de69e36f2a7b83c06b2727ff8f1.1685716420.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Jun 2023 14:33:38 +0000
Subject: [PATCH 4/6] config: move quote_path_fully to global config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 config.c        | 5 -----
 global-config.c | 2 ++
 global-config.h | 1 +
 quote.c         | 6 +++---
 quote.h         | 2 --
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index d955a16b372..6b4051a4eae 100644
--- a/config.c
+++ b/config.c
@@ -1568,11 +1568,6 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			check_stat = 0;
 	}
 
-	if (!strcmp(var, "core.quotepath")) {
-		quote_path_fully = git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.symlinks")) {
 		has_symlinks = git_config_bool(var, value);
 		return 0;
diff --git a/global-config.c b/global-config.c
index 5bd6bc45418..395d21e0381 100644
--- a/global-config.c
+++ b/global-config.c
@@ -6,6 +6,7 @@ static int global_ints[] = {
 	[INT_CONFIG_NONE] = 0, /* unused*/
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = 1,
 	[INT_CONFIG_TRUST_CTIME] = 1,
+	[INT_CONFIG_QUOTE_PATH_FULLY] = 1,
 };
 
 /* Bitmask for the enum. */
@@ -15,6 +16,7 @@ static const char *global_int_names[] = {
 	[INT_CONFIG_NONE] = NULL, /* unused*/
 	[INT_CONFIG_TRUST_EXECUTABLE_BIT] = "core.filemode",
 	[INT_CONFIG_TRUST_CTIME] = "core.trustctime",
+	[INT_CONFIG_QUOTE_PATH_FULLY] = "core.quotepath",
 };
 
 static int config_available;
diff --git a/global-config.h b/global-config.h
index a6d8e5adc4e..fbe5fccb1a1 100644
--- a/global-config.h
+++ b/global-config.h
@@ -5,6 +5,7 @@ enum int_config_key {
 	INT_CONFIG_NONE = 0,
 	INT_CONFIG_TRUST_EXECUTABLE_BIT,
 	INT_CONFIG_TRUST_CTIME,
+	INT_CONFIG_QUOTE_PATH_FULLY,
 };
 
 /**
diff --git a/quote.c b/quote.c
index 43c739671ed..25ca0473881 100644
--- a/quote.c
+++ b/quote.c
@@ -4,8 +4,7 @@
 #include "quote.h"
 #include "strbuf.h"
 #include "strvec.h"
-
-int quote_path_fully = 1;
+#include "global-config.h"
 
 static inline int need_bs_quote(char c)
 {
@@ -212,7 +211,7 @@ int sq_dequote_to_strvec(char *arg, struct strvec *array)
 }
 
 /* 1 means: quote as octal
- * 0 means: quote as octal if (quote_path_fully)
+ * 0 means: quote as octal if core.quotePath is true
  * -1 means: never quote
  * c: quote as "\\c"
  */
@@ -233,6 +232,7 @@ static signed char const cq_lookup[256] = {
 
 static inline int cq_must_quote(char c)
 {
+	int quote_path_fully = get_int_config_global(INT_CONFIG_QUOTE_PATH_FULLY);
 	return cq_lookup[(unsigned char)c] + quote_path_fully > 0;
 }
 
diff --git a/quote.h b/quote.h
index 0300c291041..87ff458b06d 100644
--- a/quote.h
+++ b/quote.h
@@ -3,8 +3,6 @@
 
 struct strbuf;
 
-extern int quote_path_fully;
-
 /* Help to copy the thing properly quoted for the shell safety.
  * any single quote is replaced with '\'', any exclamation point
  * is replaced with '\!', and the whole thing is enclosed in a
-- 
gitgitgadget

