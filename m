Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DB0C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 13:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiEINw5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 09:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbiEINwz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 09:52:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDF92B248
        for <git@vger.kernel.org>; Mon,  9 May 2022 06:48:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2B4825C0139;
        Mon,  9 May 2022 09:48:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 09 May 2022 09:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652104139; x=1652190539; bh=3S7MlgQFuG
        M1IJL1cPIoR9dt1H8IuFvyrq/wLJKUCII=; b=ETlok/RfvrnHdWgw/OkTsbJe8i
        /W8cG6X1LrYDHUXdCCBYsexEF0gLBw9XcXvZ1/Sp3fuZXpp2I5p9EGeKx5DRO+Vd
        OPASBPducUVtFbYUroN+Zxed7RzceklmT6AVWx7e035lqM05LwSfklsXiUYGixQk
        8soLA9oexf4LNpwNQsvfZB38XKnXarr11OocHPkfen71MlfZ1wGNHUiPwSVRUvHz
        KHLj2hjlqRzy2HbdJ+QnINvTtDldcwqElKKY4SbK1bVQX9odD5fKsMpUsbLU627g
        rDnoCjMDkElB6Dm1zPDTzWveEPiygmsL9lQdpq1YOl8CixW0Tbv45P0hgMpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652104139; x=
        1652190539; bh=3S7MlgQFuGM1IJL1cPIoR9dt1H8IuFvyrq/wLJKUCII=; b=I
        /pdP7DWLVTDa0WCCmYDFiY/wgwmc5oOgvR0lcOAa1LFGlAmPoec6zEGmulD1VcWf
        dqn8MvczWDy7hejL4rCSxra3gUSut3rIODpcHa8Mjr+kODTd1c/DZncYig1t1mxC
        0+FDkZbpJYVOgfYmOA7x+OQ98sbwSh9IbsiF0M5VNYumNpIKu3rUyleI6obnpIod
        FzQwBol+FaaAB2eJxQG/kaaietu4mI98dEtOj9FHaNe2RsnS1T6tBVjxk+lJfC9p
        r3yAlwIXnNHta1uzi3/gL0em5UCYXK8AtoRsIgMpovLss3Ljj5ba/SjxrRaHoBkg
        8AKoeB9/d48DoWn5hh9wg==
X-ME-Sender: <xms:yht5Yn8oQf2W8J5owW1MICCLkOjoqAUo43QAUSonngADv50flOnNNg>
    <xme:yht5Yjt0Kh66KIYkVJ8p97Srro8JqVvmjsp8nWNwPwKAFBvlctQaErdREQkqBT1_Y
    D1jEPX_CrEXSLUb9g>
X-ME-Received: <xmr:yht5YlDXREQaeZF6HmRdmj3-bNiamLToOmdyxotMskXXGWJI5kWlq2PXm_Q0s97Jsiw1iD8t9V6T-B0-m6sXfYrKgZDKJ1U7roFhRosYdfImv-wqUR-Nng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:yht5Yjf5ZA0WyXtVGkMS7uPX7bJ09k1EK8vxkHXoD2qbW_j1QKrKJw>
    <xmx:yht5YsNK3RheOy3eaV9mZjua4-zAWrvO46mZUd0gPgU-vwX4dwWIEw>
    <xmx:yht5YlmjDu7C36m0q_dMhhxBaw5CJ7F2eMurcDJuBBDsV-GInTfRdQ>
    <xmx:yxt5YlbN703ZTacXCn3t9Q9x7KcH_l9GG5GYZp0DQvgdrgkZuakkqQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 09:48:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a182cc3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 May 2022 13:48:53 +0000 (UTC)
Date:   Mon, 9 May 2022 15:48:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Michael Heemskerk <mheemskerk@atlassian.com>
Cc:     Michael Heemskerk via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] refs: honor reference-transaction semantics when
 deleting refs
Message-ID: <YnkbxByewguRY5sZ@ncase>
References: <pull.1228.git.1651676435634.gitgitgadget@gmail.com>
 <YnizZ/a/hQ6hpRPB@ncase>
 <CAJDSCnPfGhL+_AL5Q1uAs8LLvW=Yckx=Ev0tQy1myCvyNF955g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QJBo+ldFcXbqovwX"
Content-Disposition: inline
In-Reply-To: <CAJDSCnPfGhL+_AL5Q1uAs8LLvW=Yckx=Ev0tQy1myCvyNF955g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QJBo+ldFcXbqovwX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 09, 2022 at 12:18:51PM +0200, Michael Heemskerk wrote:
> On Mon, May 9, 2022 at 8:23 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > I really like these changes given that they simplify things, but I
> > wonder whether we can do them. In the preimage we're eagerly removing
> > loose refs: any error encountered when deleting a reference is recorded,
> > but we keep on trying to remove the other refs, as well. With the new
> > behaviour we now create a single transaction for all refs and try to
> > commit it. This also means that we'll abort the transaction when locking
> > any of the refs fails, which is a change in behaviour.
> >
> > The current behaviour is explicitly documented in `refs.h:refs_delete_r=
efs()`:
> >
> >     /*
> >      * Delete the specified references. If there are any problems, emit
> >      * errors but attempt to keep going (i.e., the deletes are not done=
 in
> >      * an all-or-nothing transaction). msg and flags are passed through=
 to
> >      * ref_transaction_delete().
> >      */
> >     int refs_delete_refs(struct ref_store *refs, const char *msg,
> >                          struct string_list *refnames, unsigned int fla=
gs);
> >
> > There are multiple callsites of this function via `delete_refs()`. Now
> > honestly, most of these callsites look somewhat broken:
> >
> >     - `bisect.c` simply does its best to clean up bisect state. This
> >       usecase looks fine to me.
> >
> >     - `builtin/branch.c` reports the branches as deleted even if
> >       `delete_refs()` failed.
> >
> >     - `builtin/remote.c` also misreports the deleted branches for the
> >       `prune` verb. The `rm` verb looks alright: if deletion of any
> >       branch failed then it doesn't prune the remote's config in the end
> >       and reports an error.
> >
> >     - `builtin/fetch.c` also misreports deleted branches with `--prune`.
> >
> > So most of these commands incorrectly handle the case where only a
> > subset of branches has been deleted. This raises the question whether
> > the interface provided by `refs_delete_refs()` is actually sensible if
> > it's so easy to get wrong. It doesn't even report which branches could
> > be removed and which couldn't. Furthermore, the question is whether new
> > backends like the reftable backend which write all refs into a single
> > slice would actually even be in a position to efficiently retain
> > semantics of this function.
> >
> > I'm torn. There are valid usecases for eagerly deleting refs even if a
> > subset of deletions failed, making this change a tough sell, but most of
> > the callsites don't actually handle this correctly in the first place.
>=20
> Exactly; this is the reason that I initially suggested fixing the issue by
> just removing the upfront rewrite of packed-refs. With that rewrite remov=
ed,
> the refs-to-be-deleted are deleted in individual transactions, which may =
or
> may not rewrite packed-refs. The downside, as you correctly pointed out,
> is that we could end up rewriting packed-refs multiple times, which could
> come at a significant performance penalty for repositories with large
> packed-refs files.
>=20
> Unfortunately, the current approach of updating packed-refs in one
> transaction and updating the loose refs in individual transactions doesn't
> work either.
>=20
> So what are our options?
>=20
> - delete each of the refs in a separate transaction and pay a (potentially
>   significant) performance penalty in repositories with large packed-refs
>   files when deleting many refs. I'll note that this scenario is similar =
to
>   deleting a set of refs through a non-atomic push.

By chance I know that on gitlab.com we've had huge performance issues
with access patterns like this. In some cases with repos that have
millions of refs I have seen that certain actions were completely
dominated by rewriting the packed-refs file. So I'd rather avoid going
there given that it would be a serious performance regression.

> - switch to a single transaction and update refs.h:refs_delete_refs to use
>   an all-or-nothing approach (the approach I've taken in my patch).

This is the easiest approach, but also backwards incompatible as I've
layed out above. I personally wouldn't mind, and as said I think that
most of the usecases are broken anyway because of implementations which
misreport the case where we only partially deleted refs. But it's not a
decision we can make without more discussion, I guess.

> - improve the reference-transaction mechanism to support the
>   'batch-of-transactions' mode more efficiently. If I remember correctly,
>   something like that has been suggested before, but I'm not sure if it's
>   actually been built or spiked. In this batch-of-transactions mode, git
>   could try to prepare all refs, and only invoke the hook for the refs th=
at
>   could be successfully prepared. The hook should then be able to
>   reject individual ref updates, and git would then apply only the
>   non-rejected ref updates. While such a change would make many
>   scenarios where multiple refs are being updated more efficient, it's al=
so
>   a much bigger change that's hard to make without breaking the current
>   reference-transaction protocol.

Peff and I had such a discussion in the past, and having transactions
with eager semantics would also fix some edge cases we have in other
parts of the codebase. You already mentioned git-fetch(1) without
`--atomic`, and there are likely others that could benefit.

I did have a go at this several times already, but none of the
approaches I took resulted in a clean-to-use API. I consider this to be
the best solution, but also the hardest one to implement, unfortunately.

> Sticking to a transaction per ref and rewriting packed-refs multiple times
> is the safer option. Deleting the refs in a single transaction is the more
> performant option, but changes the behavior. A stay/stale lock file could
> then make it impossible to remove a remote, or to prune /refs/remotes/
> refs.
>=20
> My suggestion would be to stick to a transaction per ref and pay the
> same performance penalty as you'd get when deleting many refs through
> a non-atomic push.

I don't think we should do this. The one-transaction-per-ref issue is
why I added the `--atomic` flag to git-fetch(1) in the first place,
because it has been biting us in repos with millions of refs. Quoting
583bc41923 (fetch: make `--atomic` flag cover pruning of refs,
2022-02-17), which introduces this flag:

    Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
      Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User: 0.8=
58 s, System: 1.508 s]
      Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 runs

    Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User: 0.7=
15 s, System: 0.641 s]
      Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 runs

    Summary
      'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
        1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic +ref=
s/*:refs/* (HEAD~)'

And this is only with a 100k references. The issue gets a lot worse when
you're in the millions of refs, both because you have 10x more refs to
prune, but also because the packed-refs file is 10x larger. So
performance doesn't scale linearly with the number of refs, but is a
product of file size and number of refs.

[snip]
> > One thing that worries me is that these patches kind of set the current
> > behaviour of driving the reftx hook via both packed and loose backend
> > into stone. My patch series that got reverted is going to change that
> > behaviour though so that we don't execute the hook from the packed
> > backend, and consequentially we'd have to change all these tests again
> > to match the new behaviour. This makes it a lot harder to argue though
> > that we can safely switch to the new behaviour without breaking any
> > assumptions when we even codified our current assumptions into tests.
>=20
> The counter argument to that is that it's kind of scary if you could remo=
ve
>  half of the reference-transaction callbacks without needing to update a
> test. I'd rather have tests that verify current behavior that you need to
> update when you intentionally change the behavior, then not have those
> tests?

Oh, I certainly agree there. And we have stated in the past that the
reftx hook is _not_ providing a stable interface with regards to exactly
when it is called. We only want to guarantee that it is called on a
transaction.

> > Taking a step back I wonder whether my previous approach to just hide
> > the hook for the packed backend was the right thing to do though. An
> > alternative would be to instead expose additional information to the
> > hook so that it can decide by itself whether it wants to execute the
> > hook or not. This could e.g. trivially be done by exposing a new
> > "GIT_REFS_BACKEND" environment variable to the reftx hook that gets set
> > to either "packed-refs", "loose-refs" or "reftables" depending on which
> > backend is currently in use. Equipped with this information a hook
> > script can then easily ignore any updates to the packed-refs file by
> > itself without having to change the way it is invoked right now and thus
> > we wouldn't regress any currently existing hooks.
>=20
> From the reference-transaction hook writer's perspective, the backend
> involved is an implementation detail that the hook should not have to
> care about. Getting separate callbacks for the loose and the packed
> backends makes it a lot harder to write a good reference-transaction
> hook, especially when the callbacks differ if a ref is packed or not.
>
> IMO, there should really be a "files" backend transaction, that internally
> takes care of locking individual refs and possibly "packed-refs" in case
> of a deletion. In addition, not getting "artificial" packed callbacks also
> saves us a few extra reference-transaction callbacks when deleting refs.
> Even if those take only a few ms per invocation, when deleting hundreds
> of refs, it's still something that we'd like to avoid if we can.

True. In this case it's just an alternative way to tackle this specific
issue given that one wouldn't typically care about the packed-refs
changes. And it's very much an artifact of the files-backend really
being two backends in one. In any case I can see arguments for both
approaches, and ultimately I agree that it would be best if the
files-backend behaved as if it was a single one.

> > >  test_done
> > > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > > index 4620f0ca7fa..8b09a99c2e8 100755
> > > --- a/t/t5510-fetch.sh
> > > +++ b/t/t5510-fetch.sh
> > > @@ -169,10 +169,10 @@ test_expect_success REFFILES 'fetch --prune fai=
ls to delete branches' '
> > >       git clone . prune-fail &&
> > >       cd prune-fail &&
> > >       git update-ref refs/remotes/origin/extrabranch main &&
> > > -     : this will prevent --prune from locking packed-refs for deleti=
ng refs, but adding loose refs still succeeds  &&
> > > -     >.git/packed-refs.new &&
> > > +     : this will prevent --prune from locking refs/remotes/origin/ex=
tra for deletion &&
> > > +     >.git/refs/remotes/origin/extrabranch.lock &&
> > >
> > > -     test_must_fail git fetch --prune origin
> > > +     test_must_fail git fetch --prune origin > outputs 2> errors
> >
> > It would be nice to have an explanation why exactly this change is
> > needed, and why it is fine that the visible behaviour changes here.
>=20
> The  test was relying on the fact that the packed-refs file was locked wh=
en
> git fetch --prune is called. My patch replaces that unconditional lock wi=
th
> a transaction. The transaction only takes out the lock if packed-refs
> actually needs to be updated, and since the ref being pruned only exists
> as a loose ref, git fetch --prune failed to fail.
>=20
> I've replaced the lock on packed-refs with a lock on the loose ref that
> should be pruned.

Ah, thanks. I was missing the fact that the lock for the packed-refs
file was taken unconditionally before.

Patrick

--QJBo+ldFcXbqovwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJ5G8MACgkQVbJhu7ck
PpS9Sw//SR0a+yy6hfmEM91vkOiTLE1FD3RqtFmdAs8hVL2Q3Ufpnpz9pIFBUsjD
2HdwEoQY+9jKAG2uPHGjcFQqloNe9i+H1NIvq8bIV5E+ArXhj9SHBDDwS2iZXdcN
8zAFuALpoxkip+2zGd5MpoHsoxm6pQONvkh656KAzmqAsfK5hhmZNNVRz9njZ99R
3riCfv3F29dTwPzyq2P7w4sL+8IJYi3BG0rp36VVKIjZrBvPz1lna76Yv3oRFGFw
duycntR6jV51JDJjzRB5xYMpbBAobN5BUztDbLtAViAQ3pTfRPpwfSFb0oSTqYWC
cRH6nAnoR9vbyxdNReZEQoM4ZRDmG7HbrNLu5zLlPsOzaqZwna21x7a9aUFnaWLA
p+QIxvF/pgiCO/o46vXB4gPuADG1k5h+oDR3DsxB9sI9eazdFW+dpcaILRipp5tI
dDJk22nSWdX8skIjW/EdXiYqyRUr7GgyFcox35DBjLxba7XiCIzRcl0gfFlNji9L
I94M3twp3RwHY1T2MiMyHBJ1Xhmjz8oDZ1AGTpXuFk7bPwylXvj/qiruCP2QOq/y
KDiFocbBqVtiSFHBjb+Yy+Ww6KZcoczqrK1ZJlyyfNnMIlDMOKO8aXufjVvUkxFo
j5lqrkrnP2tlQNiIjrUhBv1U78qh+X7Q169buNMFufJv59+9BW0=
=kgrQ
-----END PGP SIGNATURE-----

--QJBo+ldFcXbqovwX--
