Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A655C761AF
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjDDBXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjDDBXC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8F73A97
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:47 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m8so7163039wmq.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUBahcFC2EkyxihFp/0dtOPXo17e1SNi+2zLTLVehUo=;
        b=A8oU7JjZ4qwqTioJK8/ybdhvvJ+8EA+Qf05h2MdlZYlV8dwaO7yZm4o1FbQ5+VzSES
         sMLVkDqoG6R3DY1wrk50MW8Je3R4nI0Z+0sOLo6QNJtQGGK40z+ACneEtcSibizVHj5o
         F8mhYHoNTx03U7LXuskLs7tTG4hXqJOxfuD3eYMRKKCoirYMIAANmeydWRh3LGeBp+IX
         r5kq9+HFrdGHkUkj7SYo/b1mID76Vm2wC2ZnM6S4LxEvIibtPfmQw0qLt9GHWsFovsDY
         3by66QryhJjFqDSYMmaWK2a5LdOkOYvJjcKotdAi0VZ/QNiJaHw7xvohyACm7KYFIX/E
         Iu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUBahcFC2EkyxihFp/0dtOPXo17e1SNi+2zLTLVehUo=;
        b=BBJ3YHhcj+kKpHOCdw/OZQotaRdB1qcT3Wiy/OJ9Zuaj9M5o2yQ57539p6r0PFSpkO
         UtqjJe7tytrVv+QxDiyaHORWHzq9YKRTPPJic2tTKhhTbwVmTUE61fcrAddBHbNyHkto
         OV01eDN0glzIT9bRDwFDo0VLHAnO0Qdvv1q048CuPOFC/0L8D1xRWP8xbYimA2yvwX4Q
         zde2KcYa6TZEslIQtZUnZpRg6a+zALXmNmB0HbolBs19JN3UyfrNBBxirqnSQXjihrJc
         MYC7B0TRJw9Lv4s+SjkAl/IReR9K91i9A1MzojH/eJogqIlGCiOMseUUYVb4NIU54Kbc
         fOrw==
X-Gm-Message-State: AAQBX9dVpDiflY/qts4Ucodvy4r2wjKqBaInW/aPaLyJgV3oNNjBn3wO
        i7q+fgxJKVw3gH2awHG63UZZm0CTYtI=
X-Google-Smtp-Source: AKy350YnbwioB9aWSf6yCp4ShGaWIAQbOWwpJgAE7s/3k8v7keGbzS2pyirTwb7g4KlewBDMvWnY1w==
X-Received: by 2002:a05:600c:b54:b0:3ed:6c71:9dc8 with SMTP id k20-20020a05600c0b5400b003ed6c719dc8mr890581wmr.22.1680571365681;
        Mon, 03 Apr 2023 18:22:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b13-20020adff24d000000b002c573778432sm10832129wrp.102.2023.04.03.18.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:45 -0700 (PDT)
Message-Id: <0ac095731a7ffc2b373679bee0e99a0e7ae93c66.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:20 +0000
Subject: [PATCH v2 16/24] editor: move editor-related functions and
 declarations into common file
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

cache.h and strbuf.[ch] had editor-related functions.  Move these into
editor.[ch].

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c          |  1 +
 builtin/add.c        |  1 +
 builtin/am.c         |  1 +
 builtin/branch.c     |  1 +
 builtin/bugreport.c  |  1 +
 builtin/commit.c     |  1 +
 builtin/config.c     |  1 +
 builtin/merge.c      |  1 +
 builtin/notes.c      |  1 +
 builtin/replace.c    |  1 +
 builtin/tag.c        |  1 +
 builtin/var.c        |  1 +
 cache.h              |  3 ---
 color.c              |  1 +
 editor.c             | 30 ++++++++++++++++++++++++++++++
 editor.h             | 34 ++++++++++++++++++++++++++++++++++
 pager.c              |  1 +
 rebase-interactive.c |  1 +
 sideband.c           |  1 +
 strbuf.c             | 28 ----------------------------
 strbuf.h             | 24 ------------------------
 21 files changed, 80 insertions(+), 55 deletions(-)
 create mode 100644 editor.h

diff --git a/add-patch.c b/add-patch.c
index b01ba8fa81d..8d770d203ff 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -2,6 +2,7 @@
 #include "add-interactive.h"
 #include "advice.h"
 #include "alloc.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/builtin/add.c b/builtin/add.c
index d3c51e28142..76cc026a68a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "lockfile.h"
+#include "editor.h"
 #include "dir.h"
 #include "gettext.h"
 #include "pathspec.h"
diff --git a/builtin/am.c b/builtin/am.c
index 0d7ee28bddc..f7a065e5290 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -9,6 +9,7 @@
 #include "advice.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 7c1c872708f..1fb11d55e65 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "environment.h"
 #include "refs.h"
 #include "commit.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 03fb0536911..daf6c236577 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "abspath.h"
+#include "editor.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "strbuf.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 682f47c8d5a..e67c4be2211 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -13,6 +13,7 @@
 #include "cache-tree.h"
 #include "color.h"
 #include "dir.h"
+#include "editor.h"
 #include "environment.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/config.c b/builtin/config.c
index fe79fb60c43..9401f1e5e3b 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -3,6 +3,7 @@
 #include "alloc.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "ident.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 693f185d4d3..8da3e46abb0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -12,6 +12,7 @@
 #include "advice.h"
 #include "alloc.h"
 #include "config.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 896140b9055..d5788352b6e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -10,6 +10,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index f4b3a8efb23..981f1894436 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -11,6 +11,7 @@
 #include "cache.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 88a25902309..7d189a4a5d4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -10,6 +10,7 @@
 #include "advice.h"
 #include "config.h"
 #include "builtin.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/var.c b/builtin/var.c
index d9943be9afd..90616cf65a2 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -5,6 +5,7 @@
  */
 #include "builtin.h"
 #include "config.h"
+#include "editor.h"
 #include "ident.h"
 #include "refs.h"
 
diff --git a/cache.h b/cache.h
index 394e8d01254..97ddf4094a3 100644
--- a/cache.h
+++ b/cache.h
@@ -621,10 +621,7 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-const char *git_editor(void);
-const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
-int is_terminal_dumb(void);
 
 struct cache_def {
 	struct strbuf path;
diff --git a/color.c b/color.c
index 672dcbb73a6..a8e8d5202ab 100644
--- a/color.c
+++ b/color.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "color.h"
+#include "editor.h"
 #include "gettext.h"
 #include "hex.h"
 
diff --git a/editor.c b/editor.c
index 3bea3ef72f7..12025dfec37 100644
--- a/editor.c
+++ b/editor.c
@@ -2,12 +2,14 @@
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "strbuf.h"
 #include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "wrapper.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -130,3 +132,31 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
 {
 	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
 }
+
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env)
+{
+	char *path2 = NULL;
+	int fd, res = 0;
+
+	if (!is_absolute_path(path))
+		path = path2 = xstrdup(git_path("%s", path));
+
+	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0)
+		res = error_errno(_("could not open '%s' for writing"), path);
+	else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
+		res = error_errno(_("could not write to '%s'"), path);
+		close(fd);
+	} else if (close(fd) < 0)
+		res = error_errno(_("could not close '%s'"), path);
+	else {
+		strbuf_reset(buffer);
+		if (launch_editor(path, buffer, env) < 0)
+			res = error_errno(_("could not edit '%s'"), path);
+		unlink(path);
+	}
+
+	free(path2);
+	return res;
+}
diff --git a/editor.h b/editor.h
new file mode 100644
index 00000000000..8016bb5e00b
--- /dev/null
+++ b/editor.h
@@ -0,0 +1,34 @@
+#ifndef EDITOR_H
+#define EDITOR_H
+
+struct strbuf;
+
+const char *git_editor(void);
+const char *git_sequence_editor(void);
+int is_terminal_dumb(void);
+
+/**
+ * Launch the user preferred editor to edit a file and fill the buffer
+ * with the file's contents upon the user completing their editing. The
+ * third argument can be used to set the environment which the editor is
+ * run in. If the buffer is NULL the editor is launched as usual but the
+ * file's contents are not read into the buffer upon completion.
+ */
+int launch_editor(const char *path, struct strbuf *buffer,
+		  const char *const *env);
+
+int launch_sequence_editor(const char *path, struct strbuf *buffer,
+			   const char *const *env);
+
+/*
+ * In contrast to `launch_editor()`, this function writes out the contents
+ * of the specified file first, then clears the `buffer`, then launches
+ * the editor and reads back in the file contents into the `buffer`.
+ * Finally, it deletes the temporary file.
+ *
+ * If `path` is relative, it refers to a file in the `.git` directory.
+ */
+int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
+			      const char *const *env);
+
+#endif
diff --git a/pager.c b/pager.c
index b66bbff2785..6367e8ef867 100644
--- a/pager.c
+++ b/pager.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "config.h"
+#include "editor.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "alias.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 6ff12d7be2d..789f4073617 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "commit.h"
+#include "editor.h"
 #include "environment.h"
 #include "gettext.h"
 #include "sequencer.h"
diff --git a/sideband.c b/sideband.c
index 0af582858bf..25e2a185716 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "color.h"
 #include "config.h"
+#include "editor.h"
 #include "gettext.h"
 #include "sideband.h"
 #include "help.h"
diff --git a/strbuf.c b/strbuf.c
index b2e3735ba8a..729378ec824 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1180,34 +1180,6 @@ int strbuf_normalize_path(struct strbuf *src)
 	return 0;
 }
 
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env)
-{
-	char *path2 = NULL;
-	int fd, res = 0;
-
-	if (!is_absolute_path(path))
-		path = path2 = xstrdup(git_path("%s", path));
-
-	fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0)
-		res = error_errno(_("could not open '%s' for writing"), path);
-	else if (write_in_full(fd, buffer->buf, buffer->len) < 0) {
-		res = error_errno(_("could not write to '%s'"), path);
-		close(fd);
-	} else if (close(fd) < 0)
-		res = error_errno(_("could not close '%s'"), path);
-	else {
-		strbuf_reset(buffer);
-		if (launch_editor(path, buffer, env) < 0)
-			res = error_errno(_("could not edit '%s'"), path);
-		unlink(path);
-	}
-
-	free(path2);
-	return res;
-}
-
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
 	char *path_sep = find_last_dir_sep(sb->buf);
diff --git a/strbuf.h b/strbuf.h
index b980f9edc6d..3dfeadb44c2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -640,30 +640,6 @@ void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len);
 
-/**
- * Launch the user preferred editor to edit a file and fill the buffer
- * with the file's contents upon the user completing their editing. The
- * third argument can be used to set the environment which the editor is
- * run in. If the buffer is NULL the editor is launched as usual but the
- * file's contents are not read into the buffer upon completion.
- */
-int launch_editor(const char *path, struct strbuf *buffer,
-		  const char *const *env);
-
-int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env);
-
-/*
- * In contrast to `launch_editor()`, this function writes out the contents
- * of the specified file first, then clears the `buffer`, then launches
- * the editor and reads back in the file contents into the `buffer`.
- * Finally, it deletes the temporary file.
- *
- * If `path` is relative, it refers to a file in the `.git` directory.
- */
-int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env);
-
 /*
  * Remove the filename from the provided path string. If the path
  * contains a trailing separator, then the path is considered a directory
-- 
gitgitgadget

