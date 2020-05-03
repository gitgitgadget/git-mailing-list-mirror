Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D0CC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF220757
	for <git@archiver.kernel.org>; Sun,  3 May 2020 16:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="AwrGD5Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgECQ2F (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 12:28:05 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37888 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728002AbgECQ2F (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 12:28:05 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 494936044D;
        Sun,  3 May 2020 16:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1588523283;
        bh=A+6/KcKZteFXq3gQfZ7kqvFyk9nzIMI734HCyECwKP8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=AwrGD5Eva3DDdUIQJQPhWHApDjGPEfy2X6jdgX0bJvxBs9hZI38MzjKpdg74NTexo
         gdnozOkd6c0HIFVHkd6lLbhzH86ZwHEJWE7M/EwO2Si4/huzwXk0SxylApE7JJHZa4
         gb7QDrRo6OWcpfN4ML/yLZPftdYU/izYT53Gbqag0wK5ukvxcdqWjqaTbVpD+BiJlJ
         MTJMdC0ZmlAzBQdhlZpAKOJm9RUiWakzRKSr0blvveU5lJZJopvitwJWQji2SeHshG
         LXlQ8Yldz8M/99biIjYo12XQ/yU1eHu7Ig1b950+KNbsL45yKY/3b/3uKdKGGI4CU+
         EVX0sqcbKYYgUt8JgvANWTEnAmz9i3vbQMBiwCJ5gF9ytSt4J+4b2CFrhzDeiWg7gB
         IuTB+AMfRTNcEA+6Qf7PofW8N6v04rG5ou8ZwxT0ocIgE+pV/k4/t4gRrebSw3yAwW
         ErQNRKFJ8vXjEiYvqhA8ZCsjxzdr1UPnTWJHR/Sfvw01aAZJ9Mj
Date:   Sun, 3 May 2020 16:27:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] send-email: Defines smtpPassCmd config option
Message-ID: <20200503162757.GE6530@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        Leonardo Bras <leobras.c@gmail.com>, git@vger.kernel.org,
        Jan Viktorin <viktorin@rehivetech.com>,
        Michal Nazarewicz <mina86@mina86.com>
References: <20200501105131.297457-1-leobras.c@gmail.com>
 <20200501125308.GE33264@Carlos-MBP>
 <xmqqees3odrb.fsf@gitster.c.googlers.com>
 <20200501222723.GF41612@syl.local>
 <20200501235948.GD6530@camp.crustytoothpaste.net>
 <20200503094348.GE170902@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <20200503094348.GE170902@coredump.intra.peff.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.6.0-trunk-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-03 at 09:43:48, Jeff King wrote:
> On Fri, May 01, 2020 at 11:59:48PM +0000, brian m. carlson wrote:
>=20
> > I think perhaps many folks aren't aware that you can invoke Git with an
> > arbitrary shell command as "credential.helper", which of course makes
> > life a lot easier.  So if you want to invoke a separate command, it's
> > really as easy as this:
> >=20
> >   git config credential.smtp://smtp.crustytoothpaste.net.helper \
> >     '!f() { echo username=3Dmy-username; echo "password=3D$(my-password=
-command)"; }; f'
> >=20
> > So I think that documenting the use of the credential helper is step 1,
> > because probably most people _do_ want to use that for their passwords,
> > and then documenting that credential helpers can be arbitrary shell
> > commands that speak the protocol is step 2, so that people who don't can
> > figure out a way to do what they want.
> >=20
> > I'll send some patches later which document the latter feature, since I
> > don't think we mention it anywhere outside of the FAQ.  I actually
> > didn't know about it until Peff mentioned it to me one time.
>=20
> This is documented, but only recently did it make it out of
> Documentation/technical/ and into gitcredentials(7). I don't mind adding
> more pointers, though.

Ah, yes, I remembered that series, but forgot that it introduced
documentation for that.

I'll just send a patch that updates the config option to mention the
other cases, since we already document it in gitcredentials(7).
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCXq7xDAAKCRB8DEliiIei
gashAQCIRQutnQCWhp9Az6owbh5HoVBOxYCa+r0MNgi/U3uv4QD+JFMI+yKVh1zK
nHN5BJ/KpAqlPwmfB2+3sA9qw2x8Lg0=
=QRKY
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
