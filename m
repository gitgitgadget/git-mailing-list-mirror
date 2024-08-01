Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64118FDDF
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512609; cv=none; b=sX7tUH4aQHxuJ0jIe8MC8tFa3ChFsecPd8zsE3w82MiaPRUABomvf3W3U6moQlMv6OfsOerzj/tgZ4hvOj0R1BDHu71c2n+sa7HVbtOd5PQ5PDBiWb9ASp8Rer6nV8s7Z26V4Xj7lbbYeBiEP2uADNfi33uqHw3qM4YvxlovsN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512609; c=relaxed/simple;
	bh=3cDkdpCXcIe0pjFeJVxMOpEPRDXyutHizGBFz0ysTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihHi4M8Tem9k9ay8IEBXytWNcKy3C4RSceXY9Amiq59ruVUrV6c35G0VeFoWcdLotqVuJ56RH1bGMIJg+/XPKIFxCOMV+ac+WCSePnzpJuwdVpXyFjePSoYd9B4Ylb/ap0ESMPlfiQ1d2i+ultYbEsJXcrKmnfFuI2aI9Uck5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GqaiFWVi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7oTDpzK; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GqaiFWVi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7oTDpzK"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id E3DC01388083;
	Thu,  1 Aug 2024 07:43:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 07:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722512606; x=1722599006; bh=3cDkdpCXcI
	e0pjFeJVxMOpEPRDXyutHizGBFz0ysTl0=; b=GqaiFWViI5My2CrxaFOj2uGrxI
	7x9XmMxL3MUyIvMf8BmoiyKSQttr7r9eiFLUtymkE+pj9gRQzloxDyVBKzsNkUiD
	bwctied4ccQNOtyixVnyKRvN/Occ6Jqb0/MW7rRreuB2EQSZKTKNH+2aXw4UJ5GG
	PsJgfBwCosRyXDUaSzGzVt37UID0CtNE0wuQ264/KgtIMKtJtv0F58uW4TJuPdOc
	dG1isenHMThCLB3cq6pjvGGQfj0r7qSJR7ntgIOtMaBpUoXxBY3JxspvrKH0Hx6A
	y7DmGsiIMwLt7GXblNwRFlBMcSn7gPlpOSlMl4iaYak3HPwtaoA2EzkbKg9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722512606; x=1722599006; bh=3cDkdpCXcIe0pjFeJVxMOpEPRDXy
	utHizGBFz0ysTl0=; b=M7oTDpzKjRl9ofvGlkSy0KD1fBZQTYZMhinkFJEWPyDB
	oOTbwtqsLd+lGonBFwYcwP5a1gXSSLzL5wco43jnXDmb7MMwb/nqjf2oUaacUhj7
	ECXwrCeCvpyd6lSSBe4FtG4ptyenw1oZMsVrHEal19DQofjbhAZVb5oMeYnA43En
	EetXb5hpmoNN7lO3lbE40jsgxQkXcqq4ZfaX+w43iCWN4pBb3sslMABg3Zm0Z4Gh
	DIGmrZgjc2ezrn3+rk44KKneWtA+0sEvbU5tH9FV/QfEhc+RW6gokYnoESQeu8OD
	XWPFYMSO1WMj3F3StUCj3mcsyXI6QaoAH+sFPcxZMQ==
X-ME-Sender: <xms:3nSrZpPyc_TVz7oFE6KvLKL9RwL33WPFKR-ZnYldhGWTdT03Sgix4Q>
    <xme:3nSrZr92yKL3QBTuZmUabsdxniH1HQb_5cWiqp1ZraJ4HJG6VO-00_A-B4GeObpwH
    pd30SFe9-BokkSAEA>
X-ME-Received: <xmr:3nSrZoSBfntspvV0GzvrH0PnuBi7-iy_tobT4Qn1vUE3qNAetS-p6F3_ke5FN5pl4lGTmL-KfcAnnjUc6wZ932iAaHUHCt8knGDfHaBAzibSPag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:3nSrZlspzV9amyMWhXlLEHMzLULj9yAr3W-VwHYsP78PI7bZSR7yWA>
    <xmx:3nSrZhciqmOCigANRw4pMxw1QTPLbn1j_L9YjWCd9R6oP-bRELtEwA>
    <xmx:3nSrZh3KKyp8iOYBqD4pv55KAd7oUAXWdagkr0xQBqzEp0z9u1rYFQ>
    <xmx:3nSrZt-tlDfkqNxDSVqjHSmid6zSHpQKqqR-MOCIzMgheCpFBwrFSQ>
    <xmx:3nSrZl52BsGGsBp3nW2a9EI1IMRP2C129ofAuxaEFh9f7xkvbPNsJRVS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 07:43:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 75ba3b1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 11:41:51 +0000 (UTC)
Date: Thu, 1 Aug 2024 13:43:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/7] t: port reftable/pq_test.c to the unit
 testing framework
Message-ID: <Zqt02XmevPRB3idt@tanuki>
References: <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240801110453.5087-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dM7V5o7+xk5mGoCH"
Content-Disposition: inline
In-Reply-To: <20240801110453.5087-1-chandrapratap3519@gmail.com>


--dM7V5o7+xk5mGoCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 04:29:41PM +0530, Chandra Pratap wrote:
> The reftable library comes with self tests, which are exercised
> as part of the usual end-to-end tests and are designed to
> observe the end-user visible effects of Git commands. What it
> exercises, however, is a better match for the unit-testing
> framework, merged at 8bf6fbd0 (Merge branch 'js/doc-unit-tests',
> 2023-12-09), which is designed to observe how low level
> implementation details, at the level of sequences of individual
> function calls, behave.
>=20
> Hence, port reftable/pq_test.c to the unit testing framework and
> improve upon the ported test. The first two patches in the series
> are preparatory cleanup, the third patch moves the test to the unit
> testing framework, and the rest of the patches improve upon the
> ported test.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>=20
> ---
> Changes in v7:
> - Fix a typo in patch 1
> - Fix do-while style error in patch 6 and 7

The range-diff looks as expected to me, so the whole series LGTM now.
Thanks!

Patrick

--dM7V5o7+xk5mGoCH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmardNgACgkQVbJhu7ck
PpT4YRAAgJv/bQP6fQCi9YVTL3OctAZwsNl4By5YFCGxyFxTPSE47qbZpM6nXdNM
ve5rew9kOtDR3MwLZuzqoHD7EK55VjvHd/v2Am+TcBxPUajbZNsisdvgoRHodghA
YNkT/kBcPnQHfohGtBKawNf7mai+jAxmIZi330aM6NNjh1c/DNfxz4wxcmkOtCNQ
eiyywxsFQYuP9/uBEWzzD/6ILcYqFE9VQBXfyEAylx16x0oHrALjk6PD9IeOic6y
9E9gW5sDZGRR1GOJ8Rt3k28S4QLVAkaDudIXPdxeI4OWALlMtosZkFF5oYw3vkHw
zBgKUPbg4LF2tvKU1GyVG7YjGh6AKgaeP5N2pw8/AE6KJvtMfPRetiScSDlCujeJ
fvz+Ss6fTXc/Uf7EcGZ2D9pZEN4n2DOd2Bh2cKU5f0GnR0s0NxKWWLth8bxaUafJ
6AB/E8wbCiLx/XHYuUy2D3pcGKYaDdZnnyY1dARzClt1bPRfTr2gLPXRqIVeZkM5
rSk3PcPs+iqGpA8gwB31TDOg9wXKxy8nQe4CTerb8PfA9DXy7xIAqxwb43ITqN70
7VUNr36J71bt53Uv7n4Lge1hUsHkRlJwffd7Kisf6NLPW4HV287q+3I+TGB0xoL1
WtWp4wIh+oK6O5wqgcfyryXpbQoYFTKJdkd0u43NJF/yWGX8vrY=
=GtTu
-----END PGP SIGNATURE-----

--dM7V5o7+xk5mGoCH--
