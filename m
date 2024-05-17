Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D547462
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715934829; cv=none; b=kT+CA+knWNQ7CSQnaA6tigOJdM+74EvGNg3EfdjB+xt59s8iE3by8i9iBlPAwtJzmAU2m5h3/+p9jO+8HQESPI2waxXUEMThWRIl/LJnazkrX0kXU8EckIgsO5slT8mhb3GSiFc4x6LNsQIgIqgeKMC+uGtS+VOgP7rbeGI5TJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715934829; c=relaxed/simple;
	bh=fOUOxcIIk7knOtlgLMLDH5vqYhSsT54tWVMm8RfVBDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWEoNnFPSYzP/h1Fq32suwVrZOFgo7XVtwa6IOjLNR65I28zAA2e4djsCtZqc9Kz9ZnI5qUr469/okcDWCjCu1vduPwLgqAEYS6o17yiHy9dTdzQy/c6DhX0uMOTJ0X08s/WANfnszLtcEPnZnKJ52dWo096LEgZ/vja3yKf+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ETL9h8oc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IPanUSTT; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ETL9h8oc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IPanUSTT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8324E1800185;
	Fri, 17 May 2024 04:33:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 17 May 2024 04:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715934827; x=1716021227; bh=oZtNF+Yo/+
	VeuYBpJU1Kg4WWoMTKkFxxjTxO0k9xXIE=; b=ETL9h8ocWL1wdRVvPKIJ1s1vR7
	cuYGi4KTr8bcXnQymXOzZTceVfy0dYu0NOFLDhsHOuLWx3d68xu8wDoZAKv6aI/J
	QiGuKapp7VWYrvjviIZEPySiqoxYt1h0JJl3n06BAjTpvg6d1yETKH08rxNmXyD9
	AgfFs9uLkSLT4flwuJEOJ/1Lh84C+xog2IABvNY7USvT5Q4rFqUQx1iESoRDDHeF
	EDZfTLZ3jfzvS1xCPJYA5wR5Osda0UlzrvznrGuqkd10DPV5DZ3sVEO8pbooFCWL
	ZsN9pHDVd7ahG7j+SdcN/zFJHyT0tlSn26hhubNApAmucc0Jd/t23C88WSZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715934827; x=1716021227; bh=oZtNF+Yo/+VeuYBpJU1Kg4WWoMTK
	kFxxjTxO0k9xXIE=; b=IPanUSTTxBn59pNOOHl0vEEsss/qVvkkS/69b1W4+E3q
	1MWPurMIm/OnfcmZS77AYY4IdeYSw21zOVJwQEtDhXTlRlhfXnFyztKfwc5o1Oaw
	BR1amJGMy07Xy6bxzy/IshFdzgpJrSyR8hCM1neI6Zbaj9oUCMkfAkaI3tXzqGhD
	JdB10hz0J9IdkdC2w2xXJIdx/PQjkQKgUNENFKx+WNHz4RGBDhq3JbhYcTmEHRov
	pQbGZa0L0Qn9ob9qBgJHgz1yE6HvPd9DjDqNlBH2TsX9fT/+Hxfxh8WhXB7x3C4d
	lwI8NoG+cpv0i6xBULQK+ZrM0qLw8frv2LnyuOYY/g==
X-ME-Sender: <xms:ahZHZifT5pU_oFIMxJG-rLAFx02Y6Tzztn2JsxRUOBXACI6JC1GIHA>
    <xme:ahZHZsMN5_Z_gcQ-HB1aHvClFw1wB3i029NuxkOkx9BygI3Uvz0o36xD4Hm4QszK2
    ENNXdePyASHehBang>
X-ME-Received: <xmr:ahZHZjhm4nfJqu2yW-dAG__1wGOcF4b37kLx0YQRpMmlJYR5Z7Uz35aY5HnL1T8dK-j9MUY_OqweFOZmf4cHaQD-GITxz2xpuxyDzU1Fn22BY-WYiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehfefhuedtvedtfeeiteeugefgfeelge
    elveehffeukeelfefhieekteevudfhffenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:axZHZv9Bv4NDQJNZYd-h0hy4m0aCVGS-L_XH9JS286o0agKTgXix3g>
    <xmx:axZHZuv3ESOQlUCtZC2CFjZVly-uDyuNqI1H8DadUQFDtCOeLKh4LA>
    <xmx:axZHZmFN7uqVr1o_eJcmHMVdZ4GE1SkLx5Lb_Iq5dGdXWWI9V20gIg>
    <xmx:axZHZtOpBQcThECxLnrtnxXkYrcgVsKhrpcI8q70bQJoWnRLtdLRuQ>
    <xmx:axZHZgKApVmp9I3KZN5v-u71pO2tzsQHbKnp3twVjt2bPoR-YeAbbGUZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:33:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 058edf66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:33:17 +0000 (UTC)
Date: Fri, 17 May 2024 10:33:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] ci: avoid bare "gcc" for osx-gcc job
Message-ID: <ZkcWZncvfmoKGyKx@tanuki>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162415.GB1708042@coredump.intra.peff.net>
 <CAO_smVhE25ZQqc1f_fx9oPX-kH8SHxwEc=mqOAi-xQ91+pF1CA@mail.gmail.com>
 <20240510220228.GA1962678@coredump.intra.peff.net>
 <xmqqseyp1dys.fsf@gitster.g>
 <Zj-pGGGJEXlH02nR@framework>
 <20240516071930.GB83658@coredump.intra.peff.net>
 <ZkXX5MlN3EbaMhNG@tanuki>
 <20240517081909.GB1517321@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yosCviGgXaE9tft3"
Content-Disposition: inline
In-Reply-To: <20240517081909.GB1517321@coredump.intra.peff.net>


--yosCviGgXaE9tft3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:19:09AM -0400, Jeff King wrote:
> On Thu, May 16, 2024 at 11:54:44AM +0200, Patrick Steinhardt wrote:
>=20
> > That's certainly the biggest part, yeah. But I have been hitting lots of
> > compiler-dependent behaviour. This is mostly in the area of bugs though,
> > where for example toolchain A may initialize variables on the stack to
> > all zeroes while toolchain B does not.
>=20
> I've definitely run into differing runtime outcomes for undefined
> behavior stuff like that. But in my experience most of that is
> consistently found by ASan/UBSan (which we do run in CI these days).
>=20
> It's possible there are cases that those sanitizers don't catch but that
> cause differing behavior. But I can't think of one off the top of my
> head where that has happened.

True, these should be sufficient indeed.

> > I'm not sure whether this is sufficient reason on its own to warrant
> > testing with several toolchains. But we can easily combine this with
> > additional tuning knobs. Two separate test jobs with GCC and Clang are
> > comparatively boring. But if we make it GCC+SHA1 and Clang+SHA256 then
> > it becomes more interesting.
>=20
> Yeah. Combining orthogonal properties into a single job lets us cover
> both (for the common case of success on both) with less CPU. But:
>=20
>   - it can sometimes be hard to figure out which of the properties was
>     responsible for a failure. That was the very subject of the thread I
>     referenced earlier, where "linux-gcc" was "use gcc" and also "set
>     lots of knobs".

That's true. But for me the problem typically is that you need to be
aware that the job uses different properties in the first place -- this
is quite hidden away. Figuring out that a job uses "main" as default
branch just because it is called "linux-gcc" is quite hard unless you
are aware of how exactly our CI systems work. And besides being hard to
discover, it's also really fragile.

I wish that we got rid of relying on job names and made this more
discoverable. The obvious way to do so would be to instead declare the
`GIT_TEST_` variables in the CI definitions, which would make them easy
to spot and change. But it of course has the big downside that it is now
quite easy for the different CI platforms to diverge.

>   - they might not actually be orthogonal. If you care about checking
>     runtime behavior in the output of two compilers, then that _could_
>     manifest only in the sha256 code. Or as you get into more
>     properties, they may overlap in other ways. I think reftable+sha256
>     is an interesting (eventual) combo to test on top of reftable+sha1.

Yes, I really want to have reftable+sha256, as well. I didn't feel like
adding it back then because we already have a ton of jobs, and adding
another job felt like pushing the limits.

Patrick

--yosCviGgXaE9tft3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHFmUACgkQVbJhu7ck
PpSEWQ//ZX4k60StLAUaksBgCd4K/X4nMUcWfdCoDqrA5IPHULbSVmdE8VbHIKKx
1VvZSSirLnSiU+ZVqB9rkIrkvV35NDwLrWgOS0TFhYojv9P5VS1kc1FHoQ5KxwH0
SEH+gI4cmmQGTV9l/W4qgc7vmwR3nS1ZudvVoAzbc4mTk72q92qYMDdsHz7z0ZcW
VQrKC9gU0T78b7fdqk5J5pDryoEdUgX0VM9ot3dP3ZJ/6Ib+dFXMgYs0kXWAiK7w
eIvlVO5WuBiJKjbyhJQfJngPiXaWW7eFX30nXCS+DusneIFO5S6YQtJewiBtst8t
PaGkK+f46oYIjJj3VBOp5IcEYc7HT6ruE7Z/TyhIe4bB5ccwrGOP8fdk/hMr7T7w
e6LHnm8iTcEqtzyL9eC4KWjl0Ku0wGMmO/p10PlIa9jfU4j1CMe3sJlzp6DJiB+1
Gzl7faR4zuY3PgJIALMM5fEBqYoDo4ciC3S6qErASHHRCIbOBHLWyxt83xIoS8s6
Xch2IfiddDBIw+Qr7PwId5BX0i9ro1ZlhUk5Up3gC+z6c8+oz1NqkE4u0NlV1HMq
6N68M1Ll2sJSehtUVCUIiZwTwd35tdgtXFBPOHoWzwJA2Euszps1zJJ7zBhFqXOF
Pr11U8ZDhc0U4xvPTMzr0UUf5Ne19Z/Xc/1puIOdaZd/+r3RF3I=
=kOYB
-----END PGP SIGNATURE-----

--yosCviGgXaE9tft3--
