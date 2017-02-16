Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D319820136
	for <e@80x24.org>; Thu, 16 Feb 2017 11:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754978AbdBPLte (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 06:49:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32893 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754970AbdBPLtb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 06:49:31 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so1483593pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28kk6R7kh51v+HsIWKAuyoci8pNmxxnvU7siiKaQIqo=;
        b=YCoocMMwY6iCkvsiC6/B0DMSbnuG19w2D5EAIsj7GFgOpJofQ7vJnSKD89bRlrwtPO
         6m7SbYG7Xq5gdMWSWsvksuC8YBL8J3nSntWzsw3K7s/+frP/11GuO3258HIt1laRsPve
         ZORjCix6bGj2YWR64BvNhqwTrMirDweP62UQerHPPFo65K9jcDE5/ytF8J0ivY0AcsNu
         WqAMLPZz77yzqRFMA58g1GQ4Dvp9wpDCeeXLeK4KQos2Gxjv8W7E3OOMYwmUC2e/s0m+
         zhJvLEUXKNCEIg+ONs5oM+aqkJioVgVEmEdaiirD+QiwZUrA28lhFMSJd8KSMM6YRBSP
         ftbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28kk6R7kh51v+HsIWKAuyoci8pNmxxnvU7siiKaQIqo=;
        b=fjqsgxSyTQVXCkURUTHGWtyPcadahq76fwez6Wbb7Kp5msTPOMWVQuz1Bwes/WC46s
         TpI/GsQFo605E1W2a8aHETaxQesL3OWOi9RfXcxgG9dbO35YuTslfUeClz0FpRkXH51n
         HLhkrEEpITqrI8/WgYbhATxAUJ1E92bWyaK2leEJ2pgt5332gBiqduBcc+UIpZAr1825
         re3ztWOUdKttWT/bTqI3Y4kw4hL6M7zLQc/nF2bUM+y/PY5ydoEAz9tk148zz4wR4yhN
         9/9leRUsDJ/uUZa546xNnsVDFqwIU/mHdFulIJKLNbsD1t/HSZ4mJ1dck1l/MmST2RuI
         KAHg==
X-Gm-Message-State: AMke39m3uLERPTYK3W/eWX7XJMbRCKGxL31rfk47JQrTxUsYYXMcfSX6tSgE2a8xgUiGwQ==
X-Received: by 10.99.168.2 with SMTP id o2mr2233510pgf.159.1487245756039;
        Thu, 16 Feb 2017 03:49:16 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id p4sm13345847pgd.50.2017.02.16.03.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 03:49:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 18:49:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/16] files-backend: replace *git_path*() with files_path()
Date:   Thu, 16 Feb 2017 18:48:06 +0700
Message-Id: <20170216114818.6080-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216114818.6080-1-pclouds@gmail.com>
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170216114818.6080-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This centralizes all path rewriting of files-backend.c in one place so
we have easier time removing the path rewriting later. There could be
some hidden indirect git_path() though, I didn't audit the code to the
bottom.

Side note: set_worktree_head_symref() is a bad boy and should not be in
files-backend.c (probably should not exist in the first place). But
we'll leave it there until we have better multi-worktree support in refs
before we update it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 185 ++++++++++++++++++++++++++-------------------------
 1 file changed, 94 insertions(+), 91 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index abb8a95e0..24f5bf7f1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -165,7 +165,8 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  const char *dirname, size_t len,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
-static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+static int files_log_ref_write(struct files_ref_store *refs,
+			       const char *refname, const unsigned char *old_sha1,
 			       const unsigned char *new_sha1, const char *msg,
 			       int flags, struct strbuf *err);
 
@@ -1178,12 +1179,10 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *refs)
 {
 	char *packed_refs_file;
+	struct strbuf sb = STRBUF_INIT;
 
-	if (refs->submodule)
-		packed_refs_file = git_pathdup_submodule(refs->submodule,
-							 "packed-refs");
-	else
-		packed_refs_file = git_pathdup("packed-refs");
+	files_path(refs, &sb, "packed-refs");
+	packed_refs_file = strbuf_detach(&sb, NULL);
 
 	if (refs->packed &&
 	    !stat_validity_check(&refs->packed->validity, packed_refs_file))
@@ -1249,10 +1248,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	size_t path_baselen;
 	int err = 0;
 
-	if (refs->submodule)
-		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
-	else
-		strbuf_git_path(&path, "%s", dirname);
+	files_path(refs, &path, "%s", dirname);
 	path_baselen = path.len;
 
 	if (err) {
@@ -1394,10 +1390,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (refs->submodule)
-		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
-	else
-		strbuf_git_path(&sb_path, "%s", refname);
+	files_path(refs, &sb_path, "%s", refname);
 
 	path = sb_path.buf;
 
@@ -1585,7 +1578,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_path(refs, &ref_file, "%s", refname);
 
 retry:
 	switch (safe_create_leading_directories(ref_file.buf)) {
@@ -2052,7 +2045,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_path(refs, &ref_file, "%s", refname);
 	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
 					lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
@@ -2197,7 +2190,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 		timeout_configured = 1;
 	}
 
-	strbuf_git_path(&sb, "packed-refs");
+	files_path(refs, &sb, "packed-refs");
 	ret = hold_lock_file_for_update_timeout(&packlock, sb.buf,
 						flags, timeout_value);
 	strbuf_release(&sb);
@@ -2343,7 +2336,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
  * Remove empty parents, but spare refs/ and immediate subdirs.
  * Note: munges *name.
  */
-static void try_remove_empty_parents(char *name)
+static void try_remove_empty_parents(struct files_ref_store *refs, char *name)
 {
 	char *p, *q;
 	int i;
@@ -2368,7 +2361,7 @@ static void try_remove_empty_parents(char *name)
 		if (q == p)
 			break;
 		*q = '\0';
-		strbuf_git_path(&sb, "%s", name);
+		files_path(refs, &sb, "%s", name);
 		ret = rmdir(sb.buf);
 		strbuf_release(&sb);
 		if (ret)
@@ -2377,7 +2370,7 @@ static void try_remove_empty_parents(char *name)
 }
 
 /* make sure nobody touched the ref, and unlink */
-static void prune_ref(struct ref_to_prune *r)
+static void prune_ref(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2397,13 +2390,13 @@ static void prune_ref(struct ref_to_prune *r)
 	}
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
-	try_remove_empty_parents(r->name);
+	try_remove_empty_parents(refs, r->name);
 }
 
-static void prune_refs(struct ref_to_prune *r)
+static void prune_refs(struct files_ref_store *refs, struct ref_to_prune *r)
 {
 	while (r) {
-		prune_ref(r);
+		prune_ref(refs, r);
 		r = r->next;
 	}
 }
@@ -2426,7 +2419,7 @@ static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 	if (commit_packed_refs(refs))
 		die_errno("unable to overwrite old ref-pack file");
 
-	prune_refs(cbdata.ref_to_prune);
+	prune_refs(refs, cbdata.ref_to_prune);
 	return 0;
 }
 
@@ -2462,7 +2455,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 	if (lock_packed_refs(refs, 0)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_git_path(&sb, "packed-refs");
+		files_path(refs, &sb, "packed-refs");
 		unable_to_lock_message(sb.buf, errno, err);
 		strbuf_release(&sb);
 		return -1;
@@ -2558,17 +2551,17 @@ static int files_delete_refs(struct ref_store *ref_store,
  */
 #define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
 
-static int rename_tmp_log(const char *newrefname)
+static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 {
 	int attempts_remaining = 4;
 	struct strbuf path = STRBUF_INIT;
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int ret = -1;
 
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	files_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
  retry:
 	strbuf_reset(&path);
-	strbuf_git_path(&path, "logs/%s", newrefname);
+	files_path(refs, &path, "logs/%s", newrefname);
 	switch (safe_create_leading_directories_const(path.buf)) {
 	case SCLD_OK:
 		break; /* success */
@@ -2656,7 +2649,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
 	log = !lstat(sb_oldref.buf, &loginfo);
 	strbuf_release(&sb_oldref);
 	if (log && S_ISLNK(loginfo.st_mode))
@@ -2672,8 +2665,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 	if (!rename_ref_available(oldrefname, newrefname))
 		return 1;
 
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	ret = log && rename(sb_oldref.buf, tmp_renamed_log.buf);
 	strbuf_release(&sb_oldref);
 	strbuf_release(&tmp_renamed_log);
@@ -2700,7 +2693,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-			strbuf_git_path(&path, "%s", newrefname);
+			files_path(refs, &path, "%s", newrefname);
 			result = remove_empty_directories(&path);
 			strbuf_release(&path);
 
@@ -2714,7 +2707,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 		}
 	}
 
-	if (log && rename_tmp_log(newrefname))
+	if (log && rename_tmp_log(refs, newrefname))
 		goto rollback;
 
 	logmoved = log;
@@ -2756,12 +2749,12 @@ static int files_rename_ref(struct ref_store *ref_store,
 	log_all_ref_updates = flag;
 
  rollbacklog:
-	strbuf_git_path(&sb_newref, "logs/%s", newrefname);
-	strbuf_git_path(&sb_oldref, "logs/%s", oldrefname);
+	files_path(refs, &sb_newref, "logs/%s", newrefname);
+	files_path(refs, &sb_oldref, "logs/%s", oldrefname);
 	if (logmoved && rename(sb_newref.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from %s: %s",
 			oldrefname, newrefname, strerror(errno));
-	strbuf_git_path(&tmp_renamed_log, TMP_RENAMED_LOG);
+	files_path(refs, &tmp_renamed_log, TMP_RENAMED_LOG);
 	if (!logmoved && log &&
 	    rename(tmp_renamed_log.buf, sb_oldref.buf))
 		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
@@ -2817,11 +2810,13 @@ static int commit_ref(struct ref_lock *lock)
  * should_autocreate_reflog returns non-zero.  Otherwise, create it
  * regardless of the ref name.  Fill in *err and return -1 on failure.
  */
-static int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err, int force_create)
+static int log_ref_setup(struct files_ref_store *refs, const char *refname,
+			 struct strbuf *logfile, struct strbuf *err,
+			 int force_create)
 {
 	int logfd, oflags = O_APPEND | O_WRONLY;
 
-	strbuf_git_path(logfile, "logs/%s", refname);
+	files_path(refs, logfile, "logs/%s", refname);
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile->buf) < 0) {
 			strbuf_addf(err, "unable to create directory for '%s': "
@@ -2864,11 +2859,10 @@ static int files_create_reflog(struct ref_store *ref_store,
 {
 	int ret;
 	struct strbuf sb = STRBUF_INIT;
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "create_reflog");
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "create_reflog");
-
-	ret = log_ref_setup(refname, &sb, err, force_create);
+	ret = log_ref_setup(refs, refname, &sb, err, force_create);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -2899,7 +2893,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
+static int log_ref_write_1(struct files_ref_store *refs,
+			   const char *refname, const unsigned char *old_sha1,
 			   const unsigned char *new_sha1, const char *msg,
 			   struct strbuf *logfile, int flags,
 			   struct strbuf *err)
@@ -2909,7 +2904,7 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
 
-	result = log_ref_setup(refname, logfile, err, flags & REF_FORCE_CREATE_REFLOG);
+	result = log_ref_setup(refs, refname, logfile, err, flags & REF_FORCE_CREATE_REFLOG);
 
 	if (result)
 		return result;
@@ -2933,21 +2928,23 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	return 0;
 }
 
-static int log_ref_write(const char *refname, const unsigned char *old_sha1,
+static int log_ref_write(struct files_ref_store *refs,
+			 const char *refname, const unsigned char *old_sha1,
 			 const unsigned char *new_sha1, const char *msg,
 			 int flags, struct strbuf *err)
 {
-	return files_log_ref_write(refname, old_sha1, new_sha1, msg, flags,
-				   err);
+	return files_log_ref_write(refs, refname, old_sha1, new_sha1,
+				   msg, flags, err);
 }
 
-int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
+int files_log_ref_write(struct files_ref_store *refs,
+			const char *refname, const unsigned char *old_sha1,
 			const unsigned char *new_sha1, const char *msg,
 			int flags, struct strbuf *err)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, flags,
-				  err);
+	int ret = log_ref_write_1(refs, refname, old_sha1, new_sha1, msg,
+				  &sb, flags, err);
 	strbuf_release(&sb);
 	return ret;
 }
@@ -3004,7 +3001,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
-	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
+	if (log_ref_write(refs, lock->ref_name, lock->old_oid.hash,
+			  sha1, logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
@@ -3035,8 +3033,8 @@ static int commit_ref_update(struct files_ref_store *refs,
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
-			if (log_ref_write("HEAD", lock->old_oid.hash, sha1,
-					  logmsg, 0, &log_err)) {
+			if (log_ref_write(refs, "HEAD", lock->old_oid.hash,
+					  sha1, logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
 			}
@@ -3068,23 +3066,26 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 	return ret;
 }
 
-static void update_symref_reflog(struct ref_lock *lock, const char *refname,
+static void update_symref_reflog(struct files_ref_store *refs,
+				 struct ref_lock *lock, const char *refname,
 				 const char *target, const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
 	unsigned char new_sha1[20];
 	if (logmsg && !read_ref(target, new_sha1) &&
-	    log_ref_write(refname, lock->old_oid.hash, new_sha1, logmsg, 0, &err)) {
+	    log_ref_write(refs, refname, lock->old_oid.hash,
+			  new_sha1, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
 }
 
-static int create_symref_locked(struct ref_lock *lock, const char *refname,
+static int create_symref_locked(struct files_ref_store *refs,
+				struct ref_lock *lock, const char *refname,
 				const char *target, const char *logmsg)
 {
 	if (prefer_symlink_refs && !create_ref_symlink(lock, target)) {
-		update_symref_reflog(lock, refname, target, logmsg);
+		update_symref_reflog(refs, lock, refname, target, logmsg);
 		return 0;
 	}
 
@@ -3092,7 +3093,7 @@ static int create_symref_locked(struct ref_lock *lock, const char *refname,
 		return error("unable to fdopen %s: %s",
 			     lock->lk->tempfile.filename.buf, strerror(errno));
 
-	update_symref_reflog(lock, refname, target, logmsg);
+	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
 	fprintf(lock->lk->tempfile.fp, "ref: %s\n", target);
@@ -3121,13 +3122,19 @@ static int files_create_symref(struct ref_store *ref_store,
 		return -1;
 	}
 
-	ret = create_symref_locked(lock, refname, target, logmsg);
+	ret = create_symref_locked(refs, lock, refname, target, logmsg);
 	unlock_ref(lock);
 	return ret;
 }
 
 int set_worktree_head_symref(const char *gitdir, const char *target)
 {
+	/*
+	 * FIXME: this obviously will not work well for future refs
+	 * backends. This function needs to die.
+	 */
+	struct files_ref_store *refs =
+		files_downcast(get_ref_store(NULL), 0, "set_head_symref");
 	static struct lock_file head_lock;
 	struct ref_lock *lock;
 	struct strbuf head_path = STRBUF_INIT;
@@ -3154,7 +3161,7 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 	lock->lk = &head_lock;
 	lock->ref_name = xstrdup(head_rel);
 
-	ret = create_symref_locked(lock, head_rel, target, NULL);
+	ret = create_symref_locked(refs, lock, head_rel, target, NULL);
 
 	unlock_ref(lock); /* will free lock */
 	strbuf_release(&head_path);
@@ -3164,14 +3171,13 @@ int set_worktree_head_symref(const char *gitdir, const char *target)
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "reflog_exists");
 	struct strbuf sb = STRBUF_INIT;
 	struct stat st;
 	int ret;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "reflog_exists");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
 	ret = !lstat(sb.buf, &st) && S_ISREG(st.st_mode);
 	strbuf_release(&sb);
 	return ret;
@@ -3180,13 +3186,12 @@ static int files_reflog_exists(struct ref_store *ref_store,
 static int files_delete_reflog(struct ref_store *ref_store,
 			       const char *refname)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "delete_reflog");
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "delete_reflog");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
 	ret = remove_path(sb.buf);
 	strbuf_release(&sb);
 	return ret;
@@ -3236,15 +3241,14 @@ static int files_for_each_reflog_ent_reverse(struct ref_store *ref_store,
 					     each_reflog_ent_fn fn,
 					     void *cb_data)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
 	struct strbuf sb = STRBUF_INIT;
 	FILE *logfp;
 	long pos;
 	int ret = 0, at_tail = 1;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "for_each_reflog_ent_reverse");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3345,14 +3349,13 @@ static int files_for_each_reflog_ent(struct ref_store *ref_store,
 				     const char *refname,
 				     each_reflog_ent_fn fn, void *cb_data)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "for_each_reflog_ent");
 	FILE *logfp;
 	struct strbuf sb = STRBUF_INIT;
 	int ret = 0;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "for_each_reflog_ent");
-
-	strbuf_git_path(&sb, "logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
 	logfp = fopen(sb.buf, "r");
 	strbuf_release(&sb);
 	if (!logfp)
@@ -3434,15 +3437,14 @@ static struct ref_iterator_vtable files_reflog_iterator_vtable = {
 
 static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_store)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "reflog_iterator_begin");
 	struct files_reflog_iterator *iter = xcalloc(1, sizeof(*iter));
 	struct ref_iterator *ref_iterator = &iter->base;
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "reflog_iterator_begin");
-
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	strbuf_git_path(&sb, "logs");
+	files_path(refs, &sb, "logs");
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	strbuf_release(&sb);
 	return ref_iterator;
@@ -3866,8 +3868,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 
 		if (update->flags & REF_NEEDS_COMMIT ||
 		    update->flags & REF_LOG_ONLY) {
-			if (log_ref_write(lock->ref_name, lock->old_oid.hash,
-					  update->new_sha1,
+			if (log_ref_write(refs, lock->ref_name,
+					  lock->old_oid.hash, update->new_sha1,
 					  update->msg, update->flags, err)) {
 				char *old_msg = strbuf_detach(err, NULL);
 
@@ -3916,7 +3918,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 	for_each_string_list_item(ref_to_delete, &refs_to_delete) {
 		struct strbuf sb = STRBUF_INIT;
 
-		strbuf_git_path(&sb, "logs/%s", ref_to_delete->string);
+		files_path(refs, &sb, "logs/%s", ref_to_delete->string);
 		unlink_or_warn(sb.buf);
 		strbuf_release(&sb);
 	}
@@ -4078,6 +4080,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	int status = 0;
 	int type;
 	struct strbuf err = STRBUF_INIT;
+	struct strbuf sb = STRBUF_INIT;
 
 	memset(&cb, 0, sizeof(cb));
 	cb.flags = flags;
@@ -4102,7 +4105,8 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		return 0;
 	}
 
-	log_file = git_pathdup("logs/%s", refname);
+	files_path(refs, &sb, "logs/%s", refname);
+	log_file = strbuf_detach(&sb, NULL);
 	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
 		/*
 		 * Even though holding $GIT_DIR/logs/$reflog.lock has
@@ -4173,25 +4177,24 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "init_db");
-
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strbuf_git_path(&sb, "refs/heads");
+	files_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
-	strbuf_git_path(&sb, "refs/tags");
+	files_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
 	if (get_shared_repository()) {
-		strbuf_git_path(&sb, "refs/heads");
+		files_path(refs, &sb, "refs/heads");
 		adjust_shared_perm(sb.buf);
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "refs/tags");
+		files_path(refs, &sb, "refs/tags");
 		adjust_shared_perm(sb.buf);
 	}
 	strbuf_release(&sb);
-- 
2.11.0.157.gd943d85

