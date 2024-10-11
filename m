Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00E209F3A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629677; cv=none; b=F9ZQitFwcCfyK5RURrDbF2ND5ZuS12KqS/GYuL1Yi3wzZxM3e5OxkIBkNgc5I9LrT+iEHVKAIIWMuxoJAtM0UHDp/6e2y1zHghOXqhNh18wkU4V3aByA3/F0EAo8v+P4VGLZXeMhR8eQKHQwI/vU/8KdWsj9RMAC/UrszP33q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629677; c=relaxed/simple;
	bh=7sybfNBfiaIRMCI5dh3eQmEwLGxRdlv73VqKanw7Jyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edJCInhV2v2qERHKt7AmYK1vNN330A/SwOOpI3EqDXm+NAxq2bVf4fjt0y4bGQT8bQbCDJDTiJBPcKFkTXP+X8a1MxhoU+zeMrCqiT3f6aIWYnYBl1Ij/RffpSH1wHY1exOAG2WHmsembfvQe2KYoKMYrMHxkeVbF/6kxMhdIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvI2zG0t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4ImRYJl; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvI2zG0t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4ImRYJl"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD2391140126;
	Fri, 11 Oct 2024 02:54:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 02:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629674; x=1728716074; bh=/a9DWr45ow
	JuJm6y47KkFaze+ErBYgkBQ5Td5E27egY=; b=fvI2zG0tqJsam6lziWDIQEn0c7
	ck6C/k3wBlQhKbp+JyL4NrMedN6qPrx3eqWlHbvF/xQp36bEVF6cwezpagRTsSKz
	8NxHl5NE01KTV3N6u0xBd7Qv/mUs9lbsOee0vAMxgsa9ptiwYrQhoL6s1wPYB3f5
	x/2vUDVHAvBep3wodXNCuiyE9L5t3xBz6SF5Kyik7o4hOK4V4DMZALbiU5f/njAh
	NekHE1b9TiW35kht3TnQCnOKrEZeFVIhuKGGXcrNW4p6hFqKE3hlZ+O9UkaQ46NK
	C0DR00yLqHvuCNy8utKy4udVfVYAD2LvmGaE70YSLDOP8xx2ogDk7ArmeQWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629674; x=1728716074; bh=/a9DWr45owJuJm6y47KkFaze+ErB
	YgkBQ5Td5E27egY=; b=b4ImRYJlaBPfUh7jBWapM9/Fn+EZAmlg3PFCABUEYbUZ
	1aQiqUJBTFaWWDLAySq1nGUMGJ9trDK1sR/QKk5MEkRgmNNbhPzYiNi0EVUvMV88
	1sudQxSW7P413tzq2EfaJnCf1cf9nCEbEHXHt+y8tM8ceI8rHxC+I1vYO+B+4vjC
	43rwZ6TEOoCXhyY4j/6FlJ/mYcVL9i/9XKJCAv/OaHSbKdMkmrzPX5XkR3nO9juS
	dYRN8GYRP9cqY1O2LLNrSBNDo5kwILdcltLlPeAmEIj6g5u0RPkRLg5kaeRaFoPk
	yjcjYoZp8WsjIRZKuCv71eH/9afTS25nJ3LUpBNryQ==
X-ME-Sender: <xms:qssIZ7A6AVKzzinWXCq2h57l5a5Iwn0iH3mdU_uvPhnNZys7SSOaYw>
    <xme:qssIZxg5dgcqq5ksic5hGVI2OzeWDn3nG10aDNX456RrGh3d6O1Mwp8IYDHDknsUV
    gtM_zQJ95BNGgVJwA>
X-ME-Received: <xmr:qssIZ2k3Is6QFJ6WPT_7jKjeRPLePsK4AqrioQ0a0eWXMfUhs0iZ57YdgAl7yNS3lTyBy_3aUmkB2bMlMfrywMlKkZOkQqsAUbfe4a3_KlIjy2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qssIZ9xZCepBxRh0lBkpMQLkt3IVBEyRcthjbMlwI5hUSUi1D_Jh0g>
    <xmx:qssIZwSvyufrmsiXxq4iSPpqrVZ-Cgf0dmLwhDDGtuZGg7NKdH2ieA>
    <xmx:qssIZwa5IBt5jjlyfeMFawiKIUvt6cuyg4CG--NS4R8NHr-pamTyOQ>
    <xmx:qssIZxS9TyszUt9Y0bDJqmTgr6Pri6Np4atxxl7ylmIYg4BArkS1QA>
    <xmx:qssIZ7cYM0jLXvmnajDCIkpx31Kr0IEwZGJyOmOYMmy_ck49B4Q7_SOl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3ecde64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:27 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 08/10] reftable/record: adapt `reftable_record_key()` to
 handle allocation failures
Message-ID: <f5ae5ec27d6cff018b90f0589ca3da4874f46616.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

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
2.47.0.dirty

