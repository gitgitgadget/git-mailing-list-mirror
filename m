Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C21FC433ED
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385FB613C3
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 11:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350556AbhDNLcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 07:32:55 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44119 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhDNLcy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 07:32:54 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DEA1B5C0150;
        Wed, 14 Apr 2021 07:32:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Apr 2021 07:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Gw7YWGGXZhy5yQRtyIywZMKyr+W
        8Nt59ze0XvK6ISCE=; b=YLTBw3xos9Xx5BEyoB43sgFguD0gWb4kFOMDKmV9nO5
        FG3XXkn+kXxwI+UCOJUIzXk/MEJRSrfsXK1HKq9mFMqhj5OpZ6i2izzDfqsS7Fe3
        XIph3SlTzYRgsaIp2VVnb0v7x93M9ZDm8RcC2Lcsyqe0pWn58vged5R66stHqt6U
        qCiUQlIgLDNgORh7td+5w19fia2NUEg5oPeJgX4q2A66JsUwsvQJbwhv4c7rjZe8
        BCk0R7OKcxR6rC5yapf6teK60wDDE6Yvf4BtbQt2EG7ksUSmQySRH5KKn/m+lsx1
        Uosv1pZYTAAFic/e6TRAqQ2e0j/LoBcHeid2Kv2Y/pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Gw7YWG
        GXZhy5yQRtyIywZMKyr+W8Nt59ze0XvK6ISCE=; b=fE+KUfbBhLD4VU4tXDI1M4
        kF59hOI6G64581YiI1efM6v6YK2XadKCdbuRqGDWnH0xAC/S1KaWXMow/VS+q70Y
        5hEMaKPsNupd3mFyK/fQvW5gWSaqoPVGdbQVYPkvYJJQDIvmMZLkv6niWtpbOZK/
        i6UOiUIlSmpj0+hWgvQtkKwSp8U00SWSOrUsPow1WKdMOmGrBWx7iugcf706jQ0c
        9k9kTxydDcolF12zjMYNKVpj9hfrEY7TuHR9zMLmV+FlH1LF7UabgjYm37uaMTYX
        Zma4cv3Q5qFG9wzrWVcoJPXtOWysGhEhux3Kv91Va/6bKrgm0U4cb/MyUww9GL7A
        ==
X-ME-Sender: <xms:0NJ2YHVVEzHKkPbeLv2Cd8NB5VZEyaKkHPKYqf8YZCRzhgyhLR3w2g>
    <xme:0NJ2YPmc1Mkh7RH6dox8K9tJKvOe3I4pWwHm5-DpNXuV7oyqK2b0ppN8DDYXGFaWW
    R7V07Js5o0JdZ38QA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefiefhtdfhffelgeefffdtleeffedujeefgeekieeitdfhudekieekjeehleevvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejkedrheehrdefgedruddtie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:0NJ2YDbkeo9zR6yLzhmTnnSglEIgFR-_nvBe5FwCPhNLWW8z6k584A>
    <xmx:0NJ2YCUbB_sJUNpE9eOY-F7BL5KGWqDKgPfhaGzg4rtD8miOzj0C8w>
    <xmx:0NJ2YBmRyZwFG9By3ZXF9cjeiDX24TXZlx98nuRUb9vrO_YIPHQ2kA>
    <xmx:0NJ2YHjnGCYI0vT51EssQfM2UmjcyjkXDYDzrfbVCicUWzsYqYaehQ>
Received: from vm-mail.pks.im (dynamic-078-055-034-106.78.55.pool.telefonica.de [78.55.34.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FEED108005C;
        Wed, 14 Apr 2021 07:32:31 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 994259ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Apr 2021 11:32:23 +0000 (UTC)
Date:   Wed, 14 Apr 2021 13:32:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 5/8] list-objects: implement object type filter
Message-ID: <YHbSxl3cVsJUSKGp@ncase>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <d22a5fd37dd793c78b1ac17244601cadd1f7c0c9.1618234575.git.ps@pks.im>
 <877dl6eccv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i0n6O6MqPF9nNC7P"
Content-Disposition: inline
In-Reply-To: <877dl6eccv.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--i0n6O6MqPF9nNC7P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 11:57:04AM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Mon, Apr 12 2021, Patrick Steinhardt wrote:
>=20
> > +	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
> > +		int type =3D type_from_string_gently(v0, -1, 1);
> > +		if (type < 0) {
> > +			strbuf_addstr(errbuf, _("expected 'object:type=3D<type>'"));
>=20
> Maybe:
>=20
> 	strbuf_addstr(errbuf, _("'%s' for 'object:type=3D<type>' is not a valid =
object type"), v0);

`strbuf_addf`, but otherwise I agree that it does make for a more
actionable error message.

> > +# Test object:type=3D<type> filter.
> > +
> > +test_expect_success 'setup object-type' '
> > +	git init object-type &&
> > +	echo contents >object-type/blob &&
> > +	git -C object-type add blob &&
> > +	git -C object-type commit -m commit-message &&
> > +	git -C object-type tag tag -m tag-message
> > +'
>=20
> Does this really need to not be the shorter:
>=20
>     test_create_repo object-type &&
>     test_commit -C object-type blob
>=20
> Or if it really needs the annotated tag maybe that + --no-tag + create
> the tag after, and it can eventually use my
> https://lore.kernel.org/git/patch-06.16-8d43fdd5865-20210412T110456Z-avar=
ab@gmail.com/

It must be an annotated tag because that's what the `--object` flag of
git-rev-list(1) is working on: objects. But anyway, as you say I can
still use these two helpers and then manually create the tag.

> > +test_expect_success 'verify object:type=3Dblob prints blob and commit'=
 '
> > +	(
> > +		git -C object-type rev-parse HEAD &&
> > +		printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob)
> > +	) >expected &&
>=20
> Just use > and >> or a single printf with two arguments instead of a
> subshell?

I don't really mind, happy to take this proposal.

Thanks!

Patrick

--i0n6O6MqPF9nNC7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB20sUACgkQVbJhu7ck
PpQdIg//VnPcwHpv0zQyIksR8zDHeKaTra8DJGfZMyUh5hQ5/dFQ3JHtr8xlBBDw
d9mCt00CQ9y87dhfPrK0oPgwU8b5pGRCjoHHlHAtHvCqeoJgGr3WTI2A1HB3O9a2
31cwX3/wLipTA4yr6ufzjg4xrw5nF+bMF4GMDacmwqwfT6yZLSeyfupSyaBZe6Ea
JLD+hN1Vq2muPc52niFZ3HNb2rEZYS70Flxp3HJgzc5G3C7wrrets57bzNerE3Ra
BAnTAoI4Obu+x6s7tQAQkskq//MqhLVUDmQa7MyJ4gnB1IBbR5EZkZShhKGyHHlq
Kov1AJDVJ38tOPnK5+9Zm7HpJjvT0inpb2UtF36YEZ6FP2ZxXjN/pMEY2g8ugoGY
U3Ink3WCqLU9x39ESmv959frkqHEHbCynEMDEprK2eKlOMfhV5lXBscuh6y1ruEB
jbgZJecWqvObpa7HUlxYqwC+DcW/eGHmZd5/ugIf1J8Baz0dyUtO09P+tdCv06bS
2DEI9Tr7jVIgzzLuPoTpiArPY+0qYxYwgEgojopI+1EnozwgmnncOPKbb1n2WI0p
qnNIQXfz0SD0OvOSnceQi53eKA9pQLqgCSTDCxtIc28I1QzFX4JvuiFg/rdH146O
z2Ll8DPTiEHoDVLWfWkY8gjWAxbKtoFF1YTu/VFOEcNmDKNNZcc=
=7zRX
-----END PGP SIGNATURE-----

--i0n6O6MqPF9nNC7P--
