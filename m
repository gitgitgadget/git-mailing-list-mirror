Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ABA81F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfHQQkm (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:40:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57678 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbfHQQkm (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 17 Aug 2019 12:40:42 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:81dd:eb9b:e758:604b])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 065D6605B2;
        Sat, 17 Aug 2019 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1566060040;
        bh=IYTheovzxPMqd3YuqbxSuHHSNGX/a8PKmNNoy83TouU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=gdyhqtz3ZCEZqPanzgJ3zJ4d8BkpOHJ3SOh3a9KpC5aaXXg6UcVDDW09A/nCu/5Cm
         0jxTXeCE+vlcG1LYn1YM4DxJ3jB6wOloF+8c5HyTWsXtKCufJMMcfzUoH+AC6YJCsP
         SBr/ok7H3xh10UrW0guvSXCDTOh3BLYniKbgyiQfKaYINW9ZQaohzmclOPtPOCPYTh
         6EM0AwOCa9j68PeMZPP49KybGBcHMst09CLjDIYqCNfCc/37FQFo/fTqLzJarBLGWf
         yhmWthoRZUyMXyiB971vynFbng72YZGUPPmuy1iCu4yJPmB4R6lDrTYxKECkirG195
         8ZUJYl+wvepvyJYf7kdB6tfKVCKC6GhEOXl2+K9ybxfzVuQ7Qvqt4WAB6frxwE2myY
         z31IhssS6zEcrIo+No0N6QviytcD+qb7M4q3Oq5PWHB8kL50yNOVgdgg9FpPKf+9FR
         p1T/hHJZlO2t7TXAyDm2bB34zPllgMBGoVpSLme60I3qTLgwnoJ
Date:   Sat, 17 Aug 2019 16:40:36 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] fix pax extended header length calculation
Message-ID: <20190817164014.GE365197@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 5.2.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-17 at 16:19:29, Ren=C3=A9 Scharfe wrote:
> The code for building pax extended headers has been miscalculating
> lengths slightly shorter than powers of 10  since I wrote it in 2006.
> That affects entries for paths with a length of 990, 991, 9989, 9990,
> 9991, 99988 etc. and link targets 4 characters shorter.  Here's a
> series for fixing it.

This series looked good to me. I'm don't completely understand our
technique for computing the length, but the additional tests build my
confidence and your explanation makes sense.

As a side note, I have personally found computing the length of pax
headers to be enormously difficult due to this very edge case, so I'm
not surprised this bug crept in.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1YLgMACgkQv1NdgR9S
9ou+Nw/9GWJuQgPHdYNH19aa12rtsd7+DwR0A/oGr8v7b85PKSYRv90KBWcRAzJE
9sUvPc2Q6IjS9DyWdOXLITExoRZcFyAQIrJM8AwJUlMXY8xrE30f0Xo58/VZPuoW
YNXS/+I+V+EDTphRscFQtYnRiBGc1mqF90Kcl7U3NjpWTnwotte4vvi25PFZUYfy
r4poDbJAIIcjnWdmNDcQYrUiC9wNmALwv1ZDLcX90z/3BRGXbRFvp6iVw3L6bAtr
e3ClgQZt0h/yNsCclXRNL92qYML5cjMRDODR8jjvE3t7RLdk5Rpvd721OqRrGUR5
Px2boZopubteUBOwtL7cuSo65EUNjQxz3cBTJ20+4Ka2v+pIAqPfeT311N2DuAMo
/hnF2JRJPbMp1Ojr2hllNVJvsQfrUDvCIWA8ndQZasXBUBlodm2w7YnGiyQLaSM+
keqnyH5yY8e3T0Q14rpI5g+1LIWXDMY4LPJBQMD9cvQNiJDy4jvAlvC/OkR5OrYk
eVzAvFZNP0tojWhlko6s2CeuNZOuNGMAsbBEG62vFKKCehkt28XThxP6SjiUhzbr
ihc2WF38uQ2EmtrfdmVJt4nILPlq9w9bloFSZVDPWiNK/QSkDYxLq58LpSdr4z44
zaSJnr8a2rcontkRyWan294cOLdHyBbnHDMlJvZOQJqyA0p6UCU=
=FvkL
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
