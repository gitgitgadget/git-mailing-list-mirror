Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1352421D
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052607; cv=none; b=EzM0ZE52aA9+XiOE503e3BBVYgB7hfXfngt67xkG2pfHFYtQ5y+yI+J4d6fMvvQRD3JVA+dkq6iVuCaSm6ShvOMsjlxbC6lVrL4jKtL56qlBiM5w0FR0f9iSJ/Kw/L7iz1SOSqm58SfVp2FbIZbnMqIr/FSm1jRoIH6s5tYbo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052607; c=relaxed/simple;
	bh=PoQxl8JDXHEYyqm33+n3eswluxxM/U/uMgF+SSpLWps=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My09VKAtXa2id6IpJEFLd5y33xTOYSDfakkvMewN0WkcmpaOrLubnsnnbPBlHwNnb+OLGQ8Jc833wglDPTbow6yfBIHPKf7I5Tiq+X8xM1lH84rrozMNk+1NKIDYISh+MMtNFyP8S9kdFjyCtlFOZlgavJzBC5PYroJlVsQqLgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XyB+Vr7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfiLe/Vj; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XyB+Vr7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfiLe/Vj"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 557583200AA5
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 11:50:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 27 Feb 2024 11:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709052603; x=1709139003; bh=1cRRb3n0/f
	BHJoJL8MbbwzKPuo/tH87rFd+Il8mvZlo=; b=XyB+Vr7kYZmra2Sg09xZQ6YHDK
	aW8GyTL0tx3yOvPgLBjYKcXSn9Yqunc4xQR/X8MbAcX9xmWB8xfJAmvl/PvSfadh
	2zQt326n21tDFOESVOMF/z4w0D7Oy6H8rur1mLlxwnJm/9KQGJI8lVO7XoxuM0O7
	oHj1/Zf4PNKvhLagPKG4B+GO5QLEbbcq8HiGt4tkXbUNFHEa+Hh75XNU21qzHuvI
	gSwKDR3yB5BdqVIy6avgFXW2YTmXmD6e4KCiA4sL3on1UJhepgv00gODu6DZRJiV
	C1EsekzTBTMxjRCnU8xTY2qzXBvWRbFJbHJil0bS89RwCCjI+ar4dvdghbjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709052603; x=1709139003; bh=1cRRb3n0/fBHJoJL8MbbwzKPuo/t
	H87rFd+Il8mvZlo=; b=hfiLe/Vj5va1+mmywWCqXulVL5uzSTNX2ZOtUj4a9STW
	68OdOAz+jqmu9m0cIbqnsKFpOVt1s2nZDO+J2Lc1x5MC5wEfPtlEkpgJwCNkZwOQ
	LsK0S0iEI1CBUqu5aQ6g9z5YTM6QeEkgFi4uw+zwg64VQnzZvacjvxr5m5HnPdE1
	uqmkHgWpw+6SJ90E9vNBpwQiAJ922xYpqWZ6N7EbLZ8TBdPYZFN37xm/qeAU4AYN
	Qn7tOc8DhZjSQbsYlZWfzSFgvrBqWbGSbQZUQywMOJ2Kt/ww9/HuMERmsgcCFyxe
	plvAvIuMt74pn8CSM4IJoWx/7XliJS6AGNhnkCnscQ==
X-ME-Sender: <xms:uxLeZWjl8GlpneSzBJe0VjHzRc182dVGoAfViCqHiSapegv9uM29Kw>
    <xme:uxLeZXA5g30lOHBptVrHUxFOYbpntN-lyZ7GMxKrdVYB0PnHM9m65WwjZhNtMgaI4
    gwMwhtMj8neEj0MuA>
X-ME-Received: <xmr:uxLeZeFsGmEQUe1puV8tA64lOpaTAUxT-O-rF6Kf398Amxe1FmVJ5Q-j1-dULCrnH3oNW3C7ua66LyQ4tJsNafDM_jwaZOfqqunngmeIbZy6equF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:uxLeZfTtYdgSCcy9GHNgNI1lr0F_EJqj_uqIVCAJP1AWSQmxzAcn9g>
    <xmx:uxLeZTxNr06ePBYRzHl4kiqy4uMTvc02FYnAZOeIY5mGBbpOezGLFA>
    <xmx:uxLeZd5mPrxpw2tesVSW3Qw4z8xHO5FYrVx9O19wyIm8HOf6RXfaKw>
    <xmx:uxLeZRbl2ZEtvye2btwh25KJqSNk_FTMPGwsVAmI52YXPbQpW-ZCLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 27 Feb 2024 11:50:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 06a57ab0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 27 Feb 2024 16:45:45 +0000 (UTC)
Date: Tue, 27 Feb 2024 17:50:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: Re: [PATCH 03/12] reftable/merged: advance subiter on subsequent
 iteration
Message-ID: <Zd4SuYKesIE07nlp@ncase>
References: <cover.1707895758.git.ps@pks.im>
 <38d45995662ba92f4b985b82deac298446274511.1707895758.git.ps@pks.im>
 <ns2yw3icnl3udejbgsv4ojwgzbe7eg57bvsm53kciuemlvmgbr@mpjtogpzdavi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+h0Y4wxnXQIfLrGH"
Content-Disposition: inline
In-Reply-To: <ns2yw3icnl3udejbgsv4ojwgzbe7eg57bvsm53kciuemlvmgbr@mpjtogpzdavi>
X-TUID: Ybsq3YHYFK9C


--+h0Y4wxnXQIfLrGH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:25:10PM -0600, Justin Tobler wrote:
> On 24/02/14 08:45AM, Patrick Steinhardt wrote:
> > When advancing the merged iterator, we pop the top-most entry from its
>=20
> s/top-most/topmost
>=20
> > priority queue and then advance the sub-iterator that the entry belongs
> > to, adding the result as a new entry. This is quite sensible in the case
> > where the merged iterator is used to actual iterate through records. But
>=20
> s/actual/actually
>=20
> > the merged iterator is also used when we look up a single record, only,
> > so advancing the sub-iterator is wasted effort because we would never
> > even look at the result.
> >=20
> > Instead of immediately advancing the sub-iterator, we can also defer
> > this to the next iteration of the merged iterator by storing the
> > intent-to-advance. This results in a small speedup when reading many
> > records. The following benchmark creates 10000 refs, which will also end
> > up with many ref lookups:
> >=20
> >     Benchmark 1: update-ref: create many refs (revision =3D HEAD~)
> >       Time (mean =C2=B1 =CF=83):     337.2 ms =C2=B1   7.3 ms    [User:=
 200.1 ms, System: 136.9 ms]
> >       Range (min =E2=80=A6 max):   329.3 ms =E2=80=A6 373.2 ms    100 r=
uns
> >=20
> >     Benchmark 2: update-ref: create many refs (revision =3D HEAD)
> >       Time (mean =C2=B1 =CF=83):     332.5 ms =C2=B1   5.9 ms    [User:=
 197.2 ms, System: 135.1 ms]
> >       Range (min =E2=80=A6 max):   327.6 ms =E2=80=A6 359.8 ms    100 r=
uns
> >=20
> >     Summary
> >       update-ref: create many refs (revision =3D HEAD) ran
> >         1.01 =C2=B1 0.03 times faster than update-ref: create many refs=
 (revision =3D HEAD~)
> >=20
> > While this speedup alone isn't really worth it, this refactoring will
> > also allow two additional optimizations in subsequent patches. First, it
> > will allow us to special-case when there is only a single sub-iter left
> > to circumvent the priority queue altogether. And second, it makes it
> > easier to avoid copying records to the caller.
> >=20
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  reftable/merged.c | 26 ++++++++++++--------------
> >  1 file changed, 12 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/reftable/merged.c b/reftable/merged.c
> > index 12ebd732e8..9b1ccfff00 100644
> > --- a/reftable/merged.c
> > +++ b/reftable/merged.c
> > @@ -19,11 +19,12 @@ license that can be found in the LICENSE file or at
> > =20
> >  struct merged_iter {
> >  	struct reftable_iterator *stack;
> > +	struct merged_iter_pqueue pq;
> >  	uint32_t hash_id;
> >  	size_t stack_len;
> >  	uint8_t typ;
> >  	int suppress_deletions;
> > -	struct merged_iter_pqueue pq;
> > +	ssize_t advance_index;
> >  };
> > =20
> >  static int merged_iter_init(struct merged_iter *mi)
> > @@ -96,13 +97,17 @@ static int merged_iter_next_entry(struct merged_ite=
r *mi,
> >  	struct pq_entry entry =3D { 0 };
> >  	int err =3D 0;
> > =20
> > +	if (mi->advance_index >=3D 0) {
> > +		err =3D merged_iter_advance_subiter(mi, mi->advance_index);
> > +		if (err < 0)
> > +			return err;
> > +		mi->advance_index =3D -1;
> > +	}
> > +
>=20
> Without additional context, it isn't immediately clear to me why the
> sub-iterator is condionally advanced at the beginning. Maybe a comment
> could be added to explain as done in the commit message to help with
> clarity?

I tried to mention this in the commit message with the last paragraph.
Adding a comment doesn't make much sense at this point in the patch
seires because a later patch changes how this works.

> >  	if (merged_iter_pqueue_is_empty(mi->pq))
> >  		return 1;
> > =20
> >  	entry =3D merged_iter_pqueue_remove(&mi->pq);
> > -	err =3D merged_iter_advance_subiter(mi, entry.index);
> > -	if (err < 0)
> > -		return err;
> > =20
> >  	/*
> >  	  One can also use reftable as datacenter-local storage, where the ref
> > @@ -116,14 +121,6 @@ static int merged_iter_next_entry(struct merged_it=
er *mi,
> >  		struct pq_entry top =3D merged_iter_pqueue_top(mi->pq);
> >  		int cmp;
> > =20
> > -		/*
> > -		 * When the next entry comes from the same queue as the current
> > -		 * entry then it must by definition be larger. This avoids a
> > -		 * comparison in the most common case.
> > -		 */
> > -		if (top.index =3D=3D entry.index)
> > -			break;
> > -
>=20
> I'm not quite sure I follow by the above check is removed as part of
> this change. Would you mind clarifying?

The loop that this comparison has been part of was popping all entries
=66rom the priority queue that are being shadowed by the sub-iterator from
which we're about to return the entry. So e.g. in the case of a ref
record, we discard all records with the same refname which are shadowed
by a newer (higher update-index) table.

The removed condition was an optimization was a micro-optimization: when
the next entry in the pqueue is from the same index as the entry we are
about to return, then we know that it cannot have been shadowed. This
allowed us to avoid a key comparison.

But with the change in this commit we don't even add the next record of
the current sub-iter to the pqueue, and thus the condition cannot happen
anymore.

Patrick

--+h0Y4wxnXQIfLrGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXeErgACgkQVbJhu7ck
PpRZMw/+Nd8vQ6zR7R3INtl3HcVF8EkFbV1t0XtnRSlWe2O1s/SIkFwEHS/5MEg7
JthtU8qejI8vVazRrzNppP6+2nVRqrBR7NJ2+CqFjBnoUYb43TNz+cUD0tTmbY+O
Vo2hORH6m1XT6Te4UeD0QtFlMjajEnJMF8WD34emuIuGMv0lYENfjFJgqCi3Hm5V
PY49X6Mcwv60XcylAv3iUT0tPpXA04uhKiEDePn9/FcC+clxZo8nDtMCoa9a7mxX
er5oYdcQMfuhpgr4XikfO2MqCPs44K8T5ILjL5fxi5IEFVLM7C/3rtppl5I2fMe6
9mQ1hHSzVCgaztMcX71b9yggukn8ieBwVHXdXJwoOw63qcdfNxP/r5BVf5bK0DeO
rCQ4lQENK0fwJCSbtN8aNfbyQ8cOIuPGreDjqeQ8SNXHvwwW0otwqhxFroPpT1FM
0mbNG2mhHCuV2A+YS13BGBis0yB02QeM+oIgnZ8RjKPCeYBOavz8DZkWjK73rjYz
dZidrZ1BvN6WlJbAzkbGkYsP80ADIsYivTmjqDNvSlqh4R20LqN6k6cgsnafvFqM
EJPioArcss8xwCVqBDARDrgwCYw3O3CwnXg2tJ0zsvcMcAqBgzb1FFkqH8Sft9pN
+zKkY68KupY7wWb4UhJI3IrCCk1m9mRpjkTuXalHafxSDUzu8jw=
=bfP0
-----END PGP SIGNATURE-----

--+h0Y4wxnXQIfLrGH--
