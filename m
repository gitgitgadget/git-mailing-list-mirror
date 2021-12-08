Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988A6C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 08:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhLHIwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 03:52:36 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50927 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229489AbhLHIwf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Dec 2021 03:52:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 577B05C0230;
        Wed,  8 Dec 2021 03:49:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 Dec 2021 03:49:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=f2pehsaYRM61s28PWObessoEryu
        GaB6/E08QUBNiiiw=; b=V6Su7As4HL8x4tNZBONR0Hmh7rhKt8M/vQJWkkR05p3
        tHCu73QmKMbGmOEpyBPqU/VbXkEuQfDSMZ1RvFBtuQbY2/qauSoIZis6BW2mqZ+r
        QEe7910dMhRVFTRl8puvaV9lCOvQzkkKD9eO4ch6MEriANJNpbcXbWKhD3c2xJEq
        3cn/3poX7L0B4ID/uUgUJ6qBfvsJ3qu6nDjToXaHFQnf9gaHwnXNTVgJFvfykj81
        lwUNKPpwY2+xpYTrT1HyutoZ1QaelUUv+L1kjuVPuCiQfaWHH+rnT2jMt3+z5NcX
        lbpsBmpGin7BjufoEqVG8e2+cUChhwDsKC8S20TdPlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=f2pehs
        aYRM61s28PWObessoEryuGaB6/E08QUBNiiiw=; b=B/pWBEbrPDH2YVMoppGdQQ
        Y9R1ZGBgj3//VibYjyujler9qCQ9Do4SNimu8EzUv6XQ52YMcTtooRjd6zCnolEy
        rl0eXA/nh13r0pV/kTPI/BjJgUW27rRxE48vhGRpU2ekeCR1rQ3IfOI6q5deNNLA
        W/10JFzN1J2cfxruMPTZ/nSNHpfZ5JwWZp1CyRTkQZKeA6VpUYJ1HVEmx0ScX3K9
        KfoeNrMbTf/YblG/Gh1niDnGtYfeUYCYdrLKg7Vzv6E4yotaGI5+cZxBYT6gt5aC
        To1wyHy8P6FbuTttdTrRV6PRbtm9DbWKi4sTxBisYh+JiK0R7kFS+rot45VT+7sw
        ==
X-ME-Sender: <xms:f3GwYd-3iaHBztlyjorby4GYicvgEFQsFuAraJwi_B9vg4Bx4D251Q>
    <xme:f3GwYRvAX673e88qbPwVe_eb9UPXqk2YFE7U8U7n2Vx68SNXGQTaZTjq9dkQjX8V2
    BUXuVrnSmIyI8yHAQ>
X-ME-Received: <xmr:f3GwYbBlob_ikhXnazkIgUST2uCA49oO-vN5x66UGhOWwEm3goz5oTcfrT9kJjJEkxtPzxf3Y6Y276GTMT3eRHOxb_sbkblL_jMbgnKgk6uC_wz-5KdNQFHD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeejgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:f3GwYRfYNzxJwiuX4ESb2j3Hd9kH5ds0qSqO_XzfNRim2JVSDrULWw>
    <xmx:f3GwYSNwYzPiPV17pkOVcOJU8jvgSQM7XN4hhCF7KICRRgYkCm_bzg>
    <xmx:f3GwYTnNQHNxmhKgRR5i7vN2kEUwQQDoQTI5_AONP4-KLXW0SBgxww>
    <xmx:f3GwYbY-URHF-Zg10D1AwWbvjfGiFat8TtJiKy-WufU9l2xodar6Jw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Dec 2021 03:49:02 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e7ffb3f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 8 Dec 2021 10:18:13 +0000 (UTC)
Date:   Wed, 8 Dec 2021 09:48:15 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [RFC] fetch: update refs in a single transaction
Message-ID: <YbBxT+s8SssdkH7Z@ncase>
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
 <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rAn4B6djUqJ1/BDG"
Content-Disposition: inline
In-Reply-To: <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rAn4B6djUqJ1/BDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 09:15:01AM +0100, Christian Couder wrote:
> On Tue, Dec 7, 2021 at 11:11 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When git-fetch(1) isn't called with the `--atomic` flag, then each
> > reference will be updated in a separate transaction. As a result, even
> > if we failed to update a subset of transactions, the remaining refs will
> > be modified after the command has finished. While this pattern is
> > reasonably efficient with the files backend where we'd lock and write
> > each file separately anyway, the upcoming reftable backend could handle
> > such an update a lot more efficiently if it was batched into a single
> > transaction given that it could then create a single new reftable slice
> > instead of creating one slice per updated ref. While this inefficiency
> > can be easily mitigated by using the `--atomic` flag, this flag cannot
> > be used in contexts where we want partial-update semantics.
>=20
> So it seems to me that there are 3 possible behaviors/modes:
>=20
>   - "atomic": a single transaction with all or nothing semantics,
> currently implemented with --atomic
>   - "partial-update": a single transaction with partial-update
> semantics, the new behavior this patch is implementing
>   - "non-atomic": many transactions (one per ref?), currently the
> default when --atomic isn't passed
>=20
> Yeah, "partial-update" seems better than "non-atomic" when the
> reftable backend is used. But what happens  when "partial-update" is
> used with the files backend?

Yeah, putting this in these three modes catches the gist of how it can
work. Currently, we only support "atomic" and "non-atomic", and this
patch proposes to replace "non-atomic" with "partial-update". I'd be
happy to instead implement it as a third mode, but if we can find a way
to "do the right thing" without having to introduce another option, then
that would be best. But as per your comments below and my own concerns
I'm not sure we can easily implement this without breaking existing
usecases.

> > Convert git-fetch(1) to always use a single reference transaction,
> > regardless of whether it is called with `--atomic` or not. The only
> > remaining difference between both modes is that with `--atomic` set,
> > we'd abort the transaciton in case at least one reference cannot be
> > updated.
>=20
> Nit: I would say "as soon as one reference cannot be updated"
>=20
> > Note that this slightly changes semantics of git-fetch(1): if we hit any
> > unexpected errors like the reference update racing with another process,
> > then we'll now fail to update any references, too.
>=20
> So that's one difference between the "partial-update" and the
> "non-atomic" modes, but what you say doesn't really make me confident
> that it's the only one.

There can certainly be other edge cases which break, and I'm sure others
will be able to pinpoint exactly which these are.

> Also are there people who are in cases where a lot of reference
> updates are racing, and where it's important that in such cases at
> least some ref updates succeed?
>
> If yes, then maybe the 3 modes could be kept and options for
> "partial-update" and "non-atomic" could be added. "partial-update"
> could be the default in case the reftable backend is used, while
> "non-atomic" would still be the default when the files backend is
> used.

I bet there are.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  builtin/fetch.c | 78 ++++++++++++++++---------------------------------
> >  1 file changed, 25 insertions(+), 53 deletions(-)
> >
> > Hi,
> >
> > until now, we have been quite lenient with creating lots of reference
> > transactions even though they could've been bundled together into a
> > single transaction. After all, it didn't have much of a downside in most
> > contexts with the files backend: we'd have to lock each loose ref
> > separately anyway. I'd like to get some feedback on changing our stance
> > here, due to multiple reasons:
> >
> >     - The upcoming reftable backend will be more efficient if we use a
> >       single transaction to bundle together multiple ref updates given
> >       that it only needs to write one new slice instead of one per
> >       update.
> >
> >     - Syncing refs to disk can be batched more efficiently if we bundle
> >       ref updates. See my initial patch series to implement fsync-ing
> >       refs [1] and Peff's benchmarks [2] demonstrating that fetches may
> >       become a lot slower.
>=20
> Maybe it's explained in the pointers, but is this in the case of the
> files backend or the reftable backend or both?

The discussion in [1] was in the case of the files backend: if we want
to guarantee that we never write corrupt refs to disk, then we must sync
written data to disk before moving refs into place. If using multiple
transactions, then we thus need to fsync(3P) in each commit. If we're
using a single transaction though, we can amortize the costs and batch
this, where we only fsync(3P) once after all references have been
prepared.

The same is effectively true for the reftable backend though: if we want
to ensure that reftable files are safe, then we'd have to sync them to
disk, as well.

> >     - The reference-transaction hook can be used more efficiently given
> >       that it would only need to execute twice, instead of twice per
> >       updated ref.
>=20
> Yeah, so that could be a regression for people who expect it to run
> twice per updated ref.

The reference-transaction hook was always a mechanism which hooks into
internals. As such, how often the hook executes and in which order was
never guaranteed and is expected to change when implementation details
change. So this is not something I'd ever call a regression: the whole
intent of the hook is to be able to see what happens internally, not to
assert semantics or the order in which updates are performed for a
specific Git command. That's kind the trade-off with using a low-level
hook as this one.

> >       It also has a more global view of what's happening.
> >       While this is a concern of mine, it's a non-reason in the context
> >       of the Git project given that we really ought not to change
> >       semantics only to appease this hook.
>=20
> Not sure I understand what you are saying here.

Previously you saw `2*len(refs)` executions of the hook, so you'd have
to piece together the puzzle to see what happens on a more global level
yourself. With the change of using a single transaction, you'd get only
two executions of the hook, where each execution has the complete
picture of all refs which are about to be updated.

> > With these reasons in mind, I'm wondering whether we want to accept
> > refactorings which convert existing code to use batched reference
> > transactions. While the potential performance improvements are a rather
> > obvious upside, the downside is that it would definitely change the
> > failure mode in many cases.
>=20
> Another downside is that it changes how and when reference-transaction
> hooks are called.

As mentioned above, this is nothing I'd call a downside. We cannot ever
guarantee stable execution order of this hook, or otherwise we paint
ourselves into a corner.

> > The example I have here with git-fetch(1) would mean that if we were to
> > race with any other process or if any other unexpected error occurs
> > which leads us to die, then we'll not commit any change to disk. This
> > can be seen as an improvement in consistency, but it can also be seen as
> > a change which breaks current semantics of trying to do as much work as
> > possible.
>=20
> I like the idea, but it seems a bit safer to me to have 3 different
> modes, so that people can test them in real life first for some time.
> Then we might later be more confident with changing the default for
> some backends. I might be worrying too much though, as very few people
> probably use reference-transaction hooks.

Fair, I'll wait a bit for more feedback and then probably post a v2 with
a third mode.

I think changing behaviour depending on which ref backend would be bad
precedent though. Ultimately, the user shouldn't notice which backend is
in use, except that it would ideally be faster if using the new reftable
backend. But slightly changing semantics of commands depending on which
backend is active is only going to lead to confusion.

Patrick

--rAn4B6djUqJ1/BDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGwcU4ACgkQVbJhu7ck
PpQmGBAApiaB1k14hiEF7dpPxBk20Lz6SVCy+PJWVNc+aS6Z3lJ3tTrYkbnb5zGu
DWdt1rBACRcOLfDW+aDSJkVd8un5ZO5sTLrfuht/tnvj2V5i3yV2fbwU2OravKkt
FUjnem+/D0JCRO2xofkIVZtUkxorXGpiz1WBs8b9kTSN8KeYbted2YgrUtwRPfNM
D7z8E9ovcJ8lc0p4ER0Pd0Rm+Xu1ai/Ga2rVbW0gy+rdKMnik3DUaESY8KFpVKKG
gb1fcmf+S8PFFwC+wcqMRXXdGI7Fc91yIp41jdpKB7yyHS13rvU3ycV0RC/K5z1F
Xa61tDw4kNpyfsK0ruDP0SutI6PGdGkVs9Cne/iAWywyS6vglKLGYThbqVIrCI8W
h4x+GWacg48+oAuGlJqDru918fwkPgiXO68J9b+p3xrivpqJgjwenm0a1fpTju20
yczlN/xCxq+xDOSqEFivhuO4t+Emb8EMDoG3DiE1CXnopiDcI1/2uVd1uxDh4Q4t
wcSxjDVtVDGQsEkKKSALQanYb3oXp0mfgRYZn0OqcuVfzomwOzRRV/6l82VqnQvh
8DDEbP44NwwdxIdmjE9Doos79ZLlvDkSHFMCrxf3V9ppKR1U9ZoufE0VQv6YxGg9
qVOSTNrbcdO+CQ3lccbfgYA1b6edHs1qUaG63ya62sZ4DoDLSgE=
=tR7k
-----END PGP SIGNATURE-----

--rAn4B6djUqJ1/BDG--
