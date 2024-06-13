Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2C4136E12
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259236; cv=none; b=KSXHBLeq95YCXRlOywBtdg2jPWLfYiaMygn9/iCf3tW+rrxrxLreYirvue57O6aQDGyMNfzMT4K9nBzq0P8+RRyos1EwduX+Q2SjvXnqTE9ST9h+m2cUz8qhCFyIAOKj3JWMD2enpLAi6fEiTinLlZCC0VKYG4pUk/2+prFkGlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259236; c=relaxed/simple;
	bh=iDrfPJ2urEkyuwMW7G9ZqfiJbHJ/dUPRyow09vdYsW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2j9G39crLvemigUAx6i5ShuFIwMkdSANNUve44Temg9dY63s5yhCRj3vPmwz13oXoEwoF5GkwbeDlhWPHVaJiJbUgImhP+r5HAxKU5YQIz5uhk1vqQff7VgxXgZtRWs0AHTGD+/GwKILsC6P3eLHZv2E0etVVEvzhd00LRaf8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ecmQ6CgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASM5+gDa; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ecmQ6CgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASM5+gDa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 594F91C000A6;
	Thu, 13 Jun 2024 02:13:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 02:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259233; x=1718345633; bh=ceWpwuObvi
	xh/cZteacMFI7JGzykEWLJVhuMR84OxxM=; b=ecmQ6CgEx8qGnsXWIHe8K/7NDC
	LJci3iPq28v/1c5wP0Q1GJxkbY7bN4S/X9u5DN1/htmzSG9VJOrImO1YJruFfjHg
	Uz1FDH2jPf8xiOv3oFdvJwawGPvQSBgg60C8OfRwiUfiuceTPrLwgQjPMNR1ExPd
	9AcT8bFT4nRMgczbb+SinN9zLn/QUW5Nl5XpzboFE4qtvIHEc7/kYp5BffEav3JZ
	9I/sh0Wdmbem1ZX1BPSghhMcZYNFbjzUvwI21U2wSAAA3vnw53tZIfm9q4qwknol
	CgEm1NQ//cKC9xY/KyzNVUeUjxcnSpFGSUvwiw9f0xCRj/LLn84D3hpUCkiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259233; x=1718345633; bh=ceWpwuObvixh/cZteacMFI7JGzyk
	EWLJVhuMR84OxxM=; b=ASM5+gDal0FOL6ncXiCeOvufRHLZC6EhB4dEWacapM4Z
	YEI7WAvDAY6lW46siE2ByaFwWvfYSblVUxZmvgViSIGW5Idq1h1xIqraYiTUtr6j
	/Y2PpDDBgDfd9YoveCNcXb/fZR/C4N7Z2dteS+/+KzFz54GyEEhIsZ+kH6fZ1ZWk
	LhVodH4P1IugyE13GL+ONZhtPhy5F4oyr7KZ8X2Ib6BwuUT0cndDzFUhAv31iOWx
	C6i2+I+FgnsYpJGo3HY22j03A+BPllkDV5WtGIMjcBQxPQ5oQMi6qnEPt+nI6CoC
	ZqpiD5fDrlwoWiUeI3EHbNpy7zOUnIIk+Yd8AXIYng==
X-ME-Sender: <xms:IY5qZs7xAPdRE2nqdHwwlPnMj2r-hDTV0zjCm2syXX1mNFzo2bjDmg>
    <xme:IY5qZt4khNopSYQvSaFgFFCmHCIKEFy_N0qnbZuetxERhWoW39ZwdGeSbEF2duUGo
    aY1SQUeUTofXrfytg>
X-ME-Received: <xmr:IY5qZrd-aztW-XdeLJf9nsiV2rkRp29E4Np_cH5TsyNLkNV8gWtekYh8Tyg5cd62F1j2XKwfLwLS_fe3aQx8dObSEYiExwATQikoul4FnKIXPdPWSqE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IY5qZhLKNKjRQp4nQ9p5UJEDxkLKRqBFR-w0Ea9VUc9tDJTPKEUUdQ>
    <xmx:IY5qZgL64Sz556rtWlpgpI2vtc1hHP4AfXSNicC5UFEzfOuHC8XtBg>
    <xmx:IY5qZizbk9nvz2NZ74vDRNhPywyQ-_C-DhOD_Icsud1vjBx0A2Kl1g>
    <xmx:IY5qZkJrCyIS6rx1xQ5gSKK6Mzn9ggO3pR7bMEHrqnFqCWz7uKgEAg>
    <xmx:IY5qZk36M8iD0wNh9QtacE4T_hJb7Ltq2ZXjsQUpTGa_XouUsqATUB8S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:13:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2e3d0edd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:13:39 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:13:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 06/20] hash: make `is_null_oid()` independent of
 `the_repository`
Message-ID: <9058837c938a45504ed0cb6dfce62dfe5a595217.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hd3xtojlSZJiza6w"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--Hd3xtojlSZJiza6w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The function `is_null_oid()` uses `oideq(oid, null_oid())` to check
whether a given object ID is the all-zero object ID. `null_oid()`
implicitly relies on `the_repository` though to return the correct null
object ID.

Get rid of this dependency by always comparing the complete hash array
for being all-zeroes. This is possible due to the refactoring of object
IDs so that their hash arrays are always fully initialized.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash-ll.h | 6 ++++++
 hash.h    | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hash-ll.h b/hash-ll.h
index b04fe12aef..faf6c292d2 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -341,6 +341,12 @@ static inline unsigned int oidhash(const struct object=
_id *oid)
 	return hash;
 }
=20
+static inline int is_null_oid(const struct object_id *oid)
+{
+	static const unsigned char null_hash[GIT_MAX_RAWSZ];
+	return !memcmp(oid->hash, null_hash, GIT_MAX_RAWSZ);
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
=20
diff --git a/hash.h b/hash.h
index ddc2e5ca47..84f2296cfb 100644
--- a/hash.h
+++ b/hash.h
@@ -6,11 +6,6 @@
=20
 #define the_hash_algo the_repository->hash_algo
=20
-static inline int is_null_oid(const struct object_id *oid)
-{
-	return oideq(oid, null_oid());
-}
-
 static inline int is_empty_blob_oid(const struct object_id *oid)
 {
 	return oideq(oid, the_hash_algo->empty_blob);
--=20
2.45.2.457.g8d94cfb545.dirty


--Hd3xtojlSZJiza6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjh0ACgkQVbJhu7ck
PpRsrQ/+MnY4h+HhBPbUaK4df+vw9iFC8QloUKdMjfzBQAhfnFvrWW0Oc36R+/uh
RbdR9fWO8dhXS2T7DUhN1KVcvoIqKiywWUFhz6cHMTmgLESBT/tolaeecyAY7XjJ
2K9tohFiJPELiE4tyK+fxDZM7bRSLRaZz0xhO2rsqRC10AmWTrjfGcDejIHVHVWq
klsHpYjRprMynj+gzak/JTFJhWrytKMlOUF1pmusXnroaBoB4S/fDuuH/my14duL
WRgr92tJY+RlWJ/+MP9IeesjTPUXq+Sq5qb/f12N/25wDIRONLrQgedE+AD6BYQc
yNYaoxbNS1mUavfPVc4/5mRuSBL48jgBQXx/fhgXDah+/wJTCUd0O9IC26am7vby
fZDat/Tce/9GW7lDZ/3jl13QwoBQXFpk3suyayW/U2Tn0xDfno8QM/lD6sxi6SfP
X0j7jWm0rV9KVY3g785d0D6/VI41bhfKzgXgme1XYPFS+l/r7ZPEmIoOpVw+Z/Rn
MmNggA/Za2AxixM/AeMWtw4rAGdkBWfbUBknnKZcR/xS2jDF1TXra/Yz/oOZ9Etj
yKkHEmrTR1x9nsH5QQExcwm9DM7uySCQ+G6GSWGSMXzIDaHwoJpAxOEfcpzXi4tk
ZWiquj6PGrTdPlZwR0RjNCSiYSxp5qoFVcKX1aB0+VMCyMxnp2Y=
=ggCr
-----END PGP SIGNATURE-----

--Hd3xtojlSZJiza6w--
