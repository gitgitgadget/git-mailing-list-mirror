Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58719C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 379AA6101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhDSKxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:09 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60699 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhDSKxI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 06:53:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A12F41552;
        Mon, 19 Apr 2021 06:52:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 06:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kOSVsinSHAc6PxeuvuRPCp2zMr0
        Wlx34N3EZ+SzEag0=; b=Pf11kOIeQX1Gi3VO4E2FXeqBEK9c1b2snUPbNsA0S4j
        BJHP5DMAUJj1l3p9DEDdiNg243PIsWbXiff5IukKc1t1t3P0wXdfKuasSCcH4HIY
        HrYJKg9XHQg0W+1sEFgZkrComlhB6PMOxkzDhwMkhKNkntS1ZdgPQOPPqfSi4LZv
        yjEbsuWgSoN8SN5jn4qJPRHzzPj6e37lN70/G/TVyCo1RQZS7ihkNCB/8rdcJN1j
        jWVAoNsA3PPRGkrkaJkoSzDoElmL9zHecpH/CkmqLKp72+2DY8boNVag6Bm8EIeD
        Zc2zYjcOWcQ9rqydZAINe1R+GKrL64k/Y94CKsglgqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kOSVsi
        nSHAc6PxeuvuRPCp2zMr0Wlx34N3EZ+SzEag0=; b=dmj9Gk8HBsOeVDOGCuptYj
        2fveXrv8adfw6esDGUJ7V1S5FXI7ARW/1CtisQ8+42P2IDwyu8HZknJXhEdMUL6w
        2Zyl1CgA46iy1wKvM79Fh8fGGjlxrwyWZ10FKgUnLUCeVKf7/8y6B+35dXBB7jAI
        d/ldE8+orG7pasSETMxpVGoZGHFTHqpGQbaeu3lHyD+pPMJWBOePslvvw1c47JjJ
        ICESJok6+3tIYWfJD9hndHpbGEsReI003yCVfkviyZ5KdCJQQzPG1+LR/UZ9XlLa
        pafLYYkwq8QmfLGXZ6RxPgo2fOz7afIjKQfAhZpc6Pof3m5+946TM2/xHZCo/rIQ
        ==
X-ME-Sender: <xms:9GB9YLRW6jAP60nFPRsu-A4fUNoQJ3DVAv7SW3EQr9Pd559V5W0F_w>
    <xme:9GB9YMy-kqthIoKyxSMpj0fxrIKxozcX8jsaZ5URu0sV2a7x57jLshsBex68PFrw-
    ZWUAkmkU01uL1WBSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9GB9YA3dVqjq66SnKjdeR29evGbmvHebZsqfnhP9LDguAi81aN_HPA>
    <xmx:9GB9YLA4dQp-2YyD1AqFdN054S52jj9arg1ph5krOXeYYl52aoTgOA>
    <xmx:9GB9YEgHW-Nk00BU-NkLdF1GSTbQ4P-3dBPpYLNOQC5b9eOECV_Vuw>
    <xmx:9mB9YAaqGMSV51ZhxcjpRqPZ8zkNzICkMbzH-vBCR0KT30cKzIhv7w>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60E46240057;
        Mon, 19 Apr 2021 06:52:36 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 39c4a533 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 10:52:27 +0000 (UTC)
Date:   Mon, 19 Apr 2021 12:53:57 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] list-objects-filter-options.h: fix an 'hdr-check' warning
Message-ID: <YH1hRQKM1mQk99Iy@tanuki>
References: <fc73f7e7-44ca-773a-7f49-e3bf29dd25bb@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xq0++yVXURBhsh2q"
Content-Disposition: inline
In-Reply-To: <fc73f7e7-44ca-773a-7f49-e3bf29dd25bb@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xq0++yVXURBhsh2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 17, 2021 at 10:37:09PM +0100, Ramsay Jones wrote:
>=20
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>=20
> Hi Patrick,
>=20
> If you need to re-roll your 'ps/rev-list-object-type-filter' branch,
> could you please squash this into the relevant patch (commit 890c534cea
> ("list-objects: implement object type filter", 2021-04-12)).
>=20
> Sorry for being a bit tardy with this email - normally I would have sent
> it soon after your branch hit 'seen', but I got distracted. ;-)
>=20
> Thanks!
>=20
> ATB,
> Ramsay Jones

Thanks a lot for the fixup, will do!

Patrick

>=20
>  list-objects-filter-options.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
> index 4d0d0588cc..da5b6737e2 100644
> --- a/list-objects-filter-options.h
> +++ b/list-objects-filter-options.h
> @@ -1,6 +1,7 @@
>  #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
>  #define LIST_OBJECTS_FILTER_OPTIONS_H
> =20
> +#include "cache.h"
>  #include "parse-options.h"
>  #include "string-list.h"
> =20
> --=20
> 2.31.0

--xq0++yVXURBhsh2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9YUQACgkQVbJhu7ck
PpSatRAAhlQm2f2C3G7qBWDwwCfZKi3BNylCSGC6lJ5SxqEV83A3IE7IeEeL9lIY
mr6q16cmsputFQsgXNzs7znASJVeQKwnRFAQpjLsr0HvXD+St6iZhLc9TzrKd5J5
OxqjCZTdsAA4aiBiPRIyAOu7zwy5tU18ZxRkA+7yRvFdQkXjrvyxGtSCecgPIsJ8
XNLKGZLn+7Za2GYzqJWKjSDHY0dgj3oSbkfO4JjtiEIuaGkLz/+PiA1g+HCCUJZp
dadI509qSzRA/Z0xqPIBwD4PZlwTG1BD+Ms55NHwewLp/AdpsYFPNi9L61XzFiMw
G40r85bTmxhu4OKF3/HpEh3b84/1NjM2zniUsWIKBZyhxStZeO02DIuwUAs3meX/
9vR6PHuO66hhG5VkeM/yqcZ89HiyCn84W1Hsv7kp11xjAD58HzCAVoFRmRaWd0VX
4GDe7tTuBoY7uiAlj1ZJfGlvcE0DUwjuRWKimLKKlOlZuGPgARN/cZ8x9PW9KP3Q
1FLhbVTcTJoSDxEdHqqZgdXs6AUFCP+7VHqe9ZczbyYyRCAV9ddHfAgNSo6m57uF
0uOSne/q1HQ7yp5vwYD6nzo2+kwNQJLtUaQfpbjLtv00d2xEmOKwmY0Tpg6sDX/C
saGN0ydmPNergx1wtS8QZ+YWsHcUCuF+bup5r4Eb/dSja04lGTc=
=c7IB
-----END PGP SIGNATURE-----

--xq0++yVXURBhsh2q--
