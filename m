Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4419E7F7
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910947; cv=none; b=Yh1MyndOAk9ex1Dg8cPTbzKXYFZMMaR0iWYtK8wJXF4S62D0IDf0t+78wa/83fPxzwcJ2tCOp9MaqCytl17Dly/DiR6s2EsMC0A+wRn6c4c35akCmhG3KMFVXdngjCsJ6730moMXP4+MzeQCCAUghrWnYZkNq6YSWUE24W0jm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910947; c=relaxed/simple;
	bh=u3pJJ8vBnzS/ljt/ZI9HbLwre1bunsv6sZ6rJ6xlG8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diWjqic0td8KG7jEpJO5fCebhaqf4gzS/53lU3fJchRSkYi2dCUAmlozTYx3hjMvdkihceJoYtxDVgwumgySrDmc38IlhjpTR1yQUMj/A6STYzzS1WY3H2sSNJZWkaP6zne5qur3Rh+UGrQ9adD8128qhyx+pZ7BOjFTO5SM1BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KPK6gxwg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kUD/hLrS; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KPK6gxwg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kUD/hLrS"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64B21114014A;
	Mon, 14 Oct 2024 09:02:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 14 Oct 2024 09:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910945; x=1728997345; bh=a0Wh6eQsnl
	l4dhrb6IgYXukdP8zx/TgHfwnJLS6tI/4=; b=KPK6gxwgsLAyPOXTQefaaphsg/
	0ksHtCKXvqOpMmsfetE/stwKwI6looexv/UPNaA6s3JMwNHfQyEFotj6JkYQeahG
	kxxR0wCBL9eSCehB8RhW2bbEWK0uHQRYS5bTrnWpq9rKygGZPb53ms5KY1EH4kze
	JnTgUFYMkvLDJFyq2abbaaFFelOD0sE0tV33V3HlL6TGHKXdD9qtpdhCRP7R9WeU
	wnmX24tO/Y14XUG6emkkxM12eQK0V1Q5Nqm/DM9qd2MjcaUgzw/XoRAlUrSVC3es
	foQ0p4LGFvm9hg+oDrB+lvfZaFzlyFywqs1UGFjJUCdbhy7ygxnPQZQ1OwXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910945; x=1728997345; bh=a0Wh6eQsnll4dhrb6IgYXukdP8zx
	/TgHfwnJLS6tI/4=; b=kUD/hLrSM4Zfye2wcm64TiwronAmPB3H0pjynXfRDOzR
	gfRIQdk55uIiwkhF24jbv1t4WbQxPyaVlkH86PEd61OyBOIcJ9z6Py/17I/BPUVD
	PjcUd9b68ucn3Rm19t0Ls6cLYs5/5CXkwNE9F+qIzP4TWrT0FEQHYUxi0+t/acIN
	0xNMnoSl/oC0cQPXYlYJF7KL0pW305U4WcajtMGVWvUSmN6UrG7xid7abu1d1tHf
	qq/S4zoYwoj901s3WcZQr4sKI58dPgErqCH4CfZznUVcDD8m5GaVw+R3rhb0+HhQ
	sWB0WGKcphEqoE8siwrDtEuzFE0GEPLELX8CGmMUjQ==
X-ME-Sender: <xms:YRYNZ2yExcfgUvImBidoJGxk86rJmfAp3hj_I1in3O-FYhnBdKdltw>
    <xme:YRYNZySGmIdU51-nQXBw013REgf9QKW2B7uyDEbXzWvdvnC0JyrY4DmT8JBuKvMNI
    ON18RYJQOEhQCneGQ>
X-ME-Received: <xmr:YRYNZ4XNBZ2GsoiysRzkinCiNeL_vUtxV68lQPJlr-dGakm4dO3dnhrv-Wkd0dfuZseUf9E-M8zvEl69X9rAudk0RvcwdnO9IUm0kkk0bqSxnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YRYNZ8hrnSOxLdSAwaa9p34_fFemkla4eW5EcoyDNXcwUe4-nVv4pg>
    <xmx:YRYNZ4BYgKFDEZ4trsKlnelwKz2zbIIZYv-03bwIGsSpibryDlZ4lQ>
    <xmx:YRYNZ9JKDyqUQ_YSFaGjmpBFs7qyItPjWkc4xK3mZDT25FbRAsEd2w>
    <xmx:YRYNZ_AY8S1jRlaw61v655skauGeBcLvWSxplW0C1UIn2CAwKGEQCA>
    <xmx:YRYNZ7N4cw-LW6-ETT2wcWzQXengGW3ykUZd3VbvUCq9IADe6eLa079S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4fe0b290 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:08 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/10] reftable: stop using `strbuf_addbuf()`
Message-ID: <7408482c152bbf465ecd098059b1477fd38c251a.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

We're about to introduce our own `reftable_buf` type to replace
`strbuf`. Get rid of the seldomly-used `strbuf_addbuf()` function such
that we have to reimplement one less function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c  | 2 +-
 reftable/record.c | 6 +++---
 reftable/writer.c | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 8d41a2f99ed..cd4180eac7b 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -60,7 +60,7 @@ static int block_writer_register_restart(struct block_writer *w, int n,
 	w->next += n;
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, key);
+	strbuf_add(&w->last_key, key->buf, key->len);
 	w->entries++;
 	return 0;
 }
diff --git a/reftable/record.c b/reftable/record.c
index 30d563e16d3..87157f2c386 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1031,7 +1031,7 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 {
 	const struct reftable_index_record *rec = r;
 	strbuf_reset(dest);
-	strbuf_addbuf(dest, &rec->last_key);
+	strbuf_add(dest, rec->last_key.buf, rec->last_key.len);
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
@@ -1041,7 +1041,7 @@ static int reftable_index_record_copy_from(void *rec, const void *src_rec,
 	const struct reftable_index_record *src = src_rec;
 
 	strbuf_reset(&dst->last_key);
-	strbuf_addbuf(&dst->last_key, &src->last_key);
+	strbuf_add(&dst->last_key, src->last_key.buf, src->last_key.len);
 	dst->offset = src->offset;
 
 	return 0;
@@ -1085,7 +1085,7 @@ static int reftable_index_record_decode(void *rec, struct strbuf key,
 	int n = 0;
 
 	strbuf_reset(&r->last_key);
-	strbuf_addbuf(&r->last_key, &key);
+	strbuf_add(&r->last_key, key.buf, key.len);
 
 	n = get_var_int(&r->offset, &in);
 	if (n < 0)
diff --git a/reftable/writer.c b/reftable/writer.c
index b032a47decb..031d8149a9c 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -225,7 +225,7 @@ static int writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
 		*key = empty;
 
 		strbuf_reset(&key->hash);
-		strbuf_addbuf(&key->hash, hash);
+		strbuf_add(&key->hash, hash->buf, hash->len);
 		tree_insert(&w->obj_index_tree, key,
 			    &obj_index_tree_node_compare);
 	} else {
@@ -256,7 +256,7 @@ static int writer_add_record(struct reftable_writer *w,
 	}
 
 	strbuf_reset(&w->last_key);
-	strbuf_addbuf(&w->last_key, &key);
+	strbuf_add(&w->last_key, key.buf, key.len);
 	if (!w->block_writer) {
 		err = writer_reinit_block_writer(w, reftable_record_type(rec));
 		if (err < 0)
@@ -778,7 +778,8 @@ static int writer_flush_nonempty_block(struct reftable_writer *w)
 
 	index_record.offset = w->next;
 	strbuf_reset(&index_record.last_key);
-	strbuf_addbuf(&index_record.last_key, &w->block_writer->last_key);
+	strbuf_add(&index_record.last_key, w->block_writer->last_key.buf,
+		   w->block_writer->last_key.len);
 	w->index[w->index_len] = index_record;
 	w->index_len++;
 
-- 
2.47.0.dirty

