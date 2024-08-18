Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916192030A
	for <git@vger.kernel.org>; Sun, 18 Aug 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993269; cv=none; b=jlSJ6YzG9UOUQ4x1F6JDH8umo5bc1Mp7fHM6zQU+omoteKxGWXNWXoKnQTvvRFm7QEnLbKsFZ7OyLEK8yVke7911Ng75nWQugz/LQbxdV6NpmHZnPHAjP6udMAyoIFdKe/XmCnj7hfCXwziVn7fBYE0JY6q4LjG0RNybltF4XNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993269; c=relaxed/simple;
	bh=w2TzmjcV4fOxOVN6dZ1JLqPOvrRiMez3zw71tNo+/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kf8QK9SWFZcn+ictSdCxh56+1yKYChiTX12VspBJkBtaKfMeLh1kkd1HT82fEStlB7YZxDPDqT/J9Up7mqaTb5OVD0lqh5wAztn3ATsnfymRM5HPJwULyEqN/oObZTMrnOd/alD6u9eok6D9eW/2MY8upxhIK4cpABVMjyjwT4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgR3jY1Z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgR3jY1Z"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-713eeb4e4bcso336792b3a.0
        for <git@vger.kernel.org>; Sun, 18 Aug 2024 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723993266; x=1724598066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PlMMI+oi7JmHvdTuaebNPWFQG5nQnFZ/4eBxAVL5Pc=;
        b=DgR3jY1Zk2fFvHWpiP+5H3X9n4roY+TjIFu+51OEbLwkakmFChtVZnAB2aJAc+d6Y1
         AfU3jXyck1D9939KaKzntwfvHvqFpDdVpZhtv2b7ni8fsHK9LWQUhifPj7hltLoHTrH2
         FQNBdk7qpETITCyRK6AoFj7SGom3qjoZleeilWP7QDdhwtYUqwFdICieoM8ysBs+TipC
         lURZv9GtdUdhdYkVpm069KXgO7Hw1HWUIr2yXi0Q8n4HTrFkgir2mQDP58XxDNOVCc8u
         KERpB65tzJNJhrE+7Mdx2vu+MJnBn94Qa3EzWtIjshi9ATm2SIzrhDtUZtt3hmTPCuhb
         NvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723993266; x=1724598066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PlMMI+oi7JmHvdTuaebNPWFQG5nQnFZ/4eBxAVL5Pc=;
        b=GK/Vm4oD1/QgqG02IRXfNqBpR20a2QTzLfykichbOcedKIxdfPLJjhIPN90Vx6Ls8W
         rQFkxzu28w07hdzTs8CXrjF2vowE36LrSDGmQOwp7Z9xZUZ+il9tdtLjyJTD1EWLlcc1
         fU/avjR8jimtyVsbHl5I7MTORlrV9badLoEtCE/wGpnLwWuA1CEHuDrTPZ6tJrlJJFtM
         p8R98AB7bRuAr3E9sjyNQpNFq0qTNjjqbyVO+Tewv8LNSCjevpRq+FCK9z8e+PvEIbUt
         oJy2Nh1eqqvhDK+PhBVfJpE4sqjA8ObkGQjtT8vKlnIxr5KARhER9KPbZp9tfoJHJZzq
         tfBQ==
X-Gm-Message-State: AOJu0YwEaZe+23P0x4TNl88adNeK5TgLlnJXYnf5A6FSJ9/lhY+tWorq
	jqrZ5RkH5+uV6+TNjowBvCPVnIOFSske75DDBIpMCciLdEeZRZeTuqoXBQ==
X-Google-Smtp-Source: AGHT+IHffoOzDv0RY32fo8f4ok+S4Azr91Iih+Sjm0aeubnWS3I1mBWnVJls+aMlfIj0qjvwjh/G+g==
X-Received: by 2002:a05:6a20:9f0a:b0:1c8:da09:5311 with SMTP id adf61e73a8af0-1c904f7eb81mr11984975637.4.1723993264698;
        Sun, 18 Aug 2024 08:01:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae06bb7sm5332449b3a.58.2024.08.18.08.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:01:04 -0700 (PDT)
Date: Sun, 18 Aug 2024 23:01:44 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v1 2/4] ref: add regular ref content check for files backend
Message-ID: <ZsIM2DRDbJsvNjAM@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsIMc6cJ-kzMzW_8@ArchLinux>

We implicitly reply on "git-fsck(1)" to check the consistency of regular
refs. However, when parsing the regular refs for files backend, we allow
the ref content to end with no newline or contain some garbages. We
should warn the user about above situations.

In order to provide above functionality, enhance the "git-refs verify"
command by adding consistency check for regular refs for files backend.

Add the following three fsck messages to represent the above situations:

1. "badRefContent(ERROR)": A ref has a bad content.
2. "refMissingNewline(WARN)": A valid ref does not end with newline.
3. "trailingRefContent(WARN)": A ref has trailing contents.

In order to tell whether the ref has trailing content, add a new
parameter "trailing" to "parse_loose_ref_contents". Then introduce a new
function "files_fsck_refs_content" to check the regular refs.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  9 ++++
 fsck.h                        |  3 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 67 ++++++++++++++++++++++++++-
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 87 +++++++++++++++++++++++++++++++++++
 6 files changed, 166 insertions(+), 4 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 68a2801f15..1688c2f1fe 100644
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
 
@@ -170,6 +173,12 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(WARN) A valid ref does not end with newline.
+
+`trailingRefContent`::
+	(WARN) A ref has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 8894394d16..975d9b9da9 100644
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
@@ -73,6 +74,8 @@ enum fsck_msg_type {
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
+	FUNC(REF_MISSING_NEWLINE, WARN) \
+	FUNC(TRAILING_REF_CONTENT, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	FUNC(LARGE_PATHNAME, WARN) \
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
index 725a4f52e3..ae71692f36 100644
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
 
@@ -3430,6 +3434,64 @@ typedef int (*files_fsck_refs_fn)(struct ref_store *ref_store,
 				  const char *refs_check_dir,
 				  struct dir_iterator *iter);
 
+static int files_fsck_refs_content(struct ref_store *ref_store,
+				   struct fsck_options *o,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct fsck_ref_report report = FSCK_REF_REPORT_DEFAULT;
+	struct strbuf ref_content = STRBUF_INIT;
+	struct strbuf referent = STRBUF_INIT;
+	struct strbuf refname = STRBUF_INIT;
+	const char *trailing = NULL;
+	unsigned int type = 0;
+	int failure_errno = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+	report.path = refname.buf;
+
+	if (S_ISREG(iter->st.st_mode)) {
+		if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+			ret = error_errno(_("%s/%s: unable to read the ref"),
+					  refs_check_dir, iter->relative_path);
+			goto cleanup;
+		}
+
+		if (parse_loose_ref_contents(ref_store->repo->hash_algo,
+					    ref_content.buf, &oid, &referent,
+					    &type, &trailing, &failure_errno)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_BAD_REF_CONTENT,
+					      "invalid ref content");
+			goto cleanup;
+		}
+
+		if (!(type & REF_ISSYMREF)) {
+			if (*trailing == '\0') {
+				ret = fsck_report_ref(o, &report,
+						      FSCK_MSG_REF_MISSING_NEWLINE,
+						      "missing newline");
+				goto cleanup;
+			}
+
+			if (*trailing != '\n' || (*(trailing + 1) != '\0')) {
+				ret = fsck_report_ref(o, &report,
+						      FSCK_MSG_TRAILING_REF_CONTENT,
+						      "trailing garbage in ref");
+				goto cleanup;
+			}
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
@@ -3512,6 +3574,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
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
index 71a4d1a5ae..7c1910d784 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -89,4 +89,91 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_must_be_empty err
 '
 
+test_expect_success 'regular ref content should be checked' '
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
+	git checkout -b a/b/tag-2 &&
+
+	printf "%s" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-1-no-newline: refMissingNewline: missing newline
+	EOF
+	rm $branch_dir_prefix/branch-1-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $branch_dir_prefix/branch-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\n\na" "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-2-garbage &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+	test_must_fail git -c fsck.trailingRefContent=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+	EOF
+	rm $tag_dir_prefix/tag-1-garbage &&
+	test_cmp expect err &&
+
+	printf "%sx" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-1-bad: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-1-bad &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-2-bad: badRefContent: invalid ref content
+	EOF
+	rm $tag_dir_prefix/tag-2-bad &&
+	test_cmp expect err &&
+
+	printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+	test_must_fail git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
+	EOF
+	rm $branch_dir_prefix/a/b/branch-2-bad &&
+	test_cmp expect err
+'
+
 test_done
-- 
2.46.0

