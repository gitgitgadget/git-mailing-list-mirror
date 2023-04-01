Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE7CC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjDAPL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDAPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C301EFC4
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so16805790wmq.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQeudPBF1q2Yx00MlhRUxbwAiTjwEVyIQFEWB99WrK4=;
        b=qHk78wm9cbKlpXCVnUMOi4s6uuiglwrGWsywXf9ZGXjm6jI7aisx/c+HxfbDTF4Gin
         mRveFk4V1VqGiH+YpUF6G8TWs8jJNMo3hxCIoKO2hk/ug9t9q8hwFyDF78iCzAB/sXS+
         y8A43et/X7nAl3ODEZ9e/OJF4mo27qtcGsfnOd/vwKYgYIk6kOZVZAMvlpIZiOGVu5vl
         LFpZWfI2nWVmhkRC1rAt5QetXlgDC+9Xh0YSw78Zdl5rCqQWaBzV5pDuKH2MjDhtvfo6
         X0TRUm8oCdGrFi6pllqdJh4xoLaVgNEwEvGeEoc+JCshgie/dmFdyfbVkQZuPqWczFTQ
         EdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361852;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQeudPBF1q2Yx00MlhRUxbwAiTjwEVyIQFEWB99WrK4=;
        b=bHIxhcplrdCk0LY894twYNRwI0ESm6G33H+sZMJNQJVCWnHaFkn1KcpQcI2dh5OP/i
         2cpjcFFkuR1C9llxKrGWbRsFYaDu4gUALl72dKwMuCuNGFo5xgjlcrI+LbVFEKlgkJG1
         lSndBF6VfJ+7opij4ituQ8BPlmVSmwJ0o8OZxX1J9KOmLHSVKLnMI2ptTzELORcsMBQC
         CwRrNPYeK4hamLwbZMqfxJK92sT0j3vPfV6o/eOCm/LC1GWMbgdpnY9/OZ8SM4iE3uN1
         Zn9YiFSwQb2UEG25tld5NxjQ8cCVl/Xb78wVXiDXZEaB/A5soO6lL5McWJenbDeDNyT7
         TOaQ==
X-Gm-Message-State: AAQBX9d/VPWdNWYl1X10+XJ+9FRHPMBN8yz6bjnHODCw3P1azEtMAYWv
        wxv/dtd5PrRlvLW6Mf5QKDgIEfh+Kes=
X-Google-Smtp-Source: AKy350YAi44bnKly+rUdtVM3Vntk/8GUSHLgXcSG0wUpFgWJfoLotpkDml1hQfPJbC4ccdAGtp8CGQ==
X-Received: by 2002:a05:600c:3ba3:b0:3f0:4d9b:7cb2 with SMTP id n35-20020a05600c3ba300b003f04d9b7cb2mr374324wms.3.1680361852536;
        Sat, 01 Apr 2023 08:10:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a7bc5cd000000b003ede3e54ed7sm6371807wmk.6.2023.04.01.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:52 -0700 (PDT)
Message-Id: <be8c5229baa31d0c10dabcaf9342d5ca685fc23c.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:30 +0000
Subject: [PATCH 17/24] pager.h: move declarations for pager.c functions from
 cache.h
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
 builtin/am.c       |  1 +
 builtin/blame.c    |  1 +
 builtin/fetch.c    |  1 +
 builtin/grep.c     |  1 +
 builtin/help.c     |  1 +
 builtin/log.c      |  1 +
 builtin/name-rev.c |  1 +
 builtin/var.c      |  1 +
 cache.h            | 12 ------------
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
 23 files changed, 39 insertions(+), 13 deletions(-)
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
index f469e250f30..b136b0c51ef 100644
--- a/cache.h
+++ b/cache.h
@@ -665,8 +665,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-const char *git_pager(int stdout_is_tty);
-
 struct cache_def {
 	struct strbuf path;
 	int flags;
@@ -723,16 +721,6 @@ int copy_fd(int ifd, int ofd);
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

