Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C69C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjDAPLF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAPKw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEC1F7B2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o32so14578652wms.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ipHwAmtn8xKMpsfY5sEo8iqzC7xjIdi7/Wr/PXcOaM=;
        b=cFtnNHbmWiymoaIiD7IGqiZmq49LtH9fSlWlsqvmOKRk5FtxAtS7LieFwdZx3HxvT9
         hC1FHVIzOHxma/YHTJJzrEOiL5F9s9oUgGX4c4C7DNxonFAV3rTiNZs0oVQGpswlR2b+
         R4vAaHY1qxrZrTfbmas5BU5ps9IoSkNU8kukI2RHl+XYVy1MluDfuwIrG5GExQyOg5As
         94Gx17gHdYCaisKJYCERWRfSTaF16rxZvAd3FL1e04in3ejq0YERA27vnr26Z2M5bfhU
         wmqUICjyawo+ay1aqD5aKAAcTLRgDk/yZqDEkqLBHrQXkjrAHXz4USo3pTvVNlF7WRKa
         rROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361846;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ipHwAmtn8xKMpsfY5sEo8iqzC7xjIdi7/Wr/PXcOaM=;
        b=5A5ptr4zqAuaB7iEMoqwx+JsjL+D21KzlQZvpklUv9vkvTCJh0VGqPv2uXhzyYxdSR
         bp+i4116Ib8Q0reXFQgsFcIFNItw19ejk5qoXRLW/DpgyT5x+Uc78LGhzDm+trDMkBbP
         fR46NIGvj4ZkWJGgI7A2va0Q3jAwUczuQSIMuQMAZaYo9XYq4iL4HO8hCeFQOP1ZBWXH
         HPbkRaYO9jWpyQd56zJNSdP0F5sfaszKFoLqt7wwXEcR6MCvkg6aF79lrgb2jZlioItE
         xxCFeDyIYC+vZLdCNwlYy1naro2Fl9dFuE+WajPyKTjZsPvnsC7/N11TICYxiOl8GOjM
         sj/g==
X-Gm-Message-State: AO0yUKVx6zLYxbXsG3LJLoYLqYDa05N2aI5Tlj/nmOj8HvwCBL73NWLy
        TsfmEwLwYwQO5vCpJQK5idefEmCub34=
X-Google-Smtp-Source: AK7set8DXY+PbfxQhTBRuvUwTJ6y4yZ67uFLf6a+pkDj/khhiouAjzF2qnT5M1rhs/WBiw8l1xqr9w==
X-Received: by 2002:a05:600c:548d:b0:3ee:c06:e942 with SMTP id iv13-20020a05600c548d00b003ee0c06e942mr22407389wmb.25.1680361846466;
        Sat, 01 Apr 2023 08:10:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5-20020adffb85000000b002c794495f6fsm5068131wrr.117.2023.04.01.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:46 -0700 (PDT)
Message-Id: <22709819107ef71dd4ad8efa7b3376772d0eb84c.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:20 +0000
Subject: [PATCH 07/24] treewide: remove unnecessary cache.h inclusion
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

Several files were including cache.h solely to get other headers, such
as trace.h and trace2.h.  Since the last few commits have modified
files to make these dependencies more explicit, the inclusion of cache.h
is no longer needed in several cases.  Remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 compat/simple-ipc/ipc-unix-socket.c | 2 +-
 connect.c                           | 2 +-
 fetch-pack.c                        | 2 +-
 pack-write.c                        | 2 +-
 promisor-remote.c                   | 2 +-
 protocol.c                          | 2 +-
 scalar.c                            | 2 +-
 t/helper/test-date.c                | 1 -
 trace.c                             | 2 +-
 upload-pack.c                       | 2 +-
 10 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 7064475b39f..b2f4f22ce44 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "strbuf.h"
diff --git a/connect.c b/connect.c
index 929f72ec5d7..cf4dd3084e0 100644
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 7d4f190fb1d..677102465a1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
diff --git a/pack-write.c b/pack-write.c
index 152c14aa7aa..d9b460fab4c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 9d83d2f4b9c..1adcd6fb0a5 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/protocol.c b/protocol.c
index 4d8eb887e82..079ba75acf4 100644
--- a/protocol.c
+++ b/protocol.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "protocol.h"
diff --git a/scalar.c b/scalar.c
index f7680463e1b..af64f75ca66 100644
--- a/scalar.c
+++ b/scalar.c
@@ -2,7 +2,7 @@
  * The Scalar command-line interface.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index a01eec99f35..7adadd41e0b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "date.h"
 #include "trace.h"
 
diff --git a/trace.c b/trace.c
index d8eaa0a786a..592c141d785 100644
--- a/trace.c
+++ b/trace.c
@@ -21,7 +21,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "quote.h"
diff --git a/upload-pack.c b/upload-pack.c
index e17545a834a..0305fb2fbdc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-- 
gitgitgadget

