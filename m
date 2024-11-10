Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CA01537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240596; cv=none; b=RUdDYzTj35hSIQXZM/edtiIpFO9qxBaNfMjkhrqXtSl2l71J4WVOkfhuBFOYM8X+EX98FwTp0XGIMTKmqesbdM+UN3zNruu/J8c7/FhCQa/cdU6qRK1CaGj74kDZP86l7oecQbePaBhIOORS9A6eqe2XMdRD1O6mOu9/yDF33eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240596; c=relaxed/simple;
	bh=OsnWJNxiKyo/n2Z7hmkTDl/rWU2xj8B7kKDzEECYBkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3005Qfjvmp2a6PEeiVZxkBAHjWpA+oZjrrqvwmVb3CJbQu5t5IDYi3zz3eq4Pfxz2NqkZEaekRr1lqF6O8rmH/CNLcYOPXnSAoixgnKnkH/9pQ9R31yysrlgWm2BkxCeTbPGnNZmj38UQcNDyj4fSgNUJa81B3cWyQtsqcg2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMsqKbtx; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMsqKbtx"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f3f1849849so2498569a12.1
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240593; x=1731845393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axn/V3vvugd/C60cNtfS/CP3iY8fWxJMJxFlnUTCwz8=;
        b=UMsqKbtxpN81vf5VVzpZGCESEftjikOnWUxtOEMS8n1vJVsTOA0Z0OuNFvw3SWMbrd
         D9hrDVP92FMQ5LWNTJJBSz4B4TzVLMoxr0zzgjmA1QHXxfkKc8cHlFQ4gXJa5qtMbeNt
         VBiTywiKih2JzothA7a5Kzg35Vm6OJsR0TYuYYwqEzaR3hoUgqxTHzQQ9LYtR+Hc0MRG
         5pe2AehrQBBdlakJfi/YIrxd2y8sPWKNQ68PbSTU3UergiCNXuBgqm3hlqnH0OjnZ1kR
         v5E1b/6P3UCP7uKplpb8GJZnG1FNuVSuu7Le7hYLfGHkdx0RxJrdXovcEI52W9KKZC94
         cwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240593; x=1731845393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axn/V3vvugd/C60cNtfS/CP3iY8fWxJMJxFlnUTCwz8=;
        b=PdJSMILh0AwS2/BwnPjBVfP99TKV+Koru6KzfwOUMBA8lj2P4E5ZQn/tqOfG2jweph
         msVlhgcSKDpJuxBK1VxZawh2yf3iCo5WvElsqATSGiM/H4LeApX+a6vhv20suk8LlX06
         ye4LqIkq0vA/dO5XA0q2/cLVfhd4J6LPhyXyOQOjdozvBdOBwKrPvLmgvaIF/Fo7tsDz
         tEV2WrWhOjNYJD8SMUJ3GTsCJocOBktLUJh0rPjHqUawZ0SK69Y0dtxM09mxTgfuqXka
         kWFBeoB8RoG0gRDOwJxB479YgSgKMx9a72dWXm7ag69HAmnCHGRIwZfh29IlFN1F+1Vx
         HiCA==
X-Gm-Message-State: AOJu0Yz+ANdU3x4PVU23tXIGoXwG8bFJI0J4LjaI7cuU8RqBP9WzMiC1
	upN7MhKsSf0mInfOKLkBTgk8/f3jfev4oZxS2rRWWuuodMGV3YPqZtEo6N+9VmY=
X-Google-Smtp-Source: AGHT+IF3UTgeUOtIHxsU0uYAU30wEtb8uIhR88SdcqcomLYyJuVwibobAG8+CCRwgCrDMMnqFaQ/AQ==
X-Received: by 2002:a17:90b:4b91:b0:2e1:d5c9:1bc4 with SMTP id 98e67ed59e1d1-2e9b165595cmr12988739a91.7.1731240593202;
        Sun, 10 Nov 2024 04:09:53 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fe87c2sm6695619a91.48.2024.11.10.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:09:52 -0800 (PST)
Date: Sun, 10 Nov 2024 20:09:51 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 5/9] ref: port git-fsck(1) regular refs check for files
 backend
Message-ID: <ZzCij4ilPLhlKXS6@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

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
 refs/files-backend.c          |  43 ++++++++++++++
 t/t0602-reffiles-fsck.sh      | 105 ++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)

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
index 8bfdce64bc..2d126ecbbe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3505,6 +3505,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
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
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "cannot read ref file '%s': %s",
+				      iter->path.buf, strerror(errno));
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
@@ -3600,6 +3642,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
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

