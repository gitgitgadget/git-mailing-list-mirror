Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB94C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 01:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223EF2075A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 01:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O09OO7c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgHGBdI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 21:33:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41418 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgHGBdH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Aug 2020 21:33:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5E39860129;
        Fri,  7 Aug 2020 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596763956;
        bh=O9CUvbvBRmusfbNEn0KOfhvKovKMoX+H0xIXt62MEXM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=O09OO7c+UVk02oUf/5+akb8SP1KJd8U8Hs/mi95DQUYsokroyW/fyv3ziNZ2nL+4T
         0mdo4UXFpLZe+ylRJhyNAFVepM+UWvbGP0do/2yMKnrGHVlYXMB7Q3FFP2aBzSUKu8
         eNITYenptL/p/8NSVr0/dSrMaxS++2caY2fG6WfLXgC1/4xLSV1rjo96k80hUg9yJY
         t+2cNkZVFFwFNN1w5NNrXjsQLd48mU0YUcuaghIIr3JD32o5HWfB8gck2h2XWgAHTA
         O+KwlYqGgqcfroXh0pTfZnpUTLVoAl5WMtwnH9eGdTXyN688ESNhv4q4bDdLXVSPtf
         584g9XeRThB7gAKsCehEqRzHaI7gK5C96JS0rLLaEZrsTrIJGNARvuC17a4tlHG5Pp
         Hl8KlSHlTIjvvBGOUYNSwgVH895xD3L5ZDh/cZIlliUjaUhBK029wrL31Lw6cOGsOF
         DFIFQIcUscYGGThHgb6aUf7leC7yNg+Jd6cNvIYx5oTntld6N8B
Date:   Fri, 7 Aug 2020 01:32:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
Message-ID: <20200807013230.GD8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
 <20200807000126.GC8085@camp.crustytoothpaste.net>
 <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
In-Reply-To: <xmqqpn83i9sk.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-07 at 00:23:07, Junio C Hamano wrote:
> While this guarantees that no unneeded code is generated, it also
> discards type and other checks on these parameters, e.g. a new code
> written with the argv-array API (diff_args is of type "struct
> argv_array" that has .argc and .argv members):
>=20
>     precompose_argv(diff_args.argc, diff_args.argv);
>=20
> must be updated to use "struct strvec diff_args" with .nr and .v
> members, like so:
>=20
>     precompose_argv(diff_args.nr, diff_args.v);
>=20
> after the argv-array API has been updated to the strvec API.
> However, the "no oop" C preprocessor macro is too aggressive to

Maybe "no op" or no-op?

> discard what is unused, and did not catch such a call that was left
> unconverted.
>=20
> Using a "static inline" function whose body is a no-op should still
> result in the same binary with decent compilers yet catch such a
> reference to a missing field or passing a value of a wrong type.
>=20
> While at it, I notice that precompute_str() has never been used
> anywhere in the code, since it was introduced at 76759c7d (git on
> Mac OS and precomposed unicode, 2012-07-08).  Instead of turning it
> into a static inline, just remove it.

Great.  I was wondering about that when I looked at the patch.  If we're
not using it, no point in keeping it.  I think the name should be
"precompose_str", though.

> ---
>  git-compat-util.h | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 5637114b8d..7a0fb7a045 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -252,8 +252,10 @@ typedef unsigned long uintptr_t;
>  #ifdef PRECOMPOSE_UNICODE
>  #include "compat/precompose_utf8.h"
>  #else
> -#define precompose_str(in,i_nfd2nfc)
> -#define precompose_argv(c,v)
> +static inline void precompose_argv(int argc, const char **argv)
> +{
> +	; /* nothing */
> +}
>  #define probe_utf8_pathname_composition()
>  #endif
> =20
> @@ -270,7 +272,9 @@ struct itimerval {
>  #endif
> =20
>  #ifdef NO_SETITIMER
> -#define setitimer(which,value,ovalue)
> +static inline int setitimer(int which, const struct itimerval *value, st=
ruct itimerval *newvalue) {

The rest of the patch looks fine, but do we know that these structs will
exist if NO_SETITIMER is defined?  If not, we may need to use a void *
here, which would provide us worse type checking, but would work on
platforms that lack the interval timers at all, such as NonStop.

That does kind of defeat the purpose of this patch, but I still think
it's a win, since we end up with some type checking, even if it's not
perfect, and almost every platform provides setitimer, so any errors
will be caught quickly.
--=20
brian m. carlson: Houston, Texas, US

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyyvLgAKCRB8DEliiIei
gSUeAP0SGQU/5WhF82JcqskUdTJfXgH4qgqhsmo3tSE0yVc3ewD/fAJ8E254GeEQ
A9+kdOuXM1809IRmiaN80ozRV2UQowI=
=9HTo
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
