Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A6D31159C
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176330; cv=none; b=Cc34YSJHdb0+vqnicFKBAzxbsaPNp1Q6sAIMTkz9wgkQ9Rfb/Cdr13gOBOncVL5Lule+m089YeMwpXiMygdyPvGzujCXnwo8I4ABrof0uAApMVwX21K6QYoDeu0Equy90IBCOM0vXYAKfS+/HSM+++wlw2JM7BbmaZf8cPghI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176330; c=relaxed/simple;
	bh=DAAJSu0qJYVXE+yjhumi0dafgAUGnpOM+109Yx6MjwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMeSJFQUFPfsqCvVBOsCfNxY/XpvDgfTHkWxKjJGbxVl6+TVBVLhBXNW8hGhMn6c5+wMIyAyPlT7iNTkB/lW5mQa03LBRno5FgVa/dbLPl8FvLeJ5S6cWJ4NwMQi44lVwXBVPWcTh2rFvmPOpEufebx8R9siP4W7bYkapZmhIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/uTOigh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/uTOigh"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82cd70febc7so3777006b3a.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176327; x=1776781127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbO8v+wLlfuwy3EtpWDotEO5LW3iNHgx4k2E10LZoOw=;
        b=o/uTOighMUcQzySZuLeanlwsmoK7SVB2fGivp8po7vfQDV00U+n36JPNJngCE8Lc3k
         lnyyF6QCGvc6rWdUIHs/TBKymsB0CFc6jyIobl+JlAG8QEWSo03pse56RYvB6X72RrH9
         kgkJr9d0+4+C3SC2H8T3bQbgB1Yo2S0SgQnh6m6T/HYCryJNDki5em71hlaioqsXR+oZ
         rMHvwY2Nqx7FvcpOLh76npEDIwxeqGoAmtL9borRYzpD+l9fIx9VX2bwBGzTazYxGDQ4
         Xos87peYiLOcZdT62r/htnR70mHcnsh2vlUJq30l4D6UT5PqA5pusOAKI98qO4ut/vR1
         OZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176327; x=1776781127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbO8v+wLlfuwy3EtpWDotEO5LW3iNHgx4k2E10LZoOw=;
        b=nNiWGKMRYDQuFYMOrh2BOIrz98djJSKdSoILNYBXmBJJKJm9ccfMR9ZScSTE6leu55
         6rLEWZ1jecbNjnQ7accbfTWtJCGMmShJwDi/aMyv6hKcUcUAgpTtGTb5SFJMnDBa+XXF
         SD6o1wpgQGuU/9f0niv/ebdyEMcP7ICNaR+m/R119DUpEvD1ia2GBBf92CkqieIHQMdv
         FhnAhSvP/fMevnVGSh1qQ7+++fW3XQugolk19dQ43SWn11GLVKD2QEeMiJ9Sw8N1dbKc
         fRraa9ykVfLnUsUdFePf5XetXPDxLQ3aTS8ROLW1He1+qxkL0OAF1xmuUr6O5NsUrQBN
         gt3A==
X-Gm-Message-State: AOJu0YxgxZ0MPpTkV2BSv+QAsvbQhLwWsewQopWJwwqSc2aK3mVH7zLQ
	aDNq2GWcQDAG/BK7uvMzIrzyLCf7Mh7t835+xoyyPDB3MdKW8RfWadtTXTmXPQ==
X-Gm-Gg: AeBDietzdBTtPhbaG536FfyYQpQEvzC0Sqiyx0lHAPixYIb7LaE3HEXt6v2owoWLFRr
	t4i1KOJJmtgNY22X6HUxzzZYiXAow/bb9qx3mcvu9CSEfWlJVi7tjs6KouuP4N9KPkpEiT2hi4x
	bYnG8oMfu1VsWuXG1I8IFxFcR6oeC1i+HnBfp7mVFGBlc2nuZ7l6FaQ4fsQkChel53uFWVFX1hv
	sZ7/q4Ql9+ISG5vvexStWTAVA9MmNtAH60Dg6DGoKgCIUzEctJuSDyWh+2Pfrp6DSRnn66rA4le
	Ld0k6bK3ZI5gj9RJe7jI2bW2aG7fdgg+tVZQh0GlbcRJGfQcJB6VuuMbiVL9XeK228G5IVw2C2Y
	eRKNiL5vgUtCeK9Ri+PfsDiEgq0Z/cHm6k7Ki7YElWkhMAoXq05qatBSu64EMyozmyh95mjBmCs
	IgOn3NvmcSEf46R4mft8CHqckBtbFvE2sU3pDjb2WKjsNP4GEEMNJjH1iQRtpZqBK5macA3LZVG
	8YIKkG6vVHgsh/Ytvt755uxROT3oi91OE6Nw7FH+ln30ArjtjAJYCZxSlsCZa1emw==
X-Received: by 2002:a05:6a00:bc0b:b0:82c:24d5:21cb with SMTP id d2e1a72fcca58-82f0c1d9baamr15998358b3a.8.1776176327325;
        Tue, 14 Apr 2026 07:18:47 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:79f3:3c56:74cd:64f0:3838:afaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm15145048b3a.7.2026.04.14.07.18.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 07:18:46 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	abdobngad@gmail.com,
	ps@pks.im,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 1/3] t7004: drop hardcoded tag count in invalid name test
Date: Tue, 14 Apr 2026 19:48:26 +0530
Message-ID: <20260414141828.27576-2-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'trying to create a tag with a non-valid name should fail',
checked that exactly one tag existed in the repository before and after
attempting to create invalid tags.

As pointed out by Junio, this makes the test brittle by relying on a
specific global tag count. If future tests are added or removed before
this test, the expected state changes and this test would break for
completely unrelated reasons.

Since we already use 'test_must_fail' to guarantee that the invalid
tags are rejected by Git, counting the tags before and after is redundant.

Drop the 'test_line_count = 1' checks so the test doesn't rely on the
exact number of tags left behind by earlier tests.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index faf7d97fc4..6ca5c75b57 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -191,15 +191,11 @@ test_expect_success 'trying to create a tag with the name of one existing should
 '
 
 test_expect_success 'trying to create a tag with a non-valid name should fail' '
-	git tag -l >actual &&
-	test_line_count = 1 actual &&
 	test_must_fail git tag "" &&
 	test_must_fail git tag .othertag &&
 	test_must_fail git tag "other tag" &&
 	test_must_fail git tag "othertag^" &&
-	test_must_fail git tag "other~tag" &&
-	git tag -l >actual &&
-	test_line_count = 1 actual
+	test_must_fail git tag "other~tag"
 '
 
 test_expect_success 'creating a tag using HEAD directly should succeed' '
-- 
2.51.2

