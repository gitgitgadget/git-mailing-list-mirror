Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425801E5718
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389852; cv=none; b=l4TMYgAKnrcOIal+dFLq1YtK5z+7ff/o7lUOK/1CY+2wR/aIENUQDI7ABHme/514B8ChxAPpWjJ6Fpg4pN9JFArHNRiwOLPtdVqniIbLVSIXGaCC+mbvqr8vzYUi8N41JcOIqtU0WYCiK99eQHI3i/82WI8F0MJGJPbWLmxLV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389852; c=relaxed/simple;
	bh=E8stDyiz+NUrcyud9n5+dtmvFodKSxLE+9NGeQWkRE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEzVfJ/eTqvGfk+hDGoXMs5ke+Il5lYrZCMt98/FgtF3mq3ryJbtVqK9jkNGk0YBdZ41Y2oPkRsix78HirOAOeEkU4MKOEXj9Cf62wdG7DLJgyzSnoXl70OxlWdFsihoAIdNYYKGGoY5skDhFMRqp0xaVh7oAIgWUgBLvNNQ3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K1zZV+mi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qoY0XxrR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K1zZV+mi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qoY0XxrR"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54E431140225;
	Mon, 20 Jan 2025 11:17:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jan 2025 11:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389850;
	 x=1737476250; bh=Cun4vkj20/ojm5eNaQQ8JI4qzEgi28PUqTp4Nf2Eq+I=; b=
	K1zZV+mi/IYcXasrlYVOGEwQ1vxnVaIxHpxEWLc1EEyuFij/Fay580qAdTL490xX
	4YWKMrOP//Fp6jfWb9gWK0IOWitsL1n88lbTQAtCop4QwWRWkkOgpa2CMEreHDjv
	bY8zkcGEWabImmlCikHqVQuq49wx0d7fU7dJIKzjSEySfaOMrB6Cb9MnwNgdTJKD
	i1769aTAnsM7o4rGuZSrwu6UYtIYtTS6cvSAImPNq2Z7cJuIkb9sXuX0CCV0HKjA
	fXeazfoBthsSwXj8BQzLTKQ2vVHa88W2BV7FgxuI9Lor+rSVTz2b1Dup6R19bp5J
	AioYUvY/qouFi94WSQld0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389850; x=
	1737476250; bh=Cun4vkj20/ojm5eNaQQ8JI4qzEgi28PUqTp4Nf2Eq+I=; b=q
	oY0XxrRvxPwmh8azOPrzU0cZvk3z2uAN43rqrCPqZa7JhSuFugRSALmPzkpTZYJk
	j7g9A+Ur3JTRctI8IV6a/BIw/U/5HZl+jZ7jwM2COT7ODFgWr/VVkGDYAFtwDle9
	L8YIjzZMBz9/HXB+88B+LAU0i/2ZWnO0bUqglIgpb9uk4/B3wQ6COZz71a8aYP4X
	xeMzC2CraZrrp19ky4G0W/MtIbvPnuZRPFv8q+xHlhjmVpySfSWYEBamW3U7AaPf
	d5GgTWOQlRGxK+53wY7Lqy0VuNxsQEqghI7pHwmME9j8heEAdGYWdAYp3v/4ed8z
	SRvTYGMjlXbFwEhY280bg==
X-ME-Sender: <xms:GneOZxnxYJQ1G9oqSFCOkQCmidouVM0SzBePt3_wwQGkRzFwudUngA>
    <xme:GneOZ8055X6B9OcVlzITQ_NVxrcHz9mCD6flEXDE0I6Iz6YbJGQO3sAUB-4UXP7qv
    g7eIXls_9oKYCh-Tg>
X-ME-Received: <xmr:GneOZ3oi5P-7m4UsX_slLOdlQ41RbJP6wg4QUjnuR4Mu0DcA9VCk73crpt3YwDoM1PW38xp-I0FL6JsZWR6aW2OneIkfwjQiB6pPSKPBwEWMNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GneOZxm2d8QKLAKhPBzx41d3W3-Zo9isFfydS7qhduKLLoqBhh91kg>
    <xmx:GneOZ_3C4v1aJmSjd_osvduNUPGqmn2E50IyCStSQ0wpSvIsInT-Ow>
    <xmx:GneOZwvw3nx00LxStuI_tY9ipP7cR0fv_I6agA2QY9men3tLOMRWgA>
    <xmx:GneOZzWoV73ryeFvTCWYS5WkauvYmsBDFPE3rVPxznJ9j6GGbLzATg>
    <xmx:GneOZ9BSsp90PdWp0h2panXZZ1_y4DaC2OI32q-Ck69PqAGGhU3gkRU9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3cde8a79 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:22 +0100
Subject: [PATCH v2 04/10] reftable/basics: adjust `common_prefix_size()` to
 return `size_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-4-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `common_prefix_size()` function computes the length of the common
prefix between two buffers. As such its return value will always be an
unsigned integer, as the length cannot be negative. Regardless of that,
the function returns a signed integer, which is nonsensical and causes a
couple of -Wsign-compare warnings all over the place.

Adjust the function to return a `size_t` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                | 8 +++-----
 reftable/basics.h                | 2 +-
 reftable/record.c                | 4 ++--
 reftable/writer.c                | 7 +++----
 t/unit-tests/t-reftable-basics.c | 2 +-
 5 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index fe2b83ff83..10b234ea55 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -263,14 +263,12 @@ int names_equal(const char **a, const char **b)
 	return a[i] == b[i];
 }
 
-int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
+size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
 {
-	int p = 0;
-	for (; p < a->len && p < b->len; p++) {
+	size_t p = 0;
+	for (; p < a->len && p < b->len; p++)
 		if (a->buf[p] != b->buf[p])
 			break;
-	}
-
 	return p;
 }
 
diff --git a/reftable/basics.h b/reftable/basics.h
index 4bf71b0954..9ff81a68f8 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -169,7 +169,7 @@ static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 #endif
 
 /* Find the longest shared prefix size of `a` and `b` */
-int common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
+size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
 int hash_size(enum reftable_hash id);
 
diff --git a/reftable/record.c b/reftable/record.c
index a55ce76aeb..4a3e019528 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -144,9 +144,9 @@ int reftable_encode_key(int *restart, struct string_view dest,
 			uint8_t extra)
 {
 	struct string_view start = dest;
-	int prefix_len = common_prefix_size(&prev_key, &key);
+	size_t prefix_len = common_prefix_size(&prev_key, &key);
 	uint64_t suffix_len = key.len - prefix_len;
-	int n = put_var_int(&dest, (uint64_t)prefix_len);
+	int n = put_var_int(&dest, prefix_len);
 	if (n < 0)
 		return -1;
 	string_view_consume(&dest, n);
diff --git a/reftable/writer.c b/reftable/writer.c
index 740c98038e..91d6629486 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -577,7 +577,7 @@ static int writer_finish_section(struct reftable_writer *w)
 
 struct common_prefix_arg {
 	struct reftable_buf *last;
-	int max;
+	size_t max;
 };
 
 static void update_common(void *void_arg, void *key)
@@ -585,10 +585,9 @@ static void update_common(void *void_arg, void *key)
 	struct common_prefix_arg *arg = void_arg;
 	struct obj_index_tree_node *entry = key;
 	if (arg->last) {
-		int n = common_prefix_size(&entry->hash, arg->last);
-		if (n > arg->max) {
+		size_t n = common_prefix_size(&entry->hash, arg->last);
+		if (n > arg->max)
 			arg->max = n;
-		}
 	}
 	arg->last = &entry->hash;
 }
diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 1d640b280f..9ba7eb05ad 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -120,7 +120,7 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		for (size_t i = 0; i < ARRAY_SIZE(cases); i++) {
 			check(!reftable_buf_addstr(&a, cases[i].a));
 			check(!reftable_buf_addstr(&b, cases[i].b));
-			check_int(common_prefix_size(&a, &b), ==, cases[i].want);
+			check_uint(common_prefix_size(&a, &b), ==, cases[i].want);
 			reftable_buf_reset(&a);
 			reftable_buf_reset(&b);
 		}

-- 
2.48.0.257.gd3603152ad.dirty

