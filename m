Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F018C761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDAPLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDAPKx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B27D2030F
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o32so14578678wms.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGGfEQwV2bWHTq/kbZMbZLX1l6WB5MjGao/dFgmUxRQ=;
        b=j5vSecn2Za8kQch0zlG5eKLdFgJHYVI3etzHE4eUmxJkCu7gLGcDg/hc+cHxdFSI7p
         NzHQyoIEsgEL5GsAseAB8p5QJ9TDTeaV936Ao9CFSrBA8lZ/OjDCYlzpScYI5hKxeF4p
         XimBxGNNMGljCNswjgN6x3I6Sxvjk5NpYBhpQUpw+9LcsHL1kfDADW7/xirS9kIQAqIP
         isyVpTvTW3LdJ0vxRxAqX0oEOF6U4RmtcsKov1mzZ8nfn2BilZ/GcCdJI6hCBG5n5rNw
         9GLpbx9lpKo0wDMnGwqWf6J9ynHh5okqB6ldDBlrVkShrwog38bUtA9JM283h4JglMRX
         uJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGGfEQwV2bWHTq/kbZMbZLX1l6WB5MjGao/dFgmUxRQ=;
        b=Lr6MRTkWkg1UFlrq18RVKD+j8SzbUHZTGgu/l2dclxkH5JqAZe1fM82MEqqu8mbjpT
         eXoeQTIVcAgiovRqBymZA84w8p7ovkfvvPx7DkkL4NIuH3gjL+00kurtN90BrDyeGKw8
         v5I0k2DY4Q1W/h1cwuYt8Nctra45KpOFj2MgPwS3y0xM4hSFmUYQR0oJQlVLJfx+i+/K
         ukB1djN4V4vMXKp+DhL0yIlO4LBzNdvO4barruRGJc1/LQNaI9hSE8vAAnNiX3gvwId+
         8B7CqpkMhKD7Ira/Q3nQ3Z+ev7TCG5rp7lcAHyYZruep39nJLrWIOu2hS3QpNcKylaFk
         Z3Ww==
X-Gm-Message-State: AAQBX9c/mCZsjp4DIgQwbTVXpX0jsIGIDtBFAS75i5Ge8FTjZ0vjpyLE
        PSbOPDWv7sF9mHetxZ8inXQIJNssMXE=
X-Google-Smtp-Source: AKy350aVMoGd0FgcD+g0XO/7XUBBPEi0ObKEiLcQKL8j0cjvXYgMcMIZ2i0LoqoPcjl2AymC34gDzQ==
X-Received: by 2002:a7b:c4c3:0:b0:3f0:3d47:2cbe with SMTP id g3-20020a7bc4c3000000b003f03d472cbemr6125874wmk.10.1680361847572;
        Sat, 01 Apr 2023 08:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm13906089wmb.40.2023.04.01.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:47 -0700 (PDT)
Message-Id: <e3ec14f90a5297d936f7271baada3eb5cb3ac54a.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:22 +0000
Subject: [PATCH 09/24] treewide: remove cache.h inclusion due to object-name.h
 changes
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
 branch.c                         | 2 +-
 checkout.c                       | 3 ++-
 fmt-merge-msg.c                  | 2 +-
 mailmap.c                        | 2 +-
 notes.c                          | 2 +-
 refs.c                           | 2 +-
 remote.c                         | 2 +-
 setup.c                          | 2 +-
 strbuf.c                         | 2 +-
 t/helper/test-oidmap.c           | 1 -
 t/helper/test-reach.c            | 1 -
 t/helper/test-submodule-config.c | 1 -
 transport-helper.c               | 2 +-
 13 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index f29743b1619..7b71d195dc8 100644
--- a/branch.c
+++ b/branch.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
 #include "branch.h"
diff --git a/checkout.c b/checkout.c
index 9235073fc0d..04238b27133 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,9 +1,10 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object-name.h"
 #include "remote.h"
 #include "refspec.h"
 #include "checkout.h"
 #include "config.h"
+#include "strbuf.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 21019c932b3..5af0d4715ba 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/mailmap.c b/mailmap.c
index d62d7bf0e7f..28d389c1f94 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "string-list.h"
 #include "mailmap.h"
diff --git a/notes.c b/notes.c
index c07bcbe3486..02f1aa39ae1 100644
--- a/notes.c
+++ b/notes.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/refs.c b/refs.c
index 979ed3fbedc..d2a98e1c21f 100644
--- a/refs.c
+++ b/refs.c
@@ -2,7 +2,7 @@
  * The backend-independent part of the reference module.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/remote.c b/remote.c
index 3afedce593e..2947743d60a 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/setup.c b/setup.c
index 8a297b3cb5c..a546da755f1 100644
--- a/setup.c
+++ b/setup.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/strbuf.c b/strbuf.c
index 1b93d9d3c47..b2e3735ba8a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index bf4fcfe6efb..de6ab77fdaa 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "object-name.h"
 #include "oidmap.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index d4fa33ae751..5b6f2174418 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "alloc.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 4758c8654e0..c7c7fdbea98 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "config.h"
 #include "object-name.h"
 #include "setup.h"
diff --git a/transport-helper.c b/transport-helper.c
index ca8bec04bb3..6b816940dc6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "transport.h"
 #include "quote.h"
 #include "run-command.h"
-- 
gitgitgadget

