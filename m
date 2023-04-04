Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04509C761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjDDBXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbjDDBXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29830C3
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so15431826wms.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTmQhEP1pzTB/Q9gpzrhsSQRqDrN68QjwhBWbxZdpgc=;
        b=duV3X0m5wLRgFDPWUofAsmKns26S2KJHO5fRHNZYOGi1XNSHGVNAnaHeH1bELAOxhz
         2Pzf5nSQKRim72sXae/1YyYib3eZ+PF3WkqXesRn8XU9NzckPEj0JDFqmuyuP2uwRSjI
         m6zUOt4xEM1MOiQXanoqcrHJ1zJ5D2asW0uGgFUneQ4BjBQHzo3A8fbsbUTmZBoO6o62
         RsjyBbSRcesPlsh3WdqVIUWIE6q9jm1FocmET7zds9MGTe+BMfEd1kI0xiefdlCEAA+3
         JkBqACWcgccY580vQlD2ofYPPUWLwJvhbNvMKSnI8YGI+8Vgn3REg0MykVodZQpbqyaU
         NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTmQhEP1pzTB/Q9gpzrhsSQRqDrN68QjwhBWbxZdpgc=;
        b=sx8dNRW31qfiwDxrn+5YxSnOCRpJd0q/HlhNq9u1mb9PJ66MUUV/IPnXgJqF2wTSuO
         ij3BQd+X9A8iyWnfMoiGAlK1cx8DrP/aBCkhm6axv5M5P2zIdUjdCBLzJtqM1JBRMLEz
         bFDyzsn8qhIkAcl2vqv30wNBG2MYUhDtHwDvMemhoUWm/OUf0hh4hzWNa1ApqS0JNzXN
         SiQGD54weCvTCdBxSXQQ3wuYmz6gp2b2GIizgv84intDfQxYnIYFG8qJKY1M0RgORh3K
         C5pd/ur0u+FIqN9U8hETGl5B9MxbjWQtGWTxTz05xItHsckob9iaxZQOXOrnue4X5vwd
         PxJA==
X-Gm-Message-State: AAQBX9fB/RTDokoLTo2WvS/yrBudhWTc553rlxDSLK+tPmTGWPNXWttU
        SdT5YCEYMeB/Gar2j4vU21tBDcdO5bs=
X-Google-Smtp-Source: AKy350bb0Ih5GKUNLDoxiJDBqrIQRCJTZqahgDsA8sJYD1uatjFWF2xQYYn9H1kWHaqNSj/EfDx9gQ==
X-Received: by 2002:a7b:cd10:0:b0:3f0:310c:165 with SMTP id f16-20020a7bcd10000000b003f0310c0165mr734200wmj.28.1680571366700;
        Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16-20020adffc10000000b002c55ec7f661sm10989194wrr.5.2023.04.03.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:46 -0700 (PDT)
Message-Id: <d658ee210d963eba08d9cbddbf36b5dc8f56ba3f.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:22 +0000
Subject: [PATCH v2 18/24] pager.h: move declarations for pager.c functions
 from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/am.c       |  1 +
 builtin/blame.c    |  1 +
 builtin/fetch.c    |  1 +
 builtin/grep.c     |  1 +
 builtin/help.c     |  1 +
 builtin/log.c      |  1 +
 builtin/name-rev.c |  1 +
 builtin/var.c      |  1 +
 cache.h            | 13 -------------
 color.c            |  1 +
 column.c           |  1 +
 config.c           |  1 +
 date.c             |  1 +
 diff.c             |  1 +
 editor.c           |  1 +
 environment.c      |  1 -
 git.c              |  1 +
 pager.c            |  3 +++
 pager.h            | 17 +++++++++++++++++
 pretty.c           |  1 +
 progress.c         |  1 +
 range-diff.c       |  1 +
 sequencer.c        |  1 +
 23 files changed, 39 insertions(+), 14 deletions(-)
 create mode 100644 pager.h

diff --git a/builtin/am.c b/builtin/am.c
index f7a065e5290..5c83f2e003f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -40,6 +40,7 @@
 #include "apply.h"
 #include "string-list.h"
 #include "packfile.h"
+#include "pager.h"
 #include "repository.h"
 #include "pretty.h"
 #include "wrapper.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index a628388c2ce..2df6039a6e0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -30,6 +30,7 @@
 #include "progress.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "blame.h"
 #include "refs.h"
 #include "setup.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8a8ab6799e8..61e8ac113b1 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -28,6 +28,7 @@
 #include "strvec.h"
 #include "utf8.h"
 #include "packfile.h"
+#include "pager.h"
 #include "list-objects-filter-options.h"
 #include "commit-reach.h"
 #include "branch.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index fb11be6075a..b86c754defb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -30,6 +30,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "pager.h"
 #include "write-or-die.h"
 
 static const char *grep_prefix;
diff --git a/builtin/help.c b/builtin/help.c
index 87333a02ec4..128aa83099a 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -6,6 +6,7 @@
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "config-list.h"
diff --git a/builtin/log.c b/builtin/log.c
index b6246c7042c..95de51921f8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -15,6 +15,7 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "color.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 41fd56b9ba9..593f0506a10 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -9,6 +9,7 @@
 #include "tag.h"
 #include "refs.h"
 #include "object-name.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "hash-lookup.h"
diff --git a/builtin/var.c b/builtin/var.c
index 90616cf65a2..aa8150fa92e 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "editor.h"
 #include "ident.h"
+#include "pager.h"
 #include "refs.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
diff --git a/cache.h b/cache.h
index 97ddf4094a3..21fd520b045 100644
--- a/cache.h
+++ b/cache.h
@@ -145,7 +145,6 @@ struct cache_entry {
 
 /* Forward structure decls */
 struct pathspec;
-struct child_process;
 struct tree;
 
 /*
@@ -621,8 +620,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-const char *git_pager(int stdout_is_tty);
-
 struct cache_def {
 	struct strbuf path;
 	int flags;
@@ -671,16 +668,6 @@ int copy_fd(int ifd, int ofd);
 int copy_file(const char *dst, const char *src, int mode);
 int copy_file_with_time(const char *dst, const char *src, int mode);
 
-/* pager.c */
-void setup_pager(void);
-int pager_in_use(void);
-extern int pager_use_color;
-int term_columns(void);
-void term_clear_line(void);
-int decimal_width(uintmax_t);
-int check_pager_config(const char *cmd);
-void prepare_pager_args(struct child_process *, const char *pager);
-
 /* base85 */
 int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
diff --git a/color.c b/color.c
index a8e8d5202ab..6031998d3ea 100644
--- a/color.c
+++ b/color.c
@@ -4,6 +4,7 @@
 #include "editor.h"
 #include "gettext.h"
 #include "hex.h"
+#include "pager.h"
 
 static int git_use_color_default = GIT_COLOR_AUTO;
 int color_stdout_is_tty = -1;
diff --git a/column.c b/column.c
index fbf88639aae..c89c90328a6 100644
--- a/column.c
+++ b/column.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "column.h"
 #include "string-list.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "run-command.h"
 #include "utf8.h"
diff --git a/config.c b/config.c
index aac439530e9..11e3295419b 100644
--- a/config.c
+++ b/config.c
@@ -25,6 +25,7 @@
 #include "string-list.h"
 #include "object-name.h"
 #include "object-store.h"
+#include "pager.h"
 #include "utf8.h"
 #include "dir.h"
 #include "color.h"
diff --git a/date.c b/date.c
index 1fb2cd1b538..e944c8905af 100644
--- a/date.c
+++ b/date.c
@@ -7,6 +7,7 @@
 #include "cache.h"
 #include "date.h"
 #include "gettext.h"
+#include "pager.h"
 
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
diff --git a/diff.c b/diff.c
index f8e0d3b5c59..fa86d023196 100644
--- a/diff.c
+++ b/diff.c
@@ -31,6 +31,7 @@
 #include "graph.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "pager.h"
 #include "parse-options.h"
 #include "help.h"
 #include "promisor-remote.h"
diff --git a/editor.c b/editor.c
index 12025dfec37..7c796385493 100644
--- a/editor.c
+++ b/editor.c
@@ -5,6 +5,7 @@
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
+#include "pager.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
diff --git a/environment.c b/environment.c
index 39efa49fe31..8a96997539a 100644
--- a/environment.c
+++ b/environment.c
@@ -59,7 +59,6 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
-int pager_use_color = 1;
 const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
diff --git a/git.c b/git.c
index d2bb86e0d32..0241d2cf913 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "help.h"
+#include "pager.h"
 #include "run-command.h"
 #include "alias.h"
 #include "replace-object.h"
diff --git a/pager.c b/pager.c
index 6367e8ef867..be78c706644 100644
--- a/pager.c
+++ b/pager.c
@@ -1,10 +1,13 @@
 #include "cache.h"
 #include "config.h"
 #include "editor.h"
+#include "pager.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "alias.h"
 
+int pager_use_color = 1;
+
 #ifndef DEFAULT_PAGER
 #define DEFAULT_PAGER "less"
 #endif
diff --git a/pager.h b/pager.h
new file mode 100644
index 00000000000..b77433026dc
--- /dev/null
+++ b/pager.h
@@ -0,0 +1,17 @@
+#ifndef PAGER_H
+#define PAGER_H
+
+struct child_process;
+
+const char *git_pager(int stdout_is_tty);
+void setup_pager(void);
+int pager_in_use(void);
+int term_columns(void);
+void term_clear_line(void);
+int decimal_width(uintmax_t);
+int check_pager_config(const char *cmd);
+void prepare_pager_args(struct child_process *, const char *pager);
+
+extern int pager_use_color;
+
+#endif /* PAGER_H */
diff --git a/pretty.c b/pretty.c
index 76fc4f61e40..c4671603b56 100644
--- a/pretty.c
+++ b/pretty.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "utf8.h"
 #include "diff.h"
+#include "pager.h"
 #include "revision.h"
 #include "string-list.h"
 #include "mailmap.h"
diff --git a/progress.c b/progress.c
index c5c8514737a..96a8e36a52f 100644
--- a/progress.c
+++ b/progress.c
@@ -10,6 +10,7 @@
 
 #define GIT_TEST_PROGRESS_ONLY
 #include "cache.h"
+#include "pager.h"
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
diff --git a/range-diff.c b/range-diff.c
index a2994331a14..a1e0cffb9f6 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -11,6 +11,7 @@
 #include "linear-assignment.h"
 #include "diffcore.h"
 #include "commit.h"
+#include "pager.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "apply.h"
diff --git a/sequencer.c b/sequencer.c
index be10249fd0a..fcca3b81447 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -12,6 +12,7 @@
 #include "object-name.h"
 #include "object-store.h"
 #include "object.h"
+#include "pager.h"
 #include "commit.h"
 #include "sequencer.h"
 #include "tag.h"
-- 
gitgitgadget

