Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDEF3C39
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177899; cv=none; b=pRc3aqXAwpLUN+opck5bnjdP6U0ghDh9e6zDLhqT/PBCKb/jKq8uxf6E/8QOioVp9M5g7+7hLv9PDmv8wOuqLRKbwEa6Ge8ikqzEDCjXsw09cLSCGsY3dPDKsMbSsTlUaa2+dlTDB/uqqmaypBFU/4ZZfFYTjW/aWl1jOuxTz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177899; c=relaxed/simple;
	bh=mwiiC2yWubPkKB3oYTCjWdygOblpWAYhD989RZjo5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TN1zCsceakJ6sRZLwTPNCxpXNDJlab2fXxZj+OFQ8QC4rF8mMEJMTMZO6Cqzo7efhv02KwVF1yacuIn8sz0mmoWD+fZ/pLpbUP7ze/WYM9dZtvJu0MJelhvzrACjbw1Vj+95TeTi1oDFJ7q2hFrsiWeK6EB5TUR+lA4aTN+fvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ri9+tEs1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=muQN9EOJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ri9+tEs1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="muQN9EOJ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9BFE011401D6;
	Wed, 12 Jun 2024 03:38:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 03:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718177896; x=1718264296; bh=mwiiC2yWub
	PkKB3oYTCjWdygOblpWAYhD989RZjo5MI=; b=Ri9+tEs1M5aCtno682R9Z19Bx7
	GMblDReqaxz1hAGllEBbp/8+ZQ7ErQ3Rwt6o5nUjKd0Pdsi6uYvcCtuBY6hahEBx
	6pwus0hRpmVXXzW1EvtEv0d+DoCiK8MvdYn14+gHdKJPCj3D1QtmyFqEBJKr2aQq
	JfrEXLZ0ByC77N2N8L2syHwO8WvqsnlPa88SmOTztLqOjs4WkUJdvLzWpxIhkjfl
	NupEssm37laVJ+Km0InIOx4BlDJO+az1NvfL4OO7r+bZqv94I2sEbRANXySq4/c0
	3UvWtNRpX0JGTwqcTjThqfFs+K6utx6sCVk2bJumOYrHKni2Al3NoXrjomGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718177896; x=1718264296; bh=mwiiC2yWubPkKB3oYTCjWdygOblp
	WAYhD989RZjo5MI=; b=muQN9EOJzelibp+wQzrOPR35yk15IAqwg/1Zn3jX+1LR
	paQ+IaIZca+OtANYe6mZD5w05XAr2Xk4xcE2EifKHhCMUJmZeC+6LZ5TWRJV6GF9
	ohW3CkV3sWHua1FpC0aXigCsoxR/Q7lnDJ31zPV2pikG1iqvAO/01Ov8bWh7OFNU
	dYz489t4Xa6D4d5fLD/MIl2sZO06OxNDinD/HqTm2GiZirqkIpPZxdd/xAU9qv8A
	8DQVWSMhpGdNsrkqFuWhNjI/aezjrBOXtwMdlzw76ucIemH80eIAYfOtLfSmT/PI
	xOGFtegrZi58kKEzFOBjKtOqqyQFvJfqD1f+jmzs1g==
X-ME-Sender: <xms:aFBpZnwLN5UMR2L-rV1KV0oVXoCRt4twS0OVCWHNkm_8CpMs8FPazA>
    <xme:aFBpZvRnB2MQpzAi_bPl93KkRLg2soqVad7K2iBqCUGyUGdwk96RWxWb5CE1lwzyj
    AU8meeZXGLAdetb2w>
X-ME-Received: <xmr:aFBpZhXT3DW_9Sm7DyKd_Z6WlMc0d-d0cOoixqdIvJ1lo4Gh69Kkh98nOJ-moDS-OFBTV8MenevozwwpyhbVXm__gm75Hrkor14HG2X4upEyVd11bP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeffieejtdfgkefhheeuuddtuedttdeggfeiveefueekuddtfeefgfejueffffdu
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:aFBpZhgq6maitDmRMyF8i5W2lUzU0oD7XBXuedOTcXo0Z7gXkNlYRw>
    <xmx:aFBpZpBA6Q0DOQ1ISfnoItyf8ouuEMzNU9RGWgUrl4IPwaShBG8BIA>
    <xmx:aFBpZqJ5-GH9hl7g0dlHGdzlWQdjRb6PygJIKJyhBHilpZjJ-xcNJg>
    <xmx:aFBpZoDnCAQC70dqyca6VXATS3u-87cqfenhduq-rGxQN3_rAm4sTg>
    <xmx:aFBpZsPPxSu91kbtlyxHTVxPAG3ItrnhRsq0uIHhUGpnJMM9gUDS-R2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 03:38:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 305b8ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 07:38:04 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:38:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 19/21] t/helper: remove dependency on `the_repository` in
 "oidtree"
Message-ID: <ZmlQZUXMB20PBEul@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
 <3xu573xqbhfb3epktusqdxujal5ibkapnngiyzonae7edhu24p@fdajnz4imrbf>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="27lU0PXSNmMArAYI"
Content-Disposition: inline
In-Reply-To: <3xu573xqbhfb3epktusqdxujal5ibkapnngiyzonae7edhu24p@fdajnz4imrbf>


--27lU0PXSNmMArAYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 06:27:51PM +0530, Ghanshyam Thakkar wrote:
> On Tue, 11 Jun 2024, Patrick Steinhardt <ps@pks.im> wrote:
> > The "oidtree" test helper sets up a Git repository, but this is really
> > only used such that `get_oid_hex()` can parse both SHA1 and SHA256
> > object hashes. The `struct oidtree` interface itself does not care at
> > all about the object hash of `the_repository`, and always asserts that
> > inserted object IDs have their hash algorithm set.
> >=20
> > Stop initializing the repository and instead use `get_oid_hex_any()` to
> > parse object IDs for the "contains" action, like we already do when
> > parsing the "insert" action.
>=20
> I think the motive of this patch is already achieved in
> 'gt/unit-test-oidtree'[1], if this is to be merged after that.
>=20
> Thanks.
>=20
> [1]: https://github.com/git/git/commit/79d9e08db3a08c5a06e2633a39cd38b980=
e654f4
> mailing list: https://lore.kernel.org/git/20240608165731.29467-1-shyamtha=
kkar001@gmail.com/

Okay. I'll make sure to evict this patch once your patch series gets
merged down to "next". Thanks for the hint.

Patrick

--27lU0PXSNmMArAYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpUGQACgkQVbJhu7ck
PpSMIhAArPhXxiQZ45fC75MuEIXbXf6O118b0KtySvwYnfyJb019tQ/KwI08VuDZ
SLJL1jpWc5I6Jmxk8XswFzTHXh5OOOQL9VsonGkkZ8zb22XZ5+FH3vPvngIhcVgK
RwwybO7RdeMgF6+wCXtmyZ4OeBhSqiJuNx1qESFyjfNJyoQQsj3wYuVO8WgOr8Na
PlGgyIgQMmIjDINGE4d6yyRyjp+D4GdEThtSrq/e0y3mXEE3uyK7btmpWr84MRI8
6mpIylCErM1CVBI0Smz6khgEIYNIHGtFkWeTY3473ZxgAlomjHEI7VreOdNEjJCL
V0EOpImRuP4W19Yo6ycTGRjGNKWxZYPZk5KavMO9U4DkV/wHhhZ8Fyuuwrx8H9k5
pqR1BcVeNc2PT76RYX5jSFK2J+8R3njVP2Fw6CxZgJKRwFhOgfJ6eRTezLxdZjan
E0iqZ31PaZ+4tvpgYL9p9VA6X6Iw6Po32h6pVbqscigBQ43R84Ws1rJMi96Zavep
MrNv0FRITnvTGAwzRytwUyOHRNjoRHE3RYPz4eLWxFrUOXmjULc5f8RvM3CT/zPQ
O3Hm8EnVrDr+786L4MXnGgBfWT+dG7RlbDC/2M8UzeQwcWkIyZw1xbhrL9SIHxHD
5obNrS2XUOwCwRsCBiXE2SbFFOk9+1m9XnFr0HLqYHHgKWtGOcg=
=Guvh
-----END PGP SIGNATURE-----

--27lU0PXSNmMArAYI--
