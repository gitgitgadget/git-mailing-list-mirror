Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE40154C11
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850579; cv=none; b=ntzAT95Ir3DRWjdZYRmY9WBxfJX8h9Qj7F1Vw2gwX/T0oeMuG3JFm39aWlpTBh4WQBEOOiPGQGQaT46pt+VYezI7f9Y7aQqVl1Im8NgcSEPAW6QT93VgYqnxejI2GCIs2ojDw2hkGl5x5bqEdrv8p1un4fy17ca9R0NbFiwUXXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850579; c=relaxed/simple;
	bh=xREATDu8b3FclnInvFkwSK8EqPCd5QDgIMJpVcoLY7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLqRY1N/ksTRfSjy/pMu/E8kBpsDP1nhuN8jU28GltGopaBEaULzCzcg0EebL+fMowyZAvQMvU7VDsab9B+IqB2bP/XKS84hFX0WOksQMUZqMXVv3DSbOI+ynW/78XaDbHsoj2/SETWWqmBYSLl7Vv6oVOQNtNpYY/DacrziKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M1qCiypr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhJykvIy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M1qCiypr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhJykvIy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AEDAD1151CAB;
	Mon,  5 Aug 2024 05:36:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Aug 2024 05:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722850576; x=1722936976; bh=RY6FVsJDrd
	MLHgnReZjCnO8lzVZPsSpfpVbvpoI2qdE=; b=M1qCiyprrdNAnI5c4BKdh45KzZ
	A4+COO6djUVle1vCvT10k5WsD4Z3zFPpPZc2aVBybqolwfJAuC1YMjfVHJx24+Uo
	FWwt7Z4BXhXrZCZRCZcwIENbjVQ6QvpaLDRiyxcB2hm6yEZR7+8ApJyQjO+eRzBq
	0TRxIXbEMoDUh4U/muK4YvghYT2UtxhRskqqVcH2jbPpNcSC72NHMZXVNkZm4ytf
	KVgxqUJrQ3miSKW5WAGDeW1DhutsUPxhGfGF7gf5Es5BA6KzMKJBegOcAG3UVn1j
	aAh6ZuSUcTyv3I6AQ0X398Wi5E+Vj1iweNfhSiUiKrV08OCOj1UMLakw8FIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722850576; x=1722936976; bh=RY6FVsJDrdMLHgnReZjCnO8lzVZP
	sSpfpVbvpoI2qdE=; b=JhJykvIyajPVCsi0xpVW+vbrPHOlh5E9+5mxFgYpKOuh
	b+1JvgkORqBZxsY4ESTRrgKiHYJxq1MKRFn+5wCtlybvvkDkXGVkWyUry2nC86A6
	lppGuSjl4+uoP0puh9mhBfOkVnTs31qCg3EbrZrZUjtRPB8U0zb0oo3q77vb3p1S
	zQ0p0oZmMgyv0nTQ8IRVkoOHC4RfVp8ySYsYEsCjYp4V51BYfVrFDPz9pUIYegJP
	nwta3ktqgxYv2kYg6qYw2kmoosOIcf5HNHbFKx++vTMYTabflvyGO5M7/c1FLXPq
	QwbeD+d4ivlMz9RYQ/No72aAs7vjJioZJPkU/HUFYw==
X-ME-Sender: <xms:EJ2wZhgs9AUKwIV0_rKINTwspL1d7nrAABTzOLBvEajNwrSUNv25aA>
    <xme:EJ2wZmByqqbea4X1LaPei_7DE3hmXJ_MiGsk0hit5VdRaoHJfeGO0_M6W71_avdGd
    A4zWpvRabGjDps9VQ>
X-ME-Received: <xmr:EJ2wZhFLNcENBolwToqlWW31B6YgUzGFjObnrmDPB6zj1Emb3ABpiYXSE4VxnjZOOQbxN8yCCyPKnEjs09c_49V5tOk9HArtv4v5o5DrcLKZJxNUyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:EJ2wZmSosVsdIW9klDkZfR2J-it6m8r1ia3eB4DzVLFtL0ghwzMzMQ>
    <xmx:EJ2wZuxOYthD2aei-CRgQPkdPZZsU1aKhIU9jYPEmA6KITRKHK0EXA>
    <xmx:EJ2wZs4-Ol-CFb0lGGAPkqwlffJmfLqNn9-UW9xL9I9EoPPM-iCTTA>
    <xmx:EJ2wZjxjv9xBpEK0VZ1wlsXTNvvs9TswccQ8_cd1BKgK22DbNq340Q>
    <xmx:EJ2wZp_Nl6yryiUNMZ1-o2z1gri4ewfV3FofTgrLrZSRD_xwxycQyKIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 05:36:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d19c42f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 09:36:14 +0000 (UTC)
Date: Mon, 5 Aug 2024 11:36:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 1/6] [Newcomer] t7004-tag: redirection operator
Message-ID: <ZrCdDHqKfwWbr_Zn@tanuki>
References: <20240804071137.30326-1-abdobngad@gmail.com>
 <20240804071137.30326-2-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VowwCrHTVB7zyE8h"
Content-Disposition: inline
In-Reply-To: <20240804071137.30326-2-abdobngad@gmail.com>


--VowwCrHTVB7zyE8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 04, 2024 at 10:11:32AM +0300, AbdAlRahman Gad wrote:
> Modernaize 't7004-tag.sh' by removing whitespace

s/Modernaize/Modernize.=20

> after the redirect operators.

Also, please note that we typically wrap commit messages after 72
characters.

It would also be helpful to make the commit subject a bit more
informative. Right now you only say "redirection operation", which
doesn't really give the reader much of a clue what the commit does to
those. Better would be something like

    t7004: remove space after redirect operator

This gives the reader a much better signal of what the patch does.

Patrick

--VowwCrHTVB7zyE8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawnQsACgkQVbJhu7ck
PpSjww//RMp4pWYYV6+J8d1NEh0aD81y3SqBMybnczgHVWd4SLqKK3ivTl2LQGD8
DGpK1DDpzh2w7RWXDw7DDzMugRH2TNJV9RArboLewc0BYEV92ryapvMDxY6hYByc
8fPM78LfvYwkcktu0XDM8Obc3kukA0V0cZC4FK9C0sZtBDt3LPyjXfqXrRLLAr3t
PMZhih2+h2Q2U8bsPhlnNxtzHcny6PNWkTolW6lsZmG5gA4VpX4OnQ8SszPtUxcF
E2ukT0UfDKB7/vNti4pkXfeTUXWOn5hHcS2fCOp2SiF/Ilc6A/UpJTEhOip9efVk
L/i5I3oc4mpl5YKkNRjX89SDpQdO4PmGbCYtDWkOt9U2x/2gzO77FKv0vfrCQtn0
p43oM5rE7tTZBJYvOOER7SpNwM9In6WbFQjvanILG1JmQgTT1GvAiS92Sh/t/PTS
olDPYO6aTmuhFTtRf/s5Hu4GIhGIzaaFjRS28Gu6GUbTrkaZtzcv4IMg1m6O3x27
UWzBIcHEru948fcW6pmG6kKWnjv4Pn0KgXPgmfSzbLrrLg3PStmReMuWQx+akWSB
uWg2p4hlExyJRaIY8KFdVRnXeaPvP36PH5EuZA947UP451hHGxyMU21ZgnKC4G0q
E9vZOTpwtwefqEJe0/oArAJM9ekxobU6dl4gyvlg69WrmpZ66J8=
=woQW
-----END PGP SIGNATURE-----

--VowwCrHTVB7zyE8h--
