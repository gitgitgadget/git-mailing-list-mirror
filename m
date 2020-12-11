Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD193C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9436D22D73
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406460AbgLKO74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:59:56 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:53385 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406455AbgLKO7o (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 09:59:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B02728D4;
        Fri, 11 Dec 2020 09:58:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Dec 2020 09:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Th8qvLOgXJF74k7mt6+NCOIPbAs
        F8DpkXCuwTij6w0w=; b=EOrkPAlPKCvj1aaJAaLKM4SnvR3cAQOtVTCd6ORY5Km
        hPUJkEH/6bvzXsaBCfTTOyABp8NycrLuxH+e8+wk9hJhb4fDjSgTLPhHcezHJY4n
        mnks7iWlGI+a9yOoRsSlAgQI/6T+j6sUnEDZLEJQyN2zvWxe5FKmesoGAhKwHocV
        mrevBGZFtxtmPVuiP2pbZwZC5Du5olC3o4V4bxHcqWAPYsccMYgm2IclBxVpkaXG
        vSDSRJefgHXV77Jx7z/IGOvbHOYrz+cbwZLlA/8KdsXTR2oIDIKKYPzj4CfFk/Vs
        A1eFZLSira6iP/lCkkaF2WmzAEw19p7Pt5KOBSD5Xyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Th8qvL
        OgXJF74k7mt6+NCOIPbAsF8DpkXCuwTij6w0w=; b=BH776U0UF9VroX13MMxMq0
        Y2wEAvena3JN1zWCEWAwNxpxACcCaXyDnLdu3EnV8WK7H87Wq0+EhhqL7DPJsB5U
        QOV9XQC5p+PaTAubWEkhds4BdNLKp53aC1OaurfbQHz2/xRVgRDHhGJEAnL74UuR
        ZRYYUVIrWDmZ8VD8MKhpuNcN9x6L6Thnb/rS5gBqI1xVzRRZ8KlAe0LoXSnYFP/Z
        9ioA0vAFMyL2ikWiE8UepKkN0U2frYqz3DuZlKAo7Kh2vfus1ccOF7CeI21uBgbV
        QAwl15S9poTlj6jsHanV1kBcGzIC8/OJfjOovZ2735bMvr2t54msNkx3OmDm/sNA
        ==
X-ME-Sender: <xms:HInTX04UiqEncL9iGhRjX2l4YlMXKVLZqvnU9ZTnbv50bh2xfMWdNw>
    <xme:HInTX17V5nn_lWoy487w-lLDhmZUUVcn8yR5k0TmPPfHsGvGF4S_kjj4Alh4fr91c
    06xv5mQt95RjZMrOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdehvddruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:HInTXzelA3mMugw9i7FuknwzsfUx2nAo_juCflVEPh8qcLn56nI9sA>
    <xmx:HInTX5IulBIerwB6Y4qRUElu66dojLz1zHqG-WI5aRivhxe_7xeA6Q>
    <xmx:HInTX4LEytEOvtAUFzl477OOPYvAd3a-AX3Fz-V0TZ6DQDq2ZpB_7Q>
    <xmx:HonTX83CfxUbwDEWAP2sc-J2B9eSem9bVmoVWmpel7qa4o7R8HuwMQ>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D1D824005A;
        Fri, 11 Dec 2020 09:58:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 1dc32678 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 14:58:34 +0000 (UTC)
Date:   Fri, 11 Dec 2020 15:58:33 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9OJGZhJFjqG/t3S@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase>
 <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
 <X9OFRiqDDYtbg87i@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3WkKyvvWai+ABszO"
Content-Disposition: inline
In-Reply-To: <X9OFRiqDDYtbg87i@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3WkKyvvWai+ABszO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 09:42:14AM -0500, Jeff King wrote:
> On Fri, Dec 11, 2020 at 09:27:57AM -0500, Jeff King wrote:
>=20
> > I don't know what kinds of variables you want to set exactly, but
> > another possible option here is some mechanism to point Git to an extra
> > config file. This would work if you are setting a bunch of options in
> > some static way, but not if you're setting them to custom values for
> > each command invocation (because then you'd be dealing with a temp file,
> > which is annoying and error-prone).
> >=20
> > I'm thinking something like a $GIT_CONFIG_ENV_FILE that is parsed after
> > repo config but before $GIT_CONFIG_PARAMETERS.
>=20
> One more (probably insane) idea, that you are free to ignore unless it
> sparks your interest.
>=20
> $GIT_CONFIG_ENV could contain an actual config-file snippet itself.
> I.e.:
>=20
>   GIT_CONFIG_ENV=3D'
> 	[foo]
> 	bar =3D value
> 	[another "section"]
> 	key =3D "more complicated value"
>   '
>=20
> In fact, we could have implemented $GIT_CONFIG_PARAMETERS that way from
> the very beginning. I'd be hesitant to change it now, though.
>=20
> It doesn't really make your quoting problem go away, in that you'd now
> have to generate a valid and correct config file, which is even more
> complicated than shell-quoting. :) But it is at least a well-documented
> format whose generator might be used for other things, too.
>=20
> -Peff

Our mails crossed, but I did have the same idea. I don't even think it
that insane -- the format is well-documented, it solves some of the
issues I have and implementing it shouldn't be hard considering that all
infra for it exists already. True, it won't fix the quoting issue. But
it would neatly fix our "global config" problem without cluttering
output of ps(1).

Patrick

--3WkKyvvWai+ABszO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/TiRgACgkQVbJhu7ck
PpThKw/49jJfhcE8V3n9HFUYcqGoxpYuDCyBMXIOnHABzimIZM3kDd+I0/KdiNmd
O3FbuA7pZ2at2K/OR+sd56YB6Cv4K9yzIa19Jva7PzZ/OGYX5fPC2AQCAg5ulO1D
sNCP+f3L+e7szUk+yWqlozJnRUconhxcgFUatBNemBc8BU6vlgWJ6LmQMSh3vnaw
gevEukz9Zaw8KRT56LOhy5u7KK/+FsBnsiDA8JVa6a4OQKkgH2UGWhWwYrBq+RUg
ITNqB4ryFmfUo4zf6jewvfVztUegzZIv9L4XGACTx+s4T1WlXzyJ23mk9id2akkV
MP6/ZZ3qKewDmPmIHElb/RxPuuQ8rKtJJflp/q+e1YdQeZ/XXBsmUgPMFFMNRThW
XfGSPN8Pp3UwmrsGBURbOvgyi83ZgM5gOZFVuC2linL9ExbQCac1uVNbrzNoiL5J
60bZXFPrdTAueMjfSGcU8ep97XZfPEoLeAASsTxHDonQ7VplbSCp403/yIvDHXVl
QYkHU5wAW8ScP5/BKE0JqLV8bHRTgh+7X77pI2PRglEApUV5tdMyR5S1rXNwRn12
lz+oCu/Kj5cUfV8Z6BP2WIZcZTq6Lu9vSi77j9/87j62I6xxOcdhKwBuuEyNI2cK
Kd3ZL1jRM94uUMdGCXQ+GaXIQHxd8c2GCrS2lezrKpmNdf0LBA==
=sbEx
-----END PGP SIGNATURE-----

--3WkKyvvWai+ABszO--
