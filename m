Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77414AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079013; cv=none; b=TaS2s/3Veh9r7IR8u5cpYkLCQwmr9QJnxFufs3FPTDsLK60yrkczaU2xbJr7jyX7bMVNzVyPbxy5XL1LT8qZrDkWPGriDZWEYDz2Ec0MoGAKxJlVIHBLzHzARq5PPRRiFcdD6ODIx87EflVlFXTXwlYYsnSG07G018s3TH0UpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079013; c=relaxed/simple;
	bh=hypefMVF3/Ogj17LPtUltsQK2JNqmp/pEn8cJMtw/hc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWLkAKM4BgoHoPBuJBJOC7k8leAkcMJdeGGrIGJ1reJAcQlnE/pzHonr1EiOLmSHP+BqjK6B1ZRto+TEy5+iipKotqd18G1CRUm6CJdRPRP0xWThUziaKawr6VY/PLg/iA+bqbk2pHxO4C2uphgxBLTHlxgRs1hzkXeg/VHQ/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nk50NIK8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VifmtfIy; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nk50NIK8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VifmtfIy"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5795618000B9
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 13:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079010; x=1712165410; bh=8pOR+nwpbP
	tyoVnZAX+NmwAlTazeTdbfqfY3cjsMcmI=; b=Nk50NIK8BXPXE2izPtXkXV3yMm
	D7h9iEc1qoOyrz8ieyTtcNSv4ALSWoWigFO6LsCbmmbkDacBfNMlc1aKhxBMTYF9
	xWCdOD0NoN/Gj54TpXHCeq/iOqcpfNLPnXuH6AXKZPOStXAXNm68RA++zcYYtuyf
	gF05sBWfkhvaufLMAlx21j4XMZc+PkaPFl6BOQOMGHYUWsHbnnCjFgLMdx7Lhpup
	+XQUCaw/fmNZSK0TG720eBH1L+yaKlmb8X4RWL2hfRLjuBIJHrx4SYiGh9PKMteY
	bn6gao1HpFgPK8fSHA4edOaehxAr7ZTxuAnUYOfBcRkmHareXa7N+osK2cSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079010; x=1712165410; bh=8pOR+nwpbPtyoVnZAX+NmwAlTaze
	TdbfqfY3cjsMcmI=; b=VifmtfIy4XSsDRbxZBVNcQ9wev45zxV1fqwC06uvhoS2
	F/2BlSD9EANJF/IYiAXP5IzrAbzES61GcVn1LWRxyUh/npcxWsSGMKUmDctOSJrV
	OThpZM/Vzn9J2CYXhntesB5V/C2ofmqitefpxEjUNtmhM3SbZ4NHAwXhgsLyJ1Xj
	tpgwqRfe4BG1bcvyjtl8jqRddX3jnERprMGb2ycYKz3aSGs7pEp+BHLweJP4PcoT
	sMsM8z6+w8Y/BTUgNiblMC/1jgnNecN+TUpGGN4bx3RHCcjCMGYpc0QlmwNLJryP
	dEm4CLMmEGPwoGp5uriS00bnooIG8avn1Hr15FDwFw==
X-ME-Sender: <xms:okAMZk2yJRlIPs60BwmHG1fLV10tNwO-E0FL5Euj_arB-jRFcv1PnQ>
    <xme:okAMZvE0MABtTqHr8ixb-mGUH022SnLgZphBdD8Ny-McBQGC7I9V5jo_K_BUZRo7H
    c9UZssdPIDLahv-SQ>
X-ME-Received: <xmr:okAMZs5ooyfR2Wj0aCKkY230NOL-AvTe768cXgQBBcupPipwWZexq0JnnuYhNUXRpTENWUHWsJyGa6A8lAZTuwN6C7rRQjovI-tuaoEcF8Y-rgI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:okAMZt0fiDck9JKqtVFXuNDwaE9SNt5B1xL070X667dluzBspuv-rg>
    <xmx:okAMZnHjlTNrmMTOv0CRiI7IsHt4JvuppM7cNJc3Rpd4gBw8-yeGNg>
    <xmx:okAMZm_5O8z5NdLXwfP_7N9DQfZ6wPnuGLGIl1DAgoJbumkRd2pPfQ>
    <xmx:okAMZsl_lH71LxsQ-jWX9s-NxABndjmPxDwFOZMutbLyKlSGEquX4Q>
    <xmx:okAMZsSNtYlOcKDk9ePSn32moS5Ybu8cjC3ms29xBJSMXYoCqcnG59Mi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44c0ac6a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:30:01 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/9] reftable/writer: refactorings for `writer_add_record()`
Message-ID: <8e9d69e9e6685b097f4d184f9a7e2a2d753c95f1.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7RM9zaSZbp64ErRZ"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--7RM9zaSZbp64ErRZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Large parts of the reftable library do not conform to Git's typical code
style. Refactor `writer_add_record()` such that it conforms better to it
and add some documentation that explains some of its more intricate
behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 1d9ff0fbfa..0ad5eb8887 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -209,7 +209,8 @@ static int writer_add_record(struct reftable_writer *w,
 			     struct reftable_record *rec)
 {
 	struct strbuf key =3D STRBUF_INIT;
-	int err =3D -1;
+	int err;
+
 	reftable_record_key(rec, &key);
 	if (strbuf_cmp(&w->last_key, &key) >=3D 0) {
 		err =3D REFTABLE_API_ERROR;
@@ -218,27 +219,42 @@ static int writer_add_record(struct reftable_writer *=
w,
=20
 	strbuf_reset(&w->last_key);
 	strbuf_addbuf(&w->last_key, &key);
-	if (!w->block_writer) {
+	if (!w->block_writer)
 		writer_reinit_block_writer(w, reftable_record_type(rec));
-	}
=20
-	assert(block_writer_type(w->block_writer) =3D=3D reftable_record_type(rec=
));
+	if (block_writer_type(w->block_writer) !=3D reftable_record_type(rec))
+		BUG("record of type %d added to writer of type %d",
+		    reftable_record_type(rec), block_writer_type(w->block_writer));
=20
-	if (block_writer_add(w->block_writer, rec) =3D=3D 0) {
+	/*
+	 * Try to add the record to the writer. If this succeeds then we're
+	 * done. Otherwise the block writer may have hit the block size limit
+	 * and needs to be flushed.
+	 */
+	if (!block_writer_add(w->block_writer, rec)) {
 		err =3D 0;
 		goto done;
 	}
=20
+	/*
+	 * The current block is full, so we need to flush and reinitialize the
+	 * writer to start writing the next block.
+	 */
 	err =3D writer_flush_block(w);
-	if (err < 0) {
+	if (err < 0)
 		goto done;
-	}
-
 	writer_reinit_block_writer(w, reftable_record_type(rec));
+
+	/*
+	 * Try to add the record to the writer again. If this still fails then
+	 * the record does not fit into the block size.
+	 *
+	 * TODO: it would be great to have `block_writer_add()` return proper
+	 *       error codes so that we don't have to second-guess the failure
+	 *       mode here.
+	 */
 	err =3D block_writer_add(w->block_writer, rec);
-	if (err =3D=3D -1) {
-		/* we are writing into memory, so an error can only mean it
-		 * doesn't fit. */
+	if (err) {
 		err =3D REFTABLE_ENTRY_TOO_BIG_ERROR;
 		goto done;
 	}
--=20
2.44.GIT


--7RM9zaSZbp64ErRZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQJ8ACgkQVbJhu7ck
PpQpVRAAgGUIMXhEn+nk6PEOJXnT2h5Afiu7tu8szBIcmOgKnesGQbhlF3tYDjk5
0XNlc04S+3WryKhiMVVtpLoa36kfJWMbJu3f/oSuNMUIHOO5pMid2T8si4ijO+qU
ksICu4qYenh4fk2vhMKMldsVkOJOO7BDkGpjHrZKpfm3mXykNNabZBMm4gS20MLN
DJ68DvOE0ZKmh3IOaS0i81wQSOJPre7oTFboe4Ea6JI/excamrl++dw18BTWDQ+E
fLGhOzESD0Kel4mtFkggKZpUKiVccNOLuOtaQ9kkeYoPGiTZa8PijszPnSR1R9Aa
7PAX6QyTCF+kNdHv/e1VtESeDcuygN3Msyl5/7Hm27dvqBgIjCpRgM/jZVHA9m86
BrQyR3OSwlhREVERBHmybiYQIegD6yw3m1IB/hE7MQGPMsKhKqmxQcKHBhmzasXL
98NtwjMCPg6+sAMcEkTu7L+L7OcYEz9KvqK3Z5UxenGQeqSk3wZSMvlkoYBMOc4Q
nRojRFgbUoEWv/dB7FIa4H6MM2MTfxUgqp27VC5CGAO9psBmoqQ+RqyJHoHcsjHP
8Ol/YB20JrqvWJ2ZP1a69sSqkz6Ua/m4n6i6DuCVViJBod7GM08uVZgsuAbfITd8
gLT1PoD3oOpvU2pn4jjbdXh5UvQcCoDg1+/icvj0LDHkqgDPhCA=
=cFlQ
-----END PGP SIGNATURE-----

--7RM9zaSZbp64ErRZ--
