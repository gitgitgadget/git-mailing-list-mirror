Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95A59B68
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024054; cv=none; b=doh4GkqB+ekd8jZa9bcGC2pGSz6GDwNWqaaBAaWqUNI0xpoPlw10XGx13sPSEHqbG5fOhSP6gMStSLkI0dvTVN7e8sVzNThmB7Os5RnpzvOAk3fIJehJPfiZ1rp9IWm1Tn895Y2vN4iqTisDwg4tyeuaLEgCmnqvQM2S91mmVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024054; c=relaxed/simple;
	bh=+J4/JzJIq+zCfR5XL5fqBhOo7une2SNBtZLqq3nUsak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmTE6ThJlVxoPhfke7HvQHCtAsQQF9BH/FV1o4kFF/LOltwsppgEp+uaHhAISy3B7EWaXOUUqTN2MEZsOANgINoK0apIr5bR26lZfa/5Gx93OYKgfvtbIOS18DYLZVij7sZA4IqV+Na/N8foISvluWBpMoxPUruSnU5IgIEdBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G83zZzQO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/+m7eGH; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G83zZzQO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/+m7eGH"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 4E3DE1C000C4;
	Thu, 21 Mar 2024 08:27:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 08:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711024050; x=1711110450; bh=+J4/JzJIq+
	zCfR5XL5fqBhOo7une2SNBtZLqq3nUsak=; b=G83zZzQO3G0bDw8j+ZE06zZpWw
	umgEhoPfromluVRQi3kyvF7EchqPqU7OByu1V4gui/ecYsOJfhGBsEhWjPAsaHs1
	YbrI71Yqw846kg5FBGgB9E0wcVOTG8YoTGcRZuyQBkBWwHOG/lsTT8jcLxNwg7ro
	SZSDogeYe/Fe9GsHtFAIkIrfbHWwJ4YSw//z550YyqMBK/yIfu/2xVbGRmhszR8b
	WRFDIhLbbjcprO9qri/SvsjWW8yN6AV1dCMvetFRnQ85F5BlrzhJLNQKWUsWgMPS
	m+HiMLp0kAciAFgShN7OZIfjz1ijCI4WLFCLdpP/bykCjnDEqJ/6sruSYknQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711024050; x=1711110450; bh=+J4/JzJIq+zCfR5XL5fqBhOo7une
	2SNBtZLqq3nUsak=; b=O/+m7eGH2tKhS2ps9yT10K0X7dUJnopQkVOoMsQn3v9D
	SqyifDz4YIDDJwPPSqI+K4lGLOxqV/SG/Gtr4iHvPTlbynO7SIcEYa2aGAn6D0l4
	mmPoboJRszRAi93grteLim2DhHMO8SwGnlNY59UaaOarHzqU53Vt/kRZ5HrFfLby
	i8dH23pMxCeLywage+DPsr6popLgswYl8jks+d/AlIXcGFi4TbHKqUryBpk4pmwq
	5SrjAQDvDuZcUhMot6O/bjE1uc9vS46qAdWX7NnbFhViIvUasW3QImWbESxXmBL+
	epe042VKsP7Lgf5Vsvc3Ynv1TKkMSw6z2niLnzBPtg==
X-ME-Sender: <xms:sif8ZdvTkPtCF7dwTmabURORfnLvDPeG4AVTH4pQEJmez7qOXW2UoA>
    <xme:sif8ZWcS27psRabfBLgkL0A-8nZTXKCtfCCAiYTFV_mGkdyUcUX_JhtJ4DCA5QTP3
    -UKUeAWVPbPKONbbg>
X-ME-Received: <xmr:sif8ZQy4I6I_YMhCAwrgUVLu2-wNknTOlKaDdE2DJVvWs39r9UAXHir6kCfwP13Knb7P46sV-KCBo4Qne8HjxiMZSwxOdSsOqmDk5ZCDVZEEng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoe
    hpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtfeelvdekleeufeevffejieej
    feehieejkeeftdeljefhteevudfgfeejgfejheenucffohhmrghinhepghhithhhuhgsrd
    hiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhm
X-ME-Proxy: <xmx:sif8ZUORg3gg-jzNxaAGmmCMY4I_09S38ZRuMDHsn7F9fsecgR16gg>
    <xmx:sif8Zd_PjsTS_Cq8ekEyxc2pzXtTxdHoby10pqtjn_qClgK_829CGA>
    <xmx:sif8ZUV4C4TxIQstkawlixclevPOy9401R20ZcFBkALeBv-p9xi4rQ>
    <xmx:sif8ZefEKa_kemYb-K97VpGGr2L29w-W0gg1nCUl8RZsxN4RaIvbdA>
    <xmx:sif8ZdzlFszAq__Xnd920J9z0LlqFd_Mz-i7rVYGDOiMBBvh3BLJTkkPrQ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:27:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5a43419b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:27:23 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:27:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org,
	karthik.188@gmail.com, kaartic.sivaraam@gmail.com
Subject: Re: [RFC][GSoC] Proposal: Move reftable and other tests to the unit
 testing framework
Message-ID: <ZfwnrL6Zl_lcV09y@tanuki>
References: <6f0a3c13-c8d9-4f89-8c62-9c031f0a064e@gmail.com>
 <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37moweATJMM8Ub8R"
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Rb0kN=g=EPcSqYBb3U=OgW_06jqwafF=vRYhetZ9hdQ@mail.gmail.com>


--37moweATJMM8Ub8R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 02:17:23PM +0100, Christian Couder wrote:
> On Tue, Mar 19, 2024 at 6:11=E2=80=AFPM Chandra Pratap
> <chandrapratap3519@gmail.com> wrote:
[snip]
> > A new unit testing framework was introduced to the Git mailing list last
> > year with the aim of simplifying testing and improving maintainability.
> > The idea was accepted and merged into master on 09/11/2023. This project
> > aims to extend that work by moving more tests from the current setup to
> > the new unit testing framework.
> >
> > The SoC 2024 Ideas page (link: https://git.github.io/SoC-2019-Ideas/)
> > mentions reftable unit tests migration as a separate project from the
> > general unit test migration project, however, I propose migrating other
> > tests alongside the reftable unit tests as a part of this proposal.
>=20
> It means that if we select your proposal, we cannot select someone
> else to work on either the "Move existing tests to a unit testing
> framework" project or the "Convert reftable unit tests to use the unit
> testing framework" project.
>=20
> I am not sure but I think that, after migrating all the reftable unit
> tests, I would prefer you working on other reftable related tasks
> rather than on more unit test migrations.

I agree, I'd also like to keep these projects separate from each other.
Also, the reftable tests could certainly use some polishing and a lot
more documentation than they currently have. Their coding style does not
really match the rest of the project, and if we're busy migrating the
code then I think we should also take the chance and touch it up.

That will require the student to understand the reftable code a whole
lot more deeply than a mere conversion would require though. Thus, I
would like to caution any student who wants to pick up this project to
not underestimate the effort required for this project. The reftable
code itself is certainly non-trivial.

As Chris mentioned, if this project would be finished early I'm quite
sure that the efforts would uncover bugs, test gaps or similar things in
the vicinity of reftables that the student could certainly continue to
work on.

Patrick

--37moweATJMM8Ub8R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8J6sACgkQVbJhu7ck
PpSdhhAAndh0MFomV+Kirj4j/plbSXhXORAqvyAKmcqg5g6xOHCuqp2nOjV7hbNx
YSq7VhbRXL5C26PpBLi2Xf3eTNN9YMzCHcyO2kmNIXE9EPq9IteBWgAfM96j2NjZ
uhdwCcwNU2quwvHUazisBULbyLejRfQ91SEMd04UKG/HPS+l3JvbFcN6FA8c5h29
xII5Sr5evYjM3mXLsgeG3OX+I8dcsooCjnqDHscl5D1H5o7zpSEZjaXCpZC4rgMq
BY2lain44W7yrZEifWmxT5k6jnPzi2XNAjHDLDQ6kTgRBXBA8rZLCzXFGJVJA9ww
FCNkqhMJIz0y3e2CR3KYUR2qV1BYT1B3klyFGBrNgp2oRqiLHNLxmx+fwtZeNhlD
tR8Y+LegmBgdWgjVV1f2bNuOlnDuTEtXZ4y9BOvIOyd6/i0gx81ITSRa5rTZf69I
DWGysinvAFonQtQwBTvI8ZIxja+rZKDOI8D+n1vaf4fhQ7jtNJ3rxgWiMEoTzL/6
4xsWGPoTczU1fBks0wlmcV2qFNlD4g/WDDl+o024IeSs2lel5THYGoTiBYmrCiSo
mezlEn9t1BGB04xRWr4KcMqYwKZuco6ISTLTYdbgascYRNqotPKQY3cfscX2mVnz
o6MNtriE2IwpMNB/COOJLlFuIm0j6x+BuiKLpRU7vFGSO36FtKc=
=VHrH
-----END PGP SIGNATURE-----

--37moweATJMM8Ub8R--
