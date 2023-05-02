Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA65C7EE24
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjEBVPW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEBVPL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:15:11 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED591984
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:15:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-52857fc23b1so4034438a12.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683062105; x=1685654105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=33QUf9cwaDqkiFt0+KvGAGnOTp8WEcA9ics2H47iHRc=;
        b=E8i3dPXcpZxmJJ7qX3fzKpRltrSM5Z5JaQcLkn3FbCuQnaItFLdAFjgfgOfCKKQ+sh
         w1tJTPWpr/VearirUXmO/yL3oAU1VKhn/wTTi+ISqXMYNBmQjSYHXBAG/9duiLbJRz6H
         0jEM0kLgsmLjxK+imemVf/GIbYkskcZqEEyoeTwHTcMYBcXup9Ozsxn2IzhMPl4ejkuQ
         Fx6bEXmCxZBVUUPoM/G/ZDm9olbBVkuFyCT7BJ6ofVsMAGoamVP08pxFnMDEUJbLHlam
         oLdAeVgWaWDcAlWjBdwwkx2S/U2E0XFmpTN1A9k43zj3w5LfQhz695ll6Atw3ViMTpAo
         TSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683062105; x=1685654105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33QUf9cwaDqkiFt0+KvGAGnOTp8WEcA9ics2H47iHRc=;
        b=YGVUjPXFHmKzMRRX1Bs5jUJ8Wv8qpRN0O4C5X+jysgEzE1J46vXZH03daGqg5DVq3q
         1SPpJlDu7Q5RMj545b7dIkrh9XDUAs3EcZxdtw/lcflRUK94yqVDtk9awDcRb7usVw6U
         4fiELIRRd7wizLtzvAcCj73cBK4G554/wpP7if+NmTIgzScgSvwDg3WR02JozxZhSzHr
         QV3NDUb17yumZQlGvxvzPaedUzAfzUTv3oxUFm4oyYXNV7sPgtUutJV9rrGNf9M2+Wrn
         HFpmjpaAppEXONRyQTQGzaC5ednv5CdoInhWEk14MtavbLfZLWGXsyWDW3rRYw8VOt/w
         n9fw==
X-Gm-Message-State: AC+VfDzcGTNrwh1ucX0ptpXbGJyyApBLSg2MpV4WxmTS53Ydb+4laVts
        Lzir0D6WupkiFb6EjXe1qcU0JQddY7y+HPwgMcW+sxmCWhX57Rzw5FKxrDIL1cpWAoTzmyjq2Ip
        eGClKVsCc+gIYicr5anHJIP4Qv1uRidqBh9i8S9UTBzBSElsShMu7JhgAxG+kLa+OSw==
X-Google-Smtp-Source: ACHHUZ5XeRkcngBW8SPXSoChxWa5zDEZAxGBOA/a8rZWsTqhj+N3CbLs/66/+xzEEcQ+vzl+CMYOwu/NADBL7xA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:6946:0:b0:51b:aee8:7ae9 with SMTP id
 e67-20020a636946000000b0051baee87ae9mr4594391pgc.12.1683062105477; Tue, 02
 May 2023 14:15:05 -0700 (PDT)
Date:   Tue,  2 May 2023 21:14:49 +0000
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230502211454.1673000-2-calvinwan@google.com>
Subject: [PATCH 1/6] abspath: move related functions to abspath
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move abspath-related functions from strbuf.[ch] to abspath.[ch] since
they do not belong in a low-level library.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 abspath.c  | 36 ++++++++++++++++++++++++++++++++++++
 abspath.h  | 21 +++++++++++++++++++++
 hook.c     |  1 +
 strbuf.c   | 37 -------------------------------------
 strbuf.h   | 22 ----------------------
 tempfile.c |  1 +
 6 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/abspath.c b/abspath.c
index d032f5dce5..1202cde23d 100644
--- a/abspath.c
+++ b/abspath.c
@@ -289,3 +289,39 @@ char *prefix_filename_except_for_dash(const char *pfx, const char *arg)
 		return xstrdup(arg);
 	return prefix_filename(pfx, arg);
 }
+
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
+{
+	if (!*path)
+		die("The empty string is not a valid path");
+	if (!is_absolute_path(path)) {
+		struct stat cwd_stat, pwd_stat;
+		size_t orig_len = sb->len;
+		char *cwd = xgetcwd();
+		char *pwd = getenv("PWD");
+		if (pwd && strcmp(pwd, cwd) &&
+		    !stat(cwd, &cwd_stat) &&
+		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
+		    !stat(pwd, &pwd_stat) &&
+		    pwd_stat.st_dev == cwd_stat.st_dev &&
+		    pwd_stat.st_ino == cwd_stat.st_ino)
+			strbuf_addstr(sb, pwd);
+		else
+			strbuf_addstr(sb, cwd);
+		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
+			strbuf_addch(sb, '/');
+		free(cwd);
+	}
+	strbuf_addstr(sb, path);
+}
+
+void strbuf_add_real_path(struct strbuf *sb, const char *path)
+{
+	if (sb->len) {
+		struct strbuf resolved = STRBUF_INIT;
+		strbuf_realpath(&resolved, path, 1);
+		strbuf_addbuf(sb, &resolved);
+		strbuf_release(&resolved);
+	} else
+		strbuf_realpath(sb, path, 1);
+}
diff --git a/abspath.h b/abspath.h
index 7cd3de5e9d..4653080d5e 100644
--- a/abspath.h
+++ b/abspath.h
@@ -30,4 +30,25 @@ static inline int is_absolute_path(const char *path)
 	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
 }
 
+/**
+ * Add a path to a buffer, converting a relative path to an
+ * absolute one in the process.  Symbolic links are not
+ * resolved.
+ */
+void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
+
+/**
+ * Canonize `path` (make it absolute, resolve symlinks, remove extra
+ * slashes) and append it to `sb`.  Die with an informative error
+ * message if there is a problem.
+ *
+ * The directory part of `path` (i.e., everything up to the last
+ * dir_sep) must denote a valid, existing directory, but the last
+ * component need not exist.
+ *
+ * Callers that don't mind links should use the more lightweight
+ * strbuf_add_absolute_path() instead.
+ */
+void strbuf_add_real_path(struct strbuf *sb, const char *path);
+
 #endif /* ABSPATH_H */
diff --git a/hook.c b/hook.c
index 76e322f580..2d8706371e 100644
--- a/hook.c
+++ b/hook.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "gettext.h"
 #include "hook.h"
diff --git a/strbuf.c b/strbuf.c
index 729378ec82..c3b6d48797 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,5 +1,4 @@
 #include "git-compat-util.h"
-#include "abspath.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
@@ -899,42 +898,6 @@ void strbuf_humanise_rate(struct strbuf *buf, off_t bytes)
 	strbuf_humanise(buf, bytes, 1);
 }
 
-void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
-{
-	if (!*path)
-		die("The empty string is not a valid path");
-	if (!is_absolute_path(path)) {
-		struct stat cwd_stat, pwd_stat;
-		size_t orig_len = sb->len;
-		char *cwd = xgetcwd();
-		char *pwd = getenv("PWD");
-		if (pwd && strcmp(pwd, cwd) &&
-		    !stat(cwd, &cwd_stat) &&
-		    (cwd_stat.st_dev || cwd_stat.st_ino) &&
-		    !stat(pwd, &pwd_stat) &&
-		    pwd_stat.st_dev == cwd_stat.st_dev &&
-		    pwd_stat.st_ino == cwd_stat.st_ino)
-			strbuf_addstr(sb, pwd);
-		else
-			strbuf_addstr(sb, cwd);
-		if (sb->len > orig_len && !is_dir_sep(sb->buf[sb->len - 1]))
-			strbuf_addch(sb, '/');
-		free(cwd);
-	}
-	strbuf_addstr(sb, path);
-}
-
-void strbuf_add_real_path(struct strbuf *sb, const char *path)
-{
-	if (sb->len) {
-		struct strbuf resolved = STRBUF_INIT;
-		strbuf_realpath(&resolved, path, 1);
-		strbuf_addbuf(sb, &resolved);
-		strbuf_release(&resolved);
-	} else
-		strbuf_realpath(sb, path, 1);
-}
-
 int printf_ln(const char *fmt, ...)
 {
 	int ret;
diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..6b4ad63266 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -527,28 +527,6 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
  */
 int strbuf_getcwd(struct strbuf *sb);
 
-/**
- * Add a path to a buffer, converting a relative path to an
- * absolute one in the process.  Symbolic links are not
- * resolved.
- */
-void strbuf_add_absolute_path(struct strbuf *sb, const char *path);
-
-/**
- * Canonize `path` (make it absolute, resolve symlinks, remove extra
- * slashes) and append it to `sb`.  Die with an informative error
- * message if there is a problem.
- *
- * The directory part of `path` (i.e., everything up to the last
- * dir_sep) must denote a valid, existing directory, but the last
- * component need not exist.
- *
- * Callers that don't mind links should use the more lightweight
- * strbuf_add_absolute_path() instead.
- */
-void strbuf_add_real_path(struct strbuf *sb, const char *path);
-
-
 /**
  * Normalize in-place the path contained in the strbuf. See
  * normalize_path_copy() for details. If an error occurs, the contents of "sb"
diff --git a/tempfile.c b/tempfile.c
index 50c377134c..6c88a63b42 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -43,6 +43,7 @@
  */
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "path.h"
 #include "tempfile.h"
 #include "sigchain.h"
-- 
2.40.1.495.gc816e09b53d-goog

