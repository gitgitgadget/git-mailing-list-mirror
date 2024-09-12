Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42018E043
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140600; cv=none; b=K12H4vj5zxfrkMA8quxaBbInNVCi7fG50EZSw1RSeqnj+8yDpRaHUeMPimJXmi36vOm9u7bAoKsa6RMNzC/0Xgosee23xWS97WnGiU2Srq/ndlOUbvWoO8cTOskRX7C7jGYRHA9vdcg4XMLCnqE/UdTEPSz4EMVO57Sccfunlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140600; c=relaxed/simple;
	bh=rXrxOUiglOTReDdqdjkEfEM/zPSH64LxKP8xDk2JA8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+H3EUOivZhVjLx9Ttq8w8jNhEQ7ye9SYr7NYiMaZAVvgadoin8uIsETzVC6hZjCcQ7bIadiPMicicTVL0Gpnx3oAIqq+b6/25Ne792DtoQId2a9CGJhsdPcaH78tuKE1LZ7T7iLVMe1J4UHVMgXQeQGMEdgN5TlPAb0uNixmYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WCODk+rv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqncLUsd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WCODk+rv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqncLUsd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 77A1E11405DF;
	Thu, 12 Sep 2024 07:29:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Sep 2024 07:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140598; x=1726226998; bh=BrtEbDbCMD
	Q2twxdtHYway/CZE9075hCnWTgjb1fuEQ=; b=WCODk+rvh51EQxm7/yqJHWemUL
	QJM5VJL7tfBArT//KT74AWW4r+9isJTWMFBTJPWmiCRoPJaMIAqxDHjj8qHArJmT
	B5+HnYmF8cTaUN5pXVAxD9gGKNFH7DDGdDcMrAZ1JfAC4j8o5jp5a9iR5JKiB0pT
	Le9r3E/D6f2Q4PFVentyII6B1TdnxuXy4d/yCa5K0oXOmu8qCG7CJzyR3Cr8vGXM
	qqB1AnoJk+FVQoiNjP68e2RA+22sR6m8OYWll0fO4pP/ZwjN3O/Z+QZMVSuDDd4u
	rmhnW/QJXuvWoWKJOMTb7mCCLuQ/5mmYPzpHeUXfu7ZXomFUt9HxorgSGggA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140598; x=1726226998; bh=BrtEbDbCMDQ2twxdtHYway/CZE90
	75hCnWTgjb1fuEQ=; b=IqncLUsdQGOkAs7vbtr7WqkiflmKHXMmyyJfe/lCkw+D
	m1ERpWArEi2dmpxnWSsKFtR5NVm/R6VTEXHzP9dVgxADjVbrqaR9jb2wF3wTACZ6
	m44aluecOoRq3lTGAeubK5RsPV/AVdpeXcTByDPFH/QqKi++jAMi7MwsvoXwDir3
	FuOk26bvnVAmcWXknmPVGMtJyLBGcp0vYTZpi87i3S5HMTsbrvDUkQp9BoKxAbrW
	KFcdCWh3uarQc/jLiHr19/ZwSw1hzE9kNfQRtDmm1e36ZBUTe9o91fS3mQPdT0Ut
	gFu02ID3DpOHP1IZau4MyUqPdrNcIemzHoQxtiplAQ==
X-ME-Sender: <xms:ttDiZl1V0v5bX9g3RDvqnuWtWfwVL-6ZmSfi7ufO7Qhs3hfDEryJ5A>
    <xme:ttDiZsEC8hcD_Rihwhayx84z1SsjFPFsBT9NDlRI3lvWSYnpUVEaBGgfQq1_vwzFV
    TK7uZiLEV5MaMeNiQ>
X-ME-Received: <xmr:ttDiZl7q0H_XIh5ubsYIQ6hm6XLdY4Horsiu6l3qMdGdMaesKNd0iMq42NE473g_PU5xfHpX5AQaIJlaEiKajyu3hvjuAcnBnkf81qLrZIuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:ttDiZi2qD_b8neP-44Pyg-Jg9mTtCiAYs_F_uU3yC6Cf89E7Qo2KzQ>
    <xmx:ttDiZoGnT_vH8kBaU-b4SG3Rh1q2idEcEeW45pwqJCk4elq--k97jQ>
    <xmx:ttDiZj_UOlvM_TlvOH6q-CUth_xXPBgG4bD_zLcNDXRpingng7OH2Q>
    <xmx:ttDiZlmKbnF2C3KJXxGvJ2-Fuonmbvl4kZFnalOMmfn5CS1ATWEtLQ>
    <xmx:ttDiZtOTs97bxmZlSMu1fIM_-hNMRA6bZ3T9AZCZn7RcihBtvS9UWgbJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:29:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 45fc3538 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:48 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:29:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 11/21] environment: move `set_git_dir()` and related into
 setup layer
Message-ID: <437b6f1f30d1e582e2e8a35f43d60a1fccb86740.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

The functions `set_git_dir()` and friends are used to set up
repositories. As such, they are quite clearly part of the setup
subsystem, but still live in "environment.c". Move them over, which also
helps to get rid of dependencies on `the_repository` in the environment
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c | 105 -------------------------------------------------
 environment.h |   2 -
 setup.c       | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.h       |   3 ++
 4 files changed, 109 insertions(+), 107 deletions(-)

diff --git a/environment.c b/environment.c
index 49844418419..64ae13ef240 100644
--- a/environment.c
+++ b/environment.c
@@ -22,14 +22,9 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "strvec.h"
-#include "object-file.h"
 #include "path.h"
-#include "replace-object.h"
-#include "tmp-objdir.h"
 #include "chdir-notify.h"
 #include "setup.h"
-#include "shallow.h"
-#include "trace.h"
 #include "write-or-die.h"
 
 int trust_executable_bit = 1;
@@ -155,41 +150,6 @@ const char *getenv_safe(struct strvec *argv, const char *name)
 	return argv->v[argv->nr - 1];
 }
 
-void setup_git_env(const char *git_dir)
-{
-	char *git_replace_ref_base;
-	const char *shallow_file;
-	const char *replace_ref_base;
-	struct set_gitdir_args args = { NULL };
-	struct strvec to_free = STRVEC_INIT;
-
-	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
-	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
-	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
-	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
-	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
-	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
-		args.disable_ref_updates = 1;
-	}
-
-	repo_set_gitdir(the_repository, git_dir, &args);
-	strvec_clear(&to_free);
-
-	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
-		disable_replace_refs();
-	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
-	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
-							  : "refs/replace/");
-	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
-
-	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
-	if (shallow_file)
-		set_alternate_shallow_file(the_repository, shallow_file, 0);
-
-	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
-		fetch_if_missing = 0;
-}
-
 int is_bare_repository(void)
 {
 	/* if core.bare is not 'false', let's see if there is a work tree */
@@ -243,71 +203,6 @@ const char *strip_namespace(const char *namespaced_ref)
 	return NULL;
 }
 
-static int git_work_tree_initialized;
-
-/*
- * Note.  This works only before you used a work tree.  This was added
- * primarily to support git-clone to work in a new repository it just
- * created, and is not meant to flip between different work trees.
- */
-void set_git_work_tree(const char *new_work_tree)
-{
-	if (git_work_tree_initialized) {
-		struct strbuf realpath = STRBUF_INIT;
-
-		strbuf_realpath(&realpath, new_work_tree, 1);
-		new_work_tree = realpath.buf;
-		if (strcmp(new_work_tree, the_repository->worktree))
-			die("internal error: work tree has already been set\n"
-			    "Current worktree: %s\nNew worktree: %s",
-			    the_repository->worktree, new_work_tree);
-		strbuf_release(&realpath);
-		return;
-	}
-	git_work_tree_initialized = 1;
-	repo_set_worktree(the_repository, new_work_tree);
-}
-
-static void set_git_dir_1(const char *path)
-{
-	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env(path);
-}
-
-static void update_relative_gitdir(const char *name UNUSED,
-				   const char *old_cwd,
-				   const char *new_cwd,
-				   void *data UNUSED)
-{
-	char *path = reparent_relative_path(old_cwd, new_cwd,
-					    repo_get_git_dir(the_repository));
-	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
-
-	trace_printf_key(&trace_setup_key,
-			 "setup: move $GIT_DIR to '%s'",
-			 path);
-	set_git_dir_1(path);
-	if (tmp_objdir)
-		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
-	free(path);
-}
-
-void set_git_dir(const char *path, int make_realpath)
-{
-	struct strbuf realpath = STRBUF_INIT;
-
-	if (make_realpath) {
-		strbuf_realpath(&realpath, path, 1);
-		path = realpath.buf;
-	}
-
-	set_git_dir_1(path);
-	if (!is_absolute_path(path))
-		chdir_notify_register(NULL, update_relative_gitdir, NULL);
-
-	strbuf_release(&realpath);
-}
-
 const char *get_log_output_encoding(void)
 {
 	return git_log_output_encoding ? git_log_output_encoding
diff --git a/environment.h b/environment.h
index 682d4f2e3b5..b8460396790 100644
--- a/environment.h
+++ b/environment.h
@@ -105,10 +105,8 @@ int have_git_dir(void);
 extern int is_bare_repository_cfg;
 int is_bare_repository(void);
 extern char *git_work_tree_cfg;
-void set_git_dir(const char *path, int make_realpath);
 const char *get_git_namespace(void);
 const char *strip_namespace(const char *namespaced_ref);
-void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/setup.c b/setup.c
index 1bfec288ab6..19cce5afa72 100644
--- a/setup.c
+++ b/setup.c
@@ -7,16 +7,22 @@
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "refs.h"
+#include "replace-object.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
 #include "setup.h"
+#include "shallow.h"
 #include "string-list.h"
+#include "strvec.h"
 #include "chdir-notify.h"
 #include "path.h"
 #include "quote.h"
+#include "tmp-objdir.h"
+#include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
 #include "exec-cmd.h"
@@ -1613,6 +1619,106 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
+void setup_git_env(const char *git_dir)
+{
+	char *git_replace_ref_base;
+	const char *shallow_file;
+	const char *replace_ref_base;
+	struct set_gitdir_args args = { NULL };
+	struct strvec to_free = STRVEC_INIT;
+
+	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
+	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
+	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
+	args.alternate_db = getenv_safe(&to_free, ALTERNATE_DB_ENVIRONMENT);
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT)) {
+		args.disable_ref_updates = 1;
+	}
+
+	repo_set_gitdir(the_repository, git_dir, &args);
+	strvec_clear(&to_free);
+
+	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
+		disable_replace_refs();
+	replace_ref_base = getenv(GIT_REPLACE_REF_BASE_ENVIRONMENT);
+	git_replace_ref_base = xstrdup(replace_ref_base ? replace_ref_base
+							  : "refs/replace/");
+	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
+
+	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
+	if (shallow_file)
+		set_alternate_shallow_file(the_repository, shallow_file, 0);
+
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
+		fetch_if_missing = 0;
+}
+
+static void set_git_dir_1(const char *path)
+{
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
+	setup_git_env(path);
+}
+
+static void update_relative_gitdir(const char *name UNUSED,
+				   const char *old_cwd,
+				   const char *new_cwd,
+				   void *data UNUSED)
+{
+	char *path = reparent_relative_path(old_cwd, new_cwd,
+					    repo_get_git_dir(the_repository));
+	struct tmp_objdir *tmp_objdir = tmp_objdir_unapply_primary_odb();
+
+	trace_printf_key(&trace_setup_key,
+			 "setup: move $GIT_DIR to '%s'",
+			 path);
+	set_git_dir_1(path);
+	if (tmp_objdir)
+		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
+	free(path);
+}
+
+void set_git_dir(const char *path, int make_realpath)
+{
+	struct strbuf realpath = STRBUF_INIT;
+
+	if (make_realpath) {
+		strbuf_realpath(&realpath, path, 1);
+		path = realpath.buf;
+	}
+
+	set_git_dir_1(path);
+	if (!is_absolute_path(path))
+		chdir_notify_register(NULL, update_relative_gitdir, NULL);
+
+	strbuf_release(&realpath);
+}
+
+static int git_work_tree_initialized;
+
+/*
+ * Note.  This works only before you used a work tree.  This was added
+ * primarily to support git-clone to work in a new repository it just
+ * created, and is not meant to flip between different work trees.
+ */
+void set_git_work_tree(const char *new_work_tree)
+{
+	if (git_work_tree_initialized) {
+		struct strbuf realpath = STRBUF_INIT;
+
+		strbuf_realpath(&realpath, new_work_tree, 1);
+		new_work_tree = realpath.buf;
+		if (strcmp(new_work_tree, the_repository->worktree))
+			die("internal error: work tree has already been set\n"
+			    "Current worktree: %s\nNew worktree: %s",
+			    the_repository->worktree, new_work_tree);
+		strbuf_release(&realpath);
+		return;
+	}
+	git_work_tree_initialized = 1;
+	repo_set_worktree(the_repository, new_work_tree);
+}
+
 const char *setup_git_directory_gently(int *nongit_ok)
 {
 	static struct strbuf cwd = STRBUF_INIT;
diff --git a/setup.h b/setup.h
index fd2df7cd525..e496ab3e4de 100644
--- a/setup.h
+++ b/setup.h
@@ -94,6 +94,9 @@ static inline int discover_git_directory(struct strbuf *commondir,
 	return 0;
 }
 
+void set_git_dir(const char *path, int make_realpath);
+void set_git_work_tree(const char *tree);
+
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);
-- 
2.46.0.551.gc5ee8f2d1c.dirty

