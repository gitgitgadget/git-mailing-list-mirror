Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88846C433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569E064FC8
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 23:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhCJXdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:33:43 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38048 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233980AbhCJXd1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 10 Mar 2021 18:33:27 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7FF0E6048E;
        Wed, 10 Mar 2021 23:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1615419206;
        bh=/Z0jX/XRQk8AWLfnchvKOV7VXWyryvPTLRdztG0C9oQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=XI2UXKmX6ak0AMXSyCZeR7+ZnLTirxS+D/MzWZfscLROUAYRbf8z5ZjbUdNn4W5X3
         K94FpRIMkRQtQXYEBf/ZE3+ekle/ykxzL1ST7YKMZmP1oSoGLQwN5iRKfPJFkV40VG
         WUr/FDKKGCWJOkDawmkcfNUvudce5JoVZ690SMZy3TGDXHGLlU1ovZYDD51wKZFMmy
         pshAauqX+vsf3Q37Qo0DgGlZxwj6fiUcyIM14QvmV/H4/bNXQsx1hqu2fwnwGSsOg5
         zK/ct6ncBLMm8wnSAswYgsB6mZtH2qpAWI87zEJGcpMW2ICwuoGXCFELOJ7ZwbXVwh
         U0JOIR4RcCyy+YUKaadfnYpuBvS9ZgWCJgxTgT5Rc4+BAyH8ZLUDF63O7vsdqaW1X+
         rY51XAWEuFzOuTAqZW5+EhCe39lMVWXp3VjtzFN6LMCAlr6xgIAwK6U5PN2xfHBYnK
         TeegiugqIsBcaeTFL42a08BcrYX+UrvIcH7bggqBa25ABgH9k69
Date:   Wed, 10 Mar 2021 23:33:22 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jvusich@amazon.com,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] builtin/init-db: handle bare clones when core.bare
 set to false
Message-ID: <YElXQhgTFLS61MuF@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jvusich@amazon.com, Eric Sunshine <sunshine@sunshineco.com>
References: <D99DD9AD-54E5-4357-BA50-8B9CAE23084E@amazon.com>
 <20210310011120.1151749-1-sandals@crustytoothpaste.net>
 <xmqq7dmeip1v.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YUJ5SMMuNjCjP6Ic"
Content-Disposition: inline
In-Reply-To: <xmqq7dmeip1v.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YUJ5SMMuNjCjP6Ic
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-03-10 at 23:09:32, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> > index 52e5789fb0..c2b71e78c5 100755
> > --- a/t/t5606-clone-options.sh
> > +++ b/t/t5606-clone-options.sh
> > @@ -104,6 +104,14 @@ test_expect_success 'redirected clone -v does show=
 progress' '
> > =20
> >  '
> > =20
> > +test_expect_success 'clone does not segfault with --bare and core.bare=
=3Dfalse' '
> > +	test_config_global core.bare false &&
> > +	git clone --bare parent clone-bare &&
>=20
> Because "git clone" does so many different things from the normal
> codepath in the "local" codepath, I'd prefer to see this one done
> with the "--no-local" option (or alternatively, we could test both,
> but that may be overkill).

I can reroll with that.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--YUJ5SMMuNjCjP6Ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYElXQgAKCRB8DEliiIei
gRiCAQDqMPexHweVhaeWWJWe2ly6OaLtWCUjufqoQcMM9aoppwEAt3xU0T8m0Nzy
QL/awhiUerO4GOsvHuPVvIhrAb1RuQA=
=mY/U
-----END PGP SIGNATURE-----

--YUJ5SMMuNjCjP6Ic--
