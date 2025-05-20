Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FC248166
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752024; cv=none; b=TWZ05Cj78s1xH+9QCrJRrXkgnIytNdBgNwW60WbO/JXoUWOgzkDFxbOQowik82DZkgfdFyDRB5GF/bubv195nGMn4qZxciCAEcRIlhQ206Xx26MDiUBihAE13+5gSlIRd7uOYGe8/a4dMbI8z8RbGyG+xCxTVPCeQ+R7nKOgJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752024; c=relaxed/simple;
	bh=ftWoGnavDKZPcWY1sjKEFc8tMaf5bnIdNjl2S/eKZpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SlSyj5vdS0ZAmF6yJUprjFYyF5DLspRG8mj+dKbtugTnOeL+VkqdXwTFbKm5jOHdvLB6UtSgAN74MPbfKvWN5maBY/p61YuhfeIfBYzAdCxGAQQmM0sNh1xy6PkQDKvNn323YGq+3oY2eTDFqp6QAHLjKyfpT+oZ7SmSl+xqRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dli8mlTm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dli8mlTm"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-601a9e65228so500574a12.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747752020; x=1748356820; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSeiCPC+so81SAf/0cWQLoBU19b5EVdLMkmhSrCT0ec=;
        b=dli8mlTm/zskdemOGxbstSNLrLpjEKmHNTHKORysWvwYd2DeOScC/EITy5E2FZ8m8o
         JP7i1QFzhfvuMzsSAq0cZzXZdnjQ9oac+drZ3YFotwT0hx2CdU7hRPB4sRBx3+9AdnyU
         cjbdjK0JhpDURujBrRV2Llf1ESAfr+epykScbTmIbO2H1j+ENW1vLaPESECJWR77p1r4
         x0dNg46HQIE2/i3MT3jxcZnFB15YYw1XbJzrcvIeD45+63MHzyaYOGs78DHwSrPdlszo
         Xrlloedl3tXSZoPg1rbVmz0oBGKoReWt8cJgKMuu5TDbR1iHrVwypgFhRQc+TXfWOAk+
         /lBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747752020; x=1748356820;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSeiCPC+so81SAf/0cWQLoBU19b5EVdLMkmhSrCT0ec=;
        b=r4NTc+gI8fbjWWWCOLGHwd0ad5Ie+ZhoCFH8fKSJb6CxTSDO2y5Hy3PrTNe/bGviHD
         81bLkUVcH4Iq99KYCbobhJiFdtElg1CkUNRs3iymMY+eiLk8vofW87B0D6166/f1yrQp
         8/JbKLcoIgCC2Cjf/nPp2+VmrBPSO+2esrmVM4SDzPYhctdW4+KKZhrQ/mGlLlmLsoh2
         PD3P3P3mUOEvZI5UjkJuieC136NRtcWiZyHjlzmGBmGgbhX30el6nBrXt8xQsbFZbOvR
         n023UEkWAGr8tM44hI/f8G0tufVFD+Fvej6hyXYcYT2WhuYYH95g5vj/dTWdLV+aK2p+
         tSOg==
X-Gm-Message-State: AOJu0Yzhmtlh4rWmEeLa56ztvDADP2FwFGkQC8wAQeuLVJy5xPZWP5qH
	HkGUK7b+H/izkMJftWO39gXHOIws8m5HALOOKi0KQ7zSqQILuyvT2eccXUZLwPJL
X-Gm-Gg: ASbGncvFFbmBEGSSpf+8x9z0Y8To1PmyvSrdS5hWZ8XcC5k6UOBUWmV3sNBOfWYsHkH
	9rfB2J9CHxT67gp8rD6lqgVYsUy8qv9UNgiwtLYs69taEC0HW8xwshnq5ro1MbmRF3TPlggsyQ5
	h1k3zkLjXnXkpFx/6fk4E0gq/35uiVeAZc3eVNohJfwKOSpbNSHpOVVj5GyMUSzgjo7oHtavIHo
	z3//i/IQ8pV1trVaMNIOzScTxbAptGIuGMcmClK0Plt314DTs0LLH9gk4pazKy7qFdvtznnzjPQ
	tcd5g6/aK4N0cE9cNFtR/btZqnzb
X-Google-Smtp-Source: AGHT+IEkdLtJWj/RItWMMFh38iJa2AFhe/7yod5EngOYUN4KFVHlWkren+qXMej7Fu97DWL+ra7tLA==
X-Received: by 2002:a17:907:3d0c:b0:ad2:378f:99ef with SMTP id a640c23a62f3a-ad52d45ad86mr1531496366b.8.1747752020224;
        Tue, 20 May 2025 07:40:20 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d490a30sm725440866b.127.2025.05.20.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 07:40:19 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 20 May 2025 16:40:12 +0200
Subject: [PATCH] t: remove unexpected SANITIZE_LEAK variables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-kn-remove-unexpected-exported-v1-1-bb60cec57e84@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEuULGgC/x3MQQqDMBBG4avIrB2IESvxKsWF1d86iIlMrAji3
 U3dvW/zTopQQaQmO0mxS5TgE4o8o37q/BcsQzJZYytTWcOzZ8USdvDP41jRbxg4RdB/FK+yc3V
 dus/oKD1WxSjH83+313UD2eowrG8AAAA=
X-Change-ID: 20250520-kn-remove-unexpected-exported-163a97739bf9
To: git@vger.kernel.org
Cc: stolee@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=ftWoGnavDKZPcWY1sjKEFc8tMaf5bnIdNjl2S/eKZpU=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGgslFCIHTZxhO7IK+FvWx4a+4OJHsJkk1AJE
 AqiYrNKVHjrC4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoLJRQAAoJED7VnySO
 Rox/nzcL/jB5o/b3DJo2a57mcq6rg4rpzTti6ebj0uzq48wV4Iu34KLeB8R6Mdtm/GRXPYmk34n
 sHidZrB0ktj28C68aZwS1gMMw+obFlg0NSk0wRjspPKFTXIaNrPaY2S9PH/Yoni5kapGJyBWvsC
 G86tAdq9vyhM1u+aZu+AGtnTidzfhxwJ7bI8EJKiJiFrLKzg4CWsC3LdFJESt1XVNmmwcqWZT0n
 kTIcJ5pU/81xz3WQzeikgeJvObSufaIkpjs0uoL29oeDUx04K9WRLemOsOcy4oCqd5lxAojnqLb
 sadRiJVpH1x/+ag0xQrMPAfh93do8sEdO+VpqgEsSvcn7QCU8EJOSiURiXfapnS81n8IaxkOaZ8
 GNJsZR1KFOqTcmNngoovH68P3mei9DK1SIQeaUaJxs5f2+uukJRtchRJ/DtrN/MAhl4/yRuFEe9
 YchXrJiAlMQNDqazezzRkCFiUvRpvhYICtXiGVzdFIpLyt3i02YlKSxNoQB7hhMoEaAxBleBPq6
 JA=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

As of 1fc7ddf35b (test-lib: unconditionally enable leak checking,
2024-11-20), both the `GIT_TEST_PASSING_SANITIZE_LEAK` and
`TEST_PASSES_SANITIZE_LEAK` variables no longer have any meaning, the
leak checks are enabled by default. However, some newly added tests
include them by mistake. Let's clean this up.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 3 ---
 t/perf/p5314-name-hash.sh    | 3 ---
 t/t6601-path-walk.sh         | 2 --
 3 files changed, 8 deletions(-)

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
index be5229a0ec..786a2c1c6f 100755
--- a/t/perf/p5313-pack-objects.sh
+++ b/t/perf/p5313-pack-objects.sh
@@ -3,9 +3,6 @@
 test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
 
-GIT_TEST_PASSING_SANITIZE_LEAK=0
-export GIT_TEST_PASSING_SANITIZE_LEAK
-
 test_perf_large_repo
 
 test_expect_success 'create rev input' '
diff --git a/t/perf/p5314-name-hash.sh b/t/perf/p5314-name-hash.sh
index 4ef0ba7711..235cdfc824 100755
--- a/t/perf/p5314-name-hash.sh
+++ b/t/perf/p5314-name-hash.sh
@@ -3,9 +3,6 @@
 test_description='Tests pack performance using bitmaps'
 . ./perf-lib.sh
 
-GIT_TEST_PASSING_SANITIZE_LEAK=0
-export GIT_TEST_PASSING_SANITIZE_LEAK
-
 test_perf_large_repo
 
 test_size 'paths at head' '
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index c89b0f1e19..8d187f7279 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 
-TEST_PASSES_SANITIZE_LEAK=true
-
 test_description='direct path-walk API tests'
 
 . ./test-lib.sh



