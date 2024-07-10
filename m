Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD35383A2
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622928; cv=none; b=gDPclznK+37MLjhonRo6bcraj6AcB08V9TF4ByVKbcKSVP02xtfipGPog8cDuKSObNED/ghd84pxnm+lylEJYDxqCZPrXa5aUCLPSqu/z3l8CgIvjdM/GIN+zhUcgdKGlQhb3UVov5s8FMsmxds9ok3+yP9dojpKEYikoBU9f7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622928; c=relaxed/simple;
	bh=LOhHKh5KsBmtmG6sq8A+GG0E9vQ/hniBFGxe7Mwr2o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bipf43frO8qU/BwNerlJhaPdFAoMr7PA1f1MholjV3/+MxLzbVMRqR+bJ9ANMrBZjGSMNCbrBOpG0yqF1ycOwrNkPDReifFund87slEB35OOQ7yvs7xOCJUWkxXlvisYeXjbH+zcGDW9E/jUV1AtuWkFKuvvijBfI10xVwTN7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWCKHZUP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWCKHZUP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso4679540b3a.3
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 07:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622926; x=1721227726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmL75pP3+XA1E/GtvW5n6sjvKajVD4syRRBMdTpDpCI=;
        b=hWCKHZUPauUfDB+9ejFkLeqvqgzaLW+Pm+muvQb2i03EJk6uDswKj+HJ5oDbd8uS67
         nX3giQnErYjnIKAR8/frfL2dY/XO4fOL//8h+dJ2Oxf2PTJ0gwochWHm/DmsP7ySeqW4
         A1k879BMlAc+1RoVXjRsttIunDWZ/vDrPXN9rCWtIpTQwAuib+7K6zSMIgqqAbfPq8HH
         EPEiu3c25YaB8pgJHZIHRbKO1t/CwKc5IQWA2V1xKFAKhOsiG/hjREOFR8zIVObIv90t
         p4hCDtdflxiNxNV4Vx7SxfVvpni/vslufgwALkg5k9/Axyzoha/4JsLoFSR8+ya9Aojl
         I8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622926; x=1721227726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmL75pP3+XA1E/GtvW5n6sjvKajVD4syRRBMdTpDpCI=;
        b=KRylB2FfQz+9ppY46urfBtnTGC70BIQ+aTBWAyuK2w84+Smck0MR5hGGszT7xW08Zj
         xULa1sanKqLwI3YwkJzlzihpCA0RIxZKbuqShn3WBzHmq71dg3PttL8RleFiwpMR6qUj
         p3jrIUSp3uBjqERqCxUDID25PKZ1PDkFkny0xuUpW23/M9TWwkMqh7KvnQUj7BFseHca
         wdf5NpInlBBRtflt2utPye7qIYkke6guFkYAr+e/UE7EAr/BVL4Kyi4a4DPTp4BrjCov
         1TcsZ61qwMZjrmeEImrdDg4EhAjM31cULGycNFaU0cLqwTdawOj5ASt6kdE+hfG6GTsJ
         B01Q==
X-Gm-Message-State: AOJu0YxL/3TxM7ZB0u6jVjPQMTnjU+Em5RpYm2MYdhFkVDXAmimJbTae
	LG1DWYc6CIVNro24FrcqE2wSHW+bjY5x9X/PeUFoFKB6jVoL6eMgddulhQ==
X-Google-Smtp-Source: AGHT+IGoJdSvRSVk0hOitmCQM2/HHeOQo+Fre3BvuiAwQaHuGyt99spqWe36jUxbzc3y/lhvcfDtqQ==
X-Received: by 2002:a05:6a20:244e:b0:1c2:8d59:d14c with SMTP id adf61e73a8af0-1c29820c62bmr6455068637.21.1720622925328;
        Wed, 10 Jul 2024 07:48:45 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2b2b0sm34679805ad.84.2024.07.10.07.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:48:44 -0700 (PDT)
Date: Wed, 10 Jul 2024 22:48:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v10 10/10] fsck: add ref content check for files backend
Message-ID: <Zo6fTrrcAyagcg_W@ArchLinux>
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

Enhance the git-fsck(1) command by adding a check for reference content
in the files backend. The new functionality ensures that symrefs, real
symbolic link and regular refs are validated correctly.

In order to check the trailing content of the regular refs, add a new
parameter `trailing` to `parse_loose_ref_contents`.

For symrefs, `parse_loose_ref_contents` will set the "referent".
However, symbolic link could be either absolute or relative. Use
"strbuf_add_real_path" to read the symbolic link and convert the
relative path to absolute path. Then use "skip_prefix" to make it align
with symref "referent".

Thus, the symrefs and symbolic links could share the same interface. Add
a new function "files_fsck_symref_target" which aims at checking the
following things:

1. whether the pointee is under the `refs/` directory.
2. whether the pointee name is correct.
3. whether the pointee path is a wrong type in filesystem.

Last, add the following FSCK MESSAGEs:

1. "badRefContent(ERROR)": A ref has a bad content
2. "badSymrefPointee(ERROR)": The pointee of a symref is bad.
3. "trailingRefContent(WARN)": A ref content has trailing contents.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |   9 +++
 fsck.h                        |   3 +
 refs.c                        |   2 +-
 refs/files-backend.c          | 145 +++++++++++++++++++++++++++++++++-
 refs/refs-internal.h          |   5 +-
 t/t0602-reffiles-fsck.sh      | 110 ++++++++++++++++++++++++++
 6 files changed, 269 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index dab4012246..b1630a478b 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -19,9 +19,15 @@
 `badParentSha1`::
 	(ERROR) A commit object has a bad parent sha1.
 
+`badRefContent`::
+	(ERROR) A ref has a bad content.
+
 `badRefName`::
 	(ERROR) A ref has a bad name.
 
+`badSymrefPointee`::
+	(ERROR) The pointee of a symref is bad.
+
 `badTagName`::
 	(INFO) A tag has an invalid format.
 
@@ -167,6 +173,9 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`trailingRefContent`::
+	(WARN) A ref content has trailing contents.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 5fcb249735..3ad2cc86c9 100644
--- a/fsck.h
+++ b/fsck.h
@@ -32,6 +32,8 @@ enum fsck_msg_type {
 	FUNC(BAD_OBJECT_SHA1, ERROR) \
 	FUNC(BAD_PARENT_SHA1, ERROR) \
 	FUNC(BAD_REF_NAME, ERROR) \
+	FUNC(BAD_REF_CONTENT, ERROR) \
+	FUNC(BAD_SYMREF_POINTEE, ERROR) \
 	FUNC(BAD_TIMEZONE, ERROR) \
 	FUNC(BAD_TREE, ERROR) \
 	FUNC(BAD_TREE_SHA1, ERROR) \
@@ -72,6 +74,7 @@ enum fsck_msg_type {
 	FUNC(HAS_DOTDOT, WARN) \
 	FUNC(HAS_DOTGIT, WARN) \
 	FUNC(NULL_SHA1, WARN) \
+	FUNC(TRAILING_REF_CONTENT, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
 	FUNC(LARGE_PATHNAME, WARN) \
diff --git a/refs.c b/refs.c
index 410919246b..eb82fb7d4e 100644
--- a/refs.c
+++ b/refs.c
@@ -1760,7 +1760,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(content.buf, oid, referent, type,
-					  failure_errno);
+					  failure_errno, NULL);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 69a76048d3..d98ef45403 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "../git-compat-util.h"
+#include "../abspath.h"
 #include "../copy.h"
 #include "../environment.h"
 #include "../gettext.h"
@@ -553,7 +554,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
 
-	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr);
+	ret = parse_loose_ref_contents(buf, oid, referent, type, &myerr, NULL);
 
 out:
 	if (ret && !myerr)
@@ -589,7 +590,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     int *failure_errno, const char **trailing)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -611,6 +612,10 @@ int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3438,6 +3443,141 @@ static int files_fsck_refs_name(struct fsck_options *o,
 	return ret;
 }
 
+/*
+ * Check the symref "pointee_name" and "pointee_path". The caller should
+ * make sure that "pointee_path" is absolute. For symbolic ref, "pointee_name"
+ * would be the content after "refs:". For symblic link, "pointee_name" would
+ * be the relative path agaignst "gitdir".
+ */
+static int files_fsck_symref_target(struct fsck_options *o,
+				    const char *refname,
+				    const char *pointee_name,
+				    const char *pointee_path)
+{
+	const char *p = NULL;
+	struct stat st;
+	int ret = 0;
+
+	if (!skip_prefix(pointee_name, "refs/", &p)) {
+
+		ret = fsck_refs_report(o, NULL, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to target out of refs hierarchy");
+		goto out;
+	}
+
+	if (check_refname_format(pointee_name, 0)) {
+		ret = fsck_refs_report(o, NULL, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid refname");
+	}
+
+	if (lstat(pointee_path, &st) < 0)
+		goto out;
+
+	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
+		ret = fsck_refs_report(o, NULL, refname,
+				       FSCK_MSG_BAD_SYMREF_POINTEE,
+				       "point to invalid target");
+		goto out;
+	}
+out:
+	return ret;
+}
+
+static int files_fsck_refs_content(struct fsck_options *o,
+				   const char *gitdir,
+				   const char *refs_check_dir,
+				   struct dir_iterator *iter)
+{
+	struct strbuf pointee_path = STRBUF_INIT,
+		      ref_content = STRBUF_INIT,
+		      abs_gitdir = STRBUF_INIT,
+		      referent = STRBUF_INIT,
+		      refname = STRBUF_INIT;
+	const char *trailing = NULL;
+	int failure_errno = 0;
+	unsigned int type = 0;
+	struct object_id oid;
+	int ret = 0;
+
+	strbuf_addf(&refname, "%s/%s", refs_check_dir, iter->relative_path);
+
+	/*
+	 * If the file is a symlink, we need to only check the connectivity
+	 * of the destination object.
+	 */
+	if (S_ISLNK(iter->st.st_mode)) {
+		const char *pointee_name = NULL;
+
+		strbuf_add_real_path(&pointee_path, iter->path.buf);
+
+		strbuf_add_absolute_path(&abs_gitdir, gitdir);
+		strbuf_normalize_path(&abs_gitdir);
+		if (!is_dir_sep(abs_gitdir.buf[abs_gitdir.len - 1]))
+			strbuf_addch(&abs_gitdir, '/');
+
+		if (!skip_prefix(pointee_path.buf,
+				 abs_gitdir.buf, &pointee_name)) {
+			ret = fsck_refs_report(o, NULL, refname.buf,
+					       FSCK_MSG_BAD_SYMREF_POINTEE,
+					       "point to target outside gitdir");
+			goto clean;
+		}
+
+		ret = files_fsck_symref_target(o, refname.buf, pointee_name,
+					       pointee_path.buf);
+		goto clean;
+	}
+
+	if (strbuf_read_file(&ref_content, iter->path.buf, 0) < 0) {
+		ret = error_errno(_("%s/%s: unable to read the ref"),
+				  refs_check_dir, iter->relative_path);
+		goto clean;
+	}
+
+	if (parse_loose_ref_contents(ref_content.buf, &oid,
+				     &referent, &type,
+				     &failure_errno, &trailing)) {
+		ret = fsck_refs_report(o, NULL, refname.buf,
+				       FSCK_MSG_BAD_REF_CONTENT,
+				       "invalid ref content");
+		goto clean;
+	}
+
+	/*
+	 * If the ref is a symref, we need to check the destination name and
+	 * connectivity.
+	 */
+	if (referent.len && (type & REF_ISSYMREF)) {
+		strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
+		strbuf_rtrim(&referent);
+
+		ret = files_fsck_symref_target(o, refname.buf, referent.buf,
+					       pointee_path.buf);
+		goto clean;
+	} else {
+		/*
+		 * Only regular refs could have a trailing garbage. Should
+		 * be reported as a warning.
+		 */
+		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
+			ret = fsck_refs_report(o, NULL, refname.buf,
+					       FSCK_MSG_TRAILING_REF_CONTENT,
+					       "trailing garbage in ref");
+			goto clean;
+		}
+	}
+
+clean:
+	strbuf_release(&abs_gitdir);
+	strbuf_release(&pointee_path);
+	strbuf_release(&refname);
+	strbuf_release(&ref_content);
+	strbuf_release(&referent);
+	return ret;
+}
+
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
 			       const char *refs_check_dir,
@@ -3490,6 +3630,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 	int ret;
 	files_fsck_refs_fn fsck_refs_fns[]= {
 		files_fsck_refs_name,
+		files_fsck_refs_content,
 		NULL
 	};
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index a905e187cd..2fabf41d14 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -709,11 +709,12 @@ struct ref_store {
 
 /*
  * Parse contents of a loose ref file. *failure_errno maybe be set to EINVAL for
- * invalid contents.
+ * invalid contents. Also *trailing is set to the first character after the
+ * refname or NULL if the referent is not empty.
  */
 int parse_loose_ref_contents(const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     int *failure_errno, const char **trailing);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index b2db58d2c6..35bf40ee64 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -98,4 +98,114 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	)
 '
 
+test_expect_success 'regular ref content should be checked' '
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
+		git checkout -b a/b/tag-2
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse branch-1)" > $branch_dir_prefix/branch-1-garbage &&
+		git fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-1-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $branch_dir_prefix/branch-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s garbage" "$(git rev-parse tag-1)" > $tag_dir_prefix/tag-1-garbage &&
+		test_must_fail git -c fsck.trailingRefContent=error fsck 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-1-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $tag_dir_prefix/tag-1-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "%s    " "$(git rev-parse tag-2)" > $tag_dir_prefix/tag-2-garbage &&
+		git fsck 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/tags/tag-2-garbage: trailingRefContent: trailing garbage in ref
+		EOF
+		rm $tag_dir_prefix/tag-2-garbage &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "xfsazqfxcadas" > $tag_dir_prefix/tag-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/tag-2-bad: badRefContent: invalid ref content
+		EOF
+		rm $tag_dir_prefix/tag-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "xfsazqfxcadas" > $branch_dir_prefix/a/b/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-2-bad: badRefContent: invalid ref content
+		EOF
+		rm $branch_dir_prefix/a/b/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'symbolic ref content should be checked' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	branch_dir_prefix=.git/refs/heads &&
+	tag_dir_prefix=.git/refs/tags &&
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+		git tag tag-1
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads/.branch" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid refname
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: refs/heads" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to invalid target
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	) &&
+	(
+		cd repo &&
+		printf "ref: logs/maint-v2.45" > $branch_dir_prefix/branch-2-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-2-bad: badSymrefPointee: point to target out of refs hierarchy
+		EOF
+		rm $branch_dir_prefix/branch-2-bad &&
+		test_cmp expect err
+	)
+'
+
 test_done
-- 
2.45.2

