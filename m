Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E384D0E
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408116; cv=none; b=u6LKaUMVBbs/a6fbSLEZdkVVNYaCAAdBeJG7a/ht8TksR9tt0UnrvUlTSpW1xYwSXA0DDN1DFU68gS87ie2OcHyMSFSxEgPgFRkOy6gkUxrufozxQnAvLGdW4SGZm80YTDLxspEc2ohBadNWN7bRlSj7lBe21q2xu8fRpJoJf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408116; c=relaxed/simple;
	bh=gryLC0SN/WvZRJYeE2QFJzllC14CxhUbnJRjXx9fRWg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5DKVo3oCS9x1qZPHUhJ26H3Mtg4HBoWobdBdtTqYMlbTv4O0yS7X7VPlnMygdDpI9LcK/e68XHo4LovJ0jBq5l5q1f0SA7Wm4k0DMmV+7KG5toCzTJWpSqCm92OuwNxgeuCu0ZagWw813e9QzOuDMQ5PJIKfw1ZDTU6V+KDeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ETmX0NxU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHzBTvNk; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ETmX0NxU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHzBTvNk"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id B0BCB1C000D7
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408113; x=1717494513; bh=jV+K8WKYmF
	+i4lCoWKciaw9DqLfBtlyugEtd3duSUH4=; b=ETmX0NxUxcy6FxJyilShqw0m4U
	18bXde253JyiTI2WVdpxviODUOCvB0isuJgPvuC72MLu85HmE3vv7QvEeW7tIv9F
	XYXt4YbJAHOgy0nz7yd7uxmcUiG/0erOYiECz5nNQHZsYLnl/WC8j6seCaCbHTvq
	yGTgMb4oLrrsqqLo6Srnvj/6hTwueiyu9jscqpgtSC5/DPGyWx+e+lnxIhRaB//r
	BEUhvZYPbl7dAh+v2NKowMlk3c7eiyc8RTSw476S89/6PlmGy6307WlHK3z//KnE
	Je1ICUh6RC3WmQPB+VCuPoSt/pOFs4NZMqwE5FmtOpBgCIASjObyflMGxXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408113; x=1717494513; bh=jV+K8WKYmF+i4lCoWKciaw9DqLfB
	tlyugEtd3duSUH4=; b=AHzBTvNka2qv9RyfhZq7XrzlmrV2k4tviYwi13W1tgmB
	+4Ok39MFSO110jRBLfQN4qmzNFMXH3mnyfihnRpvRYYtdNcRDavLYTLyZrjgYBk1
	GYUUnOUj9LF1nf9XVfOgBdn+htuHgpzxrX5IR/FLfok+yOgH7IKDl/lDKcxRVamM
	zuYrvHrIir5tl8CztXKYzZFigvioDIWsdAwFiI92Avz+r9EgmLJdPUpkR9tHcFcX
	MCjmtiuP4CGBmPuH304JGbTjOvWbBjFY0BnFqfyyvCkVIJHTdBzIJYbF4rh1Yi7k
	hAgSJDEzNlaIzYfKywYQORQjY02+O/taI12kRpjGKw==
X-ME-Sender: <xms:cZFdZs2904FWv0O4FEBnX3jmmsND3kZOBw1IPhCGSzCuz2oqgWTnIw>
    <xme:cZFdZnEaoIp6BTsU4S8Ke13lZ1IAV0qUe-nk3tJyrL1RD6eQ_PQWmOyB30ffZYYJH
    CQBeHuGNYOanBVvWg>
X-ME-Received: <xmr:cZFdZk4geTP2tRjr3pWMX9j8p9RPIpxjFCyEhGtcRgpZaLoS3NK-pFiIFg2YEzv1CIyIYQ0MRSaTnaC3tgnNKvB0nxTkj0dxiSvZMFV16SzIGup9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepheenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cZFdZl1BZG62N5SxmyUlt9Ren_ap6EkmrWMSSy2z73RGgDZ5wwG-Dg>
    <xmx:cZFdZvEmaTd1jeg8U7Yzfy4jBP5HYSKF46P1G9ZK_rRwomg_W-sFoA>
    <xmx:cZFdZu-21HWc5wsoI58Q2ccwiRGplSW-pKDxB0y_6ct6XtPiankxow>
    <xmx:cZFdZkkv3qAUy1se0pYb0duN00UzvYpD-ko5LZzOQuqnYKRHgJMtMQ>
    <xmx:cZFdZlM7TdBZpSdT4l3NtE3gEkMnzCZzTisktdxqjgqGMRRMNTtBn-SZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e01307c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:48:07 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 26/29] line-range: plug leaking find functions
Message-ID: <ba9c2b4ea73be5e9c2529921b6491b9baaf661d5.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0McBeW8Zn+MqhJC3"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--0McBeW8Zn+MqhJC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `parse_range_funcname()` we may end up allocating a "find function",
but never free it. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-range.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/line-range.c b/line-range.c
index 60f0e5ada8..b99f0d9895 100644
--- a/line-range.c
+++ b/line-range.c
@@ -234,6 +234,8 @@ static const char *parse_range_funcname(
 	}
=20
 	regfree(&regexp);
+	if (xecfg)
+		xdiff_clear_find_func(xecfg);
 	free(xecfg);
 	free(pattern);
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--0McBeW8Zn+MqhJC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkW0ACgkQVbJhu7ck
PpR/shAAorhbJUl3S1pQuwRbqeGTF6OsLSDuw4SZP2+v0j5J9AA8sv7sLbUAjjCY
MTLwLB6F4fY42nOS+SXbdN0/o4Ck5Fr83b3A00W5vyyu0nKx7oappJ6roljp9906
BaTQQMv2aal2PMPg0rQTiniSDIJXRGbGo1wN9jdVIvhde/nrxnXp/66dkmxLFKMx
Nai4j+ywQz5Tl45PAWwcqfKxj7kO1q4y6gMpW/lCrSaHJW82L0K9kGMgzXfBDOA8
gKj4bXr/CHXLpU+pQlI8IE7Zi+IzQOU0P1z3aGDouowZbYksAxaTvQLyxxX/tuP/
8XJLMFunIOtpSGhMNAS6bDAHfgoY7ZkpfzTQ81rvkNE0NNx5jrmPIuDPhiGpl8qs
OTGNyvgGZ1OyNbROaPnL4b7VFSVCnvi/J9cfEeSMY8CStPzYSUILp4Dtl+yo2RO7
LUhFvpyZzKhcY8VdZU951wVr5KH6YVVd6KLy00CHQRByWVKVLRFl0s6gyDN+JeKf
6sBjz6mh+dBuBLqXygD9x4RoTVt3kMFYryPcgGvNrR9LZb0xTHEAm+lR6fL5/H1s
+Vr0ukvbKsVDo/zucWC2swnh39jTEqt5ct5GUkrZHa9U1CO12atKwKmGCmywXIJm
rSaoNsbi64kJZz7LpcFm0gZb/Po0bmXW7ilwAuBYx+VlncveJAE=
=Ntgf
-----END PGP SIGNATURE-----

--0McBeW8Zn+MqhJC3--
