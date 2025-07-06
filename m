Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7DB2E36ED
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836148; cv=none; b=Zz49h5SvRVrRuaLaXSVmOYUI18Q86BUhSpVuW0rupS9K3L6IJxNJ4c1HCq/s84unEPpqxYMIv6h+4D6Srbok+MHHi7UcCg447cTHaFc8TN5cK7WggBegbwnjelYLWRuyl15p88d52JgFo4E7YxxdZteV5q17kJbDWnCDe2r0vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836148; c=relaxed/simple;
	bh=OUqIraMhV/ovaQYEA5cJq1iqg9loAhW41Ir/U058j/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLvWIUz0RCApGutbvMdIiQDuvQb7c5yD12wSgy7saXQ38Sg9PrkdJTlJYG368pmCNbXE6zOFJbth9pBFLxZUOpGo/jCSEqaIWN4Wip9Iajq7dsM73uAws2y4PO9QcZpJnzLFMMddchLHF8qiO4TvfWQbgI+ffN8/zUgnZujzE2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OgAFRSrG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgAFRSrG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso2123414b3a.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836146; x=1752440946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlZymSS9r3W5Rr7srxoF1qARUYC22vbSIPL6X0s6HMs=;
        b=OgAFRSrG7fZUfF9aaNUqtOgPcjUNQDu2jg1pp2x39jwlg4T404I2jxd/f8LT56OvcC
         8hkjuB1xqIgFDPuSC4EdXE2qG8kJjDoC2S53ciCvCqTeTFP8dTPPiFmkDFWqm4AfsoFK
         Peqmil846nrGfH67t9czJasO3h9IT+AqtTvWH4MXBzv1Fex0u6KlzRpmQsgBu10A5jZd
         XKCE8wWwrbb2HHc/BOm4lzB1G99fiYFmiWGpp9JgFGPNAbdTwJcnxSeyeLhfRLhF70SL
         L3HY5Xh8y24hvUbcV6bEUKx72x15hl6IPxS3/RCthkSO5uNsa8OwPhiCcQ8RgETn+oQI
         zkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836146; x=1752440946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlZymSS9r3W5Rr7srxoF1qARUYC22vbSIPL6X0s6HMs=;
        b=OdkZWcP5qYtCOlOifp75+ViAocsF1jmjY30FJtEQ0287ss3Cxoh6MGDzR+JoyYhyPK
         SoZ+czgPBUykr6eW0g0YCLuY+emha/AN0ArIN1sLUcNO+ved7tl91EvLiXadbnLT8P/b
         bBn874t+jHPb88suCA6gtH/MxdRLMuHs+Gcq7NPe0ESSKADm3M78dUeEX6L1ASzw7U/Z
         lBPFa6OVQKLgf2W7x0AWf+npiuwC/D1zBLDIPKrFkH/WBMx8W/fZNwkL8bDp6sj7E8+p
         QY21RMgsQqV3QvWoDGFtUMcDuTCy3PnPKYpYbo+UAwdrNwvVLQB1C7tEnDLs2dj4joCR
         peTw==
X-Gm-Message-State: AOJu0Yw57fyYDbnkcKPjvTveSBUEYJ1/rqntHY/QDORAouS/pn4AH8EE
	hDfoHY6cC2fdLaNYdhrcAkFpvtd8D2Yx9JejsOAJhj++JwPFE/GEW3on7fDiIUi5sJU=
X-Gm-Gg: ASbGncvxw3mlNXT0PwicFdSY6dm2rgDUiS0QtzXC8mIDY0s+Su8v8GPZ3kfSyXgx2DQ
	3xi7omUJ7SJonVHyliAfURbQ5m1AmR0rzlrhCjixPKHjfQtMDS3H5n5M4x4NuYB5JTT5BoBu0vt
	2K55fOCCbm6byMgB1rykX2ngbr4VLJ/2ua4Rw07B4Xrm9UBiwEvftvaGW7uCE2j08vVjVLMhoKu
	g3Q59vs2q3emDHmrDY1ILZVH84aOUGLB9c/+GNziVtS7I80eGwlGQ5bxrDnLdbsbjSwQXgGuMF0
	0ZKhedtuKo2KupBTXgZdAQ62S4Y9G5juEml9+y/XVLCh0kY9GCULm+bOIzmPLASKriWz38VoT7x
	PeTIw2MyJpSA=
X-Google-Smtp-Source: AGHT+IFDpB5WR5kJ+/TquhFKwWelNi2AljbbOslwdGtqGjPHXMTmJXxI+3BZhBkdzZ/vnDBtrVoclQ==
X-Received: by 2002:a05:6a00:2450:b0:748:f8ae:bdd7 with SMTP id d2e1a72fcca58-74ce8837899mr11917640b3a.9.1751836146408;
        Sun, 06 Jul 2025 14:09:06 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:09:06 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 7/7] t/t1517: move verify-tag -h test to t1517
Date: Mon,  7 Jul 2025 02:37:25 +0530
Message-ID: <20250706210725.79903-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
References: <20250706210725.79903-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'verify-tag does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t7030-verify-tag.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t7030-verify-tag.sh   | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 42381ef7eb..0755757d86 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -156,4 +156,11 @@ test_expect_success 'verify-commit does not crash with -h' '
 	test_grep "[Uu]sage: git verify-commit " usage
 '
 
+test_expect_success 'verify-tag does not crash with -h' '
+	test_expect_code 129 git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage &&
+	test_expect_code 129 nongit git verify-tag -h >usage &&
+	test_grep "[Uu]sage: git verify-tag " usage
+'
+
 test_done
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 2c147072c1..6f526c37c2 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -7,13 +7,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-test_expect_success GPG 'verify-tag does not crash with -h' '
-	test_expect_code 129 git verify-tag -h >usage &&
-	test_grep "[Uu]sage: git verify-tag " usage &&
-	test_expect_code 129 nongit git verify-tag -h >usage &&
-	test_grep "[Uu]sage: git verify-tag " usage
-'
-
 test_expect_success GPG 'create signed tags' '
 	echo 1 >file && git add file &&
 	test_tick && git commit -m initial &&
-- 
2.50.0

