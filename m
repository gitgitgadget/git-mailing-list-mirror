Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5749CC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 21:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJTVWi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 17:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJTVWd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 17:22:33 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7282207513
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 14:22:31 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B71FE5A1FE;
        Thu, 20 Oct 2022 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1666300950;
        bh=uZ9GQJkmtv2EtYY76tdf1HZxjXq54TsTwtXylu8LSo4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ZoMwTMy+hdwx1jfWTQR8zVVBXzl7cl4v1T21yTMbLNMXVoB9M2DRfF8Z+tGoK74Gs
         pXlPH6/37jIGNO3WBvrt9+epq38zE6W93byZq5nR8WV7Aclw2yoKqoyYGWeX5Tsgw1
         39Imt02kePiTfVS8J2w1hSL4W9E9+3j1MlRLmx5GRt+AaXSB26XaTvb03xGRWVIVZv
         vuZFs4F+j+OY7PeSs1HA3RYIVBFcy/1Lj325BaK+L288pdN3n1gJAt6jpLwfMavcok
         0InVV0n6SFhVlyr2exFfwdvkw+a9+KR++nFMoMI9eW3NDbRw+OQW/a2GgkryRPrEQP
         0Te8UHu0Z8h9l21ZqoM085NXSL75buUcqvZKvZ6/0GpfeY0VEtEGXLcdeP4U5cA6NF
         y2yrO0bjLX+hk85Sdm5wj6WIa+7gVcN5oU1dDmiAbzl5CtIy1DZE0dSoO19xXQda+M
         R0wXr1rtXyX8UdpXx4YwhP+2cQ2C3/whNTgB1lZxslw/s6ivmHa
Date:   Thu, 20 Oct 2022 21:22:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <Y1G8FKzHF4GJCaan@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>, git@vger.kernel.org
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9GoIZlQZyxXRFeg9"
Content-Disposition: inline
In-Reply-To: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--9GoIZlQZyxXRFeg9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-20 at 04:26:49, Mat=C4=9Bj Cepl wrote:
> Hello,
>=20
> did anybody even think about %subj%? Is there some effort somewhere making
> git-send-email(1) supporting transfer of signed commits, where I could jo=
in?
> I like hosting sites like sr.ht, which support git-send-email(1), but
> unfortunately using that clears my submission off its GPG signatures. I
> guess, it would be necessary to make some modifications to git-send-email=
(1)
> and git-am(1). Is there some effort somewhere in that direction?

There's been discussion about this in the past on the list.  I am
personally in favour of a solution which allows us to preserve the
committer and signature information in headers in the patch and apply
that to synthesize a complete commit.

I know many people who work on a patch-based workflow _don't_ want to
resynthesize the entire commit and would prefer to keep the current
approach, which I also think is fine.  However, there are situations
where end-to-end provenance is useful and so is email, and I think it's
worth supporting.

It is on my ever growing backlog of projects I'd like to implement but I
don't have any immediate plans to do so.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--9GoIZlQZyxXRFeg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY1G8FAAKCRB8DEliiIei
gfHsAP4o8VUBDZGXYiUkHNEcfEzbFzZ5+A334W8r+q/uwxCApgD7BC5GD9zSx+HC
Co77XkeOnKuhfVHEsvAShDEmZvyyFQ8=
=4GLm
-----END PGP SIGNATURE-----

--9GoIZlQZyxXRFeg9--
