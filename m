Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4982AD05
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299471; cv=none; b=WlEaJWX1Ggp2mH0ejyLrqV2L6z44NGnifjmRCYzmsTTOX/u694LsWghRt9PpO4zTQXv+qaZ98jJPyEF/7CY1b9wY0G4eAYtLO8atNqcJMYpuDfpbd+gmWBOeahb/Wfwog/hE0GEgFTEG42G5KjM3VgWLUk6bBxf8kYdwzjP48ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299471; c=relaxed/simple;
	bh=8X7AYbIkdi6HWMJsOn8WL8bQ8PJ1PdePDY/MmQ8HcQA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ay96jMK6ygULZ1Q3RCJBkLq+cutaEKPLPG7WqcngV8yUPs2bydc+puKrivUxs6vAOLgATbHhPUKw7O1RHdan9D1tqvwcx6jmYaqqIWptvmbeutAfGCJ/p2rzSJifWaWFvZtFkXRCW23Ewgb6ambAVaIgOdaiCDEuQEqB1y90scE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=II/wIT6Q; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="II/wIT6Q"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9951fba3b4so142708566b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299468; x=1728904268; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=II/wIT6QJbNvHwI22e5TfgP5ZlrOO0dv0mWWVvWBQjQAPM+QgCjEjusDwC7JP2T1QB
         HZnLeIfXVnq9zm/UnVdC4+I3wDWjBj1C/V9oSnZ8uQ01pEHlVBg19fcoh2sxEZH32tAw
         RTo/UT3FTQG1zaFBy622om5kOO2pamy5l6Kcj82VwePOyK8yptsaJrYGBLWBdclUFK0R
         s00flt6iwK5V4gYUsITbiEr++BBUWiCf9B8qpqgpN/IPh38akNqk2Tcgbnba+lkbh5PN
         Fr8VHBma8PbdwuEoZYpSixsWOD4fbtuhvlUe8fvTkQVCLTJgkVt8md65DWQ4KsfmAnnU
         8A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299468; x=1728904268;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=s0tPoM+XB6GJ4aSnUJXO7aSKHCeHLnQwsBsx/myDY8mmttZkavInBtqSj8pNf4nrBX
         MfWGgy4KXqG5lEbtiLxjD+44clzjcZwNkfH+Rq82Xp9nJIXdCL7PIGuPErU4+0I7zAWm
         8DWKvN/hrYmk3RYGFTX2zEMPhP2zye771SVnR7t1bL/ycilFKoUztpTeHSd87ZqQwHD4
         MVJLQ/FkaKzxlBM8IR8TUo1Pha2o/HGziY2LeC9fLVpTSRicn9AnnZRhoXYKgavkl0RP
         PLiveO4zPgc+5lTblnE1J/tJHwe1hWEUaN679q70k9yU0JMQ8L5T+xjpnwiz1uadOSGD
         S3eA==
X-Gm-Message-State: AOJu0Ywbki1L+YnydP8jdtLR6aHyc6s+l8eNcLNg5CIZ0jboW/dWHMtq
	gDLV2rxwi+0mmbrYzwjV2MEoV/CLYYzyLGIV8X8/PpksuFUUKAUrcbJW8A==
X-Google-Smtp-Source: AGHT+IH/Okt5TVdWxeJWY7JcBitaHetL88aEvgSaKPdfaS6fmBO0yeD+QhBEoHZnn6fxMcz8zFAekw==
X-Received: by 2002:a17:907:1b91:b0:a99:4156:997d with SMTP id a640c23a62f3a-a9941569a73mr479689166b.19.1728299467925;
        Mon, 07 Oct 2024 04:11:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993ac07465sm313274966b.20.2024.10.07.04.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:11:07 -0700 (PDT)
Message-Id: <bfff7937cd20737bb5a8791dc7492700b1d7881f.1728299466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
	<pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 11:11:05 +0000
Subject: [PATCH v6 1/2] t3404: avoid losing exit status with focus on `git
 show` and `git cat-file`
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
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

The exit code of the preceding command in a pipe is disregarded. So
if that preceding command is a Git command that fails, the test would
not fail. Instead, by saving the output of that Git command to a file,
and removing the pipe, we make sure the test will fail if that Git
command fails. This particular patch focuses on all `git show` and
some instances of `git cat-file`.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
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
 
-- 
gitgitgadget

