Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAF5183088
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731603246; cv=none; b=dZu0sfbNVaLb1hgznAN9Iux10LmcYXMSL0Nc5q6e3iXikdbcvXgNiPCQsMc0skUAv9USxueGHN5EeCjuqJKjQbz9uaWfgHWxIU00sX1yKuLn0I3jZaPZYjesiu+j1iWs3jwgYFrula9+2gPTtVtkgbRGrhSZmmWURZidR6qyTCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731603246; c=relaxed/simple;
	bh=4iAJA46zpl/v6qmBKcIfVl8MSuXSf8PZ1daMDFkHi9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gH00RNHAa/l2h/yhGoXZsQKgG51AXqK8b4Ug6lFZ9LH9HeUvQ5ua28l59nRfmbddwfkPx9DKeSSsGB2YQOOQurj11ctgzTlLiTJ43m8MeXMBbd1XZ2E8VIee5zzWBE+ETy2286I+1/M3pxis5/TLQLoXlV0A9g6bh+sUsFuNe/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyOLXA+B; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyOLXA+B"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-723db2798caso798987b3a.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 08:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731603242; x=1732208042; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=MyOLXA+BPk/DGbiH6hkmz3WvQy+DtaKBaod36nwPcZCwzuPNht18NZDzvy2I43vDv3
         wPYPOaqpax6znxPjmHkqKKrtB54Icku8S+XOjmwGGPWFJn247wx1NODJy4cEWYi7ma0N
         zwuU6/qRcOaE1U6rtr4B3aSu30zaIrQgXTvz5H6PVnh7VsPqsKzG51Gy4f8+Ce+uRc7P
         Eikh5Fh4EsoFM6PaspAxkZIPy0Ygzz+oUKppqxbMH2uUMU+mB/fgKdzDOI41K+2BrjSR
         qlrbyB3jdWAbkbciMxBAz+GWtqf5ISL4boBHL/SPzppzNJU9PXKe549DhkV+804q888F
         ZA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731603242; x=1732208042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ML4KPi4wQjf1qC2Qte9G4jPx11iLAGGFB8tIl6WAl74=;
        b=eANHOBwWjIOP2WgB06yj+7xZU0sNAbdvkAXacmp54Pe9PgwMTmq+RZdhz3yvr3upUA
         x6eBLNESTWzVGGRSZXNaydLNOWZC/Qz2uXi7VoQoV+5axXIMb2CvEYVkUp1Z6L4PiCxp
         teHGSOgjvLGZPzKtQe1TXfMWxxH39I3GJNNvVKoTdlsVp0gMBg7MoR2nzV80RxlPTbBT
         wgmmX9WGzH7PgmWWkt7MsSLMXkXPUZRaUbINrgx88lC5hSBYHu+4zGByzbQ+d5UcfoR3
         zCxSQYrJhf82dkmlE+R8DLignzDcqi/uc8oKjjufiZTwjIWGFAqZv+okd8zo9LXuBfPi
         jMFA==
X-Gm-Message-State: AOJu0YwWvcv+80wyDkRYYGNzJbpt/m94HIJSYmagoVUnxI7aUXLzOCi2
	vy3WPc90P4etVnsWKmPZ008hIJ6QPU+dzGQg5npG6xSEWOZ/he/sxrUsdA==
X-Google-Smtp-Source: AGHT+IG2pHMyzriRYKF6KOQXfwVjjbZvU5v22bCRl0gSZ9OQfUgPCUsR+ZsuPhXI49i3Ypg7JY1pUg==
X-Received: by 2002:a05:6a00:99c:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-7244a5423f2mr12954884b3a.12.1731603242162;
        Thu, 14 Nov 2024 08:54:02 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a5cfa1bsm1484140b3a.8.2024.11.14.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:54:01 -0800 (PST)
Date: Fri, 15 Nov 2024 00:54:04 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v8 2/9] ref: check the full refname instead of basename
Message-ID: <ZzYrLDkcm3tgeCDe@ArchLinux>
References: <ZzYqoai8X_Wdtbmt@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzYqoai8X_Wdtbmt@ArchLinux>

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

