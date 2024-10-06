Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75121187554
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230775; cv=none; b=UKvvnxuapN0NtTEJqffI2kRiBOTK9fAz+uE4j1AU9JbTruKtQfUgOBFtUB/kw3pN/WfJNor339ne7J7z9Fg6HWZ+oBdiEUrlk4cHpFOhKaTW9UMGCoHGIt8PS7QYR/SONbR4l+UcyZKxeHJIyVDMwsLzYVeJm4wVz3l+0kQETwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230775; c=relaxed/simple;
	bh=8CB+9+cGPcwTwo9n6awNYLJAroYR4Cdua/kx91gl03E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tiYYsFirYvp0gc4eIq8YKXd0aLQgV2WFWtqPSI0HNdpFyiG+e8cK1dDfbfR9IHh7XYesktHjaBuUZTHlTmiYQ198DLh5wPV3gxT5Zu/+P240HqTDJb6H4KTqFBGQR/euoEWrEQK5rDoE19oo9RkJVhmXN/xKySySp0gjTHVEB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9CGmoIZ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9CGmoIZ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso2826459a12.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728230771; x=1728835571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lF4FLBDWq/Uniakre3PQv7W9CngSyj3ZeRKh7o+dE4=;
        b=E9CGmoIZBr7Y0MbsgyNEyJKI8jFNY7AFT9Dx3CokVdirP8IqErwFAqZDKH0rU9+Zp9
         hutKW+8MPLF1/MalZ6yS/orgiydYaVK85PUGcfL8aHX6Sfr0Wh6NC8u1mq+0YmJskfkV
         k9ATm3VbULWppB/Gh3ZhEw03yEahS84EIR3u5UKjcnUVFnOu+lW+n3lVFI+PtnBovLDK
         v/Y7oV0ZRXQdsOjcl//jUJNfrT0OvR0SL4SW65I+Q6N+BdbGhtpUWipfkfDhz7NA4C9f
         JLzqxww44FkxH01RNZrBXwHUX7NLjDQ6oxqwRxk05deVNDInCYYMeTaZofFcArGYbqi7
         BONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728230771; x=1728835571;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lF4FLBDWq/Uniakre3PQv7W9CngSyj3ZeRKh7o+dE4=;
        b=deb4AStOvX4RyP79YOjcbWQzJtaS+YRTIa8dk+VR5RTP+GAXzvSPAhqxhIZ3bpgftb
         bJ4i5VA8w+fS+yuIaVuM/K0WP8OuOMaaamIE/WkBRtiXOBhHv0UTpgncGotdAfUX48Yy
         4Jwbq0bKa3lIFusE/4MAVHAlAMgmV4OHhOisjlSUKz7SLUgrXaPC9TYLoknDhRYJNgfY
         qPukIQ/F6+dWlrVg/cVzQrFby3Q+6/r1UVaYR2Ajaw4r+YoFrgo9T7HKvrb5qDQnFl9X
         SUMF+WBEN/McJNnEYY408cSap5pKmCqyO4T3nQpb2RkMrWtO7kOjJEyOmvQURl/O2wSP
         1IBg==
X-Gm-Message-State: AOJu0YwJjosZN3l/zRtXzboUuPa5RS3lRjfZH5sJqQUETohoDpmFhfCr
	qqvqxK6ZpjpKZSFo0V4hQjQznCf2zyyXvx5P8GD/c/iEFKzLqxZjrCd7Eg==
X-Google-Smtp-Source: AGHT+IGSCQnz90EoIdUeIREsCNqI8TkjVOJTtmPI71ENTNPAjdZy/R1cTU7XPhu3867QaYpP1Hxjqg==
X-Received: by 2002:a05:6402:524e:b0:5c8:b9ce:a367 with SMTP id 4fb4d7f45d1cf-5c8d2e35445mr16069470a12.10.1728230770825;
        Sun, 06 Oct 2024 09:06:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9940f613c2sm182872566b.4.2024.10.06.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:06:10 -0700 (PDT)
Message-Id: <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
	<pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 16:06:08 +0000
Subject: [PATCH v3 1/2] t3404: avoid losing exit status with focus on `git
 show` and `git cat-files`
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
Cc: Christian Couder <christian.couder@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
    Eric Sunshine <sunshine@sunshineco.com>,
    shejialuo <shejialuo@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

The exit code of the preceding command in a pipe is disregarded. So
if that preceding command is a Git command that fails, the test would
not fail. Instead, by saving the output of that Git command to a file,
and removing the pipe, we make sure the test will fail if that Git
command fails. This particular patch focuses on some of the instances
which include `git show` and `git cat-files`.

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

