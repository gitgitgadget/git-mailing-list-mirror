Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403A3146A73
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 06:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319451; cv=none; b=j8bOlyjNynkqVqueJAGeK/+jhQT3tHxKbjnaIUgDBacJU4oU4dECKViOdz9B0dUSsZLbBFypT+l0XtMqILtAkWIit7i0yE8jCU65M40SszZoW5iyRiV3uIXOfHE+rqAPQmMKCVUc/R5g1UJhMXoll6+cR/d/rTnSId1GTTwErKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319451; c=relaxed/simple;
	bh=dxoIXMtL+QPUSiII6IScH61sV6YTFM4sB/OJFnFbpAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be035LXUjjBALjuY5vh16Epekq3Yghxn7kG3vjg0l1S7uNkgfnhw7/sf4Nl/ryRhtqD2szhjFMEmYBLwIOdw46Iisp+HGZiVmzkTj8ivD29Zbcuh0q8Ph9OEk91aWIrrOU31+NQcRsZtfZ8M+oeYuSEpxGJ0Kwk5rxshixBrjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fmyGwMNl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYCBu9k5; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fmyGwMNl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYCBu9k5"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 679A51140530;
	Tue, 30 Jul 2024 02:04:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Jul 2024 02:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722319448; x=1722405848; bh=DROq3RkBBi
	BWCOHPUJ5z8yfcmEzxLtY99pZOxeAj0Lo=; b=fmyGwMNl6z3YXitmAvnRV5QnBG
	Ii8jqOAH2DHvQGV0QXxwV92eagCiSNkv1OV2MKfIW4L3MNaUF7KuPZJUUo8OCcA3
	g5npmqXlAsOwuZGwehAWiFX/JzK0zmc/cYjgN8ETDCTfJxaRJENV1ox8a4HLs725
	MjIiUCQwVvi+1Owv8qfR4dyGK9dzwB4kdoIV9VPMhl7XOZxUuKeZ2gw2zqXFCPY+
	RLxyORaCF71pO1xryeaIkT0kK30AmC/CusHI3nZ8EzJxDo0r2Xz1n+TCDxzgKRg0
	J3U2y6mbvqns3rHXw2vkG0Zs7Cs5nTPj8DQyTb82EltEbfX+JIpFvc+2uiSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722319448; x=1722405848; bh=DROq3RkBBiBWCOHPUJ5z8yfcmEzx
	LtY99pZOxeAj0Lo=; b=fYCBu9k51j4nM8zzqR6EIQPzyRb8a7jLtM18VlpAJXZj
	cAfDrkLIt2K9Cs+V0r3Vkxbw3Q0Ek+RvLI0rQFauCRZPgcUffcKoOAI3wk4LiS9V
	M9CyLUX+pIJ6umMhcaZ1TrGEmPAQcOKqmZJ4dwZDFIbkBNdmHaDRelEgnH80dBQN
	HJebdypEsT5MgZuUa+N3n3/xbmJ/G1cQXGOO7AFfkhFrtJQef5OTqh9OrYqZQGwy
	3QjUc5aMIWsW7KE6ThV4jCBfSqtGnYtLuhf5jM7YXM2cS6U5LLYH5mZvfzbZkhxK
	Rx9T5ucEb4MWRBib4dSeQP1WMSkKeOXsDmTC8zCwoQ==
X-ME-Sender: <xms:WIKoZjo-fs7dnDv9Qra0WQEScgq6Ki-BBG_W8ZOOl2kU6J4qqapuxw>
    <xme:WIKoZtq2FkkMWXEwStEO6gxoLI0SLrtcrh-h5_Klb7b8Qp4Tr0rhHYOjQbfVFY0v8
    B1BIKfZyOXmiY5gmQ>
X-ME-Received: <xmr:WIKoZgMPTBtpX07xAiy2Xo3sMvDVQ1ugJuPA_4LnUG91vvU2yt9BRVfjKzdzTq7CumOTup5b9Bx2g9dZj64lniso8U3D57OYhFp5UeVV4CTI6ik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:WIKoZm6ChqqAJeUuWFEIcIJ7YjPNy90_wRMOhwCd3ucaPTmg5-x3FA>
    <xmx:WIKoZi4hIFKb1J9nok9BhQFQER3SMbgfmy-2WodpXQqkfXbcPiyx4Q>
    <xmx:WIKoZugQzNDq0k2cM1aRSVqDNdbNlbq6NvaxwTN_9v-eXbvhQBEInw>
    <xmx:WIKoZk40kXYB6_I9XUKWagpCiMC8KVzVckRdr08xVP-_zBfC0d5psg>
    <xmx:WIKoZomr_hfga0cqnD-2-y0vAkYWgAbW1snCMKmgGaGIZW9kv9IJRVGv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 02:04:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bcd502d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 06:02:38 +0000 (UTC)
Date: Tue, 30 Jul 2024 08:04:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 7/7] t-reftable-pq: add tests for
 merged_iter_pqueue_top()
Message-ID: <ZqiCU_si-bFUgl4a@tanuki>
References: <20240723143032.4261-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-1-chandrapratap3519@gmail.com>
 <20240725093855.4201-8-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="38E6/gf1+rUbn0Zy"
Content-Disposition: inline
In-Reply-To: <20240725093855.4201-8-chandrapratap3519@gmail.com>


--38E6/gf1+rUbn0Zy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 02:55:59PM +0530, Chandra Pratap wrote:
> @@ -95,10 +104,51 @@ static void t_pq_index(void)
>  	merged_iter_pqueue_release(&pq);
>  }
> =20
> +static void t_merged_iter_pqueue_top(void)
> +{
> +	struct merged_iter_pqueue pq =3D { 0 };
> +	struct reftable_record recs[13];
> +	size_t N =3D ARRAY_SIZE(recs), i;
> +
> +	for (i =3D 0; i < N; i++) {
> +		reftable_record_init(&recs[i], BLOCK_TYPE_REF);
> +		recs[i].u.ref.refname =3D (char *) "refs/heads/master";
> +	}
> +
> +	i =3D 1;
> +	do {
> +		struct pq_entry e =3D {
> +			.rec =3D &recs[i],
> +			.index =3D i,
> +		};
> +
> +		merged_iter_pqueue_add(&pq, &e);
> +		merged_iter_pqueue_check(&pq);
> +		i =3D (i * 7) % N;
> +	}
> +	while (i !=3D 1);

Same nit here. Other than that this patch series looks good to me,
thanks!

Patrick

--38E6/gf1+rUbn0Zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoglIACgkQVbJhu7ck
PpQMWRAArkhYl8Yso1em9/OBaaIHsvOC05iE9xUwZbne+Oizpf1+0FHM3nrJqGN7
SfgNdj9T1upnAxAb6XQqrkK2yU9KDzZPoOxJXPgRh1QHUcUi68PlQUVO5Js6/Gx3
2QtfHkDxhnez7c+yEH8qmXgmUhMRezA6smBWqf4M7j55mA8QUFZg7WUJBbrdGlZp
aCugtJaEiAnS7N2Q+lIFbgWrSMzPS/8jSFJ4/RSCpGUrJI7QGM0XbLAFFQjYfEUn
ueyg5ZGW57l10bK8c5F+Y7uZjgY8pqdZZl4dKJX3kEJcKYUMTCzySL7JgaYlS7P+
1PSWSBgDl8nBC3iByOjCv33x3CGD14YV39FgEKvYycZm0+XLMhpEyea+immmaav9
cTimp4fPuYQNoZvXC/KyO6rqe3CNIzw0+Cmdxd+dZ6pCTJjpvDq91qsPEz2VdEgf
epzqvM6Ak+1fso6yGFGe/wnvKX6zCrJpO4XUGCoRY4iBsQmMYV5TWRDVyX7z/6mg
bcGtdkzqICnAKi2EWuoQhP5q3WzmjsQ2WpPx4WozoYrNVFSmWHTqnR/PcfP6kaUt
mvvpX6VinmaM3FWgbMgLe/hENqKOiF2xlsZuAY6vN0sQYdXm0bvUD0BVraQp2lxy
uhMHmeI29qyPMTwi42NIjtIBj9i4VxBBoOsPtJtDeKhPRbjQFw8=
=u8uf
-----END PGP SIGNATURE-----

--38E6/gf1+rUbn0Zy--
