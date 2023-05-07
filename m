Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905B0C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjEGDrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjEGDqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9818176
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30771c68a9eso2702915f8f.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431164; x=1686023164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=VuDZ4sTvvDMHK3/+r2JM7PL3rSYdj2XX3reCGAyDeCJy6diJqFKNJxlVdhydajlDcA
         GEaqniuzKg30rAhelKTF35qxKMynUfx1Ey/BzO3YGtVPlOASqDPawS151TtMfKzNWRKC
         uPTDly24CMinyfvAbXqyw8aa498SPiWN/3ep1uz5KPjaBYrB5a2EyjismG24dEc7XuSX
         PNuhzuMI3N1pCIzBePtlWntZKQseNdSCEY4kdkWQ9W4x4Jqdw+ivqPS8sMAZpMLyi1jp
         3rw2SsQPLB6FPczUp3JFP+mXQoRHQi0JIDm1JQ/5j2IIOOtBy8odpeCb8/E73b51eRgj
         NHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431164; x=1686023164;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCGUWfMTa72akBAHQ1unEi/WpotVdZJ6yNJXRlRlCI8=;
        b=hCSpvW56KM8639h5d2Jkl75wzzCcLjlPalTy5oSd4wxeDrNdCzOYItdFdwqZdell1c
         qdH1eX4atBS7GTuAz8UFJwjCnUGziPSK2qF1oUwAptgy1fi3vOa7pXfBPtQFyUNjCbU9
         G0rOltfBs/E9hiGVScoQY2Rb0mmYt8t7QRLLgLxHIcV0Cgn95irbNL4qaTMsw6dxTD6x
         27lc1ORGhU+0xEj2cvYa9HaC/vwC2/4n73ExeC27uwrdGsA+CZ4/m0PDfL0r6tJ0XZsr
         qHIiqFUT3CHr8OhUOHMxiPMIdRlKIzlhc9rzEl6uWfpqrd+AgfDT+TUZXQse1F0bsMR/
         aN0g==
X-Gm-Message-State: AC+VfDwoOijmdY3MCIOEw6XKBXAxzSGvENVq+0o41NO4ErWPlhaVU2XJ
        Cbnv2co3Q/mB27hg+s1N6odtniPhMFk=
X-Google-Smtp-Source: ACHHUZ5Jum4pbn5mvtL5++cQMm3amREZRNqjL5xDbvYzkObBe1uMf6DNNW6sT8Lci0vvlrHPC17SuQ==
X-Received: by 2002:adf:eb09:0:b0:307:7aed:3505 with SMTP id s9-20020adfeb09000000b003077aed3505mr4281625wrn.36.1683431164532;
        Sat, 06 May 2023 20:46:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18-20020a1c4c12000000b003f188f608b9sm12473365wmf.8.2023.05.06.20.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:04 -0700 (PDT)
Message-Id: <59dafa5eaa6ba4835aad7cd6432b21b5c0677800.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:39 +0000
Subject: [PATCH 14/24] repository.h: move declaration of the_index from
 cache.h
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

