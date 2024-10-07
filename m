Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D91D1E60
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728299473; cv=none; b=K3q9oUJNYWjvlMBP4ku90j3nmwm0DDW4YXn5CvHKQ5eRw3NUxOyhqJS5svDycU4EhnL7SxscqrNGQAuDMFyHLa95XBYRcM63Km0BeG/KZixJGNhAMxhWkEiD3780LC+EbaaslH108pLHHxhBEqEe6OHkWLP/f4xHbV/VRKJkfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728299473; c=relaxed/simple;
	bh=QiL+XQMXI9+QVUPG8YvRTi9B+M+EDHuwj+mxNg8SJDo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Wt1x16MR4DrHMcKYwYE4VVBCHm1z+jGothoJhmzh0CYsJ5FQHTxYaWSwY1ixOdQ0HpFW/D7202D7vnko+5HbjmwycCQLsxoFClVjDbHDqugpa0KoVE22HZMZKEiOr9t2aGQTCMPeNEenzvP7rK62wanjvJYvM9AZBzuOvH3rWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMKP2hKX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMKP2hKX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2facaa16826so36783531fa.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728299469; x=1728904269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=CMKP2hKXVdWb7elskDdspse9AS/ejiValfDCttxf7Ubar3mrYco4y6HKt1SaTPJgrK
         IDyIchlU63IaLy38xvSE3Jj/JvQ5ohq5xu7t1MErJlxd2ZQu4Wl8+f+8OiGBcbDQPgF+
         mh00xMieasF9cIgvFhFaEXReVq9w5oR/ePSNmO0fqCAGpLta6SjFNPtP6khvVk1vB0Eb
         Vyg2kVub8opFtYLlSeY5qG829PQCe2UquQT9wiL4a3tMT2FBzOUHvQ899XpIl4o2YAnP
         rB17E0o4KFHmm55VeKnDrLPz1zzxCwPdA1F6wwwIz6iKwWbj5xNvUj9KOHJhCf8Kl/sV
         fjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728299469; x=1728904269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2i3Q1aTCZLQZNTzPO6oISTv/cdcApWY4GY97NPGCzY=;
        b=bmfEgCmdPqT6ymdRB7/ovilGq9Gu2X+tWttsPgiILFR+UVwRk3Oh1p9/QIS/Oh4MTj
         q9z069X804UjRCLo7+JPRMhQR3kI3+0TdZhVJAzxtdC15W6/JKGV0OawkT1V9eNCTL7e
         rSadrm9YDPk70jrNHigBB9e3iAM4uIfZBbtccgMbV26dR0l9J3ZdK3eJB1D4x1OpMTlJ
         FBI4ZXm0koFyNiFk1HxSpfB1xWpYIgxlhTl0s5Tjoei6Q4o5P/xCoFHLp1gWF+mUYSZT
         3ZMIy0tcvMZK+ks5fP35ZlDwGt0G/Q/6582VFMhZtCkmHlQVhfRHgWpmGcYIlY655JjN
         Y4+A==
X-Gm-Message-State: AOJu0Yz+QoG1RKf8KncDpXb3n9EonAo2+1eTTnrFZ98/Pfg0Uwg9syid
	rALf0DDa/VKUaGDy9UeCySA8cY/bzDx8XKdxqqXIc447/kerEhSAGoEW6g==
X-Google-Smtp-Source: AGHT+IElH9o1pmICQ5Dr8MyjGYXDC0p+yOV87Jo0QY+Mo7zLY3XZ98q3YdJJqPF14KN/YypnMCV98w==
X-Received: by 2002:a05:651c:1a0a:b0:2f9:ce91:dea9 with SMTP id 38308e7fff4ca-2faf3d75c6cmr43133551fa.32.1728299468671;
        Mon, 07 Oct 2024 04:11:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd3a5sm3051377a12.41.2024.10.07.04.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:11:08 -0700 (PDT)
Message-Id: <b3d3deced25f038defe6afe7d474350464328299.1728299466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
References: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
	<pull.1805.v6.git.git.1728299466.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 11:11:06 +0000
Subject: [PATCH v6 2/2] t3404: employing test_line_count() to replace test
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
