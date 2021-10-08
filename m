Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE99C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E63D60F6D
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243266AbhJHVAI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:00:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57264 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243261AbhJHVAD (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Oct 2021 17:00:03 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6F27D6048E;
        Fri,  8 Oct 2021 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1633726657;
        bh=87C9PZJVQot6AIvVgiBeMpCoSXEgxpyzGodKtIqkENA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y6gLEWs2fhj5R/dEPvLxsU3DOL//gC0PIcg5tNSVuXNqpmY032WuoEheLbdRnGyAl
         EJFFbPDlz0XTZXMBeBF5mu78AL/m42VEn33R8oSwZ6+lbg2gALzoHHshN9qsWqLfqa
         feMtVmj7CZhoNh+rp+DeNVGs/7kZIA5qv/BSdDHW3+9VlShUzfVa2GMM/vEfHAl/qR
         Lb/2P3A+4OUW5RptKNEanN1VqnJ2eVS3Ue2CMYardSMH3ZgYYbwxjbT5R6TCHloB0d
         daVZKDQdJy9OOZqTj4AVeEdu8onLQ6dCuRAwMFuLuS+9oHYF4N38asDN+AcSshN1I5
         d8kA2setdEQPp/C8I8rtcSvoL4sokL+ih7YdCvfT0RB2JXHCK/0ZMpUPEwaKU68JMQ
         TDS1N1jPw2sOXYVwR9WAwPYxGWhuMCl9zBjRdPr7xDmtgNhZBv1UtoQR1BDrrQTMfb
         HvWGDlNDwY+0gqf8eeIHDe8Seu8/XG3yr0xoiEFp8e9g6DjJq3F
Date:   Fri, 8 Oct 2021 20:57:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
Message-ID: <YWCwvOdW/L5aMpr7@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
 <xmqqbl3zjl5y.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxZwfRlqUAPei/8Q"
Content-Disposition: inline
In-Reply-To: <xmqqbl3zjl5y.fsf@gitster.g>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pxZwfRlqUAPei/8Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-08 at 20:50:33, Junio C Hamano wrote:
> "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> >     This fixes an error in contrib/completion/git-completion.bash cause=
d by
> >     the incorrect use of =3D=3D (vs. single =3D) inside a basic [/test =
command.
> >     Double-equals =3D=3D should only be used with the extended [[ compa=
rison.
>=20
> Curious.
>=20
> Would it be equally a valid fix to use "=3D" instead of "=3D=3D", or would
> that change the meaning?  This is a bash-only piece of code, so use
> of [[ ... ]] is not technically incorrect, but if the basic [] works
> well enough with "=3D", we should prefer that.

It's actually preferable in most cases to use [ and =3D rather than [[ and
=3D=3D, because the former looks for strict equality and the latter looks
for pattern matching.  If one is placing a glob pattern on the right
side, then [[ and =3D=3D can be desirable, but otherwise it's better to
stick to the POSIX syntax.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--pxZwfRlqUAPei/8Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYWCwuwAKCRB8DEliiIei
gd14AP440oWmna0Ot1QNKzUjean9SIxQ3mduQ9QRPNztMAnXWQEAy19PHnrOoTOM
iOAxYEUCzNzxCAajujUYAxZk8f3Vbw8=
=EP5E
-----END PGP SIGNATURE-----

--pxZwfRlqUAPei/8Q--
