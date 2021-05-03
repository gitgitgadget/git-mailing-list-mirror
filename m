Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA945C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 22:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8AE6135F
	for <git@archiver.kernel.org>; Mon,  3 May 2021 22:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhECW7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 18:59:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47202 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhECW7P (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 May 2021 18:59:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9859360459;
        Mon,  3 May 2021 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620082700;
        bh=SYMEc49vYc0Jhu0kb/6ecGhhLqnf48cgoOJO1p4DZW4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=G9zArwiUBReHoVWgXPILsNDnv2P8q44IEsS+1Z8wbYYspZTyyJjTwwLxRYqpKHZ94
         W05fQL4ar+Pn7Ru7hccNoXoDY9dLU1qSR4gyG0KFUEnVemqjdvsSC+YQBALZSzs3ZG
         gpqpi6FKstnC8g8piixGQlCNxhuv+pZvxHbSfcxqL5GULnDQAK/zGnlSHbksuVVL+r
         jK4OgeekOeYaw1rB0dv6/+PWqboNY1zvCG3E44XM6vb1PjEoSuw/R+who5QMePyuup
         zr/uHy4Q+7Cq2vuB6EkizcSSrOiIlzPBhSFOHy3XFMU7lPPgC5c7CXhB7xEVzpIt1+
         CebMCD28vseIKa8pcatOakqAxWIcLvNLazmMXFm+kA6M6qkwGqHJ8f7PZypfU/y00M
         mYX4y2q7B891SMXmMxzVeGbQNkv4sBpMnmZE4UYH8EIBGdylQkq3pYjpcnZeNYkbyb
         rs4FYon5B8hNGr2MQ19GEeyJLoxV/ej9KfjLQMZ+DjpfE5pKMqU
Date:   Mon, 3 May 2021 22:58:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mark Amery <markrobertamery@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug: Changing folder case with `git mv` crashes on
 case-insensitive file system
Message-ID: <YJCABtAGT7s70jl1@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mark Amery <markrobertamery@gmail.com>, git@vger.kernel.org
References: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EFmwsfKVWSHl6Kwi"
Content-Disposition: inline
In-Reply-To: <CAD8jeghpOQoibk0xM0QgLsOwLNw9GdM=4rhYuzV-NSkw8LinMQ@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EFmwsfKVWSHl6Kwi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-03 at 17:25:43, Mark Amery wrote:
> Attempting to change the case of a folder's name using a command like
> `git mv foo FOO` crashes on case-insensitive file systems, like the
> default APFS used on Apple Macs.
>=20
> Here are simple steps to repro this:
>=20
>     $ mkdir testrepo && cd testrepo && git init
>     Initialized empty Git repository in /Users/markamery/testrepo/.git/
>     $ mkdir foo && touch foo/bar && git add foo && git commit -m bla
>     [master (root-commit) a7e9f5f] bla
>     1 file changed, 0 insertions(+), 0 deletions(-)
>     create mode 100644 foo/bar
>     $ git mv foo FOO
>     fatal: renaming 'foo' failed: Invalid argument
>     $ echo $?
>     128
>     $ git status
>     On branch master
>     nothing to commit, working tree clean
>=20
> If I create a case-sensitive APFS volume using Disk Utility and try
> the commands above on that volume, `git mv foo FOO` works correctly:
> it emits no output, exits with a 0 status code, and stages a change
> renaming `foo/bar` to `FOO/bar`. However, on my main case-insensitive
> volume, `git mv` behaves as shown above: it exits with code 128,
> prints an "Invalid argument" error message, and does not stage any
> changes.

Yeah, this is because your operating system returns EINVAL in this case.
POSIX specifies EINVAL when you're trying to make a directory a
subdirectory of itself.  Which, I mean, I guess is a valid
interpretation here, but it of course makes renaming the path needlessly
difficult.

> The command still fails in the same way if you use `git mv --force`
> instead of just `git mv`.
>=20
> Note that previously, `git mv` could not change the case of *file*
> names on case-insensitive file systems, until that was fixed in commit
> https://github.com/git/git/commit/baa37bff9a845471754d3f47957d58a6ccc3005=
8.
> I'm guessing there's a different code path that needs fixing for
> changing the case of *folders*.

My guess is this is because when the argument is a directory, the mode
is set to WORKING_DIRECTORY, and then we check that the mode isn't INDEX
and so rename(2) gets called.  However, I believe there is a -k option
which should make this work, since we ignore the errors.

I suspect part of the problem here is two fold: on macOS we can't
distinguish an attempt to rename the path due to it folding or
canonicalizing to the same thing from a real attempt to move an actual
directory into itself.  The latter would be a problem we'd want to
report, and the former is not.  Unfortunately, detecting this is
difficult because that means we'd have to implement the macOS
canonicalization algorithm in Git and we don't want to do that.

Maybe someone who frequently uses a macOS system that uses a
case-sensitive file system can chime in here, but for now, I think -k
should do what you want.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--EFmwsfKVWSHl6Kwi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYJCABQAKCRB8DEliiIei
gW/lAP9LGlIEu2yodbRs/8NvwsHE5ze0Uyms1LKfCapbWv6NVQD/Q8POW+n2ouXn
+4TPIEbUBGH09oSI3hV9oJCwwLOj1wg=
=cSu0
-----END PGP SIGNATURE-----

--EFmwsfKVWSHl6Kwi--
