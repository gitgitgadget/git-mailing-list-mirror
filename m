Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27515C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7AC60F5A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhKEJZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 05:25:31 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58311 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232620AbhKEJZ1 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 5 Nov 2021 05:25:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 170AD5C0105;
        Fri,  5 Nov 2021 05:22:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 05 Nov 2021 05:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yBOaIzOXMRdJhmCJ90o8jm+EpBD
        aYXcM6+J25l8P48c=; b=WftB3iv2FR6ig64iYM5NH4BOAcOu0kX59RmSNW//ej8
        t6juu4ypfONUHL0vjlygaSQP0KC1rhpAXbmUzOvKJnrxvT8R6+IcM7BMYh/kIYR5
        bGbhIfGzzFcdDUh6JJQLCg5mXpiDS1lxdD2LoP3qcXL/6El5Juye2IPY390iQnuf
        6jN0CnRHl2Q7HFfPvmEGFa16QGgd/5zJDFwwK7SsCBR2Loi1x+a3qjArHevWakms
        Y/4W93+0Ydrlchdk7hd5a5SB/VxGjwKO/CUYQcyQtMKFyUW48cmGtf9toBE3iQin
        yPGOGRQbvYNrwmOO8craR+nqvLEE11KBq0YiUw15hUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yBOaIz
        OXMRdJhmCJ90o8jm+EpBDaYXcM6+J25l8P48c=; b=jfPMPcxAsAAJ6yPpRtBLn3
        y8OBrp/PZJn74P4PXnFlNCgG2SAleWQFsFibzaWTNsibRHDE8MUjtxNO1P1TzV33
        IZPI+ORYrcXvM0nssi9R3wwyDs52tBNddxFOWqZnMQaidZbS4io7yWyKPXP7x39c
        yGPuHgXU/agg8cE/5u0j8yWLSaUL9KiLtcjCweDT15Y5It93XmzT5ZAbS+LlAm6L
        ldXAnMsTKl4xJXLi6h2v1JvMbuhIdhceef5AtndN4pqkU7mP+YTEXffu3dzXpxpp
        E4KQ5G946zotC5KlHbpswwB0e2nH5p4fJRrBz5fdsfaat63tgYUFqYDal0hMPmgg
        ==
X-ME-Sender: <xms:5veEYYcWeiQDxqRXPQEfq1RRfdw3jN0Z4t_9p9FQBHMWjekDkc4fXw>
    <xme:5veEYaP9olaG4NgQb1N1Lzhvyl4jKXbWIIVucLColFLMo_L-9AJQllreBw9B8Vf9W
    gkfVYH_AVNwH-Iq2Q>
X-ME-Received: <xmr:5veEYZjI6nb0BXxxeigh7aunosM-sfnyq5UnbtEm2wNMAwYaf9gyt-r5SE1HYfUDY8T6uqZITgUdspOWLqpO1nT8Ea8xdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrtdeigddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epueeugfefvdetffeuffeufffhtdeutddvgfelhfelueeiheffheethfetgeettedunecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5veEYd9kM5NQQ6BGUvaWztEH21HkX7jR1wZlEX7ywH1Asun8cxXWmw>
    <xmx:5veEYUsRWnXM6Y7vpbZTcUT5nF3JGWREYSuhX-jF0caa2edDBmPgnw>
    <xmx:5veEYUFb7V72cP4v82K23nYWYGQqFuceq6dnPJNfw0GEjhnYWwEOiQ>
    <xmx:5_eEYRWN2BXirTn6mrKd7APEcpysXzGb538oc-uC2Gq-jFYLFt1gRw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Nov 2021 05:22:45 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8446c4cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 5 Nov 2021 11:10:24 +0000 (UTC)
Date:   Fri, 5 Nov 2021 10:22:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
Message-ID: <YYT3zx+P5maUAu5K@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <YYTYJpyrxtyR8yYZ@coredump.intra.peff.net>
 <YYTaiIlEKxHRVdCy@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MWsgwjz/DS7KDEDz"
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2111051010070.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MWsgwjz/DS7KDEDz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 05, 2021 at 10:12:25AM +0100, Johannes Schindelin wrote:
> Hi Peff & Patrick,
>=20
> On Fri, 5 Nov 2021, Jeff King wrote:
>=20
> > On Fri, Nov 05, 2021 at 03:07:18AM -0400, Jeff King wrote:
> >
> > >   2. It's not clear what the performance implications will be,
> > >      especially on a busy server doing a lot of ref updates, or on a
> > >      filesystem where fsync() ends up syncing everything, not just the
> > >      one file (my impression is ext3 is such a system, but not ext4).
> > >      Whereas another solution may be journaling data and metadata wri=
tes
> > >      in order without worrying about the durability of writing them to
> > >      disk.
> > >
> > >      I suspect for small updates (say, a push of one or two refs), th=
is
> > >      will have little impact. We'd generally fsync the incoming packf=
ile
> > >      and its idx anyway, so we're adding may one or two fsyncs on top=
 of
> > >      that. But if you're pushing 100 refs, that will be 100 sequential
> > >      fsyncs, which may add up to quite a bit of latency. It would be
> > >      nice if we could batch these by somehow (e.g., by opening up all=
 of
> > >      the lockfiles, writing and fsyncing them, and then renaming one =
by
> > >      one).
> >
> > So here's a quick experiment that shows a worst case: a small push that
> > updates a bunch of refs. After building Git with and without your patch,
> > I set up a small repo like:
> >
> >   git init
> >   git commit --allow-empty -m foo
> >   for i in $(seq 100); do
> >     git update-ref refs/heads/$i HEAD
> >   done
> >
> > To give a clean slate between runs, I stuck this in a script called
> > "setup":
> >
> >   #!/bin/sh
> >   rm -rf dst.git
> >   git init --bare dst.git
> >   sync
> >
> > And then ran:
> >
> >   $ hyperfine -L v orig,fsync -p ./setup '/tmp/{v}/bin/git push dst.git=
 refs/heads/*'
> >   Benchmark 1: /tmp/orig/bin/git push dst.git refs/heads/*
> >     Time (mean =C2=B1 =CF=83):       9.9 ms =C2=B1   0.2 ms    [User: 6=
=2E3 ms, System: 4.7 ms]
> >     Range (min =E2=80=A6 max):     9.5 ms =E2=80=A6  10.5 ms    111 runs
> >
> >   Benchmark 2: /tmp/fsync/bin/git push dst.git refs/heads/*
> >     Time (mean =C2=B1 =CF=83):     401.0 ms =C2=B1   7.7 ms    [User: 9=
=2E4 ms, System: 15.2 ms]
> >     Range (min =E2=80=A6 max):   389.4 ms =E2=80=A6 412.4 ms    10 runs
> >
> >   Summary
> >     '/tmp/orig/bin/git push dst.git refs/heads/*' ran
> >      40.68 =C2=B1 1.16 times faster than '/tmp/fsync/bin/git push dst.g=
it refs/heads/*'
> >
> > So it really does produce a noticeable impact (this is on a system with
> > a decent SSD and no other disk load, so I'd expect it to be about
> > average for modern hardware).
> >
> > Now this test isn't entirely fair. 100 refs is a larger than average
> > number to be pushing, and the effect is out-sized because there's
> > virtually no time spent dealing with the objects themselves, nor is
> > there any network latency. But 400ms feels like a non-trivial amount of
> > time just in absolute numbers.
> >
> > The numbers scale pretty linearly, as you'd expect. Pushing 10 refs
> > takes ~40ms, 100 takes ~400ms, and 1000 takes ~4s. The non-fsyncing
> > version gets slower, too (there's more work to do), but much more slowly
> > (6ms, 10ms, and 50ms respectively).
> >
> > So this will definitely hurt at edge / pathological cases.
>=20
> Ouch.
>=20
> I wonder whether this could be handled similarly to the
> `core.fsyncObjectFiles=3Dbatch` mode that has been proposed in
> https://lore.kernel.org/git/pull.1076.v8.git.git.1633366667.gitgitgadget@=
gmail.com/
>=20
> Essentially, we would have to find a better layer to do this, where we
> can synchronize after a potentially quite large number of ref updates has
> happened. That would definitely be a different layer than the file-based
> refs backend, of course, and would probably apply in a different way to
> other refs backends.
>=20
> Ciao,
> Dscho

Good question. We'd likely have to make this part of the ref_transaction
layer to make this work without having to update all callers. It would
likely work something like the following:

    1. The caller queues up all ref updates.

    2. The caller moves the transaction into prepared state, which
       creates all the lockfiles for us.

    3. After all lockfiles have been created, we must sync them to disk.
       This may either happen when preparing the transaction, or when
       committing it. I think it's better located in prepare though so
       that the likelihood that the transaction succeeds after a
       successful prepare is high.

    4. Now we can rename all files into place.

Naturally, we'd only benefit from this batching in case the caller
actually queues up all ref updates into a single transaction. And
there's going to be at least some which don't by default. The first that
comes to my mind is git-fetch(1), which explicitly requires the user to
use `--atomic` to queue them all up into a single transaction. And I
guess there's going to be others which use one transaction per ref.

Patrick

--MWsgwjz/DS7KDEDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGE984ACgkQVbJhu7ck
PpRcsBAAlfYA9/6wgm3sL6lDW7aNqOCLuBe20mUdTqGcxtvFI2RVgPzHUoJO9pAZ
oNKsp5Ha4gQLOTcijXzGiOc3A5kROByufP2iOpX00hdEKBOuGFAo7rNtspgq28y/
pnzMW2a8VZ3rK2ffwjbEP8uuQHbFuEXzlcsTSy44aDrs4GodJI0cKO2cRn+R1sg4
/sDNIsjzdJrcSbdFMmyID50bMsSUc5OfCJ0ZtgAJxVQJnW1JB9o2oFWFAPeOkuyt
BRXKBJv+rGg4oZFRaV7m0MnfkQuOBl9fJLrrqldegL403OFqS/9M+4KMuxOJenSB
+cw1e8GsgBIN1zwDasw8rP8j5zEInoqVgtYK/m93CXtNA/dYKvg0FH8dcK5jj9qd
Btj4MLdNP76kUNcmyTnhtbE4I9Q1r7EvH+CrmlgcnA2BlOTAQbqX24inCKe7/sBp
BaEiRl2vtu8dltm130Ep/H+JMMAJwWOLf3VG4NConHE98fhan0qAqk8yGJreeKTD
4ypBejTUNRnwv07j71Z1CydjKgiql4imU04GnGdAcIU+lCROoRlGCl5hYSEINJTm
OENc9mbQFZ4EfQ6Der7sIHiDGsxU/KTMZpsSy5GE74qKL1sN0eH+pSACgchyD98I
jkyhVgA2XZG54ZSwIHWUTQcNmAlTXmHPp3hGjf5dzuui8jFHcdk=
=fFwn
-----END PGP SIGNATURE-----

--MWsgwjz/DS7KDEDz--
