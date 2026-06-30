Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29F406822
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820087; cv=none; b=VJFDr5cwI1smYJauhmxFcgN3yl9AoxOqAC7+8IwoySbgIjz/SzQPMCTxBpi0LNzsXGQyQ2LpbRcTJKekB6oMqtmEx6KzDvw1RUcnGS4mI/k/nUSXYiNbB23u3UYMajPFvBW5hnKhdLzMuVePdzr7BZbBBjj9CZCQLi0BMoRx75g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820087; c=relaxed/simple;
	bh=tHjqbENFgjDBQUxDfnAwroUsArI/aArtyvThLM32DUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scHWjSkPlqrypyJeo6res2ah79C5bCCpTE8GHI7Q/gswGygFsfuPTpFJX/285Pz4QCCBfboZQa2/NGZE6LrkPhLN0mUwG0xtFoqA8AyQjlArVSu81KhDVw5THXlAkp0+oNls9BIOA+owqKJLSZ14Cb+Z7uOc3nm6O7mLE8CJtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V82YVme9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OWRMbGOu; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V82YVme9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OWRMbGOu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 38C057A00A4
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 07:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782820085;
	 x=1782906485; bh=DHRcnIqs3csQyccEX2qP+VxaD1LewyCqqoCVFsDyYrw=; b=
	V82YVme9NSdWaJHJsU+KAOluOYTqC6mvYkejN94it+yKIw823AqZZXW0Rzt00Pzp
	Ot1OeYML76tryqblKOjhekLquCoCioalsMcTvTSZnth+8GfArAd3KmrygRttiPKP
	jgSDYXK0WgFiJHnZfZAc/B8e+KmilQmYs3CgEpIUxy+Cn22jTbpF50+L3Et3Y/MV
	lJWth+cyJZpxvJ/QztdjFlRuU/3JRm0IWC0zqu5AmiWZRfaPNhZuSuIoBMnnUAmI
	TjPV21v5Mu9fjk6njwSE+YzJeo/47UjB+6MkiIdSaIK1wH/+zK+JSgzVdnUPar7b
	B+GP5MfqLoqrTdBxxzE+NQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782820085; x=
	1782906485; bh=DHRcnIqs3csQyccEX2qP+VxaD1LewyCqqoCVFsDyYrw=; b=O
	WRMbGOunRNn45QfYs8Jk2V+e3wkw+5N/0Yvkb8P1WU8ybQONTRLIu0VJYl1nPTVj
	zT0E6TuRmxf06BaZchYyyjZ+pvePstzmEL6qdz7PdVQ7/vZkoHtLDY/IFAVUYKpS
	5ESGZCkBbwtWN9fjDpSRSwyqubEtGtH9eeH5YcWMk+I67yVYKPZKS9uLw1cq5V9g
	nVF/rq3j2R2hK8R5vrkfjgbzjvJyWSn8G3c8unMAEcTAi6j5LzsxkXiTim/uCmni
	vAPmSJUkzj06wJCVSGuPpqAyb06CceKEBpUmW65l1I0cV40Iy+IC8Ub6Wj6NHMG7
	tSNvBO0ACm4YsHdEGgssg==
X-ME-Sender: <xms:9axDavqN-FCkovw-7OXt1ZLFEAyF-quN3OkBX2ntvrishZofLeSTuA>
    <xme:9axDagkkex5pFUXtaAHYBX32-nOINnk-fsnqe2dV8uRLJlHmWxl-ie_ULZW67oNIh
    n5pAn4Btyxfth097Ke6LH1snsFF-Q2s_8yzSe3eky_NdHxlW2Fe>
X-ME-Received: <xmr:9axDah3ZPB-ZwaW7Ua8mKW6iAMRjLjTLBcGDTHaLzZLZbWJeIEZdRbEAEQXmnjnlXebKgUyeQF3_bfDWlzVXDMPtBPRLiRoSjtc2q2LJVz_KPA>
X-ME-Proxy-Cause: dmFkZTFMj0npvFJ5xMu5TnTZGwl/kjNgIE3c+0+JrvywJVsBHvwNH0JmEkV9/sHb7KtHci
    MWHt4fCw++BHgU20LsJIOXEGWWe7laoLapVct5ezFWgUrSK246UxYzIlrE931fJU7zptCb
    Kt8ycW9gOfxVEBILBMqaO/gR7ZjX830aRvEzgMVkDX71WFJ1OAahhczPptAaL8l+tOR3ej
    9r8uWRRiGNgTXQd7Q16Bn4Ti/3nvp69LgGzwNNdE7d9Zs6RyP3ilqh9SA/M1mBNs2+qPBf
    vwS5f4zH1TbnYNSv0Awptv9a5rucDDTqwCIXVp+kgUqtQvSOo6yzZiVbOAfdN362M5E2fM
    Wz3vC7HbaripGsTlH6x4/0BIbb6sjE57H0L3mFCI04l3cNvfeVGfGoUtKE53I3m+QtuZ+X
    vM2a0ok+nq9Q/uDLlQnonDlJfVus2IATzDVIiRpWsGlm9LgmlJC7Gu8fnc0tgsjLYxsRt6
    1QFNdYVFV9xGLWDEd5Ig3WZINToC+BxGKkS852ZbsKLdqVfEANxRq/3aJOHJ0zJ3AB7nm5
    +yC8fyA/ae+sEBPAgOMJNuElcTW928rUtFErFMZiCO78gGcHgG0gXiVyC8Otlo3lmVQSF8
    OBL0wdXjVUcZ3Wwn0SKMRxdKeJv9lO3qkQJCjKhWggNPjBCI4woWJSCnWNbQ
X-ME-Proxy: <xmx:9axDaoAAKq2N57E1Y0AcXGgrmTzlm1uLCFfAmXzkCzRet7v0U6svpg>
    <xmx:9axDauwreo5YLd57N7Q-mrEOKMm4Q__5uSM2GrHh91Ba7Xdeo_X2qQ>
    <xmx:9axDammotVQ7MGj7IMq_zscb9QCkUUjlD8RLVllat_y33qcIIz4Luw>
    <xmx:9axDajEUcqTzhsTgpL-L8q7asPtD2tE772i2aaUxhgmRxNSE58BBZw>
    <xmx:9axDavJvn-cMdUxk2YpWiIu4-b-dlrk39DPFNELSpCD17UeNnNH_pl7e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jun 2026 07:48:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a8b60b81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jun 2026 11:48:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 30 Jun 2026 13:47:43 +0200
Subject: [PATCH 04/13] setup: split up concerns of
 `setup_git_env_internal()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-pks-setup-split-discovery-and-setup-v1-4-13864eb5a032@pks.im>
References: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
In-Reply-To: <20260630-pks-setup-split-discovery-and-setup-v1-0-13864eb5a032@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The function `setup_git_env_internal()` does two completely unrelated
things:

  - It configures the repository's gitdir and propagates environment
    variables into it.

  - It configures a couple of global parameters via environment
    variables.

The function is called when we initialize the repository's path, but
it's also called via `chdir_notify_register()` whenever we change the
current working directory. While we indeed have to reconfigure the
gitdir in case it's a relative path, it doesn't make sense to reapply
the global environment variables.

Split up concerns of this function along the above delineation. Handling
of the global environment variables is moved into `init_git()`, as they
can be considered part of our setup procedure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 common-init.c | 20 ++++++++++++++++
 setup.c       | 73 +++++++++++++++++++++++------------------------------------
 2 files changed, 48 insertions(+), 45 deletions(-)

diff --git a/common-init.c b/common-init.c
index 5cc73f058c..d26c9c1f20 100644
--- a/common-init.c
+++ b/common-init.c
@@ -5,7 +5,10 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "attr.h"
+#include "odb.h"
+#include "parse.h"
 #include "repository.h"
+#include "replace-object.h"
 #include "setup.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -31,6 +34,22 @@ static void restore_sigpipe_to_default(void)
 	signal(SIGPIPE, SIG_DFL);
 }
 
+static void setup_environment(void)
+{
+	char *git_replace_ref_base;
+	const char *replace_ref_base;
+
+	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
+		disable_replace_refs();
+	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
+	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
+							  : "refs/replace/");
+	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
+
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
+		fetch_if_missing = 0;
+}
+
 void init_git(const char **argv)
 {
 	struct strbuf tmp = STRBUF_INIT;
@@ -51,6 +70,7 @@ void init_git(const char **argv)
 	git_setup_gettext();
 
 	initialize_repository(the_repository);
+	setup_environment();
 
 	attr_start();
 
diff --git a/setup.c b/setup.c
index 5e6b959f68..dd8514b822 100644
--- a/setup.c
+++ b/setup.c
@@ -10,7 +10,6 @@
 #include "object-file.h"
 #include "object-name.h"
 #include "refs.h"
-#include "replace-object.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
@@ -1042,38 +1041,19 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	return error_code ? NULL : path;
 }
 
-static void setup_git_env_internal(struct repository *repo,
-				   const char *git_dir)
+static void apply_gitdir_and_environment(struct repository *repo, const char *path)
 {
-	char *git_replace_ref_base;
-	const char *replace_ref_base;
-	struct set_gitdir_args args = { NULL };
 	struct strvec to_free = STRVEC_INIT;
+	struct set_gitdir_args args = {
+		.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT),
+		.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT),
+		.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT),
+		.disable_ref_updates = !!getenv(GIT_QUARANTINE_ENVIRONMENT),
+	};
 
-	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
-	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
-	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
-		args.disable_ref_updates = true;
+	repo_set_gitdir(repo, path, &args);
 
-	repo_set_gitdir(repo, git_dir, &args);
 	strvec_clear(&to_free);
-
-	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
-		disable_replace_refs();
-	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
-	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
-							  : "refs/replace/");
-	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
-
-	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
-		fetch_if_missing = 0;
-}
-
-static void set_git_dir_1(struct repository *repo, const char *path)
-{
-	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env_internal(repo, path);
 }
 
 static void update_relative_gitdir(const char *name UNUSED,
@@ -1087,11 +1067,12 @@ static void update_relative_gitdir(const char *name UNUSED,
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
-	set_git_dir_1(repo, path);
+	apply_gitdir_and_environment(repo, path);
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 	free(path);
 }
 
-static void set_git_dir(struct repository *repo, const char *path, int make_realpath)
+static void apply_and_export_relative_gitdir(struct repository *repo, const char *path, int make_realpath)
 {
 	struct strbuf realpath = STRBUF_INIT;
 
@@ -1100,7 +1081,9 @@ static void set_git_dir(struct repository *repo, const char *path, int make_real
 		path = realpath.buf;
 	}
 
-	set_git_dir_1(repo, path);
+	apply_gitdir_and_environment(repo, path);
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
+
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, update_relative_gitdir, repo);
 
@@ -1153,7 +1136,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		set_git_work_tree(repo, work_tree_env);
 	} else if (repo_fmt->is_bare > 0) {
 		/* #18, #26 */
-		set_git_dir(repo, gitdirenv, 0);
+		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	} else if (repo_fmt->work_tree) { /* #6, #14 */
@@ -1173,7 +1156,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 		}
 	} else if (!git_env_bool(GIT_IMPLICIT_WORK_TREE_ENVIRONMENT, 1)) {
 		/* #16d */
-		set_git_dir(repo, gitdirenv, 0);
+		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	} else { /* #2, #10 */
@@ -1185,14 +1168,14 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 
 	/* both repo_get_work_tree() and cwd are already normalized */
 	if (!strcmp(cwd->buf, worktree)) { /* cwd == worktree */
-		set_git_dir(repo, gitdirenv, 0);
+		apply_and_export_relative_gitdir(repo, gitdirenv, 0);
 		free(gitfile);
 		return NULL;
 	}
 
 	offset = dir_inside_of(cwd->buf, worktree);
 	if (offset >= 0) {	/* cwd inside worktree? */
-		set_git_dir(repo, gitdirenv, 1);
+		apply_and_export_relative_gitdir(repo, gitdirenv, 1);
 		if (chdir(worktree))
 			die_errno(_("cannot chdir to '%s'"), worktree);
 		strbuf_addch(cwd, '/');
@@ -1201,7 +1184,7 @@ static const char *setup_explicit_git_dir(struct repository *repo,
 	}
 
 	/* cwd outside worktree */
-	set_git_dir(repo, gitdirenv, 0);
+	apply_and_export_relative_gitdir(repo, gitdirenv, 0);
 	free(gitfile);
 	return NULL;
 }
@@ -1231,7 +1214,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
 	if (repo_fmt->is_bare > 0) {
-		set_git_dir(repo, gitdir, (offset != cwd->len));
+		apply_and_export_relative_gitdir(repo, gitdir, (offset != cwd->len));
 		if (chdir(cwd->buf))
 			die_errno(_("cannot come back to cwd"));
 		return NULL;
@@ -1240,7 +1223,7 @@ static const char *setup_discovered_git_dir(struct repository *repo,
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(repo, ".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
-		set_git_dir(repo, gitdir, 0);
+		apply_and_export_relative_gitdir(repo, gitdir, 0);
 	if (offset >= cwd->len)
 		return NULL;
 
@@ -1280,10 +1263,10 @@ static const char *setup_bare_git_dir(struct repository *repo,
 			die_errno(_("cannot come back to cwd"));
 		root_len = offset_1st_component(cwd->buf);
 		strbuf_setlen(cwd, offset > root_len ? offset : root_len);
-		set_git_dir(repo, cwd->buf, 0);
+		apply_and_export_relative_gitdir(repo, cwd->buf, 0);
 	}
 	else
-		set_git_dir(repo, ".", 0);
+		apply_and_export_relative_gitdir(repo, ".", 0);
 	return NULL;
 }
 
@@ -1878,7 +1861,7 @@ const char *enter_repo(struct repository *repo, const char *path, unsigned flags
 		struct repository_format fmt = REPOSITORY_FORMAT_INIT;
 		struct strbuf err = STRBUF_INIT;
 
-		set_git_dir(repo, ".", 0);
+		apply_and_export_relative_gitdir(repo, ".", 0);
 		read_and_verify_repository_format(&fmt, ".", NULL);
 		if (apply_repository_format(repo, &fmt, APPLY_REPOSITORY_FORMAT_HONOR_ENV, &err) < 0)
 			die("%s", err.buf);
@@ -2022,7 +2005,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 		startup_info->have_repository = 1;
 
 	/*
-	 * Not all paths through the setup code will call 'set_git_dir()' (which
+	 * Not all paths through the setup code will call 'apply_and_export_relative_gitdir()' (which
 	 * directly sets up the environment) so in order to guarantee that the
 	 * environment is in a consistent state after setup, explicitly setup
 	 * the environment if we have a repository.
@@ -2040,7 +2023,7 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env_internal(repo, gitdir);
+			apply_gitdir_and_environment(repo, gitdir);
 		}
 
 		if (startup_info->have_repository) {
@@ -2825,12 +2808,12 @@ int init_db(struct repository *repo,
 		if (!exist_ok && !stat(real_git_dir, &st))
 			die(_("%s already exists"), real_git_dir);
 
-		set_git_dir(repo, real_git_dir, 1);
+		apply_and_export_relative_gitdir(repo, real_git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 		separate_git_dir(git_dir, original_git_dir);
 	}
 	else {
-		set_git_dir(repo, git_dir, 1);
+		apply_and_export_relative_gitdir(repo, git_dir, 1);
 		git_dir = repo_get_git_dir(repo);
 	}
 	startup_info->have_repository = 1;

-- 
2.55.0.795.g602f6c329a.dirty

