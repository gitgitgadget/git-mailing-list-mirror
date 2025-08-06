Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783721D3F3
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522131; cv=none; b=g1U9D0YyJDrJ+Zb6LRcFpzE2et0VWfZBS4E6p0f8wNeDc0KGwo07mRuAzBP6Bd2sofDNAsMyUEEEKwUQZlMGdV2qImSObftpHBJR8shpl4dqZkgeRot1i3iRaJhosb0Ud/iWL5thFMj+N8YO/HejdD7eCKD7pQjp9jrNjW0JnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522131; c=relaxed/simple;
	bh=XZwKFJ6qrym5cRRXteURWjy2mVXf7Nvnf7AkqerrqUI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lp1qVBp0ORAo7WhrEBpWQocO98mro558MDwBjgKmRFrk272vwP9062/9mKlB9C6ueh20y8321/Ye8whWN7zCsmtZm0WgzIBOG+vVgv2mBpJctXTw8+469R7XPJGfNCZvyog49qbmENhDvv5QY+So5XpD/DPwz2Az38N06PLfkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsZBnFr4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsZBnFr4"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso741427f8f.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 16:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754522127; x=1755126927; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sYnGWdLOXXjVH1RAn+fUuvFqiN5S14ikewZBJbjebk=;
        b=CsZBnFr4A8P5S+t/2wWcbaNHGU8W3bQtT3NJkk+cSqPr11P800/uSw6TscXNWkgFNQ
         ZbicbOUmqiBGFTEa5N/w8bcIZ+HPOYpSArQIfWB5VvS4v3NCC2hW03QCL/9BenEwXLyZ
         dsChqYGr+LabjuQZb6p71DOPex42+CJPP9HlCZStnOKHzPfePLhLsFqTpHQRhKwN/yzY
         h1xiMzYmTiq1wE7LW3i15Izy03ZhULIrLD5zhu7ZXubAP+KvVzPYQcoHxoMlyZ13X3/d
         GZuGKsm/dxzo8XIHmwZ6vcm2gsmG+3LsEV4zQ3AjxzfdyuEcVZ6eGwuIiYM5rQ+vtM9M
         bIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754522127; x=1755126927;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sYnGWdLOXXjVH1RAn+fUuvFqiN5S14ikewZBJbjebk=;
        b=aHlC5sJmimppl3pc2L8jfsU8CCLKH6PP7e+PpU/979Ux/PMC496rfObJN/7dfuE9jL
         G6Mk7gnSYMV/fYqBc/7wZLOkdnaKUjvL4prLqHO9hSpsOM0YqOeqM1ATiV08wuqiOfGD
         FmMXhvJsYypXdcWN/BKG2SMNA+kAEl+aViWAEcbefJ+71wgvQ4afkHB2OrGhxmxmONlp
         Bwm5yEPNLZB2PxG05R9ZVCOSagU5zhOtlRyp2UURjY2bxkB3b/5kXOr6EBhFcPlRb/in
         y/qoUF8ccxEsN1SCYtiIs1Hpiwfk9GUs+iDSWAV/3g+ii7VBsdG9CQS+sOgjKcvEmfRe
         nv/Q==
X-Gm-Message-State: AOJu0YzhUJwVCpbEXIustUxClEZN0o9qxNuPgtfSzDHqKafUWVhteTsU
	T/ScmgeCdOK6X44R34kssGIQXqgdR/RYnBmST3tR1Zsq+kvVlrX7PbB9pjiMEQ==
X-Gm-Gg: ASbGncsPYMOjqodbN2ebXkkMol9n7ScyVCLgt4w3t/LcRoXpfWhPVC8RIz2eegjilr1
	UYN7LIHGVcjDZV8p+DMbqHZJr6x28sVE0RxkYwdREq+6Suc5Siel9SVDL//ynxdeeqMLIp2hRF0
	7ySmW4Tzs9E2+ismTZ01Yt6YMZ1pRYQOMWR6/YGAMbXjKhPW0KdEyIyDTgMZyoyJMYZ8nxi0bjJ
	mFh6SZm4/868rf/35bdH/7bdxJTn5326gZgtlarnuOnCakd4zNDlFBzu16kkfzUjkCcJ/2OZa8m
	q3/Zxk/xnd8wpmrLoDX8/p8yihWtil6LqYKLVBWTbiEOGQc/Yv4kbSmEa1oARXGTX1cDgindJ/y
	Hzuw94E32jdteo+l55rYdNIY=
X-Google-Smtp-Source: AGHT+IH/WPV2m62LpIz5WuRqjwfBBdnMn++fXVcXfhICbPzcZ/MhnkKLVgREl5NyyDN2Q5SN+ZrkvA==
X-Received: by 2002:a05:6000:25c3:b0:3b7:7901:b38b with SMTP id ffacd0b85a97d-3b8f97c4875mr1155432f8f.8.1754522126961;
        Wed, 06 Aug 2025 16:15:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e586eef8sm64948345e9.21.2025.08.06.16.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:15:26 -0700 (PDT)
Message-Id: <1ea7bfd3bff81a648a5ed1d0112ec404ab64fc91.1754522123.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
References: <pull.1943.v2.git.1754422546.gitgitgadget@gmail.com>
	<pull.1943.v3.git.1754522122.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Aug 2025 23:15:18 +0000
Subject: [PATCH v3 3/7] t6423: document two bugs with rename-to-self testcases
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

When commit 98a1a00d5301 (t6423: add a testcase causing a failed
assertion in process_renames, 2025-03-06) was added, I tweaked
the commit message, and moved the test into t6423.  However, that
still left two other things missing that made this test unlike the
others in the same testfile:

  * It didn't have an English description of the test setup like
    all other tests in t6423

  * It didn't check that the right number of files were present at
    the end

The former issue is a minor detail that isn't that critical, but the
latter feels more important.  If it had been done, I might have noticed
another bug.  In particular, this testcase involves
   Side A: rename world -> tools/world
and
   Side B: rename tools/ -> <the toplevel>
   Side B: remove world
The tools/ -> <toplevel> rename turns the world -> tools/world rename
into world -> world, i.e. a rename-to-self case.  But, it's a path
conflict because merge.directoryRenames defaults to false.  There's
no content conflict because Side A didn't modify world, so we should
just take the content of world from Side B -- i.e. delete it.  So, we
have a conflict on the path, but not on its content.  We could consider
letting the content trump since it is unconflicted, but if we are going
to leave a conflict, it should certainly represent that 'world' existed
both in the base version and on Side A.  Currently it doesn't.

Add a description of this test, add some checking of the number of
entries in the index at the end of the merge, and mark the test as
expecting to fail for now.  A subsequent commit will fix this bug.

While at it, I found another related bug from a nearly identical setup
but setting merge.directoryRenames=true.  Copy testcase 12n into 12n2,
changing it to use merge instead of cherry-pick, and turn on directory
renames for this test.  In this case, since there is no content conflict
and no path conflict, it should be okay to delete the file.
Unfortunately, the code resolves without conflict but silently leaves
world despite the fact it should be deleted.  It might also be okay if
the code spuriously thought there was a modify/delete conflict here;
that would at least notify users to look closer and then when they
notice there was no change since the base version, they can easily
resolve.  A conflict notice is much better than silently providing the
wrong resolution.  Cover this with the 12n2 testcase, which for now is
marked as expecting to fail as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 100 +++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index f48ed6d03534..2def1522bd59 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5056,6 +5056,25 @@ test_expect_success '12m: Change parent of renamed-dir to symlink on other side'
 	)
 '
 
+# Testcase 12n, Directory rename transitively makes rename back to self
+#
+# (Since this is a cherry-pick instead of merge, the labels are a bit weird.
+#  O, the original commit, is A~1 rather than what branch O points to.)
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
 test_setup_12n () {
 	git init 12n &&
 	(
@@ -5084,7 +5103,7 @@ test_setup_12n () {
 	)
 }
 
-test_expect_success '12n: Directory rename transitively makes rename back to self' '
+test_expect_failure '12n: Directory rename transitively makes rename back to self' '
 	test_setup_12n &&
 	(
 		cd 12n &&
@@ -5092,7 +5111,84 @@ test_expect_success '12n: Directory rename transitively makes rename back to sel
 		git checkout -q B^0 &&
 
 		test_must_fail git cherry-pick A^0 >out &&
-		grep "CONFLICT (file location).*should perhaps be moved" out
+		test_grep "CONFLICT (file location).*should perhaps be moved" out &&
+
+		# Should have 1 entry for hello, and 2 for world
+		test_stdout_line_count = 3 git ls-files -s &&
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count = 2 git ls-files -s world
+	)
+'
+
+# Testcase 12n2, Directory rename transitively makes rename back to self
+#
+#   Commit O:  tools/hello
+#              world
+#   Commit A:  tools/hello
+#              tools/world
+#   Commit B:  hello
+#   In words:
+#     A: world -> tools/world
+#     B: tools/ -> /, i.e. rename all of tools to toplevel directory
+#        delete world
+#
+#   Expected:
+#             CONFLICT (file location): tools/world vs. world
+#
+
+test_setup_12n2 () {
+	git init 12n2 &&
+	(
+		cd 12n2 &&
+
+		mkdir tools &&
+		echo hello >tools/hello &&
+		git add tools/hello &&
+		echo world >world &&
+		git add world &&
+		git commit -m "O" &&
+
+		git branch O &&
+		git branch A &&
+		git branch B &&
+
+		git switch A &&
+		git mv world tools/world &&
+		git commit -m "Move world into tools/" &&
+
+		git switch B &&
+		git mv tools/hello hello &&
+		git rm world &&
+		git commit -m "Move hello from tools/ to toplevel"
+	)
+}
+
+test_expect_failure '12n2: Directory rename transitively makes rename back to self' '
+	test_setup_12n2 &&
+	(
+		cd 12n2 &&
+
+		git checkout -q B^0 &&
+
+		test_might_fail git -c merge.directoryRenames=true merge A^0 >out &&
+
+		# Should have 1 entry for hello, and either 0 or 2 for world
+		#
+		# NOTE: Since merge.directoryRenames=true, there is no path
+		# conflict for world vs. tools/world; it should end up at
+		# world.  The fact that world was unmodified on side A, means
+		# there was no content conflict; we should just take the
+		# content from side B -- i.e. delete the file.  So merging
+		# could just delete world.
+		#
+		# However, rename-to-self-via-directory-rename is a bit more
+		# challenging.  Relax this test to allow world to be treated
+		# as a modify/delete conflict as well, meaning it will have
+		# two higher order stages, that just so happen to match.
+		#
+		test_stdout_line_count = 1 git ls-files -s hello &&
+		test_stdout_line_count = 2 git ls-files -s world &&
+		test_grep "CONFLICT (modify/delete).*world deleted in HEAD" out
 	)
 '
 
-- 
gitgitgadget

