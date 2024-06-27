Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59015EFA4
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501481; cv=none; b=plyjZ1QKlgZyNPy5LW0471u7ICzJ7kRsg59LNXgw/xbTncGUIUViuXM7Pk9uwXEtp+2ADezRkA6H2b/QdMdwBlr0YuIWHGo7CJgoLZzmX426aUGf+s70IKBnYfkx/QhDHsfyCHXN16L2FaD0mlS98q0qDcRnjbc0CZZwVPlBj5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501481; c=relaxed/simple;
	bh=2Jorx0PwXWOhrxGBMlzhRs0RbK2JjykDd5pUimbqdYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhKRAagdgvISArNUp689L6qtV1QPcJLpp5XhHMvbevcpsHvM9eM5l7lTzZZMzsuvEF7WLeqtDHRLrC5tiZKvkt6hbAxbRI8bUO8j5xt4AxhbBkM+1jYK9HwAY/3vyW3ZM6Lu2zHNLvQS5ki4VL8FtYvQ8bc2kAERARifPXlkpz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2TmmhXi; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2TmmhXi"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7065a2f4573so4861061b3a.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501478; x=1720106278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQn820o0Xm8Tr+akXnLCY1hSNh1cPHx8kVQVfuo4geI=;
        b=D2TmmhXiCpQMeEwAoihk3D8Q8t/JR5zJVTd2zDxeGXkEpEjyHIe0aVAmdT9VrWgK2y
         /M8TUvG43+hIR82uVnbxfuoVzidsGbFyRdPRqmrbIq/WGhW8QnVYYHphnjy5wSa1Gch+
         f2boQfmtZmGQ2ur9kTouZvQMwxNX4dBbbqBDaZMycWXHSlQlCK/1jM27PPEyqjUrGwPu
         HZArC+ZBp+lv8E5iQNYbz0vxPfHt9+GMqLckGtKZvCphpTx+wsYNeX04J5zk+cqKlHuT
         heRydZgBJbVkIPT/XB5iQN4d5kMqgfjiPNqfAUf9V6DoTvk3VHR9oo4VTgz5g35EmwJX
         XAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501478; x=1720106278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQn820o0Xm8Tr+akXnLCY1hSNh1cPHx8kVQVfuo4geI=;
        b=gm0riUQ6HsBls+h+Hhmefu+uALXumcFswKGm4QQHcW29KDFO9eLWVy0Zj/t9Pnv+7I
         6/0Ayw5jbvIR1CR/PPRvUh8v7iW7OJdI2fav7GZriSwmug759OAtjeCMlRsq00SmIhfD
         micfyOoEzXFpScwjoGekOo/znqOfnB52s+02+3hLGDKOgdrHWSyGHFuxC7KCZyB2KayR
         h5oPeW1tsWiYu7otptnX+edMsQH3u5e+U0Ftm1F2l3ueQTNZ0F1akeq8m5MFnIJJWvmJ
         KykWVeDqwcSZAgQhfDB8Yq58AEURmFaVApn7Qyr/ckDWsSCoRJwJKIOxo4RS5IePO9bT
         ZhGA==
X-Gm-Message-State: AOJu0YyovzKt1hZQJRIJNXShbNeVGnD9UNTZ8UKNuBTOQbnDwzCX/XYL
	sfdFEoKXPUyBQtPdp2ywM1O3zGvvUxnzZRVEnzMTRAcyw8sBgpPlbBa4aA==
X-Google-Smtp-Source: AGHT+IHEG9sq97eEhyKrIE7BlUNytPaAHpovvS1pqBsF45Ci5FaplNPPK7Z7OYn9F8ixv/xRSS+FDw==
X-Received: by 2002:a05:6a20:3d8b:b0:1be:c4e6:ed40 with SMTP id adf61e73a8af0-1bec4e6ee22mr5390997637.51.1719501478509;
        Thu, 27 Jun 2024 08:17:58 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faac8f5a71sm14516505ad.109.2024.06.27.08.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:17:58 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:17:55 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 11/12] fsck: add ref name check for files backend
Message-ID: <Zn2Coy8iTWcfCu-g@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

The git-fsck(1) only implicitly checks the reference, it does not fully
check refs with bad format name such as standalone "@" and name ending
with ".lock".

In order to provide such checks, add a new fsck message id "badRefName"
with default ERROR type. Use existing "check_refname_format" to explicit
check the ref name. And add a new unit test to verify the functionality.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   3 +
 fsck.h                        |   1 +
 refs/files-backend.c          |  20 +++++++
 t/t0602-reffiles-fsck.sh      | 101 ++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100755 t/t0602-reffiles-fsck.sh

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index f643585a34..dab4012246 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefName`::
+	(ERROR) A ref has a bad name.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
diff --git a/fsck.h b/fsck.h
index e903845690..aad2211bff 100644
--- a/fsck.h
+++ b/fsck.h
@@ -31,6 +31,7 @@ enum fsck_msg_type {
 	FUNC(BAD_NAME, ERROR) \
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_REF_NAME, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aefc947fc3..e840a768b4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3417,6 +3417,25 @@ typedef int (*files_fsck_refs_fn)(struct fsck_refs_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_refs_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	int ret = 0;
+
+	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+		ret = fsck_refs_report(o, NULL, sb.buf,
+				       FSCK_MSG_BAD_REF_NAME,
+				       "invalid refname format");
+	}
+
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_refs_options *o,
 			       const char *refs_check_dir,
@@ -3468,6 +3487,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
+		files_fsck_refs_name,
 		NULL
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..b2db58d2c6
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='Test reffiles backend consistency check'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+GIT_TEST_DEFAULT_REF_FORMAT=files
+export GIT_TEST_DEFAULT_REF_FORMAT
+
+. ./test-lib.sh
+
+test_expect_success 'ref name should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2 &&
+		git tag multi_hierarchy/tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1.lock: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/@: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/@ &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+		test_must_fail git fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+		EOF
+		rm $tag_dir_prefix/multi_hierarchy/@ &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'ref name check should be adapted into fsck messages' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1 &&
+		git commit --allow-empty -m second &&
+		git checkout -b branch-2 &&
+		git tag tag-2
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+		git -c fsck.badRefName=ignore fsck 2>err &&
+		test_must_be_empty err
+	)
+'
+
+test_done
-- 
2.45.2

