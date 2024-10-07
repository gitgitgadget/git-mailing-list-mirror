Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B8E170A3E
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296538; cv=none; b=JI4TNIXpgzkW1ypaXAbyVVSbXz4Cs/AmsWGoOjKSTk0YSHElWuU4Sqav0R88inWk8VOO2S2T7fFSCLJDiHSz3BvO4RM6CGAgws2eoxmT3Iv8qJLYewuCy/GE/i07+eNFzUenSJRO46+p/kuxzD4gVxJFQBq1ZmZL9sTsnPIvAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296538; c=relaxed/simple;
	bh=NnjdcCVLQmzJ0WNGMkp6eCSJRm+BsYlmP5u4ZetoDgE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=htUyvgJTqHWKMFyCk4XQWLL0KGBV8G+Tswmu1vQcB8l+3ly5U+GRD6PQ2LSQNIcb9gLMUILxcwEe1CynzYarlAeXzQmU4ZOsnjOC6PxE4a6TGjhshVgZbfWMoypM+4zCA5SdVra5oE+/K6ISJ45lQcGoamKi+QnyzFD386CvdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6tigibK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6tigibK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so650984866b.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728296534; x=1728901334; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctN3kFXtEab/9LDOkVLTIjtt6yFxxpUk12K9MVkmLnA=;
        b=Q6tigibKswm9hHStxYPeZXDk/rXFGsw6gqY/llGBZYjTHYsSyjiWq4Xyz+3PnbBw74
         Qc7DNJjitGf8utF1OyNXyGbh+LQRQKE9Spiek9kXWTD01Dh6xMaLzHsWFzQTyBbdBz1F
         v31uJfHU/lQGwowkzPPpQlILrFqbGEHRUM4PxjrSJfPfmFUQOQcrbomW4vPcNGxPBvTW
         7EsyzEAMZ8ac2LZRg38PZ7Z7gFy+8DEhja1BvinOAXZ7JvNdEkg1E68vEz9XRlJGIg98
         dNhlPOtMLUs/zSGmlf66+10qAAwd12hbccX94xtqQNoN/3FJ9z4otzDEDia78Bi/4pX9
         KFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296534; x=1728901334;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctN3kFXtEab/9LDOkVLTIjtt6yFxxpUk12K9MVkmLnA=;
        b=lIAJ30gM0BGJ4oxeQ27+eZONLSvHSqQwzhTa6C0QK8J+EX92eTRmGwGcjJ7KoGmPnM
         gPvqb/deucCaaKj8EvjF5lD+/9kfSlRyH7VHv+CslDOcq7ubXsp/ykrGl0w7XW+a6lm4
         GPKeKD8hr59a8wLoAC2y0pHqC/Ge0XqXyMNE/8knqEUw4KveTcphu8WZFvxq4XL682cj
         mC6dWlxd/0ZTNjp/mXkjlGw7nM40XlKUnJSb8oTtq48pZCVu9zxOGqPbAVLVQA6SRpED
         rh6KKjVnrVmhoqWMETW9UVv5+mFhlmhc3+x1DUjcu44q/S5nOqMPpljtb8XYk3HEE87N
         Je8Q==
X-Gm-Message-State: AOJu0YzevKDq8B8PM2+deLreVLbp/st0bht9YABzlJ5L1o4uJBjzdzNP
	y5cMFsFBZAPIbTUQsAEe2A2L6SVfFuJC3ANw0JZG953IxYm7SHU8HnuYjw==
X-Google-Smtp-Source: AGHT+IHciFk6wB9sdW/JvxBLK4otVl2zRDKoKjeOB41BgAip5dQUGVl4kkAAAysvgRWQ+rW5FvrXtg==
X-Received: by 2002:a17:907:7f89:b0:a99:435c:89f2 with SMTP id a640c23a62f3a-a99435c8ce0mr667202266b.63.1728296534405;
        Mon, 07 Oct 2024 03:22:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e7d4d9csm363722566b.182.2024.10.07.03.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:22:14 -0700 (PDT)
Message-Id: <864b00997b725dbd7f3bea06391570df7d428f3b.1728296531.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
References: <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
	<pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 10:22:11 +0000
Subject: [PATCH v4 2/2] [Outreachy][Patch v1] t3404: employing
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
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Refactor t3404 to replace instances of `test` with `test_line_count()`
for checking line counts. This improves readability and aligns with Git's
current test practices.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>

removed test
---
 t/t3404-rebase-interactive.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a65783c47..81f984f4cf5 100755
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
