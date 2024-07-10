Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0DC15E97
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622914; cv=none; b=Zvz/RcOZ0boUxhA7husxqLfcRJdBY/fMPv/9HSFxAAff6agdEoPR6aLVc9fA2VRflPG32VUO4w2gXQt8I7UKR7/8B5gqx87euDjM70NDK3dQGjyYLg3uQe1wAivQOYL9jvKIBGS8H2jVoEcXFoQW3wjhLuu9bHjIblNOUnCT/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622914; c=relaxed/simple;
	bh=fbfeoJfAByVgMoH+JvXBcYph/vU427zkAAKHaM56PL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMFgdU/G0CqeosFhPwIUDuVHlREguqoc+RTnPYaFdfA5BsUOFCdKfUeieOQa0FtWEV5wHuqVLLCy8Yq939++NW7OqBAdGsy0JV/xaIQ+BQHxSGUjUA7wxVV+Rf1jPXl2ypiVYCOpgMqBnZB4UI7gkVTOc21JkIVpypdkFhLnnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX5gqUm1; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5gqUm1"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b03ffbb3aso5081642b3a.0
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622912; x=1721227712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=luLpBm2E/RD4NWyfpW0ujaF1ocfuQODuc/lwcYuSuo8=;
        b=PX5gqUm1bRn2HPaaM4lcTK8eq2QQLIy6oGVYSqIe3uyUfbpnL/YwvuAaTp89V6xe0m
         g/Tk4QSzgDDWPdvu/bnSVzeKqb9aIiwuswznD7TcYa02SaPtzeHM6kK1z5XgTqnAw0Or
         JCm60FlIJctKROSnmsy/SLCorV3RoX4pjW8AKzU1WjSoGkq+GszyWFNK8zphtDgBc/9s
         GiTwBG7ATjtA34rtRP/EpQ+7jTOxd3C24jDQkh1ONAkvgsW9Ymf0I+XwR00mOEVqEtRw
         kQ9V6ENTHZR08S/d6PKzyO6CO4X5vcEVvtcet9dKwEtZm8YHfis5cbboxPpXOn7RSAKw
         w6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622912; x=1721227712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luLpBm2E/RD4NWyfpW0ujaF1ocfuQODuc/lwcYuSuo8=;
        b=o/kgm6J8Rk8GS/0e91KFyeagkYR7+2ATQpQ8q3Wv6DWZtfEFVFjrczpRRuT+EhZNkv
         3WO7VgIFGDjzXSf0zi/V7Hd/EM+4uvSgRiSdi9cQozQOblR1M8OJuJsWiRCPBSRXmDhZ
         AZBlmnmEbo3uk9FlN+nSSFpZIAV2qsug++r0xI3Tj9V6kfOe1R/p5F8iN5Mqm1DDN92B
         SnAEHsbp7klX1oo2DRzu4va1OsM4QwLYNoKKqL9L3Uv/QH8aDiu1gD98O+YklfdTUqaN
         ayAFqGEgF8DKPCSxvkYnkO0bslWWfoyZnGM9aduxNsDnPnpVBgUNV9kGGj+Q3A3I3AnH
         jcPg==
X-Gm-Message-State: AOJu0YzFk5UQ2xfujrFPb0qSJ89HI7PbqdqPbp3b10Jh0HHo0XbTuhDg
	T25lhaHxSOoocdupwz8/4l8ui81ENKQ6zw+v2AKj38d7qCRBOKnWKd6u6Q==
X-Google-Smtp-Source: AGHT+IGjteg2PWs0Q4q8K0Y1KIM1J6AH3SLrIY1nNgWuL0b8eQt7A8mFY6hiQENipvpq2GO27hGslg==
X-Received: by 2002:a05:6a21:999f:b0:1bd:24f9:1124 with SMTP id adf61e73a8af0-1c298242411mr7268553637.27.1720622911604;
        Wed, 10 Jul 2024 07:48:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397c50csm3974939b3a.147.2024.07.10.07.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:48:31 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:48:32 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 09/10] fsck: add ref name check for files backend
Message-ID: <Zo6fQJIzH8DRfgKg@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

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
index ef1f1ed15e..5fcb249735 100644
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
index 84acb58782..69a76048d3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3419,6 +3419,25 @@ typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_options *o,
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
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3470,6 +3489,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
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

