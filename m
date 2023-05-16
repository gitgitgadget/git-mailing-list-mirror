Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96CFC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjEPGfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjEPGey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD88249E0
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:39 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so12355695e9.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218878; x=1686810878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNMWpXq6/uiNU4CL8io6aMTS/gjTAjE/JEecPsBvOqg=;
        b=pUW5ucNp6rlJHYkqW6f3/ani4z9w+RgdIeuBoU3IRNU7aWVJyuIyU5+GAqltehJbUk
         b2Q63f+Ll1eSjau4gM3pMlTtJX86cu6ooHWOIh9Kj85VmuhKStVrB+/3Qx+PUT99Wddp
         hGP5lALUAEn6zIRjBSAjkAkUaCjMin1hsC6KqT4ECcltQuIqxqx2n2dImbUOCtazvGjh
         QZKqp9bLrjYqj/eBR9En/oel+Jfk4ZL2Hmfjcxm70yxc1QEEZHy60JrrdkK0qKIJTQ96
         3hI1RwzQygfLutek849B45i5sFwAgb5qQidfdkNUOVdDtyxYWbrQzXwb82uIPFYFZavt
         YGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218878; x=1686810878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNMWpXq6/uiNU4CL8io6aMTS/gjTAjE/JEecPsBvOqg=;
        b=LvNs7dGzachUuiErxSQ3sbOdVcULYA0gpHSVJCroMV1TGNddIi1FWaCTmFygNPEBSd
         /s5nzWF/8qDS+4YfvzmCuetiB/R45x63R1weLzHiRUZ5rv+r4FYgVVpkIwXbD2CwCyZg
         amP40v/pJHv7TuY+/CkwmS3XZ6IK1bXecytfvxReVREQR7j92rTmju5DtgBzfSy+bKfE
         vxkv9CiRvnnKr7B45Oz4WA4zCHbj6kXVuDsp8AXA4c6ZTU2TCPZWL6AR7r2tbeoU4n3d
         FWkffGfiGQ7bZAwPm5LXp6FnGqNTGuxIm35Jgn/+1g6/dV1DfRS+28C7ZK9I4zsnWZLA
         mfwQ==
X-Gm-Message-State: AC+VfDzt6iSIXdMj6JGQ/H/2ZU5sSUan2JZjTD2xRIh7edhFB1sbO71h
        nOYthBiBeivJVQw0BlhoL/t+p6om7uA=
X-Google-Smtp-Source: ACHHUZ79gzGZe+VDMB//XJgo1k4A8JIflcLvMF9eYEjJQoh6UroCc5tO4F3vuYUwY4qOEONO8jnJ3g==
X-Received: by 2002:a05:600c:1ca5:b0:3f5:11c:33e7 with SMTP id k37-20020a05600c1ca500b003f5011c33e7mr5993254wms.19.1684218877860;
        Mon, 15 May 2023 23:34:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b002c70ce264bfsm1374172wrt.76.2023.05.15.23.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:37 -0700 (PDT)
Message-Id: <7b853c9e440608d50655a8e5db9d70f421c05121.1684218853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:08 +0000
Subject: [PATCH v3 28/28] fsmonitor-ll.h: split this header out of fsmonitor.h
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

This creates a new fsmonitor-ll.h with most of the functions from
fsmonitor.h, though it leaves three inline functions where they were.
Two-thirds of the files that previously included fsmonitor.h did not
need those three inline functions or the six extra includes those inline
functions required, so this allows them to only include the lower level
header.

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fsmonitor--daemon.c              |  4 +-
 compat/fsmonitor/fsm-health-darwin.c     |  2 +-
 compat/fsmonitor/fsm-health-win32.c      |  2 +-
 compat/fsmonitor/fsm-ipc-darwin.c        |  2 +-
 compat/fsmonitor/fsm-listen-darwin.c     |  3 +-
 compat/fsmonitor/fsm-listen-win32.c      |  2 +-
 compat/fsmonitor/fsm-path-utils-darwin.c |  3 +-
 compat/fsmonitor/fsm-path-utils-win32.c  |  3 +-
 compat/fsmonitor/fsm-settings-darwin.c   |  2 +-
 compat/fsmonitor/fsm-settings-win32.c    |  2 +-
 dir.c                                    |  3 +-
 fsmonitor-ipc.c                          |  2 +-
 fsmonitor-ll.h                           | 52 ++++++++++++++++++++++++
 fsmonitor.h                              | 46 +--------------------
 sparse-index.c                           |  3 +-
 15 files changed, 73 insertions(+), 58 deletions(-)
 create mode 100644 fsmonitor-ll.h

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f6dd9a784c1..74d1d6a585d 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -5,15 +5,17 @@
 #include "environment.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-path-utils.h"
+#include "fsmonitor-settings.h"
 #include "compat/fsmonitor/fsm-health.h"
 #include "compat/fsmonitor/fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
+#include "trace.h"
 #include "trace2.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
diff --git a/compat/fsmonitor/fsm-health-darwin.c b/compat/fsmonitor/fsm-health-darwin.c
index 4c291f8a066..5b1709d63f7 100644
--- a/compat/fsmonitor/fsm-health-darwin.c
+++ b/compat/fsmonitor/fsm-health-darwin.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index 6c81d7ee5c2..2d4e245beb1 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsm-health.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
diff --git a/compat/fsmonitor/fsm-ipc-darwin.c b/compat/fsmonitor/fsm-ipc-darwin.c
index 964bc074db6..6f3a95410cc 100644
--- a/compat/fsmonitor/fsm-ipc-darwin.c
+++ b/compat/fsmonitor/fsm-ipc-darwin.c
@@ -5,7 +5,7 @@
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-path-utils.h"
 
diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 23e24b4b374..36c7e13281c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -24,12 +24,13 @@
 #endif
 
 #include "git-compat-util.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
 #include "string-list.h"
+#include "trace.h"
 
 struct fsm_listen_data
 {
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 3c0df5cff8c..a361a7db20e 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index ef0142e0fbf..049f97eaaf2 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,7 +1,8 @@
 #include "git-compat-util.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "trace.h"
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index 27bb6945183..c8a3e9dcdbb 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -1,7 +1,8 @@
 #include "git-compat-util.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
+#include "trace.h"
 
 /*
  * Check remote working directory protocol.
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 58b623fbb9a..a3825906351 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "config.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index 37288978643..b6f67444944 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
 
diff --git a/dir.c b/dir.c
index fada2713b9e..3acac7beb11 100644
--- a/dir.c
+++ b/dir.c
@@ -24,7 +24,8 @@
 #include "utf8.h"
 #include "varint.h"
 #include "ewah/ewok.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule-config.h"
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 6ace978a1b4..88575aa54ca 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 #include "gettext.h"
 #include "simple-ipc.h"
 #include "fsmonitor-ipc.h"
diff --git a/fsmonitor-ll.h b/fsmonitor-ll.h
new file mode 100644
index 00000000000..0504ca07d62
--- /dev/null
+++ b/fsmonitor-ll.h
@@ -0,0 +1,52 @@
+#ifndef FSMONITOR_LL_H
+#define FSMONITOR_LL_H
+
+struct index_state;
+struct strbuf;
+
+extern struct trace_key trace_fsmonitor;
+
+/*
+ * Read the fsmonitor index extension and (if configured) restore the
+ * CE_FSMONITOR_VALID state.
+ */
+int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
+
+/*
+ * Fill the fsmonitor_dirty ewah bits with their state from the index,
+ * before it is split during writing.
+ */
+void fill_fsmonitor_bitmap(struct index_state *istate);
+
+/*
+ * Write the CE_FSMONITOR_VALID state into the fsmonitor index
+ * extension.  Reads from the fsmonitor_dirty ewah in the index.
+ */
+void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
+
+/*
+ * Add/remove the fsmonitor index extension
+ */
+void add_fsmonitor(struct index_state *istate);
+void remove_fsmonitor(struct index_state *istate);
+
+/*
+ * Add/remove the fsmonitor index extension as necessary based on the current
+ * core.fsmonitor setting.
+ */
+void tweak_fsmonitor(struct index_state *istate);
+
+/*
+ * Run the configured fsmonitor integration script and clear the
+ * CE_FSMONITOR_VALID bit for any files returned as dirty.  Also invalidate
+ * any corresponding untracked cache directory structures. Optimized to only
+ * run the first time it is called.
+ */
+void refresh_fsmonitor(struct index_state *istate);
+
+/*
+ * Does the received result contain the "trivial" response?
+ */
+int fsmonitor_is_trivial_response(const struct strbuf *query_result);
+
+#endif /* FSMONITOR_LL_H */
diff --git a/fsmonitor.h b/fsmonitor.h
index 7702301d214..5195a8624db 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -1,57 +1,13 @@
 #ifndef FSMONITOR_H
 #define FSMONITOR_H
 
+#include "fsmonitor-ll.h"
 #include "dir.h"
 #include "fsmonitor-settings.h"
 #include "object.h"
 #include "read-cache-ll.h"
 #include "trace.h"
 
-extern struct trace_key trace_fsmonitor;
-
-/*
- * Read the fsmonitor index extension and (if configured) restore the
- * CE_FSMONITOR_VALID state.
- */
-int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
-
-/*
- * Fill the fsmonitor_dirty ewah bits with their state from the index,
- * before it is split during writing.
- */
-void fill_fsmonitor_bitmap(struct index_state *istate);
-
-/*
- * Write the CE_FSMONITOR_VALID state into the fsmonitor index
- * extension.  Reads from the fsmonitor_dirty ewah in the index.
- */
-void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
-
-/*
- * Add/remove the fsmonitor index extension
- */
-void add_fsmonitor(struct index_state *istate);
-void remove_fsmonitor(struct index_state *istate);
-
-/*
- * Add/remove the fsmonitor index extension as necessary based on the current
- * core.fsmonitor setting.
- */
-void tweak_fsmonitor(struct index_state *istate);
-
-/*
- * Run the configured fsmonitor integration script and clear the
- * CE_FSMONITOR_VALID bit for any files returned as dirty.  Also invalidate
- * any corresponding untracked cache directory structures. Optimized to only
- * run the first time it is called.
- */
-void refresh_fsmonitor(struct index_state *istate);
-
-/*
- * Does the received result contain the "trivial" response?
- */
-int fsmonitor_is_trivial_response(const struct strbuf *query_result);
-
 /*
  * Check if refresh_fsmonitor has been called at least once.
  * refresh_fsmonitor is idempotent. Returns true if fsmonitor is
diff --git a/sparse-index.c b/sparse-index.c
index 2c47954d933..90d04622568 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -3,6 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
+#include "read-cache-ll.h"
 #include "repository.h"
 #include "sparse-index.h"
 #include "tree.h"
@@ -11,7 +12,7 @@
 #include "cache-tree.h"
 #include "config.h"
 #include "dir.h"
-#include "fsmonitor.h"
+#include "fsmonitor-ll.h"
 
 struct modify_index_context {
 	struct index_state *write;
-- 
gitgitgadget
