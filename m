Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E64F84A57
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247627; cv=none; b=pwh9EB/AdNigA0k3zfq28Opue3tGbQwAPfqfg8Njc1VvHVwpW0ayjPGYCfMb7kHZJJ4n5A9SDWq1TlLZPnC9EXOW60gG/p51jDseX7MNTf/fw34GPzF1bfvW8hv8APCWCA+VYmpia2U9CGEbfMfUfX9tNLyVL0dAnA/h8ILB46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247627; c=relaxed/simple;
	bh=8Rt2HlX7gJnNbd8C7ljJ/n4PVKE6USkN5NDJAh+yTeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMwIOB445pIw8MsPHgr4RcPPJPjbT8T84agocMdFbG6hSkikBwKP04vc9+N42uJRR6F6w2rGHWwLZ/l30hTug/DjG19zGnbrzebyeqn/Wx2cs13s7TAXiij374JFOrZelXlGFED7Ua6aDADRCovlqnvmFnIXYnTu0rRdtLjzB6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7yb5eWv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7yb5eWv"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f8a1626cso907972a12.3
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247624; x=1726852424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N+PklNMQHsY0+6pydbAjpwREYhZFgIxz6xPWfHR24lc=;
        b=L7yb5eWvDXBl/6S/uhcox3t0CkvE9hWrYQ1BNXGnqEZSv8tLI9b647HTSxjVpDRFQi
         NUnHzSm2roma+jFJ1okuVJ1McyIVVIhQntYOFG45OqVKqv0NLd4oJzB6v46PnEUrWypd
         /t1JA+kFWcvG/1zWddfpNWqc3VUhxYAO3tEtIS79KMYrTeBTofQU2iOLkgILY99uJ/B6
         tY5qSpc+ZurmeuDr5LZBpglLFuIVG8anhH7ZXcxobFyVgG6wzchX8LjWBLJ6QMCk+WAu
         Xy9GB+5houXZI7P0xWLMYaSAYHmgoibdDY2wg/h0+9+tmCTPrXGmZiiAxV57zZ1PRcYY
         Idzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247624; x=1726852424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+PklNMQHsY0+6pydbAjpwREYhZFgIxz6xPWfHR24lc=;
        b=V948iBYULZt0854QJvSIa6mfaBie9LgdDLxypqUrqRZLxDlWsge9/MZghg5IWP5eV8
         FIdfPzTV3cMSrJP6r6HTGahg9VOjW24dlW3+2koEni3wLwe4szMZNX90hURDCFRSiVT0
         dQGMxV/k5hD9SGiYFoCwvig2XpbowKFbeiqwhzlTEaK2Ds551qe3TnTyM/tDg8VwsIxS
         JhAqsmeiPBX2F3KGqS76d2kqOzv8sbyn4GZlJVjoNHS1euPjvAzlAdNK1LGQKwsddyGE
         ergwqF3eIViWcXkC9nupbpPZZH8gKoG1HM4a5qroaZSHWHJAiNZQSRzAVz7dp82vFnqs
         J+ag==
X-Gm-Message-State: AOJu0YxNfF+RCNB5jK3T5m4noH9kHywg+woqgYVLXKmHniWm9FrhrWQo
	ahoWRleHKcdOE1OqkwKH/LGDaSE5isKW2G7BM2hvMrIza0c9ZFQ5V0U8UQ==
X-Google-Smtp-Source: AGHT+IGT5KNcB/onsoHmFujLsSbt6cgYwP67JOqFk0Qm6Epfk3PAdwo9ETMCgeth5llLW4zJ04H+xw==
X-Received: by 2002:a05:6a20:43a0:b0:1cf:4679:9b97 with SMTP id adf61e73a8af0-1d112e8beffmr5294556637.37.1726247623972;
        Fri, 13 Sep 2024 10:13:43 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b0254sm6526251b3a.170.2024.09.13.10.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:13:43 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:14:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 0/5] add ref content check for files backend
Message-ID: <ZuRzCyjQFilGhj8j@ArchLinux>
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

Hi All:

This version handles some minor problems mainly focus at the improving
commit messages, comments and some minor problems.

1. Split [PATCH v3 2/4] into two commits [PATCH v4 2/5] and [PATCH v4
3/5]. [PATCH v4 2/5] integrates "git-fsck(1)"'s check and [PATCH v4 3/5]
tightens rules to check the refs with trailing garbage and refs without
newline.

2. Handle a lot of typo errors in original [PATCH v3 2/4]. And improve
the fsck-msgids documentation.

3. Improve [PATCH v4 4/5]'s commit message to first introduce the
tighten rules to be consistent with the [PATCH v4 3/5].

4. Remove "badSymrefTarget(ERROR)" fsck message. Add three new messages
to be more specific:

  1. badReferentFiletype(ERROR): The referent of a symref has a bad file
  type.

  2. badReferentName(ERROR): The referent name of a symref is invalid.

  3. escapeReferent(ERROR): The referent of a symref is outside the
  ref directory

5. Handle typos and some minor problems.

Because I add more commits, I provide the "--interdiff" here to make the
reviewer's life easier.

However, because I have not merged the latest ci fixup, so I cannot
verify some jobs in CIs. May need the help from Junio to verify.

Thanks,
Jialuo

shejialuo (5):
  ref: initialize "fsck_ref_report" with zero
  ref: port git-fsck(1) regular refs check for files backend
  ref: add more strict checks for regular refs
  ref: add symref content check for files backend
  ref: add symlink ref content check for files backend

 Documentation/fsck-msgids.txt |  25 +++
 fsck.h                        |   7 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 202 +++++++++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 334 ++++++++++++++++++++++++++++++++++
 6 files changed, 560 insertions(+), 12 deletions(-)

Interdiff against v3:
diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 9e8e1ac7f0..31626e765b 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -20,7 +20,7 @@
 	(ERROR) A commit object has a bad parent sha1.
 
 `badRefContent`::
-	(ERROR) A ref has a bad content.
+	(ERROR) A ref has bad content.
 
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
@@ -28,9 +28,11 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
-`badSymrefTarget`::
-	(ERROR) The symref target points outside the ref directory or
-	the name of the symref target is invalid.
+`badReferentFiletype`::
+	(ERROR) The referent of a symref has a bad file type.
+
+`badReferentName`::
+	(ERROR) The referent name of a symref is invalid.
 
 `badTagName`::
 	(INFO) A tag has an invalid format.
@@ -53,6 +55,9 @@
 `emptyName`::
 	(WARN) A path contains an empty name.
 
+`escapeReferent`::
+	(ERROR) The referent of a symref is outside the "ref" directory.
+
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
@@ -178,8 +183,8 @@
 	(WARN) Tree contains entries pointing to a null sha1.
 
 `refMissingNewline`::
-	(INFO) A ref does not end with newline. This kind of ref may
-	be considered ERROR in the future.
+	(INFO) A ref does not end with newline. This will be
+	considered an error in the future.
 
 `symlinkRef`::
 	(INFO) A symref uses the symbolic link. This kind of symref may
@@ -187,8 +192,8 @@
 	symlink support.
 
 `trailingRefContent`::
-	(INFO) A ref has trailing contents. This kind of ref may be
-	considered ERROR in the future.
+	(INFO) A ref has trailing content. This will be
+	considered an error in the future.
 
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
diff --git a/fsck.h b/fsck.h
index 1c6f750812..b72ee632a4 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,12 +34,14 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
-	FUNC(BAD_SYMREF_TARGET, ERROR) \
+	FUNC(BAD_REFERENT_FILETYPE, ERROR) \
+	FUNC(BAD_REFERENT_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
 	FUNC(BAD_TYPE, ERROR) \
 	FUNC(DUPLICATE_ENTRIES, ERROR) \
+	FUNC(ESCAPE_REFERENT, ERROR) \
 	FUNC(MISSING_AUTHOR, ERROR) \
 	FUNC(MISSING_COMMITTER, ERROR) \
 	FUNC(MISSING_EMAIL, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2a1b952f0d..c511deb509 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3449,14 +3449,12 @@ static int files_fsck_symref_target(struct fsck_options *o,
 				    unsigned int symbolic_link)
 {
 	size_t len = referent->len - 1;
-	const char *p = NULL;
 	struct stat st;
 	int ret = 0;
 
-	if (!skip_prefix(referent->buf, "refs/", &p)) {
-
+	if (!starts_with(referent->buf, "refs/")) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      FSCK_MSG_ESCAPE_REFERENT,
 				      "points to ref outside the refs directory");
 		goto out;
 	}
@@ -3473,7 +3471,7 @@ static int files_fsck_symref_target(struct fsck_options *o,
 
 	if (check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      FSCK_MSG_BAD_REFERENT_NAME,
 				      "points to refname with invalid format");
 		goto out;
 	}
@@ -3485,22 +3483,24 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	}
 
 	/*
-	 * Missing target should not be treated as any error worthy event and
-	 * not even warn. It is a common case that a symbolic ref points to a
-	 * ref that does not exist yet. If the target ref does not exist, just
-	 * skip the check for the file type.
+	 * Dangling symrefs are common and so we don't report them.
 	 */
-	if (lstat(referent_path->buf, &st))
+	if (lstat(referent_path->buf, &st)) {
+		if (errno != ENOENT) {
+			ret = error_errno(_("unable to stat '%s'"),
+					  referent_path->buf);
+		}
 		goto out;
+	}
 
 	/*
-	 * We cannot distinguish whether "refs/heads/a" is directory or nots by
+	 * We cannot distinguish whether "refs/heads/a" is a directory or not by
 	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
 	 * check the file type of the target.
 	 */
 	if (S_ISDIR(st.st_mode)) {
 		ret = fsck_report_ref(o, report,
-				      FSCK_MSG_BAD_SYMREF_TARGET,
+				      FSCK_MSG_BAD_REFERENT_FILETYPE,
 				      "points to the directory");
 		goto out;
 	}
@@ -3520,7 +3520,6 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = {0};
-	unsigned int symbolic_link = 0;
 	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
@@ -3533,7 +3532,6 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	if (S_ISLNK(iter->st.st_mode)) {
 		const char* relative_referent_path;
 
-		symbolic_link = 1;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_SYMLINK_REF,
 				      "use deprecated symbolic link for symref");
@@ -3549,21 +3547,20 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 				 abs_gitdir.buf,
 				 &relative_referent_path)) {
 			ret = fsck_report_ref(o, &report,
-					      FSCK_MSG_BAD_SYMREF_TARGET,
+					      FSCK_MSG_ESCAPE_REFERENT,
 					      "point to target outside gitdir");
 			goto cleanup;
 		}
 
 		strbuf_addstr(&referent, relative_referent_path);
 		ret = files_fsck_symref_target(o, &report,
-					       &referent, &referent_path,
-					       symbolic_link);
+					       &referent, &referent_path, 1);
 
 		goto cleanup;
 	}
 
 	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
-		ret = error_errno(_("%s/%s: unable to read the ref"),
+		ret = error_errno(_("unable to read ref '%s/%s'"),
 				  refs_check_dir, iter->relative_path);
 		goto cleanup;
 	}
@@ -3578,14 +3575,14 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	}
 
 	if (!(type & REF_ISSYMREF)) {
-		if (*trailing == '\0') {
+		if (!*trailing) {
 			ret = fsck_report_ref(o, &report,
 					      FSCK_MSG_REF_MISSING_NEWLINE,
 					      "missing newline");
 			goto cleanup;
 		}
 
-		if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
+		if (*trailing != '\n' || *(trailing + 1)) {
 			ret = fsck_report_ref(o, &report,
 					      FSCK_MSG_TRAILING_REF_CONTENT,
 					      "trailing garbage in ref");
@@ -3602,7 +3599,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		ret = files_fsck_symref_target(o, &report,
 					       &referent,
 					       &referent_path,
-					       symbolic_link);
+					       0);
 	}
 
 cleanup:
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index e735816d5b..7c3579705f 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -268,7 +268,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
+	error: refs/heads/branch-bad-1: badReferentName: points to refname with invalid format
 	EOF
 	rm $branch_dir_prefix/branch-bad-1 &&
 	test_cmp expect err &&
@@ -276,7 +276,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
+	error: refs/heads/branch-bad-2: escapeReferent: points to ref outside the refs directory
 	EOF
 	rm $branch_dir_prefix/branch-bad-2 &&
 	test_cmp expect err &&
@@ -284,7 +284,7 @@ test_expect_success 'textual symref content should be checked (individual)' '
 	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
+	error: refs/heads/branch-bad-3: badReferentFiletype: points to the directory
 	EOF
 	rm $branch_dir_prefix/branch-bad-3 &&
 	test_cmp expect err
@@ -311,9 +311,9 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badSymrefTarget: points to refname with invalid format
-	error: refs/heads/branch-bad-2: badSymrefTarget: points to ref outside the refs directory
-	error: refs/heads/branch-bad-3: badSymrefTarget: points to the directory
+	error: refs/heads/branch-bad-1: badReferentName: points to refname with invalid format
+	error: refs/heads/branch-bad-2: escapeReferent: points to ref outside the refs directory
+	error: refs/heads/branch-bad-3: badReferentFiletype: points to the directory
 	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
 	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
 	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
@@ -347,7 +347,7 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (individu
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
+	error: refs/heads/branch-symbolic-1: escapeReferent: point to target outside gitdir
 	EOF
 	rm $branch_dir_prefix/branch-symbolic-1 &&
 	test_cmp expect err &&
@@ -356,7 +356,7 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (individu
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
+	error: refs/heads/branch-symbolic-2: escapeReferent: points to ref outside the refs directory
 	EOF
 	rm $branch_dir_prefix/branch-symbolic-2 &&
 	test_cmp expect err &&
@@ -365,7 +365,7 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (individu
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
+	error: refs/heads/branch-symbolic-3: badReferentName: points to refname with invalid format
 	EOF
 	rm $branch_dir_prefix/branch-symbolic-3 &&
 	test_cmp expect err &&
@@ -374,7 +374,7 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (individu
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
-	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
+	error: refs/tags/tag-symbolic-1: badReferentName: points to refname with invalid format
 	EOF
 	rm $tag_dir_prefix/tag-symbolic-1 &&
 	test_cmp expect err &&
@@ -383,7 +383,7 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (individu
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	warning: refs/tags/tag-symbolic-2: symlinkRef: use deprecated symbolic link for symref
-	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
+	error: refs/tags/tag-symbolic-2: badReferentFiletype: points to the directory
 	EOF
 	rm $tag_dir_prefix/tag-symbolic-2 &&
 	test_cmp expect err
@@ -407,11 +407,11 @@ test_expect_success SYMLINKS 'symlink symref content should be checked (aggregat
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
-	error: refs/heads/branch-symbolic-1: badSymrefTarget: point to target outside gitdir
-	error: refs/heads/branch-symbolic-2: badSymrefTarget: points to ref outside the refs directory
-	error: refs/heads/branch-symbolic-3: badSymrefTarget: points to refname with invalid format
-	error: refs/tags/tag-symbolic-1: badSymrefTarget: points to refname with invalid format
-	error: refs/tags/tag-symbolic-2: badSymrefTarget: points to the directory
+	error: refs/heads/branch-symbolic-1: escapeReferent: point to target outside gitdir
+	error: refs/heads/branch-symbolic-2: escapeReferent: points to ref outside the refs directory
+	error: refs/heads/branch-symbolic-3: badReferentName: points to refname with invalid format
+	error: refs/tags/tag-symbolic-1: badReferentName: points to refname with invalid format
+	error: refs/tags/tag-symbolic-2: badReferentFiletype: points to the directory
 	warning: refs/heads/branch-symbolic-1: symlinkRef: use deprecated symbolic link for symref
 	warning: refs/heads/branch-symbolic-2: symlinkRef: use deprecated symbolic link for symref
 	warning: refs/heads/branch-symbolic-3: symlinkRef: use deprecated symbolic link for symref
-- 
2.46.0

