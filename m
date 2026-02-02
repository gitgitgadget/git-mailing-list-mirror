Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CB366043
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035229; cv=none; b=S8/vVmnUhYmQUXD+ncMFX6KrlL+eVE4Z8TjjkPErmruGso6+lpgrV8cGAmrMcABACpr5w15XjV5cLCPDApRVY2nctu9j8N06bBq1bJebSjmshaBIphEWfGAQ9du7t8PQry3H7nMByOXbifLnNqzcFHmB1V5mZTvfxYYnkv5/GvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035229; c=relaxed/simple;
	bh=BD9AQqZ64MFHI7lgzt/sX3zVS2bw0E1maP2evB29JCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWEqcHfDPvaWKNFBg1uRUtcSY4+xIfV6Ywf2e3UCAgknI0NedYByb+fl6dEi/6RzS3eIdT53QaatxMrCt2x7PNYMxbAVwmdqMUZMuowgfGBxzslnswljo5ozAs2TGpxj6kYStNjOHVPmPLNfCkvrlR+K3+tpvO9GIqQ1ow8jm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbl53Usc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbl53Usc"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4807068eacbso36375855e9.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 04:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770035225; x=1770640025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqZBVKWVZpeKyOwcOO7tJ4KNW68vFmCvSFX0ldPQYRU=;
        b=nbl53UscB6+034mqGC1V6WvjCOXRBxavZm2Z+DsdS2yAkA/k4Wb09VH/ZJiCyQ5znk
         IiFWldN+8CzJBOyzWj4rHCnDZ5nGMjCuXdt8r0IEVdHaWSZZr7L0hGZ+WM0OX3yoRRlw
         kQ124ot+lbWuxUUeT0PyIASZEMkp1KwH3/PCpmEhR0DA0k8RnmJr8dhBsDzeentAr9LM
         n4HgO3JKuq7abmoI4dIF9Y7gIvhSs312RsSwxGmvqQ7UeDQdCdOWI8uQAPfW/dQXViJu
         jWAVkGkAA62OUv2fVgMSGuibsQhZF0EvJ9dW2T2aNs49Mw3IsHmOE6vvTPbMDUnn1qQS
         HGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035225; x=1770640025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eqZBVKWVZpeKyOwcOO7tJ4KNW68vFmCvSFX0ldPQYRU=;
        b=ii38O0trW6ccBokY5gTDcL43ULGKULgq3C4veZjyIYq3jaydpX6b6tzvjQzfGn13OT
         iwvvoPCOhWo0UpOVBMFIWqVL8d9uHg2tJUIoT+iy5ooAu66QCkcr8o0I6yN2SXmfg5R0
         /7uiiDVRNnVBairkOzRrzfKD+I06ZbmJJ9uGHTmJYav7YSx2+M8fcS2Edx5J5moME8di
         pB5yb/xWkloSjTAUu8KE4PSO+6k1Xl8j1X00Fe15tDHMIz0S4dV+tJwYWC9+9oU+ddOJ
         YUz1h76XVKzV8CFcaHjNKmR6Zd5tfzTYwLJGk+lQTNWvXta8fS/FXPq0WEJq9EyyivqI
         rR3w==
X-Gm-Message-State: AOJu0YxOTOarBrCNoRzutsg3kgwrDc5/o9B7l2R44YvRQXbQwI8rOC6C
	yrY8TfAymAWJjLubwmmJ2pY7zjtzQjvZqaZVH5v3DUpAzRd0oJgRaIh+
X-Gm-Gg: AZuq6aK2AZnXyLZhP5A5ETPbm5Vh9kMN0gCXDElM372lUKImcEBsdpvo4G8LwOYTgiS
	HORl80o3gD6woF+MHVzcgSq9K5DEW2gb4unHVJH58Hv1Wkf2ue0F6cL52HspxIyH9jFofA0EbG5
	RLN6lJKjjhEXzZIW3AsZ4LaAc9OeCFzWIIS/70XaZzw5PU8b35tYKe6qTc4QWzyCOEqc5lfTlPL
	mn3y7F+/idfGuro4UqR6OA3YMHtfrNZHWWUf0Zz9UrQsKm0hb6SOWMvrlJKXMOT4HDB/0ZxeL7q
	LxghncrvWnPsUHUpW+7k2aMN2otivwvdYwaA8dtkw792i7L5330StZCibwSprIS/JjpuebO4S58
	k8ewP3r2Rmo94Kif/NntwsioeakbqB2yuhVs9PHKDyb7kMzitA3xhzq5GEZzBYfRC8QPsM+AhL8
	4Ind1c4WfaIfsjSCVjnEU=
X-Received: by 2002:a05:6000:1884:b0:430:fb6d:1442 with SMTP id ffacd0b85a97d-435f3aba254mr17313118f8f.62.1770035225129;
        Mon, 02 Feb 2026 04:27:05 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:4339:aac1:fb26:43f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4757sm45245735f8f.5.2026.02.02.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 04:27:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 02 Feb 2026 13:26:32 +0100
Subject: [PATCH v4 3/4] refs: parse and use the reference storage payload
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-kn-alternate-ref-dir-v4-3-3b30430411e3@gmail.com>
References: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
In-Reply-To: <20260202-kn-alternate-ref-dir-v4-0-3b30430411e3@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=18619;
 i=karthik.188@gmail.com; h=from:subject:message-id;
 bh=BD9AQqZ64MFHI7lgzt/sX3zVS2bw0E1maP2evB29JCU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGmAmBTrvdEVfing97o/GAf+goAGfiLmLash9
 SoWk8O0RHoJp4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpgJgUAAoJED7VnySO
 Rox/cWcL/1l7mYUzsk9bAuBzm0Ha4y1CR8Vwkz5r5ggTkuY3qGIMktqMbNkcdxTDco3hWWo3ceP
 KgvdXGkPS4UHLKI2mggGAFV5AyNupwky93cbSCe8wiTfQs0XRsbnCXOlYuqGAhAa5CtfbsQJS+n
 suFA3xfcDkJi9qGzPGuxoMQ2dDnkCGVis7mA+hkhik8qoqFtMA9ABbBxR2I8KekcqfxmlvRaO6/
 tU89WIAuDvgE1dAumnQw/FZEY4CsHjnBdb2mwcINia6zS2BEeUxGyqhK1jHFs+UAc/0aT/k1Is0
 ElTNFkFc/byelOjv2rC8qceBgNpmjbEhPRJaLWLhhVt5ozpIXlin3JjzW7vNT79/GakAsOwT3U0
 PRgBylKL/XPQAuICXRu4diPwQdOYg821Gmj/wqkpYGfGKywh2QGKAjUjzyVEzFSZEq58jcTsVti
 4LXp6vCVgWoQZvbHL7a3s359/5gaAt3ttroz5A+iAnIPFfX+HuY7P1ME70ihTtDRTTC7S2b6ak4
 pM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The previous commit extended the 'extensions.refStorage' config to add
support for a reference storage payload. The payload provides backend
specific information on where to store references for a given directory.

Propagate this information to individual backends when initializing them
via the 'init()' function. Both the files and reftable backends will
parse the information to be filesystem paths to store references.

To enable this, provide a 'refs_compute_filesystem_location()' function
which will parse the current 'gitdir' and the 'payload' to provide the
final reference directory and common reference directory (if working in
a linked worktree).

Finally, for linked worktrees, traditionally references were stored in
the '$GIT_DIR/worktrees/<wt_id>' path. But when using an alternate
reference storage path, it doesn't make sense to store main worktree
references in the new path, and linked worktree references in the
$GIT_DIR path. So, let's store linked worktree references in
'$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id'. To do this, create the
necessary files and folders and also add stubs in the $GIT_DIR path to
ensure that it is still considered a Git directory.

Since this commit adds the required linking, also add the necessary
documentation and tests.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/config/extensions.adoc |  16 +++-
 builtin/worktree.c                   |  35 ++++++++
 refs.c                               |  37 +++++++-
 refs/files-backend.c                 |  18 ++--
 refs/packed-backend.c                |   1 +
 refs/packed-backend.h                |   1 +
 refs/refs-internal.h                 |  15 ++++
 refs/reftable-backend.c              |  24 +++---
 t/meson.build                        |   1 +
 t/t1423-ref-backend.sh               | 159 +++++++++++++++++++++++++++++++++++
 10 files changed, 290 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/extensions.adoc b/Documentation/config/extensions.adoc
index 532456644b..df86da6aa7 100644
--- a/Documentation/config/extensions.adoc
+++ b/Documentation/config/extensions.adoc
@@ -57,10 +57,24 @@ For historical reasons, this extension is respected regardless of the
 `core.repositoryFormatVersion` setting.
 
 refStorage:::
-	Specify the ref storage format to use. The acceptable values are:
+	Specify the ref storage format and location to use. The value can be
+	either a format name or a URI:
 +
 --
+* A format name alone (e.g., `reftable` or `files`) uses the default
+  location (the repository's common directory).
+
+* A URI format `<format>://<location>` explicitly specifies both the
+  format and payload (e.g., `reftable:///foo/bar`).
+
+Supported format names are:
++
 include::../ref-storage-format.adoc[]
++
+The payload is passed directly to the reference backend. For the files and
+reftable backends, this must be a filesystem path. Relative paths are resolved
+relative to the $GIT_DIR. Future backends may support other payload schemes,
+e.g., postgres://127.0.0.1:5432?database=myrepo.
 --
 +
 Note that this setting should only be set by linkgit:git-init[1] or
diff --git a/builtin/worktree.c b/builtin/worktree.c
index fbdaf2eb2e..800a376ac5 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -425,6 +425,40 @@ static int make_worktree_orphan(const char * ref, const struct add_opts *opts,
 	return run_command(&cp);
 }
 
+/*
+ * References for worktress are generally stored in '$GIT_DIR/worktrees/<wt_id>'.
+ * But when using alternate reference directories, we want to store the worktree
+ * references in '$ALTERNATE_REFERENCE_DIR/worktrees/<wt_id>'.
+ *
+ * Create the necessary folder structure to facilitate the same. But to ensure
+ * that the former path is still considered a Git directory, add stubs (similar
+ *  to how we do in the reftable backend).
+ */
+static void setup_alternate_ref_dir(struct worktree *wt, const char *wt_git_path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	char *path;
+
+	path = wt->repo->ref_storage_payload;
+	if (!path)
+		return;
+
+	if (!is_absolute_path(path))
+		strbuf_addf(&sb, "%s/", wt->repo->commondir);
+
+	strbuf_addf(&sb, "%s/worktrees", path);
+	safe_create_dir(wt->repo, sb.buf, 1);
+	strbuf_addf(&sb, "/%s", wt->id);
+	safe_create_dir(wt->repo, sb.buf, 1);
+	strbuf_reset(&sb);
+
+	strbuf_addf(&sb, "this worktree stores references in %s/worktrees/%s",
+		   path, wt->id);
+	refs_create_refdir_stubs(wt->repo, wt_git_path, sb.buf);
+
+	strbuf_release(&sb);
+}
+
 static int add_worktree(const char *path, const char *refname,
 			const struct add_opts *opts)
 {
@@ -518,6 +552,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = error(_("could not find created worktree '%s'"), name);
 		goto done;
 	}
+	setup_alternate_ref_dir(wt, sb_repo.buf);
 	wt_refs = get_worktree_ref_store(wt);
 
 	ret = ref_store_create_on_disk(wt_refs, REF_STORE_CREATE_ON_DISK_IS_WORKTREE, &sb);
diff --git a/refs.c b/refs.c
index 32b4edaf2d..c1d69082a9 100644
--- a/refs.c
+++ b/refs.c
@@ -5,6 +5,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
+#include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
@@ -2224,7 +2225,11 @@ static struct ref_store *ref_store_init(struct repository *repo,
 	if (!be)
 		BUG("reference backend is unknown");
 
-	refs = be->init(repo, gitdir, flags);
+	/*
+	 * TODO Send in a 'struct worktree' instead of a 'gitdir', and
+	 * allow the backend to handle how it wants to deal with worktrees.
+	 */
+	refs = be->init(repo, repo->ref_storage_payload, gitdir, flags);
 	return refs;
 }
 
@@ -3426,3 +3431,33 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
 
 	strbuf_release(&path);
 }
+
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_addstr(refdir, gitdir);
+	*is_worktree = get_common_dir_noenv(ref_common_dir, gitdir);
+
+	if (!payload)
+		return;
+
+	if (!is_absolute_path(payload)) {
+		strbuf_addf(&sb, "%s/%s", ref_common_dir->buf, payload);
+		strbuf_realpath(ref_common_dir, sb.buf, 1);
+	} else {
+		strbuf_realpath(ref_common_dir, payload, 1);
+	}
+
+	strbuf_reset(refdir);
+	strbuf_addbuf(refdir, ref_common_dir);
+
+	if (*is_worktree) {
+		char *wt_id = strrchr(gitdir, '/') + 1;
+		strbuf_addf(refdir, "/worktrees/%s", wt_id);
+	}
+
+	strbuf_release(&sb);
+}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 240d3c3b26..160ecb53b7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -106,19 +106,24 @@ static void clear_loose_ref_cache(struct files_ref_store *refs)
  * set of caches.
  */
 static struct ref_store *files_ref_store_init(struct repository *repo,
+					      const char *payload,
 					      const char *gitdir,
 					      unsigned int flags)
 {
 	struct files_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
-	struct strbuf sb = STRBUF_INIT;
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
+	bool is_worktree;
+
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
 
-	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
+	base_ref_store_init(ref_store, repo, refdir.buf, &refs_be_files);
 	refs->store_flags = flags;
-	get_common_dir_noenv(&sb, gitdir);
-	refs->gitcommondir = strbuf_detach(&sb, NULL);
+	refs->gitcommondir = xstrdup(ref_common_dir.buf);
 	refs->packed_ref_store =
-		packed_ref_store_init(repo, refs->gitcommondir, flags);
+		packed_ref_store_init(repo, payload, ref_common_dir.buf, flags);
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
 	repo_config_get_bool(repo, "core.prefersymlinkrefs", &refs->prefer_symlink_refs);
 
@@ -126,6 +131,9 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
 			      &refs->gitcommondir);
 
+	strbuf_release(&ref_common_dir);
+	strbuf_release(&refdir);
+
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 4ea0c12299..028fbc0585 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -212,6 +212,7 @@ static size_t snapshot_hexsz(const struct snapshot *snapshot)
 }
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload UNUSED,
 					const char *gitdir,
 					unsigned int store_flags)
 {
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index 9481d5e7c2..2c2377a356 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,6 +14,7 @@ struct ref_transaction;
  */
 
 struct ref_store *packed_ref_store_init(struct repository *repo,
+					const char *payload,
 					const char *gitdir,
 					unsigned int store_flags);
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index c7d2a6e50b..bd09b1280c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -389,6 +389,7 @@ struct ref_store;
  * the ref_store and to record the ref_store for later lookup.
  */
 typedef struct ref_store *ref_store_init_fn(struct repository *repo,
+					    const char *payload,
 					    const char *gitdir,
 					    unsigned int flags);
 /*
@@ -666,4 +667,18 @@ enum ref_transaction_error refs_verify_refnames_available(struct ref_store *refs
 					  unsigned int initial_transaction,
 					  struct strbuf *err);
 
+/*
+ * Given a gitdir and the reference storage payload provided, retrieve the
+ * 'refdir' and 'ref_common_dir'. The former is where references should be
+ * stored for the current worktree, the latter is the common reference
+ * directory if working with a linked worktree. If working with the main
+ * worktree, both values will be the same.
+ *
+ * This is used by backends such as {files, reftable} which store references in
+ * dedicated filesystem paths.
+ */
+void refs_compute_filesystem_location(const char *gitdir, const char *payload,
+				      bool *is_worktree, struct strbuf *refdir,
+				      struct strbuf *ref_common_dir);
+
 #endif /* REFS_REFS_INTERNAL_H */
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d8651fe779..964b0b50fc 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -372,18 +372,24 @@ static int reftable_be_fsync(int fd)
 }
 
 static struct ref_store *reftable_be_init(struct repository *repo,
+					  const char *payload,
 					  const char *gitdir,
 					  unsigned int store_flags)
 {
 	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
+	struct strbuf ref_common_dir = STRBUF_INIT;
+	struct strbuf refdir = STRBUF_INIT;
 	struct strbuf path = STRBUF_INIT;
-	int is_worktree;
+	bool is_worktree;
 	mode_t mask;
 
 	mask = umask(0);
 	umask(mask);
 
-	base_ref_store_init(&refs->base, repo, gitdir, &refs_be_reftable);
+	refs_compute_filesystem_location(gitdir, payload, &is_worktree, &refdir,
+					 &ref_common_dir);
+
+	base_ref_store_init(&refs->base, repo, refdir.buf, &refs_be_reftable);
 	strmap_init(&refs->worktree_backends);
 	refs->store_flags = store_flags;
 	refs->log_all_ref_updates = repo_settings_get_log_all_ref_updates(repo);
@@ -419,14 +425,11 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
 	 * This stack contains both the shared and the main worktree refs.
-	 *
-	 * Note that we don't try to resolve the path in case we have a
-	 * worktree because `get_common_dir_noenv()` already does it for us.
 	 */
-	is_worktree = get_common_dir_noenv(&path, gitdir);
+	strbuf_addbuf(&path, &ref_common_dir);
 	if (!is_worktree) {
 		strbuf_reset(&path);
-		strbuf_realpath(&path, gitdir, 0);
+		strbuf_realpath(&path, ref_common_dir.buf, 0);
 	}
 	strbuf_addstr(&path, "/reftable");
 	refs->err = reftable_backend_init(&refs->main_backend, path.buf,
@@ -443,10 +446,9 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 	 * do it efficiently.
 	 */
 	if (is_worktree) {
-		strbuf_reset(&path);
-		strbuf_addf(&path, "%s/reftable", gitdir);
+		strbuf_addstr(&refdir, "/reftable");
 
-		refs->err = reftable_backend_init(&refs->worktree_backend, path.buf,
+		refs->err = reftable_backend_init(&refs->worktree_backend, refdir.buf,
 						  &refs->write_options);
 		if (refs->err)
 			goto done;
@@ -456,6 +458,8 @@ static struct ref_store *reftable_be_init(struct repository *repo,
 
 done:
 	assert(refs->err != REFTABLE_API_ERROR);
+	strbuf_release(&ref_common_dir);
+	strbuf_release(&refdir);
 	strbuf_release(&path);
 	return &refs->base;
 }
diff --git a/t/meson.build b/t/meson.build
index 459c52a489..11fc5a49ee 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -210,6 +210,7 @@ integration_tests = [
   't1420-lost-found.sh',
   't1421-reflog-write.sh',
   't1422-show-ref-exists.sh',
+  't1423-ref-backend.sh',
   't1430-bad-ref-name.sh',
   't1450-fsck.sh',
   't1451-fsck-buffer.sh',
diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
new file mode 100755
index 0000000000..9c777b79f3
--- /dev/null
+++ b/t/t1423-ref-backend.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+
+test_description='Test reference backend URIs'
+
+. ./test-lib.sh
+
+# Run a git command with the provided reference storage. Reset the backend
+# post running the command.
+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
+#   <repo> is the relative path to the repo to run the command in.
+#   <backend> is the original ref storage of the repo.
+#   <uri> is the new URI to be set for the ref storage.
+#   <cmd> is the git subcommand to be run in the repository.
+run_with_uri() {
+	repo=$1 &&
+	backend=$2 &&
+	uri=$3 &&
+	cmd=$4 &&
+
+	git -C "$repo" config set core.repositoryformatversion 1
+	git -C "$repo" config set extensions.refStorage "$uri" &&
+	git -C "$repo" $cmd &&
+	git -C "$repo" config set extensions.refStorage "$backend"
+}
+
+# Test a repository with a given reference storage by running and comparing
+# 'git refs list' before and after setting the new reference backend. If
+# err_msg is set, expect the command to fail and grep for the provided err_msg.
+# Usage: run_with_uri <repo> <backend> <uri> <cmd>
+#   <repo> is the relative path to the repo to run the command in.
+#   <backend> is the original ref storage of the repo.
+#   <uri> is the new URI to be set for the ref storage.
+#   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
+test_refs_backend() {
+	repo=$1 &&
+	backend=$2 &&
+	uri=$3 &&
+	err_msg=$4 &&
+
+	git -C "$repo" config set core.repositoryformatversion 1 &&
+	if test -n "$err_msg";
+	then
+		git -C "$repo" config set extensions.refStorage "$uri" &&
+		test_must_fail git -C "$repo" refs list 2>err &&
+		test_grep "$err_msg" err
+	else
+		git -C "$repo" refs list >expect &&
+		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
+		test_cmp expect actual
+	fi
+}
+
+test_expect_success 'URI is invalid' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "reftable@/home/reftable" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+test_expect_success 'URI ends with colon' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "reftable:" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+test_expect_success 'unknown reference backend' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_refs_backend repo files "db://.git" \
+		"invalid value for ${SQ}extensions.refstorage${SQ}"
+'
+
+ref_formats="files reftable"
+for from_format in $ref_formats
+do
+
+for to_format in $ref_formats
+do
+	if test "$from_format" = "$to_format"
+	then
+		continue
+	fi
+
+
+	for dir in "$(pwd)/repo/.git" "./"
+	do
+
+		test_expect_success "$read from $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" "$method"
+			)
+		'
+
+		test_expect_success "$write to $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+
+				test_refs_backend . $from_format "$to_format://$BACKEND_PATH" &&
+
+				git refs list >expect &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "tag -d 1" &&
+				git refs list >actual &&
+				test_cmp expect actual &&
+
+				git refs list | grep -v "refs/tags/1" >expect &&
+				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" "refs list" >actual &&
+				test_cmp expect actual
+			)
+		'
+
+		test_expect_success "with worktree and $to_format backend, $dir dir" '
+			test_when_finished "rm -rf repo wt" &&
+			git init --ref-format=$from_format repo &&
+			(
+				cd repo &&
+				test_commit 1 &&
+				test_commit 2 &&
+				test_commit 3 &&
+
+				git refs migrate --dry-run --ref-format=$to_format >out &&
+				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
+
+				git config set core.repositoryformatversion 1 &&
+				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
+
+				git worktree add ../wt 2
+			) &&
+
+			git -C repo for-each-ref --include-root-refs >expect &&
+			git -C wt for-each-ref --include-root-refs >expect &&
+			! test_cmp expect actual &&
+
+			git -C wt rev-parse 2 >expect &&
+			git -C wt rev-parse HEAD >actual &&
+			test_cmp expect actual
+		'
+	done # closes dir
+done # closes to_format
+done # closes from_format
+
+test_done

-- 
2.52.0

