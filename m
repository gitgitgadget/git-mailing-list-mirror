Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719253AC
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419296; cv=none; b=EgHTYzHb1xRQmJcNUhG/leOozYB1PvBRsRBKOUChf1y2eeSOGR9CqAliqZJaZ0zqgWkdsebfb5Kp6733djero1hudYu0VbFubfl9T4cTmGfRlJWbYVP3WRBGswTOdw0tdziP1flbcDe1sVKfb5Rvu6BybMLbKfySljUZL4fV7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419296; c=relaxed/simple;
	bh=t+ln3pMalIpXgetm1WD7APZrbrNuOkPAkWvBSCPPLEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fi7WXrhkYSt3pGrNIon2zALDEc05H1MhNNT05XNIgSCp7b2JkGwETIPX9O61PMlB81iUxqqGy5bDzQjcH88OvwnNEQ+kbHF02+6/aVwLs8OSs22uvLtk04+N46m+rf3AwergDuVWeKeKKNP4jHhUmk7ZRHnl6d6omiFZ6s4dbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sJ+deU6D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U4etRpjX; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sJ+deU6D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U4etRpjX"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 786721800171;
	Thu, 18 Apr 2024 01:48:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Apr 2024 01:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713419292; x=1713505692; bh=u/0owMAo2Z
	/HCSFH1LC07Psv9naVagZFVNFIuxyGxm0=; b=sJ+deU6D2tlShvvHFd5yZFBq6t
	6axFuV8iy3UsbGfZV71noncjaXEb+51GbNLuWm5+TB6kQUPQlUTScMAQgezMqAU0
	gkQAuIDWtYD/VTso64y9yOpIbXk8GTCLj8KHRQymWzyJYkDgjGlyBZeHcc7cM9d5
	vkwjG/++9BsJVcCnTHcC5L5zaSWLbDRPrr+IWxKWZBRnsi/cNmbFlGzFsQScToX9
	RlsrtOZhCUksKEAxZ28JhIc55AAo6LoQ2rLioYsvYKMpDNtpP3W4bWEiki4UH4f5
	6I5I9icR78fr7nxYairXJ4AlcO5ILMW9mI4oA5OwqHWs1J/mMdA979vX1Kyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713419292; x=1713505692; bh=u/0owMAo2Z/HCSFH1LC07Psv9naV
	agZFVNFIuxyGxm0=; b=U4etRpjXGyo3HmQVYMTygAyPSBMt5BKhyN9fn/dTPoe/
	ep5ezDnm1XJ5M2cYd4lTt7YemDFa1Ie6UySp50+rJwlGv1kJu/eZxcHqjrbREUK+
	Ue3MIzO/4p/obccI6eJGzdYuYqwBgpnmB3gsi1uRhGZM4SjQvgq8kz8V2Zvkn2Fh
	H3qC6segdL6eTfEzHyBQHq26iQM3EKrEga67VNwWmhs/bQmplqRPhv60GFIXatV6
	Svt2RqOJwjU/VgXZb0pyZmA8opaNk5K/JJFWbRC5yFUZHiRUw8hzZkw3Ao7Spg7M
	oL59bBD6hF1xvdr/7Q6hGRD9JqraB9/UbQSfRPdNWw==
X-ME-Sender: <xms:HLQgZjNfn3dPdaQdVV_y6rPj5jRVwoiOcMREGq70EC8fGSo4YC7ZVw>
    <xme:HLQgZt92XWO259WqCmAsHchVRJx68G5xOU9X-QXUQYjh0Vq1gbtT72EWF23BJdGwn
    RyHNzmQwc3_9ehbqQ>
X-ME-Received: <xmr:HLQgZiRPjDateDCW7EdvpFJcUyzGlIU-ytibjx6XPFws8fZG691UznMTzFexR5y8VwvIbhWQDqRrRUPcDs75tvoLk_ewOQVfQ9pdpU9YdSIv0rlWLg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HLQgZnt267pPFGYXOfBxs0e9bLT8Qv8m7XIkh13UkBZaD-Cb7dvpyA>
    <xmx:HLQgZre4W0KvI178OWI0YsiKxSD_JsL4rWtDD_UP7cGXC_cVvfCIow>
    <xmx:HLQgZj2snCSZGaKn7CTsJdGVIcfNjVbR3YcjUmsHHTAKkUQojjE2NA>
    <xmx:HLQgZn-1TXpVvtmGZsqHeGk85xBypoy1aV5mEjvHUTC0QatiHw9_HQ>
    <xmx:HLQgZn58pbTyR0tFrn9_oLBtUKKHuvpSnJxfFlefjTXtQzIgYezUi7X_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Apr 2024 01:48:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 26f37feb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 05:47:46 +0000 (UTC)
Date: Thu, 18 Apr 2024 07:48:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] run-command: introduce function to prepare
 auto-maintenance process
Message-ID: <ZiC0GEnlxMOjst9w@tanuki>
References: <cover.1713334241.git.ps@pks.im>
 <929b6bfa08132523ee97f5adc376c3600f779a99.1713334241.git.ps@pks.im>
 <xmqq8r1c9ea2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PY8O+gvmCHbSkIcB"
Content-Disposition: inline
In-Reply-To: <xmqq8r1c9ea2.fsf@gitster.g>


--PY8O+gvmCHbSkIcB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 08:53:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > The `run_auto_maintenance()` function is responsible for spawning a new
> > `git maintenance run --auto` process. To do so, it sets up the `sturct
> > child_process` and then runs it by executing `run_command()` directly.
> > This is rather inflexible in case callers want to modify the child
> > process somewhat, e.g. to redirect stderr or stdout.
> >
> > Introduce a new `prepare_auto_maintenance()` function to plug this gap.
>=20
> I guess the mention of "inflexible" and "redirection" above refers
> to some incompatibile behaviour we would introduce if we just
> replaced the manual spawning of "gc --auto" with a call to
> run_auto_maintenance(), but I would have expected that will be
> solved by making the interface to run_auto_maintenance() richer, not
> forcing the callers that would want to deviate from the norm to
> write the second half of the run_auto_maintenance() themselves.
>=20
> > +int run_auto_maintenance(int quiet)
> > +{
> > +	struct child_process maint =3D CHILD_PROCESS_INIT;
> > +	if (!prepare_auto_maintenance(quiet, &maint))
> > +		return 0;
> >  	return run_command(&maint);
> >  }
>=20
> But given that the "second half" is to just call run_command() on
> the prepared child control structure, it is probably not a huge
> deal.  It just felt somewhat an uneven API surface that 'quiet' can
> be controlled with just a single bit and doing anything more than
> that would require the caller to go into the structure to tweak.
>=20
> Will queue.  Thanks.

git-receive-pack(1) needs to do some magic with file descriptors and
needs to copy output of the command to the sideband. I first thought
about extending `run_auto_maintenance()` to support this, but found it
to be messy as this really is quite a specific usecase. So I figured
that prepping the `struct child_process` like this is the nicer way to
approach it.

Thanks.

Patrick

--PY8O+gvmCHbSkIcB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYgtBgACgkQVbJhu7ck
PpRhoA/+LlbgR08albSJABNFEj6GvE9NR/bVLSB1tuyByT2lBdxG+3Mg+0ucxwtV
mpkzlzPW2MAVomdV0aFTBvVa5vWp8RI5NZp2LSOmDrH5q/4nJLOdmADsCGEkZljE
r0QNF1RQj/zy9HgM/6VIVq+4JdsWUs/v4tbiX75KzcxqD6q4Q/7lfBAnpdg6C8In
1NoyyI4WE6DMpjiTpp76PvMuOhXId/mfNM2q2+Ww1HiFRAqdw+alSxTGtVEwU5bp
VjV0oPXL+Pvlls5laYwZoi57ZAVjuvbdbouyVdC0SeRkwKoyP6Lw6dx9mHcuqA/w
yah2jbRUgMuCwKIoYslxa4+V4E++2YtO4Nuz2Y5sy27Li3uhdCYkKsXLq658zyVz
yFp70dptxhkLjO5U6VQSwUm5XIsLcUqU/EurHHafFDG2yVu/tQ0K+r5a7Sy23qFJ
xR+Yg9t03siQbgTUgYVO6OKrkl4y2d2uh7q5kTpL8UNwg+2AimcNUREU+PPtsHGT
TAwHbpae8aLyV0slCfe/GK+8j9QvZ/hC+fUix/l5bC4G0mEFszilWb7VQbYXKlV2
NCfAVcIXaAGokyF3AuoAgGmmWQGB/GnX91QfMnDgTTi9Jvmv9ix6EBCVIQvtWaRU
DztaeocgStRnSAgGx5fS6/bs8H7UCazxFmisGsEddteGSlFmh+Y=
=Lpfj
-----END PGP SIGNATURE-----

--PY8O+gvmCHbSkIcB--
