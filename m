Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC0FC4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32EC660F21
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 12:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345201AbhIAMvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:51:05 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38987 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346385AbhIAMuF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 08:50:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id B3F5F5C01C0;
        Wed,  1 Sep 2021 08:49:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 01 Sep 2021 08:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=fCf/wux2hOl6FhVfS+yAZL0KqZ/
        cfk34WsrGs8Lw1Eo=; b=sw+IbIhs7MjuTmP2A1HJrcG4HhiGu8ISrh54tj/SaSq
        61vu1hc5xrfPA1FD4OytK9j3fz92kfFJIF9+Ch8LhaXAs5LLqvJCYS2vZrqCx0+G
        yJveIXTi5a8k+D1p0yydefDhVk+fa37s+x/TgpOS0ht+yGr72FD4Sr6Qtz0FzfVo
        SYN7aDt/1ktFiKoCMlNBSiIlf7QerXIhueM1PHwlglf+QciuVRlAfN/XyI+fprHU
        w8uXWA2sAXeRmVenhhX7QAJirVHT6MxnGBVb7PsbrudkvYcyfN94GYSOoWhlnX9R
        tMzX4HXAQA6E8yCw8IWrKv9h1EOJ9U4R92J8D2NVJIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fCf/wu
        x2hOl6FhVfS+yAZL0KqZ/cfk34WsrGs8Lw1Eo=; b=W4Ikoe996ffQz2VH582zu9
        jQWoML65GNIM7WsZTYeHaYFc7dZn4DqUrM7zOW2nPgf70E6bpdzfIKgm9ksFv+tr
        ZXwgL+MRF40uBzUkg6vSW/GY0QpTYCv+gHsQbqTfMc9htoWh8xAHY8HzEjNE6RkU
        9kmeQ0NC7Jd8GqBzQDcsMBwm/9TMbs1J/Fj5ijY315uYCsH0ZzzNLk9zeUik3hxj
        F6WEhbJPWm3JUNS/su/RUhj9xC7LFqef5eZmSnTWDiS/3eJxevtbeB/37VkANAPr
        FCdRU8+ULna5RfqHSvJFzrIranX3bziHVRg9WxIlsBOeQjkhvEZHFd+i23dz7cIg
        ==
X-ME-Sender: <xms:v3YvYWTsp1YqjqDKN8_m9bdAetSPwTlSG1lUU9em8pCPle11qVrQiQ>
    <xme:v3YvYbyaB7DUv2sb-XY5NwE1jqHeEhOsK8NQVqKHiXWPEbmExl4CHr5FnqTTzLVZw
    MFkMk-qD9GppZ0wwQ>
X-ME-Received: <xmr:v3YvYT0i8mxZsRhUWEgkZYYTSCPsu_aOVLVImgTtBHBKVHEvpZlh9s_jPOcyCfow2Hv9vdv6kq0feXgqB7bkgwATrFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:v3YvYSDO-qh-FMwNZ5sQCdbaqis-O-b9K4dQzoJZQuvzlo8VXMbxig>
    <xmx:v3YvYfhHvkk4FSFkG-rxRuT8roQ4e-NZz6oDVSebkyxi3hotzCZsfQ>
    <xmx:v3YvYeoQNETbhTrXGqr6btZjVZ-P73KpOWIh5ps5lvfp7yNiTfLmag>
    <xmx:v3YvYfeMhEMLtt3CZL_dp8g5Em_28pjrfN5c7NXt6-nb-1uqOhG0_g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 08:49:02 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d4f02ce5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 12:49:02 +0000 (UTC)
Date:   Wed, 1 Sep 2021 14:49:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 6/7] fetch: merge fetching and consuming refs
Message-ID: <YS92vF16DSjwtiVc@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1629800774.git.ps@pks.im>
 <31d9f72edf5c178b2e80c30bb7c0a9bc164ca5eb.1629800774.git.ps@pks.im>
 <439cb382-a4d0-18ad-5475-0cb29fba98e7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cE4zxpBEFzVkEu2h"
Content-Disposition: inline
In-Reply-To: <439cb382-a4d0-18ad-5475-0cb29fba98e7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cE4zxpBEFzVkEu2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 10:26:28AM -0400, Derrick Stolee wrote:
> On 8/24/2021 6:37 AM, Patrick Steinhardt wrote:
> > -		if (ret) {
> > -			transport_unlock_pack(transport);
> > -			return ret;
> > -		}
> > +		if (ret)
> > +			goto out;
>=20
> You were just reorganizing this method in the previous patch.
> This "goto out" trick could have applied there instead, which
> wouldn't complicate that patch and would simplify this one.
>=20
> But perhaps it would look strange to have the following ending
> to the method, even if for only one patch:
>=20
> 	return 0;
>=20
> out:
> 	transport_unlock_pack(transport);
> 	return res;
> }
>=20
> So, feel free to ignore me here. Decide based on your taste.

I think you've got a point, I'll change this.

Patrick

--cE4zxpBEFzVkEu2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEvdrsACgkQVbJhu7ck
PpRE0Q//R4ORJycQtvedXRwOjenVk9V9TlKT4VQtkScONsJhawGiDNpoTEh1h8FY
C2U8oF7rACarWBixwVUFYKuye19wJOWgRbeHn2PhWYixJTpxk0Q9NQq8tqp284nm
tU3FE55obPTEkG0Dx7O29T+YwFdLTIYhClHvJtKtxpz9mfhn8NOc912M+sVeKqSg
hNOMDx+zOB4qtHjBgivrTvpEva4yOHnHQ6sCK5yMYLwtz4yuXzjulx7Jm/XwuxHI
Un/nSMuN5YalosKKnohW9waQw37zokGlLUIh3i2ANnDyTm+2zEXklH/XNG6Fch7L
aGMX1e9kTWQ2BtkVJvchNnVm/eU+gSboyAjb8i0xASseo1ALP6xf+Z2LVI06dfDy
KJh8SEJ0O9viQ9AON13TQ/ISSpeyvKv3KoQGBfeWQaIna5H3S2ezr1d8kUQAV100
C87qoIQp0pYCB6wH22rGHF7Kjbfs6lve7QwnfGi/E3VGlqysd4LjLW++lMPXZM3l
yu7X3EVJmN+x5GSlXpjvXS43L6brpbsAkJzqaxsjnV6qtpVRiux9BEkGh6wuin5F
iOGhAP3Z0+eF+j8V7P/YG/xKrpS6Zpt6+18saMl+VcMVHnyVXbNcFdb/zj1B1ThU
da94QkUbl12+UAcDKmBzNkm7po3KW9Im/cw0ADsBUtunNe0XjT0=
=1Ta7
-----END PGP SIGNATURE-----

--cE4zxpBEFzVkEu2h--
