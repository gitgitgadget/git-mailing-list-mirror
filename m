Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6739FE0
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708496367; cv=none; b=QKOMWdbf50ZDhifK3eMlKPQP+14CaRs5Lj+/r+g7HK6IldcP/vFp2V+cmmpw/s/Y6Dv23id2xDjPcqGEZN6reYe10siBT7X5WNXn9MibaVkbpmVerMm7XGgNNA/p9ApVblozqK4UtinU22q4OXO1TiCBcNSjR17KJ3BuI5Txblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708496367; c=relaxed/simple;
	bh=4HqktaEqmVQANvq8TVWr3Xa8OAxjMPet7fGBqoFME/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUpgkRKxFV2BsooVPtDmcaHbbIw7HXtTTu+8FXB7iSXM4lajVEYiFnzyLaKOKgpR6zo952PrROIIHvwI0Y3F9IkfSgHsYUo5IHZAjvb6DXKU/XyPo/fOsqMvsDyrIZpRx5nRd+N3IbK/h3xh5pG6QIcUnVD3cVyQY7omn/mx0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzPPG73K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYN8cMs/; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzPPG73K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYN8cMs/"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A82EE5C005C;
	Wed, 21 Feb 2024 01:19:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 01:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708496362; x=1708582762; bh=4HqktaEqmV
	QANvq8TVWr3Xa8OAxjMPet7fGBqoFME/0=; b=hzPPG73KKONwSuH4LBs/j9nvI0
	0Ttna9IeJ2AO/rryVp8rJgx9HZBi6b/KYX7CocrVtPD3zoks+DZgUPRnkic8JNg/
	Fycweh0HhodPj8DIeq4xFanXP5+S4yNhijS8hHsNyWi1ey2jcYV87/fARL5nXTBm
	b2fmkFeTaOFeCl9x4jb99T1rv8ioCmdJNKqU56U8FcUjx9iwVj0Fn2G8ISqZ2IIH
	FUuurAAXhtKfUScmCEFjpVGeyMXWV73XLvxcRLFW54HGuqLPNEnOBkmxjn0s7gE9
	slTknXfirljSXcwyXyroles/jPsYBQ031mAEcF98/bsR+ojQAgwLd9YLWA7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708496362; x=1708582762; bh=4HqktaEqmVQANvq8TVWr3Xa8OAxj
	MPet7fGBqoFME/0=; b=jYN8cMs/k12ERW20qDKLl15f/z5+O/2nIHoGjxypKC4j
	QSbonifEWc88OFtzjlPFHHGt0TeWjafDE0oDSpAWtxf0rM1FRh28mX7kk915MT1x
	HrpiMY41eJvsdWrUfUi7JLmwCreVyWbntqQUjjan7Pf2AgNs3/2JATKJ8QmP4RBc
	+cPUQXb3nR22ZBMz/DRJJPtK+fF4JjgZMu+2UMivNaP8g1KYQ+ojWdnX2KpSUjRZ
	WFQNngHpyT6TmUerMsdyMx13BajaPOHD9ADPL+wV8BI52nCfVcfNAnIn7y0AQcZG
	OuZFPpEJPGiVr9frVG9NbrAj9W7+mRQ90MwWtOR0ew==
X-ME-Sender: <xms:6pXVZRQQHs7_eScFQ3XqqZRFKiUZIiChr9-RaG6Q4TlforVxN70Hhg>
    <xme:6pXVZazspDeK0XRJdAtS_rkf9CQ070U7rJTL3uVyIfIvIFeFoJmURl72HiUJuC0Sa
    FBbwVLkNctgoPeisw>
X-ME-Received: <xmr:6pXVZW2lyyt5RZ1qcGkv8RYZU7TAlk9DptbkX0diX9zPOrQkYmq-E6m7tXkBn1FcFFl-kiaRIazx747Mis5UzCGRz1X-cykay0JQikrjEuYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduudeludejudefteejjeelleeuhfeigfekgedvudefleffteffheevleeugfeuuden
    ucffohhmrghinhepghdrtghonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6pXVZZDJtOeEd_ss7g2I3oNQ6dKnXvCG8fEKpKffjFImMsmFAY9P0A>
    <xmx:6pXVZaj2FAKh2EfJXawJ_N98BKcthNNPiNqLCe_y41E-2_CuwZB22Q>
    <xmx:6pXVZdqRTkx0RCCiB1dVUq1DPjkwx1d9tSk-188SCSTtCBFM-26xog>
    <xmx:6pXVZVWiPwZpN26RpEWncfdLZmwiJl5_yunmhnZgeFhwl42Oo73Z6A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 01:19:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b436a565 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 06:15:14 +0000 (UTC)
Date: Wed, 21 Feb 2024 07:19:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
Message-ID: <ZdWV5ACvZWxrWq1y@tanuki>
References: <1de82b27-116a-450e-98c0-52eb65a8f608@gmail.com>
 <CAP8UFD1VAvnkM6afZvtpdXhA4csDBDwMnF9yUzSx_ut-Ypf+eA@mail.gmail.com>
 <Zbi8pfvGpYrlZXAu@tanuki>
 <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
 <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yGa2jubW3kpivQpm"
Content-Disposition: inline
In-Reply-To: <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>


--yGa2jubW3kpivQpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 10:32:25AM +0530, Kaartic Sivaraam wrote:
> Hello Christian, Patrick, Karthik and all,
>=20
> On 06/02/24 00:09, Kaartic Sivaraam wrote:
> > Hi Christian,
> >
> > On 05/02/24 22:37, Christian Couder wrote:
> >> Hi Kaartic, Patrick, Karthik and all,
> >>
> >> Thanks for creating the page!
> >>
> >> I have just applied the patch Patrick sent to the mailing list with
> >> the ideas related to reftable.
> >>
> >
> > Thank you! I've now successfully submitted the application for Git using
> > the Ideas page we have :-)
> >
> > Let's hope that we get selected this year. We should know about that by
> > February 21 - 18:00 UTC.
> >
>=20
> I think it's time we start being prepared for potential contributors who
> are interested in contributing to Git via GSoC. ;-)
>=20
> On a more important note, we need to assign Org Admins and mentors for
> the 2024 program. For now, I'm the only Org Admin for the 2024 program.
>=20
> Christian, could you do the following so that I could add you as an Org
> Admin for the 2024 program?
>=20
> "Visit https://g.co/gsoc site, click on the 2024 bar which will display
> the 2024 Program Rules and Org Member agreement, read and agree to the
> same."
>=20
> For mentors, as Patrick and Karthik are new to the program, we need to
> invite them first and only after they've accepted the invitation can we
> add them to the program.
>=20
> Karthik, I was able to get your Gmail address and have sent an invite to
> you. Could you accept the same after reading through the program rules
> and member agreement?
>=20
> Patrick, could you kindly share with me your Gmail address so that I could
> invite you to the program?

You can use my GitLab mail address for this: psteinhardt@gitlab.com.
Thanks for handling the administrative parts, and happy to hear that the
Git project has been accepted.

Patrick

--yGa2jubW3kpivQpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXVld4ACgkQVbJhu7ck
PpTcrg/+MPfovhwXtn0FP98zRVBM9CzfQwCJmThTJqOKVNnzvVO8NgmUB7QXPMsn
LLaS58Ks6WtiCKyYxSjFWSVFWu2zUsysVCf95QPrGJhVurgDdYbIEvW91nvXfBeG
OTReg4bnmAtg+WlyP84bDpy6KHmKVk8TjXQ58NMFMPiRLsQMyT8VTqcVwoKAPWGY
1guzJtRCWxiyLkN6bB40bDmAJseZaKX19+Y7Lxk0eODPj2yt6LUNJ57B8mA6bs93
9b1hEztL7Dc0fbFjAO6+Z1oE3cQFtwSRShMLPOm0Gio3/lIT6ZYJraxFBtUb8U8/
4g7vynFNPaUjBIM8sLksZ1H92HQta5t3RwmT8N0QhH6j55ttlpgcqVxfBKwr188h
kA+Tock3E7NU7wrOGDMhinS6r1ekCrBgL6/4Ma3cHjxUMPySjpYHS/dbycSLOL/r
rdpEx/nYBqfZwZEf8FnNB5cJamGEpuB6DbI2BoaUCMWqZfvxNyt7xD2t7/D0P77B
08aZTl7PDbzjoYbl4c3fnmkjQmpQaDVb7ky1pvQIDu4k3fAxQEL7q0vWHQ9p+RoH
LXXD17tdaYa9k736zvHNvwklSub1LwRH6thXTypbm7NK83aLIPDOzZ8mTgxh1qfG
HhyBErEcmx9sYIZ9SOo1MY2p/VOopip34NlJyd972ycAN/mBtjg=
=V/bd
-----END PGP SIGNATURE-----

--yGa2jubW3kpivQpm--
