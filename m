Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBAD1AAE0C
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103497; cv=none; b=NLgk9QZllwlMSwNB3fXs5PZrMLGUyJYaHlMzaN7QP8kIEiXY2+Ktzb6D5NW/3GJ5rC7Eb/JC7YLVDbZn5vSi1/Lb5VHqnalSFwgQvasbRGlFDCt3KIqCNOHgy+UwCyuDF1V+C3Ndey0hixjB7kKa/JvBtCcAqgpFodDOe6r6jrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103497; c=relaxed/simple;
	bh=qJ81ExCHbCNdSUmSHASX4hcz6ZOAPSepsQw1focHBHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2Ow2/DUYswDlCGoCg31nlY9I92mUKGMhSCCHG4uXaGfH9YvMeun3Oj5sNg+zCET+vakhou1QDh4ak3/O7rocQWsX3tE0JTpZWrx2HXBppHSOfYuo0ZZfeJHWISh4tGBa0QfzAlsLp4a1Z1gU+/vjxAY+XJFCSVFcVjfBSFohQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSV5JKaQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSV5JKaQ"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f3da2c2cb5so1476570a12.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103493; x=1732708293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+hX8rRC7mutbNXprXUpAnbvB+6epTFpOsVa5uBlYZA=;
        b=BSV5JKaQzTswcAT/cae7Z0ilf7f/iJVJ+fz2l+VLP9WpcEISz/ibKwJ1dPyut3iQ0w
         DHoF0gjSzX1Kmvhd2sAgd58uSdiAu7VbYuIYbC+d6/CX1cFBxyM7W78HHzzmLkw2qtub
         ij/Y69Y80EuuOipgWy6WE70HQaC17J3KJCGkjMPCuR7z4UpezHh9ILMf1DTI5mMIkRyb
         eZkBdVPDrWU+7CNf6OKgSpFEZK3Aztp45xPH4ejZRpwy7D5Of6fD/wqK8twwY8t9WkJQ
         GEkNK9uMpe90VqCULuJw+BuMRkGQdN7vqJ3hEk1E9Q79DzgCgTxhAd9gM6wsjfq8npHx
         woUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103493; x=1732708293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+hX8rRC7mutbNXprXUpAnbvB+6epTFpOsVa5uBlYZA=;
        b=LS0pDtD6+OrHUNmTDGisqYsj0NdAkFmetCe8b6fgDiIGQ8EA9m7e/1aiEzDn4EtYeF
         1i0dzm3cXvFeg3nlKkV+cmWx17OekLj6GcHW3MPmc1FOzfE9Rapo78CNug5SpIINtv6r
         g5FdPkCUncXleCVmLqzKKLLctP8ClvavHhWsI0Lz2dZIsaP11i8Zkpv3ABThj7kpaMnO
         gQU3vykIZqtsAj/78GhkdZGtXyMhWYDq2FLeJw+1JKaYbPFxp5S9v4h6aPpR4dRTuLbb
         0CbsmP6XxgJqvsuM5cOfArI17FiXOQ/fDCiJ9rzs30vghFjuXvdHJwUowNVNJbuTeuT9
         FS7w==
X-Gm-Message-State: AOJu0YwJNF5Xo2lnq5f+9FPxKFCC2F6pT3wHpSWtlfBMPeJ5tfwzelKL
	Rsr4AjH3nookeRUARxzdK/NNNpXrhPIzt+vT5V1kZV70hdD0gtmUtDYvCA==
X-Gm-Gg: ASbGncvXdbAp6yVEav+qrdp0RwLxMHJyzN8zWMpOmZQaQwGX13Ipo3HwjJF4wq50aK+
	IR3OfXSvk8D7kXZkAB+is/+Jw6BqPaSSg5wBey5ZqgYEfOePIHsxYIeTIE7tNQyrmG3VJiZF2U5
	Fpx29vDqCZL9ISeUmD1Ylifgxyrg3cKHnJpIqt2CKjraJNRgmdqBF5LfcD4wUOC8rXilhR87/Tr
	yfkBOscqOsgjLae2yGBE77dSl9ucFe0R3iZep1ZSQDUZA==
X-Google-Smtp-Source: AGHT+IEvbwYYEYU4Q6eu2A39BupO7+5o0dpK0o9adwskRVm5r24wp+ujAz/eGIXJhfPeFR/gzMM6hQ==
X-Received: by 2002:a05:6a20:8418:b0:1db:f823:109f with SMTP id adf61e73a8af0-1ddb0625812mr3559495637.31.1732103493267;
        Wed, 20 Nov 2024 03:51:33 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb82fdsm1422752b3a.14.2024.11.20.03.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:51:32 -0800 (PST)
Date: Wed, 20 Nov 2024 19:51:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 5/9] ref: port git-fsck(1) regular refs check for files
 backend
Message-ID: <Zz3NTtPCe3gdzX8-@ArchLinux>
References: <Zz3MON9_9DGD6nsy@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3MON9_9DGD6nsy@ArchLinux>

"git-fsck(1)" implicitly checks the ref content by passing the
callback "fsck_handle_ref" to the "refs.c::refs_for_each_rawref".
Then, it will check whether the ref content (eventually "oid")
is valid. If not, it will report the following error to the user.

  error: refs/heads/main: invalid sha1 pointer 0000...

And it will also report above errors when there are dangling symrefs
in the repository wrongly. This does not align with the behavior of
the "git symbolic-ref" command which allows users to create dangling
symrefs.

As we have already introduced the "git refs verify" command, we'd better
check the ref content explicitly in the "git refs verify" command thus
later we could remove these checks in "git-fsck(1)" and launch a
subprocess to call "git refs verify" in "git-fsck(1)" to make the
"git-fsck(1)" more clean.

Following what "git-fsck(1)" does, add a similar check to "git refs
verify". Then add a new fsck error message "badRefContent(ERROR)" to
represent that a ref has an invalid content.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/files-backend.c          |  47 +++++++++++++++
 t/t0602-reffiles-fsck.sh      | 105 ++++++++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 68a2801f15..22c385ea22 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has bad content.
+
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
 
diff --git a/fsck.h b/fsck.h
index 500b4c04d2..0d99a87911 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_CONTENT, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8bfdce64bc..9f300a7d3c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3505,6 +3505,52 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refname,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_content(struct ref_store *ref_store,
+				   struct fsck_options *o,
+				   const char *target_name,
+				   struct dir_iterator *iter)
+{
+	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct fsck_ref_report report = { 0 };
+	unsigned int type = 0;
+	int failure_errno = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	report.path = target_name;
+
+	if (S_ISLNK(iter->st.st_mode))
+		goto cleanup;
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		/*
+		 * Ref file could be removed by another concurrent process. We should
+		 * ignore this error and continue to the next ref.
+		 */
+		if (errno == ENOENT)
+			goto cleanup;
+
+		ret = error_errno(_("cannot read ref file '%s'"), iter->path.buf);
+		goto cleanup;
+	}
+
+	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+				     ref_content.buf, &oid, &referent,
+				     &type, &failure_errno)) {
+		strbuf_rtrim(&ref_content);
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "%s", ref_content.buf);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refname,
@@ -3600,6 +3646,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 1e17393a3d..162370077b 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -158,4 +158,109 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 	done
 '
 
+test_expect_success 'regular ref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	git refs verify 2>err &&
+	test_must_be_empty err &&
+
+	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+	do
+		printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-bad: badRefContent: $bad_content
+		EOF
+		rm $branch_dir_prefix/branch-bad &&
+		test_cmp expect err || return 1
+	done &&
+
+	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+	do
+		printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
+		EOF
+		rm $branch_dir_prefix/a/b/branch-bad &&
+		test_cmp expect err || return 1
+	done
+'
+
+test_expect_success 'regular ref content should be checked (aggregate)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	bad_content_1=$(git rev-parse main)x &&
+	bad_content_2=xfsazqfxcadas &&
+	bad_content_3=Xfsazqfxcadas &&
+	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
+	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
+	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
+	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
+test_expect_success 'ref content checks should work with worktrees' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	cd repo &&
+	test_commit default &&
+	git branch branch-1 &&
+	git branch branch-2 &&
+	git branch branch-3 &&
+	git worktree add ./worktree-1 branch-2 &&
+	git worktree add ./worktree-2 branch-3 &&
+	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+	(
+		cd worktree-1 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+	(
+		cd worktree-2 &&
+		git update-ref refs/worktree/branch-4 refs/heads/branch-1
+	) &&
+
+	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+	do
+		printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
+		EOF
+		rm $worktree1_refdir_prefix/bad-branch-1 &&
+		test_cmp expect err || return 1
+	done &&
+
+	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+	do
+		printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
+		EOF
+		rm $worktree2_refdir_prefix/bad-branch-2 &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_done
-- 
2.47.0

