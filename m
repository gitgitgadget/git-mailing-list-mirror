Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE492200117
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866549; cv=none; b=O/kl8buITC/WwTDAenoPIQ5vc+6BJSoDVPzVlX3XA4+nTvKMXZiC9SBYSBaE6KqxjEZAXHQqI8zzpjKgQ3bCBEkbctvUEexxheT68nhugMvTsPZ1qdPOq785RcaO6k8Ehjdz9cRETAKx5sOpNKoaMUwQuaDuy1wTf469D3o81Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866549; c=relaxed/simple;
	bh=ot6B0w+28e/TupIx92ZkFojzo9W9HHxyu8OY/qL+g6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADtaFZAlqNTbbhVHZSLpAv9V2AW8lmkNU8liXJBffokeF8oc/5Um56n5wwhCV9K7gPjtzivahBsTl1Sutpa4mR7CXyq9tqvqqrgDgoGFRIK/WRTRgKG7Aab+nTIQUxybOEf181Plakfw82iGPMMiritE03Qnek9KOfRcVE5I78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pStvdjog; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9CVjgzU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pStvdjog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9CVjgzU"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA7421140239;
	Wed,  2 Oct 2024 06:55:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Oct 2024 06:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866546; x=1727952946; bh=KxA1xL6cHw
	NNyBOTShE8qLiR46Dx8bSgoiF1YRu9mb4=; b=pStvdjogGZK9CNMGwKDB713N2r
	Vhjf5kXv5KMuB9NEf8FN5XDDivPCtIs+tDEnBMAB9SVHXZeq6MkuJoab+m0YUtQ4
	/JiLsSB5uZdDCxwr4o9iEbxGR2ZpG2jWN6H1lNPofuagWKOx+MFb+i33cY04v6Gq
	0va8pFAbCkq/oYNVQhQXT7zUW6SOGyXAUOkF7PfvbduS/s+osEobFkOdK0BEbCkl
	oIWs9oHrnkye1FAzAmNBbav+jzEPouvyZqR51K2Kpv31pYMfdN0gm0qp03MKmHl+
	G4s5JlI72W8GtjP8G9qPprzUHd43TPiwtRaVdua3PdUIZvQSCbKR+MyM9WgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866546; x=1727952946; bh=KxA1xL6cHwNNyBOTShE8qLiR46Dx
	8bSgoiF1YRu9mb4=; b=A9CVjgzUBojRDqLz3E3yBYoiZZbQR2/i1aSoaa7AaaTW
	SwMFgWYG91Y1EikqGQkIOO8kS5rx93vNte7iNjwh1Mf8TBo+lJUvGAsY/p696Bgl
	kgcz2X0+HD0Hodj/dNaFXgNktdCG0clcaSkBNKVvvh7xnF5vwOJIaocVSovUNB8G
	hI4FbFzk9IeSv2vXBmg2Ret3oaR3l+niuPRB6XO/7R94ENq5d/hvU26lVyv7qlti
	coK51saSsF/Z0I0rGbLOH6IvNM7C9ctOl5XXaLszKUZzP2gRRNiJt+gNMHQAfjUx
	ifrCxFqw0KqAjm38wZAU2VyIvKs6HM2xn2q/Os5Yhg==
X-ME-Sender: <xms:sib9Zv0GhuP1lLZRCB1Qg-4k6pucSQ-_kMs_jpLeLZo6gycwLRB_yQ>
    <xme:sib9ZuFjimmc164Z-msWFMnnxjMwqlEmxr-e_zaydl-tH0nd_SwZtWeApF_FmkA0V
    3iKAgsNo-X5LSDeOw>
X-ME-Received: <xmr:sib9Zv4EdW5ifEdaQs7CUu-9GhWOPxzV1HW2UX5x8_LCRK0Gi_paEUeCSEL1CsHWDJrHJio4BQ3aoLGHdbN7DUDJWZ_tjxVyHgO0qmd5rakirST0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveffudeuuddugfehuedutedtjeefgffhtefguddtieeh
    ieetkefffedvteduhfeknecuffhomhgrihhnpehuphgurghtvgdrnhgvfidpuhhpuggrth
    gvrdhnrghmvgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvg
    gufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:sib9Zk3AWk22I7KcAXMKiB-lVuzAJpbg60eZ1VNIQqfIEF-Ih4wl-w>
    <xmx:sib9ZiHTqMECzDA7WRUhdW379msOKK40hyun_lHP3wxm_SFv1MiH7w>
    <xmx:sib9Zl8n5OMbbfoFFBnfST1oDVRzKhCamTUWsZS2LXz11h0SDYL96g>
    <xmx:sib9ZvmutSNluJtNSTo1Eu2LCMeG_XeKaaDyN_Ry6qwcHzdY2N_zCA>
    <xmx:sib9ZujDBrjGzSPaT1fkwdMf0t2pg4cmmXB5KUE9K0rhMxSYozc33n_u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f3158ba9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:55 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 07/25] reftable/record: handle allocation failures when
 decoding records
Message-ID: <ca64971e7b892524e553d20e6726c95dd1865787.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
2.47.0.rc0.dirty

