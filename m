Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24D1537C6
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731240571; cv=none; b=tGmeBuYaYlM+cHb88cK2LCOuCRwMXQfTftPfNuO2BxeF4w7a9fhSHK/3JA3C96G+EltJAxAO4jPG63sxrdr6m4ZzOrspPOt7bvcoPzbmn0STg0moZpbb1m5ch4btOCS5etx7k4mK2R0LCySuHYdYnRFc23B/6aSz0PH3BJIBhsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731240571; c=relaxed/simple;
	bh=4iAJA46zpl/v6qmBKcIfVl8MSuXSf8PZ1daMDFkHi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xfp3IPXXtTZvoc4y6SkSUFlUg37t9F4bOukVM5DAegQHpEVLwSi0Mhu3pSM+4Sf70eXjnUONJZlbslfYMiZ1mtSJxA/lthZQD5R7In1nf2ylx418MaZeqpeSnxJLi4Z6R7rJivEkpyNu2gMSgOwFuJUo+2Ybkduxso5OTvEH4uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeOhF2mR; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeOhF2mR"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71ec997ad06so2968103b3a.3
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 04:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731240569; x=1731845369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=CeOhF2mR4dMHg8i5GkdX21EMJpLctEqR7lobEmuCP6q+Du3Xg+VD8Zw+zTYeX9Wqsc
         Oa0o7NkUDo9/WLlnS5JuL4+W5h4Xzf3DCkDq+sIosDk17xCTDHSaJyZe1cBUOxLHDGJ1
         bEarKNKYfzV6Kap+IX109kgjiL7oS6I2Wolty3Xthg190mPaa3MaPStd10WKa+ObG2nf
         fJwgovz8BJJNE+HQV8bjtMR4lP662d2rl3NgdVdHp2pFmCwnOlhkqi6Vc1gmJCNCDHD8
         ANQ/g1dc9QppnKCicxXGke1mEkfrxAEGR412boaBAGpC4Kp3JUddIRHg5w/lMYSx2gS1
         RMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731240569; x=1731845369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=OIGJgNUmoAoZLTiXZq6KJn1+eBwX7s2+iwHL716s3JANBmrpcJTjrEtVCZyXCenn52
         kM68iGXVOeAal8LzVyV16IyR5a7Yg6M3SjpxLcPh+dZK2fEzPdhsWNOz+7QJbKad/OHP
         4ek2VLBp9lq4eByuim8DgwMedGNhasrcE8HSJDOJBBSnaUdLEU5zdwpKwSjmQ3me4TGe
         ikugf0wcH+vbZwd7YH9PmOplFDanknK3eV1o+TOF8PjH46MAn71QQ449xpAZ+CO0bdIb
         5wiv9UP/2Te+l/dxn1uij9kVmWbMGBN70CBtHHwjCX0nFcOXSyNJHoIf5OpYRMtiPkXs
         rFkA==
X-Gm-Message-State: AOJu0Yxpltgy5/d4Pe9r9EK3+ErTHZ9aINz+PWKuzNvghFPQVMX+V36j
	zODj6CKc50atXPILS5+mipLr6TvjkF0pUrZ+ehoED0v5fTn/Cj/1e3+FbQN/jX8=
X-Google-Smtp-Source: AGHT+IGphGC7NA2ZZQ2YdOBN413MgZ56iE8TsUJ6YqWPocMB0B3xz9JCft2Rj7E/n8KCJtrPqqb+aQ==
X-Received: by 2002:a05:6a00:139a:b0:71e:6ec9:fcda with SMTP id d2e1a72fcca58-7241337ff37mr11320381b3a.19.1731240568517;
        Sun, 10 Nov 2024 04:09:28 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240799bb25sm7238949b3a.109.2024.11.10.04.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 04:09:28 -0800 (PST)
Date: Sun, 10 Nov 2024 20:09:26 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v7 2/9] ref: check the full refname instead of basename
Message-ID: <ZzCidukownju3fx3@ArchLinux>
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

In "files-backend.c::files_fsck_refs_name", we validate the refname
format by using "check_refname_format" to check the basename of the
iterator with "REFNAME_ALLOW_ONELEVEL" flag.

However, this is a bad implementation. Although we doesn't allow a
single "@" in ".git" directory, we do allow "refs/heads/@". So, we will
report an error wrongly when there is a "refs/heads/@" ref by using one
level refname "@".

Because we just check one level refname, we either cannot check the
other parts of the full refname. And we will ignore the following
errors:

  "refs/heads/ new-feature/test"
  "refs/heads/~new-feature/test"

In order to fix the above problem, enhance "files_fsck_refs_name" to use
the full name for "check_refname_format". Then, replace the tests which
are related to "@" and add tests to exercise the above situations using
for loop to avoid repetition.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 refs/files-backend.c     |  7 ++-
 t/t0602-reffiles-fsck.sh | 92 ++++++++++++++++++++++++----------------
 2 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 03d2503276..b055edc061 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3519,10 +3519,13 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
 		goto cleanup;
 
-	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
+	/*
+	 * This works right now because we never check the root refs.
+	 */
+	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
+	if (check_refname_format(sb.buf, 0)) {
 		struct fsck_ref_report report = { 0 };
 
-		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
 		report.path = sb.buf;
 		ret = fsck_report_ref(o, &report,
 				      FSCK_MSG_BAD_REF_NAME,
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 71a4d1a5ae..2a172c913d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -18,63 +18,81 @@ test_expect_success 'ref name should be checked' '
 	cd repo &&
 
 	git commit --allow-empty -m initial &&
-	git checkout -b branch-1 &&
-	git tag tag-1 &&
-	git commit --allow-empty -m second &&
-	git checkout -b branch-2 &&
-	git tag tag-2 &&
-	git tag multi_hierarchy/tag-2 &&
+	git checkout -b default-branch &&
+	git tag default-tag &&
+	git tag multi_hierarchy/default-tag &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/.branch-1: badRefName: invalid refname format
-	EOF
-	rm $branch_dir_prefix/.branch-1 &&
-	test_cmp expect err &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/@: badRefName: invalid refname format
-	EOF
+	cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
+	git refs verify 2>err &&
+	test_must_be_empty err &&
 	rm $branch_dir_prefix/@ &&
-	test_cmp expect err &&
 
-	cp $tag_dir_prefix/multi_hierarchy/tag-2 $tag_dir_prefix/multi_hierarchy/@ &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/tags/multi_hierarchy/@: badRefName: invalid refname format
-	EOF
-	rm $tag_dir_prefix/multi_hierarchy/@ &&
-	test_cmp expect err &&
-
-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
+	cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
 	git refs verify 2>err &&
 	rm $tag_dir_prefix/tag-1.lock &&
 	test_must_be_empty err &&
 
-	cp $tag_dir_prefix/tag-1 $tag_dir_prefix/.lock &&
+	cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
 	test_must_fail git refs verify 2>err &&
 	cat >expect <<-EOF &&
 	error: refs/tags/.lock: badRefName: invalid refname format
 	EOF
 	rm $tag_dir_prefix/.lock &&
-	test_cmp expect err
+	test_cmp expect err &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/$refname: badRefName: invalid refname format
+		EOF
+		rm "$branch_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/$refname: badRefName: invalid refname format
+		EOF
+		rm "$tag_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
+		EOF
+		rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
+		test_cmp expect err || return 1
+	done &&
+
+	for refname in ".refname-starts-with-dot" "~refname-has-stride"
+	do
+		mkdir "$branch_dir_prefix/$refname" &&
+		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+		EOF
+		rm -r "$branch_dir_prefix/$refname" &&
+		test_cmp expect err || return 1
+	done
 '
 
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	tag_dir_prefix=.git/refs/tags &&
 	cd repo &&
 	git commit --allow-empty -m initial &&
 	git checkout -b branch-1 &&
-	git tag tag-1 &&
-	git commit --allow-empty -m second &&
-	git checkout -b branch-2 &&
-	git tag tag-2 &&
 
 	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	git -c fsck.badRefName=warn refs verify 2>err &&
@@ -84,7 +102,7 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
 	rm $branch_dir_prefix/.branch-1 &&
 	test_cmp expect err &&
 
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
+	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
 	git -c fsck.badRefName=ignore refs verify 2>err &&
 	test_must_be_empty err
 '
-- 
2.47.0

