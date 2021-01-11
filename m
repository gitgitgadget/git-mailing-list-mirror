Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3985BC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA9F22AB0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbhAKI0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:26:09 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:45589 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727868AbhAKI0J (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:26:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F031723F8;
        Mon, 11 Jan 2021 03:24:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=fneHioV6JMmw7Sza0OnD7SUwzP9
        EF5l5s0GP7iE4UPg=; b=B3Tcoe6Y1p+748OW4d87OT28lUeeNBppnNvMOUjKkU3
        l+7CVLo4VlG6jjmSaKhEn5iKG2kWWwTT2JqGd+tiflVxdeJew0EOmTCWlbZ4X1IE
        mTc8/6byY2oa6DAFLE9NjILetsfeAJNdWr7XTo8OEOpWTknEuUFpu8YowJ62BUnQ
        0Ag+UmF5Hr6qxeGsokYVr8TygyRIcRfRJ8sjUh+B0trs1PFVRb4ab1qtvFDCqPYB
        zo41c3Ed0bWAI8BykAVn6tn5A9fZz5azEhjLx9neYNByXWWuAOI5JgGqk+/8SVdb
        UCmYQsWznhVZZmi47znIOBqdompWW9CibIYv0U2ryBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fneHio
        V6JMmw7Sza0OnD7SUwzP9EF5l5s0GP7iE4UPg=; b=q2WYG4pLtezLYsoXeQSbur
        BmNiEQEjof8yS0QSDVDMDK7d/OVJncbVb0DOACKUHYhhdHJnkWaKYnyqLVyr1kVu
        aPsaqebpW2yL4Pg7/3BZrMD9/XtVsSnjx3AVogv+YhNQbF9t3H1r/jBtjz9aW7RE
        HvEPV87jtmgR1AOUAfaA7H2Iunq6Sfyi7goWoVB4LRVgjqil5pQblvrnIZQNvzBX
        aIDQd28FFLZaivKwkz2VzXOLQZATOD4LwBD/u5zWsnRyq99zjn2H8OPTACGNSW4g
        AgzXDQf7/i0PIdL/5ux+QigmfoKgO2cRi3tpxZSqee8/SODjD8cseuw2CFKOQsLA
        ==
X-ME-Sender: <xms:Vwv8X3sOz6s_kINTObmmBa_mB2SaAXLqkBjqpIPc2q4-Dz0cCTlO5Q>
    <xme:Vwv8X4fIhXmEOQbOnskppHurtCb9dvj-kSmYc_CYYSVvMhiICyyVD-_eNZ7RMP-__
    iE5F2boKRHv83J4-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Vwv8X6wD9NXncnETvfj8fiFbEbG1ph2s5yCmwmoFI2VNt_UStsV3zA>
    <xmx:Vwv8X2OEpSPuY2nG9FSvP8fNC09W9Gf71f2S9V--6I4DP3Ubffwa4g>
    <xmx:Vwv8X38U8gNLZCPLry3n06vGWApqxzo0_QToMez6y0RV5DkmQuUDDw>
    <xmx:WQv8XzbjUnzXclAH1PA6FMJz0mh9E8gBw2sSiiK0El75dI8bOvEcXg>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1E8124005D;
        Mon, 11 Jan 2021 03:24:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2f6839b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:24:51 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:24:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v6 2/8] config: add new way to pass config via
 `--config-env`
Message-ID: <X/wLURSbxN3jS4eH@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
 <9b8461010e641369316d00e2fc58c16e0e191f42.1610001187.git.ps@pks.im>
 <X/tjtVGRKRhX0ZvU@ruderich.org>
 <xmqqr1ms8gfm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d6EHo/zbMIoGWOBF"
Content-Disposition: inline
In-Reply-To: <xmqqr1ms8gfm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d6EHo/zbMIoGWOBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 10, 2021 at 04:29:01PM -0800, Junio C Hamano wrote:
> Simon Ruderich <simon@ruderich.org> writes:
>=20
> > On Thu, Jan 07, 2021 at 07:36:52AM +0100, Patrick Steinhardt wrote:
> >> [snip]
> >>
> >> +void git_config_push_env(const char *spec)
> >> +{
> >> +	struct strbuf buf =3D STRBUF_INIT;
> >> +	const char *env_name;
> >> +	const char *env_value;
> >> +
> >> +	env_name =3D strrchr(spec, '=3D');
> >> +	if (!env_name)
> >> +		die("invalid config format: %s", spec);
> >> +	env_name++;
> >> +
> >> +	env_value =3D getenv(env_name);
> >> +	if (!env_value)
> >> +		die("config variable missing for '%s'", env_name);
> >
> > I think "environment variable" should be mentioned in the error
> > message to make it clear what kind of "variable" is missing.
>=20
> Good observation.  This parses foo=3Dbar and complains about bar
> missing in the environment; It is not a "config variable" that is
> missing.
>=20
> It is "'bar', which is supposed to be there whose value is going to
> be used as the value of configuration variable 'foo', is missing."

Indeed.

> I wonder if we should also talk about 'foo' at the same time as a
> hint for what went wrong?  E.g.
>=20
> 	die(_("missing environment variable '%s' for configuration '%.*s'"),
>             env_name, (int)((env_name-1) - spec), spec);
>=20
> I don't offhand know if that is too much info that may not be all
> that useful, though.

No, I think that this error message is quite useful as it points out
both what's missing and why we expect it to exist in the first place.

> > Btw. shouldn't these strings get translated (or does die() do
> > that automatically)?
>=20
> The format string given to die/error/warn should be marked with _().
>=20
> Thanks.

Right, will fix.

Patrick

--d6EHo/zbMIoGWOBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8C1AACgkQVbJhu7ck
PpS9gA//cvvql9nPJGJrldY0yh/xXrB0OOzhfsb0Y+TwET8o6C3cPcDNY8GwTAOL
kQr/CHRlgwva1m3pcimNvIptjueFN3BqVhPsYB7qoLC/ivwBHswN5DraSZE1FSvc
oq3S5gzF6iDae/8NNMPzFv/ek4WMvZR0lxngic2OKpL9tYj218X2mMHLrvgTYpiN
kU7iM6dkbBRyHAvD2/wpBdZfvTAy4xSE0+qxgweuNf59b1m5DeRTzHwyLrdie7J7
fjGtuaG9lc87swLXvPKNks26z1n9/yCQpind1oBjUwOFhZVUZ+LfcxmmJ5/i3Bej
Bv53PBWrrqZMqRIxzK4NlIhpBSLCTxZTh8xAG6G6FaqHmjPIjp7LNBVTFbvUCR+G
Lxpsjxzae4Qgek/JkkkkOi4jpBKuFviUTR8B8vU4+3T27ng/1v5p0zQj7ylYU9KQ
2UtR+yOvjEl+/vSktx9MVt0WLisGN/PkgOTiMl/IcbJVsrIz3hEl2L0i1IE1XIRx
FnHPuy8s22d87qn5XZw9Q3FehgRqzdK5NHSNpazEhW9blBeT4CkWFY0MXNDmHY9j
hSVta9q/8WhlQsNYB1/MkqpUsuoqQawHn3khgZP9W4bzQTBkAzn1/iB6tnPDscWe
T3Gd3qr/xhPI/k9DQWNRyY1NNTKBn/+gP1ZK96EID3VWUUWYi/o=
=Jrbe
-----END PGP SIGNATURE-----

--d6EHo/zbMIoGWOBF--
