Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04698C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjCUG0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCUG0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:31 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111D834C15
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id w11so7790328wmo.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpMzJovi4rL4tbmKmwrtRhGaO9JHxo0SbaTRGOP69v4=;
        b=HgXlHzuOE8ypHclIK5qwShreGBe39t+Z2M1X8X6LnsuRRE3M4Xrr2PR4XSzxeQr/HK
         JA7R2ESmH85H5TmuibZNGehUWuHlpIjaLByezBgoQjD4INaKQdMr1cyRVBv5hYmIL3AD
         4W9Jl8WAH2Fr2psmtwRXVe1RWfL3SUoIjhsXBp+3jEO5m93M6zl1NFANPsBV0FSaSbK6
         KPYOl0MqAOZ3deHNwyGeZ4O+ZByUjGpizui0FNHD/Mn1cgwnKjhHPzvsoG1Pv8dZ+7ep
         UbY2+TpaRHOjnFv2D5qaLjEOh7jYeZIAlRiHQuBOJhrrw4mxyDbHV0mT450T6LUNmuc4
         O+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379985;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpMzJovi4rL4tbmKmwrtRhGaO9JHxo0SbaTRGOP69v4=;
        b=yiS8mX8Bg7nGhvbOEjEvj00lDj4gJ73X32f0gHAIix82k/TDWbkGtn+5WKW2cMtXhs
         xYjqJl9urNYLVYG3gLoXPBFlZzLh5C3PjSVu8PIxlS+hO1GwEITMVVkUtBalqaw8oywj
         oUYwyysNKLUgQBEkZX4Kz9UOlw13CQWbwA6b7cANabHbaCQzXxhNQbVjgXbmUh/0U349
         RgZ9XWJVpekzdUwSwYBW4mNM6eyt0v6COsjGCb+FgMPK1qxNd1hn6JmW+HAwSK3pIHUq
         9njZj1Qt7rDTzAcaJzgXQWRH7jqiYQv6waoh9NwMUuKJWdVe+Q7lstjF4omCa+kk31ed
         n/Xw==
X-Gm-Message-State: AO0yUKXEKH1AUuY0CgDQc4Eowqp2+QAgLQe/qVCtNYi1aHIJcQgSYddD
        C/iGnu9uTZveMRncgJZWlhq3it0LLxc=
X-Google-Smtp-Source: AK7set+rQln20UqSFE8Ca4LI0Sswjz1nHrU+5y2tUo5tSVEXjdItqL7mo21DuTMdv68f26cgcfVQ9g==
X-Received: by 2002:a7b:c409:0:b0:3e2:19b0:887d with SMTP id k9-20020a7bc409000000b003e219b0887dmr1386982wmi.25.1679379985398;
        Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003b47b80cec3sm18631608wmq.42.2023.03.20.23.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:25 -0700 (PDT)
Message-Id: <a6c7245219af6552c139903b5ecd12e497384f67.1679379972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:26:02 +0000
Subject: [PATCH v2 10/16] treewide: remove unnecessary includes of cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The last several commits were geared at replacing the include of cache.h
in strbuf.c with an include of git-compat-util.h.  Unfortunately, I had
to drop a patch moving some functions from cache.h to object-name.h, due
to excessive conflicts with other in-flight topics.

However, even without that patch, the series of patches so far allows us
to modify a number of C files to replace an include of cache.h with
git-compat-util.h.  Do that to reduce our dependencies.

(If we could have kept our object-name.h patch in this series, it would
have also let us reduce the includes in checkout.c and fmt-merge-msg.c
in addition to strbuf.c).

Just to ensure that nothing else was bringing in cache.h, all of the
affected files have been checked to ensure that
    gcc -E -I. $SOURCE_FILE | grep '"cache.h"'
found no hits and that
    make DEVELOPER=1 ${OBJECT_FILE_FOR_SOURCE_FILE}
successfully compiles without warnings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/terminal.c      | 2 +-
 gpg-interface.c        | 2 +-
 lockfile.c             | 2 +-
 parse-options.c        | 1 -
 t/helper/test-delta.c  | 1 -
 t/helper/test-trace2.c | 2 +-
 tempfile.c             | 3 ++-
 trace2/tr2_cfg.c       | 4 +++-
 trace2/tr2_cmd_name.c  | 3 ++-
 trace2/tr2_dst.c       | 3 ++-
 trace2/tr2_sid.c       | 3 ++-
 usage.c                | 3 ++-
 12 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index ed2b30b38f7..d87e3211892 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "compat/terminal.h"
 #include "gettext.h"
 #include "sigchain.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 6644701fda0..aceeb083367 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "commit.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/lockfile.c b/lockfile.c
index 673c21d17a9..1d5ed016828 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -2,7 +2,7 @@
  * Copyright (c) 2005, Junio C Hamano
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "lockfile.h"
diff --git a/parse-options.c b/parse-options.c
index a577cc85f67..b6803647d0e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
 #include "abspath.h"
-#include "cache.h"
 #include "config.h"
 #include "commit.h"
 #include "color.h"
diff --git a/t/helper/test-delta.c b/t/helper/test-delta.c
index 6609fcbc12e..e7d134ec251 100644
--- a/t/helper/test-delta.c
+++ b/t/helper/test-delta.c
@@ -11,7 +11,6 @@
 #include "test-tool.h"
 #include "git-compat-util.h"
 #include "delta.h"
-#include "cache.h"
 #include "wrapper.h"
 
 static const char usage_str[] =
diff --git a/t/helper/test-trace2.c b/t/helper/test-trace2.c
index f374c21ec32..a476df6c6cb 100644
--- a/t/helper/test-trace2.c
+++ b/t/helper/test-trace2.c
@@ -1,9 +1,9 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "exec-cmd.h"
 #include "config.h"
+#include "trace2.h"
 
 typedef int(fn_unit_test)(int argc, const char **argv);
 
diff --git a/tempfile.c b/tempfile.c
index cdd2cab3bad..50c377134ce 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -42,7 +42,8 @@
  * file created by its parent.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
+#include "path.h"
 #include "tempfile.h"
 #include "sigchain.h"
 #include "wrapper.h"
diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
index ec9ac1a6efd..78cfc15d52d 100644
--- a/trace2/tr2_cfg.c
+++ b/trace2/tr2_cfg.c
@@ -1,5 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
+#include "strbuf.h"
+#include "trace2.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_sysenv.h"
 
diff --git a/trace2/tr2_cmd_name.c b/trace2/tr2_cmd_name.c
index dd313204f51..b7b5a869b74 100644
--- a/trace2/tr2_cmd_name.c
+++ b/trace2/tr2_cmd_name.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "strbuf.h"
 #include "trace2/tr2_cmd_name.h"
 
 #define TR2_ENVVAR_PARENT_NAME "GIT_TRACE2_PARENT_NAME"
diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
index 273260e1f18..5be892cd5cd 100644
--- a/trace2/tr2_dst.c
+++ b/trace2/tr2_dst.c
@@ -1,6 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "sigchain.h"
+#include "strbuf.h"
 #include "trace2/tr2_dst.h"
 #include "trace2/tr2_sid.h"
 #include "trace2/tr2_sysenv.h"
diff --git a/trace2/tr2_sid.c b/trace2/tr2_sid.c
index 5f1ce6f85cf..09c4ef0d173 100644
--- a/trace2/tr2_sid.c
+++ b/trace2/tr2_sid.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hex.h"
+#include "strbuf.h"
 #include "trace2/tr2_tbuf.h"
 #include "trace2/tr2_sid.h"
 
diff --git a/usage.c b/usage.c
index b53c99dbe5b..46d99f8bd43 100644
--- a/usage.c
+++ b/usage.c
@@ -3,8 +3,9 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
+#include "trace2.h"
 #include "wrapper.h"
 
 static void vreportf(const char *prefix, const char *err, va_list params)
-- 
gitgitgadget

