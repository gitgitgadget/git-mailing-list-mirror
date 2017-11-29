Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27F220954
	for <e@80x24.org>; Wed, 29 Nov 2017 01:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbdK2BfZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 20:35:25 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56228 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751623AbdK2BfY (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2017 20:35:24 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 02E376046D;
        Wed, 29 Nov 2017 01:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1511919323;
        bh=BM3d/06Ap8ACj/p458N/0l+5G7QaUkdrGX5Msa613n4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=CLQxnoRm9Z3uxP/3bu7sUfjPZIx359nJQ2wOedRNL+7uOR4ODlRJzSkNVR5733q0y
         T5fs64XzW+8Zqw/VPEKr2CS35t2g6knwMUofVRFjBZ+Awx37KA6/upYUMGdGye/R6T
         VX/HNceyTtTJZ52NM4Jtig9+E1TXK0O6kKSDpaj+ePaMqLr5cR6jO5UxXRYjwnJTW7
         pYDalnu+svDKpFkam7HCQDcKC97QDwIC23SwRdToJvPQAVPE4DMY9/2YrWgGLANH2s
         AU61zZ+RiF+rwD3V2ZJBiDcDpIILKAfc5B+IHoJ/wcCIB9hL6Jm9fyxn9jMr6XHrR/
         JY+kLLcqDhXU6axOwZcWXXzpkOFA/XazyBDnoecVoZXemc9PV8B6ysglDxcu6ZTYFC
         Aa84q6pa6GmIy6bhsX2SSROkPpdQe0x5hDouhdXJXLX8ElPbt6kS1jGeBbnD0gzgGl
         zKD089qlob5+38pwlbQ+ah5xJeY16iB2ZgMqSaaOpS1zcKFsmeb
Date:   Wed, 29 Nov 2017 01:35:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] repository: fix a sparse 'using integer as NULL pointer'
 warning
Message-ID: <20171129013518.GB598034@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 03:01:19AM +0000, Ramsay Jones wrote:
>=20
> Commit 78a6766802 ("Integrate hash algorithm support with repo setup",
> 2017-11-12) added a 'const struct git_hash_algo *hash_algo' field to the
> repository structure, without modifying the initializer of the 'the_repo'
> variable. This does not actually introduce a bug, since the '0' initializ=
er
> for the 'ignore_env:1' bit-field is interpreted as a NULL pointer (hence
> the warning), and the final field (now with no initializer) receives a
> default '0'.
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Junio,
>=20
> I don't recall Brian doing a re-roll of the 'bc/hash-algo' branch[1], but
> now that it has been merged into the 'next' branch, sparse is barking on
> that branch too. This patch (slightly different to the last one) applies
> on top of 'next'.

Thanks for the patch; it's obviously correct.  I'll get sparse set up
for future patch series.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloeDtUACgkQv1NdgR9S
9otr8hAA0K7K9+z4otT55/ZSnG5jdSS93ULxAFdtfPIIPRrofCyk+q6oUfoM8qGK
QHxN7YH9w1YhPrWZUdGiBpTae/J7hrF80bRI1SKT7oPw7Zj41vkk/WJakN2yijf8
SyqSns9262oLXwQG74+OfNkcCaQqBR2Deon3zt6+f+YqX6rWW+uf+uJC3z7uU4IY
a1FPfYHrhX5PJlT0Lrp32KkeLBd0Hsq/PVFPXcaCKQnJAiYftKUzFP/2Iz9FCA5/
dYdctIi/jz9z4Qzhqg9TwJe+788vSXAwo/rOymemKuBb92FF7udO+4yLpzPtOMvo
bVzrXLTi0GDu0V/jpNi4RE6YTdfX6UnrTcSAKh4L/tmAxH9OLziSUnpQRO8pQvJL
ZRZOtsHcm/ZKcV1rP43SgddarVvi6UsmmNCzM3X068oO7Yn59kqRPwu+LeRcxE00
DmJ110O/MiFJzK/qkC+mx3lotC+QD35cMvpxzNMiUJH6rAPmH87WwcwgM5pJzRKe
D/b8wIPrHItmwlCC+amYQ1dhx4aSvFX/BejCUBkcObzT5z2OFJ2IxSd6euwEn6nh
wpNQVkPsGL+HC8LnJiK+zgMDQcz8Yx8v6AoG6URj8XV0URYT/+jyrl1EuxrLk54L
PCjq/HHnl5Pq8cwa4C6RX3sZbnM4BCYnv+BTQeACRVVADBN4Fqg=
=Y8ve
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
