Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B1C77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjDPDD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjDPDDg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B372724
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f1728c2a57so679275e9.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614213; x=1684206213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA6B9hWAldqZfZXVR8JjnS0tErAdEgGFl7Zm1+qIM0g=;
        b=L5dczQIru+GbAuTc/JYcRXS8MjQDlU+rHJTD9kKe9k1rHMygw8J969+Lw5KdRuYn9U
         SzALhWvOyUQ0uNq94vo8np3RenXqYDkUUSZ0FbW8fvUCDiP2PXvzffUUXo/8LjCN3Gly
         UH22X3kGAH108tzko7fs6JepB7xLP/4rCnEY+HnXFSqe1r1hlAmKZINQmlSevZbosDho
         eiTCdHlrHyq+iGfmrC5+cuyy7dAa80bx69o0rHqy+b4+hcpWhBAYwoAT5mGhNEjvcsGv
         H3ujuYb5R5iEb7t0POP6SD6wmiBsd8M+PN2zbv/v2bEVmcJHkkU5cG2OMRj9KM9/3EA7
         F8tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614213; x=1684206213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA6B9hWAldqZfZXVR8JjnS0tErAdEgGFl7Zm1+qIM0g=;
        b=DCwXVOOsebOz23YODKPtGelNvSsJn8IOCTpCUCGdkdGRtk1lu5RqTXtKtK2g3PX4HF
         8HfIYPll8Yj3NT88HIhH4SKHlLZtVAP0ff+BA8ZzN2LIf9aVNX4NOE85cLK3r4FjA77t
         GPcHupNjvSi1orSvTwNEjHXzK+tKwuqvVyUVyg/XIPgiXAYBDFvfEgwffbUDI+xOrIMp
         yAORTMJF3Pw+AFuLLRPDu2PxqZaj5nBDbMljggpZ8ROeyzLwFwbqnyEm75J0Q/6X+wsK
         o74CRyk9p3RZfze2g27IrNeQh2VVCs084voVPSIiE6umu8F78kSf3Ez3LuK0qkAFAzKL
         7GDw==
X-Gm-Message-State: AAQBX9ciH/jYsgXZMycrNxrbFIHcA8+pH3m0Je0Ay4b4ZLzi/uyifpZS
        wF1ckMSssqa0Y9kBefWWpDtzh8VE2dU=
X-Google-Smtp-Source: AKy350bh8r8Tbq/3vfOGuqXNovltNWFHfG7iCwGOZTHDYrO8kDyw8y0Xwr1Jv1+hNXrip+FMEeklcA==
X-Received: by 2002:adf:e686:0:b0:2e4:bfa0:8c29 with SMTP id r6-20020adfe686000000b002e4bfa08c29mr2449973wrm.50.1681614212937;
        Sat, 15 Apr 2023 20:03:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020adfda48000000b002efacde3fc7sm7006425wrl.35.2023.04.15.20.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:32 -0700 (PDT)
Message-Id: <9d9672ebf52fd1d7925ad58d82695dd21113244d.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:09 +0000
Subject: [PATCH 07/23] base85.h: move declarations for base85.c functions from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c  | 1 +
 base85.c | 3 ++-
 base85.h | 7 +++++++
 cache.h  | 4 ----
 diff.c   | 1 +
 5 files changed, 11 insertions(+), 5 deletions(-)
 create mode 100644 base85.h

diff --git a/apply.c b/apply.c
index efe2dcb0e62..a65a354eef5 100644
--- a/apply.c
+++ b/apply.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
+#include "base85.h"
 #include "config.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/base85.c b/base85.c
index 5ca601ee14f..bbacdca31b3 100644
--- a/base85.c
+++ b/base85.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "base85.h"
 
 #undef DEBUG_85
 
diff --git a/base85.h b/base85.h
new file mode 100644
index 00000000000..c835086e093
--- /dev/null
+++ b/base85.h
@@ -0,0 +1,7 @@
+#ifndef BASE85_H
+#define BASE85_H
+
+int decode_85(char *dst, const char *line, int linelen);
+void encode_85(char *buf, const unsigned char *data, int bytes);
+
+#endif /* BASE85_H */
diff --git a/cache.h b/cache.h
index 2b661764794..b89f4c59802 100644
--- a/cache.h
+++ b/cache.h
@@ -593,10 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-/* base85 */
-int decode_85(char *dst, const char *line, int linelen);
-void encode_85(char *buf, const unsigned char *data, int bytes);
-
 /* pkt-line.c */
 void packet_trace_identity(const char *prog);
 
diff --git a/diff.c b/diff.c
index fa86d023196..e697f78a645 100644
--- a/diff.c
+++ b/diff.c
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
+#include "base85.h"
 #include "config.h"
 #include "convert.h"
 #include "environment.h"
-- 
gitgitgadget

