Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CDDC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDAPKz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjDAPKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24F1CBAE
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:44 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so11702874wms.5
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TR4N/Efmqx5wIuutFZPJqwYUKvntB+y/dChvQi+xps=;
        b=Vkr2EQxsYHiDvO/xHOOdoDnN+6jqlK5ebJCn9R6kOnLJcoDHlOl9TRWWN4DhSekY7e
         7y+DcKmWg1LTISPU+T9Th50Mtbi3dX35oG8zPWopE051uLhClrfz4w2wueW/Qcilu8Jr
         Ya5JbLJVOXAJCodAaBIXMCgtckT085DmwePlBptOqtuhSEzJ6Ni9BEWMOIRT9p5zlekt
         Th2JBhyWIfL3Y+8iqhaipI1GlGffSjCf91VTMTAwv3xb7UJPN9lbzyoT9jIBxi03ssKl
         OU/r2VSG4sTDnngsSyGYj7XIfaf3JQe2D+b929/3fsm2CeEA1WGVUcaI/tH14paOSH3q
         lKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361843;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TR4N/Efmqx5wIuutFZPJqwYUKvntB+y/dChvQi+xps=;
        b=Dr4p+VtyjScrxSctg53ci0bOnL2eO6Fc6GktnTPvRnAqH2zp8g32By+D1rLL6oY3cR
         myUP/FrUEzKbXA7mQg30L3586xNERKZ9ehbrZQthYS/M1VN+JNSTYWQXCuKlLgQTeXjc
         VShWwuAV8ciRHhDfocFwlufePLLhxJDWSc/SltAuQnU6Mb+WqzYXdSccJxNP2sZAdBNV
         DE4NjRDa9gBCLGsjAyrmqiQnnRatx/0TFmvgKdSz25dhTrJY1SzJcINN0lznFmbwz/DW
         KKEdUL+f+1v7ngEcGJbzwhx32Qz9rp1CMPz94tZKzGrGCmn/5F9dZe/X34+9kRCFneLz
         RKGQ==
X-Gm-Message-State: AO0yUKX1VOsVVXcz2WHbBVxZzX8i8+DZeD/q0hsaXcL53wy7eLhK6M0j
        +cJWEcHHIxVwnuBiyALi2INCL/cpdLI=
X-Google-Smtp-Source: AK7set/5B1fsPhyKf2a1QREo0mVrIgFXT/OEHwGoABEtHWgGzHlr382VbKqrtatuuGLxQpFhg9dwJQ==
X-Received: by 2002:a05:600c:2305:b0:3ee:9c0e:c78f with SMTP id 5-20020a05600c230500b003ee9c0ec78fmr22861732wmo.5.1680361843153;
        Sat, 01 Apr 2023 08:10:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b003ef71d7d64asm13731774wmo.6.2023.04.01.08.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:42 -0700 (PDT)
Message-Id: <e163bed61ff7330d7ed2991a4e19f8ead917063b.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:15 +0000
Subject: [PATCH 02/24] treewide: be explicit about dependence on advice.h
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

Dozens of files made use of advice functions, without explicitly
including advice.h.  This made it more difficult to find which files
could remove a dependence on cache.h.  Make C files explicitly include
advice.h if they are using it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c               | 1 +
 branch.c                  | 1 +
 builtin/add.c             | 1 +
 builtin/am.c              | 1 +
 builtin/clone.c           | 1 +
 builtin/commit.c          | 1 +
 builtin/fetch.c           | 1 +
 builtin/merge-recursive.c | 1 +
 builtin/merge.c           | 1 +
 builtin/mv.c              | 1 +
 builtin/pull.c            | 1 +
 builtin/push.c            | 1 +
 builtin/reset.c           | 1 +
 builtin/tag.c             | 1 +
 cache.h                   | 1 -
 config.c                  | 1 +
 convert.c                 | 1 +
 editor.c                  | 1 +
 notes-merge.c             | 1 +
 object-name.c             | 1 +
 refs.c                    | 1 +
 sequencer.c               | 1 +
 transport.c               | 1 +
 unpack-trees.c            | 1 +
 wt-status.c               | 1 +
 25 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 1e1ee2df596..b381f14a7de 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "advice.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/branch.c b/branch.c
index 99a0e7889e4..3a087b8b4c1 100644
--- a/branch.c
+++ b/branch.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "branch.h"
 #include "environment.h"
diff --git a/builtin/add.c b/builtin/add.c
index f12054d9be1..d3c51e28142 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "builtin.h"
 #include "lockfile.h"
diff --git a/builtin/am.c b/builtin/am.c
index cd1e20f24e5..8d876f31546 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -6,6 +6,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "builtin.h"
 #include "environment.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index c171def1f3e..f1e8aa3f27e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -11,6 +11,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 9d8e1ea91a3..b09017e04f9 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -7,6 +7,7 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "lockfile.h"
 #include "cache-tree.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index ffe0e214592..f2b80987751 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2,6 +2,7 @@
  * "git fetch"
  */
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "gettext.h"
 #include "environment.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 8ea9dc78aa1..25f42f2be7e 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "builtin.h"
+#include "advice.h"
 #include "commit.h"
 #include "gettext.h"
 #include "tag.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index a99be9610e9..225b7064066 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -9,6 +9,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
 #include "abspath.h"
+#include "advice.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index b7c5ffbd8c7..8f7770aa32b 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -6,6 +6,7 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "advice.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 5405d09f22f..636ce12c94d 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -7,6 +7,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "builtin.h"
 #include "gettext.h"
diff --git a/builtin/push.c b/builtin/push.c
index a99ba38a368..6001e4ae0a4 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -2,6 +2,7 @@
  * "git push"
  */
 #include "cache.h"
+#include "advice.h"
 #include "branch.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 4d639ec6b37..d8c52cc6edf 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -9,6 +9,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "advice.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index bfd51389571..3e801f54a07 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -7,6 +7,7 @@
  */
 
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "builtin.h"
 #include "environment.h"
diff --git a/cache.h b/cache.h
index c8ae80fded3..d9ca2688d8c 100644
--- a/cache.h
+++ b/cache.h
@@ -5,7 +5,6 @@
 #include "strbuf.h"
 #include "hashmap.h"
 #include "list.h"
-#include "advice.h"
 #include "gettext.h"
 #include "convert.h"
 #include "string-list.h"
diff --git a/config.c b/config.c
index e5c2e477319..3cee6538f3f 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "abspath.h"
+#include "advice.h"
 #include "alloc.h"
 #include "date.h"
 #include "branch.h"
diff --git a/convert.c b/convert.c
index 126036ec330..59127706448 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/editor.c b/editor.c
index d632d790660..3bea3ef72f7 100644
--- a/editor.c
+++ b/editor.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/notes-merge.c b/notes-merge.c
index 19405ec71ac..0258f87d21f 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "commit.h"
 #include "gettext.h"
 #include "refs.h"
diff --git a/object-name.c b/object-name.c
index 53f9d359ee8..ff647d6c7b5 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/refs.c b/refs.c
index 0f369dbde7a..cfced6f174a 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 
 #include "cache.h"
+#include "advice.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/sequencer.c b/sequencer.c
index 1a315ac13c9..eaba379e3ad 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "abspath.h"
+#include "advice.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/transport.c b/transport.c
index 11b38d16dcf..82bf2496ba7 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index d41489b4adb..c6de2ca5a7e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "strvec.h"
 #include "repository.h"
 #include "config.h"
diff --git a/wt-status.c b/wt-status.c
index ccbfd9cc6de..47f223c0f8d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "advice.h"
 #include "wt-status.h"
 #include "object.h"
 #include "dir.h"
-- 
gitgitgadget

