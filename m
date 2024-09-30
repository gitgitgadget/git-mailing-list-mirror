Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2E1779A9
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683716; cv=none; b=CWTRtpycjnz5f3/mUSRjzr7kepu2fBroUERNChy6mlcHPqo2/O7o6xEvBG+yGRdGa2rU+RpkGuXibKxIwemOl9p/hLQdqqEPun4tt5Nzb7OW11GiOaibViHN5spCzkEme589H19IX4YC28Woj9gHR4pnWOWEjmSphvKlxh3qhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683716; c=relaxed/simple;
	bh=OQd/ABrGxViU2XDjPeICxfJX7sw379F90CF6+s4iOcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5QTMGAEipu6afZBRVczM94lY3gJvGU7JTZ/J6WS1unet+rfmts3hR03NnhMo5kkTayg65fdzVcuvqGBAWjnNPixkCUHsP10E9qY+5ON013hsE+KaVIt3yJSHWs17XfiCGMyyiaWf5QLJYENBnFGUe2E2qVVjpkPymuC26Qx8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFwjFN91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BMSAj73c; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFwjFN91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BMSAj73c"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6D67A114020B;
	Mon, 30 Sep 2024 04:08:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 30 Sep 2024 04:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683713; x=1727770113; bh=L7ApDYAolV
	DA7QzZ5bOgTjDYj+BgizQxvcNCZBkL6NA=; b=TFwjFN91JIFVb07dntJsLD6xMB
	R5Q+42PY4f3a9scEwjC9Tafp4xPk41KXx1y8z7kkJu/T5vN9TxcHbAS5whcq5DPi
	AGeSHqDhG/79R6rG+pzPYvaRXp2a5T/Oou6NeCa5XzueT5HZuiKLsqzrtDfS4io8
	6EwT4cFG2ef2kikXicFIX6Vk3Iora70ouiNAW80qf+lreJ3Y0vlaeZEs3SHdRD4s
	bcuw/ibBcw0wUvKyK70pTZ3yIUufNY6wxU5Ym4s/SMjT5iCckAlAvNiJtOwv4HiM
	DV/xIWT7DgGfX5adScam9LhXY76acl9UeW4dBXzhh1knzNCo/3UE0I4Kidmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683713; x=1727770113; bh=L7ApDYAolVDA7QzZ5bOgTjDYj+Bg
	izQxvcNCZBkL6NA=; b=BMSAj73cUpSKThAgBXHzYiWo98VKynv/dCoZA/Hd2aoJ
	ACPLvmlHhzOPW/UkHxxVBGHBH1bFmCgQ6xgQ0XUjPE95t7huTfMJIprVyKScdJFG
	bzuJaWdyoGPufdjJMm5qy2YEY+WkmBoojYrRf+IboWZbCA4+4eJIRCqzU6LXiM/s
	JIXERc8Y6xxF2x/DhDtmLYPKDha1ZLnfjQ90zMCw5Ul3k6AGn7F8XWI9GXZRy5mi
	xHcjTgn2jmfEa19Km9p89bo/vSTncNPcDgwGsmOtw6j3im9zIZq95sFGh9kPZNIl
	f75chxCEX93v2U+638hlI5EQqKs9pDUPKHaA+HTFSw==
X-ME-Sender: <xms:gVz6ZuyTk1pfve4iWxzMCeufLqoCyupM6pNwxkiLfudViGlfcptQXg>
    <xme:gVz6ZqQfQnW5KMR76kxHFe9wEFQraUicb6BktCjthZ9MyFfxaYt_28h2i-OVHXt1f
    42-XxnN9BHMowuouQ>
X-ME-Received: <xmr:gVz6ZgUpJbAD_dg9AwKk23dupd6O3dU4TTkotxGqPm6VHqEHNKkDpvqledzOvXgJyd5Pz04qN4uN1uYwE-Xsgdr-XtVd4Kpd_4y1K6MxFowd4hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevffduueduudfgheeuudettdejfefghfetgfdutdeiheeiteek
    ffefvdetudfhkeenucffohhmrghinhepuhhpuggrthgvrdhnvgifpdhuphgurghtvgdrnh
    grmhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiienucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gVz6ZkhhLM6ROeqep07sQMdWf5zgwsxNhyONleX1RU3_hgjElYiMtg>
    <xmx:gVz6ZgDg7wJTvvU1Cf44TryfjTuXpIeIMyOT7ablpy66xk7xVlnrYw>
    <xmx:gVz6ZlL8SMT6yKoM-6yCNZC21wZuhLv0ApumIHCYCdKCCN4SAaELKw>
    <xmx:gVz6ZnCs-k-foZ18Jnv-lMAMLFAkRrks_ly5X4peyhQfWW_yXl38TA>
    <xmx:gVz6Zj9Zi9EkzaCkudUM6E_gXKZE2etdkhgrachFLjqocBkzgLIgFiQj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b66b74cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:46 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 07/22] reftable/record: handle allocation failures when
 decoding records
Message-ID: <874e6a1c207b9684e533ce8372d2537c07abf43a.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures when decoding records. While at it, fix some
error codes to be `REFTABLE_FORMAT_ERROR`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 80 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 60fd33c9c9..787e134c9a 100644
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
2.46.2.852.g229c0bf0e5.dirty

