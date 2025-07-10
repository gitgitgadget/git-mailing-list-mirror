Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF6156F4A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137329; cv=none; b=g7595u0RigUbuJ8jy+Hb16wN4i5hO8ZPc/SGE2SFl8rIUji4RJWBTqPDmRNoYEqk1frInQft3LU2Es5cdQ0pJBfhA+LQ+3vCpac0Se/NE91qqj/KYznZB7+QSvjwws062C436xdrmEWQ9+vwZgoDX3HePLPxkDq0xdkTIlQGDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137329; c=relaxed/simple;
	bh=pNzUiiKWNnJq9VRfpitz61s15wgIT7EjPXmLDdpvBXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMGZc3NjrZaE4p9hl6Y6tkYuMdmpEg4Fd0uM6EVgiPjl5noCPexK8gi20kTCvgEsC6zYp4Y6VIfFsiHtd/P8BpfzEh5suWVpDe/L5XngHPl0Z9PorKhh6a5gI0Xjey3EuTuOviPcNa4C+mzgrdrO9WKeaJLfhHtBRxF4HiTtzfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ap8gc9cw; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ap8gc9cw"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-749248d06faso670854b3a.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137327; x=1752742127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VuWZAKL8LlAnNKhHzBQScgConp1Pd11NDyAa/432yGI=;
        b=Ap8gc9cw2i1Z3x6WxPojG3hezgL9hVnotPzmJhmSA94pIWqQcLP8RIo8MvytYaXPEp
         E/Ad6nbTUMKTvTQM2amxFqoUqOsTZcH33JIO2xZXV8/FNIWEFrPANmB2kidBrRR0Q/1S
         AvpK8TycciynQgWCB42KRt7m+162ouH0fkonXFvQb91mwSVfhCyC2O5oL7mwNRYN+iCp
         8uhTkzNiRGru9QgslfS1Bx7UO3MaCwR3VzO4aj5f94hmW+92XIJkCJc5/cY4ymhRlHtA
         6FPQWnXMEJjPjij1t5O1J8W8j0UV3Y37ceAY0OzX0KxJnSyu6tS+0frO15P01e8YpQpD
         PNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137328; x=1752742128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VuWZAKL8LlAnNKhHzBQScgConp1Pd11NDyAa/432yGI=;
        b=hgRJvqvRdBeVjs6W2foliz1vdjqWx1nYIJ1ne8cZs1gPFtdnheTI1hnU/MvdU8Fd/R
         gj5BCeKovngbY4/NvzjiQjdnTp93mVeVvIjHnvGbLI59TN0aGqTSiZ+37xnnwt1E7Cah
         yYZr6qWVBRT3hCg71kJE2ZKOuHHOrLAq72NAPcZU//OHbhIn6h7w+xjPFfJbW9dAKvlY
         h3aH8WGh5cgni1G/AHHFlEvvUD9Z5Jp7g1jNqx6Yqz7wxvpqRT9cIqpRvkEWwrVZz49m
         k7P/tBAtyBy7HnOSZoda/GgCU0Cdk0DgQPDMACy32AsT+qdZAB6eHIpSMHm1WhOMgwPS
         vCgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3tjkhnKEkZCOSFv+Jr/S2QJQU7Er+StL+TBoIkOg0QAzm53YHUe8lo8tQWQU70xm1olM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqinGsVTV59TelWVSuYiGy+/JgSJIFc2udGX88YWWbWM1ASm1
	EJ0uX4EhhUmphpkOjmWfzmS0WCgETfQx6JJxPzzivwvCPUc67AffeG2g
X-Gm-Gg: ASbGnctPv2qYYHzwiXWWobTC1tb+MESrGXpFo8abgPhR1yiWg/J33Qsh2jgHVh4SQxJ
	2CfnYD0vtiVP/NaCaz86CoViC6bEPaPz/8Ct2TQXMPl3u18x9uB+JK25AjvyWOAemIiffSwFWLU
	TSUc7N0i6eYV8zif4ZtnjRRtgaIeW1OYllp3S4XTYdNhiKypwMZKHhIRhIjBTpgszEEXg2GPIz+
	0P3dFDloKMKrhGV/h9M6i3WA8zmLKQGbQhV/3usnJeJ/jpQT2mS/Bwz3MbQSIc4cYgsnln8JGp6
	GL3U6zLyB7pXXy7htE6Uet7UtBf9rbipiuNR10KWvdpHX7pf6OZsTMknsVL3OpesvRn1
X-Google-Smtp-Source: AGHT+IFK4DVPhiO53MDrsGd0PLOQJj7hnDSBIi1/J2ZIbF8b9o7pgVUJQGOZ0Z9xhZxnsQ7Kwwc26Q==
X-Received: by 2002:a05:6a00:1988:b0:749:464a:a77b with SMTP id d2e1a72fcca58-74ea66d32b5mr9433618b3a.18.1752137327535;
        Thu, 10 Jul 2025 01:48:47 -0700 (PDT)
Received: from r760 ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22d93sm1535777b3a.89.2025.07.10.01.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:48:47 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com
Subject: [PATCH v5 1/4] bloom: add test helper to return murmur3 hash
Date: Thu, 10 Jul 2025 16:48:26 +0800
Message-ID: <20250710084829.2171855-2-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.110.g198a7da17c
In-Reply-To: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
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

