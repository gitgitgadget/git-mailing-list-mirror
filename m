Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41119E7D0
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103523; cv=none; b=OTfOYSOsimwjMzB5eGjsbT08mt1t/YmRMaIbpjhsH6CxQjT2uVQeb5iiiySDYVNuC/gdWtWY5W3ZaOCXxYWwOxFYkVs21UzsxH/0fuPrwRpp/dI/uIbfkQmMznfomkLGV5Rv8m1L4Uemz7OhJBb4pQBrjJrMD2cSe34fqxhpwoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103523; c=relaxed/simple;
	bh=4DCT3wjkdpMOZNpjLJ+Ud/P1fD2xWBYjJZf0Kt6sLJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNoIYo/jPYBxbGcprWyZUQTvvt/sgZUGMDWPmB2iYpzlOH0nGhRZT3tOp6ntdftJ3ToU9VIY8Cq2OGzXQ0IDb+YWIt1HSrzT6GnGxiisu4U+G90yG7tCSsL+Ouo+sX3cozOf0RoJD/D33//JV9JHqsdR2ExDpWFOGL68DmSW328=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjdMjGEl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjdMjGEl"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21270d64faeso3112525ad.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 03:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103520; x=1732708320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiqeCFZDqhipWUnEYmgeXzyRKYNgnuZZpfW5Y2b78gg=;
        b=QjdMjGEl7mN8vE5/0WxIRhA0AzZqDfTT2/zV4hbJmu65M5eE5gKZE38eXKhXf+Hcnn
         8hfG3V+GDrnLfVMihYBAQ6vK3r5ld1MBUpe2L10Ly56v3NGWCErlqej7MS/WNj0Qs3L2
         Nukii8fRututT1pX9BMasMWTeD6XHKNSrFNIyNTqq/WTSnshWXdXnaYlXuoUWmOHkyVH
         DilT0AndCZxRduxGgLpRdS8kMKRvVeVjAo9rXtcVSRf+PDI3MSELdXX90ju70xug3Jb9
         wan7eyAAaFMXF4AkLbL/B6xdsyWZVbSsWtzmow+NhDKhbp/V3uLk+GK0DQy/olJ7i1VD
         EW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103520; x=1732708320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiqeCFZDqhipWUnEYmgeXzyRKYNgnuZZpfW5Y2b78gg=;
        b=HEuC0DCk0460e2tCui19ibTrQWo1wa9EpVDhi4pIhQL32CyvVL6hodRpKzVMmBBnJH
         TOTdScEimHpXYGdY1V4IHXqnhqHo8maE+UcGK+90zUYv+tXWAmTKWHWZwXmq+1EdHFmZ
         aOxu+cN8d2wX59XGU9BXdeN+HQKHi8uL41usACy3DT4EwdRwuk63qHnhsIAjzbsdtW/l
         RAy75RekPLtSJulyK0Yp2HQXcXpk444WLKOgj06Zp9lz1iFg4wbtFEGfem2OaWZuuqTx
         xeaEtzK9gsW7V9X3U6YZ8jvTgoVkdGE/jeDRX2VfOcYj2+S6y7SqT0x5pirQeQffA8KC
         KMfw==
X-Gm-Message-State: AOJu0Yxtog8kvqtmJUmuj+22bfj3OazgNam7nTx97rMhmUi6LJKJWt9V
	dErTeoZgRz0//vS0BgsvqzNaQFqnBFIjL1rOFk1IqpmVrPDOOGgR9U5aKA==
X-Google-Smtp-Source: AGHT+IFsNYwuZKnfnbUDBD74cWR1VNXWQRwwhfy3v68Ur2i8K/+KVpLLfej+TD1nNC7iZPMjhQ/wtg==
X-Received: by 2002:a17:902:f705:b0:211:ebd:e370 with SMTP id d9443c01a7336-2126aea6566mr26362095ad.25.1732103520512;
        Wed, 20 Nov 2024 03:52:00 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2120ac38dbasm61054785ad.60.2024.11.20.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:52:00 -0800 (PST)
Date: Wed, 20 Nov 2024 19:52:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v9 8/9] ref: check whether the target of the symref is a ref
Message-ID: <Zz3NaXuIrVjDsJri@ArchLinux>
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

Ideally, we want to the users use "git symbolic-ref" to create symrefs
instead of writing raw contents into the filesystem. However, "git
symbolic-ref" is strict with the refname but not strict with the
referent. For example, we can make the "referent" located at the
"$(gitdir)/logs/aaa" and manually write the content into this where we
can still successfully parse this symref by using "git rev-parse".

  $ git init repo && cd repo && git commit --allow-empty -mx
  $ git symbolic-ref refs/heads/test logs/aaa
  $ echo $(git rev-parse HEAD) > .git/logs/aaa
  $ git rev-parse test

We may need to add some restrictions for "referent" parameter when using
"git symbolic-ref" to create symrefs because ideally all the
nonpseudo-refs should be located under the "refs" directory and we may
tighten this in the future.

In order to tell the user we may tighten the above situation, create
a new fsck message "symrefTargetIsNotARef" to notify the user that this
may become an error in the future.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  9 +++++++++
 fsck.h                        |  1 +
 refs/files-backend.c          | 14 ++++++++++++--
 t/t0602-reffiles-fsck.sh      | 29 +++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index dcea05edfc..f82ebc58e8 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -183,6 +183,15 @@
 	git@vger.kernel.org mailing list if you see this error, as
 	we need to know what tools created such a file.
 
+`symrefTargetIsNotARef`::
+	(INFO) The target of a symbolic reference points neither to
+	a root reference nor to a reference starting with "refs/".
+	Although we allow create a symref pointing to the referent which
+	is outside the "ref" by using `git symbolic-ref`, we may tighten
+	the rule in the future. Report to the git@vger.kernel.org
+	mailing list if you see this error, as we need to know what tools
+	created such a file.
+
 `trailingRefContent`::
 	(INFO) A loose ref has trailing content. As valid implementations
 	of Git never created such a loose ref file, it may become an
diff --git a/fsck.h b/fsck.h
index 5227dfdef2..53a47612e6 100644
--- a/fsck.h
+++ b/fsck.h
@@ -87,6 +87,7 @@ enum fsck_msg_type {
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
 	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(SYMREF_TARGET_IS_NOT_A_REF, INFO) \
 	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f4342e3f3e..c2b99fdf40 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3513,6 +3513,7 @@ static int files_fsck_symref_target(struct fsck_options *o,
 				    struct fsck_ref_report *report,
 				    struct strbuf *referent)
 {
+	int is_referent_root;
 	char orig_last_byte;
 	size_t orig_len;
 	int ret = 0;
@@ -3521,8 +3522,17 @@ static int files_fsck_symref_target(struct fsck_options *o,
 	orig_last_byte = referent->buf[orig_len - 1];
 	strbuf_rtrim(referent);
 
-	if (!is_root_ref(referent->buf) &&
-	    check_refname_format(referent->buf, 0)) {
+	is_referent_root = is_root_ref(referent->buf);
+	if (!is_referent_root &&
+	    !starts_with(referent->buf, "refs/") &&
+	    !starts_with(referent->buf, "worktrees/")) {
+		ret = fsck_report_ref(o, report,
+				      FSCK_MSG_SYMREF_TARGET_IS_NOT_A_REF,
+				      "points to non-ref target '%s'", referent->buf);
+
+	}
+
+	if (!is_referent_root && check_refname_format(referent->buf, 0)) {
 		ret = fsck_report_ref(o, report,
 				      FSCK_MSG_BAD_REFERENT_NAME,
 				      "points to invalid refname '%s'", referent->buf);
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index ee1e5f2864..692b30727a 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -366,6 +366,35 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	test_cmp expect sorted_err
 '
 
+test_expect_success 'the target of the textual symref should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	cd repo &&
+	test_commit default &&
+	mkdir -p "$branch_dir_prefix/a/b" &&
+
+	for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
+	do
+		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+		git refs verify 2>err &&
+		rm $branch_dir_prefix/branch-good &&
+		test_must_be_empty err || return 1
+	done &&
+
+	for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
+	do
+		printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
+		EOF
+		rm $branch_dir_prefix/branch-bad-1 &&
+		test_cmp expect err || return 1
+	done
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

