Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7A42C15A0
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627696; cv=none; b=C5NOAO1gcOmPQvfR9eUoSqd1yF3Gc16WXGaCXLU+mQ+AMM6vVoCXDO3bXfzsazSBUjPyOGP6v4R5W1iMBN6PHIcNHm/fgjXkvuec/NzO4dsL2C1/976KbLHkbMFAdeLCHyLj30Q9yut/2N2I+JBd2zk67c/MkOa5R2epxEmQKsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627696; c=relaxed/simple;
	bh=pNzUiiKWNnJq9VRfpitz61s15wgIT7EjPXmLDdpvBXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YT6yCR5QKOfKINUJd6hQroXI3H26gTv3+JivCb9Rq5YMxXcQjUAojUOVxbzKhAZ0Cpmb6z03ghUvEv5rR5+DUxrG5PdvXZgvxYkal9AfA01Uka5DA+j513HgyuzQKFhf7jrPaSt7uvi9SsLVsv62H9n4xUA+p+be6sCO0FctIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu4XEfJZ; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu4XEfJZ"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso1270216a91.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751627694; x=1752232494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuWZAKL8LlAnNKhHzBQScgConp1Pd11NDyAa/432yGI=;
        b=Wu4XEfJZDENSF+LfVRjh7cBBoS6RgHOY4Xnc29O7nT1+uxnXW6zzYsM3wa5WV5gWdC
         wUjBfahDCRJhF24vyhcaa83pNvY6WroHnivGr2tDSYtmN8Yyl9MIpVjJ0rBED7HQqrns
         TwVh/8JOBMAizT8k9r1Fu85tFzDjA5c92mKzSjDUebHzQ+YsMVIW4pRDJiJc/WkiwyJc
         ouqeBNNZWmtIKO+XmASbW6djhXj7BxHguew0aveBI8CR49MEGo4DuH6eKtR1aP0Egj0K
         gp6iCbIgw0PEgASFFrErJBp4akluqO8QwOOdNsjstSlflFEIqdyRFNGWXpk2Ccbt2wkS
         Zo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751627694; x=1752232494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuWZAKL8LlAnNKhHzBQScgConp1Pd11NDyAa/432yGI=;
        b=hgEZuQITsbHm7DAq/V/fZLzdp2Tfkxfx5aMDcwUKP319K39jVo7tsluU2gSKuL5jtK
         sC2vuCOoU3QwxH2nbKbYt/gvaj7ttDwQCCvFaUbtMDlAucckQKIC4mO9SYXh0DTM2P32
         SNkXixPSlkHYU+ueuTAzi1mYwNVS6H8hmMDHIXBRoQBTA9061Z+u+KwYAs/SfLy684x3
         Ycj0urCopHPP1Li7Mht2gcsODXFX24/L/O1Q1+dCixWwyXwXv9ia4ycquvVxTPzzjmqx
         TjGoFY9fdxj+lvMnM+h1bViBU8c30Kj4QMR4/mNAra6HFCMlBKXJ1C8kGEjDHFd7rOJ9
         /Ijg==
X-Forwarded-Encrypted: i=1; AJvYcCVGHige765V3P7Aro91y7rlI0U2AE9bdtqh+5zYQ56PZnR18FdFklahK/CRBLRnhag6ZvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyAsWK5i307aEKtCcQtek27bS2Bwa+/oCX+2biKCReAZowH4Jw
	pUnyJdhzxxI3DMHiusc7O7pycoXFo+WryX30okJ1Tb6aRE5EEsE+Gwm0jRRLyrGU8eRvxw==
X-Gm-Gg: ASbGncvRdijKuT2ZW+xjokJw5fong4diO56T0kp0loSmwLN3mozT4PZMs9NIvzBMU6K
	tWPFuEXIHYB79A4VR7GtL0TbR+PV1Yf9MxbtGT/8+DsO5zS70d+/O9IDfYshi1SEemsUdDJ8Aca
	IoFowiE9RSVAOr882dcH67dRQI9Z5vXfrWwLPV1grnS3EhMNx4Tpc0WaWK8zjiYWQ6DAqlK0By/
	mDhV9VzVlVwPoZDsGC4tZLiXA7AvA+gipWqq4du2rQc6JipQ9wmfRPTfe1Aakal1pVXx5ju74Sn
	gilBdjNtB6D6hdKDxd9wqYVap8KvG4inWYD6vtZZKY482IG8dcCFaVI80+E5oKHSMeZK
X-Google-Smtp-Source: AGHT+IGMBqXzaienZf9CnyUrVapX5p5oP1Z6q7vFkeThEAMPw5/6/rO6RdZUC90jLg2lnLKEVvR8cQ==
X-Received: by 2002:a17:90b:3fcb:b0:313:1ea2:a577 with SMTP id 98e67ed59e1d1-31aac4f0653mr3440586a91.29.1751627693610;
        Fri, 04 Jul 2025 04:14:53 -0700 (PDT)
Received: from r760 ([188.253.126.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31a9ccf8881sm4720522a91.29.2025.07.04.04.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 04:14:53 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com
Subject: [PATCH v4 1/4] bloom: add test helper to return murmur3 hash
Date: Fri,  4 Jul 2025 19:14:34 +0800
Message-ID: <20250704111437.2660251-2-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.107.g33b6ec8c79
In-Reply-To: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
References: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
 <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bloom.h, murmur3_seeded_v2() is exported for the use of test murmur3
hash. To clarify that murmur3_seeded_v2() is exported solely for testing
purposes, a new helper function test_murmur3_seeded() was added instead
of exporting murmur3_seeded_v2() directly.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 bloom.c               | 13 ++++++++++++-
 bloom.h               | 12 +++---------
 t/helper/test-bloom.c |  4 ++--
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/bloom.c b/bloom.c
index 0c8d2cebf9..946c5e8c98 100644
--- a/bloom.c
+++ b/bloom.c
@@ -107,7 +107,7 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
  * Not considered to be cryptographically secure.
  * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
  */
-uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len)
+static uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len)
 {
 	const uint32_t c1 = 0xcc9e2d51;
 	const uint32_t c2 = 0x1b873593;
@@ -540,3 +540,14 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 
 	return 1;
 }
+
+uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
+				   int version)
+{
+	assert(version == 1 || version == 2);
+
+	if (version == 2)
+		return murmur3_seeded_v2(seed, data, len);
+	else
+		return murmur3_seeded_v1(seed, data, len);
+}
diff --git a/bloom.h b/bloom.h
index 6e46489a20..a9ded1822f 100644
--- a/bloom.h
+++ b/bloom.h
@@ -78,15 +78,6 @@ int load_bloom_filter_from_graph(struct commit_graph *g,
 				 struct bloom_filter *filter,
 				 uint32_t graph_pos);
 
-/*
- * Calculate the murmur3 32-bit hash value for the given data
- * using the given seed.
- * Produces a uniformly distributed hash value.
- * Not considered to be cryptographically secure.
- * Implemented as described in https://en.wikipedia.org/wiki/MurmurHash#Algorithm
- */
-uint32_t murmur3_seeded_v2(uint32_t seed, const char *data, size_t len);
-
 void fill_bloom_key(const char *data,
 		    size_t len,
 		    struct bloom_key *key,
@@ -137,4 +128,7 @@ int bloom_filter_contains(const struct bloom_filter *filter,
 			  const struct bloom_key *key,
 			  const struct bloom_filter_settings *settings);
 
+uint32_t test_bloom_murmur3_seeded(uint32_t seed, const char *data, size_t len,
+				   int version);
+
 #endif
diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index 9aa2c5a592..6a24b6e0a6 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -61,13 +61,13 @@ int cmd__bloom(int argc, const char **argv)
 		uint32_t hashed;
 		if (argc < 3)
 			usage(bloom_usage);
-		hashed = murmur3_seeded_v2(0, argv[2], strlen(argv[2]));
+		hashed = test_bloom_murmur3_seeded(0, argv[2], strlen(argv[2]), 2);
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
 	if (!strcmp(argv[1], "get_murmur3_seven_highbit")) {
 		uint32_t hashed;
-		hashed = murmur3_seeded_v2(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7);
+		hashed = test_bloom_murmur3_seeded(0, "\x99\xaa\xbb\xcc\xdd\xee\xff", 7, 2);
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
-- 
2.50.0.107.g33b6ec8c79

