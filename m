Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F011C2BA1B
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 21:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378865AbjJIV7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378842AbjJIV7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 17:59:02 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36B9F
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 14:59:01 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4066241289bso46927925e9.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 14:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696888739; x=1697493539; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyh/4l751L4Gup0iCJkdEhHSFXi9sz+WZTkvrl4T8Hc=;
        b=kpLbMKm9Wf3mDqv2fwPT2KZiqg+X1tYp0QiUjgU4wO1cQMKu6C9oC5C8XWjU/mafS+
         3CzH9D1QoeTkYbfSOjK290hItixN2/i3NyqOidGgfCaQAINuvYTLUlnIvJVQyAjxg6TU
         HxjfC5hGuIanYYFYEzbNJxatoGK6FmZU2zqT5fn1dJjL2Jbd+rB6xCz3GBaK0iGwausZ
         /OQbfuwHQnqgDuws1yDfPhqEAOsNvxKVwmWsKqw1QnnvQfhkOrx1Z1BjvrbfJDms7Ijj
         0m4a2iwv+jn1AUp3PSLfv9O4zhu1YYczd0xKiPMEUnild8DPfWyeve7NxYzt0LYebOhE
         4kBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696888739; x=1697493539;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyh/4l751L4Gup0iCJkdEhHSFXi9sz+WZTkvrl4T8Hc=;
        b=tWOawp0C216gwSnlE3+J60W7CNlQLYu2VHYMHn1fmVxDSL/8QcgrUIn4+Yn6MhxfBJ
         TSZu7pQai8QuSyS1QClIb4R7nFRmNLauuWa2U7+MegQpPiLMDaaE/govdtY1j0NOjjY9
         HZf2azTX+7KHreGnOk7XF23lBG9Qqy2th7NlfYh878AGm2uBcA8CLr8jWbl5uSxlVy6o
         Zx0Rh4//t+9fij1nUx3MujUPeWPYqZtEppbRtNEscJWLLB4TNOWp4dPBRdpRbndDpwNA
         vOpuFGlZv1t+SpzCSjjq/+yUUDBHb4kgeQm3cIhN+hnypQmb5KaUU4uxSvblqq+izBKQ
         y4BQ==
X-Gm-Message-State: AOJu0Yx1CXXndCGEv/3jkX78naFLUWLSILv4GIouEcaPInaCUSf04Pmn
        rlbC5wtGjnSFrSQw6XBYbOTeygCugUw=
X-Google-Smtp-Source: AGHT+IGe3Gg61qQHPPsIW3EzsNMLJGREsoP8KN90kPZmYf1zvDfRJAlDbVWlif5t1ZU2eZDkxCBMWQ==
X-Received: by 2002:a05:600c:3652:b0:3fe:d1b9:7ea9 with SMTP id y18-20020a05600c365200b003fed1b97ea9mr14181339wmq.36.1696888739428;
        Mon, 09 Oct 2023 14:58:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17-20020a1cf211000000b00405623e0186sm14528337wmc.26.2023.10.09.14.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 14:58:59 -0700 (PDT)
Message-ID: <295ca94003bd0e25c0d4b733010e6474dd091e0e.1696888736.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <pull.1594.v2.git.1696888736.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 09 Oct 2023 21:58:55 +0000
Subject: [PATCH v2 3/4] dir.[ch]: add 'follow_symlink' arg to 'get_dtype'
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

