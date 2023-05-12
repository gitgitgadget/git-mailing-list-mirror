Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4BEC7EE24
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbjELHFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbjELHEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68847A84
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306f2b42a86so6283024f8f.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875089; x=1686467089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=KUS1DdsR+zz6KscnaDMti7RfAcm5ZcVHeQNP2tGGABKxfhcm8p1ofKulSiKidsDboL
         MPo/gVwVQv5lRmRqrKcI1Sm/7Cw/IUMqVtJm3ayV04eoH0VLehrSw+a+hm6YlxIQQA5M
         2mYOMqTTX7fjudzfpLHSeNeCnjhtp24shLRdJiqW2X38UOsAgGOkT9h9NhBX4P5nvbTj
         IQwMlr1E8UyM5BnQY6rIt0Eemtmanlmmdt7QAmLIDOqTQpITVsdpVnQ8694Y93meckTX
         xGs5Pu2tVIzPNWKpetBDhjQG0xZzDaKsGZHLCUA0/okvIbP+wBdqUuX0f8+4Gsrvq5DA
         HyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875089; x=1686467089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=lwRbUWAxm2dUz6IfQQWRVTWuH38iRs9DZusBYjVPS/XY609DYpwygRD4ok/38y8Drw
         3K1ChqaSfyY9MSYFEAQ8Cllr/a04xWtF2yPMzC29eEWbvoxlERxZeT1zlyK5t1Ni79B0
         /fije7nOHk4lyvvF5pjDCdD5nUFamfY5vMOZFxHzUHdYb+lKaYjoM6MJfhHmNK+U3Stb
         e5OylHM3P+E0p6OAarJdBhb9/u3iF3bCN5y6jaVxHTyH3PH7ZrRs7q9cW/qrNOyr2f6Y
         KIhXXuhnB2odlk52mqm63Hql3cQCXTzNwOvzRbkaApP9Rf7QA+tZiBdLm1qlD8pvxr2L
         8CWQ==
X-Gm-Message-State: AC+VfDx3xx055vhU9kc8zTHQbVUhVbnsUCsl6R55UGNu4KyoNwUpIB+e
        KdkOzA82tutrfBgI+FFASiJDhmU+ofs=
X-Google-Smtp-Source: ACHHUZ5gVw86QY/WRvb1WrxKAzvgiPQhRmVoK1MYSi3s0LcBs6t+XpX+cwIOHXrk/e65uFLqWnHOHw==
X-Received: by 2002:adf:e511:0:b0:304:6715:8728 with SMTP id j17-20020adfe511000000b0030467158728mr19355895wrm.18.1683875088939;
        Fri, 12 May 2023 00:04:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15-20020adfed8f000000b003047f7a7ad1sm22563903wro.71.2023.05.12.00.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:48 -0700 (PDT)
Message-Id: <abfb127b812c3c7501e54bbb9213c8598056ad50.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:16 +0000
Subject: [PATCH v2 15/27] repository.h: move declaration of the_index from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
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

