Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D862E175F
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673405; cv=none; b=rEns4A1VN7hcpQ+faeL6I+K5cOYLb29M4+g8q4J8XO4B9m8XueQ5Z2nvHub5ShazHE6X5CS+L1cAsE7sOhSMYHSOUa7AW9r75/yws5WHD3C8ha8wC4SmYdBrXI/6wf0CLmFO15XvkkPCP1l7ghASk9UR52KqhoV0xJdNx3FS/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673405; c=relaxed/simple;
	bh=y2vxbh2BniEmQ2uIMUsiYZnZU5ikGcSvJIKT8SxsV5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+L26XwlnDRtbn7c8gLZQUIumYdICB4W/kEGBUOaE6p5679coSPkOPpHmBjaIXBEHLgfW976onJTWxIWoRGqa4ddz99WinzuNUlfxagMBPzuwiRFz6SAzSPMdNJFMTbOZeAhTR37IHK/Ai9ElO3+aDU/N+4Vtkavmx9z4IXmlug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OQejm6Xd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qq4t9AR1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OQejm6Xd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qq4t9AR1"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CE40140011C;
	Mon, 20 Apr 2026 04:23:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 20 Apr 2026 04:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673403;
	 x=1776759803; bh=Agpk2V92f3P+G6xf6XpAX5Y04JdZNeJyNxP0YsqClXA=; b=
	OQejm6XduvtBwbCTaP4tnP9J0lKlDpRwBlL6WP4I7zQWQQCTm27CQ3UyQCag2iLZ
	U1JtwssY3dXuKo4IaWT3h4taLOImel0r0aBT6UJc9z/RAqCrF56EC0MgdvyuLDTm
	54DfTpMY6IvYqokQAktip9PPY+pARlwmMfFcvnQARpEJf8s1AqXEG8qRvBKh3voi
	uF1grfaSpjmZyBEWCxRa8F29IanOxWnaob74jLgR87h3+apkFlvlKG13e1n4HhYP
	eTljLEuqIfa0JiN6X2PtVMUeD607mqui2vpY8n0dmjqkZJwuAR5lJhjkCtyL4QFQ
	yDVw8fuPX1jqEmglHKBXpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673403; x=
	1776759803; bh=Agpk2V92f3P+G6xf6XpAX5Y04JdZNeJyNxP0YsqClXA=; b=Q
	q4t9AR168OszPwqMqvt7k4vAmxesqRE8qXoOcK6RJ6s2o1yzcTIQnk++2pd0uLUQ
	2VWdxaojomHCu0aVGmnCTaauD+gptEwVBIqRSk4M8nc+Qt7WeahxrnB0++YFX78V
	I80Ixh7jmlYxlQhbrJxGPwCzQS8tCRMiX71iQDBDSK3jjXQh9GhrJTE9A+gyWqJO
	S4QfuRZOi6ByWUehmcFBCNKrLHTInqyeRYJUAMX7gBkKfKSDpOsWIXlNl4PpGrvE
	31Ar9MQDESfzyr/wPq6rH6M1yOBUDFjUjOiA8jRXlJXqP2kzifpO4CbED1RJokbN
	30JBy9Hh2TQMpmsQO0IPQ==
X-ME-Sender: <xms:e-LlaSXM7Nk9TZLTS60wwbAED_qY37PpnsS_RrJafVmKf1kR8U6Erw>
    <xme:e-LlaVnqhjQfewBmOrCxe06PKVGswIJSmI4wzn5nGApEFUxB_cuodUOnz2rADQJ1x
    ecSWrZRh_YahW30dVS3QU4DJuKPQnHP-Vpq8q4Z0C1QaTFvQSMAbA>
X-ME-Received: <xmr:e-LlabbL8zn-q5VvqunMBu1c96mICLf9-mi4P4O30XdbKsRQ_x07col4-GsGPGT6ML7zC544dPzmwuEk7jDi8MTchSH0yT28QhVM_JIyg7DM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e-LlaYNOuy54xIDb81CIdn_h9YOk3BMl1Zg3xi_YFRiiGuUEsvVCZw>
    <xmx:e-LlaYZVT9bVdKPpyfF5i0hSRWdRIHInYylV4jPhBzJmIwJZdaq_aA>
    <xmx:e-Llae0bvOCqtNWUGwqCXlawnHbF8gIrXVvqFl_l7gcDsH0LP5Zi5Q>
    <xmx:e-LlaWfllX3Tv_dB3gAxRhNbMixw3bopqki6bsUIGZSaIQPYNHCP3Q>
    <xmx:e-LlaW5xcFUyuIFAttwvVkGiAuxXL05YY1zFWAM9e3u-IFaaqptGT5E->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8fcbdf9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:42 +0200
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
Message-Id: <20260420-pks-setup-wo-the-repository-v1-12-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
index 24f230567c..7242a18740 100644
--- a/setup.c
+++ b/setup.c
@@ -1853,7 +1853,7 @@ void set_git_work_tree(struct repository *repo, const char *new_work_tree)
 	repo_set_worktree(repo, new_work_tree);
 }
 
-const char *setup_git_directory_gently(int *nongit_ok)
+const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT, gitdir = STRBUF_INIT, report = STRBUF_INIT;
@@ -1868,7 +1868,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * configuration (including the per-repo config file that we
 	 * ignored previously).
 	 */
-	repo_config_clear(the_repository);
+	repo_config_clear(repo);
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -1884,18 +1884,18 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
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
@@ -1975,30 +1975,30 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
@@ -2031,13 +2031,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
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
@@ -2129,7 +2129,7 @@ void check_repository_format(struct repository_format *fmt)
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
2.54.0.rc2.529.gd9106f7525.dirty

