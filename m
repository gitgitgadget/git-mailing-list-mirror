Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A99A1F8936
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517711; cv=none; b=YzotMr7Spa4wacdKUuYkiv1ci9KWoLGaWYIbaM34EorjJvrFG9NXY4IEyVXGLpTISIbQFwS2x11o2VhWyZdGELl60xJeZ+yMsZ7LVKDUIiIqr+mv0Iav5ALSXGaNHbxjaTfY0v8MDUTXsPaXEW1QQZC3gZ1rD9UcMOfBcFqWFM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517711; c=relaxed/simple;
	bh=uJaUhkoiCFEP35d4+ZcI+0GnHZNSU9pQFCvCZYa7XJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpdsPWcgNFjPTnLUyOophhHd1GiJfqzP4OV857l5cfPo7Th8eCMJEcQyMn5z5D+OhPOiYGcaOFXa6NujXoJXn9yEH3wRNl/9wAZ/NNwQfI/B5lLb4HA4xlhA3cqc4uHvrOYg9stTzk0IDB/hFuohQCb0u/DN93+Zt+E00cU4qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0XrLLD8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0XrLLD8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cbca51687so45398525ad.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729517708; x=1730122508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sHSLQnIOzYfm4N+F3fe22TSH+Q/W51zDBhzlnzDilYE=;
        b=V0XrLLD8sKSlHuSSTUczdSKQImbsTVBUhAAoOj7UM1s2kq4Dmqfvbl7zZppLR3TWWw
         yKIlRoI/BaaZnxzteC5AgSMn/gI0rBRmfk/mRXn3WVeREdEHBaB2jDCYwh5pwJU4tu6o
         LJQyZabh2J0eOqnYVNyUcBP3i7NRKMZSu/fq7f9RCXqrd3fYW/tau4xExp6bUf1MU7J5
         C3HdmaCfbwQ8nBMNJaAOpEPfdm2DISMf3gbldf8f+VmwoDgoyNoGJVYTSqqciwWNKLrj
         lyVUQ+XOhg9JVfYJDW+cHQpWgFl7AxlsNIkhvBnTFnflsY4rA+Euwl/7GuqKWIkmHgJJ
         M5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517708; x=1730122508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHSLQnIOzYfm4N+F3fe22TSH+Q/W51zDBhzlnzDilYE=;
        b=ZwqN18tm1yxGRAk1SoBdnn/7bHWPdqF1a4vcKEt4dDHj7dWCxKwOz/wQjuW6UsVv+r
         A+HmXKEOBDhTA3YblYrT/kIAtOZZECVPyaT0Ua9irh2bUGuAk/aWbKspZ1JgS0BY+uWL
         fRyDasraYkB41KcSJzYqbUOelp+6Cy+AJBSESxXHXaGkwbPrItTI5qFocV7Ei//iJoSB
         H4vWPxjTGT8zqZxW12hX8mvBbs/i5xkZqbpPKC1+tgZ5E2K6aNYQgP7rctSeWq5btcpe
         Y4Pai9zz5BSTmLcjAnWeQnd5s6gDMLC747ibgRNmyheyVwi08y0WDhK5hWZYUVdC5967
         dCUA==
X-Gm-Message-State: AOJu0YyjyJNScZ699k+r/RIBja9N6tbgCSdhDdzbJIc7PJQjZ6K/3plh
	0ypqLH/VH35X9vkE28xCCJlv07cHZuO8f4rYe9YAitS+H9Qfnr6Wx1B0U2ua
X-Google-Smtp-Source: AGHT+IF4J9WWZgyd06n+HqtabmvehtxjbPm0YbyaEeW/qCg7LD5KtYGVdu2uNd71/CUgegCCGzTjRg==
X-Received: by 2002:a17:903:1ca:b0:20c:8907:902 with SMTP id d9443c01a7336-20e5a923d33mr143199475ad.49.1729517707838;
        Mon, 21 Oct 2024 06:35:07 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f6d05sm25624125ad.275.2024.10.21.06.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:35:07 -0700 (PDT)
Date: Mon, 21 Oct 2024 21:35:10 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 8/9] ref: check whether the target of the symref is a ref
Message-ID: <ZxZYjq64HLhuk_Pf@ArchLinux>
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
 t/t0602-reffiles-fsck.sh      | 28 ++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

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
index 1a267547f2..b4912af3b5 100644
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
index f475966d7b..c6d40ce9a1 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -392,6 +392,34 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
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
+	printf "ref: HEAD\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs/foo\n" >$branch_dir_prefix/branch-good &&
+	git refs verify 2>err &&
+	rm $branch_dir_prefix/branch-good &&
+	test_must_be_empty err &&
+
+	printf "ref: refs-back/heads/main\n" >$branch_dir_prefix/branch-bad-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''refs-back/heads/main'\''
+	EOF
+	rm $branch_dir_prefix/branch-bad-1 &&
+	test_cmp expect err
+'
+
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.47.0

