Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF438241E2
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 11:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577544; cv=none; b=YwnzLdv192HpNijVyXQyeEVwAoXdcBWPW/ZVk3cSanB0kpscgErElihxVGinQ108Zb0qNzw1pUcsUx4NH63OjwOcbXpX1yPMR4nbH4JAsV0l+iBQHaNOcwmzqVzeKK2VYc2vzz91o1dCJbAZC48UVLmQVPCO4aif6PZ/oODbt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577544; c=relaxed/simple;
	bh=1t9QeZO8o4BgNYtnYR+94j3kusA/GS56M1ptN3+i3FI=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=oDzW7QLIJOuP2SCLD8EPeB8zAZhjD9du7TITcHVdbH1VGwTY7Ww1B+HTWzCDhFdMcVsSzDQY4CKyVJWXJunwWlyeD96GSTH3z+oBsgchtVgePuV1bo1aIG1Lw/4JiLKLRTPnty0Q0OAfOERhUk3NCQVRViL9n086+fnT521Imjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lo/djn0N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BB6YabAO; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lo/djn0N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BB6YabAO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id AABD332002E8;
	Thu, 18 Jan 2024 06:32:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 18 Jan 2024 06:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705577541; x=1705663941; bh=M9kOtBVa/b
	ondOhtf1ByQMiBIeQXwdQLOJSXuHumyNA=; b=lo/djn0N04Q/nmEIw4sQ3Pgv8F
	fw8YOoxzZ2SFYB1OTY9wddz3x4GsDQ15sJsGnkDXVWC4ocrazHClX4ffDxLdEXIN
	yC85yTNlaqq4kdzrMMP/Pk/zLBsrLYjHEt89BoY9S6RhbapgTQoZV44hrPqB2g3O
	cqcjx4QaWmnnmLcO1DzGFrvA5+ellmwXU+TTMuXdQsUDjEtc/5Ys68WQ3F+RVvcX
	NReK0+dQQEVC4fWwi4QB81tvRI86tE5HMQ+J0QhNjlGPyIEOwWPiqUzTWlqELrIf
	VbwqOCd+CGnB6jH3xur3M385jfRNMzDb4DhLCc5WarkkUKBRB067UoEh9w1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705577541; x=1705663941; bh=M9kOtBVa/bondOhtf1ByQMiBIeQX
	wdQLOJSXuHumyNA=; b=BB6YabAOGfI1I3r3plWNK9NxiEAgf+kqgI7fvGJVP9Zf
	E0gh6MouxUKH2rYEu9t+ukzO0IIBJMt4/uxMv2nSl9QHPao5+1t+5wUDlL5nfjvy
	DlI6uLlraJ27n05taexyNvW/IbOeiSYcV3TskoGdzEsN0yiPV/Fnx44hnoKWIobs
	gmJsCCMkyc0od3sLEEsUpsTrLx/CItbh7cNI3KicQskPRztLK1N+pGH3jq+yfb0X
	075R5s2Gd2JtPmeIcHoruKPcdgu4J37lY16jcm1jSCm0U9TBf1/zxUFfLJnLILJY
	7DWCdYAoJofL+FPPC5S4RMNmEzXQ+Sz5qXtXL0i95Q==
X-ME-Sender: <xms:RQypZUusqpuCiiyK4pW3gX4xHW-pkfOd61mEVejarL3BJ9V_zqWvAA>
    <xme:RQypZRfakMWfWQXvNjckun2MmFJbQ2ZQrsqJPH68q8mpz3U-PMFDZ4nx938uXBoL6
    N8PUgmS_c-QL7LTww>
X-ME-Received: <xmr:RQypZfzdMTmSIKTPGbGPNu6JemHqf6n_XNTFzeMFpEz7rbxobG8qOSQJc8-4aV1n_Ijr6hNeQYCw9VvWXYNEk22TTX_Ixk6qxqm7HUWb3eApQvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:RQypZXNY35jKiBSLnqnfsVVIQKRtLZH0tjs9bXnELUX-G97fcWxyUA>
    <xmx:RQypZU-_10AUeDXV4nHaZorwACuhvrAIHmtfJtAVUMQWXQTzB7IU-g>
    <xmx:RQypZfUKeNGOBClxXaisOU7-4IcJ1y-IjAJXOe678eiXlqmqBolkog>
    <xmx:RQypZWLH188Z8RCREpM6zG0uO0jps4EJymemgHp8EVeJSvgkc2lNpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 06:32:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 50bdc1db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 11:29:23 +0000 (UTC)
Date: Thu, 18 Jan 2024 12:32:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 01/12] t3210: move to t0602
Message-ID: <ZakMQP3r44eVc5Dh@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <0e2b6e197ab2fbfc81a42fd601b6aaf41e38929f.1705521155.git.gitgitgadget@gmail.com>
 <xmqqil3rtqxh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ntb99gJtwEkhaYx0"
Content-Disposition: inline
In-Reply-To: <xmqqil3rtqxh.fsf@gitster.g>


--Ntb99gJtwEkhaYx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 04:40:10PM -0800, Junio C Hamano wrote:
> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: John Cai <johncai86@gmail.com>
> >
> > Move t3210 to t0602, since these tests are reffiles specific in that
> > they modify loose refs manually. This is part of the effort to
> > categorize these tests together based on the ref backend they test. When
> > we upstream the reftable backend, we can add more tests to t06xx. This
> > way, all tests that test specific ref backend behavior will be grouped
> > together.
>=20
> So, ... is the idea to have (1) majority of ref tests, against which
> all backends ought to behave the same way, will be written in
> backend agnostic way (e.g., we have seen some patches to stop
> touching the filesystem .git/refs/ hierarchy manually), and (2) some
> backend specific tests will be grouped in a small number of test
> script files for each backend and they all will use t6xx numbrs?
>=20
> OK.  Sounds like a good plan to me.

Yes, that's the plan. The backend specific tests will be free to also
exercise filesystem-level behaviour in order to pin down that things
work as expected. But once their behaviour is nailed down all other
generic tests should refrain from doing that to the best extent possible
and instead use Git commands to do their thing.

> > Signed-off-by: John Cai <johncai86@gmail.com>
> > ---
> >  t/{t3210-pack-refs.sh =3D> t0602-reffiles-pack-refs.sh} | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename t/{t3210-pack-refs.sh =3D> t0602-reffiles-pack-refs.sh} (100%)

Is there a reason why you picked t0602 instead of the not-yet-taken
t0601? If it's only because I use t0601 in my reftable integration
branch then I'd like us to pick t0601 here instead to avoid a weird gap.
I'll adapt accordingly and rename the reftable tests to have a t061x
prefix in that case so that they are nicely grouped together.

Patrick

--Ntb99gJtwEkhaYx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpDD8ACgkQVbJhu7ck
PpSkMw//bVHfKApZhH+VRupFBHBU3IdjfKwXSxX935zoBCCn5oiVC7FMh6iiwWhr
u//vVFqY4MOO86GAhlBmAFcE7Lg8pKPpmF+wDNK5jO8nPCmvCaoOaKLsovE6gGpY
B7UqVQB0mKZwswfUBdUBplNR6Oob4uhfYkV9Iy5qeR9v38/XL+x90/AVO17EF5TZ
XvbzSNmIDGzY5sDIolfzhxo4MVXLDI9/w4fQWHt1wuDavfjUzozLuj4tK7dH67jt
dvGXSNI6h5L4NyVQiKZwSVgp/9CqsEHxDX8pEV7Wki5qnQrDsSOUxSBj2B1M/7qh
6Ve9YTg04ezFKQDGiSk8+fkG3s5cyDzx0Oj7rnTj+uzLDSkyS6VRCo46Wkfag/F9
YbAZxJyaAoI3lhC29lkw4Mi4C1kmjuRUj27uAT8uUB0Ax73zH2YFYumC6GHzJ6FL
XVSx41+F8wX0wzNjJfqT6L6loXDZplxfL3kpRNGEGdVEOoZgWOsIcG16kaCXj84A
Tq7J8wevVsNz3zzVMd0TL2X5NGipjFHV7bDCyuu8xMpLZz7iTPaR0tDIYW/SNCIH
IbfBWQijsbAKnQuD1rRb75kT/Yg2iPvzJYMKNdHNISo7TTk7UqzVleSVfVYIMS8G
4R3nMjRm27YCLHjM8QuRcTati6kbRc661iyyj3RBqq0B8T0+jnQ=
=n/NG
-----END PGP SIGNATURE-----

--Ntb99gJtwEkhaYx0--
