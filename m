Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C417F394
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683731; cv=none; b=Rv81cmGeNd5yliHYPxoBdrgxEC8wJP85n2K7L91Saq9Ie3vMa95aZgroN5s2ZZHonSWW+Iithi5A90xpEERj9i3CV0G4Idp7EGEOFLuHixJSbnKTCNAfPx+ptWmUp6LHcZ0n7pOAbPdH1Zh4IafwyvtpzcoMaf198KqGIgh9RZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683731; c=relaxed/simple;
	bh=aAPSdhwlCpDydnqM3dRqHbY8h+N4oeSJEOt+Hl2I5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rps5srO4EuYOHO6+Y5RXUouU8vUxR+2gjFvIDIPvae10Mg0M1QOrseFsTssLEyu2mKuzBv+HlEL2z9W8iLhfsJX3DFht0L7BO8AKngMMwwxZ2xy9cheMIS/Sljt6C2DoncoiHSSwk7o7UEa04kB8QLJnqI+KRnxPxcSwjM9044k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sES8mhec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=exaTaOaB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sES8mhec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="exaTaOaB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9B5F1140216;
	Mon, 30 Sep 2024 04:08:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 04:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683728; x=1727770128; bh=gfj7sLNQq3
	mC9jb+5yyAnYW/isR9ZxyeSif/nqrO6sM=; b=sES8mhecGYUFQ7XzhR20YmR+Wz
	lupnwy8NklO3zL9SQ/6gUEQK/+gnV8rAd+HuXkaBN3f4+2aLBUK40AlGFYoBYTPo
	CpwByBjhqNVVBRKc/O9dFy9IIKmOcZSqMu+V7LSQkROpcmdxH2s8NQK0JkRaDTjk
	BjOGZpQ8bR+mAeOvrCXnwyECCx1KUfjvVOOCto91OBUYmIPfYR7XzELSY2euksaK
	P8zEsk92OM5RmNAW9yITErK6AtJIkSYBJEfSlvwbN08vhCax7aZI7Jwtz8h9WaHX
	4nUB1YgfM+1np3zUYO+mThLDWDAizItYuY9Js49jVGFs2z3es5ky+16g543Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683728; x=1727770128; bh=gfj7sLNQq3mC9jb+5yyAnYW/isR9
	ZxyeSif/nqrO6sM=; b=exaTaOaBZKMoBkQnpvDFNnIUpDE27Ns2qKAL0wNAfYwz
	3BGC3gyrP+1Z4tjBHP2GZEvetFfSCR9VG4nOsDkUllzqfzXHE1BiUE8JQXUvDpoq
	pJoKfhui9o/q2zuLYtrGDtVn2f5QVgB26CTg18ZO65JpIfrDHfXCyXGDV96izW0h
	EnBJA4/k14+6TtEdd59lvn+sNKRg6Y2oBr2IdbFgU73ZU5eetxcL+Ub3LQp5d9mO
	L7ScbmBwMSlqOvi/2YM41ozpD4HEVjqaIjqO57rseRAEJehQ18AvRxCGrxOgFTpO
	MS4V3ayx9auv40x3Kyfw+WQf7LFwAW0Y2vPM4K59sg==
X-ME-Sender: <xms:kFz6ZmaeNiAPKoYiaHzruMtmLIASrz3lW27JKjbPomhWNi7nESTkTA>
    <xme:kFz6ZpYxj4uy53M5uOtprnO1fFMjAWMrwn5swL9-Z0Q4FFOHBpugobR30FGwFosrE
    xVeX17BGAIJ4AkDKQ>
X-ME-Received: <xmr:kFz6Zg85LdTFXeAW6Nbf97BjWb1nLsUsSv3czlQlgzI9D7pEsRw3MTd7ZGTF0BVLUqdNAqxQ8FLfgPU9Uv6COFc0i1EwmqEiTrQ7QXNgN3TehUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhh
    ohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:kFz6ZooxPNk2TBHP4Qg6tTix0j4VRJ8FyNQ5wt1Q2ofayV3hJE5qzA>
    <xmx:kFz6ZhrYniZyUqCDRBSGnfJLdtILyDdKwpn0NRD0kTtBizOWmdnIKA>
    <xmx:kFz6ZmT7p2wRgBIQJdUV5dlwLSyA7Y7995-5dzmog6aCtL3tq5AtyA>
    <xmx:kFz6ZhpzLxouu_ubkHRMCnvYe0q3dav-KogkIxW8HeKED1xoWagzcA>
    <xmx:kFz6ZimLTva9aPQr7aAbAA4mqyzecQig3-D3ITRxqVaqBVZ3dms731Qr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 735b9acb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:02 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 12/22] reftable/reader: handle allocation failures in
 `reader_init_iter()`
Message-ID: <9b5fd52862bf9ee4367481e285990883e8547ab4.1727680272.git.ps@pks.im>
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

Handle allocation failures in `reader_init_iter()`. This requires us to
also adapt `reftable_reader_init_*_iterator()` to bubble up the new
error codes. Adapt callers accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c                   |  4 +++-
 reftable/reader.c                   | 28 +++++++++++++++---------
 reftable/reader.h                   |  6 ++---
 reftable/reftable-reader.h          |  8 +++----
 t/unit-tests/t-reftable-readwrite.c | 34 +++++++++++++++++++----------
 5 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 5a8ea8ae77..741f62ea63 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -244,7 +244,9 @@ int merged_table_init_iter(struct reftable_merged_table *mt,
 
 	for (size_t i = 0; i < mt->readers_len; i++) {
 		reftable_record_init(&subiters[i].rec, typ);
-		reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		ret = reader_init_iter(mt->readers[i], &subiters[i].iter, typ);
+		if (ret < 0)
+			goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(mi, 1);
diff --git a/reftable/reader.c b/reftable/reader.c
index 485ee085da..f696e992df 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -554,32 +554,37 @@ static void iterator_from_table_iter(struct reftable_iterator *it,
 	it->ops = &table_iter_vtable;
 }
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ)
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ)
 {
 	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
 
 	if (offs->is_present) {
 		struct table_iter *ti;
 		REFTABLE_ALLOC_ARRAY(ti, 1);
+		if (!ti)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+
 		table_iter_init(ti, r);
 		iterator_from_table_iter(it, ti);
 	} else {
 		iterator_set_empty(it);
 	}
+
+	return 0;
 }
 
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_REF);
+	return reader_init_iter(r, it, BLOCK_TYPE_REF);
 }
 
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it)
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it)
 {
-	reader_init_iter(r, it, BLOCK_TYPE_LOG);
+	return reader_init_iter(r, it, BLOCK_TYPE_LOG);
 }
 
 int reftable_reader_new(struct reftable_reader **out,
@@ -689,7 +694,10 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 	struct indexed_table_ref_iter *itr = NULL;
 
 	/* Look through the reverse index. */
-	reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	err = reader_init_iter(r, &oit, BLOCK_TYPE_OBJ);
+	if (err < 0)
+		goto done;
+
 	err = iterator_seek(&oit, &want);
 	if (err != 0)
 		goto done;
diff --git a/reftable/reader.h b/reftable/reader.h
index 3710ee09b4..02d10c5d37 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -56,9 +56,9 @@ struct reftable_reader {
 
 const char *reader_name(struct reftable_reader *r);
 
-void reader_init_iter(struct reftable_reader *r,
-		      struct reftable_iterator *it,
-		      uint8_t typ);
+int reader_init_iter(struct reftable_reader *r,
+		     struct reftable_iterator *it,
+		     uint8_t typ);
 
 /* initialize a block reader to read from `r` */
 int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index a600452b56..6a2d0b693f 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -46,12 +46,12 @@ void reftable_reader_incref(struct reftable_reader *reader);
 void reftable_reader_decref(struct reftable_reader *reader);
 
 /* Initialize a reftable iterator for reading refs. */
-void reftable_reader_init_ref_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_ref_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* Initialize a reftable iterator for reading logs. */
-void reftable_reader_init_log_iterator(struct reftable_reader *r,
-				       struct reftable_iterator *it);
+int reftable_reader_init_log_iterator(struct reftable_reader *r,
+				      struct reftable_iterator *it);
 
 /* returns the hash ID used in this table. */
 uint32_t reftable_reader_hash_id(struct reftable_reader *r);
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index e1b235a5f1..acca927a2c 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -206,7 +206,8 @@ static void t_log_write_read(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 
 	err = reftable_iterator_seek_ref(&it, names[N - 1]);
 	check(!err);
@@ -221,8 +222,8 @@ static void t_log_write_read(void)
 	reftable_iterator_destroy(&it);
 	reftable_ref_record_release(&ref);
 
-	reftable_reader_init_log_iterator(reader, &it);
-
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -296,7 +297,8 @@ static void t_log_zlib_corruption(void)
 	err = reftable_reader_new(&reader, &source, "file.log");
 	check(!err);
 
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "refname");
 	check_int(err, ==, REFTABLE_ZLIB_ERROR);
 
@@ -325,7 +327,8 @@ static void t_table_read_write_sequential(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -376,7 +379,8 @@ static void t_table_read_api(void)
 	err = reftable_reader_new(&reader, &source, "file.ref");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, names[0]);
 	check(!err);
 
@@ -419,7 +423,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	}
 
 	for (i = 1; i < N; i++) {
-		reftable_reader_init_ref_iterator(reader, &it);
+		err = reftable_reader_init_ref_iterator(reader, &it);
+		check(!err);
 		err = reftable_iterator_seek_ref(&it, names[i]);
 		check(!err);
 		err = reftable_iterator_next_ref(&it, &ref);
@@ -435,7 +440,8 @@ static void t_table_read_write_seek(int index, int hash_id)
 	strbuf_addstr(&pastLast, names[N - 1]);
 	strbuf_addstr(&pastLast, "/");
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, pastLast.buf);
 	if (err == 0) {
 		struct reftable_ref_record ref = { 0 };
@@ -534,7 +540,8 @@ static void t_table_refs_for(int indexed)
 	if (!indexed)
 		reader->obj_offsets.is_present = 0;
 
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 	reftable_iterator_destroy(&it);
@@ -593,7 +600,8 @@ static void t_write_empty_table(void)
 	err = reftable_reader_new(&rd, &source, "filename");
 	check(!err);
 
-	reftable_reader_init_ref_iterator(rd, &it);
+	err = reftable_reader_init_ref_iterator(rd, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "");
 	check(!err);
 
@@ -802,7 +810,8 @@ static void t_write_multiple_indices(void)
 	 * Seeking the log uses the log index now. In case there is any
 	 * confusion regarding indices we would notice here.
 	 */
-	reftable_reader_init_log_iterator(reader, &it);
+	err = reftable_reader_init_log_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_log(&it, "");
 	check(!err);
 
@@ -858,7 +867,8 @@ static void t_write_multi_level_index(void)
 	/*
 	 * Seeking the last ref should work as expected.
 	 */
-	reftable_reader_init_ref_iterator(reader, &it);
+	err = reftable_reader_init_ref_iterator(reader, &it);
+	check(!err);
 	err = reftable_iterator_seek_ref(&it, "refs/heads/199");
 	check(!err);
 
-- 
2.46.2.852.g229c0bf0e5.dirty

