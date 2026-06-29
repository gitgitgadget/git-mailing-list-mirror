Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487BD3F871E
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723754; cv=none; b=FI5y/gP8IQWk8wRyRzuofH8OFUNlfDAd14Pweog0BqQSGvbMqX5L7ilP4FTHiUShH0zM6aoLlWmV+rL3OW/tVgmJFajjG7UJCX5EW8ZTsmCpDwQP+L3FsvgllnAazd4Tyqntxxwfoej5RrCiiedbupftba/uno5tkPLelq/AI5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723754; c=relaxed/simple;
	bh=Ft5u37YF9R2B+FLDm4mg1dFimUWwnUviXjxgYsFPnfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a1dJeIucZATTiPSunjwD+sAw4s2LA8gPVYK7d54jTs0S1W8UEZaP2nsUkOHxnRF/T9mJaafimfEi/ZsOqkZhG3eexWaiGcEDfbKys7VucsC+gWAZlL23YjmRiqQqa91Eijnprd+YJt+HzgvH+09kXH3sHttURP3oNf+XL+HcXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FrepNx5p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UzcK88GZ; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FrepNx5p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UzcK88GZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A296B1D00044;
	Mon, 29 Jun 2026 05:02:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 29 Jun 2026 05:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782723752;
	 x=1782810152; bh=+ueosxQzT7cqRskqeDzzjxfBoMLc+WEKDW0FDb9yK/s=; b=
	FrepNx5pUJSs0R3rKqt2z93iTA74B/rLCYUXI1MmqcIzoLBENYcZOjOZv6M73wDd
	ZB6mdC2lu3iOzQIkpcHsw3JxVjtbXzaOC1/BCmNIq6WvKHRz7i9Dy8iGw0qTdrTp
	8yePHoqgRChZ/rdxda2dU8hn04JIz22jND2uVLTtFRms+93bIPETbzaPXbsfgfiq
	1E4jEw5eSKP4FrwcadlGDgwXbWaz946Hum94x3wEwOn2+KoErsgasBXlAd4HWTDa
	iw5BRHy2/Biiu6WWK1HoCiu80/d1bXfa6nrg6BdpwfA3NchhD1AhEIVZuPm3mfxz
	rrQD+otEOkOo0i+Y2sLdQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782723752; x=
	1782810152; bh=+ueosxQzT7cqRskqeDzzjxfBoMLc+WEKDW0FDb9yK/s=; b=U
	zcK88GZ97yVWdEj6y7DUj/3zBSQad6oOc9z5RyOdKX60xCe9kftEBo41iwHrouWT
	IKASHlJnGXP75Wk+iWXnuPxCEJ90Hwmhecj9DOkc6A3v97JpUWjSJj/0m0fXgzk9
	nGbTxWyYNIJCXXrTLCNyJsyA8iEu/BuydE7rWBaarAJQQwN5ZGU0mcHpebCVg/EY
	Pu5Sr+mHoKkGmYV58mcJO0wOh9rLtQByIrTnvdWCPpnF9OW0p7fUPnmmxaIfMeQw
	Z4vt/nUk6pqaQDbgMHLZ4Q660z3Z1fjdxMu3/j4v8mU2fvkTJaukCBhn7Mr+GYfU
	F5i1QT7U4hfsfPrwK5/kQ==
X-ME-Sender: <xms:qDRCapI9EQ3Iel47K9LcJX_GU3c8bc5rRG0UXzdE81Qo7k7icYn8pA>
    <xme:qDRCaslaEh7r9wM8k29HOytnvd6xbLqZ4id-MeumYcTWansoieEon2ONgvF9G_kzT
    pkeHnxs7a5Ll-uJnSgYgEMq358hLK1L50wa1hWpDBh_h6YMLu9y5Q>
X-ME-Received: <xmr:qDRCavFFK38FdUG48dzFfRzevCVQF4waVKl_Nf7jlGxWBgQ81te4CMdx3oAWtYxAjbIpcBS0sgZ0rB0ExBcX-ZGWHPcrRFn7Y6f0dMlkdf7z>
X-ME-Proxy-Cause: dmFkZTFf78gZ4U0pV8g2y1IIGqqh2NaGrNkO7MwAw/Ul/PxXTDFsYY7TBS+5vpiy2xQ7kz
    hAKYtnO2uhrhKcBaCsJJYq2jPVxR8LLd87L7SpRvAxRPUIAFt+csN8nCQNTB5FmR62wCIP
    IbJQKlONF1vyW4B5TCQR+975Kr/6uN3lyeUY3bP4uI4r6V72gBE5za4Zgdo2EjWI2Z4+23
    zL+T+fL+VvnGSI7bzahZX0xa2GHAlT1G1LqqdC7L/nx7VON0p+oUNkhLwRzgAwDZGCVh/D
    QUao3LF4tlWzI0Yx+HzylfSpnzpnJRbJ6/5juiKS6UrTXnw6cxhucNlBjxqpyBz4ETehDi
    Pzz1PTfvmkmout+9W3C5smrOHJ/V/Fon3QNS5TdJynFWqTEyeE4PaKMq7jhn3zoNe/sQ9t
    FrjqJaG7s4b1jwXBBE1gj4+1yXSsReYlHB+DFI60KskZke8E7WGxf7bkU1oRi+XOzBGqme
    cMMrH1T/8uA4aZGFq0QcrGvU1aGsunoQLNiGZoCGfkz8GMJSwMUhSHhjkntNqnzm8sZpcX
    /yhmS2a1GCtneFQWG7tsgQ06uLxrRbc18+4KkriWgZwVgBd3WODPYz3Vc3gbvJBeDaJrZd
    RaVyw7ZyKduJsAGR8DJSXFCYwxByy63yBGEgvUgrjSnQ3uErWOQnEunNg75Q
X-ME-Proxy: <xmx:qDRCakHROWdrxg8qJsuOAPnO-Bq69wyl4hIWwR8IX5V4ivYkKdKPZw>
    <xmx:qDRCakP665Xi7Bmt3GsjH5S01H1vKms9MU7TYyBlLsmwVSmaHJ6AeA>
    <xmx:qDRCarFBp7Lf3EcO-Pumy-FBBBRvQaPo3qKWcTRSYTnMEonFNDoJ2w>
    <xmx:qDRCajMIO9G_ZZ1_ae4I2gWvpgpWHlgRKHWBhDyUL3eEkeRqUZZA1Q>
    <xmx:qDRCapgm7zTV9A00_47SSE0HnPO3PEHDYZSKCFjOcpPKmB2Wt4tIpDcR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 05:02:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9695e34d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 09:02:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 29 Jun 2026 11:02:18 +0200
Subject: [PATCH v2 05/12] t/unit-tests: introduce test helper to write
 reftable blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pks-reftable-hardening-v2-5-b0228e7d908d@pks.im>
References: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
In-Reply-To: <20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Christian Couder <chriscool@tuxfamily.org>
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
2.55.0.rc2.803.g1fd1e6609c.dirty

