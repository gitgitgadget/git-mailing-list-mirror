Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529C624
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659883; cv=none; b=MPfxDdOkO7C8U6jl7UStuqVtukUamrBlkiiFCL2hH0gc5RdHBF7PTz2DJyGH2VN7NcG3PSzJha3JhuDI27X1uH2nvlOM45Y41C2a9uV+7JBUWga3NZ9HKyRAU1NIPRxJiSy45foPAYBJZJhWf71Zd8hOA1NnssOsBY7tT4fIUAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659883; c=relaxed/simple;
	bh=e/AcMSKYY+4jTnkrtzJ+thEpc/5PrE8cHI7EDRHIBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnT/OomvDH5bULfHQ9UAxyX7Ue5sLHMXmaTH7YfJyMC6NPlpilN/owcNZCSgTEbBuPEjkTz+CgMOz0dNwX9UWno9ivyQOYbFy+32dJkDbGuAx/XsADkWtGr8Cqha8idm0lSyhnBqRjnDqCz6pEudyWLq/O7qnzTnuF9IaOvoyFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FDyjZx1z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKHyxgyJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FDyjZx1z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKHyxgyJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6989411401E1;
	Thu,  6 Jun 2024 03:44:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 06 Jun 2024 03:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717659881; x=1717746281; bh=e/AcMSKYY+
	4jTnkrtzJ+thEpc/5PrE8cHI7EDRHIBCI=; b=FDyjZx1zBnlYS+5eiuHjYdLdHV
	d4/e4J6mbkQOBcZCTvfksYdjFIY7A762DpIOf3cEniR/v4SgZWCzrnfwI9XLzNJl
	aAWOs24VZx64SW6+g07eIbNjHRFIKCa7paZodi+vYa1PdA460KpCEQxylMSJl7Vr
	0iwdygibRt2UaGMKeb5m2SGfjSuV/MniEt+TvYzUt3PU9L84SyYIK6N3FCV/Z9SR
	Dzdv9mtxYv8N6zeKKAsFip5GGY7ooL3k+v6GFliE/DyhhjxlCwT7S5dFbdPYbGZ3
	lDBo5+DbOOBvxAWlcIA0gwPJzD3dPVLKspdRf4uWbAKLWLvG8LwKqZ1vXRsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717659881; x=1717746281; bh=e/AcMSKYY+4jTnkrtzJ+thEpc/5P
	rE8cHI7EDRHIBCI=; b=IKHyxgyJeeh49+dFnmCfBZRE570AHOFLFkAleFPOECGD
	SeqhDKPj/YlfzhkXhhKK3r91SN/wMI6i0qi01/BcvHJB5o7uTKJnYumO572D3E21
	2FXbbMzBT2PBtL78/TbpTtKgmM7R7PCvZHsuL9P/FW0JXzJJDbrW6v9zws9rJNRU
	F/dDxBw22JwYTuAMwP5cG/0cMHL+6lX8FRGH7xhibn9JQ3y0RPKHoJ2u2t6gq5ui
	J5h0y4BDfWcjS1LI3cofO9sRvcxb0nyt0AbPUmnchgTcuiqoEpN7MbeDhRLhcCU/
	w+nPGmQ8LvRkxDu85IDziCEQnR1IuZ4siulLTnIATg==
X-ME-Sender: <xms:6WhhZniMvN0t35eb7dQdpLN-aZD-zn3m56yplLO1yJ94ri0gCioAhA>
    <xme:6WhhZkC7EaZMiG5dlNIG79KWTlTyocVBa7XGj6DLXkiRwKscslFdB0j8727wQ5T7z
    W_DKTXBqU8DCdxFRw>
X-ME-Received: <xmr:6WhhZnGSKLqbsNL8zB56EjWe1jM2RU3gPQuPEcwtFZNNbsuUhSVrK3xZGMZzBDUoC4KlW156G6obqemeRS2vkt7UymZyVu2b28uefN6AZfh3OLXT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6WhhZkRM5_m0uvpHBIpbvExOwQb4sPqN_bmHEOLReGgi8xkJCV741w>
    <xmx:6WhhZkxV9LhZsdbHJR-FM4-pLu4MLpWElwCTT5OBxhtYzDLWAY_lYQ>
    <xmx:6WhhZq41oU_qJGDzLyVgDq6E5BCgMZte2EWyuq7oIxnPjdvSwrx3YA>
    <xmx:6WhhZpzA45DOnDsbczDIbAM1OlJQEiL0FxIMwHVGxe6W4d8WQFNkSw>
    <xmx:6WhhZg9j7R0bwdqcC7m9dTeDrDLMv4a3SrBcchsqyDY4_dSh7Q9Lt_B5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 03:44:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0879397f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 07:44:09 +0000 (UTC)
Date: Thu, 6 Jun 2024 09:44:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] ci: fix check for Ubuntu 20.04
Message-ID: <ZmFo5bZ1hJGrgvGM@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <f91004a4382c95b1b87bf3d1aafc018af2b7b92e.1717655210.git.ps@pks.im>
 <20240606065328.GB646308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f8w17mPBwb+4Aomz"
Content-Disposition: inline
In-Reply-To: <20240606065328.GB646308@coredump.intra.peff.net>


--f8w17mPBwb+4Aomz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 02:53:28AM -0400, Jeff King wrote:
> On Thu, Jun 06, 2024 at 08:30:25AM +0200, Patrick Steinhardt wrote:
>=20
> > In 5ca0c455f1 (ci: fix Python dependency on Ubuntu 24.04, 2024-05-06),
> > we made the use of Python 2 conditional on whether or not the CI job
> > runs Ubuntu 20.04. There was a brown-paper-bag-style bug though, where
> > the condition forgot to invoke the `test` builtin. The result of it is
> > that the check always fails, and thus all of our jobs run with Python 3
> > by accident.
> >=20
> > Fix this.
>=20
> Yikes. This looks obviously correct. Though I guess nobody noticed or
> cared that we were not using python 2? It sounds like it is a
> nice-to-have to get more coverage, but the platform in question is happy
> to use python 3).

Yeah, the reason for this check really only is to get more coverage
while Python 2 is still available on some of the distros that users may
reasonably use. It's kind of a best effort check to keep it compatible,
even though we will likely eventually drop that guarantee once Python 2
is getting phased out by distros.

Patrick

--f8w17mPBwb+4Aomz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhaOQACgkQVbJhu7ck
PpRnow//bEuJpKExKG64Q253pr9ZHaSjIn5g4p9miS0kxqKheiT6zkMgZch3ckyv
LPnY7/9dKq9tJeBQHe/+zZf2ImriWZjtFPIDI5CaQzTRqMwS1N6Opp+CEGXRvGNb
BW12HebWYqyokeqC5CpGCQfTUmZXvkNqPpeV2OHygQediUVwxsXCMTQkuvv80UlA
JMTy2vmx1Fjx3GUye28XDP4GUOL4LLgCXnpivrjKsh7lA/wL9DVQy6z+sH+qZVvD
lAD1qWVL1gakUiMhzU/7jmKgZaUIKxmUqHNdfdGC02Hwwwxc/osz/m8ICOAfsKv+
wdz8v+XZ7kGM/fydVZfSN6faQ9eLfezEB2+h6o2vRW9R3pQmT8givl5C2vhVYP8D
R0oLNhCG1TESxTbxIYOqp//QLBZGAOePbB7SmfjLZR0TAf4d8XCK7tWK9chthmeX
Zg4yJpwNYlUzz2N5wk29cL1oVAAlEJmjLng0RrA2AlNxxNY0s/vYrR8TuEuSa4xI
1QqV/AFWKOYv4OFwx/WDKtbor7TXIYMzxmEBQKMWZu7yZeEAa6aJS+OXHpN44lFu
n656RwpMeIi9K57Vzaqp1orMGMDfCoWgB3ywgHb46n+Keb6RkCcvPxI1acVypFRc
IABKw2pZUCGPYThO4UDiwNWbWIV0U6B8iptftHUmjy3XTYXGoNE=
=Utwk
-----END PGP SIGNATURE-----

--f8w17mPBwb+4Aomz--
