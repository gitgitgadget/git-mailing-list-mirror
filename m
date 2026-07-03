Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B593D47B8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083549; cv=none; b=AO7xkyzAmfS+RSlj8phPbfN6BuYhOirsRaIKhhpMai90ZBU2aeJUkJzHc78H9f45rqy97d46ftCoUvr2ePDlL0dAxrBYvcrskEmAjBUPLvSEm4iaJAtUA3Ke5TDCYYMhKgkIVLPpVbdpXnf8Y6RT0FQ/YAgif3hxfdtmI6IS5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083549; c=relaxed/simple;
	bh=uwWTh/UhT2irJ2nsqKuj4esDW75vTVpKp4V0uFP/qFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTSYnrSXo/mtvIf3Bs51d/f8QYia3ksM1UwJZTQt3pcmm58DT2clCd4SlLqt+w8RBa9xVc6KzhETz7WOyYGm2HzSfH0TnaOUDnJU3yrylnxq7qldFitMtxQifYzTlaHedsrwfZsxiLGR3+5slz2mvo70Qo6C3DLnnrEsuIx4Rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PxLrQQ7B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jecYjhBJ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PxLrQQ7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jecYjhBJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2EDCF7A0105;
	Fri,  3 Jul 2026 08:59:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Jul 2026 08:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083547;
	 x=1783169947; bh=bj+jwxk+fRARESHZIqNNEl3MGASpmhf9EIGerU2LKp4=; b=
	PxLrQQ7BaDvftTZW/FJv61WFqBhpcYKa0EkaeC5ArYZLGfuYO60BK0Il8Jx5XZmM
	qpaMTeswVrKX+cyYww9FaQGRvp4QS6REPfu0at7vHYoWTlDE8h2RJhJlkxoa1cNC
	2EH6bkZR7EmPuoWNnvLLqHkM32y3MNOOTQ+y2QumnNq7mQKGT/EDgmttWEcEAoLw
	UlA2ZuyC9UJdkCs9tqmHVgA0pD6V2AKnqAqr510tKFa98MOSlvWPGgcrnvRK7jvr
	QL8h3xR42BH6FGj1kWdgINVHBZditImkNMV5TMS7ttlKFpYFBqicv78KAEuFOC5u
	gf7O3Xo+1twoyc5SqQFW0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083547; x=
	1783169947; bh=bj+jwxk+fRARESHZIqNNEl3MGASpmhf9EIGerU2LKp4=; b=j
	ecYjhBJ4yCk5hG0vowszK4pY4R58SpYxU6OAhJJ5n3yY48L0gYsK8sZhPYau3dOy
	8H5KhNarrZ+OEcKvvJ8znY3bYUvRFbe0Xl9meCbPbhk3Q09tzFyX0wzmtyAZmWm0
	mSjx9JH5ALhoQXXZLCvr1oIl1plxaYyn0y22ySM+2SuZJFJTEhg2AMXkEmY6F6Ou
	zyER7xEtfMK2NmvqekNqf6eAFUbGroW81aNasumcL3+jslYmrw0PJCBFoDdu6aKF
	8xuBJKFSVut5zef587jXRnYX1mq3oCEFyk0CgOzJT9KDKCIVavUPHlNM3u5KhYTF
	NURB+fcVbVmX+52mOg0iA==
X-ME-Sender: <xms:GrJHakC87OIHf6mzpPMVGe5vRkJp1IGQkUyYYL0tSsy80WUSbr86Ew>
    <xme:GrJHathnHL5z0cmfGThQdxvquhpjtb0vOPTREOQMajQmnoOiu4hIEIyfqnq-CSgQv
    gga6-x8j9phUH1TFirDD3CgNM_7LqmZ70RmLkhQR1qhqI7zRuHj>
X-ME-Received: <xmr:GrJHaslUbvAMZtyEYDfyCVwOzQGTZV3RztOXEgAgjzCmK5Guc0sQ88dzUqmDTLQxD588G0uwNhWisgg_T-ocVL2rqK7PKv-DRuiYjRmUcA>
X-ME-Proxy-Cause: dmFkZTEnwvHVL/02oA1h2uWNRZvjgjI9BD+dkxtOdLwJ8hgL6Y0qLSdb2NnWfTr6UNt0dl
    rwcoArYQ53f/0Y1FZHpBSRkzqgsnWJdFO56zP44BeEklSg+tOlFA8QUvWfYVi08L7JDXBX
    C0xy2B23fAAi9AWPhME0flDA5F0trsEpHLxNt21heC4fvk20kF/9jy081ZaZO/gfwY3ch9
    2xOOalj33Pq3zJIZLRyMR9G4D6StkfivX9t6bDBrNuxuuWSBUGXjxloUjOXAUCWNsmPY7p
    s+5SDmDTgvFsrgvtN+2U/UQp4QGAIPVCHjlaeXB5lhP/4PP+T0wy8yw7e67gBqEG1Egql4
    ynnB0OmXeK59idYaKLU+yZJRRzC62SEBUcwaQF/TU2it6vxrN97uKBe22UAaYNT4p1k+pN
    k0jOA5RbrQPQnltw4zlcYmD2EIEr590NHnzdjbD+Da/flRqW28jPBS8Wta3SBi8huaiVsv
    ZaWpihVGqfJQ6aNGj45ypFstsjx60dgANUFrC6RZycX1YCvROYACE7p5Xi97+neh5UeLCp
    drRMi/WJKLIgXJcd4wqGTvZ5Q2dUBs+OF+6AQRJVenSNZyjoos+EujLnNJ/wnPX1G+Ys2O
    EflNke2xTPT4KLFB/3hKLwxaGUl5UgcmVDtACtg3BZvhoCtCeH9B9VRfhNaQ
X-ME-Proxy: <xmx:GrJHapq9ks8Hvdh0IYcea-C7_yunoqSSuIiBcToCcpDKGOQsXxOI6g>
    <xmx:GrJHalFMDDuMg6edLi8EQOYDQZG3Lu1OzXXOeHSpBeVhZcZ0jidAJg>
    <xmx:GrJHalySDxi46szOBjbuIV0hnfx6pw-FQUAB9o5rDzgFNB5DKfEdkw>
    <xmx:GrJHaqoM23iYLUIn39R7c9Ew-IglRR_SJxXkiOr2v61Hx2gqODLZbQ>
    <xmx:G7JHas6z9CuPguzWNqCQTQJx6uf6nVaYPP4QD3SVpoUL8du1Orxgkbt8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:59:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ff09fe99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:59:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jul 2026 14:58:48 +0200
Subject: [PATCH v3 05/12] t/unit-tests: introduce test helper to write
 reftable blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-pks-reftable-hardening-v3-5-b87c555b9920@pks.im>
References: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
In-Reply-To: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Introduce a new test helper that allows us to write reftable blocks.
This helper will be used by subsequent commits.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/u-reftable-block.c | 47 ++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/t/unit-tests/u-reftable-block.c b/t/unit-tests/u-reftable-block.c
index f4bded7d26..f4e926ce3a 100644
--- a/t/unit-tests/u-reftable-block.c
+++ b/t/unit-tests/u-reftable-block.c
@@ -14,6 +14,31 @@ license that can be found in the LICENSE file or at
 #include "reftable/reftable-error.h"
 #include "strbuf.h"
 
+static int cl_reftable_write_block(struct reftable_buf *buf,
+				   uint8_t block_type,
+				   struct reftable_record *recs,
+				   size_t nrecs)
+{
+	struct block_writer writer = {
+		.last_key = REFTABLE_BUF_INIT,
+	};
+	uint8_t block[1024];
+	int block_end;
+
+	cl_must_pass(block_writer_init(&writer, block_type, block, 1024,
+				       0, hash_size(REFTABLE_HASH_SHA1)));
+	for (size_t i = 0; i < nrecs; i++)
+		cl_must_pass(block_writer_add(&writer, &recs[i]));
+
+	block_end = block_writer_finish(&writer);
+	cl_assert(block_end > 0);
+
+	cl_must_pass(reftable_buf_add(buf, block, block_end));
+
+	block_writer_release(&writer);
+	return block_end;
+}
+
 void test_reftable_block__read_write(void)
 {
 	const int header_off = 21; /* random */
@@ -381,25 +406,13 @@ void test_reftable_block__ref_read_write(void)
 void test_reftable_block__iterator(void)
 {
 	struct reftable_block_source source = { 0 };
-	struct block_writer writer = {
-		.last_key = REFTABLE_BUF_INIT,
-	};
 	struct reftable_record expected_refs[20];
 	struct reftable_ref_record ref = { 0 };
 	struct reftable_iterator it = { 0 };
 	struct reftable_block block = { 0 };
-	struct reftable_buf data;
+	struct reftable_buf data = REFTABLE_BUF_INIT;
 	int err;
 
-	data.len = 1024;
-	REFTABLE_CALLOC_ARRAY(data.buf, data.len);
-	cl_assert(data.buf != NULL);
-
-	err = block_writer_init(&writer, REFTABLE_BLOCK_TYPE_REF,
-				(uint8_t *) data.buf, data.len,
-				0, hash_size(REFTABLE_HASH_SHA1));
-	cl_assert(!err);
-
 	for (size_t i = 0; i < ARRAY_SIZE(expected_refs); i++) {
 		expected_refs[i] = (struct reftable_record) {
 			.type = REFTABLE_BLOCK_TYPE_REF,
@@ -409,13 +422,10 @@ void test_reftable_block__iterator(void)
 			},
 		};
 		memset(expected_refs[i].u.ref.value.val1, i, REFTABLE_HASH_SIZE_SHA1);
-
-		err = block_writer_add(&writer, &expected_refs[i]);
-		cl_assert_equal_i(err, 0);
 	}
 
-	err = block_writer_finish(&writer);
-	cl_assert(err > 0);
+	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF,
+				expected_refs, ARRAY_SIZE(expected_refs));
 
 	block_source_from_buf(&source, &data);
 	reftable_block_init(&block, &source, 0, 0, data.len,
@@ -453,6 +463,5 @@ void test_reftable_block__iterator(void)
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	reftable_block_release(&block);
-	block_writer_release(&writer);
 	reftable_buf_release(&data);
 }

-- 
2.55.0.795.g602f6c329a.dirty

