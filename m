Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D3C2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E791020661
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 23:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wSpazhZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgA3Xq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 18:46:57 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:50498 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgA3Xq5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Jan 2020 18:46:57 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7FD6B60734;
        Thu, 30 Jan 2020 23:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580428015;
        bh=R3sdtCnVePE0hsxQ4IgyzkDQy1G6zjoF9/C7HAK1m5s=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=wSpazhZqfC98OF8eQxPxLC1zMdpzvvBZyVXF+G1oEV64RJdFIMfvKvF3wRFiIWOWo
         ucDx6S72ne+NSKoSUF5J83OAez2UGv24pnrn/WOyTTjpeQ1vbVXK2VkPeI0Ct/hQiT
         vilV3+WD0xp1zWhfYuw50+zCjbAacsySaYog2eOVbCBFdeYP7Rs4sduLt9gJP3F38g
         Ghkis2inRB2hrAftFP6ZldMxTBHEA8Uau9zSCieELYUs0T4WPk0VOVERlX0Q54trun
         2sAYoGsHykFMkLbeVzuAAZgW3Tcl4MREIzzsEHUIzhtp8YhzGhVEG3z+uWqRaBLLii
         uGUKNDn056lAi+mr/h4xQEk0dV0vlo9tN2fYelT+dKfijbpOtKh1OUXjDLM2S+vKKl
         IAmwSxQeFWTMBkbLsWOMsUoMxZlRKdFPeLm6Z0dPh10lSLQOGLiY4I/iF6DcZJDGv6
         eSx7L//mf2C1QvMaSsuXhQl4tylAwxxSya4nyOTZeQGLIf1UMkW
Date:   Thu, 30 Jan 2020 23:46:51 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Subject: Re: [PATCH 0/7] fix inconsistent uses of the_repo in
 parse_object()'s call chain
Message-ID: <20200130234651.GO4113372@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
References: <cover.1580413221.git.matheus.bernardino@usp.br>
 <xmqqmua4bpqt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H83aLI5Lttn3Hg7B"
Content-Disposition: inline
In-Reply-To: <xmqqmua4bpqt.fsf@gitster-ct.c.googlers.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H83aLI5Lttn3Hg7B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-30 at 21:26:02, Junio C Hamano wrote:
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>=20
> > Note: I also tried to replace some uses of the_hash_algo with the struct
> > git_hash_algo from the received repository, for consitency. (In
> > practice, I'm not sure if this is very useful right now, but maybe it
> > will be relevant for the change to SHA256?) Still, many functions in
> > parse_object()'s call chain call oid_to_hex(), which uses the_hash_algo.
> > Since changing this would require a much bigger operation, I decided to
> > leave it as is, for now.
>=20
> Passing a repo instance throughout the callchain and redusing the
> use of the_repo would be a worthwhile longer term clean-up.

Yes, I think this would be a nice change to see.

> Moving off of the_hash_algo to repo->hash_algo is, too, and it is
> very much relevant to the "newhash" work Brian (CCed) has been
> working on.  You two do not want to step on each other's toes.
> Please coordinate.

This series is fine from my end.  I think it provides a nice improvement
that I can take advantage of in the future, so I don't see a reason to
hold it up on my account.  The few patches I have in this area would be
easy to rebase or adjust.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--H83aLI5Lttn3Hg7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4zausACgkQv1NdgR9S
9otDPw//SsTVmvyINnglFgGfndo9cqadtENq9dA+ekQHDIFoAw4xtSYkS+X5DpcD
x/O7XRGzLqKkvryKcjhyB1x/V60Irv9dSECrb3Ae6t3B3SNXWZOjloOEQqDapvfy
MM1en4J5qsc52pceliK+AzI4/xacgEHXBh3TyPktFzN0ffjF0sv0NP5U+INwc1vx
iBPKAdBtRsgKm0qrAeSC9ig9o5Ko5SmOhU1BxxFSpuHlMGXRCDFLMgvddUldAhOz
AMRmlUrcTOb5GG9wCpJm4o2TLDdk57DJCaAgh2Lpqed/j+veI/f5I3lzqChbpIeB
JzA+7bZJvEHyuh6Vp6Zem9tXN45QA0/4N92Hd81ePdFzn7Ry2Q7tjECGCu5SSJ4/
aOebYtcFpcr8NNZ4HcVg8qT5HRYl5AjuP+cC5xwD4Kk/tMNx/M/Cr1JuE93mHhSZ
fmOlX0gVpQOXFloYlpCGbI+5azv0KjRcZIgq/lR9/mdzGBcJ28LKzKxVH4w1RZJl
hKngzzVjfFcF0g3jpLlSmeMWylqRjtmxK5HmHJKBldBXfWy2NZy6IlOIBY7xxuRD
M1e45PgOdtohykeWq/8x5eCXPGSrJEpIuDvASIhMZE3XGIE/WzHJAtEyLg/L56uE
Z8aO7ccdTWBrHiiXpZTANcs+4+h4ig9j26/3/tJu6CuFj/BgahE=
=r6Y2
-----END PGP SIGNATURE-----

--H83aLI5Lttn3Hg7B--
