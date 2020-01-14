Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D745C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D411C24656
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB6xy3tz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgANQcR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:32:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36709 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANQcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 11:32:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so14492294wma.1
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SiIlIrKGF9b06z4Pt1FBkL0oNYGv2G3Eqh4bkmFHnEY=;
        b=AB6xy3tzruzQe5h6e8N036QlRLu9A8viUrD5FSugjvUPZM9ejPJUEk0fuiLn26pKKp
         Zxeaw0LCnn5apmN3ZqYDXtI7WNflvhTyR6grIwReweK8WefLP/MTjUiD/91A+Us4wT5H
         Ce1aDj7cawguzMqEwVBMmTq3DZWtf5/uOhNPyr7K7mO4+RItgbuaji26dLWXL3krgi+6
         c9/ukLFxpI70ODaRRyrZ8vh9Ckt7IAno0kSWAZ+cnuma4c7ScXJoG/HwHAeFlq18eVlp
         bPMAE7gItMIXTphaFS/uVnbseF8r/BZ/RD1gXTyw/VQkx8n8f00/5CXBjm12ISKqPS3W
         tMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SiIlIrKGF9b06z4Pt1FBkL0oNYGv2G3Eqh4bkmFHnEY=;
        b=oylGcdXQjeIhY6p8f/TTXg+EiiGl95Zk5uPA315AIcnYiYtRDy+VkkBvZU0P2CaQlM
         C/wcOJppU/e6HnkVKUaZ6WE42N3tnb3mfJzqkX1U8ZMqyn02fy98ZxXfYZgsit/KLQoS
         g8/gWmrM5vfO/bOAWgKASA7zB5rOAKfmeXpSNEj0VUc35VanGjUovpb01+AwNBi7OwnG
         ATkyctCf6oTPVKhWCO35IQRpJk6R7dGGCBo+/u9QpBVXlw1i0jP71PVDUxHPge29FGWO
         1TwiKZ18zcF3gHa96jUr3K6d1CzECyaerQ9/9FHfODhtIsSKok1Al451VKtezrrYoWG9
         NQhg==
X-Gm-Message-State: APjAAAWMLtj8T2UjcKVKmu9bi6wzqsckBcZBeUTX9f8vAB/lHXxVUJ22
        tU+fJG4VB74riDgiZxDYClEqOwKX
X-Google-Smtp-Source: APXvYqxpn9H6m0sJSWiP4RrIEmTK8aySfCgkS35MrmI43x7axlehyykAc7g6lRxv3pwa1mq5d+Fq/g==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr29375980wmo.147.1579019534283;
        Tue, 14 Jan 2020 08:32:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm21185655wru.44.2020.01.14.08.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:32:13 -0800 (PST)
Message-Id: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 16:32:12 +0000
Subject: [PATCH] dir: restructure in a way to avoid passing around a struct
 dirent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Restructure the code slightly to avoid passing around a struct dirent
anywhere, which also enables us to avoid trying to manufacture one.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    dir: restructure in a way to avoid passing around a struct dirent
    
    This is a follow up to en/fill-directory-fixes; a somewhat embarrassing
    one...
    
    When I was more than a bit burned out on dir.c in late December, I had
    looked at making another change to remove the need for a dirent but
    punted because it looked like "way too much work". Junio and Peff both
    later suggested the same cleanup, but I said it was too much work. Peff
    posted a patch which demonstrated that it was actually pretty simple[1],
    but I somehow read his email wrong and assumed he was commenting on my
    patch (if I had looked even slightly closer...). His patch was actually
    for before en/fill-directory-fixes was applied, so I have updated it
    slightly to apply after that series.
    
    I'm not sure if I'm supposed to add a Reviewed-by me or a Signed-off-by
    or both, but I read through it closely to avoid any hidden surprises. I
    probably could have saved Dscho some time last month if I would have
    just looked a little closer. Sorry about all that...
    
    (And yeah, we'll need Peff's Signed-off-by, since I'm leaving him as the
    author; I really only made a small tweak to update his patch.)
    
    CC: Jeff King peff@peff.net [peff@peff.net], Johannes Schindelin 
    Johannes.Schindelin@gmx.de [Johannes.Schindelin@gmx.de]
    
    [1] 
    https://lore.kernel.org/git/20191219222403.GA705525@coredump.intra.peff.net/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-692%2Fnewren%2Favoid-dirent-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-692/newren/avoid-dirent-v1
Pull-Request: https://github.com/git/git/pull/692

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
