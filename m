Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544017C8B
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662492; cv=none; b=LXBXOPLvC5eq2rhaJ4zKKUDxSkqFJgmxiJtHitquWhsSVBuiKncSaQJ5xg0sKaiGYcjCfP1LelinF7l8GEfMwVQxWL8einERWeqfjAkhSHxUkNLtj6YUiyIJGtpyZRtvlvviBO1EwPNdzfenhad9olBDmhU4CcUyLqq5PGhO9tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662492; c=relaxed/simple;
	bh=mITp0G8VrV1nmhnvdrLCvhRf1Irp49E/kdheNU3LoO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeGCKQPOuTyzQ62bhv4t2QsMgGqOfRvJGMjOBiM+KrUk7+jdfe9miXOea0i9W/zGjSSGVExPhwWbkNlhdJfSdlk8GyBK6n0Yw49EeytzMl/Mc1YZnA/RWvh/5DFDbCHnyKzUX+cn/+ranQe94R77gqfyrEgqjSK+cQUL7d06LVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1Ush0pk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bWuXB9PH; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1Ush0pk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bWuXB9PH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A0F2A1800159;
	Tue, 14 May 2024 00:54:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 14 May 2024 00:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715662489; x=1715748889; bh=mITp0G8VrV
	1nmhnvdrLCvhRf1Irp49E/kdheNU3LoO4=; b=Y1Ush0pkpnb19G6P9EVXJf70Gk
	qWSClYoVNBU6TxyXfiWqG8xDN6X0WnqpGXFhWS7SlKq2Af6af5ZGrTxSFwACXFyO
	W7574Jkm6niRQzg3ml8sI2V1r6YcZYqIBvwGca9nvBtAp2oyGvAp75U042gUCAER
	t9ADlMZXOLDQjIslcUqMQjL6d9IAleDhlfMOqX5n53WEfnIBzr+EM/mDwwGHimqY
	byWagcf75qtq3ft6i7E2GaUjRm6mvWu4w5DAQvcTZ9EdmtQ+HgB717H8RjvZeRuT
	tOC++kuzRXJFBXmPB5rVnNGAdiakAfJ3JHulhBPtEcRkz3mV/alkS/teODMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715662489; x=1715748889; bh=mITp0G8VrV1nmhnvdrLCvhRf1Irp
	49E/kdheNU3LoO4=; b=bWuXB9PHU4Kx3CaYX552AF4YzPR2KS1zkNoYAPG2FfN7
	7+6wC6Sb7wc6rW50p+uLl4n8bRTD0kCQzUzXJ0ySTVuO1GhqhYOujA/xecgAvfVC
	LkkHKkrVZ7cinpPDpT2eBf3avJJWL4M7y47YT6YWR8xEWnzekaRHyYfWrO7B6NCi
	asNnDR0A45p/ocP2dYNRvkHvxRBOE2kAjuL7ORsvJnqb4iHbYKHFIjolBC/DCMFJ
	W3r0klZoc8gWgPSyPlsvXWYFJng4mGC7GhbQB4E4LhsnyZOTId7SOp2Ma0qxosJP
	DDskuq56a7weS6w5upz3Vq+6QGrxB0HRiymGK/d3+w==
X-ME-Sender: <xms:me5CZrvsc_c2PO5j86XvQBk8-njxoCZHOSF4b1FLvMDwIn-5wtRj4Q>
    <xme:me5CZsfpZTFoy6wgtfI2EoNtSObc3dcZgiEd9b-a6L-Nq2W99Lc4V90P9WI_ZvHrn
    mq26VWz0AIr0SxObQ>
X-ME-Received: <xmr:me5CZuyrQaWiwaxqq-ViZtW9l2NZLjHV2lvRTzPvc3uHoIOsvG-JOEACDZP67exuipVofxRENS4df8LYo9CcutnufnKR1B5eea80-TDYvzDGpI7Di9QC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:me5CZqOn38fGftKxoDxbR5aH6hyC4Wxfy0XDm-lU-zNZBTiFs8ORJw>
    <xmx:me5CZr-WXiuIqi7vktXwRMrxC2qrGtjcB51tLOV4jIuWnXG_AOeeRQ>
    <xmx:me5CZqVlsI1D5JOVYDVmeVXP1_OzGWl7AhI_tGUXy81y_8K-xRupyA>
    <xmx:me5CZscWJwy1ZHCueU7ezMrDaz8_C02NQ4HjjwxakQ7xphdm7mJsLQ>
    <xmx:me5CZnYX5BABzxhfKvQstjIFpSVDqIG3PYbFi0XV1VUjNTj7DVPkjKkH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:54:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8689d1f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:54:27 +0000 (UTC)
Date: Tue, 14 May 2024 06:54:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 07/11] reftable: use `uint16_t` to track restart
 interval
Message-ID: <ZkLulczNVfU3zCcE@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <05e8d1df2d9921426b803d71b22ba3dba188836c.1715336798.git.ps@pks.im>
 <xmqqv83hcp0i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ei8YHbFSeRrJa48s"
Content-Disposition: inline
In-Reply-To: <xmqqv83hcp0i.fsf@gitster.g>


--ei8YHbFSeRrJa48s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 03:42:37PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The restart interval can at most be `UINT16_MAX` as specified in the
> > technical documentation of the reftable format. Furthermore, it cannot
> > ever be negative. Regardless of that we use an `int` to track the
> > restart interval.
> >
> > Change the type to use an `uint16_t` instead.
>=20
> Not wrong per-se, but this one is more or less a Meh, as we know we
> do not work on 16-bit platforms anyway.

Yeah, my intent isn't really "platform portability". It's rather that I
think that an `uint16_t` documents the accepted range of values much
better than `int` does.

Patrick

--ei8YHbFSeRrJa48s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC7pQACgkQVbJhu7ck
PpQMSw/9EctUnDH+XZH12QYwPw1MzpXy+0CnNks3qtdrc+H0H+9HRS0I0jiaQrBf
6DmIGzeXuFGXL0SyT+gXuC0i7rI2u3/B9M/KWngTJ9RpGp/7nEsfg5mdAHKchjLk
jlTGRPd9mK0MyJhlwsKpE12gKKWaBDO5WRpinDD9fOVexQOY4+248PAaK1QLLEec
ClpEU/09us062Kr0kVfj3lwAnxvzoqrw7urttRVxGKtMFK48ZCITf7ENS7v5WMvB
nY6/TsjZKaxC0rz0iSdA+b/0dgMxWYbFWP7ROSGYp8hocteOvruIqAAfvi0rkiE5
bUcfBCvR3MkU1tc+GHz5aDM4JdU9X1RzxNQtvkvdoPmknCIVNw/BDPZToPuFh14X
pMiUWT+7YEh4A2yIjr6NrExjBeHRrh2QDnL+w8VGRXhH+WzlJ8l7K5AeTCjAmN1p
wu095jqGD9XCXkseViA74Pqin/8rdwQNuoS2PfwwZQE2yduCvDdnjDlClr5+aBW/
flh8jq6M8YCHHGeaJPpComaVAt0P0X0hVob6L/KNWOXPghCgEwPe5oR6gRo6jwcY
x17dfd+uJu660Tr1RycxOjkcUH7qmiBTtLHGsFlh7fSkvOG0rUyeQVIx345S87tx
NY8OxBJddGWH6siLCj0sGTbWG/CSh1SJOQ29a5SV9nxYuCB5N1A=
=R64y
-----END PGP SIGNATURE-----

--ei8YHbFSeRrJa48s--
