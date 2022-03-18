Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50761C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 20:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbiCRUXU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbiCRUXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 16:23:19 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AA1F082F
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 13:21:58 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0F1725A0CA;
        Fri, 18 Mar 2022 20:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1647634918;
        bh=tFgeZNKfE8XbFNQRF8vfQUOHGj6AvWmf552EdUp5VYQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=c19+ZHDYChWpnY/mGwh4Nc+AOZZyBbSPubVy2zP47tuDS9nFOuDYbW/9mf5QeFtdR
         EWNDVizfNcdTGOvoMMw8UePWAZbfsQiMUHk9N4OsYq2pPETosZVgKw3TMv0BxTSVh1
         D9vzcfLXAaG+wRNiN3JS/gocWcyV+nMhqEZqzVmGdRn+NL4vmWBgt9o9MsehHe4ePd
         xO3mpSJSqyk5WUjauQOY9Y+0KNqvV4OZCGOwFz01OMjA++xeSKlXP6TERRHDxLGKaE
         6MuYOXuNptoaFrSWVexkRi/7dLdThwsp8GOQBGsD4Tbl/xwEMziROxCGAMfY7Q6oiO
         FAhGvqFOjkY1mxAxfez7jZuaT3viRvOpbrvCqF/RN94MK6+f+eOAbr9FPKX3hz7Gos
         QTPrTkzPKcjgQhQFttSALhM15+4C7X2/sFrlT94D2Hk2gx+6dliFA4YwKs+h+aKAx0
         Qou9Te4Rmrf9d9HQ3gu4BHSxUrlZYbIydzy1AUJIJIneQXt0clG
Date:   Fri, 18 Mar 2022 20:21:55 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ricard Valverde <ricard.valverde@socialpoint.es>
Cc:     git@vger.kernel.org
Subject: Re: Noticed big performance issue when fetching multiple refs with
 depth 1 enabled
Message-ID: <YjTp45Q7wmZTodP9@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ricard Valverde <ricard.valverde@socialpoint.es>,
        git@vger.kernel.org
References: <CABkk9JoOYJ-tH9MrMkfdj5xMV+exXaJ2FxSjiSCMwCxsjaKqGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="szHhFqJiEj9ye/v5"
Content-Disposition: inline
In-Reply-To: <CABkk9JoOYJ-tH9MrMkfdj5xMV+exXaJ2FxSjiSCMwCxsjaKqGg@mail.gmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--szHhFqJiEj9ye/v5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-18 at 14:44:53, Ricard Valverde wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>=20
> What did you do before the bug happened? (Steps to reproduce your issue)
> Do a git fetch --depth=3D1 , with no remote changes, having a lot of
> remote branches makes the issue more visible
> What did you expect to happen? (Expected behavior)
> Shallow fetch should be faster or as fast as a full fetch
> What happened instead? (Actual behavior)
> Shallow fetch is about 10x slower than full fetch, consistently
> What's different between what you expected and what actually happened?
> I expected the shallow fetch to be faster than a normal fetch, or as
> fast. Did not expect it being 10x slower.
> Anything else you want to add:
> Tested in a repository with ~10000 remote branches, a single Github
> hosted remote.
> Also tested with a local remote, and Git 2.35.1 version, with
> comparable results.

The reason you're seeing this is that fetching into an existing shallow
remote is extremely expensive on the server side.  With a normal fetch,
we know that the user only needs objects which exist between the old and
new heads, and that they have every object which is reachable from the
old heads.

However, with a shallow fetch, we can't assume that, since by definition
the client side doesn't have all of those objects.  A substantial amount
more work must be done to determine what the client already has.  This
is made worse by the fact that you have 10,000 branches.

If you're working in a CI system or such, you should use a fresh shallow
clone each time, which will be much faster and easier on the server.
Otherwise, you may find that reducing the number of refs significantly
can also help performance.  If you can guarantee that you'll be online
when working with this project, a partial clone may also meet your
needs.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--szHhFqJiEj9ye/v5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYjTp4wAKCRB8DEliiIei
gWzvAQDeCSv0aDAYM1QuUOXejsNgxJohZiihqr1e0SBf5J8hsAD6Awuxuzclj4pF
BX7gXGtm2kAyajSCjbjg+N/mf4nOHg4=
=Cpzv
-----END PGP SIGNATURE-----

--szHhFqJiEj9ye/v5--
