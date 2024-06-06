Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D4613E048
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669755; cv=none; b=ICTCB4vPVZKw9tlpq910LojxkOmWbSGblCXOrKp3J40Cp5Z+j4+Ws+iY0r6V7eDEUS+1XvhJFzIW8Qx1kM8gzRSLVmJYflm6//Sl/qbNpxMYrw9zft/5N+8SVTDrEa6gYT0LqqgQZtPlEnSt4SwDtCeXJLjgfWydE0uP7014tvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669755; c=relaxed/simple;
	bh=M4ldNmLY6PkJYbGwqgCNRsRl6k8gm/4HOKyFLZoBDz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5/hfDoH4xZ9ZQ60SNeJ4afHdonP1/+71WOBbGEzYMD4eUolt4L9RPq77zp581Ss3Vp2VfDRdoXHMxPNyRnMmf54cP2HnZEGqkJKMH+Fa+vIFT1cPd6qml6WpJs/GHiMkyGoPamj1Bl8B8y6uHKdL1gAFuYsUCQcJooZiKyQxPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NvoWCEQU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4jtxkT3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NvoWCEQU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4jtxkT3"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3222B11401BD;
	Thu,  6 Jun 2024 06:29:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669753; x=1717756153; bh=zfG1pMzR0F
	50nsTP/MvU5oCKBgRX/3DYroHDT1v4PFI=; b=NvoWCEQUfyeevFOp2C8K1B3iVV
	s+OhE9CXks2QM+at9njkrA3o8pRCBi0yl9/IUOuklcDz8Ba/fpQjTm6xtEb2pBKP
	K1oJhLcuW1cwFeW5Ar7q1fPOY0k9tDVQtfK8JsxmpSBwGvAbbPZT2Yan6F8rHDfx
	X3dIQOQbiWKAH/EfUJJU0j979i86x6lVykKW5mcKg+IzPUvMTJ92iSB+aqRIlAqY
	1hcdVHiHYLfX0aXkhVMA2/Cd3PZz9Ir4ZhAoKTbku/nqpb67lo7oNaftz/wPawd/
	ME3laFh/RDKOXUiIGI+N2sdm1tlWtGTEYOtTRK/I2QXrLerVFMnoXbTic08A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669753; x=1717756153; bh=zfG1pMzR0F50nsTP/MvU5oCKBgRX
	/3DYroHDT1v4PFI=; b=j4jtxkT3lCCzIek2FW8FMRKn3R6lMLCCfLbOWZgh8AcU
	EGZbukFIHu2jevVpjhZtHA4hlQpgfEqdXoMBLV0cfAZaSuGn4MagHQEcDcqGjOso
	gPzHx+RJVJRs2qjT+TPzPylKI0bj4yCiJFyfzJAgK6UEHIrfZE4PiZOUQMAxJeNX
	0E0ei/IfOdmWhKUGiFOsYLvwqUIoiRFziwbFOXT05mhX6EFggfudG+fegcMHDEUD
	pahp8o5+qjpmXPWatBYXhup6oPhkU5/qxMT9Cs4USWDE9cXqW2saUR5CKURdhuOh
	vUsZUp6Y1HhZudBEmKJd8XFUTSE+qDF9oUQjffQL5A==
X-ME-Sender: <xms:eI9hZnAoh_SVInI6EDLBBzRDSjuFZedPEeoAq2aVZL_Hp206Z1-0jg>
    <xme:eI9hZtjzFjseZzRuRmpEMMrapKPk4VdWAWnR4ck5YKh5eYB3AY5ISIk1b-EICOpPC
    e2TMV0pFC3x5lNUcw>
X-ME-Received: <xmr:eI9hZik7Wtqf6u6v5KOf_hWdM7_5PrcPyWolgpR3e-_uIQJPBBW2N5TUYFsmGv5dKF4pAdE1lvs1Te0FSkBh8GhBIk5WYdxgdThNPoULBVtYrLGx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eY9hZpxyQWaXRmpSKacnW8D9t9nif2iSy_otmssOQzJkm4zOafH-ZQ>
    <xmx:eY9hZsS46YI63gdsZwVMhIMZ9FsA8WHNGnHiSQZnxUIyR1jJruuNpg>
    <xmx:eY9hZsZfGoffa1Fk5mIup1xXSimNJA-EBCw0Q8xYRgJ1aBekmFWXMA>
    <xmx:eY9hZtQ8bKlsUzVOwfnwlC4GIVywSsP4PeE2psNhRsvtt0sxQM3ffg>
    <xmx:eY9hZiMSUdzZQ6NRW4CyLjwljhrxLB_HufbImlIsD3wUC1EUlu5By_-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fec83e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:41 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 18/27] send-pack: always allocate receive status
Message-ID: <527755b64859a59753bb28ecdfe1e36e827fe5f6.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eKSECArTXDNtXr13"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--eKSECArTXDNtXr13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `receive_status()`, we record the reason why ref updates have been
rejected by the remote via the `remote_status`. But while we allocate
the assigned string when a reason was given, we assign a string constant
when no reason was given.

This has been working fine so far due to two reasons:

  - We don't ever free the refs in git-send-pack(1)'

  - Remotes always give a reason, at least as implemented by Git proper.

Adapt the code to always allocate the receive status string and free the
refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/send-pack.c | 2 ++
 send-pack.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 3df9eaad09..17cae6bbbd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -336,5 +336,7 @@ int cmd_send_pack(int argc, const char **argv, const ch=
ar *prefix)
 		/* stable plumbing output; do not modify or localize */
 		fprintf(stderr, "Everything up-to-date\n");
=20
+	free_refs(remote_refs);
+	free_refs(local_refs);
 	return ret;
 }
diff --git a/send-pack.c b/send-pack.c
index 37f59d4f66..88e96d000b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -259,7 +259,7 @@ static int receive_status(struct packet_reader *reader,=
 struct ref *refs)
 			if (p)
 				hint->remote_status =3D xstrdup(p);
 			else
-				hint->remote_status =3D "failed";
+				hint->remote_status =3D xstrdup("failed");
 		} else {
 			hint->status =3D REF_STATUS_OK;
 			hint->remote_status =3D xstrdup_or_null(p);
--=20
2.45.2.409.g7b0defb391.dirty


--eKSECArTXDNtXr13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj3QACgkQVbJhu7ck
PpQ4Qw/+PaGRxEcchwcKyi30L7Q9FYDPWzrQMLyihb8ILgoNwtjwwAR5A+V4Suki
RGbAa9+lmvVWXcWoeAoRXTZPrcGukvDhmp8IqKpaAoPy0j2W/h6ecUywCUxgx2t9
rmqalUx0udu/8+cKckY/jAO4jSXRk7RVCUM6INWltQNNVYifCWgEE+x4HeShYnNm
zCpC6xjTax5KHa763BM857BYSXkFjKgTi1IooNjctygzOec/h6I9gSBfqg4nydla
H0yMDBZSrZfR0a63z78eupbDZUcNXk8neWzpSVhHpNxE4i41jk0fgaBEV2bMl4sI
udgbhiHlBP4oAre6IvnKosWz+SZB18/nmT/Q8ZlhalShNKrLRhOPvhaz1CBcgY8J
bGYlbrQES0xn+AQ6wecl4jH4w12UQSVdvkU+jMYtc501OsAxXoxRUY78DlW9oKjQ
OLVMFqx2a8OiHN9RK5PC1TiGx3wq0XFUPvPqLvZYcpKYoifr/G3cdfzshNlB85mE
vQwK4Ofjicx1N+tkZlvmJlP6PgNYn8mMKSXfHWbMZ01NOQO8oo7Z9dLZH/NmLMho
BSHOf4AKw9OMLEhVwz9S2VIJiBK43GmJTvlcO7LG5xa+M/Owyp4HYo77UpTSgynE
EOwgvVJ51DrV8+U+0Qi404wsrtRHUOB3xBOhceltzT8X9BzDtBI=
=ljL0
-----END PGP SIGNATURE-----

--eKSECArTXDNtXr13--
