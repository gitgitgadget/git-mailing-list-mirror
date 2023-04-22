Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC96C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjDVURk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDVURj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9621BE7
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2eed43bfa4bso2711504f8f.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194655; x=1684786655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxQBscBC/g8H1L8ETVCqABnKtnxmxuhj/69d0QIq4fA=;
        b=KvjKXZ+lhHweQ1CkNYakUEu8/fyi12tL91xzjPg3Fje16ZMllZFKTQ/gXAjYIlqVWe
         EuXSh5g09fklET9LxOVfuWSyzWmIozzIk9FDexqsXgrsWceKwVrtlP/C+o1iVocurOfw
         9VsrETUAo7bRaxpZhKywepjACbziKGs5IJ4hjOAsnnMowu49UQL/pykGaMFeDQc6GqSb
         AlmQnz6em2DMcAryniNh2n47UEQy6A5a9hTF7xyh/ikIzc9R9ZBsiuB9cZ6qh5EU2V+5
         BLcEia/n+GYqglOcsbP35vUxRkLdgzQIXHqQ+rL8anoKa8lo7M81bUEdvkz13VsjN2VH
         Pqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194655; x=1684786655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxQBscBC/g8H1L8ETVCqABnKtnxmxuhj/69d0QIq4fA=;
        b=BNyqE8WivrSH5HF2nCTTlF8twd/w7ncgmcQPq8CBQWJZwmo9N8vMSNVQGRrLUUkEC5
         apaB1teVdk/of2V8GaDJ+61znvWKcAOvw2QXyx1OJscOxZXbUwLyl3XXDALP8QH18gi8
         q8m4CI15mYjIrm/ffP1zpaoimBIQ7tSInsUH6QlMF87zFAjNyukBTLeyeV7JTYd/l6G5
         fYJpcXPcC7VdhwJDr7Z9SJgl64i7QJC82TO9LP3HNvE/WCcehgqqiekqVVR7UWh0Larz
         L2/PXytSSqCjsChBDZVRzXCeqa7lu9ge1+uT/dfZcD6fqLHAPInnsJtjB/Qw6clXVsV+
         kZGA==
X-Gm-Message-State: AAQBX9fuco1FfXMvkASRGj5BURQaCemYNy9ZVu2CZ60alklGgeHpdV2O
        crK5h+dRTrEdUj4lcX4KU8EpV0u/B/Q=
X-Google-Smtp-Source: AKy350ZLNNV2W/YewVRqRGyIwhecP5J/kXJfgguZ2PRfZWE2tNxqUAvPT6gXZ9h6Qc1A4NVtxhacFQ==
X-Received: by 2002:adf:db4e:0:b0:2f2:3dbf:6922 with SMTP id f14-20020adfdb4e000000b002f23dbf6922mr5597074wrj.22.1682194655574;
        Sat, 22 Apr 2023 13:17:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe947000000b003011baf89b3sm7229349wrn.40.2023.04.22.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:35 -0700 (PDT)
Message-Id: <1341ae8125eb23e7d469a5b3c79e3dee2d230537.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:08 +0000
Subject: [PATCH v2 01/22] treewide: be explicit about dependence on strbuf.h
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
 color.c                       | 1 +
 common-main.c                 | 1 +
 credential.c                  | 1 +
 date.c                        | 1 +
 ll-merge.c                    | 1 +
 split-index.c                 | 1 +
 t/helper/test-mergesort.c     | 1 +
 t/helper/test-oid-array.c     | 1 +
 t/helper/test-oidtree.c       | 1 +
 t/helper/test-parse-options.c | 1 +
 t/helper/test-string-list.c   | 1 +
 wrapper.c                     | 1 +
 ws.c                          | 1 +
 13 files changed, 13 insertions(+)

diff --git a/color.c b/color.c
index 6031998d3ea..f8a25ca807b 100644
--- a/color.c
+++ b/color.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "pager.h"
+#include "strbuf.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
diff --git a/common-main.c b/common-main.c
index f3193173535..601a875e2fb 100644
--- a/common-main.c
+++ b/common-main.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "attr.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "trace2.h"
 
 /*
diff --git a/credential.c b/credential.c
index e6417bf8804..42194efc9e0 100644
--- a/credential.c
+++ b/credential.c
@@ -8,6 +8,7 @@
 #include "url.h"
 #include "prompt.h"
 #include "sigchain.h"
+#include "strbuf.h"
 #include "urlmatch.h"
 #include "git-compat-util.h"
 
diff --git a/date.c b/date.c
index e944c8905af..bc030da012f 100644
--- a/date.c
+++ b/date.c
@@ -8,6 +8,7 @@
 #include "date.h"
 #include "gettext.h"
 #include "pager.h"
+#include "strbuf.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
diff --git a/ll-merge.c b/ll-merge.c
index 28bc94c45d6..85517e668e3 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -12,6 +12,7 @@
 #include "run-command.h"
 #include "ll-merge.h"
 #include "quote.h"
+#include "strbuf.h"
 #include "wrapper.h"
 
 struct ll_merge_driver;
diff --git a/split-index.c b/split-index.c
index 5602b74994b..3fc4e91485a 100644
--- a/split-index.c
+++ b/split-index.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "mem-pool.h"
 #include "split-index.h"
+#include "strbuf.h"
 #include "ewah/ewok.h"
 
 struct split_index *init_split_index(struct index_state *istate)
diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 737e0c52358..3aabae6c1c4 100644
--- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "mem-pool.h"
 #include "mergesort.h"
+#include "strbuf.h"
 
 static uint32_t minstd_rand(uint32_t *state)
 {
diff --git a/t/helper/test-oid-array.c b/t/helper/test-oid-array.c
index fd6f73ea03b..ea3bf278984 100644
--- a/t/helper/test-oid-array.c
+++ b/t/helper/test-oid-array.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "oid-array.h"
 #include "setup.h"
+#include "strbuf.h"
 
 static int print_oid(const struct object_id *oid, void *data)
 {
diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index edcb7e9f448..796c9811e0f 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "oidtree.h"
 #include "setup.h"
+#include "strbuf.h"
 
 static enum cb_next print_oid(const struct object_id *oid, void *data)
 {
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index 506835521a4..20a81a1eb21 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "string-list.h"
 #include "trace2.h"
 
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 2123dda85bf..959f27c74c6 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -1,5 +1,6 @@
 #include "test-tool.h"
 #include "cache.h"
+#include "strbuf.h"
 #include "string-list.h"
 
 /*
diff --git a/wrapper.c b/wrapper.c
index c130d7518bf..e80f83498d8 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
+#include "strbuf.h"
 #include "trace2.h"
 #include "wrapper.h"
 
diff --git a/ws.c b/ws.c
index da3d0e28cbb..036ccb8ee9d 100644
--- a/ws.c
+++ b/ws.c
@@ -5,6 +5,7 @@
  */
 #include "cache.h"
 #include "attr.h"
+#include "strbuf.h"
 
 static struct whitespace_rule {
 	const char *rule_name;
-- 
gitgitgadget

