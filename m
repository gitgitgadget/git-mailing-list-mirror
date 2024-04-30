Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034E213D277
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479995; cv=none; b=UotikhaOOt7FV6bIkzBstzZctnAnW2EANcpL70mj3UdpB0mNaL896SqImaTTK5ClhnPaHJ42t5DeNEWQuw9V5gsT16FjFPbPeVsWhLKXWOx6Fx+N7eeDhuYo1vqmSK074EezIrgponh21ciItkTUEpMnZKsNX2+42+ijTiv+UEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479995; c=relaxed/simple;
	bh=tq3mLeNrhVCWcuLC525FGp/kFUNkyrlBuHaYFTt3VCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G384V5G+uepTH/vaotzf5l1x+WXyqlENU76E20hSU7Dt5MVonjW0rPt0uxn5xbTMBjnqj/urNQZZ/o5EZFKP+JIFwzpLwuMGv0WbDhojgTpmU9LZoWC7hm7HW6XvGE1mshe9+4lfNsRv+a08RYs95iaxjfuzOnp20q2gPYio8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q735llZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1HR9ZvE; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q735llZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1HR9ZvE"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id F04C11C00115;
	Tue, 30 Apr 2024 08:26:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479992; x=1714566392; bh=XLdzags/+s
	iFmpsiVhwTlS2WZBb53gphYvLEbhJcx7c=; b=Q735llZrECiNxmfRNE27riiZml
	laZNJ15n7BYPELM55qLCzEEMkTl8seoS56x5nU7T9CrQ4mw4WHktPUID56GybC47
	aZ6mZVhtkwnGFKX8Zv6+dp3v4DZZXMGsnS2BEvK6wrv30L/2YPAsqQcWL+y4IuDG
	TWGPwLC//l4aROBATtDckZzCa/O4w5UY1Loge1cX3rSHa2ExQ1aYIGmWA6Pstmz2
	42TS9S5WYfKnpk1/NKxz0revKvIa1GEBxZo7hS28GeXyZkPwn/p/JjbbgJQLnF62
	Iq+OBEJ7d8YcwuzSqzCaZxlWA2Xk/MRTUF5+kGhQThnY8sE4KL8lvgMRX31Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479992; x=1714566392; bh=XLdzags/+siFmpsiVhwTlS2WZBb5
	3gphYvLEbhJcx7c=; b=O1HR9ZvEVQsGQUjW2IZ4yVdz+WFka2pF6LMLipfYKRVe
	/IfdkReLDUXRSMsXEsQ83LF8jk9gB0soyUw0yEgQl09qJcAGH/RneH7WaA44rhas
	JPh5tcBrzYESzQN2tG9HJCbTs5x4ZHkCaWgSy4yl/0+8JC83JBvpdu0yCY+Csohm
	18qTa9FZ+E7WDgue5WK7R4SLtCurbcU9XoMVdFEme1rri+uxyth1KcLXxChCu/LD
	0gR1ua6Jg+Hnf7hm2+JGcrsc9p9f4lkrlcjmuNaiG8B4YZgBgiTbNyaz1Ufn866C
	/yWrTU05UazhbITzeL4LFLF04+nc00pHC1HLnBpYSQ==
X-ME-Sender: <xms:eOMwZsPc1R2HZGAM-obOZlfQFzFcD9OrETfL24Xyr_QwI6T_rB8WVQ>
    <xme:eOMwZi9NIL5EQTlkCRG2kwVq2WqwdoLuQik4fABogsjIBtXFbLqRggSl1QG2q_okG
    B0n4Ooko_fZaqTy_A>
X-ME-Received: <xmr:eOMwZjRvzdkiT5goqX2V815Z42gimivdmF4UIAospBhq7UOrsq737QZq-X3o89aAYEJmlIkApRbU6VWheCNEJdzSg7spZd7FMDzuLxu0qt8LZinp6kPj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eOMwZkt9NC8q3bz2J428wbLqi0hDBGbQhDzhHJF0WK0L2OdhQOsNiw>
    <xmx:eOMwZkd_UglJWIBUDe98_vrFXNhnqcoWC6Rl2_v5fZs0yX03EQhmCA>
    <xmx:eOMwZo2X1H5nlHKcaQYh-2bO8Z6nf9g03KYOLBoAQNFY2FMeGqgOgQ>
    <xmx:eOMwZo_GRm8_PMZfDho69LHWmw4gO0PrsgWYWPR361XzOmJrr0Za4Q>
    <xmx:eOMwZsT4zxKIdtO3M-X5-ywn47hEmUI6EDnz8OcvduY4fl1vbMNlvNva>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c6644a2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:08 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/10] Documentation/glossary: clarify limitations of
 pseudorefs
Message-ID: <1f2f8cf3f2cfba65787551ce6571376275ef3a8d.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ZGaszydu6oqca4W"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--0ZGaszydu6oqca4W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Clarify limitations that pseudorefs have:

  - They can be read via git-rev-parse(1) and similar tools.

  - They are not surfaced when iterating through refs, like when using
    git-for-each-ref(1). They are no ref, so iterating through refs
    should not surface them.

  - They cannot be written via git-update-ref(1) and related commands.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index f5c0f49150..13e1aa63ab 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -498,8 +498,8 @@ exclude;;
=20
 [[def_pseudoref]]pseudoref ref::
 	A ref that has different semantics than normal refs. These refs can be
-	accessed via normal Git commands but may not behave the same as a
-	normal ref in some cases.
+	read via normal Git commands, but cannot be written to by commands like
+	linkgit:git-update-ref[1].
 +
 The following pseudorefs are known to Git:
=20
--=20
2.45.0


--0ZGaszydu6oqca4W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw43MACgkQVbJhu7ck
PpTMYQ/8DVW14lwaxvEjNBpwpRLMclYdGvG84r/F8eE/eTKwwobB+xPkFg44wxsn
r0vvKFHCh1IyWmYb25YZwUe+6KgexTnMdhpoqAfM2iR1zrnD7lngSlg3VY2BiNtA
cR0OzVFLC0cvpenbfskttonl8ddt04NErLIlXICZdNCqo1lZc2UyfcUh7cE31eXt
UiZwAlr1e2yz1aXKlbIew6A0u/zya/adAm5bjVyZrZ1sp2ZcFVRJqHY8/rxza8sO
DphMk/jqjcvT3BgAmzbwcw4uBcto0Z9V70kY/CVj1ovB4hZOvwExpxmb2wAB4aq0
LgXAOMwydQoHu/Nd8gkIWBmjVF1kGt6uiTg3s6KnykNxKkIOISFkvI4ggQjE3YI/
4VufdqlP+sP2EQpspJS3DXtwIOrCuapWC+XOiKYlm2RSEGbi+uoVH1hLPGXmUlTM
6Pj5RoIkbPHmQAIWrswJHc24ZXU2LOpEe/u+O2iz8impoNigMpczeiMRI6rgJDOx
jNpxe2M9wshIf0oIWJ/+gtqFYP4H6auxjno5a5ZNDCbWnpgDDXxpTBPmY3Gcn0cr
lDGm8aFRBbYeQoj1l7/772JL8MA4osBrViZ82NGOBOoU2ra9qbuBpciv2rvR6eVJ
28U/OOEBxEyhpF4HTi/3HGpj71/7PJ4A8kyl6e8isyxNT4WOYLA=
=5Jpv
-----END PGP SIGNATURE-----

--0ZGaszydu6oqca4W--
