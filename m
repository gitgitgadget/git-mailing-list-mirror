Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC219C761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjDAPK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjDAPKs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2ED311EA0
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so16805666wmq.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361844;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL1v2YjUjOWVwiEqFxVI69kg4JImA9WN+JwcnhEeOJY=;
        b=bESJ9JRD5aX1+CXZby00cDiUkL5Gsmgt1JF4CEOXkZ2ybkh34Y5FObEvQsJMNOlilN
         SQDbfHkb9lyDKX43oDcEOlT24Y1TgHvrsIxLPAvUpyUXklAXWyAn/dNZrQyW+wLuO2+T
         17hbS8Ud72Nd7Ad1HxHApdu8MQ4EbTMcwu7DVp4zyr0HYr8JxzsNd9lKkwF0x8dst3VK
         hO/mnH1q+LLu3BsvUTCLVvRWBQbpnpKJNpolR5MjiYqLir/AOTBMPwQZ9dKFG+vRp+n/
         kN0p6xyXiBrvqKquwDM10B66HBAc/nbgT8E6CbS8rHNLAqWvtJyibAamIZDX2V0rHdKH
         JxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361844;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL1v2YjUjOWVwiEqFxVI69kg4JImA9WN+JwcnhEeOJY=;
        b=IJ892c/Ot8jh+t2uZ3QjIv7Rz7WqOJ5T44Q7Z3pmzNPo4hvKnbbOjT0zDxClHK7nov
         UkvWwore2+WrJHXAxpCV04UgN2mLn3qGAunuT0UoXf8PDWfNjLbjR7vtOtXPgOvQkk39
         NkT8ox/d+wy+kIbtEItFMsYuNaDdB1UQl8AyGsbldF87C3d3jzfNDDoJpX7iDw6AQ/x5
         qkEEcB4SAcKBf2Pc2oh8XGAtkV+3jyjSOTmIiMWpquUePBKfVHq6v+820qQgNYKQ3HKt
         ue3icPeLkjf58nkIgMrZ7RMpuYCzZ8BHrUFH9A2DwmGYY9yIO8IWVWXm+8JH82EG9Dux
         HwJg==
X-Gm-Message-State: AAQBX9dpT/izG/wjUUwXf6yMyKF03EhoENBGoyzw5zgDN/k0aS4FHGlG
        GAaWcU9BN99xb5HAKxGJ7sdF2673Ewc=
X-Google-Smtp-Source: AKy350ZipIxsS2wmVZmBmlJ6GD9It5R2/KsFfoSWuymZfCzo2xjvHIZymVrkGk71HGrZXJrYhIVyqw==
X-Received: by 2002:a7b:ce83:0:b0:3f0:4428:9445 with SMTP id q3-20020a7bce83000000b003f044289445mr4062468wmj.14.1680361844592;
        Sat, 01 Apr 2023 08:10:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003ef71d541cbsm6348261wmj.1.2023.04.01.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:44 -0700 (PDT)
Message-Id: <86b47be1776a24b3a1d1f83e8658ec4199c44665.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:17 +0000
Subject: [PATCH 04/24] treewide: be explicit about dependence on
 pack-revindex.h
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
 builtin/index-pack.c | 1 +
 cache.h              | 1 -
 pack-write.c         | 1 +
 packfile.c           | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b17e79cd40f..ceb0f120ede 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -17,6 +17,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
+#include "pack-revindex.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/cache.h b/cache.h
index 415f0f85670..5f1279454a8 100644
--- a/cache.h
+++ b/cache.h
@@ -7,7 +7,6 @@
 #include "list.h"
 #include "gettext.h"
 #include "string-list.h"
-#include "pack-revindex.h"
 #include "hash.h"
 #include "path.h"
 #include "pathspec.h"
diff --git a/pack-write.c b/pack-write.c
index f1714054951..152c14aa7aa 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -9,6 +9,7 @@
 #include "pack-mtimes.h"
 #include "oidmap.h"
 #include "pack-objects.h"
+#include "pack-revindex.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/packfile.c b/packfile.c
index 2d3dabb1aee..02afbe77137 100644
--- a/packfile.c
+++ b/packfile.c
@@ -21,6 +21,7 @@
 #include "object-store.h"
 #include "midx.h"
 #include "commit-graph.h"
+#include "pack-revindex.h"
 #include "promisor-remote.h"
 #include "wrapper.h"
 
-- 
gitgitgadget

