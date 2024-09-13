Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C27763C
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247831; cv=none; b=KlIwprRtdL7xWoTKP2Tez5g2XUuY/+IWqwhVxkjUP55Mqss/EuvyMeFNzlIN02Jh83y/ixLle7dvsEyQxKcL5B9HtEx5Q/Lv7ytwMoydySD7ZL4UEhELQ5FNTzxkfKERySvI61ognwRYqrN36/so0CNbpxOwg+W6lEqt0aeYh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247831; c=relaxed/simple;
	bh=/9y+/rQE2fkN7EybrSPCt9HreU+OTj2hf+wByK64fj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ez/qy5fg960Ymwh8gtYmca/O4idiGtnaJ6eT5Wzdef7WiK6NEONYjDGH7WkSAP5om6/TaNvjFy3LeAERtIeFCaJKaU7xwAU18r2+tWWHXqc4Pig8JZsLnB3iO5mwq1dkBTpwPTSv1TvIAdEs6NyS06xy/XElWvp/1+T1lZGUYPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6MAmW0N; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6MAmW0N"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso2188694a12.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247828; x=1726852628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gcBP9aqsZjnsFRGAKHy5MquP9gDDmmz9/J03RZMlBg8=;
        b=B6MAmW0Na8V+qGtaCSvfKD1Wzwd2fBkXVVMOaDpCGd0WdCQD5SJYFWASO8aKBfWEBK
         uVBg1++8tX8rqJnTttWuNtcrYlknfr8uFt4/6mEaAmo4L7EETGzmTtg8Hp8QXw/lvLVT
         4PesW2msYwZD0mNhpo2RA7Uh7X8L6LlhtQi3uAgiFyF0RCVKsewR0wHfEMHRPKpWY2v3
         vSvW1YRGiSGVrUNbyJPlq2/A5g+DzEmc/LAKcJelzmL+Z7YVBAE+NBuENOSiITB7xCD5
         MRQbf0Z2cP5WdUn8Jsd4PsgEVPJUDv1ciceQnoH9NofzIzWNC2pzYd6Q8rR/i37yHETo
         JIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247828; x=1726852628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcBP9aqsZjnsFRGAKHy5MquP9gDDmmz9/J03RZMlBg8=;
        b=EMF+xbt8/hc2Ity9dUgJNEFlzmsFqRASrTI5iZFUJL/heBANtmnT8nSg9wLOpGyRLR
         tYMwXyckllr0PYWI/9KWldkq9tw0myOhGmtwki3YeBFsIzs/pEp4jQA3bDEZWuT+ho8Z
         Zi9Wc/otH5Ogns8dDFk0a4HjHSecE1eCAL9Qpr2pPKSFVX34cLjiRwkt/LejnRVa6psG
         bTybTJgGKzXfciyxrHDUyGDCYV0tnlUXj27vjyXbRmLJvIzY/B6f+hRjiqoTVby6Id4/
         LVUurWxhCJMvsNmsB4njFpvEAAm+mPKh3ADSUmF4nlBDs5USCri1Scpi8ApbAvaqbsXK
         Fbyg==
X-Gm-Message-State: AOJu0YyDwKcuRpjaYSINewQ44o571jwgb2K3SwgiU1xuzZQicRIOeL7S
	+xINFgCSpif+NwkRT4hnf5q6SwYMO8wA/3VM5h0dQIyPDzmgUbrGgz/o0g==
X-Google-Smtp-Source: AGHT+IENDj18kS5Z75zceovdOXbnsthn9J1Or1kqTPsXv/4mkn6EnELQwKwK5tl/r3RjeuSM/JCGhw==
X-Received: by 2002:a05:6a21:58d:b0:1cf:29a8:8e1c with SMTP id adf61e73a8af0-1cf75f6544fmr11102860637.28.1726247827987;
        Fri, 13 Sep 2024 10:17:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71909092264sm6332555b3a.116.2024.09.13.10.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:17:07 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:18:15 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 5/5] ref: add symlink ref content check for files backend
Message-ID: <ZuRz1_cHDnr_pWzo@ArchLinux>
References: <ZuRzCyjQFilGhj8j@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuRzCyjQFilGhj8j@ArchLinux>

We have already introduced "files_fsck_symref_target". We should reuse
this function to handle the symrefs which use legacy symbolic links. We
should not check the trailing garbage for symbolic refs. Add a new
parameter "symbolic_link" to disable some checks which should only be
executed for textual symrefs.

We firstly use the "strbuf_add_real_path" to resolve the symlink and
get the absolute path "referent_path" which the symlink ref points
to. Then we can get the absolute path "abs_gitdir" of the "gitdir".
By combining "referent_path" and "abs_gitdir", we can extract the
"referent". Thus, we can reuse "files_fsck_symref_target" function to
seamlessly check the symlink refs.

Because we consider deprecating writing the symbolic links and for
reading, we may or may not deprecate. We first need to asses whether
symbolic links may still be used. So, add a new fsck message
"symlinkRef(INFO)" to let the user be aware of this information.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  5 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 65 ++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh      | 97 +++++++++++++++++++++++++++++++++++
 4 files changed, 154 insertions(+), 14 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 03bcb77972..31626e765b 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -186,6 +186,11 @@
 	(INFO) A ref does not end with newline. This will be
 	considered an error in the future.
 
+`symlinkRef`::
+	(INFO) A symref uses the symbolic link. This kind of symref may
+	be considered ERROR in the future when totally dropping the
+	symlink support.
+
 `trailingRefContent`::
 	(INFO) A ref has trailing content. This will be
 	considered an error in the future.
diff --git a/fsck.h b/fsck.h
index c90561c6db..b72ee632a4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -89,6 +89,7 @@ enum fsck_msg_type {
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0cb4a2da73..c511deb509 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -1950,10 +1951,13 @@ static int commit_ref_update(struct files_ref_store *refs,
 	return 0;
 }
 
+#ifdef NO_SYMLINK_HEAD
+#define create_ref_symlink(a, b) (-1)
+#else
 static int create_ref_symlink(struct ref_lock *lock, const char *target)
 {
 	int ret = -1;
-#ifndef NO_SYMLINK_HEAD
+
 	char *ref_path = get_locked_file_path(&lock->lk);
 	unlink(ref_path);
 	ret = symlink(target, ref_path);
@@ -1961,13 +1965,12 @@ static int create_ref_symlink(struct ref_lock *lock, const char *target)
 
 	if (ret)
 		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
-#endif
 	return ret;
 }
+#endif
 
-static int create_symref_lock(struct files_ref_store *refs,
-			      struct ref_lock *lock, const char *refname,
-			      const char *target, struct strbuf *err)
+static int create_symref_lock(struct ref_lock *lock, const char *target,
+			      struct strbuf *err)
 {
 	if (!fdopen_lock_file(&lock->lk, "w")) {
 		strbuf_addf(err, "unable to fdopen %s: %s",
@@ -2583,8 +2586,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 	}
 
 	if (update->new_target && !(update->flags & REF_LOG_ONLY)) {
-		if (create_symref_lock(refs, lock, update->refname,
-				       update->new_target, err)) {
+		if (create_symref_lock(lock, update->new_target, err)) {
 			ret = TRANSACTION_GENERIC_ERROR;
 			goto out;
 		}
@@ -3436,12 +3438,15 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 
 /*
  * Check the symref "referent" and "referent_path". For textual symref,
- * "referent" would be the content after "refs:".
+ * "referent" would be the content after "refs:". For symlink ref,
+ * "referent" would be the relative path agaignst "gitdir" which should
+ * be the same as the textual symref literally.
  */
 static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
 				    struct strbuf *referent,
-				    struct strbuf *referent_path)
+				    struct strbuf *referent_path,
+				    unsigned int symbolic_link)
 {
 	size_t len = referent->len - 1;
 	struct stat st;
@@ -3454,14 +3459,16 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
-	if (referent->buf[referent->len - 1] != '\n') {
+	if (!symbolic_link && referent->buf[referent->len - 1] != '\n') {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_REF_MISSING_NEWLINE,
 				      "missing newline");
 		len++;
 	}
 
-	strbuf_rtrim(referent);
+	if (!symbolic_link)
+		strbuf_rtrim(referent);
+
 	if (check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_BAD_REFERENT_NAME,
@@ -3469,7 +3476,7 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
-	if (len != referent->len) {
+	if (!symbolic_link && len != referent->len) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_TRAILING_REF_CONTENT,
 				      "trailing garbage in ref");
@@ -3509,6 +3516,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 {
 	struct strbuf referent_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = {0};
@@ -3521,8 +3529,35 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
 	report.path = refname.buf;
 
-	if (S_ISLNK(iter->st.st_mode))
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char* relative_referent_path;
+
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_SYMLINK_REF,
+				      "use deprecated symbolic link for symref");
+
+		strbuf_add_absolute_path(&abs_gitdir, ref_store->gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		strbuf_add_real_path(&referent_path, iter->path.buf);
+
+		if (!skip_prefix(referent_path.buf,
+				 abs_gitdir.buf,
+				 &relative_referent_path)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_ESCAPE_REFERENT,
+					      "point to target outside gitdir");
+			goto cleanup;
+		}
+
+		strbuf_addstr(&referent, relative_referent_path);
+		ret = files_fsck_symref_target(o, &report,
+					       &referent, &referent_path, 1);
+
 		goto cleanup;
+	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		ret = error_errno(_("unable to read ref '%s/%s'"),
@@ -3563,7 +3598,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		strbuf_rtrim(&referent_path);
 		ret = files_fsck_symref_target(o, &report,
 					       &referent,
-					       &referent_path);
+					       &referent_path,
+					       0);
 	}
 
 cleanup:
@@ -3571,6 +3607,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
 	strbuf_release(&referent_path);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 9580c340ab..7c3579705f 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -326,4 +326,101 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success SYMLINKS 'symlink symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-good &&
+	test_cmp expect err &&
+
+	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-1: escapeReferent: point to target outside gitdir
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-1 &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-2: escapeReferent: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-2 &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-3: badReferentName: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-3 &&
+	test_cmp expect err &&
+
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badReferentName: points to refname with invalid format
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err &&
+
+	ln -sf ./ $tag_dir_prefix/tag-symbolic-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-2: badReferentFiletype: points to the directory
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-2 &&
+	test_cmp expect err
+'
+
+test_expect_success SYMLINKS 'symlink symref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+	ln -sf ../../../../branch $branch_dir_prefix/branch-symbolic-1 &&
+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic-2 &&
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-3 &&
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	ln -sf ./ $tag_dir_prefix/tag-symbolic-2 &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-symbolic-1: escapeReferent: point to target outside gitdir
+	error: refs/heads/branch-symbolic-2: escapeReferent: points to ref outside the refs directory
+	error: refs/heads/branch-symbolic-3: badReferentName: points to refname with invalid format
+	error: refs/tags/tag-symbolic-1: badReferentName: points to refname with invalid format
+	error: refs/tags/tag-symbolic-2: badReferentFiletype: points to the directory
+	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.0

