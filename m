Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 170DF20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753124AbdKVWii (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:38:38 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:45367 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdKVWif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:38:35 -0500
Received: by mail-it0-f67.google.com with SMTP id x13so8051746iti.4
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GV2a3wsPfV6nrGn5ba/A0k1DwqDWo9/IpR+hIs885LY=;
        b=jqLbYB28dopAIIRhwQ7zaepKqDkf3K6AE59U2EivhjEIQ/AJCdd80kGYua5s1VF7Mu
         EG8bSust6Dt/rUJMOdkG+ElovZsLD8cVu3wPJYtovzgNe5vV5nwbJqMJhJi+8Eg7c+zj
         +L57x2It8hGTvN0ca5b2fny3j6jwNHUzWlBMAdTmdm/xDacx8lFLr5c4mqZ2SjrzB5s6
         B9f9Te9fIi7t57eiUPd6lgbQdD3gmDpjp03OaS0GyUl9YNXg/lO+y14T0d+jrAHlFyi3
         FLAvqKwzBKfrxgfbE6ZpVBaF2shBulzVd61Iz7jpC01K43RyVmFrLqKrRvnk5V4yqrKw
         e7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GV2a3wsPfV6nrGn5ba/A0k1DwqDWo9/IpR+hIs885LY=;
        b=abXExt8pdanWck2JWcCVzchLKcZUBe6Wru4XKb7+cSLbVex8lyHSgiLU2L9ZIBmPBi
         xLrS8mLEF+gJEKBxKAFIIO+de+ZfYqTrz3Nuf5PwVENMgvA2QGm5pRP7oAMf2UYhLNlt
         uH8VcaIHes3L7JXOZ/0SqF+vLeCbFBms1K1lO1AHgX04sInWYtlYsSCtbohDqcq3mAOD
         mMkJEwy19f3LGNC3lVy46UJi6LlJ0Ol9sZJPvRkYK8QQWKXriy/cdxH2LTqm46mE4NME
         kgzi3ZRv5SZiPbAzj+9s9h4O905nOmYw49oQRogb7fqXLGjPF2KJNR9wCZpXKgGI/XmU
         gRIw==
X-Gm-Message-State: AJaThX44Tw1TW/NYIDPsvTJR98s9a9DwnZ6c4r2RP8neFEHpP4JPQgwJ
        iX/fQFHFwDqYdQ9tz7+p281/Yli+zBY=
X-Google-Smtp-Source: AGs4zMY0XC9ZgQ0Jr1/74Z0vpnRE1rcQnZkuNp2IcaGu7cWIHnp6ZMh+jHUU7vaRl8aQb9J4nFdsnw==
X-Received: by 10.36.3.141 with SMTP id e135mr9215419ite.1.1511390314046;
        Wed, 22 Nov 2017 14:38:34 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id g187sm2470124itb.29.2017.11.22.14.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:38:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] contrib/coccinelle: convert all conditional bugs to bug_on
Date:   Wed, 22 Nov 2017 14:38:27 -0800
Message-Id: <20171122223827.26773-4-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.448.gf294e3d99a-goog
In-Reply-To: <20171122223827.26773-1-sbeller@google.com>
References: <20171122223827.26773-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a coccinelle patch that detects a conditional BUG and converts it to
BUG_ON.  Also apply that semantic patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/merge.c                 |  3 +--
 contrib/coccinelle/bug_on.cocci |  8 ++++++++
 environment.c                   | 22 ++++++++++------------
 notes.c                         |  9 +++++----
 refs.c                          |  7 +++----
 refs/files-backend.c            | 14 ++++++--------
 refs/packed-backend.c           | 13 +++++--------
 sha1_file.c                     |  4 ++--
 tempfile.c                      | 34 ++++++++++++++++------------------
 9 files changed, 56 insertions(+), 58 deletions(-)
 create mode 100644 contrib/coccinelle/bug_on.cocci

diff --git a/builtin/merge.c b/builtin/merge.c
index 612dd7bfb6..df5884b4c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -770,8 +770,7 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 	struct strbuf msg = STRBUF_INIT;
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
-	if (squash)
-		BUG("the control must not reach here under --squash");
+	BUG_ON(squash, "the control must not reach here under --squash");
 	if (0 < option_edit)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	if (signoff)
diff --git a/contrib/coccinelle/bug_on.cocci b/contrib/coccinelle/bug_on.cocci
new file mode 100644
index 0000000000..e778d19e3c
--- /dev/null
+++ b/contrib/coccinelle/bug_on.cocci
@@ -0,0 +1,8 @@
+@@
+expression E;
+@@
+- if (E)
+-  BUG(
++ BUG_ON(E,
+   ...);
+
diff --git a/environment.c b/environment.c
index 8fa032f307..9ba01a85ec 100644
--- a/environment.c
+++ b/environment.c
@@ -177,22 +177,20 @@ int have_git_dir(void)
 
 const char *get_git_dir(void)
 {
-	if (!the_repository->gitdir)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!the_repository->gitdir, "git environment hasn't been setup");
 	return the_repository->gitdir;
 }
 
 const char *get_git_common_dir(void)
 {
-	if (!the_repository->commondir)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!the_repository->commondir,
+	       "git environment hasn't been setup");
 	return the_repository->commondir;
 }
 
 const char *get_git_namespace(void)
 {
-	if (!namespace)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!namespace, "git environment hasn't been setup");
 	return namespace;
 }
 
@@ -242,8 +240,8 @@ const char *get_git_work_tree(void)
 
 char *get_object_directory(void)
 {
-	if (!the_repository->objectdir)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!the_repository->objectdir,
+	       "git environment hasn't been setup");
 	return the_repository->objectdir;
 }
 
@@ -282,15 +280,15 @@ int odb_pack_keep(const char *name)
 
 char *get_index_file(void)
 {
-	if (!the_repository->index_file)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!the_repository->index_file,
+	       "git environment hasn't been setup");
 	return the_repository->index_file;
 }
 
 char *get_graft_file(void)
 {
-	if (!the_repository->graft_file)
-		BUG("git environment hasn't been setup");
+	BUG_ON(!the_repository->graft_file,
+	       "git environment hasn't been setup");
 	return the_repository->graft_file;
 }
 
diff --git a/notes.c b/notes.c
index c7f21fae44..cae8fa0657 100644
--- a/notes.c
+++ b/notes.c
@@ -400,10 +400,11 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		     oid_to_hex(&subtree->val_oid));
 
 	prefix_len = subtree->key_oid.hash[KEY_INDEX];
-	if (prefix_len >= GIT_SHA1_RAWSZ)
-		BUG("prefix_len (%"PRIuMAX") is out of range", (uintmax_t)prefix_len);
-	if (prefix_len * 2 < n)
-		BUG("prefix_len (%"PRIuMAX") is too small", (uintmax_t)prefix_len);
+	BUG_ON(prefix_len >= GIT_SHA1_RAWSZ,
+	       "prefix_len (%"PRIuMAX") is out of range",
+	       (uintmax_t)prefix_len);
+	BUG_ON(prefix_len * 2 < n, "prefix_len (%"PRIuMAX") is too small",
+	       (uintmax_t)prefix_len);
 	memcpy(object_oid.hash, subtree->key_oid.hash, prefix_len);
 	while (tree_entry(&desc, &entry)) {
 		unsigned char type;
diff --git a/refs.c b/refs.c
index 339d4318ee..1a5473fbe3 100644
--- a/refs.c
+++ b/refs.c
@@ -937,8 +937,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 		return -1;
 	}
 
-	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
-		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
+	BUG_ON(flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS,
+	       "illegal flags 0x%x passed to ref_transaction_update()", flags);
 
 	flags |= (new_oid ? REF_HAVE_NEW : 0) | (old_oid ? REF_HAVE_OLD : 0);
 
@@ -1279,8 +1279,7 @@ struct ref_iterator *refs_ref_iterator_begin(
 		iter = prefix_ref_iterator_begin(iter, "", trim);
 
 	/* Sanity check for subclasses: */
-	if (!iter->ordered)
-		BUG("reference iterator is not ordered");
+	BUG_ON(!iter->ordered, "reference iterator is not ordered");
 
 	return iter;
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f75d960e19..a00a7d9f78 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2208,8 +2208,8 @@ static int split_head_update(struct ref_update *update,
 	 * size, but it happens at most once per transaction.
 	 * Add new_update->refname instead of a literal "HEAD".
 	 */
-	if (strcmp(new_update->refname, "HEAD"))
-		BUG("%s unexpectedly not 'HEAD'", new_update->refname);
+	BUG_ON(strcmp(new_update->refname, "HEAD"),
+	       "%s unexpectedly not 'HEAD'", new_update->refname);
 	item = string_list_insert(affected_refnames, new_update->refname);
 	item->util = new_update;
 
@@ -2285,9 +2285,8 @@ static int split_symref_update(struct files_ref_store *refs,
 	 * referent, which might soon be freed by our caller.
 	 */
 	item = string_list_insert(affected_refnames, new_update->refname);
-	if (item->util)
-		BUG("%s unexpectedly found in affected_refnames",
-		    new_update->refname);
+	BUG_ON(item->util, "%s unexpectedly found in affected_refnames",
+	       new_update->refname);
 	item->util = new_update;
 
 	return 0;
@@ -2570,9 +2569,8 @@ static int files_transaction_prepare(struct ref_store *ref_store,
 		struct string_list_item *item =
 			string_list_append(&affected_refnames, update->refname);
 
-		if ((update->flags & REF_IS_PRUNING) &&
-		    !(update->flags & REF_NO_DEREF))
-			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
+		BUG_ON((update->flags & REF_IS_PRUNING) && !(update->flags & REF_NO_DEREF),
+		       "REF_IS_PRUNING set without REF_NO_DEREF");
 
 		/*
 		 * We store a pointer to update in item->util, but at
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 023243fd5f..e10c2f94d8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -334,9 +334,7 @@ static void sort_snapshot(struct snapshot *snapshot)
 
 	while (pos < eof) {
 		eol = memchr(pos, '\n', eof - pos);
-		if (!eol)
-			/* The safety check should prevent this. */
-			BUG("unterminated line found in packed-refs");
+		BUG_ON(!eol, "unterminated line found in packed-refs");
 		if (eol - pos < GIT_SHA1_HEXSZ + 2)
 			die_invalid_line(snapshot->refs->path,
 					 pos, eof - pos);
@@ -349,9 +347,8 @@ static void sort_snapshot(struct snapshot *snapshot)
 			const char *peeled_start = eol;
 
 			eol = memchr(peeled_start, '\n', eof - peeled_start);
-			if (!eol)
-				/* The safety check should prevent this. */
-				BUG("unterminated peeled line found in packed-refs");
+			BUG_ON(!eol,
+			       "unterminated peeled line found in packed-refs");
 			eol++;
 		}
 
@@ -1272,8 +1269,8 @@ int is_packed_transaction_needed(struct ref_store *ref_store,
 	size_t i;
 	int ret;
 
-	if (!is_lock_file_locked(&refs->lock))
-		BUG("is_packed_transaction_needed() called while unlocked");
+	BUG_ON(!is_lock_file_locked(&refs->lock),
+	       "is_packed_transaction_needed() called while unlocked");
 
 	/*
 	 * We're only going to bother returning false for the common,
diff --git a/sha1_file.c b/sha1_file.c
index 8a7c6b7eba..f10886f907 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1885,8 +1885,8 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	int r = 0;
 	struct object_id oid;
 
-	if (subdir_nr > 0xff)
-		BUG("invalid loose object subdirectory: %x", subdir_nr);
+	BUG_ON(subdir_nr > 0xff, "invalid loose object subdirectory: %x",
+	       subdir_nr);
 
 	origlen = path->len;
 	strbuf_complete(path, '/');
diff --git a/tempfile.c b/tempfile.c
index 5fdafdd2d2..63884b6bdd 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -107,8 +107,8 @@ static void activate_tempfile(struct tempfile *tempfile)
 {
 	static int initialized;
 
-	if (is_tempfile_active(tempfile))
-		BUG("activate_tempfile called for active object");
+	BUG_ON(is_tempfile_active(tempfile),
+	       "activate_tempfile called for active object");
 
 	if (!initialized) {
 		sigchain_push_common(remove_tempfiles_on_signal);
@@ -215,10 +215,9 @@ struct tempfile *xmks_tempfile_m(const char *template, int mode)
 
 FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 {
-	if (!is_tempfile_active(tempfile))
-		BUG("fdopen_tempfile() called for inactive object");
-	if (tempfile->fp)
-		BUG("fdopen_tempfile() called for open object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "fdopen_tempfile() called for inactive object");
+	BUG_ON(tempfile->fp, "fdopen_tempfile() called for open object");
 
 	tempfile->fp = fdopen(tempfile->fd, mode);
 	return tempfile->fp;
@@ -226,22 +225,22 @@ FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode)
 
 const char *get_tempfile_path(struct tempfile *tempfile)
 {
-	if (!is_tempfile_active(tempfile))
-		BUG("get_tempfile_path() called for inactive object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "get_tempfile_path() called for inactive object");
 	return tempfile->filename.buf;
 }
 
 int get_tempfile_fd(struct tempfile *tempfile)
 {
-	if (!is_tempfile_active(tempfile))
-		BUG("get_tempfile_fd() called for inactive object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "get_tempfile_fd() called for inactive object");
 	return tempfile->fd;
 }
 
 FILE *get_tempfile_fp(struct tempfile *tempfile)
 {
-	if (!is_tempfile_active(tempfile))
-		BUG("get_tempfile_fp() called for inactive object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "get_tempfile_fp() called for inactive object");
 	return tempfile->fp;
 }
 
@@ -275,10 +274,9 @@ int close_tempfile_gently(struct tempfile *tempfile)
 
 int reopen_tempfile(struct tempfile *tempfile)
 {
-	if (!is_tempfile_active(tempfile))
-		BUG("reopen_tempfile called for an inactive object");
-	if (0 <= tempfile->fd)
-		BUG("reopen_tempfile called for an open object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "reopen_tempfile called for an inactive object");
+	BUG_ON(0 <= tempfile->fd, "reopen_tempfile called for an open object");
 	tempfile->fd = open(tempfile->filename.buf, O_WRONLY);
 	return tempfile->fd;
 }
@@ -287,8 +285,8 @@ int rename_tempfile(struct tempfile **tempfile_p, const char *path)
 {
 	struct tempfile *tempfile = *tempfile_p;
 
-	if (!is_tempfile_active(tempfile))
-		BUG("rename_tempfile called for inactive object");
+	BUG_ON(!is_tempfile_active(tempfile),
+	       "rename_tempfile called for inactive object");
 
 	if (close_tempfile_gently(tempfile)) {
 		delete_tempfile(tempfile_p);
-- 
2.15.0.448.gf294e3d99a-goog

