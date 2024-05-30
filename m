Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4D183987
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073479; cv=none; b=Zko+79u++7nzZifCMd1V5RaUM+nGcgQFpvIGz3I0A07xw2EXS/LGAhZBaAjc17xf9wBAWYc1Au3NoODx5R51wvtZaY0Q5mObZ/PAbcdP3cDcuMHJTlSL1p0np5oDxWKQ713bfUf/bPdSuu5+QX3QYS4E2xsy/qTuslXxA0QWx/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073479; c=relaxed/simple;
	bh=7t5oD+MSVT8n9niTDZ1kPJvkw3qfChNWW7h8/6u9kM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLxnhLfmqhhyNpRifozYMoF8/FUxZQ/iDwSIfufkLfXs1oV8GhAi2FtyQYkaVvNTEbUBeWqgdCf3W369WkrVaX9GkSFa9HBB4Wy2Fyi6k4uqIjkpTJm++KPctV8liT41lar5ECE0WcbjWnpVZxPAVj0z0FkIHxhUWw1qDxWaJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oGSuYdLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qTo1MF3J; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oGSuYdLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qTo1MF3J"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1BABD13800E2;
	Thu, 30 May 2024 08:51:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073477; x=1717159877; bh=TgPvfxbiR/
	D4j4JUKVB89o3b29VaMuoR9B97KvbuOrY=; b=oGSuYdLwVAXP6d7clP1zT8PNVa
	5Ev4OlxIgQVsyTeb8lo6dU8GmjQKDkTXi3XS7Km72qjoq5QHIuLO7txJlzOm5o1q
	N9moLkve9lSIq9a8AidLX5Ukm5jNq+GPl5BnlWurvqcKoe7JW4/zq7EBNoxCgdX1
	qbugfOu5cZ6o7L3L/M5QJpCljL5kL3sVwrnMo91k+vsClRD+MqqdRgo/eHj+pOvs
	F4frZVQYgOEv4QeAa8muM49ixExKtB/xxF06cJb4oHf+DkZ2NZRGBQkVFiuCRifd
	c/a5A/DMjBhRSpNZidO79tZqaRFeKi1TNiE3puUYlhYsebzMMlm14Sm0mZ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073477; x=1717159877; bh=TgPvfxbiR/D4j4JUKVB89o3b29Va
	MuoR9B97KvbuOrY=; b=qTo1MF3J2bs9ojdlD1yrIGTPLm0mefEBd7T/DCEq9HP9
	bOydhUQPtsTHPlROQWLOS/z1GH9GUMqLdtmDR4U0PgnrvduFGqpy3bSAUdjeOQqr
	hTlk0y0QlAwaZlNsQsM935UHAUy8X17fH145enREE/8mf4CH4nbf0bJsFYbHtsUx
	MZDpxBk+rr2Pmgum89xfPLc9dajYiO8UtR4y2ZZMCMbWNp2J6HWqK2qdj3mFn9ce
	igTrAHRSN+g3qwhnOk/xIMLv//dRg7MMuMzm+am0xXEobDKMXkAAbhUV63SJxc/5
	ov8YiFR1dhE/XWnZ3LzcpiOeVkDTB0j9X30zCAII2A==
X-ME-Sender: <xms:RHZYZurL08AOE-KjK9GGHDCzkUaZA0N0xlHc4pWQgGtuxubHQ4RGZQ>
    <xme:RHZYZsoqEJMt7znizuyrK-EPi5yWF8IgTePiE4eQ2WUDCOzsDGJv6ERRceTmDBMZq
    tQg87EATS_J26T2gw>
X-ME-Received: <xmr:RHZYZjMM7Llm2sPMOOOhBwwgLOPCNQtC46qp8zXxMdh5OehiunZKa9876031-59KhSxzLdlYQd4uj3PuPfVlOCAa-Ihp0vy2StgqGAhl7CBa5Q327Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:RHZYZt5vXvqYk8tX__En16CE8iQGiR_fUVFV1GhO4PyUd9Q8PUUuVQ>
    <xmx:RHZYZt7ZolPkwNtfCnOV55D2Dr9Z2UkSGbc5oBQyj8MLKRM2IA73sw>
    <xmx:RHZYZtjToskmcoGujl3jjFPSBENnM60MZtXXnLJUbQOfpMdoeWGr8A>
    <xmx:RHZYZn7UZTLW4ImqyAiYOy84XHvxitB57dO-kh67RU9GBBb5KgCfbg>
    <xmx:RXZYZnnccMtiBVcW-yGL0FwVcs5IxyDNlUj9l1OUFfMjduBfb9y4IWAM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a1cb30e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:59 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/19] parse-options: cast long name for OPTION_ALIAS
Message-ID: <dd40c7464d642d16e0d7f84936be1076b99e8a6c.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evz0kMlf8wY8TiD4"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--evz0kMlf8wY8TiD4
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


--evz0kMlf8wY8TiD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdkAACgkQVbJhu7ck
PpQ9Ug/+IBbIIpnZ93EGFUX/0qOi7iCQCqpzzppcuh+qlCSa9aGvEYhoZDrizasY
VaN0tKzknAkJkn/iVJo1+YxJT1yc+saAJ97PRveCvp23qbawgwkbqPQwgd+MiQaX
5Ejjlk7YV3xqiZVtCrZCgRN1h7Z302areQpZ0OPzadaQeah3psAZoDhQIhom+qrH
a7sCei/mqQCvSorFDM5d9z5rEGknNBmfinb8PFcslbEdupRkkiHVPG44T1UkO2SS
WDYPzG6H3wW7jw0jqg2lsKIif5Np7v9ur6z58cit7+PRD4E5adsSjGRWkQcjixXe
+myWVTMW/oDJkaG+G+jrFwH7k9b5b/LYYQqOEp06OuVz3ZEJNQaO8mubhLhCYapv
Ia7OoxxSkiPquE3l5B4DQAliaT3A31vN9F/CLlgmtIrzqMp6LqiuSvi29M8qLjYY
4mJUU4v9FlC3c88IDC179zla1YE0lQnOiFLVZeobbFJ8+bQ15anTshu1qSgCRoQU
5dry6zFBRwxikfrXK2LmIk8hOB5+75Oshpb3V1LytK+Y7O9ClPb6Bf7eUAPx+Vhr
vH+xzfkDDvt4R+ca2nUV1FmEJUAoUBawxOcdebQUZXpLPIcvMe/J9J1ig6tcDYjW
z5aBhqGNoLUL2x2C8qo1S2VxWmgSaN+SHvdi7hhXKsIg8YiJh9o=
=jkNc
-----END PGP SIGNATURE-----

--evz0kMlf8wY8TiD4--
