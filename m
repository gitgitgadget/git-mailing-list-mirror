Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9A817624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097681; cv=none; b=hcGbUU4dEMacy9wzjdl9KBHkOyfRo5hDNFuj0Ncc8p/gLwYuHvz46cu0JRRrlHXxI/d7VqrQ4rffoeRma+5yyUEzD6S2zq19zbicncZOVLRCQjLlLEdeItC/gqHOU2qC64F7MoozbU6yrZ78pDfIbhTA7fjw68ZTrIVArDJu1t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097681; c=relaxed/simple;
	bh=bEwKYEeNOH3bky4m8CTF3M7QjYSCC/zm7+ZhyOcbERs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaquIKqk9t8wqCqLvVhRrrces29nLlhKrBUc+yJAe+AyRlisILIKkrcP1boxt+oWsoHVxr6WqD367NDzc2txVHzHGTEACZHaxCxWvIQoYS1XFYl3DJ1gK7rzWl6C1Pg5bYFmoidzMO3klYpWBSW2QqiATzO14xNnErmHP+8n7RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RRVWxTc8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dm1gk40v; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RRVWxTc8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dm1gk40v"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4390F1800118;
	Tue, 11 Jun 2024 05:21:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097678; x=1718184078; bh=rSgYeGEcZu
	1986qtw/kDmVKwmce6XNF6Dw86ev3i2b4=; b=RRVWxTc83TSXjsVxnRPo/64c/1
	ivuNWUTR10HaeBHmDLXvgeXDY2avDQysKLI92USTe8mjaJwP0kOna2+5NxnGDQAE
	40BLy7GWoOgdrr34SrghVfV1uqDSOa1QMa0xCeqBTQBWXx8+VQDW461tixDvlNh3
	cFkMCGTw1rbAjs+TkP7AJPaw1uH5mgantpDZu/qBCAbCQ7rhI/+CRPftPpUzXtJG
	Atwz1KK0zGglapFrGaOdNlgxF3HBK6MxNoZOr7JBQ+F36LpO0YK9IwVQX8kLinX2
	3eQ3A/h3lWjslcUs6xTu9BVBYW+rdnCeYNn4phHpWqliHocm6cuibjx3JTVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097678; x=1718184078; bh=rSgYeGEcZu1986qtw/kDmVKwmce6
	XNF6Dw86ev3i2b4=; b=dm1gk40vXS9w205uKVFPOjsDTLQHK27nHcRXqNwCpfJx
	TNX/PV+1Rec/aeG50l7BwSMh0zcCeX0ubtVIav47FZR+Uc7BjdAI+C0AzJ9De80m
	3aAaUGQRGeto4lqCkACxJucVyLF8pN/fJJNPEYSS2EhhSikr3h2w9QN+/vwnAhLR
	Z65ILF/+YWk8kEoylaQ0HxQInAKgMz8mp25EVNSYlgbHMQY1GWb332Nk2o9uxfwW
	G+ILenrLBIYjmBuqe1I18VU2050a2TtRq6PYLD0Gs4m59+1SkdtRvkzCF7hm0hJM
	zUHh3seTcKld+6E5cSr6Xx0TtgP5VXTC31p5ykczdw==
X-ME-Sender: <xms:DhdoZt8huSh4DdtEU9j3T4PyjzLELsanf1whKBDKsNlQsCGSF7T4AQ>
    <xme:DhdoZhviy451FBILIo1blIZg5xUxb5pGY20uMFtR0GRu5jSBaXBY6_FTrfD3eoGDy
    Y5ajFkHUCmUBV0wlA>
X-ME-Received: <xmr:DhdoZrDfN8wuXfkcbhZb1yvGpkn-mgWmufa-biI1EmPrIuoXqIf8-0uLTg-phpAt6Vdo4mGs-mWA-CeZ3exRVShk5V9REjIJbawmwpOrAEQLngWfbNtV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DhdoZhfK5UGkn9GOhuV92juI7aUO0VwawofBSWYEg3OAlfqlE1oekA>
    <xmx:DhdoZiN63_2blcu0fLUohQOwaRcF01uW-7JxF1qbqd9DPh52xWXppw>
    <xmx:DhdoZjkPDVM-NzQtN8NQ6SyZnJiVT1aBUmD5CNOHlperdlUTeGJ5rA>
    <xmx:DhdoZstCZgHgpkaBEmHJXvAnIv6nWzUKNQq8Ro0cXh4zpN8ncSdrow>
    <xmx:DhdoZvrCCFFNKy3uz-PNjTfEHVnMxW3wcNdTFStOk7DcwVVb0d7BA975>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 62da65ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:09 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 26/29] line-range: plug leaking find functions
Message-ID: <67f8637dc66530f05678f327d18370b524448481.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L9/tvl2HvR6rz2cK"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--L9/tvl2HvR6rz2cK
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
2.45.2.436.gcd77e87115.dirty


--L9/tvl2HvR6rz2cK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFwsACgkQVbJhu7ck
PpTibQ/6A2pxiRigf8DMFcbkgtBKqRdZris1+0w4W98uVYPnon6YoJtlW0gZJsbi
imy0VxXzpX/jqDly73WN7qoqzzTlXFARRHzpO257XDhP8chWjIHgeOolbzpYHYK0
shLUrT9h5hAOJ3+CG4DhWP5cXqVj+en4QitHcmNVIvRotQVfNPimLlOH5XqiAnIr
/lEIeFvKHUoa6J/gBO1XS9zBDFvgnRS+595x2dGjZ573AMGl25YWejYsWeGiJHu1
abfsPXGDQgb9k1bNWe5zd8bR54Ye1sJhgDlVuO8IF1Qmr8pQAgnsOHTIIw0fGFOD
GHp4tI/nmvCBynfyTECJPHrXqppeoe0WMrtcAMeFDaTDHDZ1zaBsD04xIes6lM/n
U4Atyxtfd3lXFRoILser4DeLtWLhlYlDT2kEoyCBiyAtDuLP7gONMbwDYtuibOKy
eNC1/PNc6rJdHBOeEXpdD89kW8wefHS3xxwqvJDxIvgC7LLFVRih666naG2YtcBi
sYJAEllm3tq2uG6FYuTESl2qZ6yCwSOBb23TAF54tdzlYCKgRzst4TiJU/8dqMO5
fIkd8CwCNAzKfg513eZ4TCpx1HajqmePwMo6Rd9vJqtbm72KheZSF3BopGWMAP0K
7px1Z4/gdVqaLFTVMpQt6euF2COyRhC5crdXTXMHbG1NJwSiCBg=
=XTK9
-----END PGP SIGNATURE-----

--L9/tvl2HvR6rz2cK--
