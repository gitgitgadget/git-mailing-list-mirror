Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8913C68E
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525304; cv=none; b=P5p1C9EK75CQnY6UbLvkQn2oW7YRO9dDXoGLAy/0iy7fZpPBMQK68d0aZ+DapBLw2txkwmDje6VeZgYDK0sJpd849BuxKpEviLGkPB8ztPzttWvU2lGA6R8T4y+wUgVIIxhUEX2NkE1j2543PcT4WsNYuzL98tl6/VpKBAsI0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525304; c=relaxed/simple;
	bh=FSwCfY5b2zX+WaHFdomIyhUr+fprPjxXGKBidiCrspE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxhY9GEaTPeso1ZdeAbtgfbUdUNe/RKN65FIwjEVx3poHyD2ggLNokwjlFJ61g5ULnfvwBV/Cei9rDesIlyiHe565btKeOaEapwKOF/AgrL8371x/Ic2hXqeLoNvQVVmJ31ED69SchLNKjcf+mH4e7OJwKnThpYbiWQkbm4BTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/qQqd0G; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/qQqd0G"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d333d57cdso5133765b3a.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525301; x=1723130101; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGTAi9V7Ce02hF3GVXPtYjyvAo1+9i33Dhi8/Yi5dRk=;
        b=Q/qQqd0GKDg6Kxu9/6HWlm2YIRjVVABaiqjxRObAvXQJSoGkwQrE+zs8ATWdfEywmR
         M8fA4pWtfGid3BXY5URzoVyNGExt4s80JVVP9HGAYDrECq0coSKHBc1tMkwLozSPipzj
         wyg5byHxdlWSAmMSBmMhUHf6sjr9E2NFnH2DJrQZwJNGJZKTrrhTnz6Evh3B3xo1JzyG
         qtqz9Z42/MXrcFsBUPsdYy3J72rtp8mCgMt8DaVXCbvYz4Z2oGt0JZMTThYNl8zHKqr+
         o6hQLnmyeNmm5D5Wxo4ka2YHFZG9YIa8xdiJiKi+hl28w+Qj8XG1yCU2oNrUd7kfDv/b
         NHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525301; x=1723130101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGTAi9V7Ce02hF3GVXPtYjyvAo1+9i33Dhi8/Yi5dRk=;
        b=Dk0FQq86JptygPyeo6rchdwN1fuhXR7XRA2ecbCDBdHpNNNoN5sE7wynv5j8D8lSLk
         zXimNdCuxda90Eqj3RIi8jwQxB9aAfdyuj2z7G/+qDrVZbp0x37g/+tJ4aNYZZe80j/J
         mPffqhTWxQdGozg/+p9/3eWetn1UdtdmdFonhA/mZce1HNIc6DxX4nwaRME4lSP7+ovE
         X9BhWGCG7Q5JmGhSjqcv8ru8SiZv+VA7V6etKuRktmd7lsXR4fz9AO1vZrpmqWEYnV35
         BXkN9rvkeW/XZ2IpuL4pyfD/K6SJKDl2y80UynzwMl98nDRNSLg47axaRVgNcFL/kGvE
         fmqQ==
X-Gm-Message-State: AOJu0YxPcddJPZDlvq3oxksRc4ZCnptCGzBJo9gYb2029ziuI7xv6k5s
	8YQpK1QJ3LZS62abIiq9u7eJHYT6qjZo12yNbeSuhiRRiVpdYj9Pxc1+SQ==
X-Google-Smtp-Source: AGHT+IE0SGQBwBXvsdMs3WksAVTwh/jCf/gWPM/Li6xTR5xcs0l2LiJHl3RDlkLE7O1LkN4+2qU9Vg==
X-Received: by 2002:a05:6a21:7896:b0:1c2:8c32:1392 with SMTP id adf61e73a8af0-1c69955f4bamr947668637.22.1722525301572;
        Thu, 01 Aug 2024 08:15:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead715733sm11609067b3a.84.2024.08.01.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:15:00 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:15:24 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 11/11] fsck: add ref name check for files backend
Message-ID: <ZqumjDzfeaLZQgr5@ArchLinux>
References: <ZqulmWVBaeyP4blf@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqulmWVBaeyP4blf@ArchLinux>

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
 refs/files-backend.c          | 32 ++++++++++++
 t/t0602-reffiles-fsck.sh      | 94 +++++++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+)
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
index 5574e78656..1186b6cbb1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3419,6 +3419,37 @@ typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_name(struct fsck_options *o,
+				const char *gitdir UNUSED,
+				const char *refs_check_dir,
+				struct dir_iterator *iter)
+{
+	struct strbuf sb = STRBUF_INIT;
+	size_t len = 0;
+	int ret = 0;
+
+	/*
+	 * Ignore the files ending with ".lock" as they may be lock files
+	 * However, do not allow bare ".lock" files.
+	 */
+	if (strip_suffix(iter->basename, ".lock", &len) && (len != 0))
+		goto clean;
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
+clean:
+	strbuf_release(&sb);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3471,6 +3502,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o)
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
+		files_fsck_refs_name,
 		NULL,
 	};
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
new file mode 100755
index 0000000000..2be28427ab
--- /dev/null
+++ b/t/t0602-reffiles-fsck.sh
@@ -0,0 +1,94 @@
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
+	test_must_fail git fsck 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/.branch-1: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/.branch-1 &&
+	test_cmp expect err &&
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	test_must_fail git fsck 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/@: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/@ &&
+	test_cmp expect err &&
+
+	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
+	test_must_fail git fsck 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
+	EOF
+	rm $tag_dir_prefix/multi_hierarchy/@ &&
+	test_cmp expect err &&
+
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+	git fsck 2>err &&
+	rm $tag_dir_prefix/tag-1.lock &&
+	test_must_be_empty err &&
+
+	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
+	test_must_fail git fsck 2>err &&
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
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+	git -c fsck.badRefName=warn fsck 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/.branch-1: badRefName: invalid refname format
+	EOF
+	rm $branch_dir_prefix/.branch-1 &&
+	test_cmp expect err &&
+
+
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	git -c fsck.badRefName=ignore fsck 2>err &&
+	test_must_be_empty err
+'
+
+test_done
-- 
2.45.2

