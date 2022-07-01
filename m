Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C7AC43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 16:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiGAQou (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiGAQot (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 12:44:49 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6F38D9F
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 09:44:47 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E1EC75A491;
        Fri,  1 Jul 2022 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1656693885;
        bh=bhE0s/X605FvaDMkp9+lygRtywFvEzQBkof/cezTRkY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cOt52hXA6RGJgqscJGqFiZyDmNt7J7+mGFt5wriWQkEtdCj82r/kDPx0PIGrqV1PL
         E6bGCreCrzwGQ2CAmic5l1zh7W6l2Rq1v8WEANwjjiHOCQMhB0Kqdz1+2T2GbaGDHO
         9bBnlhuTmTQzJW4tMxZTsGOMZbR8p5I5LUeOhWHEqTS1qECsL7xfD2yfOwoqsMYPSf
         X4dVLEinWh4Yb+37XFaSxYFJATGOCevxCH2DLLDN0pl6cTFDqu4Gihqrd5qAR/0F2x
         y1S/qi1CtG09m/ujKXvLkFnVM8CZ3S1M8GNA4aoaMDZq8KQgtVllHOzb8tgcieZ6vr
         cyYJxWFJCrjBWiOIAMeDpHZ8/89qn4GFMpAa3RSgtlM9lOIwV8ND9ljLHVMysxWqMC
         uY4P2YXITJHLN7VpH+V4KVsS101qGu1tZtT1oZd7xQlJ7hBM0re+43L5AouhX1qfnH
         SObSacuUrNCn7u/iUyt802sb0o8/hxeOT31db8+fmGbsl10PwhV
Date:   Fri, 1 Jul 2022 16:44:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] http: support building on RHEL6
Message-ID: <Yr8kfCqKHwO1QqS6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yjeG9sqYel1B8jAo"
Content-Disposition: inline
In-Reply-To: <pull.1277.git.1656692646303.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yjeG9sqYel1B8jAo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-07-01 at 16:24:06, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>=20
> There was a bug report attached to the copy of 511cfd3bffa (http: add
> custom hostname to IP address resolutions, 2022-05-16) in the `git/git`
> repository on GitHub, claiming that that commit broke the build on
> RedHat Enterprise Linux 6. The most likely explanation is that the
> available cURL version does not support the `CURLOPT_RESOLVE` feature.
>=20
> Let's work around this by warning the user if they configure
> `http.curloptResolve` if compiled against a too-old cURL version.

I don't think it's a good idea to continue to support RHEL 6.  It lost
regular security support in 2020 and I think it's fine and even
preferable to force people to upgrade their OS once every decade.  10
years is, in my view, well beyond the reasonable life span of an OS.

There's no possible way that any Git developer can be expected to
support RHEL 6 because it has no publicly available security support[0] and
we can't expect developers to run or use insecure OSes at all.  It's
also irresponsible of us to enable people to use such an OS considering
the likelihood of compromise is substantial and the risk compromised
systems pose to the Internet, so I think we should drop this patch.

[0] Yes, there is _extended_ security support until 2024, but that's not
available to people who aren't already RHEL 6 users and it doesn't cover
dependencies such as libcurl or Perl that are required to effectively
use Git.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--yjeG9sqYel1B8jAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.35 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYr8kfAAKCRB8DEliiIei
gc8aAQCad8Zu+EUi+48tIyV2ZIlENqEcf5gA6gaZQL9n1KHh0QEA7T7Eh0G2mX+k
Mlbqv673EsjYI+V2cet94riD4nq+IwY=
=kX+g
-----END PGP SIGNATURE-----

--yjeG9sqYel1B8jAo--
