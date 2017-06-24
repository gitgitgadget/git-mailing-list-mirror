Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D22220401
	for <e@80x24.org>; Sat, 24 Jun 2017 17:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbdFXRUS (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 13:20:18 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:34096 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751417AbdFXRUR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 24 Jun 2017 13:20:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 92D2E280AD;
        Sat, 24 Jun 2017 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1498324815;
        bh=UenyCKyxT/MLOxgx4++oTcMO+q9VxYLBET/j0lqYOyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKS52iQrliTpMynfbQjYVK4puWQMEZ1qAnUQkW0DBOJwpiAHKZYOQKATzIKq2ka07
         ozzBObt7TmNVIfDxrMerrGr9CAFSNRRQPckWXOeT2NE46h8oRFB6LEvSgHwlH4ZsSs
         udcVBNb1KBgnWcJjy+xhNa6IO18n36dbixp/XqvW8EmsV09/x9FnPXiKp1rqm3n5Yj
         V3NUyGeNGLnyZvb4Z9aOy5GhfnM9P20L2rqWmxBJTUXCoydorIwUIlryNPrVtqjvnp
         y6xifxKYA5d1o8asV5hX1fl5aYcbvIKxgQ5zOa724NeG37Vq2JKQIozKAjh5q753Z9
         4LYs8z+LAFIjA/7vZKcOjzktxJCNRVKnVlo2uG4iwIdZCkLMLJVTEMEBjdkJZ4E618
         UsasrKU7ATiBETTtLtUCl7WR9HP3jGLp5T45bIHq2Fii8LttnlvDE1H+jfuw8b1EHD
         g4oQd/quEoOhx35zj7Vtl3tmM6j0cDmR8VF1nre/1g3nV27MiYy
Date:   Sat, 24 Jun 2017 17:20:11 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Using '--help' for aliases
Message-ID: <20170624172011.5afp3qhrec5ovynl@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <1498070489.32360.14.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="muvcaxmuwdgprdcy"
Content-Disposition: inline
In-Reply-To: <1498070489.32360.14.camel@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--muvcaxmuwdgprdcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 12:11:29AM +0530, Kaartic Sivaraam wrote:
> I am yet another user of 'git alias' (who wouldn't ?). It has become so
> natural to me to use the aliased version that at some point of time I
> tried the following,
>=20
> > $ git co --help
> > `git co' is aliased to `checkout'
>=20
> That made me wonder. Git is able to inform the user that 'co' is
> aliased to 'checkout' but isn't it possible for it to take one step
> more to display help ? Just wondering if there were any reason for not
> doing it.

It's possible to do if "co" is an alias for "checkout", but it works
less well when co is the following[0]:

	co =3D "!f() { if git checkout -h | grep -qs recurse-submodules; \
		then git checkout --recurse-submodules \"$@\"; \
		else git checkout \"$@\" && git sui; \
		fi; };f"

If this alias were to run on a Git with that option but without checkout
--recurse-submodules, then it would print help and then update
submodles, which isn't what I want.

[0] sui is an alias for submodule update --init.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--muvcaxmuwdgprdcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllOn0oACgkQv1NdgR9S
9otbiBAAlen+sRqLMbeKQK+hlmfDtGlNR0OY/30Q37P5e7BRd8k/bw4x1eGfD/Yn
LMC/JhhWmKe+dxR5VJ4/6PRTlzWTiGmBcx2mVNWoGBsvIDilNwNlB9rt5JSNmy0z
pC/mAMLZKekyETQDI3aD6bhCx69q5eG6OzdzrsvIy0QYMFJUfXPca5s//KCKYlBP
+wgXOXCX/+8BsSDgrTXjW5THJPGbFfsrhrOB2eMZhv1FTF0jREOJQ5GfyV2EpHp4
bqNbGlsyDoPZTloM3JTV6JjMsfpb6qjCYrif31ee8rXGY9F6FnTo5760qupEr5gW
+V7dH8paivDMeCUN+NP1VkR521y8REK1EN9jmwSnETnx8zUAle2S2QOuWMdI1qPP
+dEfjw+aBaroE0Wjes/5nW08PudJ+2ay8ChREM/3ZY42E58P/ikVOFs04lTUpP6g
JUPHH+d0iWUT5bBp6diUeQ6CjhbPx6tiNH9BqWTjczicFW+Oghhw4pvzzPBgVlVb
UiFiaiehdV+60hK906is7J8GVo4atbXtIHH4+H/3PeLknvJxphClqATztBZECz3n
KBDreQ7XGG2qPd4xm3kH8FlNOK+fOBTSZEK8GHTvLZmePsNwfeH7pZvkS1RbqHW2
Z2n83/sONoxXfyvWHMZXMFGn76Bezqi+n9afi7/SacsvVP6OiSI=
=7/jh
-----END PGP SIGNATURE-----

--muvcaxmuwdgprdcy--
