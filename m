Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0477EC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 23:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjAIXhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbjAIXhF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 18:37:05 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C1F46
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 15:37:03 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B76785A34F;
        Mon,  9 Jan 2023 23:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1673307422;
        bh=rqynQ9y2f3LmFuWYXIHzorpl7nlgeVhstpq6nFdK+zA=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Nyjd+YVqJ75xcd4SeJKflurddkHx1p0QvhkUDB5Ushq9mtLfnnYGqIsvijJVRyaHS
         VzNc8MF30Fh2s5klLUWKHinOKaZvsGsY5rdWm+GP6i363vtNXz86uL2RoTUTn66f6e
         Nd30n7L1zV4z6+a5Q3a5lwI169AzugGvXKALT7VirIeJCcdnphGi01yCZhAI6FS8mV
         qXHBgUMhQHWlv7nEN3Qi80SCLD8fY23bStFW84ZNJ1S86eVx/8V1OJy4+kMkpFkg+c
         V2GBYkzw0atKe6xOoND8UyJqj8daimgeevNb6gVlTXT/Kym2juXbXDUXPnnYV5NzEk
         bYhwS8yvisJWHkiXKuPlBSd4bbN35V07n3+yEeke1mJiY4v5WRF++AO89+6p/dJT8S
         /btyaQ4pFZ1r7PT/QsWsN84XXkDNo82HcPwRuTw1C03C2cFu49W3Sir/5jNxSoF+G7
         J/wBsX+QGMdyRfBKPGN8iG22HlGsoF4/wn55R2yd7Fg+z52/eXp
Date:   Mon, 9 Jan 2023 23:37:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: BUG: git prompt breaks with zsh < 5.0.6
Message-ID: <Y7ylHW8nrsT1eVtW@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shupak, Vitaly" <Vitaly.Shupak@deshaw.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <5807cdbe6d66427c9ff45ea78c2c1ffb@deshaw.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XdzhMOmcaCcf1AeV"
Content-Disposition: inline
In-Reply-To: <5807cdbe6d66427c9ff45ea78c2c1ffb@deshaw.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XdzhMOmcaCcf1AeV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-09 at 17:12:56, Shupak, Vitaly wrote:
> A change to git-prompt.sh in v2.38 to show presence of unresolved conflic=
ts contains syntax which is not valid under zsh < 5.0.6. This version of zs=
h is old, but is still the default on RedHat 7 machines, for example.
>=20
> The offending block is:
>=20
>        local conflict=3D"" # state indicator for unresolved conflicts
>        if [[ "${GIT_PS1_SHOWCONFLICTSTATE}" =3D=3D "yes" ]] &&
>           [[ $(git ls-files --unmerged 2>/dev/null) ]]; then
>                conflict=3D"|CONFLICT"
>        fi
>=20
> [[ $(command) ]] syntax doesn't work in older version of zsh and should u=
se [[ -n "$(command)" ]] instead.

Does [ "$(command)" ] work?  I would assume so, because that's in POSIX.
If so, that might also be a valid approach since it doesn't look like we
need the special behaviour of the double-bracket operator.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XdzhMOmcaCcf1AeV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY7ylHQAKCRB8DEliiIei
gQHaAQD4VVFUAqXQBETYCQlc43xVG3OhNQXvV30w7ncIOx0j5gEA35UcfP4tjKzV
6YHWkcsuUFXWR7ws4d+/+4jU3/A1uQc=
=IgCH
-----END PGP SIGNATURE-----

--XdzhMOmcaCcf1AeV--
