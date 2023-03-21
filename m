Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D01C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCUG1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCUG0f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23033445
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so3684313wmq.4
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379989;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0duFKKzzEoS76qghyZt5ZCKOCb7+s895TLNGoNW0Ys=;
        b=ZqHfoNumkT8tUVymtKBQwMSI8UM/b9U4EsEMwEC3DuK1GY92kUA//frFqa6erBGnaj
         k2foPzOk8s3ZMEyuUKKWl7HdrX0aTqYSdJ4GympN5Zlh+villv4sY7DskQeZu6l9+ywc
         KAI7ZtiNvidQDDEn2tpj0SrTxw/JBWlzASeWy6JeQ/GvNnFYlyP34cosQdMBGsK+rb8y
         6QXYQ0IZxLBhuPRxCg62ZrQz6+GQF/UAZaZSXUEk0f/J+8sXwAFysNVliDaRJDR9w9ia
         D8NPmnZLookqdzGOkajMNKXm6fhBNU6iigLfydSX+fvzKY5wjPUM+TYvSOgsPOIuHwzR
         /xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379989;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0duFKKzzEoS76qghyZt5ZCKOCb7+s895TLNGoNW0Ys=;
        b=s2Slxyuhz2Iod57Yh2PoHWgLxmv79xzrkBY88iGf1sQ130JSmyXMAucarHxzszAtpS
         2E8sUyFQyuwinLaYiwHI7ANcWedD9Ns0sI1Ct2m6khYjPtH7UIvDnJhVRdfHMsQlDXSR
         fzEmsLMC529Kjnz/ncrFk/ibANXLO5n1GeIzbI4N3vUvt211egkd/NL/Auzf1/n0vw9e
         9g/dm0GCeUhw+1CRG380eAREvOK49JELXLwibTDWrDX6ruCMCblZ0ogKEFU0g62v3tO2
         mnXQ76MYwnGvEfVHvA2Gm9nqxWRafwYy9t/FQULARglq91w+8Uj6J+PO/xHH6gIvFUZb
         YQSg==
X-Gm-Message-State: AO0yUKWgIipAcx6DyT3m6+izX+FXGoMcJ2ClgIZpq4+ae4+SR3daetiX
        /fayHb26qWhXTp4uh7Rm7xxOSGlVhVw=
X-Google-Smtp-Source: AK7set/iIq2oIScp03oyWKWSajw0k41FIEhmKBrQd7P0v8EvsdYtGZ970LvhsYMzYgs/vXiYsA/k8g==
X-Received: by 2002:a05:600c:2251:b0:3ea:f75d:4626 with SMTP id a17-20020a05600c225100b003eaf75d4626mr1398413wmm.38.1679379989117;
        Mon, 20 Mar 2023 23:26:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm12358294wmi.42.2023.03.20.23.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:28 -0700 (PDT)
Message-Id: <72d58b391a1335315cf62bea4bcd5c7d80f89226.1679379973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:08 +0000
Subject: [PATCH v2 16/16] csum-file.h: remove unnecessary inclusion of cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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
index 4b5b841d046..61672d50bdf 100644
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
