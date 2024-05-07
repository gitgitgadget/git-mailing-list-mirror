Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B434EB56
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715054587; cv=none; b=fVgfXZDUHwDV0o/nPqPLe6Mzt3nfjlMPZaH0wF7JbRN1TKVqrgTjRpRjwCMpwCpGa8PGma7xeWaZ3dNvOfvOmCX36YQBgXKBCWwTBy5GGJLJZSE0fI2LeSTOadey+LroK6TmyCQZgRUwstdA6EDtQn5MO60hFR6eLOYI4WrmF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715054587; c=relaxed/simple;
	bh=Wnl6nPusmQNezDRwrIDr3+9O5lnn1gie3fqygI8cULs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ap8J4Rsvv62okMaDcJYr2Ub5B3HjPMAWUqHK+hLEtTr2Gqt9LFQHib4COnqhYLBlXzLG1fY9lQd0bT+o65FEblKUNZReoeoO2oEqbEhAjZx/kIINE72Pnao2rq0Ox1zdpuNincga5ZwYFQrsAZIepR65x3xWjI+c6nchEjfy+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fp4AW58g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eWtp6Mf7; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fp4AW58g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWtp6Mf7"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C780A13803C4;
	Tue,  7 May 2024 00:03:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 May 2024 00:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715054582; x=1715140982; bh=BSGeA5Ea2y
	2zFXE9c9adAyi3pZiwkPxjFkPsVA1pc/Q=; b=fp4AW58g1bPctsmV+LcBZeN4oD
	nf68pOzsW6/tLVlfNTMyB8oH9QdZhdRV9DH7LTeLLNZAr66xg93fPOQ1w/Ama603
	XPqxNFvHUT7JGh4AFWgqDQPs/17wLutLdoac/fhq7tEsLEnQgLoXB2vnkpVrbmCx
	iw44oGHQTwKC9+l6dofD2eIDMF3u9IprvRTfsfu34wvtxbhUarSc+mof9Tf9Solj
	NrhWxfhtC3uVTwMfqB4bgm/lFJDYFa6yZSIz2+pO3bkLMEhSgpxG9MdtdJmCKZf6
	eN5KNoOKKReBUzrILkoG9/bQA4e64edJQjJVgnLyYSNfpfGCTz82Wsu3oSBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715054582; x=1715140982; bh=BSGeA5Ea2y2zFXE9c9adAyi3pZiw
	kPxjFkPsVA1pc/Q=; b=eWtp6Mf7B8KQW1BoutmtoKCnqfqZwb0YqHygoxGT9saV
	dRtPH8tBNoSS5ZCJk64kPC7eQP6gdX6sQXnD7R4OaapZ21dbGVNuJ9noTbqhzmFX
	9dJ0egUNYX97bEaSWISCehENJ2IQ2HYefJNq87NImJ/SNC8O8qWVyl2YAd+Z/hcE
	Me7JsFbCKPrWkk3HEvG7kNn6BLiVnSK9nEp+CXttDikIc4gQypNqIinmsJKf9K/6
	OutuWgw00jKY3wJdCtZNUGp+i4W7knn+8DS6VPzNKJjyD2NPto99SxSl90rmw1ju
	LRKsJ6dl44PGAgIlyCzbVWYOJG3/87xHjsoD0oWenQ==
X-ME-Sender: <xms:9qc5ZvVaNZ8SQUJ2ywaEhkqWi3WyXSP-RzU3QLs0Aa408zw47YRNhA>
    <xme:9qc5Znn0QVHLtjfbvdFiCRq16SUFaU1Qp_Ucf5z3fFqgOcNzStE7bdSBfDvU7DFaT
    B4C5S6OqwJJXjR3hw>
X-ME-Received: <xmr:9qc5ZrYlph8p2zbf988rjfuL0Dix0uAHjWP61vfb8sMzob-YfWOEZGk_firCViHcPDGmPR1O6INq-Ra62JUpIgFdgpnf7CdyLhFG2bF2zrEn37EL2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:9qc5ZqX-SpyGpg-CPNYPfTtTQyharQlWDB4wOu_om8hZjMb6gL-aJQ>
    <xmx:9qc5ZpluFv_czipUT3sUL73nlaeWchjl2QAmoyMD1OKb-iXiRF1mew>
    <xmx:9qc5Zncp3ec_3f3dveH05UEtqBQnhdDYr5lC_R0wC42dIyX2vw4A4A>
    <xmx:9qc5ZjEjvUrIIZDiLJLhVC3Jwbe8FJ1xGecyf7Nn0FcTKx-2x7GnXw>
    <xmx:9qc5Zr7noeNmi9ZimJu9EjHoIzFzs8esqMRLBoSL9DaHV4bKKfWO1vtr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:03:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e5eded80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:02:50 +0000 (UTC)
Date: Tue, 7 May 2024 06:02:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: rsbecker@nexbridge.com, 'Karthik Nayak' <karthik.188@gmail.com>,
	git@vger.kernel.org, 'Kristoffer Haugsbakk' <code@khaugsbakk.name>,
	'Taylor Blau' <me@ttaylorr.com>,
	=?iso-8859-1?Q?'Jean-No=EBl?= AVILA' <jn.avila@free.fr>,
	'Eric Sunshine' <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
Message-ID: <Zjmn7_C_eiSo0rBL@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com>
 <015b01da9d5b$bbe59120$33b0b360$@nexbridge.com>
 <xmqqjzkaanr1.fsf@gitster.g>
 <ZjiL7vu5kCVwpsLd@tanuki>
 <xmqqttjazwwa.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NW6qI/Jg2r6ZYtpa"
Content-Disposition: inline
In-Reply-To: <xmqqttjazwwa.fsf@gitster.g>


--NW6qI/Jg2r6ZYtpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 10:13:25AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > ... I was pondering
> > whether we want to introduce a document as part of that patch series
> > that starts to keep track of upcoming removals for a potential Git 3.0
> > release.
>=20
> Finally somebody has bit it ;-)  In the 2.44 cycle, I wrote
>=20
>     The RelNotes symbolic link says we are now working towards Git 2.44.
>     It may not be a bad idea to reflect on what technical debt and UI
>     warts we have accumulated so far to see if we have enough of them to
>     start planning for a breaking Git 3.0 release (or, of course, keep
>     incrementally improve the system, which is much more preferrable---
>     continuity and stability is good).  End of year being a relatively
>     quiet period, it may be a good time to think about your favorite pet
>     peeve, to be discussed early next year.
>=20
> in a few of the "What's cooking" reports.

I know :) I have been thinking about this on and off, but never felt
like pushing for it yet.

> > There are multiple items that could be added:
> >
> >   - Removal of the old syntax of git-config(1).
> >
> >   - Removal of the dumb HTTP transport.
> >
> >   - Removal of `info/grafts`.
> >
> > There are probably other items.
>=20
> A list of things I can think of that I won't be the primary advocate
> for but I do not mind too terribly if we had champions for the
> topics are attached at the end.

I'd be happy to champion for each of those.

> > In any case, the old actions are here to stay for the foreseeable future
> > until we commit to a breaking major release.
>=20
> True.
>=20
> > Thanks for the thorough explanation, I have nothing to add!
>=20
> You could have avoided it if you copied some from the initial cover
> letter to each round (i.e. preparing the series to be read by some
> folks who did not read an earlier round).

Fair enough. I should have known that this part is indeed quite
important to the whole series and included it in the newer cover
letters.

>=20
> Possible additional Git 3.0 items:

Some pretty controversial takes in here ;) I guess that's by design.

>  - Removing "git http-push" to push over HTTP/DAV.
>=20
>  - Removing support of `$GIT_DIR/branches/` from remote.c API.
>=20
>  - Removing "git update-server-info".

Yes, all of these are quite sensible.

>  - Removing "git annotate".

I don't care much about this one, but it's nice indeed to get rid of
duplicate functionality.

>  - Removing "gitweb" and "git instaweb".

I don't care about this one, to be honest. It's basically unmaintained
though as far as I know, so we might just be accepting the status quo.

>  - Removing "git filter-branch", now we have a better alternative
>    "git filter-repo".

This one I'm sceptical about. The one upside of git-filter-branch(1) is
that it's part of Git itself, whereas git-filter-repo(1) is not. I thus
think that a prerequisite here should be that we first land the new
script in Git before actually deprecating the old tool such that things
remain discoverable. And upstreaming git-filter-repo(1) would be a
worthy goal by itself already.

>  - Removing discovery of hook script in "$GIT_DIR/hooks/", in favor
>    of the configuration variables that point at them.

Those have been an attack vector in the past, and I think that using
config to set up hooks is quite a bit saner. But of course, we first
need to land this topic :)

>  - Switching to SHA-256 as the default hash algorithm.
>=20
>  - Switching to reftable as the default ref backend.
>=20
>  - Switching the hardcoded default branch name away from "master" to
>    "main".

All three of those may be nice. The first one is going to be hardest as
it requires support in forges. GitLab started to support SHA256 a month
ago, but it's still experimental. But to the best of my knowledge GitHub
does not yet support SHA256 at all.

>  - Declaring that "git restore" and "git switch" were failed
>    experiments and deprecating them.

I use those quite a lot, so it'd be a shame if those went away.

>  - Declaring that "git submodule" was a failed experiment and
>    deprecating it.

Well. I know that most people think that submodules don't work and
should just go away, and I count myself as part of that group. But
realistically I don't see that as a feasible goal, even more so because
we don't actually have a proper replacement. They may be somewhat
broken, but there is no better substitute.

You know, let me take this list and propose it as something like
"Documents/UpcomingDeprecations". This will make the whole discussion
here a lot more discoverable.

Patrick

--NW6qI/Jg2r6ZYtpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5p+gACgkQVbJhu7ck
PpSGUg/+PNvwqsCm8Snz9gfOorcVtYrDtrRBar8rXSF1n6QQ4voCsLZr+e7cD+3N
Sr2865Fs+QFwQMQvky56+X4Vne9aDu34ccHtxliainigaMG+ak3oGZ5r2lCWufEE
7Fi4WAjxR6ebvrCCdP8O0TRnRIeauDS3+3m/XovBcxJsUodt8QKjQXiI1XlwMycq
CMTp/y0Vx2y3Si+Eipgh5+Mm63NJ6NR8Eq6fgqvhEXIV4f9wagt6sg60SlWC9ULG
rtDiY0fiUdns+F0gknP4HWWB8lRYz5vryX3BS0t1JNvMKCZE88vmNTduYaSbMQH8
hGP6gImbBrS7Cixp1jHdNjzhss3E87s9hx650YEdVpJAreADAoejKjDqYgjd9qi9
sfaMsfg9lb/lJRQ1x3NVECZp8Q6R25PXpN5L4Z98LxNhJN0+khc2treZWKYgI7QU
JjjySzhfKqnCcQO93lHU2lZuShjz6OhMcYApP5j+NMjNkg8unFRhMPdD7C9AXWTf
fru3NW1/83aZsOeIfBmuTCkFbfVYJkUOsbHKJpDK39JPHvX94TqV+OlLQk8g+X2x
a6ay2p/qxLDfEQx5aTj6vsY+Bb/+4ih0YR4448lTLu2RDee1xQLaRDMmQ9L9Uadr
UIzTUUz2vq2XavJ1cB4x0p62ic2063yt7ECP1L7djCTH75UpAEQ=
=sfrI
-----END PGP SIGNATURE-----

--NW6qI/Jg2r6ZYtpa--
