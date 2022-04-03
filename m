Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35C4C433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 17:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346397AbiDCRhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235651AbiDCRhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 13:37:40 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0CC1A3B6
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 10:35:46 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6E2E35A3E0;
        Sun,  3 Apr 2022 17:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649007345;
        bh=P3IspwMwE65pz+9uAhMgju6nbFH5B5wqSwNCVaeZNzY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Mm8m9xXG0JDzSwpFZ0ydR/t1SfYTfSwgzQ4vO5odkO7KCESHXQKRZ3NivAFNB8ujz
         US4sR+vn9er2jKUiqcwAZnX5EBamFYUm1BgksA5FP6OZELi0c5yQx54fP4ZDcxpUD6
         Kw3HDEQDYm0kDk/38G6/eWCJP0G8t/51nHGKR55GYmTN61WC6l1imD/RUQkZVIzZnB
         nbcoAzGniohp1QC8wFVvl7v8oRDgVcZVxh16ZsJOZlKn7BZaqsjuriZWfuMMn4wFhn
         2l7+ToeZVS/KdcAZnB+jDyCiq/Nx7qjXTgj0OYv9w7NEmsTrnLIg96xTIeyemEWXAn
         o4nYQPzCK/ChnIb2wR98zqSSn7nNcifzmjFzuwsJNkXJo33pBjP9UjGPh4Z41nNxSK
         /CkwAYXyqENjT2jDK8C3Dd1T0LGGkzPCZheNZOxjkv+hBBCR+PkcBqdVOYojgsH9F5
         f2n7o0PdPe+LW8B3rqdT7AaU+sISD+U+WqYtjEvVwk4ksSXt24j
Date:   Sun, 3 Apr 2022 17:35:42 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: any real-world SHA-256 repo users out there?
Message-ID: <Ykna7sJP8ktvNLor@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
References: <20220403084258.GA27999@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Eduyw98XGWN+q62R"
Content-Disposition: inline
In-Reply-To: <20220403084258.GA27999@dcvr>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Eduyw98XGWN+q62R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-03 at 08:42:58, Eric Wong wrote:
> Hey all, just wondering if it's something I should prioritize
> adding support for in some git-using project I hack on...
>=20
> Of course, I'm not dropping SHA-1 support.  So I'm wondering if
> I should wait for (or hack on :P) git to handle both SHA-256 and
> SHA-1 in one process; or if it's something I'd be better off
> managing via multiple (git cat-file --batch) processes.  No OIDs
> are abbreviated, so it's just 20/40 vs 32/64.

Git can already use one binary to handle SHA-1 and SHA-256 repositories
and has been able to since Git 2.29 (although 2.30 has some fixes you
should use). It just doesn't provide interop at this point, and I'm only
working on it as I find time, so I wouldn't hold your breath for it.

I have some indefinite plans to improve the support for SHA-1/SHA-256
interop in the future, as well as port SHA-256 support to libgit2, but
those are dependent on some things which are not certain (but very
likely) to occur.

I strongly encourage folks to add SHA-256 repository support to tooling
since it's likely going to become more popular in the future.  I have
some local SHA-256 repositories on my systems and they appear to work
fine.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Eduyw98XGWN+q62R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYkna7gAKCRB8DEliiIei
gaFyAP0S/QiFg5Z4hnQA9dEDzSK/DSQQInxoYU3TZhBxizP05gD+I7d1tG4V3h2a
B4SiYLFU+Uwo0MB3CCUeSN31Xa/0xgc=
=me9/
-----END PGP SIGNATURE-----

--Eduyw98XGWN+q62R--
