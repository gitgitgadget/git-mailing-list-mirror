Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C14CC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B9C20857
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ral/y2zH";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8mKGTCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKYH5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:57:10 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52399 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKYH5J (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 02:57:09 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 869115C015A;
        Wed, 25 Nov 2020 02:57:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Nov 2020 02:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZKmm2AaaPsT9zUczEwyomrdxaJm
        2Xt5Y83y8g3AlaQc=; b=ral/y2zHQrL/9/+dDMDpbm4QTTKeK1XHKJSPYOCteHa
        8DlEXS/iqWOZJDBwsJFt72xNmpowMjf0tVyZ5f3Dbw4KXVddPG19iQuDnWOJkeCb
        9MWfREVUuMi31xIhuvXYjpKVFTaNWUa65Vn0un5FT0iW6/kuq5OdSrf0Bb0fpDMf
        z1vz4uKk+uThHvPe5Nv7ai2Y6AWAn6ovTG7ZCHnFXMpr0nCqInmK/e6D4OUaJ5GK
        TlA2FIT7gyEEUuxVMH7MlFXi4bcfckoAUQM7O6771gc35ohFaK5iqaShYgDoACxY
        cEETJz+Rq0WBAPJYjflyLEyTC3qmuaSY4Dd3Xz1qUHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZKmm2A
        aaPsT9zUczEwyomrdxaJm2Xt5Y83y8g3AlaQc=; b=U8mKGTCu4mvcr6xTZ0l7Qy
        aTU66I+VHPtT4Y5ZE9tBtnz8CxMpE4Y88QjMemm4zKyFOaBbvgc0qUhYgW/9CXdB
        a+Ypq/B80xiGDmFqyNfN6eh2xF/MqOIcySstz5Zx39DhYlqhTPwQfSiZeAESZ8nc
        WpWqvQR52ekSZ1UKoSIqBqQ04hPTF2BbP0MdAdH0lRCZlThrBb1g80ksaPNichBu
        P16ktZYfcyN13lCvn7D8pBviNP7FyjBtbUkRIrD786ZEuhq+H/TK8IBQd3FLbXDu
        WJ5eDjdV4nltSU8qTcQC2jvTZv5Bo1mJdVx/Z6mXK0omqvDeV7klaaZp/7t2qSGw
        ==
X-ME-Sender: <xms:Uw6-X570WgfAzTYwQu1TtUtuuvCczGZpsVb3bEe-oNpZ0lyxjuLOQw>
    <xme:Uw6-X243HqfXBmHHCB-lOD4jjS_Dk99L5AdeLHwfKYkAwOvBHcrcESt7quaAkC0u3
    Jbbs1aZr3ObrQ8WGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejjedrudeluddrfeelrddvfeehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Uw6-XwfGcsIZeXVwWaGl1MpI4Yl_GwQiX4_-v_oStJOYsHyZ7h-Pxg>
    <xmx:Uw6-XyIHIM4VBfn_TKtyZah9qgcsKFOmZjmYQoHYKeYksGrvRWcQ4w>
    <xmx:Uw6-X9JZp9Vaqm_BslXBCX8CZu7oz180ebSgbQXkrj9x5CBlKRds4Q>
    <xmx:VA6-X92HRrCmM2d5mHvzg37Rgc_0axHCfkANaOFKHu_IzpDsRvtKIw>
Received: from vm-mail.pks.im (x4dbf27eb.dyn.telefonica.de [77.191.39.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id D6C833064AA7;
        Wed, 25 Nov 2020 02:57:06 -0500 (EST)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ca00dbba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Nov 2020 07:57:05 +0000 (UTC)
Date:   Wed, 25 Nov 2020 08:57:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X74OblVAeE7PVJOP@tanuki>
References: <cover.1606214397.git.ps@pks.im>
 <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
 <xmqqtutef6kb.fsf@gitster.c.googlers.com>
 <X74CigYS7AUtMo9Q@tanuki>
 <xmqqpn41g9xt.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J73pi6KODj6DDauY"
Content-Disposition: inline
In-Reply-To: <xmqqpn41g9xt.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--J73pi6KODj6DDauY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 11:41:34PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> > +		for (i =3D 0; i < count; i++) {
> >> > +			const char *key, *value;
> >> > +
> >> > +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> >> > +			key =3D getenv(envvar.buf);
> >> > +			if (!key) {
> >> > +				ret =3D error(_("missing config key %s"), envvar.buf);
> >> > +				goto out;
> >> > +			}
> >> > +			strbuf_reset(&envvar);
> >> > +
> >> > +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
> >> > +			value =3D getenv(envvar.buf);
> >> > +			if (!value) {
> >> > +				ret =3D error(_("missing config value %s"), envvar.buf);
> >> > +				goto out;
> >> > +			}
> >> > +			strbuf_reset(&envvar);
> >>=20
> >> Didn't we got bitten by number of times that the string returned by
> >> getenv() are not necessarily nonvolatile depending on platforms?  I
> >> think the result of getenv() would need to be xstrdup'ed.
> >>=20
> >> cf. 6776a84d (diff: ensure correct lifetime of external_diff_cmd,
> >> 2019-01-11)
> >
> > We did, but do we have to in this case? There is no interleaving calls
> > to getenv(3P), so we don't depend on at least $n getenv(3P) calls
> > succeeding without clobbering old values. It's true that it could be
> > that any other caller in the callchain clobbers the value, but as far as
> > I can see none does.
>=20
> Doesn't the code expect "key" will stay valid even after another
> call to getenv() grabs "value"?

Oh, right. No idea what I was thinking there.

> > It is required as this is what sets precedence of GIT_CONFIG_PARAMETERS
> > and thus `git -c` over GIT_CONFIG_COUNT.
>=20
> OK, that is what the "will be overridden by any explicit options"
> was about.  Perhaps that deserves an in-code comment, something like
>=20
> 	/*
> 	 * process GIT_CONFIG_KEY_N/GIT_CONFIG_VALUE_N pairs
> 	 * first, to be overridden by GIT_CONFIG_PARAMETERS
> 	 * inherited from parent Git processes' "git -c var=3Dval"
> 	 * later
> 	 */
>=20
> before we check GIT_CONFIG_COUNT and loop over the new style
> environment variables.
>=20
> Thanks.

Will do, thanks!

Patrick

--J73pi6KODj6DDauY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl++Dm0ACgkQVbJhu7ck
PpQvYA/8CulrRqh8DyZuTb6okJMIBTbGrlAvhqWhQzc0dSW2JqpQWsgqEC81VEUy
UlrQM22Hx5ZYdTNVmNxn7mJMV06g6ADbWqpZ9mwcwsCRjoa0LUeR/bUSktX7rMYT
f7PuAqdR0TyniPNn2h6COdqhua19+6FKPenOgzKeFA5YnN+8FJyltsAiaPmW4jaL
lOVL8Po3QeLBkMdphd6MbQfcvLGMKMlJJBWwwQuFfALxOserIVYBbMcZFNp8UH/J
IUlR/U+7tvmXYE67VvRMr+eEvr/RQLDfc/L9p5qGsWEuzl0XNf2ud+aZDRoMo7HQ
D0SZ7W+9n53r0+NaAtnboNvJEPxz7B4bdQhlEmbg/YwnuTuWMUQLMgssLB/DhTQO
HE2iS1PAe14atNrqyJ11tgUSNyeM9UJs//WHLi7tZOm44HD+N0HSLiEStjzDLjX3
jx18YbFVFKlinhYjUYAfjHsHygY38A7HmLxef8Dr2pylhFwNE5C8YCtVxCkwMMXr
5EArq76yOPGXy6Ndk0kL2707UT0aMwwvCBuhS7Vzg2+QMmXc0DHrZNaviW1cU0OM
qHWgd8qori/kI6pRkk/RhBNmHiRo6F1ztk46h5EhnL0s+3T2HNu17HOlm+7EFgOF
Rsy6ZALFiahZ+f9eP4NOwoDmeegCGCSv6CddJbZmWgomlkmFo4g=
=JKju
-----END PGP SIGNATURE-----

--J73pi6KODj6DDauY--
