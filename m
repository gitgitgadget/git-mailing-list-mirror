Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E690053A6
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538305; cv=none; b=h0y7F1PztU1+p/JRNdgq2bUWT+3/dKta7StSVRzniF7B5ZW9DUmtkUdwdN1Mn0Dz5J/EubPEYhbKMh4xnrP4x0QcJuaON/b0gsBxyLB8l+KL0V5HWKTcsbBnyMCSMpsCpXdWGe1tzUytwPeEL29glpez+xgxGxXNBZkej+xrJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538305; c=relaxed/simple;
	bh=p2xi7xz2kXMpyFlWLfv2DBK58CJyRP+Z0lw4QBmGFlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAkSipkYV8oCXKxaIMPkODZaMlcC4NJPQz2UsH9u+LHy7smLKpo0rfosAElmLqHsPRTyq3rvZh9PJIpm4I0Zt5nRR21F6TKfR2BnoXMBW+v99dXWT37tfN5VuygMLnAwtBJk/5SGVVj3ZTb7T3FZgtT3Z5FH629WhANYUdtn3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1cqoJ0M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cCWWX97x; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1cqoJ0M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cCWWX97x"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id C57CD18000CF;
	Mon,  4 Mar 2024 02:45:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Mar 2024 02:45:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709538301; x=1709624701; bh=ijjfJfKRV8
	ZajVO+CpDSPyeot1grVC2hC7mokVXllLE=; b=Y1cqoJ0Md7hgxOld00kVAlrT3a
	NxE1Heb9ncgE04T/crCD4Ovi4TyCdfGNUL43+KQlDl1WJQOfE38fpU5VYsgLGwL/
	KHvWmXBxXwTi3T90NE0GOAqc1QnY5LjAgbAnud6ckkNp28lbTiEqrQDWyODv5Lfh
	rmAm2cpHWUKiwqMXWgNtVWcjbkJIOtwr6U1z8TjnLWorPVOHeUs/VOD13C2Txo+1
	y3vKW25Bu/0B0jABG9LV/Uq6H2Bb0uMcvTtsSj8mao/fC8YVnn9ery913WQl1BRw
	QJfVT4rx0po5XcaoLm44GHKZXCX7rZmwop3SoEn/g4Gg0e0n8WvNXjEZTx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709538301; x=1709624701; bh=ijjfJfKRV8ZajVO+CpDSPyeot1gr
	VC2hC7mokVXllLE=; b=cCWWX97x2O8i6xNV0zF0a6WJMU5GSD/epmOCS4DXDuy7
	GQHGdnc2IC4l5w7AOi37+8Pr9WP0JYzR8F9mOar8Edz9PxiYPcv9CXVeZ5ZNZGqx
	a/USDfcpzW+UsVpRZn3BhyfYvkQbmjCj5ds3HeKUEMUKaAWjECx1ToWaj0TzvFOy
	/lZcmsb8CK/wNcgB10xI919ngPFLurUaBxlvVhm5CwAlUdHejw7W7kGoyCOiwEkD
	/rge38fHfdq6wb345rf7/ku0TqF7eZA2DpqcTO89JiOuEh3JoaKJyLuHLRX4QWd+
	NVx4JEdm6ojj9Aox0LNGZ87Hs0J5Wo/3Uwko5XLUXQ==
X-ME-Sender: <xms:_XvlZbv8b8TEFoCKpgiedY05stT-lX-7SgGbzGBTctB8Ry5JMSH4Eg>
    <xme:_XvlZce5GK_fJKo3XSlrRgZzKgQYCyuKsBnoW_HxCh-fO3ELJO74KXBc4RMTF9DYL
    tYLDhoK2Pag0IpWHA>
X-ME-Received: <xmr:_XvlZew7RJG1iExJqX4INVLvioo3V6S31aqktHnh4bkNxIdA3SMKFDkFJQ468aZjbZ3e5RMFxUcYLuxkYu8YQ4MdY6I7XVEVwYjEfCW-2Kv0uQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiveektdfggfeluefgvdelvdeftdfhge
    eugeefveejleeufeekgeefffehgfelgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_XvlZaP3VlL83t2MZCAfYpHhP4NXURZf1idOxQlbukfUG-V5Snt6bQ>
    <xmx:_XvlZb-mCxKJ4hl355ftyfMLKklgfniTfzFAu1o-KqGCSiEh52nrTg>
    <xmx:_XvlZaU1wAEy0AnnfVLu_VaS7dZXfQ1blqOz3vestxe_EkTw8Mhz-A>
    <xmx:_XvlZdIsdwdcnjgr_XHbWYbkJDrn1-YN3C7Jc23Jx_Bt4v6mlBFMOdLxkN4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 02:45:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 307cebe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 07:40:33 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:44:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] some v2 capability advertisement cleanups
Message-ID: <ZeV7-NkUwT53IvIa@tanuki>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VNlRdaA/bTpH8Avd"
Content-Disposition: inline
In-Reply-To: <20240228224625.GA1158651@coredump.intra.peff.net>


--VNlRdaA/bTpH8Avd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:46:25PM -0500, Jeff King wrote:
> While working on another series, I noticed that upload-pack will accept
> the "packfile-uris" directive even if we didn't advertise it. That's not
> a huge deal in practice, but the spec says we're not supposed to. And
> while cleaning that up, I noticed a bit of duplication in the existing
> advertisement/allow code.
>=20
> So patches 1-3 clean up the situation a bit, and then patch 4 tightens
> up the packfile-uris handling.

This patch series was really easy to follow and feels like the right
thing to do. I've got a couple of nits, but none of them are important
enough to warrant a reroll.

Thanks!

Patrick

> There are some small textual conflicts with the series I just posted in:
>=20
>   https://lore.kernel.org/git/20240228223700.GA1157826@coredump.intra.pef=
f.net/
>=20
> I'm happy to prepare this on top of that if it's easier.
>=20
>   [1/4]: upload-pack: use repository struct to get config
>   [2/4]: upload-pack: centralize setup of sideband-all config
>   [3/4]: upload-pack: use existing config mechanism for advertisement
>   [4/4]: upload-pack: only accept packfile-uris if we advertised it
>=20
>  t/t5702-protocol-v2.sh | 18 +++++++++++++
>  upload-pack.c          | 58 +++++++++++++++++++-----------------------
>  2 files changed, 44 insertions(+), 32 deletions(-)
>=20
> -Peff
>=20

--VNlRdaA/bTpH8Avd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXle/cACgkQVbJhu7ck
PpRfuRAAndvq15zmYnTcw/OnGFH4jVtRRVQUY3NuTcRzF8iilg4FLU5hba+3dbSB
GIyNk5HMobm40D/+NC5fssoOV4gq+T4rOZv5cD0YdV4wY06gY/7BFeoS/16SU7bw
sYzLa7EakIVQcNBh29LFM1wCN7vMyvMKEQqEHBQswih6XsS76g73t19Vp2+o6x0z
ozofXt4dyyHqSv5rzr+F3THWGAtbcXjksIq9hHVMe4gNukFErEDm99iHsvePjudh
QfwIGc6P+kSxe8Y+BezuenKT5M7KrnphxQJEemaM+W/Rn/OOSwOfEzaUd0GvX4wp
tNFvHEFRzMh/ebvQLxWWWmdUOHdr1GwouMyb8Fe+vQFNgehJiAM7XJeF+Vjp6N3P
j3IA+ia0lrnG125ck3fVyah/RewOAWJLBbviqN2jJwSvPw4q54oPu+ZIjfeSsmpF
GQO5AQ/Q65zrMaUgUKqtw1D5UjwxiYWA2p5MAM3fRyv9mg+z3hGpBKTmYMHC8eiW
xmA8pXmtU/ywYEKIdJKDIygcqkyp//VTYU0ab/3EyZ0bHulGjTWvCTuXemAv+fk2
jCqRDxFt+tc8Kmd7VO0+UjrbeVqlCwlOhJH0KKjr/aGIKb5T1TFO1Z0LghD9I+xQ
kDy9k2fJo0sQoqRkthCQ53QUvYyWf95XlXDsNBj/HEwvJM62b9o=
=FsG+
-----END PGP SIGNATURE-----

--VNlRdaA/bTpH8Avd--
