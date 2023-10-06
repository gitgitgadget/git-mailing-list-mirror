Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DCAE81E1F
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjJFSJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjJFSJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:09:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB406C6
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:09:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso21864205e9.2
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615772; x=1697220572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyh/4l751L4Gup0iCJkdEhHSFXi9sz+WZTkvrl4T8Hc=;
        b=im5BYKYj2qKAjFhUWCjjtVBz3u8lgrtHQ4CqCGpTOr4cujH0Cl6l0egamtggWx1Dc0
         MNySYozkklH+2YiUZPEgH7wBEZJ+cBQUVBZG32EKwj0L9byW/aao4vf7p/Imr6yJH5t9
         l7A2e9ACaTrKXQq37nsPCRbTV4YXVsWDzbtpOZlToFOEbAoUZrlGAKLaEWj+oZjDAZUe
         mUzs3nUanwOkrNDTGYCZcYT/GPxpvthkc6jP+OpqlRHNrBI341kpbrtJyu92p97rk/bG
         yX9DRvzW+w4d9NOuQehrm61HnnoikT9JfrujBKRTNadSItc5TJtSQZSJU3PlznCGC8Lm
         Ybgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615772; x=1697220572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyh/4l751L4Gup0iCJkdEhHSFXi9sz+WZTkvrl4T8Hc=;
        b=AduIZvUarpos0ci+wBltlOXh8Q2Tb1FBv9QDK/+25QPgMknRVaV5L9DxNQ1RV0tKBc
         1mkL0DQGPXsfJSvCTP7swU8hy8INLbkgMS4BuFQmE4c00d9N0DVfeQh6Dl58BFYA3DRR
         3W6ju9SDmFPe7VY/WDAqwQtBcbqVQ9kDcOCNo174PQ3auPh0S1y6HL+lva70m+DRq6jk
         cosqY3MSwOspUFiibXlpZYyg0cmYwLLmXt/YqXuB4RhODGcU0Jb4XC3VlCc1C11OpH/r
         qAgFtcGS8J3kYMl3XyQLVVUqyJJbwQa4Eqxh2TkbUIRazd4jr3iB2n8fn8jUYC+y1zsX
         +4tg==
X-Gm-Message-State: AOJu0Yyxsb/S2yWVq5yfKIPEygUugLKGKloft7aT8n1G6hG/3GLqjV3+
        iY95jptiztQPvmnIQoAllvNDI3W46b0=
X-Google-Smtp-Source: AGHT+IH5Ijf52L3ZYpYOiDg+gDCR6er2v5wIhyYC3boj5Emrb/00FLqVLbG9A5z0oBkrua57Yu+gaQ==
X-Received: by 2002:a05:600c:2050:b0:405:40c6:2ba4 with SMTP id p16-20020a05600c205000b0040540c62ba4mr7801177wmg.5.1696615771948;
        Fri, 06 Oct 2023 11:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e24-20020a05600c219800b004013797efb6sm6497653wme.9.2023.10.06.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:09:31 -0700 (PDT)
Message-ID: <a382d2ba652a1ac9b0e39552558fb69a4e2aad5e.1696615769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 18:09:28 +0000
Subject: [PATCH 3/4] dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add a 'follow_symlink' boolean option to 'get_type()'. If 'follow_symlink'
is enabled, DT_LNK (in addition to DT_UNKNOWN) d_types triggers the
stat-based d_type resolution, using 'stat' instead of 'lstat' to get the
type of the followed symlink. Note that symlinks are not followed
recursively, so a symlink pointing to another symlink will still resolve to
DT_LNK.

Update callers in 'diagnose.c' to specify 'follow_symlink = 0' to preserve
current behavior.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 diagnose.c |  6 +++---
 dir.c      | 13 +++++++++----
 dir.h      |  7 ++++++-
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/diagnose.c b/diagnose.c
index fc4d344bd63..4d096c857f1 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -81,7 +81,7 @@ static int count_files(struct strbuf *path)
 		return 0;
 
 	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
-		if (get_dtype(e, path) == DT_REG)
+		if (get_dtype(e, path, 0) == DT_REG)
 			count++;
 
 	closedir(dir);
@@ -110,7 +110,7 @@ static void loose_objs_stats(struct strbuf *buf, const char *path)
 	base_path_len = count_path.len;
 
 	while ((e = readdir_skip_dot_and_dotdot(dir)) != NULL)
-		if (get_dtype(e, &count_path) == DT_DIR &&
+		if (get_dtype(e, &count_path, 0) == DT_DIR &&
 		    strlen(e->d_name) == 2 &&
 		    !hex_to_bytes(&c, e->d_name, 1)) {
 			strbuf_setlen(&count_path, base_path_len);
@@ -155,7 +155,7 @@ static int add_directory_to_archiver(struct strvec *archiver_args,
 
 		strbuf_add_absolute_path(&abspath, at_root ? "." : path);
 		strbuf_addch(&abspath, '/');
-		dtype = get_dtype(e, &abspath);
+		dtype = get_dtype(e, &abspath, 0);
 
 		strbuf_setlen(&buf, len);
 		strbuf_addstr(&buf, e->d_name);
diff --git a/dir.c b/dir.c
index 5e01af3a25e..16fdb03f2a5 100644
--- a/dir.c
+++ b/dir.c
@@ -2235,19 +2235,24 @@ static int get_index_dtype(struct index_state *istate,
 	return DT_UNKNOWN;
 }
 
-unsigned char get_dtype(struct dirent *e, struct strbuf *path)
+unsigned char get_dtype(struct dirent *e, struct strbuf *path,
+			int follow_symlink)
 {
 	struct stat st;
 	unsigned char dtype = DTYPE(e);
 	size_t base_path_len;
 
-	if (dtype != DT_UNKNOWN)
+	if (dtype != DT_UNKNOWN && !(follow_symlink && dtype == DT_LNK))
 		return dtype;
 
-	/* d_type unknown in dirent, try to fall back on lstat results */
+	/*
+	 * d_type unknown or unfollowed symlink, try to fall back on [l]stat
+	 * results. If [l]stat fails, explicitly set DT_UNKNOWN.
+	 */
 	base_path_len = path->len;
 	strbuf_addstr(path, e->d_name);
-	if (lstat(path->buf, &st))
+	if ((follow_symlink && stat(path->buf, &st)) ||
+	    (!follow_symlink && lstat(path->buf, &st)))
 		goto cleanup;
 
 	/* determine d_type from st_mode */
diff --git a/dir.h b/dir.h
index 28c630ce806..98aa85fcc0e 100644
--- a/dir.h
+++ b/dir.h
@@ -368,11 +368,16 @@ struct dirent *readdir_skip_dot_and_dotdot(DIR *dirp);
  * stat.st_mode using the path to the dirent's containing directory (path) and
  * the name of the dirent itself.
  *
+ * If 'follow_symlink' is 1, this function will attempt to follow DT_LNK types
+ * using 'stat'. Links are *not* followed recursively, so a symlink pointing
+ * to another symlink will still resolve to 'DT_LNK'.
+ *
  * Note that 'path' is assumed to have a trailing slash. It is also modified
  * in-place during the execution of the function, but is then reverted to its
  * original value before returning.
  */
-unsigned char get_dtype(struct dirent *e, struct strbuf *path);
+unsigned char get_dtype(struct dirent *e, struct strbuf *path,
+			int follow_symlink);
 
 /*Count the number of slashes for string s*/
 int count_slashes(const char *s);
-- 
gitgitgadget

