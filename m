Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD4C433EF
	for <git@archiver.kernel.org>; Sat, 25 Jun 2022 08:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiFYIx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jun 2022 04:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiFYIx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jun 2022 04:53:56 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E6393F0
        for <git@vger.kernel.org>; Sat, 25 Jun 2022 01:53:55 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E72025A0E9;
        Sat, 25 Jun 2022 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656147234;
        bh=9J2UbEZSd15Zx0AtvvYaxe8YNGewEFnQvK3QaeOtExU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=y2bSepG12ttvfh4hIee3feBePlcuP8LiU4/6+Ck2Mh6SWEM1O74Qw35xpxSsLY7HD
         qVave8nbZ9oTSfNCHg5XwGymZKi8BYJPkQ+Z/DyfLcVRHAgN4NxJscj1p+so3k+nLN
         CMqBdYGvdeQb8J+0fYHYydjmTrBWgwI+WraSLwilqORhoMzvnBMHy0DTxrc8sRHMkd
         nH23JP1is+3Yl9zopdLCu3otIgwCdM/UGf1eAO9TnG57F+d2JhGiY1SyBAENpIpwlB
         sE0AIa9P7+lvIaHYCbwFIFnRZ4Eus+0hn5wVnU+q76iKMfWHljJRL3UE36HxIGuV4J
         qsZbVpaOlkCPzzWaXuO6vVoZRG0bk8hRAFcQWir1KWB+lVkgtxWwenhC22hfayqeDe
         KLv1WzHO+DNBpAZFQU+O2mli45U6XwREYyxxHEKnmTk2Z5QiSXCPvRe6SYDl7QUjnX
         PE2LXmfGQWk5pq3IYXFSWfF9b82FWhAwMI4zzWgiOC9eRiFBNMG
Date:   Sat, 25 Jun 2022 08:53:53 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
Subject: Re: SHA-256 transition
Message-ID: <YrbNIUnftj+Ooumo@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stephen Smith <ischis2@cox.net>, git <git@vger.kernel.org>
References: <12011256.O9o76ZdvQC@thunderbird>
 <220621.86sfnyuvt0.gmgdl@evledraar.gmail.com>
 <YrI9dvfoc5NYgVDq@tapette.crustytoothpaste.net>
 <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KWSAZ3rjVMjn+Luq"
Content-Disposition: inline
In-Reply-To: <YrWXdNGZGN7gXL40@coredump.intra.peff.net>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--KWSAZ3rjVMjn+Luq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-24 at 10:52:36, Jeff King wrote:
> On Wed, Jun 22, 2022 at 12:29:59AM +0000, brian m. carlson wrote:
>=20
> > > We've since migrated our default hash function from SHA-1 to SHA-1DC
> > > (except on vanilla OSX, see [2]). It's a variant SHA-1 that detects t=
he
> > > SHAttered attack implemented by the same researchers. I'm not aware o=
f a
> > > current viable SHA-1 collision against the variant of SHA-1 that we
> > > actually use these days.
> >=20
> > That's true, but that still doesn't let you store the data.  There is
> > some data that you can't store in a SHA-1 repository, and SHA-1DC is
> > extremely slow.  Using SHA-256 can make things like indexing packs
> > substantially faster.
>=20
> I'm curious if you have numbers on this. I naively converted linux.git
> to sha256 by doing "fast-export | fast-import" (the latter in a sha256
> repo, of course, and then both repacked with "-f --window=3D250" to get
> reasonable apples-to-apples packs).

I did the same thing, except I just did a regular gc and not a custom
repack, and I created both a SHA-1 and SHA-256 repo from the same
original.

> Running "index-pack --verify" on the result takes about the same time
> (this is on an 8-core system, hence the real/user differences):
>=20
>   [sha1dc]
>   real	2m43.754s
>   user	10m52.452s
>   sys	0m36.745s
>=20
>   [sha256]
>   real	2m41.884s
>   user	12m23.344s
>   sys	0m35.222s

Here are my results:

[sha256]
time ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack
~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack  2768=
=2E42s user 181.00s system 185% cpu 26:31.70 total

[sha1dc]
time ~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack
~/checkouts/git/git index-pack --verify .git/objects/pack/pack-*.pack  3041=
=2E28s user 184.84s system 199% cpu 26:54.74 total

Note that in my case, I'm using an accelerated hardware-based SHA-256
implementation (Nettle, which I will send a patch for soon).  This is a
brand new ThinkPad X1 Carbon Gen 10 with an i7-1280P (with 20 "cores" of
different sizes).

So this is about 9% faster in terms of total CPU usage on SHA-256 with
that implementation.  The wallclock time is less impressive here.

Of course, it might be slower in software, but considering that AMD has
had SHA-NI for some time, newer Intel processors have it, and ARM also
has SHA-2 acceleration instructions, it's likely it will be faster on
most recent machines assuming it's compiled appropriately.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--KWSAZ3rjVMjn+Luq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYrbNIQAKCRB8DEliiIei
gaOeAPwKzCw3dQBMhib/NrvaeAdV04468H+6MKGk3GfwlRChLQD/RqziPX68HnOY
ZESFBuIKmAyXItySfj/C09FVNaOYtgs=
=Hsqt
-----END PGP SIGNATURE-----

--KWSAZ3rjVMjn+Luq--
