Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58211EEE0
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247822; cv=none; b=H31Bjq9bsz1Dn/68t5vu4V8Sq05EvscJG7HkTIYhJJrKZkKpnDX9/df7kbE6chDxeA23q8edI+I8+3OkUiCscLezJAbqwjth7yzsOqizE1OebYr/ptSX9RUnMRk/uGmbnGBfHfMl93x0zSokfOZRJFWsFgLb5xLEgunanU7pVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247822; c=relaxed/simple;
	bh=OhGORKm+WzOH6a6N5pnzZN3RTC+86gZsP+KutYOPL1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJUH68PsY3S+rWgSXLLRCH/YcBcYElYD+5XGay9sX8HH/Jymy3C1ShYl5iG3tui99T9Gh/nonI31qm+SErDhmcPqhSowthI99RESN4MfANrE6H5LJSw7pFVTxZgK/wTNUS1eoWiOSkzHT+63VaUpRih8CgR2pt2efRYO4Pis6Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D38CZDup; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D38CZDup"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718e2855479so1808326b3a.1
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247820; x=1726852620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cAM1klxnaoWNDeAZoiNYXJICZCovJJwhKXZYT8wqVl8=;
        b=D38CZDupfA+/Ua8zIfgJQlCfIExc8fuDrz5WFNyOfm3AbtS9+rmxsK8QiJKtZmJysZ
         RETEBW0IGe3JJCmXBns5Px1EWKF/SAIdhFwoddK8rZc802StEuw6YYhHXzJkR9hxaPi5
         /jL/nj2SMAS8xchFQ4UNaTy2gtxM4IQGJDhpXTaAu8sXdGTA4MGyGko76oqSxJXdZwrc
         qRObG3jtVtxMinoneIN1OR4L5Z1gpLoxHFpYzR5RkwGyikK76k5kIgkvmVZm2zxS9YA0
         aogNbLzTTs3cK1ERpRPfdem1kWqMLfva6spjCACUf5ctYZli2scvCNRl6INycu+SDX1W
         qO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247820; x=1726852620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAM1klxnaoWNDeAZoiNYXJICZCovJJwhKXZYT8wqVl8=;
        b=Pq/1Wh5xcSUGiuRsy+MtLYzGwiA2jZMOH7bhJEge62O2QpDTp6PR9ef1L45SYmnOyh
         FEQYJ/0wxwds+iMJA4dQrmgHW3h0e7SYNcdeY3krgbFPjZ+JZ+smynf+K0yo5qZYT8dh
         rFrN+9uT3rXP5Rv8OFT7FwU+67UDiGqUFHGMgZEp2VnzY7phfSioIVqbeelG7tL6W/EE
         36lJF2C/2U/SLHi72aip9qXpzJgWfGQoe6ULwXGQYovEPadT5ahz+LMmnCcD4X/3S4li
         IEbA4qP2op9viYHBmV7T2i9YzOeJMDNhN8+gH7ubuncMPmL3jesIL1ZZUOpAGkptbkao
         rEPg==
X-Gm-Message-State: AOJu0Ywq6ZLXAh9hxZgCr6lNdzgp37CCtQc2balaLs5YR+jvM7HB8HSw
	kLS44sDvWPuU4t0WpMi15d7CHaoV00KRp8kKZbQPzSFoR9ARHmVoupNtVw==
X-Google-Smtp-Source: AGHT+IHdmTNOwjllOK4LpRD/2MhbVEFFkg+eeNfknWJ3ByZZ6UCQK9sedooOgxJjG1YEkvKqx6tgWg==
X-Received: by 2002:a05:6a20:e30b:b0:1cf:3f2a:d1dd with SMTP id adf61e73a8af0-1cf75ead7b4mr11244710637.12.1726247819571;
        Fri, 13 Sep 2024 10:16:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fc8fafsm6321447b3a.34.2024.09.13.10.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:16:59 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:18:07 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 4/5] ref: add symref content check for files backend
Message-ID: <ZuRzzwZds8ys-JEN@ArchLinux>
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

We have already introduced the checks for regular refs. There is no need
to check the consistency of the target which the symref points to.
Instead, we just need to check the content of the symref itself.

A regular file is accepted as a textual symref if it begins with
"ref:", followed by zero or more whitespaces, followed by the full
refname, followed only by whitespace characters. We always write
a single SP after "ref:" and a single LF after the refname, but
third-party reimplementations of Git may have taken advantage of the
looser syntax. Put it more specific, we accept the following contents
of the symref:

1. "ref: refs/heads/master   "
2. "ref: refs/heads/master   \n  \n"
3. "ref: refs/heads/master\n\n"

Thus, we could reuse "refMissingNewline" and "trailingRefContent"
FSCK_INFOs to do the same retroactive tightening as we introduce for
regular references.

But we do not allow any other trailing garbage. The followings are bad
symref contents which will be reported as fsck error by "git-fsck(1)".

1. "ref: refs/heads/master garbage\n"
2. "ref: refs/heads/master \n\n\n garbage  "

And we introduce a new "badReferentName(ERROR)" fsck message to report
above errors to the user.

In order to check the content of the symref, create a function
"files_fsck_symref_target". It will first check whether the "referent"
is under the "refs/" directory, if not, we will report "escapeReferent"
fsck error message to notify the user this situation.

Then, we will first check whether the symref content misses the newline
by peeking the last byte of the "referent" to see whether it is '\n'.

And we will remember the untrimmed length of the "referent" and call
"strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
to check whether the trimmed referent format is valid. If not, we will
report to the user that the symref points to referent which has invalid
format. If it is valid, we will compare the untrimmed length and trimmed
length, if they are not the same, we need to warn the user there is some
trailing garbage in the symref content.

At last, we need to check whether the referent is a directory. We cannot
distinguish whether a given reference like "refs/heads/a" is a file or a
directory by using "check_refname_format". We have already checked bad
file type when iterating the "refs/" directory but we ignore the
directory. Thus, we need to explicitly add check here.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   9 +++
 fsck.h                        |   3 +
 refs/files-backend.c          |  81 +++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 117 ++++++++++++++++++++++++++++++++++
 4 files changed, 210 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 8827137ef0..03bcb77972 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -28,6 +28,12 @@
 `badRefName`::
 	(ERROR) A ref has an invalid format.
 
+`badReferentFiletype`::
+	(ERROR) The referent of a symref has a bad file type.
+
+`badReferentName`::
+	(ERROR) The referent name of a symref is invalid.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -49,6 +55,9 @@
 `emptyName`::
 	(WARN) A path contains an empty name.
 
+`escapeReferent`::
+	(ERROR) The referent of a symref is outside the "ref" directory.
+
 `extraHeaderEntry`::
 	(IGNORE) Extra headers found after `tagger`.
 
diff --git a/fsck.h b/fsck.h
index b85072df57..c90561c6db 100644
--- a/fsck.h
+++ b/fsck.h
@@ -34,11 +34,14 @@ enum fsck_msg_type {
 	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
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
index df4ce270ae..0cb4a2da73 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3434,11 +3434,80 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+/*
+ * Check the symref "referent" and "referent_path". For textual symref,
+ * "referent" would be the content after "refs:".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
+				    struct fsck_ref_report *report,
+				    struct strbuf *referent,
+				    struct strbuf *referent_path)
+{
+	size_t len = referent->len - 1;
+	struct stat st;
+	int ret = 0;
+
+	if (!starts_with(referent->buf, "refs/")) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_ESCAPE_REFERENT,
+				      "points to ref outside the refs directory");
+		goto out;
+	}
+
+	if (referent->buf[referent->len - 1] != '\n') {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_REF_MISSING_NEWLINE,
+				      "missing newline");
+		len++;
+	}
+
+	strbuf_rtrim(referent);
+	if (check_refname_format(referent->buf, 0)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_REFERENT_NAME,
+				      "points to refname with invalid format");
+		goto out;
+	}
+
+	if (len != referent->len) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_TRAILING_REF_CONTENT,
+				      "trailing garbage in ref");
+	}
+
+	/*
+	 * Dangling symrefs are common and so we don't report them.
+	 */
+	if (lstat(referent_path->buf, &st)) {
+		if (errno != ENOENT) {
+			ret = error_errno(_("unable to stat '%s'"),
+					  referent_path->buf);
+		}
+		goto out;
+	}
+
+	/*
+	 * We cannot distinguish whether "refs/heads/a" is a directory or not by
+	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
+	 * check the file type of the target.
+	 */
+	if (S_ISDIR(st.st_mode)) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_BAD_REFERENT_FILETYPE,
+				      "points to the directory");
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
 static int files_fsck_refs_content(struct ref_store *ref_store,
 				   struct fsck_options *o,
 				   const char *refs_check_dir,
 				   struct dir_iterator *iter)
 {
+	struct strbuf referent_path = STRBUF_INIT;
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
@@ -3484,12 +3553,24 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 					      "trailing garbage in ref");
 			goto cleanup;
 		}
+	} else {
+		strbuf_addf(&referent_path, "%s/%s",
+			    ref_store->gitdir, referent.buf);
+		/*
+		 * the referent may contain the spaces and the newline, need to
+		 * trim for path.
+		 */
+		strbuf_rtrim(&referent_path);
+		ret = files_fsck_symref_target(o, &report,
+					       &referent,
+					       &referent_path);
 	}
 
 cleanup:
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
+	strbuf_release(&referent_path);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index a06ad044f2..9580c340ab 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -209,4 +209,121 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'textual symref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-no-newline-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/a/b/branch-complicated &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferentName: points to refname with invalid format
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err &&
+
+	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-2: escapeReferent: points to ref outside the refs directory
+	EOF
+	rm $branch_dir_prefix/branch-bad-2 &&
+	test_cmp expect err &&
+
+	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-3: badReferentFiletype: points to the directory
+	EOF
+	rm $branch_dir_prefix/branch-bad-3 &&
+	test_cmp expect err
+'
+
+test_expect_success 'textual symref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+	printf "ref: reflogs/heads/main\n" >$branch_dir_prefix/branch-bad-2 &&
+	printf "ref: refs/heads/a\n" >$branch_dir_prefix/branch-bad-3 &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/branch-bad-1: badReferentName: points to refname with invalid format
+	error: refs/heads/branch-bad-2: escapeReferent: points to ref outside the refs directory
+	error: refs/heads/branch-bad-3: badReferentFiletype: points to the directory
+	warning: refs/heads/a/b/branch-complicated: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-complicated: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: missing newline
+	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/branch-no-newline-1: refMissingNewline: missing newline
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.0

