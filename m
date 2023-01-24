Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EFC54EED
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 22:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjAXWFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 17:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbjAXWFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 17:05:03 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BFC51C55
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 14:04:44 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 80BA35A58A;
        Tue, 24 Jan 2023 22:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1674597871;
        bh=sbbgi3ormvFFCrYkuGZ242LJH8UySXFeVUHew4Lasmw=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=1fDZvZ2P9NuWreKfE7H4PycoSX0v/j5Xv8S2gb7HV1CpqN7kfQ2ATdm3xex4uf2uz
         vlVOBMfHt13aZQ45gKzVuGVe2TPcUpiyo86Puz37PocHHIfEzxuWt2LIH5B0AVMkE4
         Cu2LBv7H+iQJ3qCQEhoh4igjcooB5gTEQonGJ55BVRf9iGRu0WbpoEjBOsxzNLr2xv
         shgqUKAzM5kO1lInSn8DSBRSP4UVLEW+4RlLsuOyaO/qe8uylLwuQHJsfbpP/7o11K
         xdWDN3OZ+P7lxv8J7sXR8jGRu28MbcDxeUZ3tgJe0CvjPrS902le+hWr/jT/iYEyGP
         Vbf9HKQ4IZWqdExyxYlw2IDk3hQ4oIieyxJaAY+CLQd2/eUaGyguDnWsY+Z7W8bdWO
         0wjYZpTEyXDk9VIVo+e7hNkSmfDNxS2mV8PAa5XxY656dOTcEYTXvsd7O0O002CS3Z
         TIlhjHXnDdrRNemZmpkQ1Jnc7yAnDgKl4hZUKuxhqwqQ5mFyv+7
Date:   Tue, 24 Jan 2023 22:04:30 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Auriane Reverdell <areverdell@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git not allowing 744 as permissions for a file
Message-ID: <Y9BV7kpHJsORRDiq@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Auriane Reverdell <areverdell@gmail.com>, git@vger.kernel.org
References: <CAFC92SFZgQtstEzV5pgT_tPSs=6fRJ=rE6ad_DENnn_UoobxFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xVtgeNAFUBxkYbwA"
Content-Disposition: inline
In-Reply-To: <CAFC92SFZgQtstEzV5pgT_tPSs=6fRJ=rE6ad_DENnn_UoobxFQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xVtgeNAFUBxkYbwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-01-24 at 15:48:36, Auriane Reverdell wrote:
> Hi,
>=20
> git doesn't allow to add the execution permission on a file only for
> the user. A chmod 744 on a file will transform into 755 when added to
> git. This can potentially lead to security problems on certain
> systems. Is there a way to fix that? I'll be happy to do so if
> somebody shows me where to do it.

No, there isn't.  Git tracks only whether the executable bit is set.
All file modes are either 644 or 755.

If you need the permissions or ownership on the file to be different,
you can do that by using a script to copy the files into another
location with the proper permissions or ownership instead of using the
copies in the repository.  For example, I do this with my dotfiles such
that the files have the correct permissions.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--xVtgeNAFUBxkYbwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY9BV7gAKCRB8DEliiIei
gdOcAP9aYEg5lnpEYdoD60iCs/jwZQYh0QrCiTJv1dsqLgl9UAD/dV7OBUE9RRSH
sltaQjBPXuuI8N1kE2g9IEshUPjPhgs=
=7Z4V
-----END PGP SIGNATURE-----

--xVtgeNAFUBxkYbwA--
