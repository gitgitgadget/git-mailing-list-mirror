Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F057201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162465AbdKRVBU (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 16:01:20 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:56102 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1162452AbdKRVBS (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2017 16:01:18 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EC3D760488;
        Sat, 18 Nov 2017 21:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1511038876;
        bh=RvCWMV/wx2iufSxlFwGcfSd2pJ8pz6aWKfKnI55Xc7I=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=LwPdx2T+QnejmBCkBF+r+8IHf2f3aZC3oYM4JR5K3QQITrpLPoVRbArVyKYyqZCy4
         AvqKgS+v+mK5/RbVZ3ETlBPlKWPwUgEkM+MSMj9G63LjHA7AXRQP9ExBAAhVncrWH3
         jm6TCqWIIyOze8IerwtMDWM4U6loHdoOg5wu0YbHhylJoO6KujColx4dWyd6jSY5SH
         oRTptJtGUGIB1xjcpcNMkRiFKDAe+6CH1VxzTfCMe+RQ+4Ygvu8BjruvbrSSQOwEjO
         za2SfFnS7d82peX/KApwz+Ok+4uwsZllKp474pdQuJah2vpxkMAOshryNlxoMJ3uzg
         1xKEA9L4SnfGZsbUcAxosdSI48v2pm8LZaByAuCNf1RSn3i8s6x3mL/S05PH7nJZTQ
         QmbvYAP43sLz9/BYZ5T3noECPFXEPiRVmL7QucyrB2GTHpoQFC6u+ml6ZnxtLxQRsf
         hsy/p/X7ItKlVzU84pNjdbxT7CNOWbFX4f5kF8On500epA1S5ps
Date:   Sat, 18 Nov 2017 21:01:09 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Florian Klink <flokli@flokli.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: honor $PATH
Message-ID: <20171118210109.ttp7bnihi3xb4xvs@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Florian Klink <flokli@flokli.de>, git@vger.kernel.org
References: <20171118124249.26479-1-flokli@flokli.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2fvyipauzfiotvur"
Content-Disposition: inline
In-Reply-To: <20171118124249.26479-1-flokli@flokli.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.12.0-2-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2fvyipauzfiotvur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 18, 2017 at 01:42:49PM +0100, Florian Klink wrote:
> This will search $PATH for a sendmail binary, instead of the (previously
> fixed) list of paths.
>=20
> Signed-off-by: Florian Klink <flokli@flokli.de>
> ---
>  Documentation/git-send-email.txt | 5 ++---
>  git-send-email.perl              | 3 ++-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-em=
ail.txt
> index bac9014ac..b9b1f2c41 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -203,9 +203,8 @@ a password is obtained using 'git-credential'.
>  	specify a full pathname of a sendmail-like program instead;
>  	the program must support the `-i` option.  Default value can
>  	be specified by the `sendemail.smtpServer` configuration
> -	option; the built-in default is `/usr/sbin/sendmail` or
> -	`/usr/lib/sendmail` if such program is available, or
> -	`localhost` otherwise.
> +	option; the built-in default is to search in $PATH if such program is
> +	available, or `localhost` otherwise.

This patch adds support for PATH, but it also removes the fixed paths.
On many systems, unprivileged users don't have /usr/sbin in their PATH,
and I know of no systems which provide /usr/lib as a PATH value.
Therefore, it's possible that this change will break automatic detection
of sendmail for many users.

I think what you probably want to do is use entries in PATH first, and
leave the two old values as backups at the end.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--2fvyipauzfiotvur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.2 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAloQn5QACgkQv1NdgR9S
9osREQ//Sv/WtwYxbNUBrJAYixFnP2wtNdGIGhSL/lH1zHtaoiEohdKuSyOlw2VK
zhKuAFaPNslXnpiGSgz4/u8omMkgFTCRKSSWHLexvE8KpSZl4RnklxXs78EFQPJo
sq8xvPxqUJy+IXy4glLFc93W4vKNUcFAT1ddfGX3MVXJ/VYUOSE1Vpjr/+grB47l
2dccmHnLdhgCnzXo6sybfBVTBGMg0Dc7cfy+f7B+oTGQ3XAqf8Fy3bWx+oA3EFCR
9BBjaReZE9cweybn/e6THXYbu9GuuCgCQ6bNGdk96p1A3+AbY3iQfder9FFWNm1G
fLZVP9L+hfKIkApLkt/W9Ne6ZQYoel8r0qwjcbK1evizL+DOOYEMRpffUD9Tx4yq
k9W2mussR0r0w4095eqIIw/ocv8NHl9K5LMMjQFMKGl3r28+T8ijiJ0UXhqv8Ptw
IoIHbS6HtWSO8QHqOkBVGZAZAJ8bZCEyqirAvPhG5eju5/NjsWnbgudABX1I+1h1
Lp09qs8gmdno173iXVTv2rpYEgFKcDrH228WQkXeJljIcpyg8P/hDlFttgdCpvTV
d1Hb3xz4H/mkD5zoM0Krap7HD0NaDnxTKWROfGQME+kBtu8rHKDP+JyFmwd4ToKc
S32izJr5fyPQ7kViXp6qo77L+Q32H6YSumoTEVUqEwv5IC0nUrc=
=p5gi
-----END PGP SIGNATURE-----

--2fvyipauzfiotvur--
