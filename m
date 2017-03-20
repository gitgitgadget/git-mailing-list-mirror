Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0197320958
	for <e@80x24.org>; Mon, 20 Mar 2017 22:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbdCTWe1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 18:34:27 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46696 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753439AbdCTWeZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Mar 2017 18:34:25 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0BABE280AD;
        Mon, 20 Mar 2017 22:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1490049174;
        bh=s1Ao8MYh/4Vse9paveT49kqn07gbbOAyN2IgppeDXvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDowaKg0FsDDZhjRPAxhezOD4n3+AbnEFS6AiyKnQfKw420Y3zmGWLafbFDLHsjxF
         ZXBWg80ZvUrn1I8esbnijbm6EHmQrt38V/MzDQtQVs9IJWXe4hLzsjz607PDfekN4m
         jx55BwXCLpVINuR5awn6LqZcU1/L0lSKZ4F2JEhLbITw3nR2qAZzerOdJmu7RmWZDX
         diS7raUAW61WdSIKQ6z8fWaKhDBV/9LLaXJsLkOTazgtV4gNCqua47M7V1f/7KTCUy
         /t4QQ4FwT2oz/Lr2Q6I9cS7xHQkufPWtZOQK7NpD84RZXMNVKfkbjskH4SaUGJAz4R
         sawgtou19Q/CHhis0PlnFWVvG7vQOjsUFEXyM7Bs8vIgHpgc/QE7vNlUr9rRpYaxT1
         mhSTv0sg/cd/Ww92fKX8VmboVXpK0j1OXXE6rQkY3yEEEAIZZnCC1KFArLmf3nQRIR
         zmLx7sIADzBvXhj4SIOvf4idjZo7E8iICJFFhr+pFlJn/KQlwD6
Date:   Mon, 20 Mar 2017 22:32:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/20] sha1_name: convert struct disambiguate_state to
 object_id
Message-ID: <20170320223250.vyzqyqejxrr4dfp4@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net>
 <20170318211954.564030-11-sandals@crustytoothpaste.net>
 <CACsJy8ACRgcE0SV2qa4bU+QdT7=WMcBRkV=cr4SR-bcXxTMj9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vkmcyenazgcoinny"
Content-Disposition: inline
In-Reply-To: <CACsJy8ACRgcE0SV2qa4bU+QdT7=WMcBRkV=cr4SR-bcXxTMj9Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vkmcyenazgcoinny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2017 at 08:07:09PM +0700, Duy Nguyen wrote:
> On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > @@ -332,7 +332,7 @@ static int init_object_disambiguation(const char *n=
ame, int len,
> >                 ds->hex_pfx[i] =3D c;
> >                 if (!(i & 1))
> >                         val <<=3D 4;
> > -               ds->bin_pfx[i >> 1] |=3D val;
> > +               ds->bin_pfx.hash[i >> 1] |=3D val;
>=20
> The indexing makes me a bit nervous, especially since diff context
> here is too narrow to see. It would be nice if this code (at the
> beginning of init_object_disambiguation) is converted here too
>=20
>         if (len < MINIMUM_ABBREV || len > GIT_SHA1_HEXSZ)
>                 return -1;

Well, I think that's the way I would have written that text at the top
of the function.  I expect that we'll end up turning GIT_SHA1_HEXSZ into
a global named something like current_hash_len via global
search-and-replace, so it will always be the right length.

The indexing should be safe because len is guaranteed to be sufficiently
small, and I feel like it we would have seen it break by now if it had
had an overflow.  i will always be in the range [0, 40) (for SHA-1), so
i >> 1 should always be in [0, 20).

Am I understanding you correctly and if so, does that assuage your
concerns, or did you mean something else?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--vkmcyenazgcoinny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljQWJIACgkQv1NdgR9S
9otEew//Qu2MsOW58JV8uttdRfa9asc3JK3aGnzA6NcplBFnx52gzLJgt9xWUoVc
LXGIXOwK3qj2Y3KcIvK1knbHIeoE2gKRVDI/1/w6T0L9E56FlKHAy1IZwWSphQz/
ty7k2yiMhYlKX0qrng4qfqloOls1M1cts/GNWM16ZexzAmTRmogricSGw5rwXo8V
QKK3J1SQ3xE7BjaLlJ5kSlThRC8WKAphdgOj6yf5PcqcqouI/Bz3ilRXyR2woogN
pqSZiuzC3LQ0xG/NG/48Z6f11mWY2lo447dxk0/jzHUHqzirYv3bjNlYBTOt4tfU
zeEtWtpNPsUw5OAt85iyI+PaSE2E/HD8oTDhRzg5Tw2y80ViuNXeREqFc3IPCX3l
+gdU7sp+g3ArlMqDvbyk0Fi2+AGChJiNgrFUtmQnzk505t2mlBloq5GEd58cWLbq
1j5cvo/vE9te0p//TsyH9dKyb//8/OHhg5WSjUhy86QomqFLplO9hNppkyCRphgB
eH9LUwKo/1Lr+Ifmkby1UyGA0XSjYqbo+yKZUEZ4amgX1/ycH/VUqUBZ331Yz2WZ
ZQ+WczfU/hmbQaNUGibxj4fsFIwhZXj6OMpzJg72XvMqYJlber7ia0SMkQFOO2wK
IlvujriDihIie6Zflr3pZa1BYZfIuGyg9rqKCdfs849FdLwthsk=
=++h9
-----END PGP SIGNATURE-----

--vkmcyenazgcoinny--
