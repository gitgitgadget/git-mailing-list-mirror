Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A2EC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B017D61B44
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 23:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbhKQXEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 18:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235956AbhKQXEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 18:04:36 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD2C061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 15:01:36 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 308875B482;
        Wed, 17 Nov 2021 23:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1637190095;
        bh=W6T+py7v28SZrZTIesc9txi5gxMLKfnxK9xgJQLrNqo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZOWo10rFWThl0P/FK26JcRVCx8VWS83NJlZ/frnskRGUYs8N4PLb3W4Q0oFwzyIif
         2SBMS3smnzep+DuHfUqnH7k3lwDp7SLU6/dePJw/vWFjNlnuPZ1iP4HK55k7eQDVfB
         gFqQCnVGl51ZQEYFnumSjn/7tS0V/j+wHMUez6NRcmoh/G1glaFManTaxJV9WX5U5n
         C6hDYaI8T45oBxmqf3T38O6f5zX5UhwEuBrSZVC1QaQ+kG/RpbzUv27FRPvUv8uxGs
         OShudIkRUFaDYKUnvcdv9JERu4ZcWvimU3T88EiOzcjEbsWwXMce6oqr3Bxz0cyB2b
         3XAw0YLjk6ZYMd/IRJM/ffwTinbfZaCmbHcwqWVAzsYHVKZj8DSSjSP6Ka2VRFwj9s
         tzyhozWzY/sVMiIIAMflmz8023WaGfBRe/DNbVUkO/zu1B3JalhNGNprq1yR4PsVnq
         QcDDasIKNSKsha4MYlBLadNazRW9edhcnexgiS5G6l+MmjaHS7X
Date:   Wed, 17 Nov 2021 23:01:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Message-ID: <YZWJy16Emrkr6qVL@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-2-sandals@crustytoothpaste.net>
 <xmqq1r3f5izn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t0D8WcXRGr/xbAac"
Content-Disposition: inline
In-Reply-To: <xmqq1r3f5izn.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--t0D8WcXRGr/xbAac
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-11-17 at 07:39:08, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > Finally, add a self-test option here to make sure that our buffer
> > handling is correct and we aren't truncating data.  We simply read 64
> > KiB and then make sure we've seen each byte.  The probability of this
> > test failing spuriously is less than 10^-100.
>=20
> I saw that 10^-100 math in the other message, and have no problem
> with that, but I am not sure how such a test makes "sure that our
> buffer handling is correct and we aren't truncating data."  If you
> thought you are generate 64kiB of random bytes but a bug caused you
> to actually use 32kiB of random bytes with 32kiB of other garbage,
> wouldn't you still have enough entropy left that you would be likely
> to paint all 256 buckets?

True, but our code processes smaller chunks at a time, which means that
theoretically we'd notice before then.  For example, getentropy(2) won't
process chunks larger than 256 bytes.

If we don't think there's value, I can just remove it.

> I also agree with Peff's comment about making these look as if many
> of them can be specified at once, when only one of them would
> actually be in effect.  Giving one Makefile macro that the builder
> can set to a single value would be much less confusing.

I can use one Makefile macro, sure.  I think we'll still need multiple
macros for the actual C code because we can't really do a string
comparison in the C preprocessor.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--t0D8WcXRGr/xbAac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYZWJywAKCRB8DEliiIei
ga2rAP9/TmoRmRU5CR/H558ANArJXd8RBt0wTVy6SchxB7xY5wD+PFAT4Try2QyV
5wu8xDShFeTyvOm0yVJTBMQi1+ctYgQ=
=ABzy
-----END PGP SIGNATURE-----

--t0D8WcXRGr/xbAac--
