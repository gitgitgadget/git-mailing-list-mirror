Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F116E892
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140857; cv=none; b=Cu+SjMsWKrco4m7k6auILV0is1/9soTuqQOawd5kIALsxwx8PuhdeQE7llfDDRnm9Ums6H2OMFjhjBwSbMbHVB76hNLtqn2QLpvWH/NErrQ/WVp156reuuHSp7uJJ23LTyWazSjtOhhw8P/RLmqknZ7hXaFvGlzQh0Qt3I75BlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140857; c=relaxed/simple;
	bh=SFU7fnCToMKdvu5REM4dKFl5UPiPJR67vTOtSgeZtOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sq4925EOfi7LCuv1GxC7axABaGh2aYFLrBzMZAOjfJCCoFTAa5+TPrjftR4Q2HYzCK+zTkZMdbKfu9LPq5VbuRCwqD7vvI0MpaD1ZbMClhY7W19YI1675K/4qLY1bawHb5NUokVHSk4KP241cWr0aB9p2d9vr5BqNnmKRM9u6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MauCve8X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jyokR3Dp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MauCve8X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jyokR3Dp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2FEBE13801F0;
	Thu, 17 Oct 2024 00:54:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 17 Oct 2024 00:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140853; x=1729227253; bh=zvZ8jsVm7w
	YCJDc32qMf7cyA0g9S+Qau1lePrQs8rXU=; b=MauCve8XLeMbj606ucKaVyvmhH
	FzVgIc0WLraJkn/AhKe2mJHT6lbUCFRYy3n5PLPHlwIjJ66xHRQ18xdZ9gTpIGj0
	kzXzf8BkJmJSqYLDsj5J3wKEE8RfJ9N+cmnTAUdeAhRiQdz2aI84rWqG7Ie+zBiE
	S3yeFMbTuafT6VqKMcTo2BBSnndSvprSg/kfjdJ/nE3ESTwo/vs+o9dweZQm9pVD
	FIk45un9SkGYbvgiZUieKpej7V7LVXTJetqwSEF2eyj827h7+JI/su8mZMwpZpND
	Yt7bjK6502PR1cSBc3yfkiLrJeuiTcObp3PGzYY3rIjYiY70kAC6E6Q5CM3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140853; x=1729227253; bh=zvZ8jsVm7wYCJDc32qMf7cyA0g9S
	+Qau1lePrQs8rXU=; b=jyokR3Dp3NtTWcKW/1D3J8Lsy2VXq3OLxWXVRACOOgRd
	epeCHFEbC/985Y4egbFLwlG8EVqHwrZthQLy5QGXK1lUBz5fATJFflodobIzfxv2
	X0B+TzVGI94uBAKi4Br5tHRrqEQwOreVzbMQSbaTNmQ0GARD93IznQWUYOFD2B67
	CSXO2gShANCi159liSBP80m8wV+zQhK+8Krsn38pPvUXtx/h5AhydrIudV70H6bz
	goJYyGBrBYFWW67bh5UflFA9De1oKKZO9x9cTAcWUJCHlc7Z8n9EGHNv93bDvkbc
	Q+YmbTc+8B1FTFEBemfIVUnw5b3QNbfFV2BnzqEmzg==
X-ME-Sender: <xms:dJgQZ9qS6dzPghOCMmIoAIORNRsxyTvxpra5z2jxOmfrw165wuptKw>
    <xme:dJgQZ_p-UZ7ETTAs5kqcGuiEZP5o8jrsme3eEaSxf9G8nCtDVFYEMXNovJcFclmru
    vCpADUh8CuSEdQMxA>
X-ME-Received: <xmr:dJgQZ6MEoHJSHpZABNHZL6fSYhzpVvt29pMgkoqB_M_kGVbUYmW2iJwQTEpTpAgQ4OrYfAHJJyTGfz1U1cpBjSwnxUp-9R-GezupDOmrR5RluA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhm
X-ME-Proxy: <xmx:dZgQZ47Xc3ejJ4l4hLPzjIZ9burUSq0DyU2FfCn7aQFnZRIYoiWHxg>
    <xmx:dZgQZ84fKAdfqWcslbSKY16Fgd8SOH8pQ37uYwaPvBuXcfhzqj4NPw>
    <xmx:dZgQZwg7d4-ghYovd26YFnUGBKVvFe6lYxnsnmV67fks1KVms5zjYA>
    <xmx:dZgQZ-7jygIOXF1YYKvB6wkzp8lchQj2lsVKODQMVlvZxzyEAYXkDg>
    <xmx:dZgQZ2QT9yy-nZu7QQe81vOHH960xXhvA4kgHnmAIzZLr7kzK0CIXyQg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d6199b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:53 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:54:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 08/10] reftable/record: adapt `reftable_record_key()` to
 handle allocation failures
Message-ID: <268e4cd6fc6fb0d9ab6216723dc39c5cada3734c.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

The `reftable_record_key()` function cannot pass any errors to the
caller as it has a `void` return type. Adapt it and its callers such
that we can handle errors and start handling allocation failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 20 +++++++++++++++-----
 reftable/reader.c |  8 ++++++--
 reftable/record.c | 32 ++++++++++++++++++++------------
 reftable/record.h |  4 ++--
 reftable/writer.c |  5 ++++-
 5 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 4f62b823db8..697b8b41531 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -111,9 +111,12 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	int is_restart = 0;
 	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int n = 0;
-	int err = -1;
+	int err;
+
+	err = reftable_record_key(rec, &key);
+	if (err < 0)
+		goto done;
 
-	reftable_record_key(rec, &key);
 	if (!key.len) {
 		err = REFTABLE_API_ERROR;
 		goto done;
@@ -121,13 +124,17 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 
 	n = reftable_encode_key(&is_restart, out, last, key,
 				reftable_record_val_type(rec));
-	if (n < 0)
+	if (n < 0) {
+		err = -1;
 		goto done;
+	}
 	string_view_consume(&out, n);
 
 	n = reftable_record_encode(rec, out, w->hash_size);
-	if (n < 0)
+	if (n < 0) {
+		err = -1;
 		goto done;
+	}
 	string_view_consume(&out, n);
 
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
@@ -522,6 +529,10 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 			goto done;
 		}
 
+		err = reftable_record_key(&rec, &it->last_key);
+		if (err < 0)
+			goto done;
+
 		/*
 		 * Check whether the current key is greater or equal to the
 		 * sought-after key. In case it is greater we know that the
@@ -536,7 +547,6 @@ int block_iter_seek_key(struct block_iter *it, const struct block_reader *br,
 		 * to `last_key` now, and naturally all keys share a prefix
 		 * with themselves.
 		 */
-		reftable_record_key(&rec, &it->last_key);
 		if (reftable_buf_cmp(&it->last_key, want) >= 0) {
 			it->next_off = prev_off;
 			goto done;
diff --git a/reftable/reader.c b/reftable/reader.c
index 388f8bf6d7b..ab89efd9c55 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -356,7 +356,9 @@ static int table_iter_seek_linear(struct table_iter *ti,
 	int err;
 
 	reftable_record_init(&rec, reftable_record_type(want));
-	reftable_record_key(want, &want_key);
+	err = reftable_record_key(want, &want_key);
+	if (err < 0)
+		goto done;
 
 	/*
 	 * First we need to locate the block that must contain our record. To
@@ -439,7 +441,9 @@ static int table_iter_seek_indexed(struct table_iter *ti,
 	};
 	int err;
 
-	reftable_record_key(rec, &want_index.u.idx.last_key);
+	err = reftable_record_key(rec, &want_index.u.idx.last_key);
+	if (err < 0)
+		goto done;
 
 	/*
 	 * The index may consist of multiple levels, where each level may have
diff --git a/reftable/record.c b/reftable/record.c
index 0182c973437..672c5f909a9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -207,12 +207,12 @@ int reftable_decode_key(struct reftable_buf *last_key, uint8_t *extra,
 	return start_len - in.len;
 }
 
-static void reftable_ref_record_key(const void *r, struct reftable_buf *dest)
+static int reftable_ref_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_ref_record *rec =
 		(const struct reftable_ref_record *)r;
 	reftable_buf_reset(dest);
-	reftable_buf_addstr(dest, rec->refname);
+	return reftable_buf_addstr(dest, rec->refname);
 }
 
 static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
@@ -465,12 +465,12 @@ static struct reftable_record_vtable reftable_ref_record_vtable = {
 	.cmp = &reftable_ref_record_cmp_void,
 };
 
-static void reftable_obj_record_key(const void *r, struct reftable_buf *dest)
+static int reftable_obj_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_obj_record *rec =
 		(const struct reftable_obj_record *)r;
 	reftable_buf_reset(dest);
-	reftable_buf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
+	return reftable_buf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
 }
 
 static void reftable_obj_record_release(void *rec)
@@ -664,19 +664,27 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
 	.cmp = &reftable_obj_record_cmp_void,
 };
 
-static void reftable_log_record_key(const void *r, struct reftable_buf *dest)
+static int reftable_log_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_log_record *rec =
 		(const struct reftable_log_record *)r;
-	int len = strlen(rec->refname);
+	int len = strlen(rec->refname), err;
 	uint8_t i64[8];
 	uint64_t ts = 0;
+
 	reftable_buf_reset(dest);
-	reftable_buf_add(dest, (uint8_t *)rec->refname, len + 1);
+	err = reftable_buf_add(dest, (uint8_t *)rec->refname, len + 1);
+	if (err < 0)
+		return err;
 
 	ts = (~ts) - rec->update_index;
 	put_be64(&i64[0], ts);
-	reftable_buf_add(dest, i64, sizeof(i64));
+
+	err = reftable_buf_add(dest, i64, sizeof(i64));
+	if (err < 0)
+		return err;
+
+	return 0;
 }
 
 static int reftable_log_record_copy_from(void *rec, const void *src_rec,
@@ -1027,11 +1035,11 @@ static struct reftable_record_vtable reftable_log_record_vtable = {
 	.cmp = &reftable_log_record_cmp_void,
 };
 
-static void reftable_index_record_key(const void *r, struct reftable_buf *dest)
+static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
 {
 	const struct reftable_index_record *rec = r;
 	reftable_buf_reset(dest);
-	reftable_buf_add(dest, rec->last_key.buf, rec->last_key.len);
+	return reftable_buf_add(dest, rec->last_key.buf, rec->last_key.len);
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
@@ -1124,9 +1132,9 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
 	.cmp = &reftable_index_record_cmp,
 };
 
-void reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
+int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
 {
-	reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
+	return reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
 }
 
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
diff --git a/reftable/record.h b/reftable/record.h
index 271da3bf360..25aa908c859 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -40,7 +40,7 @@ int put_var_int(struct string_view *dest, uint64_t val);
 /* Methods for records. */
 struct reftable_record_vtable {
 	/* encode the key of to a uint8_t reftable_buf. */
-	void (*key)(const void *rec, struct reftable_buf *dest);
+	int (*key)(const void *rec, struct reftable_buf *dest);
 
 	/* The record type of ('r' for ref). */
 	uint8_t type;
@@ -137,7 +137,7 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 /* see struct record_vtable */
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
-void reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
+int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest);
 int reftable_record_copy_from(struct reftable_record *rec,
 			      struct reftable_record *src, int hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
diff --git a/reftable/writer.c b/reftable/writer.c
index da6941a78ac..377db709c85 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -249,7 +249,10 @@ static int writer_add_record(struct reftable_writer *w,
 	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int err;
 
-	reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &key);
+	if (err < 0)
+		goto done;
+
 	if (reftable_buf_cmp(&w->last_key, &key) >= 0) {
 		err = REFTABLE_API_ERROR;
 		goto done;
-- 
2.47.0.72.gef8ce8f3d4.dirty

