Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1EDC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjECSvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjECSuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:52 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F41A19A8
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5144902c15eso2745759a12.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139839; x=1685731839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BI8GcA1W0eLnfWvRtV9iJbidfJEUTlErMxT+mrnnqM=;
        b=u+qNoYYn0nQNlEaluR55OD5MCaRtxvPUAn0TxGhyBBFJYyRbSXzWWYEUumzrRdBZpL
         iH8Ez6ne2hTOZPBp4CiVROL1gZ4VkpTPbM1xAXn1nBU68iK8GN5jf4OmwZiL82JVVEh1
         MCFGcq9YEytGCnriQL4S3QJiogXfDAgfcFZ4JAKbxI6JcNCNCu8bRqtyBQT2WPHwYCd8
         HwJdso50NUtPyv638+oisXuKB4lz7+DM0geuVDy2+g+mu8Dct/paImTnve21rJp2tgIU
         hyhLCEvC80mH9vc+F6w9OhbfFQ0i+J5PDn5DxCH2RA/dM6f0vyqfjSMIDFQhY00E2w9l
         6nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139839; x=1685731839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BI8GcA1W0eLnfWvRtV9iJbidfJEUTlErMxT+mrnnqM=;
        b=hPP4FzyiGfMpI0EutzTr9c/6SDDbgLPdiFpC2QuyiLZp0V4zzYDoR/Crd+Bk7ITqf4
         5Gdd6y1ETcjDzGT4oHgVbCWlDzpKqs9YnqeuKdiedgJ8wt0CLtbTjoj/6A2YcLwXmU7G
         xwgo3DGJ7Jy+pOVwMT7vSy4syeaWP8zmI7PZFEW5Qv45LUqhePoEo+IrTyLFIY/Z8mhf
         LCmSmY/qk4K+uB+AB3l4qy96evij+fKnmjnxidJn0JjDuDyjBhGeUzOgpvejZbjMLhOL
         v5aQZkBSxTW1t8BslmZE+HpsffTbGAUAwggAt/LIC6b5bE+7nqyHY+RDe9Cbh2rp4WaT
         H8Kw==
X-Gm-Message-State: AC+VfDzxgNPp9//jZtQi2AvST2WP8o3TIGl8f3ckBNLgJLHmIVL5iX9D
        GsCB++1HVXckf2JGO3AnX9IeNjHrsZCYtjb/DZBNPZeXwK/+6ox9OxX2rTEVVIWKRMKepBzodFK
        qB2b6Xp4kBnfGzkZmCpYR0JGcBJ7fo2OHMYqSf96EZXaTq23g6PEZzOmV0qnfgonBNw==
X-Google-Smtp-Source: ACHHUZ7E/L4aerBnU/hY5tdPMa0Swg/MbJIW8Fu+B7YX3YM2b4abLj/6wO34CC/lQ6LtfqqtOVv6nueaKGJ3f50=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:8841:0:b0:513:290b:7516 with SMTP id
 l62-20020a638841000000b00513290b7516mr780726pgd.3.1683139839072; Wed, 03 May
 2023 11:50:39 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:26 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-2-calvinwan@google.com>
Subject: [PATCH v2 2/7] abspath: move related functions to abspath
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move abspath-related functions from strbuf.[ch] to abspath.[ch] since
paths are not primitive objects and therefore strbuf should not interact
with them.

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
index c856253216..20d0e37d9c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -531,28 +531,6 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
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
2.40.1.521.gf1e218fcd8-goog

