Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35B1E5705
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517689; cv=none; b=CaVsOTNSjE5ZL9QgdXaRtU+jZHhrren5d8mK8qigTZ5+yyidaOSvnuofrW2/fxiJqwRWHN1kTjY+JP3zA7uFtdtMhL5G2QPwp+Es7ZeElCArwwZyqkHKWGOoKzZP72au3RG/dCHwJSbUS1QZaXGvRVr2fhK8dwigYmapQtZjCqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517689; c=relaxed/simple;
	bh=GJLazU+dCdSgE10awpnKVBoQQUzQ6/IqD6H194iqA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+YS+capySJle13y/aO0K2XSv0oyfZRHES0LD1iZvRntM6odlitciqP7MnnIz/iRh2rtn5ARzplz1+iJKDgPmcRpynv5UGEB473H/7PNldn/nKCMHZfOx4q1Ylo+6I2hzEP+CcMaX/SKyMGEt57ygBeHNa0xN/c1AHhf4PHwTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMzcMTfD; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMzcMTfD"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7eae96e6624so873477a12.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517686; x=1730122486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFU0TdtTS78gcnNCH1jRtNx6PdVqgtzc6vnVLLxx0Tg=;
        b=DMzcMTfDUzNjJbzCARXkNYGTG6+ZQ7OoLMhnvJpLk4B1t98q0dyPdU5/R6V/CNPEpH
         c6mH3BjMULsbQbSEphsUgKxdljM7cUsrz0/Fu9+jXUa6M6QIEE4IyEPGEtRayavCJq9o
         xj2fwKbMvhDDGUBSDdC9JYn6nIcsqOTyMWhJiiWZGLEU7SIfSN7qrdo0BWB0aTKBGSZI
         JK9TatvwS58WyZzCFwf2Rm+Qoc1hLoEY/jScIQNLjn7L7KLyVLl6kz8C0Zjndc2ERMQs
         EUTzx1vv2uRrDe9ruCb7Mhexikf883FcOvLaXu+txlyRaJO41JkxEgm7AvaGYeQFTdqA
         Piew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517686; x=1730122486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFU0TdtTS78gcnNCH1jRtNx6PdVqgtzc6vnVLLxx0Tg=;
        b=wK8ndmLN8z+pjvA3pIDC5w2T9S6VPkMbzJqS56Stoua2VZ8AefOCBjxRTqILQ4rUEd
         hQqpYAAoqZ14AWJfFIF3VxZsxB1d9Ca/GaCYqgg9snEsHLW6HEDdeoRrB01M2/eEErvb
         7YqO4VNayh9cLBOzVRMwGiZJ+Z83NfcBZIoqgc+X0rgZl88Ni3Ej9pxwr7Ya7R3NXFnb
         qerGkK5xRwdam0kA75uD9y8fhsrhLd0C9W3LnETwQKNal9Q5+Ci4a2sVxm/kuDmmjl6/
         MCXUPwR6Cvpx0jTkmaVWr7YsSI6AS6u6PTcfxb3VUEVXLFd2wZDvCMpE3ZuPWrTi8e3S
         yqgg==
X-Gm-Message-State: AOJu0Yx3cCqyAGpJXE7CwWBksYGl6vxjPWsAI6vgSwUHl4uSHqpQHure
	MMnyuFDePB69LW86lUYEYJuiyY+kVg2GXQgeHjCqNMCZfeRJIkB+uUksgwqw
X-Google-Smtp-Source: AGHT+IG0ijOh+ws9ylH5jIlfQiStKL30DWnehkR/5F/DwiM7wuIaMsD1j4jk0oO7+qbKMeYqtPSNmA==
X-Received: by 2002:a05:6a21:1304:b0:1d8:d3b4:7a73 with SMTP id adf61e73a8af0-1d92c4baaa2mr17014495637.4.1729517684731;
        Mon, 21 Oct 2024 06:34:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea1c4sm2834847b3a.152.2024.10.21.06.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:34:44 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:34:47 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 5/9] ref: port git-fsck(1) regular refs check for files
 backend
Message-ID: <ZxZYd1qL6LxAc9-Y@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxZX5HDdq_R0C77b@ArchLinux>

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
 refs/files-backend.c          |  43 +++++++++++++
 t/t0602-reffiles-fsck.sh      | 117 ++++++++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+)

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
index 24ad73faba..2861980bdd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3505,6 +3505,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *target_name,
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
+				      "cannot read ref file '%s': (%s)",
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
 				const char *target_name,
@@ -3597,6 +3639,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 6eb1385c50..29bdd3fc01 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -164,4 +164,121 @@ test_expect_success 'ref name check should work for multiple worktrees' '
 	)
 '
 
+test_expect_success 'regular ref content should be checked (individual)' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	git refs verify 2>err &&
+	test_must_be_empty err &&
+
+	bad_content=$(git rev-parse main)x &&
+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-1: badRefContent: $bad_content
+	EOF
+	rm $tag_dir_prefix/tag-bad-1 &&
+	test_cmp expect err &&
+
+	bad_content=xfsazqfxcadas &&
+	printf "%s" $bad_content >$tag_dir_prefix/tag-bad-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-2: badRefContent: $bad_content
+	EOF
+	rm $tag_dir_prefix/tag-bad-2 &&
+	test_cmp expect err &&
+
+	bad_content=Xfsazqfxcadas &&
+	printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
+	EOF
+	rm $branch_dir_prefix/a/b/branch-bad &&
+	test_cmp expect err
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
+	bad_content_1=$(git rev-parse HEAD)x &&
+	bad_content_2=xfsazqfxcadas &&
+	bad_content_3=Xfsazqfxcadas &&
+
+	printf "%s" $bad_content_1 >$worktree1_refdir_prefix/bad-branch-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content_1
+	EOF
+	rm $worktree1_refdir_prefix/bad-branch-1 &&
+	test_cmp expect err &&
+
+	printf "%s" $bad_content_2 >$worktree2_refdir_prefix/bad-branch-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content_2
+	EOF
+	rm $worktree2_refdir_prefix/bad-branch-2 &&
+	test_cmp expect err &&
+
+	printf "%s" $bad_content_3 >$worktree1_refdir_prefix/bad-branch-3 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: worktrees/worktree-1/refs/worktree/bad-branch-3: badRefContent: $bad_content_3
+	EOF
+	rm $worktree1_refdir_prefix/bad-branch-3 &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.47.0

