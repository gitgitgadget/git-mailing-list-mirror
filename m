Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DBBC77B7F
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjEPGfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjEPGer (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:47 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ED746AE
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:31 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f475366522so43981855e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218869; x=1686810869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=e4ObqYpA8bY0oZNvGJFvGYUw4DCzHpLLMVJ2EeFVrkYSqHYALARnXiJcYOYzHxULFV
         C3Lt/fMYn+AOY2eo4lCh2ItYhktRYdVmEP8sp9zmSnHlyCcVu9vxHkXWmHLuXSvONM+w
         6fnQEVtHfk4D6qh+5XWhTXCLw1tSfPYB2+ElyVlRB2KO4DJmOfQSfhhiCXHCDfAIzdBv
         FiD1R2lVGFj5Sd1tEdrr8U5mrDzHBwsDYi5rl/wO27vXLeFVWXJXbxwmtimADmch/YRX
         QVfGya3JOrr27H4LQqt3ZGym2Kbx/T3xAzDGRCctuZ3D1c1w81AT746Xia1UMs+GooUA
         CnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218869; x=1686810869;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=jyOpGeUFjzcaVlv2ahcgGcVtKh/hWTYi3uR6ddxqfv8J8eaeYNFcvHyMz9/YSFaC+M
         c4KBi3RWTvH0WMX2pQ/Bf7hQwUCi6y0BbXThQE8oGxsEoMKr8BRuCXje/2AXe5peG/Gk
         s9XMdBxzkCZeHLuNmWWwBgqbAamHD9DIAtIrhAuV9K5HTTWobcUIkLMSdFTz251/+/RX
         U9N76AfIHk3gfyOMcm6jrPacTHVcdrnpFeGoxQ/IxeQaLQyS5jQzx6x2aqB7JgwIT4H5
         0xr7L83yKu6m51GlvMc0MP82Z1DAujZdGMTuGEi5NOzBPAe+wnzjQlsTHR24sUGbGyqW
         jDbA==
X-Gm-Message-State: AC+VfDxannODD0mh0gP/ALNYzOeShLdVxley8CCiLNTjoyUsuHhIL2PF
        bm3bEbOw1uLQN0VLZKEDRWuVUdicHCE=
X-Google-Smtp-Source: ACHHUZ6cRY8yVwGzvH963lnyneQUvMGIXb3xVjIj/FPeCHNAS61VOl9PeqxV0c4j3BaPaxjuUi7xMw==
X-Received: by 2002:a1c:7c0b:0:b0:3f4:fc57:1c3e with SMTP id x11-20020a1c7c0b000000b003f4fc571c3emr6904377wmc.12.1684218869363;
        Mon, 15 May 2023 23:34:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24-20020a7bc458000000b003f4e4b5713esm1115501wmi.37.2023.05.15.23.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:29 -0700 (PDT)
Message-Id: <c8d8032c75c29c3c48c77b6e3cd3ced3b0ea9864.1684218851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:55 +0000
Subject: [PATCH v3 15/28] repository.h: move declaration of the_index from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

the_index is a global variable defined in repository.c; as such, its
declaration feels better suited living in repository.h rather than
cache.h.  Move it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h                          | 4 ----
 repository.h                     | 3 +++
 t/helper/test-dump-split-index.c | 1 +
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 5b690b80a16..11882897741 100644
--- a/cache.h
+++ b/cache.h
@@ -312,10 +312,6 @@ typedef int (*must_prefetch_predicate)(const struct cache_entry *);
 void prefetch_cache_entries(const struct index_state *istate,
 			    must_prefetch_predicate must_prefetch);
 
-#ifdef USE_THE_INDEX_VARIABLE
-extern struct index_state the_index;
-#endif
-
 /* Initialize and use the cache information */
 struct lock_file;
 int do_read_index(struct index_state *istate, const char *path,
diff --git a/repository.h b/repository.h
index f81228bcfb5..763794880ed 100644
--- a/repository.h
+++ b/repository.h
@@ -169,6 +169,9 @@ struct repository {
 };
 
 extern struct repository *the_repository;
+#ifdef USE_THE_INDEX_VARIABLE
+extern struct index_state the_index;
+#endif
 
 /*
  * Define a custom repository layout. Any field can be NULL, which
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index d1badd71126..63fde9157c4 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "repository.h"
 #include "setup.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
-- 
gitgitgadget

