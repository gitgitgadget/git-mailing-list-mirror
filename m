Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598904502F
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722402372; cv=none; b=lXgMQIG0Oi5kRFKVc2i1nkd+n0N2YwmcOjyXiKkXAt3grogWPED5b83OStXoBjMSORA5DoTpWvMI9swQhD9YLtzbw2Jq6gFHU+eaWv58gj9QzyZgVVDaykr7/ZAVUjBHckgGp//1YY+m+ytfnBBQsl3cOukiUYxUHOG6gJqHw80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722402372; c=relaxed/simple;
	bh=KnYv4Sa7A/eR6FO4R4jppAz7x77xPwQ7SM5/W+YYLqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BestC+R3Gdq1h76OgJmK0XO8CtLoeLnlIzWTJdg/6VbUY3XaF33CjuTtSwd1IhT0S8xjiYXfFdCEnvzPHf6UzWAJTTpDVfoLDnjmH8LZzvpGBXiIljHc8f900pOiyiOGtTqnKP4NdUdjLFqCYQsjtEkQS4D+YnAFXEeE09grSKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HUo1zYKJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvoT4NqA; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HUo1zYKJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvoT4NqA"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 785F11146E52;
	Wed, 31 Jul 2024 01:06:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 31 Jul 2024 01:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722402369; x=1722488769; bh=KnYv4Sa7A/
	eR6FO4R4jppAz7x77xPwQ7SM5/W+YYLqg=; b=HUo1zYKJFmv8ZZXlR2mmrk7tFf
	tThSUx/Z31SSSvLOnYnrSTsNWoQZOwbPtODg/f7WCdRRklvPflJ1CCiPo5n+DA7W
	O2RdbKO/ogtLt67BBhaB328FPIr8ufXUxV0jnxLWD5pXadzCwJwv4bFjx+MBwpLc
	yiFXnwByVDLzJa7q4w4z96mhs0tIpOnioFJ2SBq68UDaiQM1piNwaR7mh90X4u9Y
	9juZdmB3jpVPVK5NzqPMdkumITJqvlKtnbrQyTRsmm5VXZk2zED26Mt7cxvS8SQs
	zTfAfoyb81f84zT+Qo37xqX02C51B/cutqbfvxVfiK/+uUghjxElbmXVHs0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722402369; x=1722488769; bh=KnYv4Sa7A/eR6FO4R4jppAz7x77x
	PwQ7SM5/W+YYLqg=; b=ZvoT4NqAhP7saZkJP/m708qrK1RCEGxtXn+ZsDJf2BlV
	AqudXurb2Th6ldcdqo0eigxcqIt9n28kI3bnfmEt8rU1FtDr5wDGuY7i7InZhb1o
	Bo1oPWJTaX8zFvjnzirrpZWyZQxzx89HLJhf4XcQ625+mUAiTsVicG7Ce0y2O7hw
	fRJBAR5hJe5AYXgsqoPM6e2jYCa2lA7JM0sX1gq4Lu53GjRD0m+bnYqPWqUtm2px
	OcDO4F5yLjJqyBfzQuYdWxO1a5lZtPHBVAjL0ygv3evZZdoTgV+E5OERKoVrk/v/
	BI4BQYoOp7pQVpvJkF5G6aDk0EWeafCcHua9UsF9hg==
X-ME-Sender: <xms:QcapZiYOFDS3M-MiogejDx1Y7W_o3S1vV5Hp95uBubyJ7O_DF17IGA>
    <xme:QcapZlZGPnhm-2YSzyqsTtTV-hDH8qpH4gTScXLxYn6oLFu6m5-_jpp1O8oVrLutz
    AcGzGk3n2IXmaoQNg>
X-ME-Received: <xmr:QcapZs-OXYi54lsXgHNLdckQaEyvdnSrL2K8P_U6d6tsOIE5DZ0JzGNgWO-XDrA8dETtoZ-dTIFkBXnnB5hiQj6pvJduVuKEXrP7ojEf7nncvos3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeehgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:QcapZko024uYTWeJi2rRkB2ve3C5NFOLT8NCaslswmUTaI4tkLPPtA>
    <xmx:QcapZtqDyxnIHP7xit1mvUJpDFBnD85L1DdiYIcLEeVVQLQZBz5Drw>
    <xmx:QcapZiSc--0Gg48gcDCd0TMzedMJZo4FIUUBD97SN9WfsDiwaY1sTQ>
    <xmx:QcapZtpkN_7sv7tWUMSdnjE1_fT4MnAN0FqlFHF5WqXB2tEbvWdjVQ>
    <xmx:QcapZk1ybeu859tUPj0z9DJKQvYkOaTI-mCk5UH5nl4Hzg-YtOAplnH->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 01:06:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e690f113 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 05:04:38 +0000 (UTC)
Date: Wed, 31 Jul 2024 07:06:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: stop using `the_repository`
Message-ID: <ZqnGPeaqsXd4GTGb@tanuki>
References: <cover.1722316795.git.ps@pks.im>
 <D33BCEL5LQQ0.33TQBJ9KVBMBX@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CJ/Rj1wZOP/Wx8dL"
Content-Disposition: inline
In-Reply-To: <D33BCEL5LQQ0.33TQBJ9KVBMBX@jamesliu.io>


--CJ/Rj1wZOP/Wx8dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:55:09AM +1000, James Liu wrote:
> On Tue Jul 30, 2024 at 3:22 PM AEST, Patrick Steinhardt wrote:
> > Hi,
> >
> > this patch series removes use of `the_repository` in the refs subsystem
> > and drops the `USE_THE_REPOSITORY_VARIABLE` macro define from those
> > files.
> >
> > Patrick
>=20
> Thanks Patrick, these improvements make sense to me.
>=20
> Is there a priority order on removing `the_repository` from other parts
> of the codebase?

I was tackling the refs API because I knew that it was a "leaf" package
that doesn't have a ton of dependencies on subsystems that may be using
`the_repository` itself. So I guess that the order that makes most sense
is from leaf subsystems up to the root such that we can adjust layer by
layer.

Figuring out what those leaf subsystems are is a different story though.
I typically tend to brute force it, see how far I get and if I succeed
then I don't mention all the failed tries that led to the patch series
;) Over time you then get some intuition for which parts to handle next,
even though I realize that this is not particularly useful as advice to
somebody not that familiar with the codebase.

Patrick

--CJ/Rj1wZOP/Wx8dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmapxjwACgkQVbJhu7ck
PpRU1Q/8CHYkMeF2X2qXteSO60iNN2Bk2PIERkr2lOBck0cTQ+hRrZAACnVjvLtf
wFWInZsPr34CDVmRtFu/K9JHJJ74EaaAJVuO8NJvRksC+lyVxhxY3U5hxRiIRUIq
0zkoUuFXMO4zGJXuZfTYoruCV9ESvzSwZtNC0RXe8LZI8Y3PbUixtikefrv3yC9s
lPPj1qbq+NCDgP16peOgh5HyWztDMUclDv8dvgmlZF//A15XkplfntKJzSfV44yJ
ZmLrmaWcRTAMDzOKxQmXvmJB7gJlXa8NFbw0BMfVlm4gZ0NOzskPKhI7fAcO4Zut
JO3OqcVbMSmoEgjHCFHYSHTD28QhgjppWzWNlZK41taNmZcUCcjCC77T2INsx9S/
pYk9Bt6AYzFVMFoW3zr8+wBN/pNRBQizo4rWtYknioP37RbhCBsi1MSv0x8TdEAI
gXHbIosMdS1LXn2cpUS6Yt54/riWkxR6t/wpROse9XETvmdQ7W1qUPxv2WDH7Eit
WpXivxY18nCf15V8Z4CpKjX0vvrFm5bqIakr5K6H/hLhFxY0bgDAW77DWQPD4LW/
gMGwLW9BMJJfPADEproZQh+XW4UmOdRLhs81/9y65VvjPRfNvfeyFLutVWVEA2s9
CKy4nJV6BADz1LciMbCc1bgXHrRZai/Su3OqJb/Ldoe8G8vGWYs=
=NdA5
-----END PGP SIGNATURE-----

--CJ/Rj1wZOP/Wx8dL--
