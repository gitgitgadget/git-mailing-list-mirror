Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF208142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986681; cv=none; b=UNfl23KKdqIqBRdGPtBItJYKlrVcldk3xJ34CNQvgTgZWnA4kQ5IyqHqzvTwba95gb8IcD2VPwg4X0PAvoldheN02PgensuDgBP9xbFkGmMWXUVsgqKMt6kvuneJTqMTsbny/HsJJZp5BD3v0phWc3jAi6d0Yr/mD2G0JzCL2bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986681; c=relaxed/simple;
	bh=wk9CV1AL5ubqpuhU6yIHqAK/CcLGDjIqHfYXRN6e7js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZjjd0zX51h08wqQdmGHOmUG7x7KRmvRVyUqg1mPvrbsnN/Iqvdm5wbR/8di4+gQaLFQ2hFztv6KaTvlhXloDhC6aJpHt2ZFZYKGb9G1SjFCnTaAPn44wUAoLVM94ZCWJf7UpeX4NVJbfa1YjgZsXFBQK44FO0imuSIt7PTuQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c6HY8PRn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nm8z9f+K; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c6HY8PRn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nm8z9f+K"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id DD94A1C00122;
	Wed, 29 May 2024 08:44:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 08:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986678; x=1717073078; bh=hd/KBKn6AZ
	sB4vi2dTE0ZrSeMfGutRFzAZsjfvDfM78=; b=c6HY8PRn1m26fcxYqu2JJdHgn8
	QPAASod8r0tmXQV3KMt4ivCe/NNNSze+F2t48o0xr6yH7jwRTBzWUV86zRUE1sA7
	I5kzYUJEH3MOmYSAtv8sS0pGDepO1sL8EmRp6Mx23LZ0UQBnzyATRR5J1Le7Xp6F
	DRPHGAXadjvrTy9JnPAoTTtRTbr2fzzfuV19qnBsG7+MHr6XfJQEi5FIUh2Nin//
	RAYYP377W8/pxT5AyYkvezw18OJAyG9ot1nuShSs/lfB2EfyOLt0Az1HbwLzVTYo
	fihd1otG7Qk7sqp8Zlhei6+EeSUwYShxgID4c1nXfKDEv77P6fJGck/E5VXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986678; x=1717073078; bh=hd/KBKn6AZsB4vi2dTE0ZrSeMfGu
	tRFzAZsjfvDfM78=; b=nm8z9f+KE8MehYEqrXy/uE7zZFtsrTISEqrPLqvvLWUU
	uxZMXHTs7ac0/H4uydn6mqFzEoKN5BbL5uCTxihniKMXxJ9SqAXEUPiCUbE7dTDi
	iL7WKpyZOgNaW3CArMtT/+GUvk5yYidT0luzl79cnhf58E0fO6bI08mMdhqZg4Pu
	YHSiHPU7JJ6j5OoHUr5uiaT7iRqxX8WwiB9OtQ4VVduzzeysCNPJfWuWn8xpMBhl
	fl4ptdByMgrdalGj1tAqvreA5EXRK/ffx+xGmYfW9SoRCXFKwLuycD6Ulofbhq8z
	RjOesWybBE6ADy0rw9XGvsl6ykUPLhtvqh7QTl0/hA==
X-ME-Sender: <xms:NiNXZnEcl8SZjcT8JwG3JBJUjUSrkROOZfGP9D2fwt6RQgys6tdE5g>
    <xme:NiNXZkW-BvYKp4l3B5mpBByMbQzTjl45UxSOl9uOdZDL-zkb4jlRnvAVClC_k0E5U
    YS4TO9EXYgmrvHVFg>
X-ME-Received: <xmr:NiNXZpJZzQRO_KnA0t6lmTgIgm55MueT3JiflFTsfkki-jzBpaf__09PNezEmhVJBeydjl-e0KfAuZsDQDvRo6RRgRL5NJLzQZ3xQeA36iTZvQew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NiNXZlG7Y_3gOxP1W-AOfHs5j1oIvUPCesKhVXS2MTzJwBTLfoWpHw>
    <xmx:NiNXZtVLsabowishTMRo1tr_5IMACJITcFRxF1I4Bi8kp3SX3tavtA>
    <xmx:NiNXZgNE4WJomLADtjbWEcGnX2xTBwehBlgZKQW0Z1W92tMNc_lCXA>
    <xmx:NiNXZs04Zjz596W3F-w0FqFoxVxZO3PJ22SymC6H9G-YFomXvMyFdw>
    <xmx:NiNXZqgeiJht9t-6D_pJDfhCEzfLk6Uu5x_iuQtZIEk4zFFbhBWZwSjh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c4089cc4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:23 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 07/19] http: do not assign string constant to non-const field
Message-ID: <03b13c449b52ecfc845e8ffb0dd69fe67d50651c.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b4GeHrqwvatGvLa2"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--b4GeHrqwvatGvLa2
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


--b4GeHrqwvatGvLa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIzIACgkQVbJhu7ck
PpQgFRAAoDSyFsbqdX2zEocB556U5LGe87rFmmp7njJrnrBf23sKON4wvfVkTPzw
MLQmnQDbvUx9ybRzS2pQYme710MM+pv/J5hPzvUjIj0z81yaPev9MdHWmPg8ONs4
3Af0bgqSd37HL0BcU2U28gWHJNcaErg7+tw+55ubmfhuIrSXAPSz+CbeXMgTfHaR
kmHpCSFF9jbv5CB3ra7mXPpG1JiMWR7ehZ5GGjl0i3GhJft/haPydvxXg/EJAI7h
o+/yzVmXJmmLPVRLQXZ7SDcoHzHfh5RuVkDxaaVQpyrA9DKXW6hZiAb+b2J+ehEB
u0aRb+RhDxVRoAY5r2F8v2/krIoGtSSzgysrTnTa8m6n5uaz/uzXPJs9wNGzLvv9
Z1RM4EmGpkKGgLUryC5stquw7K5BO8AHGTzCepeaijoEfwE4KMO4lT7WTNCe5SJZ
p+zDkwMRYTgg9vSji+xlHYHrJ5GhpygKM3sG6+8Sy2Vvcm+133jl3hUcdzgWbFtU
r/gbpNZWyY7fYg5Zde+oV5QCu/uftkBd8+/916DXWy32EOkrKPTRT/nK15oWkqVw
jy2Z4BW8C6W8T5DLLTWNHVct7wxviAxgdCzL9pdgX8TWvHOUtfL7snyk0CCftX7t
kQvmYHp40AxwSOOvB8vlvDCA7r8sJB0wFI9+Y8SLovMk0ujVByk=
=smqn
-----END PGP SIGNATURE-----

--b4GeHrqwvatGvLa2--
