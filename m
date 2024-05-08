Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1E681729
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166247; cv=none; b=S13OC0Os9rv5VO8WY+455+0g9egGZVRoT2VvvaJfSoJFw/r0LF5QhFDKggrluvUONkH4H9ZbZJHpGPTvn1OISwyaT5OVEl1G9hSCWIGv55kEmnnyh1h6mAA7nA9dhgCAMI+wwRU0fsZqDagFyoI+BrxeBD+SE5XRXgnFHIT5Ekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166247; c=relaxed/simple;
	bh=SjQmixg0I5BolOZDDQZTKLfLIYeGvgGglmWn8wHuBPs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TK4YCud53Hw/DtLZBCcBCiBhBcvfWx/TaGLpkm+XpgdRN1cCNXI2OuyVYdrIO+/0II58Nk0AV0kfBql9PUcI+/71oKWD+riRmF5AI8p1TMDWVoEJpi5D/g/6eKoPvxzPIVwcjEmKxHSSXom+ZFQ4KjA28pxYU3n8lq66gQOL2Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VGeM0OyE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Trc0EOVv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VGeM0OyE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Trc0EOVv"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 917CD1140226
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:04:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 07:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166244; x=1715252644; bh=O1dnZy4VQ5
	p78DneuAJe9CzVH9xMYTUrJOwkbGgNcx8=; b=VGeM0OyEsfO2dXH/TSmLb+tu9z
	LHQGeECcnx5t21475BXQa/lXz3j5Usd96ux/GEuBpH0o/PsXTmLXniNCYvcV+/y1
	nf+D7mncvG/AW7URheiiUpMBpPmCYG0wpVJ85M1wAnKsQtenWcnIEHiHoPs71wnU
	mjDFcRGA+vS0D8qbnfA8mrfbk/u2XoClfZkeUY+3Lw9IVaU5KCnQxj7s9pcfh2/c
	xVhjmtwp484tkdDndCqWAA8JSysiIsbFTVdrxHbNUD8RCGfbSp9oXWtOW9n4qrpz
	bMJMh54feRi/hwaTCEFgFo36iLRA+XUTkQt4/Rupf7w3ZoC7xLKuzjqamjBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166244; x=1715252644; bh=O1dnZy4VQ5p78DneuAJe9CzVH9xM
	YTUrJOwkbGgNcx8=; b=Trc0EOVvGDy4LTqXXeMXWDgFqTLP+dKKYkyzWOaUfBzY
	YbhjXorrXQ4C05zrdTLLWdekBqNgwKU0A3vjGKOjocpNaIUkub/aKwaB/Tjoal7d
	t6Gmmru30fZu++xH3u+bYY5j7Xq/yylRnyniRa3LRUgDge1quvAXt88skbtYOdcZ
	ZsoKoEIN1Q2nzfv8wq63wLIOsWA2rBKXrZAPuHD8H39a48lmWIeeQfBlbU24MIi2
	jI3D20w5iTDYBK77359ayl5usZIuJXWh3s6kMudQE+MJqqLxaU2eBfag6KOLY4nP
	mO1cwnAqu3UFECTzWTRagJtF1KlKrRlkyIEpQWyfLA==
X-ME-Sender: <xms:JFw7ZqFH9GBozDw0uOXds6_RoC3uyR-EWBzOsIfugcFIRBjW632dNA>
    <xme:JFw7ZrVBv649nQQ2fJWPzLXAK4JHXDsBGJWub8IG5iz2yY7n_PzrGAZr8UPOPCGfc
    swDxODWMtricN6Fiw>
X-ME-Received: <xmr:JFw7ZkLws7zyk9Ly5EFN8hCxSlR06N4WWm_mQw1a5uUIkE03EDgnl8vCdQq-tAJJa4R8z15esjJtCIIB79PIHIQAMNG33Dj776r9Qt61eVnlh88kZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JFw7ZkEENAAqQGHSPKdcRmJdABYXSMlr1rLA4w7mJtZJNfqZkTgewQ>
    <xmx:JFw7ZgX6J1hdescZ7mYrArXS9SXw1yujXekLfNDTMdJ-xlPYkoXLdA>
    <xmx:JFw7ZnOOKMdotvQil7aufS6UOyYjZ4SxHFYjDuxc7FRHVZg5jfcHnA>
    <xmx:JFw7Zn2K4bogCxZ0F8vo6WrDS4cSi4idXOeJr8RXGU7hq71lwjIvAA>
    <xmx:JFw7Zrf2FG3D1yeGEo5j3TX5yJFiffaeCEqu8zXqVnJX6ObbYQXgYEw2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:04:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c7777124 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:54 +0000 (UTC)
Date: Wed, 8 May 2024 13:04:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/13] reftable/reader: set up the reader when initializing
 table iterator
Message-ID: <5a10a115841512a46e4d3a3d3713e5532facdb39.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0P6OCYDtf0wsLqp6"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--0P6OCYDtf0wsLqp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the seeking functions accept a `struct reftable_reader` as input
such that they can use the reader to look up the respective blocks.
Refactor the code to instead set up the reader as a member of `struct
table_iter` during initialization such that we don't have to pass the
reader on every single call.

This step is required to move seeking of records into the generic
`struct reftable_iterator` infrastructure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index c3541e2c43..021608f638 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -224,8 +224,14 @@ struct table_iter {
 	struct block_iter bi;
 	int is_finished;
 };
-#define TABLE_ITER_INIT { \
-	.bi =3D BLOCK_ITER_INIT \
+
+static int table_iter_init(struct table_iter *ti, struct reftable_reader *=
r)
+{
+	struct block_iter bi =3D BLOCK_ITER_INIT;
+	memset(ti, 0, sizeof(*ti));
+	ti->r =3D r;
+	ti->bi =3D bi;
+	return 0;
 }
=20
 static int table_iter_next_in_block(struct table_iter *ti,
@@ -386,26 +392,23 @@ static void iterator_from_table_iter(struct reftable_=
iterator *it,
 	it->ops =3D &table_iter_vtable;
 }
=20
-static int table_iter_seek_to(struct table_iter *ti, struct reftable_reade=
r *r,
-			      uint64_t off, uint8_t typ)
+static int table_iter_seek_to(struct table_iter *ti, uint64_t off, uint8_t=
 typ)
 {
 	int err;
=20
-	err =3D reader_init_block_reader(r, &ti->br, off, typ);
+	err =3D reader_init_block_reader(ti->r, &ti->br, off, typ);
 	if (err !=3D 0)
 		return err;
=20
-	ti->r =3D r;
 	ti->typ =3D block_reader_type(&ti->br);
 	ti->block_off =3D off;
 	block_iter_seek_start(&ti->bi, &ti->br);
 	return 0;
 }
=20
-static int table_iter_seek_start(struct table_iter *ti, struct reftable_re=
ader *r,
-				 uint8_t typ, int index)
+static int table_iter_seek_start(struct table_iter *ti, uint8_t typ, int i=
ndex)
 {
-	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(ti->r, typ);
 	uint64_t off =3D offs->offset;
 	if (index) {
 		off =3D offs->index_offset;
@@ -415,7 +418,7 @@ static int table_iter_seek_start(struct table_iter *ti,=
 struct reftable_reader *
 		typ =3D BLOCK_TYPE_INDEX;
 	}
=20
-	return table_iter_seek_to(ti, r, off, typ);
+	return table_iter_seek_to(ti, off, typ);
 }
=20
 static int table_iter_seek_linear(struct table_iter *ti,
@@ -548,7 +551,7 @@ static int table_iter_seek_indexed(struct table_iter *t=
i,
 		if (err !=3D 0)
 			goto done;
=20
-		err =3D table_iter_seek_to(ti, ti->r, index_result.u.idx.offset, 0);
+		err =3D table_iter_seek_to(ti, index_result.u.idx.offset, 0);
 		if (err !=3D 0)
 			goto done;
=20
@@ -578,7 +581,7 @@ static int reader_seek(struct reftable_reader *r, struc=
t reftable_iterator *it,
 {
 	uint8_t typ =3D reftable_record_type(rec);
 	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
-	struct table_iter ti =3D TABLE_ITER_INIT, *p;
+	struct table_iter ti, *p;
 	int err;
=20
 	if (!offs->is_present) {
@@ -586,7 +589,9 @@ static int reader_seek(struct reftable_reader *r, struc=
t reftable_iterator *it,
 		return 0;
 	}
=20
-	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec),
+	table_iter_init(&ti, r);
+
+	err =3D table_iter_seek_start(&ti, reftable_record_type(rec),
 				    !!offs->index_offset);
 	if (err < 0)
 		goto out;
@@ -722,15 +727,15 @@ static int reftable_reader_refs_for_unindexed(struct =
reftable_reader *r,
 					      struct reftable_iterator *it,
 					      uint8_t *oid)
 {
-	struct table_iter ti_empty =3D TABLE_ITER_INIT;
-	struct table_iter *ti =3D reftable_calloc(1, sizeof(*ti));
+	struct table_iter *ti;
 	struct filtering_ref_iterator *filter =3D NULL;
 	struct filtering_ref_iterator empty =3D FILTERING_REF_ITERATOR_INIT;
 	int oid_len =3D hash_size(r->hash_id);
 	int err;
=20
-	*ti =3D ti_empty;
-	err =3D table_iter_seek_start(ti, r, BLOCK_TYPE_REF, 0);
+	REFTABLE_ALLOC_ARRAY(ti, 1);
+	table_iter_init(ti, r);
+	err =3D table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0) {
 		reftable_free(ti);
 		return err;
--=20
2.45.0


--0P6OCYDtf0wsLqp6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XCAACgkQVbJhu7ck
PpS9VhAAotdReq4SJAW8sN1Xh5nNDsyhT17qWvIBGqpnpX9q5iUcVHbWcqiLe7j3
J9zXuWHq5tz+l3w0yU1T1oKpH0O+zZDtFqNS2THzctqa0XG2U83C6ljkHK4pcgQL
7qjSIhkAfaHojFJOLIX+JJjTzRpnZVT4DCClUKtc0W0aJooVo23ZH/sX7/rbew+c
mOf5ztLuQaPnyIosxbqu7HHgy6EnomV+sx3h7ZgEHirhHv6PfO4M+QafoD76S8/5
erArWJ2Pyfn8ZcY2kc6uZ+nfK2BDse+Y7F3vRGjHmW267VoUR/tLoRTBz9LDHOw9
h00IELZ7VKMcVq2JThhfVGECxL6PaPhc9HscfTrcuD2Pzd25Txqb/i2l7IIzXcJ9
kVo+Yp3FD5I4VI4YpFgP/i/w0wYWzxIWFIuKkpyNOhK1n8YYXhLEI5he5n1ISxsG
8V5FCOItSz0AXENsILNsawE9Y1Jzi6D9mjkWG3pmSsRLdgJ8srsOZklVYPfwzp3O
8ROXZq6e+TrtzcFyYx+bO6wPd0EH7bJYbOhxH0TDMe8Smqg1Yq5SRSN5fE4m4yIY
sJ2u9Od2VYHi91KYpx3XH+vfl+uG+/U98RXMSTbICImmc4FDCyO5xcvNnDTIbue9
vXyc9453iZ6SvYcB3cClUmrl9OXTzfQ3c+cgkwkzwnr8FAWuhU0=
=i7eu
-----END PGP SIGNATURE-----

--0P6OCYDtf0wsLqp6--
