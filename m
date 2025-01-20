Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425201E32D7
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389853; cv=none; b=BOcKRTUVdugG4FMrdcn2w2etgW1HEtrfM5At245+ejpuTGdO5f1GNIbySHyXZmPI2U+7hvlNWkiMrOzspvYn4jEmsBEA/Fda5CLdB0gf02LY4X8p+2ulwrqiV48Ov88mtmAVuFcMkSsnxWlBAUS0XS/n5YSsVHQLMqqp2cdf2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389853; c=relaxed/simple;
	bh=cW9KYHyJ6PlY8q3YgF6IblR7CF1T6ZktjRpyQHjmaR0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1s4Kx6By/IclvZTPeV20aWm7mgqBMbOOIxPME8tM7crqx77Agezyq5RayHs+kHTvSn/u6WrxAM2zcg7ch17DGsYQSNkESNw9Qlp/2l4mAMWEpbvZ6gKHaM044ONejmyP5Y6CYLW979a35/TlVSMRL9uC3ugOR+hlPc/PzGIgBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HtS+2kpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RN6kUKU7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HtS+2kpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RN6kUKU7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6377A1140226;
	Mon, 20 Jan 2025 11:17:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 20 Jan 2025 11:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737389850;
	 x=1737476250; bh=0VRsJ/qXCcnmGXa1EFA1Jm0fZtoSAddtmo1quYMho+A=; b=
	HtS+2kpdqmGPkWrpchJx3K34nhQ1g9XaAH5XIrW5Rfol2xe7sIviIrv6pXyDoFMC
	VirXWkmYC+8AdSl7sYz1dLS22IBAax2Wn70BVPbJrfbhfauIzrH0yeNyC9j8qDYt
	f8hpZCDbloKFzqspdobn6VJjA5BSxaxnyEMbzGX+ahora4RnVzEr3pUk7Y/OMGmp
	IDNmgp3oNTIyZkhBWM5A282SvaLBa3MuIffcS8j2dkBA45qJ38eTIwwd0pS2S6WJ
	c5HxPqYBAECba3XseCtwzjBau/mSJ6+Oh6PgPAxf170XgSCuh2gG31cbqNcIE8wo
	gLCwzaHc0G6lvNtKG/pKOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737389850; x=
	1737476250; bh=0VRsJ/qXCcnmGXa1EFA1Jm0fZtoSAddtmo1quYMho+A=; b=R
	N6kUKU7HU+9xiL+gCeDEsRHIwZNvHPeenN9vDKTwamZ01Udv8pVaFarWeXRqSm0e
	UjH0TszTiXxuww/8k33ovAT6+GXjmh2FWIJUZkYTrhSqdNrvScSq+VxxODE74pW7
	TZmAhsXoS+kiLWXY7yBgvDzK5u8xlnFlTFrLNUTaJUTDBaWSV6gAzYtaxjks+AXB
	ZmWD8ly/f0IH5Sy2iOVCIlVv9JI/fLegrE4V8hfAs/HUP7AGGPVpdQk2l+ybGBsh
	eluLIFMltiEy8UkPWQbbq9RL8hkfM3NAvXXEMEhWxuVESu5lhubtBpi+I0qEYOFM
	W2qKEOOkspxSW1K2nQO9w==
X-ME-Sender: <xms:GneOZ_kV9865ci8bzw4Sk2sOJrqRWHUAXieZlyr8wzK5rca5tjL3Zg>
    <xme:GneOZy0tdJSx2KX3MseYi_PHlCeviHred2mfehCtLBDzA251bwjI9cpvm06gAzO01
    PqLW_uKldQSdTwa1Q>
X-ME-Received: <xmr:GneOZ1oC6jgCPkP2TUfc8eEFbYoTk7x0g-UvANUzuze_LwV1SEFLbkLnwNJmXr62T7dpv7TQzkv8xGjn3ngE31kAHjwBYe0hV6Ak5fJVFJZXCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:GneOZ3lIm_VJyNXt2QmIdhca9-HLgHQL0UANtp7_wRSpHKbjPbZR7A>
    <xmx:GneOZ91VChC1LNz4iWRtW2dr0gTduvGOcW-6bDcIpGKoPIyC5FXbNg>
    <xmx:GneOZ2u5LWzZ-UjaJXvtHJ4LUDLPNUsCrR6NjRtuvwgfBftNGD3l7Q>
    <xmx:GneOZxWmT0_fb3l5_4fBuUIBzVsvYzKoOkJCar7tWe9T4c_eDtsKlg>
    <xmx:GneOZ7BhZeXYZDczmI5fSmr3AXOzEYF_qSdmZj2f6SiyH5JHeRlplu6M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jan 2025 11:17:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 973b529c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Jan 2025 16:17:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Jan 2025 17:17:23 +0100
Subject: [PATCH v2 05/10] reftable/basics: adjust `hash_size()` to return
 `uint32_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-b4-pks-reftable-sign-compare-v2-5-b4566d02e4a5@pks.im>
References: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
In-Reply-To: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The `hash_size()` function returns the number of bytes used by the hash
function. Weirdly enough though, it returns a signed integer for its
size even though the size obviously cannot ever be negative. The only
case where it could be negative is if the function returned an error
when asked for an unknown hash, but we assert(3p) instead.

Adjust the type of `hash_size()` to be `uint32_t` and adapt all places
that use signed integers for the hash size to follow suit. This also
allows us to get rid of a couple asserts that we had which verified that
the size was indeed positive, which further stresses the point that this
refactoring makes sense.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c                |  2 +-
 reftable/basics.h                |  2 +-
 reftable/block.c                 |  4 ++--
 reftable/block.h                 | 10 ++++----
 reftable/reader.c                |  2 +-
 reftable/record.c                | 52 ++++++++++++++++++----------------------
 reftable/record.h                | 16 ++++++-------
 reftable/reftable-record.h       |  4 ++--
 t/unit-tests/t-reftable-record.c |  2 +-
 9 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 10b234ea55..3b5ea27bbd 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -272,7 +272,7 @@ size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b)
 	return p;
 }
 
-int hash_size(enum reftable_hash id)
+uint32_t hash_size(enum reftable_hash id)
 {
 	if (!id)
 		return REFTABLE_HASH_SIZE_SHA1;
diff --git a/reftable/basics.h b/reftable/basics.h
index 9ff81a68f8..a2a010a0e1 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -171,7 +171,7 @@ static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 /* Find the longest shared prefix size of `a` and `b` */
 size_t common_prefix_size(struct reftable_buf *a, struct reftable_buf *b);
 
-int hash_size(enum reftable_hash id);
+uint32_t hash_size(enum reftable_hash id);
 
 /*
  * Format IDs that identify the hash function used by a reftable. Note that
diff --git a/reftable/block.c b/reftable/block.c
index 9858bbc7c5..2380aabb2f 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -72,7 +72,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 }
 
 int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
-		      uint32_t block_size, uint32_t header_off, int hash_size)
+		      uint32_t block_size, uint32_t header_off, uint32_t hash_size)
 {
 	bw->block = block;
 	bw->hash_size = hash_size;
@@ -214,7 +214,7 @@ int block_writer_finish(struct block_writer *w)
 
 int block_reader_init(struct block_reader *br, struct reftable_block *block,
 		      uint32_t header_off, uint32_t table_block_size,
-		      int hash_size)
+		      uint32_t hash_size)
 {
 	uint32_t full_block_size = table_block_size;
 	uint8_t typ = block->data[header_off];
diff --git a/reftable/block.h b/reftable/block.h
index 0431e8591f..5f67ed74c5 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -30,7 +30,7 @@ struct block_writer {
 
 	/* How often to restart keys. */
 	uint16_t restart_interval;
-	int hash_size;
+	uint32_t hash_size;
 
 	/* Offset of next uint8_t to write. */
 	uint32_t next;
@@ -48,7 +48,7 @@ struct block_writer {
  * initializes the blockwriter to write `typ` entries, using `block` as temporary
  * storage. `block` is not owned by the block_writer. */
 int block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *block,
-		      uint32_t block_size, uint32_t header_off, int hash_size);
+		      uint32_t block_size, uint32_t header_off, uint32_t hash_size);
 
 /* returns the block type (eg. 'r' for ref records. */
 uint8_t block_writer_type(struct block_writer *bw);
@@ -72,7 +72,7 @@ struct block_reader {
 
 	/* the memory block */
 	struct reftable_block block;
-	int hash_size;
+	uint32_t hash_size;
 
 	/* Uncompressed data for log entries. */
 	z_stream *zstream;
@@ -92,7 +92,7 @@ struct block_reader {
 /* initializes a block reader. */
 int block_reader_init(struct block_reader *br, struct reftable_block *bl,
 		      uint32_t header_off, uint32_t table_block_size,
-		      int hash_size);
+		      uint32_t hash_size);
 
 void block_reader_release(struct block_reader *br);
 
@@ -108,7 +108,7 @@ struct block_iter {
 	uint32_t next_off;
 	const unsigned char *block;
 	size_t block_len;
-	int hash_size;
+	uint32_t hash_size;
 
 	/* key for last entry we read. */
 	struct reftable_buf last_key;
diff --git a/reftable/reader.c b/reftable/reader.c
index ea82955c9b..9df8a5ecb1 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -750,7 +750,7 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	struct table_iter *ti;
 	struct filtering_ref_iterator *filter = NULL;
 	struct filtering_ref_iterator empty = FILTERING_REF_ITERATOR_INIT;
-	int oid_len = hash_size(r->hash_id);
+	uint32_t oid_len = hash_size(r->hash_id);
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
diff --git a/reftable/record.c b/reftable/record.c
index 4a3e019528..f7766a32ef 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -229,7 +229,7 @@ static int reftable_ref_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
-					 int hash_size)
+					 uint32_t hash_size)
 {
 	struct reftable_ref_record *ref = rec;
 	const struct reftable_ref_record *src = src_rec;
@@ -237,8 +237,6 @@ static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
 	size_t refname_cap = 0;
 	int err;
 
-	assert(hash_size > 0);
-
 	SWAP(refname, ref->refname);
 	SWAP(refname_cap, ref->refname_cap);
 	reftable_ref_record_release(ref);
@@ -319,13 +317,12 @@ static uint8_t reftable_ref_record_val_type(const void *rec)
 }
 
 static int reftable_ref_record_encode(const void *rec, struct string_view s,
-				      int hash_size)
+				      uint32_t hash_size)
 {
 	const struct reftable_ref_record *r =
 		(const struct reftable_ref_record *)rec;
 	struct string_view start = s;
 	int n = put_var_int(&s, r->update_index);
-	assert(hash_size > 0);
 	if (n < 0)
 		return -1;
 	string_view_consume(&s, n);
@@ -365,7 +362,7 @@ static int reftable_ref_record_encode(const void *rec, struct string_view s,
 
 static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size, struct reftable_buf *scratch)
+				      uint32_t hash_size, struct reftable_buf *scratch)
 {
 	struct reftable_ref_record *r = rec;
 	struct string_view start = in;
@@ -374,8 +371,6 @@ static int reftable_ref_record_decode(void *rec, struct reftable_buf key,
 	size_t refname_cap = 0;
 	int n, err;
 
-	assert(hash_size > 0);
-
 	n = get_var_int(&update_index, &in);
 	if (n < 0)
 		return n;
@@ -451,7 +446,7 @@ static int reftable_ref_record_is_deletion_void(const void *p)
 }
 
 static int reftable_ref_record_equal_void(const void *a,
-					  const void *b, int hash_size)
+					  const void *b, uint32_t hash_size)
 {
 	struct reftable_ref_record *ra = (struct reftable_ref_record *) a;
 	struct reftable_ref_record *rb = (struct reftable_ref_record *) b;
@@ -495,7 +490,7 @@ static void reftable_obj_record_release(void *rec)
 }
 
 static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					 int hash_size UNUSED)
+					 uint32_t hash_size UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
 	const struct reftable_obj_record *src = src_rec;
@@ -527,7 +522,7 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
 }
 
 static int reftable_obj_record_encode(const void *rec, struct string_view s,
-				      int hash_size UNUSED)
+				      uint32_t hash_size UNUSED)
 {
 	const struct reftable_obj_record *r = rec;
 	struct string_view start = s;
@@ -562,7 +557,7 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size UNUSED,
+				      uint32_t hash_size UNUSED,
 				      struct reftable_buf *scratch UNUSED)
 {
 	struct string_view start = in;
@@ -626,7 +621,7 @@ static int not_a_deletion(const void *p UNUSED)
 }
 
 static int reftable_obj_record_equal_void(const void *a, const void *b,
-					  int hash_size UNUSED)
+					  uint32_t hash_size UNUSED)
 {
 	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
 	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
@@ -701,7 +696,7 @@ static int reftable_log_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_log_record_copy_from(void *rec, const void *src_rec,
-					 int hash_size)
+					 uint32_t hash_size)
 {
 	struct reftable_log_record *dst = rec;
 	const struct reftable_log_record *src =
@@ -782,7 +777,7 @@ static uint8_t reftable_log_record_val_type(const void *rec)
 }
 
 static int reftable_log_record_encode(const void *rec, struct string_view s,
-				      int hash_size)
+				      uint32_t hash_size)
 {
 	const struct reftable_log_record *r = rec;
 	struct string_view start = s;
@@ -830,7 +825,7 @@ static int reftable_log_record_encode(const void *rec, struct string_view s,
 
 static int reftable_log_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      int hash_size, struct reftable_buf *scratch)
+				      uint32_t hash_size, struct reftable_buf *scratch)
 {
 	struct string_view start = in;
 	struct reftable_log_record *r = rec;
@@ -978,7 +973,7 @@ static int null_streq(const char *a, const char *b)
 }
 
 static int reftable_log_record_equal_void(const void *a,
-					  const void *b, int hash_size)
+					  const void *b, uint32_t hash_size)
 {
 	return reftable_log_record_equal((struct reftable_log_record *) a,
 					 (struct reftable_log_record *) b,
@@ -1002,7 +997,7 @@ static int reftable_log_record_cmp_void(const void *_a, const void *_b)
 }
 
 int reftable_log_record_equal(const struct reftable_log_record *a,
-			      const struct reftable_log_record *b, int hash_size)
+			      const struct reftable_log_record *b, uint32_t hash_size)
 {
 	if (!(null_streq(a->refname, b->refname) &&
 	      a->update_index == b->update_index &&
@@ -1056,7 +1051,7 @@ static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
-					   int hash_size UNUSED)
+					   uint32_t hash_size UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -1083,7 +1078,7 @@ static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
 }
 
 static int reftable_index_record_encode(const void *rec, struct string_view out,
-					int hash_size UNUSED)
+					uint32_t hash_size UNUSED)
 {
 	const struct reftable_index_record *r =
 		(const struct reftable_index_record *)rec;
@@ -1101,7 +1096,7 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 					uint8_t val_type UNUSED,
 					struct string_view in,
-					int hash_size UNUSED,
+					uint32_t hash_size UNUSED,
 					struct reftable_buf *scratch UNUSED)
 {
 	struct string_view start = in;
@@ -1122,7 +1117,7 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 }
 
 static int reftable_index_record_equal(const void *a, const void *b,
-				       int hash_size UNUSED)
+				       uint32_t hash_size UNUSED)
 {
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
@@ -1156,14 +1151,14 @@ int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
 }
 
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
-			   int hash_size)
+			   uint32_t hash_size)
 {
 	return reftable_record_vtable(rec)->encode(reftable_record_data(rec),
 						   dest, hash_size);
 }
 
 int reftable_record_copy_from(struct reftable_record *rec,
-			       struct reftable_record *src, int hash_size)
+			       struct reftable_record *src, uint32_t hash_size)
 {
 	assert(src->type == rec->type);
 
@@ -1178,7 +1173,7 @@ uint8_t reftable_record_val_type(struct reftable_record *rec)
 }
 
 int reftable_record_decode(struct reftable_record *rec, struct reftable_buf key,
-			   uint8_t extra, struct string_view src, int hash_size,
+			   uint8_t extra, struct string_view src, uint32_t hash_size,
 			   struct reftable_buf *scratch)
 {
 	return reftable_record_vtable(rec)->decode(reftable_record_data(rec),
@@ -1205,7 +1200,7 @@ int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b)
 		reftable_record_data(a), reftable_record_data(b));
 }
 
-int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size)
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size)
 {
 	if (a->type != b->type)
 		return 0;
@@ -1213,7 +1208,7 @@ int reftable_record_equal(struct reftable_record *a, struct reftable_record *b,
 		reftable_record_data(a), reftable_record_data(b), hash_size);
 }
 
-static int hash_equal(const unsigned char *a, const unsigned char *b, int hash_size)
+static int hash_equal(const unsigned char *a, const unsigned char *b, uint32_t hash_size)
 {
 	if (a && b)
 		return !memcmp(a, b, hash_size);
@@ -1222,9 +1217,8 @@ static int hash_equal(const unsigned char *a, const unsigned char *b, int hash_s
 }
 
 int reftable_ref_record_equal(const struct reftable_ref_record *a,
-			      const struct reftable_ref_record *b, int hash_size)
+			      const struct reftable_ref_record *b, uint32_t hash_size)
 {
-	assert(hash_size > 0);
 	if (!null_streq(a->refname, b->refname))
 		return 0;
 
diff --git a/reftable/record.h b/reftable/record.h
index 0df950f401..c7755a4d75 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -47,18 +47,18 @@ struct reftable_record_vtable {
 	/* The record type of ('r' for ref). */
 	uint8_t type;
 
-	int (*copy_from)(void *dest, const void *src, int hash_size);
+	int (*copy_from)(void *dest, const void *src, uint32_t hash_size);
 
 	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
 	 * vs ref deletion) */
 	uint8_t (*val_type)(const void *rec);
 
 	/* encodes rec into dest, returning how much space was used. */
-	int (*encode)(const void *rec, struct string_view dest, int hash_size);
+	int (*encode)(const void *rec, struct string_view dest, uint32_t hash_size);
 
 	/* decode data from `src` into the record. */
 	int (*decode)(void *rec, struct reftable_buf key, uint8_t extra,
-		      struct string_view src, int hash_size,
+		      struct string_view src, uint32_t hash_size,
 		      struct reftable_buf *scratch);
 
 	/* deallocate and null the record. */
@@ -68,7 +68,7 @@ struct reftable_record_vtable {
 	int (*is_deletion)(const void *rec);
 
 	/* Are two records equal? This assumes they have the same type. Returns 0 for non-equal. */
-	int (*equal)(const void *a, const void *b, int hash_size);
+	int (*equal)(const void *a, const void *b, uint32_t hash_size);
 
 	/*
 	 * Compare keys of two records with each other. The records must have
@@ -135,16 +135,16 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
-int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
+int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, uint32_t hash_size);
 int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
 int reftable_record_copy_from(struct reftable_record *rec,
-			      struct reftable_record *src, int hash_size);
+			      struct reftable_record *src, uint32_t hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
-			   int hash_size);
+			   uint32_t hash_size);
 int reftable_record_decode(struct reftable_record *rec, struct reftable_buf key,
 			   uint8_t extra, struct string_view src,
-			   int hash_size, struct reftable_buf *scratch);
+			   uint32_t hash_size, struct reftable_buf *scratch);
 int reftable_record_is_deletion(struct reftable_record *rec);
 
 static inline uint8_t reftable_record_type(struct reftable_record *rec)
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index ddd48eb579..931e594744 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -65,7 +65,7 @@ void reftable_ref_record_release(struct reftable_ref_record *ref);
 
 /* returns whether two reftable_ref_records are the same. Useful for testing. */
 int reftable_ref_record_equal(const struct reftable_ref_record *a,
-			      const struct reftable_ref_record *b, int hash_size);
+			      const struct reftable_ref_record *b, uint32_t hash_size);
 
 /* reftable_log_record holds a reflog entry */
 struct reftable_log_record {
@@ -105,6 +105,6 @@ void reftable_log_record_release(struct reftable_log_record *log);
 
 /* returns whether two records are equal. Useful for testing. */
 int reftable_log_record_equal(const struct reftable_log_record *a,
-			      const struct reftable_log_record *b, int hash_size);
+			      const struct reftable_log_record *b, uint32_t hash_size);
 
 #endif
diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 6d912b9c8f..d49d2a2729 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -76,7 +76,7 @@ static void t_varint_overflow(void)
 
 static void set_hash(uint8_t *h, int j)
 {
-	for (int i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
+	for (size_t i = 0; i < hash_size(REFTABLE_HASH_SHA1); i++)
 		h[i] = (j >> i) & 0xff;
 }
 

-- 
2.48.0.257.gd3603152ad.dirty

