Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4019C555
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774581; cv=none; b=hLveXtuViM40DDZvnUELNUMEsFLIKwEBukJym5x+uqR3UHM72GT5Asw5gAdGAnBfySOnw5xMQuuiC6HaK/eI2ctKrHDB0OzEYqVjAy+phhVck2r8ovZZ9K/1/65WLticKe60EiBdICk0XCX10DLk6TXHWvNwnjH/nCJL+srUK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774581; c=relaxed/simple;
	bh=QiL+XQMXI9+QVUPG8YvRTi9B+M+EDHuwj+mxNg8SJDo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bddcNSoTMM/lkWYJedlh+8/B+tw4YKi+DZAyABmkn56+doLkIxo5o2ryMdP2elI9u42QbfBkezLu2++kSzgXtr8VaYXLW3kHeoiYfE20Hfi4cFmJJxhEvvxzktGESDtxCzyF67eAatDyF6Fag53gAMTQg1JML/PhsTaRbTCs/6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvg1OwVz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvg1OwVz"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99f1fd20c4so101207666b.0
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728774577; x=1729379377; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=Gvg1OwVzCgZgRR5PuLk2LgsEa5x6ANhbi9JNpGTSyBiNfl4GOoZ1KJF9le3eVG246Q
         cbxjhs+PBGNKRXl397Tpp8bAJXgLcwND7b6Lztx0EoBp8eC2o5xgZom3IIxudxylvv/H
         3C1b8i6M01XKU7eR+kMz67qCIVpRIkRcUyQC7TjhGAOINqVPsf0CVxP9TGG+jEMBVnxa
         JRzGWL45xONi0O0cbJY7bx+60CBWKyIdrWBiYVljel5ejpDmGGhvnKP2eHwnTRJ1VEAn
         Djh2CSwtP7MUM+iDE0Gy7NC+OUQzCcyDFMDj+huDFciEzgpYOcU2eu21rr+QuAy7TbuX
         F8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728774577; x=1729379377;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=kOmlhNKTKXh3C5g/xM80DH9o2TQU1/zje0SSHi//Ytv+vaLyPUSOpDSFq9MaDnzgOb
         EgQYmqK+xLX8j5qGfn2cOWs398wRWQPRk+OflGTRciL9L3DDdtDdBvEIHBojUJQti9Jd
         e8QOD4IsB0daJbAgm713eUN9B+xw2VGCjjI9qsIQZwh6ZCkniUbaMH/zOmZwUnwKzbMr
         6S1LJEeia5Z1gbHmaBsOCaL9y7abUd9ska2wH6ElcAfNj6I+P1diNV79APsEIKn3ubMK
         OacciIicNGP5WkJu859NKqYNiLwmWuQgiikw0ZqlOZCZSqFLfAS1ttq8U4sUJq7tlEMh
         H4FQ==
X-Gm-Message-State: AOJu0YxPdEVWVpGy/UBKN7XQt0onVwzPPdKcvsvE5BNyrHPxvHoMdu1M
	VX5/KcYb7PHUX9RDSEnEH9njhK/7GZHSgljB1tdTBTzwuUWdb8tOIXasBw==
X-Google-Smtp-Source: AGHT+IEMUPSLSjQexGECRoJc57B5sr90scQcU0ZyJNiQDEQ3JD7gpk+9mwkJ/kHgO1LblyHvpKwVNQ==
X-Received: by 2002:a17:907:97cb:b0:a99:da6c:f607 with SMTP id a640c23a62f3a-a99da6cf789mr395295766b.44.1728774576930;
        Sat, 12 Oct 2024 16:09:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f8dbd6d0sm63434166b.200.2024.10.12.16.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:09:36 -0700 (PDT)
Message-Id: <e2cae7f3a510027864303fe91dcf447f63eb0873.1728774574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 23:09:33 +0000
Subject: [PATCH 2/3] t3404: replace test with test_line_count()
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

Refactor t3404 to replace instances of `test` with `test_line_count()`
for checking line counts. This improves readability and aligns with Git's
current test practices.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t3404-rebase-interactive.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a65783c47..2ab660ef30f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -281,8 +281,9 @@ test_expect_success 'stop on conflicting pick' '
 	test_cmp expect2 file1 &&
 	test "$(git diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
-	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
+	grep -v "^#" <.git/rebase-merge/done >actual &&
+	test_line_count = 4 actual &&
+	test 0 = $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)
 '
 
 test_expect_success 'show conflicted patch' '
@@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up editor once' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count
+	grep ONCE output >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'multi-fixup does not fire up editor' '
@@ -416,8 +417,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep NEVER output | wc -l) &&
-	test 0 = $count &&
+	! grep NEVER output &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
@@ -436,8 +436,8 @@ test_expect_success 'commit message used after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D conflict-fixup
 '
@@ -456,8 +456,8 @@ test_expect_success 'commit message retained after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep TWICE output | wc -l) &&
-	test 2 = $count &&
+	grep TWICE output >actual &&
+	test_line_count = 2 actual &&
 	git checkout @{-1} &&
 	git branch -D conflict-squash
 '
@@ -501,8 +501,8 @@ test_expect_success 'squash ignores comments' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D skip-comments
 '
@@ -519,8 +519,8 @@ test_expect_success 'squash ignores blank lines' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D skip-blank-lines
 '
-- 
gitgitgadget

