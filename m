Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDAE154422
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742320; cv=none; b=uAaDKsElJqaC7bx4roiAIWecRYfctsPSAYqg32VvsSezjF5+X9olf6T70Aqg09ppHm6ChZkrK6zY1iP4Fnc0kXVcm0rqw+lvIkGejKrRGDBvVcjiYzsTL/YHcoCajUNG8UjTbQGoBLm+RHq3MMBN2+9WifPiTlmZanLNBygcLys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742320; c=relaxed/simple;
	bh=MrsyKSJLBoFPqRm+CNAiya0WgDGuqsCAcN7B8rV2mws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpJihO9hCOS5yWQdDSS2zm/pRmJO4oqG6rJrwtSU0GAv6rirVxghhkT+We9CevoQQ/UnXYS3yKKZ5PE1duxQa08xfNPQv69C0NUx1QUofqPPTCXPLclWngaCBUBXNo8oLTOb9jeBJpKXNdrZxXoQDnR91cDB6uYnGRFJ8AZrelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=og9+HP2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ilYo8eBm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="og9+HP2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ilYo8eBm"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 49AE51140203;
	Fri,  7 Jun 2024 02:38:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 07 Jun 2024 02:38:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742318; x=1717828718; bh=EevTjOx2eL
	8MRT7qIgpqVRLDiltLL5rmORZfa1VSk94=; b=og9+HP2UI+KamdcPLYw45/FMsw
	Betg0BNqCiPazrQGhGLdDfI2ik3P8BGAGqMqTNBd49I4B08GOBgONzFjYK4VOuJc
	x65NyKg3wZxNmnNQj1wVbYMDWrzD9Tn2rwpkpqluDBApqsmaO5Eh8MdpHk/F+keK
	4nrBcXCwY1VYnlVt5J+9pHEpJ8PH2dHJTW0FuF2EDiki3MYte/1DronNlpe6OBLp
	5Ic3rv8Jpnn/2RDjriNmv0OM03SL2iEzBcMOmG7q84a3ZwSlgmrYV7UwAWzW1EP0
	uhMcjYz7MjWONeFAz3a1J4fd1PweFf5XXZjWkvklFv5f8v1+Ao5hCH0ofUJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742318; x=1717828718; bh=EevTjOx2eL8MRT7qIgpqVRLDiltL
	L5rmORZfa1VSk94=; b=ilYo8eBmTn8qOuIn3qWU+HZuWkWfN4g2CmWiRApiw7wV
	+Ud/f3nL9K0dV7Y90+dBVEbKnPsfQ4mDMABMxE+gg4XUwDmJSnjh6YO0P7aiGRir
	dLG3XZf5A1aTkMBgvmnAKC78PSPHrQimuvOuedXnpQiXlkQiJwXecWG8yIUeyqKL
	7mcNFp5pTGhQtix1LiNFEY1/iTYXAlNuLadJGqgALIHMOv4y2ZesPtyA8FE2tT7+
	GpFXLsalk+aPxaDUOJb+TmZxU2WDzJLKp4AIeSbRBud0uW77EKa9kdF9cwsqs30e
	EAJbSKiEHPLKflvzD/Ck+NKjt8FYkCKJmfKaSxHtwA==
X-ME-Sender: <xms:7qpiZrH2VLOyr8Nrgj9dDjvIp78CX2NHE-sYtyXAwHmLrgmKTwEPCA>
    <xme:7qpiZoUr8uHtvTLd2_WWVc35UjOaiEULiUVQuExeS8Ac-9ti_3TzCm8ESyMOPsV06
    q3jjj35kK4TVCEBiw>
X-ME-Received: <xmr:7qpiZtJdMjOELBAmE0H5cUYnilUWjXYubI_r42c1LjolSPi8nZglTKQtppZfMGreFFVchzlnq04zXdewy-DXzHjl0nVE5Jf2lvFvkd--M1Xbauiy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:7qpiZpEKOOvHdwUwPXek9Mv_dbWpvFERuYDUfJXeH5wrAoR_9ieAag>
    <xmx:7qpiZhWKSjgGH6uQvNcZkt3uO7cjsebnhMyfGgm0-x9R2VWBKxdk5A>
    <xmx:7qpiZkNFDvLDmjumOsuO6udcHeLV3MlikVLmdIik-F2Nb94h-2aEOQ>
    <xmx:7qpiZg1Br0gmTskQ86FymS65Gj5rJnk2KA4K78y5Zc7KgmyHOgD4uA>
    <xmx:7qpiZnwE0Qa7M7w0yLdD2q6UAyFyTb2LMVmCQPeCRzD3qZwMqeZJXgtN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 99b2b70b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:36 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 13/27] object-file: make `buf` parameter of `index_mem()`
 a constant
Message-ID: <4770470a84ef8e76636547347b95cfb50251406f.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ObaqFemlKunm+N2T"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--ObaqFemlKunm+N2T
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
index 08c00dcc02..0b58751f94 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2484,12 +2484,13 @@ static int hash_format_check_report(struct fsck_opt=
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
@@ -2499,11 +2500,10 @@ static int index_mem(struct index_state *istate,
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
@@ -2520,8 +2520,8 @@ static int index_mem(struct index_state *istate,
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
2.45.2.436.gcd77e87115.dirty


--ObaqFemlKunm+N2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiquoACgkQVbJhu7ck
PpQbsA//WDDOU1eM2fF/eqyL6eObucTbB8kZVCT8mdB1W1BzPOYFCcqzGcYrcIXa
dHdhNgn8YCWsHcZ+EUxA8VYdVz9f10S5MRYPJAqg3yYmsc7Ssan93FWFALm3qECQ
2a41xsaIOH6zJKv1nTU+ftzPCb/p+npnqTpGwDGJVkNXrOYrHACWJNjYKYdPa3FG
QnWLxzc50aRVQVh5TmKCOdOlgwirrXLoNrZHrgjHfqmS5Db3hqntoTWNmhRg/NC5
SHOq/z/+70mhrRwtJwyHjCRVHsqpQ/wEe5kG3WNFwgGDzGR2rVR1W5AlGjE3tBLZ
tSwZybCB79dO2pEhVnL2R3oPCr+gSxFmPSftlOKyHUNRWkHYboHaRqqNlJLUalOc
NkxU8wQ6iKnLJkNECWsXHQdxLgqXo2kwbD5q7v6xqgbygvPey42Sftv8AeWzsFhK
iQioo6bG+ScnmHFunjkWNOEpO6lAQOFDS+GqG4AGQ/xNtzlUS4KROHLSO1SEG+98
5GHEe+f3HxC6MqNT/NmkIMA24sB/ixdYkMdeFHUvfH8rAtyV7VwChVEZ6AWwsB0L
Gfmk7o7O1YkaY8CnTUevADHbi9Z3Wv2/EQ7tLbfTDc8l10Hp8uZgsRA2D6IiQIwV
UTGhuWdzzU4wDEMwv8NuMznVJlTCE+8r/TfUVbgN/LRGDQ9hIrE=
=JOP1
-----END PGP SIGNATURE-----

--ObaqFemlKunm+N2T--
