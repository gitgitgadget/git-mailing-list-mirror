Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0679E1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 02:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfAYCT5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 21:19:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33314 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbfAYCT5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 24 Jan 2019 21:19:57 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:c162:ac20:e47c:bd21])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D93216042D;
        Fri, 25 Jan 2019 02:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1548382795;
        bh=xanbhUjNn/YZY7BGmwKyNG+2ry49yV6vM5FSJYDylZY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=oKCF1ThKXGWwJhXMUrFznJHugMcnquk5vMEnkzoOaKZGQ3Q0DhICZoJA1uF5RSO0u
         aZwYuulfs0RnDnXkj3KF70kyqUYHr78oAIUqOwqv8muKgma1Khn5BwGIXL/co/2e5h
         6YKIQpdqM2RXvReeILsa9ECJcspAQ2UbuW8sens4jY6Wazqnrx1QFsgDxhRXdDmlqY
         QhUScmKmHfkHVqni93j2JFGky4voiKTMGw7yCsTiCCgT1Cp0l0/gYIi4gelgS5yGGw
         wfdk9jzjXzW8sx0qydAwi9AwyXfWXv8SszZvcr0ZPZE1BSLCvMnUSHE/mZ29jBgYjW
         I/GHRNtZ/mIG+NKyztQw0UvQ1R/ZcJlYKFBUSTmtI4u4MjT1H+fleuCVBXlhbgiowk
         nwn/5xYH5cXEonXtjwL8ymq5Uw75WHb9DwAWMcbk4ei42nWnWlx76wEICxvMronpgR
         EseLnIBrujRhXTrjSX3V/nip65fYUBqNNEzTaSwf+Bx5Sj+fwrb
Date:   Fri, 25 Jan 2019 02:19:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
Message-ID: <20190125021950.GV423984@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
References: <20190124164654.1923-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ubBGeysJ7fFOU9Y9"
Content-Disposition: inline
In-Reply-To: <20190124164654.1923-1-newren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-1-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ubBGeysJ7fFOU9Y9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 08:46:54AM -0800, Elijah Newren wrote:
> The critical part of the patch is the few line change to
> show_raw_diff(), the rest is plumbing to set that up.
>=20
> This patch was based out of Peff's suggestion[1] to fix diff-tree to
> do what I needed rather than bending fast-export to cover my usecase;
> I've been running with a hacky version of this patch for a while and
> finally cleaned it up.
>=20
> [1] https://public-inbox.org/git/20181114071454.GB19904@sigill.intra.peff=
=2Enet/
>=20
> As an alternative, I considered perhaps trying to sell it as a bugfix
> (how often do people use -M, -c, and --raw together and have renames
> in merge commits -- can I just change the format to include the old
> names), but was worried that since diff-tree is plumbing and that the
> format was documented to not include original filename(s), that I'd be
> breaking backward compatibility in an important way for someone and
> thus opted for a new flag to get the behavior I needed.
>=20
> I did struggle a bit to come up with a name for the option; if others
> have better suggestions, I'm happy to switch.

Maybe --all-names? You should definitely let other people chime in on
this as well; it should be obvious by now that I'm no expert on naming
things.

> Range-diff:
> 1:  29e9ddf532 =3D 1:  29e9ddf532 log,diff-tree: add --combined-with-path=
s options for merges with renames
>=20
>  Documentation/diff-format.txt      | 23 +++++++++++++---
>  Documentation/git-diff-tree.txt    |  9 +++++--
>  Documentation/rev-list-options.txt |  5 ++++
>  combine-diff.c                     | 42 ++++++++++++++++++++++++++----
>  diff.h                             |  1 +
>  revision.c                         |  7 +++++
>  revision.h                         |  1 +
>  7 files changed, 78 insertions(+), 10 deletions(-)

I think it might be nice to see a test for this option so that we avoid
breaking it in the future. I'm also curious how this works with -z, and
a test for that would be interesting as well (as well as illustrative of
the format). For example, is it still unambiguous for machine parsing,
even with oddly named files?
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ubBGeysJ7fFOU9Y9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlxKckUACgkQv1NdgR9S
9os1/RAAg/v7qLWUzETEmPElTrTV/ra7n+zk2mjzdHqQn+wCxtujmAfs55l0pL1Z
ZmG1ZJdoa6FznFlz0p70WR1K4iUfgOhDvSqTL5ACm1D8EitRNLvqSu8hm5KSF32g
nOOz5f3ROjWmJFQNygWkapq2VVft+lh2pTVn9nzkpATMy8zRMAowyS7X6v9NuUtI
L7cuj3CCjBWKOTjpo+dQI8ZvT4lmsf40hhFl85+SiGEfdN5FlqaLoNiFSTIkiXXK
z4hcu+91piu/rCFWnahBxxKFIt+dxtDOwOBDCKIknNMYh6KhvnUbZ7UEdhfXhbXL
7CyP2G81x+uc/RRwPtGfMcBRx1NvJkwWE0NTS/9okSueZ/JhBaFBxiSUPkI/n6Y9
D/z4xS5jJ/nJwO7as3rMSknFk0qWPSmDMKdicvgWYeHOX4Rd9+/ip35vBekGyZO+
Pez7qrhLPOJUNCfxdbFjfFHt1x4ERWA+B8PReqOMGSMLYCEP+VkHHwBjJ8ZhVet7
GNuIBQu+ZnS7JNAe0JawSH//VnG57dKoV/tTwoAzNHx1KgYX9J9O/Iy48N/jcl32
lLVaqlo4iO1kRIeMrq+YAa3D1zC0pAnBS32Aom1ro/xWvGxZBuHM5/tiKgLWbZJI
y4l2KNfGZ962N3b3onrjgsk+gEGBWdG6SsxzXZS9ZaCjc/B5bC4=
=Fclo
-----END PGP SIGNATURE-----

--ubBGeysJ7fFOU9Y9--
