Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD9D22578D
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828693; cv=none; b=XrlenhOwY9qSo8vQCs/GchKkHnzWFoe/bgQx13CcGICBRHO3kswMRAKdq+EP3b0iVfMyPk018XhMJe59DAvPYiYiL3lPFozuEyGLtDGM0wraCwj78NHHr8s9XmzvTMRMYuX8bdYEtYC4knUR5V7qG+r4iJIGJNJ6c7f4UHuRVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828693; c=relaxed/simple;
	bh=1JzTu4bvGvPwrZgH9CUPU/nFqBuYW2ZE6Jftg+hCans=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmQGkhyM4btt7o27WnqndRI/1pQ4/OQLA9cUQwxJAm2UgQTg/oYGqAJ/6lCQiyw95E2HsgspkDWy76sBqDryybI0ycbALEVwRzb1SQlbdmDweAn/MwpXHHhd8B5INNYlVwRIVx4MxaQgPT7eOXDXhVPOzAO5In0kR5nmfVigSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mbwbFMKK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZR5M/E3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mbwbFMKK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZR5M/E3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A246011401BD
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 02:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828690;
	 x=1738915090; bh=HTlfRPzx98OMdf3qM91VRhYWHVWeHYpklnJxSSC0SqY=; b=
	mbwbFMKK2jbjDdH8x7droSna8kTW8XCxBKoORDoGuTIvpzT4FCV60UMA10MUJ35Y
	wOAY9FbqXqq0kDJqumjZSPcCK2AH7POI+fasGTGSy4FVcuodKlHPUdJbnipgmyqK
	LomLkf4i6/FlBtdV/CcJYQ93POEh20+4Buo9e7b6P0mPiPuOBkqOGcryeWbqCVr8
	C9ZTFNmkp9o4YruFOhMXCN1sUjg6xqGFnqMu1iZ0n55uNegWXa2uMVEL4iFbMTMS
	DSyq+exQYl2/ltq413bYu1SluLsQx5Yq6QmU6aQOz4TGIXv/z/zDWJZq1mVA6bT9
	WSI02jRhfzE+KLvnsUylMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828690; x=
	1738915090; bh=HTlfRPzx98OMdf3qM91VRhYWHVWeHYpklnJxSSC0SqY=; b=P
	ZR5M/E3LVCIm2+kSSA07gx+2VPWqYt0v0XqHpQju5gWsKT38YZMm0zWA3g1VdcwI
	v5jIzDoa1+Mn3SdRorqe5Pj4W8eOwgPVXDojJaAe781KGFgFAJCuYCTHO0+QIkQE
	nSUh18nsnOcH51AYAA+2nhFX8Qd2JiBH8XkWS69zlRX0NQBvJ0ubuv1Pca4+Xss4
	KmPvAVUB2RfHrKRLXEQ4I4+ACVf/NJq+CRzJumgXC0JtY8eAOtUYDikezmBJ9x0A
	LW+ZGqeuTjt5AINhLUpyGc42cwcIIv9aRXZKSrFtuVsEi+pjU9g/6vQYGYe1oFzg
	A3FlaIl8fGnMjEQRH31yw==
X-ME-Sender: <xms:kmukZ6tQ_cs48ms329R13CRQ0zqFFlm1f8Ul1Oq2Q3xYCkyzAB4lNA>
    <xme:kmukZ_cW72Bt7kdUkwMiBAlBubm2QZDnLN7j57mltk4zhOsUHF2rK5O1pHhScloVS
    Si9P_gzuORSjkidHw>
X-ME-Received: <xmr:kmukZ1wJg2mo2p3n5W5xlwfunLQOucy6RPlaKrLuSC_u4pWbseqD0I1_1eEXnosnLqdDPHa7yUTlEPgKBU0NcB1Gfrws8z0afy2D53GYq01f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kmukZ1MQ51S07y7viNn8CuGIRSRRTASO1EiNeOpvAwXHMYhha6spnQ>
    <xmx:kmukZ69J1AF_3zSFaMy25fq9ulhN7ltK_0Z02djchkons7HenBDf6Q>
    <xmx:kmukZ9U10bGQJ4m0oYkuGOccB2tiJJ6gIpwcRfuyvb0J0S25SUC5sQ>
    <xmx:kmukZzfbanVCrakq5K54FU5wdAH9viHvtOcVX3c39l16VsLQfNOxqw>
    <xmx:kmukZwmzQnlsA6cZIlxV77lDM5MS65hlhjeD5f9OqFvLdwo1ZL07KFZh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:09 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 378c5692 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:03 +0100
Subject: [PATCH 07/16] path: drop `git_pathdup()` in favor of
 `repo_git_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-7-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Remove `git_pathdup()` in favor of `repo_git_path()`. The latter does
essentially the same, with the only exception that it does not rely on
`the_repository` but takes the repo as separate parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c              |  2 +-
 builtin/am.c          |  2 +-
 builtin/clone.c       |  2 +-
 builtin/config.c      |  8 ++++----
 builtin/fast-import.c |  4 ++--
 builtin/fsck.c        |  2 +-
 builtin/gc.c          |  4 ++--
 builtin/notes.c       |  2 +-
 builtin/replace.c     |  2 +-
 builtin/tag.c         |  2 +-
 builtin/worktree.c    |  4 ++--
 dir.c                 |  2 +-
 http-backend.c        |  2 +-
 notes-merge.c         |  2 +-
 object-file.c         |  2 +-
 path.h                | 16 +---------------
 16 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7a3c77c6d8..269a98bf97 100644
--- a/bisect.c
+++ b/bisect.c
@@ -930,7 +930,7 @@ static enum bisect_error check_good_are_ancestors_of_bad(struct repository *r,
 	if (!current_bad_oid)
 		return error(_("a %s revision is needed"), term_bad);
 
-	filename = git_pathdup("BISECT_ANCESTORS_OK");
+	filename = repo_git_path(the_repository, "BISECT_ANCESTORS_OK");
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
diff --git a/builtin/am.c b/builtin/am.c
index 390b463144..2921bb89ef 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -158,7 +158,7 @@ static void am_state_init(struct am_state *state)
 
 	memset(state, 0, sizeof(*state));
 
-	state->dir = git_pathdup("rebase-apply");
+	state->dir = repo_git_path(the_repository, "rebase-apply");
 
 	state->prec = 4;
 
diff --git a/builtin/clone.c b/builtin/clone.c
index fd001d800c..5ae6ee9db9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -938,7 +938,7 @@ static void write_refspec_config(const char *src_ref_prefix,
 
 static void dissociate_from_references(void)
 {
-	char *alternates = git_pathdup("objects/info/alternates");
+	char *alternates = repo_git_path(the_repository, "objects/info/alternates");
 
 	if (!access(alternates, F_OK)) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
diff --git a/builtin/config.c b/builtin/config.c
index 16e6e30555..53a90094e3 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -775,13 +775,13 @@ static void location_options_init(struct config_location_options *opts,
 		opts->source.file = opts->file_to_free = git_system_config();
 		opts->source.scope = CONFIG_SCOPE_SYSTEM;
 	} else if (opts->use_local_config) {
-		opts->source.file = opts->file_to_free = git_pathdup("config");
+		opts->source.file = opts->file_to_free = repo_git_path(the_repository, "config");
 		opts->source.scope = CONFIG_SCOPE_LOCAL;
 	} else if (opts->use_worktree_config) {
 		struct worktree **worktrees = get_worktrees();
 		if (the_repository->repository_format_worktree_config)
 			opts->source.file = opts->file_to_free =
-				git_pathdup("config.worktree");
+				repo_git_path(the_repository, "config.worktree");
 		else if (worktrees[0] && worktrees[1])
 			die(_("--worktree cannot be used with multiple "
 			      "working trees unless the config\n"
@@ -790,7 +790,7 @@ static void location_options_init(struct config_location_options *opts,
 			      "section in \"git help worktree\" for details"));
 		else
 			opts->source.file = opts->file_to_free =
-				git_pathdup("config");
+				repo_git_path(the_repository, "config");
 		opts->source.scope = CONFIG_SCOPE_LOCAL;
 		free_worktrees(worktrees);
 	} else if (opts->source.file) {
@@ -1087,7 +1087,7 @@ static int show_editor(struct config_location_options *opts)
 	git_config(git_default_config, NULL);
 	config_file = opts->source.file ?
 			xstrdup(opts->source.file) :
-			git_pathdup("config");
+			repo_git_path(the_repository, "config");
 	if (opts->use_global_config) {
 		int fd = open(config_file, O_CREAT | O_EXCL | O_WRONLY, 0666);
 		if (fd >= 0) {
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index a6a84058cd..c6f5147e8b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -328,7 +328,7 @@ static void write_branch_report(FILE *rpt, struct branch *b)
 
 static void write_crash_report(const char *err)
 {
-	char *loc = git_pathdup("fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
+	char *loc = repo_git_path(the_repository, "fast_import_crash_%"PRIuMAX, (uintmax_t) getpid());
 	FILE *rpt = fopen(loc, "w");
 	struct branch *b;
 	unsigned long lu;
@@ -3280,7 +3280,7 @@ static char* make_fast_import_path(const char *path)
 {
 	if (!relative_marks_paths || is_absolute_path(path))
 		return prefix_filename(global_prefix, path);
-	return git_pathdup("info/fast-import/%s", path);
+	return repo_git_path(the_repository, "info/fast-import/%s", path);
 }
 
 static void option_import_marks(const char *marks,
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7a4dcb0716..c12203e012 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -326,7 +326,7 @@ static void check_unreachable_object(struct object *obj)
 				  printable_type(&obj->oid, obj->type),
 				  describe_object(&obj->oid));
 		if (write_lost_and_found) {
-			char *filename = git_pathdup("lost-found/%s/%s",
+			char *filename = repo_git_path(the_repository, "lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
 				describe_object(&obj->oid));
 			FILE *f;
diff --git a/builtin/gc.c b/builtin/gc.c
index 0bf3533494..57f6aee174 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -546,7 +546,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	if (xgethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
 
-	pidfile_path = git_pathdup("gc.pid");
+	pidfile_path = repo_git_path(the_repository, "gc.pid");
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
@@ -607,7 +607,7 @@ static int report_last_gc_error(void)
 	int ret = 0;
 	ssize_t len;
 	struct stat st;
-	char *gc_log_path = git_pathdup("gc.log");
+	char *gc_log_path = repo_git_path(the_repository, "gc.log");
 
 	if (stat(gc_log_path, &st)) {
 		if (errno == ENOENT)
diff --git a/builtin/notes.c b/builtin/notes.c
index d051abf6df..18bcbb2f91 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -197,7 +197,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		struct strbuf buf = STRBUF_INIT;
 
 		/* write the template message before editing: */
-		d->edit_path = git_pathdup("NOTES_EDITMSG");
+		d->edit_path = repo_git_path(the_repository, "NOTES_EDITMSG");
 		fd = xopen(d->edit_path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 
 		if (d->msg_nr)
diff --git a/builtin/replace.c b/builtin/replace.c
index a4eaadff91..15ec0922ce 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -345,7 +345,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	}
 	strbuf_release(&ref);
 
-	tmpfile = git_pathdup("REPLACE_EDITOBJ");
+	tmpfile = repo_git_path(the_repository, "REPLACE_EDITOBJ");
 	if (export_object(&old_oid, type, raw, tmpfile)) {
 		free(tmpfile);
 		return -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index e8a344b926..d3e0943b73 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -667,7 +667,7 @@ int cmd_tag(int argc,
 	if (create_tag_object) {
 		if (force_sign_annotate && !annotate)
 			opt.sign = 1;
-		path = git_pathdup("TAG_EDITMSG");
+		path = repo_git_path(the_repository, "TAG_EDITMSG");
 		create_tag(&object, object_ref, tag, &buf, &opt, &prev, &object,
 			   &trailer_args, path);
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index c043d4d523..c84e6aa2cb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -337,7 +337,7 @@ static void check_candidate_path(const char *path,
 
 static void copy_sparse_checkout(const char *worktree_git_dir)
 {
-	char *from_file = git_pathdup("info/sparse-checkout");
+	char *from_file = repo_git_path(the_repository, "info/sparse-checkout");
 	char *to_file = xstrfmt("%s/info/sparse-checkout", worktree_git_dir);
 
 	if (file_exists(from_file)) {
@@ -353,7 +353,7 @@ static void copy_sparse_checkout(const char *worktree_git_dir)
 
 static void copy_filtered_worktree_config(const char *worktree_git_dir)
 {
-	char *from_file = git_pathdup("config.worktree");
+	char *from_file = repo_git_path(the_repository, "config.worktree");
 	char *to_file = xstrfmt("%s/config.worktree", worktree_git_dir);
 
 	if (file_exists(from_file)) {
diff --git a/dir.c b/dir.c
index 5b2181e589..4122f6513d 100644
--- a/dir.c
+++ b/dir.c
@@ -3455,7 +3455,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 
 char *get_sparse_checkout_filename(void)
 {
-	return git_pathdup("info/sparse-checkout");
+	return repo_git_path(the_repository, "info/sparse-checkout");
 }
 
 int get_sparse_checkout_patterns(struct pattern_list *pl)
diff --git a/http-backend.c b/http-backend.c
index 33cf378282..50b2858fad 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -183,7 +183,7 @@ static void send_strbuf(struct strbuf *hdr,
 static void send_local_file(struct strbuf *hdr, const char *the_type,
 				const char *name)
 {
-	char *p = git_pathdup("%s", name);
+	char *p = repo_git_path(the_repository, "%s", name);
 	size_t buf_alloc = 8192;
 	char *buf = xmalloc(buf_alloc);
 	int fd;
diff --git a/notes-merge.c b/notes-merge.c
index 8d701ed428..c997c0c1e3 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -309,7 +309,7 @@ static void write_buf_to_worktree(const struct object_id *obj,
 				  const char *buf, unsigned long size)
 {
 	int fd;
-	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
+	char *path = repo_git_path(the_repository, NOTES_MERGE_WORKTREE "/%s", oid_to_hex(obj));
 	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
 
diff --git a/object-file.c b/object-file.c
index 6ce1caacae..335cc2a5da 100644
--- a/object-file.c
+++ b/object-file.c
@@ -717,7 +717,7 @@ static void read_info_alternates(struct repository *r,
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file lock = LOCK_INIT;
-	char *alts = git_pathdup("objects/info/alternates");
+	char *alts = repo_git_path(the_repository, "objects/info/alternates");
 	FILE *in, *out;
 	int found = 0;
 
diff --git a/path.h b/path.h
index cebc93cb0a..df16dd23bd 100644
--- a/path.h
+++ b/path.h
@@ -292,24 +292,10 @@ static inline const char *git_path(const char *fmt, ...)
 	{ \
 		static char *ret; \
 		if (!ret) \
-			ret = git_pathdup(filename); \
+			ret = repo_git_path(the_repository, filename); \
 		return ret; \
 	}
 
-/*
- * Return a path into the main repository's (the_repository) git directory.
- */
-__attribute__((format (printf, 1, 2)))
-static inline char *git_pathdup(const char *fmt, ...)
-{
-	struct strbuf path = STRBUF_INIT;
-	va_list args;
-	va_start(args, fmt);
-	repo_git_pathv(the_repository, NULL, &path, fmt, args);
-	va_end(args);
-	return strbuf_detach(&path, NULL);
-}
-
 # endif /* USE_THE_REPOSITORY_VARIABLE */
 
 #endif /* PATH_H */

-- 
2.48.1.538.gc4cfc42d60.dirty

