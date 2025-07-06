Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419CD2E36ED
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751836135; cv=none; b=sJEUTg7pGJi5mUGpO65AoIXShF5sqRJI2v7h/PZcHsAS2VqTI8GOVuZBsr0r0s6g+9+zVgYt+7KT3u6vEEysn/Y+g+uxp9KNvKTtanFxWxXe6/IVkedmZhT947mr9xjXa9qPDOGTsVBz+qYn3XukxnDcycoO+ZieLY30FOMmwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751836135; c=relaxed/simple;
	bh=O+6KPxYF7l6IQ4SZw8lxBuEDj9jDbmuBLJvZVkQQcvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqu1EKRSdluWBXlkj/TODzicyPCvD8eDWXrGWhVHitpLE3W8cBFTjiRZTbnr/Ruq02KA9mGXb3VLNGyeg0B5zYTd/bIREHNH2WSUFAUvzc5bQ8UXbTwd4RQsuTltMqXKDril4XapKaYjJ4wmNGwjLaTo0mxoxOgmASgrE074MX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9TUhKak; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9TUhKak"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74b27c1481bso1424496b3a.2
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751836132; x=1752440932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRWoG//ff0MWiP5lWHpxBF1qdq3rLh3uhRVq+9gd4jg=;
        b=Z9TUhKaku+qRMrFzVaF+EBXGV0j16j+S2EEPVsh3OyWKigeP32hSp5qJDbdIuX3l2N
         DEgrOkvDEmw8rZOscPicPKNCOCvtlmRSjXqAncVg9qrPoew8bF7XEWSo6R3hiXtMNnPj
         HwFpi/ojb2nWw31JS5TVSlaNsPnVLRiVntD0UQJoEEWFLJom3HopogQfxTFnXZVS1uvV
         9Eg2ppuEkCSl+jKZ5i3PFxLMyuDmEBOZIzkv/ayjOVTlW6yeN2eC9yS65nwUNQ43awn0
         0XKWANLLJH1cjAQeSWc3qmzc7orC1a9/ZV/T3yQdwUA2c0vNdMdtjFPxsNqWUrda4+he
         vXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751836132; x=1752440932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRWoG//ff0MWiP5lWHpxBF1qdq3rLh3uhRVq+9gd4jg=;
        b=qocghUt2k6hOLkQ0h5PqhYMFvjqGFmBOK+1+4srcbzZEhhwrOcaHOP9DGYgnjTTvta
         olJvPhTSiuMnQ2qA9mFtLRz9pyaO9+8+9whI0kcJFqEG/NkyJLxXHBn9XDcTiU82V6a1
         p0ulr0PYQiHm82OcsofdSkR6yxYa5PttsMdeIruR2irX84gQS+o/adrCVdgj8YdGy8e1
         +HiJ+SyHolgfwPloVEG9xhobyn8nhRBqNsoQrZX9nCCzoFK4RavTGGG4l9hIdWnWZDDn
         MBf1/mULpWMCpEsy7nsHz+rhzjZwmY2x9IQxVgM02HsloSl5COeXpply7tAUNTH/PBJv
         4DRA==
X-Gm-Message-State: AOJu0YxKZOhMRp9zH8Ic6dqKCwyO8euLHB9WCmNYxt30tvu+lsKrNHPf
	Px5AJxN/v7AmeJW/uhOYW4yLACBLsp0snKwAFVUaAnVfkC+4+j+I1mQB83TRRCxMq8Y=
X-Gm-Gg: ASbGnct2nkUuX/+n2CMS31KZk9H/1FS9Cmkd4rqMPyFsqy+41d7rT16FjyAVEpcyMEO
	SXcvtOBFDMHSzG8843YPmOAyORUIQ7wfI0eW2OH3rEzxBHWeIWhPzYiuj8AmLwM9GIxrrvMmyWi
	tb6Y0sK2/HrUYOTb/I7N/fT3pMtdwTcUbtbW1tDDCF0iXj0iXQrULmyNcRwgJM8PPygdxrMKwvT
	10kDsfLI1BE8sISpgZ8mj9NLLcl5L8RENiMN0H3XN8g8BYDDQHGl3LoV2EZEaYcb0LJf6T2A7IW
	/DvlyF2UbK7PvulF351I212krTqXDNomVMcpWXddoV+rwPhYhuV7+Iyh0KsxT25WkhNSpr5PdFH
	hknDF7YFuKZo=
X-Google-Smtp-Source: AGHT+IF682NZrhiaC52Ix1RdbG5EZ4hN/sm0i6H0Kp0OyUj1y0HsSNZJc963CAtq4VKW5dp7ZT2ULQ==
X-Received: by 2002:a05:6a00:14c8:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-74cf6f1799fmr8548358b3a.2.1751836132410;
        Sun, 06 Jul 2025 14:08:52 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a2c10sm7220117b3a.136.2025.07.06.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:08:52 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH 4/7] t/t1517: move pack-refs -h test to t1517
Date: Mon,  7 Jul 2025 02:37:22 +0530
Message-ID: <20250706210725.79903-5-usmanakinyemi202@gmail.com>
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

The test 'pack-refs does not crash with -h' checks that
the command exits cleanly with usage information, both inside and
outside of a repository.

Move this test from "t0610-reftable-basics.sh" to
"t1517-outside-repo.sh" since it better fits with tests that check
command behavior outside a repository.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t0610-reftable-basics.sh | 7 -------
 t/t1517-outside-repo.sh    | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 3ea5d51532..ffd8ecc0ce 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -14,13 +14,6 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 INVALID_OID=$(test_oid 001)
 
-test_expect_success 'pack-refs does not crash with -h' '
-	test_expect_code 129 git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage &&
-	test_expect_code 129 nongit git pack-refs -h >usage &&
-	test_grep "[Uu]sage: git pack-refs " usage
-'
-
 test_expect_success 'init: creates basic reftable structures' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index e04be2d811..5b4373f8cd 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -135,4 +135,11 @@ test_expect_success 'ls-files does not crash with -h' '
 	test_grep "[Uu]sage: git ls-files " usage
 '
 
+test_expect_success 'pack-refs does not crash with -h' '
+	test_expect_code 129 git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage &&
+	test_expect_code 129 nongit git pack-refs -h >usage &&
+	test_grep "[Uu]sage: git pack-refs " usage
+'
+
 test_done
-- 
2.50.0

