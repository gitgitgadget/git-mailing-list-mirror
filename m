Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D3CC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 02:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbhLGCWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 21:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240696AbhLGCWf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 21:22:35 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B87DC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 18:19:06 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0EC8B5CB78;
        Tue,  7 Dec 2021 02:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1638843545;
        bh=BdPTvlmUxkyuzUH57ujjhmCHLlebc4VSwkgdTB5qQnY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vcFr/dZyrIJ/jrHXk2LsQegfL9g1jnLYNsIwavejxTuq/3r53m8zyYm1DKsPSgnv8
         h5uvaBXhiELwc4lYu6nZb2ayeXF9NHZNKz8BwrfXeXazFCew3RjNZkQ3et6mbVg+CB
         RRT89hxfogd7ULtU9FCj/DOPjT3FQH2lcZkhBbCoE/jUZ6HDu70dnSORuozUKf2GAo
         zTZ+HSAJyYOpfJx48mO3A22Xqyt6ZUxX2mW6tfNifcrxAYlvtOOfSXzOyBskAZH02M
         QreUzuwyDDfbZMu/VvRrMDYpmg2rEhuXLdk2D4QexMXaAMT+Fv4FIjMKqrE5dZYWGm
         ld6ukQS0gY02GBOa7OfkunY+l9PF34GcCTWUNs6BjMnGRS0+e9UybQCdUyO7iSW09c
         0jB1r8Dz2TrDTPmrb/45RKCQ/bjOapFh1mx/c4qyLr79OKOj+MxHb+moBV89kx9gWN
         5tYS0LnQWIIsOEvUYHAubL0wP23LQCjLTPgSfJMbU78xy+pz/Nq
Date:   Tue, 7 Dec 2021 02:19:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
Subject: Re: Regression in 8d92fb292706 ("dir: replace exponential algorithm
 with a linear one")
Message-ID: <Ya7ElLg96aV2iySI@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        =?utf-8?B?QmrDtnJuIEzDpHNzaWc=?= <b.laessig@pengutronix.de>
References: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bBevHwCQpf5S85mh"
Content-Disposition: inline
In-Reply-To: <20211206121639.o4a4tdzlijnhnjqz@pengutronix.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bBevHwCQpf5S85mh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-12-06 at 12:16:39, Uwe Kleine-K=C3=B6nig wrote:
> Is this something that needs fixing?

I don't think so.  The old behavior was to add a file that's under a
different repository (subdir), which is bizarre and at least to me,
unexpected.  I believe the new behavior causes us to not add the file
because it belongs to a different repo, which seems correct.

I have no clue how we could practically check out the file in the first
situation if subdir remains a git repository.  Even if it does work, it
is likely to lead to confusing behavior when the index for subdir is not
in sync with the index for the main repo.

If I'm missing something here, though, please do point it out.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--bBevHwCQpf5S85mh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYa7EkwAKCRB8DEliiIei
gYgHAP9ewX995kPGbqlZZXxZpJZHrxPnlAs0zfoWcdut7TVhcQD8D7LBtbain/sR
8nSLnLj4sNS9PKMotMCwVGBGTIdoXwg=
=V9q7
-----END PGP SIGNATURE-----

--bBevHwCQpf5S85mh--
