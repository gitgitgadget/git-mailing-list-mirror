Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4C145B08
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504697; cv=none; b=rVVD8QYS/82VfMYi4YWfCywAh/VGw8WY2yvP0P/0Q7YdMGJbRxTly0CWhLqBW0rdC/pROuNzmsaZtMmvA0cVzxXr3UdUWIepvl2MWPVgONMRDHDEXir0534n9YpNUnaPhmJWBtpFzM5Cf3IN4iwjGBDez7om8DqKn97YalYuCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504697; c=relaxed/simple;
	bh=wSxDpZA2ln7Cd4vd+DTFcbvVuGIN9U/AIWY3BmQ8KgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtZf93YkDSLCNqrQ0XaOLD3H4davol493BeyaTQKzt5Uxf7Zo4yavtwMXkUIjODfeFo+Mpoan+GP3JIKTMpcB5dPaoV2IlFpT7qNQPH3lG25Kcg38ET4UQP+vWbXaQ9vmP5gapel94rAAB5AefP1DftMrW+/gWjtczu3COqwM5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VeZ9lL58; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QLzW6vEc; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VeZ9lL58";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QLzW6vEc"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9EDA51380159;
	Tue,  4 Jun 2024 08:38:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504695; x=1717591095; bh=VdVsw40YFN
	E7wvKF7q7MNycXv1TKMBX4vnoy0hKPVlY=; b=VeZ9lL589gXAmllckz568wKo8x
	LU9/d3V8EmWqrk8y1hqZ9VGlbcMawyEmBIJAA7M52H5tlafboHyPyElVLUqGFMMn
	fHRpyxG9IlJdpmEas5tYg/aHfImSn4zy0ETzXG4vi+aO0AjBTaxN3l+HEy6s/uUw
	DWpw7Z8f0eLnsc5sZzGFccxRKtF4JL4w2auNtdmxtVTUeR7LhkalXS0cHBvTD3oa
	jlNiLxjf4kMlNdr+gzrq628weI5IPE5N+8B61hxBgjA7GXlIH3D6XOmdOphc64NG
	Y56I20ISjfXu5BWSN2nRSQm0kbJ1WROnowxffCzo3Z3gAZ4O7M17BrHcAHUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504695; x=1717591095; bh=VdVsw40YFNE7wvKF7q7MNycXv1TK
	MBX4vnoy0hKPVlY=; b=QLzW6vEc19TJW1Z/7Q58Q4e+q9wViqbqKYBSHSV3JTGS
	0Ewzc8rue4Haane9/MK/dp5F17PjFhsQRzScAQgvkjQt7pXJZ8Lvk/lps9McHcnz
	vky+yBl7QKPMCuf3gsqRcbffrGwqWkNJM0XnJ2rNLZRE2Rg1Hf9IMunbJR8TW13k
	WQGxYtyMlvqdt8tHFZyq5jvAuZNf3I/jQkOe8HAE8ifGYicXOflje4UdEqXPdh+L
	iCnQVA1tuAPxyjVEHJNRtrQrFLXS1CUbToJ4qerVLLQaDuRY/BmI1GhlqMHboprO
	2lhSwiGQF8TVSYQLtsi+KOW0aPpRCGdsAmSPPryUdQ==
X-ME-Sender: <xms:twpfZvUW3sir3PtTqfT9-1kyQeitnp3R1HOgCSSW099wndEw16DAJw>
    <xme:twpfZnkAAvf2wIr_vIoHOoqhlM4a-Fg9lV2Mtsm41BhG9gDSsr5XSVnf3yzs59pZK
    DjRaplTLFrD9oPbhQ>
X-ME-Received: <xmr:twpfZrZBM00VtaFYPVocAflR9Gz6tyxlC65Rt-QZAEHbBvElFsL-2xfzOoUQ0JLPogJIaIIxKnJp5OPOg6QQm82fZTwhonfx_gscmLVpq1RgThI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:twpfZqXqh5jwNYX8kycwmbJd4LslmcYELP2fjmfdz8lvKi5AwIphlg>
    <xmx:twpfZpnqDrFeVoLxCMPQWQuK6H72XTHzFyGRELstjIb1AfmQ7vy05w>
    <xmx:twpfZnf1ET5J746cwXo7EhxTnsQOvwqQOT4ozDk5nLTOPTGMpSXnFA>
    <xmx:twpfZjH_f35GNb5icLHb-mukspCqxbk3Sfxn38bsC_dodVqBdWMEXw>
    <xmx:twpfZiDjBXSw6H8o3J3v3oypf2XYpl7QrxxnMu_GXispK-jtCvMy8QEW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5ab1b7d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:47 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 17/27] parse-options: cast long name for OPTION_ALIAS
Message-ID: <9d596a07c5e6418948632617d9cdf4a66796bd50.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pIrSfZbktt57yxzg"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--pIrSfZbktt57yxzg
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
2.45.1.410.g58bac47f8e.dirty


--pIrSfZbktt57yxzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCrMACgkQVbJhu7ck
PpTnYhAAqrLOWO4YR7szFZLhw50J/3cF/JoRbybVdvtemjv4DF2GP8VmfHTxqdfM
EZTTDLrnHmnOuiHZeI2hd9ZwTm7jv65Fgj76bRfJqmzG4sLZjqo2nJX8e8ck5GaL
CQUaBwzb/lLcri0wUqFnDZGzhF9ZPlrvrJxXVkbLJHyhwEX6oK6HAE8Zxct16dXn
acFGJUzYY4mLitDFQ9dmpjw/SP/ed7W/2xJrJ2NXNZzlgoOnW3j+AQkxv6tTqW3A
qNFDBybp7ZtXihF/VgP3uMI74qCI1Kv8Opbs7u8gABIuUcYug+g8QGku5NcI5Hyc
qOLoWou9IAjlP2k/VS6/feMCUWq//bngoKPy3B7TA2iLiZjT48E7aO1XyB3aTLoa
YfcItjXrkBWTqxJdZop63Ivued46E/m90I3pZdlbamqz0+2mxARNnOVDLp/Qt8KS
L0J8XG/tB7hKOmjgFNjoXnlOvTxiaKAb98SxwfIeyLl9PxlqhdnliiUqI+h/1iXG
gD1b8yhaM0TaUcvvxZSq9KQT1yfvE+dgV4iTMYhxV8RSg/pqd7Am3an1QH8k9kVn
gDof0rJJ/1Y0BkxaBixfJr2fzs3+cQb7Dao9X8l/GDBvgaOwfoGeEqLNmvGR/OOX
3I44NE+iv5MVuu++WPyoUVVoWu0ex/rKgFkZ1bwqLTc5Ij0DNA8=
=T109
-----END PGP SIGNATURE-----

--pIrSfZbktt57yxzg--
