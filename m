Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9177C433F5
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E6961266
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhKOPKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:10:18 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51643 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232654AbhKOPKP (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Nov 2021 10:10:15 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 807C25C01A6;
        Mon, 15 Nov 2021 10:07:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 Nov 2021 10:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xEuBGNKgVmXNMWZaRfaPEtGRiL1
        toicanVAFa4EqHdU=; b=EU13sMcllVjx4Z3LbOoJQTyJYy5z9C3ABLgHyrJFICe
        xp1L2t9zgL4rBCWFE7YCgkpiTBqtCoCBeQbGq1/H2aQKI5z5s0GqiilIJ5HZakQz
        0z7zEfxEgO+gX+bHaZK3JEZe6vQsdHGpm1ddDm9qHcpMA1SexStOUo0Cs6pnIW/H
        xf0mcX0oCaEAoxMovjxYf9BEd9YmKdNGQp5wKajGSsQCOV+5HC/bGtT22YewWLtt
        omb39PKrWYOxvbI2i11xpW2QE0HrdpcNJThqdci0HpgKOoXtzfKzDwC3SCu5JfcG
        /8tfyWhD6UKfRjVNTTT0905hO/NP7N3pWGtyLaqQZNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xEuBGN
        KgVmXNMWZaRfaPEtGRiL1toicanVAFa4EqHdU=; b=LztZE5OuQ449E9o26w8MCj
        GfQuMqGMEpRKIPvswomK6C1XKWULSClbvqkunthZ49GWEF6mTyJOW7rNfhkWoOCS
        oOUULjAN8Wx0Kp5NNrtE9nv9Upg9+1rVirE0bH2Kp/EKF5Rgf2xWC1pCSyfqY1vf
        akzqE00bM/hbbFlHnhhgFIPaPR0OhNvDenfRixsUbh4idk8RhVkVWGxKxLMoPeXM
        451Y+q/K9xEIvwwMwoSUxUr894+QCQe1YOxnPUwaMU4DRgGVKjdgjwt7uTNJtnom
        Y0ZUBj1NdoL/SXOSBTeGSgi5ArgZf9/UfbNeG9YwSm2EozysP831VOyadPgZrywA
        ==
X-ME-Sender: <xms:pneSYXM3n-ADmBDAif9Lad5gL20uDETHVyEuPU3wQT-Oth62iPpvQw>
    <xme:pneSYR8Kls_dwymwpnxoy5JiwmHkiuIfmkcM7hl8n9qKB-crFnCxDc4UCmqTUCXrQ
    DuJjwtfoWzp46dkzQ>
X-ME-Received: <xmr:pneSYWSB7l0pKQ9nOzaxtrjkZawFnHHnDu12GDLLcmXfBUeYTed_vhA_dDGbu6bqWLvc3lY_KSDc3u-XWPs5eCY2QcEX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpedvgfejjeektdejudelheeuieejheeuueetie
    etvdekieegjeehheeljeehhfetheenucffohhmrghinheptghonhhnvggtthgvugdrtgif
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pneSYbtb4IsYkXz_Xajes-dokymEu6ih_BoCcyn63ibyzLBMGC9jCQ>
    <xmx:pneSYffUmBc_VnE5H9x4V7whiGW_RBVFEWmtd1csIslFt6gbP6Kncw>
    <xmx:pneSYX0zA2JHGo0ymu6AHJQ-sA4H19w_nDt2fkp30EerkaSCo6TkZA>
    <xmx:pneSYXEDQ-PQihWDIGiMZplm-vgpxgeqPfBYX1Y3Pvbfz7bQ-FwNwA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Nov 2021 10:07:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3f210b5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Nov 2021 16:49:12 +0000 (UTC)
Date:   Mon, 15 Nov 2021 16:06:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
Message-ID: <YZJ3hZkX9YjNBAdk@ncase>
References: <xmqq4k8kzuz2.fsf@gitster.g>
 <YY0HbQJEWbOwuuFj@coredump.intra.peff.net>
 <xmqqwnlemwcy.fsf@gitster.g>
 <YY17rBFIdDl+H47I@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zSItBWIOj0DeYSjw"
Content-Disposition: inline
In-Reply-To: <YY17rBFIdDl+H47I@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zSItBWIOj0DeYSjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 11, 2021 at 03:23:08PM -0500, Jeff King wrote:
> On Thu, Nov 11, 2021 at 09:32:29AM -0800, Junio C Hamano wrote:
>=20
> > > Now in this case, we're sending too much output, which is OK for the
> > > purposes of the connectivity check. It will just walk day-1 and its
> > > tree unnecessarily, which is a performance loss but not incorrect.
> >=20
> > The primary use of the traversal in check_connected() is when we
> > have new refs we haven't seen, and they go to the positive end of
> > the traversal, which will end in the refs we do have (there may be
> > tons).  The idea is that when one or more of the new refs are truly
> > "new" in the sense that one or more the objects necessary to connect
> > them to our refs do not exist, not even in the "not reachable but
> > not yet pruned" state, this traversal will hit a missing object and
> > will error out.  So, it is alarming that "day-1" is shown without
> > painted uninteresting via any of the negative [day-4..day-9]
> > commits.  Which means, if we are checking if we need to initiate a
> > real fetch to connect day-1 and day-10 to our DAG, when we think we
> > have [day-4..day-9] and everything behind them, we stopped traversal
> > before seeing all the "objects necessary to connect them to our
> > refs".  If day-2 were missing in our repository, we would have
> > noticed if we did traversal from sorted tips, but the unsorted
> > traversal happily misses it.
>=20
> Yes, but if day-2 were missing in our repository, then we are already
> corrupt. And in most cases we would not notice adding a new ref that is
> also corrupt (e.g., imagine adding _just_ day-10 which is a descendent
> of day-2, but we stop traversal at day-9 when we see that we already
> have it reachable).
>=20
> So I don't think it is actually changing the check_connected() outcome.
> I couldn't come up with a case where we should be checking a commit and
> don't. Only the other way around.
>=20
> > Not that noticing that day-2 is missing from our repository does not
> > help much in *this* particular case, though.  It is likely that a
> > common negotiation would say "I have [day-4..day-9], and want day-1
> > and day-10", that is reponded with "OK, I know enough, here is
> > day-10 and its tree/blob that would be missing from a healthy clone
> > with everything behind day-9", and it won't include day-2 (nor
> > day-1).  So in this particular example, it would not matter if the
> > new unsorted traversal is subtly broken (I think the extent of the
> > damage is similar to making the SLOP problem deliberately worse),
> > but I am not sure if there are other failure modes that would yield
> > outright incorrect result.
>=20
> Yes, I think that framing is right: it is making SLOP much worse. We
> could similarly have had bogus timestamps in those commits which would
> cause the same outcome. So in that sense it is nothing new. On the other
> hand, I wonder how often it will cause extra traversal work (keeping in
> mind that this commit traversal is just the first stage; after we find
> the commits, then we talk all of their trees, which is the more
> expensive part).
>=20
> For the case of adding new commits directly on top of another branch, I
> think there would be no change. But any time you have to walk down to a
> common fork point (e.g., imagine I made a new branch forked from an old
> bit of history), we may fail to find that. I haven't quite constructed
> an example, but I have a feeling we could end up walking over
> arbitrarily long segments of history.

Sorry, but I'm currently completely loaded with work and thus didn't
find the capacity to have a deeper look yet and will probably not find
the time for a few more days. So the earliest I can have a look at this
is probably beginning next week.

With that in mind, I'm happy to have this change reverted for now, as it
is...

> > We probably should revert this step as it can affect correctness in
> > a big way, but I wonder if the other steps in the same series, or
> > other topic that came later, rely on it.
>=20
> I looked them over, and I think this is pretty independent (with the
> exception of the refactoring of the no_walk/unsorted flags, but
> obviously that had to come first).

=2E. completely independent of the other patches in this series and can be
reverted on its own. Only question is whether we also want to revert the
patch introducing this option in the first place given that it would end
up without a user afterwards.

Patrick

> > At the very least, I think this may be prudent during -rc period,
> > but on the other hand, I do not know offhand what would later
> > pursuade us to reinstate it and convince us that it is a safe thing
> > to do.
> > [...]
> > diff --git c/connected.c w/connected.c
> > index cf68e37a97..35bd4a2638 100644
> > --- c/connected.c
> > +++ w/connected.c
> > @@ -107,7 +107,6 @@ int check_connected(oid_iterate_fn fn, void *cb_dat=
a,
> >  	if (opt->progress)
> >  		strvec_pushf(&rev_list.args, "--progress=3D%s",
> >  			     _("Checking connectivity"));
> > -	strvec_push(&rev_list.args, "--unsorted-input");
> > =20
> >  	rev_list.git_cmd =3D 1;
> >  	rev_list.env =3D opt->env;
>=20
> This seems like a pretty safe and minimal backing-out for the -rc
> period. We would still ship with "--unsorted-input" as an option (and
> mentioned in the docs), though. If we're worried that it might be a dead
> end and we don't want to support it, we could revert f45022dc2f
> (connected: do not sort input revisions, 2021-08-09) entirely. That
> carries a little more risk of accidentally breaking something during the
> revert, but from my reading of the patch it should be pretty safe.
>=20
> I'd be curious to hear Patrick's thoughts on the whole thing.
>=20
> -Peff

--zSItBWIOj0DeYSjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGSd4QACgkQVbJhu7ck
PpRyEw//QtHW+MU/6mk/aIK9wyFaolqCiq2mLK6uBsTNHwH9U8UYxeWMbiwnwhPq
0tYLYIEh0DNZLA3NvEUfoMRr/opQCqINnOIaqN+tuHB4K2EUkaMhZAS5PgKQ4JdY
NoEUxF/WClwtCgPQ0v/HLXAit0TgPvhDM9TzgvavFBH+rpz2eRrcSaMa485jbF7z
fehZDGwqSvP+bhCsJOFjXoIDLu9xm3eL5cVvSyRUI0azwM1SESoJbT86Uwjclyvt
EHJGtAVaPxhtV8ajmCwBlsUu6PyZJ0dg9PcFfyGJJZOi/nzkd0lxdwU/ZTbXZ1aN
+4u6w2/X4iPrBn5qd0YFrElTvPnW9skXP601ZTwEZOVQv+XImydkHhoIhpmtYyyr
TaIXMztBxTpZJORpKroXcSH0aNs2S+Ou9VwbeRU9qa13/xZhaOyFmMh0XxUp4f9O
n9xWj2ZfgLGBz1dWtiXZE6AdMeOzQfBC7ZnF/gwJ30frkqWB9jyADhVaz9GnOAs3
BAsQKfd9Ai39+/aW3evG+AnBb9vn0uf+UOTNk71KiD8hhJ3jCvuy8LpyqY1udvuN
tEo/PnoneFWw3wP0SNxiCgiWGrprNWXkCHkFQXyWagThYgre8EK/zxz3c/nQXTX6
lLzCf7HmaxO+i3fmm5xLiv3zkZPM8XNJ28hercoEOQPD+Hlfja4=
=j3nQ
-----END PGP SIGNATURE-----

--zSItBWIOj0DeYSjw--
