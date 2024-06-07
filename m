Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE329CE1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742335; cv=none; b=Wsh9PVV6SeckrW/USP12RogYj1F8D9fTGLEA7Jz3pHnaRl/Ut4sR7+gtrMVRGTnQQA1QPW6FGxyeo7qXN+poaGkREUANE/7o8GeF1jzIpXd+Vw6y5rguPLNj0KYkjj6t2GRRVfyEpdFoAS5QCjuuvmdyaoPUMA50AbNvz2byQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742335; c=relaxed/simple;
	bh=2HYaNaynDbA3aDbuHTpmf9Bday8cWZjSO0wXnX3Rzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5+pt146VoyoJMOf+sTf/sZy5ojcVZlrKlpJYaOee6yYZ40veyg3eqGYaqqtzs3nKkkB2BJhJhGrEu2IwbSX3huQThvQQ+6yntQkloAMVlaEMa0NAXdb32s4M1l0I2p6wYP0F9PnJ/OQG76uDnjYI7usC6fJ6F+kSFsxQmysIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K7l8dj+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PFQCj9o8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K7l8dj+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PFQCj9o8"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2AEE311401F6;
	Fri,  7 Jun 2024 02:38:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 07 Jun 2024 02:38:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742333; x=1717828733; bh=We62imLdwE
	zyTkpXQ/eG0PSRRieV0FSWoCV1JPWpvs8=; b=K7l8dj+pznpAppDq4rw0LX03HM
	e//d7b13/JbMn8w7jeHwlirruXdxaK6qKxvygMsOGYvJetQW51yOFaSAOOG0qAQf
	l4zqe7Kf2AlrXqKkmevzySBXlqXsY74pklE1f8R3Hu5y8muhXhOuUaM4mFbQWjk/
	cnpid5HQtVSUAB1FeNw5NQrhBHTBiQCTkZUkxntydqWyM/+oByw8EekQCGjg8ugK
	Ht7ymrgE3OMx6EXxX1XM2YMUW2J9ZDXghZlBOtAsYBogmy0uKSK/EBRvfRYt12Ox
	cyLV8dCD0d1MuLr2Jfsyx0v3GNrlXhWB1AancAOISOuV7KTh1fCYEJrHQ8iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742333; x=1717828733; bh=We62imLdwEzyTkpXQ/eG0PSRRieV
	0FSWoCV1JPWpvs8=; b=PFQCj9o82MKXbb6FTQWQkEPf3AszPeBCcj95qFMQXATo
	Gh9bnWUGnqqFB3SUz9+nM8hDU8Trls8688pJvbvEJ/CXlpNY/6N0prkkgKiMt82E
	LAK5LFRaqkHJQsdL3FkBEMK/aXK8GH5l73SvCrxYgxi8ncWwWmEihd1gsKYEc85m
	+8NngTfsrZOnfjsUwwntb+V08qc3F9CLehYgtC4wZnlBWZLgvxohVDOEt2GswSC+
	WUZypu5ogzBJHs7mdTZMIQAKO0qgBruVdQz6o8GWrd1egKfdefq2uo8rJO0bctRe
	3jaeuT3Ox9n81QYx1jXHYaYWE4U8Pr4zISk+eVwi7A==
X-ME-Sender: <xms:_KpiZkYJP5ZdU8dZdEgxJmkP-TUQar7PvjKGRdBLdPpztzgIPhZrrw>
    <xme:_KpiZvbyqSNKy2z7_BlRSU46g2C-GmuCjIpnci4RNRiRpnn1s9OBAvbEUgZ1czf7Y
    AjGL-oE6VWUCzEmqw>
X-ME-Received: <xmr:_KpiZu_OzSVb2ZgHTGR9BhWyEJY1FQz3sHWVXQZ8-W2rrMsOti115iTIdvknLx-w45hjVRgkZtpw6U-eFmFGtGw-A_9jpQRkVZTYjmX_sboSQrb2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:_KpiZupBw0thR-rH4m5FEGWWbz5p-5Hj6SkOicxeu43X9IU59cUveA>
    <xmx:_apiZvoQV5t7LL8oxz2intqkuKJHoMSFJzzXD8HSkfoYhYosz_wQbw>
    <xmx:_apiZsRysVCOgCKHXldwK_1xa-wTJioWugAtNuXsWGu7-3vgHluibg>
    <xmx:_apiZvqG9_9kvFQaVs03ZI8noESP-L2Mv5TjS7h-cXwu3ufvixtsFw>
    <xmx:_apiZgk70dgh02iTTp88WOx9T2U8i5YhzABjglLOfsv-7oCqdAi_huds>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1bffac77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:50 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 16/27] http: do not assign string constant to non-const
 field
Message-ID: <71c83468f1f654e79877616bcaf471fb192a2b27.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nEAjZxhOV1uI5770"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--nEAjZxhOV1uI5770
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `write_accept_language()`, we put all acceptable languages into an
array. While all entries in that array are allocated strings, the final
entry in that array is a string constant. This is fine because we
explicitly skip over the last entry when freeing the array, but will
cause warnings once we enable `-Wwrite-strings`.

Adapt the code to also allocate the final entry.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/http.c b/http.c
index 67cc47d28f..2dea2d03da 100644
--- a/http.c
+++ b/http.c
@@ -1974,7 +1974,7 @@ static void write_accept_language(struct strbuf *buf)
=20
 		/* add '*' */
 		REALLOC_ARRAY(language_tags, num_langs + 1);
-		language_tags[num_langs++] =3D "*"; /* it's OK; this won't be freed */
+		language_tags[num_langs++] =3D xstrdup("*");
=20
 		/* compute decimal_places */
 		for (max_q =3D 1, decimal_places =3D 0;
@@ -2004,8 +2004,7 @@ static void write_accept_language(struct strbuf *buf)
 		}
 	}
=20
-	/* free language tags -- last one is a static '*' */
-	for (i =3D 0; i < num_langs - 1; i++)
+	for (i =3D 0; i < num_langs; i++)
 		free(language_tags[i]);
 	free(language_tags);
 }
--=20
2.45.2.436.gcd77e87115.dirty


--nEAjZxhOV1uI5770
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqvgACgkQVbJhu7ck
PpRsxA//SMalxeAOM7ykvLBnL81OPPgXeV2wJbR58hC3WAjoUM/oCltIdRwjCX5y
Kn6m+SdidZ1MZRQ2FcHzB0verRs4Qy80KXec7JbXJIdvnrFpBpa7HlelD3POZxqD
RHZce8MzouNV7P+Xe+ZvDxYxc+odolEqPdpROI8jDdESN8U70pxw/LxRme+ePp8Q
W41Y6hloqNuXN6t95KaHO8yAAC/64e3+HnzYda2r7xXJHoWuYLYUs/HAic2vNZOg
8PEgOsFnPzPAd13a/yzmgTdZ8LpPVdpZtWWVdEV2Gt3oi1tv0PQ3qJMwc7ssLUMq
6eKyvTv5Jiaf7gHNTPFoxTky0T0RztuAKCFqGEHqSstdh/pWbLcX6xziyXGsdpCY
3Ou4Qjia1hHa6qMr6dzQnwDtkpxBMplOEHBsl8HGRZWM0nd9X7+IuuPbWE4pwBek
pYMkHspfPoZhaot0nwdk8uCEUWWnQKu4l8w+NIofuEjMEZfLHo/xb8SSNkKVt2kb
nFMwxNW+oTf1Wrg0Qw3m2ske/tt7OEHHi0wXpADluuqRGDbqKeYMWgxB0ATyMAjG
fqQfC0dp09i+m69dUfQRd9Gymhy02F5YOdUr+n7wNAM92qdaBp6Ze5NhpGxF+kpF
K5LnV6LwsTrVq5UFIfV1hbdykvL/bajvIvauuZPrnlOMOFjLfkk=
=CHTe
-----END PGP SIGNATURE-----

--nEAjZxhOV1uI5770--
