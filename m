Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90E264FBD
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838092; cv=none; b=BvNxu03Uzl9NSzKTokxBF18p9liI0RSc454bVR4ThUEnotMGBGYCxtkyjR1vly8NkSmOmJFG1OMesK6p+C/zfLHN/sPd8kbczb7aKbJ5qPVp+q1ABD5LuPeQ4Dqi0rdudBHa3proX/yNGphumaYVSXNt+diR/QtB6yy0bli99k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838092; c=relaxed/simple;
	bh=qNze35MgPi+5knen13lYeCLPF79RoKcrJIbb4HcZvrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEazvVa6jH2LjXePY/OvrsaJzLGrlpWM/jrzTj09Y5VD8+cT5bzSATO/hZnHP6ZOkeFdjibsugOS1nR3ElGqfymYTt7tUa8OG/VwVcxC53YjGnb7Ay7gywHkQXP2hZg74ld9bnGtvRQ05XW5/cAe/vNXVyebGO4eDEyofnD+Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9im1IQu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9im1IQu"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74af4af04fdso2645214b3a.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838090; x=1752442890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHUkZQwyNfT9bd2zYgGVuigW8XA1GHIA7l3jy9szCqI=;
        b=R9im1IQuvLnpgok3ergxRhRPm4EsCBHxeOE0Y0yNVxiYLlleG2ZTz1DlID+NFeTWRk
         W8gkHr2oYol5RUxxXOYeGPe3E2IBWZPfS2Dk9XebW8yDXJiMFouiWuVqNCU9xO4zqLzS
         iBJB2ulmtZdQJokDE5a/A7boQjcgImb6loggG4iQ/8zK2/ljZeZOmw4j75VkBTeFr0dR
         31r1cc8bAH7xGiBMThZiACxsP84VYSUTOP4GH490w5jMbDmtedwK+G4Ap9H7p6Gzvy0q
         2Sl36M/UyoeiKFGbj4YhNjhKaxYlEc2b0Jp/bpq36YAefukmo6y4EbTytQ3dqFuQ1wBQ
         5iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838090; x=1752442890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHUkZQwyNfT9bd2zYgGVuigW8XA1GHIA7l3jy9szCqI=;
        b=p8me+mKP/bSxTxxgQfTzBCDmeynedo2h70qbivVBBpSzzL7m30kCU3Ry+OcTIIMRXn
         CxEPtJjsErjyFE4llUKnZ6vCCWpg4svJFmQH38nvJZYLLh5dpLOPzAW1NBNMpxwXUYLA
         2PiGx5su4Olg03s7Q6TL2RAwlOXO+zEiSuSOeSHxacJGxJ7d1ImsDEbRsn/z1+AhZsNC
         TQ3pD/asKPANuoid5vaPTmhSpyY2Ic94BUQbj4pjt0/0aAgYYVuYfKXFYHNPgG+oocdH
         NS7mZTCqS5K8R7YgpYfG7xeyzem+azfhZ2HMl/5TREpxUzuFL3u9W8c5zHC2dnM63FhI
         daZg==
X-Gm-Message-State: AOJu0YxH8v7G9DPRk4erPDXg1DJl+1Z59EkqnawGiTrhWC/O3OQHrNBN
	oru511HNbRBDUw50qV8ipkL3wMSG2g0MrIRhzsaMgJrOCvCvhJf7gaYk507lA/dp9bw=
X-Gm-Gg: ASbGncvBbHQeZnSKP+K+cL/jMOeZt5dvitszKe/2mQghDxgd0pv9cRQ/LjJH2Dtxhyg
	7aTaj+YhL0hfkvPrE2HQl0ykpm3SZ9iYWXpkPOcjbPNDKG1PoGpeTlbMj4GTP/DNbkjggswBVsn
	MN/zgukh+WjdAApLuMbAFcKFfpn4qdCSRd8O9et1XAMT6lbrwsUrG8SQJNMSXgf/yZRpRmg1zza
	mXP7f9OAyTMB624hsNTU4g4AFDUiiph/7OOSVTnWEm3+qq/cAZXJWKPO8EpEdGz/WrZuSOKVce2
	rH7qW5n6I40V5vB16jgB9qKFz97MdB0Bmfo6fR0xztHy1/kD1lENEb+S3XSsliQ2/6UwsN2GGr5
	dnEfbdsiepw4=
X-Google-Smtp-Source: AGHT+IE6+K58ysIAEwTR7p+T4nAO+HFF0Uc8d87gpbeVesi8ADw/+3tRPWzxR2nWNbUuvZNrgb0kWw==
X-Received: by 2002:a05:6300:4c:b0:220:9512:9213 with SMTP id adf61e73a8af0-225af73fe9dmr17107973637.15.1751838090524;
        Sun, 06 Jul 2025 14:41:30 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:30 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 5/7] t/t1517: move send-pack -h test to t1517
Date: Mon,  7 Jul 2025 03:11:06 +0530
Message-ID: <20250706214108.714499-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test 'send-pack does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t/t5400-send-pack.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t1517-outside-repo.sh | 7 +++++++
 t/t5400-send-pack.sh    | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 5b4373f8cd..a140b5cc38 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -142,4 +142,11 @@ test_expect_success 'pack-refs does not crash with -h' '
 	test_grep "[Uu]sage: git pack-refs " usage
 '
 
+test_expect_success 'send-pack does not crash with -h' '
+	test_expect_code 129 git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage &&
+	test_expect_code 129 nongit git send-pack -h >usage &&
+	test_grep "[Uu]sage: git send-pack " usage
+'
+
 test_done
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 83b42ff073..571e8f1bc5 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -55,13 +55,6 @@ test_expect_success setup '
 	echo Rebase &&
 	git log'
 
-test_expect_success 'send-pack does not crash with -h' '
-	test_expect_code 129 git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage &&
-	test_expect_code 129 nongit git send-pack -h >usage &&
-	test_grep "[Uu]sage: git send-pack " usage
-'
-
 test_expect_success 'pack the source repository' '
 	git repack -a -d &&
 	git prune
-- 
2.50.0

