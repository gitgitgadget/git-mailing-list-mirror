Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB5C35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 22:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6674820708
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 22:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lT48eShU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgAYWnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:43:41 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:46772 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgAYWnk (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Jan 2020 17:43:40 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 3EFA2609C5;
        Sat, 25 Jan 2020 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1579992219;
        bh=/IYTIEr94hUMpc1XPfvdxGZS750g+qjoa41y7IuUZ74=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=lT48eShUk7qhVVzi2p7NlnnW8JiNH7PdXf93m6yzkS5gANVuzuWmL2SSuFwOifV4q
         /EMUMDvfcLPwwyVYlyWc7hmhQmAl2pwqkOO49NMvLdp/EKnSCSp0rtn7MgtW7aEPNT
         MSLP1JXEJ4GBjheg0aVWLm5WPvjpQcSNKEEiMXP3XvG3o6oe15rJgc4m0WBG2T3ACe
         X23X8T0iruz0h38nXGVUh4hfitszpF41Wfc44Iu4hTvZB9Cixr2w44nzweXqgeAm7Y
         qyRkgY/LMmiwC/06z09jQeF6zMefA9XnH+wOP8GUrM2bi9Wz3+x3HO3ML8Qx1jrBU/
         7VF6m713AXwmiqw1aPmjedIX7JPE6Py0ejhBUvKN79Oj0NNHgOUS+TSY88182hoRYH
         C8u/SXKBMAGyEnI2VAViEAUwII6T3l+BkrwYBG/v5yJ0qSrdkBNN7DGrsoP2TgrDU2
         YApcKmOqIbNhJL+FFmsSwzpOdS2+JKfaSXYstc86OPhA0VOTqX7
Date:   Sat, 25 Jan 2020 22:43:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t5616: make robust to delta base change
Message-ID: <20200125224328.GC4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <20200113123857.3684632-19-sandals@crustytoothpaste.net>
 <20200113202823.228062-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200113202823.228062-1-jonathantanmy@google.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-13 at 20:28:23, Jonathan Tan wrote:
> Commit 6462d5eb9a ("fetch: remove fetch_if_missing=3D0", 2019-11-08)
> contains a test that relies on having to lazily fetch the delta base of
> a blob, but assumes that the tree being fetched (as part of the test) is
> sent as a non-delta object. This assumption may not hold in the future;
> for example, a change in the length of the object hash might result in
> the tree being sent as a delta instead.
>=20
> Make the test more robust by relying on having to lazily fetch the delta
> base of the tree instead, and by making no assumptions on whether the
> blobs are sent as delta or non-delta.
>=20
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Junio, I think this patch may not have gotten picked up.  It fixes my
problem with SHA-256 and makes the test more robust, and it didn't
appear that anyone else had objections to it, so I think it may be
ready.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4sxJAACgkQv1NdgR9S
9otccw/9FGSVdf9T+H4EBKN1pYl5qM1uqf1wJSiy1lG7m89yOqyRoyJ86WmtMEt5
cLT6Sp3SOvK3tkq3Qzo0mit8vafn/SHCELf6OoQWh1PZrvAyXJ5xOp1h6vZ+ooU4
BpDGTtcdd7RdJcgguobjG2o3ajCez7Phwj7aRZMAOCVfUD6zlckDhbDtqYJDHayn
BYlbLqdDU3f0lQs2d2hUeNzyQZHYNyYe2unU+v8/sIzMFcPNjWmLSrLxlSk8oAE5
EfMY+SxEHHjbY5z7oWwonBL/LLB3p6dOKTCRVDNy6v3mkvLR97VZePCIQt0E2fb/
3vRGmrA0x13HaD+9+LziiHkDwtb8J/cvB75vdg481zcf0J++6Hk2CXbQpTImjGW4
g0rgmlMU7Tan6hZH8dQfrjBvAmg+oXW9fSpTc8iiiq/HzGA2UKGG3SQMox5W9VPI
wfNbUP/n50TyCAIi5AGD/azvb60zXU7yYie3nsmJXmq7Y//fSYxNkcpNMqSFCDBb
1UR1WlLXEI9yW24CgtSeA9xQVMdPlHd4DB1X5Rf5WXHD4b6i3YvY8TqGmCfimeFS
cAfW4Cb6L3cy9bRb7QuUTLJtLoL0cyS/RDs3llHqGznPsPcCwaRfhez9OXflc9gh
5IHGlRiG0XeKYWSLh4VTq6DBcdauqGG0ZR7s/ScK7RZV3S8c8BY=
=kSNl
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
