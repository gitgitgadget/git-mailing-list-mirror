Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5081F5413
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838651; cv=none; b=hNq0pyADxq44cXWh4oyH1dDVoTMOnSbDS6melF1Ph6PipZDMQJKphfSsR03erknTWAYeBFISg8SoAlJD9rvBr+YMQZFu/cNefvmp3ELnnk9nM4WtHEPVp0z6jVkZbGe9p+rtnw7kBRc/k3NH6eUmnjNELeIFNFR3/epqiKBJucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838651; c=relaxed/simple;
	bh=bEN9Abk81MkzI7KSOCp+jAjQ/SlkCTz4r8nRJSZvLDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4Zpa+JpIjMjp5WRa0YsNaFSG2eIyjfoCC4kMoyBsTYD94KI15rsLDpjS2v3OHuqD+AHLWUxeq7p+3aqH9TQCVHdPjXykET+3myBeU6HweasxB4/BQ6NbNT/mc/FXrRweuRKinrRaqKY2uQUv9JzHc2/RAYHDUUCxmgCIKXOcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2wDw8D5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2wDw8D5"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235f9ea8d08so20689465ad.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838649; x=1752443449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izLJ3X4QBDd9R2XB7ByvIGXW4OxeWPzNCyqdvU4COCk=;
        b=I2wDw8D5a7UIAIkpeD78GzmQiW3KsReYi7D7hDwTmIoLUPBdIpNFKIwtOieJqCiKoU
         Q3Zs528TxUomPuzJmxQbcyrc9GACX23n5ZNaNHSXF3sYZ40cVMXD8BirIXgC3R1kbUsw
         Eb9x+lCMBp2I3MT+bvXAvfkvq6qaBVSWnFSXfN3dizUAawkcrPrWAmXxjw1QWmM2PW4K
         pDbuJ1mWnyurFzuw/HPyysV+cCRg8BFdDUAt0JFqMhL94qlidGsBYXP2GCoMQOBT94bZ
         V1gLVFnAj6WrCaZwMRGwwzn7W8V03rnkTDBpsam2BGqSi6JHb/7a6xcpIwdo3paO89Mu
         FwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838649; x=1752443449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izLJ3X4QBDd9R2XB7ByvIGXW4OxeWPzNCyqdvU4COCk=;
        b=F900CSPvPIa6zzUMSa3+Fj14wrQXityhiTAvm0E7isOOQS7mTQwpaB4+ISTRNBI/FM
         cQA1egXGZ8IsSCAogJe6TIlx2OJgqg3yraC8Wo+51D4YhT6wiw6h661pFCV2uvBYVETD
         MCBFjm5SmDsvEbwwB7kmiCE6IAZQiCXCqfuca0ysGfF8yhUZAdeIgbgikQQqtFB4s46T
         FwOZtfSzgpNX4uENGTbucHEcRGVpI42FANozrSz+H8XeG9BQUSSMSbkT/QxZF1hsPYv+
         z0leJWOgOHPeRFJsYTLdrOuv6Q96RcMOqtMjIERdQ/V8yNvp61fefmGB0+e3nB4IiWfw
         GpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGhURrZwnuyGvTXgDL5dDsLWj8dRJQjETb1vAYFUG+MU4lXw/ECUYEk3Ufnm1t4kH2m9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEvGvQKYmebUqNWY+k3SU6L7A/OkIz4fHNwE9rv34XivxAc3Co
	4I1hsKvcdtojA6qTI4hb28IJk6i45pj0PbpwfQcitguqzvVfZJ3NgEP9m1UXqGRBPa4=
X-Gm-Gg: ASbGncs28dpWCUATmtiupIqpW2pKGLRB8EP65CZVAl7NlicRkau7/JmZaFR41Pv7/wD
	rlj+ztWaVcbkZhZKF+F2vqUjrpjveRDIqex8A32jQypbmbAc7Nb6BQ6oJd9IBYPbNFSEZP92XZ9
	LWewqI53j4mlwFZZMwG2dbYVrwevLLdbtVdLQ9b2HRVSgjR8eeUmX0Co5oKQTGIZEOq8BWVtr4l
	uKQogCmgcEgSKy3UvZLxmG0m5C7K3nFMr2DWccTqASLtHUqO3e0iige5jsHB7eQjeLSTl1aJtS6
	Sli2Cdj852Wq3Gk/Q6HkzXQ9O1ntaIxEarOKvAu77aIyA9pzGIMwmBazi3kpefQaxLi4hFrvzZT
	zHpiLW/UvUoM=
X-Google-Smtp-Source: AGHT+IG70BNuhhtF30fFzO9P5DUzADkLiD0h6e8ot8mc25wF+6+NAFXflS6gL8JfF3Lw8T+T4SYtLA==
X-Received: by 2002:a17:902:d4cc:b0:236:8df7:b30a with SMTP id d9443c01a7336-23c90f92800mr118193645ad.1.1751838648917;
        Sun, 06 Jul 2025 14:50:48 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:50:48 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 1/7] t/t1517: move checkout-index -h test to t1517
Date: Mon,  7 Jul 2025 03:20:33 +0530
Message-ID: <20250706215039.715732-2-usmanakinyemi202@gmail.com>
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

The test 'checkout-index does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t2006-checkout-index-basic.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh         | 7 +++++++
 t/t2006-checkout-index-basic.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..9e54214725 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -114,4 +114,11 @@ test_expect_success 'update-server-info does not crash with -h' '
 	test_grep "[Uu]sage: git update-server-info " usage
 '
 
+test_expect_success 'checkout-index does not crash with -h' '
+	test_expect_code 129 git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage &&
+	test_expect_code 129 nongit git checkout-index -h >usage &&
+	test_grep "[Uu]sage: git checkout-index " usage
+'
+
 test_done
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index fedd2cc097..bac231b167 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,13 +21,6 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_grep "[Uu]sage" broken/usage
 '
 
-test_expect_success 'checkout-index does not crash with -h' '
-	test_expect_code 129 git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage &&
-	test_expect_code 129 nongit git checkout-index -h >usage &&
-	test_grep "[Uu]sage: git checkout-index " usage
-'
-
 test_expect_success 'checkout-index reports errors (cmdline)' '
 	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
 	test_grep not.in.the.cache stderr
-- 
2.50.0

