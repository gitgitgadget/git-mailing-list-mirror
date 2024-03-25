Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC5F19D1CE
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361261; cv=none; b=isEJQn9fbvzwKWd2p1kCq/pHpnTjKUx9e7DUrgUcwSYykx21YCrWu4vFKkkhMiaGe9H+AET/nqtb+EKYA5gLZ9kfyHT6cySXq1cuXQSbZ5ABwtsZu//X8pZGvr3Gu92e5EQxoMllnpL3aUPQ4SvnMnyvX07R3vRh6QZY0pMTrg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361261; c=relaxed/simple;
	bh=Q3cMjq59wOxecyA9yYw7hoRHjLwKiWPpjkgInq9mxAY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaZ7SWafAkMwcbe3whxNVnyPhgOibCzP6moi4kRDbTLJMCIQHQ3ZM941WnpHkYMeyti5lypcPb3hW95Hr1MFtUaIMLiN5AS625JqLUIDb+gKFbV9XAMgT/zqf7SGJcOL9gMugcBu1wG31Ka9645GsMO722xawW6QmQtVwBN1zMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tr+nnjYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ojz1Gu6E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tr+nnjYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ojz1Gu6E"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F399211400FD
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 06:07:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 06:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361258; x=1711447658; bh=l/Peby/0z1
	Su0b0HSUcSskYLROZs5NTytPNwdBOvTe8=; b=Tr+nnjYoK28XPlqcw2ZeMXtLxP
	gRDSZUfy/hD8FqFwzXV4rIUidHKPfMewLeY8IftbISKHGRh+A1N4K87zy63PTAje
	Bjyg6sCrao8O5gW4BS+tvSZ3mJ0DOgXHzwoVN9GtR0xBDOLYgQu3aLeEtXwcWNte
	/CTzckAFEH3SRz/uqgwIQKax9EZCCFomEpb4Ag7VXlRKd8geEFFkxjsluRmZKF1d
	Dgux3lqxH9tC+lriJwYmYrjMW950KjSDdZIixFny7sPBrXCGAmOtCHt1bRkNMs6q
	j11AGekYTMNzzCeNTVqALI5nQ1709YzrCCsgSgPlNL1sD1aUUKk8qsihdySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361258; x=1711447658; bh=l/Peby/0z1Su0b0HSUcSskYLROZs
	5NTytPNwdBOvTe8=; b=Ojz1Gu6EaEtwK+KjoRJpk11IKLIdwu8L/jB0PC6Ehz8q
	8YrF4LGTQmoJYPmEBNewmro+IqIS8UTVKkNj26AxZUmCmttAQSSBStVjuFR2wPQV
	eaxtarA/VXaHoNrBIfUfB7dxuLbPTvPMNQYM9s7r6iICn+2AaAp6rG8+HH9OD1zT
	TXi+rEQdA0wubRLrEUrQBodGZWw4t4A/ECI8Spa1MA0r2Z6ZQ291ipZkZCbi1jWy
	QhD6S7WayTSmEzr9T/2tWMv9uR/0lYRHEfctUtSzhdOm0OUL4QFFlL2u1qz/0MnI
	SCs7QNSzURmZt56X4pYepKlMb/bAaOwQYxfHBUy2cA==
X-ME-Sender: <xms:6kwBZjZlQr97YRvU0TMquaPSA2m5glwerXwsNZgmUb_bwm9jXpwHAA>
    <xme:6kwBZia48X9mXXptkgZLAhwnIRMwSxBHPrEol3TEqvBV766HLPbTbl9_OI8O9m9V1
    MaqZna0XZ6DD2Vlug>
X-ME-Received: <xmr:6kwBZl_kxVNsbBheUXQC9iBWYW_lQX_A18TSujMf2vqJsPfS2L3aHNXPINvdlB-CgEXLsoZD7zEo-_s10ID4poJGX_YapWPhoTAL1YiYdcocqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6kwBZpoC56TjV0D_e1gB_3FmarDdLcycKRdn9sRXqIMnedwIUOR8Gg>
    <xmx:6kwBZuo77vAj-xKxd3kERCZRSsVXAWFSF8rBnlATouJ4n9yNTXu57w>
    <xmx:6kwBZvRa4kf3d0qlGEBMgCdIttv6EGAUsNt9ZUHTRIeo3Xa3Obi1QA>
    <xmx:6kwBZmqDpdzcPkX24WZfkmEuBJxoKWRaeQ0BHM4ma3ix6tnWREYONg>
    <xmx:6kwBZl0cicG1AREb0tVnYCG7IbxYHRqZjIqSSTo2JTVpMouseK1azw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 25 Mar 2024 06:07:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5dba9a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 25 Mar 2024 10:07:27 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:07:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 2/7] reftable/basics: improve `binsearch()` test
Message-ID: <ZgFM5pUU4TKRbiMt@tanuki>
References: <cover.1711109214.git.ps@pks.im>
 <7955f7983a6d8ef81a572f108b11c7afa93e34fd.1711109214.git.ps@pks.im>
 <zlj4jlfv645bxqgtjkrm3qdan3b7q4lzhxv3nqp7qagycri323@m5hhhxwuoetv>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vxXePNLS4IGan9Ts"
Content-Disposition: inline
In-Reply-To: <zlj4jlfv645bxqgtjkrm3qdan3b7q4lzhxv3nqp7qagycri323@m5hhhxwuoetv>


--vxXePNLS4IGan9Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 01:46:56PM -0500, Justin Tobler wrote:
> On 24/03/22 01:22PM, Patrick Steinhardt wrote:
> > The `binsearch()` test is somewhat weird in that it doesn't explicitly
> > spell out its expectations. Instead it does so in a rather ad-hoc way
> > with some hard-to-understand computations.
> >=20
> > Refactor the test to spell out the needle as well as expected index for
> > all testcases. This refactoring highlights that the `binsearch_func()`
> > is written somewhat weirdly to find the first integer smaller than the
> > needle, not smaller or equal to it. Adjust the function accordingly.
> >=20
> > While at it, rename the callback function to better convey its meaning.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/basics_test.c | 55 ++++++++++++++++++++++++------------------
> >  1 file changed, 31 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/reftable/basics_test.c b/reftable/basics_test.c
> > index dc1c87c5df..85c4d1621c 100644
> > --- a/reftable/basics_test.c
> > +++ b/reftable/basics_test.c
> > @@ -12,40 +12,47 @@ license that can be found in the LICENSE file or at
> >  #include "test_framework.h"
> >  #include "reftable-tests.h"
> > =20
> > -struct binsearch_args {
> > -	int key;
> > -	int *arr;
> > +struct integer_needle_lesseq {
> > +	int needle;
> > +	int *haystack;
> >  };
>=20
> This is probably just personal preference, but I think `key` and `arr`
> in this case are a bit more straightforward.

I was trying to make this consistent across all the callsites, and here
I personally think that `haystack` and `needle` are well understood by
most folks and generic enough.

> I do like that we rename
> the args to be more specific. Do we want to also append `_args` to
> denote that it is an argument set? Maybe `integer_lesseq_args`?

Oh, yeah, that's an oversight indeed.

Patrick

--vxXePNLS4IGan9Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBTOUACgkQVbJhu7ck
PpRP1xAAo03KIHAnivbwQnDi6WhVhgg5NnQYEAFRWkst31kzO5zl+QxfWofgYl2O
0md9G4vaDhbRHzpVpJnMsuV2My7ZQhHUHgo2BAy0VyQQFdvgordYNdaSorjGXBua
suEAcX9IrJcAn6gGtXLfXja+SoJV9ZoYrITPkD3YvpPPNWkTlxqZBvuQlgDEwa3C
hmCZD7KKtU39Ad8rWi1YmIAXCc2pVm0DHOEiVVhgugd4SubPMr70x1WgGiapCldU
kfejbHKEIqcIj1sCtSYQ1tvSCMHGVhAHkF4H09+M0We1QNFbEqIpKBMOBtEuUCyQ
B5uypd29mZORF/PlFFDckcz/E3wOcrjKFTduKP8PmEZQq+p4LwlUooTRiz74oo3f
YjZor1BSBgfqLoSryN9dycqeJk7L21yeaC+zT59KWAtm3luLB7qAM5ADkTdf5P7m
zNIrKqWZmHXuZYOdeEPVEZ9VghhpHBoxXNbKU1eT38PxqJexhoO+j1K7nV01b4jg
YGoHBLL7jO2BJZYBoSO4byMtJGDUoZhg6/kq+F8j6ZfPvLNh/Ak4t3PuovpyfqL/
Zj0aweZACfquQblAol3+B2z8ej6CQGrwn9eFahqJGKc4nWe0721xPBXG0uHb6kMQ
cZ+yRd2+15Rw8WXakRnOloE+aWzag62YH+CGugaYmXmSogCyreQ=
=oSAw
-----END PGP SIGNATURE-----

--vxXePNLS4IGan9Ts--
