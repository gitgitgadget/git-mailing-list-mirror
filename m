Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F112EBE7
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128494; cv=none; b=HVZl5HTLZu8hmkeG3deVCfw9LnAzDnABp3twzW8Oty9uYoP7UioUYdpUcOBFsy2bYpw67IOjk7nPW5TBTHfrQFP/neEC+Sq1rw7BljxdYhj0fBr8t9NzSIHDo0g814cuypTluJE1Zg1wd5ExF16yD3q8BN8V/awT923P2hHL3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128494; c=relaxed/simple;
	bh=2ExSVu7VDjeK2DmOHAb5SzLkHps9OQmoJSCzGOPUmb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NnFM6LOa6GbNvIs6khbGfSmowziGNdEQ1NK/wygDEx7K8GLQ+DihXtAyCGzko1PzOUfVC8F2ahE3Uj5Ex2bm292MOBFA2hAJijfeag1SsOlFNKkuLOdjiJyIfnB3zKawMnEZVwKX+MERq0cGeqc2u6IDhjDjFMkyqyGbQti0Pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu2apcWt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu2apcWt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453647147c6so34013215e9.2
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751128491; x=1751733291; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=Cu2apcWtDG0f2Ma5qVgEVfAnrbyt+mY59sq4CLqUS5V00A7PCUTFOQ65caDCeZcePA
         dNLUdwLcXwLjhIXYmX1e1SNtvDxKYcRpHA9vY5d84AoR74pOl6V/2QUoLwb6zHl2ttq3
         ahy0wghA7GqsxezaBJVPllNxYXR4WN15xnt2Nf36h0LY0sSds22aI7SeZe4XlKvHIXJn
         /r5Rv2EUHX4rKRtk7N8ZkuZBCk/GtFfM29rv/sdXJjsO2Ve1vM6/ky18MxFuTl7InR9j
         Qct+8USFuiQXT017WoDlz0gh8fDXARtosf0zQXP9tAtSySfI72CTb1OgYOXgUTiCURbs
         levQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128491; x=1751733291;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=nQKsNwsPD+1JBzk/C7uGwBEzg0WW9fMGVphbEflrPsdYKdUIvGeSeuRrnMPnB0bbdw
         +NjcyUG9hKKFV3I3bEsTKnpwN1wGNnK72BrdTo9M3zfmhNL6wIu6rSssFINawxTnhohB
         OHHVczar6FEFUSy/Hjt4Bk3aOaUCVowoxAemuyF1cZzfl1qoYJ+6jygtCqTk+LXPYNdH
         T4KgLkbd5Na3wLJu6uULKfDSDcus9NIpjt4i7mBHKcxcUmQ/xTDL2IC17nMr8XZpDDqs
         pmJ99lOr2GM8aXVYTZkdWzIskWV5CqXyCbRcb9eT4Fk23cX0kmUHehtOpDsAhlGk/vAN
         MUmw==
X-Gm-Message-State: AOJu0Yxt/IGGGIc6O+uhfeM3p8qOPsRn4vuTtzji73puU4EMu9enJbfU
	zXJs/8bGz9oBEwB7S6r3dqCVjKq7DZbvOvVhPgW+exDUl4za6C4VvE7f7srPaA==
X-Gm-Gg: ASbGnct17VYT5JIigR2vBy9NaT79lgrIhwOv7VO9JEZk0skMcXotSiHXxhFhRY/sDhY
	mJguLElacvJUnnRdaDZJt0evK2OPoxr+TDkuqBFSq1ZsRC1KN+B++a02ZX9pmqUMiSJWq6nWW22
	jKxQID1vHrXsdGvnaVwDItIaJQ2y+NL3XgP91WydYxV7sLRGyDsku7JWfmnpN7pqVQGuYFE8fOv
	AAuh85pBuzUcyzyRvdO8PtbB6A6Fo2Lv17WeVTkKwQS/2FWe06NPqHb2pQnWBFWRoqBuDqRjNa0
	8uqhNVPQLPqgCo6bJU6+JCha+mEWRnrO7mRdxVWWH/YpYs8PTgRU4+KxaH3xtCbetCZRgZgAWw=
	=
X-Google-Smtp-Source: AGHT+IFLFpBlG63KRxDN05IVFArUtI1vxAxSGnK/N+rCer8i3HkYHRSesZ0b+ngoCbpKm5+Ehzy+0w==
X-Received: by 2002:a05:600c:1c8b:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-453917ee4afmr65815785e9.4.1751128490952;
        Sat, 28 Jun 2025 09:34:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453822c6b9fsm113764065e9.0.2025.06.28.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:34:50 -0700 (PDT)
Message-Id: <e5c40d37750fe7effa95e8bf2cc24945150364d7.1751128487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Jun 2025 16:34:44 +0000
Subject: [PATCH v3 2/4] test: use "test_config"
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

Use the modern "test_config" test utility instead of manual"git config"
as the former provides clean up on test completion.

This is a prerequisite to the commits that follow which add to this test
file.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 t/t4055-diff-context.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index c66f966a3ab3..1384a8195705 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -47,43 +47,43 @@ test_expect_success 'the default number of context lines is 3' '
 test_expect_success 'diff.context honored by "log"' '
 	git log -1 -p >output &&
 	test_grep ! firstline output &&
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git log -1 -p >output &&
 	test_grep "^ firstline" output
 '
 
 test_expect_success 'The -U option overrides diff.context' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git log -U4 -1 >output &&
 	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'diff.context honored by "diff"' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git diff >output &&
 	test_grep "^ firstline" output
 '
 
 test_expect_success 'plumbing not affected' '
-	git config diff.context 8 &&
+	test_config diff.context 8 &&
 	git diff-files -p >output &&
 	test_grep ! "^ firstline" output
 '
 
 test_expect_success 'non-integer config parsing' '
-	git config diff.context no &&
+	test_config diff.context no &&
 	test_must_fail git diff 2>output &&
 	test_grep "bad numeric config value" output
 '
 
 test_expect_success 'negative integer config parsing' '
-	git config diff.context -1 &&
+	test_config diff.context -1 &&
 	test_must_fail git diff 2>output &&
 	test_grep "bad config variable" output
 '
 
 test_expect_success '-U0 is valid, so is diff.context=0' '
-	git config diff.context 0 &&
+	test_config diff.context 0 &&
 	git diff >output &&
 	test_grep "^-ADDED" output &&
 	test_grep "^+MODIFIED" output
-- 
gitgitgadget

