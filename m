Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 918141F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 02:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfADCIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 21:08:15 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58162 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbfADCIP (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 21:08:15 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c537:b034:2963:7e8f])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 314A66042D;
        Fri,  4 Jan 2019 02:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1546567693;
        bh=Jb0cCT+BIjS5iULpBRfMCHGsa0SjwmS8cnsjAHZRv64=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=psWuo6aKylb7jxkQC9Pm8aX5m/kiCTGUfr1BUdPTlvP5nc1+BPn90/a1r4tOqRHZM
         jwjQ+2FqHS8u3e6Ff9HlJv3sqHLnFi571EuCnj7IoneYH0BbvJrx00J4b0qfslQwuB
         TtMBkiMn+lqEnL9MQ4Y+cqPimOpwqjg5qZwiP32ZXfdJu0mfN9NIQZHDGFyLeGQLEi
         XAUWSo2iUoBMEU8A9DyY1NN/sp6eYwIorH7HfMRhnNfwtLVjnDdCU97xGg2ple3dv1
         RDJHhaYGoou8WspARHXTu7dR8Ibms3KII3lc+41y7z8KmPoQDp6VuH34+uCu2q8mTR
         K+/DQsLHJK3j85MgLBRVpbV8yf9tmjKC9GSwStq5ZzthhmC3ypikFaJtrDgqxIhS/D
         BqpSqIJwmn3RXPjxDRiQV7bVCuq/dMYQznWHwd8EZJHdEI6ii81GJB0pYymGiIr1gu
         VFMKRwZRopYieMfTPVnWNEKMEuhJppxJnLsgx9ZsKZccZlr9L42
Date:   Fri, 4 Jan 2019 02:08:08 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff: add support for reading files literally with
 --no-index
Message-ID: <20190104020808.GF423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
References: <20181220002610.43832-1-sandals@crustytoothpaste.net>
 <xmqqr2dukhw2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <xmqqr2dukhw2.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 10:56:45AM -0800, Junio C Hamano wrote:
> This is good as a goal, but the implementation seems to be overly
> eager to dereference any symlink or non-regular file found in any
> level of recursion.  The use case presented as the justification in
> the proposed log message, and the explanation in the documentation,
> suggests that only the paths given from the command line are treated
> this way.
>=20
> It may make sense to do this as two orthgonal flags.  Dereference
> symlinks and named pipes given from the command line is one use
> case.  Dereference any symlinks encountered during recursion is
> another.  And the latter might be useful even inside a repository
> as an option, even though the former would never make sense unless
> running in --no-index mode.

Yeah, I definitely think I'll be doing a reroll to address the recursion
issue as Peff suggested. I've just been on vacation and will be
traveling again soon, so I haven't gotten to it yet. Feel free to wait
for the reroll before picking it up.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwuwAgACgkQv1NdgR9S
9otosA//cmU+50GA+4BdnxJRQEFx5a5huJRLxDUq99GwTVtYvaltfu7arQTFANhZ
3lXnbmWOPgMI1ZEKNBcVrGiZaNLjHBVxYtWdnCnSgP8aEtiQl/PcWkwtt0IwKGzN
6OuL3qzgZMt+ths8aA6CTBfRicdyfRAswoU2YNXBG1gRc9mWH7usae7JziTIWeWy
LoSEp1d23qOrlC9xkLBPkIkdxgiISxXiazzH8xmgvo80ewPLFQoXhxH9ZZKSJihE
/gSPprube+bifPSN500sQrEL8NVpVaW9qCdELx1zlU0e3LUzOKNdcMNFYYX1e4IF
UlvRjxiCdSAzG7dh+0vW8JSwHaaOENvRQ7Af/dNV1a7KYRkXg5awR9rJCq/dVvls
1fMXTsLJfn/7smwaU//IiEQG1Q5DKxeypfySewLDtMfrwKlq8xiMXqGFSK1phxbX
2HppH8QmgYiOOrbrGQXGKcVueUZDqKUZSu9agdX1NBiVV116gExK93PNAmAhkc6u
/hF2wFgfN0VmXstj90vIui26x91MCo08cd1wgDY7Fd8V3wUIObHp8xuxsg1Y2JZF
BI0QqzPQw5uLJALPsl/leNcT4MWzhgpO1gBBsHwMjkKwljAJiDypMAh7M109FEtB
ZhwWcpiwAeOP/4yxuwT4bczUvoB6Bs4I9Wt/WFLdXQz9zLZas0s=
=8tGm
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--
