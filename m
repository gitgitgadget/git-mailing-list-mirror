Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092B613C
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 06:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707026415; cv=none; b=fdBSdhsr9erfchZa1VC/jyjRHrEs2VMas+BIJOj/esPhev4/ikHCAXwgTU6VX19mP4Kn54vj5FE+RezIVcmDDpFwG9lGv2VvXZzJllV104NgpNXIHucZUGQzsB7SrwzE+6JzUmBCab7CC2wqyuAxfVFR2e5P3DwLHbj6R4sPb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707026415; c=relaxed/simple;
	bh=uyxV4mvkjDfcW8UPVchKPV4Oc9jGlJn0saaoZScEPjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+bgkAmHxo9Z3zRv8+PxV5Hhm8WOBRqABNUBjd1OQC631aU8NDV7SmJjljvclXxAMk48cuQu1pLDeYraLQPQXeaYQ6YarYjFeDysGIsnN2poIXyzSmVk4e+3FetLbuiNx4lsKHUvXAIs6lx8J4uQTo6Lq0xvPR60R9h5WqpKxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qlYTCBPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1/SsBqM; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qlYTCBPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1/SsBqM"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1C1411800069;
	Sun,  4 Feb 2024 01:00:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 04 Feb 2024 01:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707026409; x=1707112809; bh=sNWsy9rl+A
	uSDf4d+fDpYaAEkFggWK5/TgJ3a/JhoNA=; b=qlYTCBPhf3MO1myc6b+dfH8zCD
	UGIwjocsyAAdaw13fBdp9rnBiFYelfe4NfrJeGSz/aNzguobuHc25z7zqJPA5y8N
	zr8lFWglFABdRM4T7Nvkt4nHJPAmqGoSzEkqXxXldW9uMAQ38rSSk8UOz7TA3sz/
	7tLAU+Ax7aIXCt2gVM1s+5nEh1IZaVu5aIF1iAgIWqo/zUHWwm6UOku/hkU8ydsX
	SBN3U/pHBnSex2D1xvMAigEBS1gy6xbC2gr/G2fkNFaor6ZN7A7yhKCKgaldjSth
	4CRnm42Mngk1AnBiZ45uVTmt/KlxdggJUar5c/SeSTvnxjkAIJ9K8Qwv8EhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707026409; x=1707112809; bh=sNWsy9rl+AuSDf4d+fDpYaAEkFgg
	WK5/TgJ3a/JhoNA=; b=R1/SsBqMM9+RRG6QltAp5qwkWEAZp1z5CJmVJLfDhzGw
	LtLzCPvh/6zi93PSNWhR2lnrDqIIA+j40nQWMLMlQuptZcUSdnl1j/NzRNsg+cDG
	ydxvUtqJw+WXcbUrphyb6/OBmwRWu3R5r/GNUl+sDjMXsGl8EPh+yJlxyhAWyjj4
	PPZdwkXbwBeGY3U/kBQfEvuzBMuCiCpb3KrN9tOua4dbCRrC2ETj7EIKEJj9+yEY
	JaXETWGtYK+hT7FRBrvpi0iK+xdH4fMSFAl6Agha1DO6GpUHMsyzIkWnpMFZs2JE
	F/XVxisOLsjBicQeHN6vAK/GhK44rb8OTbFOTZmf5w==
X-ME-Sender: <xms:6Se_ZZm0SvKCl2-vVih1TAPRqWp6PSgt1lcunnelF7SG2Tqbkna22A>
    <xme:6Se_ZU13Erv7HkElrDQBKJKIo4HST-tADuozXxFpTv5vR92MZvPrHUBuARKVPrhaS
    tLLOwwo1cFy9Unr7Q>
X-ME-Received: <xmr:6Se_ZfpRaPY57onh52Bx5vVTAc3CumnkLepLdfvdvILoc9OWTqF0uiESr0Pfjou5kFMKFl1V13KidyF9-MpoMk_UcYcriMDTATPhvWfIogtb9Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedujedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:6Se_ZZnvbEcXmEkssVZPIoLbBVjPnXn4EbN0Sg9KmoT3cUQ8InK_jQ>
    <xmx:6Se_ZX0-9ROXLb0tiWIFuAgP7Y_MA06WyNJB7m0vYotuSWiMi2zi-w>
    <xmx:6Se_ZYuFslfi-SfYFqgHTyJ6OIxGYnjbZka9x-814fUgvMUpatJaAQ>
    <xmx:6Se_ZSRARWPJZjoD7zl3ce8PuzU5vg_O8N9WQfMK3MY6XVy4shQ3c1a4IFM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Feb 2024 01:00:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 89c35e55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 4 Feb 2024 05:56:38 +0000 (UTC)
Date: Sun, 4 Feb 2024 07:00:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/2] refs: introduce reftable backend
Message-ID: <Zb8n5N3-_kxDyPGs@ncase>
References: <cover.1706601199.git.ps@pks.im>
 <cover.1706862705.git.ps@pks.im>
 <xmqq8r41qo0y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbryAT+5mgN1wae7"
Content-Disposition: inline
In-Reply-To: <xmqq8r41qo0y.fsf@gitster.g>


--qbryAT+5mgN1wae7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 03, 2024 at 12:41:01PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > this is the second version of my patch series that introduces the
> > reftable backend.
> >
> > This version addresses the feedback by Karthik. I don't think it really
> > makes sense to spell out every change here -- the range diff should
> > likely be easier to digest.
>=20
> This, when merged to 'seen' (which also has "for-each-ref now thinks
> an empty string is a signal to show ref-like things outside the
> refs/ hierarchy" topic, kn/for-all-refs), seems to break *-reftable
> CI tests, cf.  https://github.com/git/git/actions/runs/7765401528
>=20
> I'll tentatively eject the topic from 'seen', even though I have a
> suspicion that it byitself would pass all the tests.
>=20
> Thanks.

Yup, this is known due to the semantic conflict with kn/for-all-refs, as
you point out. Karthik already sent a single-line change in this thread
that fixes the issue. I'll rebase the patch series tomorrow and pull in
the topic as a dependency and adapt accordingly.

Thanks!

Patrick

--qbryAT+5mgN1wae7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW/J98ACgkQVbJhu7ck
PpRkbA/+Oxe6Ex5NzDras8QD4QnymtnITOBsK/H/WmC58v3WUHX6p9pTafD9zLYb
mGeE4JdiyX7KL7js3U1ZuEYwPFLFEB03VmfpMb/HRW+F39sAoMmrlnRqWJod4LYd
bDQlJ+jBTVo89wR76mscFItHXUZJvZO2IJH3us9EGoMR0pe7TmdWH95ySnmyr1wx
/k3JQPDDs0GP2EOy2oHE9cDY8Zv2WGumQwS3O34vghnno0aDlgp3i8zQtpBboIOV
AKSBh2Nu19A9jul9XhVpJ3wwgNpXD3BQoeKqOZ9rJZwMX2koHCdoPeRowgi361VB
cqsmnsViQiiaCgJrGWRq6nmo8w9IOdITXNrl1VOuoCPL5orSVmVGZ9zKH0AXMMGH
c1KlJ5uF+WLuW4AADOHV0Pyri0t96iw/UiDWPww7DT7pIhHff7BKVeqsxUYY2W+k
C4dXFL6CBoUnuB+s6Uuo8zxZcmzY+XhX0M1JXLuEi589PstA76b050ipIEMFugjn
0kVvF0XkxoREDriaorkdOmL8zoWKxP+JUSqgHQDk2nLzLhj35SAisnMq3vDMwREC
vqWlRHKh+0CKY12DcN0wVnjHzzv5ECzYf2rovJPlzjFEXHR0cxL0ab+dauxUsYNf
2K2MUGU1TsfOMIeym/DqTveArfOEkJjjCh50MKE1wcAUdwZNYfE=
=FCXT
-----END PGP SIGNATURE-----

--qbryAT+5mgN1wae7--
