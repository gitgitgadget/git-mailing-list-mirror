Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8D1C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiBQL6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:58:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiBQL6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:58:43 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE9293B50
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:58:28 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6BA3532006F5;
        Thu, 17 Feb 2022 06:58:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 06:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=hjg7BVrx2Xr434bMbZ70fFlXMin5ONyIPK7EZe
        rfV/A=; b=XDIaFGUGESwrui+GTvMcFqTC6+jgRQPGS780ECao5S1B9u98X7s7Mh
        FyP0McxO1f67Dwk24mStOonbq2YcC8GZlu+lUVRTBCYtzWqyqSJLZn8TnUuZ2xNZ
        Gn6krM44bGayVK3gD0aacKZexs2F8ptmZZ39608v53T++nHIjgGPtGNQnOX6WUgZ
        gc20MvTLqqCpyx4QXRvDBMgEzmS0Ucb60u0bW1CIVZewY+p823/779jywnwPqmhG
        +AgvZOcUPhp8HpNZY7sPXSz0ht+AtF8OIr+ploSYzbqpnxi3G+kVa6n0uPiDoYqY
        +6xsV9kuNRbZnKk9uMyQw4xGvTTTQy5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=hjg7BVrx2Xr434bMb
        Z70fFlXMin5ONyIPK7EZerfV/A=; b=gewBzvs0nYeP5+WLEXEaI1hIDTaNevXA5
        g3c2nUSPkHhsGf+Doj6COcYCKfl8yN1v4UJP+6pRBPIQWQZZByd83UMpnxP0MFgB
        AgNw7F0tYCGxESw3rz9wokBjjbC24X1DHXKbGiAgrz+umCJRVUIQzI9LVrVlpbqx
        vlN8iuDuefNsBg0hr+FedUfZBCsRgS/O0PrHvGttI7EhPFKqhdIsVxr9XjG8hVOE
        dFY95vXYOJV7LhNLHDS7Gv6EgSGW647woZnHaCuSUeb5El/sExK/pbXZmo5e5jxJ
        B2M9AAjb7n7GmPwlcQZ+vi5BYHSpLXFuE0/xfOnbGUd/bTq5n3yew==
X-ME-Sender: <xms:YzgOYu38uFzex3zLoyZruFFYhMYy07jZ2Po5hYCQMth_MkiEaQE8PQ>
    <xme:YzgOYhG7cqbzhVSXJPLp0bewv46TImVBrv1_iVe3R2KXE7aTRSckKTsguioaRjMiQ
    Bk_FNgAKriGIKiSIA>
X-ME-Received: <xmr:YzgOYm5E9xvirHIKZSC45RQ0jpz0xZ43pNWTrgu13ZZIq3SDi_7IMGLdVNfbWGAhsf5SCkLAURlBh6BuhLm4Q2p3z8NkM6ZUuMJuMPR5w-g-PrA6gKqaQEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:YzgOYv1iDs7bxXpsNY05eX2Uc5KP7k7_YOkD--bnFBs7qKTC-gSXUQ>
    <xmx:YzgOYhE4j4z9xGi2N0wJLvjFi_mx87uuHhexoBY-sn1Tfk-ywLw2Nw>
    <xmx:YzgOYo_B7HNIe2PcDjlYHluVdNh54K9Jov-QBpi_8Y_HrmEISYZxyg>
    <xmx:YzgOYkNBk4wNU-UCp8QUhspreR83vnU1JzI2OtIxiQunucvEGK_tfw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 06:58:27 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2e93599e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 11:58:25 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:58:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
Message-ID: <Yg44YMVniOT6RVrv@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
 <CABPp-BFM67LzZFL=w-iA7vButaBKokpetDR5dr8TTnbSCmBdeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAH9hGmuPBlFq3+Q"
Content-Disposition: inline
In-Reply-To: <CABPp-BFM67LzZFL=w-iA7vButaBKokpetDR5dr8TTnbSCmBdeA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iAH9hGmuPBlFq3+Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 16, 2022 at 05:34:23PM -0800, Elijah Newren wrote:
> On Mon, Feb 14, 2022 at 1:32 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When fetching references from a remote we by default also fetch all tags
> > which point into the history we have fetched. This is a separate step
> > performed after updating local references because it requires us to walk
> > over the history on the client-side to determine whether the remote has
> > announced any tags which point to one of the fetched commits.
> >
> > This backfilling of tags isn't covered by the `--atomic` flag: right
> > now, it only applies to the step where we update our local references.
> > This is an oversight at the time the flag was introduced: its purpose is
> > to either update all references or none, but right now we happily update
> > local references even in the case where backfilling failed.
> >
> > Fix this by pulling up creation of the reference transaction such that
> > we can pass the same transaction to both the code which updates local
> > references and to the code which backfills tags. This allows us to only
> > commit the transaction in case both actions succeed.
> >
> > Note that we also have to start passing the transaction into
> > `find_non_local_tags()`: this function is responsible for finding all
> > tags which we need to backfill. Right now, it will happily return tags
> > which we have already been updated with our local references. But when
> > we use a single transaction for both local references and backfilling
> > then it may happen that we try to queue the same reference update twice
> > to the transaction, which consequentially triggers a bug. We thus have
> > to skip over any tags which have already been queued. Unfortunately,
> > this requires us to reach into internals of the reference transaction to
> > access queued updates, but there is no non-internal interface right now
> > which would allow us to access this information.
>=20
> I like the changes you are making here in general, but I do agree that
> reaching into refs-internal feels a bit icky.  I'm not familiar with
> the refs API nor the fetching code, so feel free to ignore these
> ideas, but I'm just throwing them out there as possibilities to avoid
> reaching into refs-internal:
>=20
>   - you are trying to check for existing transactions to avoid
> duplicates, but those existing transactions came from elsewhere in the
> same code we control.  Could we store a strset or strmap of the items
> being updated (in addition to storing them in the transaction), and
> then use the strset/strmap to filter out which tags we need to
> backfill?  Or would that require plumbing an extra variable through an
> awful lot of callers to get the information into the right places?

We basically would need to plumb through the variable to most callsites
which also get the transaction as input, and that's rather deep into the
callstack. The reason I think it's preferable to instead use the
transaction is that it holds the definitive state of all updates we have
already queued, and thus we cannot accidentally forget to update another
auxiliary variable.

>   - would it make sense to add a flag to the transaction API to allow
> duplicates if both updates update the ref to the same value?  (I'm
> guessing you're updating to the same value, right?)

It should be the same value, yes. There is a race though in the context
of tag backfilling: if the initial fetch pulls in some tags, then it can
happen that second fetch used in some cases for the backfilling
mechanism pulls in the same tag references but with different target
objects. It's an unlikely thing to happen, but cannot be ruled out a
100%. As Jonathan pointed out the backfilling-fetch is only used when
the transport does not use "include-tag" though.

The result in that case would be that the transaction aborts because of
duplicate addition of the same ref with different values. And I'd say
that this is correct behaviour in case the user asked for an atomic
fetch.

>   - should we just add something to the refs API along the lines of
> "transaction_includes_update_for()" or something like that?

I think something in the spirit of this last option would be the easiest
solution. Using `includes_updates_for()` or the above solution of a flag
which avoids duplicate updates would potentially be quadratic in
behaviour though if implemented naively: we need to walk all queued
updates for each of the tags we want to queue. That's easy enough to
avoid if we just add a `for_each_queued_reference_update()` and then
continue to do the same thing like we below. It also gives us greater
flexibility compared to the other alternatives.

> [...]
> > @@ -361,12 +362,28 @@ static void find_non_local_tags(const struct ref =
*refs,
> >         const struct ref *ref;
> >         struct refname_hash_entry *item =3D NULL;
> >         const int quick_flags =3D OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_=
FETCH_OBJECT;
> > +       int i;
> >
> >         refname_hash_init(&existing_refs);
> >         refname_hash_init(&remote_refs);
> >         create_fetch_oidset(head, &fetch_oids);
> >
> >         for_each_ref(add_one_refname, &existing_refs);
> > +
> > +       /*
> > +        * If we already have a transaction, then we need to filter out=
 all
> > +        * tags which have already been queued up.
> > +        */
> > +       for (i =3D 0; transaction && i < transaction->nr; i++) {
> > +               if (!starts_with(transaction->updates[i]->refname, "ref=
s/tags/") ||
> > +                   !(transaction->updates[i]->flags & REF_HAVE_NEW))
> > +                       continue;
> > +               (void) refname_hash_add(&existing_refs,
> > +                                       transaction->updates[i]->refnam=
e,
> > +                                       &transaction->updates[i]->new_o=
id);
>=20
> Why the typecast here?

`refname_hash_add()` returns the newly added entry, and we don't care
about that. `add_one_refname()` has the same cast, potentially to
demonstrate that we don't need the return value? Compilers shouldn't
care I think, but on the other hand some static analysis sites like
Coverity use to complain about such things.

Patrick

--iAH9hGmuPBlFq3+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOOF8ACgkQVbJhu7ck
PpRRfg/9Hzd2PtiqtighRkxJxlDLAO2eZkfCjJMEhTBIiEGns91xP273IhcRVPgw
43kUynllmN4nXBRbUpEQsOS/mw2NmZnPeGce3geM6HMae7zpZn5MYPbqO9OLccKJ
Jj/I9iSKy4IuTABaeMyqtreTaGoZS1lfamc8mOvzCuMZUTubYOTt7y0WyXySYG8H
6FAkSNvb+xGDvoXPRLpoAswQ3QA2BjSvJHlGnQ7GwkQur9Hd21kQkqy81cIn9upt
2+us/AckrIqNeWExLSmEJyH6/QbN2tuwQSbBWXDpiNftgj3KjCzCadiCdLrVjG9i
/3q4f5G/ywiHHJmr9oTcrXnoGwo9FYws3KkSw8WqmsYZjHSh/h5q6iBt0dB6ukWx
vsRYqIe7YuSmKwManZA9AuzG1yBkmymsp4iL9iRxQGRJJBkvjRE4O9x4goawU9sf
HVmhzLQVTeudS2lllJXgdBMiWhgs+Y7Hw3ULVTnJivTz5Rnf2aN7J7EFSlaQWDij
6PfR6YbehXS7iOaykmkR4c5RXgxrQ3byE+tAsvcATbh2/km9u/BZQa8FFvQBC2mz
4B9g2j5SubjgVzOjs5E6bcXNbXfI6M49E3Z42gC3Fnhy3CSJMhBD3BSGDMgoMdwR
1UjB0DmSdOPVle90wqwSmzDKPiWeQJ9MnuC1gEnTpxjgq/0AdOI=
=DYKw
-----END PGP SIGNATURE-----

--iAH9hGmuPBlFq3+Q--
