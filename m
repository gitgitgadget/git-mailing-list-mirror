Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD1A15853A
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489721; cv=none; b=gLCuRiiB2ejaz1T4sIw73Tj5TTor8Zx7D91uuuL6Hqc7SZ3dt0YBR/nQA3vcnYtG5qXAAZzz779mEzNuMMPLRlX20BOMCZGb0CjOW/eaAzBR4MiqxhSfP1q5YrS0u0JHhjGe9ytt35srVG2EyQicicLOn9PB7ylbz3OsFiKAWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489721; c=relaxed/simple;
	bh=BKq4p+uIAv9ZuYOSnNE/KpcSjc6cn80W99iWojHflnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5cw0heZKuZdzUvxI4Q/C8SnSD37eEGaCM+SDnCIx9/emdzFE+K4ZtmlLy7M71TzNMZTeT8kcOFEgjtWH052yN+deSUn76VhnjMcVeF1nLqDlAsCn7AXoprvUrFIgRevuajhnR4FlDB/P29JUu/9ZfCxWmKrL7/vOEMm4LJkrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=skqsqY9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oFjI96+1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="skqsqY9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oFjI96+1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 991311380119;
	Mon, 16 Sep 2024 08:28:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 16 Sep 2024 08:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489718; x=1726576118; bh=xxOqBrbNa2
	F/37Wz124W2Nw0AOdQOQ/0N4nMv9H09+g=; b=skqsqY9dg4inaE47kKkykPqSxC
	Kka6ceMtZMEtgHCYLtB4xw5pC6qwYqhpfWqk1YYs6fOgJyXPLglxuiNfFk0ivKW5
	pKFtDNjgS5B37ym9ogeGZzhi1j/bBQG4wvjFvcxQnjL7yYRjbiux18/GvFhfA7ZC
	hWigO8VOW7Sx6XdUMQzu1r1t71SbI4FlAYRK/HJtPw5IApn2DUBf8BCX0eRlRCmq
	bz9XjAlYIrH9c8+NWFmPsJG71J9EBuZSzwYCrx5Qukw/z4LvZcFEi5G13jZxN507
	VpaqtE65DigHG0u62y5HH9qTz7u2/zXqm1+98X0XLpvE1eZrgI+fRMjhskdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489718; x=1726576118; bh=xxOqBrbNa2F/37Wz124W2Nw0AOdQ
	OQ/0N4nMv9H09+g=; b=oFjI96+1BsQ6aq5uSIbz4KzWqBDi42te5/eG51K2WQw7
	zZ5WCKlDaY2YCEcuao23zTyxRY4dTHZmb6/UcRv/tGP85PFnSts3NcRXZG8O45GU
	xzc47tSbJ1Q7SCOVPLr41I5ggsIBGGNVrvm4+uGoi0gatd6TeaP1q5aIzJ4agQiE
	jzF0l0EY14rBisMzY9Aa8lvqEP21QUQbB64U0TYSDm0/pwRM/dPAwb2NM52asALc
	uQOTcTFicyQ61mBkNLxt/cfZivVw8YqKt1ZiTLjfoah8EWGhDn/THm3Ba0JYn2bc
	+23NgxgAHNGxyM61u3knREqWjuhjoAgEC+j30vhfIA==
X-ME-Sender: <xms:diToZiAwuy6f_FK-sjWgCH3SoRkUPLEOAjqeIV71ISFqe4qh1xQ11Q>
    <xme:diToZshZZnjW6DF6IgBVLzWay4f-w26EtgficNUShblg9WCIeN6Cd0SZyal10LqrF
    iy4VBD3pAqKgGSYUQ>
X-ME-Received: <xmr:diToZllC_mPziV7fC1cjVLuBVWZx1qknmuM-mUSUBd0PayXZqfWpAznag3rjC3WPb6xIxWiu1z6thUVFBT6pFyJTUtTkWomsxspotGxoJgS-ldAh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveffudeuuddugfehuedutedtjeefgffhtefguddtieeh
    ieetkefffedvteduhfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpuhhpuggrth
    gvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvght
    hhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:diToZgyizZ945JjMRo-APl4GNaEwb-Ihzq3CSfxRiG5G6UaJyBrJog>
    <xmx:diToZnSLeNEBXX9woRNStsC87VYv3FqEWD05W-SPdpgxOhGo0fUrlw>
    <xmx:diToZrY0dCXfX2fHMAJDiTNcrjCZymWUxBdYHTRoJEhkHzMYIGNHsA>
    <xmx:diToZgSHOzhqVDhaku_7q55NufTIvwUoUzwydnV5SF3ukrpwUDrEMA>
    <xmx:diToZicTts_ewJiW2A1aABXo-UpNLCq-9je-rDYclYPZEuvvhveWzOKw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f497de43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:20 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 07/22] reftable/record: handle allocation failures when
 decoding records
Message-ID: <372e36f880e02558f83713068194231c876c545b.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures when decoding records. While at it, fix some
error codes to be `REFTABLE_FORMAT_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 80 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 60fd33c9c94..787e134c9a0 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -359,7 +359,7 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	uint64_t update_index = 0;
 	const char *refname = NULL;
 	size_t refname_cap = 0;
-	int n;
+	int n, err;
 
 	assert(hash_size > 0);
 
@@ -375,6 +375,10 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	SWAP(r->refname_cap, refname_cap);
 
 	REFTABLE_ALLOC_GROW(r->refname, key.len + 1, r->refname_cap);
+	if (!r->refname) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
 	memcpy(r->refname, key.buf, key.len);
 	r->refname[key.len] = 0;
 
@@ -383,7 +387,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	switch (val_type) {
 	case REFTABLE_REF_VAL1:
 		if (in.len < hash_size) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 
 		memcpy(r->value.val1, in.buf, hash_size);
@@ -392,7 +397,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 
 	case REFTABLE_REF_VAL2:
 		if (in.len < 2 * hash_size) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 
 		memcpy(r->value.val2.value, in.buf, hash_size);
@@ -405,7 +411,8 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	case REFTABLE_REF_SYMREF: {
 		int n = decode_string(scratch, in);
 		if (n < 0) {
-			return -1;
+			err = REFTABLE_FORMAT_ERROR;
+			goto done;
 		}
 		string_view_consume(&in, n);
 		r->value.symref = strbuf_detach(scratch, NULL);
@@ -419,6 +426,9 @@ static int reftable_ref_record_decode(void *rec, struct strbuf key,
 	}
 
 	return start.len - in.len;
+
+done:
+	return err;
 }
 
 static int reftable_ref_record_is_deletion_void(const void *p)
@@ -552,6 +562,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 	reftable_obj_record_release(r);
 
 	REFTABLE_ALLOC_ARRAY(r->hash_prefix, key.len);
+	if (!r->hash_prefix)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	memcpy(r->hash_prefix, key.buf, key.len);
 	r->hash_prefix_len = key.len;
 
@@ -570,6 +582,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
 		return start.len - in.len;
 
 	REFTABLE_ALLOC_ARRAY(r->offsets, count);
+	if (!r->offsets)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	r->offset_len = count;
 
 	n = get_var_int(&r->offsets[0], &in);
@@ -801,12 +815,17 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	struct reftable_log_record *r = rec;
 	uint64_t max = 0;
 	uint64_t ts = 0;
-	int n;
+	int err, n;
 
 	if (key.len <= 9 || key.buf[key.len - 9] != 0)
 		return REFTABLE_FORMAT_ERROR;
 
 	REFTABLE_ALLOC_GROW(r->refname, key.len - 8, r->refname_cap);
+	if (!r->refname) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	memcpy(r->refname, key.buf, key.len - 8);
 	ts = get_be64(key.buf + key.len - 8);
 
@@ -829,8 +848,10 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	if (val_type == REFTABLE_LOG_DELETION)
 		return 0;
 
-	if (in.len < 2 * hash_size)
-		return REFTABLE_FORMAT_ERROR;
+	if (in.len < 2 * hash_size) {
+		err = REFTABLE_FORMAT_ERROR;
+		goto done;
+	}
 
 	memcpy(r->value.update.old_hash, in.buf, hash_size);
 	memcpy(r->value.update.new_hash, in.buf + hash_size, hash_size);
@@ -838,8 +859,10 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	string_view_consume(&in, 2 * hash_size);
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	/*
@@ -850,52 +873,75 @@ static int reftable_log_record_decode(void *rec, struct strbuf key,
 	 */
 	if (!r->value.update.name ||
 	    strcmp(r->value.update.name, scratch->buf)) {
-		r->value.update.name =
-			reftable_realloc(r->value.update.name, scratch->len + 1);
+		char *name = reftable_realloc(r->value.update.name, scratch->len + 1);
+		if (!name) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		r->value.update.name = name;
 		memcpy(r->value.update.name, scratch->buf, scratch->len);
 		r->value.update.name[scratch->len] = 0;
 	}
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	/* Same as above, but for the reflog email. */
 	if (!r->value.update.email ||
 	    strcmp(r->value.update.email, scratch->buf)) {
-		r->value.update.email =
-			reftable_realloc(r->value.update.email, scratch->len + 1);
+		char *email = reftable_realloc(r->value.update.email, scratch->len + 1);
+		if (!email) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		r->value.update.email = email;
 		memcpy(r->value.update.email, scratch->buf, scratch->len);
 		r->value.update.email[scratch->len] = 0;
 	}
 
 	ts = 0;
 	n = get_var_int(&ts, &in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 	r->value.update.time = ts;
-	if (in.len < 2)
+	if (in.len < 2) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 
 	r->value.update.tz_offset = get_be16(in.buf);
 	string_view_consume(&in, 2);
 
 	n = decode_string(scratch, in);
-	if (n < 0)
+	if (n < 0) {
+		err = REFTABLE_FORMAT_ERROR;
 		goto done;
+	}
 	string_view_consume(&in, n);
 
 	REFTABLE_ALLOC_GROW(r->value.update.message, scratch->len + 1,
 			    r->value.update.message_cap);
+	if (!r->value.update.message) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	memcpy(r->value.update.message, scratch->buf, scratch->len);
 	r->value.update.message[scratch->len] = 0;
 
 	return start.len - in.len;
 
 done:
-	return REFTABLE_FORMAT_ERROR;
+	return err;
 }
 
 static int null_streq(const char *a, const char *b)
-- 
2.46.0.551.gc5ee8f2d1c.dirty

