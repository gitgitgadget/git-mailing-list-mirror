Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F77C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDVUSG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjDVURs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9142699
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so1778043f8f.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194662; x=1684786662;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjrl8Oed5rjHg5PtrqFWFgcxhLHnyHcgNOXFVIVvWtE=;
        b=mUi3EzOrk1+SptgQPjxkCInc24I8+3omfwtM8jDFyaJ2Y7+IEC/AAXU8H06ZZ2Z7e+
         0kIYnOur3HB4Hf2xgov+nKBkhXJsv3NPAS9/YtRqVjBmLJxCQI1wasYnkknxh096MbAe
         iJg8Op9uNfGxIcSxTQ+f/RmD5jSYHYMmpPFrtiV/9RhvHQ8AL1csA5oLmQ9uNggn80UJ
         ISg4l1GeG+CAXEN0FofKdo7DNbuM8uTvKLjKbtmYs/06IUn787Di3hSifAG+qn76HIqH
         rkL4yWbGoaEWVKph79LyZe0MhqfJ4c+V1CRmgSKmx/bZBOw6+NJGrXS9UI6e/CS54Czc
         T0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194662; x=1684786662;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjrl8Oed5rjHg5PtrqFWFgcxhLHnyHcgNOXFVIVvWtE=;
        b=XZ8VyCEvqZ3y/ia1EBjdRbitBiVXg4CWPZZ45Pj08JK8uGCXDVZzPfI1sr4RhnPEok
         qMt82n+74MIU4L7S0/T7OtrRBKnDIWpP9Qk9AodJkDQCt1FsnrQ+4m6TN2kCtaVOhx3T
         saqLYqu3O0naCh1NsD+uTJTlgIVC9IaLCgqFyzslqXGTBV+EncHe0UfBcp2vsuJdPpc0
         a8KIGyjxznhIrFPmBifi8ht092JXG4znLO6OXpN5KvkmSGJx+oNS/u34jH5MD8FF7iBK
         FrS29QGU6V7iPo41lU2LsoKPQhNDizw0QhDUvHv8Y0ZaU0vL1sZSlY5RBOgMJp4hKBwx
         +erw==
X-Gm-Message-State: AAQBX9e4xbRatP3hZK4r2TLHXBxuYrrZEwLLeWKW2tLS+fphnbl0wpLE
        vXTRgpzyGaQTYMo6zPG5Kr+I3ImLVJc=
X-Google-Smtp-Source: AKy350YgtRW7XOHttdHU8yLK6DZb91jVaAdhkz+5FydSKlIFoV/u8ax0yFhqFBYlTc1c3uoMqEWFsw==
X-Received: by 2002:a5d:6407:0:b0:2fe:fde1:23a2 with SMTP id z7-20020a5d6407000000b002fefde123a2mr7348360wru.50.1682194662144;
        Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13-20020adfe88d000000b002e55cc69169sm7206269wrm.38.2023.04.22.13.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:41 -0700 (PDT)
Message-Id: <673a3ae4fe2cc9a341e33dde6bd756e517f6f658.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:18 +0000
Subject: [PATCH v2 11/22] dir.h: move DTYPE defines from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h | 14 --------------
 dir.h   | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/cache.h b/cache.h
index 6955745cccd..ad741e70bc2 100644
--- a/cache.h
+++ b/cache.h
@@ -10,20 +10,6 @@
 #include "object.h"
 #include "statinfo.h"
 
-#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-#define DTYPE(de)	((de)->d_type)
-#else
-#undef DT_UNKNOWN
-#undef DT_DIR
-#undef DT_REG
-#undef DT_LNK
-#define DT_UNKNOWN	0
-#define DT_DIR		1
-#define DT_REG		2
-#define DT_LNK		3
-#define DTYPE(de)	DT_UNKNOWN
-#endif
-
 /*
  * Some mode bits are also used internally for computations.
  *
diff --git a/dir.h b/dir.h
index 3d6c87387e9..79b85a01ee4 100644
--- a/dir.h
+++ b/dir.h
@@ -640,4 +640,19 @@ static inline int starts_with_dot_dot_slash_native(const char *const path)
 
 	return path_match_flags(path, what | PATH_MATCH_NATIVE);
 }
+
+#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
+#define DTYPE(de)	((de)->d_type)
+#else
+#undef DT_UNKNOWN
+#undef DT_DIR
+#undef DT_REG
+#undef DT_LNK
+#define DT_UNKNOWN	0
+#define DT_DIR		1
+#define DT_REG		2
+#define DT_LNK		3
+#define DTYPE(de)	DT_UNKNOWN
+#endif
+
 #endif
-- 
gitgitgadget

