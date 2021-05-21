Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A31CC433ED
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B7D613CA
	for <git@archiver.kernel.org>; Fri, 21 May 2021 09:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhEUJn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 05:43:59 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:59871 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236912AbhEUJn5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 21 May 2021 05:43:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id EAD321343;
        Fri, 21 May 2021 05:42:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 21 May 2021 05:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=r8Tj1jBlvu7hsbHuQsmUz+RHhqs
        IeiUFHNBZbmwEprw=; b=giQ2Ii7xeDmEhiwFVq2pHkwuTTRqMp6OUcE7VPPEMIj
        BgOIRR0PnfHEtB/IeHrc3ZSG89XY6M1dP6q0BRuAYZXibR2s2xTgDyxFgIXXVvSe
        jnyH8J0Zf6CCYj6WagpjKPd7aoAG9YB6APLfUpZhF/xXgqbD5vzB05SPYy1KjEoB
        rfACbn0W6kn0EnFkuzPpf5wAdhTpB7r/YiKpl6vdCen59KsytG52uuNWT/vymgV7
        4g4S+ng21B8/0AvkPtHq5qTrDQuiJqCYP7oN67XX6p9pgfm6HqthXiGin0LIDgwC
        vzAO2wRt/SXlksYncmuk4DRh9pSpaMeeoQzILeAu9Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=r8Tj1j
        Blvu7hsbHuQsmUz+RHhqsIeiUFHNBZbmwEprw=; b=ZjvNIrwsNm+DVUKcXQ3KCz
        BnSm0VsXBME/JpBdwxosRTuoNUMAiaVqvm7dEVR6A0Z1BGyZiN04eULT9ymzk3MA
        kcJefjwQFLzmGaUigBXUWLu77o4FSO2aZjrR3ryXd/DOapTvMMM06cGQamYFT36m
        fu+tjRlYnPRy+ihjIFzypziriykyhfkH0cjCH6A6wIwWYclpjHerLCzAd4bHaFiW
        1/7HKCoapu0zvN685+Lnfb0p9yvWdSCS03ZZ8dwv/UnV2hvoy8GwNNYx+E9ZRC/c
        2u7RXwVIHbin1LQEwCYjy0M/WhvvK+DHczpQAWdnMqxdQLuy2rTuTujlW/DeLvUg
        ==
X-ME-Sender: <xms:iYCnYID8exvNQMLZp2TpLd_2V1PN0zYv0b1Wt4D3qpZFMozGEO_x5w>
    <xme:iYCnYKiemybKKj3g_adUjoAYyaKGTR1IrBkFv7a1P2ip5UjKGHwotZTSCDKITt4Ww
    ddYlpH5mQm6HORCrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdeirddutddvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:iYCnYLnVDSsMOxK_HGskqe3LUvlBva-kuPxnY-JbFZzNC-snZUYuZQ>
    <xmx:iYCnYOyhV3xYk2oFJwH0F_HGBo8FcvVc3MCsefhso_rfFjVw1XaREg>
    <xmx:iYCnYNS9ndYXSyj04jV0ZRL4O5yY8At0g5axRdup7LuFiD5gHy0jOg>
    <xmx:iYCnYIP-pVdp7D2PyIIQRfVQ1U6zhHiRT-mYI8R69FbCL0TGjqg-oQ>
Received: from vm-mail.pks.im (dynamic-089-012-006-102.89.12.pool.telefonica.de [89.12.6.102])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Fri, 21 May 2021 05:42:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d9a11e0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 21 May 2021 09:42:27 +0000 (UTC)
Date:   Fri, 21 May 2021 11:42:26 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/8] Speed up connectivity checks via quarantine dir
Message-ID: <YKeAgv4AiPD4OLAH@ncase>
References: <cover.1621451532.git.ps@pks.im>
 <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JLX2lZrKiIeVDWAb"
Content-Disposition: inline
In-Reply-To: <YKaTUItbQ1pyMrrW@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JLX2lZrKiIeVDWAb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 20, 2021 at 12:50:24PM -0400, Jeff King wrote:
> On Wed, May 19, 2021 at 09:13:18PM +0200, Patrick Steinhardt wrote:
>=20
> > One of the issues I've found is the object connectivity check, which may
> > run for a significant amount of time. The root cause here is that we're
> > computing connectivity via `git rev-list --not --all`: if we've got many
> > refs in the repository, computing `--not --all` is hugely expensive.
> >=20
> > This commit series thus implements an alternative way of computing
> > reachability, which reuses information from the object quarantine
> > environment. Instead of doing a refwalk, we just look iterate over all
> > packed and loose quarantined objects any for each of them, we determine
> > whether their immediate references are all satisfied.
>=20
> If I am reading the patches correctly, your definition of "satisfied"
> is: the referenced object exists already on the receiving side.

Indeed. Each referenced object must either be in the quarantine
directory or an already existing one in the main repo. If it's
quarantined, then we'll eventually check it, too, so we don't need to
traverse any further than immediate parents.

> But that's subtly different from the current rule, which is: the object
> must be reachable from the current ref tips. The invariant that Git has
> traditionally tried to maintain (for a repo not to be corrupt) is only
> that we have the complete graph of objects reachable from the tips.
>=20
> If we have an unreachable tree in the object database which references
> blobs we don't have, that doesn't make the repository corrupt. And with
> the current code, we would not accept a push that references that tree
> (unless it also pushes the necessary blobs). But after your patch, we
> would, and that would _make_ the repository corrupt.

Right. The assumption basically is that if it's part of the repository's
ODB already, then it was checked at some point before and should be
fully connected. Also, we typically wouldn't delete any objects which
are referenced by anything else, so either we delete the unreachable
tree and its referenced blob together, or none of them.

> I will say that:
>=20
>   1. Modern versions of git-repack and git-prune try to keep even
>      unreachable parts of the graph complete (if we are keeping object X
>      that refers to Y, then we try to keep Y, too). But I don't know how
>      foolproof it is (certainly the traversal we do there is "best
>      effort"; if there's a missing reference that exists, we don't
>      bail).
>=20
>   2. This is not the only place that just checks object existence in the
>      name of speed. When updating a ref, for example, we only check that
>      the tip object exists.
>=20
> So I suspect it might work OK in practice. But it is a pretty big
> loosening of the current rules for pushes, and that makes me nervous.
>
> There's another related change here that is actually a tightening of the
> rules. The current code checks that the ref tips proposed by the sender
> are valid.  If there are objects in the pack not needed for the ref
> update, their connectivity isn't checked (though normal senders would
> obviously avoid sending extra objects for no reason). Your "iterate over
> all quarantined objects" makes that stricter.
>=20
> I'm of two minds there:
>=20
>   1. We could easily keep the original rule by just traversing the
>      object graph starting from the ref tips, as we do now, but ending
>      the traversal any time we hit an object that we already have
>      outside the quarantine.

This should be doable, although it's a bit more complex compared to my
current proposal. As far as I know we don't have any APIs to say "Please
look up objects in this object directory, only", but we'd need to do
that or otherwise we're not able to tell where an object was looked up
=66rom.

Alternatively, we can implement this via a combination of both
approaches: first, we enumerate all quarantined objects and mark them
so. Second, we do a refwalk on all tips and stop whenever we find a
non-quarantined object.

My guess is that this is still going to be a lot faster compared to the
current implementation, at least when updating existing branches. But in
the case where we're pushing into an empty repo (or when we're pushing
entirely unrelated history), we now essentially have to iterate over all
objects twice. I'm sure this is going to be noticable performance wise.

>   2. This tightening is actually important if we want to avoid letting
>      people _intentionally_ introduce the unreachable-but-incomplete
>      scenario. Without it, an easy denial-of-service corruption against
>      a repository you can push to is:
>=20
>        - push an update to change a ref from X to Y. Include all objects
> 	 necessary for X..Y, but _also_ include a tree T which points to
> 	 a missing blob B. This will be accepted by the current rules
> 	 (but not by your patch).
>=20
>        - push an update to change the ref from Y to C, where C is a
> 	 commit whose root tree is T. Your patch allows this (because we
> 	 already have T in the repository). But the resulting repository
> 	 is corrupt (the ref now points to an incomplete object graph).

So with my patch we catch it right when it's being introduced, while
right now we only detect it as soon as somebody actually wants to start
using it. Depending on one's viewpoint, one could probably argue that
the repository is already corrupt as soon as we accept the tree into our
repo because we're missing objects. But except for git-fsck(1), one
wouldn't typically notice.

This does surface a second issue: right now, if receive.fsckObjects is
set to `false` (which is the default), we'd also happily accept objects
into the repo which aren't even parseable in case they're not
referenced. This is another form of corruption we allow with the current
implementation, but which gets detected by the new check.

> If we wanted to keep the existing rule (requiring that any objects that
> sender didn't provide are actually reachable from the current refs),
> then we'd want to be able to check reachability quickly. And there I'd
> probably turn to reachability bitmaps.

Honestly, at GitLab we've only had problems with reachability bitmaps to
determine newly pushed objects. We tried to use them to detect all newly
pushed blobs which are below a certain size (to detect LFS pointers, we
had this discussion before). But computing the set of new objects with
bitmaps enabled was orders of magnitudes slower for some repos than with
bitmaps disabled and has caused quite some pain already.

One of these edge cases I've fixed with negative tags causing a complete
graph walk (540cdc11ad (pack-bitmap: avoid traversal of objects
referenced by uninteresting tag, 2021-03-22)), but seemingly there are
more. I haven't yet found the time to dig into this though.

> I suspect that "rev-list --use-bitmap-index" in the connectivity check
> might help in some cases. Especially when you are looking at the union
> of objects reachable from all refs, we can avoid a lot of fill-in
> traversal (because if the bitmap for a recent ref includes the object in
> an older ref, then we know the older ref is covered, even if it doesn't
> have an on-disk bitmap at its tip). But I would not be at all surprised
> if there are other slowdowns in the traversal code when you have a lot
> of refs (e.g., I think we're pretty eager to parse all of the traversal
> tips as part of the setup).

Does this help if you've got hundreds of thousands of refs though? As I
said, one of the benchmarks I'm using is a repo with 880k+ references.
And lots of objects referenced by them will never be covered by bitmaps
in the first place because they're not part of the usual user-visible
references but part of an alternate.

Patrick

--JLX2lZrKiIeVDWAb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmCngIEACgkQVbJhu7ck
PpTpAA/+PXYoEUCj/mZ8AKituv/n2oNhVn3Y3exspMmoiWi5GCk8EQtxLranq6nD
UinBdgsftD8pXbw4J0RW1GMVjB2pums5t79WxwXYNYEvmUvrSsKCgxZwLgokL8ZS
jNMKo8HwosQuZ46Zts9T1nbeEYREu3A1911wOwHeVoDWfN+iGkKG5kD9x2DKzUeu
qDGXA5fd/vyco32K25On1lN1FHr1BmjYpOO4i2nBj1jrIZZUIkIa1z+2wA2kz4qv
v864fuyDL20s2DcHIDrAY86xq0XZThz2o+1+3YMIlYc+B6L8MJfa+OLPHFIfWgBR
MJMWl/6iaIzFvFuxdyAlMK6GhfrYJ3i5f9ZAJv7CWU8efwOtueEyiwj0nVm2c8F3
9u3b+JTlYIsqk3DafEEOshO3VIah9Dri8eEexyezfEIFMFgFk37A5z0S4wbYhCKj
xtSlzHT5JbFr4GX+SzU//4l4SqvIWl4d73ccaKGralyVi/fdHqDo59gsyLp+ZQB0
0i3qPch3QpcboJ2af69gyzmqXIVn8patRadExhNWs6xNUccnY1Y06T+4h7U/HKTt
T1qN+1Y15zUd6HWkwtlUDZreWgTdUk9GTevz87ZdP2Sw9NRrTQG1/dhqOWcgRpHS
5Lh7iST80vqOXoNXGjxaFONDE5CesNs2japWbvGKPkHQlyZ9KDk=
=qh2G
-----END PGP SIGNATURE-----

--JLX2lZrKiIeVDWAb--
