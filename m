Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BEC76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjDDBWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDDBWl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:22:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9292105
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:39 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so18068334wms.1
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CL1v2YjUjOWVwiEqFxVI69kg4JImA9WN+JwcnhEeOJY=;
        b=J+5Kd/EUU1X2Us+x3aeVsJcRmK0vQJ21voHMqY/+as05WBDn3SkmpFICiUKXbyg9kN
         r+V3HV92YhBXYr4IOSL4VzJymGLTU/0tBxnhhp2dMOFhM/P6V+k5sNzMIoF/svFqRyU1
         x/8kFy1I/FH7t89xZpkmBQlwVlk+amZ0cH3B8tbjHWApYHMVGvIe6bs8FFxvM4t7J2v9
         NvV+H3kY6oj+y+HDtciBBCjCGlKa5qVolQDXhkDBV9dAuWTH1BmZ6wOMNWivBTd7n9W7
         5FyFQQyWdDoFbuO5eEGF+O4d3zkVWE9msuZPjG9z/ynoD/Z6Us5Ac7MfGbvFwcQWwDCK
         PK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571358;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL1v2YjUjOWVwiEqFxVI69kg4JImA9WN+JwcnhEeOJY=;
        b=a7iIlBR6Kd1N4lZ8xcI/xShnBJLlC3osnNz8Uk72a3WzmBmYyl6YPktEpm+V2uCcJ4
         9a2d+IpX/nTXvVq7VBq6hO55Q9BkU3cW9iyiDV+RWLa5CNAozc2ADTQ8YMak5b/WPhxY
         w51GAK85MKDMx7tu3jcuDkdRY6YowkNOLynEXLDBJ+RAWa1tNHw+ke6AmwKEfDMEYwuk
         MgsOjmomJuPylMihUTVodV74vewPcfXfqvpjoJvaEP0IBOchhifEd61oi1qK8JklySYT
         YvUJS62pBiQdwJFPqw7fclBPPxl3GYNiw8camGarVsvTV7NvjnYca6XN/4oV9yOpQ5O4
         zWrw==
X-Gm-Message-State: AAQBX9fUUGAU4uKLUSORpdgm3//Eg+hcMxdlzikukGyXg/jK2zN3ibVy
        9OcenpgYc9IpUVzTA3pgOPJ0h2jmKrY=
X-Google-Smtp-Source: AKy350YALZyIm4xcY/iM+SCfO19tMFW4Q8bYjcQMGNDf5oNNdbgadjqeOEM1W+/tfE1vqXKDgVVFAA==
X-Received: by 2002:a1c:cc1a:0:b0:3ed:33a1:ba8e with SMTP id h26-20020a1ccc1a000000b003ed33a1ba8emr832762wmb.1.1680571358044;
        Mon, 03 Apr 2023 18:22:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b003f03d483966sm15618895wmo.44.2023.04.03.18.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:37 -0700 (PDT)
Message-Id: <86b47be1776a24b3a1d1f83e8658ec4199c44665.1680571350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:08 +0000
Subject: [PATCH v2 04/24] treewide: be explicit about dependence on
 pack-revindex.h
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

