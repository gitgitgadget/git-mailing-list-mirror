Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15EC20958
	for <e@80x24.org>; Wed, 29 Mar 2017 23:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932996AbdC2XV7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 19:21:59 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58926 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753026AbdC2XV6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Mar 2017 19:21:58 -0400
Received: from genre.crustytoothpaste.net (unknown [172.16.2.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 1A3B4280AD;
        Wed, 29 Mar 2017 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490829716;
        bh=jsw0JVL5X30deqJApSATe+f0qSLtVw1DGu0FdNcUo/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6/9b4r0tTvRE9CCv2S6VdFkK1XUBnoTzcityWklukKadf+XoNNOe7tZVh21l7TX6
         QGx+6tQDMDOjkXCNf4D8tQ7eQLZZ1IGpb9U345eoEl/NSaAyYv512jmMcZg8HByAUA
         OyzKxcsM2qmwB9AgqLrXCd+Hf/ScsQfrrmNcVTWWaOkpYnDbK38vqHopksqpQqDokY
         6/LVyCNL5mvS/Hzk1d0hAZYO/dSfSG9htIo51ZzL7Rf7gG2sTXKSsSX0B2NkMczV4n
         IKVTxiPwgG7ceGepwyA5Q1ncfKhNTmRvgIonKF+VV7dkZarvx5a7B6Lf4IF9c8GTtO
         mP2rDn/MvoADilZN33ngGHQcnBAc26rDxQ54M2LgSsjV+mVDhvKkOTDHaTJtlXXvtz
         b1QzScSSkV4xagDRJJRiJDWm5VDzT54FVlj+OieO1PO+Q7+IagjxWhgbXQNgIoaE0Z
         BLyuoSv1W5vJoPx6vg0HGEhlDTW9Czf6WZ7a5/jJ0CqO2G4qmBJ
Date:   Wed, 29 Mar 2017 23:21:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/21] builtin/receive-pack: convert portions to
 struct object_id
Message-ID: <20170329232152.lpz3biuk6eq43ftb@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170326160143.769630-1-sandals@crustytoothpaste.net>
 <20170326160143.769630-8-sandals@crustytoothpaste.net>
 <20170328070712.p2o7wziysy7n2vxk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ba5j6atkkup7ykz"
Content-Disposition: inline
In-Reply-To: <20170328070712.p2o7wziysy7n2vxk@sigill.intra.peff.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5ba5j6atkkup7ykz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 03:07:12AM -0400, Jeff King wrote:
> It took me a while to find it. This is the switch from "len =3D=3D 48" to
> "len > 8" when matching "shallow" lines. I think this makes sense.
>=20
> > Note that in queue_command we are guaranteed to have a NUL-terminated
> > buffer or at least one byte of overflow that we can safely read, so the
> > linelen check can be elided.  We would die in such a case, but not read
> > invalid memory.
>=20
> I think linelen is always just strlen(line). Since the queue_command
> function no longer cares about it, perhaps we can just omit it?

I've just looked at this to put in a fix, and I don't agree.  We are
guaranteed that we'll have overflow, but linelen can point to a newline,
not just a NUL, so it isn't always strlen(line).  This is the case in
queue_commands_from_cert.

We do use this value, in computing the reflen value, so I think it's
better to keep it for now.  I agree that a future refactor could convert
it to be NUL-terminated, but I'd rather not make that change here.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--5ba5j6atkkup7ykz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljcQZAACgkQv1NdgR9S
9otZ9A//eUqFjBZZXS+yOT+xTDrLaCMDLDCXf3IMN8OLNRZ1marSMTyrV/9RUisE
DDIUf/Nq/bU1GvnJTULpzWxE0vQB9p9GRtEASV5A1TRuyL3gDzNxjnVYBacio+yd
CzudX6DZXCzE3RhrmAmARYPulaggBPSxSoE3OSDcETEaE9fZfxJfMLTHeFiTw18W
OfEhbiXGQcGF0LDwptMwBnOCs9cAh+arcSU1OzANq5SAhIYT4d/dHmKmQxrdJAu2
9zxqYvNhHP/DaJGnorAmSb4GampB2VPEC55ynFpopJAydcaPjYZAb9RCU1SiCdOJ
M55HGHWtPGriIUQW/ARotujNlsbfON0YZm3TJhrlEJceF2ZVHyXtj8NefWERzC8x
noy9JBntoPvKolhv/29FD0NZZARzOgnTD/RvAaQ8TGt/2kI+iC/TDTG17UoBlaIY
syCV3rFjV1VlGUKDaHgEoQZrL1baSCR5qtjEBB1hS9JSp18B+sn4xJisELnCkb/1
5xsoPsonceA2/N9S0hmlaw4CEUlHBBHH4hhwYGDSpw8Ivz6rPjXn27/D9c2+gS5N
Tgekq1MvAbmhiRKiCo1GAJkArHloAQJYLwo9Hm2MZtpgIDFzvqpD7DN3yGqRkJi5
+9KtCbBfgR1TPmexDms1kmf/j/h0DN0DV5aoZMAc6IKcWIDtCzQ=
=tdl8
-----END PGP SIGNATURE-----

--5ba5j6atkkup7ykz--
