Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F162C433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 01:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348347AbiDOBLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 21:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbiDOBLN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 21:11:13 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213685DA4B
        for <git@vger.kernel.org>; Thu, 14 Apr 2022 18:08:47 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 36D1D5A407;
        Fri, 15 Apr 2022 01:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649984926;
        bh=5+PeOHnahIsczgAZ7unPihUB9ti/Eaqr5n2fgT3Vn7w=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=m0ReREuPglSFfbKa5X5KDqfS6k7ST+vxHMk7lirWltze9pQIlElgB2y4wL5smaS5o
         Doz7uLuvO4FvS6SINVIWzSTg3eqlIhF73BWUJWv97/prdGwotXf0gQbhpiM4Ya0QyA
         OpfewgsyXQXQx9pMLucdQUHv/Z7Alb8EKVLAfy9I5eoZh8/VKd+8g+NP8E7MYFEoAL
         wwQgrkT9weH4be5aLQQyoUszPOMgoM7PSBop5eopbfiDAal9/ESWNr4UTf+VugHhh1
         UeU/PpT/jQIRdUnqvkt7mUnX615GIf+20EatD6FyVrOQ+pTAuvKRe4SXPhMAGOZdRJ
         B7X0FPplNpgWNkNUbWYP/tqqgF+IIXY6pwbv9oONCTbdMp4u4QBQRUUzCFT3teugE9
         4v37Hwuy9haABEWJG7xv/IBW8QYBvcbAiIlF0TjJwxx2+0ocVEzPuYptYuUGH4HI8G
         2yFO+B01dVXJ5JlvyznT7PksVZ92M4E7TjIRHw4kYhtAMkxfz2P
Date:   Fri, 15 Apr 2022 01:08:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Pathological performance with git remote rename and many
 tracking refs
Message-ID: <YljFnJk55WYLKd6Y@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
References: <YldPmUskbU+bOU2n@camp.crustytoothpaste.net>
 <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vGQQ3ZyLdvF7Y9ZQ"
Content-Disposition: inline
In-Reply-To: <220414.8635igdtfn.gmgdl@evledraar.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vGQQ3ZyLdvF7Y9ZQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-14 at 07:12:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> Aside from how we'd do renames with transactions, do you know about
> clone.defaultRemoteName and --origin?

Yes, I do know about that.  However, in my case, the repository is
cloned before I even get a chance to touch it, so these options have no
effect.  My dotfiles aren't even on the machine at that point.

> There was a (small) thread as a follow-up to that "rename --progress"
> patch at the time, did you spot/read that?:
> https://lore.kernel.org/git/220302.865yow6u8a.gmgdl@evledraar.gmail.com/

Yeah, I remember reading it at the time.

> More generally, probably:
>=20
>  1. Teach transactions about N operations on the same refname, which
>     they'll currently die on, renames are one case.
>=20
>  2. Be able to "hook in" to them, updating reflogs is one special-case,
>     but we have the same inherent issue with updating config in lockstep
>     with transactions.

Yeah, that's one of the reasons I was thinking of implementing
--no-reflogs: because in that case, the operation really is a
create/delete operation and it doesn't require any additional logic in
the transaction.

My goal here is specifically not to rearchitect ref transactions and to
implement a relatively simple solution.  Your response is indicating to
me that updating reflogs is going to be the former and not the latter.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--vGQQ3ZyLdvF7Y9ZQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYljFmgAKCRB8DEliiIei
gZ3xAP9b6XD7WRgcVRKh0vT7H2O9PA1A0oTiIDb+GR+UGlsh2QD5ATmkh1spGnTK
MIc+oI7L+/B4lVMln3xqa0zZBfBSxwg=
=xndr
-----END PGP SIGNATURE-----

--vGQQ3ZyLdvF7Y9ZQ--
