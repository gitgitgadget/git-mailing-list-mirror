Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8FB17624C
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008971; cv=none; b=s/4VeRxTrjMK+ZRowL5L1Gfqwm6TIP23JmbN9TSdj905OlYc9rV/51PRSVXuZQzOb1EnBQMI9c6TY5Nc3D3rgzCo3lgyAsDIjDLoe8K3gz7TjkFwCBl2HPYhs1IQjfh3U3sOcLaDp2vNFNMfYVErOWJRKJTmT4GUKjlo+Rne43Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008971; c=relaxed/simple;
	bh=vmg4O+C43gbc9a8720xG2Q3KVd0rdRalkEh7ez4EREk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=th94RvBif8Bd8LB0g9PU2cBG3PIQlJK6ukJL6e/NzwtU8Il168GUi5FJmmLi+Fnw1hrMTNHwqxPUprBmhWbw/G/u5LNhhvEs0Dswg6vX6fIII71IkqkVGu0nXunjaDZR7OAIFfaaMrG6FfYMXTktjKOB0jCgcjU9CKX1ZypzDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jC/dovee; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RybAKDYV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jC/dovee";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RybAKDYV"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38FC3114022E;
	Fri, 30 Aug 2024 05:09:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 30 Aug 2024 05:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008969; x=1725095369; bh=h1LTUd8Wuu
	kzG8rpzc69xe+z4sTBiVd+qWVELezsM0I=; b=jC/dovee65YYP7ETQ+pqJBiQNA
	A+MJVPVji7ykPd8uRMNg+yqYN1B48te/gSCoM/teO26rjcU3kj+p+aGp6GMlNZjV
	JH7/Jfp8N2Oo5wfjRAz78otTYqzqJdKP1DotD4odF60W+bDgVA2v0nD1b5yB3WHc
	eUDhnFphtYRJRaKHSfP66pgV0yAef3AYuu+2FKGW8u7OugdSfgeJ4DXE/0KvNu0X
	+S8ttNn9KFQ6+ytkZ1MxrVVGqZpAj9y7BW7ESW6gX7xMTSOHZ12hyHXKLYbuXfj0
	YpN5BqDf/pTcTpsIdeStiWVF3k0dnKRRfgGcOPMeThZztDKs5pWy3CA4Vrvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008969; x=1725095369; bh=h1LTUd8WuukzG8rpzc69xe+z4sTB
	iVd+qWVELezsM0I=; b=RybAKDYVjgGwHCMxFSIO7dmYGDrFbRe4vHvENNfAMfWl
	E6RH5kfw0DeWcrap18TqOSacWY2YyvKKGls2Mjkiw7o/UySUoxNzrr+SL14SAD2e
	YwY3VQKsE6Gn3J99ClygAQrxiChIQ4DpAvKJ/DjJD+rodj2/NW3bn8gmwaUkKR5O
	JFSyuKkBXl6n+LRf5IuRjHhRtxsx9MIL131ZpYxSxs7uy6+MSIoD395Ied5LlU5j
	aUxumgszZK/d3kF7+XOhQJA+a71B95J32FvZtpAQ61vCSGGdtlXm1tD0sinAdiQX
	fnrxEP1FhAKm82qs3K/IBYgpDlBiQI/h/rRG4cWkBQ==
X-ME-Sender: <xms:SYzRZsk-7JsV2qPWB_oa86ccP-mZ9Ch0M0kr1P-2IM2axpHxzQfoRw>
    <xme:SYzRZr1tQRunifu5fhkKnRgCODGiL5oN704PkKphJLwW8nZSSzmYCP2B7Kh8_p5EB
    qm7fhW4E8qSELi4-A>
X-ME-Received: <xmr:SYzRZqrfD2slf5ovzRzWDEkFgKMBkFxyXAkUmIcr-D2q5VoABZVdy9NPJlzeVJSBlSnFL_Pj7V77KNh4w3t63hnb0Ymf08Xv7DPLJXWJfKSyURZIxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehj
    lhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:SYzRZoljULp_rbgfX5wOaeUNgmfG73or4esxBeK5bcoBWTdPJaMFpw>
    <xmx:SYzRZq07N1qRF38z_dISAbLs51U2ueWpECqAkcxJ_CM6TZ9UQ75Tog>
    <xmx:SYzRZvtyhJN43-sJc079zdF5oyiECSidCDyRrNHiMOl5Gyr3r41R7Q>
    <xmx:SYzRZmUItOqbre5IhfIYpceO7zR0Bqm9cmbJGafVpsHwA2MPlet_bQ>
    <xmx:SYzRZtRe9lhhdE7xIjQVOU2Zb93oZnsF775felwl8vCQnKIUfEyYsN9q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8b42ea6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:17 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/21] environment: move `set_git_dir()` and related into
 setup layer
Message-ID: <9e0e2528b9434fc10d5f4af92e1cc1667959cb42.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

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
2.46.0.421.g159f2d50e7.dirty

