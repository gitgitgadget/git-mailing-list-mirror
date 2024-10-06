Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCC189B81
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230776; cv=none; b=E6A4r+vXLLpDWj6WKOgelogsLem+6WNnwYelPnKUaX3LZeYFymRSEu67WSPJbAv1vFLX5jF+/Bs/T+z8lOysjNi2wBzxgHdHh7G468OJ8gjjmW8/9X6vhHpCyLklqcX2guitakBp5PM5CW0P4w3KMPSq7WsjBr6hklbMT2CatWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230776; c=relaxed/simple;
	bh=PUEIXCF3DtANtaoHxw0rA8VJ/DijqpHQV5On1NkaGH8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WgI+s5MFAh3cppFjAbNKLYuYYJ14If0xyyx71fBq1L3YwGDt3mQxXGZtJiCqzKVijX1Rbfvg8etNWKX0WHvrSulIbPA7sKrEwXL1LaYVa/6Fjh0royo9l4BbutJpLy9nP3L//HLQeIPJSo88I+mNHIIOyKA5rRQY9aZujW9f4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsVhH0ot; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsVhH0ot"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso621601566b.3
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728230772; x=1728835572; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaeFS5oWtug1ZZsawHwx7IKifPdFVJcnzlM4ZYbdU0M=;
        b=QsVhH0otfIPojuShDiL0uApneBp+yW1tUbebZ3g4LWP+mgJWXYNm03RRvlRzvfbWpL
         gVZnP78L0pxpLubNkfj4nnePuLn/P28hgZrSl4xXBu9113GP6nUskKPh4fcN6ZlnSpzX
         A69JEWNRwkQsK9RLtLViACUsI+lO5s6jgIcasmCt+Lu9C/wsID1GFRReeuvEo9irLtY0
         VErz4btqtF6iFu63sxbNPT3iBQzB0B5nHKF0719XM6+efIuedmW+yDH4ceis3FsuZ7zH
         AuaWgc60RW0eUJuPoGxvmRB9NJnsyT0Ep+589impxoraCUY79T8YpVlVCfbjI3f/Mfha
         t7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728230772; x=1728835572;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaeFS5oWtug1ZZsawHwx7IKifPdFVJcnzlM4ZYbdU0M=;
        b=E+Ws0EpUocJGYafVzJ5bHuWFm2hw4JmTXdUVa3sBIfBAZamSAwIpfpo13Tj7cAJ3dZ
         LJnp1GIadSFnqaQsWxTDF527DNbMvv0RvUwLJMnc9Bxur0GyLo2+hwDpvA5q5hN0cqxs
         xRQ6thf3/hqxdDe939PQoYRDxr9hLTALyGcUFOadr7FBx54uyISXF2Y+pjh9OyeY0zPB
         p8lBwyMORg3dGKR1ji65DTtIfv1Nk0ISq+zmaXU1liTLWTd2FILGHSA5TzXYCqQfWSvw
         hZ4fzSXRzXNnG792yBX8ykjNtvtyVb7XSgpLiX576KmB3uXZ+Unu0A5YRJLa6Qa5MIBY
         UJLw==
X-Gm-Message-State: AOJu0YxH5VsbysCWM32AjQQoaxUqJB8VrEyx3t5U886IhyIzzNRrn6W3
	hjvZKB6mAB3wzxxk90x95I+f/yjF/VLjYUolGPUPxhGFdcr7WJ8WXzcmCw==
X-Google-Smtp-Source: AGHT+IHnF7x7MKxuQCSrT6AKKeTY15rO7URBGrHGWF3cOcPuCDsh3vhR6YnVTZ8gSAauas35+aYrEA==
X-Received: by 2002:a17:907:747:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a991bd71c59mr1026927266b.29.1728230771577;
        Sun, 06 Oct 2024 09:06:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a994ae7d1d1sm114165966b.104.2024.10.06.09.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:06:11 -0700 (PDT)
Message-Id: <37b1411ee2c420f1a8578d27a2f7d54ccd3f329f.1728230769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
	<pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 16:06:09 +0000
Subject: [PATCH v3 2/2] [Outreachy][Patch v1] t3404: employing
 test_line_count() to replace test
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

Refactor t3404 to replace instances of `test` with `test_line_count()`
for checking line counts. This improves readability and aligns with Git's
current test practices.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t3404-rebase-interactive.sh | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a65783c47..19390eaf331 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
 	test_cmp expect2 file1 &&
 	test "$(git diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
+	grep -v "^#" < .git/rebase-merge/done > actual &&
+	test_line_count = 4 actual &&
 	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
 '
 
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
@@ -436,8 +437,8 @@ test_expect_success 'commit message used after conflict' '
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
@@ -456,8 +457,8 @@ test_expect_success 'commit message retained after conflict' '
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
@@ -501,8 +502,8 @@ test_expect_success 'squash ignores comments' '
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
@@ -519,8 +520,8 @@ test_expect_success 'squash ignores blank lines' '
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
