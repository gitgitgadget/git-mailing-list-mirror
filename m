Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABA282F17
	for <git@vger.kernel.org>; Sat, 15 Aug 2026 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786799484; cv=none; b=V+uMwgJt0k5t6jLmyzut4uVlnBznxCr4n9odqturC1OXeOxBdTetnCqXW70u0CjF3kgZ/MbRBE5SUMhwdtdznz1456f0Zm47nQLg1kw9/9Ve0iCwRYGZyAdRivoKV21qH7hhFVnoj2EFzKOa6rNyzrpPLe49LxCr/ZIo62W1by8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786799484; c=relaxed/simple;
	bh=lEdwquUmuXTaq7bbA7rMu7VKau0ce85j8HicsjkTmiQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Mf/V4ifu2dNHvJJVzJ3ISlWGG0vFvshR6JuSwG1q9zx3JeYfLagzDhJMVxAYJn+dxlDWYwOFuRKzyKZdgdVctGboQDpfPW/vjtP0GWXn3EqAfeklqTzfS7PBGao0JtKfjlGsTN5oPz7iADSwI7ZpanmJR1D+j5kGJit49pfcCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et70UVie; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et70UVie"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e54f8c051so94988485a.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2026 06:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786799482; x=1787404282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3FczR1h/aamCKhH4ADc194Y4KFLalrfQpXuqWpXm9c4=;
        b=et70UVieEv+bMR3adaXN4p1zLaP38t7LUM/HvEwwABsheqr31b84Aqb1N3pl4ddS2h
         oiRlQxexgaH4paF6Sam9FoGL3bRHKJMnIX6El+Fq0Qo7js/W1Kz37JJtR9Z5WEUt9xvU
         uFHn7z16kFo27NCmg4ZER6JeBNj7YOsCn1UCUHZiZiEV+/0CLvuvLs28JyxEcWJooigQ
         H+XIM3JQXsSaDVIpGKOde2/uBwAEj/dK92fs9bgyi20yBagM7/h0RNFFc9ZJuTx3zBcv
         M1o3FO3DOoOGHd4mEeybgNJPeVUcdcmlHIv6zq813CK1m7TYTpva0hny9T2BSpy/wlgY
         3xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786799482; x=1787404282;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3FczR1h/aamCKhH4ADc194Y4KFLalrfQpXuqWpXm9c4=;
        b=QDZx+g3tYWgtp3enilnn6IYvPt7BSDJ8tbOp3h+YscYaSouWAordv4URHBV0S7Pw+O
         NcdX2/bMFfISh8VNbBCGjDmmAmQbedfTAHhGygyPLdQCaaq1FIeC0j+u/MN1JFW15i+R
         6h6q/4BHR0Ps+CZnvpRuXUvtbCO0+XSTKjaV5/5YX+bbB5lMFrHhC72Q5a5e3FcuHB9Y
         UUgY7+UQnPO0Cj/QmsqAD0KYiUsFgtQnAqAp8X/ko2sFIgKKJkqhw+Jq11zdAIXCo+X4
         uRjU12eag8b8zL2jbSBRb93G8QsffQmunF3qADXv8EL66UkkCoRCb/ZRG5eXQYPcCVbY
         peDQ==
X-Gm-Message-State: AOJu0YzUy06MNug086LC33WAqUe8l2rMHa7p9lStYdUIO3hfetSHQ3ik
	74rsIpgzK0Blj+jJf7qA6iOR+lf9jXRIP7+W41dNfK10pi5QjP65aqU+jnaa+w==
X-Gm-Gg: AR+sD10CBEmgdgbNlN1h5eM3wayBFrVCCtF5KYbGhqm20Rbe0iWuoxscnqw1rKUhsbV
	7MlJd+7qxaKj/1pNuKMvfazMsvG8E9F822w67sqW6ikdhGJU3xqeEvmWi0PxHJB/wIG+BF+w4W8
	ba1Ck/uTEXgEOt40ml2OBmFHVnp/sIvpszdeNNKr8IPrvs1BT/NMPpjFlbVypWUtYyFcIIfdphG
	vDAnSqirIXwNho7jJBXQHDi5+LkldUdNy54DI5nKzj9VaHcouqtuH43dUnlaIey6WW4THyO8FXW
	BbioXPQ3G0LCXrTPuA5nvSkiSrwjQG7uwdCl4KqENiXIA5SKO0G7CssabY1AbF9ffERD/PIfPLu
	2Tby/czhd1845wEASNyb2DQ6DVJ8t9qyUXx9dbVevegmdW3zK+8kIQuuULqaE96uxi8s5Z35QBz
	1F1yaL/ilY85tolu8BtSLyxDZV6KbAw4b85JFS4tpFfEIRjOt0DFhLWF8yCnu9HEKu
X-Received: by 2002:a05:620a:1996:b0:915:9e84:85d1 with SMTP id af79cd13be357-936d2363fc6mr1224861085a.23.1786799481720;
        Sat, 15 Aug 2026 06:11:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.211])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936ce2189c1sm530564285a.33.2026.08.15.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 06:11:21 -0700 (PDT)
Message-Id: <pull.2205.git.1786799480344.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 15 Aug 2026 13:11:19 +0000
Subject: [PATCH] worktree repair: detect relative path in .git file correctly
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Since read_gitfile_gently() always returns an absolute path, the
conversion from a relative path to an absolute path was not
functioning and dead code existed.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree repair: detect relative path in .git file correctly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2205%2Fyoichi%2Fworktree-repair-relative-path-handling-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2205/yoichi/worktree-repair-relative-path-handling-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2205

 builtin/init-db.c          |  2 +-
 setup.c                    | 13 ++++++---
 setup.h                    |  4 +--
 t/t2406-worktree-repair.sh | 54 +++++++++++++++++++++++++++++---------
 worktree.c                 | 28 ++++++--------------
 5 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index e96b1283b7..2369fcea1b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -210,7 +210,7 @@ int cmd_init_db(int argc,
 		const char *p;
 		struct strbuf sb = STRBUF_INIT;
 
-		p = read_gitfile_gently(git_dir, &err);
+		p = read_gitfile_gently(git_dir, NULL, &err);
 		if (p && get_common_dir(&sb, p)) {
 			struct strbuf mainwt = STRBUF_INIT;
 
diff --git a/setup.c b/setup.c
index 95909e9603..febb3248a5 100644
--- a/setup.c
+++ b/setup.c
@@ -458,7 +458,7 @@ int is_nonbare_repository_dir(struct strbuf *path)
 	assert(orig_path_len != 0);
 	strbuf_complete(path, '/');
 	strbuf_addstr(path, ".git");
-	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
+	if (read_gitfile_gently(path->buf, NULL, &gitfile_error) || is_git_directory(path->buf))
 		ret = 1;
 	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
 	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
@@ -956,12 +956,15 @@ void read_gitfile_error_die(int error_code, const char *path)
  * return path to git directory if found. The return value comes from
  * a shared buffer.
  *
+ * On success, if absolute is not NULL, it will be set to whether the
+ * path in .git file is an absolute path.
+ *
  * On failure, if return_error_code is not NULL, return_error_code
  * will be set to an error code and NULL will be returned. If
  * return_error_code is NULL the function will die instead (for most
  * cases).
  */
-const char *read_gitfile_gently(const char *path, int *return_error_code)
+const char *read_gitfile_gently(const char *path, bool *absolute, int *return_error_code)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
@@ -1016,6 +1019,8 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	}
 	buf[len] = '\0';
 	dir = buf + 8;
+	if (absolute)
+		*absolute = is_absolute_path(dir);
 
 	if (!is_absolute_path(dir) && (slash = strrchr(path, '/'))) {
 		size_t pathlen = slash+1 - path;
@@ -1615,7 +1620,7 @@ static enum discovery_result repo_discovery_find_dir(struct strbuf *dir,
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
-		gitdirenv = read_gitfile_gently(dir->buf, &error_code);
+		gitdirenv = read_gitfile_gently(dir->buf, NULL, &error_code);
 		if (!gitdirenv) {
 			switch (error_code) {
 			case READ_GITFILE_ERR_MISSING:
@@ -2185,7 +2190,7 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
 {
 	if (is_git_directory(suspect))
 		return suspect;
-	return read_gitfile_gently(suspect, return_error_code);
+	return read_gitfile_gently(suspect, NULL, return_error_code);
 }
 
 /* if any standard file descriptor is missing open it to /dev/null */
diff --git a/setup.h b/setup.h
index 654f10e059..018893b1d7 100644
--- a/setup.h
+++ b/setup.h
@@ -39,8 +39,8 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_MISSING 9
 #define READ_GITFILE_ERR_IS_A_DIR 10
 void read_gitfile_error_die(int error_code, const char *path);
-const char *read_gitfile_gently(const char *path, int *return_error_code);
-#define read_gitfile(path) read_gitfile_gently((path), NULL)
+const char *read_gitfile_gently(const char *path, bool *absolute, int *return_error_code);
+#define read_gitfile(path) read_gitfile_gently((path), NULL, NULL)
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
 
diff --git a/t/t2406-worktree-repair.sh b/t/t2406-worktree-repair.sh
index f5f19b3169..5f241c9878 100755
--- a/t/t2406-worktree-repair.sh
+++ b/t/t2406-worktree-repair.sh
@@ -228,30 +228,60 @@ test_expect_success 'repair worktree with relative path with missing gitfile' '
 	test_cmp expect wt/.git
 '
 
-test_expect_success 'repair absolute worktree to use relative paths' '
-	test_when_finished "rm -rf main side sidemoved" &&
+test_expect_success 'repair absolute to relative in side worktree' '
+	test_when_finished "rm -rf main side" &&
 	test_create_repo main &&
 	test_commit -C main init &&
 	git -C main worktree add --detach ../side &&
-	echo "../../../../sidemoved/.git" >expect-gitdir &&
+	echo "../../../../side/.git" >expect-gitdir &&
 	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
-	mv side sidemoved &&
-	git -C main worktree repair --relative-paths ../sidemoved &&
+	git -C side worktree repair --relative-paths 2>main/err &&
+	test_grep "gitdir absolute/relative path mismatch" main/err &&
 	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
-	test_cmp expect-gitfile sidemoved/.git
+	test_cmp expect-gitfile side/.git
 '
 
-test_expect_success 'repair relative worktree to use absolute paths' '
-	test_when_finished "rm -rf main side sidemoved" &&
+test_expect_success 'repair relative to absolute in side worktree' '
+	test_when_finished "rm -rf main side" &&
 	test_create_repo main &&
 	test_commit -C main init &&
 	git -C main worktree add --relative-paths --detach ../side &&
-	echo "$(pwd)/sidemoved/.git" >expect-gitdir &&
+	echo "$(pwd)/side/.git" >expect-gitdir &&
 	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
-	mv side sidemoved &&
-	git -C main worktree repair ../sidemoved &&
+	git -C side worktree repair 2>main/err &&
+	test_grep "gitdir absolute/relative path mismatch" main/err &&
 	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
-	test_cmp expect-gitfile sidemoved/.git
+	test_cmp expect-gitfile side/.git
+'
+
+test_expect_success 'repair absolute to relative in main worktree' '
+	test_when_finished "rm -rf main side" &&
+	test_create_repo main &&
+	git -C main config worktree.useRelativePaths false &&
+	test_commit -C main init &&
+	git -C main worktree add --detach ../side &&
+	echo "../../../../side/.git" >expect-gitdir &&
+	echo "gitdir: ../main/.git/worktrees/side" >expect-gitfile &&
+	git -C main config worktree.useRelativePaths true &&
+	git -C main worktree repair 2>main/err &&
+	test_grep ".git file absolute/relative path mismatch" main/err &&
+	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile side/.git
+'
+
+test_expect_success 'repair relative to absolute in main worktree' '
+	test_when_finished "rm -rf main side" &&
+	test_create_repo main &&
+	git -C main config worktree.useRelativePaths true &&
+	test_commit -C main init &&
+	git -C main worktree add --detach ../side &&
+	echo "$(pwd)/side/.git" >expect-gitdir &&
+	echo "gitdir: $(pwd)/main/.git/worktrees/side" >expect-gitfile &&
+	git -C main config worktree.useRelativePaths false &&
+	git -C main worktree repair 2>main/err &&
+	test_grep ".git file absolute/relative path mismatch" main/err &&
+	test_cmp expect-gitdir main/.git/worktrees/side/gitdir &&
+	test_cmp expect-gitfile side/.git
 '
 
 test_done
diff --git a/worktree.c b/worktree.c
index cbf95328a3..86b599ed27 100644
--- a/worktree.c
+++ b/worktree.c
@@ -409,7 +409,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));
+	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, NULL, &err));
 	if (!path) {
 		strbuf_addf_gently(errmsg, _("'%s' is not a .git file, error code %d"),
 				   wt_path.buf, err);
@@ -650,6 +650,7 @@ static void repair_gitfile(struct worktree *wt,
 	struct strbuf repo = STRBUF_INIT;
 	struct strbuf backlink = STRBUF_INIT;
 	char *dotgit_contents = NULL;
+	bool absolute;
 	const char *repair = NULL;
 	char *path = NULL;
 	int err;
@@ -667,16 +668,10 @@ static void repair_gitfile(struct worktree *wt,
 	strbuf_realpath(&repo, path, 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
 	strbuf_addf(&gitdir, "%s/gitdir", repo.buf);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &absolute, &err));
 
-	if (dotgit_contents) {
-		if (is_absolute_path(dotgit_contents)) {
-			strbuf_addstr(&backlink, dotgit_contents);
-		} else {
-			strbuf_addf(&backlink, "%s/%s", wt->path, dotgit_contents);
-			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
-		}
-	}
+	if (dotgit_contents)
+		strbuf_addstr(&backlink, dotgit_contents);
 
 	if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 		err == READ_GITFILE_ERR_IS_A_DIR)
@@ -685,7 +680,7 @@ static void repair_gitfile(struct worktree *wt,
 		repair = _(".git file broken");
 	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
-	else if (use_relative_paths == is_absolute_path(dotgit_contents))
+	else if (use_relative_paths == absolute)
 		repair = _(".git file absolute/relative path mismatch");
 
 	if (repair) {
@@ -855,16 +850,9 @@ void repair_worktree_at_path(struct repository *repo,
 
 	infer_backlink(repo, dotgit.buf, &inferred_backlink);
 	strbuf_realpath_forgiving(&inferred_backlink, inferred_backlink.buf, 0);
-	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	dotgit_contents = xstrdup_or_null(read_gitfile_gently(dotgit.buf, NULL, &err));
 	if (dotgit_contents) {
-		if (is_absolute_path(dotgit_contents)) {
-			strbuf_addstr(&backlink, dotgit_contents);
-		} else {
-			strbuf_addbuf(&backlink, &dotgit);
-			strbuf_strip_suffix(&backlink, ".git");
-			strbuf_addstr(&backlink, dotgit_contents);
-			strbuf_realpath_forgiving(&backlink, backlink.buf, 0);
-		}
+		strbuf_addstr(&backlink, dotgit_contents);
 	} else if (err == READ_GITFILE_ERR_NOT_A_FILE ||
 			err == READ_GITFILE_ERR_IS_A_DIR) {
 		fn(1, dotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);

base-commit: 11c6700f10234578d10523faf35656ca491425c9
-- 
gitgitgadget
