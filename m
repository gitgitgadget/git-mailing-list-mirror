Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BE58234
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199826; cv=none; b=DIkqJu1PwKs987r1WFJcub6xFqNkyR2VSayjj2oBlXlhXrrNpxWCMm6E6HBotIg/VOvIaYfc1consfT3eBrUvsMbtXuPABnHzk/pSP78MeRi+WbHjzBdSmNIyrtLnX39w9KVGyMPj76EvSZly6L61JCTOGK4LgNgC2zmVVTeLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199826; c=relaxed/simple;
	bh=+Tg2m1knKXQ7gznTYRPhwR3t03uojCv43C6gZTM9BuM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKsiI6lgZTZ/dv9lnN7bCdfbl7zOPhP9eKBeJDGy+4oWT+8CnuZvJyqKSkvhQAZkGbetDE6n/iIr3LfUsZ9Ya1J6dD/ncTgVmbDqv4p/lGiiCTXLZHzemP/blbaNBXjrS/KvIMnSyWPBUK/i1ftz8LyOe6EkT+26esRhw1oozSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cQ8tDyAL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GKZjYpgn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cQ8tDyAL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GKZjYpgn"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2B1EA1380136;
	Mon, 11 Mar 2024 19:30:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 11 Mar 2024 19:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710199823; x=1710286223; bh=blbVyC0u5J
	VXCXFO0uMhqO6YSVbTAeMSq8lyan3mSVw=; b=cQ8tDyALiLwCZyHLgpvpczVvQh
	My1zvvPq0e4ILKJViaQS4w3cRjl9GQ+nk+tTkdLkEGKUR9WBdvcUCov7JuFsuGsi
	NN+l2VE9AiEnIGAnbS+3deIY7xReAGf+jFP4Zr752TuvOpv0dFCC/sQDxYv9lbIX
	AAurW0uqPKd/7h2vQgo+NOdgjJfBe690mjDO8O0VIBEjIBRYZhhJG4BkpowQYfkY
	RKgjMXKBLFUVXwRDku4juwgGQjKqQpRB89BL2yPfnw+oh5BVc2bGkyGr7vldP6lK
	lPDAySya8b2e8WKwH1NjKmbXsGErxcVs9rLdZEEKYGJGDLAzcRVuuKum5gRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1710199823; x=1710286223; bh=blbVyC0u5JVXCXFO0uMhqO6YSVbT
	AeMSq8lyan3mSVw=; b=GKZjYpgnCCxKwzYwkCU/MeMCyJ58D/7vtk0cPB7bHUoj
	BozwSTbyAhK3GTMF0JUUvkZljxXqQm6gRYIZpTLunYeOV/d8oRTTvB9gsRNBYAmq
	eS9cyI7iQl/QgNq0azr6vbLe1cXOqFuEtycgPfb1v+s//Q0kT/KVHVOHtIiP3u6H
	hMcw1jcTv+4hPGBviek0qXUDuWRqeoO/IFObC5hW3uetUNJeYGIsT6VIoZYM6+ih
	apxSebb4BxtBDptf2MEwdYu0t2RlCWOXGKllUFIgb/lI3TzB1Jl6stzTHwHBRojI
	yklWa31lf9/4YMq04ZJg8W+6Z7H+dN6BexiTK2izzg==
X-ME-Sender: <xms:DpTvZUy9t6m-fDYhQmTvcjbopK53rxoZskO4Gca2Ms-vj8SH35OfnA>
    <xme:DpTvZYT9UwkVUv1MMG8yjj43DQVE21c8QGoG1q5OIfW-LNwUkJokQGTw6nNZZpOIl
    FYiYTNRe8A6FH8N9A>
X-ME-Received: <xmr:DpTvZWXhl5Mbjw8cc54kHzKh55DxUOaB-optfiinDBuKtOl3PTvyRjXQfKwF02IsnQRHRE1uVYRMlNOr4nsCsRygeBPHesoB_eyTAWvzv2ASVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephfdtvdduleegteeghfektdduleeuleeilefftdevleelveeuffeihfehfeekkeeinecu
    ffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:DpTvZSgiK_CTRhdJBGhTeZ1G0WGQS9YZvI7Rdp9_Frvs-YALjlD_EQ>
    <xmx:DpTvZWA_MWy0MCr-jNgiHygsVDy_yo18Ib_WKN7cHt5wayIxo17sAA>
    <xmx:DpTvZTLYTn2BXWFtWWTA_QvM2dIjBVVJm3R5aA-pFjUjPwgC0giAnw>
    <xmx:D5TvZRNSU1LIYhBJ12IUHRiNEeHkvhwr4QopuYcvj8bn33IKcENcAw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 19:30:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fc19c472 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Mar 2024 23:25:41 +0000 (UTC)
Date: Tue, 12 Mar 2024 00:30:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Angelo Dureghello <angelo@kernel-space.org>, git@vger.kernel.org
Subject: Re: [BUG] cannot git clone with includeif onbranch
Message-ID: <Ze-UBgQtoWK8Rk4F@tanuki>
References: <72771da0-a0ef-4fd9-8071-6467cd7b6a6b@kernel-space.org>
 <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3S0OVMTWRj4PLIK4"
Content-Disposition: inline
In-Reply-To: <Zetw0I0NHgABR_PX@tapette.crustytoothpaste.net>


--3S0OVMTWRj4PLIK4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 08:10:56PM +0000, brian m. carlson wrote:
> On 2024-03-08 at 19:25:52, Angelo Dureghello wrote:
> > Hi,
> >=20
> > below the bug report, not totally sure this is a bug btw.
> >=20
> > ---
> >=20
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >=20
> > What did you do before the bug happened? (Steps to reproduce your issue)
> >=20
> > Perform a git clone https with includeif onbranch in the .gitconfig
> >=20
> > Create a .gitconfig
> > with
> > [includeIf "onbranch:wip/pippo/**"]
> >         path =3D ~/.gitconfig.pippo.inc
> >=20
> > git clone https://github.com/analogdevicesinc/no-OS.git
> >=20
> > Cloning into 'no-OS'...
> > BUG: refs.c:2083: reference backend is unknown
> > error: git-remote-https died of signal 6
>=20
> Thanks for the report.
>=20
> I can definitely confirm this with a local Git 2.44.0 built out of my
> working tree.  It seems to trigger as long as there's a `path` entry
> whether the path exists or not.  It _doesn't_ seem to trigger with a
> `gitdir` check, but does trigger for `onbranch`.  v2.43.0 is not
> affected.
>=20
> I do definitely think this is a bug.  First of all, we should not
> trigger BUG conditions, even if the user has done something naughty, so
> we should fix it for that reason.  Second of all, this seems like a
> completely reasonable thing to want to do, and considering it triggers
> for existing files, and that it worked just fine in v2.43.0, I don't see
> a reason we shouldn't have this work.
>=20
> A bisection[0] leads us to 0fcc285c5e ("refs: refactor logic to look up
> storage backends", 2023-12-29).  I've CCed the author of that commit,
> who hopefully can provide some more helpful context.
>=20
> I have some guesses about what's going on here, but I haven't poked
> further into the situation, so I'll refrain from speculating for now.
>=20
> [0] git bisect run sh -c 'make -j12 && cd $TMPDIR && rm -fr no-OS && PATH=
=3D"$HOME/checkouts/git/bin-wrappers:$PATH" git clone https://github.com/an=
alogdevicesinc/no-OS.git; RET=3D$?; [ "$RET" -eq 128 ] && RET=3D1; exit $RE=
T'

Thanks for bisecting! My first hunch would've been that it's caused by
the change that changed when we initialize the refdb. I would have thus
hoped for 199f44cb2e (builtin/clone: allow remote helpers to detect
repo, 2024-02-27) to have fixed the issue. But the bisected commit
points into a different direction, so I'd be surprised if that was it.

Anyway, I didn't yet have the time to investigate this issue further,
and am currently a bit short on time. I will have a deeper look next
week at the latest.

Patrick

--3S0OVMTWRj4PLIK4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXvlAUACgkQVbJhu7ck
PpT3/hAAirZIxNP1WyMs5PRC2F6tLlHtn2OlrTUR1l+CkLMuvRGn8jlcQqRGBbK3
P0b3bn2QlhM+tyf4Z5Uly1fWYsWCu9gkpa4YPpcRDtBWsHOPwk9cyIUlJN3B7l0r
ypMXl0g+1wOYl5D+ZnmpNDeaKd6BvdvBNioNe+JuremEQaY4QhgE2FlLrthhQXia
h4bR5WKMaU8aoJkDCghbgpZWD2hVbXesUQbt9JOZfXyNSXCu+LF6v26LZ/JiYZQV
l7XAW/JCQg6u039zyWk5II6Mpxe6RJyBS2N9K60MdMVBdgciMl17PPuC1Wg2HvQi
1UMeyYwPhmpkkdpqPJUo5W9D44CoQupwAsgz7bFi71UzzUYG3QJnR7dPMrqzTkmk
EnxoglxiX1KfTqAmqROAz0ispDf58PZCQVzgiM9zCwSra3ut3xvsC4r2IHoKbFrs
Au+hJWMMjapAA98lFABqkcZsixt7+G2iETee3cmIw34K0bi5ZpxXFj2UwQogX8Gn
nM4d27efDcSOLb9G60h82Gv6xqHM4tX75TmHP7nAbrlTouHnaFv5Cw+sTMV9pHjW
wIFIuU+KL7rgjBtj6gEbP3bEDh2SjPkmYL+X2ElLBMYiCdKmTD9ZFNU5gToqvCgf
t6cxWpNg3ToNXCZNW92zBIHhjv+fbkxkBPv8YI2D+eqJ7XW0bks=
=Sxn/
-----END PGP SIGNATURE-----

--3S0OVMTWRj4PLIK4--
