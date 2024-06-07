Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13B1527BA
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742799; cv=none; b=AF4MNKsdi6+9CCUoBQgBrcUffUtb7TrG62kYNWFUWgnLRc8Vv4aRg1+y0VWj4xYz0cYCzQ2KLEgtKvKkQzLjBI/SP6ExOmt+QbPKNTXUZVKvAjHqbEEB8xB56Q2Gra0rolms3nbX5qmf/0JD2ZSpK/t/gzT4iOikEMk55Hckxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742799; c=relaxed/simple;
	bh=7v+TUkVGdzn7mqIdvMGbMP0GoOA1dH+LKVw6CM5XQko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvrMPNvwQWebd5tWrVHefl5wI1LOgHsKa/++pArzpn+gaoEQY/AX6W8uIq6QjzBMU6RY/YBwZeqj+ZMQGTRQRtzgjziUYlqRsUCgbuu5vg+Hawds8aJWp9M2FbobsAjqR1Oxp9marhI+2eVJ3GG68QGXsKz/BUt1xgGx45hzevQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YQVslhdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O25YSQnY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YQVslhdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O25YSQnY"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A3F8B13800D5;
	Fri,  7 Jun 2024 02:46:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 07 Jun 2024 02:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742797; x=1717829197; bh=7v+TUkVGdz
	n7mqIdvMGbMP0GoOA1dH+LKVw6CM5XQko=; b=YQVslhdfUIHKvBCQxQJyx4Vqcn
	BV3G3wu75RHwptB//PulGhEe+ZOV0DpSyQ9trGlGPfHPv4CVKWNyUk1cgBvPJ85J
	14sBer9IVtBwUCE/aj+rPBu8BNVcAyE5go/7fFYh+rG8bx+gTTl28v3avRDF6Dza
	XSFndOhVpdSUllRk4y8mIbFavn0C1ijKcmBgHEXl29muKqBVR3mC1cTGXBPRALs4
	q+kGVTOrMW8Uc5+igIdNDA/0OafrEGs8FkERFeHdxiFlrWlwwK0/62FkQEKLrUHY
	gQqNOD6FC7Tx8sAkaQEqyzGUufZE6hk41BaOF8DJYJ6AfP8wy7q5TOzGZcOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742797; x=1717829197; bh=7v+TUkVGdzn7mqIdvMGbMP0GoOA1
	dH+LKVw6CM5XQko=; b=O25YSQnYJ4d0u43al9Axjho3DyPK7FzC2I1LSj46s69s
	4wcM8jENQYkLvUBSFMYlcck3w54gIQ/MN+ra7QIA8q+eXgSzZr8nX53zmfJuJxKA
	Dd4lLE9akReHqVhtZiS2WbLavj9/qrEaSmnNcRt8IdFO3dATziFQB6bjNDh6JOdc
	ZdZZM0b+oYyuC69hUu3D5jE2KPL24Jmbj48jT+IKR1ZAJPVbr5yEZ5Mft76Cv7Bp
	LWlinpTjZ0xB25F+xYzTB8LK7OrpGPqnrYXfUYnE6lmMeW8ePVYuFRbFR6a9wIlP
	FrqXe96wdd9Ot1ed5xCZBJrz27WpB4AZzB1TyokLug==
X-ME-Sender: <xms:zaxiZkBQuSQa3xw8wWd3c0Mnrft-7djdArXpObIyjEyVPnYNCB-Q1w>
    <xme:zaxiZmjH9uP2wgshj-WrP3Az-atJzDHvEMLwQzyZ88wkQkI1lC2PIL7-c2G_itwtt
    _cwyR6YyMQO0mX-gA>
X-ME-Received: <xmr:zaxiZnmvesLcSLAgNPNYuSSBpMjX5obvwuYGglekNW86xr4U2Hz3aYeTldIaJEJ0MXx9iq6t-_-b3pvwXhujwXe1pR_MIFVs4N2u8p8_0_lLwDsf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zaxiZqzYUv4UHDvwmnJOIg_Ha8oc-2iQsLLLaCZi78udVycBVaQgCg>
    <xmx:zaxiZpSNxNq_R5WHe5eLXSl7H7oZT-mG3z1iIEyHtGKngouhiq3VmQ>
    <xmx:zaxiZlbcORp0LDS5v5dbOSntbCZjZsG8Icaq9a-l1ePBPeMQFKJNIw>
    <xmx:zaxiZiSmfUye0gyZfW69RZCHY7c1Qa1iCxWCEgiQcDnGJCYMvSU5nA>
    <xmx:zaxiZrc2ZXkxYYroPfpvTz6yv1UX2nrribn143zf2Cmro2bgTI1mC52h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:46:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 27a888c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:46:35 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:46:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/4] Makefile: add ability to append to CFLAGS and LDFLAGS
Message-ID: <d68539834f3827fa3ffe91517e053c043243a378.1717742752.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/UIlM0QOKYu0Z+VB"
Content-Disposition: inline
In-Reply-To: <cover.1717742752.git.ps@pks.im>


--/UIlM0QOKYu0Z+VB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are some usecases where we may want to append CFLAGS to the
default CFLAGS set by Git. This could for example be to enable or
disable specific compiler warnings or to change the optimization level
that code is compiled with. This cannot be done without overriding the
complete CFLAGS value though and thus requires the user to redeclare the
complete defaults used by Git.

Introduce a new variable `CFLAGS_APPEND` that gets appended to the
default value of `CFLAGS`. As compiler options are last-one-wins, this
fulfills both of the usecases mentioned above. It's also common practice
across many other projects to have such a variable.

While at it, also introduce a matching `LDFLAGS_APPEND` variable. While
there isn't really any need for this variable as there are no default
`LDFLAGS`, users may expect this variable to exist, as well.

Note that we have to use the `override` directive here such that the
flags get appended when compiling with `make CFLAGS=3Dx CFLAGS_APPEND=3Dy`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 2f5f16847a..b5252bed3d 100644
--- a/Makefile
+++ b/Makefile
@@ -1359,7 +1359,9 @@ endif
 # which'll override these defaults.
 # Older versions of GCC may require adding "-std=3Dgnu99" at the end.
 CFLAGS =3D -g -O2 -Wall
+override CFLAGS +=3D $(CFLAGS_APPEND)
 LDFLAGS =3D
+override LDFLAGS +=3D $(LDFLAGS_APPEND)
 CC_LD_DYNPATH =3D -Wl,-rpath,
 BASIC_CFLAGS =3D -I.
 BASIC_LDFLAGS =3D
--=20
2.45.2.436.gcd77e87115.dirty


--/UIlM0QOKYu0Z+VB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZirMkACgkQVbJhu7ck
PpQOwRAAlXhPbbTtyj1F5grFZLzCl5HmoiI0KSvks3MYtngEOAwr5CjpgQm4VM9t
hCZpulHB72s83sdKTKQMNblYCtotzr0yXMK5bP9pos81HkHHggvmGTS2+1sKiRT6
ntTukOQfeJSPHES0Dmsug/phcdjpihnZynJpf6JO2wBnjZMR1jfw2H/PVL3mD8tZ
88PIrC5G4j0dw/mMRoQV8gvqXI2uSNMLdCNNXdbMar0TWIGwaLidbyxZBoM7YTtV
ZFVzlCbUfJ4G4EUXzCZGsLY3eCslb7XXqDKrpnyhtqvOZln8NCUBbRcWJxXoLggV
XfdIeyvHbQbGykO15XVaC25xGv2nuXP6ckxNtyl6Aj3kxCVXHYt0GlPuR+onCmdZ
YG2+jwz4LRJY4wZvn6/TMVzLXLCIWbmKAtKuJGIMvJ3kgtgqZ3eXrLeiYCE+eSzd
VlhsofSQNvG4yNWUJxeeRPr77g0Rk3qQx8J5ziBkjwfe9UJ9Y9jsqVPEJXiruMlX
twqBA17pdYr6qOlPKkHFVtamH3dSNjmneOyYMNxu1o7FUL3ot/u960VdxKolTdl4
qDYYxmvAlE7VIGOM4pagP/6A6NCAVQRYlqLJYPdfzpQAKwkGdsI3DLeYqwMXSLI5
zn2TkN2OybP+tDEXnV52W09MzN6UNpM423O2P3AhWq7eFNk09yU=
=iVTm
-----END PGP SIGNATURE-----

--/UIlM0QOKYu0Z+VB--
