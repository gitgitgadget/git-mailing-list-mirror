Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3EDC77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDPDEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDPDDg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B8230D5
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2eed43bfa4bso653345f8f.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614213; x=1684206213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORgi3XkRxetuqDIw16hCNyxvy587ZYTzf+hQdHh7H4g=;
        b=SeAy7KxcsF7fxksZRsbQaCschz5d1Aj7iYT+r5f1tjsaB7MRW8lUt7/Hr2K+14ZRb2
         Rpd3r6BjfexMFGwZIHFpmCMfvI5sLRXHuMzMMEI+I5SZOME9LxcYCPRyXwAOSxSOqW8J
         MGkIxOpxxyzm45cte0BD1DbG8l5C8tpv+yQGACMzp6h//3cAAApue/BXjx46hacHyB23
         jEv4TV2WLvAz2LrvQ0QgJk+6T+SF0t4s9uLphrdlFurrU73MxgARIwStKvNp5hx2186A
         hGPJA3C9ebMaHlLKOimm6co8trbfLgqYcDal6PgtQkyUAc6T2IRhaEJca6N3B1Ygv60D
         timQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614213; x=1684206213;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORgi3XkRxetuqDIw16hCNyxvy587ZYTzf+hQdHh7H4g=;
        b=A2Qb6GXmtdJzYMk5I5GEPmzagWXNl6EumiAGnyv6i2vU4k8jWD2tqa2rWiD/gWhQRA
         arf8yycMUEe0udgY9elnAmqEYnIHRP9fHPHVrcNTAEaXsbW1q379cBd76YGvrjjn9ALd
         v+iJuh9t9kXEF3gc0Q9d7uk44lnGmUgFx7/n+D0bgeQUTlU3Q1E2IBUksHSL2+psFNvU
         XAq1Wt+q15hRY4xhgsA3SAdqIST0ofMr5PuPB2Bp/XoG74njuFCgveUYdC3CAj3TAxWk
         HECy7CtAnUfsU5abVGGAInrYv2fwBw1Xs3CkwzuoiCCiuim/CcSsQMB+Zr3jOIZWG2yq
         c11Q==
X-Gm-Message-State: AAQBX9fiqbsQoigzruKRalWAGaTL/M8p09bsc9jfyg1xLJKVc8802FMD
        G6YgTgHV3fwE+s44OFobPN4Z/quJ6cI=
X-Google-Smtp-Source: AKy350ZajKAhrDh7sczyRevEkzmJezBK6LmMbAjLT1oQJx7d5/dvPrQv4lZJPWvddPZ12F8DITPv0w==
X-Received: by 2002:adf:fc41:0:b0:2f2:3dbf:6922 with SMTP id e1-20020adffc41000000b002f23dbf6922mr2287133wrs.22.1681614213512;
        Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bcd18000000b003f09a9151c1sm8067097wmj.30.2023.04.15.20.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:33 -0700 (PDT)
Message-Id: <e8efc37ecb289b0f8085fac69ad7a408ed3e7461.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:10 +0000
Subject: [PATCH 08/23] pkt-line.h: move declarations for pkt-line.c functions
 from cache.h
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
 builtin/bundle.c    | 1 +
 builtin/clone.c     | 1 +
 builtin/fetch.c     | 1 +
 builtin/ls-remote.c | 1 +
 builtin/push.c      | 1 +
 cache.h             | 3 ---
 pkt-line.h          | 2 ++
 7 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index e68fc83d943..584d905d965 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -4,6 +4,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "parse-options.h"
+#include "pkt-line.h"
 #include "cache.h"
 #include "bundle.h"
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 017ebc3faa8..fa300f483e9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -39,6 +39,7 @@
 #include "setup.h"
 #include "connected.h"
 #include "packfile.h"
+#include "pkt-line.h"
 #include "list-objects-filter-options.h"
 #include "hook.h"
 #include "bundle.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61e8ac113b1..4fee2a62376 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -29,6 +29,7 @@
 #include "utf8.h"
 #include "packfile.h"
 #include "pager.h"
+#include "pkt-line.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
 #include "branch.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 11d9424804a..7972febf726 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "transport.h"
+#include "pkt-line.h"
 #include "ref-filter.h"
 #include "remote.h"
 #include "refs.h"
diff --git a/builtin/push.c b/builtin/push.c
index 6001e4ae0a4..7d2b0505aac 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -14,6 +14,7 @@
 #include "remote.h"
 #include "transport.h"
 #include "parse-options.h"
+#include "pkt-line.h"
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
diff --git a/cache.h b/cache.h
index b89f4c59802..fde782a96f0 100644
--- a/cache.h
+++ b/cache.h
@@ -593,9 +593,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-/* pkt-line.c */
-void packet_trace_identity(const char *prog);
-
 /* add */
 /*
  * return 0 if success, 1 - if addition of a file failed and
diff --git a/pkt-line.h b/pkt-line.h
index 8e9846f3151..7c23a4bfaf7 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -246,4 +246,6 @@ void packet_writer_error(struct packet_writer *writer, const char *fmt, ...);
 void packet_writer_delim(struct packet_writer *writer);
 void packet_writer_flush(struct packet_writer *writer);
 
+void packet_trace_identity(const char *prog);
+
 #endif
-- 
gitgitgadget

