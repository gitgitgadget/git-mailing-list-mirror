Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF0604B7
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023136; cv=none; b=ZPWrnEut4s+s7HZZmLsOJxJB+stmj4fZsYICoIakv8vn7X7COdSnhqejPPFaHRc4wpbL9rakRAkdZIIcJtrt5mYR8W6/duzY4brd8o439TJ0GLxKVyOWbUKto4SlNylCosAlSxibMUzmXxm8UHtGcTKGtG/wEKrhHTNZe5KQ69g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023136; c=relaxed/simple;
	bh=FeV7aMSkTWMjNmpPJKyHXOnhZNU0aJQ1s5WAPhR3Zr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9qn1hXgFG/+52rbXHx3B6+0dIYkB156mh5NbdXLfcm74FGs2dJPjV+Q4v0CHHq/TGitszZ8onXPAs8FP2hqjOKhDw9PfWTGn6RLztpFMHzqLqXPbs2gXusjdt7cscdd/exLEXYCs1o0rkgTuOGqPD5SIZlYAkO6gfzPhXz9CDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H1+LHvGV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=naO4jIZk; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H1+LHvGV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="naO4jIZk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 36F005C012C;
	Tue, 23 Jan 2024 10:18:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 23 Jan 2024 10:18:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706023132; x=1706109532; bh=QMoxl6ei/z
	E4bfVdnX5xSXIOA/E4btjyvJ1Ri+w9Grc=; b=H1+LHvGVsi7LBtKnNxOVn/l7aj
	Px4BlcWas3xbhoyGuqdhyZehyI9M7BUELfxZ32JLhFoxgJVQaHKcklRb6rxhSdKz
	UfwyD5j/RS7Z6v3PA+sOllSpLWc+kxT22ve5HcjT18NMiPM81JrUTZXLOW4VL0E6
	TECWHHgbm7JGUOU/UakLCNurAXTqbmqnMQ9ZIrxpavpo8oUBoMTiONjCTymNiwUo
	gHVeKP3NkCHzzzJ5r/Y87qRAGTMcZsleFUBjmIy6u/y87MrNp0Uvj7LB1dn55h3E
	Z4IIvdqIFKRYvTBvK053oY21SerV1knnhNilITWEwZCnrAYi2qvx/dDrK/TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706023132; x=1706109532; bh=QMoxl6ei/zE4bfVdnX5xSXIOA/E4
	btjyvJ1Ri+w9Grc=; b=naO4jIZkLl2GykXa94xA6G9FaxzEs7XNUU3zZqb03Jtk
	kWZW2/YohHChW+6Pmk/NbG7zj+nqj+XLq7EQg0i8WjrS0uRGbNX0/yT6zXzYaNjU
	VkH8lhbeftLTJwBnKt3StVqOkc9hCIKGLToekY5KnbRUVk6wJerSBBDTyCiMETI7
	gsHJaiz7jm4eVI0oihdScEC4HQbIjWgRWWGg1WQcH01c6gn1dDjbxShhXm3PmQ9e
	FBOFCOwQtRr2EZ/FocdQ7gHLncuCb/EDdGqSM1rwFgMs3XHGTNG02TUNu1937fCY
	M9PVFNLkF8ttAVTZ1vCnbktP53sXgFUhBLtLHxhE9w==
X-ME-Sender: <xms:29ivZe_Khr61cMpb1m2rwbduoV2LY9DZG8hTP1H0w4kq-0kAOZ_bYg>
    <xme:29ivZes9Adi06C29qzuujOT_Grv9rklSttGPVySfxLXp0Z7FEfVYdI712XdeXu2hm
    r-_O_G_prM3b_frOQ>
X-ME-Received: <xmr:29ivZUDXLOwl-N01zM63U1QZaakXHgE-jZSmLOJR8XwCflUtP7qkKvYE0jmA1AXvFWtoMHK5WLwVSI9oBk_PpXewEcZJTsSGMLszBl-yJ2FvlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:29ivZWeSXgxrxt2n2wBYOK9It_EnNMwfnAgUDQuIXx3wiKK36itI3w>
    <xmx:29ivZTOkBMFJvpa0Z4__R9-wbSLZTp0v2Q3aPp38Cqo1YKndFpJMiw>
    <xmx:29ivZQlYanTrIjBp_ll5V9T917kOyu0eVH3NjUzXKk2TuZy79pBV1w>
    <xmx:3NivZcbkvug-E3gTVg2Mkx-x7g4yYG1krbaBvs430ydPILpGIrSL2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 10:18:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e01efe0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jan 2024 15:15:43 +0000 (UTC)
Date: Tue, 23 Jan 2024 16:18:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] t1302: make tests more robust with new extensions
Message-ID: <Za_Y1tP8-LEiNjrD@tanuki>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1704877233.git.ps@pks.im>
 <1284b70fab6dd85114cb24fc5c7b6c49e35eb135.1704877233.git.ps@pks.im>
 <87a5owqgzi.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UZu7H+ZCM1WRBXah"
Content-Disposition: inline
In-Reply-To: <87a5owqgzi.fsf@iotcl.com>


--UZu7H+ZCM1WRBXah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 03:08:00PM +0100, Toon Claes wrote:
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > [[PGP Signed Part:Undecided]]
> > [1. text/plain]
> > In t1302 we exercise logic around "core.repositoryFormatVersion" and
> > extensions. These tests are not particularly robust against extensions
> > like the newly introduced "refStorage" extension.
> >
> > Refactor the tests to be more robust:
> >
> >   - Check the DEFAULT_REPO_FORMAT prereq to determine the expected
> >     repository format version. This helps to ensure that we only need to
> >     update the prereq in a central place when new extensions are added.
> >
> >   - Use a separate repository to rewrite ".git/config" to test
> >     combinations of the repository format version and extensions. This
> >     ensures that we don't break the main test repository.
> >
> >   - Do not rewrite ".git/config" when exercising the "preciousObjects"
> >     extension.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/t1302-repo-version.sh | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> >
> > diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
> > index 179474fa65..7c680c91c4 100755
> > --- a/t/t1302-repo-version.sh
> > +++ b/t/t1302-repo-version.sh
> > @@ -79,8 +84,13 @@ mkconfig () {
> >
> >  while read outcome version extensions; do
> >  	test_expect_success "$outcome version=3D$version $extensions" "
> > -		mkconfig $version $extensions >.git/config &&
> > -		check_${outcome}
> > +		test_when_finished 'rm -rf extensions' &&
> > +		git init extensions &&
> > +		(
> > +			cd extensions &&
> > +			mkconfig $version $extensions >.git/config &&
>=20
> Why did you not remove the use of `mkconfig` here?

I guess you mean stop using `mkconfig` and instead use git-config(1) to
manually write only the repository format version as well as extensions?
The problem here is that the resulting configuration would be dependent
on some environment variables, like `GIT_TEST_DEFAULT_HASH` and the
refdb equivalent `GIT_TEST_DEFAULT_REF_FORMAT` which do end up in the
repo's configuration. So I think it's actually preferable to overwrite
the complete ".git/config" so that is exactly in the expected state.

Patrick

--UZu7H+ZCM1WRBXah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWv2NUACgkQVbJhu7ck
PpQh5Q/+LwDw3KIWNjXdUl+LmwgvSIb762B23TuRyGOPP0t2LLX84mTuChWaTyIY
Me/8PeiRlDGwxsnP1WBhIpGoZ1Vqt7aMJnAMK0k0+wxwuPNqvGSa54KodLmNA7Kd
k6EaFAS/fya5JYOlYCFCWX/8R9MsEKtRpgeEInp487TAbF0s8Y1OvXgawKjEdHpD
eByZt0agEZFm4zRh0f9hKV9gakkSdyNt8pqM/ZbbXKZdnstIRKyky07D9d89I5FW
LF3Nq6CfH1g5HB+FdjKmpQY/NCBQ145XIM816/iVmCSrgGyWC5YanZ05Sxk/nCJc
AFidppsUV7BgmpmFsIleugKciIdVFbeihZyIIhtumFjPZK4cSIY75HlZtbWhOLzy
GH59+GmoSI1LCtxhFbOs9lwYEuWXauGyJe0V4ZRgF7et5SfPySycpCYex0hfJPwO
V2wAhTYLEkj/xNSVb9lShE0imk7mSAFKYKqdwXLWGpWDW7aYbpm2FgHvomNM+iq/
ClVJUyLK+Cn1F6RBdVd6GuYnD2RYZ8tJdH+pwky33D+1ambB+poswnMjt9dHABT4
/5wI8GMstN5ADYNzWTmSrRyxYZHHwngqCnh7oGQoMrGYobb1BqE1adozBgCFg/mS
R7rqAfpx7kjluHy5Ut7ZJC7GdAvMWKEoJ3chPu2ndUlVmEs+DBU=
=N6PW
-----END PGP SIGNATURE-----

--UZu7H+ZCM1WRBXah--
