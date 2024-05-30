Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB316FF26
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073464; cv=none; b=D3d8gYw6NB2DrBK6/7dkRUF8Yp1TFpn+Y5iYrTb2e5pLFWRO69+lKCP3CDnJLlGbNRTnMSSnjExe5+px6z/JJFbqlh9QzziA2pHICQzNUp5YfzK/2alLwhZyQHTT4Qub023kj/ZMi7rTnti0m3ussz/bqEl9Pd8RFi+NxdTxpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073464; c=relaxed/simple;
	bh=YjnPR//gUwTDMcLUh9J5uvmKK6a5Vvb4uk+f2sk+0MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyQS0k5WrATGXF8sAy4+P4B5wa99b1IQczMFN6osRyH25ZBk//9SeLLaGVWzo6dlgeBwfg/0/B3e2ULHGKmEAdyfmZHg9Rws3J7dUKMIM+tcxCzVa4MktGXW5F8u32R7kOPPl5buYNUR6mRlRuBrYaZiytPZ2Sc7iUPM+yVD/QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T+vKL4cf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ykn2m/QN; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T+vKL4cf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ykn2m/QN"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 57B2B1140153;
	Thu, 30 May 2024 08:51:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 30 May 2024 08:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073462; x=1717159862; bh=d00xM7BYnB
	23WsryHd7RCDVIRPj6lQO3D3j/Nzjv6uE=; b=T+vKL4cfSp6mD0A61tjOt9BmNh
	0D4+tGV/i+nbwOcw3MqkUjru0VbTiiHDsFFy5Fra4kZrd+y+v9cKqKi2vBpByyxG
	gPTlEn9vcED9hmZpqxEGT+0ajUg80qRPNTM9i4Wb0qb8CCPsYaC0RLsRzX2gEOq+
	7ZXB/ElDnU4eOYnH5LnZM9tCgnQrVJB24eYMWRsiDvRJpOhtujnOU23BW19h9eyw
	+WFqDHG98Slnk77GroTISMxe7AH0NXGbpAdOdgJqyh3DkVrNw/5RSRamapc7Y2iw
	Iw/kvT+OfZRifAjraUb3LrPGZeV+3uS1PrGf5WQayzu5BIJGzrsnDEdmLGIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073462; x=1717159862; bh=d00xM7BYnB23WsryHd7RCDVIRPj6
	lQO3D3j/Nzjv6uE=; b=Ykn2m/QNYRlEPx7Fnxuw0O15Cm8SBp2nf1fj5k+/XYqu
	2ns/l6UHwTB7+xpMNfuzwFrl+PBDUMpj4yTePnQ+GlzRHjiSoYTryPWwQ1t24bC0
	+RAT2hKVXOfJUm2VPXVlVbSCDmfmmKaAmTBZT2DcLbdEzxwYGoxu2Ux+m+5p+pdf
	MbitM7QCBG8lK8eCn0TC3lvgXRnEI739FAy/HtNh6OOfX24JEyjpMTTyxXPpCJNe
	7hX1/eqvkvkV6RLmhBSsVuMOU6fg6Uyv3u//vzAxXslYsxSfl6agPWWJYw53aOpR
	taHgCFlvN+Snx9Q3P1u4HCEYoHnU7+OnISwlz/2YDA==
X-ME-Sender: <xms:NnZYZphVCn5KK8O9U81RgHbDKAGWUsGIUJWsclD4_vOMSExpf0oKgQ>
    <xme:NnZYZuAdY_Nx9UQoXxpxlRyXHfecyMtBA-5nvZXyLb7jjCyLClge5l4DJfu-vXpa0
    zcYY0DRoDX_BEcekw>
X-ME-Received: <xmr:NnZYZpFQ62_3W955VyqZUbo9CZGPrBTo74j9FUV5R1_jEzcxT4zbjjfj6zTsJsoLJ8WMDhG43eqVUZrr9uQB3EiJOHAZFKyCBLp27ywX5SbNK0jUow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NnZYZuT_Ilpi_UKqI9slh5PtNQeRwaEaqsY4HvYkVW-BQQMgFWS8dA>
    <xmx:NnZYZmyQQa3fDBnhWMAG6N61nsTYc0wsaG0wJPAJgplnHvdM4QdlpA>
    <xmx:NnZYZk4iIvnrq2XYj-pvMLtV8Dl-8BtViWchtl5v0PeIxoDGaJRlLg>
    <xmx:NnZYZrxA4HQDbSTjtSBUuxFXOKen8dR5JM-66WH-LcaYz95DL2N-YQ>
    <xmx:NnZYZq9Do539aWPgmkZZEs0EAx9vbum_Uma7hVM9HSW7maMLNzVyowit>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b7723961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:45 +0000 (UTC)
Date: Thu, 30 May 2024 14:50:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/19] http: do not assign string constant to non-const
 field
Message-ID: <6da87a09056f9394387c61882586010976d07bf5.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WaJxQu4K+As1w7LC"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--WaJxQu4K+As1w7LC
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
2.45.1.313.g3a57aa566a.dirty


--WaJxQu4K+As1w7LC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdjIACgkQVbJhu7ck
PpRmixAAqrHJsLKV9xSOxeM+mvWuJM7clNoEb2bbL+q+q8/85lGmclyAfMbjMQa0
TyxtVFDkH2/YXeZ0EMoJUsFQR0K3Qvpmty6ZlXoXhRsEuWD+dZhSROjqXYm+eV5G
c+P7BJ8R1At2fdF2ic1JjZ2jeo3y8wYUZsCiiYJwFpjZbaaGO8W3AFMjHzEly9wQ
K6mqgAeh52lTJ9J41V9kPFeI91ELyyLjrj0fGEK0XgGxF+604Wcft4eBZwdOVidq
HnkrGQIXPKrHptEvez/f0uGPr5y7M49QP5rK/mQHntX+PsikAt3tmht2jBhZGKHa
PTlLrkKh9mVEEHFuA4OZlXxnhKaC68mem4g0/nPGa/gTPqKabZ1XLpVp5nyoL/9z
9DB7Y0yB4UgvDsF33nmuwVAlcKb7wMmVtABQEMMdEMXDRfxkU7O/KzCRQQ8yIJOQ
sIu0c/nJIwbsHhQS0MNoFcsnP4iuRHlRmmVjqAdes1LuZIPrOUAHZDseiJaUbwPb
Z4Pt+WTB+PGoR8a/yr1AnB0InD+WuNuWTVXrLphcg8M5bRapobHUnBOIrMhet6Hl
540zVeQEQqBPTQ5nPypbwGLygLvItaF1q+3WOJvNn0x/HLJIFc3xmzx7MNLS8lrd
wUNx3hGtYwUsODOdKf6rDAzdtSYTrHJqocFB2B+OU00Cbl3clQY=
=MT3c
-----END PGP SIGNATURE-----

--WaJxQu4K+As1w7LC--
