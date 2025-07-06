Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4501F75A6
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838657; cv=none; b=srpDX6db9bXeaO802ATWCUWMZUbReQpZawgASzZmRr+pcv9IB8xTz8UKmW2fL3vEd6lNScS30w3GRuVpbY3fEF8GsA/nR3VAWdAfM3/ekTPi33Je9G0bHlrz/uoSjbA/TRzvTSRre4Hl5HdQqG0IbJ0PBd74EqGTrqSSL7faRaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838657; c=relaxed/simple;
	bh=lu9jBuDrAKf7yQNNgZInvWV5/bJmdrSlUz/XNKoutMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZuL90c1KhLqaTz7FfhEuVtUpMT7idzvVJy4Rey0Udqfj3gmVb7AYXlXPOGXPy4T+gUrB0QyyI5sR7Nz3vm+GtnBq0TPEySMYefN7l6Gu/67XfuYpk6Nkuje6QodXa6mrnbPadFlNNTVmzIFdfsfi8HqsK4y73iEXSQb6eDWi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gazmzvGK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gazmzvGK"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23c703c471dso28934815ad.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838655; x=1752443455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+dUBWdLiWs8LXQUWYmiLFU5qfDINRC4rx8DSKKZEYI=;
        b=gazmzvGKYmUJpsZMehPyF2bteQmePCeaNoxmB0E2k+JKblLs5xfZFZE8qH0d/6ozv9
         v2aeyZWWPmv5ez/qaBD7ZXNkggQHQsHv6/RYnFJm6zI1oztfquuzyVXK1MaLFIwA8LaT
         Z0zv+qbcTJum46pMbeaFLTVLCvYXO58Lh/iTsoNRok79i66mW5h7jhPpesV4agDGoaxm
         FmH1NRxTFKGQpBAYFcfp3A5KKq5n8n0etQn8DioC6KBNkGYCHaenXBd0o4ECN6UQi1HD
         ri0sjei+JE0a4V4os/L8r/vdlOym93Pf4lViZ9ULUwh5e9ZrOjQPyOBwlTJGB5YtlDJ0
         dSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838655; x=1752443455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+dUBWdLiWs8LXQUWYmiLFU5qfDINRC4rx8DSKKZEYI=;
        b=DDbWx4daG0DBUHxPCskOqTQAoWTzOwdlmIP0M2S7wiUIo/floNG3Im6S4wKXJiTBDG
         lNc3HCBSJSUp7DNjdojQklzPSnnrz39ps7IIf+Ke4zBDitEwTBSv97dRCLkthgF1k+dO
         KRhuvPieFUW+L02o8+NU4T+Z9BMTL4+qKy+JqP+AQJtS7zwV7xEA0oeKbDFjyrOnnW4X
         poV59tT4kwCdQf5S3iOU/2Pew1OcNGqziEeYIM360we4qOBvBt6AqWn350ujp2cRfUq1
         MAy/9VBFTA9YCi20t3l7al9TCsxc/LUVDrRbiBoex4DYgLF8Zq65GCZKC1druZ5e2HfW
         wfPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvVVab6EANLIRZQQvNRWhj6vGUNxQm/dszBe+Sz+Z6uxlOkbQi4+m38JPIda5VtPjYGsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7r7t02v9MSRHI1M1+GCOxCMEi500KLuCdJQMwrzQiN7VpJ85A
	PBfWMqmvIHy0Co6jyl8DoSqByHOKN0CBUWVhFYv12zVf/w75xyVXiAAsWDM9meQ/snw=
X-Gm-Gg: ASbGnct91rHeXw0jw3fYXqBkz9O9UWAIRawcW98qQCnecKPXYMLbcXBkKbvdzJXS+5n
	KDsJFDOARFULeyHpctYe6i5ZubfrslIstBudDP/TBkq/KeYtv0LuLSmUd9wtFuJ+ip4pC7TfKWK
	FoL1pcTJsYA09RgvwZl3mdRn8oQvBx21lF3kIJH5HcSsDHtvv49tZtrTOiMNOfPzFj0mjDK2KKf
	BcYFqkZEL5IEYOe6e80PCOr8LrMyd9/jSZlrqzVpD2+Pa/JHsl6msSoNzULLXN2VXZQHYh9b4kP
	21XACTGCZ/zXf2NeAMU+JV4v4+8M8HKL3yJJrv7lcxnNdkswMQA3nbzoY6NOZUmGdJj64/m2Sxi
	tb53PaaxForA=
X-Google-Smtp-Source: AGHT+IGFBIMf9dZjf3LhvdQiDcTU8G2dCdJsNpdGh4ToZxBFLxVZtEBOjLr9BUEQ+RICEII1+V5jBA==
X-Received: by 2002:a17:903:2acc:b0:231:c3c1:babb with SMTP id d9443c01a7336-23c85951fd8mr144508715ad.18.1751838654665;
        Sun, 06 Jul 2025 14:50:54 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:50:54 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 3/7] t/t1517: move ls-files -h test to t1517
Date: Mon,  7 Jul 2025 03:20:35 +0530
Message-ID: <20250706215039.715732-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706215039.715732-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
 <20250706215039.715732-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'ls-files does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t3004-ls-files-basic.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh   | 7 +++++++
 t/t3004-ls-files-basic.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index d3487acbfc..206b9e118c 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -128,4 +128,11 @@ test_expect_success 'for-each-ref does not crash with -h' '
 	test_grep "[Uu]sage: git for-each-ref " usage
 '
 
+test_expect_success 'ls-files does not crash with -h' '
+	test_expect_code 129 git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage &&
+	test_expect_code 129 nongit git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage
+'
+
 test_done
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index 4034a5a59f..a1078f8701 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -34,13 +34,6 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_grep "[Uu]sage: git ls-files " broken/usage
 '
 
-test_expect_success 'ls-files does not crash with -h' '
-	test_expect_code 129 git ls-files -h >usage &&
-	test_grep "[Uu]sage: git ls-files " usage &&
-	test_expect_code 129 nongit git ls-files -h >usage &&
-	test_grep "[Uu]sage: git ls-files " usage
-'
-
 test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	mkdir subs &&
 	ln -s nosuch link &&
-- 
2.50.0

