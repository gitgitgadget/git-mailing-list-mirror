Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899D91F45F
	for <e@80x24.org>; Wed,  8 May 2019 23:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfEHXMg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 19:12:36 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36056 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbfEHXMg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 May 2019 19:12:36 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:414a:17e4:5dbd:d3cf])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2DAFD60736;
        Wed,  8 May 2019 23:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1557357154;
        bh=ZTkk/VLBw8jUoNOJvF4fKNI4ndxikcfVH57uJmPAE3c=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=I/nTczEQcPpyv/peNOF6txk0u1OgYawXrMoM6GYCL+mFh/wchXFWwCexI7ycEBYvJ
         DpPqU6xdBF0KPkuA5UZ0LDptP5jggO16y3X05N/GjWQyCmx0pyspaAfGcknuYYhxG0
         8Z66GjDUMzWJKBnlS7g3O4tp+rsXuvfQkM7fXggkpl2KLSrDW/MbSlAcxBbW8aPWX0
         OnEaBlg/IZPjdyfo1Qm9KtAGkztLtB5XQjAT2jcf7zOVI0Uy3TjzORNb00QO3vQctR
         RtMwFi/73yr5z0YcBd02/EWYv1lYp+FS3LkOvZP6Fcs6XwrpfDMZfXi8nNXkdxxiLs
         C+81lDwj8p0OasTxtdmXYxhjqasn/5671pzXd+tN70rde7JbB2sBPt6ivC/ixI0o2+
         Qt622M0L93/TPBExlsISrjXzNoHrhQAo+MVEyAi7nScw4AgKvcGcQ01qf5tx6yRkhy
         pTCZXgZOmOAA2bkMbXLUx3mI4FVF6ZDU5vXIZGam1TCgP9i8zVI
Date:   Wed, 8 May 2019 23:12:28 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] send-email: honor transferencoding config option
 again
Message-ID: <20190508231228.GC7458@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <xmqqzhnxfe3p.fsf@gitster-ct.c.googlers.com>
 <20190508105607.178244-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
In-Reply-To: <20190508105607.178244-3-gitster@pobox.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-4-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2019 at 07:56:07PM +0900, Junio C Hamano wrote:
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 98bc295c6e..b9dd775b63 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -231,7 +231,7 @@ sub do_edit {
>  my (@suppress_cc);
>  my ($auto_8bit_encoding);
>  my ($compose_encoding);
> -my $target_xfer_encoding =3D 'auto';
> +my ($target_xfer_encoding);
> =20
>  my ($debug_net_smtp) =3D 0;		# Net::SMTP, see send_message()
> =20
> @@ -271,7 +271,7 @@ sub do_edit {
>      "from" =3D> [\$sender],
>      "assume8bitencoding" =3D> [\$auto_8bit_encoding],
>      "composeencoding" =3D> [\$compose_encoding],
> -    "transferencoding" =3D> [\$target_xfer_encoding],
> +    "transferencoding" =3D> [\$target_xfer_encoding, 'auto'],
>  );

These changes seem sane and the series makes the second one
straightforward. It's also a nice way to add defaults in the future, so
thanks for that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.15 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlzTYlwACgkQv1NdgR9S
9ovSDw//fh4kQ80JnKPajyQmUqMHGdvyTZsfZyVjvjmE7eduaGtOlvUsRxTACV1T
964JAu6ES4BcWPWaMhzUe3Z7m0K3hs+D71DXw7fMM4Px9XTfe+7EmGah++lkErUL
XB+KK0m75qA+4odzUGYMZoAzL+f00m68qctu05+G1ll65p9OGQ2X49hbknYP2IB4
0iZeSW8t8tQTa/+4hZTiHrw9hzf47yKLzjFtgLcO9kDDb1Nb1Nmc816cyRoEchlU
/rySweAVux1Xri/jObvaBYQRyyOLelFa3Vs6dHnUZJ+CQU5Yskd7XBM/NSQB5Tiu
bHldfWFfnhDR0iUXFDnog4YkiyK5if/8BtbmU+osDbfNOQBPd9X95hlcGWupKk+g
q44W8Q9zukwdZalifwBrsAByiPZVl2lbbbrXLyQcavvSOvJ7U11cPHoVDFjzdGBK
ldO8p+cAhjzRyjagRrL11kYkaPmohuaEQFlPYqDOxMJ470bfeKPAmIIP1jc59+V0
tEHcUu++J9eFB654tLCTV1L5X73IGF23VKkiPeiGNkEUWDXHfXEG7Z+rNZNKQRXO
xapKwq9Ctqhho6D6hY1Ny38t9sXzg1fM6pTQm4qaMtUC3AadOohTnlZLis2H64+R
cDUzSviq1osS/t65MFntrX6v2RsGJIL2QboFJd57y67kM+LxlmU=
=oUqx
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
