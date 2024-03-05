Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D32812B71
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601750; cv=none; b=kedOyXOJXoHSQeZFNNfOgI4KWcgxq1eDDN+Rh5LtzZ6uaLXOFcMI8iI6FGnVhyA2Wi7B1SPf0UQFrLqhnI0cAPYek1qXg/b2FFP6RmdkW94jZVvAsixdmZ/w0XxvO8b+Y54Fs1tgAfv0rT37Azn6eG4Oz7isAgEeA3CCDvCvZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601750; c=relaxed/simple;
	bh=3c2ZLP4ElaTIWQ1MwsygQRdMHcyYe/0LHge4IZg7Xzk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udLC72xa+t/0iFBjwuAj4AOtA7Y+r/l9YbLaMdhivWCkWZ2Lxfc+5NVfmble/mWcQvC0dDAHa2vLnP3A5KRLTpi1BkuaD+lTBbiN2Qpd98+wu//o8mN8HE6n8kbGQJeHg82FDMsFwkd4e7zHJYK1f2JyRp2zESqKnU2BcVWNMt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYrZneq5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYrZneq5"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60987370f06so40320057b3.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709601747; x=1710206547; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1iKt0S10KykeU5net5hBhrTTpSl/3gXUvECXqShjT8=;
        b=uYrZneq5wfwWBhYypxcnyyu6xPZcFGO9vJSuvPhlEadoZC/D7OgkxX+nSzM4yTt3DX
         yU6GVILRxD2BX47h61+pKQMQsp9JZQaOyuHqM267tMpS8knI19nSzRW250jiUYayx/dw
         U6jMId75XdK/XpKbCanxEKWpnshC8NMwrg4P3ZvWoaISrI6jelePEvKfu8BHJTnDUl6j
         v9BvslSRUADjlJ9TlX3pYxVKO/jqSqV7sPlZD0Nt3BaTtqOOJquV/HQgJKdlmaHOdalf
         gGzrpx+Qta1hRgClK7opjwgtAAZoKvvELL3a0s/bOXs2sQtrl4+g2gB48C08jyGLLAP8
         ZSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601747; x=1710206547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1iKt0S10KykeU5net5hBhrTTpSl/3gXUvECXqShjT8=;
        b=h0H2OrCjxElWKpgIWOdOPla6pk+6L8VomwkzoAqcHC5RPUaHIxFYTE+QK9pvQgZ2IH
         JVAjiw6MisRqWsai+/TSM99LvMFVzuCTFPl9nn90Oji8qBiOAAK3+at6kGK+5zz7mrzO
         yT/L0qI8x0Wyp6SOlPsoQDX+Ls34Ch7il4xwAjYfAR/TicKaOjbOoebqavx8ZVz2afWj
         aIfakIYwV8PovsV4qfD55PLj+KNaXg4ZTsaTu8a6MSFtxladwqKy8cHo28DTiQ9cM1lh
         5vNLgzeihsQTyWyxXtqjrNyb+cf35A6miOFpqxkuC4g+56GiBG3cJQ0a/BIesnRRzn7/
         wd7A==
X-Gm-Message-State: AOJu0Yy52pRQ03zKysEieHjCkegclZWQkwVb0vBKBByFiFFnRpV3+wyv
	mTesGCUoP+a4Hl96cF4/MmkGd7BhQkVt9YUV9wDlyqkCVgeNr/vv8SdObLlB45ySL9vjKIjWSDt
	PX4B/Y3/J31Y0Dd2OgrDvbG6RYDzAThRGkQp3ePl/Cb/3nY2GSietDdSDTZ2nCPJVUCtfcybnNO
	wrJThzjunmnK2jAAFWTDnSo4yA0F2F
X-Google-Smtp-Source: AGHT+IHpJWsnObp1bmiCcGCqpFhXm6cSqGmTUUJEU5wTdWf7yhnoQyv4pLG0o6XzVB8bt1+mCfgVJOyoGxg=
X-Received: from capy.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:151e])
 (user=atneya job=sendgmr) by 2002:a05:690c:3387:b0:608:d499:3439 with SMTP id
 fl7-20020a05690c338700b00608d4993439mr2260950ywb.7.1709601746938; Mon, 04 Mar
 2024 17:22:26 -0800 (PST)
Date: Mon,  4 Mar 2024 17:21:11 -0800
In-Reply-To: <20240305012112.1598053-2-atneya@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305012112.1598053-3-atneya@google.com>
Subject: [RFC PATCH 1/3] Make read_gitfile and resolve_gitfile thread safe
From: Atneya Nair <atneya@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com, Atneya Nair <atneya@google.com>
Content-Type: text/plain; charset="UTF-8"

Continue the work in commit: 3d7747e318532a36a263c61cdf92f2decb6424ff
to remove unsafe shared buffer usage in read_gitfile_gently.

Migrate read_gitfile_gently and resolve_gitfile_gently to take strbuf
out params to allocate their return values into, rather than returning
a view into a shared buffer.

Leave the shared buffer in case a caller passes null for this param (for
cases we haven't cleaned up yet).

Migrate callers of resolve_gitfile to resolve_gitfile_gently.

Signed-off-by: Atneya Nair <atneya@google.com>
---

Notes:
    Open questions:
     - Is checking the return value of read_gitfile necessary if on error,
       we are supposed to die, or set the error field to a non-zero value?
     - Should we clean up the other call-sites of read_gitfile?

 builtin/init-db.c   |  7 ++++---
 builtin/rev-parse.c |  4 +++-
 repository.c        |  9 +++++----
 setup.c             | 36 +++++++++++++++++++++++++-----------
 setup.h             |  7 +++----
 submodule.c         | 32 +++++++++++++++++++++++---------
 worktree.c          | 27 +++++++++++++--------------
 7 files changed, 76 insertions(+), 46 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0170469b84..9135d07a0d 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -198,11 +198,11 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	 */
 	if (real_git_dir) {
 		int err;
-		const char *p;
 		struct strbuf sb = STRBUF_INIT;
+		struct strbuf gitfile = STRBUF_INIT;
 
-		p = read_gitfile_gently(git_dir, &err);
-		if (p && get_common_dir(&sb, p)) {
+		read_gitfile_gently(git_dir, &err, &gitfile);
+		if (!err && get_common_dir(&sb, gitfile.buf)) {
 			struct strbuf mainwt = STRBUF_INIT;
 
 			strbuf_addbuf(&mainwt, &sb);
@@ -213,6 +213,7 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 			git_dir = strbuf_detach(&sb, NULL);
 		}
 		strbuf_release(&sb);
+		strbuf_release(&gitfile);
 	}
 
 	if (is_bare_repository_cfg < 0)
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index d08987646a..e1db6b3231 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -728,12 +728,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			if (!strcmp(arg, "--resolve-git-dir")) {
 				const char *gitdir = argv[++i];
+				struct strbuf resolved_gitdir = STRBUF_INIT;
 				if (!gitdir)
 					die(_("--resolve-git-dir requires an argument"));
-				gitdir = resolve_gitdir(gitdir);
+				gitdir = resolve_gitdir_gently(gitdir, NULL, &resolved_gitdir);
 				if (!gitdir)
 					die(_("not a gitdir '%s'"), argv[i]);
 				puts(gitdir);
+				strbuf_release(&resolved_gitdir);
 				continue;
 			}
 		}
diff --git a/repository.c b/repository.c
index 7aacb51b65..3ca6dbcf16 100644
--- a/repository.c
+++ b/repository.c
@@ -118,7 +118,7 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	int ret = 0;
 	int error = 0;
 	char *abspath = NULL;
-	const char *resolved_gitdir;
+	struct strbuf resolved_gitdir = STRBUF_INIT;
 	struct set_gitdir_args args = { NULL };
 
 	abspath = real_pathdup(gitdir, 0);
@@ -128,15 +128,16 @@ static int repo_init_gitdir(struct repository *repo, const char *gitdir)
 	}
 
 	/* 'gitdir' must reference the gitdir directly */
-	resolved_gitdir = resolve_gitdir_gently(abspath, &error);
-	if (!resolved_gitdir) {
+	resolve_gitdir_gently(abspath, &error, &resolved_gitdir);
+	if (error) {
 		ret = -1;
 		goto out;
 	}
 
-	repo_set_gitdir(repo, resolved_gitdir, &args);
+	repo_set_gitdir(repo, resolved_gitdir.buf, &args);
 
 out:
+	strbuf_release(&resolved_gitdir);
 	free(abspath);
 	return ret;
 }
diff --git a/setup.c b/setup.c
index b69b1cbc2a..2e118cf216 100644
--- a/setup.c
+++ b/setup.c
@@ -397,14 +397,17 @@ int is_nonbare_repository_dir(struct strbuf *path)
 	int ret = 0;
 	int gitfile_error;
 	size_t orig_path_len = path->len;
+	struct strbuf gitfile = STRBUF_INIT;
+
 	assert(orig_path_len != 0);
 	strbuf_complete(path, '/');
 	strbuf_addstr(path, ".git");
-	if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
+	if (read_gitfile_gently(path->buf, &gitfile_error, &gitfile) || is_git_directory(path->buf))
 		ret = 1;
 	if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
 	    gitfile_error == READ_GITFILE_ERR_READ_FAILED)
 		ret = 1;
+	strbuf_release(&gitfile);
 	strbuf_setlen(path, orig_path_len);
 	return ret;
 }
@@ -830,7 +833,8 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
 
 /*
  * Try to read the location of the git directory from the .git file,
- * return path to git directory if found. The return value comes from
+ * return path to git directory if found. If passed a valid strbuf, the return
+ * value is is a ptr to within the buffer. If strbuf is null, the return value comes from
  * a shared buffer.
  *
  * On failure, if return_error_code is not NULL, return_error_code
@@ -838,7 +842,7 @@ void read_gitfile_error_die(int error_code, const char *path, const char *dir)
  * return_error_code is NULL the function will die instead (for most
  * cases).
  */
-const char *read_gitfile_gently(const char *path, int *return_error_code)
+const char *read_gitfile_gently(const char *path, int *return_error_code, struct strbuf* result_buf)
 {
 	const int max_file_size = 1 << 20;  /* 1MB */
 	int error_code = 0;
@@ -848,7 +852,10 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	struct stat st;
 	int fd;
 	ssize_t len;
-	static struct strbuf realpath = STRBUF_INIT;
+	static struct strbuf shared = STRBUF_INIT;
+	if (!result_buf) {
+		result_buf = &shared;
+	}
 
 	if (stat(path, &st)) {
 		/* NEEDSWORK: discern between ENOENT vs other errors */
@@ -900,8 +907,10 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 		goto cleanup_return;
 	}
 
-	strbuf_realpath(&realpath, dir, 1);
-	path = realpath.buf;
+	strbuf_realpath(result_buf, dir, 1);
+	path = result_buf->buf;
+	// TODO is this valid?
+	if (!path) die(_("Unexpected null from realpath '%s'"), dir);
 
 cleanup_return:
 	if (return_error_code)
@@ -1316,12 +1325,13 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 		int offset = dir->len, error_code = 0;
 		char *gitdir_path = NULL;
 		char *gitfile = NULL;
+		struct strbuf gitdirenvbuf = STRBUF_INIT;
 
 		if (offset > min_offset)
 			strbuf_addch(dir, '/');
 		strbuf_addstr(dir, DEFAULT_GIT_DIR_ENVIRONMENT);
 		gitdirenv = read_gitfile_gently(dir->buf, die_on_error ?
-						NULL : &error_code);
+						NULL : &error_code, &gitdirenvbuf);
 		if (!gitdirenv) {
 			if (die_on_error ||
 			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
@@ -1330,8 +1340,10 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
 					gitdir_path = xstrdup(dir->buf);
 				}
-			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
+			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED) {
+				strbuf_release(&gitdirenvbuf);
 				return GIT_DIR_INVALID_GITFILE;
+			}
 		} else
 			gitfile = xstrdup(dir->buf);
 		/*
@@ -1365,9 +1377,10 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			 */
 			free(gitdir_path);
 			free(gitfile);
-
+			strbuf_release(&gitdirenvbuf);
 			return ret;
 		}
+		strbuf_release(&gitdirenvbuf);
 
 		if (is_git_directory(dir->buf)) {
 			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
@@ -1692,11 +1705,12 @@ const char *setup_git_directory(void)
 	return setup_git_directory_gently(NULL);
 }
 
-const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
+const char *resolve_gitdir_gently(const char *suspect, int *return_error_code,
+		struct strbuf* return_buf)
 {
 	if (is_git_directory(suspect))
 		return suspect;
-	return read_gitfile_gently(suspect, return_error_code);
+	return read_gitfile_gently(suspect, return_error_code, return_buf);
 }
 
 /* if any standard file descriptor is missing open it to /dev/null */
diff --git a/setup.h b/setup.h
index 3599aec93c..cf5a63762b 100644
--- a/setup.h
+++ b/setup.h
@@ -36,10 +36,9 @@ int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
 void read_gitfile_error_die(int error_code, const char *path, const char *dir);
-const char *read_gitfile_gently(const char *path, int *return_error_code);
-#define read_gitfile(path) read_gitfile_gently((path), NULL)
-const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
-#define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
+const char *read_gitfile_gently(const char *path, int *return_error_code, struct strbuf *buf);
+#define read_gitfile(path) read_gitfile_gently((path), NULL, NULL)
+const char *resolve_gitdir_gently(const char *suspect, int *return_error_code, struct strbuf *buf);
 
 void setup_work_tree(void);
 
diff --git a/submodule.c b/submodule.c
index 213da79f66..455444321b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -316,9 +316,10 @@ int is_submodule_populated_gently(const char *path, int *return_error_code)
 	int ret = 0;
 	char *gitdir = xstrfmt("%s/.git", path);
 
-	if (resolve_gitdir_gently(gitdir, return_error_code))
+	struct strbuf resolved_gitdir_buf = STRBUF_INIT;
+	if (resolve_gitdir_gently(gitdir, return_error_code, &resolved_gitdir_buf))
 		ret = 1;
-
+	strbuf_release(&resolved_gitdir_buf);
 	free(gitdir);
 	return ret;
 }
@@ -1879,22 +1880,25 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf gitdirbuf = STRBUF_INIT;
 	FILE *fp;
 	unsigned dirty_submodule = 0;
 	const char *git_dir;
 	int ignore_cp_exit_code = 0;
 
 	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
+	git_dir = read_gitfile_gently(buf.buf, NULL, &gitdirbuf);
 	if (!git_dir)
 		git_dir = buf.buf;
 	if (!is_git_directory(git_dir)) {
 		if (is_directory(git_dir))
 			die(_("'%s' not recognized as a git repository"), git_dir);
 		strbuf_release(&buf);
+		strbuf_release(&gitdirbuf);
 		/* The submodule is not checked out, so it is not modified */
 		return 0;
 	}
+		strbuf_release(&gitdirbuf);
 	strbuf_reset(&buf);
 
 	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
@@ -1958,15 +1962,16 @@ int submodule_uses_gitfile(const char *path)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	const char *git_dir;
+	struct strbuf gitfilebuf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir) {
+	read_gitfile_gently(buf.buf, NULL, &gitfilebuf);
+	if (!gitfilebuf.buf) {
 		strbuf_release(&buf);
 		return 0;
 	}
 	strbuf_release(&buf);
+	strbuf_release(&gitfilebuf);
 
 	/* Now test that all nested submodules use a gitfile too */
 	strvec_pushl(&cp.args,
@@ -2276,6 +2281,7 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 {
 	char *old_git_dir = NULL, *real_old_git_dir = NULL, *real_new_git_dir = NULL;
 	struct strbuf new_gitdir = STRBUF_INIT;
+	struct strbuf gitfilebuf = STRBUF_INIT;
 	const struct submodule *sub;
 
 	if (submodule_uses_worktrees(path))
@@ -2283,9 +2289,12 @@ static void relocate_single_git_dir_into_superproject(const char *path,
 		      "more than one worktree not supported"), path);
 
 	old_git_dir = xstrfmt("%s/.git", path);
-	if (read_gitfile(old_git_dir))
+	if (read_gitfile_gently(old_git_dir, NULL, &gitfilebuf)) {
 		/* If it is an actual gitfile, it doesn't need migration. */
+		strbuf_release(&gitfilebuf);
 		return;
+	}
+	strbuf_release(&gitfilebuf);
 
 	real_old_git_dir = real_pathdup(old_git_dir, 1);
 
@@ -2343,8 +2352,9 @@ void absorb_git_dir_into_superproject(const char *path,
 	int err_code;
 	const char *sub_git_dir;
 	struct strbuf gitdir = STRBUF_INIT;
+	struct strbuf resolved_gitdir_buf = STRBUF_INIT;
 	strbuf_addf(&gitdir, "%s/.git", path);
-	sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code);
+	sub_git_dir = resolve_gitdir_gently(gitdir.buf, &err_code, &resolved_gitdir_buf);
 
 	/* Not populated? */
 	if (!sub_git_dir) {
@@ -2385,6 +2395,8 @@ void absorb_git_dir_into_superproject(const char *path,
 		free(real_sub_git_dir);
 		free(real_common_git_dir);
 	}
+
+	strbuf_release(&resolved_gitdir_buf);
 	strbuf_release(&gitdir);
 
 	absorb_git_dir_into_superproject_recurse(path, super_prefix);
@@ -2484,17 +2496,19 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 	const struct submodule *sub;
 	const char *git_dir;
 	int ret = 0;
+	struct strbuf gitfilebuf = STRBUF_INIT;
 
 	strbuf_reset(buf);
 	strbuf_addstr(buf, submodule);
 	strbuf_complete(buf, '/');
 	strbuf_addstr(buf, ".git");
 
-	git_dir = read_gitfile(buf->buf);
+	git_dir = read_gitfile_gently(buf->buf, NULL, &gitfilebuf);
 	if (git_dir) {
 		strbuf_reset(buf);
 		strbuf_addstr(buf, git_dir);
 	}
+	strbuf_release(&gitfilebuf);
 	if (!is_git_directory(buf->buf)) {
 		sub = submodule_from_path(the_repository, null_oid(),
 					  submodule);
diff --git a/worktree.c b/worktree.c
index b02a05a74a..a6f125c8da 100644
--- a/worktree.c
+++ b/worktree.c
@@ -309,7 +309,7 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 {
 	struct strbuf wt_path = STRBUF_INIT;
 	struct strbuf realpath = STRBUF_INIT;
-	char *path = NULL;
+	struct strbuf gitfile = STRBUF_INIT;
 	int err, ret = -1;
 
 	strbuf_addf(&wt_path, "%s/.git", wt->path);
@@ -353,21 +353,20 @@ int validate_worktree(const struct worktree *wt, struct strbuf *errmsg,
 		goto done;
 	}
 
-	path = xstrdup_or_null(read_gitfile_gently(wt_path.buf, &err));
-	if (!path) {
+	if (!read_gitfile_gently(wt_path.buf, &err, &gitfile)) {
 		strbuf_addf_gently(errmsg, _("'%s' is not a .git file, error code %d"),
 				   wt_path.buf, err);
 		goto done;
 	}
 
 	strbuf_realpath(&realpath, git_common_path("worktrees/%s", wt->id), 1);
-	ret = fspathcmp(path, realpath.buf);
+	ret = fspathcmp(gitfile.buf, realpath.buf);
 
 	if (ret)
 		strbuf_addf_gently(errmsg, _("'%s' does not point back to '%s'"),
 				   wt->path, git_common_path("worktrees/%s", wt->id));
 done:
-	free(path);
+	strbuf_release(&gitfile);
 	strbuf_release(&wt_path);
 	strbuf_release(&realpath);
 	return ret;
@@ -567,7 +566,7 @@ static void repair_gitfile(struct worktree *wt,
 {
 	struct strbuf dotgit = STRBUF_INIT;
 	struct strbuf repo = STRBUF_INIT;
-	char *backlink;
+	struct strbuf backlink = STRBUF_INIT;
 	const char *repair = NULL;
 	int err;
 
@@ -582,13 +581,13 @@ static void repair_gitfile(struct worktree *wt,
 
 	strbuf_realpath(&repo, git_common_path("worktrees/%s", wt->id), 1);
 	strbuf_addf(&dotgit, "%s/.git", wt->path);
-	backlink = xstrdup_or_null(read_gitfile_gently(dotgit.buf, &err));
+	read_gitfile_gently(dotgit.buf, &err, &backlink);
 
 	if (err == READ_GITFILE_ERR_NOT_A_FILE)
 		fn(1, wt->path, _(".git is not a file"), cb_data);
 	else if (err)
 		repair = _(".git file broken");
-	else if (fspathcmp(backlink, repo.buf))
+	else if (fspathcmp(backlink.buf, repo.buf))
 		repair = _(".git file incorrect");
 
 	if (repair) {
@@ -596,7 +595,7 @@ static void repair_gitfile(struct worktree *wt,
 		write_file(dotgit.buf, "gitdir: %s", repo.buf);
 	}
 
-	free(backlink);
+	strbuf_release(&backlink);
 	strbuf_release(&repo);
 	strbuf_release(&dotgit);
 }
@@ -685,7 +684,7 @@ void repair_worktree_at_path(const char *path,
 	struct strbuf realdotgit = STRBUF_INIT;
 	struct strbuf gitdir = STRBUF_INIT;
 	struct strbuf olddotgit = STRBUF_INIT;
-	char *backlink = NULL;
+	struct strbuf backlink = STRBUF_INIT;
 	const char *repair = NULL;
 	int err;
 
@@ -701,12 +700,12 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	backlink = xstrdup_or_null(read_gitfile_gently(realdotgit.buf, &err));
+	read_gitfile_gently(realdotgit.buf, &err, &backlink);
 	if (err == READ_GITFILE_ERR_NOT_A_FILE) {
 		fn(1, realdotgit.buf, _("unable to locate repository; .git is not a file"), cb_data);
 		goto done;
 	} else if (err == READ_GITFILE_ERR_NOT_A_REPO) {
-		if (!(backlink = infer_backlink(realdotgit.buf))) {
+		if (!(backlink.buf = infer_backlink(realdotgit.buf))) {
 			fn(1, realdotgit.buf, _("unable to locate repository; .git file does not reference a repository"), cb_data);
 			goto done;
 		}
@@ -715,7 +714,7 @@ void repair_worktree_at_path(const char *path,
 		goto done;
 	}
 
-	strbuf_addf(&gitdir, "%s/gitdir", backlink);
+	strbuf_addf(&gitdir, "%s/gitdir", backlink.buf);
 	if (strbuf_read_file(&olddotgit, gitdir.buf, 0) < 0)
 		repair = _("gitdir unreadable");
 	else {
@@ -729,7 +728,7 @@ void repair_worktree_at_path(const char *path,
 		write_file(gitdir.buf, "%s", realdotgit.buf);
 	}
 done:
-	free(backlink);
+	strbuf_release(&backlink);
 	strbuf_release(&olddotgit);
 	strbuf_release(&gitdir);
 	strbuf_release(&realdotgit);
-- 
2.44.0.rc1.240.g4c46232300-goog

