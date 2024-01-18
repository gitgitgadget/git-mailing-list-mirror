Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBE1F922
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571093; cv=none; b=sJolayYWm2uY1gXVX85rWeUeurLjldYih4LpCPMM6KvwN9dNXx93G44oRRvSNx0oEJz5Mwy7wfYE2fsDswyI+z0Dww7FtyezOUCIRlLUW2NkZkkAnU2ALz6ScVeysk3o/nN5Qp9ceT4meSb4eFqeSmM8lq10bRcMgsyyOQMmcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571093; c=relaxed/simple;
	bh=Cp6XWbCXLBvvR11iXZ7Fg7lbHxqZu8BsosAjOY976Rs=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=jdhI9Fp8u+DJD6wZ3PXRGzlUumwKfJ3zDqKHdEO/X27C6dThLTIBFZKfqcSjbhscmVmW8SQ+17acwfLn4hCgIfHW2ntWbVnzUgqDO0yo68fYf7e35jldJ0+KMRe0movLp20n6OqxfYaoIm4lzb+YoAQVbEsHGNLjFYaEoMC1un0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kOAsu4iD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HdCUUGax; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kOAsu4iD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HdCUUGax"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id C575E3200B1E;
	Thu, 18 Jan 2024 04:44:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 18 Jan 2024 04:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705571089; x=1705657489; bh=7FZuS1k+jm
	FzGrt2flhDLl8gXTUERfa4c5TGOC06P8E=; b=kOAsu4iDRdMr5Bmlt7LzvKFQGG
	QZx26u2bRnTAPfh+mUfeGwXt7fgCBd0c2+IvdBcYFFYb8j0VYuBUeFUDCqpn8NbO
	7GOscpqH80BFbFE2Ktn3j8gsLPv+yFUsZiO40AVCkVVPWuZGkYubWH2sFqSOuREY
	ytnWOGmLerAZYk6z2PhfNSMplsq6p1Kit9IPeKuoZESf8iSXVhSu1wqQFBitIPat
	raoHV7Kr4A3qfG0e8zTnWrGqMzo85oW37PJwNGa1NPf+tytBWeSsj8sNjSYLIHK/
	clf87Kvux3SVr+dlNxYCsJOpl2QI17DKnRcUJOIbdiQu8lCp5QA8Gf9OF6ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705571089; x=1705657489; bh=7FZuS1k+jmFzGrt2flhDLl8gXTUE
	Rfa4c5TGOC06P8E=; b=HdCUUGaxiz0tSTQaY7Z4jNX29ICDx3HF3JFGKzQ5qGqP
	VKSSxrnq9fb3hd/nrIhaE63yJX2VUzItCqNGuBsbqrodJBoLMrJtkIQR4CR/6oCD
	fkSXMG0/1zHiTIZ6aIUVMMovwUeppfvzP3/0IrJi+ncA6QuBTBO80V57gs6GYMhr
	E5PRunnY4g8Klf5lyFZ7Zmp+U9utEvCCTc8QPIP2DflrJVFnyJJ7weRqF2w5hpUu
	qG8v5QKWDq4AePGYvJeVqN9vEYn4B1kVRGVM8U1ENvGF0BzxI9VuMyHUkIwycjFk
	xBJguUjlYzPf3IImP4QGsWJosRqK0gKjBwpPcVxCcQ==
X-ME-Sender: <xms:EfOoZfKp6GC5M4wtAnnmL2xkPNM24_ZS33asA2_YJ20igaB0UdY2Rw>
    <xme:EfOoZTLkzRpVjW8qtVmRD39-Y3gp9nfbxt9B7U1yvbMOT4To1xqZ5dSKf3hYw2fR-
    nD2HOvAhMnEQWjsYw>
X-ME-Received: <xmr:EfOoZXttJxbTgTarb3Km5vF-XUFWFLuA49zVL3uqcADGSYy4eXo7NVDCixPkpWlyJ9guqN6lfIhZArlvYrcMPpZ99HcMkGqLoWDeCyWCcdVHjRo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejjedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeefvdelfeeuteegiedtkeehleffkeekgf
    ffudfhuddvfefftdehkeeihfekjeekheenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:EfOoZYaLbbduBOGqn9xfcbLHsMkKY4esWpdEDS6ibDCIK-Dtu0WdlQ>
    <xmx:EfOoZWaQypSON2owNZY8wTpRLADB3yMB-NyPs9wba_S9PC3ZUdBqmQ>
    <xmx:EfOoZcC76WoC_rAsnbdPtO8cCWUrFAYTCQV6s2XcAZ-ML_9la0H5GQ>
    <xmx:EfOoZfCeKLiDSCzBte30TiepI8DaaPyFbOvQj77nOqTxnp7V8h8lUw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 04:44:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 72ca2ad2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 09:41:51 +0000 (UTC)
Date: Thu, 18 Jan 2024 10:44:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Matthias =?iso-8859-1?Q?A=DFhauer?= <mha1993@live.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] ci: make p4 setup on macOS more robust
Message-ID: <ZajzDNR1MtbV7zxp@tanuki>
References: <cover.1705318985.git.ps@pks.im>
 <a5d725bea7b2cc2b8f66682920dbba016e89da9e.1705318985.git.ps@pks.im>
 <DB9P250MB0692629640B05593B798E5A0A5712@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Ebn9g37RzN/n+Ka"
Content-Disposition: inline
In-Reply-To: <DB9P250MB0692629640B05593B798E5A0A5712@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>


--4Ebn9g37RzN/n+Ka
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 08:19:10AM +0100, Matthias A=DFhauer wrote:
>=20
>=20
> On Mon, 15 Jan 2024, Patrick Steinhardt wrote:
>=20
> > When setting up Perforce on macOS we put both `p4` and `p4d` into
> > "$HOME/bin". On GitHub CI this directory is indeed contained in the PATH
> > environment variable and thus there is no need for additional setup than
> > to put the binaries there. But GitLab CI does not do this, and thus our
> > Perforce-based tests would be skipped there even though we download the
> > binaries.
> >=20
> > Refactor the setup code to become more robust by downloading binaries
> > into a separate directory which we then manually append to our PATH.
> > This matches what we do on Linux-based jobs.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > ci/install-dependencies.sh | 10 ++++------
> > ci/lib.sh                  |  3 +++
> > 2 files changed, 7 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index 4f407530d3..b4e22de3cb 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -37,15 +37,13 @@ macos-*)
> > 	test -z "$BREW_INSTALL_PACKAGES" ||
> > 	brew install $BREW_INSTALL_PACKAGES
> > 	brew link --force gettext
> > -	mkdir -p $HOME/bin
> > -	(
> > -		cd $HOME/bin
> > +
> > +	mkdir -p "$P4_PATH"
> > +	pushd "$P4_PATH"
> > 		wget -q "$P4WHENCE/bin.macosx1015x86_64/helix-core-server.tgz" &&
> > 		tar -xf helix-core-server.tgz &&
> > 		sudo xattr -d com.apple.quarantine p4 p4d 2>/dev/null || true
> > -	)
> > -	PATH=3D"$PATH:${HOME}/bin"
> > -	export PATH
>=20
> Didn't this put "$HOME/bin" on the PATH? And isn't the main premise of th=
is
> patch that "$HOME/bin" is not on the PATH?
> or is the issue mainly about where we modify and export PATH and was mask=
ed
> by GitHub Actions already having "$HOME/bin" on the PATH?

Yes and no. While these lines put it in PATH, this only works inside of
"ci/install-dependencies.sh". When we call "ci/run-build-and-test.sh" we
do not source this script though, which means that "$HOME/bin" will not
be part of PATH during the actual test run unless it was already added
by the CI.

I'll update the commit message to explain this better.

Patrick

--4Ebn9g37RzN/n+Ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWo8wcACgkQVbJhu7ck
PpSjvg/+PqjlL3lGWJFlGQLz4GnBdnUoINnW4qnoIFGZOC7puQ9UQPVKTvnc/tsn
gtQlhpiWZ/JY4dtl39WhU/Dm1cut74W890RpFOn1BK0y5vcsxJisv18mmBEU/AnE
EKF364Cq7RlmTEE+0/VVvZl/t9+JRlyBOlyoLIdLZbkk1S7OveNN1bv3BhPJMt2J
4kCeT6LpSF0bkgG9NQt0zs3JDqmL+GsQnEX3xd/SPmNeSw+dZVVVZR4IBq+O8CG0
Ta1bUt07oDZKaWRKcjNxxI8n2h+ZcebvFXyoKbn5zIumQVrf32V00ckwc29DVx+b
ywrS7JW9tWhDJypO6kyXwG6x9dRO6JGbZhEXGwmrDrkxm9xFUU8DYDEd4CNBS4tW
o5YTFpbUbKrrzzis7pgvf7O50Idjc909ErGnOVCJQXdUrmKr3IAEjtZwEDkh6sJv
Dt+9i1kye34tPbM2HVhv5zGTpuA1zl7DcKQ1gNC2W6AdASS7dM8ED6typsPjxIBn
xwtiOL/TIZ/9Al1+xKCwLDDItB/paBK4c6dVISD7FrQFOn2ukbR4IdF91eOfzhsV
hm48N73DkTJTUS17oLnHN/W2VbCetkq+Qslm2qg0oJv/Kh1h5esbcTR7a3G4b94b
r8nvHLnk8oBCMLFdcJYMGU+HqbGiCZtzUOiOyVaAjz/tFv0uSyY=
=QpYf
-----END PGP SIGNATURE-----

--4Ebn9g37RzN/n+Ka--
