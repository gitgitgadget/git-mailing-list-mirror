Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DF1C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258CE2223D
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 07:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hA3xGzao";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JJuj0zoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgKRHEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 02:04:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60201 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgKRHEf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 18 Nov 2020 02:04:35 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 0EB28DEE;
        Wed, 18 Nov 2020 02:04:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 18 Nov 2020 02:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=inbhDarPKMQerpC7k0dtJq+bF2YJTI5ecRnCjIR/
        dEo=; b=hA3xGzaoj+IEtBQI93icJyGBZBGf364zcbKjl0JKxCKTIlOEgStIINuX
        vYzwiCwFCaCcauWlG7qnnBPlXsjC2wuIDoRaw6EiLnq0v4k4PVPOdG8TWPVQQ7UI
        BorLh9Wx4rBwwcS6qqvMLdcjSIpSZJjyx7dKkuCwtAXAVVsB9ljgwoxCJLld9qDN
        rTaHF6tB5Jh7OBCSgfDfXFajsJRR49C2n6tvwFid11B7DQk1pKh4hQFWkOECNBpX
        o3K1G897SA4d9JC4asoSzcBU8pqg8P5IEjoTbqImYASByQIjvLdgKIMVY66ROVqJ
        q345mXXy2j/zjMBqWdUVuHCo49CdzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=inbhDa
        rPKMQerpC7k0dtJq+bF2YJTI5ecRnCjIR/dEo=; b=JJuj0zoM83fvoq7QipCQXC
        EnijxjXuxyxFVp4omPQW/72HfV1o/GOOWSNNdUdDcvoVDtFBca5p7xeknYoK8fKb
        8oRxGZf7gc33CbNAwI04vtAqKKTEM18B/ejJuGqNWqYm9s+7UwhvLlaHZu6DwAPi
        Dcg+ieUAsypRplKn/WhTIP1SbxE7yT/CUtXkqx1W5XlkMUka/R2cygljOqM+A5En
        vo4D7USJ7fAURAyeCf7zbQ7J0qaPYAuoBJayLVH8RC/ObQRH7MemBTSzCWNtHf3s
        6PlG8KlWwSi+v3wglRfVcEWJqBv89Gnl6YyG8++AVKaIdIO2dWdRL/4z0sOxUSCw
        ==
X-ME-Sender: <xms:gce0X_pvMhw7fyWQiDDd6AN6dAaVN5JQ5M2k2jnK91ExXQvkcPk_hw>
    <xme:gce0X5plgqCGt7h80mpiiayfLSoKdXmoZCxIjZwVs7QqPEeHHllb4ZFmrrMi_lr8x
    HyqQQxXc24VbipJug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefgedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdejrddvfeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:gce0X8P2JazmI-NoDYzrbCIkA0LEdqjXOMM_8QSZqisaol4Y63Eb4Q>
    <xmx:gce0Xy6vhEIXnO-nH0UaT6t7xQEmcu-g8MdUmFfpLIxsSl_p__2RwA>
    <xmx:gce0X-6ujSZRsIleQpGr7fxSYIxURApNwFTGDmFT69xK7cdSRiDCew>
    <xmx:gce0X-FrGs-tu5Op0Mv_Ss32VuWWefqrRZMQ2cdRZuXdfCfzzzfLvg>
Received: from vm-mail.pks.im (x4db707ed.dyn.telefonica.de [77.183.7.237])
        by mail.messagingengine.com (Postfix) with ESMTPA id 64EF83064AB4;
        Wed, 18 Nov 2020 02:04:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d051e351 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 18 Nov 2020 07:04:31 +0000 (UTC)
Date:   Wed, 18 Nov 2020 08:04:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7THfjaP91+GV//V@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <20201118005014.GC389879@camp.crustytoothpaste.net>
 <20201118015907.GD650959@coredump.intra.peff.net>
 <20201118022532.GD389879@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s1oTRKoV8+NOLrmN"
Content-Disposition: inline
In-Reply-To: <20201118022532.GD389879@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s1oTRKoV8+NOLrmN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2020 at 02:25:32AM +0000, brian m. carlson wrote:
> On 2020-11-18 at 01:59:07, Jeff King wrote:
> > Yes, I think concatenating uri_encode(key) + "=3D" + uri_encode(value)
> > would be easier to reason about, and solves the ambiguity problem. If we
> > are willing to break from the existing format, it's probably a
> > reasonable direction.
>=20
> We'll have to deal with embedded NULs, but other than that it seems
> robust and easy to reason about.  I like the proposal below better,
> though.

This would be easy enough to handle and fixes all the problems I
currently have.

> > I wondered at first how this is different from:
> >=20
> >   git -c a.b.c=3Dvalue foo
> >=20
> > but I guess it is meant to do the same environment-lookup? We could
> > probably add:
> >=20
> >   git --env-config a.b.c=3DENV_VAR foo
> >=20
> > to have Git internally stick $ENV_VAR into $GIT_CONFIG_PARAMETERS. That
> > avoids all of the rev-parse rigamarole, keeps the format of the
> > environment variable opaque, and solves Patrick's problem of putting the
> > value onto the command-line.
>=20
> Sure, that could be an option.  It's the simplest, and we already know
> how to handle config this way.  People will be able to figure out how to
> use it pretty easily.

At first, this idea sounds quite interesting. But only until one
realizes that it's got the exact same problem which I'm trying to solve:
there's still a point in time where one can observe config values via
the command line, even though that moment now is a lot shorter compared
to running the "real" git command with those keys.

> > It doesn't solve the ambiguity with "=3D" in the subsection, but IMHO t=
hat
> > is not all that important a problem.
>=20
> I'm fine with saying that we don't support environment variable names
> with equals signs and just going with that.  It solves the ambiguity
> problem and I'm not sure that they could usefully work on Unix anyway.
>=20
> Moreover, people usually use the unrestricted data in the second chunk
> for URLs, which shouldn't have unquoted equals signs.  You could
> technically name other second fields that way, but why would you when
> you could just not?
>=20
> So I'm not too worried about it either way.

There's not only URLs though, but also paths in 'includeIf.*.path'.
Sure, it's unlikely that paths have an equals sign embedded. But I think
we should try to not paint ourselves into a corner.

This problem also would be nicely solved by URI-encoding both key and
value and then passing it via GIT_CONFIG_PARAMETER.

Patrick

--s1oTRKoV8+NOLrmN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+0x30ACgkQVbJhu7ck
PpR3yhAAjh0tL+KJQbv2u8VK/I5JFlnrEHhk2z9UtzBGy3aY9m8hhhOoNtCW0VtD
RxGziaFnrrn6J1kpDzbxvLegN3rHUq1VvG38bqu4vfZ/zuj3YEZPUdkPcUGkEwnO
wXSiTDl/tnisgcJioZukCK5stgW8ia7X8/CRgqeQjLvNBViSXsbK+Oa7TYBOlFJ8
S0v7CUy/c8OqrIgWb96jWyKuAFNL73CUIsFj9T7z9ilbtwCQeA8bWr+5nYyA2FZ2
45G9fLR3P5Pv+3IlT/kz5u/JBcou+p+Vb7mAMPrAoQ8X9/RL7CCwVie7e6dExlD7
OmwdeiSqxSTFryMFV89Z68V8CwQcGBNXp7LTrlT+eiQoOmgKFUaE1IwObw7pu5tR
oEvlishHaa4nyCVYjR8/rYrSI1c4CC4GURtWu1lWVkgDO/7wUSDx2G0/iQs2kz8o
Q4Y26fmGZnc73qk4NpBgnHjba6HuIe6RgPDAt+ILmLz1YWLN3tPTzlA+AYwjCBN8
RS4nubr40XGU/kUfxYwDdOUJj2XRREgNjFWFNgpwoSv4db6zcxirHioNoCgLuCbJ
qxWCKDcmg7kjCVgdKpVOhj3DizyzpVwyhNtlNBv7p3qh9isLLlzaXCzv4o4Qnk7D
t4KNPVfxq8HLSK0j5sDWUR7icPycjbFwLneZge1XrPnPUEi2K9E=
=D1u8
-----END PGP SIGNATURE-----

--s1oTRKoV8+NOLrmN--
