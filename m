Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 394721F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 11:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389628AbeKPWIv (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 17:08:51 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54892 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389624AbeKPWIv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Nov 2018 17:08:51 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:941b:b2ff:ecfe:7f28])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0956C60B16;
        Fri, 16 Nov 2018 11:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1542369405;
        bh=iwjOOXDyrrm3v1s4JD/ikOZp9SaAoLqN3KLpP5l6V88=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Z/BNyp/8sWLJdUd06tv4kG+1QTXlXVd9x+YgpYtjlkqef/yGwU6JNA2XAETVqePvw
         50GrYwSEAojPtfoOIHTL2jVeN9rRFej5QpNZ6oHMpDXuaOUYOov0sVzhhyXVwgKwvj
         RoFsHVxhQhZeVqBmwCpa3PUCeiJeS4NG5tC4pWVkc7JLun/sDXjZ7wWPh89TJJsrA9
         TnTcZ+BpjIBm+6G9ZqDiuEgsXP+GiQ3Dgt0M2Uadl7rME+GTZYT44RhlYVWCpzypkH
         lEN3hbzidaydREadFnfKN2IPeWPd7MJ/O/aIqJK8N/uYSVx8C+HLLj/Hu4Xa5WhZ1f
         BNnqzCXnB+iwqxl3qRXusY9NG9Qkoprv9RNahGPDz1mSltt09g1U2RxLry8omu5pUA
         4SbiENnHfJM7cwb0aLCGTq2sw971BONU/fTuM3CwbczzHzJwkLgZg0ut/VCfkDt9Nt
         gstkHS24YQDwnMa2Y6R9l37lNiFHYDqxsboGNioKF+vQl2H2/a5
Date:   Fri, 16 Nov 2018 11:56:39 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
Message-ID: <20181116115639.GO890086@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20181115182826.GB25806@pure.paranoia.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Content-Disposition: inline
In-Reply-To: <20181115182826.GB25806@pure.paranoia.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 15, 2018 at 01:28:26PM -0500, Konstantin Ryabitsev wrote:
> Hi, all:
>=20
> Looks like setting url.insteadOf rules alters the output of
> git-request-pull. I'm not sure that's the intended use of insteadOf,
> which is supposed to replace URLs for local use, not to expose them
> publicly (but I may be wrong). E.g.:
>=20
> $ git request-pull HEAD^ git://foo.example.com/example | grep example
>   git://foo.example.com/example
>=20
> $ git config url.ssh://bar.insteadOf git://foo
>=20
> $ git request-pull HEAD^ git://foo.example.com/example | grep example
>   ssh://bar.example.com/example
>=20
> I think that if we use the "principle of least surprise," insteadOf
> rules shouldn't be applied for git-request-pull URLs.

I'd like to point out a different use that may change your view.  I have
an insteadOf alias, gh:, that points to GitHub.  Performing the rewrite
is definitely the right thing to do, since other users may not have my
alias available.

I agree that in your case, a rewrite seems less appropriate, but I think
we should only skip the rewrite if the value already matches a valid
URL.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.10 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlvusHcACgkQv1NdgR9S
9otwmRAAzszKIoT+4DbaIca2H3q+/+9NQK9YWNGhX19/68mJ/Am1LAMJA7rvmGGX
LBzI/J2ADfz79oF1pxoZxgQb1r21ltia4c9fT+PNj1cXKT+dnIDzT/V0OEJeW2QL
dRc160p4rK91CmFAneNDCyUrGGuL/vJHH5WAgcXb9noEYElieDJvEJcaF0tLWGwH
43roZynV79ZwOlJB6JTII2BfogoUbON08HcC6YLoWhFOfY56ktXJHySZzfFneTcJ
s7KZe403TwcajA41cH/eDKP0kSsdycUH8pbiS72Sv4Mzc2mtqWXD8oRSkSi7Gnj0
ngxOKQ/50WlHBxVfMEBaROrekjnqMofksYynC2FoUzhKwACWo8kxMrU11dXe38vE
coOw+ZOoqAiWh//zWdg+XeE+8p8k5rJb9tTvrfyLE6Hj5wStjO9sF/5P7+0HtvSs
X6C82td9uV6cwdL6kWme1aUl6BJJQFOYPgkzwbBxNZRkvzijwRpfjdyJ9oWbe8Gf
GKHfuqp9F8iCJXSUh3D8ACiHD1f1JSZAaet2rWnHyRtpCy6hhw4hlcYFFC+2zG0t
rn8c+iCjLoLZAuk+zrIOkMph/3nrALT64aP8iL03OUp8xu7xDzJbFOdn5HetgB3k
iBcf/2g2N8E02poXkqm/00vnDtvjl4zBTG+AxALo6j1pwTh3Eyo=
=RhJm
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
