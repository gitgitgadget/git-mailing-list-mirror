Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D287F7D1
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407594; cv=none; b=GlzsvjNkr/Bm1s/GzcneZ14Kvaifn1UyNXBbnCkN/CvktSgw19G3ZWACYHEyOVEC9FI1uYfZKDX3QALwax3PE/jJd/QxtrhnPxD4BrnJ1FpXDTSHkUccJdW3E0kPm5TfMIYHlfm4T7uJ4IiGZZBvq1Zy5jLDerwOpOL7bXaHbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407594; c=relaxed/simple;
	bh=qw/dDE3Os19ZU4NlgplP8HNXH4Ks2AOLsARjxIzS5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF0/ea1u4ftsgLEfxg3btLU5xaTf+9bF/gL9p7cbVRc63JRzqcXtlG/vKS8wUn0fnuC51TDvx0JtZBF8HmsATa2h/FoepGnofJw5beizMAghjuYAwqesRx9X1OvAWfbIys2skQ245YxdR5N7c5Ceqt1c04NUY64+Kzp+mwgaEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IRgiiu3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K4v1Saai; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IRgiiu3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4v1Saai"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 8235D1C00082;
	Mon,  3 Jun 2024 05:39:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407592; x=1717493992; bh=/dh2YKXF3o
	4oO6ykD54JNoioSv2KMtE+hwaQ/UeUu8A=; b=IRgiiu3SErBqJVqgmSDMPLReJ6
	sgjhunBMvnScaSoPw7oAMlD0Si3ERxOgTpiIOxa+OirfMy7/99bYFnHEQMwcMcB3
	erI760ExJDkFXVCzjyQAxAj/hGDvajcVHvGAapcJTeU1hXddZI/MSHa47PU/4epE
	Q7FtDIqSNsFUGWkeMrnCaw7ajtTqGDCCS9nThwCiRNVrpX7Ff/ttRVh8/H4RaG6B
	wEeJVuva39Q9E729fGlsHAwCp8/Q7pkKGq+TqA+Y14bQ+6jpqJIz7WPMYntRMdjU
	W+YnZwPbist79nwrk5qLCBvhBDrXswtPiUwgx+IlnfS4Eok/ISAgTdeiCylQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407592; x=1717493992; bh=/dh2YKXF3o4oO6ykD54JNoioSv2K
	MtE+hwaQ/UeUu8A=; b=K4v1SaaijWc4IQSbQkfCIQBQh1GDpDndndR72Y+l8GOT
	9S4q6jCxEoczFlbI0zU2NvxchlVSmEhBl2boZ6Y52re5sExi+BD9zFgWJYWDyeWn
	cXHXL6RiXBVqBqSWARwCDANAfEYoGcIBfm+hLcl8d+TtwynTAicVXmeQv9QLtjsG
	hm/Ru7K5L225BEFJXImy4eLZ7lR690pi0f1EU3XR3OrcW1sSW5ClYHbe/R9iHa1Y
	l3ehqqt6FSh+cXlH0AMjPGU/qw7bDorVmGxRM794exgEWsmaJLjXQFrYDe3hPcvd
	xY2iYIYyLaNB4FnWbdFAxoyH3QCbWXdCPa7sejF1cA==
X-ME-Sender: <xms:Z49dZtv4x3PbJXZ_1U2XTGg3zrfAKPa_GkqgRIoR2zMFMV7C-DBnmw>
    <xme:Z49dZmfTk5Fz86cHPhhJxL_69R0PXIIcw8MrFKrhXE96BLX1J7aHDLpVz3voOqFS1
    7Ccm-7iV4RS6vrhGA>
X-ME-Received: <xmr:Z49dZgzlM_iHTQY-6_Ei6m4WpzdPT6v2zWT6mWjiEe1i2avZ2uaZ8ieg4sIpfGAcT5NFpX1FEVymrU0SG9YEvM1vKBMjKVik9qUQTmjR6_eTuU0b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aI9dZkO61CEAVQYtaBmWGTf2MEcgUDaiwpiZWZ2iPgwAYpeP8qn4HA>
    <xmx:aI9dZt9E85ImXs8akRDUVhNomr-8iUc85ZCO_c-rete4fYvuAkssSg>
    <xmx:aI9dZkVJ74EdEnMQeMefywAyytMyK6t9dniWc8ZoiHq9ekyLF_z_Og>
    <xmx:aI9dZufB7yLLqMR5axDqkh526NSIbHx3WSXfwq4R9tqC0mNKH7SXQQ>
    <xmx:aI9dZoay-7XLz5KS8YiMcBCA8fIs0nKjnW3bLtS-NN-k7RC6klW2DW69>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0f093e91 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:26 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 11/27] ident: add casts for fallback name and GECOS
Message-ID: <81e20a7bb88b1ff0308517bc19a73aad93c027e9.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="knjworDDQr1Q2sM8"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--knjworDDQr1Q2sM8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `xgetpwuid_self()`, we return a fallback identity when it was not
possible to look up the current identity. This fallback identity needs
to be internal and must never be written to by the calles as specified
by getpwuid(3P). As both the `pw_name` and `pw_gecos` fields are marked
as non-constant though, it will cause a warning to assign constant
strings to them once compiling with `-Wwrite-strings`.

Add explicit casts to avoid the warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ident.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index cc7afdbf81..caf41fb2a9 100644
--- a/ident.c
+++ b/ident.c
@@ -46,9 +46,9 @@ static struct passwd *xgetpwuid_self(int *is_bogus)
 	pw =3D getpwuid(getuid());
 	if (!pw) {
 		static struct passwd fallback;
-		fallback.pw_name =3D "unknown";
+		fallback.pw_name =3D (char *) "unknown";
 #ifndef NO_GECOS_IN_PWENT
-		fallback.pw_gecos =3D "Unknown";
+		fallback.pw_gecos =3D (char *) "Unknown";
 #endif
 		pw =3D &fallback;
 		if (is_bogus)
--=20
2.45.1.410.g58bac47f8e.dirty


--knjworDDQr1Q2sM8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj2MACgkQVbJhu7ck
PpSEjA//UeM++ldFVM53Yab9m790EMxRmdurfNpF2ytD9IqW+jabTIPubMJAJ+Vm
gr7oVdyjsckGelqTATepipxLAJnUM2bRfKiQk7qOOT7/ZlpcqyKdLD08ZZiKsgTG
iAOoV6VCaqAEianmyQ+L/XAGGHG5yP8SDquBJ+RumFy61CW10WxQoMZ/bigbAD7Q
pbTMz63bgfYI4T645OkQWxL1S7KpGPN9Ewrcu3oTVDlCnNXCCJF2OlYco5xGd0P5
RFOoqfzgVhVwIQCZBwxeQevin41TJ+srxdGQ0Qhyz+FhPMgBpbOYR9r7d3l+LqVE
zsX2Ie6wVIdG7PWaSF3ebmwVynkhtPjSTkUQS/qxwY5ZLjc/o/lTkSwm/FLO96eb
kfkw/Tv3Vrsqp6+QbGaqR1CFaFz4heZRjV86IbNCn2JmUBQXIpbUCFUfSTZiiRJ4
i1p5OHyIHCPEFDFWAykVc3v82KxXl9Xgd0UOIklopMSwo6X2eB1IDcvfC5zbp7hX
/honBpyME8H9VkHLeQvyMu1Hz1uuGbmAvcab+1n/F3YzZrZt0if1K8EgSQD7phQI
18GBsGFOJJNHgJb/1X7lB5Ik1HmP5mDYWzj2kxaRkIKdPwUXWj9Ugib2HayHHAgT
/Ky31omyvUsTEShQ2HwN7oTrGP/sUgOWPtiKLkt4UaaQMSPMtno=
=VYn1
-----END PGP SIGNATURE-----

--knjworDDQr1Q2sM8--
