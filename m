Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF5AC18E5B
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ADA20772
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOHIlUUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgDAERy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:17:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46559 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgDAERy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:17:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so28799184wru.13
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KOdFBrHGWNs2atkOc59kMAuhffvFz5pBGVjQsL0Jl2A=;
        b=fOHIlUUVKtQqMKWMX1BfVzK/7miVr+NZJzCyuwS4LKGNfAHTQbN0vtKDCGjDhxoCqd
         SgByIFhI75He/LomGGmJ1/2GtR49SZjwAAP7yaQOcPlkS/RY8Bfj6e8RLn+oMVq1Tsae
         e7PC1cYdavcd4p0PMhtFFnyTU+3Wu+W1bgyDPZj7pLrv5iE1XBnjRAfHFR8/ZAZRcXc4
         I8jiyUUXecS/tBUETx+9gK+1tPNLR6py5bngoXz9gsccKMZ5+Z9ozwgqXqRl/oKztXV2
         BgL7SEAr2liTPhI0B6w1ppX6tLdVxt7CTkWGE0cJjIg6b9kabheItLLmEp6Nbtimz4CA
         qJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KOdFBrHGWNs2atkOc59kMAuhffvFz5pBGVjQsL0Jl2A=;
        b=l9kUpH+pqd4OgReZC55QJCoQgjauBKTvK2S0KJUNa51dYKMyTXye2OkIrc1XMbR0Y5
         kMmfyR9poW3a7YoUGdxO3Bp1heEDbba6eW1Vp6vyrvl5V3X66UIZXbsDujl4Rf1Q4sOr
         unqAZ2sZkcJA3VWV+xXjjONNn3HJuWF3BvQynKJLnXzuTVAIB/nSpeaeiax8HJqxnlqT
         bZnhOSwN0SjcoeyKSsQVW7gaVenu6lfLetYl338PnjP+0+ln6rvBG04lFLWfBh8RqV8K
         kK+MjGuAidl+kxhAuAyc8n2vU6/OFgWJl6HMkSE+mxVc1s8+4236cSvUEPO9QG4IeVXd
         Ykrw==
X-Gm-Message-State: ANhLgQ3w4rhcdqFoGUiNJHonPRE8sWGXkBOnrJBJ3SQi+X4Zkx+0rEZC
        hWGAdncKriOcpzyn3JdPh3C9ynl9
X-Google-Smtp-Source: ADFU+vvYvpYqeTY7hcPTV24dKydAOzDsJx5IhdbKzv4/ws6wH+cgd5R6H6nPs3qSNoEsUmKOTfcwjw==
X-Received: by 2002:adf:90c6:: with SMTP id i64mr22755631wri.88.1585714671655;
        Tue, 31 Mar 2020 21:17:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm971123wmg.13.2020.03.31.21.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 21:17:51 -0700 (PDT)
Message-Id: <eeb38a25f3a14a3032d59ef9c0a60ac585177556.1585714667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
References: <pull.700.v4.git.git.1585258061.gitgitgadget@gmail.com>
        <pull.700.v5.git.git.1585714667.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 04:17:38 +0000
Subject: [PATCH v5 04/12] dir: consolidate treat_path() and treat_one_path()
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

