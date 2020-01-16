Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D0AC33CB7
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3978F207E0
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAa3R3WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgAPUWG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44207 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbgAPUWC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so20496287wrm.11
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m0QkGRJwaBOHnq20njOP2P+5PTFGxFeHxLlQiMl5pyo=;
        b=hAa3R3WHmczwAjZHdmZnLSCiqpxOw3YV5+/h16Jc+90FvEqyAyUr7eeCP29/vMBgyk
         s3sRCoWOep3Fr7CMVNDSMz5Oewco1KsIOLGi8C1SU7TPJv+WF7bE/Z9q5P+nDGXY5lbT
         2d5tvrmXink5bzJnBhmvRChyp2TxIRaQX6E09hdDg/JDURQl3zm9UBlC6sbI5TIH8b/S
         ChvC+kWSKKuhGtgA1Ejo4YaGTO0spbXz+WcgCmsw/cFGTd3dEMX3bk+SstLaY4HUKB+F
         qREN/kFum/29twfY9eJ3sYK4l5x5lnQwSa2yik1QVDOc6XuKZ5ZZw2QwbyBO8DZXC/cF
         sa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m0QkGRJwaBOHnq20njOP2P+5PTFGxFeHxLlQiMl5pyo=;
        b=sA0UgfEB0JEWi9Hrbx5MfEPXmibSkB/7xtkCn3+qSpcg5moLmMYMYfuGzDiPiBHetv
         WIZy+jV/G8wUN1eBAVfY/cIqosoJXERAN/rsAdKAnu/diZXq6WMDkmAhPyvoS9r8iosd
         XdzM46hPFMZHgo0LVjdthEnJIyERIBGSzn74YhnPmLQJB4Hs9ZxjkDB4wKAyAievXJUW
         8XClLoQuBOIhxXkcWxdY8EEnc51aiTdDf5OdXx3PyII+ZN3iLoWvv4JBad3KD1pb4xTa
         N0JNAzuLbt9YjMurMoDKRUm6BLcs3fyhoGR9upZ5GmfxV924Fl63qU+/0Jv85XB3v8yp
         Vufg==
X-Gm-Message-State: APjAAAWiUNWs0TNT0w+FIy+Gan/hvoBmi9jji8DKiSLU8KAh2XJ/eXMJ
        dDX06f7cFi7AB5ZpdS7wmzUjffg1
X-Google-Smtp-Source: APXvYqy3fM+5iE3fTxwniB5sGA7AH0peHEEWlqVSmLT7MGdKnJ/Ae9aKCwe5Ft+h182aIp2JQpxlTQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr5132480wro.360.1579206120113;
        Thu, 16 Jan 2020 12:22:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r62sm7106223wma.32.2020.01.16.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:21:59 -0800 (PST)
Message-Id: <5b8fa6e5a74b7d27d815978572ed17940bfd1198.1579206117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
        <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
From:   "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 20:21:55 +0000
Subject: [PATCH v3 3/4] dir: restructure in a way to avoid passing around a
 struct dirent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Restructure the code slightly to avoid passing around a struct dirent
anywhere, which also enables us to avoid trying to manufacture one.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 73 +++++++++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/dir.c b/dir.c
index 5d4c92d3aa..8437030006 100644
--- a/dir.c
+++ b/dir.c
@@ -41,7 +41,8 @@ struct cached_dir {
 	int nr_files;
 	int nr_dirs;
 
-	struct dirent *de;
+	const char *d_name;
+	int d_type;
 	const char *file;
 	struct untracked_cache_dir *ucd;
 };
@@ -50,8 +51,8 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 	struct index_state *istate, const char *path, int len,
 	struct untracked_cache_dir *untracked,
 	int check_only, int stop_at_first_file, const struct pathspec *pathspec);
-static int get_dtype(struct dirent *de, struct index_state *istate,
-		     const char *path, int len);
+static int resolve_dtype(int dtype, struct index_state *istate,
+			 const char *path, int len);
 
 int count_slashes(const char *s)
 {
@@ -1215,8 +1216,7 @@ static struct path_pattern *last_matching_pattern_from_list(const char *pathname
 		int prefix = pattern->nowildcardlen;
 
 		if (pattern->flags & PATTERN_FLAG_MUSTBEDIR) {
-			if (*dtype == DT_UNKNOWN)
-				*dtype = get_dtype(NULL, istate, pathname, pathlen);
+			*dtype = resolve_dtype(*dtype, istate, pathname, pathlen);
 			if (*dtype != DT_DIR)
 				continue;
 		}
@@ -1842,10 +1842,9 @@ static int get_index_dtype(struct index_state *istate,
 	return DT_UNKNOWN;
 }
 
-static int get_dtype(struct dirent *de, struct index_state *istate,
-		     const char *path, int len)
+static int resolve_dtype(int dtype, struct index_state *istate,
+			 const char *path, int len)
 {
-	int dtype = de ? DTYPE(de) : DT_UNKNOWN;
 	struct stat st;
 
 	if (dtype != DT_UNKNOWN)
@@ -1870,14 +1869,13 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 					  struct strbuf *path,
 					  int baselen,
 					  const struct pathspec *pathspec,
-					  int dtype, struct dirent *de)
+					  int dtype)
 {
 	int exclude;
 	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
 	enum path_treatment path_treatment;
 
-	if (dtype == DT_UNKNOWN)
-		dtype = get_dtype(de, istate, path->buf, path->len);
+	dtype = resolve_dtype(dtype, istate, path->buf, path->len);
 
 	/* Always exclude indexed files */
 	if (dtype != DT_DIR && has_path_in_index)
@@ -1985,21 +1983,18 @@ static enum path_treatment treat_path(struct dir_struct *dir,
 				      int baselen,
 				      const struct pathspec *pathspec)
 {
-	int dtype;
-	struct dirent *de = cdir->de;
-
-	if (!de)
+	if (!cdir->d_name)
 		return treat_path_fast(dir, untracked, cdir, istate, path,
 				       baselen, pathspec);
-	if (is_dot_or_dotdot(de->d_name) || !fspathcmp(de->d_name, ".git"))
+	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
 		return path_none;
 	strbuf_setlen(path, baselen);
-	strbuf_addstr(path, de->d_name);
+	strbuf_addstr(path, cdir->d_name);
 	if (simplify_away(path->buf, path->len, pathspec))
 		return path_none;
 
-	dtype = DTYPE(de);
-	return treat_one_path(dir, untracked, istate, path, baselen, pathspec, dtype, de);
+	return treat_one_path(dir, untracked, istate, path, baselen, pathspec,
+			      cdir->d_type);
 }
 
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
@@ -2087,10 +2082,17 @@ static int open_cached_dir(struct cached_dir *cdir,
 
 static int read_cached_dir(struct cached_dir *cdir)
 {
+	struct dirent *de;
+
 	if (cdir->fdir) {
-		cdir->de = readdir(cdir->fdir);
-		if (!cdir->de)
+		de = readdir(cdir->fdir);
+		if (!de) {
+			cdir->d_name = NULL;
+			cdir->d_type = DT_UNKNOWN;
 			return -1;
+		}
+		cdir->d_name = de->d_name;
+		cdir->d_type = DTYPE(de);
 		return 0;
 	}
 	while (cdir->nr_dirs < cdir->untracked->dirs_nr) {
@@ -2216,7 +2218,7 @@ static enum path_treatment read_directory_recursive(struct dir_struct *dir,
 		/* recurse into subdir if instructed by treat_path */
 		if ((state == path_recurse) ||
 			((state == path_untracked) &&
-			 (get_dtype(cdir.de, istate, path.buf, path.len) == DT_DIR) &&
+			 (resolve_dtype(cdir.d_type, istate, path.buf, path.len) == DT_DIR) &&
 			 ((dir->flags & DIR_SHOW_IGNORED_TOO) ||
 			  (pathspec &&
 			   do_match_pathspec(istate, pathspec, path.buf, path.len,
@@ -2314,10 +2316,10 @@ static int treat_leading_path(struct dir_struct *dir,
 	 */
 
 	struct strbuf sb = STRBUF_INIT;
+	struct strbuf subdir = STRBUF_INIT;
 	int prevlen, baselen;
 	const char *cp;
 	struct cached_dir cdir;
-	struct dirent *de;
 	enum path_treatment state = path_none;
 
 	/*
@@ -2342,22 +2344,8 @@ static int treat_leading_path(struct dir_struct *dir,
 	if (!len)
 		return 1;
 
-	/*
-	 * We need a manufactured dirent with sufficient space to store a
-	 * leading directory component of path in its d_name.  Here, we
-	 * assume that the dirent's d_name is either declared as
-	 *    char d_name[BIG_ENOUGH]
-	 * or that it is declared at the end of the struct as
-	 *    char d_name[]
-	 * For either case, padding with len+1 bytes at the end will ensure
-	 * sufficient storage space.
-	 */
-	de = xcalloc(1, st_add3(sizeof(struct dirent), len, 1));
 	memset(&cdir, 0, sizeof(cdir));
-	cdir.de = de;
-#if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
-	de->d_type = DT_DIR;
-#endif
+	cdir.d_type = DT_DIR;
 	baselen = 0;
 	prevlen = 0;
 	while (1) {
@@ -2374,12 +2362,13 @@ static int treat_leading_path(struct dir_struct *dir,
 			break;
 		strbuf_reset(&sb);
 		strbuf_add(&sb, path, prevlen);
-		memcpy(de->d_name, path+prevlen, baselen-prevlen);
-		de->d_name[baselen-prevlen] = '\0';
+		strbuf_reset(&subdir);
+		strbuf_add(&subdir, path+prevlen, baselen-prevlen);
+		cdir.d_name = subdir.buf;
 		state = treat_path(dir, NULL, &cdir, istate, &sb, prevlen,
 				    pathspec);
 		if (state == path_untracked &&
-		    get_dtype(cdir.de, istate, sb.buf, sb.len) == DT_DIR &&
+		    resolve_dtype(cdir.d_type, istate, sb.buf, sb.len) == DT_DIR &&
 		    (dir->flags & DIR_SHOW_IGNORED_TOO ||
 		     do_match_pathspec(istate, pathspec, sb.buf, sb.len,
 				       baselen, NULL, DO_MATCH_LEADING_PATHSPEC) == MATCHED_RECURSIVELY_LEADING_PATHSPEC)) {
@@ -2403,7 +2392,7 @@ static int treat_leading_path(struct dir_struct *dir,
 					    &sb, baselen, pathspec,
 					    state);
 
-	free(de);
+	strbuf_release(&subdir);
 	strbuf_release(&sb);
 	return state == path_recurse;
 }
-- 
gitgitgadget

