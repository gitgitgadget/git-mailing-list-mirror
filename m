Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAF1CD1E4
	for <git@vger.kernel.org>; Sat, 14 Mar 2026 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773468387; cv=none; b=ZUrAl9hheaf1xTosTfPCJlAQWIk0cevd5XXRIdLDlEYf/KAjoBIZcx9943bqgojdxoJmRMO0JC9nSxN9r06oS3bIxSFT1kFm4LPo81nNrlfGW5KKVaP9YvUY5nsyftH4sz6vEuDBHeJNPmvFoaUdS1aTXBrPQn5FYpcnMYvGG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773468387; c=relaxed/simple;
	bh=PikcFHAR2T+oklkJjJtVuS/Gi1yp/OsZCZ2qg22aRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hoYciUnVT7gfvjWtFlTsFJ4Jnch+FiJZrFS0rzkbsiwhCkod7qnL9RjKQneBoryUZuAFzTaPUkD5xBKJx3PAOWfIf6SMqqqxOiYY3ueL6VriSjncL7696nHCRQ363SDHVFKJ6LfCZ9+BlPAymjNUBlxxddPWpo5+oGiB5NsEisQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmuUts3y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmuUts3y"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so1808680b3a.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773468385; x=1774073185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h8cg8d7Rv9wjnO5jF/oVq0kSey4vydRYQpTR7X4yykg=;
        b=lmuUts3yEOTU8Eyvk22gfBL/7QIhb6w0GLKo1OEKaKvI6haSfwG9JkHlimGIapRoby
         4FQutDwlSuzauKYQx5q2pDisyoHGRexLFRS1/yXC6LM0Y3AM6zMuad5qlTRkHJPMk6LN
         xOIZG9h7OLEriUZ8ktfgaRbu2M1ywrSPQIQNPA5LUVKu3vzfcUDImRMhiLDlDpliGEGX
         TX4SiDs1lkspnm0Gh+h47gSKJPf9cEM51dN9Dbvmi5V33pxb0pQSlpFMJOOigL6j+/D6
         7EGjq6p08stztmN6JaJehOehWhCCR++2BxEGQueG2hdqB29xg8nd7KAE8IjvbuCIInOF
         /RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773468385; x=1774073185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8cg8d7Rv9wjnO5jF/oVq0kSey4vydRYQpTR7X4yykg=;
        b=o5rvEJnkJ/cmC6dA717YDOX5LeZjvccQK9CY7co1SOZt097lBr2i5jj2UqDHwEAVhz
         YVgpQbXPvNdoxQbtn4lHZy/YIGzT4JTcq/TKsHi8GRPPhCSRMNlKBfYFTvAEDXpiyLMF
         TNQWYMHODD+Zg8AANUSOq+7FYnIITb3VhlfCCB6StsIVKo5Ze+pR3w1dbYl1UpoX6Q30
         t6tj+D/phl0J/2n1DOgXflB+Ss3FQrfCtgi3iFLYg4xDSSLGrHXS8FP/f4/AYczE0rNX
         MbvsjeQHb59JKp/d4aBFlidrHDMVaV8YH/tTaB/GhaoVrMejOz9Uj6QCmewi+Sl71X5y
         WwKA==
X-Gm-Message-State: AOJu0YzDp8ayXPwMzxYD3NwdHH8tkVHLK0hkA+170lu9JWRZ1ML3mXps
	mMlYBc8JbT7SKJ9S2dKh4q9VDhshc64SSALDkA6WShhd0Xe3EqgXEl9ipkGGpJxkXoI=
X-Gm-Gg: ATEYQzzIXsCILmzDC644hNID2s51iNRofLpHeDaZCpJeBIRNk5Atc0woyOxQxqhDc03
	NOTOSGp+lgWtmkHv3Y27YM8Ner414VkSnA/5oLiWGu1LlXllAMr/evYn/XjvHLybi4aHKGYJaHZ
	tKohKNK2y6rsfHHtIYEzlamLVzUHQwpZVs8/a/xMdAQkjNrQfhIWP+T16+1RThZ3WSqlJ67LfB2
	6rQSOWAjMws1NuFgbZUhRfnhkePTGe5HarypSTNvDfqxo7/aczT/RadqjQkhsmKu/0YqTbAFwby
	w9Kuagw+E6een7Dvt+7MPCAbTtNgfrlTzJcmnu4ShYft05Xf11HWQr88JJo6Ql+lyw/z0oWcZNT
	IYB8EsKDtowcH2dghnqZAkIW/kWb1Vqll+dRlrIpnRT7irRwmPvNlnR/IWBG0CqtO074qIkoXsq
	cgeJR29iRH0XH3zAtzg76XVeWxjSyFKmUzbujvlS3r15H87B74FFSkb3hPvkf2brIbcSyN0lhuS
	Ytpgw==
X-Received: by 2002:a05:6a20:729e:b0:398:c3c3:8687 with SMTP id adf61e73a8af0-398ecab95d7mr5639055637.24.1773468385439;
        Fri, 13 Mar 2026 23:06:25 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cd6:3841:bc6b:8052:ee17:538d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb6336bsm3968814a12.21.2026.03.13.23.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 23:06:25 -0700 (PDT)
From: Ritesh Singh Jadoun <riteshjd75@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Ritesh Singh Jadoun <riteshjd75@gmail.com>
Subject: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
Date: Sat, 14 Mar 2026 11:35:50 +0530
Message-ID: <20260314060550.1277-1-riteshjd75@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pack-refs tests currently use raw 'test -f' checks with negation.
Update them to use Git's standard helper function test_path_is_missing
for consistency and clearer failure reporting. This aligns with
CodingGuidelines and makes test failures more obvious.

Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
---
 t/pack-refs-tests.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 2fdaccb6c7..3cc4906f05 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -61,13 +61,13 @@ test_expect_success 'see if a branch still exists after git ${pack_refs} --prune
 test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
 	git branch f &&
 	git ${pack_refs} --all --prune &&
-	! test -f .git/refs/heads/f
+	test_path_is_missing .git/refs/heads/f
 '
 
 test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
 	git branch r/s/t &&
 	git ${pack_refs} --all --prune &&
-	! test -e .git/refs/heads/r
+	! test_path_exists .git/refs/heads/r
 '
 
 test_expect_success 'git branch g should work when git branch g/h has been deleted' '
@@ -111,43 +111,43 @@ test_expect_success 'test excluded refs are not packed' '
 	git branch dont_pack2 &&
 	git branch pack_this &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
-	test -f .git/refs/heads/dont_pack1 &&
-	test -f .git/refs/heads/dont_pack2 &&
-	! test -f .git/refs/heads/pack_this'
+	test_path_is_file .git/refs/heads/dont_pack1 &&
+	test_path_is_file .git/refs/heads/dont_pack2 &&
+	test_path_is_missing .git/refs/heads/pack_this'
 
 test_expect_success 'test --no-exclude refs clears excluded refs' '
 	git branch dont_pack3 &&
 	git branch dont_pack4 &&
 	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4'
+	test_path_is_missing .git/refs/heads/dont_pack3 &&
+	test_path_is_missing .git/refs/heads/dont_pack4'
 
 test_expect_success 'test only included refs are packed' '
 	git branch pack_this1 &&
 	git branch pack_this2 &&
 	git tag dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack_this*" &&
-	test -f .git/refs/tags/dont_pack5 &&
-	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2'
+	test_path_is_file .git/refs/tags/dont_pack5 &&
+	test_path_is_missing .git/refs/heads/pack_this1 &&
+	test_path_is_missing .git/refs/heads/pack_this2'
 
 test_expect_success 'test --no-include refs clears included refs' '
 	git branch pack1 &&
 	git branch pack2 &&
 	git ${pack_refs} --include "refs/heads/pack*" --no-include &&
-	test -f .git/refs/heads/pack1 &&
-	test -f .git/refs/heads/pack2'
+	test_path_is_file .git/refs/heads/pack1 &&
+	test_path_is_file .git/refs/heads/pack2'
 
 test_expect_success 'test --exclude takes precedence over --include' '
 	git branch dont_pack5 &&
 	git ${pack_refs} --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
-	test -f .git/refs/heads/dont_pack5'
+	test_path_is_file .git/refs/heads/dont_pack5'
 
 test_expect_success 'see if up-to-date packed refs are preserved' '
 	git branch q &&
 	git ${pack_refs} --all --prune &&
 	git update-ref refs/heads/q refs/heads/q &&
-	! test -f .git/refs/heads/q
+	test_path_is_missing .git/refs/heads/q
 '
 
 test_expect_success 'pack, prune and repack' '
-- 
2.46.0.windows.1

