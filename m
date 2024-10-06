Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D244D154C08
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728192820; cv=none; b=WXPcS/+I7Ait4vPrB5HPqPp48XDKdT1Pm03+NwPrhvFzaFlUuTn4d/Ae9DfLwvHO8nx+VI1Fluf+5BTFzVVEGudipu9ldWHlaI64h/TbtKxTidN8BypmVpTPOAuLucWx88ohvPtMMYfGQb4TOJecM9NEbsFR/RJBTbWN5Q3dssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728192820; c=relaxed/simple;
	bh=knefsMFyyCKyVHoQ622vvqHm4qZJ5Ls1Ds4BLkz60Rc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ndgV1aEH4aefP3HtcXLaeizykZ9wjtmZ6Yazy3OHq8boXFPKEL0/iC8G5UaNxoAwPe7Euueij+BNLZ15iN+WyTGraLH9QNPGgdKanxgi61D6JXL3ZS5X0/VGclkTW794rtOgzOBHLqIPW6qyXFT8CxIrSgwt8BX9cD52wzeqIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbza3qqF; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbza3qqF"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c89668464cso4481818a12.1
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728192817; x=1728797617; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaKtbbcirwQEaCnzI2Su5PaEziMNaDRk+1puNV6gOYo=;
        b=Dbza3qqFeR5ZXzIgLwk3oVAAQrtMBBdYYXVdngAxRIiKIdGhuvBZOR6w5ue4Qt/qq8
         f5ioZhtcGxQlnCQ878XRGUvnmfsyvT6Q6yUUh4uPtGC0VjlbAo+IteoBI2bVM5Jsxtu0
         qc74IWaSosxmgZACehrz0bTULmXXhpyvwuSPTwhlYjlCna8o/P8EsMZr+ta4uiXiySzd
         yYkLGKqujhzv7Ce8//0+ZLzj9rm/DMJ7nOPduFvWC1DjhXv9jUdA4QM2BJ1KE+RtLCVa
         xgyE2RAxwRosPsVSrRmgZCsCGgU/M5sGCDBKrRC1U39TgEmrpfeiOiwdUBg7xZRxIlJN
         K7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728192817; x=1728797617;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaKtbbcirwQEaCnzI2Su5PaEziMNaDRk+1puNV6gOYo=;
        b=TTpsTR38hiQCaEIT8eKh1UXkbJZ8EdIfr9FjQ/cFxZtUhI+HFHbdjRbL+cRXluJRXw
         keCEdIZBZvLY3WzMgt+yH/xW0r4oMceyyhdCfmkSL8ouHgWtH0Fzy9HrZ4hnh8z4zRAP
         e32V7UErJc8/bi4dn2A0Q93G/9/gqH2dqiOE1oNVu0UH6qFjdmUdcYwDMVG9n3p5pbQi
         MyDKpgeb5oXIhEZYBn0jLOuCMquSe3rpXl7hb3thNcIUpZoe51XfXW3cTpZSgclffcb+
         FvsiwSGDQFykbYyittq8KRJLl0JRLmeQBByyab4GQ65iYddqefg6hxFKmw8/hWf5vwGv
         hpgA==
X-Gm-Message-State: AOJu0Yw8c0j+emlvmNE+0/Hl7MTMF2SiU+UuY6TWizcmseBxaCESOU8q
	wOrvz86ivgVRNHvLKP27/qpYNElqFQlMhQLaNC10AAmZnhwzVqTo1VAcvg==
X-Google-Smtp-Source: AGHT+IHD5tctbFFkxS1bBXo4ALBhPlkMiUqtiu1+PiOgtF5LWu5RqS88nOTxutTbzDKOOshfucNTUw==
X-Received: by 2002:a17:907:7288:b0:a86:7cac:f871 with SMTP id a640c23a62f3a-a991c01a735mr910785666b.54.1728192816547;
        Sat, 05 Oct 2024 22:33:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784ebasm218390666b.141.2024.10.05.22.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 22:33:36 -0700 (PDT)
Message-Id: <5dd96eaf14cb6fbe130fb50ce2738646d7d3ac57.1728192814.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
References: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 05:33:33 +0000
Subject: [PATCH 1/2] [Outreachy][Patch v1] t3404: avoid losing exit status to
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
 t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f171af3061d..33ea1f05e2c 100755
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
+	test 1 = "$count"
 '
 
 test_expect_success 'multi-fixup does not fire up editor' '
@@ -410,7 +415,9 @@ test_expect_success 'multi-fixup does not fire up editor' '
 			git rebase -i $base
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
-	test 0 = $(git show | grep NEVER | wc -l) &&
+	git show >output &&
+	count=$(grep NEVER output | wc -l) &&
+	test 0 = "$count" &&
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
+	test 1 = "$count" &&
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
+	test 2 = "$count" &&
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
+		grep "^# This is a combination of 3 commits\." actual &&
+	git cat-file commit HEAD@{3} >actual &&
+		grep "^# This is a combination of 2 commits\." actual  &&
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
+	test 1 = "$count" &&
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
+	test 1 = "$count" &&
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
 
-- 
gitgitgadget

