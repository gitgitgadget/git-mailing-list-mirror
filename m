Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE11C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDVUSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjDVURr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C82129
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f1957e80a2so39814605e9.1
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194661; x=1684786661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrXcFxS4F9XvyH52gObTjZ4eSz6BCCXjHgXrK8G1Bcg=;
        b=ktqrgIdSDXYhyvUCH8A9K7jvt/Y/6wSJzi4aQZB1krXQ8z5FpGmlx7SoqK4+t2yguq
         gvYEIpbHU6HUExXk/BlIZ2IgVE3K3spDk0rQKf8iLLeh5QtOqBn8AnOL3zvhes6nGTy/
         Y21uQ11anqMLegOXDkZ+KjoZxJGfErRosfMHdbcWeom4cVHMj2A0/pKsDsBbwughUhOL
         8SE8DxHQWmxkVF7YG4uJh4fLdqOiG6JLLXMfsEtX5x8wXqMsCCGyYJbjZKc338fr281T
         I/1jBUOMMP5ktw2f4Ig36wbAoJLY8lvreduBJGJYxYUeWt07YZLPeQ1K9gzkbP6YlSZT
         OMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194661; x=1684786661;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrXcFxS4F9XvyH52gObTjZ4eSz6BCCXjHgXrK8G1Bcg=;
        b=KM767Wkvf/M/RoJE99mnSapr28XSxwCnndRvvOjlo/6PhZTDaVsdmZHO6sF3x6HBIh
         73UOUBnnqEk1avUA+0gsFiKzO9C+ODm8mL2H79yoIXmfb0LJvNU6BDmOsZlp1df/4QBR
         Y0s3RhSAS78ch7KkD0KQFon6s3P4u9Nmjxqc1iDoYqtaaZuqJOxB/Y/4uQ3CNDASQAwz
         38g3cmtaUDFYYt3iusqxt2Am9JqVe+N3WNqN8MY/Pv83QdT4gbcbg6ePuNLLNzdB8veD
         4zQg22t+p5rJ3ql4rEueZjEW0xh2LdL58tyTs0aDtpGsdDWwyP1KvE7Q9ZB4rpp1jxju
         aHiQ==
X-Gm-Message-State: AAQBX9dnulkE5OBW/DTuaQAtyCCokth70U0WtSgHjdQJlD41qFN3KRuf
        PnTzaA/R2pZnYI4zTrcb8eOOhZDHHYk=
X-Google-Smtp-Source: AKy350b329oI4iEmqkoVFFN0P656b/QGavU1SZb+HsiAF3XIT5oX6etflY1Fbh4CPPZdV6uKcviAHQ==
X-Received: by 2002:adf:e689:0:b0:2f9:805f:eecb with SMTP id r9-20020adfe689000000b002f9805feecbmr6644074wrm.3.1682194660727;
        Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6-20020a5d5246000000b002fe87e0706bsm7179578wrc.97.2023.04.22.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:40 -0700 (PDT)
Message-Id: <951eff98a4d3f7cc4190dcd080b0648f62b84cf1.1682194651.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:16 +0000
Subject: [PATCH v2 09/22] ws.h: move declarations for ws.c functions from
 cache.h
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
 apply.c       |  1 +
 cache.h       | 26 --------------------------
 config.c      |  1 +
 diff.c        |  1 +
 environment.c |  1 -
 ws.c          |  5 ++++-
 ws.h          | 33 +++++++++++++++++++++++++++++++++
 7 files changed, 40 insertions(+), 28 deletions(-)
 create mode 100644 ws.h

diff --git a/apply.c b/apply.c
index a65a354eef5..2de8bb203d7 100644
--- a/apply.c
+++ b/apply.c
@@ -32,6 +32,7 @@
 #include "entry.h"
 #include "setup.h"
 #include "symlinks.h"
+#include "ws.h"
 #include "wrapper.h"
 
 struct gitdiff_data {
diff --git a/cache.h b/cache.h
index 0570f9ad07d..dde275c9301 100644
--- a/cache.h
+++ b/cache.h
@@ -603,32 +603,6 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 /* diff.c */
 extern int diff_auto_refresh_index;
 
-/*
- * whitespace rules.
- * used by both diff and apply
- * last two digits are tab width
- */
-#define WS_BLANK_AT_EOL         0100
-#define WS_SPACE_BEFORE_TAB     0200
-#define WS_INDENT_WITH_NON_TAB  0400
-#define WS_CR_AT_EOL           01000
-#define WS_BLANK_AT_EOF        02000
-#define WS_TAB_IN_INDENT       04000
-#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
-#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
-#define WS_TAB_WIDTH_MASK        077
-/* All WS_* -- when extended, adapt diff.c emit_symbol */
-#define WS_RULE_MASK           07777
-extern unsigned whitespace_rule_cfg;
-unsigned whitespace_rule(struct index_state *, const char *);
-unsigned parse_whitespace_rule(const char *);
-unsigned ws_check(const char *line, int len, unsigned ws_rule);
-void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
-char *whitespace_error_string(unsigned ws);
-void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
-int ws_blank_line(const char *line, int len);
-#define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
-
 /* ls-files */
 void overlay_tree_on_index(struct index_state *istate,
 			   const char *tree_name, const char *prefix);
diff --git a/config.c b/config.c
index 9beba19b41c..97063a0743e 100644
--- a/config.c
+++ b/config.c
@@ -35,6 +35,7 @@
 #include "setup.h"
 #include "trace2.h"
 #include "worktree.h"
+#include "ws.h"
 #include "wrapper.h"
 #include "write-or-die.h"
 
diff --git a/diff.c b/diff.c
index e697f78a645..73d2ac03673 100644
--- a/diff.c
+++ b/diff.c
@@ -41,6 +41,7 @@
 #include "object-name.h"
 #include "setup.h"
 #include "strmap.h"
+#include "ws.h"
 #include "wrapper.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
diff --git a/environment.c b/environment.c
index 8a96997539a..541f0b19acf 100644
--- a/environment.c
+++ b/environment.c
@@ -67,7 +67,6 @@ int read_replace_refs = 1;
 enum eol core_eol = EOL_UNSET;
 int global_conv_flags_eol = CONV_EOL_RNDTRP_WARN;
 char *check_roundtrip_encoding = "SHIFT-JIS";
-unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
diff --git a/ws.c b/ws.c
index 036ccb8ee9d..d356d4ec9ee 100644
--- a/ws.c
+++ b/ws.c
@@ -3,9 +3,12 @@
  *
  * Copyright (c) 2007 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "attr.h"
 #include "strbuf.h"
+#include "ws.h"
+
+unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
 static struct whitespace_rule {
 	const char *rule_name;
diff --git a/ws.h b/ws.h
new file mode 100644
index 00000000000..5ba676c5595
--- /dev/null
+++ b/ws.h
@@ -0,0 +1,33 @@
+#ifndef WS_H
+#define WS_H
+
+struct index_state;
+struct strbuf;
+
+/*
+ * whitespace rules.
+ * used by both diff and apply
+ * last two digits are tab width
+ */
+#define WS_BLANK_AT_EOL         0100
+#define WS_SPACE_BEFORE_TAB     0200
+#define WS_INDENT_WITH_NON_TAB  0400
+#define WS_CR_AT_EOL           01000
+#define WS_BLANK_AT_EOF        02000
+#define WS_TAB_IN_INDENT       04000
+#define WS_TRAILING_SPACE      (WS_BLANK_AT_EOL|WS_BLANK_AT_EOF)
+#define WS_DEFAULT_RULE (WS_TRAILING_SPACE|WS_SPACE_BEFORE_TAB|8)
+#define WS_TAB_WIDTH_MASK        077
+/* All WS_* -- when extended, adapt diff.c emit_symbol */
+#define WS_RULE_MASK           07777
+extern unsigned whitespace_rule_cfg;
+unsigned whitespace_rule(struct index_state *, const char *);
+unsigned parse_whitespace_rule(const char *);
+unsigned ws_check(const char *line, int len, unsigned ws_rule);
+void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
+char *whitespace_error_string(unsigned ws);
+void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
+int ws_blank_line(const char *line, int len);
+#define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
+
+#endif /* WS_H */
-- 
gitgitgadget

