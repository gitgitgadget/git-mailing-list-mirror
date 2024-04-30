Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB9517166E
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480442; cv=none; b=Rl4AidHjkEeE9J4Sa/Gvi60i8AIYfSo4e323QLnsYzg51i11b5MKKAPpJCg3OtybXKHQEnbRP6MrOu19iubZLsq6Yhq4fVDQZFG/YXIM5d8x7ZuuYnIMGBTnlRDQYm3cE8lV6ox0yBUNlNm5EBc30raFVps1EHdXxHn/3svhG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480442; c=relaxed/simple;
	bh=r870XG+PhA+nFSf3+g1UIsemTag+xGPYlsJ9q7L1RCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKNtzuYC+J8I7H47KrA16Z88GkwfVgU0Z2/a4cWfF/wLFXEdIgv8xJdYnfM4Hng20tRITJOb1+v2RGG/Hkreb/oPtA/lU+qTSpvvLK5jObyVkK69p2qGIwrgSMuIlJ5nmPvReTLLN6lke+fAwmPzLLQvoLOf2yG61ix80opG0mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F52A5ryk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N9JYbj9I; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F52A5ryk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N9JYbj9I"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 1287E1C0018D;
	Tue, 30 Apr 2024 08:34:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 30 Apr 2024 08:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480439; x=1714566839; bh=r870XG+PhA
	+nFSf3+g1UIsemTag+xGPYlsJ9q7L1RCc=; b=F52A5rykmlCuS+qLYYE+2MwZXW
	bBO0YOvlqCZQX8uxAvmFlXZ0JGheNLEci+J3iC3lyXhFZBObI+0eli1k7B7u/mPE
	mWnSKkIL2ZUqhsD9qIhha0ajXrb0La5aDzQgFZcNSl7E+c0LWjWOC+cmJlyS9cgB
	gmOdSICZ6Z6KIMTf0+DPMcrG4s6/RRkG41DG6VzXRvhIiJltfHJNGyG7rQPAgTGA
	qgpiYxYThqNp3WrAzKM23MU4aDm+pPWtLFh/qO1OL3geFi3dkFG+YTrQdIpOwGBi
	83/TVMorDVna/he2aM4WHHQ2yyrrFHlxvEPj/RfV056Qr2r//oPHGUr5SzIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480439; x=1714566839; bh=r870XG+PhA+nFSf3+g1UIsemTag+
	xGPYlsJ9q7L1RCc=; b=N9JYbj9IsvhkDHO+/yLcbaOW8pxKlOdyXcLo41OrJn3X
	kI8bC9kzKR/t/aKkLaJAnep0uKJwMgvF55ema6Xd6NVzlv25UKiKIc6t7BrpM3cJ
	zmFy9NdvjZPq9mfhDaJfBZeNTB1tlqoYr/HQhjvTY2HjJG+USi4HAnYBEWI9O7Re
	06AGnSgwVj7yZAaHep/g4OKXvJys1NLitvjQAAwjgHiBJBnosrtoLiCUWknITnwX
	R4Wh6mFuHw33cX8TVB2OoSBi+OCE3Jj5ZaUnF8+iKg2GkpA9ObCdbIlwSTLJOjDQ
	PQKS7owzci0Rk84xBso/UPOXaJfeNe0V9brW/c4sDg==
X-ME-Sender: <xms:N-UwZoo1Lw3UdwVjOgSiqypSFWQAokbHR2az8hNP5SaLbvQGxo8BVQ>
    <xme:N-UwZurjYVbwFEKog21s_Kdp9JowPi333p-IJlVvnU_oUI-7tBYXdoIKgB3Vxd8ny
    OkUe-5XQOqoquKkVQ>
X-ME-Received: <xmr:N-UwZtOeirmEHbf_aC2w1XBI4OOk9k8sfMrEh5D7f1t8qHMhDOso_nScA_OOaSRbT8b6nNViYLOWV3w5okGnFj9uKvje6kdW3HCXFmu9mAmk5i0mrI6R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:N-UwZv6dHjTQchoxvuoU_dLSt9djhgQZ0OTTIkA1Mv0genKOJ9DiHg>
    <xmx:N-UwZn49Z9mLCyrSen9iLiKDWM5zWM3JcMpwl_ZIXwSTmMttzSY3eA>
    <xmx:N-UwZvj-Qsd9ASGQjOZq11_jwSaVNaQmj_nU9K7i1JfEjFCVattQqg>
    <xmx:N-UwZh7x1pf1JxnRCOLWZHwfVFKrfT1o24bRV8K-wQMaG54JlTMoOg>
    <xmx:N-UwZq1FvuJQkgjSJpBfELgaUs5Jw6E6MnSdO5K1OftR81dOdRo7unvb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:33:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8d98e83b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:33:35 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:33:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk,
	git@vger.kernel.org
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <ZjDlMs3Zm1JQybAx@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
 <ZjCd_drNT6kyjNa6@tanuki>
 <20240430102310.GC1279403@coredump.intra.peff.net>
 <CAOLa=ZSLx3BQa8zHyDZp5CDuQc4rgSk1LjSX=uQViWXsiv1LZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8UkfABSzpPGPPRRH"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSLx3BQa8zHyDZp5CDuQc4rgSk1LjSX=uQViWXsiv1LZQ@mail.gmail.com>


--8UkfABSzpPGPPRRH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 05:07:19AM -0700, Karthik Nayak wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > On Tue, Apr 30, 2024 at 09:30:05AM +0200, Patrick Steinhardt wrote:
[snip]
> >> > Are there any practical implications of the changes in this patch fo=
r users
> >> > running commands like "git log FETCH_HEAD" (I can't think of any off=
 the top
> >> > of my head but it would be good to have some reassurance on that poi=
nt in
> >> > the commit message)
> >>
> >> Not really, no. We have never been doing a good job at enforcing the
> >> difference between pseudo refs or normal refs anyway. Pseudo refs can =
be
> >> symrefs just fine, and our tooling won't complain. The only exception
> >> where I want us to become stricter is in how we enforce the syntax rul=
es
> >> for root refs (which is handled by Peff in a separate patch series), a=
nd
> >> that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
> >> They should still resolve when you ask git-rev-parse(1), but when you
> >> iterate through refs they should not be surfaced as they _aren't_ refs.
> >
> > I actually would not even mind if they are surfaced when iterating with
> > --include-root-refs. But then I am a little skeptical of the purpose of
> > that feature in the first place. After all, the reason code shoves stuff
> > into .git/FOO_HEAD is precisely because we don't want other stuff
> > iterating over them, using them for reachability, and so on. That is why
> > "--all" does not include them, for example.
> >
> > But I did not follow the development of the feature, so maybe I am
> > missing some cool use case.
> >
>=20
> The use case was to allow us to look at these refs when working with
> the reftable backend. Currently there is no way to do that, with the
> files backend, well you could just read the files. So mostly a debugging
> usecase.

That's true for normal root refs, only, though. The pseudorefs (current
special refs) can still be surfaced even if the for-each-ref machinery
doesn't surface them because by definition, they always live in the
filesystem.

Patrick

--8UkfABSzpPGPPRRH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw5TEACgkQVbJhu7ck
PpQ6Hw/9HD5V8o6nXd12K++lhchSUffg7FLohaEc32SZmMXbDPn2DS7CnTgD/DL3
ICvgVukAcyIAnf6/w7Ls5q3yxazUm2tfvbO1EX9DE1WWveqQVvKLak4zcoxmhUGj
NHWXks55A6JIyHz8WPXMjoMyYFt3RCTeM6Fm2cjfNopzPf26Mow5QRX2HO/fSXGI
QFY/OVcW7J/F0310YNHqVOTKlxwWw5KglScLH5UHUV54NQSPe1x5puY4nbuoeIq8
yKElhzP2hanEN2rF2UstNjPbPi1RwamiLWdAObk8sMZWzXQlQ0UFj2Xp4swU2FCn
pyM7WSWbnGMg2iLbHZBBTwWWlU36raxCeDES4hXw/1DjrgaoFHdBAyPQCoAgjoXv
IEiaGXEiz24dBsqvOtlmpNGdZnEwff0/AMDGXUSpJCOmH5a1FBPkn0YQLzo5zn6N
ZHNimKfZKB61jf6lh2Y2Cv4C4liMQePkFTq3+6zjbFt5rtBKo1RAa8d8uxYiWfax
uu+rcD479IV29hOv+MGZOKt0UOkzazIbwdZbpygCO/bxstROMHCuL0UX5/Uckci7
DlplGM7IzPpnKvc9upBdzqbBLNNhrTAXuemtR9Fsc3dzyP9ABOv1yd5diGX/VSTm
lcZ5SE7qCxX31eMY8bLytp3MkqJQWRrAVSjAs2uUaIURvsc2AzM=
=VPmZ
-----END PGP SIGNATURE-----

--8UkfABSzpPGPPRRH--
