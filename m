Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5018BC29
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298315; cv=none; b=Oa5Xe9TTPfdNu9EAv2ixFOkMfNk00GWOUlk+dGjiPIykq38HbgQwXY+OpCIgX9FsRioAchFUkyUJsrfAV0BPZOZjP4/VsQoIPBoUFzUXHzYC2PT/6nUwGnjFr2Tt7AzjCbw2wNMl1sj+pF0BUerjx4sjwokwxxzGh6jAUTUHreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298315; c=relaxed/simple;
	bh=8X7AYbIkdi6HWMJsOn8WL8bQ8PJ1PdePDY/MmQ8HcQA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=t6Gs9uCD8EWO8dpd138S3SoYoxSV5xknm6ScIqmcX6FCuWOehYSlDb68s8W+xsmBm4B5iwe2oMdzirQWsxwGHPRwOvt6y8BAQdRBlItnr/nnPbS+caOJk480ik0aDX8f5w+Q/LXPYqAUMWAQWMsFhpaLtMDF/2bb494ABY/s05k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU7eqwGf; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU7eqwGf"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so6028710a12.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298310; x=1728903110; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=fU7eqwGflg452pMaIFHgNHkepvinkB0gW8YQ1WhEhs1ljFp6Cpz4KmhzoFFyFM92+j
         w7qx0jG/I0zifTCWXixnQrxK8FYRFhuFBqp7gB84/yasyDrVXL6YjlrH53pF7p3ld7cn
         521EXR02EgxJ9SxCn41o9nRp2oypQITGBftLLIRVPUY5JfOR5o/24OtzVziG5ECwNBKv
         48pxqqESn1RlOggdVbbfXs0MJkKeIkcifiODm1xCEcZPbekRH7w85fUnwi4q0pTSd3Kp
         hZnFSuB5fOfcQMzip/0XBFxkoo1U4oDRIoXB9X1PIwp7pz5iDgG6uwQsWyU+n3trGKNv
         ZbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298310; x=1728903110;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDnWYjNHpEFCxbMSFSMnpDZIaC6pxr1AJpOo0w99cRM=;
        b=PfBQCO1tbjE0aCAhlHkHiV4lrU4gfqbeimxHva0KWlq3uNI8Yk+NVl5tNnvFi18uGt
         yU7k6SVD/cHQ7rBp+fdaNudYdATwSG07I97b4WmFbo+GklKzxd76tUBWNCP+VCJMM8sm
         Cr52oywFs72L5YiIhbBYy4OKOWyiQNm/xl9NLTS72TvQXCyFhpnJARmZZ6qfiF7oT5G1
         wI64ebEp9+OQmfBdW2wz5yxhHF25AznLOrc3RV9SfjUht6StTeYYSDknHOcEk+Ra/B5y
         8wd4QQPwJg7lPSUq+Y71yChAqJiNurp8Au8ef6iBoEm6Au9mrJL2ToqqUKdiKpfm/tkR
         4YYw==
X-Gm-Message-State: AOJu0Yy5/5mmdhZrxzBLoj2IuFVpmH0Uf7x8eXRfoRHvvwlqCx4TVG+m
	qMfEdzRN2C+I9PylukKfDMjEaXrj/iJLm5it9IzuQh4dTbUGZG3/P2tTsQ==
X-Google-Smtp-Source: AGHT+IGjl64sNkxroBB/tbSYToJ3L9jDeWm9IXa/v9N6blzJkVDcVvWd3DyJ6EIYEYG19iE0ZKDXIw==
X-Received: by 2002:a05:6402:2695:b0:5c5:c5c0:74ec with SMTP id 4fb4d7f45d1cf-5c8d2e73b39mr11026170a12.24.1728298310390;
        Mon, 07 Oct 2024 03:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f3a6csm3042337a12.81.2024.10.07.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:51:50 -0700 (PDT)
Message-Id: <bfff7937cd20737bb5a8791dc7492700b1d7881f.1728298308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
References: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
	<pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 10:51:47 +0000
Subject: [PATCH v5 1/2] t3404: avoid losing exit status with focus on `git
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

