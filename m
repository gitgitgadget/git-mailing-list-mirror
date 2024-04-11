Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F72EAE5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825724; cv=none; b=ibSbJFdeW7ksHY8VXZDTbcePVAS6YUUi975zgPi8q/IT4fg/j837infwkSMCYjbhm/g8VC6VzNk2LoybE6ksLBMe1SqMGOvjl4gKJeO5mBs2X/cDOeBxje0zYOikOmdpaN42WMEjb/3sJ6j6Kib6fA+rSG7gqTi3ymUDg/yNWyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825724; c=relaxed/simple;
	bh=slE4iJXQFdJEQARDyHut/blUc/Ll0rkMPOhR8i/HKkM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPtAEkRzSwJucsDWPf0SvtcJFYX8lS1mVR/rjJoVfkfhErl5C5+uTAr0GVnx4B/SMGq0J0uaH3Tz7z5RIrJIKcABDQKHf/ibftTbSbIBGoyplOXgQe3CKhwe6RwoErTUU2/O0geD63J/kU1p3dSc/EUpxs/VPYvD4/FSYrocWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFwu+Rya; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMcbPOjd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFwu+Rya";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMcbPOjd"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C16B51380163;
	Thu, 11 Apr 2024 04:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 11 Apr 2024 04:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712825720; x=1712912120; bh=zgigrmgdHg
	dpK4uqgZ6O8cfEg9mbdXCJA21+8HkdCoI=; b=NFwu+RyaX7Jvm+/dY/7q3kyH/z
	W1yzWTnhPJR3EaubuOR0DT5UOqvbr2CjZ7bf99c1JjxdafzOCogw9/i/rr70HpTY
	YYGnNqjOI2mZofKQ3TgMF3IgcBPCc/9TqckrTW4FalbkeQ3yZ+hu1hfPVieiWZ60
	8XR3OP3f8oNGjQol6cuisTDOReJMa1cBRJu++5Cr4XYTMke6GplZxADR8l/q3Lhg
	Ds0vi+SWqNEjBapTzn3/BaMr1l5UxN8NA0NQYCTbOM5HlifrNFPP2R4IKLuUH/f/
	7/nOwTspxX/Ch9QQyYFAdaIZAX7j2MYU9qMKdbBHhrmcyEK9GRp01k/HAYpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712825720; x=1712912120; bh=zgigrmgdHgdpK4uqgZ6O8cfEg9mb
	dXCJA21+8HkdCoI=; b=vMcbPOjdMdvvveDxsPVEd+m+c7j9DxtgUk/voFS2Xw4H
	X1jw6XpPuH6UShvqDITj2sBrAxPTNyJsmv+yoz6cp871buWx4u1E5IwyMnrWv3wn
	J4C3itRf7eypPc0uDHJT9BgKwGM0vtEbrb0d4CrMIOkQtGimv5RNsCckNJhmDqxA
	eudD5YYFJ2q5Onahga1fYc/+l8rfhmAKS9obONd+uvGXf7e94IE5yA/6UdhWYyY+
	ju7qfBf52XeWMAZpBNCIem1WoNXjQctvyLELJL1PpkT0NQYzDxB+hU3Kgriq9870
	DcVADQbEyfQp1kd8OJMmJ2ftsrAamW/xcwj5nW0QWg==
X-ME-Sender: <xms:eKUXZs-y9Z1uEyNvBI6FNC-NZCz34aXJ_NcskWNVMpKB6UusSh98sA>
    <xme:eKUXZks4DaEK9JtnYyOp3w-rIC3Ui3F4h7-j3aMdi9zIDiZdYuhVEwx1Mq5TS-L5_
    M71bDWhufGuqMKChg>
X-ME-Received: <xmr:eKUXZiCyuFn5r-0Iwfh8RhuZ4fOnqn7Z6B6t9TMQKvCPCY7QdommNQ2HqE6ytWqTdbrnGSG0QQit8n7ZdfMKsOysRSS0eUCNn4RiX-2rshSXBgc3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:eKUXZscDEF6565zb-lQTu9USvb-uh-UTW-P3FfpkQkLCTLxIN6SwQA>
    <xmx:eKUXZhMq7rkMpogtRgsbyqR6UhO1kK-kpihUzsNt4KTDxw-POyt7IQ>
    <xmx:eKUXZmmYn-hlD1QgWPPcA4wwN2WbUPCYxV2ohtgeyLsfRxK00SnHcg>
    <xmx:eKUXZjvMS3C36HILCcf4ro8VP5SlpdUNL1ZOLlIbd0G-xGPRTEiDwA>
    <xmx:eKUXZk3aQVkTXjtp7T8s3a2mTmPokPrA1VYcJbB5AU5nPSPo2CBJwqDU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Apr 2024 04:55:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b8452cc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Apr 2024 08:55:05 +0000 (UTC)
Date: Thu, 11 Apr 2024 10:55:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 05/12] ci: convert "install-dependencies.sh" to use
 "/bin/sh"
Message-ID: <ZhelcuEL_D8RRtQb@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <6abc53bf5173e7de3fa271d175145c1672f17a88.1712555682.git.ps@pks.im>
 <powdcoghaz226mefeeoinoyryzhooiqifrix76hocdd7scu42x@xbfkvqu5aa4b>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Azm6VzfhK/p2r3Ds"
Content-Disposition: inline
In-Reply-To: <powdcoghaz226mefeeoinoyryzhooiqifrix76hocdd7scu42x@xbfkvqu5aa4b>


--Azm6VzfhK/p2r3Ds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 03:46:49PM -0500, Justin Tobler wrote:
> On 24/04/08 08:46AM, Patrick Steinhardt wrote:
> > We're about to merge the "install-docker-dependencies.sh" script into
> > "install-dependencies.sh". This will also move our Alpine-based jobs
> > over to use the latter script. This script uses the Bash shell though,
> > which is not available by default on Alpine Linux.
> >=20
> > Refactor "install-dependencies.sh" to use "/bin/sh" instead of Bash.
> > This requires us to get rid of the pushd/popd invocations, which are
> > replaced by some more elaborate commands that download or extract
> > executables right to where they are needed.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  ci/install-dependencies.sh | 28 +++++++++++-----------------
> >  1 file changed, 11 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> > index fad53aac96..7bcccc96fd 100755
> > --- a/ci/install-dependencies.sh
> > +++ b/ci/install-dependencies.sh
> > @@ -1,4 +1,4 @@
> > -#!/usr/bin/env bash
> > +#!/bin/sh
> >  #
> >  # Install dependencies required to build and test Git on Linux and mac=
OS
> >  #
> > @@ -30,19 +30,14 @@ ubuntu-*)
> >  		$CC_PACKAGE $PYTHON_PACKAGE
> > =20
> >  	mkdir --parents "$P4_PATH"
> > -	pushd "$P4_PATH"
> > -		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
> > -		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4"
> > -		chmod u+x p4d
> > -		chmod u+x p4
> > -	popd
> > +	wget --quiet --directory-prefix=3D"$P4_PATH" \
> > +		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> > +	chmod u+x "$P4_PATH/p4d" "$P4_PATH/p4"
> > =20
> >  	mkdir --parents "$GIT_LFS_PATH"
> > -	pushd "$GIT_LFS_PATH"
> > -		wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.=
tar.gz"
> > -		tar --extract --gunzip --file "git-lfs-linux-amd64-$LINUX_GIT_LFS_VE=
RSION.tar.gz"
> > -		cp git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs .
> > -	popd
> > +	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.t=
ar.gz"
> > +	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$GIT=
_LFS_PATH" --strip-components=3D1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
>=20
> Do we want to fold this line since it is rather long?
>=20
> -Justin

Yeah, let's.

Patrick

--Azm6VzfhK/p2r3Ds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYXpW0ACgkQVbJhu7ck
PpTi8xAAjEJmsuG27xsO0jo7DgK6IvucyJdkpa5KCDt4iloulSA1m+ss0Fc641Tw
o72De4UR1D+6rtDObdXE5VXlN0YW99Q31+1aCt2bQMeqzgoxHi61pPjfAS6eF4no
jMAAbcJEorU8Wpg8I40DQyYGsmBVUuurAgueFuGZ9kyF5E+uiizq1rRlf/ff3Wmf
cLaKsugcPj9cOkMWok0+XpNvcEUUx0tbTx3mG54yBWFLvm0ZS9QncdYPJSmftduL
LM663mU5mhmgj6oqo6ZFS2jRy4tdlszWWc9vwMqewSlE5y0zSZ/SV3EU+zU5JXf1
nVE9AphBdXnptSMq9YeAX8JB5Tq5RVki+AOvIL0T1VcYWJwMb11juFe0Z236aMKl
dWt8zGy7BqnuFU/+9Xvy5mfWUaY0F1rRMo5QmgiZgVpGJlvaqV/xoDkY7qcXuX4p
90qT5yhWJHJTb+50Y8/zGOLvTGiKFWFMBuPO/Tiamh+wv+gZyQ+7bMXFfB+341+b
6p59X/dt2LIltnJeG75tSbCdTDl0eiYxP9iDrJatl+p6W93sMmMq7MlxXgEK+Cxf
ID7MRJ3THj/uTkkL8zlwvkYihzX0raZftZg46cYY5leD+3LHUyKHYB9j6B97sKcB
jAbn5tsz3JotNGahXdxx/4neOiuv0NjdiFLlWgFgPGH8b+ym/D4=
=DtHF
-----END PGP SIGNATURE-----

--Azm6VzfhK/p2r3Ds--
