Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C535274B29
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752312955; cv=none; b=CaQy1+x/ZxYcFGmZe4aKYlox0EZXXxSlwGdxX3UP7bZygQowBjYQm0fzJMKqSaIlVHyP+f+rXjgXu/+up2WCVSFc1G424xeQ2v2dzCEx/Odi6GM18B/0Kg9aTTL1qy9R5S7zt9gIV2vvGRJMjpbipltgoLvaT6H7PWfeM5OzV4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752312955; c=relaxed/simple;
	bh=5AKyN3pvuiSuVg5v+a+GuXiykW3BaNXvtvWkPc0myEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdCnD+3mWeGmCrY/9nciSpeU8W1KEQ6Z51oLqqLB/4WBvpItAqeIYiEh9FDlRV5EzUhl1BtiPnsP6Yh85p74B3ZVmHuyqDDLy+ircrXxvkMMXIcqcnQpPKl7TLtQNI9rd3KTFs/JugtDVTnlipLjKbcfIMyqs8DK1oE+lUckFC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViEuNpA3; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViEuNpA3"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1747956b3a.1
        for <git@vger.kernel.org>; Sat, 12 Jul 2025 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752312953; x=1752917753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDOJQ64Npskgg6d8O2YWaLOLEIE4L0hBZpKtZ9+ref4=;
        b=ViEuNpA3s4f3uRQ4rf9+LX66dKNnY7ryVopxEz500FQuMjfzu2/gFwUwXsQPZjN0ow
         FkZZaOZDevjobEL6WKLHn5hglRK7Fyyw4NsTKjenwih3YqJU2LxTO26aHvltP54bEccZ
         phbydiSsfdRvEto0ULiiDyj2PC9QxEsEFWYfi1qDGasIe0DOtLoYXIri1dQFdJ2aBYuP
         GH7ZU4eXI9eHAqSyVlesMD66cJvDSHID1R3uejIiCgBg+0PUtEgCLkIwnHNeZsybjIP3
         nDJlSAbR2VLqKzyjjAptZK8Nqyo9S4JOODPhOeHMgdm4ZKpWkwiEK41HEaJOcwm0bFgI
         HfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752312953; x=1752917753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDOJQ64Npskgg6d8O2YWaLOLEIE4L0hBZpKtZ9+ref4=;
        b=dWKKdszy1yqPABE51VbO989gMiQXSxTxWHrnMSgeeQWk1NEi241c1ibnExB1dmIh2n
         xJ9zV2AmM6mPjesOumI3B+J5I6wNxGm9Xc3FvXnOi7AKoRZkDclSeEmICp4huoKe/aDi
         lEDq3l1Jr9h5rfgLVjRty0zq7OmsDYAYZ7cgSv6lQEg1X2zG4jBEZZahQ6b7vOftZWaI
         7+zaIrzrZE5KN+Va+mbhXZgIAhgkFkEhMR+GkiEPJjkqgkYGHS6X3dSDV6ZHehUpYF2z
         pBsKlnbJv8Izbb4+rLe34hv0YIC/hKb8uHdimtqLDrdamstRU9BEgKi8ePt4ml/eMPaY
         KJhA==
X-Forwarded-Encrypted: i=1; AJvYcCXX21AzxH0Zq+lkec26CiksoBVj5gUIuCNeLzOoLS9AYrSKmn2kJv8Ad/JWrfr3d9ogG2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQOtiRXCsRHrgM4yaG2bSrzTEMwGabX6CS6jxTevRAmCgi/mIY
	qVz9ONL4ZVnyJX2iZ/JuFE1pT2zSPNlUa5v7Z2VFXSj/CkaF+JLTZnGl
X-Gm-Gg: ASbGncsdRt+Kxo79MptsLYX7z+NAdDVPD4aLMSZWVVyfAE4bmq/L0gXYm7YWXCybjPY
	gTo7mmRT1KxwRW4k0UZW6T1PXEnJnE+rCpFliVLm5aQFVJHmrjTNJLL/jzoAPFAdfPZtQGy/h5c
	VSdilZBgGil2+ziwuuIPBc1HSh8VxST+5ljqqtky7GpEWro+Guw82ztniLRLAcs0PiJzWNOBHoL
	1SZ7I/7CZ/R88HhkuLxCme9pCC15sZg3JmWqHPT+RKEFJCl17CTSiJZ+N1K4iCMR5B8pqrBfqLm
	GUESQjEJCcfJYuVGnjBsQq4d7mf52IMZ3OB4oAF61sWSuL3vItIZ17jTwZgMpCSb+anwu7GTVCX
	MHFtklSilAsGgn0fYoQWHdl0MWaLYhqIHus20jJJHs1CaEl8SsR6eK6rnppchjUGNz/MRDrDKic
	mBAAHT7s3pp1CA3sGCc1Tpxpjps/36ZE8Ki22bzY7D
X-Google-Smtp-Source: AGHT+IFLWaM+PePbnJ02NXuVt7sBkbDYTK6f04rYxcJZpOQ5EAH+nebZ8/aYL356cnE3ztQh4C/26A==
X-Received: by 2002:a05:6a00:1905:b0:736:d297:164 with SMTP id d2e1a72fcca58-74ee03a0d90mr8617599b3a.1.1752312953248;
        Sat, 12 Jul 2025 02:35:53 -0700 (PDT)
Received: from localhost.localdomain (awork062176.netvigator.com. [203.198.28.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b43dsm7126997b3a.79.2025.07.12.02.35.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Jul 2025 02:35:53 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com,
	stolee@gmail.com
Subject: [PATCH v6 1/5] bloom: add test helper to return murmur3 hash
Date: Sat, 12 Jul 2025 17:35:13 +0800
Message-Id: <20250712093517.17907-2-yldhome2d2@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250712093517.17907-1-yldhome2d2@gmail.com>
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
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
2.39.5 (Apple Git-154)

