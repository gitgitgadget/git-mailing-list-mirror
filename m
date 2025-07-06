Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7125DB0A
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838653; cv=none; b=fbCSGp7kBwvGJ/CnqD3NFAUkjkQFqDPdUKl7gFIqV0YBz3fDyzYKQQFxlRrU0+B1TVSoSrY2Xc8rbN5+Qh/3g7JtehKXAZgI1mBp1aCPKcAZDX/kt9lNQAleYA7wByS2tlOYKgitGXBTbaYuK1o/JDDmIR8fgtEqcsgaJBYnD9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838653; c=relaxed/simple;
	bh=UcVCqRZEuB6SSpJUX1wa+Ubj01MjQE9m/dU74Ux2/1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpJnjm7Yr/D25zUPHiw1R8NG5B4BAR8GmwgQvSuu0RTyqp7Xz7WP4ZGtk3TXvtqzJtq10NuYmHVnJtF4tc0M68ubq2fyTTHA1IvwTp8L0sYT15r5F9IE94yW+orCjriiWW1bfh1x5mpjozqTpgRuR6Uuy2zLCEpTus4KW8xvKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b52Eg1f+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b52Eg1f+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234b440afa7so24476525ad.0
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838652; x=1752443452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPN5CmfpTqkO/Jro13cfwG1DiT4PtHinY2VqqndLfaI=;
        b=b52Eg1f+QV7MU5hq6UeT/9tVEfR0Vk1JVgeAnlrwm6EbXvrFHUc78TEELqob8SkAv0
         ridwP3woiTVZVc+EkSk3jYZIGuZbExB0xa3/mCMlrSBCY1WYj1zBXOBAZYJauMnum/7y
         OQcu8DNn6C3SJyRVN5EqCxqbPfLFXGKCantVtfMGl7xrkUu7tyI0E3buFMEPzHY9jSlj
         LLzmFXyZsEs76CrnzQsheNfjZJeoO2Ih4fNjWxMbrM4YfHv/8UFwyQuRnaOS7UqshJwB
         egsZBtv8OKHkbgT5sgICeV3A/ezEjKtMXMgl6yWffVFq+ROTaE9DYrmfddzWUEWh2vvJ
         Q5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838652; x=1752443452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPN5CmfpTqkO/Jro13cfwG1DiT4PtHinY2VqqndLfaI=;
        b=GRTZ2lgRk2Pe33WLYj+TUEl53XUT3Dx2g1oZnCZ+Ia0AedN3j5IMgXuRn4xLjoRLVn
         tmjX/r9NiyB7bdF1N7YdSqkIhv39koN58F2VWulp8orrZS/AVVN5nLs3R8+Eo08VTeyW
         0z9EuESpFntyHf55XwSIgxYgmR8QgqAuiQZrzTRJ3lrbQbza02E93RaK7qhFcFkU9VIX
         CYgsZ/z97925MbzKibU15rGrKZ2eChpBUK8AKy3Qqtd/sGGbmB69uG+Gl9ridsBqsFfd
         +f46cDDGGSgswMBOpvtnh6uV024VQFuEHsulgB81qXhbz4xmXW1GjYpB1hllmB+ws0HE
         Eyeg==
X-Forwarded-Encrypted: i=1; AJvYcCXLAMIxId2FmYqIuSqSpnAz80pIzzFiU5o2Nr1gNSSFPm8EPTg2Ht83yd5RmR4jnS3sSQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEDbrZ4ZBoP/epZj/ijxX7unD8b0DS84O0IPxODNifSCUl4P2
	WxgpADfBajIoPNjLxsWoJPVPMbPJotxfKx1wMQsk2giIi2fIy86tUJbw
X-Gm-Gg: ASbGnct962mXbEvEycf+jbpQYfX05tmbwQ4hbvvMl7igChPPH9nFaisZcUa6+OtRCoT
	kB9s2VSXXhSp/qHwrthtUxyNoCR5M7Zm68QKxH1ANWyWcXZMkHo0C/dmGh5qVTXFast8OZ70xYl
	7T/c1V2DFmYyd7IkQE4EoI9a/cedE2Mv+j7k47Cd9Ws/JsKmaDe9FBATllQ/kD+rrr0uX3Q445d
	x31OvN9l5Mjb5Rd87Pzj8b1zWsPtx97voFruy/b9uw0dfNOXv6/x9206xTImJHfQrDWauaSl0f+
	CvtEa1LBp6MtaQuAAWVLb16FXr2SFpZtNv1cv8pSC5daUQpQw84lXIF1edSs1WyKqCuRn+YD4b+
	WMw0XuNb5uFyqEIxmiCIC4A==
X-Google-Smtp-Source: AGHT+IF2MaPDPvPU3WXZ8I9GnkqQTJ/LQyNlk835eeSjDSz3NueOzOf6bXiPvuiZeAZUBHp4CXkRiA==
X-Received: by 2002:a17:903:610:b0:235:5a9:976f with SMTP id d9443c01a7336-23c90fc7db2mr69357135ad.24.1751838651792;
        Sun, 06 Jul 2025 14:50:51 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:50:51 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v3 2/7] t/t1517: move for-each-ref -h test to t1517
Date: Mon,  7 Jul 2025 03:20:34 +0530
Message-ID: <20250706215039.715732-3-usmanakinyemi202@gmail.com>
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

The test 'for-each-ref does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t6300-for-each-ref.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t6300-for-each-ref.sh | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 9e54214725..d3487acbfc 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -121,4 +121,11 @@ test_expect_success 'checkout-index does not crash with -h' '
 	test_grep "[Uu]sage: git checkout-index " usage
 '
 
+test_expect_success 'for-each-ref does not crash with -h' '
+	test_expect_code 129 git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage &&
+	test_expect_code 129 nongit git for-each-ref -h >usage &&
+	test_grep "[Uu]sage: git for-each-ref " usage
+'
+
 test_done
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ce9af79ab1..5db7038c41 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -292,13 +292,6 @@ test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git for-each-ref --format="%(INVALID)" refs/heads
 '
 
-test_expect_success 'for-each-ref does not crash with -h' '
-	test_expect_code 129 git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage &&
-	test_expect_code 129 nongit git for-each-ref -h >usage &&
-	test_grep "[Uu]sage: git for-each-ref " usage
-'
-
 test_expect_success 'Check format specifiers are ignored in naming date atoms' '
 	git for-each-ref --format="%(authordate)" refs/heads &&
 	git for-each-ref --format="%(authordate:default) %(authordate)" refs/heads &&
-- 
2.50.0

