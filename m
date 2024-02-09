Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2786E804
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466687; cv=none; b=NDADkfJk+b9jJN0gkiyB6UkSPYFJljtEFN7TDiJ36QZ8pNXWQCoJLmA2MJKiGv6kPKPF3vyQLwLPJYt6GrPBzLA381iTJDl5tLDez8RrngqFbLU9SajQwFs3ApU357AGWipOz4ODyT4nyCE6UoZzsSppSvAqRmCU/HRLUSI/F50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466687; c=relaxed/simple;
	bh=97DETr6Y6wY0zLXNf2P9KYLBSuIRr3Oh6Y2ZyrVWj2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlglRE4UjtrJPgc0OO+SuIWEob3GNE7toFY3qEXLpbGKCTsboUfZ9ErtpeeZJhbrjfIysq0xw/+NiJXTqs/w6tbioorV1Ui4KD4n43A5E1Ik2tYrfCsnaPlHk5Nskb5iVIfFRMxW2h6iL+h0ID91mOTdMZFK92ea70EZIYgLu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U3yDb4lV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pH062qQW; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U3yDb4lV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pH062qQW"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0B65132000D9;
	Fri,  9 Feb 2024 03:18:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 03:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707466683; x=1707553083; bh=Th7itDMgsf
	yWG7q1gdjK6kVSIqBExvDagGO68ECsXmA=; b=U3yDb4lVngQp6EXapN7D5UjlTJ
	0Tm1h4Kt6Ga9lNpWpKceRwffyzZGUhJYvpHbCtsPYypnYkOhZXa62WB3jOfBk2iM
	UFnsc8HFGSYYpdM4QEs2pLC1A1xTk8xRBXAu+raa0fPl7v5r6X+7113mD8k+HjR7
	OvqSEdGQDwKm144JSVdeW3PbtWUQawsp7unoEYza639SRBP128XpvpPf2UNrMnHC
	lH0BJw3qIj079ZxeNo06iiqw2MwIHp12EB8hH42vetgv9SdFnnsYaQSncM7rnw55
	Y18GkVG95mUWHRlHcwzvxUe/0vgcmGG68JKMsvPAKK95QWPjXoZTmeFtIwpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707466683; x=1707553083; bh=Th7itDMgsfyWG7q1gdjK6kVSIqBE
	xvDagGO68ECsXmA=; b=pH062qQWQ6p4PAjI2F3R4upngt9dMfURg7zshjuDSlg7
	Bau4phxNw3fWeIWQ5DMrPvB2JYl2L7txKZV87IIvScO+Qjs1+Xbt1nVfODOuyEBZ
	amd74VfKb1RpKMI7W2XB6pk4KGfzRkVxkbci66r5CtmJ3K9NCb7VQ5Y/ZaX7KS9v
	laOwS0EbgiUvobLxKYpgu4ZSWbp5XjqRPbVdguBd7Sx3nSO9tvkCYJhUUtys6CmD
	FnNs65smyWa9iYdbY94eQc2bNOpI5jltx5gaSxRAYxhzVNQvQo0AJxw/M5UgVvPK
	7tRp9Dq9MhWlrbefaiutQLp8rEd5AsJuAERZHHOizA==
X-ME-Sender: <xms:u9_FZWy23XtOTNW0p_DMSGNZ3hzzaKf5gz8BzdcyZWZcsqlVvoEoMw>
    <xme:u9_FZSTQ0QrQmGLdyzp75xbTiw6IwWEAKwNWTyyPpkLwPR9hMejWQQtxlwzOi1byv
    L9_-k0rcqP63WAQpg>
X-ME-Received: <xmr:u9_FZYVP5ix6EO0ITmOtMfHqp_l1PlhQK9jMVs-bq6hBG6ksiOWDDtg0z-S-sxK8cCg3aX6jSRHOUu2YuLcF47XzjvwAtRBeF-2HEqNQn22izp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:u9_FZcjFAPN353r51xLOlf1fTtj57z9VPXl6Kgt_eiReVsRcoQIPmQ>
    <xmx:u9_FZYCqqSkTASlnjB_zI9FbOJQvGG4rw1MgzavuyrJ26yZVo9wCkQ>
    <xmx:u9_FZdI0U9uL9sAxNuHquz8nnEWNbkc1UGhbeGQ6EKqmcIwvSUTMnw>
    <xmx:u9_FZbOHD6GYBxlOa2HFc4ML9l7RDxWuYODusIQ4TRmIoaH3iJFyyw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 03:18:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c62c8a93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Feb 2024 08:14:25 +0000 (UTC)
Date: Fri, 9 Feb 2024 09:17:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] Always check the return value of
 `repo_read_object_file()`
Message-ID: <ZcXft0_UbsABjlVQ@tanuki>
References: <pull.1650.git.1707143753726.gitgitgadget@gmail.com>
 <ZcHW_bc6N5umk2G4@tanuki>
 <3f14077f-c70c-5eef-5b25-984fdf7b3b68@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xn10RWzUTB2wS0+V"
Content-Disposition: inline
In-Reply-To: <3f14077f-c70c-5eef-5b25-984fdf7b3b68@gmx.de>


--Xn10RWzUTB2wS0+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:15:15AM +0100, Johannes Schindelin wrote:
> Hi Patrick,
>=20
> On Tue, 6 Feb 2024, Patrick Steinhardt wrote:
>=20
> > On Mon, Feb 05, 2024 at 02:35:53PM +0000, Johannes Schindelin via GitGi=
tGadget wrote:
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > [snip]
> > > diff --git a/rerere.c b/rerere.c
> > > index ca7e77ba68c..13c94ded037 100644
> > > --- a/rerere.c
> > > +++ b/rerere.c
> > > @@ -973,6 +973,9 @@ static int handle_cache(struct index_state *istat=
e,
> > >  			mmfile[i].ptr =3D repo_read_object_file(the_repository,
> > >  							      &ce->oid, &type,
> > >  							      &size);
> > > +			if (!mmfile[i].ptr)
> > > +				die(_("unable to read %s"),
> > > +				    oid_to_hex(&ce->oid));
> > >  			mmfile[i].size =3D size;
> > >  		}
> > >  	}
> >
> > A few lines below this we check whether `mmfile[i].ptr` is `NULL` and
> > replace it with the empty string if so. So this patch here is basically
> > a change in behaviour where we now die instead of falling back to the
> > empty value.
> >
> > I'm not familiar enough with the code to say whether the old behaviour
> > is intended or not -- it certainly feels somewhat weird to me. But it
> > did leave me wondering and could maybe use some explanation.
>=20
> Hmm. That's a good point. The `mmfile[i].ptr =3D=3D NULL` situation is in=
deed
> handled specifically.
>=20
> However, after reading the code I come to the conclusion that the `i`
> refers to the stage of an index entry, i.e. that loop
> (https://github.com/git/git/blob/v2.43.0/rerere.c#L981-L983) handles the
> case where conflicts are due to deletions (where one side of the merge
> deleted the file) or double-adds (where both sides of the merge added the
> file, with different contents).
>=20
> Therefore I would suggest that ignoring missing blobs (as is the pre-patch
> behavior) would mishandle the available data and paper over a corruption
> of the database (the blob is reachable via the Git index, but is missing).

Yeah, that explanation sounds reasonable to me, thanks!

Patrick

--Xn10RWzUTB2wS0+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF37YACgkQVbJhu7ck
PpQzwxAAhYsKt5Ex6oTAJvU0WUHdMGR6nFzpB1IcDkpOOfV3Dxu82f2pWgrzfQWj
V6nleTnilIB+k/nEo3kvtQreG3EmrREBz9qBZ7M0sG+UUy1/5fBAtBvCXREpXLGJ
6z4DwAUeJr8nDpwNWjoDRSil7S2rbFNzOgZQ+lYgvkAX13Oro6VY6OQc7vGmkcgS
Pw5rX7R4/lpufedNz7EboCdgMOsYux2mv4QldtBuh1YcffaUM1402ytY7DffJLgc
QuHQ7TeFCO4eL1VKac+0URjZNUUAevvs/zr0HoUYO7kYa7sTbh/GeW8HNdDDK1pO
YZRJ0FvowX44GJnvrAT2heskoh+PrbY7Mw8R9gysQIetha6YAgfGhlB6pQXES876
8TzRWsZeZbduuGCPKEnSOPDL0iMO7hHY+kzzkkA8vBfh+JAZ3e5ctn/j5IR3l/+v
5+ra54OfPjBMtzCg/B3CXGw4JMXzsiYwLeuU1Wx5m9soHybynSDyhcqf4RlmxqnR
suCl39ziMOfEFRAlQPu55EjP6JYXQHvwVsoq1COZ+0KENX3eFlmIyNUheWhaaudv
sIVapxmGJlkg3zo8LNJeavzLI9SntOu3JGa+g7oGGTCbeJlmH8l8A8t8xdQXMuKE
9bfwXpkr5asH8hHFhg3SquWRPPJGQO7mWux8YV/MoU9nUmcJR6o=
=lsNy
-----END PGP SIGNATURE-----

--Xn10RWzUTB2wS0+V--
