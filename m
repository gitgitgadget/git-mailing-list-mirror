Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090DA20437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbdJLLCG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:02:06 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54942 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752169AbdJLLCF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 07:02:05 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 790FF6042F;
        Thu, 12 Oct 2017 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507806124;
        bh=L6XKsNdJJfBcqqs73sFvGLtQVXQyh/RNyADGGv0GjmM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=H6zVJRMtF/MLs2EjrQptZr2C7p38Akm43iUeEEH+utlAW+5/rSQsexNA3ib1vN28e
         /HBG5ftS1dGO0ocL+XB72+sXwVGGMEEpugNFhp1cHyTG/6Y7tLscoA+sUYmF2uQ/9W
         wHCfGUpRTK6g49xLgyBE/gs548GnrGeo51yzq3GTP+nzI48t9+aWEi808txZjgZ9I+
         BrmTXPpl+hpQS4bUmIQGnMbrR4bbNVVYAHDkbK/N0Ult1aFMOSefhMQ+LpZdf2NsT6
         0BvkKmDCSFgD8LLOsLrrdGSRfHPlSFx2BPqCsfxIYfleZvzAF8cHuVXmeGdBQPbv8f
         /RgO13hl7w26sKFZcB4/7nLjhfN2pGkITKJ4dKC99a6Wgi14B5D8Sgyl7rIMneC1vk
         Wbh+g5u1YyBLkZlNZavYnTIzOOJLhu9Pnbrvyat6I+ESJnuhhSVjlJPrjnU6IaXCeW
         s/Vr4RFlFwS0I4frxIPctJJpDAEj3d5EA9hqRJy181HEjBgslt7
Date:   Thu, 12 Oct 2017 11:01:58 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: git repack leaks disk space on ENOSPC
Message-ID: <20171012110158.pxjn6ckgw6z2g3md@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Krey <a.krey@gmx.de>, Jonathan Nieder <jrnieder@gmail.com>,
        Git Users <git@vger.kernel.org>
References: <20171011150546.GC32090@inner.h.apk.li>
 <20171012031702.GB155740@aiede.mtv.corp.google.com>
 <20171012093439.GD32090@inner.h.apk.li>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2jrphqfnk73klrh"
Content-Disposition: inline
In-Reply-To: <20171012093439.GD32090@inner.h.apk.li>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--l2jrphqfnk73klrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2017 at 11:34:39AM +0200, Andreas Krey wrote:
> On Wed, 11 Oct 2017 20:17:03 +0000, Jonathan Nieder wrote:
> > Does using create_tempfile there seem like a good path forward to you?
> > Would you be interested in working on it (either writing a patch with
> > such a fix or a test in t/ to make sure it keeps working)?
>=20
> I will look into creating a patch (thanks for the pointers),
> but I don't see how to make a testcase for this - pre-filling the
> disk doesn't sound like a good idea. Most people probably won't run in
> this situation, and then won't have tmp_packs with a dozen GBytes each
> lying around.

A patch would be very welcome.  We have this problem not infrequently at
work with development and test VMs, which tend to have a relatively
small amount of disk.

If you decide that you don't want to create a patch, I'll probably pick
it up eventually.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--l2jrphqfnk73klrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.1 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlnfS6YACgkQv1NdgR9S
9ouClhAAoPfnx+Ms14ZgXDHyDRfYhWBhGfBiBvP8/rXssS+hB1UvPBPkU7kVlt/w
/aY8ik7i2Wp1B3v8T7m3y4LLd2zCwc6jIYz+NolgViWF8GEC4PwoSrbkzsx+oHhT
ZpDluSSsE46eHoYWhdCM2pOHMtBYMzggX7BerEjhnCtRN2aMh/uFUOSPDvKOmNR8
dP0dWOkGqwywnWQPI8VzaXSJKQEhuJtdOkFCV229u+0YOecYGZjQMYrYHr9UQD8w
KDAQlsHEH7j2S4un7uk7gyETTOxUx+JmPiqRuUK4LJQH4b33Gn06QtNKaAgKW1ou
xRN7UkiPSYMsBvKOLJwjr7ngwa2nEtpBssjUHn60XzV8wCYGN1ABFF6Nnsmp1y+3
wJQlvM9nOc4f7HMagcImK2HDhB43h4yRf2e7cyAMrX5by4iSrnvZJ0PZAEkiMkZc
fS9GCXsw8j86s06/A8e0bVv77tJiXTvhQJHEgvQUREzjPeQeWcrNymfhMt3H0TJ2
lbUKhywcfqAAV6oA/hNBPPoSU7d0e/xXadFaJFMedjnzunUUCgvpVtxrq7SlQJto
vOrafYYS7XZNF6uz5fM+w9MVzkDGbTBarvb9PySe6D2xHxaJQI+T8Zo06f9yEqK+
YROGq5uGjMuNNDUJq2DRtmF5s9ElAG5+8ohm/StENytbBTOuIgg=
=WJi5
-----END PGP SIGNATURE-----

--l2jrphqfnk73klrh--
