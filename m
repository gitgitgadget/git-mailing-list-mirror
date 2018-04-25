Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEA01F404
	for <e@80x24.org>; Wed, 25 Apr 2018 06:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750945AbeDYG6y (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 02:58:54 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46360 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeDYG6x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 02:58:53 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id E29FE335C2C
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 06:58:52 +0000 (UTC)
Received: (qmail 5712 invoked by uid 10000); 25 Apr 2018 06:58:51 -0000
Date:   Wed, 25 Apr 2018 06:58:51 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180425T065446-231760424Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7jIye1Ygp5H0AIi"
Content-Disposition: inline
In-Reply-To: <20180413170129.15310-1-mgorny@gentoo.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e7jIye1Ygp5H0AIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 13, 2018 at 07:01:29PM +0200, Micha=C5=82 G=C3=B3rny wrote:
> --- a/entry.c
> +++ b/entry.c
> @@ -411,6 +411,7 @@ int checkout_entry(struct cache_entry *ce,
>  {
>  	static struct strbuf path =3D STRBUF_INIT;
>  	struct stat st;
> +	int ret;
> =20
>  	if (topath)
>  		return write_entry(ce, topath, state, 1);
mgorny: Should the topath case trigger utime as well?

Other questions:
- Would there be be any value in hoisting the utime change into
  write_entry's finish block rather than having it in checkout_entry?
- Should mtimes on directories be set if the directory is explicitly
  created?
- Maybe using futimens on supported platforms?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--e7jIye1Ygp5H0AIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlrgJypfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsS47Q//SX9zDYObtPq1ynnIEhDBO9VlkgKYr5i5K/ZOVVDK/nfqDwuQRGRjvW6A
3yzGC3il29v3lZwn4Ha9hNdXk4G3IvkE27OaXGZGF/WJglx+Jb2pbWXghFqPoPx8
UgUNr7Smb1gT0OZpA4OTZYYGs1+oBenbXO0WVikb2Ei+UMXVhAUy57BH+Dk6Jst0
XqmVhy/7b8tQbpBG5Ge70gl8PijnHkVH6VBGqQKbD+73w5PQ1UD0jsjZ+uzl/1cU
Ut32hrA11x7hqClLPZ3/N+YxG0jjHtrrzmCRY/qqA3ARVOfyUT9nZve/QDM6qPXO
fbMxBKSHKuqb/yTUfcWsN4UFRqgcd1FvvXxMJTE5dxJa5SCBFR2typrquTv1RsVs
yI2pUD1V32QdwKuhpMJrNLZ+OQXX86ImO6aBcCjt1QsRETsN7UlCEDNGZImjJDtj
pdLpBIPiF6IAiuzbVzdIOrjdLLl2YSHJDeENLurOEGFyD0+Sf6Go924LuAa3WXex
xG+8HyS0TKl7hbV3pbOEqnnE7RO/QFUaS69nTOXYl8ZVceqly6ZvAZOvEHJnuQgu
zqLntxQz16RqoOk3EahsIHLhdNSrjBHr9B2Mg3ZebZET6ZwjcNX13NAMzqwDGcHp
r8uzp9yeWV1uXvFTjFLPW9bGuXC24vub2VFcITP8CyDkBCeEPXE=
=aX3j
-----END PGP SIGNATURE-----

--e7jIye1Ygp5H0AIi--
