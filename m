Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51F6C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 11:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiKALwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiKALwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 07:52:11 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EE11C13A
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 04:50:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C3C4F5C02FF;
        Tue,  1 Nov 2022 07:49:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 01 Nov 2022 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667303398; x=1667389798; bh=gl1EUG7tWG
        wJjlLrDnBbjbxkC4pkXsbcL1/G68yxnUM=; b=Va+/c84u2GgL1Iln59LXjMrWQB
        sXVr4P+7M7keoyeNGmmRFI3xfUug6Wv8Pan5CDs8I5jzwDYWkuTpVC9BdaV13EJd
        bR+GRTwpbZ8YOMURjLLBzWV9voLRRFWH3eLjTcoQieZuk8Pi3urqHnF34oBpA3vm
        s7hsZqyMo2LPr7BvqLXI5grT2Ofhjlt6bRoJSaD7WTg+o3f/pMTZoyUss438w5+9
        uld4DzkggkPOUx4G4UL2PTvP8YaddDpwku8yaO9Gn9bntJ8ZdEzSnvyXcXXqGAUf
        WQTnbu7VCbqn5bo1RBaDIAJ+PE4pRTtzUw0A/lSThAtpHxQtxNSIZVZY4sww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667303398; x=1667389798; bh=gl1EUG7tWGwJjlLrDnBbjbxkC4pk
        XsbcL1/G68yxnUM=; b=AO7pQN3CMqcbrdU+EXfMM1BAxlAFLLcjSUKHHa9OvSLu
        G79x9jDQJvxOEW9wcxNIT1/OjG7BrKqYutwSZO11Pf3RFLSDRtKk3RY5hMhv5nnw
        V/TNPz8BXZZXIBq2NWE9SJYMqzriUFtQ84GXNikBzHbQ66JQF+TAolswbDUpKrm2
        OS8pYTIo851VhKGhyspkmSToZk9Pm8TsImRpQfgV3BhDmgnB1sj/MYHtRgchs7oq
        d68Qqp5+MlfB/kjA7piYQOZFUN8keDDBEUzBW6xBx1Aj6QNjFk67HxGVaVBsIeC/
        ioYtrEBNNMGmxhomrPACEuHCL338bBJ53qyn3oOcBw==
X-ME-Sender: <xms:5gdhYybg9tfINUCpm7vwuq1ut-Ll3-EOv50Dov4PyKNDowbPVHbS2w>
    <xme:5gdhY1awfaCdZQ2186uZWy2PsjwSXn-KePkcIHZuQRK7jc6nmZwy_TuNx4geqyp9Q
    Xaw033Rob5ksxXOPw>
X-ME-Received: <xmr:5gdhY8-wmVxfvTq1pPZ_A-yEHDR5g0mRWCd0BGuBg7lP5RIBdLuesooI8HI1T4gnVp6ziFfoCK5zrzdLJNyHp5VtKBlnnxLuljRpA4NbmOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudehgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5gdhY0quAUiMKFmLua2FR_tJBuo7iJMslWeqwVRVE_4wMyd-d21fIA>
    <xmx:5gdhY9p1yT_fbGy7PAKGVuc8Ya8pJYz7C7h1YmEr6G86xMcvjc1ITQ>
    <xmx:5gdhYySmh1oNvpdLMeI1Wdy-qvUsMF6bzCvXkjgzaIs1CkQ8AZgNXA>
    <xmx:5gdhY02kd4SoVLFxT9L-fkxj3UeUw2LMa17pQqQW9LTT6Xhp1pJQPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Nov 2022 07:49:57 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c4df1f0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 11:49:37 +0000 (UTC)
Date:   Tue, 1 Nov 2022 12:49:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2EH3+l62S55EJOZ@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <Y2DgJi6foPyBhycU@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PRLoILMIhR4TUP6h"
Content-Disposition: inline
In-Reply-To: <Y2DgJi6foPyBhycU@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PRLoILMIhR4TUP6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2022 at 05:00:22AM -0400, Jeff King wrote:
> On Fri, Oct 28, 2022 at 04:42:19PM +0200, Patrick Steinhardt wrote:
>=20
> >     - A client shouldn't assume objects to exist that have not been part
> >       of the reference advertisement. But if it excluded an object from
> >       the packfile that is reachable via any ref that is excluded from
> >       the reference advertisement due to `transfer.hideRefs` we'd have
> >       accepted the push anyway. I'd argue that this is a bug in the
> >       current implementation.
>=20
> Like others, I don't think this is a bug exactly. We'd never introduce a
> corruption. We're just more lenient with clients than we need to be.
>=20
> But I don't think your scheme changes that. In a sense, the tips used by
> "rev-list --not --all" are really an optimization. We will walk the
> history from the to-be-updated ref tips all the way down to the roots if
> we have to. So imagine that I have object X which is not referenced at
> all (neither hidden nor visible ref). We obviously do not advertise it
> to the client, but let's further imagine that a client sends us a pack
> with X..Y, and a request to update some ref to Y.
>=20
> Both before and after your code, if rev-list is able to walk down from Y
> until either we hit all roots or all UNINTERESTING commits, it will be
> satisfied. So as long as the receiving repo actually has all of the
> history leading up to X, it will allow the push, regardless of your
> patch.

Oh, right! Now I see where my thinko was, which means both you and
Taylor are correct. I somehow assumed that we'd fail the connectivity
check in that case, but all it means is that we now potentially walk
more objects than we'd have done if we used `--not --all`.

> If we wanted to stop being lenient, we'd have to actually check that
> every object we traverse is either reachable, or came from the
> just-pushed pack.

Yes, indeed.

> There's also a subtle timing issue here. Our connectivity check happens
> after we've finished receiving the pack. So not only are we including
> hidden refs, but we are using the ref state at the end of the push
> (after receiving and processing the incoming pack), rather than the
> beginning.
>=20
> From the same "leniency" lens this seems like the wrong thing. But as
> above, it doesn't matter in practice, because these tips are really an
> optimization to tell rev-list that it can stop traversing.
>=20
> If you think of the connectivity check less as "did the client try to
> cheat" and more as "is it OK to update these refs without introducing a
> corruption", then it makes sense that you'd want to do read the inputs
> to the check as close to the ref update as possible, because it shrinks
> the race window which could introduce corruption.

Agreed.

> Imagine a situation like this:
>=20
>   0. We advertise to client that we have commit X.
>=20
>   1. Client starts pushing up a pack with X..Y and asks to update some
>      branch to Y.
>=20
>   2. Meanwhile, the branch with X is deleted, and X is pruned.
>=20
>   3. Server finishes receiving the pack. All looks good, and then we
>      start a connectivity check.
>=20
> In the current code, that check starts with the current ref state (with
> X deleted) as a given, and makes sure that we have the objects we need
> to update the refs. After your patches, it would take X as a given, and
> stop traversing when we see it.
>=20
> That same race exists before your patch, but it's between the time of
> "rev-list --not --all" running and the ref update. After your patch,
> it's between the advertisement and the ref update, which can be a long
> time (hours or even days, if the client is very slow).
>=20
> In practice I'm not sure how big a deal this is. If we feed the
> now-pruned X to rev-list, it may notice that X went away, though we've
> been reducing the number of checks there in the name of efficiency
> (e.g., if it's still in the commit graph, we'd say "OK, good enough"
> these days, even if we don't have it on disk anymore).
>=20
> But it feels like a wrong direction to make that race longer if there's
> no need to.

Good point.

> So all that said...
>=20
> >     - Second, by using advertised refs as inputs instead of `git
> >       rev-list --not --all` we avoid looking up all refs that are
> >       irrelevant to the current push. This can be a huge performance
> >       improvement in repos that have a huge amount of internal, hidden
> >       refs. In one of our repos with 7m refs, of which 6.8m are hidden,
> >       this speeds up pushes from ~30s to ~4.5s.
>=20
> I like the general direction here of avoiding the hidden refs. The
> client _shouldn't_ have been using them, so we can optimistically assume
> they're useless (and in the case of races or other weirdness, rev-list
> just ends up traversing a bit further).
>=20
> But we can split the two ideas in your series:
>=20
>   1. Feed the advertised tips from receive-pack to rev-list.
>=20
>   2. Avoid traversing from the hidden tips.
>=20
> Doing (1) gets you (2) for free. But if we don't want to do (1), and I
> don't think we do, we can get (2) by just teaching rev-list to narrow
> the check.
>=20
> I see some discussion in the other part of the thread, and we may need a
> new rev-list option to do this, as mentioned there. However, you _might_
> be able to do it the existing --exclude mechanism. I.e., something like:
>=20
>   rev-list --stdin --not --exclude 'refs/hidden/*' --all

Yeah, Taylor proposed to add a new `--visible-refs=3Dreceive` option that
lets git-rev-list(1) automatically add all references that are visible
when paying attention to `receive.hideRefs`. I actually like this idea
and will likely have a look at how easy or hard it is to implement.

> The gotchas are:
>=20
>   - I'm not 100% sure that --exclude globbing and transfer.hideRefs
>     syntax are compatible. You'd want to check.
>=20
>   - these would have to come on the command line (at least with the
>     current code). Probably nobody has enough hiderefs patterns for that
>     to be a problem (and remember we are passing the glob pattern here,
>     not the 6.8M refs themselves). But it could bite somebody in a
>     pathological case.
>=20
> -Peff

Well, we can avoid these gotchas if we used `--visible-refs`.

Patrick

--PRLoILMIhR4TUP6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNhB94ACgkQVbJhu7ck
PpTyxw/9HMBc/cc3BVpfasCFnoQZFHGtFcsHwCQO4tU7HdxOkHIiCeZzqzNIrhm7
P63z6KTjig4KdrdqNoSNyFTPYVkCXDw8wvU8nypLg6rqVaGIa1whzL1x7Mx60eaR
8eKyJUiiPYbNjEjSX14H8SqYk83IzeQZi3mixXxj5UHdoASb2//O/VCiKwGezTCV
RJPQ1g2ivwq+CtFdfeC3c9KmyaLyL4K6m0M2Aa82lG6N+NwW75j77jypcnn5g6Up
vEbrbnOZNw3EYkA0sgXeSIN8VleRdASSomefHgudT2WJD6IxuZ4wRo8PJbzxm4QK
lpQ3eOZIIkWcSE4B9Ji5y6GVvziHrXgweEvVlbFWH8uxLEDvnpTeGwZC5vjmajVK
ZHHGpPHKTe4SbJgZKes6CezcHMjCiuJ8DTX1FEshcPLGyRDmllpIaGXNXBHc+1ic
lrfoQfXv7kHoXjUyq7UPePqYdyfVDpLABsDyVZG3dzBBUBGbCU5gFWytZMcehcXv
YXJ3t3qW+8oDlch0dkgZQLRYRM/vF1x7wakmAWe4xz1KLZPiaVVMmJlEd/3d+dFu
MQf/kcd/JyxWfq+fUddB3fYGr7UBvB8pmTjyrJVMS9KyD977HE4BImt/6Fe8BITP
Jf4WK47q/W7lIMq3IEzfhhMUv3x5hu7PEi+0cGlwTfS2IrAn2BA=
=LFre
-----END PGP SIGNATURE-----

--PRLoILMIhR4TUP6h--
