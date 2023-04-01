Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35323C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDAPLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDAPL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:11:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B7A25473
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:57 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so11831262wmq.3
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukccWYzmlNzBYLB4Y0DURMPte1jAyunBFMedtYyj2dk=;
        b=QOYn9REJy7Y9PDM7ZCmL3Q9EE2s/3x3fM87WlIFN2UWePpFUNGpir6kdGAfTG/vp3G
         pAbg1ATH/qXUa/u1x9Gk+A6YNN5iH58g+qFSMoOnrQ60tj6GVxHnAj6J9wb/wTBgloCn
         dJ2MmWz9Iga8QAU4/BgMn8fLGbd6M+gkBzDvDgHMt23sGojRdqnm1nXX6fv+Dsw8Kuih
         EQmoa1OOIZqjCfmBB35CC3hF+1gktYDcsGdzC2w0g9H7ynQ8lT8f4zlp/Jw7ZMdQ7ld/
         2HZyFMEORckFsocrt3T5LGW4SNMjPtvw2JE68ngBkDrhlNmAhydeNRaGzufuDTnENok1
         7acA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukccWYzmlNzBYLB4Y0DURMPte1jAyunBFMedtYyj2dk=;
        b=RGjEV+zJlxSRF2mCNpJAkrkeymVVXZM0Cmo++6YcsX3JahST4uSEuj9RgpYzO/Y7GL
         I9fTc2pKKDM1Cr1vxJbBra3HGv8QzGrHG1XdLN3aulQm2ZZ3a0EqzD0MJ+1j0hSHNiJk
         FoNLognOzsUW+fz9wD1BNz/h4+u2JBD2X8fJ46z4fQd7zkfO7mmYJlkMKDsw5VRSBkLI
         bm2rlKumR380aC49494Pk4HPpidj8oNGaXehg74PVunl9sOq0/YTFJRqHmIXtiOOH7rr
         WTC4kBRRakbBG0oRmcnGAmNaUelYEXaCWIFwyQrC4weLtmq+xPVA63lXnkjrWADpzeza
         afsQ==
X-Gm-Message-State: AO0yUKXa1rRRwbqy7yIBe+C4ptKcuaMG+5YFhK/teyKLtjh8a0g0dYTZ
        1aPrRPGi6I2E3wekYmNhewUxP7Vhzeo=
X-Google-Smtp-Source: AK7set9zJo81zdPSJGkmayIGfJ641Yblut1IiRl4h2BZW5pH/cDuTUpB4KmvvBJsaMnmyEGpSvXGUg==
X-Received: by 2002:a05:600c:2157:b0:3ed:cf2a:3fe8 with SMTP id v23-20020a05600c215700b003edcf2a3fe8mr24093597wml.8.1680361855554;
        Sat, 01 Apr 2023 08:10:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bc059000000b003ede06f3178sm6325784wmc.31.2023.04.01.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:55 -0700 (PDT)
Message-Id: <c4808cf95786bcefb98bdfc62e5d0a321895cd30.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:35 +0000
Subject: [PATCH 22/24] treewide: reduce includes of cache.h in other headers
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

We had a handful of headers including cache.h that didn't need to
anymore.  Drop those includes and replace them with includes of
smaller files, or forward declarations.  However, note that two .c
files now need to directly include cache.h, though they should have
been including it all along given they are directly using structs
defined in it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 archive.h        | 2 +-
 refs/ref-cache.h | 2 +-
 rerere.c         | 2 +-
 resolve-undo.h   | 7 ++++++-
 revision.c       | 2 +-
 split-index.h    | 2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/archive.h b/archive.h
index f96839ef383..3a4bdfbd078 100644
--- a/archive.h
+++ b/archive.h
@@ -1,9 +1,9 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "cache.h"
 #include "object-name.h"
 #include "pathspec.h"
+#include "string-list.h"
 
 struct repository;
 struct pretty_print_context;
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 850d9d3744e..cf4ad9070b9 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct ref_dir;
 struct ref_store;
diff --git a/rerere.c b/rerere.c
index 093c0f6f993..7abc94bf444 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/resolve-undo.h b/resolve-undo.h
index 2b3f0f901e6..d1ea9727712 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,7 +1,12 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
 
-#include "cache.h"
+struct cache_entry;
+struct index_state;
+struct pathspec;
+struct string_list;
+
+#include "hash.h"
 
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/revision.c b/revision.c
index 7438b50e267..bea401992e3 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/split-index.h b/split-index.h
index 7a435ca2c97..1a153f47ba3 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct index_state;
 struct strbuf;
-- 
gitgitgadget

