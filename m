Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A53C433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875BB61105
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhDJBjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:39:53 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58090 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231946AbhDJBjw (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 21:39:52 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE0BF60422;
        Sat, 10 Apr 2021 01:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1618018778;
        bh=LjKwfUJpSI2fxSm5G8OSOOLTavI0ju9nonlwqWHIQDY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZoQoZkxCEtDFlQdyJPpnAFrAnBwQlVJ5yY33OAqJAmToIZohIroENLyZnHHTKc666
         JK/Khnac3RkUYdTbpnVn37y5ZEoKEsm8O10suKA7HolpD6fhwbrtw4WgK9GcjzjKSM
         HqtCojhAuIaRNuhJ+briHdF/KIGNWFX/0IeG18282gFx9T6Iw/t6Zjl1a2x3AlHmqZ
         EmV06Fm+LE3SVibz4GPdv/J8Su63zPD2K4R+rkadBXu8MK3+HSLIlVQvt0Rlo+HGgX
         YYxL9U/orK11BHdqTeNmM4PqetaXO0Lz7o9PoyJPE5pE0K6n1hI4MfYTBpwzsRoHun
         8ks9x/JEj10sgeqnFL3eUvAnklcDaMfD7VL6oq3JqR/YDIWkU9UHFBz5qGIAENeFTB
         ang6DHBl+vuVJfgFCmyFFp1Oa+L+pViJSnANgeDpktgeo/qBVIA+rkP3k9YcCDmv+U
         w/w7IfmJAtCrOITdewTKvudq0MwRLmQ21jY3GQ1dxIx4+EiSf62
Date:   Sat, 10 Apr 2021 01:39:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
Message-ID: <YHEB1ClofnD6nQWA@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
References: <20210409211812.3869-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IByV8tnY2AvBobjL"
Content-Disposition: inline
In-Reply-To: <20210409211812.3869-1-sir@cmpwn.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--IByV8tnY2AvBobjL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-04-09 at 21:18:12, Drew DeVault wrote:
> The present options are misleading; "ssl" enables generic, "modern" SSL
> support, which could use either SSL or TLS; and "tls" enables the
> SMTP-specific (and deprecated) STARTTLS protocol.
>=20
> This changes the canonical config options to "ssl/tls" and "starttls",
> updates the docs to explain the options in more detail, and updates
> git-send-email to accept either form.
> ---
>  Documentation/git-send-email.txt | 11 ++++++++---
>  git-send-email.perl              |  4 ++--
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 93708aefea..3597935e41 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -168,9 +168,14 @@ Sending
>  	unspecified, choosing the envelope sender is left to your MTA.
> =20
>  --smtp-encryption=3D<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> -	`sendemail.smtpEncryption`.
> +	Specify the encryption to use, either 'ssl/tls' or 'starttls', whichever
> +	is recommended by your email service provider.  SSL/TLS is typically
> +	used on port 465 and is preferred if available.  STARTTLS is typically
> +	used on port 25 or 587. Any other value reverts to plain SMTP.  The
> +	default is the value of `sendemail.smtpEncryption`.
> ++
> +For legacy reasons, 'ssl' is accepted for 'ssl/tls' and 'tls' is accepte=
d for
> +'starttls'.

I definitely approve of describing the two options.  Even just saying
that one option is tunneled and one is actually STARTTLS would be an
improvement here without the additional options.  Apparently I managed
to figure it out, but I'm not sure if that's because I use STARTTLS or
because I would logically prefer the more modern TLS over SSL just by
looking at the names.

Since I agree that "ssl/tls" may be a bit confusing, maybe we could call
that option "wrapped" or "tunneled"?  Other names are possible, of
course.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--IByV8tnY2AvBobjL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.27 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYHEB1AAKCRB8DEliiIei
gUCEAP9wZA6WOxFWoOrD/R4QNDC/1MREaoIbFMNHovxbL5PZpQD/bKQR0ZSZR8x9
69/VjN1yExZ3MUl0oYz8JhQ9KjZrcA0=
=ICTw
-----END PGP SIGNATURE-----

--IByV8tnY2AvBobjL--
