Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2748320357
	for <e@80x24.org>; Fri,  7 Jul 2017 21:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbdGGVWJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 17:22:09 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:55714 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750941AbdGGVWI (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jul 2017 17:22:08 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 26BFB280AD;
        Fri,  7 Jul 2017 21:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499462527;
        bh=hn4+XUOVkQy9yRIxTPt6uqj65HMpS4Nzab2FK9+88kQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROgbXHHl/d1ye0XGtUkgg9m3bzOMVzbdFNt4dq8Ckzp6g6dOwa1FrfhZ6bnZYPUEl
         AXtxjpzclkqIECe9dp8o5rh/ykKpJqRDHFtLHH+nTcodD/owHufjnBC2m2SsETnZpr
         tLe8QtgqtWJo457kEBD+waU1rtjqmpM4BHUzWuvE5xiEB7zUUL9atP3g8Tmu3BKcHe
         VPDqui4Zoz/G+qg1d3s/Vyp5BcQWi7UCkJlJubm7fjdIwE9T7Lk1CfRybFoyQXHK4T
         9rswXRfCF0KlTyRs/pDAD/qLs9wSzx1XgC3OM153iKwA1FLL+pkBRh22EfbjWd4mAZ
         15e4cvaMtvoAkoi9Ypx4vEWTpZEW5K9P3dRjDFGIGCwtQ/pCbWacObb8m0BJp8AOsh
         uCAihr0iUQXHP3QmT3bXBDemXqQZ4vasY4jOUK/+CEhtxBKnWkqvYdSwv5FWCd8pen
         6zB2axej8Z91If98F8SKnY6oja+1gqfuhB0d0HSloA9BOFE//A/
Date:   Fri, 7 Jul 2017 21:22:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 11/12] sha1_name: convert get_sha1* to get_oid*
Message-ID: <20170707212201.ofdgjaips2tw3koy@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
 <20170703185533.51530-12-sandals@crustytoothpaste.net>
 <CAGZ79kYWKUPhfMvg2N+1h6b49d3Bqw_3Moes9XscjkmXAumz8Q@mail.gmail.com>
 <xmqq4luqiv9g.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz35kajygomsxxs5"
Content-Disposition: inline
In-Reply-To: <xmqq4luqiv9g.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rz35kajygomsxxs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 11:38:51AM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>=20
> >> @@ -636,7 +636,7 @@ static int get_sha1_basic(const char *str, int len=
, unsigned char *sha1,
> >>                 int detached;
> >>
> >>                 if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
> >> -                       detached =3D (buf.len =3D=3D 40 && !get_sha1_h=
ex(buf.buf, sha1));
> >> +                       detached =3D (!get_oid_hex(buf.buf, oid));
> >
> > omitting the length check here?
>=20
> Good eyes.  It probably should check with the possible oid lengths.

I'll reroll.  This may have been a bad conflict resolution on my part.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rz35kajygomsxxs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllf+3gACgkQv1NdgR9S
9osphw//VeHUoQp5NwgCQzfLN4r8IRYwOxAJVDfyyZOWAHa7x73CaYsO/2T9ftEk
ujJ16JxyadO2fqVJdSM2+0GeVAxRp2hShRS4yvhm1k8qV3VQNFiMrIcXEjwAk9z7
iotTbfXbv/TdUrUM7uNfRcq/3hYz/8IwmE/LZmhc+pnOjmwf4+eXrW5CO/lZEUK4
pgtXfAduEcH7OZJ3oAhj5urzs48zvSoCPW3L2Tz5wgA97Ub7F5X50hsXgEArH3z9
JEHRf7QxPGzCG6rLU2KqK54ttakdiE/tzaRMeo81X8eiah7a2bQEuryAsAKtI0Yz
k4M2zPhai8t+4BXFMjc59QjNzEKZboqgr8Ou7NITiHA+UvvAe+FQO7i98Y6QrcdB
xFoltGICguQC5l6abwXFB7FDrTHyKQLlbNgKLzlVYfZYw4QEyekYd2JQoIgbgp43
A+nYh+DL0JlYI3AkbcJPEL3ANY8TTgRxWbrAbE/n1xXfjGaUaOS/kScX/5Q2UgDR
BDZGPnf8jgLs3rkoZZ46G8G2ab+dJp7O9DsrC3GLGQE8qQHINJnT4VojWLKQsiiA
ycJGHxfbGQsTYHk8r79nA8Kq/zAv4Ys/LvoeaX0VogiaE4/fMdDSa4gqW2WenV9F
me89n7iCRk4KEAhungmpBKbPYG3c6WIJuwyN1WUqMaVfYN/9lts=
=D4hU
-----END PGP SIGNATURE-----

--rz35kajygomsxxs5--
