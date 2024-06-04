Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ACC146582
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504678; cv=none; b=eMtLz42/nthsfn9bxdDL8r6Li6bMFVW4bDy16nKDCF4KY192MKG75bB9rxYkHJq8jeCXr0Y/hjc79YVaspv8tr5inX7FzrO7wRs/8fyXfMWnB0akQyhKYnffvg+akkGdib4jRJIJ3KoFqsgVr4LqblAP+SNgTjLZ6dZQKNAfYpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504678; c=relaxed/simple;
	bh=YOYMC+MJNj3jBepQ4NAEN5Q6WTy3P2ExIOVp4uTf09Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHFH53HLJp6S4AwDWidaGaIoIfnh3cx6dyQfTSGqfUtCGqLzjl0BpbErp+9tJ677lmA69UQu43Vw1GtEt1WTXAWw8qr0j4YMTdhKOIFBqAiO3AiDfc01mXPtoZ1OjNppfyRwFJAffMihM+qb4Qy3ji5NByIDYcpgM5kzzb1BqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wey8Sxpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBHaWZLH; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wey8Sxpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBHaWZLH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EA41311400DB;
	Tue,  4 Jun 2024 08:37:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504675; x=1717591075; bh=3+xXICtCCi
	+WvyNGFJHkNTvy4ggIwCLsV1vQwvWl6wo=; b=Wey8SxpehJUqpA0iJUdPfFxE/M
	qVl0NNPZD6i6P+eXmFx6MO5DKLyeKe4eZ0LC2mGcvtgFEBZte0id/zVEdMWoLULO
	V4X0btzH7WOvmM8Is92j6W5UmNBwrLU+ZByhCy1fdxc6DzhwzsCdZLL1ut18iUBY
	eUnOKPVxP0Jnxb6wXB9cicWFqIthg4+PK38VKepA9Pd/lSEiAAZW43CvqqnPBfIM
	rttgcaIJGUbcnKZqrJLDMKWJHYrwi0WUXRyl+ECfgEV1TNjgWhCfY9PJt3p6nwFj
	bPVEU7Ys0rv0xNcpmgWKUFAsHc2t85t6QkfXf/LU/AL7R6atbmf9Gara7uBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504675; x=1717591075; bh=3+xXICtCCi+WvyNGFJHkNTvy4ggI
	wCLsV1vQwvWl6wo=; b=DBHaWZLH6FrUGSpiYGDVUEVjouPNVK2EVSmXTiAcXp9m
	FMilheMmR7rHMmD3QHtFqGHRP5phmcZ0U/UrZmaZ1nsRzf5q2xUFipxMdqQWvguT
	0PDVrrajiXLFGB0Ny3fufL5/sFC17AzWY/iNW2y9moTcvlwqudGzlXfhxo7sTloL
	Mm+WExTrqeZrjC5B5hEFbQbPJKWxGZxlR5GMzTqCgeW3hpjPNVPYLJmunT69ihLX
	vLPIgFJz+hWXV6sPWB080UwSMZD8/IKw10SikRzZAbwwYXZdrf3cwCzez5WlAVLR
	Xkm0jY1tnitIApmsKAxjKd+egH1gbAxLKFwv5KUMlw==
X-ME-Sender: <xms:owpfZl8MOUavZw6iQvoqTvSo93WDys0-f1_YESl86yRCh-AWYQ74yA>
    <xme:owpfZpu68Tgw8MPdK8aGrW9HYIbCXD9cvFlUJqPGoG50oCWtl5y0v97HphhPSGjJb
    rUTOEaXvDct69Usyg>
X-ME-Received: <xmr:owpfZjAO2NQAdv0pMJRvgeL7fwXzSbW4q-DapKoOUE76Y3I-vt5XKa2KvXeiD0e9wO5If1DdvU0jpK-56d3-zz3IEkYjT_UxIf_Gzrl6YidHkk05>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:owpfZpeW4LWzLIEzyh4AYWl2OEVqYockV3aAsUiORZGAmgrGtO6dkw>
    <xmx:owpfZqOMYzkqVmUTtZ8qHF4Iy0bx0itpK9P2z6cQCC3yGIpSX01knA>
    <xmx:owpfZrnv52CGMSqCghSr5hNsRElUl9gFgnUvFMw0muRFs85qX9g0Xg>
    <xmx:owpfZkvZSoM0ovdjTIB9wLYD9jyrEK1nGozlijjny8VX1Aiep1rGew>
    <xmx:owpfZnomZLtqp8xENts84XnEaRtMitE-mDUXnykqe1sgjrgAJtZOgA11>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f5ea24ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:27 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 13/27] object-file: make `buf` parameter of `index_mem()`
 a constant
Message-ID: <62f0e47f94dad4f9a7318a0349bb83bcd29cba61.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mm9QSXQERrrt10HN"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--Mm9QSXQERrrt10HN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `buf` parameter of `index_mem()` is a non-constant string. This will
break once we enable `-Wwrite-strings` because we also pass constants
=66rom at least one callsite.

Adapt the parameter to be a constant. As we cannot free the buffer
without casting now, this also requires us to move the lifetime of the
nested buffer around.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/object-file.c b/object-file.c
index 3afe9fce06..b5b5a59dc6 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2485,12 +2485,13 @@ static int hash_format_check_report(struct fsck_opt=
ions *opts UNUSED,
 }
=20
 static int index_mem(struct index_state *istate,
-		     struct object_id *oid, void *buf, size_t size,
+		     struct object_id *oid,
+		     const void *buf, size_t size,
 		     enum object_type type,
 		     const char *path, unsigned flags)
 {
+	struct strbuf nbuf =3D STRBUF_INIT;
 	int ret =3D 0;
-	int re_allocated =3D 0;
 	int write_object =3D flags & HASH_WRITE_OBJECT;
=20
 	if (!type)
@@ -2500,11 +2501,10 @@ static int index_mem(struct index_state *istate,
 	 * Convert blobs to git internal format
 	 */
 	if ((type =3D=3D OBJ_BLOB) && path) {
-		struct strbuf nbuf =3D STRBUF_INIT;
 		if (convert_to_git(istate, path, buf, size, &nbuf,
 				   get_conv_flags(flags))) {
-			buf =3D strbuf_detach(&nbuf, &size);
-			re_allocated =3D 1;
+			buf =3D nbuf.buf;
+			size =3D nbuf.len;
 		}
 	}
 	if (flags & HASH_FORMAT_CHECK) {
@@ -2521,8 +2521,8 @@ static int index_mem(struct index_state *istate,
 		ret =3D write_object_file(buf, size, type, oid);
 	else
 		hash_object_file(the_hash_algo, buf, size, type, oid);
-	if (re_allocated)
-		free(buf);
+
+	strbuf_release(&nbuf);
 	return ret;
 }
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--Mm9QSXQERrrt10HN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCp8ACgkQVbJhu7ck
PpTRgA//T34WwHMhRqMFWYmu42TASStM00t96nAF2BP1C1Xmj/WOlq6JQJKjgC6X
KpP0YM0EsKpVzuiPgXxUT1H3BtMN/hkFMTHOTjiZ5T9hVoowJ6CZzmNg7oOW+ijc
QXvd36kICbKnzEDnmhM5NiStUdgR7aEdkLqIByugvMXxjQekyv5ZHAdTx7GR6kV0
+Qsii2jF3DEQ41BbSYEUdYYzDGxScpOO0EKDK+ESxuZRwgqIhcPTxKLO4IvhVXhG
g6MjccZQWlBFHgOQFRexlbsDF8N/6YhrUo0Ozhf+LGdaRbqrNTcRLAn3TYUn0pfj
ZGENLymmgb/cRhUJ5dVXJPOojCeLQUNcztptGsLwt3AGfZGlC2LdZXnipKGFWvCp
kv5zA91QsMf5v3MiEnRbZvDn5bqkptVgBtCEXq7sZKWf7p/jvIvzfs9yHPGc0xa+
wHbYKdmmTpP5/LD4OMA+8hvLe8MJiYEa84YAPleJUO2AUgLu7iNryOzkuv8rc3Nl
GS4LS6hUkqjYwVUFgrixM77hw+Sv/Cy8IgrHvXLdEvIiTW4PKrgEGy+duKBvtE8E
yPRWA2AaNZsTFuwmSo6BI9fovFfas1d278NuT9CXlLXVI8Q4f8SNRAp8q+Mgk49N
cjdBQapBVFWBkJP8k773Wu3uRHtS/emWqLcgmK6hXPUpCoxe/2U=
=mK+Q
-----END PGP SIGNATURE-----

--Mm9QSXQERrrt10HN--
