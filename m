Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3D5134CDC
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617172; cv=none; b=l7t9VnWbREZ+hJB1H/tQAQpgaD+wkGZXYghhFRLu21dkTzkZ+4rmEpeihSIHeox14OKYc8HZMCaq0/biItJhc7IKYt+fPh//dtzjoqfmy8vOyiLxgFMZjNGQJMSou/XyUvlYEdN/NB8/LhXvZr4f1sqvw+HyxG9qAoV+o3dYY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617172; c=relaxed/simple;
	bh=sSwRG6s8+cO9OGn/QrnbK7st4zhaD1vDBd2mFGnQlX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWb8z/PLRZXVqmVf/FhlazQho7dUr7uxCu3+2hiwFFJ3LK1HolIvY2ODgoZscglPEVhdVmtXYHVKeKp3vmJER2UpQ6rCEjuLzKGomXrDWRq3GxY9T8kWAdduwi8PMQVYLEIundlkiFjz7BFfo4qi8VuXF464/AFXJrhnBZcsF3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZwV/f/JU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLlHfRbR; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZwV/f/JU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLlHfRbR"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id D0A48320094F;
	Thu, 22 Feb 2024 10:52:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 22 Feb 2024 10:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708617167; x=1708703567; bh=sSwRG6s8+c
	O9OGn/QrnbK7st4zhaD1vDBd2mFGnQlX8=; b=ZwV/f/JUsnu/l6P+F3Re/tQ8ak
	v5b15h2/NbP66hHvq3MDAinXG1fnTeDfm1QgBeibS38pf3pJWFUu6OkQYy3ZRxr4
	2hf1u6lmoKNPduloM/2F/Y8ijau34qzqOzlReUvJPmMJTcaa2agnWDBEXJSzYDxN
	o3pKys5k2DrYlV7DBWkak2ZaQVo8Y9I8zommKidiOY3P6PLKhqlfGHdK0Dzbh8tu
	hW1HM+CBtjiG2GiFsdWjIogoDdE4i42+uzP/wKgwhlOgiNSnI/ubrsZWxVNFyvGs
	UGPkYFAmMbOzFYs6VWBOk0i0BAAietLCkOYpDvl9nnhsDLavxR43CvJpynMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708617167; x=1708703567; bh=sSwRG6s8+cO9OGn/QrnbK7st4zha
	D1vDBd2mFGnQlX8=; b=hLlHfRbRyzSenWEGAU56lOdK9c+rGK2zZYc4gG/C82fX
	7lsxTpb4PtUh5r699CHnYCBGJxQvceYgvoW7QO4JgnNFjJbw9NzIIwbTHUSPikhf
	8jTjFqelXgkzOstdD/YCrQ7WOtMPfqGUxluHTwwtXTZUuWBtIAfcOwzenzKhrRDt
	kD+ljx/A/MKy2BFzK2ZRf4t5KbIBWqg215KIB7nXtZyTd6TdZhoIL50EXaKunoMo
	QyfzTcWbqMb4ICAF6lEfV7+jk5zn6o+XqF4N7bIVUuoZTAiGNF14Ik40jZqZBaTP
	QUL+DLC99iczNQZ/1LWHxVR2owrmRjvxRRHSNkBewA==
X-ME-Sender: <xms:z23XZRwInorkfdnkbybIiGDdZLDLWnPkcPKiseA4O83QTDTmCDJgbQ>
    <xme:z23XZRS4WAorXISbc3DfMKFxrcRZxoikdrPnSobyrobnQlB_sCemJ153NH3y9yXkN
    SHExvyjXD4vHP9byA>
X-ME-Received: <xmr:z23XZbWw-B57v1JFpj5q3B6INFRDxHWhZrT7lA5a61dI4EUmryGJgXpT00NnSWyEbm7NCm0RhvLJxY6SkIcOsPhOy4YbcF2Q3jfuHbC6gHjbFP_N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejveehueetkeevleevffeffeekffffueetvddvvdegueejgfelveevueevfffgtden
    ucffohhmrghinhepfihithhhghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:z23XZThHZcCgKPMdTzWIHOA8vjeK0xLTmc2PTIrL3x1OkN2zY6o8OQ>
    <xmx:z23XZTBn_1yYR0kSgjLPntDKIk8XqMRkT6rMtnZ23byzgyNc31Yvtg>
    <xmx:z23XZcKrmlA3YLmQ6x0zCfvcIzLSXLrbmtEQ78kz4ivcrpv3EoFE6g>
    <xmx:z23XZV2sTUZhbvLq7pnBBunEcay3at2x8JdYQCR31qMmFd3TbzUcuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 10:52:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d5875c1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 15:48:36 +0000 (UTC)
Date: Thu, 22 Feb 2024 16:52:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Victoria Dye <vdye@github.com>
Subject: Re: Git in GSoC 2024
Message-ID: <ZddtyZqX1ME741j4@tanuki>
References: <ZbpGzAd6FGEeTdrh@tanuki>
 <c61322de-8cd9-42b8-a04b-a8ae47b25c5e@gmail.com>
 <Zbtmoo8qTmj-yt99@tanuki>
 <d4797f27-825b-4e2b-85a6-cc30f33934e3@gmail.com>
 <CAP8UFD3GBT7s1jGOc=fe6XdYGF1c--tMBDiy_sDg1Afsa=drDw@mail.gmail.com>
 <26cf6320-7ead-4ca0-b4b8-ca7008cae401@gmail.com>
 <CA+ARAtqicQkhKFcTxoT+GWMhCxnV-BNqd0oOcn2YwznfFnnRPw@mail.gmail.com>
 <9cec06d8-971b-4c5d-9d85-969021b0dd48@gmail.com>
 <Zdb8lnUSurutauRa@tanuki>
 <B6C95613-B316-404F-9076-FAC5955B8890@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SYEsOqY8g+I8bMbJ"
Content-Disposition: inline
In-Reply-To: <B6C95613-B316-404F-9076-FAC5955B8890@gmail.com>


--SYEsOqY8g+I8bMbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 07:35:33PM +0530, Kaartic Sivaraam wrote:
> Hi Patrick, Karthik, Christian and all,
>=20
>=20
> On 22 February 2024 1:19:42 pm IST, Patrick Steinhardt <ps@pks.im> wrote:
> >On Thu, Feb 22, 2024 at 10:01:54AM +0530, Kaartic Sivaraam wrote:
> >> Hi Christian, Patrick, Karthik and all,
> >>=20
> >> On 21/02/24 10:32, Kaartic Sivaraam wrote:
> >>=20
> >> Also, it's official now. Git has been selected as one of the participa=
ting
> >> organizations[2] in GSoC 2024!
> >>=20
> >> Let's look forward towards a summer with great GSoC contributors who
> >> hopefully become continued contributors to the community :-)
> >>=20
> >> [[ References ]]
> >>=20
> >> [1]:
> >> https://summerofcode.withgoogle.com/organizations/git/programs/2024/ti=
meline
> >>=20
> >> [2]: https://summerofcode.withgoogle.com/programs/2024/organizations/g=
it
> >
> >I can access the second link, but the first one is broken for me. First
> >it claimed that my Google account wasn't connected to GSoC, and after a
> >reload it stays blank now.
> >
>=20
> That's strange. Could you possibly try logging into the Summer of code we=
bsite [3] directly in an incognito window using your GitLab account?
>=20
> I've previously faced issues with logging into the summer of code website=
 due to an add-on blocking access to other Google domains. So, if you have =
add-ons that might block resources accessed by the website, could you possi=
bly try disabling them?
>=20
> If you face issues despite all this, the only resort is to write to GSoC =
support about this issue at gsoc-support@google.com
>=20
> [3]: https://summerofcode.withgoogle.com/
>=20
> Hope this helps,
> Sivaraam

Things work now after a re-login. Kinda strange, but so be it. Thanks!

Patrick

--SYEsOqY8g+I8bMbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXbcgACgkQVbJhu7ck
PpQPEA/+MMKmigD398ESZuDSxaaRLVpbPExqDbmok1yxbojeVBpFBMrfD4Udo+tn
UrIq9oEOXDSNv1llQRMxuTREx5cTNzcEO73kWY6CdKsrexyscNarEdSDpYu6fQej
K3tH4ulCtONYsvh+cQIJSC2pXkRUWxaNDNAh9oO7MAaGJMpbyCIJwolitFgS7n/l
r60fJYyf/SQul3Lik/d1PRRSlBHoowl9fr93WxSUbGNgslhIEBEqSm05CNeKVUlG
HHhsJsZAk8B/SHFtEph2B79b7ktpuZ1SFOp/EPNnf80ZdxOQu5hPGEygD51suEGc
7XxXnwCq0vF5do8LUeEyYellrP8fNf6xZsQNz5BE3R2es25lNcCMw7g7vn3hYOlY
Lf1Qm+llW4/mqvn02K6HjZ6sv+RxZDNFnAl0C/8QE0IEh6ZPktHwj092eFDdxSIR
yrrvbr6T780EQu0Xh3IwJcsrDMCPxWpnCEg/xGFkANjqmH7HIHuN3WXQBo3/JrSP
7jdW5bpNx5THiqbMrGPd4/OJ6e9CyoiIkUpdj6IeEADHS9E82YmJNwnikypX1xzU
XCK6tj2yyNzHbSfrJ5q7odlAmUnNZob4xYe4W0mtmH76/xrozUJD5IQG9RiX0m7C
kJZsz4K0F/g4mJyEVrBtGcj2awm0ErzPVTu9fz9EKBmxB2E5QXA=
=0x8y
-----END PGP SIGNATURE-----

--SYEsOqY8g+I8bMbJ--
