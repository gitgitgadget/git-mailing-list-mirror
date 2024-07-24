Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D87845016
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 07:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807113; cv=none; b=chlGkqLHfy0joswbK0gqaWlI69qv4WO3owibVoKFpn6p+F9e8494eHzAuLLX1HYh6kcGOwo8i5NZdkdwnVcVB7KtYEmTWUoK18eU8GTXofVQnRwX6tIWOQirM2sop6h/NRDeoshHZKojL4rF2ptgbPFe/nVjEKEyZNGS4zV3+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807113; c=relaxed/simple;
	bh=07wsRVfLkDIFuiMTyE8rK3xkB0fkFH2rBDt8jDsEpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXXgF5zd9katYmbgu9B3TdvViKYCi+ND7cqmgpNVoo9fu74Nyel/JSDU4a9X0HyJdKiUB6gGbmKQRKOxQJeiSy83Mtn7jLXrU7TqDv3N1wCgj9WnG9WI/HTo4PjmoP0pjw/FxxojDlBxqLe9AXSRBuNVz3mRbSavDv6HxqROYQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Em9WQv+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l9Rs3ZYs; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Em9WQv+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l9Rs3ZYs"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2D62A1380157;
	Wed, 24 Jul 2024 03:45:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 24 Jul 2024 03:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721807110; x=1721893510; bh=R+FVi77BTL
	rZxL5ionAIZtOlmwh5mJXN4LA+d1It49w=; b=Em9WQv+1TVYFdgUor5Q0AFrcmf
	1Nrz+NB3X6uoFFpp6HVCIp/KEVSPK2l9w3CFmx5o6sJEMdgVOsS0mQ64/4IIp/hV
	k75eG1LnQi8ZjRH4AmNDDgBHoRip/yE/n9XfLK+LP31Z3J06ohXfM/WZ3Rfb96Ow
	Jjl+1/4uPM7bfFPdUUuYggoQOJ8gOw0ILNc5duoMyWuuLuxAo+4SeneVekudDUIc
	g15ePQQ0cjsAKPOom1L6B3rqsp4jBJLpsBex+QAW4yScJk6UHEaL+GamCfoh5W9P
	YQMqOXfy2eDy0n4kF0xl6Tzuu+cRH5lc5W4RnfubUm87YQHnSSzONrncsMHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721807110; x=1721893510; bh=R+FVi77BTLrZxL5ionAIZtOlmwh5
	mJXN4LA+d1It49w=; b=l9Rs3ZYswYqs/RIuWxklnXW8XSeV59w+ruZ8QInEdhfw
	kASw5rIV91nteXrBOGbJiZLU0urCMNfmRNuWAcN1p8zHPNembp9lI0OT4j/xjaZk
	mNGb29+p9EJOL3CI3EmemeR0Jto4KLV5s5c4mOyX4vJYH5U1riAVM+nxFWqDyOC/
	Hh3KKF+nZVfNZkSpI8p0jGqHCXvq1prJVuk/3ECb1zA/5Sq5YU6mLBkpESkxqDFh
	7whjorcUvOnbSWQe3IRMl7SNAMkKGXd+43m7JUdbRAzTqv62h0efo9MPL/6W+Yi9
	dFqibfC6YS3Or8XenMnwH7CNA8GrhfmeFcn/PrlvIg==
X-ME-Sender: <xms:BrGgZnWLekg0U_PnFQ9nz6Gwjl6WlnWcKyoQx17I3_LUZgF7hi3HbQ>
    <xme:BrGgZvmaSkP9DrU3L6EMLCj4yA4sWWceIdsaePrjhhL_F156DlrMwDKdPHFFTW_yD
    JU_7n7R9IzTrQ_ijQ>
X-ME-Received: <xmr:BrGgZjYK7HACBnr7nBdKZYsQTSwHYJTvn2pbn3BrYZUDRROsu9VrFP3ykQzpxlX8k2tm281gP79SHAptpyyIxX7A7rSLO4OG2QLy3y_62sg4b0v4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:BrGgZiVJWKi8qxcgFkEVCs6y-LAGl5H8F-0C2qrot2Mun_xYFY09TA>
    <xmx:BrGgZhknrr9Sg43K-OJpUbFECLqOD_hwnhwF4LSST3RvCVIZEfVi-g>
    <xmx:BrGgZve3OU7nopDX3Oc_lC1eBXcRLizF6AtmYJl1nZ9BLG15tB6lhA>
    <xmx:BrGgZrHPLGY-zLp-XvDbCO7uk2kytXUveHMBSa8Ht2F-Y4Ywiu-8Ng>
    <xmx:BrGgZva3pRhBFX6IOXvZlo1L4Z32Rl-_ZutoJrBAh_DvVWvzPues6cLe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 03:45:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 183acb8e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 07:43:51 +0000 (UTC)
Date: Wed, 24 Jul 2024 09:45:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH] t: migrate helper/test-urlmatch-normalization to
 unit tests
Message-ID: <ZqCxAZ2O7SkX_eNB@tanuki>
References: <20240628125632.45603-1-shyamthakkar001@gmail.com>
 <Zp-3e6VV5bl8dWvR@tanuki>
 <D2XCB5UYIB5B.1L3U95DQSWJ2@gmail.com>
 <ZqCO6JTQqdxD73Wq@tanuki>
 <D2XKUY6MQJOR.2B3YHEXQPOQQL@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eiDyQ+O1444wPvtT"
Content-Disposition: inline
In-Reply-To: <D2XKUY6MQJOR.2B3YHEXQPOQQL@gmail.com>


--eiDyQ+O1444wPvtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 12:36:32PM +0530, Ghanshyam Thakkar wrote:
> Patrick Steinhardt <ps@pks.im> wrote:
> > On Wed, Jul 24, 2024 at 05:54:33AM +0530, Ghanshyam Thakkar wrote:
> > > Patrick Steinhardt <ps@pks.im> wrote:
> > > > On Fri, Jun 28, 2024 at 06:26:24PM +0530, Ghanshyam Thakkar wrote:
> > > > > +	free(url1_norm);
> > > > > +	free(url2_norm);
> > > > > +}
> > > > > +
> > > > > +static void check_normalized_url_from_file(const char *file, con=
st char *expect)
> > > > > +{
> > > > > +	struct strbuf content =3D STRBUF_INIT, path =3D STRBUF_INIT;
> > > > > +
> > > > > +	strbuf_getcwd(&path);
> > > > > +	strbuf_strip_suffix(&path, "/unit-tests/bin"); /* because 'unit=
-tests-test-tool' is run from 'bin' directory */
> > > >
> > > > Curious: is this a new requirement or do other tests have the same
> > > > requirement? I was under the impression that I could execude the
> > > > resulting unit test binaries from whatever directory I wanted to, b=
ut
> > > > didn't verify.
> > >=20
> > > I am not aware of any requirements, but if we want to interact with
> > > other files like in this case (and where we potentially have to
> > > interact with a test repository), we'd need to have some requirement
> > > to construct the path to these data files (and the test repository),
> > > similar to end-to-end tests where they can be run in only t/
> > > directory. Do you think calling `setup_git_directory()` and then using
> > > `the_repository->worktree` to get the root of the worktree of Git sou=
rce
> > > and then construct the path relative to that, would be useful? That w=
ay
> > > we can atleast call the binaries from anywhere within the tree.
> >
> > Instead of using the working directory, you can also use the `__FILE__`
> > preprocessor macro to access the files relative to the directory of the
> > original source file. That at least makes it possible to execute the
> > result from all directories, but still obviously ties us to the location
> > of the source directory.
>=20
> But doesn't '__FILE__' give relative path instead of absolute? A quick
> test_msg() tells me that '__FILE__' gives the path
> 't/unit-tests/t-urlmatch-normalization.c' for me. So, I don't know
> how we would be able to execute from _all_ directories. Although, I
> think the restriction of running from only 't/' would be fine as
> end-to-end tests have similar restrictions.

Ah, you're right of course. Scratch that then.

Patrick

--eiDyQ+O1444wPvtT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmagsQAACgkQVbJhu7ck
PpQWGg//TWcfxU2wK7nikvX/ADJSoFvbfohFwqCcE1xDDXVNI+rDxa1wZFnyQ8C3
ocM5a+QEmSvcyNx1e0VsyuaCGttWUMC2vzkG5V7vNx2EtL7WZChqbcKhW3rWFT3E
DPJtPaa4EqavdaZop/gdv6e92tLTxHt+VCwR51mytVKtmGIi/9Xgo1HfGFJPudfw
yfx0YhSx0plLvOtMXx0Ik9xerAV/EZxYUYhq2/D2hJ17BzMtN953zWxaZa5o9Cht
b7KDHy2HqUU5dT04p8/NccyOcD/IULvMWrnPNcgKxQmVkWixHVADRrbshPrH+rBd
6XFDo5P6LyDuk2a//hNFVtgNAduTOJdNKKSD0nWCb4DEUfH1MRUp6CbVDcy7fac3
uPjxv/yw/CSQy+CqvPwf+Tt7u6qDTlR1dGSpkrcn05Bg40bWmQBJwH9lpu5MI83d
750CoTfEoiu3g4CgwkOZTjwFxD6XHqv+s53KQNpf+T65VvvYcE3Yq3F/tnRGIkDd
2ikoipNOXDTi4HN1b5D5Z6LzwWkh8ZAzmHqvrU5lQYRZCIQEaCG6Vv3MrlSSODpr
APq0mtSisjt7oV3ZnC3rdNWrTyUsPJFglmuV0lVr2e1NPHtDkKZsKtXuzDBcksUN
KE5SnUZlP2AzY9YmWsyhdsdz+vHIvHLUqVY5Lqe4F5laj+edc3w=
=2kOF
-----END PGP SIGNATURE-----

--eiDyQ+O1444wPvtT--
