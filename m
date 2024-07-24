Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162A2595
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721819117; cv=none; b=LXBbHWTpzfKwY8LVlqLOFMfLSl78AaZn/uK07MEbe6EvInI4UclbYuSM1ccesrjiIwr1e2wJaFtetxoRd/7uSprOjdcbA8Qs23Ftw4CIajPVsWLPl8YemMBu6F/zsX/U2QOuPcFWR3xz/2yjpwJIUsmO2dAd1NqtWcUGLjzHbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721819117; c=relaxed/simple;
	bh=LNggavBDKmwvVL2UeHCsm+4MwOSX91LQMvazJpFj8f4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oG4Yojw54IicEM45FKzfI5fLTzHtHpuVi665Wzq+Ugggb0sSkT4odZ7pC0vtG1x0JkHvvW0pCh7c9Tt/BTuc8/mMFf2DBv88idJtFBEUy45i31eX736Bi2CRv8Yh1utZNFTYUXjRLHSNtgCy54BGZk/F6WicJ4NL4SBXalPsl0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=egwAQzam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f1zZXO9d; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="egwAQzam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f1zZXO9d"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4E6D8138025F;
	Wed, 24 Jul 2024 07:05:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 24 Jul 2024 07:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1721819113; x=1721905513; bh=fKwXMswSqRAaco1xGj/qrVBOauElepo/
	QfbNqnfUPWA=; b=egwAQzamX8TiDT6IAySBwDwkL/gD/RnaCxR6VkUwvRF+jFuL
	zQn4MlRGafY9FSDg1KnFMxjsYCHPuciZg1mLnRzCU99ip9uWsK0QZB79BkNynB6Z
	efstgicsEP2N1OaBoPl0VjtOu94aHOGRUlu4Skpd9/Nuj/xqt+E2+KjSqqefKe60
	DHfPDX86p2FquucQzwmvDtsvyklBsVVf5OrQFOOE8V8eG+QnrP5T19+WxmcFjEdp
	1xQDDtFiLrM8idTt3TbNeS2PQpQp7Flo5tiRz/QiyIRV/Wxy0oGwp5FYd6VWclyw
	jNrNg0/RrtIdmCezQPeNcwtSy5rfCjtZEdn7hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1721819113; x=1721905513; bh=fKwXMswSqRAaco1xGj/qrVBOauElepo/Qfb
	NqnfUPWA=; b=f1zZXO9drs3TqZvtRX1J5bmLL7e9N1/MNy1HTDj2dClJLhJjKex
	vYZY1SqIC8+jbWiaLI2PjNBZ5Y+hEue48f7Fj4lpr8MiUdJtQ6sLDocsw80fOKmY
	4XGS08aRWDSPXXqNL74+V9PXQHoYJCPOVPNto7zPmeLTYsTO4OfRIoJG4nRpXdHE
	kANGM6KkhrcrQC4OEXfgOViSP9Pcbos1eY0zEfRpS5nkru7Og6LmnI2AbYf1zU+6
	zsX0xQvhFqRyWMgTisWRIixZOcH4wj0MROMx+4EBsnrbWGklw1gKwQNDZBK+1iwf
	eN0q9K+T1OIMIQZVP9NvScTvr9z6By76vJQ==
X-ME-Sender: <xms:6d-gZiyJYxAJJ3A80Kh0ghAWp7BvrB8f8mYbaBiP589WmEi5Waocfw>
    <xme:6d-gZuQLJUwznaR-aARKHn43vOCs78O0JU0ULosUwPojn3FE44MD8qxEXvjEBYVVj
    cpdDiu-QIl7EmbKYg>
X-ME-Received: <xmr:6d-gZkVABVqQvbMc6nj_80tpGBxA7MdKLJAXk70hXzLtwzR2okxet25ULwzXMVZ8pNc2IWO4c2B-_t6leDA0ospMNlP8NDMVDJDWAhIUP_TXxJod>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    eugfeutdeuieehteelveegudejkeejheeljeejhffhgffhvefgkeeukeejtdeijeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6d-gZojHeWYMqt7YqeihtVf1ePtpTbd4K7aikrUhy9_bWlxM8Jwthg>
    <xmx:6d-gZkDpwShJQxv-OwoHkp5zVWjxB7yEl_xCQGuoqcAEJO7VHil27Q>
    <xmx:6d-gZpJsBpopGJYgnUZUki8PST9rbBNooGkS0CdrEzzanTI6VjaFVw>
    <xmx:6d-gZrD3fH-sIHpxcpC9mJEP2-Y1wYoqN0FyAKjkJyiBjYIeMiHjKQ>
    <xmx:6d-gZnPe6ONFr2c_UmKpohlINIzHyfKGj7VO6qLi_D55im4xgL7q9Ads>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 07:05:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2d066e23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 11:03:54 +0000 (UTC)
Date: Wed, 24 Jul 2024 13:05:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] Documentation: some coding guideline updates
Message-ID: <cover.1721818488.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vfgi2tRnUY/+X9/u"
Content-Disposition: inline


--vfgi2tRnUY/+X9/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've had it in my mind for a long time to update our coding guideline
for some things that I frequently stumble over during code reviews. This
small patch series fills in those gaps.

Thanks!

Patrick

Patrick Steinhardt (3):
  Documentation: clarify indentation style for C preprocessor directives
  Documentation: document naming schema for struct-related functions
  Documentation: document difference between release and free

 Documentation/CodingGuidelines | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--=20
2.46.0.rc1.dirty


--vfgi2tRnUY/+X9/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag3+MACgkQVbJhu7ck
PpQlZRAAqKwdkJg8I6EQ6SQ3ww3ktYkwCDS20unSNomLuMCP3dcYrC77B3IT6lTf
2DYovsAExFJySp5jRkaAUGABhH6oyP/pWBxszxn9fBlWjj86ubs+taqp3giLhG+U
s3XSWQDp+nx/K9v3o5+8JNfa6+oSlYztBJzn+NtRLwyrE8suWhy/zph45NqGO8qO
iDehPv7Ra8o+RfWN8rDw/iQFhKJsW+uiizoAj6F2v32TxdQeQrQwqjpiV20Ep7Pu
JmtGZIss+GIHbZSIRR39Uz6+qziG4rKsXPTHsYwz1vbu50jkODNkmdDx/YTK8+kN
YPy7BagbuF+WgilTkjHJl5tWtnXCAu4er0unjn3EduxFKmwMG7E66XxdexYZ1STo
5V2DZvyMXxGcOMmDM3QhxDAkoDYKjyRawjidGHfrztHsBBSsSQmEJEUhK7bfjgvN
fbkS3vwR9HuEPbmUV5t6GwEcje+n/Ox7beDf720OQ4QZXloDUBY5y0PKJgw2w6rN
vsZrmAGO2iO+/G3dHtWN3J/b5mPSBTS3rfXzchs5yzzHhAwdF9fy/ZWkbWPcO1Dd
TszzGQWS9JRc1EYVu3JZEGlPb2myhoJRzfM2DwFhrjtNThrN43yQjJgFoW7thQal
vCiiWbcJCUnFVBG6mkqT/BO26S+FWLksqMLtYghZW+Pj0JIudrs=
=9kDl
-----END PGP SIGNATURE-----

--vfgi2tRnUY/+X9/u--
