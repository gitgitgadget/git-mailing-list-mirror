Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4617243AD2
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366009; cv=none; b=DhDsga1CJQKI/gSzAI4b/ZIy44xtQZE3vSAfavWa5gBNXXsgsw2YF+vD/MbN91xz+txAMXUZ3OAYqZgIiBJpRN8K5DfXb+GeMqi2EdSsdX9338mJur+Fs6iT8SUdBZDmO0KnJgmMAbNg5usKDKb5XpjCBbEBHBfoD9RU7xLlMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366009; c=relaxed/simple;
	bh=TquNTPss3vt5Zz6jFxMITLmh6Od4ehYcfB/66Ndep+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7T3nm3YlOEZ0CEyBZEiTM2/nOIQ3Q3gU3zeMYaUWqxjXknN7q70XDVc69st5NWy0e6Flv9x9ySm47MDnYa4PLfFfGBqC6ZTSRNRL7qz/BkLnfzaB+ERUnLyGdA6chEp58//khKE4f0+ZW72PnKSI9g00qcBGp4ldGoYfM7dV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjJu6UZq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjJu6UZq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-715abede256so3882771b3a.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725366006; x=1725970806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oQUzJU1uezWQSiSKf2V4jt5Q2GJMakZjotgycN8kXY=;
        b=hjJu6UZqgpb7vLYatxsUljZgzrw99BK/HHGxHrpddsSIMrAvi24yyHhL1N/ztzhN23
         InrqqMwfwxIj4d5nI5kTOE5b9wnkUDEPt3Jn8enkk653JD3ijD1h4wx+PuiBy44YMaiI
         aCfYWdGF3Za22/IzJv6afB9cTy1cEp/CEON9XwDZNwUEN3JMnW8SloQyD3OFsqQdPRu0
         wadbbfasaLu6WzZtUcNASyNAIQS/rVXISCN93VggeJhVFQVzI/YmHn1f3ZW7/0DwaqDQ
         xTZcEaV0QH29ofKXNdXbeEWXikdVTQ6te4kTsHBbcyEZxzLHtuQ+iPGyCXyKQ059Ujwr
         lEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725366006; x=1725970806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oQUzJU1uezWQSiSKf2V4jt5Q2GJMakZjotgycN8kXY=;
        b=f2pGmFuUsMfhk+jFb7z+C6A7jtUCE9jrcPNiGbCnxQGg1CebnWdzut9rrWFB5AhuCy
         n0g2A/HXIrZBVaG9YCRpaiuiNVlllXAC/Nhox3A3bYJy8pcOy/4uZd3M54UlPn+/F/AK
         XqSWtfEEnFbB+zV+WP1igPhsmB1/z44h38ABIi6bfXUBLuDXVE14QYBS8OGVqPIHzyLL
         L1fY5lYIovtePwqnZ6wviVmJ59sQTWb1SNSnCKwlOjkcBvy/UYIqsL/pMFxlbRn9SvMs
         PDwFBIx55sStoi90pY0xOHVSuonWkXrbsTGxzr/6fUu+I1VlNDH4jRHqK/RbQENPKvos
         vYJQ==
X-Gm-Message-State: AOJu0YwfWipxRMbkM6SVALosUtN6/+Gzgv0i2gL1Sq+Jq8E9gu9wKwGe
	HvFNR06GLjlMkT2iM8PkxJWczXBOTuQObNnWtFDEZKM2Rns14BCFyZuqZA==
X-Google-Smtp-Source: AGHT+IGdWQuEbCyAnBW/01e08IEzP5F5txTqVjQv8h4QS/PANaZGoM+sh0lYbsllfkHLyZxU+JxG/g==
X-Received: by 2002:a05:6a20:c6ca:b0:1c6:cb01:db61 with SMTP id adf61e73a8af0-1ced62a2caamr10026980637.28.1725366005879;
        Tue, 03 Sep 2024 05:20:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8818feacesm8139413a91.30.2024.09.03.05.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:20:05 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:21:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/4] ref: add symlink ref content check for files backend
Message-ID: <Ztb_Lzxgla2FHICH@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb-mgl50cwGVO8A@ArchLinux>

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

Because we are going to drop support for "core.prefersymlinkrefs", add a
new fsck message "symlinkRef" to let the user be aware of this
information.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  5 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 68 +++++++++++++++++++-----
 t/t0602-reffiles-fsck.sh      | 97 +++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 14 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index beb6c4e49e..9e8e1ac7f0 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -181,6 +181,11 @@
 	(INFO) A ref does not end with newline. This kind of ref may
 	be considered ERROR in the future.
 
+`symlinkRef`::
+	(INFO) A symref uses the symbolic link. This kind of symref may
+	be considered ERROR in the future when totally dropping the
+	symlink support.
+
 `trailingRefContent`::
 	(INFO) A ref has trailing contents. This kind of ref may be
 	considered ERROR in the future.
diff --git a/fsck.h b/fsck.h
index 5ea874916d..1c6f750812 100644
--- a/fsck.h
+++ b/fsck.h
@@ -87,6 +87,7 @@ enum fsck_msg_type {
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMLINK_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index fef32e607f..2a1b952f0d 100644
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
 	const char *p = NULL;
@@ -3456,14 +3461,16 @@ static int files_fsck_symref_target(struct fsck_options *o,
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
 				      FSCK_MSG_BAD_SYMREF_TARGET,
@@ -3471,7 +3478,7 @@ static int files_fsck_symref_target(struct fsck_options *o,
 		goto out;
 	}
 
-	if (len != referent->len) {
+	if (!symbolic_link && len != referent->len) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_TRAILING_REF_CONTENT,
 				      "trailing garbage in ref");
@@ -3509,9 +3516,11 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 {
 	struct strbuf referent_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf abs_gitdir = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = {0};
+	unsigned int symbolic_link = 0;
 	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
@@ -3521,8 +3530,37 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
 	report.path = refname.buf;
 
-	if (S_ISLNK(iter->st.st_mode))
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char* relative_referent_path;
+
+		symbolic_link = 1;
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
+					      FSCK_MSG_BAD_SYMREF_TARGET,
+					      "point to target outside gitdir");
+			goto cleanup;
+		}
+
+		strbuf_addstr(&referent, relative_referent_path);
+		ret = files_fsck_symref_target(o, &report,
+					       &referent, &referent_path,
+					       symbolic_link);
+
 		goto cleanup;
+	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
 		ret = error_errno(_("%s/%s: unable to read the ref"),
@@ -3563,7 +3601,8 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		strbuf_rtrim(&referent_path);
 		ret = files_fsck_symref_target(o, &report,
 					       &referent,
-					       &referent_path);
+					       &referent_path,
+					       symbolic_link);
 	}
 
 cleanup:
@@ -3571,6 +3610,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
 	strbuf_release(&referent_path);
+	strbuf_release(&abs_gitdir);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e0bf8c8c8b..e735816d5b 100755
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
+	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-1 &&
+	test_cmp expect err &&
+
+	ln -sf ../../logs/branch-bad $branch_dir_prefix/branch-symbolic-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-2 &&
+	test_cmp expect err &&
+
+	ln -sf ./"branch   space" $branch_dir_prefix/branch-symbolic-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
+	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-symbolic-3 &&
+	test_cmp expect err &&
+
+	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
+	EOF
+	rm $tag_dir_prefix/tag-symbolic-1 &&
+	test_cmp expect err &&
+
+	ln -sf ./ $tag_dir_prefix/tag-symbolic-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
+	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
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
+	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
+	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
+	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
+	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
+	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
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

