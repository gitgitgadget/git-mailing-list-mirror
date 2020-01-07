Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDFCC32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF462072C
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 01:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NPR490dJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgAGB7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 20:59:05 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60694 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727326AbgAGB7F (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 20:59:05 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5EDE960482;
        Tue,  7 Jan 2020 01:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1578362343;
        bh=0nl71lOUdVaid6ReFOrQB9PxZm8TYZ0lvgIRTe2mgqo=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NPR490dJyPVl8ySITRnNx6g8d3S1Gm3er9qmFe7CYpG2qk/4kYx5Q4yOfbxVJSSF8
         5/tchY0Zl+/Hr3gcOj3SMuo6TAzduW8p4AQImwQu65V2OdL0cNcCfEN/gfNCpiVbnn
         fdcAjsJHjL/iAft8+fCZyf4Kwg1CYGRUjdlXd89t0gEZdIbwZwt2CwvpboOqBjtjGy
         RNrq/Ok/0BVPt6GiF83RX7QfWqvWwej5m1zvLqHVV6sBjuDssgo2ahvjotQxYZjyK3
         5RIDXp+0+sKU9vpcv4nrUmZ9T+QdQmcX200JDf2YQG1+rnxVrHzjeyakQ5cmKkny3K
         iCmAE6rCKa9wmnxR/F85YndvzpdJIfsTEPbfLxeIh1SYcz7ZGXSEtjA85fN2qm4r30
         sRldISaqBv/CR3ry6OrTAprgmJ6kwixoXuZXR6Hjedp6cJv5bZlqZts1kFWhn4N+Mu
         GMX0ytQ/S46iC+dtTsk58Tlh14KHn4C3ulgLJoYY3OVy1V7JZQj
Date:   Tue, 7 Jan 2020 01:58:59 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>, "Miriam R." <mirucam@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [Outreachy] Return value before or after free()?
Message-ID: <20200107015859.GJ6570@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Miriam R." <mirucam@gmail.com>,
        git <git@vger.kernel.org>
References: <CAN7CjDDBA0ZoCG9aaQf5rg3gxqny=EjR6v6jE1mnxvUJQSF_0Q@mail.gmail.com>
 <20200106213051.GD980197@coredump.intra.peff.net>
 <20200107010809.GH6570@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qo8f1a4rgWw9S/zY"
Content-Disposition: inline
In-Reply-To: <20200107010809.GH6570@camp.crustytoothpaste.net>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Qo8f1a4rgWw9S/zY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-07 at 01:08:09, brian m. carlson wrote:
> Unfortunately, compilers have gotten much more aggressive about assuming
> that undefined behavior never occurs and rewriting code based on that.
> clang is not as bad about doing that, but GCC is very aggressive about
> it.  There are multiple instances where NULL pointer checks have been
> optimized out because the compiler exploited undefined behavior to
> assume a pointer was never NULL.
>=20
> In this case, the only case in which we can safely assume that this
> behavior is acceptable is that r is NULL, in which case C11 tells us
> that "no action occurs" due to the free. So the compiler could just
> optimize this out to a "return 0".  Just because it doesn't now doesn't
> mean we can assume it won't in the future, so we do need to fix this.
>=20
> I'll send a patch.

Oof, I just realized that you had tagged this with "[Outreachy]", which
means that you were probably planning on sending a patch to fix this,
and then I went and did it instead, so let me apologize for doing that.

I sent it because oftentimes we say "we should fix this thing" and then
never do it because nobody sends a patch, but in this case I should have
paid more attention and waited for you to respond and send one instead.

Again, sorry about that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--Qo8f1a4rgWw9S/zY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4T5eIACgkQv1NdgR9S
9ovDHw//Qb4Lr9jp7ORf0upzEwmiHYlIvGqJ40pFHk/HXQPySUQewqnU1uDWvRs8
02aFf/sec8it+BjKpvZMJtJ1VPg7oXHIVEg13jVR02ji07DQ+kgm/VHQzCXVKJOA
qU2BjEMO2yW/fiM4XAZUhfLG60t3vCMOOaEwmoNSdhW1pm8Bhtf4+OE8mADpGKfM
plzhqZU3mCJE6CSrJ+ufbVzTHmTGUNCoF7KWTsrkiKTOVTenZUphqI6vySuHZmOC
3bXNhGwbQp9xgB5vsyCkIRzVv3Z1HL395WK5/gJode4XBH+mqs27raQnrneqH19g
AhQmkO3oHsIezP71q4FRGQHN/XREHUdOhUsWIyKGd92kxa4tNCdNSjI+YxH7sQwF
/Oq9s0J5ZNUXJ+ScIPAahRyNlMJQN5DJY1KzgU6ghLswFvB7zY4KHcjFRhjcq0/8
YYGonuomhY/uOsEJLcUW78Rk7SzS0lG4MPTKdO52XIhI2lVNnTo8hRKC4OxAekh1
tzJa9zUhzpn/mVTIgIcmDamEKrwOtwrGcHnYnoD/SlelIqSq9o3V2vcXbDNdNmQ7
LS5C0ovA6vDXAkfC1fFsVU8SasACB9hGhvarOyIbuEW3+IQuNVNO3n1XP31X06hz
2R3SQalrVD0LotwkYfe8Bd9mXvlaSFs/T9g8mxGHAAHKPrHpiQ8=
=pN1k
-----END PGP SIGNATURE-----

--Qo8f1a4rgWw9S/zY--
