Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6F3B892D
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783408912; cv=none; b=U1OXK38zZ40HImbHG54eftMXQgkAhALysslhKw8LkBXvIvxdqXlScigWLaC4DKmHOxMclYTL8UUs2aqvCqGhUQ5F3GcicznXRBHVUxU/dWO8yXmgZ8zbsF5C4Ai3ofanhqJ8tmpZkNLQkydt1YnSdnJXnKqnrrOZcaOBfPPxD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783408912; c=relaxed/simple;
	bh=KhJ9RjgCvl5h/NUIcflStsFCAfQrAbFCE/moeUQrK48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2CtATfuFYVWnj2umoUcWq7fiiaLoIrl/5SmusX2Wa00knwLMlF20/zrsfM6WnUKw2Y0ZEkFKqdgmdbgrQIItw4g5wPjUhMdYnkgGjkLUeVCk886o6V7JwI7DhASTLZUzFqt0Uw4dmC8rVGw/Sd487xvO0by+Wni37/SaOXLhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GQl8gBmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g5ftzSHE; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GQl8gBmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g5ftzSHE"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E17FA7A01B2;
	Tue,  7 Jul 2026 03:21:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 07 Jul 2026 03:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783408900;
	 x=1783495300; bh=tfBHZ0s1tMh04MO8q4XhqGkUGlXeTw1UuUjo6CUOc88=; b=
	GQl8gBmVTGTvjyCEOTASNODqeeC75JUs9cmc0qxldm6v2dFDbDvcBz4YqUtdpMU3
	qN/iMlJhYc0F0Ok7OP1JUKRKwomHfJaiDVFJi15DFoCpW05+c49Ca3Hn1tg4TRXu
	Qy7Jr96pm1ngClTyoMNjg4SPgrLDxWCGNTUkf7Q+Ee1ULpnsznbhCf5YcPeMKTXu
	O02p1i2wRYxFUwLhB41fq/Lhj/vRj/jPrMbFJmfcLe4VowhCPNpldUW8+4agMtNi
	biwdeYft1b5WEDUXxAP50LxrP2/wCt6xTbJp/osAqe0HbkPH3mTwsHDCtvYGo9Nf
	8H4UCzrMYqDLGNAHjzlz4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783408900; x=
	1783495300; bh=tfBHZ0s1tMh04MO8q4XhqGkUGlXeTw1UuUjo6CUOc88=; b=g
	5ftzSHE0yRRuB2nVWFoyEX8uiy0lci/Y+fO2WQEkzbTHw270Fjw+guyfRBwb0H+A
	2vFHTBh7+ral4yi2/CIbRoDQHssDqmXjrNOeGMfVEqIQLkCyAgjpUn7QXnbVg/OF
	HtL0Q02tfsXUWGV1G3rA92esAtlZAT+FEFXwXe8TVyQklQtAYXPhcfBlYRmHGc9l
	QwIyQ1livjgH3WYYI73A7VYRDr2JH+P4guL25Bxry1Q35GnoI5gi1gAfls57lgfn
	pTcWkzwYn9MVJuVEtC6fRpLA7WOVyATz2U4cmWgqoDPc+XqW5S6wHZtOfR/9QcVj
	k3NxFMSIKkSMnIM/Cy9UA==
X-ME-Sender: <xms:BKlMagbHxuuR41h19SWiVHT2E7QkSzr1Uv9-QlVnbYswvD_mbGmftg>
    <xme:BKlMai0ZzFm8Syn3y09MUsGHxU-CZQmJ1_NWjz3bWpDavkqwAFpfWoJXToUd6BSqU
    ycl-p0uRFqegZZsojwGSe9mfbVKLtHVQjJr34960r6DNRdKBKO2zg>
X-ME-Received: <xmr:BKlMaoUufwozM2kRH0cH_I3NLclAL4Og-UvjR5ZSDZyGtgmG9ZvfnngoR8Ao2nIuJL7OmXQai9eWs179BnFJRdUvUfgatzQDdC0hHBPyjg>
X-ME-Proxy-Cause: dmFkZTGN43lq7lHtzoztmsp2ha3377ph9aD/+BVx8B3RlzKxJTITPwJpgbD06HEEJ5Ah07
    0LxTetEuoADDN+Mls8RD45ALjsaPLIReBcQJPOvQPTry8ULvEMzVHzXlYRPjSpMIeerVH5
    p8Rmz3b79H9S7nsP+1mbJhQJ0dy0Xv8QbVJni1FpZizZ7kpWPdWX++YgEoJpRO2Tl8a45W
    5SlNg+T0N5LSUaaqyinki7fdkmBnThGqUuHMxdk/nHtieM4TbfGnj2CEBrJs4aOV2HRq59
    IgODDry8R917oTbxnFbKbkjSTMUTDvzcg5AUPmrfe2SFRp3e4X2egtqQl3BbleTxAhjAVU
    6f8OBBxyDELi4GLJvfhWKcSa8KPa3zeOfRyasXOVm/AUTbREtVIztBI+NiisTTeO36qJpn
    COaZzvZK3vq5rZg70E9yH103NFejy5y+/UMp4KDkyr/S/AaCyHvmaFOidMlJEsrA93P3S/
    dpQ2Cd4ucdJNrs2CA2D2zoguCBP87fdSR6+XqWdfbABFWuHwibMl0mV5jOrqrteIIpt2Da
    xw8uFPhurVPYJfdKNsVPwVNmhtb/3hVDo+4Hpl3ggRPF+c+/n1OyL5Aabj7JVUk6vkgqFd
    1Xu/EniMt80S8OJzacL3jw2TH4IiEKXqobjcueegu/rroGWPP0SyUKSNRemA
X-ME-Proxy: <xmx:BKlMakXQWN3h5OMZj11OW4XsB9xcg9_MV9LD6sXJOzFLlguC6JAddg>
    <xmx:BKlMavcm7Ekkp1xfmH6PE-VzD6QPURJOddtI9EEBUU0PfpkYt_67PA>
    <xmx:BKlMalUC1MwZDemk9x2cUSF6q9xbILXBKjOXAKwiZuIVqsZa-AHCew>
    <xmx:BKlMagdmjPq-4jZ-5x6Yelj2PvOGzcbqVcrhJBYoznEbABz4UVw-TA>
    <xmx:BKlMaq0dV8uJt9v_tBgG2spk7V5wBX7rUgpNDrUmzCxk__Ca1p4HIYWt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 03:21:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0e31533 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 07:21:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 09:21:23 +0200
Subject: [PATCH v2 04/13] setup: split up concerns of
 `setup_git_env_internal()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-pks-setup-split-discovery-and-setup-v2-4-aab372cd227c@pks.im>
References: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
In-Reply-To: <20260707-pks-setup-split-discovery-and-setup-v2-0-aab372cd227c@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 85fad0d77d..324a235dd1 100644
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
2.55.0.141.g00534a21ce.dirty

