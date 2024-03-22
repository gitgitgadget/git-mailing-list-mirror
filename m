Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B345033
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110169; cv=none; b=C/OUcJBk3iBzBKlQFsGYMwiR3syBP+zEeshdBMiBEEe6+y+nfmXqZSBvfDyj6UkKBOzIclAEIm8liUfljqwxQ30hznHms5pg8Jb40JMsh5cjJie8DHq9RE82VAQ/wdPrIrKU+u4Hs4DdWwJxTIlvgK3g1vgA/KHfJIPVKrjRbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110169; c=relaxed/simple;
	bh=rKovJTyTp+8/JRebPji9kMT5D2tNRmHtEeI0pxH+K8k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKn0neRNpreKj2YiztR6OpIWDlFJZ4xnBTCgthsquz+/6VKg47EmHB1F77ns2aXpMRfBkQEzKrhuL5xC6vu/ot24oeh3MAbkfm/yzPGuSDPSgEvaIYzzKI9ecNz0JPIdVAYbc2qoLj37DQ5PSiHHQejA1zaDNGtdmUsncyX5jHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wt9EGCFC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hiGOFOP2; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wt9EGCFC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hiGOFOP2"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38C8B114013D
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 08:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711110166; x=1711196566; bh=qfiGegWuXb
	rIgwMta1Zr0bm7JNs0q4sDzvVnJGIVu8o=; b=Wt9EGCFCsHySSkaofXIziQhfJp
	fRQMUAXrlMI2SmztzzsBPEXTcrQgnFzKm9pc523NHqN1GUUs4nO7wodeIT+TolEH
	MY13bBPJy/TZ2P2mK7CdbD6CL5fN8hsRcrCwtHXAZj/i3cvec0nnE85BkFomyt2H
	IwBuOrNs1jygiH3L8jGUcOlJ6PMtcFGLl050Bcg4J5qFjElZuATg4lbj8x8/zB75
	nDX10Jm+Rk9eAjNStnsAWfUbA2+r3+erdK0e0jghIcvsH88TNU57R9Gb5rj887Dg
	nnJ3ioVGa0is0rNq7MhAjVIMvssUJK8q8wxm+abVruim6iT2k12GukzfX47A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711110166; x=1711196566; bh=qfiGegWuXbrIgwMta1Zr0bm7JNs0
	q4sDzvVnJGIVu8o=; b=hiGOFOP2YIu8+dG/YtTHpvC7i6zmZrLsWt0t96Voz8JW
	UhRMKezzrrGYG0iQb3yeUJ6FChC+XTBUWVp8WJVRh55WuPS67sD2TqSMGgBPuq38
	xu3fS4XRqZr6M5ww3wLoYXDXvZMpj5sciHJJrD7K9ru308YWiXHNGjN8jGKBzuS7
	QtJ3Ztjumr/3U29YcnRJdTPtJ852oa0Q2dKXOV6C+l0mXpAgFR96gmy+xmpz0tKz
	JfXsL/0pBUqAUHS7wBPtRTSe2LpUrkmtUuIdTJQ7PFcUuMSpJT89JYSlwTiBeyZq
	E/y1wryHU4YE55/ikjpY8VK1fIpSHNC8MWtpggh5LQ==
X-ME-Sender: <xms:Fnj9ZcXB2EOn9ReoydPqOB73Euo22EUc9nmPkwc9l4eILWeEjVQPHg>
    <xme:Fnj9ZQmb82CqmVmloayIj40p7dPUcAJOWfLUXvHM3QL_vBxmbqwPW95869LieCvMR
    htA8frNGqdReCBQyg>
X-ME-Received: <xmr:Fnj9ZQZxr9aGikgbmsLzOH6oWK0KVO-jNexCLrr32DxI_cPV924U9rp8Iy5gQ2kjyZB6FmhYjokrQ-XD7yaYf8dk2075-07K-X7pqG-aM4bhz3TTGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddttddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Fnj9ZbXvqbIA0pRBi97QQilHTwsc2Om89VR9FfKprL6gsy3CiZDx6g>
    <xmx:Fnj9ZWly1-ydIfzQ_bUsfKe-fdpqrQIgRGnBM2ofIbdJ2bdxmqUnoQ>
    <xmx:Fnj9ZQepOHCOVjpYHYUv7oyc-cT9XXNSdrMSYpxE-t15ljyuKnPjsQ>
    <xmx:Fnj9ZYHTDQfRxcfT1qSDDwM2jvOB8zZkw5Kp0GiCDWdUlfJiLtQV2w>
    <xmx:Fnj9ZbwDzdS0QSdjJiYsvvWwv5xu3-2F4EsnRT9QGLhB0BY0Qh3qBQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 22 Mar 2024 08:22:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26a0ec49 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 22 Mar 2024 12:22:39 +0000 (UTC)
Date: Fri, 22 Mar 2024 13:22:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] reftable/block: refactor binary search over restart
 points
Message-ID: <f56275f288d94837d49e49ec806a803c6ec911d0.1711109214.git.ps@pks.im>
References: <cover.1711109214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MUothEwD0JqKUsJp"
Content-Disposition: inline
In-Reply-To: <cover.1711109214.git.ps@pks.im>


--MUothEwD0JqKUsJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When seeking a record in our block reader we perform a binary search
over the block's restart points so that we don't have to do a linear
scan over the whole block. The logic to do so is quite intricate though,
which makes it hard to understand.

Improve documentation and rename some of the functions and variables so
that the code becomes easier to understand overall. This refactoring
should not result in any change in behaviour.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 97 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 27 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 422885bddb..6cd4c053df 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -273,34 +273,36 @@ void block_reader_start(struct block_reader *br, stru=
ct block_iter *it)
 	it->next_off =3D br->header_off + 4;
 }
=20
-struct restart_find_args {
+struct restart_needle_less_args {
 	int error;
-	struct strbuf key;
-	struct block_reader *r;
+	struct strbuf needle;
+	struct block_reader *reader;
 };
=20
-static int restart_key_less(size_t idx, void *args)
+static int restart_needle_less(size_t idx, void *_args)
 {
-	struct restart_find_args *a =3D args;
-	uint32_t off =3D block_reader_restart_offset(a->r, idx);
+	struct restart_needle_less_args *args =3D _args;
+	uint32_t off =3D block_reader_restart_offset(args->reader, idx);
 	struct string_view in =3D {
-		.buf =3D a->r->block.data + off,
-		.len =3D a->r->block_len - off,
+		.buf =3D args->reader->block.data + off,
+		.len =3D args->reader->block_len - off,
 	};
-
-	/* the restart key is verbatim in the block, so this could avoid the
-	   alloc for decoding the key */
-	struct strbuf rkey =3D STRBUF_INIT;
+	struct strbuf kth_restart_key =3D STRBUF_INIT;
 	uint8_t unused_extra;
-	int n =3D reftable_decode_key(&rkey, &unused_extra, in);
-	int result;
+	int result, n;
+
+	/*
+	 * TODO: The restart key is verbatim in the block, so we can in theory
+	 * avoid decoding the key and thus save some allocations.
+	 */
+	n =3D reftable_decode_key(&kth_restart_key, &unused_extra, in);
 	if (n < 0) {
-		a->error =3D 1;
+		args->error =3D 1;
 		return -1;
 	}
=20
-	result =3D strbuf_cmp(&a->key, &rkey);
-	strbuf_release(&rkey);
+	result =3D strbuf_cmp(&args->needle, &kth_restart_key);
+	strbuf_release(&kth_restart_key);
 	return result < 0;
 }
=20
@@ -376,9 +378,9 @@ void block_iter_close(struct block_iter *it)
 int block_reader_seek(struct block_reader *br, struct block_iter *it,
 		      struct strbuf *want)
 {
-	struct restart_find_args args =3D {
-		.key =3D *want,
-		.r =3D br,
+	struct restart_needle_less_args args =3D {
+		.needle =3D *want,
+		.reader =3D br,
 	};
 	struct block_iter next =3D BLOCK_ITER_INIT;
 	struct reftable_record rec;
@@ -390,7 +392,35 @@ int block_reader_seek(struct block_reader *br, struct =
block_iter *it,
 		goto done;
 	}
=20
-	i =3D binsearch(br->restart_count, &restart_key_less, &args);
+	/*
+	 * Perform a binary search over the block's restart points, which
+	 * avoids doing a linear scan over the whole block. Like this, we
+	 * identify the section of the block that should contain our key.
+	 *
+	 * Note that we explicitly search for the first restart point _greater_
+	 * than the sought-after record, not _greater or equal_ to it. In case
+	 * the sought-after record is located directly at the restart point we
+	 * would otherwise start doing the linear search at the preceding
+	 * restart point. While that works alright, we would end up scanning
+	 * too many record.
+	 */
+	i =3D binsearch(br->restart_count, &restart_needle_less, &args);
+
+	/*
+	 * Now there are multiple cases:
+	 *
+	 *   - `i =3D=3D 0`: The wanted record must be contained before the first
+	 *     restart point. We will thus start searching for the record in
+	 *     that section after accounting for the header offset.
+	 *
+	 *   - `i =3D=3D restart_count`: The wanted record was not found at any of
+	 *     the restart points. As there is no restart point at the end of
+	 *     the section the record may thus be contained in the last block.
+	 *
+	 *   - `i > 0`: The wanted record must be contained in the section
+	 *     before the found restart point. We thus do a linear search
+	 *     starting from the preceding restart point.
+	 */
 	if (i > 0)
 		it->next_off =3D block_reader_restart_offset(br, i - 1);
 	else
@@ -399,21 +429,34 @@ int block_reader_seek(struct block_reader *br, struct=
 block_iter *it,
=20
 	reftable_record_init(&rec, block_reader_type(br));
=20
-	/* We're looking for the last entry less/equal than the wanted key, so
-	   we have to go one entry too far and then back up.
-	*/
+	/*
+	 * We're looking for the last entry less than the wanted key so that
+	 * the next call to `block_reader_next()` would yield the wanted
+	 * record. We thus don't want to position our reader at the sought
+	 * after record, but one before. To do so, we have to go one entry too
+	 * far and then back up.
+	 */
 	while (1) {
 		block_iter_copy_from(&next, it);
 		err =3D block_iter_next(&next, &rec);
 		if (err < 0)
 			goto done;
-
-		reftable_record_key(&rec, &it->last_key);
-		if (err > 0 || strbuf_cmp(&it->last_key, want) >=3D 0) {
+		if (err > 0) {
 			err =3D 0;
 			goto done;
 		}
=20
+		/*
+		 * Check whether the current key is greater or equal to the
+		 * sought-after key. In case it is greater we know that the
+		 * record does not exist in the block and can thus abort early.
+		 * In case it is equal to the sought-after key we have found
+		 * the desired record.
+		 */
+		reftable_record_key(&rec, &it->last_key);
+		if (strbuf_cmp(&it->last_key, want) >=3D 0)
+			goto done;
+
 		block_iter_copy_from(it, &next);
 	}
=20
--=20
2.44.0


--MUothEwD0JqKUsJp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX9eBIACgkQVbJhu7ck
PpTm7A//aICYGIN2y7b1ylBydXdGSBvK8DNcgFTE6e+0wgPFUkP4+VftoBDmEjYU
VSYLJ6z4Og1VRTnCTEWnPVmYazNa2sXlE+Z2LLq+VVsxPgRI9XptUssIsjW7FvNu
5TA78KZFQx3iSUyvN8DbSJpImFeN57HbCJMsNKuv6t2jUYLACB5n7+pf83A/c3+D
xHYM7Oheeu3STZMM+3Y9owdgvySNT5gUb5aCOGDw0e1Qo5qgDFRK41mYxM2/EVmQ
KjoxVA/1T/H/2WoK4OYUt6TV9lDZKWzQEP5uCe8Gcrvf/vidJX+JYgVO4rYvnCgM
pHLu0A2ngwFLqbYSOHOANLS8+lQHicSbOZy+SGuCS+pPEVEq+JXzE7nSiouwsZAI
EAfP7oogn1ltVM0lCioewGvGtyGaFcfRe3TL2mCapRirRCLu89g6M6xhIsuM6svZ
iXczdBO+e8q+JsSLaajS5tDkuWdnknPdd1rTHQqpYMol6HhC8JdrL+qUPVtQ+78e
DMespPoe7Xl2pC3RdZ6rFjmy07erG+oGjpljUVGfokO6Wjbeh23UjzlG1UBmOAl8
e66usmivnwVzISwjJ0I8G2GXxtapInCe0+fNa75Lrv/PLGNN4iOY3rXbMOUHltBR
B+WZxCdwlk6+vb6AAKeux8SqvsZ4zAw2+4m0iRNQ0KRP7Hn5ye0=
=p7cV
-----END PGP SIGNATURE-----

--MUothEwD0JqKUsJp--
