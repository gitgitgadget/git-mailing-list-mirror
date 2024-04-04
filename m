Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84494C637
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 06:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712210910; cv=none; b=KyIZQeV4iCGDwhukRb7DHwUF7T01EvXXnWK4qHBQ18kHS3xmY4Empl1n08xQ3anANgWXzxWu6BJXeB5cfOUPGjfan7vKFFs4NbTqee7CGnYx6tuSs1F4Yxsg2ssye/MRMSnFQqfKTmJyx+elFuHfAMpzywJA5eWi4J7EbZWrhOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712210910; c=relaxed/simple;
	bh=U7eblgBPkzyak/v1oX8/mBJEKlL2j8ek4cLXqNILSGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWZdnr5HiOlTTubdueu2cT3gyXmnoleTA/wgl/DgcphSPyzhGPqJFz/tS9ESZCfy2JRXqCmbkGdWXos2suTm2nKTH1PfDAdJ4MT+loNZTSqdihzgWMNe+lWUSOD0O3zYf4g5/cVOmAd8DJ5OZiAzmE5iI4gE5f7r5fhNHYFeDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NGZca9QK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kcDJVrWZ; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NGZca9QK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kcDJVrWZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id D12785C0086;
	Thu,  4 Apr 2024 02:08:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 02:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712210907; x=1712297307; bh=U7eblgBPkz
	yak/v1oX8/mBJEKlL2j8ek4cLXqNILSGw=; b=NGZca9QKlpcUhQT6hWzzw9R8oI
	+FPJr0EaL4DL8GZxMgQq2u3B5pYpG+4r2h/DLDsUnDoTVT3JfbLKtyk9vCTQS4Ew
	7W5kFxg+1K1+QBhJsFF35KvQIbWr5tnqpxusZRGtoffMD7wHRJYjLGtLBjW0odbU
	4nJRUuUyZv5/CFCoattEQq9xKHa4n0CN0ICa7BTVF5OsHzwHtMRjBNNHG6ZDUFG+
	QVeHjPUwapK5bAduxwSJRsYGxtGajr/SsZ8x3dkZDsfD/J0pLGjDrEJnwv+wRFEs
	miO0nPr8Ihje9qKaRH8iFTtjhG2Wn+w+eDL9dRMKIbVabljn2kj2bx3+IdcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712210907; x=1712297307; bh=U7eblgBPkzyak/v1oX8/mBJEKlL2
	j8ek4cLXqNILSGw=; b=kcDJVrWZ9hVjcOYwNEKrwOtv9p3IipH08dVFBsIS9its
	NG3jC1GoUHZZrdD2SOWhb6XE9kmPwl0In8oLOYpzcJpOfJyq4onsYaaB/DXaXk3a
	BaJ+fvRc0meUq4sZdVG5UvQGpBQ1Aia2ciBAGrEIbu0bCoXisGY4TqY1b2j+g25h
	ehvD6UQO+7SOh2kM161ecJ8Uec3Qz5vIZoq0vLUy4OxEmNx0M2tMBdwU5VEoy7xZ
	TleIR9zL5Sn2VD5zH2VfCk1tK70IJmPh8Js/hY/jtWuGVs1uXs4l2fqXGAJQB1ad
	G+Ig2QlQTy177sneKyhYJWW3+Cq191vpGS0aAkVDcg==
X-ME-Sender: <xms:20MOZuDh9fG9v6dQvUQd5747JBuzXSCn020gbFvrfr-Ksn3iY6rv-A>
    <xme:20MOZoiIFrHM8oYRVNgUqJCknM2IDYSsn6ft7TMUqvn9QvAHhpQWlk5JJ0WCmpR0d
    sA1wzutdVT9HbRaVA>
X-ME-Received: <xmr:20MOZhmqAmpNoVI6HJWpo4E3tzq0xwfcBzOdBNeWbuPeFPa2sJvshz0q4k5yKvOp4Ygn8mki5kBhc-Iar3wbudnJtNpGyaL5bNzD_an1g8yPtaLH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:20MOZsxO5Eng5p7m4PI__9A1uDEljLrn4tC_9R6a0PpcJf89qpojSg>
    <xmx:20MOZjSZVF1RsUyGGDDLuIkPjTivkOtfUDjDh-2lHhAiW49NnoKT6w>
    <xmx:20MOZnaPgJM57pDeXCEHGnPOkVsTMjjOD7ro5pprUfdWk4fIaJx9Vg>
    <xmx:20MOZsSqBlbqUDjVrsTtx4EgKhGZ9cjqHbZTbTT8ZcRzjmuvHMDFvA>
    <xmx:20MOZuFKBJsLFy7G6Wsjfq7ojVIoYcUTacbb0pAd7DOWCa-ODrDWP-Ex2wMC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 02:08:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53f1ab33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 06:08:21 +0000 (UTC)
Date: Thu, 4 Apr 2024 08:08:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Brian Lyles <brianmlyles@gmail.com>
Subject: Re: [PATCH] rebase -i: improve error message when picking merge
Message-ID: <Zg5D1qnKd9bGiXBw@tanuki>
References: <pull.1672.git.1708945087691.gitgitgadget@gmail.com>
 <db27d746-5b83-45fa-a8e7-d88022ce1ca5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LM/Eo48L47v09uf/"
Content-Disposition: inline
In-Reply-To: <db27d746-5b83-45fa-a8e7-d88022ce1ca5@gmail.com>


--LM/Eo48L47v09uf/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 02:42:19PM +0100, phillip.wood123@gmail.com wrote:
> If anyone has time to review this I'd be very grateful. I've added a coup=
le
> of people to the cc list who have recently contributed to the sequencer b=
ut
> if anyone else fancies taking a look please do.
>=20
> Thanks
>=20
> Phillip

I ain't got much of a stake in this, but I've put in my 2c anyway. :)

Patrick

--LM/Eo48L47v09uf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOQ9UACgkQVbJhu7ck
PpRN/Q//bYQXwHS1CgTq70IxgeGTtuLfSEtcaKtyUKUBilYQDvhLpYwy8093FDyp
OQBI3gyaiFfQCE0N1sMdAzWXXyQNssLils5RQCgZCAiW6GYCOP62m3jQwQa5H/Fx
Jav74WU/koQBjBidZ5CLa5+zjhwd2bV9ROxg6aUFlJbU72JdgJzdxxs/w5Qus3F5
GUB/OAKhki15gkY7wtEToT5W9qWpRTLpt3AGNXjExw8zPRY5/uRq8mO/WCBvg+OJ
fC0tSyxNJJifTsY2GgKzEdtPihZI+cy6Sa9mg+fiO6KfrGcfPaA7NpRXUzmEggrX
eyxeZB0S41mJHk76ZN+TEpVARy585D8VYbv6NH1Wgw2wHp207bOAB6f2D9Fu7ze8
J+TYvz12cRL3shW6veaKwwKfY5se+WDrkaKjjdaRb7XHF+eV5HisOC5Ig/ykII2W
nGyL9o+HuESI+dea00cJW4WZklsU1/FCRqxj/cMsF1Kkh8K2tMKf5YhuYynuwz41
lubkyLNH8h9bInA5APVXgqjuM/Ojw/zVY47ZS8Qru/vbtdNvx9Nsu/AZfFmGJ4+K
pa8HNa5jUUbGxTnUajkrDZBZd8kO4WksRvOHqbygswrNEGxXVVqeHbHhnttj0TiY
yoFkQqfoIDI3GDpvOMTCmbLxFJ8znjiB9CmeaN8UfUmsbzZt7rA=
=gcPu
-----END PGP SIGNATURE-----

--LM/Eo48L47v09uf/--
