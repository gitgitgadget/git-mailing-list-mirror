Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238BC77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjDPDDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDPDDe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:34 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989A926A6
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id he11-20020a05600c540b00b003ef6d684102so10092994wmb.3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614211; x=1684206211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg9dCGj/E41vODRP6M1NnnQyNQK9Qh1cjUc72jXAaU4=;
        b=sjY/AcK8D2Db/hK7MpsP1+OBiq8DrOxJ7wwM3xnuWTdOvA5PsuIuWuh1LhA9l2PNsa
         ErpIytr95dxnX4aMOgk3JdADfCjb15oKSSmg6PjRKT6xbmpAedeErogCN+CARv1yogzp
         CV2qrFamX9+firbNSnQo2U2+TE8rXJioLLAKJDYyhiuOv55Evs7U/44sdLrQSgpV4xoZ
         REHBDtjoxpzl8Mv7fwmLRNxnNKGL1QOUnw/RVe0eNpoIx+rND9QfyWlql7r5qHSFtGzG
         7OT6K468oenk2r9qe9NKTOpUDUSpnJKi41oMbkYi1YaCeFchrWen4W15fDbPJ3KzcxIR
         WbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614211; x=1684206211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg9dCGj/E41vODRP6M1NnnQyNQK9Qh1cjUc72jXAaU4=;
        b=JTVbDx9RAUPQ3eLJDH22M3jzDICX/Mvs63R5IhcjS/YdqTJKgRHSmL5FrGwo1fc2rk
         ceC+7hUw2hgXfeXrbU1C05Jdr8NPD53L8MMStDFtGSnDqpEj406REsRzmoTkkgPEuwbe
         quKWPJD76JRIVTfurHttE5BMuLRFpya8syzuB/Iw511X1xfcTLotcFQhE5WREu1QTJNs
         eisJVIfiDUg6L4dzd9mO+3GrD6XXq/a00ecwj7mhhHfMhiv0RB8PVE/kWBXmX0Qf+QXl
         KC2XtI2gzDEIMxU3tochjw+blQXdDqQVfTtdfrrifY6QQQGSL15LEG6/QO+93ndniq3p
         +odQ==
X-Gm-Message-State: AAQBX9e/cVyCaHfViAQ6saaqC3lQ4wfSIZQNZ7UTNUon3A4S7okm2sw6
        ++f42E9fFs3dJY0nHWkmYvcjBOybEjY=
X-Google-Smtp-Source: AKy350boPeRdc8UrsA8qRdZn3t1uUX2mCT3dxrXQHEw4RGFr3GecWfiGV9OIWf5kbVk+3Wt6PyJjHw==
X-Received: by 2002:a7b:ca50:0:b0:3f1:661e:4686 with SMTP id m16-20020a7bca50000000b003f1661e4686mr2724696wml.7.1681614210949;
        Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b003f0a0315ce4sm10819760wmb.47.2023.04.15.20.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:30 -0700 (PDT)
Message-Id: <cf28ce0ee209c8441a175aca49929e5c860a0dee.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:06 +0000
Subject: [PATCH 04/23] packfile.h: move pack_window and pack_entry from
 cache.h
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
 cache.h                   | 14 --------------
 packfile.h                | 16 ++++++++++++++--
 t/helper/test-read-midx.c |  1 +
 3 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/cache.h b/cache.h
index ffec289dc5d..ffb9028f015 100644
--- a/cache.h
+++ b/cache.h
@@ -593,20 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-struct pack_window {
-	struct pack_window *next;
-	unsigned char *base;
-	off_t offset;
-	size_t len;
-	unsigned int last_used;
-	unsigned int inuse_cnt;
-};
-
-struct pack_entry {
-	off_t offset;
-	struct packed_git *p;
-};
-
 /* Dumb servers support */
 int update_server_info(int);
 
diff --git a/packfile.h b/packfile.h
index 665603b696a..c3692308b8d 100644
--- a/packfile.h
+++ b/packfile.h
@@ -6,10 +6,22 @@
 
 /* in object-store.h */
 struct packed_git;
-struct pack_entry;
-struct pack_window;
 struct object_info;
 
+struct pack_window {
+	struct pack_window *next;
+	unsigned char *base;
+	off_t offset;
+	size_t len;
+	unsigned int last_used;
+	unsigned int inuse_cnt;
+};
+
+struct pack_entry {
+	off_t offset;
+	struct packed_git *p;
+};
+
 /*
  * Generate the filename to be used for a pack file with checksum "sha1" and
  * extension "ext". The result is written into the strbuf "buf", overwriting
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 05c4f2b2625..b32abff7f11 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -5,6 +5,7 @@
 #include "repository.h"
 #include "object-store.h"
 #include "pack-bitmap.h"
+#include "packfile.h"
 #include "setup.h"
 
 static int read_midx_file(const char *object_dir, int show_objects)
-- 
gitgitgadget

