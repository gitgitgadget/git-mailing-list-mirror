Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4638146A90
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586850; cv=none; b=D+hIh9JekdCy0i4zqEQFoHcildhaGZaQzKxNNo9Pmbvi9RkYLTTR3bMLMhazof3zSur7+k23YagFS34i3Oo4WlcQI9ejCWVhgaNOr9/AotGBxTBKvnw5+u6xCT41CcTu3zeJEmZNu5F+WFyvWwt+QNCIm2Ff/06djHMurT6Wm50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586850; c=relaxed/simple;
	bh=8LjAPzqG8IYCQH23r9P4qdlpgdWbnJ4KJmZ3a6Vtu0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+cu8/od6ar0irpi6IIqmnTwBLVuuiJAmwd21CuQiQnxediQyUjaoz+KkPIdd+MJuKvJt5ObadyEYuDr2YkaCCHBkbFidwpiM4VbnYSSv9BzzN6VGr1pdF0XW5ogHIrAHenPOLvUVMfTiTLmDC5z/498m15GP+poR0JUz+md7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joS75vP6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TstsdBR4; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joS75vP6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TstsdBR4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D5B851C0011C;
	Mon, 13 May 2024 03:54:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 03:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715586846; x=1715673246; bh=C30iV0HCQq
	00PeUzHLKbciMnYL5Kg4ZFjaOWZ8iUgXs=; b=joS75vP6leopnE9snwtfVPLACb
	c2B7WbMAM635a9gzcaMm77APRfD+JObFf+FMJW1vXvO0aEeisp3ogTtJEaIcxJ/F
	m2SFmEt2XvHzB3H7c8HRYTcukodTHIg9Cm/v0fZBgtrOYlHZ99wCHlwAtvBO2LX9
	UFZCpBTEuFBmp0GK5U7G8VLHYaiiR2gdbgTgQQw3CPiIb2ZvGav+8qAxfj6bCOXJ
	9Q5orf5VbfTTsVT44/dhCoquXQaibJSIx1gWvXVD21zg23XCfmeXHeSYPV8un5bN
	4FY1aOUzwdJ3aHY1Z1ZZVsavC53OMcwItBnKqtm2v2VFIPDlkd65b05bYrIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715586846; x=1715673246; bh=C30iV0HCQq00PeUzHLKbciMnYL5K
	g4ZFjaOWZ8iUgXs=; b=TstsdBR44JJF6eVGJ3BfE9NTbOtGlTST1QJlfWATxzRb
	1Hg0O1CHAAM9HHIWpPe8Lnx5tc4KZjs7jSRe47ZeH5KpfHS+VJeJ5i/FiOnmywUx
	XNKSDqumRC0tNj+xQuWE1gaGJlMMm7EEyH+Rzkoy6GwCYtXRXi9sT+kDQ1PG8yrW
	AALhZAesHwrQ0YWjhzSO0cbtQR3BUUvqvenpOC5asyAt1RZEbkPXc8zWQBvYl2dV
	aFeVrS6tmGXrzfS8BrY3IpIBzEb12Smc9KTwAM6gGcE+9AKgqVf7NTJ58yZ12KJ+
	HveqwNjDYe3dYkEy+mSAwsNhSgJd5DrXq3qfaBKZ5w==
X-ME-Sender: <xms:HsdBZhR167_wUoOspJc6lZwuVHqN3ZJ8Cx2-cqgAPo_9UTb4acjCcQ>
    <xme:HsdBZqzt1tD15CQSBD5RBP6Es9MDdEVuEMKRYbtqdIoFofCDaR669dfNiE0yOkDLr
    FpqifWxXVhn4die1Q>
X-ME-Received: <xmr:HsdBZm0S_D7Zpf8GneF225JF5goc2bjW10mFzsLx1vmfa97jn_aidgmoyhNrMSXOpdkldDAzxuVSMz8Rq0DEPhRtk-FBOQ4EJ-H_qlQv8ejSc1s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HsdBZpAyQRGYrag_Tk9eBfBeJsu6lUqdByFuEFVimKiqq-n0IexaOQ>
    <xmx:HsdBZqirM6WlC87RlqEBMxy_SghYfIelM1tPG_mGPwI5RXeTvXCsjQ>
    <xmx:HsdBZtqi_zKTtHou2pmhY1YwYP9olLb2PnVb1LJhL5_yTAPiTGpTVw>
    <xmx:HsdBZljEvQILRO1C006G2zlHBAYCm5bYl4SBRN4iDrcBLWhSPS3D8A>
    <xmx:HsdBZieGEpXoyCRoHzvyzPb2sk_OLIj4z7HsRRKTWgiCV5BrxJmmo3gw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 03:54:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f86c7eca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 07:53:46 +0000 (UTC)
Date: Mon, 13 May 2024 09:54:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 08/11] refs/reftable: allow configuring restart
 interval
Message-ID: <ZkHHGtbI2oyxNlhV@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715336797.git.ps@pks.im>
 <bc0bf65553c8dd89bf5fcaa592fc3427507f1993.1715336798.git.ps@pks.im>
 <xmqq34qp2uud.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vr/CkD489bCDfho"
Content-Disposition: inline
In-Reply-To: <xmqq34qp2uud.fsf@gitster.g>


--2vr/CkD489bCDfho
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 02:57:46PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +
> > +reftable.restartInterval::
> > +	The interval at which to create restart points. The reftable backend
> > +	determines the restart points at file creation. The process is
> > +	arbitrary, but every 16 or 64 records is recommended. Every 16 may be
>=20
> It is unclear what exactly "The process is arbitrary, but" wants to
> say, especially the use of the noun "process".  The process the user
> uses to choose the inteval value is?  The default value chosen by us
> was arbitrary and out of thin air?

The latter is what I wanted to say, but I agree that it's hard to parse.
And honestly, I don't even know how arbitrary it is, so I should
probably not claim something like this in the first place.

> Just striking the whole sentence (or removing up to ", but" part and
> starting the sentence with "Every 16 or 64") may make the resulting
> paragraph easier to follow, I suspect.

Will do.

Patrick

--2vr/CkD489bCDfho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBxxoACgkQVbJhu7ck
PpS9+Q//YtNgodkMd3ZkUfkfjUAKtSVK4qei2LPdxKGLoHQ/Ioc445aIFnGX/Qoc
064jSSoEFnWAqujCe4oXsnE/GoyzKgqhmbpjSb82lNSzABMRkjGQ4JDDbQkD8tMv
3UZGcR8E2YTFHHJV8sQRZy3SWpVwShm/ySOIId1In5lbx5/Gx7GzJooqufUGBPQI
LWeYVgf1oqEHb2vAp0CK2jp4Q8DfkE3flTSMAxh2xtnPBipORSGB+zkKnVBD47cO
wcVgMV+LmMPDHEg/eRgNddtajVdksvmx0sh+z0BRpPS1qWkK6xzVmE9IvUMSzFQS
NL1bxBqndZ3IGqHhmt2L9xWcdLqfPcka5yp/7qNXcfWwl7KCLHrdbPKomIwnlcdm
VWf2XaxNK99sSvc2A9HIPl+/Eg+Tdckvhe3wrlNCpKkC/70vPjqDFyZnGM8Dosnt
Dd5keKWZc4Pr8gh4PR9UvxGco6jhSWU7EKd5jRCqf5ft1892WSr/QFor870sfNaW
hoYOjgehOUAkMLJIpGv1r2kUHxCk0e93fsl3p9Jt1TmoUPK1VmpCHKsk9entnYpF
DbncokFJKTLBDOvagHiMI1AZOq/DUI5RhqgNtRag0MyzZ2ZrWDZ9ippfYcMmI9yf
LZVpmYAeS0Sz/az/Jkn1LsM+0qIKedgR+4QNykaiTE8GMAvSv1g=
=4/kH
-----END PGP SIGNATURE-----

--2vr/CkD489bCDfho--
