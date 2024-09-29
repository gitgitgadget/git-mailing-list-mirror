Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033A541A80
	for <git@vger.kernel.org>; Sun, 29 Sep 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727594164; cv=none; b=pimkXoE03nc3h37z9mMtmPnhQUnIEj+wQon1nimIZmEI8bl3vAzvllz4P8Qj3c0q5F43evTHYRji02RT5XTfrH+v+bWxY8ayfvf4EySpl6oKtpb4h9H5ALftEgMr8MjHDLjAX9EITgaNen69JOFyn122FT9fF1bIPrspJDczq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727594164; c=relaxed/simple;
	bh=pko4bPXNmFe+yLYPQMZREJoBps7+UMT5xQtXIyfFfXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEB+wo0EIj58d0mlI58J4YCxWp7FV0O4b/CMORH+R/4syoknBPmSwLUWKq77PNJiKiSrkIeSZ+eNxZr7PPV7ArH0Rb5e5SO403iOhUW+BxYfwGVf7qk+p15H0YApP5OaHBIrchP9xj8UIpmp7/oIPAzqKMlT7+LxjiHXqfli6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRMTANyN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRMTANyN"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so1470790b3a.3
        for <git@vger.kernel.org>; Sun, 29 Sep 2024 00:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727594161; x=1728198961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wJNgxMD8w83MEp8FDGh673OZgYRvyJABz0VkV6JNJ0s=;
        b=jRMTANyN31m6VSaRqMmU61hwajjoShDiKBkxCjB3P8/cJNoU5i9/NPGDUnszYgfcME
         AZ2AjK0rstic0OYfuJ/0+dYlaghMKeXSifSpggKZo6JlFWoODNPL9BrWy8Q6bkSXYioR
         c2qZxcuG0PbzkRG73RY9ealKoaYxPF4Jk0CiEnAodxefbbvIXX/ir2Q+brEvbekHg+li
         L06VuAd9AcEKJ9v0Hma8JJPtFpGSJVH3V/AiYd6Vq/ALuYJzRx2xR1f99gStSO1l3yaP
         twNVA/AHn9jPNXzTthC5ZBBi29LCCJFRqtiM7y4gbHyjWhXhloAuYw5hG8qVtipE6c9y
         v2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727594161; x=1728198961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJNgxMD8w83MEp8FDGh673OZgYRvyJABz0VkV6JNJ0s=;
        b=aIe5rL4KLNQW3BBkvlVQhr3SADcupqsx1+MmHoIyshu+Ev4wsn7RXcx0DCKXny/EP3
         U+dTvHPyK1Dp0FausELVlzwB3v26KUDAvt3uC0siRCileBGP5JkVksrC87FprQt84Cz+
         tWG7RVucZ2udNDSSJ5diB4Crfe3iWTkb0bRs2HmUwfCfLJM4UG2GJDIgGC0qE4yy7N9b
         zudbcO3eTUBH+by262dOQ3OjIDdnERyr+J2R8OLxtrnI5Pjew4sgqF1D2DpcJOrsRYLW
         iL5DPHSuW+PP8rdA26HGGwhwKWSjJUgoDWjk9p6jApVy8WnA3WmOt2vsLu+iv6jFLb27
         zTIg==
X-Gm-Message-State: AOJu0YwcEiLzMEjTR+J7nFdI5yN0YW/sBMvSqdtc8i9/4j39Wfhsp//Z
	oOedUvqY29DiRhqaG6rTO7IHO0phaIS72ZFhjox84VrCEUJuBGjSYIr3PQ==
X-Google-Smtp-Source: AGHT+IG1bey+ohM8oU0S1bn7ld5xDH7JuuWN6up85ljn46YfiyXTLn8qpa6UiHMwzm0zmTUC76HEKQ==
X-Received: by 2002:a05:6a20:d80d:b0:1cf:3245:5227 with SMTP id adf61e73a8af0-1d4fa80fd44mr12061813637.46.1727594161284;
        Sun, 29 Sep 2024 00:16:01 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b264b7dd6sm4156970b3a.46.2024.09.29.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 00:16:00 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:16:00 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 4/9] ref: add more strict checks for regular refs
Message-ID: <Zvj-sBX-0AFsuFDC@ArchLinux>
References: <Zvj-DgHqtC30KjJe@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zvj-DgHqtC30KjJe@ArchLinux>

We have already used "parse_loose_ref_contents" function to check
whether the ref content is valid in files backend. However, by
using "parse_loose_ref_contents", we allow the ref's content to end with
garbage or without a newline.

Even though we never create such loose refs ourselves, we have accepted
such loose refs. So, it is entirely possible that some third-party tools
may rely on such loose refs being valid. We should not report an error
fsck message at current. We should notify the users about such
"curiously formatted" loose refs so that adequate care is taken before
we decide to tighten the rules in the future.

And it's not suitable either to report a warn fsck message to the user.
We don't yet want the "--strict" flag that controls this bit to end up
generating errors for such weirdly-formatted reference contents, as we
first want to assess whether this retroactive tightening will cause
issues for any tools out there. It may cause compatibility issues which
may break the repository. So we add the "unofficialFormattedRef(INFO)"
fsck message to represent the situation where the ref format is not
officially created by us and notify the users it may become an error in
the future.

It might appear that we can't provide the user with any warnings by
using FSCK_INFO. However, in "fsck.c::fsck_vreport", we will convert
FSCK_INFO to FSCK_WARN and we can still warn the user about these
situations when using "git refs verify" without introducing
compatibility issues.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt |  8 +++++
 fsck.h                        |  1 +
 refs.c                        |  2 +-
 refs/files-backend.c          | 26 +++++++++++++--
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 59 +++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 22c385ea22..e310b5bce9 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -179,6 +179,14 @@
 `unknownType`::
 	(ERROR) Found an unknown object type.
 
+`unofficialFormattedRef`::
+	(INFO) The content of a loose ref file is not in the official
+	format such as not having a LF at the end or having trailing
+	garbage. As valid implementations of Git never created such a
+	loose ref file, it may become an error in the future. Report
+	to the git@vger.kernel.org mailing list if you see this error,
+	as we need to know what tools created such a file.
+
 `unterminatedHeader`::
 	(FATAL) Missing end-of-line in the object header.
 
diff --git a/fsck.h b/fsck.h
index 0d99a87911..7420add5c0 100644
--- a/fsck.h
+++ b/fsck.h
@@ -85,6 +85,7 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(UNOFFICIAL_FORMATTED_REF, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 5f729ed412..6ba1bb1aa1 100644
--- a/refs.c
+++ b/refs.c
@@ -1788,7 +1788,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(ref_store->repo->hash_algo, content.buf,
-					  oid, referent, type, failure_errno);
+					  oid, referent, type, NULL, failure_errno);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 35b3fa983e..b2a790c884 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -568,7 +568,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	buf = sb_contents.buf;
 
 	ret = parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
-				       oid, referent, type, &myerr);
+				       oid, referent, type, NULL, &myerr);
 
 out:
 	if (ret && !myerr)
@@ -605,7 +605,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     const char **trailing, int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -627,6 +627,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
 		*failure_errno = EINVAL;
 		return -1;
 	}
+
+	if (trailing)
+		*trailing = p;
+
 	return 0;
 }
 
@@ -3513,6 +3517,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 	struct strbuf referent = STRBUF_INIT;
 	struct strbuf refname = STRBUF_INIT;
 	struct fsck_ref_report report = { 0 };
+	const char *trailing = NULL;
 	unsigned int type = 0;
 	int failure_errno = 0;
 	struct object_id oid;
@@ -3533,7 +3538,7 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 
 	if (parse_loose_ref_contents(ref_store->repo->hash_algo,
 				     ref_content.buf, &oid, &referent,
-				     &type, &failure_errno)) {
+				     &type, &trailing, &failure_errno)) {
 		strbuf_rtrim(&ref_content);
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_CONTENT,
@@ -3541,6 +3546,21 @@ static int files_fsck_refs_content(struct ref_store *ref_store,
 		goto cleanup;
 	}
 
+	if (!(type & REF_ISSYMREF)) {
+		if (!*trailing) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+					      "misses LF at the end");
+			goto cleanup;
+		}
+		if (*trailing != '\n' || *(trailing + 1)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_UNOFFICIAL_FORMATTED_REF,
+					      "has trailing garbage: '%s'", trailing);
+			goto cleanup;
+		}
+	}
+
 cleanup:
 	strbuf_release(&refname);
 	strbuf_release(&ref_content);
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
index 628f9bcc46..2f5c4a1926 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -185,6 +185,61 @@ test_expect_success 'regular ref content should be checked (individual)' '
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
 	EOF
 	rm $branch_dir_prefix/a/b/branch-bad &&
+	test_cmp expect err &&
+
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: unofficialFormattedRef: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-1 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-1: unofficialFormattedRef: has trailing garbage: '\''
+
+
+	'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-1 &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-2 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-2: unofficialFormattedRef: has trailing garbage: '\''
+
+
+	  garbage'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-2 &&
+	test_cmp expect err &&
+
+	printf "%s    garbage\na" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-3 &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/tags/tag-garbage-3: unofficialFormattedRef: has trailing garbage: '\''    garbage
+	a'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-3 &&
+	test_cmp expect err &&
+
+	printf "%s garbage" "$(git rev-parse main)" >$tag_dir_prefix/tag-garbage-4 &&
+	test_must_fail git -c fsck.unofficialFormattedRef=error refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/tags/tag-garbage-4: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	EOF
+	rm $tag_dir_prefix/tag-garbage-4 &&
 	test_cmp expect err
 '
 
@@ -203,12 +258,16 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
 	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
 	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
 
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
 	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
 	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+	warning: refs/heads/branch-garbage: unofficialFormattedRef: has trailing garbage: '\'' garbage'\''
+	warning: refs/heads/branch-no-newline: unofficialFormattedRef: misses LF at the end
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
-- 
2.46.2

