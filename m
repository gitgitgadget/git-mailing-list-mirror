Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E80CD613C
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378858AbjJIV7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378839AbjJIV7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:59:02 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE4C9E
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:59:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406650da82bso46546245e9.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888739; x=1697493539; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv1i8EjSJYpO2KpYpS3Fztg/+oxg0kh/zvWm6sZWwF8=;
        b=ZV4pT4gLhMnyHWJ3PCCV0A1O1RM6RbljP8VW7FGiRWR4TGkRXzu7P4JGD/nloLBHkh
         I/rJfRaGe9IkxlCBrqjr1VsE8eo6lNzWGylydvBPIb13r3QVQDhLB5NjIWnGMLUD29b2
         cMBA8wH5r6VQOdVaJWoAv1EKt06WBrEbwkWVoB9fWg2CrIYLvm/xyembLUVzomvfSUKE
         3J/EGc/OMm10Uu574kLUu/bUnhBbkGKBtMEzSeSuF8CXSRAeyAWPgmdtvDc5N06glWCs
         F6E8k0HQM7RvM38/MVuj4hlC3K7UWiAGRmeQ5vhOGXFS8hcPe0vwNUiut96JAcuNo2H0
         fg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888739; x=1697493539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv1i8EjSJYpO2KpYpS3Fztg/+oxg0kh/zvWm6sZWwF8=;
        b=m7xwysm43s6Gu+LuuzglfO/0/KLozbAteLU7CyLivpvnvMfEpJERUCuRWpIVV5pi58
         dJz0fOaLa4PIrUWPuEkhoNKfNGZKRZxadPlgWGTEsoYQqyM2b0YaMZ/N7XYhcx2ZlxD6
         CR7efih1amphJyXM32tphWHQKMvOD7wfAqe0enl2oxVsDicP9JiOU1VlYm0KAxZjfRPI
         AFvcMR0ySEXHuQY3zH1CQc8SCrTvGR58Uio43z4zciImQZq7P3QKu/psDe5ufkPCynPl
         lPGuHORYl9Ll5+ytJhc37niM8xipXXdL+eYII+g3ZUnbBIRlvCu45B6tsyt3ACVuzBsh
         P9Xg==
X-Gm-Message-State: AOJu0YyPy0qGKW7ts7E/9l9GK/ddUTU677W8y+QMXShJ/fFEjec8Y8iM
        BK9RIR1fO/3WAPHJJPY6QsNH4xwFr0U=
X-Google-Smtp-Source: AGHT+IGsFWTYyXtIjZSuQys+TNF4Qb0jcgpWMK+GzbInuR/IFRKCUFqOqZZLbL12TC50YNM5mO/spg==
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr15468928wmd.41.1696888738588;
        Mon, 09 Oct 2023 14:58:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t2-20020a5d6902000000b003250aec5e97sm10844251wru.4.2023.10.09.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:58:58 -0700 (PDT)
Message-ID: <172538b5e30fe38f5f37726fd6c31fc63984edba.1696888736.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 21:58:54 +0000
Subject: [PATCH v2 2/4] dir.[ch]: expose 'get_dtype'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Move 'get_dtype()' from 'diagnose.c' to 'dir.c' and add its declaration to
'dir.h' so that it is accessible to callers in other files. The function and
its documentation are moved verbatim except for a small addition to the
description clarifying what the 'path' arg represents.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 diagnose.c | 36 ------------------------------------
 dir.c      | 28 ++++++++++++++++++++++++++++
 dir.h      | 11 +++++++++++
 3 files changed, 39 insertions(+), 36 deletions(-)

diff --git a/diagnose.c b/diagnose.c
index 8430064000b..fc4d344bd63 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -71,42 +71,6 @@ static int dir_file_stats(struct object_directory *object_dir, void *data)
 	return 0;
 }
 
-/*
- * Get the d_type of a dirent. If the d_type is unknown, derive it from
- * stat.st_mode.
- *
- * Note that 'path' is assumed to have a trailing slash. It is also modified
- * in-place during the execution of the function, but is then reverted to its
- * original value before returning.
- */
-static unsigned char get_dtype(struct dirent *e, struct strbuf *path)
-{
-	struct stat st;
-	unsigned char dtype = DTYPE(e);
-	size_t base_path_len;
-
-	if (dtype != DT_UNKNOWN)
-		return dtype;
-
-	/* d_type unknown in dirent, try to fall back on lstat results */
-	base_path_len = path->len;
-	strbuf_addstr(path, e->d_name);
-	if (lstat(path->buf, &st))
-		goto cleanup;
-
-	/* determine d_type from st_mode */
-	if (S_ISREG(st.st_mode))
-		dtype = DT_REG;
-	else if (S_ISDIR(st.st_mode))
-		dtype = DT_DIR;
-	else if (S_ISLNK(st.st_mode))
-		dtype = DT_LNK;
-
-cleanup:
-	strbuf_setlen(path, base_path_len);
-	return dtype;
-}
-
 static int count_files(struct strbuf *path)
 {
 	DIR *dir = opendir(path->buf);
diff --git a/dir.c b/dir.c
index 8486e4d56ff..5e01af3a25e 100644
--- a/dir.c
+++ b/dir.c
@@ -2235,6 +2235,34 @@ static int get_index_dtype(struct index_state *istate,
 	return DT_UNKNOWN;
 }
 
+unsigned char get_dtype(struct dirent *e, struct strbuf *path)
+{
+	struct stat st;
+	unsigned char dtype = DTYPE(e);
+	size_t base_path_len;
+
+	if (dtype != DT_UNKNOWN)
+		return dtype;
+
+	/* d_type unknown in dirent, try to fall back on lstat results */
+	base_path_len = path->len;
+	strbuf_addstr(path, e->d_name);
+	if (lstat(path->buf, &st))
+		goto cleanup;
+
+	/* determine d_type from st_mode */
+	if (S_ISREG(st.st_mode))
+		dtype = DT_REG;
+	else if (S_ISDIR(st.st_mode))
+		dtype = DT_DIR;
+	else if (S_ISLNK(st.st_mode))
+		dtype = DT_LNK;
+
+cleanup:
+	strbuf_setlen(path, base_path_len);
+	return dtype;
+}
+
 static int resolve_dtype(int dtype, struct index_state *istate,
 			 const char *path, int len)
 {
diff --git a/dir.h b/dir.h
index ad06682fd54..28c630ce806 100644
--- a/dir.h
+++ b/dir.h
@@ -363,6 +363,17 @@ struct dir_struct {
 
 struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
 
+/*
+ * Get the d_type of a dirent. If the d_type is unknown, derive it from
+ * stat.st_mode using the path to the dirent's containing directory (path) and
+ * the name of the dirent itself.
+ *
+ * Note that 'path' is assumed to have a trailing slash. It is also modified
+ * in-place during the execution of the function, but is then reverted to its
+ * original value before returning.
+ */
+unsigned char get_dtype(struct dirent *e, struct strbuf *path);
+
 /*Count the number of slashes for string s*/
 int count_slashes(const char *s);
 
-- 
gitgitgadget

