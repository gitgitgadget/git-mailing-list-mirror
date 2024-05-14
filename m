Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EFC18029
	for <git@vger.kernel.org>; Tue, 14 May 2024 04:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661121; cv=none; b=Iiz+ZDHUu0IcfJDbZriRHn8tHpRk6Zf4m9HG8PjEYR61WsQ3+f4WZ0mbuHdwi9IoCpKZxBoPxSpzL+InW8RAkDt87Bms+Ys63BD0yQpQITq/pPzs7j7PvzagiBw2aX3j6z/sKfrGtmP0R3DEwKE/5gpx+96y4huFtTHnsENPfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661121; c=relaxed/simple;
	bh=pQjcuCMKtgFeHBsjBu2xWWaUYMDFxEWkCa11XIcgRA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+ze5nuLVwsGoG+nUpckznhfYCzgsmX9WF1NszyE8N/2LC01V8c5b5WxfbLMe03JTIE7mweNUipCvGBDQPxZ16h2eALa21/8Z4LgmAG4OxKFawz/vbWGVmqS8FPw4hp0RBkQ7fcuBxgtR1i2LmB9ogz5mXY3JTkVvEQZ+jGZ5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AK+X2wMY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQnqkeY4; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AK+X2wMY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQnqkeY4"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 08C911800060;
	Tue, 14 May 2024 00:31:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 14 May 2024 00:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715661117; x=1715747517; bh=EN0t10Fhlb
	IDHchmZ2OvaEiZy40/qSuv0oSiuy4s2Zc=; b=AK+X2wMYfEbfy709KF3/MxKsdj
	9mgNtNqZSbAQunxhcEKzK03TGGAXpaguI1EpDbtNui+Wtwv1NhG46IT4v20gT44j
	76CMIRNhSxC2iKqdPUWKIiIhmFJDEgEpAOUZQtzpYCkzgyscru+ZQHHZIlFXw/NX
	N9HPVpo6F5axxRaksF3sd30ioSEAvbsNFGil/VI3yKClFqDJ4150XCbV5MufGBMd
	9gYdJQy3yhK3m2lkCEq8ybdOe66H9q7aYNwvC2JgYwUe+kH6z91OLQFmxnEwGcez
	/HmQN/MzYqqupWbZUkOWlrWmQfSRtXMnW9lUXjnXEWCVg/DZEjFIBhIvZ6mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715661117; x=1715747517; bh=EN0t10FhlbIDHchmZ2OvaEiZy40/
	qSuv0oSiuy4s2Zc=; b=EQnqkeY47suwfgY2ZOeMyw7mfffudTiIGaWeYER7H0iw
	1cTf7DiuX5j1LYCyK8642/2Q8QWfqvdLSlfZ8etzpyfP/oSAmcbrZgzbnO8kknUT
	VeH0Srwu5cjvTHDbpMZZRTt2C9TcRwNWznK3BJKClR7a2r+b+KAsVETyx1gJViVl
	aGubdDfZYAHrfyXu8WYFILghTAcBJd3wmwLDSsDBq1+O9sWQ9Vbrnj8VvrmXOECr
	Nefee0RIPcKiEa63zaQorFAbAewAFQ2LIPyoO+HzBCGuKNpyDQGFF40iifplxCF5
	ZKCeG3+b7fyLAA/H+j/PZjfWalcK5gfZh+27U92I7g==
X-ME-Sender: <xms:PelCZlA7LExXqNjM4Y5NJ2k6eqSq2ylfXYc-jMY3pbrfhn2jlYj-wQ>
    <xme:PelCZjg91YEx5g8S3Wahjivtgu_TztufD61zawEIQIwDTfJCEdYonH7LCJxuSqTzM
    dt1LyQo1CE3_8kppg>
X-ME-Received: <xmr:PelCZgm5y9M7YKmQB4329i2FA9Ic74JpllUX6OOd8YPQOnA8kmyQal1BLzOgoovYFFq8pfH9LAmCpd6ju6VDb_B-mwPm5WxKNvlV9-ndlkNH40YmWGBY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:PelCZvxKK91o9ynpmY2vGZEiWUjY_hTfakFIomZl9bSnoj_0U3w9Og>
    <xmx:PelCZqQZYfVvEWfIxjpMAOZe5kSlKO54N31K1SQsXmsCyx9ldvaIkQ>
    <xmx:PelCZibfdxNV6TQWJq5oa-zpxitAuppZ4mgkVtvTYLLuIpGQ-rmMTQ>
    <xmx:PelCZrS4KxpFmik6nFaO_ehfYi4Tr0A08Zz-CakV7DEjg2pdCgtw8Q>
    <xmx:PelCZlc38D3-P9IPRms-tnZg4t4_7Th6OQTp8GNBcOj1HwvDeMSqSx4t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 00:31:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d69aa7e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 04:31:34 +0000 (UTC)
Date: Tue, 14 May 2024 06:31:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/5] builtin/patch-id: fix uninitialized hash function
Message-ID: <ZkLpN6UaI_jj2zDg@tanuki>
References: <cover.1715582857.git.ps@pks.im>
 <20240513224127.2042052-1-gitster@pobox.com>
 <20240513224127.2042052-4-gitster@pobox.com>
 <xmqqbk59cnp6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+cyGOPvPvhdq5SDj"
Content-Disposition: inline
In-Reply-To: <xmqqbk59cnp6.fsf@gitster.g>


--+cyGOPvPvhdq5SDj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 04:11:01PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
[snip]
> > +	/*
> > +	 * We rely on `the_hash_algo` to compute patch IDs. This is dubious as
> > +	 * it means that the hash algorithm now depends on the object hash of
> > +	 * the repository, even though git-patch-id(1) clearly defines that
> > +	 * patch IDs always use SHA1.
> > +	 *
> > +	 * NEEDSWORK: This hack should be removed in favor of converting
> > +	 * the code that computes patch IDs to always use SHA1.
> > +	 */
> > +	if (!startup_info->have_repository)
> > +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>=20
> Hmph, in other places I did
>=20
> 	if (!the_hash_algo)
> 		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
>=20
> to find the case where we need a reasonable default.
>=20
> Is there a practical difference?  If there isn't we should
> standardise one and use the same test consistently everywhere.
>=20
> Not that it matters for this particular case, where we in the longer
> term should be hardcoding the use of SHA-1 even in SHA-256 repository
> for the pupose of computing the patch-id.

To the best of my knowledge there isn't. What I prefer about my approach
is that it explicitly points out that this is conditional on whether or
not we have a repository. But in the end I don't mind much which of both
versions we use.

Patrick

--+cyGOPvPvhdq5SDj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZC6TIACgkQVbJhu7ck
PpTclA/+Iw4UFK8rpVfShWiR/btG2gosB6beZGBb4vc79Et+4BbCj4tUiCIPNJEe
pY0LafhobbHcnD02H/jgFdREBYbww/jQanf1ywvnlKevFxdTVrUgFuEodokPeDxW
5rdnoIjC6O1S72W8eT9E7iMHQEx6fGR5AXV0GVYVrghA0epU3AkKkJNM4ZqqdYY0
dnlqeRawx51GdUTXfbFusGC17B1z15w1nbHWl9aY/AWw6/j51Cus4dN9kOjK7caM
i42psJ6t9eoiBnbxUWC2YWhS7hxtJVSOFS62CaSK/mdJX391++1bhhf5oJOB6+Y2
HDskTYrmyVK8S12cx7D7lVa4AZuhfug9YcfOUt+mZpeyFvPCk3lwwfBzp45pMu+s
oTjMYs13NcwrMa5/N8Wzhwf0A9erbiSijKkQAvWybLvwKyo65PM8AnZV6Mb5MUNa
EWy7aNAQBLLpOdA5dhYr81DVQVXP41DEelIF0Of8o2BjhSQgJnHB6Rse8j7GPB3h
oykTc1BgApUEmcIU7Z/arkQKW07H8KJReYHTyJWcw/dnZP3+vev9No1zDsc/9cK5
XG5xO6an3pgfZ4s4rPqVjqDkffEhqSHOY7GA3IPPsBMDj3sWvopKphDWVTrX33/T
qAgXHzOOgKUeWCWqqSqYPxFiVvwaEvLpX48KECi7ylESZbutjJU=
=kHPM
-----END PGP SIGNATURE-----

--+cyGOPvPvhdq5SDj--
