Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31041125B9
	for <git@vger.kernel.org>; Sat, 11 May 2024 07:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715411872; cv=none; b=J4ClYqDsac358jINvAG418t5B/EAQ4mXWrBh31Fe82Jryv0eGCrX54r+gXc5JC/QcOPJtXA3GZQ9oOuOX/WwRsy6CxFfTkZi30ABXW6f9+/evOKAjr0FVCASOXRpshhpUtsC62OyY/cqfUVXriXBCmTdVMqcyfVHxGgd+bDeVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715411872; c=relaxed/simple;
	bh=UwcQB1p8FN1saLhDxNSO87H9vfaqtssnHeIMJRBG8WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umTRWUaVb8F8bMNsSUE1vZjexbhlWF9w3An9T9xXERc2WRCTKKPRZjPuk5NYWcBPESznTqDuYrt1iYWOqjHcq49Wrcqt6UMH+8PMYYEEBr//GgNNbQLzW8eTM9wZt0e4Yx+aMI++Y7jYEqJsDQsXx6ppvOM9N71Y4ZPMxka7qoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CUCTFM2f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EerL94Xi; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CUCTFM2f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EerL94Xi"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 32EB018000D2;
	Sat, 11 May 2024 03:17:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 11 May 2024 03:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715411867; x=1715498267; bh=DvmCJtfmXO
	SZmiSNtFgT83Yqt3I0c8fy/8nq7yf9HjQ=; b=CUCTFM2fSwJfEKg9/ANHn0+2Y1
	5k5zP7NHCycf2ZkeeVK9ExszNBsztgpa/QUTD9ZAbg272B59nnkU3LMnEvGJfKXU
	ukIuoguUjD7A5ltJtoUdb74kbaTDlgxX3HKSZ7I26z3LAmdNZn0Mmvr1EtdOovX+
	YN5AUqxNYRe72mcSI2ieaeqefZmAXRpIjNGl4GAoPa9mperg/iCx4MvJYg6j/3wP
	YXL5iczlnEl9FEgw+NGFi5CDL8u49oTLWHZejyNLlgtpjixKzt+opOUS48lU8aD2
	N7S3FSCIId5LsvftHhq2ABjR1/SJ++ZRc1vnP4X+y8AwyylgkyAtPj+qMXMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715411867; x=1715498267; bh=DvmCJtfmXOSZmiSNtFgT83Yqt3I0
	c8fy/8nq7yf9HjQ=; b=EerL94XiZndEKr/DOijH3COmUtX2Ho00Srlnx2nynuhR
	3lMp214ls3ci+NEneHEZb+b8HGzN9V1tF88hdznZ+N+AI8w9iJG0eVV596GT+f26
	jafmEKt+eodp7X4zfAiD/TP/rRT5j53pQHK1zCrCmb/TJPHMPWXv9NrvWHXyGEO0
	7TICgOkfwa+8sPpcwFzxypTVGUD4lrwv3k1Fha7PE6zEVVKVYaglxhW0seeViAMM
	Hd28yrG3KLhmPLZiFAdgUSc/NdeNF3G8CUtpXt6KUdG1HNx/Uf2i8E/4C/8sUOCk
	yJ07q97i43mhWEpufcHoEZ/eVxerQcfac4Oiln9x8g==
X-ME-Sender: <xms:mxs_ZpX3YzsZzSwid5zslPxqsayVDW5WSR3GQawsKceSh3UUfoVSOQ>
    <xme:mxs_ZplkUtUbv8F7_ckyFX-fpnkDg20FR9xw1n8_PcAXfS_V5_KO_ON5KrPxmLpda
    atfAKTAqghSygzN5w>
X-ME-Received: <xmr:mxs_Zlaj4jyMY02bL4I3ZJOPYetVOMo61B6fYYp7MSVFVBdL53SecKSuR2e8DSsu_nC0r_uvpxRAj8Y-AmIjKneIOwlEE1O0z0HksU9H8mstMMIBtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeekffelheefkefggffhuedtueejlefgve
    efvddvfeelveejvdeiffdvuddutdeuleenucffohhmrghinhepghhithhhuhgsrdgtohhm
    pdhmrggtohhsqddufedqrhgvrggumhgvrdhmugenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mxs_ZsU7avc-A8BFVHjHZ5CEV3zErQTOiRQmlp1S2G1K-jx3ThqWiw>
    <xmx:mxs_Zjk1zvW4czY9I54E-RyUDayslSy8oEgd0DJrV776TkF5oKcPvg>
    <xmx:mxs_Zpd7EOzbNwcQgzKCcPxHMVSkRr1ofU7bQf_tpEs553awb9GEZg>
    <xmx:mxs_ZtHa36W46a7CrnSSZg7GaimUzYVjUP9cnY1ygfhiijaxNkVi0A>
    <xmx:mxs_ZoxQq5diy27Gl4VFAxZei2zU1jo4Md1I2H19CVUkY0CawVZWWCfw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 May 2024 03:17:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0e1f8a7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 11 May 2024 07:17:29 +0000 (UTC)
Date: Sat, 11 May 2024 09:17:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] ci: stop installing "gcc-13" for osx-gcc
Message-ID: <Zj8blb0QqC2zdOAC@framework>
References: <20240509162219.GA1707955@coredump.intra.peff.net>
 <20240509162544.GC1708042@coredump.intra.peff.net>
 <Zj3F9EVpSmQtyy0R@tanuki>
 <20240510201348.GE1954863@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PzrPb9FA4oXv3CFX"
Content-Disposition: inline
In-Reply-To: <20240510201348.GE1954863@coredump.intra.peff.net>


--PzrPb9FA4oXv3CFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 04:13:48PM -0400, Jeff King wrote:
> On Fri, May 10, 2024 at 09:00:04AM +0200, Patrick Steinhardt wrote:
>=20
> > On Thu, May 09, 2024 at 12:25:44PM -0400, Jeff King wrote:
> > [snip]
> > > I'd like to report that this let me get a successful CI run, but I'm
> > > running into the thing where osx jobs seem to randomly hang sometimes
> > > and hit the 6-hour timeout. But I did confirm that this lets us get to
> > > the actual build/test, and not barf while installing dependencies.
> >=20
> > Yeah, this one is puzzling to me. We see the same thing on GitLab CI,
> > and until now I haven't yet figured out why that is.
>=20
> Drat. I was hoping maybe it was a problem in GitHub CI and somebody else
> would eventually fix it. ;)
>=20
> It feels like a deadlock somewhere, though whether it is in our code, or
> in our tests, or some system-ish issue with prove, perl, etc, I don't
> know. It would be nice to catch it in the act and see what the process
> tree looks like. I guess poking around in the test environment with
> tmate might work, though I don't know if there's a way to get tmate
> running simultaneously with the hung step (so you'd probably have to
> connect, kick off the "make test" manually and hope it hangs).

My hunch tells me that it's the Perforce tests -- after all, this is
where the jobs get stuck, too. In "lib-git-p4.sh" we already document
that p4d is known to crash at times, and overall the logic to spawn the
server is quite convoluted.

I did try to get more useful logs yesterday. But as usual, once you
_want_ to reproduce a failure like this is doesn't happen anymore.

> > > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > > index 5f92a50271..13cc0fe807 100644
> > > --- a/.github/workflows/main.yml
> > > +++ b/.github/workflows/main.yml
> > > @@ -285,7 +285,6 @@ jobs:
> > >              pool: macos-13
> > >            - jobname: osx-gcc
> > >              cc: gcc-13
> > > -            cc_package: gcc-13
> >=20
> > As far as I can see this means that we don't install GCC at all anymore
> > via Homebrew. Does this mean that we now rely on the GCC version that is
> > preinstalled by Homebrew? Won't this break every time that Homebrew
> > changes the default GCC version?
> > =20
> > I may be missing the obvious.
>=20
> Yes, we'll have to update to a different version when the runner image
> stops carrying gcc-13. But it's not based on homebrew's default.
> According to:
>=20
>   https://github.com/actions/runner-images/blob/macos-13/20240506.1/image=
s/macos/macos-13-Readme.md
>=20
> the runner image contains gcc-11, gcc-12, and gcc-13. So presumably it
> would be a while before gcc-13 ages out and we have to bother bumping. I
> do agree it would be nice to just use the latest gcc in the image, but I
> don't think we can specify that here. I guess we could say "gcc-auto" or
> something, and then the actual shell code could poke around for it.

Ah, thanks for the explanation. I was worried that things might break at
arbitrary points in time. But if this is only containde to whenever we
upgrade the runner image, then I don't see this as much of a problem.

Patrick

--PzrPb9FA4oXv3CFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY/G44ACgkQVbJhu7ck
PpS+WQ//ahEm9q70MF4IuFlwWQiHxiPZ5sIHy56/Q7pc88KPIZREDnxcS4zrU5q5
BCI46zn8l15ejXeRdZBOHKKwCg3FYZ8BPdZ0GaQvjtz/Kvte7nisEjiTIRl3Jb6b
8UzB5h1dHa4e/LSxPQZmYkOVZ2vUgTAAotkXyguDvb7oTOCTCjeelDZvMDnC3vI6
xwCiI77HfvLxp10i4EgcvX/D82eSmQbPAQIwHrr6CyYP/IKxl1blpLZuA94478ha
nTXb09LX0l+7EBJsl2hwZGZXYYx5DgNMg0ZsHwOjNcC9fPnCZX/m3swurZmIqTy4
1D8bEKPmGDPC6z0K1Dk6XKbxYv+9Mf80GlM8olDs861U7m3nQ3ORZpBtQmmoFdtn
UVxcabowcNp6VCLtRI7jRBi95pf+G89HF3OQjjTPLgJAjp6vAFnoWj4yQWmJ6nA2
EtOIdwP/Qv1n/L8/fC75icEf5wDJpxzy8m8C+4VmRV2TF93WDmuv5wopd0W3o6wn
w6URQuDhl5GI4sCwYblttp2kHUgWwRzwuam9V0SbOsAiTztOnEnyhlZ6IKLE90iS
p0O/2ZZt4QGi2KEQVPk9FM/1kfGDHt/k5p34UdvLiCZMOWuPC3jODRv7o3z/Cx7P
m3oI3Y4mx3+EoJMIr/32S6UpAgNDX+Sw2j0bnXdlGSeRDcevqMQ=
=55kT
-----END PGP SIGNATURE-----

--PzrPb9FA4oXv3CFX--
