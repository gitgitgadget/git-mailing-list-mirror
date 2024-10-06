Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C706F23CB
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 08:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203500; cv=none; b=tD0mRXpf+AUC857zGbqQH4piy52MGqpWG1oXxZ7TAr0wsKUAxSxiVkZvrFvvN7iwBYHuSbPLAEPWM/Wa0CyAIxBcy22YSH75QxRHk1SrQI0L8c/jMwczQxGE/uwm/JJ9gUwKnWmdEnkSDx38XnJn+5IwLh5vnYsXaU8Wk+8J5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203500; c=relaxed/simple;
	bh=+gKOcuqt3w71kUSe5zRDLEL0Pfg+tOdmcX8VcI4fsPY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gQ93wb0gNjmBlR0JhF2xaCe0gyEPz6sfWO2PXHrTn7Ov/MVE/YzhSp3856RpiCKXd277OuO1rJMabFZo1asBtVVrEggNKOYQiqQDWmHu/7Q55tVckekzoBIzYQ3Gwk1quQti4rpMG+O5AtbkLAnhHrfDBVqgfpfs7bTDc36CNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGI0i5ui; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGI0i5ui"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99422c796eso110464166b.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 01:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728203497; x=1728808297; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUxT9A9+S4cVf90bv0/ONE6sl2NUyGTrQb0ryoxhJBg=;
        b=cGI0i5uiL4Pe6SGX8AVUrggSTAfDS8FS7B4iHkIs0H0ZfGfpxr0wKVcTwJkxKC3Uiu
         41yOPYpQnXQ/y4aW0nKp7UZ1/PqXZ69eJrmcSBMGTLEwH9LWLgs7Ds5KWe6psR8ssuoa
         NU7uCpeSkqDAB7q/NZKXVxlfw4SEwtBhXyMoJ8/VWJuJNpTZ4vsHDDkUp3ODpPNNLzWr
         FwfEs//wz+GVNkAof0JNbPi7MO7hHJVeu1yL8cHwUxGctTQANv39nzoA9ED0Te10SIUE
         yFGfl93JLzVyMcWJSVPaWYNFNXD2v3mfI3SWvJVzB11z20uoy51nIFIZBdMFLh1RPizQ
         XuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728203497; x=1728808297;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUxT9A9+S4cVf90bv0/ONE6sl2NUyGTrQb0ryoxhJBg=;
        b=eQB93sLFwQT8iL2Tqkqgkwk36Bpnx7FzU6jikztDuVQuEqi2/xEyXdwyjXXvZ5xRbc
         diSp1v8lYFK0jAQDLF7I2TTbGID6HbRoaVQlZAG8tR0tre8ta23D697rQohCDBd7bpzX
         AmRJOlrdp6jKCLLFOSbSxHtH8DNmUlcqwCol/kTzFige9Ic85LAEJpbDAgi4PNnmI/Ai
         3Pa1Nw2VwXLozd2wk4RoWOTux2vRlHTDSQZDX+pH4rytrPNgBzDHj/d9Nz88oatW68dD
         OvnNKMrnRAyCDIz+bLnjqsUOuwfn9GU2ZtEeCUR3bvCpr0tD83N3Cx/+sRG/SgTNm73B
         +zhg==
X-Gm-Message-State: AOJu0Yy0JFPxdg5SnhAg36raA/4k7r29NOYGVrwWq8A6dazD5tfOI0FF
	Lvs7k/wiwAhRHHlA0N65Zzt1Nm8awHxvwFa6BVWmb7YbFw6hyKAbPegSJg==
X-Google-Smtp-Source: AGHT+IFdwlKxLcpRPeaefSEjKns2iWlwwQHY0LQn4VRePZuaygELxm9WQru9NBRrUJOT0qxRPVGnSg==
X-Received: by 2002:a17:907:6eab:b0:a99:442e:34ac with SMTP id a640c23a62f3a-a99442e3691mr326919866b.40.1728203496470;
        Sun, 06 Oct 2024 01:31:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9950d0af39sm19454566b.33.2024.10.06.01.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 01:31:36 -0700 (PDT)
Message-Id: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 08:31:35 +0000
Subject: [PATCH v2] [Outreachy][Patch v1] t3404: avoid losing exit status to
 pipes
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

The exit code of the preceding command in a pipe is disregarded. So
if that preceding command is a Git command that fails, the test would
not fail. Instead, by saving the output of that Git command to a file,
and removing the pipe, we make sure the test will fail if that Git
command fails.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
    [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
    
    At the beginning of my task, I made the mistake of submitting two
    patches for two separate commits instead of one. The first patch
    addressed the issue of losing the Git exit status due to pipes.
    
    After submitting the first patch, I noticed that the output of wc -l was
    failing due to trailing whitespace. I attempted to fix this by using tr
    -d to remove the whitespace. However, instead of squashing the two
    patches into one, I inadvertently created another commit.
    
    Eric Sunshine sunshine@sunshineco.com provided valuable feedback during
    the review process. He explained the details of the patches to me and
    pointed out that using tr -d was unnecessary to resolve the whitespace
    issue.
    
    The root cause of the whitespace issue was quoting $count in the test
    command, which led to the inclusion of whitespace in the comparison. By
    removing the quotes around $count, the comparison works as expected
    without the need for tr -d.
    
    Signed-off-by: Usman Akinyemi

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v2
Pull-Request: https://github.com/git/git/pull/1805

Range-diff vs v1:

 1:  5dd96eaf14c ! 1:  be5a691e96f [Outreachy][Patch v1] t3404: avoid losing exit status to pipes
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'multi-squash only fires up e
      -	test 1 = $(git show | grep ONCE | wc -l)
      +	git show >output &&
      +	count=$(grep ONCE output | wc -l) &&
     -+	test 1 = "$count"
     ++	test 1 = $count
       '
       
       test_expect_success 'multi-fixup does not fire up editor' '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'multi-fixup does not fire up
      -	test 0 = $(git show | grep NEVER | wc -l) &&
      +	git show >output &&
      +	count=$(grep NEVER output | wc -l) &&
     -+	test 0 = "$count" &&
     ++	test 0 = $count &&
       	git checkout @{-1} &&
       	git branch -D multi-fixup
       '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'commit message used after co
      -	test 1 = $(git show | grep ONCE | wc -l) &&
      +	git show >output &&
      +	count=$(grep ONCE output | wc -l) &&
     -+	test 1 = "$count" &&
     ++	test 1 = $count &&
       	git checkout @{-1} &&
       	git branch -D conflict-fixup
       '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'commit message retained afte
      -	test 2 = $(git show | grep TWICE | wc -l) &&
      +	git show >output &&
      +	count=$(grep TWICE output | wc -l) &&
     -+	test 2 = "$count" &&
     ++	test 2 = $count &&
       	git checkout @{-1} &&
       	git branch -D conflict-squash
       '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'squash and fixup generate co
      -	git cat-file commit HEAD@{3} |
      -		grep "^# This is a combination of 2 commits\."  &&
      +	git cat-file commit HEAD@{2} >actual &&
     -+		grep "^# This is a combination of 3 commits\." actual &&
     ++	grep "^# This is a combination of 3 commits\." actual &&
      +	git cat-file commit HEAD@{3} >actual &&
     -+		grep "^# This is a combination of 2 commits\." actual  &&
     ++	grep "^# This is a combination of 2 commits\." actual  &&
       	git checkout @{-1} &&
       	git branch -D squash-fixup
       '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'squash ignores comments' '
      -	test 1 = $(git show | grep ONCE | wc -l) &&
      +	git show >output &&
      +	count=$(grep ONCE output | wc -l) &&
     -+	test 1 = "$count" &&
     ++	test 1 = $count &&
       	git checkout @{-1} &&
       	git branch -D skip-comments
       '
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'squash ignores blank lines'
      -	test 1 = $(git show | grep ONCE | wc -l) &&
      +	git show >output &&
      +	count=$(grep ONCE output | wc -l) &&
     -+	test 1 = "$count" &&
     ++	test 1 = $count &&
       	git checkout @{-1} &&
       	git branch -D skip-blank-lines
       '
 2:  4199434bd6e < -:  ----------- [Outreachy][Patch v2] t3404: avoid losing exit status to pipes


 t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..96a65783c47 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -319,7 +319,8 @@ test_expect_success 'retain authorship' '
 	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
 	git tag twerp &&
 	git rebase -i --onto primary HEAD^ &&
-	git show HEAD | grep "^Author: Twerp Snog"
+	git show HEAD >actual &&
+	grep "^Author: Twerp Snog" actual
 '
 
 test_expect_success 'retain authorship w/ conflicts' '
@@ -360,7 +361,8 @@ test_expect_success 'squash' '
 '
 
 test_expect_success 'retain authorship when squashing' '
-	git show HEAD | grep "^Author: Twerp Snog"
+	git show HEAD >actual &&
+	grep "^Author: Twerp Snog" actual
 '
 
 test_expect_success '--continue tries to commit' '
@@ -374,7 +376,8 @@ test_expect_success '--continue tries to commit' '
 		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
 	) &&
 	test_cmp_rev HEAD^ new-branch1 &&
-	git show HEAD | grep chouette
+	git show HEAD >actual &&
+	grep chouette actual
 '
 
 test_expect_success 'verbose flag is heeded, even after --continue' '
@@ -397,7 +400,9 @@ test_expect_success 'multi-squash only fires up editor once' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 1 = $(git show | grep ONCE | wc -l)
+	git show >output &&
+	count=$(grep ONCE output | wc -l) &&
+	test 1 = $count
 '
 
 test_expect_success 'multi-fixup does not fire up editor' '
@@ -410,7 +415,9 @@ test_expect_success 'multi-fixup does not fire up editor' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 0 = $(git show | grep NEVER | wc -l) &&
+	git show >output &&
+	count=$(grep NEVER output | wc -l) &&
+	test 0 = $count &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
@@ -428,7 +435,9 @@ test_expect_success 'commit message used after conflict' '
 			git rebase --continue
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 1 = $(git show | grep ONCE | wc -l) &&
+	git show >output &&
+	count=$(grep ONCE output | wc -l) &&
+	test 1 = $count &&
 	git checkout @{-1} &&
 	git branch -D conflict-fixup
 '
@@ -446,7 +455,9 @@ test_expect_success 'commit message retained after conflict' '
 			git rebase --continue
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 2 = $(git show | grep TWICE | wc -l) &&
+	git show >output &&
+	count=$(grep TWICE output | wc -l) &&
+	test 2 = $count &&
 	git checkout @{-1} &&
 	git branch -D conflict-squash
 '
@@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate correct log messages' '
 	) &&
 	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
 	test_cmp expect-squash-fixup actual-squash-fixup &&
-	git cat-file commit HEAD@{2} |
-		grep "^# This is a combination of 3 commits\."  &&
-	git cat-file commit HEAD@{3} |
-		grep "^# This is a combination of 2 commits\."  &&
+	git cat-file commit HEAD@{2} >actual &&
+	grep "^# This is a combination of 3 commits\." actual &&
+	git cat-file commit HEAD@{3} >actual &&
+	grep "^# This is a combination of 2 commits\." actual  &&
 	git checkout @{-1} &&
 	git branch -D squash-fixup
 '
@@ -489,7 +500,9 @@ test_expect_success 'squash ignores comments' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 1 = $(git show | grep ONCE | wc -l) &&
+	git show >output &&
+	count=$(grep ONCE output | wc -l) &&
+	test 1 = $count &&
 	git checkout @{-1} &&
 	git branch -D skip-comments
 '
@@ -505,7 +518,9 @@ test_expect_success 'squash ignores blank lines' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 1 = $(git show | grep ONCE | wc -l) &&
+	git show >output &&
+	count=$(grep ONCE output | wc -l) &&
+	test 1 = $count &&
 	git checkout @{-1} &&
 	git branch -D skip-blank-lines
 '
@@ -572,7 +587,8 @@ test_expect_success '--continue tries to commit, even for "edit"' '
 		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
 	) &&
 	test edited = $(git show HEAD:file7) &&
-	git show HEAD | grep chouette &&
+	git show HEAD >actual &&
+	grep chouette actual &&
 	test $parent = $(git rev-parse HEAD^)
 '
 
@@ -757,19 +773,23 @@ test_expect_success 'reword' '
 		set_fake_editor &&
 		FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" \
 			git rebase -i A &&
-		git show HEAD | grep "E changed" &&
+		git show HEAD >actual &&
+		grep "E changed" actual &&
 		test $(git rev-parse primary) != $(git rev-parse HEAD) &&
 		test_cmp_rev primary^ HEAD^ &&
 		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
 			git rebase -i A &&
-		git show HEAD^ | grep "D changed" &&
+		git show HEAD^ >actual &&
+		grep "D changed" actual &&
 		FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" \
 			git rebase -i A &&
-		git show HEAD~3 | grep "B changed" &&
+		git show HEAD~3 >actual &&
+		grep "B changed" actual &&
 		FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" \
 			git rebase -i A
 	) &&
-	git show HEAD~2 | grep "C changed"
+	git show HEAD~2 >actual &&
+	grep "C changed" actual
 '
 
 test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
@@ -1003,8 +1023,10 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
 		set_fake_editor &&
 		FAKE_LINES="2" git rebase -i --root
 	) &&
-	git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
-	git cat-file commit HEAD | grep -q "^different author$"
+	git cat-file commit HEAD >output &&
+	grep -q "^author Twerp Snog" output &&
+	git cat-file commit HEAD >actual &&
+	grep -q "^different author$" actual
 '
 
 test_expect_success 'rebase -i --root temporary sentinel commit' '
@@ -1013,7 +1035,8 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
 		set_fake_editor &&
 		test_must_fail env FAKE_LINES="2" git rebase -i --root
 	) &&
-	git cat-file commit HEAD | grep "^tree $EMPTY_TREE" &&
+	git cat-file commit HEAD >actual &&
+	grep "^tree $EMPTY_TREE" actual &&
 	git rebase --abort
 '
 
@@ -1036,7 +1059,8 @@ test_expect_success 'rebase -i --root reword original root commit' '
 		FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
 			git rebase -i --root
 	) &&
-	git show HEAD^ | grep "A changed" &&
+	git show HEAD^ >actual &&
+	grep "A changed" actual &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 
@@ -1048,7 +1072,8 @@ test_expect_success 'rebase -i --root reword new root commit' '
 		FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
 		git rebase -i --root
 	) &&
-	git show HEAD^ | grep "C changed" &&
+	git show HEAD^ >actual &&
+	grep "C changed" actual &&
 	test -z "$(git show -s --format=%p HEAD^)"
 '
 

base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
-- 
gitgitgadget
