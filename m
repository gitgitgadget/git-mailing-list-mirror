Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8F1E1C2B
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058511; cv=none; b=kNDK/f3ck1VXG5SzMDAQDcHJV6cnVu1t7aFRg4Z5lwTiSGI95os+HQCmGU+vNsK6ora+jD1HVujs/eIIuTg4eJ388GoZZwSfHbjMBdztTXsZR4Io6vMPG9smoHDXry3fBJ+dS+z9FqlDwngJ8yHukEjw2HHFTvo1M7Umned+DGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058511; c=relaxed/simple;
	bh=NM8u2BZd0RchRWmh6EUzJLiHB7q3nUf0PdZIMPwsRUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIKuDoGX6W0xPa+boCSgA482OhZOgnFKMMVEk8VsA/YqEUZiYJ1TsoEgcn7aHDw8v2wiFPmGp/1e9RzWm9MDv5HoPza6tWJ/vQ1DJWglqEGUOCa2jMN0lCSwMk52UMs2azRSPKeru/Wj3O01Ln50KdfzAogFNpNJsLGhfC1aES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1Hvgu0cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G0sQD+Fg; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1Hvgu0cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G0sQD+Fg"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id AC19E11400D1
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 08 Nov 2024 04:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058508;
	 x=1731144908; bh=/NvzbzNCu1k9QZB2goBhq2WMS1OrExOeaINMmyk2Xic=; b=
	1Hvgu0cvAXaSzFpH56CKmMs8lUGwm8zcpBrsnjeO1WygseM/Tlr8KVmyyoHacYXZ
	ABPu29YMDg6u5W/zjgZAYBBcmOJ8HJ3BaqLkqBKoDhuoBqgDZPyGaPhKuVHGjqtz
	810TjV/qJOahIdF7EGI6l3G/3EW5/zNs84c9B/TuAtaplEwD4xqtB/wqlwYPm6iO
	vRXcmpkWZTK0oSxeX34K+xPIJe91xDLp1hbQWViok8tDCci3DnOvlOSBDcz+xdjK
	BWkpPQjxccoCpVxFkXv/GPcEnsAxkgi0m2tmOtf/eWkggxavLliYnLJvLQQpXLvT
	7KmYsYZHCWuMsvq+n5F0zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058508; x=
	1731144908; bh=/NvzbzNCu1k9QZB2goBhq2WMS1OrExOeaINMmyk2Xic=; b=G
	0sQD+FgFSy9HdiGhJEunvTUxQoOIeU5I2EjPIZxiwfLwhADCQO5sxT+SaqW0hByD
	/aFrXfze7CXJXUKR0GudvZy3tyGGyoEcTQ/q9IDrimDwEOCOl/P72IGfW2CBw+9k
	hVWBaQmSWGkuG9sJwHVSkynyNz4/oYWyX1pdbFF+76RJR4Agk1KTQAiCuoI2cubH
	hTMFMM1QsxycGkZKRFRhNJtRwB1Ahas14bQAmEkRHJxDiL6r6kr76MyU70eA+wno
	Qi7L9cqt3VbBjUA+fGiL9jAydVc6OR0PRW6E+emJ5eLM+GpWlyg5jqbxBPYWfxhi
	oD1/+5d4mtf4BcL5XZWqA==
X-ME-Sender: <xms:TNstZ6Ga3sPd9cCQYGeF1_5pKotPwA7aRFBHW8MDDJBH3cPuXztG8A>
    <xme:TNstZ7WYFtc0Bv1ADqmmRmXgjtqh7VM3ojauUuw7T8dbBzuFcjoqpn_V86gVYL1dB
    3rSOIguXTb5HTxscw>
X-ME-Received: <xmr:TNstZ0L7DZZHZgkxSSIMkzHxC70b7081Rk0r_Prv8ykvQcY3HbPg8XoBVkC-Nmb5h_tHW2hKVGawHnBUvJBiU-nAUjWN1V8zTk5KlRGO79NH7iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TNstZ0GzbJUVXaaZWzMmZ_GJDg3DtmsoSAvrwx8OqZGOA8K2GH2waA>
    <xmx:TNstZwV9hCKg559QN7DZyhO5hsqZEoG71KkPsTSd-8xvEITP-EX6iQ>
    <xmx:TNstZ3NVPtIFbnFke3zt6MTaLXw2TXxvmaCBQAgLZNAqayTatN-Mtg>
    <xmx:TNstZ31F8XfcHo2TXQQNUTIM9eCs8B6xafb5YEhVxN9l6g3kNdqTiQ>
    <xmx:TNstZ7eFFCmvKT12o9GNeEZIm02S4mAfefBTCyl7v50yWFIxIBJTE_U8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95da5d41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:50 +0100
Subject: [PATCH 10/10] reftable/block: optimize allocations by using
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-10-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
X-Mailer: b4 0.14.2

The block writer needs to compute the key for every record that one adds
to the writer. The buffer for this key is stored on the stack and thus
reallocated on every call to `block_writer_add()`, which is inefficient.

Refactor the code so that we store the buffer in the `block_writer`
struct itself so that we can reuse it. This reduces the number of
allocations when writing many refs, e.g. when migrating one million refs
from the "files" backend to the "reftable backend. Before this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 3,025,864 allocs, 3,025,815 frees, 372,746,291 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 2,013,250 allocs, 2,013,201 frees, 347,543,583 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 13 +++++--------
 reftable/block.h |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 3fa36c002a0c1852790780e74a6e055161f857d9..1aa7e8cd3cbf0980f6bc20262be89e755d0a4b4b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -110,24 +110,21 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 		.buf = w->block + w->next,
 		.len = w->block_size - w->next,
 	};
-
 	struct string_view start = out;
-
 	int is_restart = 0;
-	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int n = 0;
 	int err;
 
-	err = reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &w->buf);
 	if (err < 0)
 		goto done;
 
-	if (!key.len) {
+	if (!w->buf.len) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
-	n = reftable_encode_key(&is_restart, out, last, key,
+	n = reftable_encode_key(&is_restart, out, last, w->buf,
 				reftable_record_val_type(rec));
 	if (n < 0) {
 		err = -1;
@@ -143,9 +140,8 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	string_view_consume(&out, n);
 
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
-					    &key);
+					    &w->buf);
 done:
-	reftable_buf_release(&key);
 	return err;
 }
 
@@ -569,6 +565,7 @@ void block_writer_release(struct block_writer *bw)
 	REFTABLE_FREE_AND_NULL(bw->zstream);
 	REFTABLE_FREE_AND_NULL(bw->restarts);
 	REFTABLE_FREE_AND_NULL(bw->compressed);
+	reftable_buf_release(&bw->buf);
 	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/block.h b/reftable/block.h
index b3f837d612a8f0fbe98430b04e2dddaa975a15ab..d76f00553073c10185e716e71e2f415ce5dcf7e2 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -39,6 +39,7 @@ struct block_writer {
 	uint32_t restart_cap;
 
 	struct reftable_buf last_key;
+	struct reftable_buf buf;
 	int entries;
 };
 

-- 
2.47.0.229.g8f8d6eee53.dirty

