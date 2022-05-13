Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E77BC433EF
	for <git@archiver.kernel.org>; Sat, 14 May 2022 01:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiENBvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 May 2022 21:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiENBve (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 May 2022 21:51:34 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA383D9DE8
        for <git@vger.kernel.org>; Fri, 13 May 2022 16:54:03 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5691F5A236;
        Fri, 13 May 2022 23:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1652485900;
        bh=CrZV+rDDr0l+QOntsv0Qrv+iY4dw1biQRmpI/yl2ReE=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Czqd7t0fJt+dOrmqtrJ54R/FKH5DDMjdCDs6h1zwcm+EX5fd/232i0I9DKJSoaf3n
         wWjO9AzP/+vxTlYxNr868Bl+OBB8/cwD4uFCwXkAudS3/bEFml1D4BRffMbjbt2D1C
         eCX0GIWKsR0tN51Y4w4AgJYDytQC4LKKQOCZEqxD6PpnGbAqgM7Zatql5WfgVabrfH
         IOFbU3YDSLGSe1bnICD9IpDrZG/vJC6rN4NbbWhwZ5/L0Q7v3qhr2M0Q3HUpNsjfrD
         nYWHhAm2PbdMEpcLyel2CoQ2mwvtPBr2QA0Hq7t1ipf3mGgtzK4RIULx2ZAlK0miG7
         /OsLf3Ke0Jl79WogcfcUqC3F0p1a027oO/KfUDfCu9k/CBa6eX8DIb4PuJM2b4CGvX
         lCkUB2f+ZiFdEUket12e1t57iomYv0rQFbCJbJ9v0JYQaVogDmw9EInnO4H4quVIrm
         bTK2JX6CMc36CqBi3kBWsyz9IFdmcJaqIAAmuIqbgw6O+bSezNe
Date:   Fri, 13 May 2022 23:51:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Simon.Richter@hogyros.de
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] Allow empty user name in HTTP authentication
Message-ID: <Yn7vCg6Rl7TYRw82@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon.Richter@hogyros.de, git@vger.kernel.org
References: <20220513070416.37235-1-Simon.Richter@hogyros.de>
 <20220513070416.37235-4-Simon.Richter@hogyros.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JeYxIyxmRgGytgBI"
Content-Disposition: inline
In-Reply-To: <20220513070416.37235-4-Simon.Richter@hogyros.de>
User-Agent: Mutt/2.2.4 (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JeYxIyxmRgGytgBI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-05-13 at 07:04:16, Simon.Richter@hogyros.de wrote:
> From: Simon Richter <Simon.Richter@hogyros.de>
>=20
> When using a Personal Access Token in Microsoft DevOps server, the userna=
me
> can be empty, so users might expect that pressing return on an username
> prompt will work.

I don't think this is a good idea.  libcurl relies on CURLOPT_USERPWD
being set to enable authentication, and before the appearance of
http.emptyAuth, it was extremely common for Kerberos users to specify an
empty username to get Git to authenticate properly.  I probably still
have some repositories on my system configured that way.

I believe GitHub can also accept an empty username with a PAT, but it
can also accept a dummy (e.g., "token"), which I would hope Azure DevOps
can do as well.  In such a case, the documentation for Azure DevOps
should just be updated to tell people to specify something like "token"
or their username.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--JeYxIyxmRgGytgBI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYn7vCQAKCRB8DEliiIei
gSngAP9Ohd5Az9Cs1IEmlDb+Yq+ZRIamquoZW2pM2JRb3qZeCgEAiRzcNV9Ko9An
WknAERIqL8nEfceqwnLYSx5JYQn3jg0=
=XdFp
-----END PGP SIGNATURE-----

--JeYxIyxmRgGytgBI--
