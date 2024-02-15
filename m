Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E1C1078B
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983033; cv=none; b=S4RCzFLHD6VtV9kmCRbh9CLgveIDLlG7eF3GBbL4fMxdjmd7rf1zsNqjaWSFgEeAQrjQAFpXTgTPFGLqaLJph7xW+zLb5/lbNXfGa7pz0raqg9h8tghSJ/aVjw9gkHgz+NeZtyD8DRoun8gMTc6ftK6uTt25WH8HNKw38S29wDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983033; c=relaxed/simple;
	bh=FxQAmr8BB/9PQo8wzNsoA0mS38rcAyJmnyr7ZxnSS0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbatpoA5B1lketn87ZPx4NnDlGwJlveZu1FqJqJu/HWL58OGx9Yt0AWzoco1tawNwmuAIKj/JVs67QRYc+sewxq2kdXPsb2O+meCRsQ6bEcrxJ0UmYefQd2lnYkXN21QK6pZ2+WHgtKyub5GrfBacf1zS5gqeQ3SokJG7tDTkG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Wi5NrED4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SV8kblqf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Wi5NrED4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SV8kblqf"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E28141140087;
	Thu, 15 Feb 2024 02:43:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 15 Feb 2024 02:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707983028; x=1708069428; bh=uEkpsELoQ0
	fGmYWqhqegt6OCoLD83R9aZMubuJsBSno=; b=Wi5NrED4nKFYXP/5rnkbD22QP7
	Ty7k/X/Ue5Ozm5H4N8ScZNeZdSoWHpYZSX6aHnqJxRaa8jPcyK4DK5/KrCnpT5aL
	EOPhRR57r1mNTLHvIDSw1tKPfVSc+7219RHhI0PTf8m9OkpQGNGftrb/UtRMLVfC
	r6nO+ANxv3Z5z6pparXTuL3sv92E/gSXHsV2bLJYoZ3R3dVkY/S/bVo9vQZxSn+h
	SltiTVYClnAyN/QYJK146lF87XmTWxb01r1Udb9bwlUtSnaVkzARrVHKkS+LsolK
	7ulaqVl3bvq1VNwD21OG1xpfmUR86+fxW3hzhFYYX+4p4r/gwMYJnmK995QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707983028; x=1708069428; bh=uEkpsELoQ0fGmYWqhqegt6OCoLD8
	3R9aZMubuJsBSno=; b=SV8kblqfQr29TPPO49DOzRVoJVph2jXhhlyDFVDVEBxw
	HCX/kmBWNHYM/hRhrTRjAa0uM6Bn599o4CggCjdXDazdMrrW/PbTCIEBj5oEb6kR
	P8ytLRXtgrt1pUFDrYt2eVj8slTXnYOkgUWCoyKHLefM7PJtU6YaIeLlUhfhsSh8
	hCrjwmcpKVDBKY6+JUNRsatgjHgdk2I4aKg3o3ln7qP4sE7/VwI6ElOD4PJUA8d9
	5PPI4qqIVo1lDoWHJTd/Q9UjFY/p7l/qmaebk8ssN7PuKaNU5CoSdN8YhbeVfuXe
	OBL8qBLjZYMt27sa6V3XymJRivssAOCcljaVPiG1xw==
X-ME-Sender: <xms:tMDNZak1PxdCM-1gQ4HIrD0MdN2coNSYsS1kPSFsCcIYNARHvu8W6g>
    <xme:tMDNZR3L4f3G2AvgbL_3rZOPJ2NIZq0dK5BiEy9CdNBEIAYcSxyTkUSngZu6XQFKn
    rMFV-3Y0hyYkQE5lQ>
X-ME-Received: <xmr:tMDNZYrhu1H-ZnOmzI0hSfqtqYer75hYQQtOS2827Ouy-Ck3dSm6NLpHH49d6Gq6xtGx_YK7rLSmoxS7RVbqYZvN9oL9p4PDxfSGaplpNNEl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:tMDNZelvvHX6qZ7M2HiXBIaJGZlw4nuSWkSQxgaNPm7the6WRnxnKw>
    <xmx:tMDNZY3A1uJZVw0jY2OnTGEiUjtvflQnZx9fdk2SRGgO4ig-EI2Cuw>
    <xmx:tMDNZVtGUc8TxElxQuLzzQzTmIWFqdJ7ga7_tlqu-chcC2ugZgRMQw>
    <xmx:tMDNZVz8-8k-Ic-9SZAJiTJl1jV_lyitZ2CPOZFLnoKY_watZ3wx3w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 02:43:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 413e0515 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 07:39:54 +0000 (UTC)
Date: Thu, 15 Feb 2024 08:43:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Han-Wen Nienhuys <hanwenn@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/8] reftable/stack: do not overwrite errors when
 compacting
Message-ID: <Zc3AsEu0FYzU6tMX@tanuki>
References: <cover.1703063544.git.ps@pks.im>
 <cover.1704262787.git.ps@pks.im>
 <1dc8ddf04a112c38f41d573a48dac3f99b4b51e9.1704262787.git.ps@pks.im>
 <CAOw_e7b72HVQob_hiV0gtRhGWsb=rz40WL=oaV63t7oOmEA-mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YJo5ytAXKa/U+kkx"
Content-Disposition: inline
In-Reply-To: <CAOw_e7b72HVQob_hiV0gtRhGWsb=rz40WL=oaV63t7oOmEA-mw@mail.gmail.com>


--YJo5ytAXKa/U+kkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 04:12:54PM +0100, Han-Wen Nienhuys wrote:
> Good catch!
>=20
> Sorry for messing this up.

Nothing to be sorry about, bugs happen to all of us.

> > In the worst case,
> > this can lead to a compacted stack that is missing records.
>=20
> Yeah, that would be an insidious corruption. Have you considered
> writing a test to reproduce this (and thus verify that the fix really
> fixes the problem?)
>=20
> I think it wouldn't be too difficult: you could create a custom
> blocksource wrapper that returns I/O error on the Nth read, and then
> create a reftable with two ref blocks (could just be 2 records if you
> use a small blocksize and a large refname) and two log blocks.  Merge
> that with an empty table, and see if the compacted result is what you
> got in. Loop over N to get coverage for all error paths.

Ah, that's a feasible way to write such a test indeed. I may come back
to it in the future and will add it to our backlog. Thanks!

Patrick

--YJo5ytAXKa/U+kkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXNwKsACgkQVbJhu7ck
PpSv/A//R3V1xecOJLg1kxgRucp9CNVgGA4tTKrZ8+N+wgHzEFHtHXP2hxraLgsJ
aLIpcTlg6dLgGx5drBoxtoLl8m/PuMgAqdexke7q/HDvo7Pqz3sfkBkS3l0rs6PN
OwyAft7XOVMO4fAZZbpmaQO4RbgXVQTvLntL+/jPSeym9h7Aq9JTGNHsNG696v1A
78I1kH3Q0sW4UljcI/jLE2Md8gh+uukrvlolvyrb2lFOuUK2xgEgfP52y4hlbrWE
IEM2HG2MrUTsYPg8fhFGwjae0BBYp5jal7MO6tAMJ0GWoNVXzyBHYUTcUcHAUQva
t6D4e6A+YkSg52s80oqkCKWtyNmjGcXJmCi1nfsBm4YQdMeQeBAJJW6fFJwDn3P/
Af1z2JdlwzZi5XMjmHwkAMljK4qTO+YrwuTf4b3F1TboCTW33wvDiwsASWxc/3DP
77TCVUrkovP9vIGsKWuxV0FPVZpamvr/gQtUGI3pQ5cQnh5rASErTa/7OP8+mHdT
TR2pTCao8B/FKISkMbvUD0kHr3F/bKohc2LjxZp6bhWkO1+A5vRV39hiNGBFmLDQ
NhVKO08s+1mdUkM30Qvyd3AR/HvJpAKoQtxAup2I1jaKFyBZBQaOEDOfYnVFg2O3
fT/P8xYlgrzksFYFKI2/3Ak6du6do6t+Pc8PiRy2+C7OBYEtraU=
=gx2M
-----END PGP SIGNATURE-----

--YJo5ytAXKa/U+kkx--
