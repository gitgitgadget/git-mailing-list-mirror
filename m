Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2895C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjDDBWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjDDBWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:41 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65321FEE
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:38 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l27so31146571wrb.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TR4N/Efmqx5wIuutFZPJqwYUKvntB+y/dChvQi+xps=;
        b=TysSmkd1ZdBHeiZSivIEWeKbNd9uwhY4PYWw1ke8QYTYmNBsHcJ1XEl1ZD3XGuYdqK
         W4OSmTKndsKumT13ad4LqMzYyEevBJ3mvRneWGD1K60PGRQfHjoh11/bRYqVUIyDVfeN
         5ZuciraAgg4SePnSg7gCQRni+X4YGCD+toGxNVU+ieJCIhOaFLyLd7BIGmemy0St+trK
         dx8/Kg10woUhGpC6PrH/LmfwuPxzbIUf8T28BQVzVSprwUMwbzfMz0b9KkySrf3souMo
         KygshITudY9Tn/W8LT6EUvMxERancgcwxC7U2smGZvbaYFNvhZjqmH/Mk4ou//+xeT69
         MGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TR4N/Efmqx5wIuutFZPJqwYUKvntB+y/dChvQi+xps=;
        b=wG7FSEN4Eovw3tDAgKsQYgOea2kGykUsI22ozK0Ga/Vx5p1Dj+uV3XFja+wRwlLmz0
         e80NB6iDlMvVh+Obxn5YWuIOY6SRCM9uGd6JExiWf8Zj3/au/odEkM25U8faCi8Mpx8g
         r0XQzB8ZcbdVyBW7/BTteGnzPDTZmj2UC7iNm2lfBAE/KhULuUvkY5TVm8nplc5wDlu5
         akvYuSacBy4eESHNSACnfzLUioJEnv4olXtM9/y27b9z34teE8241n9OoyGgaVa6wb2K
         twGQpzaLEF7bmOSSX8DvLVrmX6rnGpcDre9CHYFQo4SlIH0bU/lbBSZoiS0RQD6Wmv8l
         GfOg==
X-Gm-Message-State: AAQBX9f4Nqgofxoyui5FM8LWuKqLQi+GV6NKJvpCASIpweRzDNtBVIDh
        v9YpZIWRiWvHoIDCJAvwu20/iF/lGHM=
X-Google-Smtp-Source: AKy350Y99Yqb8SPbp1lZo5zplkH7kD7BlnHzmVNlB5D1oVanh+MW9iDkg6vhWTBjmu1P1ZJ/20QtGQ==
X-Received: by 2002:a5d:5704:0:b0:2ce:a8e4:bb79 with SMTP id a4-20020a5d5704000000b002cea8e4bb79mr264449wrv.53.1680571356980;
        Mon, 03 Apr 2023 18:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iw13-20020a05600c54cd00b003ef6988e54csm20478223wmb.15.2023.04.03.18.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:36 -0700 (PDT)
Message-Id: <e163bed61ff7330d7ed2991a4e19f8ead917063b.1680571350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:06 +0000
Subject: [PATCH v2 02/24] treewide: be explicit about dependence on advice.h
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

