Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45537C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBXAKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBXAJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A05206BE
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:50 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id bw19so1693863wrb.13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs0Kirh6Ks9gVzZeeD7dB9V705dm6hE6h+AnSX3of9A=;
        b=FbiJzsR8TX8Y23Rja8HqADr929sk5qDdSlLRYNN52EwrmU6YBz/n5FLhIk+JlFlr7L
         GBjgBGf9DTk8SzDt8Q8d6TH3ljl+Bn8WiRvN7DdXfYcUQnlTm36CVvl8dydQO8Xl4jRL
         HtRPTLLKLsrfC3bewWAEH2eZwNQUTYJxMl5+9kL7U5DaPlbY3baO6XSPS/RyhR8Pyb9/
         mAeJ1Fw05Sq2hH3P2Nyb4BrESBoIFbwHCVnLF5M5PbaKhOI2HHdt9T4kX6fQP1loHRPM
         h2RC9uJ6ceKYhIwMfgZOz6ynoP69HKIvtAfMQ91EWkk223KUCzXj1BaBguou3ZIlO65X
         M1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hs0Kirh6Ks9gVzZeeD7dB9V705dm6hE6h+AnSX3of9A=;
        b=msUC8K6/t9XqvO9BlKerLUGnRNTgSwOJetwMcEhmppDoKK6/LXXD/Ol63sF3x3F8If
         gK9gfH2X7u3Sx43iTv3UzigCmOAY+vWxJ95XxvBIGvzMR0i8fspE8nv+d/x8N1XBPpjj
         taHXD+i6bFOInPh3vhSgt7v6JV787qA4nZFYDCG1yQPUm8+jaZsvdWgcT7AXsxhlm+Es
         mn8pMsTukRjO7VuhnXHfiBiUy5C7N2dOVe4eoTMM17Vg7NVMyK7pJLeSn0nulc80He7I
         +26S8ZBWzfXl4Y+aGRS78+Y03KPuDZ1Ct/+cwcx+JMpW8Hm/w5atPOFphbQFtd+KQMcz
         N44Q==
X-Gm-Message-State: AO0yUKVdeSy22SD6UJ6ay91Q5xnSMaEVelMUNWtrJdcM9PRkPJoysF0y
        2Cxr/sbdTpfLpOqWTw2m5iVLic/meI8=
X-Google-Smtp-Source: AK7set9QNMptZ6FB3GjKSWaJKSDpMXa0Lw5f1BMcaOcyIRcqP23jDM2/K+2bptELanVdx95Ka8L+yQ==
X-Received: by 2002:adf:f082:0:b0:2c5:8736:c022 with SMTP id n2-20020adff082000000b002c58736c022mr10637913wro.62.1677197388641;
        Thu, 23 Feb 2023 16:09:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6-20020a056000108600b002c53f6c7599sm9880969wrw.29.2023.02.23.16.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:48 -0800 (PST)
Message-Id: <de1e29132de573753d8ac183036fe5e30b09bc6a.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:29 +0000
Subject: [PATCH v2 10/17] ident.h: move ident-related declarations out of
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These functions were all defined in a separate ident.c already, so
create ident.h and move the declarations into that file.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/cat-file.c      |  1 +
 builtin/check-mailmap.c |  1 +
 builtin/config.c        |  1 +
 builtin/var.c           |  1 +
 cache.h                 | 58 -----------------------------------
 config.c                |  1 +
 gpg-interface.c         |  1 +
 ident.c                 |  5 ++-
 ident.h                 | 67 +++++++++++++++++++++++++++++++++++++++++
 refs/files-backend.c    |  1 +
 revision.h              |  1 +
 11 files changed, 79 insertions(+), 59 deletions(-)
 create mode 100644 ident.h

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3040016e27a..88c5ea8b267 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -10,6 +10,7 @@
 #include "builtin.h"
 #include "diff.h"
 #include "hex.h"
+#include "ident.h"
 #include "parse-options.h"
 #include "userdiff.h"
 #include "streaming.h"
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 7dc47e47932..96db3ddb4bb 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "config.h"
+#include "ident.h"
 #include "mailmap.h"
 #include "parse-options.h"
 #include "string-list.h"
diff --git a/builtin/config.c b/builtin/config.c
index ca006e9cc15..49d832d4093 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "color.h"
+#include "ident.h"
 #include "parse-options.h"
 #include "urlmatch.h"
 #include "quote.h"
diff --git a/builtin/var.c b/builtin/var.c
index a80c1df86fd..d9943be9afd 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "ident.h"
 #include "refs.h"
 
 static const char var_usage[] = "git var (-l | <variable>)";
diff --git a/cache.h b/cache.h
index 0c631e75b55..4e0d9bccc06 100644
--- a/cache.h
+++ b/cache.h
@@ -1445,65 +1445,10 @@ struct object *repo_peel_to_type(struct repository *r,
 #define peel_to_type(name, namelen, obj, type) \
 	repo_peel_to_type(the_repository, name, namelen, obj, type)
 
-#define IDENT_STRICT	       1
-#define IDENT_NO_DATE	       2
-#define IDENT_NO_NAME	       4
-
-enum want_ident {
-	WANT_BLANK_IDENT,
-	WANT_AUTHOR_IDENT,
-	WANT_COMMITTER_IDENT
-};
-
-const char *git_author_info(int);
-const char *git_committer_info(int);
-const char *fmt_ident(const char *name, const char *email,
-		      enum want_ident whose_ident,
-		      const char *date_str, int);
-const char *fmt_name(enum want_ident);
-const char *ident_default_name(void);
-const char *ident_default_email(void);
 const char *git_editor(void);
 const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
 int is_terminal_dumb(void);
-int git_ident_config(const char *, const char *, void *);
-/*
- * Prepare an ident to fall back on if the user didn't configure it.
- */
-void prepare_fallback_ident(const char *name, const char *email);
-void reset_ident_date(void);
-
-struct ident_split {
-	const char *name_begin;
-	const char *name_end;
-	const char *mail_begin;
-	const char *mail_end;
-	const char *date_begin;
-	const char *date_end;
-	const char *tz_begin;
-	const char *tz_end;
-};
-/*
- * Signals an success with 0, but time part of the result may be NULL
- * if the input lacks timestamp and zone
- */
-int split_ident_line(struct ident_split *, const char *, int);
-
-/*
- * Given a commit or tag object buffer and the commit or tag headers, replaces
- * the idents in the headers with their canonical versions using the mailmap mechanism.
- */
-void apply_mailmap_to_header(struct strbuf *, const char **, struct string_list *);
-
-/*
- * Compare split idents for equality or strict ordering. Note that we
- * compare only the ident part of the line, ignoring any timestamp.
- *
- * Because there are two fields, we must choose one as the primary key; we
- * currently arbitrarily pick the email.
- */
-int ident_cmp(const struct ident_split *, const struct ident_split *);
 
 struct cache_def {
 	struct strbuf path;
@@ -1570,9 +1515,6 @@ int update_server_info(int);
 const char *get_log_output_encoding(void);
 const char *get_commit_output_encoding(void);
 
-int committer_ident_sufficiently_given(void);
-int author_ident_sufficiently_given(void);
-
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
 extern const char *git_mailmap_file;
diff --git a/config.c b/config.c
index 1d22f232516..d3ab9417a45 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "branch.h"
 #include "config.h"
 #include "environment.h"
+#include "ident.h"
 #include "repository.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
diff --git a/gpg-interface.c b/gpg-interface.c
index 687236430bf..bd13fc92fef 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -4,6 +4,7 @@
 #include "run-command.h"
 #include "strbuf.h"
 #include "dir.h"
+#include "ident.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
 #include "tempfile.h"
diff --git a/ident.c b/ident.c
index 6de76f9421d..8fad92d7007 100644
--- a/ident.c
+++ b/ident.c
@@ -5,10 +5,13 @@
  *
  * Copyright (C) 2005 Linus Torvalds
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "ident.h"
 #include "config.h"
 #include "date.h"
+#include "gettext.h"
 #include "mailmap.h"
+#include "strbuf.h"
 
 static struct strbuf git_default_name = STRBUF_INIT;
 static struct strbuf git_default_email = STRBUF_INIT;
diff --git a/ident.h b/ident.h
new file mode 100644
index 00000000000..96a64896a01
--- /dev/null
+++ b/ident.h
@@ -0,0 +1,67 @@
+#ifndef IDENT_H
+#define IDENT_H
+
+#include "string-list.h"
+
+struct ident_split {
+	const char *name_begin;
+	const char *name_end;
+	const char *mail_begin;
+	const char *mail_end;
+	const char *date_begin;
+	const char *date_end;
+	const char *tz_begin;
+	const char *tz_end;
+};
+
+#define IDENT_STRICT	       1
+#define IDENT_NO_DATE	       2
+#define IDENT_NO_NAME	       4
+
+enum want_ident {
+	WANT_BLANK_IDENT,
+	WANT_AUTHOR_IDENT,
+	WANT_COMMITTER_IDENT
+};
+
+const char *ident_default_name(void);
+const char *ident_default_email(void);
+/*
+ * Prepare an ident to fall back on if the user didn't configure it.
+ */
+void prepare_fallback_ident(const char *name, const char *email);
+void reset_ident_date(void);
+/*
+ * Signals an success with 0, but time part of the result may be NULL
+ * if the input lacks timestamp and zone
+ */
+int split_ident_line(struct ident_split *, const char *, int);
+
+/*
+ * Given a commit or tag object buffer and the commit or tag headers, replaces
+ * the idents in the headers with their canonical versions using the mailmap mechanism.
+ */
+void apply_mailmap_to_header(struct strbuf *, const char **, struct string_list *);
+
+/*
+ * Compare split idents for equality or strict ordering. Note that we
+ * compare only the ident part of the line, ignoring any timestamp.
+ *
+ * Because there are two fields, we must choose one as the primary key; we
+ * currently arbitrarily pick the email.
+ */
+int ident_cmp(const struct ident_split *, const struct ident_split *);
+
+const char *git_author_info(int);
+const char *git_committer_info(int);
+const char *fmt_ident(const char *name, const char *email,
+		      enum want_ident whose_ident,
+		      const char *date_str, int);
+const char *fmt_name(enum want_ident);
+
+int committer_ident_sufficiently_given(void);
+int author_ident_sufficiently_given(void);
+
+int git_ident_config(const char *, const char *, void *);
+
+#endif
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6f257c70054..31bc5c45ee6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -5,6 +5,7 @@
 #include "refs-internal.h"
 #include "ref-cache.h"
 #include "packed-backend.h"
+#include "../ident.h"
 #include "../iterator.h"
 #include "../dir-iterator.h"
 #include "../lockfile.h"
diff --git a/revision.h b/revision.h
index 30febad09a1..ab71443696d 100644
--- a/revision.h
+++ b/revision.h
@@ -8,6 +8,7 @@
 #include "pretty.h"
 #include "diff.h"
 #include "commit-slab-decl.h"
+#include "ident.h"
 #include "list-objects-filter-options.h"
 
 /**
-- 
gitgitgadget

