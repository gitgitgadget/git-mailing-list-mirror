Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DA1AED37
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637547; cv=none; b=DLsL3JumA3MkgslMioLH768F9vHIKTx/tPNStkwPpXB8CY6e25PXN6GKGzfQf76Smvk2aX2W98TWyLmrPFYFSV7hcwe/7Bk4XbwyPUvJ23NujbmEBApzZN1YrjgNV+po/HzXG3UC3kjTyiMNAY/+Mhdg8NJ1LK5E8jKb2lT3lxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637547; c=relaxed/simple;
	bh=46spoNG4u9mAlTmXupv1e8rIawPDMsH9kZHdBrZQ3gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiGQLvFk/vzCzOk1VyEjVTDl2oWm/PkPo2eixuVIwhfDHZ7MKHKNsGA/bzM8BEL6L3mPfao/q6UCh5BiSJWMvR+bHK9zpR4woIOGplovIrRyzlATkqtnSSST7cQ8+Kjf0ysF6iYqk/UC1D3quawWu+nCVkAwiJYjtAmqr4VdofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXAP1rwJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXAP1rwJ"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so5232844b3a.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637545; x=1724242345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tojuI0+mu7UKoZesL8YaT3fhKoLlaYzvyRRQYad9BGo=;
        b=iXAP1rwJU7Y1udV2FBaq7gRENRcLFVSR2Tx2+jeorca/7/mx32Y1tmidIp909d/9Gu
         2HT7xwKVej0GAgIPjpT9jNnMa+E6uwVO4Wqgfx5x03tCl0+37kohldOUbfg4TTK1b/oX
         sQeTHmSBkyn8BYJbFIDwJQYhuizVmfcA4cWr7faqyTEf3u4jWot5a9h/Rw5PoXujzcBq
         NcKvjmY8J2m2J/D3v7mdA+ydhxFiW43pcEx6/47Z6CoRgvRHTSgLXxYWkJMjNMt9TNFO
         +ti5ohUQ306UnEUVp+YgK/6jR9GBn0bQEie57gavDaWOWfI3VfszkjCSaxEpdYHIDAfU
         rtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637545; x=1724242345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tojuI0+mu7UKoZesL8YaT3fhKoLlaYzvyRRQYad9BGo=;
        b=CzVevXk7ysmwB/mOdvbXpOWDpejtlL61zqYrOZvmWD2NpCG1We97EpKmZCjoF4bINR
         bSQZ+YSNLBO2c4mgvayNCuDqzF8wf7/+7wt/uSwP5sbIsc6KXtQLtXzqCQ44DBMVc4wi
         aepTBjMf4/K0IAPmbkivReNwnQu8uJv5boHhREyz2j1/iRG9acwWAqIztvgR/ogSL/lP
         rNNdsUR6VsEzSgpQ5eyXGnUPhf0bKjuoQumeDIWp2ErgMT3GgNByWbyK7F8vfzp5oL9C
         ei9l+RcUECA05+73uCUwPGsPs+KiTD3Tcv7sdAPSND+3GSfHn4T/p0YqnR9Gm6bk8zeY
         Byqg==
X-Gm-Message-State: AOJu0YxWRHmkYKQXTW6fmYY0oXBgs/mMqgbLAuFAyLU+TtrsO5YiDwu0
	69BUZXnYaRFJbiavXRy8Lc/A1gB4eXAi3GhYeA1wwlkP9n6jEZBN2WCrwKo48I0=
X-Google-Smtp-Source: AGHT+IHtyXdw9VpLRGQFS91cu8dGzirlGHtWJ07TV1QKDCR5BMf0Z9rqdLS2mdO+CRJ+lJTeiM5iAQ==
X-Received: by 2002:a05:6a20:ce47:b0:1c3:a63a:cee3 with SMTP id adf61e73a8af0-1c8eae6f3b6mr3431933637.13.1723637544777;
        Wed, 14 Aug 2024 05:12:24 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:22 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 06/10] t-reftable-block: use xstrfmt() instead of xstrdup()
Date: Wed, 14 Aug 2024 17:33:14 +0530
Message-ID: <20240814121122.4642-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use xstrfmt() to assign a formatted string to a ref record's
refname instead of xstrdup(). This helps save the overhead of
a local 'char' buffer as well as makes the test more compact.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index dfb7262a65..d762980589 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -44,10 +44,7 @@ static void t_block_read_write(void)
 	check_int(n, ==, REFTABLE_API_ERROR);
 
 	for (i = 0; i < N; i++) {
-		char name[100];
-		snprintf(name, sizeof(name), "branch%02"PRIuMAX , (uintmax_t)i);
-
-		rec.u.ref.refname = xstrdup(name);
+		rec.u.ref.refname = xstrfmt("branch%02"PRIuMAX , (uintmax_t)i);
 		rec.u.ref.value_type = REFTABLE_REF_VAL1;
 		memset(rec.u.ref.value.val1, i, GIT_SHA1_RAWSZ);
 
-- 
2.45.GIT

