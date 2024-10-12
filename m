Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AB719CC3D
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774580; cv=none; b=W7v8GZJszguB1yahlRqgSbVO1o0rfj6Bhq0UU9HgV7jtVGv2kNP6oDOWplJAuxttyUaJWyr9hb9hpr8ALJUCG+M307bJkaWxcUuUx637SOc4OhfvzwSTFasNQDS9JFG0Pk9XwxRAYz9kriwm1BabIXR8gAChOP6alIznsgVRSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774580; c=relaxed/simple;
	bh=8X7AYbIkdi6HWMJsOn8WL8bQ8PJ1PdePDY/MmQ8HcQA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=V9mmVK7RWHsNzlazNZeyM21eJtYquYO1i25TsonbDvNyrSQNgLjCom+Qy5NRfNBbOvy/DKZ0vzhQPhFGSJnzQl4f9bFGChu+wUlCK7UuLExwnY1vRVsId6NAJgvebdD6T+i7V1WrI5zPn6rw69QDSe2O59Befvav+hjFzhmbjso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geC2lhnZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geC2lhnZ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9944c4d5d4so450378666b.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728774576; x=1729379376; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=geC2lhnZoEHzFFDW7Hn9QEKqR1iOqO4UTP0U6DWfoZc66VOzFBJZ6PNNlfAxvdZviH
         gbiHrg3+wu6FzP3fsUPvMcYafDk9D1us8MmBm2sV8E1MjN0ibvndp+03P+Y8o1FLK2EH
         wu1AXap1724bTKkxxNfOv6pV4GWagH1ITS3bh9mL43YOFh9vxcy5TL52/Hx2shr7YJAY
         KUmBS4seJu2OI6XdyiJ/BmK29GOG/5HaGHdd1AzqsGaxrktIkta1tCNZ1WTgZLhI3B9/
         c0Qa9XOqu776RmAeITBIcfYui7oaXJyBpCeh1jC64sOpWpjyOJp2DJrNVjTZ3XD4ZypV
         4SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728774576; x=1729379376;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=YFpShgPPs9e05vZamznUX4k8zALPxpHk2QBozmleSMtQZ0cNrTlr2oQpBNK9k+AD0i
         KQKrGWoSPrM4WzkNj794LwQV/Yq8//2XswTGYcjyWBhc88fZ0N91fN/T75jZ9QJa3MKo
         INPYvrQCLk8D7SzGmoY07cqsPyPFsXeQe8FsL/8kDqx68nP9TJeCmdKnHbJh+Y/CsHU3
         jklnpq6raqIM1GSE63vWhoGN1ipM3H0DRiKJevyJavuUA7WpC+kMcKVDzvM5ZI0qe0wV
         8lUNVNn0jI5WLoQLXCM6fcsZngSAQdKkHpq1m84pAXBlZqQg4M/yjURXWQzO5VQh/5aa
         U9hg==
X-Gm-Message-State: AOJu0YzWAoGzmdBUoKn0Pa3sdG9nS0lR3BnYRqayFJ46OnyB0F8m+wb/
	n+FRkX4wIvnbV9jP4CV0P+OT45ScJECI/FjB4MfB8B5tIixLGurvB6IXEA==
X-Google-Smtp-Source: AGHT+IFx7Bho6WOgHKVJhVw2d72L+G2Ic6PBAZuMUD4G8FOkDLCqnD5UYNKD1FcuEIDaKRdJmT+ZcQ==
X-Received: by 2002:a17:906:6a14:b0:a99:ed0c:1d6 with SMTP id a640c23a62f3a-a99ed0c0ac9mr240662166b.49.1728774576236;
        Sat, 12 Oct 2024 16:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dcd55sm374124866b.173.2024.10.12.16.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:09:35 -0700 (PDT)
Message-Id: <bfff7937cd20737bb5a8791dc7492700b1d7881f.1728774574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 23:09:32 +0000
Subject: [PATCH 1/3] t3404: avoid losing exit status with focus on `git show`
 and `git cat-file`
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

