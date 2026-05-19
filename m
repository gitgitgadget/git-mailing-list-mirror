Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDF395DBE
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184374; cv=none; b=o9EJXMiCqenm2+SdqAha2oXjuzqbdNfMkOLO1XP8budxDRN2QuJc3lGmdt5zS4k0no+s9OrQgcRawWgoc61W4Rzk82EFpmgIkUpY4U2uw29qo1VWCpsOBvan+lB0jJy7kQbcCLpDD/LYqwEa6TZ1ezJyvOXisYJQzErWen20gMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184374; c=relaxed/simple;
	bh=cXajPxJmtbajbKygva/lQmyxMlmkdWQSDvGisFj/XdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OWy7FiiFM9lb+zEkPL3gkNS7bDEAGc6lZk586gb9lhZLpSi9opXobjqk1ADDYiu3sklIGwn9cdxfOIcWJ+zVSwE6Vigl3KW1c+Oyl+2CIaAMJQm8wjI32izCuHCZ4Au+xvhW1gGqPwl9qv15eVE2oaNQLLTycM11g3HK7YqfBhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vf+av03G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R+A8dwvY; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vf+av03G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R+A8dwvY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 56B571D000AA;
	Tue, 19 May 2026 05:52:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 05:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184364;
	 x=1779270764; bh=PmNyxHJYFvZV61WywJglXJquVFraeF9gKRp2fkrxscw=; b=
	Vf+av03G0SQx+TDie+GwpqTQpnQxL3Oq1KBSfSgx+MO+UaBLksL0LzGj+Og2rrdn
	dE0BrB8UD3htY0BPFwARIBUmU+9C95//Y1fk7ngF2PBusOEMQYveitDB8DW8P4dv
	RMSE8ymdmqjxsQAM965xaIHrR/dEL7ot7mZ3NSuYyNU8JFiT7bp5azrwl4cg1c2c
	ZiypHhmMetpPUkEYekegnOeE7bjE6R6LxIytI3F5y4lYGk83jKlvKrYdnVLGdHIv
	2/PUmnBnvnLy8DCW5+0Mtt243u4dCz7WFUFXZJhu14rtd3s0ysShzvash6TdQQeW
	ElIfbqkjHYXhSP/umaCD5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184364; x=
	1779270764; bh=PmNyxHJYFvZV61WywJglXJquVFraeF9gKRp2fkrxscw=; b=R
	+A8dwvYs8FknnTk2rHqNnC5+tSr+vhXXt6BQTkmRgdSp/TXLeCgO/W/S5wS+Hih0
	Ol7FeosRs9CXRCv/gehQ4QWbxIwJhO2A1mYpR1hXARoT+4nczPfl92tOhl9XdWVf
	f/yIRLmTQAA3ITfP88JqjhC682OPWsG9xiMkjrMwA3kumUzSRnet2LxD4eTkkEaE
	bOj+enWENR/UXYZLE+Rwk+EdiG55ZKG78ma+iP9jGTGdR6ghz/IwCSE0Ra2E2Mih
	HHA7d2NcX3vFhNXGhFgugQEXrRPg7VGcJ/JTdjPYZwO05WYSlebztIHCXDHeyUV9
	CJKr0hfzSf5IRqvMNM4yQ==
X-ME-Sender: <xms:7DIMamhOx6TuKj9PMShSznXCZ68_tdOUDfHicKRKQLDHOpeYeHWqcA>
    <xme:7DIMat64Wszr_nTxC3ZhnWW6wZEqvH6d-xpi9Ja456bMvbPmKeIDoGPzYblv5wcQn
    gockbKUIusHBfbHBgkpIQXX2nTjtub6odTydDT7fhwl0mEkJBfe>
X-ME-Received: <xmr:7DIMama9chhX31yOPZqLUAfxCXSkK5dkhDV6HyzrjQufF4XTm01b-gkZqq8ke0X-6upFDiUZdVjNvRa74ZkM6mDpskF6JwCeULPxEH4vHP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7DIMaq5yrRLKPLFzcsG3_vONHpURK3GF70rftyeKzG_0f3-T8SIzyA>
    <xmx:7DIMahDlX5qJ5hziGx5mbW1wGwkBuBld2qpwggzGGgVl4pQ9UnTiRg>
    <xmx:7DIMaodBXfFHqj-bKoI2otgA16nhZJdWWB8QpAOMTMYPRxc_0_N4sg>
    <xmx:7DIMaoJ4QV6PY02P8Zqc1zYLEPU4sPc716d5UbUfPkXYnh4ndHTe9g>
    <xmx:7DIManuuekQMZfL6UM2bwJD6vDjW7MUjFqF83bWlKPHUB9oo6t16dh_x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 51c9a1df (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:16 +0200
Subject: [PATCH v3 12/18] setup: stop using `the_repository` in
 `setup_git_directory_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-12-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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
index eaede42c4e..2cc018fc5c 100644
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
index aba60d5712..a84fc860ec 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1557,7 +1557,7 @@ int cmd_main(int argc, const char **argv)
 	int nongit;
 	int ret = 1;
 
-	setup_git_directory_gently(&nongit);
+	setup_git_directory_gently(the_repository, &nongit);
 	if (argc < 2) {
 		error(_("remote-curl: usage: git remote-curl <remote> [<url>]"));
 		goto cleanup;
@@ -1605,7 +1605,7 @@ int cmd_main(int argc, const char **argv)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit) {
-				setup_git_directory_gently(&nongit);
+				setup_git_directory_gently(the_repository, &nongit);
 				if (nongit)
 					die(_("remote-curl: fetch attempted without a local repo"));
 			}
diff --git a/setup.c b/setup.c
index 8965f8ccaf..c12c6cbda2 100644
--- a/setup.c
+++ b/setup.c
@@ -1862,7 +1862,7 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 	repo_set_worktree(repo, new_work_tree);
 }
 
-const char *setup_git_directory_gently(int *nongit_ok)
+const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
@@ -1877,7 +1877,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * configuration (including the per-repo config file that we
 	 * ignored previously).
 	 */
-	repo_config_clear(the_repository);
+	repo_config_clear(repo);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -1893,18 +1893,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
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
@@ -1984,30 +1984,30 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
@@ -2040,13 +2040,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
@@ -2138,7 +2138,7 @@ void check_repository_format(struct repository_format *fmt)
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
2.54.0.771.g3ed373ac14.dirty

