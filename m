Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CAE1FE45E
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821411; cv=none; b=a5FV2Dk31d9DoEVZdpmhTpHt/jMn381CcocSinXFHtyx9rPUAOeoJdVezN8wOQpqHNuNoJ8yNm8ZgBNV/7rgtx00rVON94AIYTL/x6LgKgWOZv2DBoS9m6gJAI5tQ5vakKbjhlXx1B5+vloVaRhmSsEzN6ZaJAKJZahwJBS2Ges=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821411; c=relaxed/simple;
	bh=NiSz0kFXgj2oW62wBNpIa05qAzJdZQp1gZun8gTT0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/UBsWrSpjplsLZHFYgIud87XoYkcvpmsaL2zDt2OeG8AF070CXtVtQoahkSVCsOgKWvlOFliQwcY8o/RUs7YkdyO9Ql887cRbJ6DxFmfjpLr+mLZ6kTsSDzIWsXrIMqnpa7LOWEYT6whOmH6y0/hVCHZmh9lyQanrBphR4RrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFJ6kzHs; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFJ6kzHs"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddab8800bso8050505ad.3
        for <git@vger.kernel.org>; Wed, 05 Feb 2025 21:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738821407; x=1739426207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tZWI8TgIs25Erf+1G0IhxEBg80nHgq+9lTGFbSIIC1w=;
        b=VFJ6kzHsFn9w9ZhzKr5Y8HnuYndn9B/K1rYk+8kqtWgOleh0GZLOIvRBD0101AcLoM
         Vq01eHtcO5MfB7HdzZE/Ey5rbUAPONdB92EDgygVHz/eLHjD9Nu7gYJAGVoUi6jLfD1W
         XJkaiR203Uq4jL2cQZxGWQH7W+UqNOJp8NE9B1JbZLF8he1Bkc2R0foZo2fa0CUU/P/v
         2gABp++FDJxjXlnpDuY+WYuyxY5gORDShlLIhetKwkefv03XM4QK6GM4FHu4QrrG+8iT
         GgJxkAY+2eOuYxDKKLrQwVhafbrnAg+MKY0Hsv3W4HYJwTjV3+nNiU8aJIvQSnWEAoZ/
         oc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738821407; x=1739426207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZWI8TgIs25Erf+1G0IhxEBg80nHgq+9lTGFbSIIC1w=;
        b=Cuvx/JmqrUfjIOQAgpFUokCfocSVbiX8ZrDIdjJR116HL6bOuq5UJw/bNcenuVJeS1
         9KBgUBSq2zHV2QLp0soyEJOZsy+uEAiThCNQQD+GaT0POdbZJG3tAbn7ucuBXotvCbAU
         AEjSimuQC9IYijxcFxFCF0EHBNFJEs4msvKpEqfww9rNs6X6tyPje8WncwhrAHUVdlPE
         7x0dNtSidNnFK5rRRSHQAhxc50oLLH0/TB1zR58QsiNPEQ9JMvDJQrp/T2aeudMkWDA+
         ohUSymoNtlASrPinq8qSrb5dZnv9ZQsUdEPV8u/QrO1kCrCaGYHVvdRO990E+MmlZ484
         n5oA==
X-Gm-Message-State: AOJu0YwsSqV25/P+qjBo/FGLv4NHVkOkYM5JiWC2gFfbMW5aNGHA7uID
	ZajZx5bBbdvEK61Ki81lWbEz+y07Bm6kbjIq0wzPYZQnqowZ2RHGid+Q+g==
X-Gm-Gg: ASbGncuZiOIg3cQlguftGmYQOqBSzJbVaE5D3ZKCIif2oqs0PEAScdvkU1JmQKgBRys
	Uk1yma8ixGyYIMP+lk+q6hmGfCx8Q6iceVlQabYLrtGD+7anW9qNaC9mtHFj7hiZRoXDy2rB71q
	413sQueYYv2RVn55FB884KBSl+46jyIebQwITiEPdIdc7XqT9NalM/fa0jihcFHQbWhRb+vUKRF
	Ykv0nOjVumppbTEUgRokLRIfGoaYEheAuuLeqv5FFHVSmGmVwSxvwae9KpLzMU66jxm3A==
X-Google-Smtp-Source: AGHT+IE6Bu+T1HCTGq9RULcqtAmZ4RU60D1yR96xC0EafZzXD6xGnLnq8ix+GR1T7qp0Rbsw1VpKvw==
X-Received: by 2002:a17:902:e74a:b0:216:4e8d:4803 with SMTP id d9443c01a7336-21f17edcab8mr80582385ad.42.1738821406896;
        Wed, 05 Feb 2025 21:56:46 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368797c8sm3921135ad.159.2025.02.05.21.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 21:56:46 -0800 (PST)
Date: Thu, 6 Feb 2025 13:58:27 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/8] t0602: use subshell to ensure working directory
 unchanged
Message-ID: <Z6RPg9i_nhPiSvAx@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RPJI10-2QkwyqH@ArchLinux>

For every test, we would execute the command "cd repo" in the first but
we never execute the command "cd .." to restore the working directory.
However, it's either not a good idea use above way. Because if any test
fails between "cd repo" and "cd ..", the "cd .." will never be reached.
And we cannot correctly restore the working directory.

Let's use subshell to ensure that the current working directory could be
restored to the correct path.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 t/t0602-reffiles-fsck.sh | 967 ++++++++++++++++++++-------------------
 1 file changed, 494 insertions(+), 473 deletions(-)

diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index d4a08b823b..cf7a202d0d 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -14,222 +14,229 @@ test_expect_success 'ref name should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-
-	git commit --allow-empty -m initial &&
-	git checkout -b default-branch &&
-	git tag default-tag &&
-	git tag multi_hierarchy/default-tag &&
-
-	cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
-	git refs verify 2>err &&
-	test_must_be_empty err &&
-	rm $branch_dir_prefix/@ &&
-
-	cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
-	git refs verify 2>err &&
-	rm $tag_dir_prefix/tag-1.lock &&
-	test_must_be_empty err &&
-
-	cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/tags/.lock: badRefName: invalid refname format
-	EOF
-	rm $tag_dir_prefix/.lock &&
-	test_cmp expect err &&
-
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/$refname: badRefName: invalid refname format
-		EOF
-		rm "$branch_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done &&
+	(
+		cd repo &&
 
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/tags/$refname: badRefName: invalid refname format
-		EOF
-		rm "$tag_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done &&
+		git commit --allow-empty -m initial &&
+		git checkout -b default-branch &&
+		git tag default-tag &&
+		git tag multi_hierarchy/default-tag &&
 
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
-		EOF
-		rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
-		test_cmp expect err || return 1
-	done &&
-
-	for refname in ".refname-starts-with-dot" "~refname-has-stride"
-	do
-		mkdir "$branch_dir_prefix/$refname" &&
-		cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+		cp $branch_dir_prefix/default-branch $branch_dir_prefix/@ &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
+		rm $branch_dir_prefix/@ &&
+
+		cp $tag_dir_prefix/default-tag $tag_dir_prefix/tag-1.lock &&
+		git refs verify 2>err &&
+		rm $tag_dir_prefix/tag-1.lock &&
+		test_must_be_empty err &&
+
+		cp $tag_dir_prefix/default-tag $tag_dir_prefix/.lock &&
 		test_must_fail git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+		error: refs/tags/.lock: badRefName: invalid refname format
 		EOF
-		rm -r "$branch_dir_prefix/$refname" &&
-		test_cmp expect err || return 1
-	done
+		rm $tag_dir_prefix/.lock &&
+		test_cmp expect err &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/$refname: badRefName: invalid refname format
+			EOF
+			rm "$branch_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $tag_dir_prefix/default-tag "$tag_dir_prefix/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/tags/$refname: badRefName: invalid refname format
+			EOF
+			rm "$tag_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			cp $tag_dir_prefix/multi_hierarchy/default-tag "$tag_dir_prefix/multi_hierarchy/$refname" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/tags/multi_hierarchy/$refname: badRefName: invalid refname format
+			EOF
+			rm "$tag_dir_prefix/multi_hierarchy/$refname" &&
+			test_cmp expect err || return 1
+		done &&
+
+		for refname in ".refname-starts-with-dot" "~refname-has-stride"
+		do
+			mkdir "$branch_dir_prefix/$refname" &&
+			cp $branch_dir_prefix/default-branch "$branch_dir_prefix/$refname/default-branch" &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/$refname/default-branch: badRefName: invalid refname format
+			EOF
+			rm -r "$branch_dir_prefix/$refname" &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success 'ref name check should be adapted into fsck messages' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	git commit --allow-empty -m initial &&
-	git checkout -b branch-1 &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	git -c fsck.badRefName=warn refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/.branch-1: badRefName: invalid refname format
-	EOF
-	rm $branch_dir_prefix/.branch-1 &&
-	test_cmp expect err &&
-
-	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
-	git -c fsck.badRefName=ignore refs verify 2>err &&
-	test_must_be_empty err
+	(
+		cd repo &&
+		git commit --allow-empty -m initial &&
+		git checkout -b branch-1 &&
+
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=warn refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/.branch-1: badRefName: invalid refname format
+		EOF
+		rm $branch_dir_prefix/.branch-1 &&
+		test_cmp expect err &&
+
+		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
+		git -c fsck.badRefName=ignore refs verify 2>err &&
+		test_must_be_empty err
+	)
 '
 
 test_expect_success 'ref name check should work for multiple worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-
-	cd repo &&
-	test_commit initial &&
-	git checkout -b branch-1 &&
-	test_commit second &&
-	git checkout -b branch-2 &&
-	test_commit third &&
-	git checkout -b branch-3 &&
-	git worktree add ./worktree-1 branch-1 &&
-	git worktree add ./worktree-2 branch-2 &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
-	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-3
-	) &&
 	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-3
-	) &&
-
-	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
-	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
-	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err &&
-
-	for worktree in "worktree-1" "worktree-2"
-	do
+		cd repo &&
+		test_commit initial &&
+		git checkout -b branch-1 &&
+		test_commit second &&
+		git checkout -b branch-2 &&
+		test_commit third &&
+		git checkout -b branch-3 &&
+		git worktree add ./worktree-1 branch-1 &&
+		git worktree add ./worktree-2 branch-2 &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
 		(
-			cd $worktree &&
-			test_must_fail git refs verify 2>err &&
-			cat >expect <<-EOF &&
-			error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
-			error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
-			EOF
-			sort err >sorted_err &&
-			test_cmp expect sorted_err || return 1
-		)
-	done
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-3
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-3
+		) &&
+
+		cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
+		cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err &&
+
+		for worktree in "worktree-1" "worktree-2"
+		do
+			(
+				cd $worktree &&
+				test_must_fail git refs verify 2>err &&
+				cat >expect <<-EOF &&
+				error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
+				error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
+				EOF
+				sort err >sorted_err &&
+				test_cmp expect sorted_err || return 1
+			)
+		done
+	)
 '
 
 test_expect_success 'regular ref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
 
-	git refs verify 2>err &&
-	test_must_be_empty err &&
+		git refs verify 2>err &&
+		test_must_be_empty err &&
 
-	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/branch-bad: badRefContent: $bad_content
-		EOF
-		rm $branch_dir_prefix/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
+		for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$branch_dir_prefix/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/branch-bad: badRefContent: $bad_content
+			EOF
+			rm $branch_dir_prefix/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
 
-	for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
-		test_must_fail git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
-		EOF
-		rm $branch_dir_prefix/a/b/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $branch_dir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	for trailing_content in " garbage" "    more garbage"
-	do
-		printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+		for bad_content in "$(git rev-parse main)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$branch_dir_prefix/a/b/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/a/b/branch-bad: badRefContent: $bad_content
+			EOF
+			rm $branch_dir_prefix/a/b/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
+
+		printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
 		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
 		EOF
-		rm $branch_dir_prefix/branch-garbage &&
-		test_cmp expect err || return 1
-	done &&
+		rm $branch_dir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+		for trailing_content in " garbage" "    more garbage"
+		do
+			printf "%s" "$(git rev-parse main)$trailing_content" >$branch_dir_prefix/branch-garbage &&
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\''$trailing_content'\''
+			EOF
+			rm $branch_dir_prefix/branch-garbage &&
+			test_cmp expect err || return 1
+		done &&
 
+		printf "%s\n\n\n" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
 
-	'\''
-	EOF
-	rm $branch_dir_prefix/branch-garbage-special &&
-	test_cmp expect err &&
 
-	printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
+		'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage-special &&
+		test_cmp expect err &&
+
+		printf "%s\n\n\n  garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage-special &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-garbage-special: trailingRefContent: has trailing garbage: '\''
 
 
-	  garbage'\''
-	EOF
-	rm $branch_dir_prefix/branch-garbage-special &&
-	test_cmp expect err
+		  garbage'\''
+		EOF
+		rm $branch_dir_prefix/branch-garbage-special &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success 'regular ref content should be checked (aggregate)' '
@@ -237,99 +244,103 @@ test_expect_success 'regular ref content should be checked (aggregate)' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	bad_content_1=$(git rev-parse main)x &&
-	bad_content_2=xfsazqfxcadas &&
-	bad_content_3=Xfsazqfxcadas &&
-	printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
-	printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
-	printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
-	printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
-	printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
-	error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
-	error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
-	warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		bad_content_1=$(git rev-parse main)x &&
+		bad_content_2=xfsazqfxcadas &&
+		bad_content_3=Xfsazqfxcadas &&
+		printf "%s" $bad_content_1 >$tag_dir_prefix/tag-bad-1 &&
+		printf "%s" $bad_content_2 >$tag_dir_prefix/tag-bad-2 &&
+		printf "%s" $bad_content_3 >$branch_dir_prefix/a/b/branch-bad &&
+		printf "%s" "$(git rev-parse main)" >$branch_dir_prefix/branch-no-newline &&
+		printf "%s garbage" "$(git rev-parse main)" >$branch_dir_prefix/branch-garbage &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/a/b/branch-bad: badRefContent: $bad_content_3
+		error: refs/tags/tag-bad-1: badRefContent: $bad_content_1
+		error: refs/tags/tag-bad-2: badRefContent: $bad_content_2
+		warning: refs/heads/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
 '
 
 test_expect_success 'textual symref content should be checked (individual)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		for good_referent in "refs/heads/branch" "HEAD"
+		do
+			printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+			git refs verify 2>err &&
+			rm $branch_dir_prefix/branch-good &&
+			test_must_be_empty err || return 1
+		done &&
+
+		for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
+		do
+			printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
+			EOF
+			rm $branch_dir_prefix/branch-bad &&
+			test_cmp expect err || return 1
+		done &&
 
-	for good_referent in "refs/heads/branch" "HEAD"
-	do
-		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+		printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
 		git refs verify 2>err &&
-		rm $branch_dir_prefix/branch-good &&
-		test_must_be_empty err || return 1
-	done &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
+		EOF
+		rm $branch_dir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	for bad_referent in "refs/heads/.branch" "refs/heads/~branch" "refs/heads/?branch"
-	do
-		printf "ref: %s\n" $bad_referent >$branch_dir_prefix/branch-bad &&
-		test_must_fail git refs verify 2>err &&
+		printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-trailing-1 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: refs/heads/branch-bad: badReferentName: points to invalid refname '\''$bad_referent'\''
+		warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
 		EOF
-		rm $branch_dir_prefix/branch-bad &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $branch_dir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-1 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-2 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-trailing-3 &&
-	test_cmp expect err &&
-
-	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
-	EOF
-	rm $branch_dir_prefix/a/b/branch-complicated &&
-	test_cmp expect err
+		rm $branch_dir_prefix/a/b/branch-trailing-2 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-trailing-3 &&
+		test_cmp expect err &&
+
+		printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+		EOF
+		rm $branch_dir_prefix/a/b/branch-complicated &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success 'textual symref content should be checked (aggregate)' '
@@ -337,32 +348,34 @@ test_expect_success 'textual symref content should be checked (aggregate)' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
-	printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
-	printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
-	printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
-	printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
-	printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
-	printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
-	printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
-
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
-	warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
-	warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
-	warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
-	EOF
-	sort err >sorted_err &&
-	test_cmp expect sorted_err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		printf "ref: refs/heads/branch\n" >$branch_dir_prefix/branch-good &&
+		printf "ref: HEAD\n" >$branch_dir_prefix/branch-head &&
+		printf "ref: refs/heads/branch" >$branch_dir_prefix/branch-no-newline-1 &&
+		printf "ref: refs/heads/branch     " >$branch_dir_prefix/a/b/branch-trailing-1 &&
+		printf "ref: refs/heads/branch\n\n" >$branch_dir_prefix/a/b/branch-trailing-2 &&
+		printf "ref: refs/heads/branch \n" >$branch_dir_prefix/a/b/branch-trailing-3 &&
+		printf "ref: refs/heads/branch \n  " >$branch_dir_prefix/a/b/branch-complicated &&
+		printf "ref: refs/heads/.branch\n" >$branch_dir_prefix/branch-bad-1 &&
+
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: refs/heads/branch-bad-1: badReferentName: points to invalid refname '\''refs/heads/.branch'\''
+		warning: refs/heads/a/b/branch-complicated: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-complicated: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-1: refMissingNewline: misses LF at the end
+		warning: refs/heads/a/b/branch-trailing-1: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-2: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/a/b/branch-trailing-3: trailingRefContent: has trailing whitespaces or newlines
+		warning: refs/heads/branch-no-newline-1: refMissingNewline: misses LF at the end
+		EOF
+		sort err >sorted_err &&
+		test_cmp expect sorted_err
+	)
 '
 
 test_expect_success 'the target of the textual symref should be checked' '
@@ -370,28 +383,30 @@ test_expect_success 'the target of the textual symref should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
-	do
-		printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
-		git refs verify 2>err &&
-		rm $branch_dir_prefix/branch-good &&
-		test_must_be_empty err || return 1
-	done &&
-
-	for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
-	do
-		printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
-		git refs verify 2>err &&
-		cat >expect <<-EOF &&
-		warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
-		EOF
-		rm $branch_dir_prefix/branch-bad-1 &&
-		test_cmp expect err || return 1
-	done
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		for good_referent in "refs/heads/branch" "HEAD" "refs/tags/tag"
+		do
+			printf "ref: %s\n" $good_referent >$branch_dir_prefix/branch-good &&
+			git refs verify 2>err &&
+			rm $branch_dir_prefix/branch-good &&
+			test_must_be_empty err || return 1
+		done &&
+
+		for nonref_referent in "refs-back/heads/branch" "refs-back/tags/tag" "reflogs/refs/heads/branch"
+		do
+			printf "ref: %s\n" $nonref_referent >$branch_dir_prefix/branch-bad-1 &&
+			git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: refs/heads/branch-bad-1: symrefTargetIsNotARef: points to non-ref target '\''$nonref_referent'\''
+			EOF
+			rm $branch_dir_prefix/branch-bad-1 &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success SYMLINKS 'symlink symref content should be checked' '
@@ -399,201 +414,207 @@ test_expect_success SYMLINKS 'symlink symref content should be checked' '
 	git init repo &&
 	branch_dir_prefix=.git/refs/heads &&
 	tag_dir_prefix=.git/refs/tags &&
-	cd repo &&
-	test_commit default &&
-	mkdir -p "$branch_dir_prefix/a/b" &&
-
-	ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
-	warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
-	EOF
-	rm $branch_dir_prefix/branch-symbolic &&
-	test_cmp expect err &&
-
-	ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
-	error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
-	EOF
-	rm $branch_dir_prefix/branch-symbolic-bad &&
-	test_cmp expect err &&
-
-	ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
-	test_must_fail git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
-	error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
-	EOF
-	rm $tag_dir_prefix/tag-symbolic-1 &&
-	test_cmp expect err
+	(
+		cd repo &&
+		test_commit default &&
+		mkdir -p "$branch_dir_prefix/a/b" &&
+
+		ln -sf ./main $branch_dir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
+		EOF
+		rm $branch_dir_prefix/branch-symbolic-good &&
+		test_cmp expect err &&
+
+		ln -sf ../../logs/branch-escape $branch_dir_prefix/branch-symbolic &&
+		git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+		warning: refs/heads/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
+		EOF
+		rm $branch_dir_prefix/branch-symbolic &&
+		test_cmp expect err &&
+
+		ln -sf ./"branch   " $branch_dir_prefix/branch-symbolic-bad &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/heads/branch-symbolic-bad: symlinkRef: use deprecated symbolic link for symref
+		error: refs/heads/branch-symbolic-bad: badReferentName: points to invalid refname '\''refs/heads/branch   '\''
+		EOF
+		rm $branch_dir_prefix/branch-symbolic-bad &&
+		test_cmp expect err &&
+
+		ln -sf ./".tag" $tag_dir_prefix/tag-symbolic-1 &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		warning: refs/tags/tag-symbolic-1: symlinkRef: use deprecated symbolic link for symref
+		error: refs/tags/tag-symbolic-1: badReferentName: points to invalid refname '\''refs/tags/.tag'\''
+		EOF
+		rm $tag_dir_prefix/tag-symbolic-1 &&
+		test_cmp expect err
+	)
 '
 
 test_expect_success SYMLINKS 'symlink symref content should be checked (worktree)' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	cd repo &&
-	test_commit default &&
-	git branch branch-1 &&
-	git branch branch-2 &&
-	git branch branch-3 &&
-	git worktree add ./worktree-1 branch-2 &&
-	git worktree add ./worktree-2 branch-3 &&
-	main_worktree_refdir_prefix=.git/refs/heads &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
 	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-
-	ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $worktree1_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $worktree2_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
-	EOF
-	rm $main_worktree_refdir_prefix/branch-symbolic-good &&
-	test_cmp expect err &&
-
-	ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
-	warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
-	EOF
-	rm $worktree1_refdir_prefix/branch-symbolic &&
-	test_cmp expect err &&
-
-	for bad_referent_name in ".tag" "branch   "
-	do
-		ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git worktree add ./worktree-1 branch-2 &&
+		git worktree add ./worktree-2 branch-3 &&
+		main_worktree_refdir_prefix=.git/refs/heads &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
+
+		(
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+
+		ln -sf ../../../../refs/heads/good-branch $worktree1_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree1_refdir_prefix/bad-symbolic &&
+		rm $worktree1_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../../../worktrees/worktree-1/good-branch $worktree2_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		warning: worktrees/worktree-2/refs/worktree/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree1_refdir_prefix/bad-symbolic &&
+		rm $worktree2_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../worktrees/worktree-2/good-branch $main_worktree_refdir_prefix/branch-symbolic-good &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+		warning: refs/heads/branch-symbolic-good: symlinkRef: use deprecated symbolic link for symref
 		EOF
-		rm $worktree2_refdir_prefix/bad-symbolic &&
+		rm $main_worktree_refdir_prefix/branch-symbolic-good &&
 		test_cmp expect err &&
 
-		ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
-		test_must_fail git refs verify 2>err &&
+		ln -sf ../../../../logs/branch-escape $worktree1_refdir_prefix/branch-symbolic &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
-		error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symlinkRef: use deprecated symbolic link for symref
+		warning: worktrees/worktree-1/refs/worktree/branch-symbolic: symrefTargetIsNotARef: points to non-ref target '\''logs/branch-escape'\''
 		EOF
-		rm $worktree2_refdir_prefix/bad-symbolic &&
-		test_cmp expect err || return 1
-	done
+		rm $worktree1_refdir_prefix/branch-symbolic &&
+		test_cmp expect err &&
+
+		for bad_referent_name in ".tag" "branch   "
+		do
+			ln -sf ./"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-1/refs/worktree/$bad_referent_name'\''
+			EOF
+			rm $worktree1_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree1_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-1/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-1/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+			EOF
+			rm $worktree1_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ./"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''worktrees/worktree-2/refs/worktree/$bad_referent_name'\''
+			EOF
+			rm $worktree2_refdir_prefix/bad-symbolic &&
+			test_cmp expect err &&
+
+			ln -sf ../../../../refs/heads/"$bad_referent_name" $worktree2_refdir_prefix/bad-symbolic &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			warning: worktrees/worktree-2/refs/worktree/bad-symbolic: symlinkRef: use deprecated symbolic link for symref
+			error: worktrees/worktree-2/refs/worktree/bad-symbolic: badReferentName: points to invalid refname '\''refs/heads/$bad_referent_name'\''
+			EOF
+			rm $worktree2_refdir_prefix/bad-symbolic &&
+			test_cmp expect err || return 1
+		done
+	)
 '
 
 test_expect_success 'ref content checks should work with worktrees' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	cd repo &&
-	test_commit default &&
-	git branch branch-1 &&
-	git branch branch-2 &&
-	git branch branch-3 &&
-	git worktree add ./worktree-1 branch-2 &&
-	git worktree add ./worktree-2 branch-3 &&
-	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
-	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
-
 	(
-		cd worktree-1 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
-	(
-		cd worktree-2 &&
-		git update-ref refs/worktree/branch-4 refs/heads/branch-1
-	) &&
+		cd repo &&
+		test_commit default &&
+		git branch branch-1 &&
+		git branch branch-2 &&
+		git branch branch-3 &&
+		git worktree add ./worktree-1 branch-2 &&
+		git worktree add ./worktree-2 branch-3 &&
+		worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
+		worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
 
-	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
-		test_must_fail git refs verify 2>err &&
+		(
+			cd worktree-1 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+		(
+			cd worktree-2 &&
+			git update-ref refs/worktree/branch-4 refs/heads/branch-1
+		) &&
+
+		for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$worktree1_refdir_prefix/bad-branch-1 &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
+			EOF
+			rm $worktree1_refdir_prefix/bad-branch-1 &&
+			test_cmp expect err || return 1
+		done &&
+
+		for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
+		do
+			printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
+			test_must_fail git refs verify 2>err &&
+			cat >expect <<-EOF &&
+			error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
+			EOF
+			rm $worktree2_refdir_prefix/bad-branch-2 &&
+			test_cmp expect err || return 1
+		done &&
+
+		printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: worktrees/worktree-1/refs/worktree/bad-branch-1: badRefContent: $bad_content
+		warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
 		EOF
-		rm $worktree1_refdir_prefix/bad-branch-1 &&
-		test_cmp expect err || return 1
-	done &&
+		rm $worktree1_refdir_prefix/branch-no-newline &&
+		test_cmp expect err &&
 
-	for bad_content in "$(git rev-parse HEAD)x" "xfsazqfxcadas" "Xfsazqfxcadas"
-	do
-		printf "%s" $bad_content >$worktree2_refdir_prefix/bad-branch-2 &&
-		test_must_fail git refs verify 2>err &&
+		printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
+		git refs verify 2>err &&
 		cat >expect <<-EOF &&
-		error: worktrees/worktree-2/refs/worktree/bad-branch-2: badRefContent: $bad_content
+		warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
 		EOF
-		rm $worktree2_refdir_prefix/bad-branch-2 &&
-		test_cmp expect err || return 1
-	done &&
-
-	printf "%s" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-no-newline &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-no-newline: refMissingNewline: misses LF at the end
-	EOF
-	rm $worktree1_refdir_prefix/branch-no-newline &&
-	test_cmp expect err &&
-
-	printf "%s garbage" "$(git rev-parse HEAD)" >$worktree1_refdir_prefix/branch-garbage &&
-	git refs verify 2>err &&
-	cat >expect <<-EOF &&
-	warning: worktrees/worktree-1/refs/worktree/branch-garbage: trailingRefContent: has trailing garbage: '\'' garbage'\''
-	EOF
-	rm $worktree1_refdir_prefix/branch-garbage &&
-	test_cmp expect err
+		rm $worktree1_refdir_prefix/branch-garbage &&
+		test_cmp expect err
+	)
 '
 
 test_done
-- 
2.48.1

