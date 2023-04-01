Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F9C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjDAPLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDAPKu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DD91D84C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso15594615wmo.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6y+k8VfS2an6jpSvwaHUqvn8TONlJuNwEq0tO3ku+A=;
        b=CRpaWXfQvXotTCEIPKV2T5ztZMgEsAs6mCr/qcztpEid9mS8RGRTDS/ZeXxmF+JeuW
         bapmj7a6vOll4hoxQBhaXxykkMN6oEW5M8NpKbLXT9931VPqsDLwYKdHNY4/k6a1hJ7Z
         XIG5/P+nHPQ8yuzFoZ6W/Z7xmo5LQAL2exvARv2AGFsD7+4xfMYuqlAza+F9hx51IRri
         E4ztqTsjiAK7KaGsvUJJtDIHX2k+6Mvfzvvhy+ERAXon+/tZg1JdfCRjHdUphlqc5Lbm
         XF/kRPMvBImJ3pEcQ0toyBCovgCQXMAjqM02AslKCA1nm7B3lIrW71UQsIK1Bz/Gt/jj
         EPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6y+k8VfS2an6jpSvwaHUqvn8TONlJuNwEq0tO3ku+A=;
        b=Ik7l3JunTGWd1Wf+SvO+xGH9ENN8vs2gGqWdwErWEi5PqbVmog5wH+kbxOLvnjtp5D
         z1dI8OZZTA+0csiZXwUODY7JgwbRIB2JMjhmqMeLd8Hnb0gpirsPxS/BXZxtZIn7eZX9
         5PhdDdBEBkpqSYOVeTxNENxLP3Dqlxee6F10AD5p/AS/meCFRIPp2eukhNW1y+nFy3Pk
         OsNwKOEqxb1A+D2vt5tabnKqhj3UuB4PhYFIhdbIJJDynmbh9YJnyrEDPaAh6CsioypZ
         ekf85SoZ+TptEwKyfYnkymh/zEsTkWzyo2Xw9FbkxvzyQLgVzt6phbb+y29sSFvkixua
         mVZA==
X-Gm-Message-State: AAQBX9erSyWeBnWElSew2GS9I8igs4GYk0tXbAFgmLUK7zOulYUAFV6x
        B4GJ9Cby1zak3vt7EN8YO4ERsVALThc=
X-Google-Smtp-Source: AKy350Z9FaqbAQ+HDRT+KgoeIncuo+eCrKO1Q+m8X8GhFZFOZd88yqqK5lh3yDzhHGTFePdtqpHJYw==
X-Received: by 2002:a1c:7714:0:b0:3ed:ea48:cd92 with SMTP id t20-20020a1c7714000000b003edea48cd92mr16577723wmi.15.1680361845896;
        Sat, 01 Apr 2023 08:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m26-20020a05600c3b1a00b003ede2c4701dsm13550585wms.14.2023.04.01.08.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:45 -0700 (PDT)
Message-Id: <c6a561cf4339108d6f04042ddbe6b3af766fc964.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:19 +0000
Subject: [PATCH 06/24] treewide: be explicit about dependence on mem-pool.h
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

