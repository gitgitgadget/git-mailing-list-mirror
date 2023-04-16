Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06895C77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjDPDDq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDPDDf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C2E2711
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2efbab47633so378593f8f.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614209; x=1684206209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxQBscBC/g8H1L8ETVCqABnKtnxmxuhj/69d0QIq4fA=;
        b=Dqj/IiWeaHmTvcedswG35N2XLHlXsDRA/VRnsdZeGIxTpsVK58yX6rnuUO/k4bOigy
         BtGbOP38s2fwRUmt06JgjdH9IVqoLpwZgIT+s+QBy123yhe3RUYiTD9jLpjc5WgkNQW8
         19QcVCeFf4evbJRmUmSZElYtTrbbbDGHV2zosgS/bT/y0zeWXwQEoT14fNqOomgXWFZC
         DpiQgV2bXTrZ7D/W2veTl8Jq+t9t5XkBmSvWLcj4+yR+g58lXUViMfmEds6iUoMjpUOh
         yWQv6cJ1Y+Kxp6rGP34X24/sxV82y4baBwQWvZkQDPEO7c8OgK2sZxTKyevbUcb7rp0Q
         f2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614209; x=1684206209;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxQBscBC/g8H1L8ETVCqABnKtnxmxuhj/69d0QIq4fA=;
        b=PEycovQWEfR6mAyEC507fcYT0S5+HCQuCKj0sQR2ZSh771i2J13IGrRj29VRTTyBlY
         5RzkX1NvIc7v4LNVMZeZHWWF8BRO0gb0643LwfaqxzfTED4/c7W1ukba4UFaP0UKerWJ
         6DjdsdEAzXV0OZbMYBquLRVKDs01no7kXwMZ28yHrcgq9AByf9BmH9+8DbzeF6/ywQzl
         acppIkdYrn1zGqnbdySVmtT8IOxl9whHEcRLoX6NfT0XTocEIiFC2uad1q8vkRWtIWXD
         Ba/gp54po2YMdXmQXJJbX3iCW0as6MTQr+joqfVSVRM1prO3iKhpc+rG9m4CQ1NvBVMN
         i+iw==
X-Gm-Message-State: AAQBX9dzGRQQre8cTtMuN71z0obF24yg0ZySOPBj8Q4qYY2wODVvNmmv
        F6N0W9N3XhXbyVRDPZ+fxzgHkQZhJL0=
X-Google-Smtp-Source: AKy350abtpFjjSHCVDeF61tDlDiPZr9wKZX6YdTA9Efw/Pkvm/1EXfm/txX7djNTX6+nx5ZKCAKZIw==
X-Received: by 2002:adf:db4c:0:b0:2f6:6f0c:a2ba with SMTP id f12-20020adfdb4c000000b002f66f0ca2bamr2737896wrj.63.1681614208972;
        Sat, 15 Apr 2023 20:03:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4e51000000b002f01e181c4asm7056363wrt.5.2023.04.15.20.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:28 -0700 (PDT)
Message-Id: <6d6b80993749b9cec9ba6249d970da421de24e1d.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:03 +0000
Subject: [PATCH 01/23] treewide: be explicit about dependence on strbuf.h
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

