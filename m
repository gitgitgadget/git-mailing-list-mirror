Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBAFC2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 21:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753245AbcKTVxy (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 16:53:54 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:46456 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752072AbcKTVxx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Nov 2016 16:53:53 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B6D68282B7;
        Sun, 20 Nov 2016 21:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1479678829;
        bh=tiTLI4LZSisMGvb27FoBKhq3lgqjxEkE05PGC5juiYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=llv1zD4vxIDk64wAsWN9K0AuiHUMr/lA5pRxF4AivBFQFjHXvO7Lt8paroeamL82n
         P31sq2Yc5kkA846joFEsV86Cy/dOZX/w/oVtr+ecSBTZXG60Pc7w+hEe3j/xvF62wP
         rMyHZrAG8n8izFz1wGilkw/vCutxUS8oIENVAnQbVYAtONWvzRN5UHSe7lTqosfQoP
         8/DWaWtgl+PECMTh0iCzde8cOpB83SE4Ni+ot68l53QhACJNX06NHxIUj7UujSIWXv
         8RVTM8t4KoXEV/Ar9firtt69b4YxvWaua6ApUjlJylAieVsB/3/5UpnTYPvZs8RWiK
         E5BekVhW5085Lp0R0KZ3NN1ljbDxNrKsMX9zMjxa0IM3KW6VMqFO6CnuJ3VgUshDgE
         vTJfveCoq53T61Vtm8LLiNUgttEg3SvkF19YcnZHCMmRCOR6nZ/TwVSe7hq9GexPc8
         e9dNivNdOFIerUPR+afKbR8bFZNrb1c+pgEeje2KQWikyBOZ4Cb
Date:   Sun, 20 Nov 2016 21:53:44 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Mike Fisher <mfisher@csh.rit.edu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Remove dependency on deprecated Net::SMTP::SSL
Message-ID: <20161120215344.jaqt4owlhovig3hz@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Mike Fisher <mfisher@csh.rit.edu>, git@vger.kernel.org
References: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="neavn23ectxz6din"
Content-Disposition: inline
In-Reply-To: <451E4A46-BA43-41A5-9E68-DE0D89BE676A@csh.rit.edu>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-1-amd64)
User-Agent: NeoMutt/20161104 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--neavn23ectxz6din
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 20, 2016 at 04:18:16PM -0500, Mike Fisher wrote:
> Refactor send_message() to remove dependency on deprecated
> Net::SMTP::SSL:
>=20
> <http://search.cpan.org/~rjbs/Net-SMTP-SSL-1.04/lib/Net/SMTP/SSL.pm#DEPRE=
CATED>

As much as I hate to say this, I think this is going to cause
compatibility problems.  Net::SMTP is part of core Perl (as of v5.7.3),
but the version you want to rely on (which you did not provide an
explicit dependency on) is from October 2014.

That basically means that no Perl on a Red Hat or CentOS system is going
to provide that support, since RHEL 7 was released in June 2014.
Providing an updated Git on those platforms would require replacing the
system Perl or parts of it, which would be undesirable.  This would
affect Debian 7 as well.

We currently support Perl 5.8 [0], so if you want to remove support for
Net::SMTP::SSL, I'd recommend a solution that works with that version.

[0] I personally believe we should drop support for Perl older than
5.10.1 (if not newer), but that's my opinion and it isn't shared by
other list regulars.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--neavn23ectxz6din
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlgyG2gACgkQv1NdgR9S
9ot7wA/+PSjQQvdc9v1Nkk/riSP6SvFEfXRGFqmhArizXSVHl/n3bvRCuRPXfh1v
IrxTE24g4vXZaJcWW+i533LO5TAFzfg3nb43y1PqDFAdxYd6CSwyYjqvrsWv2mCM
DjO3fkgi/MezSKam47EbhJCgc24UshZgRV7eTahe67jEupLUhY3+L8gJ1/4I3Tcd
C57qirls+CLrTu2zA9Ip0kbu3E2ZTiNwVuFUxDp2ScXowtCwjPI/bwvNDmHhPJRI
nEtFEbjPuZ64rwxrxmz0VhwbAT5Bni0JuOcZ2MoDxt23+IEm+NIOxIAPpS4EDaxO
kNZbnYEq0lEKpK2fnDzuUT7kTSueFlaisnSANDmPk/NhiX/uabloQq2gJQLFLzhX
6IspHDC8qNW5MKzgTK0XAlvbIanMHPV0KbmOQrMYHWJuI4QmLRAkIFSNiCIU1THz
wa7toFd8PhkCtzbS+dT9Ml+Dqg8bUyzPzZSGYDxhp9MQND2IuD+ikGq6T1tG0prT
9ce+K0pVjhC53hBp0sBT7JP5QbMvvX5cVVpNk8vrgWxI0pf6DLaJrB3L0iBExDuh
SFHLdNIu9eTsLTsp/xDbHBPXWCBRc9jK/eSJJoC3p8SPYx8nrszMc+yHT/HMAfUM
/1LVXFY7rzKYx02RW+gmRSAjvYVZ0UFsHaJ+50wu/Jfj2yTiCZw=
=CdZ0
-----END PGP SIGNATURE-----

--neavn23ectxz6din--
