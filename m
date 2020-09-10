Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8987DC433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E0820882
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 23:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIJXDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 19:03:30 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57264 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725275AbgIJXD1 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Sep 2020 19:03:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 4A91860489;
        Thu, 10 Sep 2020 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599779002;
        bh=NMttmdGPra3JX9eDJUH0ROjr5KJerzTXDAPHfHKfS08=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NfBBQMK3sk4CG/MQ92/Y39siD9bBVXXdgbuKAcv++TT7/OlhaXc1QUV/PuER9UC+6
         ayEGd/eE5fMPWtBYYYwZ1MIhmWO5Z6AOSkBtzgYnsiGygEWps5oXzh6ON90TyAwg56
         6RZf1AfSmb7dTHW3K5bdbvxwa8Ftzrcx7j2X2pKJxg84suP6i57jGRSS94P2aiKh+h
         dGTgF89G6GrnTjkXlKdWPobHB9SZJa4j9FE+QlZGHUqC8w437SlRGgBQAOqyNxOEL+
         i55qFhQZTI5TlfXsB4zqWt25rls3bLLVqiuJ1WSLW/3aFBD1Foy2peMBCvQSFUnRot
         PwU/y+t1ywwCsjp3iyNcjfYzpBS4uqWT0sc5FnukWbLYzeIUPGx6ETfsEsvMnwnkHk
         A+ue0rK9mHnVWdEpb1XPYuhOglMhjcmLax5YTqkI1Fq8/44pe0ZqnhvSKr89xRvrFT
         gXnLUYqI+WgaYT30IDnOuc4GZSandMpjoqEuUsaoV2FafyphhN9
Date:   Thu, 10 Sep 2020 23:03:17 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 0/7] quote_path() clean-ups
Message-ID: <20200910230317.GK241078@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
Content-Disposition: inline
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-10 at 17:01:52, Junio C Hamano wrote:
> Here is an update, after seeing Peff's review.
>=20
> The overall structure of the series stays the same.
>=20
>  * The second patch lost an incorrect use of 'flags' parameter down
>    to quote_c_style_counted() from quote_path().  In the function
>    declaration of quote_path(), the flags parameter is now named.
>=20
>  * The third patch that moves the "optionally quote path with SP in
>    it" logic to quote_path() is essentialy unchanged.
>=20
>  * But the fourth patch rewrites the implementation to avoid
>    shifting the output bytes with insertstr().
>=20
>  * The fifth patch (formerly the fourth) that teachs "status --short"
>    to consistently quote hasn't changed, except that we test also
>    for the ignored paths.
>=20
>  * The last two patches are unchanged.  They are optional clean-ups
>    that are not required.
>=20
> We might want to add a bit more tests for:
>=20
>  - how conflicted "funny" paths are shown.
>=20
>  - how doubly funny paths (those that quote_c_style_counted() needs
>    to use backslash quoting *and* that contain SP) are shown.
>=20
> but I'd say that is outside the scope of this round.  Seeing what is
> done in t3300, the latter test cannot be written portably as far as
> I can tell.

I took a look and this seems like a great improvement.  Thanks for
picking up where my patch left off.
--=20
brian m. carlson: Houston, Texas, US

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX1qwtAAKCRB8DEliiIei
gUFEAP9vPYquuML5djjfW1LH1zp7nBJAJXUJfOwm1PGUgWuT5wEAxb1IqWmGVgN1
07WJxBX8ZPEdefhmnbcRZcKgMrpVrQ8=
=KGfD
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
