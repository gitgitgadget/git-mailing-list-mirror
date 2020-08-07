Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760C5C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 00:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E93A2075A
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 00:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="auyq99Pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHGABg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:01:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41410 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgHGABg (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 6 Aug 2020 20:01:36 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5B4ED60129;
        Fri,  7 Aug 2020 00:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1596758494;
        bh=1g22xEyifFePCccW50EtuL85bPNMUbPMm3gB7tgbcpo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=auyq99PgEzpS1M9Cm4AQZz7p2mi9wdVb9/nHb+FEZKHzr879InfjQzA4inKPYusFA
         7q0M/vsTUTMCucmUR/wAV5xxl2/X3laVtuTYHy2CdMfM79X8iOCI2nXaoP1EvAuepQ
         MphODgg0Sag21bePouri/ZboZSu+mlb8oNjfIqRZtlj04UvtGd/n0uN05WXpmBf/gI
         TKEQ8bxS9khzy1EXJqPOwotcBjKoXEm+m5vesmm7Dyveq3E97vHfOUaNCU4AFl0Xlv
         E5HNHYxSXxm2c5jy1MndFcLswJyPPTEGP+8Ih8nRZfb5Fn5Q8IowRAxXBJNuVfPCt0
         gPdo/z/Smibd7eYwCg5SqtP/muG29suhxj472xgv/U2Qa2kVGdwErDdYeit5GebZPi
         dpkBOuZdNrV1/gYl2mFB7EcDDeHmtcZNLCs+f2ZE8dOmPvduQpKvOo50iX5Hq1BsAy
         358tBHNt07amYruVvJB780g6uUMsQ5srtKsopXZ2y8piq08Ha7z
Date:   Fri, 7 Aug 2020 00:01:26 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: "#define precompose_argv(c,v) /* empty */" is evil
Message-ID: <20200807000126.GC8085@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy2mribft.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZmUaFz6apKcXQszQ"
Content-Disposition: inline
In-Reply-To: <xmqqy2mribft.fsf@gitster.c.googlers.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZmUaFz6apKcXQszQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-06 at 23:47:34, Junio C Hamano wrote:
> I am wondering if it is a good idea to use something like
>=20
>     static inline void precompose_argv(int argc, const char **argv)
>     {
> 	; /* nothing */
>     }
>=20
> instead.  As long as the compiler is reasonable enough, this should
> not result in any code change in the result, except that it would
> still catch wrong arguments, even if these two parameters are unused
> and optimized out.

Yes, this seems like a prudent approach.  I believe it's widely used by
the Linux kernel, so presumably compilers are capable enough to optimize
it out.  As you noted, it provides type checking for all platforms,
which is nice.
--=20
brian m. carlson: Houston, Texas, US

--ZmUaFz6apKcXQszQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXyyZ1gAKCRB8DEliiIei
gU6/AQC0IlIPKKsClXoC0hW0eSMlcuTvSdSyYd7wUpwy0A5JUwD6Aqmktf1LaTtl
VaNpbWY7oHpZnZ+F2doi1TL259+xag0=
=hQ5P
-----END PGP SIGNATURE-----

--ZmUaFz6apKcXQszQ--
