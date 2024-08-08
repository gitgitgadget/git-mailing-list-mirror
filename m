Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BABB15534B
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116675; cv=none; b=bkebMe6IKrzmPYmeraLG8kcqBky8xQIv5o08//yNfNl4V5BbShEm9pGCdlN1L96St95DCAMvCOLvh38wnzRGS0O4riWdiEAoKE6gezvPzuag/PucO9DXiLtyHfuiaJgJvCksVH62srj5q/Yb0Xan1DeilfHidt9DWWRDzClg5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116675; c=relaxed/simple;
	bh=3tMP4uEjzZzahc+GKDcyD1gdBG8K5wRKhA5/9LSTuWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQZ0B+O8YbHG3e8+UwMW7hc+Otwnz0C8iw0OL0n9JlXFf2T97g6YRXDHKRt9GyQHdP8ipu7PaCBsfapxV0YmC+D9R//nw5F/yqmzOfjGREg/ZLNjT4MMLc7uFchuXrxFSH7IvnWz/lWaR1P5OpSbviWU0Z6tC4cC3iNJm0POvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLlVljbk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLlVljbk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so611822a12.3
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723116673; x=1723721473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxs3Rp1Bn4gj9+ZhnLJZqEXXntL8QK31pnSW5jvtwF4=;
        b=dLlVljbk+4vpEkaEeaUnsY0MEJGuGCLR0VbimcmaUwKrSGKKv1HjTkIGxCuYjlDW+J
         2DjeysiWuIquaTmkuPe/ND8jxwX5beFPCZbIZb3T9971j62ugT6tfb2pPqtbN8/sKlnQ
         dxT/1GlwgI7ba4l1hFYFQn3W96cErBROnuKXIQWEd6pMNY7kL0yF2ucunIvwaVw4+WUz
         tg9ByGLnNijhW+vkOqCp3c+kNC0xi9Wuet8laQk4Apy4If+ta6LFoi1nbriHOnGPPZZh
         2rTIcO7PXcBYSjC+nzSO44dAsyuHN7nqsAOf1FCumu/36XMDHTBZ+pCcoy/l2/hPafr2
         dJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116673; x=1723721473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxs3Rp1Bn4gj9+ZhnLJZqEXXntL8QK31pnSW5jvtwF4=;
        b=Pa/Jp8oc+svUQElt8b+M4mpOIa/em96hGg4adN2esxM/4Hc4D3aA6BP4uHs6n6qo22
         7OU/U5uof4GJs6uWlP5os2bgi2RxJ+l45N04/n47puZN6tEcoab5kd1mG/mkNaCCSITg
         Ya5xCdfTIFIoBs/bOwIsiJ0B+49+jf/4Okc1QH9Ggs/dnHq0zU5OSwFRIPLSx9xkv0dR
         ZRxblHxjL4tQ6+V66AkS0f4mX+BYiKaCPc0b5HnNJ8RipWsy4d5kyKgbkSLSy22IHNXr
         ACqgQ3HGelptjzSBqfSrCmQAQ6IhvFzdPAssJ5nnSH9u6gPyW2KLf0OVGtv1b1mPrASF
         HeXg==
X-Gm-Message-State: AOJu0YxZ4EVpZSqCux5xZZHzyCvUl2OuikZ3TwWpzdLyB/Ujqc/y0qz+
	dAFv7pbr+x5dHFozojp7HifY6Pwyme9RoJQe8XZayK+L20UUKE1BUIkWgWJArFk=
X-Google-Smtp-Source: AGHT+IFpuaE36ol3pv2gvAelMG+eEfX3Qgvk04Amawbw3WSQ+bn5VlkKFvMi/MtlmT2UWJD3a0kHZQ==
X-Received: by 2002:a05:6a20:9189:b0:1c6:b099:6f89 with SMTP id adf61e73a8af0-1c6fce779c0mr1897478637.4.1723116673047;
        Thu, 08 Aug 2024 04:31:13 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb22a455sm961077b3a.71.2024.08.08.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 04:31:12 -0700 (PDT)
Date: Thu, 8 Aug 2024 19:31:42 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v16 9/9] fsck: add ref name check for files backend
Message-ID: <ZrSsngBqfyTPDg7g@ArchLinux>
References: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrSqMmD-quQ18a9F@ArchLinux.localdomain>

The git-fsck(1) only implicitly checks the reference, it does not fully
check refs with bad format name such as standalone "@".

However, a file ending with ".lock" should not be marked as having a bad
ref name. It is expected that concurrent writers may have such lock files.
We currently ignore this situation. But for bare ".lock" file, we will
report it as error.

In order to provide such checks, add a new fsck message id "badRefName"
with default ERROR type. Use existing "check_refname_format" to explicit
check the ref name. And add a new unit test to verify the functionality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  3 ++
 fsck.h                        |  1 +
 refs/files-backend.c          | 31 ++++++++++++
 t/t0602-reffiles-fsck.sh      | 92 +++++++++++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100755 t/t0602-reffiles-fsck.sh

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 7c809fddf1..68a2801f15 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -22,6 +22,9 @@
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
 
+`badRefName`::
+	(ERROR) A ref has an invalid format.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index af02174973..500b4c04d2 100644
--- a/fsck.h
+++ b/fsck.h
@@ -32,6 +32,7 @@ enum fsck_msg_type {
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_FILETYPE, ERROR) \
+	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e511e1dcce..7f6eefa960 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3419,6 +3419,36 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
+				struct fsck_options *o,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	/*
+	 * Ignore the files ending with ".lock" as they may be lock files
+	 * However, do not allow bare ".lock" files.
+	 */
+	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
+		goto cleanup;
+
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		struct fsck_ref_report report = { .path = NULL };
+
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		report.path = sb.buf;
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_NAME,
+				      "invalid refname format");
+	}
+
+cleanup:
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3470,6 +3500,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o)
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
+		files_fsck_refs_name,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..71a4d1a5ae
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='Test reffiles backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+TEST_PASSES_SANITIZE_LEAK=true
+
+. ./test-lib.sh
+
+test_expect_success 'ref name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+
+	git commit --allow-empty -m initial &&
+	git checkout -b branch-1 &&
+	git tag tag-1 &&
+	git commit --allow-empty -m second &&
+	git checkout -b branch-2 &&
+	git tag tag-2 &&
+	git tag multi_hierarchy/tag-2 &&
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/.branch-1: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/.branch-1 &&
+	test_cmp expect err &&
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/@: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/@ &&
+	test_cmp expect err &&
+
+	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+	EOF
+	rm $tag_dir_prefix/multi_hierarchy/@ &&
+	test_cmp expect err &&
+
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+	git refs verify 2>err &&
+	rm $tag_dir_prefix/tag-1.lock &&
+	test_must_be_empty err &&
+
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/.lock: badRefName: invalid refname format
+	EOF
+	rm $tag_dir_prefix/.lock &&
+	test_cmp expect err
+'
+
+test_expect_success 'ref name check should be adapted into fsck messages' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	git commit --allow-empty -m initial &&
+	git checkout -b branch-1 &&
+	git tag tag-1 &&
+	git commit --allow-empty -m second &&
+	git checkout -b branch-2 &&
+	git tag tag-2 &&
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+	git -c fsck.badRefName=warn refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/.branch-1: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/.branch-1 &&
+	test_cmp expect err &&
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	git -c fsck.badRefName=ignore refs verify 2>err &&
+	test_must_be_empty err
+'
+
+test_done
-- 
2.46.0

