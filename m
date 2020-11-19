Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0576C2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 06:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E952158C
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 06:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bPrUGW/Q";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cLMvUJ/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKSGhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 01:37:42 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34003 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgKSGhm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Nov 2020 01:37:42 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C9985C01A0;
        Thu, 19 Nov 2020 01:37:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 19 Nov 2020 01:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=5a6cifWPVdjYbNl+g/JW8rzoSnWfrg4UJ9b4BViv
        XRI=; b=bPrUGW/QSYug8AAWb/2nLGvDHsnhfW1MXt2588qZxviEUFcKL175tf69
        85YEl22PWm5S+e54TDmqW2k0oMQt/NxC4GbBC5nsih+oAThegQtUVsdaUv5bDefb
        /R0FBWWLXhp0oXGcX8fMtibTvfuTNOkKRiYaSY2weAFVaoEOfmoN9738rhbEFwpr
        DsOLFfDDcxS6c7TERDykEIdItK7UeLsvIx8PbwMaAQuM6Y8nwWRpABy8+uAGxQ1/
        FrinVtUR/wsEj64IjECiTzVdZEM5AouNwN0b8eKC/iMnImsmHS+jOU1uU8ZNZCbW
        KKaiYJF0xizsE+fX1Nbo1pOGGW7c7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5a6cif
        WPVdjYbNl+g/JW8rzoSnWfrg4UJ9b4BVivXRI=; b=cLMvUJ/ZeMP0lCV9dobewy
        q/fXgrPbq+UASjf1lJZG2C33zQPM8rtDTqBopOrl/oDWfUPImqLiqAgosgyGFKuX
        lVMIuol1WERXe3wV5UQrPp4sl97Xyw2ShTUFqbMOtx/jiuNik8TjpBAAc2OPdLBn
        to1rGTmlyJFc7DOIEh+q6plc3NFsl1hil73n01J/qhAd5FG+CpcpWby7YNhUitEj
        0IEKSz305rZ8cUYuYliSOxSXtl1z8e8TCmH6bwyN9ET4WOoveOd06OqpmJQgVhEf
        YYhZ3JRyzP4RmN1C7sASsXLjHbMLkTWbPXWqIrIzE8f9OPG3tQAhQH3lp5PZuh/g
        ==
X-ME-Sender: <xms:sBK2Xw6IkFjdKQZ2hQQVW3ZD1rNNsHUR-QHpFDP-cINrHHoIeK_muw>
    <xme:sBK2Xx6epGhu7XUw8gGAsISOoaCrGXCOCza-zTYz4FeQMVozsCvtBHzMBazqXLwvd
    vcmZ6okWy3MfTRVzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefiedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudeluddrvddvrddvuddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:sBK2X_eeLjOW2KMPZP8yjrh39Dn3AcNhfI7DbfBO-Gg2tp4jGfCVPA>
    <xmx:sBK2X1IFQ7DpPf2dZKLDxKwXfqRcrpnp-z9ZFKuvpI4zvAHkpboq7g>
    <xmx:sBK2X0K0LIP2Hrycc-dPcmzkvKxw9iYFN6r2NXSUHoBfM8eMbtvATQ>
    <xmx:sBK2X7VHDXX7ByW5uuOBETR803a85sW4rwweJcXZz5a07kcjzlcTSQ>
Received: from vm-mail.pks.im (x4dbf16d3.dyn.telefonica.de [77.191.22.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 389213064AA6;
        Thu, 19 Nov 2020 01:37:35 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 62abd138 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 19 Nov 2020 06:37:32 +0000 (UTC)
Date:   Thu, 19 Nov 2020 07:37:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <X7YSq9zgTgfFCF1N@ncase>
References: <cover.1605269465.git.ps@pks.im>
 <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
 <87mtzlflw7.fsf@evledraar.gmail.com>
 <xmqqy2j1851k.fsf@gitster.c.googlers.com>
 <20201117023454.GA34754@coredump.intra.peff.net>
 <20201118005014.GC389879@camp.crustytoothpaste.net>
 <20201118015907.GD650959@coredump.intra.peff.net>
 <20201118022532.GD389879@camp.crustytoothpaste.net>
 <X7THfjaP91+GV//V@ncase>
 <20201119021116.GE389879@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HXOmDMo55RM/jxEz"
Content-Disposition: inline
In-Reply-To: <20201119021116.GE389879@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HXOmDMo55RM/jxEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2020 at 02:11:16AM +0000, brian m. carlson wrote:
> On 2020-11-18 at 07:04:30, Patrick Steinhardt wrote:
> > On Wed, Nov 18, 2020 at 02:25:32AM +0000, brian m. carlson wrote:
> > > Sure, that could be an option.  It's the simplest, and we already know
> > > how to handle config this way.  People will be able to figure out how=
 to
> > > use it pretty easily.
> >=20
> > At first, this idea sounds quite interesting. But only until one
> > realizes that it's got the exact same problem which I'm trying to solve:
> > there's still a point in time where one can observe config values via
> > the command line, even though that moment now is a lot shorter compared
> > to running the "real" git command with those keys.
>=20
> I don't think that's the case.  This command:
>=20
>   git --env-config a.b.c=3DENV_VAR
>=20
> would be equivalent to this shell command:
>=20
>   git -c "a.b.c=3D$ENV_VAR"
>=20
> In other words, ENV_VAR is the _name_ of a environment variable to read
> for the config value.  Subprocesses would inherit it using the
> undocumented GIT_CONFIG_PARAMETERS.
>=20
> Or are you trying to hide the configuration key as well?

No. I just didn't realize that it's supposed to be the name of an
envvar.

Patrick

--HXOmDMo55RM/jxEz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+2EqoACgkQVbJhu7ck
PpRb3hAAqvSTF5QVkqXwiJXDcimLicqBd9alEU2+jXXlbNBnaajISB9hqPKr/PLb
aMR64eDWP6m2XFsZRLggFzKn6286IVPChpMktxRBpV0XOSU+lD+THe0a67ue33aT
zLMH6jn4TGhXVckI0ldi84eIyBjItsATHCnB1d7GjAz8emSOufnYY5PWACxpGq31
yfhcRWLAwvHAgwavMPVTw/4sdjmqkYvASlYXIc+WdnFctapCYZcgUyWwQim12Dp9
cFxRoALRc4ciQhUBGI/u9c8sJjQZ965Vo5151i6TfkMh2LZ+9I2lmu85PS0e2llw
CQy40xlQficwTza/m3t84XGpTW5gk6fiVbV+QbjejLZTvbSj0tcsihUgb3iB9TLK
5AQvkFFbBc9CBdolQl2DYNSano/CCBrvVr4lTsSaqd+/MNsmR7aMVANsa+ywupTy
c2MWVejwwqS0/hlGvmfQBHW8AHbcHk+8OKIKsMtG1nSv7NbhufDt0ZB6M405PkK/
aFLZK+mgTEvueG+ms8k2sC7QNxr17ziClWa5oiL61pKyc9IPxPTlsMEq5ApePRLz
pYnqpGJ/ea5EEJsUhEQiBmh8va/JtQq43MtZecRu4bxRsXu2XhMzu78cKJ6jLJLj
qn2k1mQbKAYwaKKG0nJLviqSV15o8NUCczT6lKnPjTO2i6VszV0=
=EVMW
-----END PGP SIGNATURE-----

--HXOmDMo55RM/jxEz--
