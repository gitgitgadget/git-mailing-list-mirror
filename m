Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D22367DF
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789137972; cv=none; b=kgoZN1CEH1V8KlAKGIhWyS3FIv3zaKyH0WuZs8euSWH9nRKWWqW/357uNou9etxd/xa5Bs2q/MjkYtMHSVcqvorD5A3he5u1lG5ym/CbXClaGU/n6JtKh0+DRpUdxHplZqh1k+wtzL6XF7PH9JQsqm34hq2TJGNReRGcvoIJEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789137972; c=relaxed/simple;
	bh=GssEXeq/nd89QOuZDvCU+S/UjFu9nXZtpCCzMKdynoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhqODwBVZlcWDOkDoi7mmjzr0UOo20HLX0pyvG/gtmdp25xIYdmtxkneBf3M65IrnZi8/jAfIeAopWqIl95krbVAAVVVXjJonm3bGmFqWMJF0Z/8NxK1rhall0F41Vf9ocLZs+fDuvTTLF3uK8q/nfUIaxX/e5DhbcaGIkXiCHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxsoVGKd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxsoVGKd"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4c14d66d922so505980b6e.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2026 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789137969; x=1789742769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mROsD4Ax+5lSkFRIG+d9KxUNnfJZRH5ShQF+vUkncvs=;
        b=OxsoVGKdhBhzjQNIay8efpMWt229zg3A5iJg1SXMm3otx3Kf6SZpQ5EyNQdHl9jK3N
         +/pxQqgdQukc3po+TSxJRDnN4MgBgFhNFbCLjCoMg3bDwPGnYnVAANKTLJC4nbc3biUp
         Vmg9AUYhLDJIlxbah2oq/46xUvtIHiABj/31ANQCe3CggOGaDUIDY4FbqupPWRU/lxPm
         +RORkiYrQSt2bTmteWag4Jt8OmmostuX5Sxim9cDJCf4c6Nnd/5eRAZ4k5rEmIcv61Cp
         e2oedpDVQ1UdsDF/rmCaZozQov7sEJu0g+Xxi6Ljbj9OHsTUxUDzpdJDnG7u3zQlZY7l
         74xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789137969; x=1789742769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mROsD4Ax+5lSkFRIG+d9KxUNnfJZRH5ShQF+vUkncvs=;
        b=BMVzDBty1a4AstxslZxCaeds+12yM6smKw2SNTjREoprvj/x27vJPg0P1OdxZvha1G
         ht9vKVpNj/mc2IahWv6GQxNNhN8VczrBTVDUHwqQZmUZJHloHEwjNwlt4Li0sWeDJP/2
         FGcL2BFTqIXNHBWwwIrXp4d/kpqf0FCEQg+bK8MWQrSnwaa55ecguukPlxqlxDwlRnVe
         BDRxys8wyfREeXuhmJjzeVqsiDgr3PqfkmFfnczRpx6BRV0lDTjwUd5LrS66DEgHwaDY
         YhkTWUw1H+PRoIEv7BfbeVU5bnW3cVVVb2vtr4kbAXuajfwUxKH9F/l9YcwK4vKivoWO
         E+FQ==
X-Gm-Message-State: AFuF++kNWHLbQ1JOpTY9q5/92jfBAohGtGaO0am9kMlbYbdDEcvml/fw
	vIk5cgviLiBO+NoUTKu7JlUK4rw+QXLnKq5aP2kORg2/K/4efJ1rIals
X-Gm-Gg: AYBFou3hGx5KYYdcSWOW8ti2f2FsF9l9aacpEjhIXKc0Yw0fNnOk9uJYIapzk//Zbrv
	djv+zjDhV3oL9nHAskxfgqiInBIVTSXeEwadSvM/1KTJa3Iuq4z0kiBbCnynnPEBrVoFdmGJtH4
	dZ3XaNhVAeDptAtrkYKS5SqARwKOenpYXPUCmb/+0PzUYbmw3J8dP+KsYFT+Yrh7ucOAcy2TrI+
	HL/HB1A+L+Oq6ZD5jCy+EuQCqib97OHX9eJFf5QlPkWjmo3TobrIkiEWoNbflh82ihQ4k/dTLcb
	T4eZUoxA/9dvPA91lPXvK2cF3FyxpmzqgkOxQVFgmhLvJshzOsDgI4WV7WcZA0mvj6XgKf/8m+/
	VF2tH6GpBqv8dd348+3vjP4ObZNPyFwhSYS6sMsVQzTqbvamZDWIBwKowTfQcFaYPp6jOQ6j+sU
	nvu4b6ecLCrUmr8KXGS9V7W2V/1fwSaxVNjKXIV5skgT3Au1aF+Np4lX0X09JubIWUTjNRrC8VV
	hd8K1qnivq/DszN2g4Qe6b8mgpAHxaP1RZUEAHSfDAZsHKIZYtX7HcyhVdiBMeK6og285ElbPB6
	tF+ekw==
X-Received: by 2002:a05:6820:8590:10b0:6bd:32ea:1d15 with SMTP id 006d021491bc7-6c0b9a5532bmr2267368eaf.13.1789137969312;
        Fri, 11 Sep 2026 07:46:09 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b759d0sm7843335c88.7.2026.09.11.07.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 07:46:08 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com
Subject: [GSoC Patch v6 0/7] add more path keys to git repo info
Date: Fri, 11 Sep 2026 20:15:12 +0530
Message-ID: <20260911144519.1011780-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.

Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-root: superproject tree from submodules.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.
* path.cdup: relative path to top level from subdirectory.

Keys support suffixes for format.
Commits contain documentation and tests.

changes since v5:
* Refactored get_superproject_working_tree(struct repository *r, ...): Updated
  function signature and callers (builtin/rev-parse.c, builtin/repo.c)
  to accept repo, eliminating xgetcwd().

Note on path.cdup duplication:
As discussed in v5, path.cdup currently duplicates the prefix-counting
logic from rev-parse to keep this feature arc self-contained.
A follow-up refactoring series will be sent immediately after this
to introduce a shared repo-info helper library, deduplicating this
and other overlapping path logic across repo and rev-parse.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-root with absolute and relative suffixes
  repo: add path.hooks with absolute and relative suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.grafts with absolute and relative suffixes
  repo: add path.git-prefix
  repo: add path.cdup

 Documentation/git-repo.adoc |  62 ++++++++++++
 builtin/repo.c              | 151 ++++++++++++++++++++++++++++
 builtin/rev-parse.c         |   2 +-
 submodule.c                 |  43 ++++----
 submodule.h                 |   2 +-
 t/t1900-repo-info.sh        | 195 +++++++++++++++++++++++++++++++++++-
 6 files changed, 430 insertions(+), 25 deletions(-)

Range-diff against v5:
1:  4ce9dcb24e = 1:  3880485020 repo: add path.toplevel with absolute and relative suffix formatting
2:  c431008d40 ! 2:  e75e17b44e repo: add path.superproject-root with absolute and relative suffixes
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
      	return 0;
      }
      
    -+static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
    ++static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!get_superproject_working_tree(&superproject)) {
    ++	if (!get_superproject_working_tree(repo, &superproject)) {
     +		strbuf_release(&superproject);
     +		return 0;
     +	}
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!get_superproject_working_tree(&superproject)) {
    ++	if (!get_superproject_working_tree(repo, &superproject)) {
     +		strbuf_release(&superproject);
     +		return 0;
     +	}
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.toplevel.relative", get_path_toplevel_relative },
      	{ "references.format", get_references_format },
     
    + ## builtin/rev-parse.c ##
    +@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    + 			}
    + 			if (!strcmp(arg, "--show-superproject-working-tree")) {
    + 				struct strbuf superproject = STRBUF_INIT;
    +-				if (get_superproject_working_tree(&superproject))
    ++				if (get_superproject_working_tree(the_repository, &superproject))
    + 					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
    + 				strbuf_release(&superproject);
    + 				continue;
    +
    + ## submodule.c ##
    +@@ submodule.c: void absorb_git_dir_into_superproject(const char *path,
    + 	absorb_git_dir_into_superproject_recurse(path, super_prefix);
    + }
    + 
    +-int get_superproject_working_tree(struct strbuf *buf)
    ++int get_superproject_working_tree(struct repository *r, struct strbuf *buf)
    + {
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    + 	struct strbuf sb = STRBUF_INIT;
    + 	struct strbuf one_up = STRBUF_INIT;
    +-	char *cwd = xgetcwd();
    ++	struct strbuf target_wt = STRBUF_INIT;
    ++	const char *worktree;
    + 	int ret = 0;
    + 	const char *subpath;
    + 	int code;
    + 	ssize_t len;
    + 
    +-	if (!is_inside_work_tree(the_repository))
    +-		/*
    +-		 * FIXME:
    +-		 * We might have a superproject, but it is harder
    +-		 * to determine.
    +-		 */
    ++	worktree = repo_get_work_tree(r);
    ++	if (!worktree)
    ++		goto out;
    ++
    ++	if (!strbuf_realpath(&target_wt, worktree, 0))
    + 		goto out;
    + 
    +-	if (!strbuf_realpath(&one_up, "../", 0))
    ++	strbuf_addf(&one_up, "%s/..", target_wt.buf);
    ++	if (!strbuf_realpath(&one_up, one_up.buf, 0))
    + 		goto out;
    + 
    +-	subpath = relative_path(cwd, one_up.buf, &sb);
    ++	subpath = relative_path(target_wt.buf, one_up.buf, &sb);
    + 
    + 	prepare_submodule_repo_env(&cp.env);
    + 	strvec_pop(&cp.env);
    + 
    +-	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", "..",
    ++	strvec_pushl(&cp.args, "--literal-pathspecs", "-C", one_up.buf,
    + 		     "ls-files", "-z", "--stage", "--full-name", "--",
    + 		     subpath, NULL);
    + 	strbuf_reset(&sb);
    +@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    + 	cp.git_cmd = 1;
    + 
    + 	if (start_command(&cp))
    +-		die(_("could not start ls-files in .."));
    ++		die(_("could not start ls-files in %s"), one_up.buf);
    + 
    + 	len = strbuf_read(&sb, cp.out, PATH_MAX);
    + 	close(cp.out);
    + 
    + 	if (starts_with(sb.buf, "160000")) {
    + 		int super_sub_len;
    +-		int cwd_len = strlen(cwd);
    ++		int wt_len = target_wt.len;
    + 		char *super_sub, *super_wt;
    + 
    + 		/*
    +@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    + 		super_sub = strchr(sb.buf, '\t') + 1;
    + 		super_sub_len = strlen(super_sub);
    + 
    +-		if (super_sub_len > cwd_len ||
    +-		    strcmp(&cwd[cwd_len - super_sub_len], super_sub))
    +-			BUG("returned path string doesn't match cwd?");
    ++		if (super_sub_len > wt_len ||
    ++		    strcmp(&target_wt.buf[wt_len - super_sub_len], super_sub))
    ++			BUG("returned path string doesn't match worktree?");
    + 
    +-		super_wt = xstrdup(cwd);
    +-		super_wt[cwd_len - super_sub_len] = '\0';
    ++		super_wt = xstrdup(target_wt.buf);
    ++		super_wt[wt_len - super_sub_len] = '\0';
    + 
    + 		strbuf_realpath(buf, super_wt, 1);
    + 		ret = 1;
    +@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    + 	code = finish_command(&cp);
    + 
    + 	if (code == 128)
    +-		/* '../' is not a git repository */
    ++		/* parent directory is not a git repository */
    + 		ret = 0;
    + 	else if (code == 0 && len == 0)
    +-		/* There is an unrelated git repository at '../' */
    ++		/* There is an unrelated git repository at parent directory */
    + 		ret = 0;
    + 	else if (code)
    + 		die(_("ls-tree returned unexpected return code %d"), code);
    +@@ submodule.c: int get_superproject_working_tree(struct strbuf *buf)
    + out:
    + 	strbuf_release(&sb);
    + 	strbuf_release(&one_up);
    +-	free(cwd);
    ++	strbuf_release(&target_wt);
    + 	return ret;
    + }
    + 
    +
    + ## submodule.h ##
    +@@ submodule.h: void absorb_git_dir_into_superproject(const char *path,
    +  * project is a submodule of. If this repository is not a submodule of
    +  * another repository, return 0.
    +  */
    +-int get_superproject_working_tree(struct strbuf *buf);
    ++int get_superproject_working_tree(struct repository *r, struct strbuf *buf);
    + 
    + #endif
    +
      ## t/t1900-repo-info.sh ##
     @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
      	'.git' \
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
      test_expect_success 'path.toplevel absolute and relative' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
    +@@ t/t1900-repo-info.sh: test_expect_success 'path.toplevel absolute and relative in a bare repository' '
    + 	)
    + '
    + 
    ++test_expect_success 'path.superproject-root works with --git-dir' '
    ++	test_when_finished "rm -rf sub super" &&
    ++	git init sub &&
    ++	test_commit -C sub initial &&
    ++	git init super &&
    ++	(
    ++		cd super &&
    ++		git -c protocol.file.allow=always submodule add "../sub" sub &&
    ++		git commit -m "add submodule" &&
    ++
    ++		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
    ++		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
    ++
    ++		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
    ++		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
    + test_done
3:  8664f8aaae ! 3:  ae8a2592b3 repo: add path.hooks with absolute and relative suffixes
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	return 0;
     +}
     +
    - static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
    + static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
      {
      	struct strbuf superproject = STRBUF_INIT;
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
4:  438f7e4e16 ! 4:  7f27bf14b9 repo: add path.index with absolute and relative suffixes
    @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, stru
     +	return 0;
     +}
     +
    - static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
    + static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
      {
      	struct strbuf superproject = STRBUF_INIT;
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
5:  82be68426c = 5:  cc52587980 repo: add path.grafts with absolute and relative suffixes
6:  346f1654d3 = 6:  77bf284a05 repo: add path.git-prefix
7:  3ccdd9b5e4 = 7:  e30d98f5da repo: add path.cdup
-- 
2.55.GIT
