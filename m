Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B963AC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8522320714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 21:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4ycirxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZV1t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:27:49 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42375 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgCZV1s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 17:27:48 -0400
Received: by mail-ed1-f65.google.com with SMTP id cw6so7980660edb.9
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KOdFBrHGWNs2atkOc59kMAuhffvFz5pBGVjQsL0Jl2A=;
        b=P4ycirxkoqWM5hWmcHHnLNzc14Ume7oE+KJtwmy6g/egqnmDWqStIpdKPIE4hhePh3
         gJH64EPWTcX6tlrhAXGdSqFeLSGvm6JqU07mrCEGMdabu0mQkgnfEkGxsCLVb8lG5BJP
         AF8r2oa7M1PxUg0vJHnghS8SrbxJaIS8fysycUrczvnU+C4TiucdKaPFXhctb70LASYZ
         cY1KJjIYxPdp6tVJ1wRbPp0vci1uexC1uncE+Xvx79cTo2QryG55U3zCQx8tjr1S1U5w
         yPH+6SRQ/KnxmA6j1dRydHA40zXLK4Q4q2/GO2J4XMlis905UQ6kdZaQGO16CHatSN1l
         aKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KOdFBrHGWNs2atkOc59kMAuhffvFz5pBGVjQsL0Jl2A=;
        b=UmdqMy41vb3CWJ7e7B3llNYAzKL3OJcjj78Q8BK4Qyyb2kVuE8G0x9qQrpF8S+53u6
         vUU2GDGPN06sgsfuv72uR0cHtRrkoJd5nuifNtCUTsabZKibXaje55EzZJ92cEEzr/8n
         54j24NCHhgRg6soTen8FD0iTKlyeuSL79b9ZTmtJLBimN8oxhV0Y7Rlmvbo6erxsmaho
         CNlK50dZj/p3DntfLrEVOa0r+W5Kksu9n0xkQubVlaBjTuz0J2Vg5gWevDQ6a+PL9WOy
         Io0ZnC9rPJcOrMRe5GcnOI26GfGyk5TQ4l1L4ox8whkSRMJ//7RUCSJOIv1iFIAYs89B
         4Sfw==
X-Gm-Message-State: ANhLgQ3ZbuAUrMq334BxHjVk9nA/XjneOriLXrCTclwNG7If4g7t++i9
        AfBFaRHfIRsTbUXkWEb8xoQIjsZR
X-Google-Smtp-Source: ADFU+vuZoTO8SDtRnGIixmvOsXJMsGnkwN7FtuzlxdQk61m7XyXCCpRd2AvT1dhOMHvbYGZlQUQ0CQ==
X-Received: by 2002:a17:906:aac3:: with SMTP id kt3mr9410847ejb.16.1585258065040;
        Thu, 26 Mar 2020 14:27:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p4sm445319eju.57.2020.03.26.14.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:27:44 -0700 (PDT)
Message-Id: <48f37e5b11476d2b59dcd7496b44c6a862311f57.1585258061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
References: <pull.700.v3.git.git.1585164718.gitgitgadget@gmail.com>
        <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 Mar 2020 21:27:36 +0000
Subject: [PATCH v4 3/7] dir: consolidate treat_path() and treat_one_path()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Martin Melka <martin.melka@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 16e2cfa90993 ("read_directory(): further split treat_path()",
2010-01-08) split treat_one_path() out of treat_path(), because
treat_leading_path() would not have access to a dirent but wanted to
re-use as much of treat_path() as possible.  Not re-using all of
treat_path() caused other bugs, as noted in commit b9670c1f5e6b ("dir:
fix checks on common prefix directory", 2019-12-19).  Finally, in commit
ad6f2157f951 ("dir: restructure in a way to avoid passing around a
struct dirent", 2020-01-16), dirents were removed from treat_path() and
other functions entirely.

Since the only reason for splitting these functions was the lack of a
dirent -- which no longer applies to either function -- and since the
split caused problems in the past resulting in us not using
treat_one_path() separately anymore, just undo the split.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 121 ++++++++++++++++++++++++++--------------------------------
 1 file changed, 55 insertions(+), 66 deletions(-)

diff --git a/dir.c b/dir.c
index b505ba747bb..d0f3d660850 100644
--- a/dir.c
+++ b/dir.c
@@ -1863,21 +1863,65 @@ static int resolve_dtype(int dtype, struct index_state *istate,
 	return dtype;
 }
 
-static enum path_treatment treat_one_path(struct dir_struct *dir,
-					  struct untracked_cache_dir *untracked,
-					  struct index_state *istate,
-					  struct strbuf *path,
-					  int baselen,
-					  const struct pathspec *pathspec,
-					  int dtype)
-{
-	int exclude;
-	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
+static enum path_treatment treat_path_fast(struct dir_struct *dir,
+					   struct untracked_cache_dir *untracked,
+					   struct cached_dir *cdir,
+					   struct index_state *istate,
+					   struct strbuf *path,
+					   int baselen,
+					   const struct pathspec *pathspec)
+{
+	strbuf_setlen(path, baselen);
+	if (!cdir->ucd) {
+		strbuf_addstr(path, cdir->file);
+		return path_untracked;
+	}
+	strbuf_addstr(path, cdir->ucd->name);
+	/* treat_one_path() does this before it calls treat_directory() */
+	strbuf_complete(path, '/');
+	if (cdir->ucd->check_only)
+		/*
+		 * check_only is set as a result of treat_directory() getting
+		 * to its bottom. Verify again the same set of directories
+		 * with check_only set.
+		 */
+		return read_directory_recursive(dir, istate, path->buf, path->len,
+						cdir->ucd, 1, 0, pathspec);
+	/*
+	 * We get path_recurse in the first run when
+	 * directory_exists_in_index() returns index_nonexistent. We
+	 * are sure that new changes in the index does not impact the
+	 * outcome. Return now.
+	 */
+	return path_recurse;
+}
+
+static enum path_treatment treat_path(struct dir_struct *dir,
+				      struct untracked_cache_dir *untracked,
+				      struct cached_dir *cdir,
+				      struct index_state *istate,
+				      struct strbuf *path,
+				      int baselen,
+				      const struct pathspec *pathspec)
+{
+	int has_path_in_index, dtype, exclude;
 	enum path_treatment path_treatment;
 
-	dtype = resolve_dtype(dtype, istate, path->buf, path->len);
+	if (!cdir->d_name)
+		return treat_path_fast(dir, untracked, cdir, istate, path,
+				       baselen, pathspec);
+	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
+		return path_none;
+	strbuf_setlen(path, baselen);
+	strbuf_addstr(path, cdir->d_name);
+	if (simplify_away(path->buf, path->len, pathspec))
+		return path_none;
+
+	dtype = resolve_dtype(cdir->d_type, istate, path->buf, path->len);
 
 	/* Always exclude indexed files */
+	has_path_in_index = !!index_file_exists(istate, path->buf, path->len,
+						ignore_case);
 	if (dtype != DT_DIR && has_path_in_index)
 		return path_none;
 
@@ -1942,61 +1986,6 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 	}
 }
 
-static enum path_treatment treat_path_fast(struct dir_struct *dir,
-					   struct untracked_cache_dir *untracked,
-					   struct cached_dir *cdir,
-					   struct index_state *istate,
-					   struct strbuf *path,
-					   int baselen,
-					   const struct pathspec *pathspec)
-{
-	strbuf_setlen(path, baselen);
-	if (!cdir->ucd) {
-		strbuf_addstr(path, cdir->file);
-		return path_untracked;
-	}
-	strbuf_addstr(path, cdir->ucd->name);
-	/* treat_one_path() does this before it calls treat_directory() */
-	strbuf_complete(path, '/');
-	if (cdir->ucd->check_only)
-		/*
-		 * check_only is set as a result of treat_directory() getting
-		 * to its bottom. Verify again the same set of directories
-		 * with check_only set.
-		 */
-		return read_directory_recursive(dir, istate, path->buf, path->len,
-						cdir->ucd, 1, 0, pathspec);
-	/*
-	 * We get path_recurse in the first run when
-	 * directory_exists_in_index() returns index_nonexistent. We
-	 * are sure that new changes in the index does not impact the
-	 * outcome. Return now.
-	 */
-	return path_recurse;
-}
-
-static enum path_treatment treat_path(struct dir_struct *dir,
-				      struct untracked_cache_dir *untracked,
-				      struct cached_dir *cdir,
-				      struct index_state *istate,
-				      struct strbuf *path,
-				      int baselen,
-				      const struct pathspec *pathspec)
-{
-	if (!cdir->d_name)
-		return treat_path_fast(dir, untracked, cdir, istate, path,
-				       baselen, pathspec);
-	if (is_dot_or_dotdot(cdir->d_name) || !fspathcmp(cdir->d_name, ".git"))
-		return path_none;
-	strbuf_setlen(path, baselen);
-	strbuf_addstr(path, cdir->d_name);
-	if (simplify_away(path->buf, path->len, pathspec))
-		return path_none;
-
-	return treat_one_path(dir, untracked, istate, path, baselen, pathspec,
-			      cdir->d_type);
-}
-
 static void add_untracked(struct untracked_cache_dir *dir, const char *name)
 {
 	if (!dir)
-- 
gitgitgadget

