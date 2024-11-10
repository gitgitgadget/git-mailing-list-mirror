Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E561537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240608; cv=none; b=TeovZtcazcSHdk3YjoWJwocRTf4AaFtwZfT6Q9NPOxiUed2DN1Kjf6PGiKORethVrNdm1ZHkzoB0XFKEMCIXpCBMyR6eadciAKz3hlGbczgRGXl3ZCz7o+L3trzK5TurALeP3xo9o2ehGLFidFjsERvnUDERzu8JPEaQNiZ5ZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240608; c=relaxed/simple;
	bh=afwqolSTzx4hNOmHAZU++IjpKj5i3Ao9MuTohyY3Pwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUmloO5BqeI5PMwgaLtOiaqVV5WIBwdgXWnYagnoii7EItDXURndL4dYeMQ+houUX0+IzCMJwMV64srJfWXYKPxTgxt2M7so8B5eKSqC2rMKF0cN0YRgcMybefi1rrvGQKsNnoZtkHm8hTGtEONDrzGRHwnvHHh1yr+Zt6mJfaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRZc/WqO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRZc/WqO"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-720be27db27so2915557b3a.2
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240606; x=1731845406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oTzlqaK5G282+jHQ0kfI2JnrYlouXKCq9QhUvCXkLE=;
        b=dRZc/WqOzfw/DHMBKLw/cHEcG+86ZHo/6SSFL0vvPi44HyQQ1Rz9WvBinxUjJPaG6D
         sO/RYHkO7jZXp/9mufgEbbBZLeFiXDWy0RFDemAXAhn7mQvoP3r9LN/kWOebdGAQIq0U
         kTWun0M/LidN3xmVZbsypLIgQKpw5vJZncG4qN2c72jl2Kvube3rnSdASWra7aJYRdo5
         0xGwXlMjZb2n0lVcy/YaEBGZEcy6KmDiPci2tMf2RK7AhvswQLHMl+bNkj7pbtjorSFV
         T+9iLEB6pQEOuFkK8fuGgmrsBcWlt/iJh3AhLyh/e+cmqM3F/6wtqjEO6iPNRolZTaPW
         OCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240606; x=1731845406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oTzlqaK5G282+jHQ0kfI2JnrYlouXKCq9QhUvCXkLE=;
        b=DeTSVrORfBN2aUnGZRujP2fOeKeVhtLpLlVVmX+UM5Qjd8Fo+oJ3EPecKaqZEhyTOE
         F4v72O4F2iJg6xOi28X4MSdvFQsgrWkXSqQBcrCWP6uIdTAgXyuufLI+mONk3/2SK/FU
         JpTFm9NG2q/NZPeBOA1EoEasNoMoN4Oz2caqGXvfY+aO2HphSrKz75L9CCerVJLnUdQZ
         yP3+On4l70LsTyZs1iZG6EF037UF/vH79JlAUOJkvWv/BYm/BZVRHSQJnletncqFlqsv
         W1717q+OLdUQeQjyqBsps1CvcxinoEbDGF17bjm/sKMi/22VLDlNA2773YaKxPJuliEZ
         v3XQ==
X-Gm-Message-State: AOJu0Yyu6JhQcxQbeZkqdvrcYmYcUoo/3/WjrfYrE2jLUtt6GFE+iIA0
	exG7Pk1OMQUhug4+lEuE6/mCQGuN8yWcSRkGYGX1Q7njBONjjVHlsE15OcHnmRE=
X-Google-Smtp-Source: AGHT+IH0eJA0bHgaBEhc3rtl1UQWVdwH5QxbvR6Ifl6pXgKypZGlWof4UZ9AEqwIsJRTm3Fgogoq+g==
X-Received: by 2002:a05:6a00:21cc:b0:71e:587d:f268 with SMTP id d2e1a72fcca58-724132788e0mr12515213b3a.4.1731240605860;
        Sun, 10 Nov 2024 04:10:05 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7d75sm7244135b3a.68.2024.11.10.04.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:10:05 -0800 (PST)
Date: Sun, 10 Nov 2024 20:10:03 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 6/9] ref: add more strict checks for regular refs
Message-ID: <ZzCim_sgaFHF3FIM@ArchLinux>
References: <ZzCiCGxL4Adnd_eq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzCiCGxL4Adnd_eq@ArchLinux>

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
may break the repository. So, we add the following two fsck infos to
represent the situation where the ref content ends without newline or
has trailing garbages:

1. refMissingNewline(INFO): A loose ref that does not end with
   newline(LF).
2. trailingRefContent(INFO): A loose ref has trailing content.

It might appear that we can't provide the user with any warnings by
using FSCK_INFO. However, in "fsck.c::fsck_vreport", we will convert
FSCK_INFO to FSCK_WARN and we can still warn the user about these
situations when using "git refs verify" without introducing
compatibility issues.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 Documentation/fsck-msgids.txt | 14 +++++++++
 fsck.h                        |  2 ++
 refs.c                        |  2 +-
 refs/files-backend.c          | 26 ++++++++++++++--
 refs/refs-internal.h          |  2 +-
 t/t0602-reffiles-fsck.sh      | 57 +++++++++++++++++++++++++++++++++--
 6 files changed, 96 insertions(+), 7 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.txt
index 22c385ea22..6db0eaa84a 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -173,6 +173,20 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
 
+`refMissingNewline`::
+	(INFO) A loose ref that does not end with newline(LF). As
+	valid implementations of Git never created such a loose ref
+	file, it may become an error in the future. Report to the
+	git@vger.kernel.org mailing list if you see this error, as
+	we need to know what tools created such a file.
+
+`trailingRefContent`::
+	(INFO) A loose ref has trailing content. As valid implementations
+	of Git never created such a loose ref file, it may become an
+	error in the future. Report to the git@vger.kernel.org mailing
+	list if you see this error, as we need to know what tools
+	created such a file.
+
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
 
diff --git a/fsck.h b/fsck.h
index 0d99a87911..b85072df57 100644
--- a/fsck.h
+++ b/fsck.h
@@ -85,6 +85,8 @@ enum fsck_msg_type {
 	FUNC(MAILMAP_SYMLINK, INFO) \
 	FUNC(BAD_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO) \
+	FUNC(REF_MISSING_NEWLINE, INFO) \
+	FUNC(TRAILING_REF_CONTENT, INFO) \
 	/* ignored (elevated when requested) */ \
 	FUNC(EXTRA_HEADER_ENTRY, IGNORE)
 
diff --git a/refs.c b/refs.c
index 395a17273c..f88b32a633 100644
--- a/refs.c
+++ b/refs.c
@@ -1789,7 +1789,7 @@ static int refs_read_special_head(struct ref_store *ref_store,
 	}
 
 	result = parse_loose_ref_contents(ref_store->repo->hash_algo, content.buf,
-					  oid, referent, type, failure_errno);
+					  oid, referent, type, NULL, failure_errno);
 
 done:
 	strbuf_release(&full_path);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2d126ecbbe..871c8946f8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -569,7 +569,7 @@ static int read_ref_internal(struct ref_store *ref_store, const char *refname,
 	buf = sb_contents.buf;
 
 	ret = parse_loose_ref_contents(ref_store->repo->hash_algo, buf,
-				       oid, referent, type, &myerr);
+				       oid, referent, type, NULL, &myerr);
 
 out:
 	if (ret && !myerr)
@@ -606,7 +606,7 @@ static int files_read_symbolic_ref(struct ref_store *ref_store, const char *refn
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno)
+			     const char **trailing, int *failure_errno)
 {
 	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
@@ -628,6 +628,10 @@ int parse_loose_ref_contents(const struct git_hash_algo *algop,
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
 	struct strbuf ref_content = STRBUF_INIT;
 	struct strbuf referent = STRBUF_INIT;
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
+					      FSCK_MSG_REF_MISSING_NEWLINE,
+					      "misses LF at the end");
+			goto cleanup;
+		}
+		if (*trailing != '\n' || *(trailing + 1)) {
+			ret = fsck_report_ref(o, &report,
+					      FSCK_MSG_TRAILING_REF_CONTENT,
+					      "has trailing garbage: '%s'", trailing);
+			goto cleanup;
+		}
+	}
+
 cleanup:
 	strbuf_release(&ref_content);
 	strbuf_release(&referent);
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 037d7991cd..125f1fe735 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -716,7 +716,7 @@ struct ref_store {
 int parse_loose_ref_contents(const struct git_hash_algo *algop,
 			     const char *buf, struct object_id *oid,
 			     struct strbuf *referent, unsigned int *type,
-			     int *failure_errno);
+			     const char **trailing, int *failure_errno);
 
 /*
  * Fill in the generic part of refs and add it to our collection of
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 162370077b..33e7a390ad 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -189,7 +189,48 @@ test_expect_success 'regular ref content should be checked (individual)' '
 		EOF
 		rm $branch_dir_prefix/a/b/branch-bad &&
 		test_cmp expect err || return 1
-	done
+	done &&
+
+	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $branch_dir_prefix/branch-no-newline &&
+	test_cmp expect err &&
+
+	for trailing_content in " garbage" "    more garbage"
+	do
+		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage &&
+		test_cmp expect err || return 1
+	done &&
+
+	printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+
+
+	'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage-special &&
+	test_cmp expect err &&
+
+	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+
+
+	  garbage'\''
+	EOF
+	rm $branch_dir_prefix/branch-garbage-special &&
+	test_cmp expect err
 '
 
 test_expect_success 'regular ref content should be checked (aggregate)' '
@@ -207,12 +248,16 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
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
+	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 	EOF
 	sort err >sorted_err &&
 	test_cmp expect sorted_err
@@ -260,7 +305,15 @@ test_expect_success 'ref content checks should work with worktrees' '
 		EOF
 		rm $worktree2_refdir_prefix/bad-branch-2 &&
 		test_cmp expect err || return 1
-	done
+	done &&
+
+	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+	git refs verify 2>err &&
+	cat >expect <<-EOF &&
+	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
+	EOF
+	rm $worktree1_refdir_prefix/branch-no-newline &&
+	test_cmp expect err
 '
 
 test_done
-- 
2.47.0

