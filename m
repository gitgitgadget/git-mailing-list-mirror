Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB916A00B
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 03:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712634211; cv=none; b=WVe6hbK1HUkFTeLOppt1Xq33KJ6zwhytEncRVbCTAzPCFSqw94g/ZNkojHwtWx+Ggbxc1vhctIUvkYDGKYYc2FOM4cXKj7bVtGLOVKWmDwciKYCLXCeRgJnudJte3JP/e9CcfN1hNlkAL5oQceByUuV76iP2ixL/rWRoN45v9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712634211; c=relaxed/simple;
	bh=wDbhXQ/PWVcVNno/FXLSd6fgYR4RkacP5yxsVKrn+jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMSIPzKfJXxWBkgh5c3oV9600v+o9zNBqVOxnuSwdlYBwaQYZaPaJOa0nKJVbbUBLOchu4uCh1aFP4Nhd7GBZoyVeDVmuzxSHTKl9wlqYsAr+idI5haylIi/HIDZTD9zao6TN3cNV5FDbXyoVkadaVRp0FeQnZLg5jhpHHFPhMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QYUlkhA9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/oFzzBL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QYUlkhA9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/oFzzBL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BCC11380138;
	Mon,  8 Apr 2024 23:43:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 23:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712634209; x=1712720609; bh=IbfPsLf3Bg
	dnbO7SSS+rcJMHVlAfE44HpP6HLQp8VPo=; b=QYUlkhA9ryV9YDjon5+lCcSO8m
	48+t9FGR1one6c+TxI4/AQsa9Q4rbsFnUhO9Sgp5ZwgKpAJpou8ycAtv97uPuoGr
	SAilpIzXUjM4DRBkBPZx6nB9lV6Z5vMcFCsP1aXsboO3m8AmRvB+UFcS/15xTzi5
	o2gHLkk4QFXAlL4/zR1tuRbRPt4kpyRI3TURuGOSg5e7b6BzA4HjoB6jhmQxgLO8
	pZ73aaBSqRPHVNILgifr8Rd6Knz3fOSewhzGnEdEbMrGRurF3GNBBcvgxGnYm0/G
	MNO46rGwErgFa3ZnDQrwptbHDjBbrijiF5SJYv12inCYX55X10A1sm8wBCfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712634209; x=1712720609; bh=IbfPsLf3BgdnbO7SSS+rcJMHVlAf
	E44HpP6HLQp8VPo=; b=J/oFzzBLe1EkGapcxVcz4gSBYi/QPrFj1J1934sXtcly
	HV0WFaoXFc8c+rudzOV2PBQmj0vjmRzkSaK4XtGaAmelPgZN6b65cvy+KNrePOra
	qSBpinWCDV0cx1QfuhCg1O6DzgvKGFofdGNKeW07bG7i3DHm6eZCRsRoBtF5kdFO
	Q76M1d7+xPSlhshSnB7/fxmT2Ct4SN8dXvRteZpQy4zIG2DR6kHE0bJr1JPlofAY
	QqCRIv5riFYz8wMRF5CAK1yYg4U1a3ttsuCI4dqvj0wbEM7uTE+PidSDA76ieGAb
	3Vw4Z7sI3xPEcbnDYiT8gRrU1hfYhifcLw5n46KXjA==
X-ME-Sender: <xms:YbkUZhrlSMA3iPRq3him7fvzRRM3IYLaPipVa8Pb40OCkYmjZ3gJXA>
    <xme:YbkUZjoEzWRYQkooAfwT73BYxCdZKlPKg2308ovWv90DT_JrjaX280rs08sGOzD1f
    -DMKW74UTzBKW3AbA>
X-ME-Received: <xmr:YbkUZuNA70XNGFH_kuoqmotnTcAyClGODd7mzKRXGxRGr70VSsSvHK5G7iZQ2laIOje69XKzg_PTNStq-YK-FFbrQBW5qhumm_cfCQ-spqbyI9MCF5o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdfgveeuffffgefhuedvgeetkeegffetgfetgfehudetvddvvdeuieefleelffef
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:YbkUZs7-UavwnzmvzVLLKM8Isopi-E-80FHpZPQg7lOLOzOP-fK_Ng>
    <xmx:YbkUZg5WAmMgMSR7pfk885EJisi7X3lmMa4Vd7-TR2q6CR6KkJDDow>
    <xmx:YbkUZkjUHTvIOfn2LDEb5kUxoaoZ64pkhevwLnQ2AGZLzLdRz_JDhA>
    <xmx:YbkUZi6kaY1BwkYNS5-iEPT57hEceE5hGa1cFDUYR1wYsgJ1-PUPCQ>
    <xmx:YbkUZtvEgZ8QeGE7h_Rn_fMHEOx8JyEAhabfsqrzf1x3HY7tWq7S7wyk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 23:43:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1d85361c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 03:43:17 +0000 (UTC)
Date: Tue, 9 Apr 2024 05:43:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] t: exercise Git/JGit reftable compatibility
Message-ID: <ZhS5Ws7e0tjwlW6y@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <xmqqle5n2sbf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qrmU6BXoQJOhGHFL"
Content-Disposition: inline
In-Reply-To: <xmqqle5n2sbf.fsf@gitster.g>


--qrmU6BXoQJOhGHFL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 07:17:08PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > CI runs for this series:
> >
> >     - https://github.com/git/git/actions/runs/8595241646/
> >     - https://gitlab.com/gitlab-org/git/-/pipelines/1243766428
>=20
> Thanks.
>=20
> When this is queued on 'seen', I seem to be getting test errors from
> t0610.  I suspect that it is not a breakage in this series, but the
> fact that this series enables reftable tests without setting any
> GIT_TEST_ environment variables, that causes an existing breakage
> (or two) more visible.  I did not have time to locate which (other)
> topic introduces the breakage, though.

Interesting, I cannot reproduce any failures with the current state of
seen (17ff004052 (Merge branch 'ps/ci-test-with-jgit' into seen,
2024-04-08)). Was this on your local machine or in CI? Which platform
are you using? Could you maybe provide logs of the failing tests?

Patric

--qrmU6BXoQJOhGHFL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYUuVkACgkQVbJhu7ck
PpRj6g/8CbCdB+td8YUrY3nbNEb4yZ+tFMF+FnoqvGujCQNkJak207u6PWe5rNAm
UuBBQLsfxo9KY32U5sXgLvI494VCT2ScjFrvLsd3pVLAqpW0WSiDERpRBkQ/IYai
IrXjj4aztBpniSstf5YUFhdNKejFHUZCe26oBKs6liqgyJMwjILjb4sRPCD1PQCj
nge4ee9UGceEc68RbaUQYfDG25BNmBT7I3GqoEChTVM6DCmDmfTBySqMbepKdcep
2IsLYiG3eMOCJNH4BvWXau94GJqq88TkZ58603uGqWOTbA0cUrmLBfEmGvqMAlJO
addHQIUflnmfhCG76tXS/dr0U6r+qRfZ8aySRsLMEE5UsCK+jENz6jrYgig/oSDD
BeADGEgKBoTN0BqvnfzrlMGZmbuC+MXTU76Z8+RS95r9xrCx759/3y76yc2DIktS
+3QzHfQp0w0FzLNpfaxfGLfgJ4DO8+n/dO8LKNic2l3Ea8d8uznnJKvHHP+p7yud
Kk/zDPVi5jV3N5lNsb1hPHitDkSc1EWEWHH4Z1rkZdKeK8cXjc/4z3gr+brVaQxE
fxsMtWcJb9rcJ3Whc5jMyKX3JpHfLTebE0S/rrHv95Z/vb4BYfO7O5a0IJbCIsSw
ljtbuhUQiTOXNfftJHK7onfabxjcSWpL3jdBXuSS4Y4ssFRjD7g=
=RnSC
-----END PGP SIGNATURE-----

--qrmU6BXoQJOhGHFL--
