Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7564118E75D
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924345; cv=none; b=jeu2rSXHs6LIsLJKCTZwpvP/acOlbKKPyDpCwu9WrXMqSEZ7eVoBIjK9LWr1XgqQO7jZFn6fiVF+4ojyT6FA/3kxisC/f4VT0RN/whRt/EzPhqM+pkGZOORNYbPP0F6lgUu+QLt2CQU0NvQZ+j3lRdxHqxPiwCz+Gt1ajB26FgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924345; c=relaxed/simple;
	bh=+OFXAcgoVOhiOvSYh00zQIke64MpS8p+PvIiSliGWBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5hIQIOb9UaBpw5zJW00Tp7jBpruKXYw7UjtCU0pl9R0dVQCRbKvAn//coCiOdTVYzYDuCtyZ82ZujppOGLO9/1lvEF1nul0vlEzEk6pUwCTmi4xhfLW75RwfQz+7N0tFMwBSo0TQ/b1hIjRiqobTnBb9x7wnD47JQwL8B+rWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mmv/vP5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A34FvVO0; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mmv/vP5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A34FvVO0"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0A7071151CB0;
	Thu, 29 Aug 2024 05:39:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Aug 2024 05:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924342; x=1725010742; bh=NOS00PYJoc
	bEQi9lJL4zQpVlvLnPJU6sNrfNxEaxCQM=; b=Mmv/vP5JCZBtpPl8crToJ2UitA
	PJGvOK5AzDGyOGe7bbChagDL2JdZ8+cp58Ru2mk9fAl9djpK8rDn/GwoC5O4wf0v
	wsSCdJCOrrhvz/PrmeDKaOcwS3OxcjKcXSGszbMw2VFRp0iapSnVdHafKyVnLbay
	YpmUEFvM5xadJenuD0T2nGSkkx/hgWKV6WNQiy2QMRyE5SI/EpVUKSe6RAVqQEfj
	vvSTpBTAmgkVh5qerT9MU+IdOFcLIDAZwgyctpBnH8NCxoExexcaC97KINo9JY0U
	uWkgdbfgDiKa+XUDPSS8zIMTdwjiVxGuEGZ1zmo5D3g3LKWLvF1sUr4YYe5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924342; x=1725010742; bh=NOS00PYJocbEQi9lJL4zQpVlvLnP
	JU6sNrfNxEaxCQM=; b=A34FvVO0aXT9m4evcRNfG+LxXvEOeOFsyKRrP06rrsjq
	vaoneYTgbPKZQROEGa4UsJRvRD7Rstap7LQ/Kospg1BkxOUf/CrJ6Zu8f8Sec+Dr
	mkJ7xM3HdbFRNFXZ0h9HEJyZq1uFYdOO1/969M2M8pyXbmQroK+MGTZFURJiI0uB
	X5tGUAksVMXrQeXOjC+1yqeI/vFN3qgz9RzAgVpN0wE+S4hrs48zqX7UKbmsdn0G
	dAchDvC6NY0hL8dEC2znRZ0DhDrWZoB0sB+If4HPjPMbiJhbeGU9b1VVJzlcfxr7
	GWDdzo0k/iTKNjvGyJjwM2stEs48RN3686APJhYXGQ==
X-ME-Sender: <xms:tUHQZv-dF_RfhdAE8OIT3dRMhGIb7LzOJtB0dtT3AIsLjBwPKr4n9g>
    <xme:tUHQZrt7CzfWCYnB5PNoPG_pd5qFWYVa7NEw1p79PkncOHJoZI7MNc1AENy87xrYe
    CbPBXvkL22hbw5aJQ>
X-ME-Received: <xmr:tUHQZtAI0vJL4CPRbKnK4UWxWo6cB1X0Z9Cv3ZNzBl-7fBf6oqTphxcQXaeshuiu5ekXTNU7Y8GsoNCbzOltNfbAwtFpGi-AT1X1pAZaY557dVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:tUHQZrcM_NsUrjD7f-Gs9ig4dG2oIX3lP1i68ZMQV-O-ljvXc0BxuQ>
    <xmx:tUHQZkOYtcShB9T37e26aAXLlHXwi6ysTWW6oE3WpJ4LKf7WVJa8CQ>
    <xmx:tUHQZtmiyOBSzyC7x_eMQDF6dI2AzmhBXh7qJJKz1q4SgjGmlpFGyQ>
    <xmx:tUHQZuvdZbhWoVHigcyIaGRORgOSwviMoVxkaF7Q8UxFlFKvZiQpcg>
    <xmx:tkHQZtZKdIBdBRJQxktUC_aVKDPlsaLj4bsbneGD0mwgaf9A5AcXtckn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6bff9a45 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:52 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 11/21] environment: move `set_git_dir()` and related into
 setup layer
Message-ID: <c20f6c04dfaee67ffdb8fbcad31672fd6348bb8b.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

The functions `set_git_dir()` and friends are used to set up
repositories. As such, they are quite clearly part of the setup
subsystem, but still live in "environment.c". Move them over, which also
helps to get rid of dependencies on `the_repository` in the environment
subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c | 105 --------------------------------------------
 environment.h |   2 -
 setup.c       | 118 +++++++++++++++++++++++++++++++++++++++++++++++---
 setup.h       |   3 ++
 4 files changed, 115 insertions(+), 113 deletions(-)

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
index 1bfec288ab6..a4a9fbb3a2a 100644
--- a/setup.c
+++ b/setup.c
@@ -2,24 +2,30 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "chdir-notify.h"
+#include "config.h"
 #include "copy.h"
+#include "dir.h"
 #include "environment.h"
 #include "exec-cmd.h"
+#include "exec-cmd.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-name.h"
+#include "path.h"
+#include "quote.h"
 #include "refs.h"
+#include "replace-object.h"
 #include "repository.h"
-#include "config.h"
-#include "dir.h"
 #include "setup.h"
+#include "shallow.h"
 #include "string-list.h"
-#include "chdir-notify.h"
-#include "path.h"
-#include "quote.h"
+#include "strvec.h"
+#include "tmp-objdir.h"
+#include "trace.h"
 #include "trace2.h"
 #include "worktree.h"
-#include "exec-cmd.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
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

