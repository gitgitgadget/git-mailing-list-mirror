Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DAFC77B62
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjDDBXD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjDDBWx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FBF2105
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so31120716wrr.12
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EY+NKghyk9DcaNVw+9oailBJd+YAFwgrT46FEd5bw8c=;
        b=oggwZapCsGEjSjAkv/HvsxdGr0UtzCAavzFkRnsv4ER3LLskV5dOiGgqiMSYWbvD/f
         j+/KyKdegKM26C4tc1H9+4uwNy1BFW7YiN3aTQNlB3uoFbHrmgQcTWEy5Ag7oS5Tum7K
         4+wYfbOSrg/HziF/wUM7xeLAypzwjUywuZ8VemTaYjATCzuYz0c69kNJqOeptCclMVYN
         L/KejsjSPoYOdSB/nNwyAGn29LhXc2vHLShpPzpwB098PYBzTiYm8CMhdYwd7knhUPI0
         3c2z1og/Gq7dT8VYepocI4Cq9BhPpbhy/KqmcU5eI4sqbJkvnbURnCV4Hqtezt39wnQb
         YDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY+NKghyk9DcaNVw+9oailBJd+YAFwgrT46FEd5bw8c=;
        b=nB0PN2EjzKrSYzwRyJks2HgYQmJlrkc4lDgpuySVtbWkeHAsSCFZDTbKNrDNcQe7VT
         f/bMQTfkg0ufy+SAMQ/7VCN6NKtFB/mSqrMQbSZ3W5OetGgThZqrkLe7Q0m9GbyzpFpW
         vW3Ro5b6kCGagUi/vQKSXQoWGoqsAyUJ8uTNBbgoadXK4eu/gov/5AAOaT0THhCf8tm+
         kUVp06mMs6pztJNs7h/iUQFzgkn9cwJp3Jy2F0VbyB4w65EiYj10C1Uz0dD6lFg8hFew
         7IjDpx/ulsHqQqVz2Ws2mQ0vcOTd3DYLzgZF+oV9uHFMu/hROODbBx99nFcbYIKDohMG
         Yf9Q==
X-Gm-Message-State: AAQBX9d9ReW8RV6aA7rN56uPJc78Vs2j6g9JXRr3KOVkXEOm+CsLVp2k
        cOvW3wkzHPOvrnXB9kkcdbUrpKdkoQ8=
X-Google-Smtp-Source: AKy350Zu6IANnqIQwAmqQvh/Osxl2hiqn6wYHZhvIP/68v6+3rERSFtsIY3+rSyY8iiwq+WdjTL1ZA==
X-Received: by 2002:adf:f24a:0:b0:2d4:e032:6322 with SMTP id b10-20020adff24a000000b002d4e0326322mr15877792wrp.31.1680571361106;
        Mon, 03 Apr 2023 18:22:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020adfdd92000000b002d64fcb362dsm10890837wrl.111.2023.04.03.18.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:40 -0700 (PDT)
Message-Id: <62f61514e2f4433975d1de81f9593f710e328fe6.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:13 +0000
Subject: [PATCH v2 09/24] treewide: remove cache.h inclusion due to
 object-name.h changes
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
 branch.c                         | 1 -
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
 13 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/branch.c b/branch.c
index f29743b1619..7df982693af 100644
--- a/branch.c
+++ b/branch.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "cache.h"
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

