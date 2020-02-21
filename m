Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E0DC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEFD222C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="edHlVD0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgBUABs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:01:48 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37584 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729234AbgBUABs (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 20 Feb 2020 19:01:48 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D008A60797;
        Fri, 21 Feb 2020 00:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1582243307;
        bh=wBveg/zFKN5tGemJ3HPxnD4ONRQQP5vQtduok3y567A=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=edHlVD0wfwqfplwSc0h7gKoWv5Utsw7mGJdd0qYoxe2GyLmadkuGNX5nSbpTVgZBU
         ghXlCxQEIAlaG4gd/zswC2Y83rbHYwvTt5jAI+6kSeauFzrLH6kRXa0h4rmwNdUtg7
         nTqTKvotqzoN9XdNRyd2pF68u7svsKe9GtSj7b49LY5feRISdfA9BskMXBIhPhYqo/
         kLFvIM4VkK5qtYchdjjeoostCdSWpcsPQ3hoPcEguYdcuRTrOe5kXXW5xddUp5x7Pa
         8uVe/nm1s6X8bWtfljJSfUwztccZlkblOast6+KPvCJlOr5nDo/1AP4w+QFNeruaag
         BdzHY6Cw/wgmE1KgSm65RJX7W49CCvH6bZv6AtTyqZs5+O3Sv8E0s7zaNYdCeicXpu
         BIgHBMAPdr9nnic+uEKOQJ8ojDcI9ZYQZyyOtKNSHwxxMzp/W2/8+TrvmlRUepbJXB
         1FOYkoWYfJhrmjFM4Y3GtplS/WBGdyoxDPPFa2SbXU6UqnuSQpW
Date:   Fri, 21 Feb 2020 00:01:41 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git does not wait on hook exes (^C)
Message-ID: <20200221000141.GA6462@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
References: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <CA+dzEB=jJEkuvcX5qDfeXS=mbJu_m=-yUsmHd_KrKAXC3YDe7w@mail.gmail.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.4.0-4-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-02-20 at 21:14:55, Anthony Sottile wrote:
> Here's a small example:
>=20
> ```bash
> #!/usr/bin/env bash
> foo() {
>     echo zzz part 2
>     sleep 1
>     echo exiting now
> }
> trap foo SIGINT
>=20
> echo zzz part 1
> sleep 10
> ```
>=20
> ```console
> $ git --version
> git version 2.25.GIT
> $ git commit --allow-empty -m foo
> zzz part 1
> ^Czzz part 2
>=20
> $ exiting now
> ```
>=20
> - I pressed ^C during the first sleep
> - control was returned back to my terminal
> - the hook script was still running in the background

I believe the way that SIGINT works on a terminal is that it sends the
signal to all processes in the foreground process group.  So my guess of
what's happening here is that Git and your script both get SIGINT, Git
cleans up and exits quickly, leaving your script running.

If so, I'm not sure that Git can do much here.  If Git waited for the
hook to exit, then a broken or hung hook would cause Git to hang
indefinitely, which is not what the user intended when they pressed
Ctrl-C.  Usually what the user wants is an immediate return to the
terminal in such a case, and I think most users would consider it a bug
if Git were to wait for its children.

Certainly I'm open to hearing other views on this, though.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl5PHeQACgkQv1NdgR9S
9otkUw/+IlxpCVl2b7fiEby6FZh57OxZKwhyROMP0XVolRQjusaMTOUCXCYGNV+R
nxrImDqRR6gZ29uNqaz0oTT+bdg41D9Q8r+OqIlZ5B135dCup5EVSC/QuqZ2yvFm
h3dMYZoRNEovELCwMZxCcF32LQBStSZe6/35tFdmcrErvL87ks1MGjx8ZNmzSXIY
LrzHoHDS4CFNL92dx5tF8X7r08QJq+SvVvqADan4+l/togUfLOS99WYGmkcLrK+8
dZT4O914pe7cwsgiNR2GGubAaBCuIMTddo4897vVY6FbnKghPXJ0OlLjxiSBkbEL
WMGSVlYhB9TelT2EmIDtOJoRaIVU7tu3e27Udd1vJPyX+8w0jmNfmRRxOJDenux/
w8qhr6pf9KdO4GYPmbhmaZWaKrI0exJN6beb5tymOLaKVi99UiLvxh7gi9BfU0cy
zDkqh7p65j3YzFQS7QpPH3PkcNUg/RVNzwM/5z1tBIpwBa23bixFXKYv/hw+glN2
VMpfluD6p7BTjnilFZ+j+4/CbQTcEC4R9Hz56rhBhEzwfSt6RWfTP6K8Hlqc6Fk1
kBEusbmFdw5rlLPQ63KR9Z4vBb5EUIQlz80qVyWI9kJm/6v1PJ3IqLTpbqYo6HJd
gZOSV7oQwT2JfGnyENhL11+93yLKHDYJxVgNmxOBgeSjpTYy+xQ=
=O5DN
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
