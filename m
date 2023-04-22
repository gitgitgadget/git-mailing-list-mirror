Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74DC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDVURs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDVURk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF81BF9
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f19afc4fd8so3324795e9.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194657; x=1684786657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg9dCGj/E41vODRP6M1NnnQyNQK9Qh1cjUc72jXAaU4=;
        b=p+clux+eXJTYbU79FT4wVuKLg33sWByuGpiqA+U86KDBwrr5QufS8MQZihKrMhyixN
         uXI22f5TTQyTr2Cac17WLmHDZnVak6QfqVJcw5UoZqrQaSCfYXvp5hHmrBiHvfJIlXp/
         l26clhNFlWF5SADnCwfXIZlBToaMaVzgP6vXKtCv6qbnEnN9/q+LbM3OUFmkjh9rTbRu
         6/rARB9nE9prcpAK40UnOrfmnFyzFQsK+VJU8OybQhyfJScsGk5usGZDjFtyuGz+bQ8Z
         h+NOALUkCQi2/SXtm76GnxZsFu2+kb2LY77Xp/Gnax0DUbIf50rEaRAyaUyiYaO+Dvj6
         5gGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194657; x=1684786657;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg9dCGj/E41vODRP6M1NnnQyNQK9Qh1cjUc72jXAaU4=;
        b=THQyxksDl6X6dtaP4Cjrghi76SU+CgHEZCH05NaT/AIsvDu6ni3HbgEwAraKr7ftFL
         X6/lgBkCwdgFWG9x1dq18KKLwgJLAxi6Y1WtzSD/gJXpV+hjNB49SRvHLNIQGKXsZN7L
         q94HVhoIMcCfNDOX2PB/27Nf+6lKdBGjsLvchysA/23JeZq7c01CxfeArA9XRfTDGyep
         c/FjbBVOny134n26UPlfXR1OCJjCd7jv8tC8YaweDfc+IHV6uL731wReF/Mp5gfe8Dx4
         bDzgmhqMXy38F9SLyVZpROpi2Ldmg2B/nPIDXVRl349TPqTw08QB2YSDUjKqv07l9Ytl
         m/0g==
X-Gm-Message-State: AAQBX9fNO1AMY3kG5li8FO4G1Ro63YGvU661eH17UjomVvdZG6RPiy7h
        HC723LTTrbX4EDhL/EDX3rp5TMtVdp4=
X-Google-Smtp-Source: AKy350YatYioEcFPD6dQaamjJyTEdUIOuoufvr/9yo1NjzVwdFek5sq2qpMZGWivk2Whx7zRcX5qOg==
X-Received: by 2002:a1c:f602:0:b0:3f1:7a50:dd66 with SMTP id w2-20020a1cf602000000b003f17a50dd66mr4749732wmc.27.1682194657019;
        Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i40-20020a05600c4b2800b003ee6aa4e6a9sm11340016wmp.5.2023.04.22.13.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:36 -0700 (PDT)
Message-Id: <99dfc5eb5dc1db367feeb90f668d32f4133fb044.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:10 +0000
Subject: [PATCH v2 03/22] packfile.h: move pack_window and pack_entry from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
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

