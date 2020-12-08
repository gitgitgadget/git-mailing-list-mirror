Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E313C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A95F23998
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 02:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgLHCdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 21:33:18 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55914 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLHCdS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Dec 2020 21:33:18 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A469D60751;
        Tue,  8 Dec 2020 02:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607394727;
        bh=HD+pp+8QxFEF0XH9zzrGxlegPZx72QJDNaDU2dJogDU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=ECAmD1Zl5weuwL/3yH5v0iMChD0pba1Ioxm2CBWDjE9x+8dYdOQMCyNEfc29xibMR
         A2S3wft/KT8QifNS75WLS/Hak8Ux0/qXVnBlIlcHS7bkz8CXVbKaR8A9XMMWU9goVW
         f6v6VHhXJMCkIXvgEMgOoEjQIwe5alYWpXmlo5Ovk5+I5BVicS4ApKbp3tUAMadaYo
         PDT58K4ZA413rnHsvarK6slisgS1ipMRiQKxr2hBOm1hIm+5hdzqfTJofMippDxvcE
         RVp44Dsm/9BqBI1159df9Nhj2RaVmQbm/d6rlzHVri9ZODm4JzReSJnKkkCAYstQty
         /2Qs7qwFJ8fHI7JJMsNhXPedasYDmG45lxBO5S6ov5R9l6SF+xRX+DRWGU3vrTK/QZ
         S8HwJRoApuBcjpRCM3vfMEcQEuUfo1mWIo+X7lcCGMySyhF9OcBx/IPy1GLFGV3jEx
         JrkK2ebzNA7vTGBd1Wq+g/cix6P+r6HkxDpVeO2wql8liNa8pYr
Date:   Tue, 8 Dec 2020 02:32:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Cloning empty repository uses locally configured default branch
 name
Message-ID: <X87lobsQmgncoIpF@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20201208013121.677494-1-jonathantanmy@google.com>
 <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6tYdRp/QeBCZM1Zr"
Content-Disposition: inline
In-Reply-To: <xmqq7dpt82l4.fsf@gitster.c.googlers.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6tYdRp/QeBCZM1Zr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-12-08 at 02:16:07, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>=20
> > Has anyone looked into solutions for this? Both protocol v0 and v2 do
> > not send symref information about unborn branches (v0 because, as
> > protocol-capabilities.txt says, "servers SHOULD include this capability
> > for the HEAD symref if it is one of the refs being sent"; v2 because
> > a symref is included only if it refers to one of the refs being sent).
> > In protocol v2, this could be done by adding a capability to ls-remote
> > (maybe, "unborn"), and in protocol v0, this could be done either by
> > updating the existing "symref" capability to be written even when the
> > target branch is unborn (which is potentially backwards incompatible) or
> > introducing a new capability which is like "symref".
>=20
> Thanks for looking into this (I think this came up again today
> during my reviews of some topic).
>=20
> It would be a backward incompatible change to add to v0, but at this
> point shouldn't we be leaving v0 as-is and move everybody to v2?
>=20
> If it is a simple and safe enough change, though, saying "why not"
> is very tempting, though.

Yeah, I think this would be a nice thing to add to v2.  I've considered
adding a way to push symrefs (that is, update the head on the remote
side), but that would be a bit trickier.  Still, there's no reason the
fetch side couldn't learn a "symref" capability in the meantime.

I don't see a need for this in v0, since all versions of Git that
support this will also support v2.  I think it's okay if other clients
have to add support for v2 before they get the cool new features.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--6tYdRp/QeBCZM1Zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX87loAAKCRB8DEliiIei
gZZAAQDyzFJdXI72fmY51C5iHHFM+CdsIMLiaTubLi4JyzXicwEAjc+iGWx1yGeS
+JxYRkYtA3Gx/yOJCQhxir8+0DUZnQ0=
=pk+K
-----END PGP SIGNATURE-----

--6tYdRp/QeBCZM1Zr--
