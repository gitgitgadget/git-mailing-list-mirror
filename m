Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A91C6FD18
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDVURv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjDVURm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F395A1FEB
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fe3fb8e25fso1759944f8f.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194659; x=1684786659;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ORgi3XkRxetuqDIw16hCNyxvy587ZYTzf+hQdHh7H4g=;
        b=mGDoaAWYcxgK2PrNY2+7sOAjlypcIpL2T70aYt1IacVZR3US/WJdsFbJQVERSQIZ9M
         hnzdSoQ36zsVNzPZPLhiaSudMHsPpRSwCEWOwElKm1UV1/O8ow/xxTs2Eygk2y8fabkX
         o6gAzz2K/iX1zmSkYYBKSBGLXBPGH1cOoqxIEParbl6tTG0Df7K/eHLXqimGEU0K2z3V
         +D3s6Svm611FpsiE0r1yxxIZIJVV8sRxj0vqtwhlmmDtG0pUrSlHmE7xDsTTd0y+g6L+
         5QgvMCy9QVPS+HiLLNnqUdPf0Gk4xZuXX9SITUbLSWTtHmENDKR8jZjdOODtno5sXxnT
         7a/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194659; x=1684786659;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORgi3XkRxetuqDIw16hCNyxvy587ZYTzf+hQdHh7H4g=;
        b=dpbCAPlScfT+jNTPd/atO9Xf54wrVnRGpqtbHXxrQgd2fhmFhul9EoUDFWiEmo/0Mi
         w4VlPE474tsi35tx+lshR8ttRn/sy8vdTIQcixmV+qQrmGWZkGZbTZXRgYGcFpWeAX43
         /jTkpXeefLvMAYiFf28w3OtmA4xtN4BtJP8p6+/ErFyj0YwtMXgqEyB+RrTrlv+K2dDb
         dbVmDLzSgpjsYLTNt+kdpJEPS0eiwlOORiJOAr4qG9psHrWTjAoOTrp1q9YIiJ9Kr2Qg
         O5JJTFyDweXQT9k7GJfiLE5ebTP1bgInhW3cvWS96uRxup2GVuqyguMN7dp97WOUAucs
         JGVA==
X-Gm-Message-State: AAQBX9fJychhnoHCmCfyBD5MVsRn0i9JmajbQf0k5n8F+DRadbz+UiH+
        cgmsX/u5xslHfG0PNnCL3tuOpCg//aA=
X-Google-Smtp-Source: AKy350ZCsMGIFM38sD882pS7uT5IMz540VHwcjfUyZOITGW57sZLHTGBJU7PVQ3vBxd4XZJSpKTy6A==
X-Received: by 2002:adf:fdcc:0:b0:2fa:14c8:3f22 with SMTP id i12-20020adffdcc000000b002fa14c83f22mr6305488wrs.30.1682194659435;
        Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003f1733feb3dsm11521472wms.0.2023.04.22.13.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:39 -0700 (PDT)
Message-Id: <2d829783f30ad9d9bee116d777f38b3d89ae0e0c.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:14 +0000
Subject: [PATCH v2 07/22] pkt-line.h: move declarations for pkt-line.c
 functions from cache.h
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

