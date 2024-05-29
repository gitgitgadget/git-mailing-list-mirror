Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C355B17DE23
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986695; cv=none; b=VIp6xUqmPxSEhXxNh16pBlqml/boZ2pwgg72TVJ5E7RpAZkvFvHP2mAD+kco5Bt68crIXQxGrhNYL3C3FMHeKo9ZD7KE2V7WPY+kBE/z0OoVEV8rihLaww9Rb1HtVeq5+gl/0AJApWizdiQGNtTm9rmagqjgUiGJjpqPM/G0Ki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986695; c=relaxed/simple;
	bh=2OLM8aCYa9H822q4x435RAx1HDHCHFMkxL8dAS1s9og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRX//PqJJnRMMxVzgD4DWxXKrd4ZmcAMRfkwD57erbMwlCNhOgB6K9NcXT/t5YwXMjHVIUZcxWjjNIJox1IZ9YTp48kkJD+0O0FdxilzKdHjVhyZzzXwc5MNV3D3wsGb1dt56Zdyuc3QVVy7ANIg3EoAL+QpBAJxh6zl1c6ocwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ku6xhrvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nUs+BAAd; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ku6xhrvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nUs+BAAd"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 3E3A81C0012A;
	Wed, 29 May 2024 08:44:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 08:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986692; x=1717073092; bh=qiGltB2fm8
	TXHjNSghWQAQaQrY9Uh1HE4fGM/kuIT30=; b=ku6xhrvuW2jHcVaZGQgeyPdlzw
	uWvvdO66iYuPkmZBiN0OWdDekjRpHR5jgyh0deHC3ENAcSexwPbtByFf3z7e4UrL
	v43IrEfj7aW20io1lxiparVoMTYz0k1GhYqY6Nwl8XSqUB3vT314AvUhqWeDms+0
	pMqm67cZMF4x0xzHWvUhCbUie+93vqWy3RDZBRlH4TCVaNULAQHGycMCBwd1RdpO
	46ygCVTmzCeI/o2hdCzGtMzaaQduY3N33/iOYMB6Bhvf+hjSogqVGXPvjhil1SLP
	UBOEYlv30CUwf+s1rIi98iY5ZzVFXHrAfalD2oxGULYrVVhv0nSRQUd+ol2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986692; x=1717073092; bh=qiGltB2fm8TXHjNSghWQAQaQrY9U
	h1HE4fGM/kuIT30=; b=nUs+BAAdRNqbfd5hS21OuU59/akQ82zPhundQ5AjAj/0
	VqQYJ/mpZUPtDDkX6N3l42bzF8H4OosEL7GClXMofm2OkEblomodInRQuWc8P3lo
	Fj+mKM5KC6lElMzhsXSgwrZ+jqTyX0Xvj3p49IcUL7GdYnxASH5FFb2EE57xoGQs
	9ioo+tnDeZOluOuI4S/ufvQHw9X8v/WZELN8CtDCCexavCipk6/2JHsVO21hgJav
	pkGuaQKVQOFnAUpC1FkDPsaSoFmfdE0uF9MxqbfZcVosasY8/fx1ApNPmLbvOIAB
	KsT75ZcHz0xxpJczNg1aVqs6vP1jsdG2yCD2YTWguA==
X-ME-Sender: <xms:RCNXZhjS3uBisXjziFJd2sVT54ykhOFXQBya23EhLzNyx63ocOy4Jw>
    <xme:RCNXZmAgt7VvHYd_W0E5gnj4D5RlPGUxL0Bi54k7LYV_pizs9K7Fh3FpUz12H3WWz
    q-DshPj7HQKuyVrEg>
X-ME-Received: <xmr:RCNXZhFh7_UHy-5p4JLtwykTuKmXbeI1kHEJcnM87sQHTzEYfVR3cLn8Xl89zMPHBndrd2kgafyfi_Jgs476WC2cBRb9BG3GpZp3oqYCZX4RCt3L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RCNXZmQGsUY02AqNsIWzblUVoVccaE8-XXeUFmDTkEqc0UJOoXa95g>
    <xmx:RCNXZuxUkf2x3zX9G7s2_xhEbTb0Vwr9H6mymLKoEh3JXdl4IycWUw>
    <xmx:RCNXZs7Mo_vJCjk6CnMAK7Ff0dWi3xwsZoU-rMSG_4fuQxBNzkHlXg>
    <xmx:RCNXZjzZRDPlxjoCnAA-6KOhrY3rz4JCqN1-j8UMTmOxzKNRrMhPMQ>
    <xmx:RCNXZp-TYYr8lOBmYpcmGmTdII2zqgaHzx-5FFuQZOd-bwbev7m-Vw6K>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 67372ce4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:37 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 10/19] parse-options: cast long name for OPTION_ALIAS
Message-ID: <c07b27bbb44cc62f8dc805a523da66c0260955b6.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+XKyrfwEXPjpHcE+"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--+XKyrfwEXPjpHcE+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We assign the long name for OPTION_ALIAS options to a non-constant value
field. We know that the variable will never be written to, but this will
cause warnings once we enable `-Wwrite-strings`.

Cast away the constness to be prepared for this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index bd62e20268..ae15342390 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -355,7 +355,7 @@ struct option {
 	.type =3D OPTION_ALIAS, \
 	.short_name =3D (s), \
 	.long_name =3D (l), \
-	.value =3D (source_long_name), \
+	.value =3D (char *)(source_long_name), \
 }
=20
 #define OPT_SUBCOMMAND_F(l, v, fn, f) { \
--=20
2.45.1.313.g3a57aa566a.dirty


--+XKyrfwEXPjpHcE+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI0AACgkQVbJhu7ck
PpRFGg/+IvPifvmp6QS3IlRiI+caQ7tG/qamep1cdLBDxGf6WKU5rSLNBAczMnNG
ZCDm/Ms+29O7DqCjtwQVESk35pLD6phzVAmBnYssOkx6K+AlKK2PfTg4vkhmLqwz
FpzMXmn4Uet7zYu/2BwZtHkir4H1B8Nlh3RVUvFsHsKQRJdGKlkcwchOqgfpt85h
JsG/2wmtd4UxTMib1rZbQY/0N5sR5EkCqpUhxGk6DAZpvUlRD3dzgl+svh2Lri6+
ut15Y586aZY1veQk6GyG18Av0oIPsvD3qWgqg+zLyMvg+GdyUdd+67JZ6zERN6Og
CKimX67aqD2g/5+KjU4z5v8PETSgFw1z4KVKR9S+jhrB8HOWQtQMiBiKaKqtaGQX
ReKAcvQg9pkczsTdIUNAGp2/Io98KZ8D4TwfIJiGQmxBRd6dGZL6VeBiNfuQ6Af+
2cYa18NKTHmFIBHKQjVctYmxF49sRcg7scAYK3eTKyJpK7dVJ6CdYh2QYRBNVQyr
l6/u5YL/9/d+/DIaTQz9XsQJZH0fVFS4wDwJpfhgDa4yHldPzHQNZUrR84xYmmvZ
lkFFjxQeNFPS+mCr9mffAObW+P6/yP6PL66tOldAKPeV+6DxEEc57AnJjZ9D6clX
EiLtTW6c0+0BuCMcMxnVyIBHdqZu2Km+r/LtrjcCJ3xbizGm2r8=
=ltTw
-----END PGP SIGNATURE-----

--+XKyrfwEXPjpHcE+--
