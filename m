Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB246A8D2
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057612; cv=none; b=XNCfZuAkBbCnoUlZoX+LuK8lxSpCv4G3cZ/Rh/MTjmrqv5IcfLbGSRorlO/KExWV75F2AMjHZNQ1I6NH2xDM4q6gFq1oLXSjGbg5BolQftQi7I05KitsMGExMlhw1AiIB1g3pM+uIAI9glkw2vvTm5KdDRADQi0x7N5kxD0JPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057612; c=relaxed/simple;
	bh=MxkTOvUeYDsurSYf5qJiwM1COXlPupFAyybOcGj4bZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyCpQ79VXzvC8NBk4kZn+in7khGqONMnbLK7qGjwksLsGtF7GZ1mKH1JnGHxj6+5soCL3XHQ0nLqbs36TcGgxWr3sCYBLchOY4noGwuajM4/7VzkDeZKSRfZZSXrpWNnUL9OsCbuO7LKsO7rwmAr/OIJQhU/gLW/7vVxGmSCTP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4hIf2kc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFpcw/+Q; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4hIf2kc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFpcw/+Q"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 155DE11400BC;
	Tue,  7 May 2024 00:53:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 00:53:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057609; x=1715144009; bh=1EBXPu+Szj
	eLGiRqXKtCHQryxhm3tHYEFg6pBaf+akQ=; b=Z4hIf2kcA5lcqEz8G8JUwVxF+u
	/bcoAZE4lA/z0+UmGqBDGS6hTOUnxsWcc8L3wekHEZeMcfiEo8d/cx33b/CDYm9t
	e9ITOKU/oIR6Eho9I54tsFfEtB2apTf/FzlqUz7pcHPLGOiFpgHG+JXQdmBbjoK6
	57/uWd37zne3ErT6+fS7KZv1RF645BJNpeWLl0C4182Z0fSVw+vGl4IPMo1YUvTl
	g73m6/CVFRbiQ13pt7dYr3PgvWJvliNZEkTD5BrmSWOVnDPQgkBTpDIbOu2Wf9Cz
	GGIhMM46eodtH/g4taiIS4HiHzFcqYeaZ76ToOIrS8Cz9feXSZ9pKGxFqtOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057609; x=1715144009; bh=1EBXPu+SzjeLGiRqXKtCHQryxhm3
	tHYEFg6pBaf+akQ=; b=fFpcw/+QEQEj6F6S6c4MK5FrF+r4PLuLLwJHponUerKc
	gd3AUo69GolCPAIeM8DInIhBJEmy9ChIDndE3wA7ENvy0voEt/APf1jzE2poHncg
	Wmxq6za+iLeLjezrgoZlFqhpioSPYqtYT4hFGbwBkd/FLCwZG12gvriZz9uEfhiD
	kGapPi531g2KMK7VQLx0UTwoYo52oAYbcPRm4H81/z176QWGOzx7egFlLw6qJrDD
	qka4LMzq2cYBtGXlhBYwLlH53p6qQwRUh9M4MUSdzV+hOAayfS0VMgPi7pdwzrkg
	er1hUaXYbDxLN7sB/q6vSWbJcWlNuh7VCziVnmI7wg==
X-ME-Sender: <xms:yLM5ZgHfDEV5FbayUV4atc6Pc__Tnoe4feq98xYJLOp6wngj0E5Dng>
    <xme:yLM5ZpX1t7E5mRfgkTYJpSBDWE4rUSeq5VdFnL8D1uCBVsTXUdVTIX_4C_Rp_Dxo0
    GbIttBdbpIGRIFXGQ>
X-ME-Received: <xmr:yLM5ZqLGs4T1zdJHQVmGVlPc2lubqJm_xmVHAZXd5kPG4pgenR2QyVjKR32sHnkniC2oYP5NLj4UC-Jitb5o4DT8TT4YcPvGW-z8j0DOatl-t5Ep3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:yLM5ZiGLPOPMgyIuOBssTTR5BFeeiCdRNb0Ljfwe6D39FE4zHt07MA>
    <xmx:yLM5ZmWndkJrT3pHzVSAUMKRTsmpuq3V4m2py4j2bjOnfZnyWcvPTw>
    <xmx:yLM5ZlOg7E5vXEf_j6dZnDr8tgwX0qy74zfSofvgvbfnv2D3NXrXyA>
    <xmx:yLM5Zt1m7Gs7MoYCMKRqniKqGcxtFCeZ-UlpiBshMBGvMqrql4w9kg>
    <xmx:ybM5ZkwUPzNUsdGRIxA9pUpldjP8cjdZA3BoulvPfOhiFnBJl6DkUalM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 64d5baf5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:20 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 09/13] builtin/bundle: abort "verify" early when there is
 no repository
Message-ID: <5b4a21d2ce791a2ae45ce91ff3ae4f4a03efecb8.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FlCEpQegesc/mj5v"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--FlCEpQegesc/mj5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Verifying a bundle requires us to have a repository. This is encoded in
`verify_bundle()`, which will return an error if there is no repository.
We call `open_bundle()` before we call `verify_bundle()` though, which
already performs some verifications even though we may ultimately abort
due to a missing repository.

This is problematic because `open_bundle()` already reads the bundle
header and verifies that it contains a properly formatted hash. When
there is no repository we have no clue what hash function to expect
though, so we always end up assuming SHA1 here, which may or may not be
correct. Furthermore, we are about to stop initializing `the_hash_algo`
when there is no repository, which will lead to segfaults.

Check early on whether we have a repository to fix this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3ad11dc5d0..d5d41a8f67 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -139,8 +139,13 @@ static int cmd_bundle_verify(int argc, const char **ar=
gv, const char *prefix) {
 	argc =3D parse_options_cmd_bundle(argc, argv, prefix,
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
=20
+	if (!startup_info->have_repository) {
+		ret =3D error(_("need a repository to verify a bundle"));
+		goto cleanup;
+	}
+
 	if ((bundle_fd =3D open_bundle(bundle_file, &header, &name)) < 0) {
 		ret =3D 1;
 		goto cleanup;
 	}
--=20
2.45.0


--FlCEpQegesc/mj5v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s8QACgkQVbJhu7ck
PpSWnxAAgglar9ZqZDX8/s9CqU+1qrSGvkKv7PV5Z2zEI5a2bhfQLwzT6nUSocUz
5hwvrdN6hANEj0iByFsteZGyD3zalYKNyhXvTr+NDJmCtZagszB2ZOnskHhQKId0
yrRHVn2iOeFPel7z+zv4cZbOqUedk2+r8uEKs3AEGwa6AbOQLNxlZm2hBUn8HOkG
H8Y1P4b7bMkZ7hzJDXxb631wjdOCdBAgnQ/jxRcHSaFxVkXRuVHV77f9wbBUGNPx
VjRmcNvwoLD0XwXq/p6l6HlEasAtcRIW4U1BepJ62pYjfzmnnWO9PSB2Fzh6UzKK
krEgl6ME5TyhCvIST7Wb4pcbLSyYt4/9569O5m8pmB80PK+jN4iYwIEEmLnuIdGw
4EtsMKlMy+MCN/lGecphVO6QTofYjCHPZf+j4LZ7cl48nIQ3h+mlctnPlNrH3q7C
IAOYEquEAmAu4Jz81RUOg/ekN+efRsp0eTmMOSFGRaJ8eE5Dk7hmy7hJP0ooTTSq
4JCfKnXLYlUDYmZTUPi7WLyxojYlNVXuI4EXFqDS/RmSobm7ABFfimuSopVWnP0c
aFgqS7xzqlBln7th8BbuisEACfv96PfBdWiA6JfH6fhV7pK1MeiHifMLFOm0QVKW
egKlvke3k/kvCvOcXN4wot7dGmxq2RLUdgXWAEWPyBg199TGsHE=
=pgdL
-----END PGP SIGNATURE-----

--FlCEpQegesc/mj5v--
