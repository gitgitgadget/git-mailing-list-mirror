Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005BE142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986690; cv=none; b=OzKtTyf7cYjHHhkkutdc7Ut7QhLuQcebrBoTo81n0UAUcWngm6K2Mb67b4XgoWjfH5HFg8RGFtuAU/WbbkHJUwBnc7TbIRpRpCcFpVfcYQwNgkG4kcxC6L5mSTlOv0cF9SyXH4oKO4Sum5JmOA09LNpcXnF+CWZKv0aJUt/cIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986690; c=relaxed/simple;
	bh=zD3uVtRVKftNRrYUSWHqnUgAUQSJ3+EUrtaVi980Kww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE6XIabS8nt3qa1ACi5YXtiurOKL+aCbaITY/KUxYpQh1b9k6BmebrFGgdSIPx//F1MzPUAh0+iy63sMmLDbxFdKZXEwFXpqu3WYC6Bv1r74oWsZKsOWeAqy6CqNKaT1/jliwszJRDGITZuWDcR1HX1pqyl3srGRybyZhaEPyrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Astsbusf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KY4M0n6r; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Astsbusf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KY4M0n6r"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 6F4B71C0012A;
	Wed, 29 May 2024 08:44:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986688; x=1717073088; bh=PNPQngMdeF
	0oy5oEzjKtPFtQNPtRZhC5gId+ecsdsb4=; b=AstsbusfafCG1R7JjWhrv2I+Uh
	3G8qZqSYF5ikh/HYi6midY1WDc8UaVHh+L6hrsUiOepKs0mBOSJ7IArNwi+cmVTz
	xeN2Y1zumHmKLAy3IF3gfz7Zvewab09wh3PDnbD80RUGNdtBvoqwXmhfZInUA9Cl
	TpDz5Ns75S2m0C+GtjNbiY7L2gvnxYaqgnSqGdtazhPqLwtJ9jYm6b6XXvCfvvSu
	q4x+H2fRN7i4OfMAkZb8ZIK6jJk+1CU1hQ5YkyQs5OS92Og4ZQ3/ox5qCm9Ym04I
	b8Qxa/4+2v1k9WEwYvfAdrknzMfKa4Dt29pw/TJ1Xt/B2VwIXF3zC9DEXo7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986688; x=1717073088; bh=PNPQngMdeF0oy5oEzjKtPFtQNPtR
	ZhC5gId+ecsdsb4=; b=KY4M0n6r2gi7j6aYa2e97fw/jKg5YFwD/FNjD+gaDHdB
	YFBMjRBkwOx5j5bBUNWYVrTCq6mECiuwC1Cok4A9V0lrwUV29SqLF6rAe/VY8BaM
	pBHpAks+upi0ezRwJ4Ry6/qd8fEZpNHFCCeLWMZHMB2Y3VP2fJPAiiuXpJAaKhA8
	EIMm1zW0hUrsAQqbpkoc4oHOqgIX3kwO9xG8A4zr/A/puQ73kuzvNaK4L75PXFpl
	yHR82B3xBZYHzpXgjwsOGKzmKzmCj4DZHHY56Vr/y04P3X/VseEEsl/Ms9GGQuG8
	yddvX90n6M7pTWdG0aJFvdv4FD3iKXw3dxIcVar+3w==
X-ME-Sender: <xms:PyNXZtxaJWyYxI2g9IXZYIPARGoTJSs1XSpMVoQo8OmoGqD5kTOKfw>
    <xme:PyNXZtRzT2442EacdPXZBH6PuVxguscubcJEG3fMMWKKfP0CnKAzbi-8OA0XT0YT8
    WpCzn9yAzMcvBWNoQ>
X-ME-Received: <xmr:PyNXZnUhtfAk2Z4m82xEnmnlUK7-N7J6RK_KbHS1HohA7cO5XE4Qgwb8LRHiCR2lMFCq-TPEabQ45mq6ThKF_7Kv6l2QKGheGrCWbZtqL8jJJky->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PyNXZvjI7csWKdMPmt0BRJcrY7lc_UAPQVnGZzocr1blLgUrgGzbkQ>
    <xmx:PyNXZvAlsQezdHipFl2YPIGBmUAmiKEKyLYafR-CYXj6yn5i4NfHJw>
    <xmx:PyNXZoJjqQixFkfBypnjaELdguCYJhcFPkkZ5a34rNUIy9RY4ddODg>
    <xmx:PyNXZuC7-8ln_7TRAiksJisKejqQ-S4PpqChdbgI-YIBknSDdEgTzA>
    <xmx:QCNXZiMB4UzowLeyXbtg0l9K3w_tOJTuRT_N-BAUisUjrLabkMYYNdfT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3dc95511 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:32 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 09/19] object-file: make `buf` parameter of `index_mem()` a
 constant
Message-ID: <6cbb8444a6dabb883ac3b0e450c0bfbd17b58bea.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="y9ZqgL+D/tpfV0SJ"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--y9ZqgL+D/tpfV0SJ
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
index c9e374e57e..46ea00ac46 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2483,12 +2483,13 @@ static int hash_format_check_report(struct fsck_opt=
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
@@ -2498,11 +2499,10 @@ static int index_mem(struct index_state *istate,
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
@@ -2519,8 +2519,8 @@ static int index_mem(struct index_state *istate,
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
2.45.1.313.g3a57aa566a.dirty


--y9ZqgL+D/tpfV0SJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIzsACgkQVbJhu7ck
PpTOIQ/8C5KZVvSgudAAQhUoEJzWcqZGchtJY5iDtFSASemIXCk9xwTmfPvyOtiR
hI1FrmKxJGPgpb21b6T4ltfLkVDOgSeQEGcgkPAqrvhKXF7ItG0hNDblVaxUf7TD
I0V4eqVA+Jdpn+2zsxusfgyVHQ1Z6nGA9vNyZwVj4t2w7cUnb+OdJJGrHQJc8UUV
cSeCPyeHiHR1X0vl8FD9jNb5SkN/swGuZXwd3XQ/1I4HzqhBFtWZ4WMLPsDhl1Ac
a5wVwRusr7gvnSDR64GoAGDGcI+iz/+9WtZsZ9LH6ljA1u/WicrdI0qvIWFByVeQ
+ThiQ+DzphUQMpl1+Fz+fFGPu3r/R0utJnKjgNKjSGo5pOjQLQlDsSDZlx3rmoUS
rdiUA7kM7q+0mZg3H/8IijIA2SbXCMxZVHxYytrrWHUERj6z1H63j34DimCBiwDk
CY2h/Jtk9w16vHXP2yZGVqTVoIT0mCmCEO5OiERFzYsgVevrjoc4JQ/VIdq/K3Nb
bpS3+u/eO+8fSUA2TVax+5pwcrrpirj74rjhFuLOb70ZXL0K+/HoKZuOY4b4nrz/
BiRylcYDehnX5JlChrIY4hfc/21HAJFlQSM8nfhH2/FGwaVxUTGsnf8Wldjzy6r0
GRK7Pt6t7M6hyBtEJtzMT91OLXBb+59pruSl2yXQ9E7K0qVYTxg=
=pcVt
-----END PGP SIGNATURE-----

--y9ZqgL+D/tpfV0SJ--
