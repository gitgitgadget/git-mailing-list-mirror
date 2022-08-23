Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB7C28D13
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 00:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbiHWAv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 20:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiHWAv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 20:51:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737CB40BE4
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 17:51:25 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A027B5A26C;
        Tue, 23 Aug 2022 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1661215884;
        bh=sOuIJjeDih5/5a9mclGuV0ytfJl5qVTScrI4rwBx+uw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=La6JTBye1V1TIVZY+CC1Jydge0X02aLiNVinxNGmhzpI7uiB7xc1N35pvK4kx1Elk
         JKbIpdEI23GX9jh57A4kcDA1Lud88tizjEwskm8Z2YTper2JmKpVnDjTkp2HuKw62t
         bKxWoJ5cdoXdI+MZiBALNjTqTWmjmPGUbMvj6PWulAIzZ587Y32OsodxOcwk7CtR8J
         FsTNIU1e1eIm9+VyIUCST2iPHkYbc4myawqGVqU4X8h0oBjO9cN8V65FQ+6mDZlclx
         kh95+5yiQgEgvtapv3reFyNH4L3kAC25yhvTly/nOwG4UGpHecfBIhMcUkt2cPOFeq
         AaupDorViphSEvjs+H/wNa3pBCGoSMewroYZsrRmucmzy+GqZuMl1yzJuRMXNDSemj
         dptfCX0cHagYnW5NJ3bmqfOsvfW9bkd9Ru8PrfIPqVuzb2P+k1lXCwSmHlFRXCQ3Gg
         X6a6NEjL6vMigqsDJ0tkB0w3nZrYjtEZTip1ZYIFERMt8N4888P
Date:   Tue, 23 Aug 2022 00:51:23 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tim Hockin <thockin@google.com>, git@vger.kernel.org
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
Message-ID: <YwQki4nAEOp4wvv9@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, Tim Hockin <thockin@google.com>,
        git@vger.kernel.org
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
 <xmqq8rniikrg.fsf@gitster.g>
 <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
 <xmqq4jy6igb2.fsf@gitster.g>
 <CAO_RewaZHL34WBaoXVyXh6ZNVuG+fi5uGUbpRMsc9N=orHzx1Q@mail.gmail.com>
 <xmqqzgfyh0vj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uzgHsEqpaRe/VT/w"
Content-Disposition: inline
In-Reply-To: <xmqqzgfyh0vj.fsf@gitster.g>
User-Agent: Mutt/2.2.6 (2022-06-05)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uzgHsEqpaRe/VT/w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-08-21 at 00:54:40, Junio C Hamano wrote:
> Tim Hockin <thockin@google.com> writes:
>=20
> > Sorry, I assumed it was clear, but that was dumb of me.
> >
> > I have a string - might be a tag name, might be a branch name, might
> > be a SHA (complete or partial).  I want to resolve that into a
> > canonical SHA.
>=20
> "git rev-parse --verify string" would insist that 'string' is an
> object name and show it as an object name to the standard output, or
> gives an error message and exits with a non-zero status.

Note that this will print a full hex object ID whether it exists in the
repo or not if one is given (for example, the all-zeros object ID).  If
you want to verify that the object exists, write this:

git rev-parse --verify string^{object}
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--uzgHsEqpaRe/VT/w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYwQkiwAKCRB8DEliiIei
gQppAQDMtleNPxVOIn2KzEx6WkObQanlXEZQo6tG0rOzq3YPfQEArWCOc4XZ2Bv/
iHAjjkwkx9jFa0sq1kBov6Mn1+OlZgM=
=7hG7
-----END PGP SIGNATURE-----

--uzgHsEqpaRe/VT/w--
