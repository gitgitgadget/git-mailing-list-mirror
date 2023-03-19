Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA701C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 06:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjCSG25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjCSG22 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 02:28:28 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072BF1CAD9
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso7328483wmb.0
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 23:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679207298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5P1UlA78wC6o2NO71/KwdNqnIIdQ9p+id+oFGNwep4=;
        b=b3BskEKg9G096ArMgWoP3GdSYq9J17tMly/zmtM6QkqIju1WS9PI278JMiF1tOO6Mw
         Xx0oK58xWfUC+C+DvN+YCIojBOo/VueR1+6JZfydGG8HFhq+ryUYN+Jb7LKBdciXpE4t
         hjIHF11hOr96/7E/tc2H8Mj0OXob0o+SWd3jCVM5583n3VRNYwQbvP2oq9qLj0HwAHZ5
         StRI/+mNkQp97zGToN1uN45mo6Goen+VwyLdVNloS2QmQL78LifSJOFNngAqsey1DkXv
         ONASaF+7BDLilbVcNw/uJKz1xMCjS98d24l0Z3TS82vIZ3EMETFTgYgsHHlcRQfWBbnu
         +9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679207298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5P1UlA78wC6o2NO71/KwdNqnIIdQ9p+id+oFGNwep4=;
        b=vKbiEJFyewiSITr59IsRc4afYlmzckWb89osx4brkY4nzDJDKVMIskpN/cyV5vnYAl
         4I9nvktaTc2yJZPGIijs5E3vCShi/7SSbVdZkytMCl1WVI89q8OXhyez08ecJuUDO6en
         EA5HNG9q8e5Rzz6bShECIzGWiVZz3nyam1PJ1P5VDGewcseZhE/b8y4tuALgrTyCEKN3
         dRoyJ6PucQ2LwQc+xqZUgNrwRnS8zOSZwtBlnirPyu92s0Zu2RwoXzijVND3NxwoGt+a
         XBRD7bRGlwdb+fiPTlHyIj6ly9IO5Gbgi3kgufkrT49OaS79UrY63MvQM1mLutZwbJ4p
         uOFg==
X-Gm-Message-State: AO0yUKWtNA8UrR0DSSoWXg8PZuzmu0DG0X9hHTtnVLJ8CXdHbKFo4zMV
        j72ohllpZq6GdrYpupPHfthbxKXiYCY=
X-Google-Smtp-Source: AK7set+YQkbB8Q8oUhqFww13styjwTjIYiiD9GDa9aKSxUeP5q5DZTuED3QSPvZn2Sz2jq3cDA9DJg==
X-Received: by 2002:a05:600c:22d8:b0:3ed:62c0:c6c4 with SMTP id 24-20020a05600c22d800b003ed62c0c6c4mr8889206wmg.17.1679207298423;
        Sat, 18 Mar 2023 23:28:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2-20020a05600c00c200b003edd1c44b57sm1468350wmm.27.2023.03.18.23.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 23:28:18 -0700 (PDT)
Message-Id: <38af06f55bc8fd87af580aa94b8a83cdc5b1fd4d.1679207286.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Mar 2023 06:28:02 +0000
Subject: [PATCH 16/16] csum-file.h: remove unnecessary inclusion of cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

With the change in the last commit to move several functions to
write-or-die.h, csum-file.h no longer needs to include cache.h.
However, removing that include forces several other C files, which
directly or indirectly dependend upon csum-file.h's inclusion of
cache.h, to now be more explicit about their dependencies.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 bulk-checkin.c      | 2 +-
 chunk-format.c      | 1 +
 commit-graph.c      | 2 +-
 csum-file.h         | 1 -
 delta-islands.c     | 2 +-
 fetch-pack.c        | 2 +-
 midx.c              | 2 +-
 object-file.c       | 2 +-
 pack-bitmap-write.c | 3 ++-
 pack-bitmap.c       | 2 +-
 pack.h              | 2 ++
 packfile.c          | 2 +-
 12 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index eb6d7a2805b..d2428b86111 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
 #include "environment.h"
diff --git a/chunk-format.c b/chunk-format.c
index 6d1071729df..60a73c1b140 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -3,6 +3,7 @@
 #include "chunk-format.h"
 #include "csum-file.h"
 #include "gettext.h"
+#include "trace2.h"
 
 /*
  * When writing a chunk-based file format, collect the chunks in
diff --git a/commit-graph.c b/commit-graph.c
index 5481736c76c..f0cd2e7a2a3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/csum-file.h b/csum-file.h
index 4cd9014e367..566e05cbd25 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -1,7 +1,6 @@
 #ifndef CSUM_FILE_H
 #define CSUM_FILE_H
 
-#include "cache.h"
 #include "hash.h"
 #include "write-or-die.h"
 
diff --git a/delta-islands.c b/delta-islands.c
index 1222b6a6cd1..73a01179e83 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "attr.h"
 #include "object.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index c453a4168f9..10f759532ce 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
diff --git a/midx.c b/midx.c
index b111665dcab..9af3e5de889 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/object-file.c b/object-file.c
index 05fff230f73..397596e3c8f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -6,7 +6,7 @@
  * This handles basic git object files - packing, unpacking,
  * creation etc.
  */
-#include "git-compat-util.h"
+#include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 63f16080c9b..0fddeb1298b 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
@@ -17,6 +17,7 @@
 #include "pack-objects.h"
 #include "commit-reach.h"
 #include "prio-queue.h"
+#include "trace2.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 241ac9166c1..23d87e71bd9 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/pack.h b/pack.h
index 01d385903ad..3ab9e3f60c0 100644
--- a/pack.h
+++ b/pack.h
@@ -4,6 +4,8 @@
 #include "object.h"
 #include "csum-file.h"
 
+struct packed_git;
+struct pack_window;
 struct repository;
 
 /*
diff --git a/packfile.c b/packfile.c
index cc3b1e242c7..dd4b369e59f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
-- 
gitgitgadget
