Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC52FC33CB1
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 14:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702722084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvseY5JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAOOVX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:21:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52341 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOOVX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 09:21:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so34022wmc.2
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 06:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l/TorfeVEd2KK3jc5Sp4NCdwWewU/N3AU70euoh9f30=;
        b=rvseY5JNDu9TtYm2z6SfmPep/y6YYmQxEueGcV+ZhcHrKGDxWGLajBoFW+OgV1ARjf
         7qKf4LcJ+uluk/gGcYJpHAMqY7DQQ1ldxje2zBl/75uT/xdmmzLV5GVhPy14Hqao/5Rz
         lvt3urkdw7RaLjFhmFuc2sCQPi/HOq46jTqd1Ef+UtzMSaPqhiBGIMvgzBv6gX5YvhnM
         TaV71cYtt5puM9boReCve7gJvJ3dVR11A+x1MQQSuwaTIVMac3V40Kk4lGXBTkWbLuxV
         SnrEnfcSJPHvLZPOyYA+H0PRO5wF4SqXtWjahGh2XY9UxhThTbzo5W7BLQKoTE6caaUy
         uB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l/TorfeVEd2KK3jc5Sp4NCdwWewU/N3AU70euoh9f30=;
        b=cw/T0yBFFJbgDu9mdMlOjI8XFjMGGu1n7qTqqqW/861t5v++SzHyqCMLdhzQhew/yY
         PP35PwpE10t1MwGxi2PM8RIE9hFqNHYLnMZMBgsgVrssVFL9UJqVj6uAO8aQreja7Ar5
         CmW+MaXmZH2GMcWJCT4TCG8sZII4NiIrFYPfqODMc+/8K24DaAVRFTHwB7nDnORdGDQC
         q0XwJkOTAAhclkbYv5FrnSl+W4j6qCVsLnh8m6iV93+ZGfP2z7h94bgG9uhKK/eItPDY
         ar3RerJbyR4gSSEWbVkCcQWJnDRGf0plLZA5P7dAbkJFy8Gbl0qvPY++HL0kIudPRo9B
         D/RA==
X-Gm-Message-State: APjAAAXDpiME8vkqDKDvaAHlcwdu6CQzv6r/k07xvMZYxlucNriyzrSU
        2khhzmGd2ALJYoCvpn0Lbj7JqPhG
X-Google-Smtp-Source: APXvYqzAHs3qY4vB6MaPSGRkqm3yGRJK/f7l8A5semRzdCgh0aKpjXIdlEvXv74MxlqARtOv02SAlw==
X-Received: by 2002:a1c:44d5:: with SMTP id r204mr34713713wma.122.1579098079759;
        Wed, 15 Jan 2020 06:21:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 124sm24818992wmc.29.2020.01.15.06.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:21:19 -0800 (PST)
Message-Id: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 14:21:18 +0000
Subject: [PATCH v2] dir: restructure in a way to avoid passing around a struct
 dirent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
    dir: restructure in a way to avoid passing around a struct dirent
    
    This is a follow up to en/fill-directory-fixes, and consists of a small
    tweak made by me to a patch proposed by Peff[1] (signoff from [2]).
    
    [1] 
    https://lore.kernel.org/git/20191219222403.GA705525@coredump.intra.peff.net/
    [2] 
    https://lore.kernel.org/git/20200114220357.GA3957260@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-692%2Fnewren%2Favoid-dirent-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-692/newren/avoid-dirent-v2
Pull-Request: https://github.com/git/git/pull/692

Range-diff vs v1:

 1:  f63d591d3d ! 1:  edb18304b2 dir: restructure in a way to avoid passing around a struct dirent
     @@ -5,6 +5,7 @@
          Restructure the code slightly to avoid passing around a struct dirent
          anywhere, which also enables us to avoid trying to manufacture one.
      
     +    Signed-off-by: Jeff King <peff@peff.net>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       diff --git a/dir.c b/dir.c


 dir.c | 73 +++++++++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 42 deletions(-)

diff --git a/dir.c b/dir.c
index 7d255227b1..356d24bff8 100644
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
@@ -2399,7 +2388,7 @@ static int treat_leading_path(struct dir_struct *dir,
 					    &sb, baselen, pathspec,
 					    state);
 
-	free(de);
+	strbuf_release(&subdir);
 	strbuf_release(&sb);
 	return state == path_recurse;
 }

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
