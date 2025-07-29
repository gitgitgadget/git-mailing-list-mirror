Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473F1F874F
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 07:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753772519; cv=none; b=COlwZAJmWZCcQjlWboefdGQAbToCYhCJGAZAEVtNmH0NhLbccGPOy1Nz1pRfbYTutHDkarevNkd9lMOPX49oTini+SlgRTenM2tzpViuLbLkBad0wenxk8TljQ9/Q9EuCWBYc3HvGlHemRS8QmFp5n8BQed7oRqad3fPZ+5gEPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753772519; c=relaxed/simple;
	bh=2ExSVu7VDjeK2DmOHAb5SzLkHps9OQmoJSCzGOPUmb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PJaPfVEtzZdpwhe1a4H4pk0XpKagPLrBJSSXnenLsmSk9h/cwimHXgmVjhejj2848cC+c0z5uHQMl/jL5oAIMe3d5rkqHQ9x3sz4zGSDcs5rd4U1OQ4PZmHYNnMJAUnoa0GkGzAP3qSm2gK/ekW4N0iwRECcd31dy26RdYc3GL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d51eR0a6; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d51eR0a6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b77b8750acso423303f8f.0
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 00:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753772516; x=1754377316; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=d51eR0a6xQzybHhpacHsXgmblHhy+2/EJwlKcVlZRIvHFWQikI+T5EFbu30DWUjQe3
         ocoSxm/E3oZP0QHdwyR7MEdumkxt11kk3hKh2F2IV9+6XCCDElBitOIFnxQnljOn2Aoo
         3ahEOKpJnIFmodGu1E0JCYYuQO3XWY7J762/ZSDpbODAHlvMRdjo+M8DkhzFAim6OXHD
         ckBpMkg5oqMd4ir++LqadI6Ip4dYTaaLijI8HlnLHy756JUWsunH1bM23u0m9a3ZMgIs
         KX3QHjxkmRZsMAzXjpW9Wtqpx17H0uqkTfGmQvcyfJK29JaloOA5lKmjsDlMvseN8vTG
         y1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753772516; x=1754377316;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Yk8Dd0F5Rku8hhBmi11OTSXnI6VQo1v9qpGzLMsS34=;
        b=PlyYRry1iFQaCECY1NKpbfcwP+7liESL7/RVYrJBV0DKsbvvIjJpjWXjUgDbFDsosC
         Yqdo4uwK3cvmUU5n3cK1HsYDNnSwaQ7Wr7SS6YwjYtFzR9aQlWidCVpsW5SSMkwhDDqE
         bwFc5gf7CUcUz7tT/LvM8X8subUWmlV3ifo79z5/SivGuvKrTZ91TkI9rbVgf4+fenO3
         e4w5ax4FOAuNDe9qNwmXJu+qa9eA7hNVExm3PmRLMu2vfwZqpNKMY+kXiq15au5Afa+o
         KSfTLtdgOo6Fya23vqnlcvIWz1CyuEuAWuL6eUyPA2kUnW8oBu3OAWwAUK+idkww4VDg
         t3nQ==
X-Gm-Message-State: AOJu0YytN8s6PyaDVqWTi1o4e2quvqgU3cL2C4D4jtBSQYpxmS++JQ+G
	XtjFZGIVPAv0lFYxphjjM4xgqwF9kKWQcNHvEB35HZscZPdFtN5Awr0sjDlfvw==
X-Gm-Gg: ASbGncsCZzuiQVhfdqJURBqMqyd6f0Lj2RC8iLYjO/cR9hKD0ADQak5Z2jrkOlPgB/r
	tu2REevV5A8wCbdnpgskqY+Auw6w6xLDsOZxh5yWDkS42YYKLly4dAfcBis2eShuh1xbcSexYk+
	JVeFfMvT88/ybHx6cEa5g6pRFcvyD+4RHZfiV1j6Z7nxvgPOm3vEod0vxk6pV2CH5Vddce64uiP
	hGsiwjq1syNaJb4h1NvGrPxc5gCCTzy9JNzsFymqpGMUgZP3MQh7BNrC0hjBVI0TTCs/2jCmogK
	TIMWyIfDQYJIvnkwOngmz77y8ATNN9sU1+KGS9kf+FGFsDUb9CnzR9vd34/NK9UvTBSARKwJLuI
	hrbJ+A72USF2xRws66xtlpvU=
X-Google-Smtp-Source: AGHT+IEQO/slBEFOy5kcCvt7dob8LffFSxhV4/OyPwJPBUXFUUb2OuFdBOZcDnoZUHnQHmDRFUTqtQ==
X-Received: by 2002:a05:6000:1acd:b0:3b7:8735:945d with SMTP id ffacd0b85a97d-3b78e50f459mr1674322f8f.20.1753772515380;
        Tue, 29 Jul 2025 00:01:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b783454d65sm8227641f8f.1.2025.07.29.00.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 00:01:55 -0700 (PDT)
Message-Id: <feace2d3676a03d720e9c85b7842f47446e9462e.1753772511.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
	<pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 29 Jul 2025 07:01:49 +0000
Subject: [PATCH v5 2/4] t: use test_config in t4055
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

