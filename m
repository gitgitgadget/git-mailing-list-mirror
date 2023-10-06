Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15E7E81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 18:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbjJFSJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjJFSJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 14:09:35 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63264C5
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 11:09:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3296b87aa13so699273f8f.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696615771; x=1697220571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iv1i8EjSJYpO2KpYpS3Fztg/+oxg0kh/zvWm6sZWwF8=;
        b=R34t9chTclhB/o2f+CnW0M2IVmAW2SEUftnvhncDI5YgZ0roPGi5bc8kI+CRRpcweK
         cvbKWdH0FDGnX6Rwb6JDeInrjyN7m7kaoDztWm8IJSV9MTXSPp4y5hORdjP1gRwiNlo4
         Y3EWoNapl+yx/ucsXvOtyOrkaxsr4bdwnMNRVTBRW8kAequlMOoU4ZbuYtEqacf2Ia1T
         y9rAUOj/RG6AcuFAlBgqtDJC4EbdQ1ZqXf6h4OjjqizoSJ4ARirZkxxHaczbLz11tJJC
         AK2Gu0Ym0902n3AD5R6Ec89T7FSgED/5RO0c9H9Bg+fw3V9jUMUxjs0HLJBt5QGwv8+i
         XQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696615771; x=1697220571;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iv1i8EjSJYpO2KpYpS3Fztg/+oxg0kh/zvWm6sZWwF8=;
        b=QP1FoUVTe4YC7NPto3SuiOXl/yBusF+3L80Z4wa4dv5V7dx/yv0Ut5uCNLqdaHTZ/i
         1JxaFqGQpHCM4DZJZ1HfNWOwePfjCcGAtZ1KFPOlcBVkI2HYiXXIv5v/qFJtIzm1csAj
         Q1h6UsGjJa859QNyvxF7afRux6uNKReDGiEQMDKaxhH/ZsDFSmqezuNp83HECGzXCuD1
         +iK3qeWh6pIkzboqBQ+OFVq13sTtJhZDATxScXBaKfErp9n+0U5OSz3TekYdCDkeWaFT
         kEvIcngxkko0uDLmtjU/2EPPR4Y57501zRXGv1/exfBO2Z0XevUWNAprFSFjNoRTCbY1
         qQNA==
X-Gm-Message-State: AOJu0YxdBQLN9zoxCC3FOVNTIu81g5LJRBosty2MDv095f/BXNr2Pj5/
        g+HlMV+cZx7zyK8g8ix7LjqYeiDiSHY=
X-Google-Smtp-Source: AGHT+IE3gyAUQS41ywWnQwZvMhYDDfSQh9HFEHwyaIUA7X27jh+HMaOhx4aRv9nxDmoAuBg96NAT4Q==
X-Received: by 2002:a5d:69d0:0:b0:31f:fa61:961d with SMTP id s16-20020a5d69d0000000b0031ffa61961dmr8819268wrw.63.1696615771374;
        Fri, 06 Oct 2023 11:09:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020adff0cb000000b00323293bd023sm2186506wro.6.2023.10.06.11.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:09:31 -0700 (PDT)
Message-ID: <24014010ea350a2ea8676b6560ca1d60838c56ef.1696615769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 18:09:27 +0000
Subject: [PATCH 2/4] dir.[ch]: expose 'get_dtype'
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

