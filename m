Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1962257AF8
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772520; cv=none; b=uK8HLADf5Aaf8HtL65OTmgJ0X2VLSqtuyFoq/35RmYwllrIyFlMR2ILUV5ITuxVuRoJQwCFkvn1IWxsUHahNEAxbtbAI1QwSG+BBClQRieKPCZrnZlyXYFdBHYTMjnHZprq2fhQcrIVbv9whSUtGQpjHx3fx38QE/xuJbfob+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772520; c=relaxed/simple;
	bh=Z60OfPM9em5e8Ij2reOQeZedqFU+OWyuhnRk/vYfJDg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sU4S2LiZw9cWmwkEX2mVTyexr0rY+LrZlbIZOgnKsmmpxU2vijuk79PToaw9+O1GgZjvYvhilHw5U4HACu296DhxADiNs0CKBO+tU3qGxsH9F9kJGH+OrpXVvX2QKDymqs1hFXm71M25p/PndFBmECMqmDJ9pGunzCWvWLjvOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAd0Wo2H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAd0Wo2H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d3f72391so48042635e9.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772516; x=1754377316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTq4/KMaMX+XFLvZIcbb012jl178PexolS5j8q5Yh64=;
        b=WAd0Wo2HCu/DxLRmZhBmRxWkzBKChTF/EmaCOCCXxZAeDxyrVzTzIR7iS7gy2L8jgM
         ywS4o8lN6wF6uFUo0vZTFGlgW5nZs8BycuIgz7XcoOtxg9lP+9NRKE8kwVlvzHKftDWG
         1qlrUVjCpAj3dm401R4L5nLauV30qxg/1JpEj7Nb9GEURTo6L3ofb5KVbjG+bLJVpmD7
         SbKFXXMBjj6wLYe1SfNbbUAQSPtckCjEzWbNiFZXJl4cDm63eTK19kpZ3nElQBnFfYYF
         ig0GxqpVPHEYgFew04ZZhm11Y337mvSK+TUVknl6obpLioXDoHVKA2uOaknPRjq8W5L0
         Sj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772516; x=1754377316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTq4/KMaMX+XFLvZIcbb012jl178PexolS5j8q5Yh64=;
        b=wtjizM9dVU5vy71sK+ISnjhrm1wLxKwvhw/S5a9GzytH2zKN5RN+6tuj86oQMcbtei
         W3IMAjoZSi7lypWWBBIMHNClnH7KSh3VDHIdy+7eAGT/h3Or6BUgwORYrb1ODep9L2oP
         WQr70yH0C0W7gyLdaxGwsQOeJJRbFyVcrsPdNBQlhOkdJogaHlO+WjZ8TbsMLiaRaOxz
         biFWxQ9912BKliN4eTksvsmpeh3Y42jfaO0C6DAm72EksNe8R0usy2OHSNQQYlb80XB4
         CeNqeIJWWmcWE//IcIaoJakhwq8C7kHFmplDUHIuO76WfALt4Uz5LyTPEAfrF3V5kyi9
         4fzw==
X-Gm-Message-State: AOJu0YwqjET8hO3hPLYynFpgojQ56Vser9/SPFlM08dZgEGWtcu/C4qb
	fu3GJjdUlglva6D/t+3EasbsGvRFfHnrBvZXP5dd9c5uyuRIrfR67cCEAS5M3A==
X-Gm-Gg: ASbGnctCAGPt7PAtilGhCH9L0PqVe+SOCf4m+a4Z/Siq37fvJo90u2PMLGkF7MK8QUj
	2JWMYqC5ot10w0kauNPPmpvd2FAksiEKXNArb3frdjkUtETo9MHQboiYUOEUf8z5pq4ZQcF3N3s
	c7rJqmuMAaYm2RhRE2XN+DTQL/DdbUFA5wp51Bnq+xV/elbH28fp2OKGqjg6jDt/nJ86XvCrb2v
	Q1efL3YVx74aEZ+0im7tHG8yyl7cwRA03Jl/feqbe3+NxYkTsynJv+clLCWYCymE1PE0GdWmGKp
	r9C8uLEROi4K/Cij+VvRWZ2wsoaHYq1iJMIc8zi70piCkKBoszki+QYnCernmemGeGVzmnspxOM
	gdLft/AKn9pN8hieJ6YoUqOD8qAX39aUFpA==
X-Google-Smtp-Source: AGHT+IGtx387f0p+KHBxMYEPrcsjdA1dt0pTtx4vmvtvvA/AYrbEjjT00BGiAyZktsbOHkGnn2PsXA==
X-Received: by 2002:a05:600c:4f81:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4587643e9b0mr132092265e9.16.1753772514190;
        Tue, 29 Jul 2025 00:01:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5e4aeasm11869035e9.29.2025.07.29.00.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:01:53 -0700 (PDT)
Message-Id: <bbb2bc7082baaa11fd428efb375c5d142f82e7fd.1753772511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
	<pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Jul 2025 07:01:48 +0000
Subject: [PATCH v5 1/4] t: use test_grep in t3701 and t4055
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

As a preparatory clean-up, use the "test_grep" test utility instead of
regular "grep" which provides better debug information if tests fail.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 t/t3701-add-interactive.sh | 48 +++++++++++++++++++-------------------
 t/t4055-diff-context.sh    | 28 +++++++++++-----------
 2 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index b8a05d95f3f1..b088ee141ff4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -63,7 +63,7 @@ test_expect_success 'setup (initial)' '
 '
 test_expect_success 'status works (initial)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'setup expected' '
@@ -86,7 +86,7 @@ test_expect_success 'revert works (initial)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git ls-files >output &&
-	! grep . output
+	test_grep ! . output
 '
 
 test_expect_success 'add untracked (multiple)' '
@@ -109,7 +109,7 @@ test_expect_success 'setup (commit)' '
 '
 test_expect_success 'status works (commit)' '
 	git add -i </dev/null >output &&
-	grep "+1/-0 *+2/-0 file" output
+	test_grep "+1/-0 *+2/-0 file" output
 '
 
 test_expect_success 'update can stage deletions' '
@@ -141,7 +141,7 @@ test_expect_success 'revert works (commit)' '
 	git add file &&
 	test_write_lines r 1 | git add -i &&
 	git add -i </dev/null >output &&
-	grep "unchanged *+3/-0 file" output
+	test_grep "unchanged *+3/-0 file" output
 '
 
 test_expect_success 'reject multi-key input' '
@@ -185,7 +185,7 @@ test_expect_success 'setup fake editor' '
 test_expect_success 'bad edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -198,7 +198,7 @@ test_expect_success 'setup patch' '
 test_expect_success 'garbage edit rejected' '
 	git reset &&
 	test_write_lines e n d | git add -p >output &&
-	grep "hunk does not apply" output
+	test_grep "hunk does not apply" output
 '
 
 test_expect_success 'setup patch' '
@@ -313,8 +313,8 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
 	git diff --cached file >out &&
-	grep "new mode" out &&
-	grep "+content" out &&
+	test_grep "new mode" out &&
+	test_grep "+content" out &&
 	git diff file >out &&
 	test_must_be_empty out
 '
@@ -636,7 +636,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	printf "%s\n" s e     q n q q |
 	EDITOR=: git add -p &&
 	git diff >actual &&
-	! grep "^+15" actual
+	test_grep ! "^+15" actual
 '
 
 test_expect_success 'split hunk "add -p (no, yes, edit)"' '
@@ -648,7 +648,7 @@ test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	EDITOR=: git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff >actual &&
-	! grep "^+31" actual
+	test_grep ! "^+31" actual
 '
 
 test_expect_success 'split hunk with incomplete line at end' '
@@ -682,7 +682,7 @@ test_expect_success 'edit, adding lines to the first hunk' '
 	EDITOR=./fake_editor.sh git add -p 2>error &&
 	test_must_be_empty error &&
 	git diff --cached >actual &&
-	grep "^+22" actual
+	test_grep "^+22" actual
 '
 
 test_expect_success 'patch mode ignores unmerged entries' '
@@ -696,7 +696,7 @@ test_expect_success 'patch mode ignores unmerged entries' '
 	test_must_fail git merge side &&
 	echo changed >non-conflict.t &&
 	echo y | git add -p >output &&
-	! grep a/conflict.t output &&
+	test_grep ! a/conflict.t output &&
 	cat >expected <<-\EOF &&
 	* Unmerged path conflict.t
 	diff --git a/non-conflict.t b/non-conflict.t
@@ -728,7 +728,7 @@ test_expect_success 'diffs can be colorized' '
 
 	# We do not want to depend on the exact coloring scheme
 	# git uses for diffs, so just check that we saw some kind of color.
-	grep "$(printf "\\033")" output
+	test_grep "$(printf "\\033")" output
 '
 
 test_expect_success 'colors can be overridden' '
@@ -743,7 +743,7 @@ test_expect_success 'colors can be overridden' '
 		-c color.interactive.error=blue \
 		add -i 2>err.raw <input &&
 	test_decode_color <err.raw >err &&
-	grep "<BLUE>Huh (trigger)?<RESET>" err &&
+	test_grep "<BLUE>Huh (trigger)?<RESET>" err &&
 
 	test_write_lines help quit >input &&
 	force_color git \
@@ -863,7 +863,7 @@ test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	printf y >y &&
 	force_color git -c diff.wsErrorHighlight=all add -p >output.raw 2>&1 <y &&
 	test_decode_color <output.raw >output &&
-	grep "old<" output
+	test_grep "old<" output
 '
 
 test_expect_success 'diffFilter filters diff' '
@@ -876,7 +876,7 @@ test_expect_success 'diffFilter filters diff' '
 
 	# avoid depending on the exact coloring or content of the prompts,
 	# and just make sure we saw our diff prefixed
-	grep foo:.*content output
+	test_grep foo:.*content output
 '
 
 test_expect_success 'detect bogus diffFilter output' '
@@ -886,7 +886,7 @@ test_expect_success 'detect bogus diffFilter output' '
 	test_config interactive.diffFilter "sed 6d" &&
 	printf y >y &&
 	force_color test_must_fail git add -p <y >output 2>&1 &&
-	grep "mismatched output" output
+	test_grep "mismatched output" output
 '
 
 test_expect_success 'handle iffy colored hunk headers' '
@@ -896,7 +896,7 @@ test_expect_success 'handle iffy colored hunk headers' '
 	printf n >n &&
 	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
 		add -p >output 2>&1 <n &&
-	grep "^XX$" output
+	test_grep "^XX$" output
 '
 
 test_expect_success 'handle very large filtered diff' '
@@ -1002,7 +1002,7 @@ test_expect_success 'add -p does not expand argument lists' '
 	# update it, but we want to be sure that our "." pathspec
 	# was not expanded into the argument list of any command.
 	# So look only for "not-changed".
-	! grep -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
+	test_grep ! -E "^trace: (built-in|exec|run_command): .*not-changed" trace.out
 '
 
 test_expect_success 'hunk-editing handles custom comment char' '
@@ -1072,21 +1072,21 @@ test_expect_success 'setup different kinds of dirty submodules' '
 
 test_expect_success 'status ignores dirty submodules (except HEAD)' '
 	git -C for-submodules add -i </dev/null >output &&
-	grep dirty-head output &&
-	grep dirty-both-ways output &&
-	! grep dirty-otherwise output
+	test_grep dirty-head output &&
+	test_grep dirty-both-ways output &&
+	test_grep ! dirty-otherwise output
 '
 
 test_expect_success 'handle submodules' '
 	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
 
 	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
-	grep "No changes" output &&
+	test_grep "No changes" output &&
 
 	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
 	git -C for-submodules ls-files --stage dirty-head >actual &&
 	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
-	grep "$rev" actual
+	test_grep "$rev" actual
 '
 
 test_expect_success 'set up pathological context' '
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index ec2804eea67c..c66f966a3ab3 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -38,36 +38,36 @@ test_expect_success 'setup' '
 
 test_expect_success 'the default number of context lines is 3' '
 	git diff >output &&
-	! grep "^ d" output &&
-	grep "^ e" output &&
-	grep "^ j" output &&
-	! grep "^ k" output
+	test_grep ! "^ d" output &&
+	test_grep "^ e" output &&
+	test_grep "^ j" output &&
+	test_grep ! "^ k" output
 '
 
 test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
-	! grep firstline output &&
+	test_grep ! firstline output &&
 	git config diff.context 8 &&
 	git log -1 -p >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'The -U option overrides diff.context' '
 	git config diff.context 8 &&
 	git log -U4 -1 >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'diff.context honored by "diff"' '
 	git config diff.context 8 &&
 	git diff >output &&
-	grep "^ firstline" output
+	test_grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
 	git config diff.context 8 &&
 	git diff-files -p >output &&
-	! grep "^ firstline" output
+	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'non-integer config parsing' '
@@ -85,8 +85,8 @@ test_expect_success 'negative integer config parsing' '
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	git config diff.context 0 &&
 	git diff >output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output
 '
 
 test_expect_success '-U2147483647 works' '
@@ -94,9 +94,9 @@ test_expect_success '-U2147483647 works' '
 	test_line_count = 16 x &&
 	git diff -U2147483647 >output &&
 	test_line_count = 22 output &&
-	grep "^-ADDED" output &&
-	grep "^+MODIFIED" output &&
-	grep "^+APPENDED" output
+	test_grep "^-ADDED" output &&
+	test_grep "^+MODIFIED" output &&
+	test_grep "^+APPENDED" output
 '
 
 test_done
-- 
gitgitgadget

