Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578B1CD20
	for <git@vger.kernel.org>; Thu, 30 May 2024 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053882; cv=none; b=qwbCLxbeoEb5QM8hJtwMk1QoaQB6xqmdE8AEf8PrzQwxI4E0NpJUnyb1W+l2NYkd1YrfmaRzaREG80FJPn1CCqIeYH4QxTFLBMDf5BU39JC9w3ZAa6oe88UTCSFi1cv+ESBsSL8Yy14pSKf6Fqhwl8PccdWx6yAu+5AHrCLlhUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053882; c=relaxed/simple;
	bh=Onp9ujQ/5Z6tuL8Yzdyi+IbGDCcyBwPlCIoyB/vTOrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTvbs5QEYLbypFD78dfVhAJ2NVoU+LwmWI3gJCmmHxtFcJo08pw+LT17Tp+N66ATrZtmn/nehd5lUwvWlcJQIY2DHRPyVaE9KE1oIiF/NwlqMJif3cqjJZTA6TKJYgdIpH8wVZgDqg2jpmfls6/wF31qX8dypPbtsGnkeIVQbiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HvW/O6yL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bqm0geh4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HvW/O6yL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bqm0geh4"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 35B4E138016A;
	Thu, 30 May 2024 03:24:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 30 May 2024 03:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717053880; x=1717140280; bh=Onp9ujQ/5Z
	6tuL8Yzdyi+IbGDCcyBwPlCIoyB/vTOrM=; b=HvW/O6yLsueXlvh93Q6EpsJ9s3
	y4tRZZWNjhBJRcWV5Nnnm5SrIAjukWfy5dUP2j6+Pu80DzsE/57PynOuOd9CPHPB
	17kwqjlx7+8jIiyBrXJ4vQf8Htsj/hBtZ3hMtxGCdSAnocdsQeZDFwuRQXh5nUpw
	1sqNs+5hNOxZezfXHNygHlwaEWFqWEnqrJsZEUVj3+gPQlYjgcI02dpr2Cj/QyY+
	vElBQGii4aVFe9PhrFPexJVYI3Jx/bPC5pa3WxFuTugh3YCNbI0tUa3Mu/XreBQ9
	LrAANVTlYr00h9T2iAH/MaZUeBbr6H3rtTYu0xcruqwGLoOlck6xZ5qMvjhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717053880; x=1717140280; bh=Onp9ujQ/5Z6tuL8Yzdyi+IbGDCcy
	BwPlCIoyB/vTOrM=; b=Bqm0geh4w8om9G/mpWC3tsB3CnECnzVDT9sXpp5hBKzP
	it/UxlKUcIUQrePxKP26Totq1yhXP2tN8Cjnb6S3AZQxwvv8qASA+X1k4TuG4tpr
	UXKWJJieLIsc8UZVMYAh68ltY3xGCcwzPrkcY13AEmlafuQyEvCZD+1Om5qYQBW3
	DdWDtzLK7emlup/rtsN8rxbw/3fH3whmYj+xUbuFTZx1dutVAQJ4c5nVVUdeLoJV
	cbSTQhOMdSG2Nzk0LcFQeglQFmadpel7MQvZjQpI2vZcywEakhEgfFvg1f8H8X4n
	H6ie+C5EB0CQd8rLXGbRaf7gGccu6nAyBB4Mf2nVvw==
X-ME-Sender: <xms:uClYZoeS38JJfHxQR_jEd8g_fc20x-QfGGYHSr9HKL85hzbBqEyaxQ>
    <xme:uClYZqPJQEU-sHa4pWnBiT8epQSq6eCZE-wST4_1y_HZWPrvua5ZpoLdP-5eJHVOX
    86ltQjB4oCm_nkSgA>
X-ME-Received: <xmr:uClYZpikYuV_Q0wQyXJLfHQhgkEDi6rRe7qaHJ1YOwMHfaZZ39DIrg76h9Ko6v-D59_3J0b29LXiKAid6OKB0WakA9wbNB7RoF7BO2OdHhTHeIxiEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekfedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uClYZt8Q5BsS8p4vas5FTZuzeh8Ywm1wy5jTAfEyf8fpybIhar3Eqw>
    <xmx:uClYZktNG_MWsXpDCEUCsnxq5N6Q9a6VceEFkQV-gigICAWhMaQ-WQ>
    <xmx:uClYZkHnG9aJpRmrcPltml8y54MOF6eJ9S03t9ebyVg47ulmqlVk2w>
    <xmx:uClYZjNuLzxOA3UHp8rLNHWv73dWUFSK0vHcdUo99zZTXfdJFxfpfA>
    <xmx:uClYZuXbuxaYcwTeUAAOqoGaeL-i2ragJOrtLsCbjhTfaEZfhCtovgiD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 03:24:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 407344af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 07:24:20 +0000 (UTC)
Date: Thu, 30 May 2024 09:24:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 3/5] mv: move src_dir cleanup to end of cmd_mv()
Message-ID: <ZlgpsrKN7N38V2GP@tanuki>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
 <20240530064422.GC1949704@coredump.intra.peff.net>
 <Zlgk_MMDGlphfO9U@tanuki>
 <20240530072159.GF1949834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T/u7j0bN0uz5smDf"
Content-Disposition: inline
In-Reply-To: <20240530072159.GF1949834@coredump.intra.peff.net>


--T/u7j0bN0uz5smDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 03:21:59AM -0400, Jeff King wrote:
> On Thu, May 30, 2024 at 09:04:28AM +0200, Patrick Steinhardt wrote:
>=20
> > > But if the actual move queues any errors in only_match_skip_worktree,
> > > that can cause us to jump straight to the "out" label to clean up,
> > > skipping the free() and leaking the array.
> > >=20
> > > Let's push the free() down past the "out" label so that we always cle=
an
> > > up (the array is initialized to NULL, so this is always safe). We'll
> > > hold on to the memory a little longer than necessary, but clarity is
> > > more important than micro-optimizing here.
> > [...]
> >=20
> > Ouf of curiosity, did you check whether this makes any additional tests
> > pass with SANITIZE=3Dleak?
>=20
> No, I didn't. I think you can only trigger it with a sparse index, at
> which point it seemed like diminishing returns to try to reproduce.
>=20
> But running in "check" mode is not too hard...
>=20
> ...time passes...
>=20
> Looks like no. The obvious candidate would be t7002-mv-sparse-checkout,
> but it looks like the sparse-checkout code has minor leaks itself.

Okay, thanks for double checking! I was mostly asking because I plan to
send another leak fixes series to the mailing list later this week.

Patrick

--T/u7j0bN0uz5smDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYKbEACgkQVbJhu7ck
PpQdcQ/9HDAiQxEnqb2vL88ezmub1/jduVdNvu8/+RJpEzYHFNAEuu7sUrYi7hEY
hmMcSisPM+3D1OGSiVBmJjoCXlLTpd9x1EJ7CQ4wl+gHieJJ6QLLH+nBOB7mTVF/
Sz0GNWQb6Caq19iolGcoV2Lc1iMgYkLYCvIj7Gj92MgVHnruuxNw5OWXuBVpFZ4s
zGFpevJhYYl5FIvL2/yi5oKT0iqu7tMe3OgmU7RfuGxkppn6rk0Hnv+0Mt+owD7w
0bQb30KkQJJRya266F+UHdOa6G7on50UAPKsr+nG8RK1XlByMihQps1cLwDu/Hyl
4305uK+sZZQYTJM/M8UnvpQ5U+cbt7CODlOhPGRJf5dyTeYKWQ0aTXDoG8jdMJD9
CG/fIL4A3g7tcmyVmX8tHwzLRYnaPvJ/f/GtII2jqRX/SzIL4sU+vu0bhuEwKoWr
aTD7NHuQS0B8+s+jPCDHjD+qbH2VX99djqV5fVfkcrkkQFzKq9nEgzqW3/R27yD/
EmFvYaki/8E0eIc3iqpKyS2XwsEpWSWyPGrDqTd38KOl4q+Y1NOnsDsCapCwICl0
zBfixFynTDLvfrG6HXyZNe17zX5xqDIS9btalTz65i7/8R5SumbnA9WmL8dxZApo
e68BTmHUKjAAcOxO38GMN/nPmR+CBvoOPSvdwaHi0Sg62CViQGM=
=h5UA
-----END PGP SIGNATURE-----

--T/u7j0bN0uz5smDf--
