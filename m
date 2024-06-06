Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F3194C61
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669746; cv=none; b=N15WsSwFovtJAWJtm02fTT8emsLRaOkZx7QqPJJnBtpMSGpeoK2i081Qcqz7EheZBMKJLBRW2zFE5hA6Rfe4ExYtdI7t+jAzoW937rHQ7hqQ1CP8yRuQ9pkNFn3iyUD5EJXxihMAB18fIfeArOJXg3EUfJszN+n8VIDxBUJ0HTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669746; c=relaxed/simple;
	bh=L4btAryBejP0zLSEGgr6813/ApF6OPr4Y6NkJFtCDuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0K2+rh55qQARkm9YWSgpaw8F2ZugGie2iyEnIUcUQEboxaXElyZufM5uG4IXrpOnE5QlytnpddxvCllhDNO8dROFrADI96QmTPoD1eKp3b7pXOFRVs4bU78SaFr8363g34l4mTKSOoaekMadF9R5HEEhcIhEXs3ll1+/VrA7pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8rAHPtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NNIIudUi; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8rAHPtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNIIudUi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5FA8A138014F;
	Thu,  6 Jun 2024 06:29:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669744; x=1717756144; bh=8vAiFMGiLU
	RpqVLjMTEwDChCmXuSTjAnObdrhLgPFYk=; b=H8rAHPtVulHSeTYDsrbwvEb4wY
	fucoDzvW4QB0wv0jNU6gEuCRl4JWZNB24GQivngyc7GT3HAk3a+kHcS+v7PiZQyg
	pp/R+xp6js7b1IFYACVXtx90uvw9iMEdJ568AQ2g/Fo49HmHFiuxLFYenFqWjYfe
	DZYc8TlGTr/R9DTW9rEZ8KmluVwBfejckgdjyPMiXQL008QOLt8XZesiQyAeYDNq
	uFxAwWXo4fCf7iLxZB5JdWOatplFxIHCHQscJQEs73AhxCzx2tWHZ2Lz5PzI6MHh
	jpNjCZbKadd2jp0idSqmDRTvZGBPctuG9hkdZwqQpxwd7ikV/IEn2Ktg1E4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669744; x=1717756144; bh=8vAiFMGiLURpqVLjMTEwDChCmXuS
	TjAnObdrhLgPFYk=; b=NNIIudUiaUVBdXbUo1HRJoWoW+eHmIuGPt1m1c1/2+il
	Mc9zcdDLyWPxFm5dyNDxYf+T+xKWOzvMOQQyxKzV05vewMpv0NhvcMKRRbKzE3Qr
	j1AZdo+o7aIyJJQT82vRsyX0iyDrKOEgmjE2qKjCN05OptUwUCiNiz0WH5VITA4b
	xjmtEH0YHL1zALLWdPrXux/PkAuGU2rBiF7PZNF6ObkFbf2go/e2/y7ZiFnqXirg
	gAC36RWdtkzpykhzOLiSVPe2aHh4lEgZMkqoQESI0oyrjKAw4UlxUsqkr9h4/Rg7
	l8mrG2pmzvFhjPFh2RNGqjSg1CrMEqz0dqaOA1pP5g==
X-ME-Sender: <xms:cI9hZh-HjW2X43On2-KRuyTzPrHjPZ4wulYsuG8DxQzgWYazqo7zpw>
    <xme:cI9hZlt-Moc19BJ3xnY8muq4jh1qozCXibUCLg19CV7IEtfQdsMzU4uNg0qq10WVu
    qruZda7ExTOkopX7Q>
X-ME-Received: <xmr:cI9hZvDmSUtCvbYDeVb-Dwj6NhP1F3IY27GK7rNpYLdHSRfQ3exswAR8mxAe61h9XGaZswW-XJE6-qBhBNo5WCZtDU1TY3_IY3dZTnqVvfU_8yJj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cI9hZldgFr4It-ZIU4YQtoL8LGKs0b175nBNGYXuCxRDqcv86mu_CQ>
    <xmx:cI9hZmPzjIhzNb5VtMjtdgvoOhWBXbqQG-Zv180fzcB6xxBqaJ0vrQ>
    <xmx:cI9hZnkv2YBq7uvWfRGSx6mXrtXH9dLvFKuDXSoZnKX6IYkcTFdrHw>
    <xmx:cI9hZgt-SSE7nQi6sVdXsUsvk383eSvspkZqhyO23by7C19MLNo8qw>
    <xmx:cI9hZjqjSlFFWdg2FagqSTrYMihJZ9d4nGUD9xNd0koE5Ob0ZkSXKJgL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 269d0c13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:32 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 16/27] http: do not assign string constant to non-const
 field
Message-ID: <c80f6eff8c11d689da2ab8731c1d716c69079407.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZbGuGpFzkFLk32Jp"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--ZbGuGpFzkFLk32Jp
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
2.45.2.409.g7b0defb391.dirty


--ZbGuGpFzkFLk32Jp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj2sACgkQVbJhu7ck
PpTgPQ/9EOd8FEI81PszSLlj8PlczDaExM2a0KveQPG/vvfjf4TSnbqnrADKYEtK
CRdY6+iaUD+xQAletHo8pZ4mjK3JWan2w/ZivracfwrWMSTvi65JDDnRFbYhVxPo
QHoZAdc/e56/EFIeXHcu4MudU/4U8pX9nTcDtujkDciRVKSpXInYwaMHAttNtY7X
lM36O7MZ+1EWKhI0gVAtw2A8vWyKHVqeUPBLigx/stUDG8gKJDVJ7dnMDLwYddda
j8Hv+7/BxvdR+JAppf/3JMeU1m/n39EJYkM4pbwxnVHtPehkkJmXeZPIPotLN6s7
gQNN4/OlcRyhgQ2xcDAdSlU2KpBGIlH+Kfap0RIAsIKp7BMFWuS+vAenAJbkAjW9
TTVa8mc+8ovX0o8bwF84AuDpODZ4mJ4huhCKq01+B4B4302akr18NEvAl8yeIimZ
tot68HRnDsRseOa0ZOpxg9JKFsXNUJey5SyRBur9Dr0QfwDZwvTanqMduDfbwVFW
QHSXQ10VRzO7s4+w4/5BdBn4KNM1ApiMpxqYQWt7NlhSxMWmbp943jinvGARw8yB
u6lV5skDSggdU/D3zpHmha9oQ0dTRMYL7VgtJAZD/9uu3Nvf3UYuZrelQX/9u66Q
JWwIvf04TVJyLY47Ns3XxkfLhPbTxaeDIGGXgpRCV2tJxtx8hiY=
=P1d6
-----END PGP SIGNATURE-----

--ZbGuGpFzkFLk32Jp--
