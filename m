Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3CF1EEE0
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247807; cv=none; b=MbdqoworNS78cAHCGe3YA8E+49y1+N2FF4C2n8b5XUjuaFWZtD7UbwHY2vOvnBGsRCCDe+A2k2N0YJIO/FDJWv6I6FsRDQyJa1wZe1vB6SUjRiBx6vRbDcj1Z02lKdYccXPQyqMjaZsEYAJXpmYrUcU5Xw9P/i0s8mZHV6Q5/I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247807; c=relaxed/simple;
	bh=FaV57rEiAL7/iJUjn/Rm1+vBriELlI1QOaQv5uZth44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M98zpw+N+U+fq0XvDBbW+EGwprwF7hx1nk0+3bUwYlMKn1BEkoo83hY++kmzyxtEMQgDvBB8Y1XB+wPbV3SzFGpNiq+b2o0yYY7UHbIzxhQH/e7UbUyyS25Mrw1gvV6E48CQT9e4uhgXZb3ZSeqZsuev8J/QDm+gwjlxThh+GgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffreELEQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffreELEQ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e11e4186so2223001b3a.2
        for <git@vger.kernel.org>; Fri, 13 Sep 2024 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726247804; x=1726852604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypX13elVG1B9f26um6JWWC8armjF1e0oEu2SmguDvmQ=;
        b=ffreELEQPppy8E1nL26GmH52EEtuDm2XM6GYvUTXqi5w6CSy60YlRt+KX4VLyOllFX
         2zG5+X9T+CxWeqCBA6DIY4Ss6bK+nEJ/HTbJtLrrejlp3GZywlPD8+OYv5FwOEj11zSm
         sQVMw5t0H0oX38X+Lco2sstQL4y4uWCCknLg3NiRjKClMwAoA+N9tUYX4s0f2ZJZnna0
         Lnr9rdK6JKh6aT5TB0Q6LEzcIihtKb4MRRAHUFgMysjvuzBulKkNOSKRD3Z0sIxNuNGh
         BLyf+bAYJTZ4I5c4iQnsZU89E09ttYvbB1mqM82PH+HGsZbqsr3AUAjgl8GjAgHKUY3U
         mCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726247804; x=1726852604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypX13elVG1B9f26um6JWWC8armjF1e0oEu2SmguDvmQ=;
        b=lKuiMHe1gUAsffvu8b54u++gFbo0geolHoXrv8XmD2U+o8Wbfm9YcYG3NXEM0pGrfj
         zqm7p8kcrTyx6+g5XXIY+4Y4ZbrMbX/8XwilTv3ZxOyCEYlKZHMbpvRJJCrK2zZPyYtY
         GJNjIyu3zP3p5M8CLEBsK+KkUSh7PSaNc/vzkuq0zlC23UIJPu95BQfqtF1a/hseYedQ
         qhJeuuaFyMaZYhcQZ9cnmHp4LxEvSMFA2+4sxj+28qmSIKywndCJIz8rsn0RQA+b61+q
         tffVI+zdboP3JB8ridRivUPHQrwjlFOQxXeaQzGmzUZBdzf/av+aL8PAbc8aOkX1ilRb
         0Bdw==
X-Gm-Message-State: AOJu0Yzox+XOvrf4/dXDc8FXt7E/dQ19+f+I+U+fGQKodAL6oHjFWt1w
	MBTQcbAh88joLpzbDrGll+MxraQ2ij8Zdwldgf4OAIgufy/GlJzmDWf2rw==
X-Google-Smtp-Source: AGHT+IFncdEYCpXAY7oWHuWr+3TooUOcv5fs3tQfNmHY4Mxq2/ianUesneOkk/z1/iGqX3Iy55T7VQ==
X-Received: by 2002:a05:6a00:3d12:b0:714:1f6d:11e5 with SMTP id d2e1a72fcca58-719260815d3mr11286747b3a.12.1726247804113;
        Fri, 13 Sep 2024 10:16:44 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c9779sm6330099b3a.190.2024.09.13.10.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 10:16:43 -0700 (PDT)
Date: Sat, 14 Sep 2024 01:17:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 2/5] ref: port git-fsck(1) regular refs check for files
 backend
Message-ID: <ZuRzwKTFd65RL4HC@ArchLinux>
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

We implicitly rely on "git-fsck(1)" to check the consistency of regular
refs. However, we have already set up the infrastructure of the ref
consistency checks. We need to port original checks from "git-fsck(1)".
Thus, we could clean the "git-fsck(1)" code by removing these implicit
checks.

The "git-fsck(1)" command reports an error when the ref content is
invalid. Following this, add a similar check to "git refs verify".
Add a new fsck error message called "badRefContent(ERROR)" to represent
that a ref has an invalid content.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 43 +++++++++++++++++++++++++
 t/t0602-reffiles-fsck.sh      | 60 +++++++++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+)

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
index 890d0324e1..b1ed2e5c04 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3430,6 +3430,48 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_content(struct ref_store *ref_store,
+				   struct fsck_options *o,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
+	struct fsck_ref_report report = {0};
+	unsigned int type = 0;
+	int failure_errno = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+	report.path = refname.buf;
+
+	if (S_ISLNK(iter->st.st_mode))
+		goto cleanup;
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		ret = error_errno(_("unable to read ref '%s/%s'"),
+				  refs_check_dir, iter->relative_path);
+		goto cleanup;
+	}
+
+	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+				     ref_content.buf, &oid, &referent,
+				     &type, &failure_errno)) {
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "invalid ref content");
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 				struct fsck_options *o,
 				const char *refs_check_dir,
@@ -3512,6 +3554,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..a1205b3a3b 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -89,4 +89,64 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
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
+	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-bad-1 &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-bad-2 &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
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
+	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
+	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
+	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
+	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
+	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.0

