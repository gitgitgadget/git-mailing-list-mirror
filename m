Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E21F4168
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838669; cv=none; b=KslrFcethaSLO+r8ACWkpqQd6hQAwS3rSYdev+VfTfLw5P2m7at2wURvLzpJfptcUyUFgq6bcEbM6unu2Gs4fMaTDFa1SJwGLaOAQfk1uVSDqmTH7rBGvAsdGpV0jEzmpUyfVyBn8wWb2vBMo7PGs5+fWXc+h6zEsb4N9PbZoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838669; c=relaxed/simple;
	bh=h29B3v6VCSTIDhtlUk9oxVjrP3KSFMtttpj7Lm/4iL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7l+JPg5m6NIIWOUQodpV6+Ix4JEzXKHysmqj44pWDWLGWB0Ea+/CClCjgSBnF9i6r9VCJgqTM2hEuYJitnY1lCMUFg4Qrh/PhHtYAPiSiBh/pZMwz+D4ZTh/1Uon1Uj8HKT2ygSDUqZ09nx2aC0tszkeJMZJxFuYS/+EtPwOyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KS+oXncC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KS+oXncC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-236377f00easo31240165ad.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838667; x=1752443467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdMduXr/TgsaR6JzOkiGxwzzgi4xM3rjP/fjiJsVEhI=;
        b=KS+oXncCT87jBcPDhAh6IgYIe3I23RbA306lCgXsMqgYZb0wjyDIN4wuFDfCoR0jPG
         GJOaSE9B4SRlIGUynKZZ8IZ4ErT5bQYf6/hkMx9/V04bFe6WDV787oqR8KSEZibs9kjG
         CPlwWrW+8wd0PVPOBSi/WW2O/4s5H3Er6llIaWOQUMPEdPUruMz4oTmqoEfLbw2LyaWk
         VvgmgHHfur0xCz17P380P4GUr6X0b+CTNF5PCTANSx3OaANWFqWTjJ72wOpTBskwVlvR
         WluRzjxyCLZp7XV+YvufvjwWgIMVjUd9YOLxPQ02VAg+T6x11HV4JqaASCsP/nvOROCa
         WAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838667; x=1752443467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdMduXr/TgsaR6JzOkiGxwzzgi4xM3rjP/fjiJsVEhI=;
        b=u+C6Ulmi5dDV2TSykD/g0GHc4Mo+YBAup/QJx/X6JlVWSLDyvjkEb8T5WZjtUqCCks
         Yi8VKwbZQ3KIgNgtdfuviWL7BHTRmluxP12yhpPPecqWOf89WzQ1SCBwkIlw9Q5OlOv/
         sp7fSagwjHqP51uRwktxiLTC7AvRdj6fEPKiD2bOP1G2S00hs61Pb6o5WrxIWthQbzLH
         mToezEoooDAUPvvqcqkKSPxIZjw2sHcZXkauo2DB9h52vcKzeIjzUmUXrxYw+4Y7EI5R
         QndhY7fV46UIBJJY/iJhmj5B6+BI7DNl/KQhmAQKOgXCtFN555rdMDM9NXmCXZQDNsgl
         5ZMA==
X-Forwarded-Encrypted: i=1; AJvYcCWX1UDFoFEuFrGE9g/YmYP01uRRdDHDM67qrM379FRhUEqxC1xPIzJA0BSeSmsb+KgYVCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+324FT/XkSFqfFpxaHNfTRkFX+HledNw/e7EUFylMKr2BW3Qo
	A6PXP6BJCofaTXxB8Ff8xGQP1yPpI39c/4rRVNZnrOES2Ye3AxRQRyTY
X-Gm-Gg: ASbGnctG0OI/DpxWHx8aKGLuthSjOzHgIjQ2hrhaIu99mKqwA4We2ZFvMi9OKy4V429
	q6qMcyVpn11hRn7kLWY5rGE29zVqrqpEyrzuKu8ztxiwN6S7yWtgQ+/buuyOVgMKuC0V9u7rvRE
	E62VyylrXJ0R6SXdwAIay4MgNvDXic8p+9cwZ3mdT+3XA22LqZVn9ae6ItCqYfvdAIRYl/EpIwv
	bHcvwMZVY2Xci8McBcRoIS9MzpAfTJgnqof52dJxClNAzo+I4NgztZLtywPIhplmROixUpEoSLd
	/CsFMuyIr7+5Hj3xRRaNxe030uCU/BIcE/11WHFgm/2GcilTmQnnUXBsIugvif51hv235HV4XUo
	tVN6AO0mAlqM=
X-Google-Smtp-Source: AGHT+IE0SIjFKTc8UKaw2VdGLBeTgEV65dC+XiIE6chgdq9gq3ShTLuDhAWWtpgVc0HC+6kxJbjwsw==
X-Received: by 2002:a17:903:28c4:b0:236:6f5f:caa9 with SMTP id d9443c01a7336-23c85e7735dmr92287865ad.32.1751838667359;
        Sun, 06 Jul 2025 14:51:07 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:51:07 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 7/7] t/t1517: move verify-tag -h test to t1517
Date: Mon,  7 Jul 2025 03:20:39 +0530
Message-ID: <20250706215039.715732-8-usmanakinyemi202@gmail.com>
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
index 8a46fdfdd1..25ec3b3978 100755
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

