Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94B6192B60
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324284; cv=none; b=bIXb3Ch8Fvr/qiwMw4u0FGJpgWR1ZqD6g6essf261h/2p6bF4lfIHFgkl6WROTv1bQ+jaWIQdUpeDh75F7gfnGcdD2MQGLe4qFAR3cFFviN6CESVMrgI2bCgSxxFjmcONUukg8L+1WLz6im/lpd9PosbeUZn6Kiq5PbJSnCUe4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324284; c=relaxed/simple;
	bh=OjjXKcWjboBDwCwS5+M6OsYMG3y361Le7AVNbWjxZSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QedCbcE6eijkJsxQmfMRy5cOmI78bUdcOHTmNbpKXs+AH2csoG3NxcJtApTr8wi52EBKq9bhmvG1ttxOLFkPKJ3PUhDOgxCHNvVZLYgRysP7bWRjS6DloRLtcec7h/6DXWuEKELFY6NTr5vw0OwdPPepgIh0agkqBuQyiP3MDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qc/q+Ntg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lyiAuCyU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qc/q+Ntg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lyiAuCyU"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B371C1140473;
	Tue, 30 Jul 2024 03:24:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Jul 2024 03:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324281; x=1722410681; bh=1vaRnmch/F
	DoeRVASHvedFndINirE+AxeAF13C0T2Pc=; b=qc/q+Ntg80l2Kv1WimwECPfZc6
	UW2Qmd1s1DPh/f7jIwxvvSEU/GbOyOGC2tyrVM6Czb1xv+W0GYWR273k1/8Ww6e0
	PDrzigeqX7ltWKVDgTAJKsCC4u8EB+f9gOs3HxrtHSxhnDO3DHKtaWRipvMgkI4C
	bCwj7TeuQ6Glmlkur+I/esUO1qn3n4cc76lLE0ozeHrJ8TDsUPRYHvTkLkg/P62C
	NrqHtELQ5uQpHEOEdPMfJjsyM67tagybLw9HLx2NOvMtQbQSrsuXPm8WP0JG/TcZ
	LzySlOrLi2Z2i55Q2v8rZsqwXBp0CF8ptwk9T1MgbEMvFkvQVwAOUgtZoUxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324281; x=1722410681; bh=1vaRnmch/FDoeRVASHvedFndINir
	E+AxeAF13C0T2Pc=; b=lyiAuCyUuTb9a28S0gKpjabUYLu3NHMcmnlmHTMhgOY5
	qdOgQIWlb65fLIu8Ch3Zb6IHeCcBzkDcR4ZQuSKzCgKlbG7blCnj8suyacO8YSnr
	SRhC1immnlqjRfRVlNtRWnPaM1nPgSte3VP533iiViCSXH/J2OmlelNN0n3fYhYD
	H0toN1fKfSKuiB3el5ecGjVtmfpBYDmcRxl8c7Lflw2z01O32UzBAdEEhvigL+H1
	GlSIl3BXkP/5jBb9/pAQsZZdAZd25n8h02Xj8e7ghmPZfDEYwq3Pd7CvM/6nK5Jh
	urCgDH+j9SIypL9GsCnPgKg0Ib5gWrfIm7LZ+Bsqcw==
X-ME-Sender: <xms:OZWoZvhmpnl03E7dey0-pQRehoT_tH3noNj7OnOc6YiZQ2Se7zUzLg>
    <xme:OZWoZsDD8pDToSxyfob6ZA6iC_WpSll4hopMZEOqBnJkHloC3qNd89XfSMTR5dPrX
    l0yQVBrgsxFOZKOXg>
X-ME-Received: <xmr:OZWoZvEwnL_ugX28kupl-HieO5hcNFj4Vyul7xt0uG1oQMIGhPSFoeVUOdAAprU0jLwIRPJr-TD5totE3eCOXTzYFatEq2lx5cm1hS_thVT7YnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:OZWoZsTIiEpjnVFyPGPrZAlG9sA1uCtv8jJkhm6YvVp46GBPMatjcw>
    <xmx:OZWoZsxXkenyqnK8q1uqJihQzl9QRrJ7Nl0ri4SLxfv0LkPPSj_lVA>
    <xmx:OZWoZi5GumCCstBMKu5Ka4jkZ3dLaddDE3_JsU04zFejMfJlZKCZ7Q>
    <xmx:OZWoZhzHYpOOX5qvL0KqBBrjNSyU6de2ubsT6yDQLg8aXEI4SuKvYQ>
    <xmx:OZWoZmudY9miOLyFSHfs6HZiYB7i_Y49NZbPaAXSSla_bhQhalbSzpvt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 085e4b6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:13 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/5] Documentation: clarify indentation style for C
 preprocessor directives
Message-ID: <e3baf012344df07a464dba997e8e32f521c8c195.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
 <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYcMbNBIBZzIBEu3"
Content-Disposition: inline
In-Reply-To: <cover.1722323818.git.ps@pks.im>


--fYcMbNBIBZzIBEu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the preceding commit, we have settled on using a single space per
nesting level to indent preprocessor directives. Clarify our coding
guidelines accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 1d92b2da03..65fba3b810 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -214,6 +214,16 @@ For C programs:
  - We use tabs to indent, and interpret tabs as taking up to
    8 spaces.
=20
+ - Nested C preprocessor directives are indented after the hash by one
+   space per nesting level.
+
+	#if FOO
+	# include <foo.h>
+	# if BAR
+	#  include <bar.h>
+	# endif
+	#endif
+
  - We try to keep to at most 80 characters per line.
=20
  - As a Git developer we assume you have a reasonably modern compiler
--=20
2.46.0.dirty


--fYcMbNBIBZzIBEu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolTUACgkQVbJhu7ck
PpQvLBAAg8A+KPIFJaiGD3tMX8cDLtjY0Fv+OnDEmrzgSZ62fjH24v3oysUhMfeo
Q8nuxxFugnxvwmrdgGdzg/07rBU7OTf4vBNG4K4b3C4MHz60Oom5vE93CZ0C17Qr
Oex26I6KZnpdNFKz3TeIc37hNXKkvAtoOrgO+VfKunR7eF1tfNgOzpMU5hiVmr70
1ydNtFm94IiKkL7d+YN5IHIUY+Xpoo26/csgwzIfFgFiTrRLBO8FO+KzrO7N4KDC
njQc2S1+sa9ZLmPxWCuyZRSpN4YODj4xZNAxbjPzKeUxXdF5UvSmU0gz3AaKK51r
IXc9iRPS+fBq0YDzOj4fN3ZlDpaKPtVLDrcMl1lOCARBbwZdKxxiVqy810qKcp2R
ly7jy6aExqcyhyo1ocfc54HCq/+H1rhEio72buro3RrtpiKBWU+N5LFhhDl3muN3
jhVLMdupg8fOti0e3dUmEhnmKO6UzbW9Nn9XguLM4BBjqhKcS9K/8x/dLgSYfcZl
Ek87o6+Oc8nM4BMNZy6TmPdqpCUZ2gfkzo8Mgu/ZFbcXD7aQ8zg4NV5NuvWAdi40
yo3qHiCYfI64sWUqBDFlpGBi250YUCt4ndXv8BX2CoHhRLF6wFlsT+V8UcOK9Qv2
VW0h6F9nMQIs0cPbEbwTuqgzOML+PCYGyv41VjaRvvU2c6INnVY=
=RvN4
-----END PGP SIGNATURE-----

--fYcMbNBIBZzIBEu3--
