Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FAB1D7E3D
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315131; cv=none; b=Qd6fq1aGaPrNiJm6hef4nIiznFZ4HH3FypmqDzREf+leGRep7L8WExRaJXg3jaZR+0SiIDKgiLgAC11+H0/BdZ3V1BuwQlQEglPqY/iLCz5V+Qe7UrxycngyoIux8KBaUBhndxzniRYX1rtKWFrerGShTDsqJMRFM5aH5L4Oeps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315131; c=relaxed/simple;
	bh=QiL+XQMXI9+QVUPG8YvRTi9B+M+EDHuwj+mxNg8SJDo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nf9MHDjFAaISHnm3MBgBTEWoL6mbobXf/VUin7aDOJsukmKnI9k9pPKXsXtnZOOEmUySgTcuEaAnk/qxj6R9zRGJq8gsgJjUfwB9SMhmM0pzDaGwEZIDbwadqH5qY7AyWQ6K17qJSM7NuFvz3Za6YnDSQSTJ0+tOvPnH0iJ4+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2qDZ4Bc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2qDZ4Bc"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a994c322aefso247285066b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728315128; x=1728919928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=V2qDZ4BczSileGDl+/khhTxEvaUVn6TO4Ok8j7ixbFI/hsuzX8ctMaqXw5Lqna5ZXS
         yG8RN80lkPad1gpgLvxTb788On65lZoutfi6Zv3+Yv9ideDVMB+guqNqMBglL2QX1ghV
         kmZa+gY7fxzqBTkaE78xnjGvZ9v6DrR926zgQqNZAxy4im2k8HKEs7zal24Dair3vDDd
         o2fQS7AtRTAQtgI9dfE4hXi+N0V+wqRdaQlWyBFai00LyAYuOcE5x14sW7LOK24jHBRb
         ZmJJ4VAu5pxchqh2EmaQjwmRmohkdsUbpyaRd+Ob4rY9kpdG2rKmws/vYzYBhAVJVor7
         8QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315128; x=1728919928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=uVWDIwTZDumHtjClY67OFsNHFjj5J79yKs/X0Z9+CmUIdVBPAspcf5F6/bV284URB7
         jkVgM0r105p0D2nV5L4NFudWzqpOvl5XNgDELbpCj9EhaDXHl0ES33SxIF1bXGQW2hlY
         mVOiE+xiShkJqNnSFHSRMlbh2z5+AOScj4jIJIirtFNikOwzqj0EEK//UCfCpoh5WFuZ
         2yrY0Cp9jXFXg4ySpqyQ7/Q0OtuJPza1fyCWWIt3xYEissI+8+YqhvwTaWf3lPevrFOE
         sLTM4tQAuDDH2Hweaf8AQe8Hy1A46Y/fhLSR/IVV4/Tg4BKOubvg0yVt8LwMNV7E+C5H
         Hkbw==
X-Gm-Message-State: AOJu0Ywqsohuy8IBGmNzeYUI6xvKDIbS5MU1aA3PXXU0VhVilaNuGHIM
	UE/QeVg9hyxzTEtuYtQO8n4hwRl6Ih72vjLrqVRQ1X3nxVwHpPa66gcMag==
X-Google-Smtp-Source: AGHT+IEMeU1HBEa8I2WhX4iW2t4DXFyFedetBjkKuffZKr25LugggkX1FZ1mFYQTs9OjeR9ixdrpIg==
X-Received: by 2002:a17:906:ee82:b0:a8d:2281:94d9 with SMTP id a640c23a62f3a-a990a21d61emr1922861866b.23.1728315127745;
        Mon, 07 Oct 2024 08:32:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5d0a32sm399605266b.19.2024.10.07.08.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:32:07 -0700 (PDT)
Message-Id: <e2cae7f3a510027864303fe91dcf447f63eb0873.1728315124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v7.git.git.1728315124.gitgitgadget@gmail.com>
References: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
	<pull.1805.v7.git.git.1728315124.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 15:32:03 +0000
Subject: [PATCH v7 2/2] t3404: replace test with test_line_count()
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
    Phillip Wood <phillip.wood123@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
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
