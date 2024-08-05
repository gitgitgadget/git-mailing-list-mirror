Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338150269
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 16:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876368; cv=none; b=EIqVO3sssYyZ9nnbwVosC1CwnILeufgCmt0ZVHghUuKx52gqjpchJag+svR2NKgRXC6ihR+zV5M9n4WODMkBcevetGvjxX1S4q10NEj1HWdKCE2UGDpFulxiexM878HTM7GDoq5anvXkLb5gJ80LINE9XpYJdhvZlfJ9NZwmp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876368; c=relaxed/simple;
	bh=x1x0/L17MIv7FWq0nll16j0kP+Ld8pB6mIkv4TCw6FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABPf3f7rjJY7jgZqzgtxD8GDc1R0vGgvDgJM/HrDQKZnRo5xsuvXnzKqZKn4WfLBkJjFVnQjCTEFtMu3QfULIxdHZEcf081rb4wP/RgjNG7LSedK9osOMmdag8F00Vas9eWtFJBmiBSqMQQG+a1EzQxojrbdG8+MqSyvTK2wOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLHi3Pyx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLHi3Pyx"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so2752358b3a.2
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722876366; x=1723481166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7GVLAk1nKGAH84IIInM1iVRMLBlvgEqAvSnpkhYWf+o=;
        b=fLHi3Pyx5Fqtrl1HKlIXZ1xM+5IYycSS+4SxB9gSko0gWMUeMfknZOhAk5K0vJZ4K5
         PHABvXmEaTk5FiJqwWbFquNWGdjp0c3xy/MzjIiARPBZMZjjz71jdx8BzaG2E2D2h8i1
         pP7RO/l4Z3hMgknTLgwUNwCMj8FPMxfhhXtKBoYIGN3rikq0cgOcPsbJWk3fUl2U9/kF
         G1hyzlBQuS2Im7AAnF4h3TwvaSjKkE8GAkHfWII28VhLGLj+s/e4DFuX8drA+pPJhgmX
         RaE645SONEIV7BHgZVyHGhZNt3BTVpQQ/JomMu4rkv8jOHrTIlnFKUXuKGLhFf7daPxZ
         bKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722876366; x=1723481166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7GVLAk1nKGAH84IIInM1iVRMLBlvgEqAvSnpkhYWf+o=;
        b=v2oVvxOzR3IKOYl1e87EQbywkeRKUsHU5kItF/N0sJsc9KGVicwavlRQuun+N/3ffp
         OO/ZJkVxUPHGRQiRBicTl379nGNwZgd+TaHyrZMgDuxOtnZR6rm0ievtYbVsTsjbgbcI
         xzR1WAoGcDbTupK9s/uTd09mn7wCYaKM9tu8F86xkOAaNDDKRzmeKvBJ634moBCKtjdd
         A7wG/EfEBgT34lScp2Xv1Yr3VxfrC5DIBhkmvwz40ZHsW7zIG3+CuCg8UZeXqdI3dnxA
         v7kc15QEiRvRUbMfPJMDevfvQ0oJkubLp3lE8GiYa6R41Fxq/40n3obBWcJaNdULD2Gn
         GsjA==
X-Gm-Message-State: AOJu0Yzlh86avqRVHFPwo0IdY+O1IRcw2wW0Ik4xxZwPp94uouBlF5Wh
	tIcEzoNFeMoYkbt1HPQigvyyBwjzjnUYlgXz4hcFTLQfDF/lkPas7WmbUQ==
X-Google-Smtp-Source: AGHT+IELABheRQ4rPdOAWzOAUhuB63RBuYA7cZTA8q1qV/Rl0rqumVEVCRHbI0Pt8vGbIlXSqOdknQ==
X-Received: by 2002:a05:6a00:9158:b0:70b:20d9:3c2a with SMTP id d2e1a72fcca58-7106d045555mr11466028b3a.28.1722876365480;
        Mon, 05 Aug 2024 09:46:05 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2de28sm5571962b3a.191.2024.08.05.09.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:46:04 -0700 (PDT)
Date: Tue, 6 Aug 2024 00:46:33 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v15 9/9] fsck: add ref name check for files backend
Message-ID: <ZrEB6YWB82CyH0DI@ArchLinux>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrEBKjzbyxtMdCCx@ArchLinux>

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
index f337356860..6e6b47251d 100644
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

