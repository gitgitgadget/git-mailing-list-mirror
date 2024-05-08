Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874F681729
	for <git@vger.kernel.org>; Wed,  8 May 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166241; cv=none; b=TuHBKTthioU2mUdcpaVWYOTfNBPpYXLpj2XSpMeOreJijQpfv4QV7Dg8CP+uO7bYf+CJCD85yIDY4Sl8YC63hEv6tc5yQJR/z9/Eo57rKcPWy0PhqE30Zkr+QS0r5EnY1FIBOJis6fsgWQsuFejGmrzKa/vadD6VMMrGW3M/rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166241; c=relaxed/simple;
	bh=WxsyxLJT4GjlPUF7cWZDFSWZovva1g1AiRXvQf7PUKU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpGGCXUGICeAGT0/uE2eVsMIW5+d7DfkNmtvao/Gs17SeV1H7370HQ5TsTOVfIJJZ1ZB2ppwGGJjl7OHBWD+sg/J6zHRQpWLTLJfLiS7eUB6+RiYJd6Xn+dNdg3I+prn84dQ9yC1Fp3uD2YJQce3CP7a6XFb4A9B+e4fri2+LFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rxQWkLr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGifNl1o; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rxQWkLr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGifNl1o"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9C56F1140256
	for <git@vger.kernel.org>; Wed,  8 May 2024 07:03:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 08 May 2024 07:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715166239; x=1715252639; bh=ruFr1iLrS4
	icLvadiQnjCqpNgC2DZ/vN8VpjAapcKAE=; b=rxQWkLr1YWIr1kJfSSaJVBJLk9
	YSHv1D+ZD5OrylItfyozhASHbQs6atH9YjqvKsafDI84Zixea9yNEg3CHWEs/LT1
	4ojECLxoawB0Gbla4v3hKDi2g0RRlzYP49y44m/o53ZmRnimE5QHraVGvazMv2AK
	CyklkudYPDhpkyKz4xPXfar8Ef86L3Ir8ORcQ8gb6N0U6fUwlBMeFtyW3zb/cEJ/
	V0+HC543GDXyYIniEOFpDDOsebzJPZmrSG9VMQzQVRcxDAeupWoSV0AS2Gpd1pAb
	TdcT6Ol2u0jN0bINUfFfLz4Z3LQMah/jyGvTw12RWuzuA+yccHXB74+HdCaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715166239; x=1715252639; bh=ruFr1iLrS4icLvadiQnjCqpNgC2D
	Z/vN8VpjAapcKAE=; b=MGifNl1ouuA/JuwMfxajDkRDa6s442qkqJczIER8y48F
	ZucycGjRVWjpO7qRrtT0PzIshTg3/COUTAQR5ygTPYRGZ50NCQOaUIdV3x0hAvdp
	wjL3jR1g2n9pWMjhJ2wSLxVOrFM2jV3W9lzV8/cdNzOUO6SOoTsklUVrzeCRJU+z
	+HGM//1AzX4AMYlMOYWfblydFPQTfzXjXp3qnehh0jnumBBLSgmnE+2M1sOJGqAg
	J+Z3pEmm9X4M9ecPXXyywInFdp0UfWpdQpSswe6kYEbMw//jozLl3wWOjkrM/98Y
	k13mcVCkfyo47yw7+Na0GB0gssMGpQfMIgZTBcB1Wg==
X-ME-Sender: <xms:H1w7ZidhOR1HwhP28JdX_GfGjPnzP_KRKJxX9VBYu0Fw267w8CR8Xg>
    <xme:H1w7ZsODoajgTBo7s3ipIwqZEVaMY3wvV_oYDSDkuPIkpFPfkvo_1gCojvaEehk2c
    XY5-0C_rGcXgL9Zbg>
X-ME-Received: <xmr:H1w7ZjikSnL824HU9dKpWuU1TaijzEfUZug4or-f5SMnCTPNjNYeLG4Z13z0xbY_4ppk6cHG0GCY3yd4OrbiBcAjUQHNaI7lboOh3TMs71NX62mLUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:H1w7Zv-n1fGXXZB4FFNL1tmjBDoAREt6XnIDJ4qnWpjsK3UJCccrzQ>
    <xmx:H1w7ZutlPyq_UY02Cs5O4F9QHWdsEXUivroVHu6LEJnBwXjrtRVZdQ>
    <xmx:H1w7ZmEjGjJSKlN2OfIW-OsFYohFMc__ubXlCrTF0niJdEarqlaFMQ>
    <xmx:H1w7ZtPH8_5JyeOuZrkSni8YWNGzKonDC_l5hRK_E890sCdG55E74A>
    <xmx:H1w7ZjUUFKRdqZQ2_AnHsU3TYwa2K7uTc0jLxgrXhZKPq6yhm-T7qvRj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 8 May 2024 07:03:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 18ef1880 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 8 May 2024 11:03:49 +0000 (UTC)
Date: Wed, 8 May 2024 13:03:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/13] reftable/reader: inline `reader_seek_internal()`
Message-ID: <4d498ef3426877c703bababaa743dd5613ba5839.1715166175.git.ps@pks.im>
References: <cover.1715166175.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EGkKnCb+BOYTOQ4Q"
Content-Disposition: inline
In-Reply-To: <cover.1715166175.git.ps@pks.im>


--EGkKnCb+BOYTOQ4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have both `reader_seek()` and `reader_seek_internal()`, where the
former function only exists so that we can exit early in case the given
table has no records of the sought-after type.

Merge these two functions into one.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index b210753441..c3541e2c43 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -573,21 +573,25 @@ static int table_iter_seek_indexed(struct table_iter =
*ti,
 	return err;
 }
=20
-static int reader_seek_internal(struct reftable_reader *r,
-				struct reftable_iterator *it,
-				struct reftable_record *rec)
+static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
+		       struct reftable_record *rec)
 {
-	struct reftable_reader_offsets *offs =3D
-		reader_offsets_for(r, reftable_record_type(rec));
-	uint64_t idx =3D offs->index_offset;
+	uint8_t typ =3D reftable_record_type(rec);
+	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
 	struct table_iter ti =3D TABLE_ITER_INIT, *p;
 	int err;
=20
-	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec), !!idx);
+	if (!offs->is_present) {
+		iterator_set_empty(it);
+		return 0;
+	}
+
+	err =3D table_iter_seek_start(&ti, r, reftable_record_type(rec),
+				    !!offs->index_offset);
 	if (err < 0)
 		goto out;
=20
-	if (idx)
+	if (offs->index_offset)
 		err =3D table_iter_seek_indexed(&ti, rec);
 	else
 		err =3D table_iter_seek_linear(&ti, rec);
@@ -604,20 +608,6 @@ static int reader_seek_internal(struct reftable_reader=
 *r,
 	return err;
 }
=20
-static int reader_seek(struct reftable_reader *r, struct reftable_iterator=
 *it,
-		       struct reftable_record *rec)
-{
-	uint8_t typ =3D reftable_record_type(rec);
-
-	struct reftable_reader_offsets *offs =3D reader_offsets_for(r, typ);
-	if (!offs->is_present) {
-		iterator_set_empty(it);
-		return 0;
-	}
-
-	return reader_seek_internal(r, it, rec);
-}
-
 int reftable_reader_seek_ref(struct reftable_reader *r,
 			     struct reftable_iterator *it, const char *name)
 {
--=20
2.45.0


--EGkKnCb+BOYTOQ4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7XBsACgkQVbJhu7ck
PpQXGRAAjj9CZG6qboTh5pHCuPcfq8ZSJXa21jH25EEdep7YtslAbMnFGQNKxQqG
faiYn1N3UzKeB3EFyUsmEZx0m5oadk3qHoajNbKywiSzCOO0jPw176dziQkWTnQr
pidb6vtERyVcPgXdGIkLdrNTaLhcRLcpTT53GorvpxgrUfCsa1jwA47YhDPdvvnX
eE9/F6yUifLUXN/4bd6BGn6Y3Q1IH5mGkED+cEy3oyThURY/VErOIT01NIaeEDMh
t4JG71ZZfuZK1ZUzcu8NfE16iHP79CydgIBLwPTiY5TnTIET+Zt6iEJ/bDBjo8nW
EwFT140fpt9zi7klnJxd09Ws+d83szLp0B8b7K5K61itTKcGf3+tGKw/k9M1uFzF
g8rzZNvU+YNbCmUa/6bPKBXWJBv2oQZRcHBRou3lRZB7LXirgyUCZCgLliY7JRBN
7es9Ps3RwZJ5KFm4UVie/BZls3MejDmPjKXpfb0+6MmLa0XGDf/2kN/QnoZM66Jq
c/LxnXvnpMvBYNcogP4qeNjb0xeLE6vQfC4JPEFG4r9gtNBcuX7yi3kf0hcRYZyz
+MhYS03Ts0lzf+0snPiAUSLzHe7t50LGV5BEDLh1d0hOyqU6q61ORlypmk4q5+GD
tHjFduYXCxyQcYN1meSZxOEXayYsJRs9apwADWwKzf4RclK/g3Y=
=JVpX
-----END PGP SIGNATURE-----

--EGkKnCb+BOYTOQ4Q--
