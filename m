Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA71EBA18
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389855; cv=none; b=kmp3bVLnNFMgdnxowlso4R9kbY+K5Z3G9kSITxIEqcGOi1WcAg60HU4w3FVjP/urq6pj7cTVCmscX1CxJz7LKoItnmKnCPn1AdBGJY8u29FLMeASwiM6VObq6fXLr/TNbiVF/SueZaK9M3DEzMDnzTMkEzBwQzVOx7BdCs8JVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389855; c=relaxed/simple;
	bh=KHATIjskoB4bhJF+0J+m+X9nHi1qhOtXWq5B4Y/S02s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Odxd/pjllfcnUsMfYfnUbdjPXEwPcbAD5mPArgDFi3DyhujY2MrWz3r7ZZIN5XnrC7HI8eyQtfWJpkUdrTD+U2wzYBdwRXWcX+Rn87Z4cVCG+QOxlMxct8ziqqvriFwyqqJyF7LRC0GogD/BqXqlozSqfvyXz7vaHzxAdxKHWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sUfUeNU+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oy3nU1It; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sUfUeNU+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oy3nU1It"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 3AC241380872;
	Mon, 20 Jan 2025 11:17:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 20 Jan 2025 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389853;
	 x=1737476253; bh=GIzFW0s1680vF9ZEfl1E8iPBDs2KKkZmm+XTbQT8FjQ=; b=
	sUfUeNU+2bW4gCuJXJ5PZ3LY75m4OwoYtcDD5NQJVQTrk3ZnpVE0rfJMwoioaGG/
	D8Zmvh7Pwg0TcEa1coBATY8zMQeHVs2CLApJtYDFBTEPnCeS7A8AvK2nFSMv90Bs
	CCMcLe8cmuJHatKYXd/kC8rxw8Kw8VbNgI7+xsBj9EwwKJoV5ZdJ9+7FWrmY0crP
	o9bcSWGQtBJ/MmARDDoWfNSEWQ20gtG+bbwxuM8H+d6xJbZphIztgSrcOhtcuHg2
	rRHRDUYKOvhF1DR/rvO0K4sh/HRHDNdgTu6WujPJFSHfhUTFuAeayE/bPqRv9P5k
	18iu+pTPEWneZLrpXuZu+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389853; x=
	1737476253; bh=GIzFW0s1680vF9ZEfl1E8iPBDs2KKkZmm+XTbQT8FjQ=; b=O
	y3nU1ItInGcMRscWqHfIONlQMnV/2Rq3Qgs0S3IfRBq1zDBJU83zvf1FG69n3Odf
	M/qbLWlNHRhZRO3J25JR4jKx/G2uheuG2qssaFQqaDcpSmBvztIx06FQMTq2ctBs
	U9xf9nE1yKyuIuOYTCEC4R8WLStS6tEQ6mDKDPWDm3XvlT27aBUifWyr6T+L4CzZ
	AUch0W1X8VhImknPufJLaGucKXo2H/FJVduWhTFJgNucH08DkkNrt9z0Y4Z1Jiws
	SRqYMOadCcaABGnJfFIwiS9nxMGcdJFQYDFKIeo2p3vHnmAwVj7XBp0GSdn7NFkN
	aaVCUNfAi3USuqGMR3DJg==
X-ME-Sender: <xms:HXeOZ2eqY0gZcIfWOVxBv484L6XHPkoGWxvkqOGr5W3c7pXjmY47JA>
    <xme:HXeOZwM0cg6TSOzUCdOGMwQ6fZbJH19wB-DKa7q4vtJj3tsODdkoITB3Fe5Ez-jk9
    pbv5N6oq1Hcels4gw>
X-ME-Received: <xmr:HXeOZ3gvf0VbzULgulv7qd51Ssrg7wud5nL2YdMDkmO6TX_3l-DEJ74QeNaSjmyCxa1zhqMnNMZl5tWcI6pzYfGoVe3fqlWGig8EL3N6bSW2-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HXeOZz9yUPMc8yGDHhUdVmvU1iActZRzwUSmEOWC3pPiYxwQK3TTcw>
    <xmx:HXeOZysDPRDs4wvjiqlavZ00UhihlhK0yQEX7KflQZvtRx0XHC4b_w>
    <xmx:HXeOZ6GXXXHPFVdfVHa9OzJ1LREgaJzMSr6O7DGxH5HdUH0t8WiD9w>
    <xmx:HXeOZxPHHTQ0nKp1AKcwR8fGvTTnjMT9Y3R-wqK1t8Bj12aN_FXjvA>
    <xmx:HXeOZ74q1-NKNwOQKa6xLKeMqmI4bATagF_F0OLsturvmibL65ayJ3Pl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d87dcdbd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:27 +0100
Subject: [PATCH v2 09/10] reftable/blocksource: adjust `read_block()` to
 return `ssize_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-9-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `block_source_read_block()` function and its implementations return
an integer as a result that reflects either the number of bytes read, or
an error. As such its return type, a signed integer, isn't wrong, but it
doesn't give the reader a good hint what it actually returns.

Refactor the function to return an `ssize_t` instead, which is typical
for functions similar to read(3p) and should thus give readers a better
signal what they can expect as a result.

Adjust callers to better handle the returned value to avoid warnings
with -Wsign-compare. One of these callers is `reader_get_block()`, whose
return value is only ever used by its callers to figure out whether or
not the read was successful. So instead of bubbling up the `ssize_t`
there, too, we adapt it to only indicate success or errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c          |  8 ++++----
 reftable/reader.c               | 30 +++++++++++++++++-------------
 reftable/reader.h               |  6 +++---
 reftable/reftable-blocksource.h | 11 +++++++----
 4 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 52e0915a67..bba4a45b98 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -24,8 +24,8 @@ static void reftable_buf_close(void *b UNUSED)
 {
 }
 
-static int reftable_buf_read_block(void *v, struct reftable_block *dest,
-				   uint64_t off, uint32_t size)
+static ssize_t reftable_buf_read_block(void *v, struct reftable_block *dest,
+				       uint64_t off, uint32_t size)
 {
 	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
@@ -78,8 +78,8 @@ static void file_close(void *v)
 	reftable_free(b);
 }
 
-static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
-			   uint32_t size)
+static ssize_t file_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			       uint32_t size)
 {
 	struct file_block_source *b = v;
 	assert(off + size <= b->size);
diff --git a/reftable/reader.c b/reftable/reader.c
index 9df8a5ecb1..3f2e4b2800 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -20,11 +20,11 @@ uint64_t block_source_size(struct reftable_block_source *source)
 	return source->ops->size(source->arg);
 }
 
-int block_source_read_block(struct reftable_block_source *source,
-			    struct reftable_block *dest, uint64_t off,
-			    uint32_t size)
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size)
 {
-	int result = source->ops->read_block(source->arg, dest, off, size);
+	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
 	dest->source = *source;
 	return result;
 }
@@ -57,14 +57,17 @@ static int reader_get_block(struct reftable_reader *r,
 			    struct reftable_block *dest, uint64_t off,
 			    uint32_t sz)
 {
+	ssize_t bytes_read;
 	if (off >= r->size)
 		return 0;
-
-	if (off + sz > r->size) {
+	if (off + sz > r->size)
 		sz = r->size - off;
-	}
 
-	return block_source_read_block(&r->source, dest, off, sz);
+	bytes_read = block_source_read_block(&r->source, dest, off, sz);
+	if (bytes_read < 0)
+		return (int)bytes_read;
+
+	return 0;
 }
 
 enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r)
@@ -601,6 +604,7 @@ int reftable_reader_new(struct reftable_reader **out,
 	struct reftable_reader *r;
 	uint64_t file_size = block_source_size(source);
 	uint32_t read_size;
+	ssize_t bytes_read;
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(r, 1);
@@ -619,8 +623,8 @@ int reftable_reader_new(struct reftable_reader **out,
 		goto done;
 	}
 
-	err = block_source_read_block(source, &header, 0, read_size);
-	if (err != read_size) {
+	bytes_read = block_source_read_block(source, &header, 0, read_size);
+	if (bytes_read < 0 || (size_t)bytes_read != read_size) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
@@ -645,9 +649,9 @@ int reftable_reader_new(struct reftable_reader **out,
 	r->hash_id = 0;
 	r->refcount = 1;
 
-	err = block_source_read_block(source, &footer, r->size,
-				      footer_size(r->version));
-	if (err != footer_size(r->version)) {
+	bytes_read = block_source_read_block(source, &footer, r->size,
+					     footer_size(r->version));
+	if (bytes_read < 0 || (size_t)bytes_read != footer_size(r->version)) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
diff --git a/reftable/reader.h b/reftable/reader.h
index d2b48a4849..bb72108a6f 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -16,9 +16,9 @@ license that can be found in the LICENSE file or at
 
 uint64_t block_source_size(struct reftable_block_source *source);
 
-int block_source_read_block(struct reftable_block_source *source,
-			    struct reftable_block *dest, uint64_t off,
-			    uint32_t size);
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size);
 void block_source_close(struct reftable_block_source *source);
 
 /* metadata for a block type */
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index f06ad52e0a..6b326aa5ea 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -31,10 +31,13 @@ struct reftable_block_source_vtable {
 	/* returns the size of a block source */
 	uint64_t (*size)(void *source);
 
-	/* reads a segment from the block source. It is an error to read
-	   beyond the end of the block */
-	int (*read_block)(void *source, struct reftable_block *dest,
-			  uint64_t off, uint32_t size);
+	/*
+	 * Reads a segment from the block source. It is an error to read beyond
+	 * the end of the block.
+	 */
+	ssize_t (*read_block)(void *source, struct reftable_block *dest,
+			     uint64_t off, uint32_t size);
+
 	/* mark the block as read; may return the data back to malloc */
 	void (*return_block)(void *source, struct reftable_block *blockp);
 

-- 
2.48.0.257.gd3603152ad.dirty

