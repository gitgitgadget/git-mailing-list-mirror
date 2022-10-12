Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D26AC433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 21:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJLV13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 17:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJLV11 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 17:27:27 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02291D73FF
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 14:27:26 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 26B195A399;
        Wed, 12 Oct 2022 21:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665610046;
        bh=/Bh4bZS+yk9ShzrFEy9T1Cp9wuz1L9OxddBApyZBVyo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=IWrpnx+Mq7q4KKAN8L4E/unID1LKjfyxherOyP8BAqIhgvCXzaZf9vTY3ONQfqMwX
         yP0A6ODbb/Y9Eczk4rjryKQlKm+K2fNFzs/P/nAKL9o4iiYfvSfgkQQwrca4hHqw+j
         tUM6N0rCoyueJgTqD9F2Uk8PkH/Ru+aVq0oREbQ6WthGr85OUO9tyyPH6wgP9dz5Mk
         7i1qnUvqlrzH5bfEiCqZlxOIC23h41XvNaZvcr/AScZFKGetoWtgcW8X5kt60e7q2R
         wM6amEqVz6HeIBPHJbKoeJbx1B61hq8pxIIl3jkgG5dBtE/YwAyOmySbNiijxMn6r7
         3DZk4XvBpr+BnG3iUbC5HC4XKkS0ObD7LEMIOiFTu8wog/uicjPmwDogwLFt8zeKzH
         JoSQ33bUix49Tva3AjhuneSAjeFcvMaZYQP7iChPHk0ZlkOVIJzNyrZI0NA63j6/vh
         a4BdW3jh5PBNzk2M8+U6D6cOWVX878NdQ3H1eiCv9OXL4FTK9mH
Date:   Wed, 12 Oct 2022 21:27:24 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     sndanailov@wired4ever.net
Cc:     git@vger.kernel.org, gitster@pobox.com, aaron@schrab.com,
        philipoakley@iee.email
Subject: Re: [PATCH v3] docs: git-send-email: difference between ssl and tls
 smtp-encryption
Message-ID: <Y0cxPHNZjTqZR5XE@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        sndanailov@wired4ever.net, git@vger.kernel.org, gitster@pobox.com,
        aaron@schrab.com, philipoakley@iee.email
References: <20221012150619.12877-1-sndanailov@wired4ever.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9bsosD660wmvRJLI"
Content-Disposition: inline
In-Reply-To: <20221012150619.12877-1-sndanailov@wired4ever.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9bsosD660wmvRJLI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-12 at 15:06:19, sndanailov@wired4ever.net wrote:
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index 3290043053..765b2df853 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -178,9 +178,18 @@ Sending
>  	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
> =20
>  --smtp-encryption=3D<encryption>::
> -	Specify the encryption to use, either 'ssl' or 'tls'.  Any other
> -	value reverts to plain SMTP.  Default is the value of
> -	`sendemail.smtpEncryption`.
> +	Specify in what way encrypting begins for the SMTP connection.
> +	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
> +	(unencrypted) SMTP, which defaults to port 25.
> +	Despite the names, both values will use the same newer version of TLS,
> +	but for historic reasons have these names. 'ssl' refers to "implicit"
> +	encryption (sometimes called SMTPS), that uses port 465 by default.
> +	'tls' refers to "explicit" encryption (often known as STARTTLS),
> +	that uses port 25 by default. Other ports might be used by the SMTP
> +	server, which are not the default. Commonly found alternative port for
> +	'tls' and unencrypted is 587. You need to check your provider's
> +	documentation or your server configuration to make sure
> +	for your own case. Default is the value of `sendemail.smtpEncryption`.

I'm happy with this as it stands.  Thanks for taking my suggestions and
sending a patch to improve the docs.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9bsosD660wmvRJLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0cxPAAKCRB8DEliiIei
gcapAQCqAU6/L1XYVGi4rGQ7T76oVd0pO5+m0gdOaBa4uFj63gEA/fUKMrUDb016
8tdl3GfyM280DsqJKpQRUCwWNreG+A4=
=473x
-----END PGP SIGNATURE-----

--9bsosD660wmvRJLI--
