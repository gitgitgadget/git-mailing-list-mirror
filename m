Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5499C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C950E60EE4
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 09:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhKJJTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:19:55 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:41825 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230468AbhKJJTx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Nov 2021 04:19:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 369625C014F;
        Wed, 10 Nov 2021 04:17:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Nov 2021 04:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HN/FntZUYBF/VGIWXjmiKwyrqNk
        LE0iN2HB9o7GIOgE=; b=4yKH0hchm2gQVaTZK2+867VaMsb+4RRkPJ4wpbJy8wU
        7Jcb0ET8Y+cfawaNZVdAdrY4M1ewfYPYaBPUXkcy3iRuvdLt8xUOc3ey1lt9uUiU
        3ShElYJS1DlpfyJ7etgRXv8df8pIrWIUOQ6+zfXwstJJprWqd4IHU55p59YyV7rw
        BkCOgVK+kPZAUYNJ9vnDVSL+mk4FbB8SlejfNysWA2yuQ6nWDaiqdjeU2yzH6Fba
        i/lKugorE1n1wqO7mdtMjWCvWf7qicaZJZ70IimPDo1ip8J8gRbM8l/xBTDqLC7C
        hp1/C9t3LyKz7h2ox7VFlrB9kdpvuilFEoEEdEXTB+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=HN/Fnt
        ZUYBF/VGIWXjmiKwyrqNkLE0iN2HB9o7GIOgE=; b=i5+S/WblRKKW76hYj0O1IV
        RmNKks//zBwGjM4csJ4mfTfPxME2DCnISI556lAefA1u8udoVf/HrRZETVkPQKnO
        MZJhP+7CQ7qSi0Pfdd32qE+6hxzzyUyCczkJ9zzU/jZkXimuCFniSn3wShHRQ1JR
        MCWvGj48JvOP3nfbdKyhC0fePu1T7tZspFvzuIMNvR+0413p63H3nQbiz6wosoFd
        Vm89gFlRBpNRg30DXHPuDMoouF9YVwUxZ/QvE8mqdD/FSbBt1VAjag68IckhwsRF
        1iqpOomKwY7U3EsP2g6kfKwWPkUMx6gE7AmZ5ilkNny7b6cyAE4GVr4ffOI1vz4w
        ==
X-ME-Sender: <xms:EY6LYYE53-cBcZiGdX5ykGrDnfThFX5vThhVmWaL5wfp4P2x52etUw>
    <xme:EY6LYRV-l3A1qYVWA1s8W0BiOCD65HayPP9tYLYhp7vZDk6MXN4PBWWJwlkDj7Bv-
    477yoRfIyya3hEh2A>
X-ME-Received: <xmr:EY6LYSLlg3QXeXoWdx4vwLhAnf_JaZkKIPqM4dCsB6zpChGoh4mc-_J1IRRB_Fp6ub5l6JQV6dvnXMtq13cieNNMZFcKFcQ1iXPEHhf71Us6_N2ZEsZ7Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudejucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhitghkucfu
    thgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehge
    fhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:EY6LYaGHQBhEhme4plbcUIb0zorRQEhoTQuJ5bIHv-9Ah6fGytHnHQ>
    <xmx:EY6LYeUpBDA5MumY6aUrzdHtqK37PZG8LzzzaTKzKWCBskOFMpykeg>
    <xmx:EY6LYdMwbOVfyLU-fVXHm16BXRIT9mk16E5UU5cO-TndYsDbWZr7oA>
    <xmx:Eo6LYbiucsxK0He8ozXdIrRsFNVdRRnXutxeMaoJvppifWtIDuncRQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Nov 2021 04:17:05 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1ad2451d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 Nov 2021 11:02:13 +0000 (UTC)
Date:   Wed, 10 Nov 2021 10:16:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <neerajsi@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYuN971dStHrlJh3@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
 <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
 <YYT6tDyfBbwot2br@coredump.intra.peff.net>
 <YYpauqpBDVzOo+Px@ncase>
 <YYuEq42toR6mycem@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aUYHbXsKLFm/8F+G"
Content-Disposition: inline
In-Reply-To: <YYuEq42toR6mycem@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aUYHbXsKLFm/8F+G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 03:36:59AM -0500, Jeff King wrote:
> On Tue, Nov 09, 2021 at 12:25:46PM +0100, Patrick Steinhardt wrote:
>=20
> > So I've finally found the time to have another look at massaging this
> > into the ref_transaction mechanism. If we do want to batch the fsync(3P)
> > calls, then we basically have two different alternatives:
> >=20
> >     1. We first lock all loose refs by creating the respective lock
> >        files and writing the updated ref into that file. We keep the
> >        file descriptor open such that we can then flush them all in one
> >        go.
> >=20
> >     2. Same as before, we lock all refs and write the updated pointers
> >        into the lockfiles, but this time we close each lockfile after
> >        having written to it. Later, we reopen them all to fsync(3P) them
> >        to disk.
> >=20
> > I'm afraid both alternatives aren't any good: the first alternative
> > risks running out of file descriptors if you queue up lots of refs. And
> > the second alternative is going to be slow, especially so on Windows if
> > I'm not mistaken.
>=20
> I agree the first is a dead end. I had imagined something like the
> second, but I agree that we'd have to measure the cost of re-opening.
> It's too bad there is not a syscall to sync a particular set of paths
> (or even better, a directory tree recursively).
>=20
> There is another option, though: the batch-fsync code for objects does a
> "cheap" fsync while we have the descriptor open, and then later triggers
> a to-disk sync on a separate file. My understanding is that this works
> because modern filesystems will make sure the data write is in the
> journal on the cheap sync, and then the separate-file sync makes sure
> the journal goes to disk.
>=20
> We could do something like that here. In fact, if you don't care about
> durability and just filesystem corruption, then you only care about the
> first sync (because the bad case is when the rename gets journaled but
> the data write doesn't).

Ah, interesting. That does sound like a good way forward to me, thanks
for the pointers!

Patrick

> In fact, even if you did choose to re-open and fsync each one, that's
> still sequential. We'd need some way to tell the kernel to sync them all
> at once. The batch-fsync trickery above is one such way (I haven't
> tried, but I wonder if making a bunch of fsync calls in parallel would
> work similarly).
>=20
> > So with both not being feasible, we'll likely have to come up with a
> > more complex scheme if we want to batch-sync files. One idea would be to
> > fsync(3P) all lockfiles every $n refs, but it adds complexity in a place
> > where I'd really like to have things as simple as possible. It also
> > raises the question what $n would have to be.
>=20
> I do think syncing every $n would not be too hard to implement. It could
> all be hidden behind a state machine API that collects lock files and
> flushes when it sees fit. You'd just call a magic "batch_fsync_and_close"
> instead of "fsync() and close()", though you would have to remember to
> do a final flush call to tell it there are no more coming.
>=20
> -Peff

--aUYHbXsKLFm/8F+G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGLjfYACgkQVbJhu7ck
PpScqw/8DN+Auf8u184ZfPU/QFHmoGy94HdHOcMBXX8A7HxOy6WSBB8Cshc4tdwa
d4YdC/ITJWOAt2tFRhvz8FpdIK2zItnmhNlladeJ2lVR9+OFYcCoO+o5h7aj9tMc
wJv1R5oSTJixdsbW8NMqDHEisL4GNpIAK5ZmQ4o6tBUuN/ISgWoCb92vWXIQaa7s
mpZ4+mSlTGKbibsgDaX4ADThdU+OOSgPTL+/bFS+JYvT02oRDbRIemupYiwXoRrh
WYtsVT4bc8KmdIrFHFpBYiK1Irurz7550t+3+KwAUVTeJBycRuIlYH8z/+85H1/c
PyQt9SbxQwpCUp0rwBoVx+luiaCtgoq15RKbSEADq4n2ge3Kk761Ye/495bhwyrZ
Nt4c8rxdUkz9AY+pG7P6HcegRv7LemRbFadCZsLOmI5OjUvEAAB2lMy013KMr4MR
seOybZUGLTmElcSi3WTmtm1N+l1/eOSCa7YmoGMm+hi5lVktO2SXtjf4rITbV+wE
4wEWXLUwZnQU5D6euVybr6WRqss9+xKKgo4+3aIy6WSqeM7yq5l9JMKSKpBZ00Iz
Jtth8IYQJ335j0NElmUl92RVruZE5cBSWMtvHYOrx/SQt4aofmRtMYEqQf/3hAvf
BfVealnXK8HzmHyGhwk+0LcLeWuvY+XrLF27u2Fdv5ffyl2S2lI=
=TVfX
-----END PGP SIGNATURE-----

--aUYHbXsKLFm/8F+G--
