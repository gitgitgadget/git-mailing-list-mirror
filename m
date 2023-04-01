Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275BC6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDAPLK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDAPKy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0041EA23
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so103878wms.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAXhH+LzGFxAfkUwTGHBBpYa3E6LXP/MJEq7bJTXUek=;
        b=Pf21qgmToBTkvU8dZC7iisiCR+km3l3/jmlrtfVIl+HQo+5gD8pJDCgEiMs8IZ6Zz8
         MZI9yHdgUDtvNchi932fT18awgy9Muvq+3jvFY+YRLhYS9lPQIqro4MZzly9oZICNQe+
         UjuXLjl2izIhIpf5uZJn9io3sru41Dq3JMlEvvu9vJHTBtaaltGclp+3SdTLRzdZq/GH
         ZHh5CaTfPRfFGkVF7MjUUIJ2GFUCrzHVqQmPLefLxGkMnHF3/g7URvu4b1hIT3A9vJYV
         QYwBBIUEP9EU/hF34MzZnMPdVXwCODNtcoA4B52krBalFOzkYZuxo8hEry6qcyqJISDl
         S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361850;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAXhH+LzGFxAfkUwTGHBBpYa3E6LXP/MJEq7bJTXUek=;
        b=ruvG7Zpw0nBSgplyAckOdDSJC91kLNDAq1ugAvQTBWg/OlQSbw9gxIL7GSFzfF6s5R
         okbmDV99Yey162ZvzEbrhHKThL4LMKb6igEroPl1nLhgqQe3gPuFXkTxzSrxPUD+lnvo
         6SMibNPvJkU4UxyxD9RBO30TAmuNJR0OyQD6ygva1lEMOYskoO0pbCXZYzhrNtondDGM
         JzpWlkcDuqGTUhHBvfbTOg6qYyulpciELRuzufCBJy2PKvzYzY45jtaSJS1BJqxCL0OW
         SYxZjAZ5e68vLxQ8t+pU7iKO6+BvSt9Z+tusGASOAH+VHf9AJZezht0SUUZRzO+CLwK3
         TqCw==
X-Gm-Message-State: AO0yUKVoRwCKWGFQaQfFjOonwuoVOlRLb9QY6DEpGIInpIFX3wM+l3r8
        lyr0lXh/RMpncn1fz573mdkht2n0+V4=
X-Google-Smtp-Source: AK7set/2YKZI5LF5caRwSeOyOiIy48KKzA0ECZkgroHOBOd1oF8WP0ZqLlM0plbMU1B7/rZ09g1awQ==
X-Received: by 2002:a7b:c7ce:0:b0:3ed:a07b:c59d with SMTP id z14-20020a7bc7ce000000b003eda07bc59dmr23707472wmk.21.1680361850000;
        Sat, 01 Apr 2023 08:10:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b003ee74c25f12sm13472916wmo.35.2023.04.01.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:49 -0700 (PDT)
Message-Id: <c103d486b2a06af9b72be5283484d43a713fa0fc.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:26 +0000
Subject: [PATCH 13/24] treewide: remove cache.h inclusion due to object-file.h
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

