Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127A1E7C10
	for <git@vger.kernel.org>; Sat, 19 Jul 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752928121; cv=none; b=Ff0s5jh+DfDDKF+4OYJYgobGjP4BuY09YoPrWnejZEFllTS1QMMRoDJLlvnm/Jce0yakM3Zby82U845TwSzmUYOmqh6svq9JjY01+DuH9/VxnVdpflapC1JzSr0HVVtqUmzYqxBmbmfK7OORTyubtW2sc9OjruRoJJMyLTblFZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752928121; c=relaxed/simple;
	bh=2ExSVu7VDjeK2DmOHAb5SzLkHps9OQmoJSCzGOPUmb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NhlhWGH3NQ9gY/V+g+0XYrXK892pGpG7yxDdKxjdwdGkVREGjt+Lcf9LkIKMLuKI2f5i563iMcTwjQ10EHG4QnTrRNdN1DURPJ5KY5k7kobeB3FXefQzMDvtc39/9WYXhrA4E38B7MjYLANiaBpF5tUmGPqqBejxxfCfsV8DJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK2LPbMj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK2LPbMj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-454f428038eso24136605e9.2
        for <git@vger.kernel.org>; Sat, 19 Jul 2025 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752928118; x=1753532918; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=kK2LPbMjrxlPte5AS43iocuZMk8LFr+C8Lwd7pSJK6mS7+OPps4cIlA0xF5BTQTaU0
         YnLHfnAw+N9+6zLCpCGT8IH26YqIZpA0nxlb7lBkTgbZGwEnbfOP3dmBLCgH0whVinbi
         K7bMJB+5UDQLoNy5qOUKBYf7nDRqYbdsU6HBXPT08RRw54jcnAperKzh9WrRxNU1r3j1
         LsPvtoGIPjhT/0mn3gMKQ/+K/yLHrwsiy3YC5aaNVCzibEa8BGuAFe1rMfgJFdICD8le
         gmYK4kiLMGDHba2ScC+C/kfZtDTeomdp2CUPq3TqgKH9zle4bQXqdD3vdkErsYdzJREH
         So3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752928118; x=1753532918;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=aEkAtZPw/S0G0yLqI+DSLxvL+bPhuyYpvPosrN2EYzftidkgDnXwG1qe1IsJ8lDnMX
         o2Px/lbGQpEu3+HaALr/fKLmcSkUkTw34iLzeFpkA5zfUUlDA5cUxH8Uf8bE2s+lnN2J
         7lUwjUs1YRuh9l1zMUpuThxyPFyu4BJrLu1tzET7cOwnmbpGymjKKRpwnH8fbv2G4Pxm
         9MdA7oyRUktb7RTN08Hj8jcYubfMIGpSFwvhSpMx0DyJyRXs0mDjeCE4SBgTcvrT6DWH
         CrdT2S9SboLtJbFgs/6DpdOjYvjWAlo+veDzJFZ9a4/slTul8CbT4/hEiWe+5kBRQg/y
         tMCg==
X-Gm-Message-State: AOJu0YxYIwZSH53+ySQ0u3NkM+lagLDFxTrdujRyHWFajjYhpN1OcWFx
	sKrQBYoD+myHPczYenEbA7TH2DVkYKnneu+MlFAxpqPJGUI0BGAmzMB+ewDjfg==
X-Gm-Gg: ASbGncvYDa+sKkl1aw4FPrvWqWfTUaPShqc0dt6SVjpU/YL7OMZyqLkwW5KdqjevxvR
	vb4LUrdu+o9zjigzWTsWbjSTnBQNd+frtCCilUQ4oAXh6yGjksgTGP3NM5NR/jvof66DZ/9R69j
	XNxLEFiaVWYQLyM0IySe633FvwswiCalpI9GHnYirbMpW7OyARFalTWCyJI7jadt+ahAa5bMYml
	FArAdxcx/C9lduWklsWpZEM6NQZeczieM91/7p9MCmtL8fhmjogTlEis6UJv6VScrhTQUoOBw23
	w4ln9sU2Vze1SuGe6Z9VAAkE+XyEuu1xWsGv8T+teijBVYnsPuQM4rbWkKbNiaeaG6lZ0AGMHfl
	eQ9sXlIDvhYfPOjm/ZAqvQII=
X-Google-Smtp-Source: AGHT+IEE13faAQTdyc7/jHJzlaMuKYa3c5L/pRXYIRku3aRnLnrOSU8SpBW3GQxHujCrU3To2IwDog==
X-Received: by 2002:a05:6000:1a85:b0:3a5:2ec5:35a9 with SMTP id ffacd0b85a97d-3b60e4be76amr12533110f8f.3.1752928117336;
        Sat, 19 Jul 2025 05:28:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca24219sm4488427f8f.15.2025.07.19.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 05:28:36 -0700 (PDT)
Message-Id: <feace2d3676a03d720e9c85b7842f47446e9462e.1752928113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
References: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
	<pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Jul 2025 12:28:31 +0000
Subject: [PATCH v4 2/4] t: use test_config in t4055
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

