Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5F73D564E
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876698; cv=none; b=RkbGMiMMU8bail/IqEU2exn/TuiX95aLDEFzJpCQyrdh24pvraD0Sqfd3ySlkTJwhQrw+r6QXsM5R5Fk3S423CmzCVfXTRybE3vL8qvqOf7PiKixcJT2CKdYStv6L22v8bdvFfCoS7+ertmd6LUWi5Xa9L18ob4KRTmADzJV0WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876698; c=relaxed/simple;
	bh=Powy9B052ZZYIvznIcdYhmxABfb5S4R0o9WqaZydafI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h3TXVfEDNndmwgG3bwXaxKHMMDLhtdAiRkfZqEWOZBdcgOgsPL8gIC6JfoWJjXWKEI6rwtRfyKi3AKAzXa53onK4WdC609g7bgahv+91d8nDeIseW3LsWzcKdYfcsdh4ADgCv9Az2NsVk1f+uIAt4LL/7rwPXEIJk+BeOgIwYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HW9vcvSc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCInThad; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HW9vcvSc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCInThad"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ACEC51D00190
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 09:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876696;
	 x=1774963096; bh=Mk/wDynNwYCEEujHRQ9vwfdePOytPCKE55qYSqgmSko=; b=
	HW9vcvScOsmAQYjh4bPy3/tdWuVMEQdFafqE1e2oovpM2qeQyVEJSEw6yZGBgpju
	NoYUrjOsVqEbHEqiQs/DkUNbizAvkZf9YEHsDFx7/67MPOKjwSL6hVyYCAIM+Unv
	71airrKwu1hJxvVNgjhambezPAuif4jJH+kPK0waeFayHpwuvRwRlQ/SzqnWBmdf
	gx5XsWg3rIGr7b5doRhpa0D5EG/JNOYNZfYpgffo+vm0LL+DfeXqIL1UAphappJY
	U/9X5aQlUjuQjgrqFLFIyNalxtY0PVlLkRYV0uhErf8lc9X3FjfbI/MgXiLSgtJu
	pOZ4bMBICeDAwBzWsNjKSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876696; x=
	1774963096; bh=Mk/wDynNwYCEEujHRQ9vwfdePOytPCKE55qYSqgmSko=; b=G
	CInThadCwbNfCEt0EPPjyA11hndw1ZKmP24RMlN486NdnOFlEy5TMAEkSyyvaltR
	wcKTD6wCoAU0rzGPNScTNiMmfZcHjZWuILdqLaUH2CZ8myyiTMoeiAEcAIZbcRxd
	ovtYJUPu65TYi+huOYB/cXJ/2npYehDXqong3QyNUUMFfp1csd9DDvBI1XjSuKSz
	VNMizaq4DIq/avyp8gpSggLAvAqpwzx+DLGjry7N4Ri0fMUpygp/F6pxZnTU3/gl
	OAPl5HIQUPa8heOkA4uUDbARs+I+wqwucYPT55ptdUmrRcXra2DZ8zXqRoJ7A029
	d0HijcHllZ34ywdFqXPgg==
X-ME-Sender: <xms:GHjKacmRuAM5YDA1-e_EtUyKe2QrvTcaAJ0VwChVgZCAbfTjejPisA>
    <xme:GHjKaSy9fML9k5lg-4yKyuhuXM5FRq-2l45SIwtWJc7D0I4_JypBvXZR1ACuJYDW1
    4QFvLnZddBv6kCu5GbGp9RT--Y6uiUJakBGhnYMK8seTmfnaI1Gzyg>
X-ME-Received: <xmr:GHjKaQR_xOkXXG059V40vhifZ5lvQGU5Zof7pDs5_qBYYqOHe6kptiCuNXJ0cujXs5u7jzQzajahuQw53jde5Zw5mtYBrjZAh_GJaVkessPfhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:GHjKadst7QpOL3XmuM5DHgCwATzkXFU5OvVYjzM161xd0ari_-axag>
    <xmx:GHjKaas9OI_Ko8VbaI0GMGVMzl3maHNBv0MSWeDnTkxa459xnHSTSA>
    <xmx:GHjKabzQqGeQD5pov-hLMkfOt4Jl_lGWGTgeAGerf6qZH8OqM3q0fQ>
    <xmx:GHjKaYjRuFLcDvFcDZg58cS08_1EkA6HFFCHLAzDE_OhWrChKr9PQw>
    <xmx:GHjKaQ2qxOnSjwmQA5ScirPX4TwZ_YBWbZ8i5C9Q36I7_uMNEgv1VyO7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edca1114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:34 +0200
Subject: [PATCH 12/18] setup: stop using `the_repository` in
 `setup_git_directory_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-12-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `setup_git_directory_gently()` and
instead accept the repository as a parameter. The injection of
`the_repository` is thus bumped one level higher, where callers now pass
it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/check-ref-format.c |  5 ++++-
 builtin/diff.c             |  2 +-
 builtin/hash-object.c      |  2 +-
 builtin/help.c             |  2 +-
 builtin/stripspace.c       |  2 +-
 git.c                      |  6 +++---
 http-fetch.c               |  2 +-
 imap-send.c                |  2 +-
 remote-curl.c              |  4 ++--
 setup.c                    | 36 ++++++++++++++++++------------------
 setup.h                    |  2 +-
 t/helper/test-path-utils.c |  2 +-
 t/helper/test-subprocess.c |  2 +-
 13 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 5d80afeec0..e42b0444ea 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -1,6 +1,9 @@
 /*
  * GIT - The information manager from hell
  */
+
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
 #include "refs.h"
 #include "setup.h"
@@ -41,7 +44,7 @@ static int check_ref_format_branch(const char *arg)
 	const char *name;
 	int nongit;
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 	if (check_branch_ref(&sb, arg) ||
 	    !skip_prefix(sb.buf, "refs/heads/", &name))
 		die("'%s' is not a valid branch name", arg);
diff --git a/builtin/diff.c b/builtin/diff.c
index 1ede873ac1..4b46e394ce 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -455,7 +455,7 @@ int cmd_diff(int argc,
 			break;
 	}
 
-	prefix = setup_git_directory_gently(&nongit);
+	prefix = setup_git_directory_gently(the_repository, &nongit);
 
 	if (!nongit) {
 		prepare_repo_settings(the_repository);
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 5d900a6b8c..d7905bedc2 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -102,7 +102,7 @@ int cmd_hash_object(int argc,
 	if (flags & INDEX_WRITE_OBJECT)
 		prefix = setup_git_directory();
 	else
-		prefix = setup_git_directory_gently(&nongit);
+		prefix = setup_git_directory_gently(the_repository, &nongit);
 
 	if (nongit && !the_hash_algo)
 		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
diff --git a/builtin/help.c b/builtin/help.c
index c0aece4da3..a140339999 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -740,7 +740,7 @@ int cmd_help(int argc,
 		return 0;
 	}
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 	repo_config(the_repository, git_help_config, NULL);
 
 	if (parsed_help_format != HELP_FORMAT_NONE)
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 4a566cbc5d..18705f1a5b 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -54,7 +54,7 @@ int cmd_stripspace(int argc,
 		usage_with_options(stripspace_usage, options);
 
 	if (mode == STRIP_COMMENTS || mode == COMMENT_LINES) {
-		setup_git_directory_gently(&nongit);
+		setup_git_directory_gently(the_repository, &nongit);
 		repo_config(the_repository, git_default_config, NULL);
 	}
 
diff --git a/git.c b/git.c
index c146eaa20b..0df36c9b9d 100644
--- a/git.c
+++ b/git.c
@@ -84,7 +84,7 @@ static int list_cmds(const char *spec)
 	* Set up the repository so we can pick up any repo-level config (like
 	* completion.commands).
 	*/
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 
 	while (*spec) {
 		const char *sep = strchrnul(spec, ',');
@@ -386,7 +386,7 @@ static int handle_alias(struct strvec *args, struct string_list *expanded_aliase
 			int nongit_ok;
 
 			/* Aliases expect GIT_PREFIX, GIT_DIR etc to be set */
-			setup_git_directory_gently(&nongit_ok);
+			setup_git_directory_gently(the_repository, &nongit_ok);
 
 			commit_pager_choice();
 
@@ -480,7 +480,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 		prefix = setup_git_directory();
 		no_repo = 0;
 	} else if (run_setup & RUN_SETUP_GENTLY) {
-		prefix = setup_git_directory_gently(&no_repo);
+		prefix = setup_git_directory_gently(the_repository, &no_repo);
 	} else {
 		prefix = NULL;
 	}
diff --git a/http-fetch.c b/http-fetch.c
index 1922e23fcd..f9b6ecb061 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -109,7 +109,7 @@ int cmd_main(int argc, const char **argv)
 	struct strvec index_pack_args = STRVEC_INIT;
 	int ret;
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 
 	while (arg < argc && argv[arg][0] == '-') {
 		const char *p;
diff --git a/imap-send.c b/imap-send.c
index af02c6a689..cfd6a5120c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1799,7 +1799,7 @@ int cmd_main(int argc, const char **argv)
 	int nongit_ok;
 	int ret;
 
-	setup_git_directory_gently(&nongit_ok);
+	setup_git_directory_gently(the_repository, &nongit_ok);
 	repo_config(the_repository, git_imap_config, &server);
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..454283c43f 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1546,7 +1546,7 @@ int cmd_main(int argc, const char **argv)
 	int nongit;
 	int ret = 1;
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 	if (argc < 2) {
 		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
 		goto cleanup;
@@ -1587,7 +1587,7 @@ int cmd_main(int argc, const char **argv)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit) {
-				setup_git_directory_gently(&nongit);
+				setup_git_directory_gently(the_repository, &nongit);
 				if (nongit)
 					die(_("remote-curl: fetch attempted without a local repo"));
 			}
diff --git a/setup.c b/setup.c
index e1814fb8e6..99c0d1640e 100644
--- a/setup.c
+++ b/setup.c
@@ -1859,7 +1859,7 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 	repo_set_worktree(repo, new_work_tree);
 }
 
-const char *setup_git_directory_gently(int *nongit_ok)
+const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
@@ -1874,7 +1874,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * configuration (including the per-repo config file that we
 	 * ignored previously).
 	 */
-	repo_config_clear(the_repository);
+	repo_config_clear(repo);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -1890,18 +1890,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	switch (setup_git_directory_gently_1(&dir, &gitdir, &report, 1)) {
 	case GIT_DIR_EXPLICIT:
-		prefix = setup_explicit_git_dir(the_repository, gitdir.buf, &cwd, &repo_fmt, nongit_ok);
+		prefix = setup_explicit_git_dir(repo, gitdir.buf, &cwd, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_DISCOVERED:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_discovered_git_dir(the_repository, gitdir.buf, &cwd, dir.len,
+		prefix = setup_discovered_git_dir(repo, gitdir.buf, &cwd, dir.len,
 						  &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_BARE:
 		if (dir.len < cwd.len && chdir(dir.buf))
 			die(_("cannot change to '%s'"), dir.buf);
-		prefix = setup_bare_git_dir(the_repository, &cwd, dir.len, &repo_fmt, nongit_ok);
+		prefix = setup_bare_git_dir(repo, &cwd, dir.len, &repo_fmt, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
 		if (!nongit_ok)
@@ -1981,30 +1981,30 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	    startup_info->have_repository ||
 	    /* GIT_DIR_EXPLICIT */
 	    getenv(GIT_DIR_ENVIRONMENT)) {
-		if (!the_repository->gitdir) {
+		if (!repo->gitdir) {
 			const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 			if (!gitdir)
 				gitdir = DEFAULT_GIT_DIR_ENVIRONMENT;
-			setup_git_env(the_repository, gitdir);
+			setup_git_env(repo, gitdir);
 		}
 		if (startup_info->have_repository) {
-			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
-			repo_set_compat_hash_algo(the_repository,
+			repo_set_hash_algo(repo, repo_fmt.hash_algo);
+			repo_set_compat_hash_algo(repo,
 						  repo_fmt.compat_hash_algo);
-			repo_set_ref_storage_format(the_repository,
+			repo_set_ref_storage_format(repo,
 						    repo_fmt.ref_storage_format,
 						    repo_fmt.ref_storage_payload);
-			the_repository->repository_format_worktree_config =
+			repo->repository_format_worktree_config =
 				repo_fmt.worktree_config;
-			the_repository->repository_format_relative_worktrees =
+			repo->repository_format_relative_worktrees =
 				repo_fmt.relative_worktrees;
-			the_repository->repository_format_submodule_path_cfg =
+			repo->repository_format_submodule_path_cfg =
 				repo_fmt.submodule_path_cfg;
 			/* take ownership of repo_fmt.partial_clone */
-			the_repository->repository_format_partial_clone =
+			repo->repository_format_partial_clone =
 				repo_fmt.partial_clone;
 			repo_fmt.partial_clone = NULL;
-			the_repository->repository_format_precious_objects =
+			repo->repository_format_precious_objects =
 				repo_fmt.precious_objects;
 		}
 	}
@@ -2037,13 +2037,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		format = ref_storage_format_by_name(backend);
 		if (format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format: '%s'"), backend);
-		repo_set_ref_storage_format(the_repository, format, payload);
+		repo_set_ref_storage_format(repo, format, payload);
 
 		free(backend);
 		free(payload);
 	}
 
-	setup_original_cwd(the_repository);
+	setup_original_cwd(repo);
 
 	strbuf_release(&dir);
 	strbuf_release(&gitdir);
@@ -2135,7 +2135,7 @@ void check_repository_format(struct repository_format *fmt)
  */
 const char *setup_git_directory(void)
 {
-	return setup_git_directory_gently(NULL);
+	return setup_git_directory_gently(the_repository, NULL);
 }
 
 const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
diff --git a/setup.h b/setup.h
index 1a37089fa0..18092fbf16 100644
--- a/setup.h
+++ b/setup.h
@@ -136,7 +136,7 @@ enum {
  */
 const char *enter_repo(struct repository *repo, const char *path, unsigned flags);
 
-const char *setup_git_directory_gently(int *);
+const char *setup_git_directory_gently(struct repository *repo, int *);
 const char *setup_git_directory(void);
 char *prefix_path(struct repository *repo, const char *prefix, int len, const char *path);
 char *prefix_path_gently(struct repository *repo, const char *prefix, int len, int *remaining, const char *path);
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 163fdeefb0..15eb44485c 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -377,7 +377,7 @@ int cmd__path_utils(int argc, const char **argv)
 		const char *prefix = argv[2];
 		int prefix_len = strlen(prefix);
 		int nongit_ok;
-		setup_git_directory_gently(&nongit_ok);
+		setup_git_directory_gently(the_repository, &nongit_ok);
 		while (argc > 3) {
 			char *pfx = prefix_path(the_repository, prefix, prefix_len, argv[3]);
 
diff --git a/t/helper/test-subprocess.c b/t/helper/test-subprocess.c
index 8a070e47cd..a8194d24b3 100644
--- a/t/helper/test-subprocess.c
+++ b/t/helper/test-subprocess.c
@@ -9,7 +9,7 @@ int cmd__subprocess(int argc, const char **argv)
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int nogit = 0;
 
-	setup_git_directory_gently(&nogit);
+	setup_git_directory_gently(the_repository, &nogit);
 	if (nogit)
 		die("No git repo found");
 	if (argc > 1 && !strcmp(argv[1], "--setup-work-tree")) {

-- 
2.53.0.1185.g05d4b7b318.dirty

