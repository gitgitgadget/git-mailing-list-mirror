Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099091C9856
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725365991; cv=none; b=shteQPzPkr8gtmSohaqfSLPjzFX4Xqw/TgZ5s/Oz50UVHS18MTCf2wtdxe03uBX37Bul+LPMUaG5Yn7znZHVZs64DRdRvKY7i4M4eNsVr9jaHlqns9/N+QGNsAL4J8VLiYciDSkHT3R0yhGiDdiLzMJsXBmezL3Qwe4WRog1MpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725365991; c=relaxed/simple;
	bh=mdw9p/I/ToQsj4fmR8irvgLJjJcvftghaTSMUEXLTQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc2Y+I7m86vWBP1KD/674EaLaj5jG5zazFd32039dxQObEM32x83uT9UIVSWd7Xq+PaIIHSyKTsjNEm1d9+qNg2/pzMoJNCvcsiliiFVEjXAIcQTYlRQpiw+cTCnhMzqReJiimlbOXvLQ3lnfysC2WeUY6lpVhLi4rYReCCWrpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNkWTpk6; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNkWTpk6"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-268eec6c7c1so2617574fac.3
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725365988; x=1725970788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QN1FKJ0XYDPZdwIAhDnu5iaqp/bSjb842VzbUVu5FcI=;
        b=WNkWTpk6QwVpToLWxAk0BTYb709FBrmeelQaSiB3aozknxxdEGhZbJmOGeIH93YQIm
         6uHPPXJTIK+02IgfV/cfGFDGiYkrbBNAopmOzlAYam+6dROPeQ5SiX2p3rsPkqiCHEYz
         BHcTx3nyTUSNv5tTaJr4hYcVifS67aa0teTK3LXt1+4OzfqnIBmhd6AIJ18Q0c0iqhg9
         hOUg2NOGvQ2Bk9VmBYTEZWZbPvn+ttrXkKxwHpCesK01kRvpCI9nT6IN4gRjeIpzKuqb
         2iKwW+tAaMDirVw3HQJ7NoPwNg97D9ZHss4y0jj/tx6ypCiV7cIFjDZ5kxz41U4vVI92
         88MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725365988; x=1725970788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN1FKJ0XYDPZdwIAhDnu5iaqp/bSjb842VzbUVu5FcI=;
        b=B28kDK6fkxMsRaPAQZeEBxxvHTpuUBpEooTitE3gdqA2GoE/sF5habnOS0ECt2aEEO
         u5s0sTdgbdyh0XtGCN7gcFHcbPp4voi7vSbzosMwAWcKuhWe88M0Yg/bCbchn7rTD4KJ
         n95yZlpGszo/nXJWsQEkwOcXFDHdxw/A9eyIzNbXCzCs0hMxbI3UxJKkw6i0/vq1rnZ0
         TMXrhcM/m27+7BkwTTXfeREyHKa/8eSz2fvIC4OAPU7jc88HYxCsBtvTNHjfpYieetjR
         Bn5BQAFl6FXavAUuEK/ODwg7RYKbaKV+ittcmFq8wkUZhmhVKEHwXfqESKdflSBhd5GJ
         YEEw==
X-Gm-Message-State: AOJu0YxLIdHAWN/f6vlgIuke5sIkTkvQvDsWDQ9JhmWv6SIrGY5mJsb+
	hSvb5+xJid90ZLQWOjdAZoWYCjRWYejyxL4NhGPSrc8H0cr2P1AyGjSSLg==
X-Google-Smtp-Source: AGHT+IHvcy0/fH3CLWjcBIQadFExMgOgcuGilcJDfjz7e6+rgNlrSJDdvnNOQyW21Na6vJkwb05M0A==
X-Received: by 2002:a05:6871:8ab:b0:270:1f1e:e3ea with SMTP id 586e51a60fabf-2779013e567mr20924663fac.28.1725365988260;
        Tue, 03 Sep 2024 05:19:48 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5956sm8393941b3a.75.2024.09.03.05.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 05:19:47 -0700 (PDT)
Date: Tue, 3 Sep 2024 20:20:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] ref: add regular ref content check for files backend
Message-ID: <Ztb_HqLg-WvwA2I0@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztb-mgl50cwGVO8A@ArchLinux>

We implicitly rely on "git-fsck(1)" to check the consistency of regular
refs. However, when parsing the regular refs for files backend by using
"files-backend.c::parse_loose_ref_contents", we allow the ref content to
end with no newline or to contain some garbages.

Even though we never create such loose refs ourselves, we have accepted
such loose refs. So, it is entirely possible that some third-party tools
may rely on such loose refs being valid. We should not report an error
fsck message at current. But let's notice such a "curiously formatted"
loose refs being valid and tell the user our findings, so we can access
the possible extent of damage when we tighten the parsing rules in the
future.

And it's not suitable to either report a warn fsck message to the user.
This is because if the caller set the "strict" field in "fsck_options",
fsck warns will be automatically upgraded to errors. We should not allow
user to specify the "--strict" flag to upgrade the fsck warnings to
errors at current. It might cause compatibility issue which may break
the legacy repository. So we add the following two fsck infos to
represent the situation where the ref content ends without newline or has
garbages:

1. "refMissingNewline(INFO)": A ref does not end with newline. This kind
   of ref may be considered ERROR in the future.
2. "trailingRefContent(INFO)": A ref has trailing contents. This kind of
   ref may be considered ERROR in the future.

It may seem that we could not give the user any warnings by creating
fsck infos. However, in "fsck.c::fsck_vreport", we will convert
"FSCK_INFO" to "FSCK_WARN" and we can still warn the user about these
situations when using "git-refs verify" without introducing
compatibility issue.

In current "git-fsck(1)", it will report an error when the ref content
is bad, so we should following this to report an error to the user when
"parse_loose_ref_contents" fails. And we add a new fsck error message
called "badRefContent(ERROR)" to represent that a ref has a bad content.

In order to tell whether the ref has trailing content, add a new
parameter "trailing" to "parse_loose_ref_contents". Then introduce a new
function "files_fsck_refs_content" to check the regular refs to enhance
the "git-refs verify".

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  11 ++++
 fsck.h                        |   3 +
 refs.c                        |   2 +-
 refs/files-backend.c          |  68 ++++++++++++++++++-
 refs/refs-internal.h          |   2 +-
 t/t0602-reffiles-fsck.sh      | 120 ++++++++++++++++++++++++++++++++++
 6 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 68a2801f15..06d045ac48 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,6 +19,9 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has a bad content.
+
 `badRefFiletype`::
 	(ERROR) A ref has a bad file type.
 
@@ -170,6 +173,14 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A ref does not end with newline. This kind of ref may
+	be considered ERROR in the future.
+
+`trailingRefContent`::
+	(INFO) A ref has trailing contents. This kind of ref may be
+	considered ERROR in the future.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 500b4c04d2..b85072df57 100644
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
@@ -84,6 +85,8 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 74de3d3009..5e74881945 100644
--- a/refs.c
+++ b/refs.c
@@ -1758,7 +1758,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(ref_store->repo->hash_algo, content.buf,
-					  oid, referent, type, failure_errno);
+					  oid, referent, type, NULL, failure_errno);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 890d0324e1..0187b85c5f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -560,7 +560,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	buf = sb_contents.buf;
 
 	ret = parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
-				       oid, referent, type, &myerr);
+				       oid, referent, type, NULL, &myerr);
 
 out:
 	if (ret && !myerr)
@@ -597,7 +597,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     const char **trailing, int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -619,6 +619,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3430,6 +3434,65 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
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
+	const char *trailing = NULL;
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
+		ret = error_errno(_("%s/%s: unable to read the ref"),
+				  refs_check_dir, iter->relative_path);
+		goto cleanup;
+	}
+
+	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+				     ref_content.buf, &oid, &referent,
+				     &type, &trailing, &failure_errno)) {
+		ret = fsck_report_ref(o, &report,
+				      FSCK_MSG_BAD_REF_CONTENT,
+				      "invalid ref content");
+		goto cleanup;
+	}
+
+	if (!(type & REF_ISSYMREF)) {
+		if (*trailing == '\0') {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "missing newline");
+			goto cleanup;
+		}
+
+		if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "trailing garbage in ref");
+			goto cleanup;
+		}
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
@@ -3512,6 +3575,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 {
 	files_fsck_refs_fn fsck_refs_fn[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL,
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 2313c830d8..73b05f971b 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -715,7 +715,7 @@ struct ref_store {
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     const char **trailing, int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..a06ad044f2 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -89,4 +89,124 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
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
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/branch-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-1 &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-2 &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-3 &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-garbage-4 &&
+	test_cmp expect err &&
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
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	printf "%s    garbage\n\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
+	printf "%sx" "$(git rev-parse main)" >$tag_dir_prefix/tag-bad-1 &&
+	printf "xfsazqfxcadas" >$tag_dir_prefix/tag-bad-2 &&
+	printf "xfsazqfxcadas" >$branch_dir_prefix/a/b/branch-bad &&
+
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-bad: badRefContent: invalid ref content
+	error: refs/tags/tag-bad-1: badRefContent: invalid ref content
+	error: refs/tags/tag-bad-2: badRefContent: invalid ref content
+	warning: refs/heads/branch-garbage: trailingRefContent: trailing garbage in ref
+	warning: refs/heads/branch-no-newline: refMissingNewline: missing newline
+	warning: refs/tags/tag-garbage-1: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-2: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-3: trailingRefContent: trailing garbage in ref
+	warning: refs/tags/tag-garbage-4: trailingRefContent: trailing garbage in ref
+	EOF
+	sort err >sorted_err &&
+	test_cmp expect sorted_err
+'
+
 test_done
-- 
2.46.0

