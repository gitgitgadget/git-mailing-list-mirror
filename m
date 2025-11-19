Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026CC32C92B
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538704; cv=none; b=XvXpH7gJU+CU0WNOsO++Eppak+7y7clL9ICGCGgHEJn51KxqzsbhSytGXn72/S/qkQ1Ch8S3XFJ+HSTAV5L6ZXXkOXdIwkXOA+t0KQRsw4EcDnfdSDtTcreNyJxKEjSZsKHNx9zEHimO4l8jI5jlUVr62j6tbBnd/AclVpmxT5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538704; c=relaxed/simple;
	bh=QYmQtljqprjE/7SiOKxqmOSX+OeHnks8im4h3LS3THI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsHY1zc2d922Wv11kNMBfw6DfZyocbw5hUhPPp4WVo64jW+C1M2MYSUlbWNvtnV7Hi4C9KGDxSQGgbvzqN0rd0w2tuP3HIm9C6eqEyMnWfMtTyTd/PTnYK9TivVf2dskHqrjSyZYILKP9zhYn6m6eTorxjK0xiR7+Gisj+rblAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a8woJhYL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y2CY3dzI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a8woJhYL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y2CY3dzI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id EB588EC00BF
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 19 Nov 2025 02:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538701;
	 x=1763625101; bh=ixpQ0sLqXoQP1eDo/9zU10PcH/oFITFgQP3y2hxX12g=; b=
	a8woJhYLRNL1gSN8jeCx991henccHqHkGRYO329F1XtZgLQvCJwsU4zJ7xaWluaa
	KHaZKw3FkY9n176d+TpnzqyzwtKVVzqk5Z4Ds6bweWuO3sZ6/ezfegSLf6zi9WZg
	KiWriLyop+yAyFn1IHKyaOWm0DHVvgQYtYmo3jMzfJTQzxhvtsgaHD7t/3y6yUu+
	gdnnIq4CO45LLhU+hmKDS/cz4JOAKrR3pw5twHgfFRwd3O9af9t3pdYzqb+5M7nS
	FQlD4cBRxzztJ61IBmeC0uW8EpBrISljcpdJak9orS3azCXNnPklmxNT1/lPuET1
	paTqyyFyRKJzckLX2/5PuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538701; x=
	1763625101; bh=ixpQ0sLqXoQP1eDo/9zU10PcH/oFITFgQP3y2hxX12g=; b=y
	2CY3dzI8JoiUcaWTCnKQlkv1PrSbjUlbaqHsfmQ8B0AX4uofCwcCezl0KhExYL34
	znTaZmUJU8YfCRipOiZ0rv+I+1Fllh3jf9oGR3QYvbgVqPlrtlVd9q77Jq1+LID3
	PAjzkgg+YenMPTgyFG6XbPPGVGom6hGY9uvcQuW4OBEvP5+jZofJWgqJEw7jQ5aX
	pBWL4Orb95kTUjiiaB4TvJNowvVQJ7rRW9cHliOSlRTvbqc7ub05ERyZe8RWdLQA
	N4CffMSLlr5QRnVctSZ+NP51LOHkLfZbuKFChbeDBB8qmqCxgtkLxoDoYfyfZft7
	5UYjWUo4iFz8z1Vy69SPg==
X-ME-Sender: <xms:DXcdaeme6qSP86F1TwYJigF5yapHP_CSd3UzFKS61xx11juTzrACcg>
    <xme:DXcdacwTFzYPXe_x8_GwPGRhWaWML4u8A-SiZLGM4yOhuQQXNs2BMLDjKyIYjF9Db
    vAaCf6YcBrXctcvW27q3bqTN6tsTESJnMF26bvqaIa9IPyqkrHxDg>
X-ME-Received: <xmr:DXcdaSQhz2dJnmPvodKf5qm-O-OaMy38kpyAOboiY34Qr2qhGwHSDIZhUEXZkaudYM3Zta9JogorpPhlYLH4-pxIdQLUZiFuYFlX65Mehg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:DXcdaXv1nHjfO77fg4RuMDYZRLMHR0eXAvIpX7Dqfns3nyApyraDFg>
    <xmx:DXcdacv86fd87CFPVfid0CsWb2nbft7S9eDgSiJbGmsF7Wd9hPAGNg>
    <xmx:DXcdaVzxjZ6QKu3cLAV4goNMn_DFutZo_aIkOlG4QngYA655prRp1Q>
    <xmx:DXcdaah1F2GApbpyXwNJlkWv7W-zSMXZlynZtTpKSQYPuJ64rIYATw>
    <xmx:DXcdaa2ZdZfndeIu_OtaLxF99kkI883dJyN3LqApmPmZUWu9X9aNvppU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:51:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a154a6f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:51:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:51:00 +0100
Subject: [PATCH 12/13] odb: handle changing a repository's commondir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-creation-v1-12-2b2ed2612cb6@pks.im>
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
In-Reply-To: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `repo_set_gitdir()` is called in two situations:

  - To initialize the repository with its discovered location. As part
    of this we also set up the new object database.

  - To update the repository's discovered location in case the process
    changes its working directory so that we update relative paths. This
    means we also have to update any relative paths that are potentially
    used in the object database.

In the context of the object database we ideally wouldn't ever have to
worry about the second case: if all paths used by our object database
sources were absolute, then we wouldn't have to update them. But
unfortunately, the paths aren't only used to locate files owned by the
given source, but we also use them for reporting purposes. One such
example is `repo_get_object_directory()`, where we cannot just change
semantics to always return absolute paths, as that is likely to break
tooling out there.

One solution to this would be to have both a "display path" and an
"internal path". This would allow us to use internal paths for all
internal matters, but continue to use the potentially-relative display
paths so that we don't break compatibility. But converting the codebase
to honor this split is quite a messy endeavour, and it wouldn't even
help us with the goal to get rid of the need to update the display path
on chdir(3p).

Another solution would be to rework "setup.c" so that we never have to
update paths in the first place. In that case, we'd only initialize the
repository once we have figured out final locations for all directories.
This would be a significant simplification of that subsystem indeed, but
the current logic is so messy that it would take significant investments
to get there.

Meanwhile though, while object sources may still use relative paths, the
best thing we can do is to handle the reparenting of the object source
paths in the object database itself. This can be done by registering one
callback for each object database so that we get notified whenever the
current working directory changes, and we then perform the reparenting
ourselves.

Ideally, this wouldn't even happen on the object database level, but
instead handled by each object database source. But we don't yet have
proper pluggable object database sources, so this will need to be
handled at a later point in time.

The logic itself is rather simple:

  - We register the callback when creating the object database.

  - We unregister the callback when releasing it again.

  - We split up `set_git_dir_1()` so that it becomes possible to skip
    recreating the object database. This is required because the
    function is called both when the current working directory changes,
    but also when we set up the repository. Calling this function
    without skipping creation of the ODB will result in a bug in case
    it's already created.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c        | 37 +++++++++++++++++++++++---
 odb.h        |  4 ---
 repository.c | 13 +++-------
 repository.h |  1 +
 setup.c      | 84 ++++++++++++++++++++++++++++++++----------------------------
 5 files changed, 83 insertions(+), 56 deletions(-)

diff --git a/odb.c b/odb.c
index 88b40c81c0..70665fb7f4 100644
--- a/odb.c
+++ b/odb.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "chdir-notify.h"
 #include "commit-graph.h"
 #include "config.h"
 #include "dir.h"
@@ -142,9 +143,9 @@ static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth);
 
-struct odb_source *odb_source_new(struct object_database *odb,
-				  const char *path,
-				  bool local)
+static struct odb_source *odb_source_new(struct object_database *odb,
+					 const char *path,
+					 bool local)
 {
 	struct odb_source *source;
 
@@ -1034,6 +1035,32 @@ int odb_write_object_stream(struct object_database *odb,
 	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
 }
 
+static void odb_update_commondir(const char *name UNUSED,
+				 const char *old_cwd,
+				 const char *new_cwd,
+				 void *cb_data)
+{
+	struct object_database *odb = cb_data;
+	struct odb_source *source;
+
+	/*
+	 * In theory, we only have to do this for the primary object source, as
+	 * alternates' paths are always resolved to an absolute path.
+	 */
+	for (source = odb->sources; source; source = source->next) {
+		char *path;
+
+		if (is_absolute_path(source->path))
+			continue;
+
+		path = reparent_relative_path(old_cwd, new_cwd,
+					      source->path);
+
+		free(source->path);
+		source->path = path;
+	}
+}
+
 struct object_database *odb_new(struct repository *repo,
 				const char *primary_source,
 				const char *secondary_sources)
@@ -1055,6 +1082,8 @@ struct object_database *odb_new(struct repository *repo,
 
 	free(to_free);
 
+	chdir_notify_register(NULL, odb_update_commondir, o);
+
 	return o;
 }
 
@@ -1106,6 +1135,8 @@ void odb_free(struct object_database *o)
 	packfile_store_free(o->packfiles);
 	string_list_clear(&o->submodule_source_paths, 0);
 
+	chdir_notify_unregister(NULL, odb_update_commondir, o);
+
 	free(o);
 }
 
diff --git a/odb.h b/odb.h
index 41b3c03027..014cd9585a 100644
--- a/odb.h
+++ b/odb.h
@@ -78,10 +78,6 @@ struct odb_source {
 	char *path;
 };
 
-struct odb_source *odb_source_new(struct object_database *odb,
-				  const char *path,
-				  bool local);
-
 struct packed_git;
 struct packfile_store;
 struct cached_object_entry;
diff --git a/repository.c b/repository.c
index 5975c8f341..863f24411b 100644
--- a/repository.c
+++ b/repository.c
@@ -165,17 +165,10 @@ void repo_set_gitdir(struct repository *repo,
 
 	repo_set_commondir(repo, o->commondir);
 
-	if (!repo->objects) {
+	if (!repo->objects)
 		repo->objects = odb_new(repo, o->object_dir, o->alternate_db);
-	} else {
-		char *objects_path = NULL;
-		expand_base_dir(&objects_path, o->object_dir,
-				repo->commondir, "objects");
-		free(repo->objects->sources->path);
-		repo->objects->sources->path = objects_path;
-		free(repo->objects->alternate_db);
-		repo->objects->alternate_db = xstrdup_or_null(o->alternate_db);
-	}
+	else if (!o->skip_initializing_odb)
+		BUG("cannot reinitialize an already-initialized object directory");
 
 	repo->disable_ref_updates = o->disable_ref_updates;
 
diff --git a/repository.h b/repository.h
index 614649413b..6063c4b846 100644
--- a/repository.h
+++ b/repository.h
@@ -195,6 +195,7 @@ struct set_gitdir_args {
 	const char *index_file;
 	const char *alternate_db;
 	bool disable_ref_updates;
+	bool skip_initializing_odb;
 };
 
 void repo_set_gitdir(struct repository *repo, const char *root,
diff --git a/setup.c b/setup.c
index a752e9fc84..a625f9fbc8 100644
--- a/setup.c
+++ b/setup.c
@@ -1002,10 +1002,51 @@ const char *read_gitfile_gently(const char *path, int *return_error_code)
 	return error_code ? NULL : path;
 }
 
-static void set_git_dir_1(const char *path)
+static void setup_git_env_internal(const char *git_dir,
+				   bool skip_initializing_odb)
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
+	if (getenv(GIT_QUARANTINE_ENVIRONMENT))
+		args.disable_ref_updates = true;
+	args.skip_initializing_odb = skip_initializing_odb;
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
+void setup_git_env(const char *git_dir)
+{
+	setup_git_env_internal(git_dir, false);
+}
+
+static void set_git_dir_1(const char *path, bool skip_initializing_odb)
 {
 	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
-	setup_git_env(path);
+	setup_git_env_internal(path, skip_initializing_odb);
 }
 
 static void update_relative_gitdir(const char *name UNUSED,
@@ -1020,7 +1061,7 @@ static void update_relative_gitdir(const char *name UNUSED,
 	trace_printf_key(&trace_setup_key,
 			 "setup: move $GIT_DIR to '%s'",
 			 path);
-	set_git_dir_1(path);
+	set_git_dir_1(path, true);
 	if (tmp_objdir)
 		tmp_objdir_reapply_primary_odb(tmp_objdir, old_cwd, new_cwd);
 	free(path);
@@ -1035,7 +1076,7 @@ static void set_git_dir(const char *path, int make_realpath)
 		path = realpath.buf;
 	}
 
-	set_git_dir_1(path);
+	set_git_dir_1(path, false);
 	if (!is_absolute_path(path))
 		chdir_notify_register(NULL, update_relative_gitdir, NULL);
 
@@ -1668,41 +1709,6 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
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
-		args.disable_ref_updates = true;
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
 const char *enter_repo(const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

