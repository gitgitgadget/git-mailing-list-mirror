Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7314D702
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730638; cv=none; b=IC9MrbV6NZYywMEcV+xRlGvrW+zGkMbAVeIlEPsoWcFmbtgAWcn2snF7LUtky/wA8gWEpuFoxyJEa0Q4DbkzpfahaYECeR8UNFK4wtbVQY6pSa49iNsf54xCN+KkGXVkwisHOLZ1pDCkRUbC36yaHOyDWgCSsjEmbR26l3VtU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730638; c=relaxed/simple;
	bh=cwPTCprP0JpFDZZX+KhNl07auITXVkvjHKw8yle24Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrB/OYZKc18H4D9dxtHPAky9GUqDASpmSpBRJUosq/wcReWFZ5w3T8Qy1MiENsRwFa/KhrQRRISrOI959222DncIgzPmhy9Fbdd5SyCWDtGMSrzRRzp4+7Eo5venR+xg2KW/eh4DeMKtGJ9HHsK2SEqVvzmUAgcI0xKawvMNIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mGWEL7GT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BPMTwv9G; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mGWEL7GT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BPMTwv9G"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id E50EB1380726;
	Tue, 23 Jul 2024 06:30:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 06:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721730634; x=1721817034; bh=a95DraBY/+
	3NFOHFwG///yenFYmzwLlSvCvdVV4scDo=; b=mGWEL7GTuS77IAloRdZJfb+EGn
	ejzudCyMGM8/x2xzSs8ODZSCekrrlbqjT+h25/gsNTV2fpIz4yuTU/u75N+bX304
	REudDjJ3s1GXZFeOXr8QLruLNiDwj137LIIoBkuEUvcEqfZvNs4rS/9Jnc574KrG
	F2PW6kcJFKxtcmHjHjP4yGBDCEjBpiTnp1SD5v15hqJsb5AxxeW4vOx+NnfG9C3r
	+9kN0dCq1GeFyqP1hjLtvkJdA7AsHR5bhtVbVWzfMVXICSv8CpZCTd1bpWiumAD8
	Y0JCVQxPS2+LOTMxEc9nDFg1TEcwfyog8Nq9wMT2XGelxSH4YYab7gH/jsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721730634; x=1721817034; bh=a95DraBY/+3NFOHFwG///yenFYmz
	wLlSvCvdVV4scDo=; b=BPMTwv9G1nfhOuXRJWCEp1de64uYIm3ktRW5FBVz/Bsl
	EQ7bM3LJnrXnK91wMSMl+b4ZSpPqpImIIhkg5IJLXoiku3//sqD9rCAoaAn0vk26
	D/Kq/BbW8cuCIIcJPEC0CGn+c4YZIjoeJhKzuBSp9dlP6V+lXoiHEZxYXplNbZgb
	9zlKx6IuQuVGfPtXv6nYRFBqitOwvBxN+H/U20xrfCMgw/i4P/Ged5WPRC/bD4M6
	JePjUvf0oUIV0996pi8sQ7whzQNnRn2EZQtNvw6IMXfr+kFhqMOVachWr1VesmwT
	sUPnwgO7enl+f8gFTU41A9GacOUHZOTNi+5I8WBm9Q==
X-ME-Sender: <xms:SoafZqVeyGa56mwE7xHTiUCopkqqabX5KQPK-q1zQwuftM2YpP7nsg>
    <xme:SoafZmmmamZAgmcVGhpZZjet0vi2Ybs4-bOfVI-azcSBFMHcwp0nsBJ9ed_S7b13Q
    bzLRgiz_4A8lUszyA>
X-ME-Received: <xmr:SoafZuaIF9soqxfCWZgnyziv9Xg4EDWmpKMcP8pc9XIT85O_CjEZtLCdFkaHZbm2Ec-xWR7FENClaVvRkaXn4gS8aGAfRjxohAY8VlWZOvSdnwpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:SoafZhVa71puyaEpoW7kLUh9Yg-L8lCjVRSRs0AiTZTJNVjbyCrpEQ>
    <xmx:SoafZkn9d0CO_8roaucCKxAaU_O670VhZUKl4AnRHmbcNP3aA0Mh4g>
    <xmx:SoafZmcK2Y6NJtWCncY0GVwYkdsI6nSC8MOAonpXVCb794VJ6Gv29g>
    <xmx:SoafZmGJUy0MtEN-sYE7k0nZcWzer77i7_bnQeqYRhg-04cRtAheWg>
    <xmx:SoafZju_MCfWe6IqMHXs_pBV1LvPBEj_R9XqycMcsAXQaM-dy_ZZTyX_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 06:30:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 88c64e62 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 10:29:16 +0000 (UTC)
Date: Tue, 23 Jul 2024 12:30:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <adam@dinwoodie.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: v2.46.0-rc0 test failures on cygwin
Message-ID: <Zp-GQ0MQmuIyAear@tanuki>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
 <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
 <20240718005723.GA675057@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ivmKq8Pn0+qf+gEy"
Content-Disposition: inline
In-Reply-To: <20240718005723.GA675057@coredump.intra.peff.net>


--ivmKq8Pn0+qf+gEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 08:57:23PM -0400, Jeff King wrote:
> On Wed, Jul 17, 2024 at 07:05:43PM +0100, Ramsay Jones wrote:
> > The patch given below fixes the test for me! (I have only run t1460-ref=
s-migrate.sh,
> > since the full test-suite takes 6 hours to run, but now all 30 tests pa=
ss!)
> >=20
> > I also don't know the code well enough to answer your question regarding
> > the re-opening of the migrated ref-store, but it doesn't look like it w=
ould
> > cause any problems (famous last words).
>=20
> Thanks for testing. This is new in the upcoming release, but I think
> it's localized to the "git ref migrate" command. So aside from the
> annoyance of the test failure for you, it is not too urgent. I'm tempted
> to put it off until Patrick has had a chance to weigh in, even if it
> means missing the v2.46 cutoff.

Thanks all for digging into this while I was out!

> I'd also be OK with pursuing it in the meantime if folks feel
> differently. Having slept on it, I think the answer to one of my
> questions here...
>=20
> > > -	free(new_refs->gitdir);
> > > -	new_refs->gitdir =3D xstrdup(old_refs->gitdir);
> > > +	/*
> > > +	 * Re-open the now-migrated ref store. I'm not sure if this is stri=
ctly
> > > +	 * needed or not. Perhaps it would also be a good time to check that
> > > +	 * we correctly opened it, it's in the expected format, etc?
> > > +	 */
> > > +	new_refs =3D ref_store_init(repo, format, old_refs->gitdir,
> > > +				  REF_STORE_ALL_CAPS);
> > >  	repo->refs_private =3D new_refs;
> > >  	ref_store_release(old_refs);
>=20
> ...is that we must put _something_ useful into repo->refs_private,
> because old_refs is an alias for it that we are freeing. I suspect that
> "git ref migrate" does not really look at the repo any more after this
> migration function returns, but it makes sense for it to leave things in
> a consistent state.

Yeah, `repo->refs_private` shouldn't ever be accessed after the
migration has finished. Still, as you say, it feels like the correct
thing to do to keep the `repo` in a consistent state, even though it's
not necessary in our codebase right now.

> So my biggest question is just whether there is any downside to doing
> the release/init pair rather than trying to reuse the existing struct.

There shouldn't be any downside, but it is wasted effort. The main ref
store should always be accessed via `get_main_ref_store()`, and that
function knows to lazily initialize the refdb as required. So instead, I
think the preferable fix is to release the new ref store after we have
populated it and set the main ref store of the repository to `NULL`
instead of re-initializing it.

So the following should be sufficient:

    diff --git a/refs.c b/refs.c
    index bb90a18875..915aeb4d1d 100644
    --- a/refs.c
    +++ b/refs.c
    @@ -2843,6 +2843,14 @@ int repo_migrate_ref_storage_format(struct repos=
itory *repo,
            goto done;
        }
    =20
    +	/*
    +	 * Release the new ref store such that any potentially-open files will
    +	 * be closed. This is required for platforms like Cygwin, where
    +	 * renaming an open file results in EPERM.
    +	 */
    +	ref_store_release(new_refs);
    +	FREE_AND_NULL(new_refs);
    +
        /*
         * Until now we were in the non-destructive phase, where we only
         * populated the new ref store. From hereon though we are about
    @@ -2874,10 +2882,14 @@ int repo_migrate_ref_storage_format(struct repo=
sitory *repo,
         */
        initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), fo=
rmat, 1);
    =20
    -	free(new_refs->gitdir);
    -	new_refs->gitdir =3D xstrdup(old_refs->gitdir);
    -	repo->refs_private =3D new_refs;
    +	/*
    +	 * Unset the old ref store and release it. `get_main_ref_store()` will
    +	 * make sure to lazily re-initialize the repository's ref store with
    +	 * the new format.
    +	 */
        ref_store_release(old_refs);
    +	FREE_AND_NULL(old_refs);
    +	repo->refs_private =3D NULL;
    =20
        ret =3D 0;
    =20
    @@ -2888,8 +2900,10 @@ int repo_migrate_ref_storage_format(struct repos=
itory *repo,
                    new_gitdir.buf);
        }
    =20
    -	if (ret && new_refs)
    +	if (new_refs) {
            ref_store_release(new_refs);
    +		free(new_refs);
    +	}
        ref_transaction_free(transaction);
        strbuf_release(&new_gitdir);
        return ret;

> I do think it probably causes a small memory leak. The "init" function
> allocates the actual ref_store struct, but the "release" function
> doesn't seem to free it. So we are probably leaking the store that
> points to the temp directory. But that is also true of "old_refs", or of
> "new_refs" if we hit an error. So I think the solution is probably for
> init/release to be symmetric, and for the latter to clean up everything.
> But again, I'd prefer to get input from Patrick there.

Yeah, we'd have to free the new ref store struct, as well. I wouldn't
make `release()` free the structure as that would be uncustomarily
named.

Patrick

--ivmKq8Pn0+qf+gEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafhkIACgkQVbJhu7ck
PpSNcA//eatAP8lLEQV2G9TAYFNS9nUmEvcYrQRqvJR8Q1oR7vRpoGKawW1VjVs7
OeCPa7Ye3P8bxSSvVIU/oMEWJ857hKcaB+FkPXvqdEGwFBHiErWTifx1WG11hYc8
MfU8dCgDs+r5uXmSc40/pOujqOTMV1ARGy0z2NJTaRAZ8O9UJYSJR1G26BBb5fLY
7ihEUw4kCcy2RqcFQ/H3E6+LIxuHZnAayPdKcLV+eV9uV5j69SE0NM5wPsPQY+gG
omY3rwTI9WyLezAXT7N9CONtvVr+hx4eIMhHhjHQxHW8I/D0ybZcDSyMGv7UaPDX
9tPmYtiYNsLlhsLu4DaSKfcP8afYrvcUzmzP0A0fjnzEHfrtvUlpKGBRqGknuA8E
eSBwlMSq5AaS1R4PtYzaaLsnwavZO44j5kJ+jY1XrYO8sKZO4M+BweS/XvNC/ate
Hdb8+nPP75h7u91WCKCxQYx8YahiAri825JEFWGvn1jx4cSQVlGyr1rVQemToMLA
f43ePpGQ7hYtu+HGW3mhVZS52Di6dfgd98pIPycrgBJ9TzI2malazpqVWqcVLHrF
t1QIfEgNjsw5SetWsH6GWjFsNJO7JZgR6xQwbLPg8TO9kY/LXREDpxKDdtv1q+hM
9oowpztzh7L5S1I/TCxk4HBCz8paJ4Krtf7UW9MY3P00HVPxVzU=
=IHyj
-----END PGP SIGNATURE-----

--ivmKq8Pn0+qf+gEy--
