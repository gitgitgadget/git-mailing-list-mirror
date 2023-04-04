Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAE1C761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjDDBWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjDDBWm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:42 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00991211E
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id l27so31146622wrb.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6y+k8VfS2an6jpSvwaHUqvn8TONlJuNwEq0tO3ku+A=;
        b=INbUJNDSbKBvvN1FkhPfX5QHaQYizZpspSESHA9uIow/8K8YqmSMIG/GY0OEdQtxUJ
         MN9lS7VJebdo0QKqMZMPkfwJ6zl2VSjep34Szl31gEmCZ8Umh/FPBxvAHwF9f+WZB+K6
         Dox1o5T2Sp1maDsciLMotaPNSNnA9RaDy7gTCLyGz6rE4VlEWmDLkOdVN4h9k52psrSE
         UiwcSEElQ/Ij9jk6WFj1+4xgPx2i27vnEI1C/K9lI+O7DJ+nV1rFLs/zg7Q3gXemrdB6
         +dxf+v2jnVuRXCe+MJb1ZEnuppsmgLtqmMpArEZH1BdVtYC+bg3PtjUaSKhZ9ga2O6Sj
         MtSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6y+k8VfS2an6jpSvwaHUqvn8TONlJuNwEq0tO3ku+A=;
        b=O0ixOAQycCbYJYok9NviR2yb50WHuzc6mVVBLZGcIGNp+zvHTeLDLEFFxvkDOhH1jX
         gqQaAh4VnFusZjarfGzzTLP8IxMABOImToK8AsXvN2CpbZb/hdsAgL3Li/nvYrf39Oox
         RzCnLjLUzsNwUsKn4fm4PWfnbn4TT4SkFDIeEzrFjVuZ1booBDu81UVsHklqdVhCsruQ
         Oc/BHXKKxtxkKYSqUw75SHWwnDNwE9HI0Mv6jo4wLY/ER1M1Bk9cC8zd5zmahWBbfwSL
         FYHnwBMNwsnUZUdXoTiF/JXzPUqqrGI8ngH0JbYofiOzByBCODYoe0AdUo/4RyQA0VIE
         tq3w==
X-Gm-Message-State: AAQBX9cFs666ySvT+qU3VaMixFuqlb3Te2NHeF9BN5AhHKDtLdgicEdv
        xRm1CDKU6yvIg6K1gFvhVTjr3WXx0ys=
X-Google-Smtp-Source: AKy350ZryCPwEZqVj9NHchfluDIuxs2KWKgTZBs5YcRsctiazKDb+7iTB0iZrjmKY1Yhj2hWo5ewRA==
X-Received: by 2002:adf:ecc9:0:b0:2ce:a8f0:5e1f with SMTP id s9-20020adfecc9000000b002cea8f05e1fmr247265wro.71.1680571359385;
        Mon, 03 Apr 2023 18:22:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020adfcd03000000b002d45575643esm10893727wrm.43.2023.04.03.18.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:39 -0700 (PDT)
Message-Id: <c6a561cf4339108d6f04042ddbe6b3af766fc964.1680571350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:10 +0000
Subject: [PATCH v2 06/24] treewide: be explicit about dependence on mem-pool.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/checkout.c        | 1 +
 cache.h                   | 1 -
 merge-ort.c               | 1 +
 read-cache.c              | 1 +
 split-index.c             | 1 +
 t/helper/test-mergesort.c | 1 +
 6 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 422ea768404..65988fd8a3b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -15,6 +15,7 @@
 #include "hook.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "mem-pool.h"
 #include "merge-recursive.h"
 #include "object-store.h"
 #include "parse-options.h"
diff --git a/cache.h b/cache.h
index 6eac3134a22..66705dd469e 100644
--- a/cache.h
+++ b/cache.h
@@ -13,7 +13,6 @@
 #include "object.h"
 #include "repository.h"
 #include "statinfo.h"
-#include "mem-pool.h"
 
 typedef struct git_zstream {
 	z_stream z;
diff --git a/merge-ort.c b/merge-ort.c
index 9b0b184b130..1008684fbbc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -31,6 +31,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
+#include "mem-pool.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "promisor-remote.h"
diff --git a/read-cache.c b/read-cache.c
index 1b585ce8424..4ada6d62b90 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -21,6 +21,7 @@
 #include "blob.h"
 #include "environment.h"
 #include "gettext.h"
+#include "mem-pool.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/split-index.c b/split-index.c
index c98807c655b..5602b74994b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "alloc.h"
 #include "gettext.h"
+#include "mem-pool.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 335e5bb3a90..737e0c52358 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "mem-pool.h"
 #include "mergesort.h"
 
 static uint32_t minstd_rand(uint32_t *state)
-- 
gitgitgadget

