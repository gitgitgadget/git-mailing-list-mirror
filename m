Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E517AE95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 11:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbjJILAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 07:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346110AbjJIK77 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:59:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E599
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:59:58 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.west.internal (Postfix) with ESMTP id 8152F3200953;
        Mon,  9 Oct 2023 06:54:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 09 Oct 2023 06:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696848858; x=1696935258; bh=1d
        YMWYq+6gb+VsmkSgQmG4MHcKunAw/uPftu9qUHzIs=; b=GSKoHMX2N3reARlYgp
        iK+rKpLmiALXutv1M2dld7Z1ftbp/oOhRyxmD5RxKeqog2TqRFjto88Z/NfqZphM
        gsu4kQWBPZHdrx7l+LMCCqA0Jh+alq+ghrUUbi2SAT1UUMupV5LRZFOug54ABVoL
        12x9RokuAg09v34AagK9QuujcfYemiSP0yIfly6r+f7Qq9mRq59nBnFx3OmEOKyN
        I2z5Xd06sWm0NAkz7HkW5Z/fbltxep5pKklUBncNMbo8OP6TcQ09uGlUiUQ8mTrK
        Hg5IFbRHeENVJhu6/pR2DccE5Eorp6RYo+02ltvD/eJo0z2fg/We2BkDwUKB5BLz
        d+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696848858; x=1696935258; bh=1dYMWYq+6gb+V
        smkSgQmG4MHcKunAw/uPftu9qUHzIs=; b=S9ORtOQYVZViE98P0S1ZGAU0leF5q
        YHeG8xZMkUMhSlE7SV5tP0qozgfykwkVR6Buc7M5f9JS68osYUo9p6AUy60KGnxL
        6IRk7aEygyPUAafOaz17impREZskpM/axxH5iT6WClVQzfvOcJ9U8xvxrCiDo3nq
        ZhINfBd8n4ChXh1T1N3lC6yfY6nIUrRwaPbwXDTWXvojUbzULY+vH95rOyJTUeo/
        +vRpIAk0hfmXZ9U2lRwAWfUJsMd5VDoE4+ezjCzr3v8YpzvoQEBerLg3h/LMnjrn
        urPlKA3TdyGRXZmRs5JzTRap2+MAi5vCQhZVGfyoYZckVl4KU9Oa3847A==
X-ME-Sender: <xms:2dsjZTDhJD065fpvWHZtcIUAXF5y9bk2VZxteICekP3QI5ffokYY3w>
    <xme:2dsjZZgdO6vbgYhDzLzhPWOipzg1HDWnXYMqe4C5Uqq9ULF9C6nyTgq2XnvyZY7a7
    mw2HMu9-5upilI7Ew>
X-ME-Received: <xmr:2dsjZemBQhT7UyWeo4QDaGr9zSQd3LjOFjRy7ldSWrMeTYIVXOGsIiQtfeQWHC8FGfSYv6_3H5h8-9SaeZo6YcZvMTUtYw_-wK0epABkbMTgyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:2dsjZVwSuHbc6mK7cOhgR0-A4r0so_a2Xbya3Vhh7xAVtbYzp18U_w>
    <xmx:2dsjZYQ98t2YkpsALJnbA6PnpyCI7hLLGJ2AQmx4iRR6V4NQ_7UH9w>
    <xmx:2dsjZYZl_9HYKpBRHWT1m6v6HpDrpyiVzbM7pV-xWLn7ZVEE2iMg_A>
    <xmx:2tsjZeOcQiWZN8tBy5uROrKj23NIoTTB5WLZj8ebkQe7tEYSLyE74Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 06:54:16 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 3a68eeaa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Oct 2023 10:54:13 +0000 (UTC)
Date:   Mon, 9 Oct 2023 12:54:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        "Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/7] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZSPb1OYRrQSUugtg@tanuki>
References: <cover.1696629697.git.me@ttaylorr.com>
 <e96921014557edb41dd73d93a8c3cf6cfaf0c719.1696629697.git.me@ttaylorr.com>
 <xmqqil7j751u.fsf@gitster.g>
 <ZSCR7e6KKqFv8mZk@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FwvH0pmd6f6kzSxM"
Content-Disposition: inline
In-Reply-To: <ZSCR7e6KKqFv8mZk@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FwvH0pmd6f6kzSxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 07:02:05PM -0400, Taylor Blau wrote:
> On Fri, Oct 06, 2023 at 03:35:25PM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > When using merge-tree often within a repository[^1], it is possible to
> > > generate a relatively large number of loose objects, which can result=
 in
> > > degraded performance, and inode exhaustion in extreme cases.
> >
> > Well, be it "git merge-tree" or "git merge", new loose objects tend
> > to accumulate until "gc" kicks in, so it is not a new problem for
> > mere mortals, is it?
>=20
> Yeah, I would definitely suspect that this is more of an issue for
> forges than individual Git users.
>=20
> > As one "interesting" use case of "merge-tree" is for a Git hosting
> > site with bare repositories to offer trial merges, without which
> > majority of the object their repositories acquire would have been in
> > packs pushed by their users, "Gee, loose objects consume many inodes
> > in exchange for easier selective pruning" becomes an issue, right?
>=20
> Right.
>=20
> > Just like it hurts performance to have too many loose object files,
> > presumably it would also hurt performance to keep too many packs,
> > each came from such a trial merge.  Do we have a "gc" story offered
> > for these packs created by the new feature?  E.g., "once merge-tree
> > is done creating a trial merge, we can discard the objects created
> > in the pack, because we never expose new objects in the pack to the
> > outside, processes running simultaneously, so instead closing the
> > new packfile by calling flush_bulk_checkin_packfile(), we can safely
> > unlink the temporary pack.  We do not even need to spend cycles to
> > run a gc that requires cycles to enumerate what is still reachable",
> > or something like that?
>=20
> I know Johannes worked on something like this recently. IIRC, it
> effectively does something like:
>=20
>     struct tmp_objdir *tmp_objdir =3D tmp_objdir_create(...);
>     tmp_objdir_replace_primary_odb(tmp_objdir, 1);
>=20
> at the beginning of a merge operation, and:
>=20
>     tmp_objdir_discard_objects(tmp_objdir);
>=20
> at the end. I haven't followed that work off-list very closely, but it
> is only possible for GitHub to discard certain niche kinds of
> merges/rebases, since in general we make the objects created during test
> merges available via refs/pull/N/{merge,rebase}.
>=20
> I think that like anything, this is a trade-off. Having lots of packs
> can be a performance hindrance just like having lots of loose objects.
> But since we can represent more objects with fewer inodes when packed,
> storing those objects together in a pack is preferable when (a) you're
> doing lots of test-merges, and (b) you want to keep those objects
> around, e.g., because they are reachable.

In Gitaly, we usually set up quarantine directories for all operations
that create objects. This allows us to discard any newly written objects
in case either the RPC call gets cancelled or in case our access checks
determine that the change should not be allowed. The logic is rather
simple:

    1. Create a new temporary directory.

    2. Set up the new temporary directory as main object database via
       the `GIT_OBJECT_DIRECTORY` environment variable.

    3. Set up the main repository's object database via the
       `GIT_ALTERNATE_OBJECT_DIRECTORIES` environment variable.

    4. Execute Git commands that write objects with these environment
       variables set up. The new objects will end up neatly contained in
       the temporary directory.

    5. Once done, either discard the temporary object database or
       migrate objects into the main object daatabase.

I wonder whether this would be a viable approach for you, as well.

Patrick

--FwvH0pmd6f6kzSxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUj29MACgkQVbJhu7ck
PpSUmRAAkRZ+vosMA5mTOfjfx3LCisTXMYHONGg8NMAhT7Ii22cKLK3PhvlVzJUy
QnaeSV5iPoglbsKFRG0t1K18c3X3Aff+0sPocDggXd/SXE7deNlC74PFMxZS3MOI
X1/k9ggJgY93EeE7sv58DYalFoByEupnLwFH0cPUm4fPqt+5pFZ2/nqUtXv/ntUN
EUExkc6F0GxnZv/dZLXxhso0lGu2m0sdfySWDDwVJNbto/96fO+lShX9spv3TYDj
qPegkf01S6mhANFbHoEcxEGwQGvJxmBuyavpDVGYU5uq9r9g+JTUaLLarTlk5y27
jQpGUXuGKgjV9y9q93zLq+w7cd7AN2CyDgZBv5WcYb2iR6Ls15/nAzf3CPlZ0gNi
1DctNNRXaA/5C+iR0ueYg9o6q4pGk1Whc0/ObUHEyWMsWpfcIqzloibvzNlLGXdN
doRroE50UvXITtF+rbYsAwJqEXg1wP6qpV/VfWcIdKnWwpynLQFN5YXn9UMDMd30
vbUrqYkqoRKLhf+XEAUaGclj5jVB5uPOFr0MT1mSMR6afj9ULV9kLY6ba/y7JtiB
XP007mbnUhmKjx9DgSQe/yd5+cIYR1qCELQCUsunJAL8ZRomwtJ953HFsHdcRXRQ
oVnjg8RXBjSWqMcc8pjRCsKsv3SrS+TwZaiIoi1acKJV429DMGQ=
=spA4
-----END PGP SIGNATURE-----

--FwvH0pmd6f6kzSxM--
