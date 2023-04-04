Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2280C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjDDBXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbjDDBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D7935A1
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m8so7163007wmq.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAXhH+LzGFxAfkUwTGHBBpYa3E6LXP/MJEq7bJTXUek=;
        b=Uj78tGEaX+8vscgyh7AHMDmJwDehs4R6q+31XddFhnhhjuTUjiO9hc812/yEfiLFKI
         dpWTXmpB4SJnLg/vkyRzMJj1PnPW9eATM75x0HtQrm121IIYdNxK/TnX/xBjUKz++mbQ
         /DVaANz2fz0WBu0BADuPeBRxUMi8fKIA62wQGCaV6y7WkPU/l82FDluOq/s/Shq23wS8
         XgxjDzoi9hba4698mY/FyDIwxAmwX+LDVv2IBf3pr/j5eSWYep2FFHu6S2/sAyDGLsdm
         VsHsbSfLueTKI3XJ6q1blYMiWgyabTWpYDj8XTAZMX9R6Bnde23HyZ1dcoviDC72wuHJ
         8g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAXhH+LzGFxAfkUwTGHBBpYa3E6LXP/MJEq7bJTXUek=;
        b=3lt/Vv8ovdeFAoV65IJj7sBRYXVSWR7aNYXBikPcA8sXP+Xkl7FJiNZF7VkdkXF2/1
         iq8DEi/iOamjSoCv0BgMhzH0ljQNfucTH9eWqm/VIRFQmvLLl4m1uOIeU7epWqZvhb4k
         jaStXgFvKAg5L0fDkvwWxb8g9M5OoKLtd51d+XSgOvonXSIGA/0JZpIS6FrHVdtaVYUv
         xZ43EzoqU3pUx9kMiIcKp7vWzjIWH6c6epHVcPZaTFQL1OMbFEtzvPK149uOWG0v8+n5
         7jrwZ6XJeSNnHdGll3XYngsZoEXetOyBn9O933BU/ei4yJhE5XTnLKYccfBHn/E184Ed
         sL8A==
X-Gm-Message-State: AAQBX9eKGKjlKbo3+TueCTov+IY8Fim9phDVXmlYjWC/XUtq7BMbtcU9
        CgEwnTZB0to3M7GJUuE+bejBuV+qVYk=
X-Google-Smtp-Source: AKy350YeoQBxE2CX2gpzNqDZSH6GTE8f+3bdRViaHBmqI0fm6q+0ugF53B8g247HDcWyBIAJz8j1Gw==
X-Received: by 2002:a05:600c:3649:b0:3ee:8e3d:4b9c with SMTP id y9-20020a05600c364900b003ee8e3d4b9cmr832125wmq.21.1680571363522;
        Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c218500b003ed243222adsm13472814wme.42.2023.04.03.18.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
Message-Id: <1827ecb4d1d01e657155be72ec0a8a4992544e98.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:17 +0000
Subject: [PATCH v2 13/24] treewide: remove cache.h inclusion due to
 object-file.h changes
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
 bulk-checkin.c  | 2 +-
 commit-graph.c  | 2 +-
 http-fetch.c    | 2 +-
 http-walker.c   | 2 +-
 http.h          | 1 -
 notes-merge.c   | 2 +-
 pack-bitmap.c   | 2 +-
 pack-check.c    | 2 +-
 pack-mtimes.c   | 2 +-
 pack-revindex.c | 2 +-
 streaming.c     | 2 +-
 tmp-objdir.c    | 2 +-
 12 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index af15f8a9af4..9192298db6a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
 #include "environment.h"
diff --git a/commit-graph.c b/commit-graph.c
index c20e73ceebf..0c4f2266445 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/http-fetch.c b/http-fetch.c
index c874d3402dd..fffda592670 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/http-walker.c b/http-walker.c
index 4588e6a340a..3b41f5654b3 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "repository.h"
 #include "commit.h"
 #include "hex.h"
diff --git a/http.h b/http.h
index 783b2b09b8b..3a409bccd4e 100644
--- a/http.h
+++ b/http.h
@@ -3,7 +3,6 @@
 
 struct packed_git;
 
-#include "cache.h"
 #include "git-zlib.h"
 
 #include <curl/curl.h>
diff --git a/notes-merge.c b/notes-merge.c
index cc9538ac5c0..233e49e3195 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1371f17d22f..48fc2ec76de 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack-check.c b/pack-check.c
index 40d88bc5ebe..049f2f0bfc0 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 0096ace080b..020a37f8fe3 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
 #include "object-file.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 22a1958a1fc..4d9bb41b4db 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
 #include "object-file.h"
diff --git a/streaming.c b/streaming.c
index b3415724ee4..21e39585e89 100644
--- a/streaming.c
+++ b/streaming.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "convert.h"
 #include "environment.h"
 #include "streaming.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index fff7ff42db7..c33a554f921 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "tmp-objdir.h"
 #include "abspath.h"
 #include "chdir-notify.h"
-- 
gitgitgadget

