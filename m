Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB763C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF4861007
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 15:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbhDSP1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:27:53 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:42539 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233733AbhDSP1v (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 11:27:51 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C8113746;
        Mon, 19 Apr 2021 11:27:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 11:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=dtCbe6EXnKK0+jEuLiCtgkO8OVA
        bhqZEgf8uTLtJYhY=; b=X3zdfBP7iXOwrcwv4w05+ssMU2rZXo9tnqRMy8IqIXG
        NpL92CutbZCLZCBEWaClX07JGWnRRIqy4FZf9x5ckHZzZvPltmf5sUyTwyxb1nG4
        vTVj11paMhi8wvV2kYqapjvpCXnhSKjbZuROE6vzOj/6prjbBV7YNBAB2ZAB7ECX
        ApPZCusrRz/iaMpD7sJtv5yIh51wpZ7aMGoDESqX05YqLCJ15p9hejtZuktps/Yj
        ygo9Y8nKKgIzhCxaqbbeCGVWuBkqDEuahQd/rio3y3TcLKVmgoKu3CJSfqTPYtPL
        W87SGk/67d5OrNa3x/ri+hIuWVRWlVa/TPm0ZMw8QdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=dtCbe6
        EXnKK0+jEuLiCtgkO8OVAbhqZEgf8uTLtJYhY=; b=emi4iHvZd7LYG/+EdkV4N0
        vcOPkhrqSxSy8MjgzWQBEPG3DM/Gf3+Chv5LMl5ZVmt7bzLib+R/5NoqGNwyty4r
        EblgMuXy48bIGK0GR/42c6p8E0XOtR/KrY+ERG2yALcRIv+tQX+celvKO3OYz1Es
        vW9TyyoYbrG/NBeLK2u/l9ohBdY+6QK+tMpDGvfW3ZFjm+IrU6Iq2nF+QNLwNvvq
        DJtGn4TBQufZCjKvmNv2cemnJhbjoq6jSeKYJ75Bwurr4n5rJ6bn2GqOt1y3E6ur
        AeNIQTjcQQLDZsrCHujnQQh8k625kwjJ4JZGrw1NPnHW08u4nh0zdlzIt5RRiIVQ
        ==
X-ME-Sender: <xms:VqF9YHgS7OLrVqkLSnN45pWuIx6Hi3B3-aLv7wvZGkxcwZGrJEWFsw>
    <xme:VqF9YEDJsRUHoKL7CIh-PFxVvI3BktyeGEiU_4FEGaKxX4HAz3vazD8IlVkIUfhhL
    NST5g3Ktxl1YALUIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:V6F9YHGI4vWzZcn28DAdrpkbrAj2rieZwe9gyNDbuXFSP8ZG_gJO3Q>
    <xmx:V6F9YEQKGUPZv_Yi0UxPifFR1taVXYu5cdY5QxV8rkI3VtpLcVMYEw>
    <xmx:V6F9YEw71rvxqkpmK-b8Ha_krVoc3DlaMN8pSzeY8bC3Eg388c7a7A>
    <xmx:WKF9YOtc8odbD-kiuvfzriKgyNtixOQFzz-bdeUoEefFJngvT6B7KA>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 00659108005F;
        Mon, 19 Apr 2021 11:27:17 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3738c967 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 15:27:13 +0000 (UTC)
Date:   Mon, 19 Apr 2021 17:28:42 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
Message-ID: <YH2hqhHh1eh+U+6h@tanuki>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
 <87o8eeteyz.fsf@evledraar.gmail.com>
 <YHqeh9MeRDADviU0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZG7GGoy+x7s449us"
Content-Disposition: inline
In-Reply-To: <YHqeh9MeRDADviU0@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZG7GGoy+x7s449us
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 17, 2021 at 04:38:31AM -0400, Jeff King wrote:
> On Fri, Apr 16, 2021 at 05:40:36PM +0200, =C6var Arnfj=F6r=F0 Bjarmason w=
rote:
>=20
> > Bonus points to anyone sorting out some of the existing inconsistencies
> > when fixing this, i.e. --exec-path supports either the "=3D" form, or n=
ot,
> > but various other skip_prefix() in the same function don't, seemingly
> > (but I have not tested) for no good reason.
>=20
> I suspect just because it's more (per-option) work to support both
> types, and nobody really cared enough to do so.
>=20
> > It seems to me that having a skip_prefix_opt() or something would be a
> > good fix for this, i.e. a "maybe trim the last '=3D'" version of
> > skip_prefix. Then we could just consistently use that.
>=20
> There's a similar situation in the revision parser (which does not use
> our regular parse-options). There we have a parse_long_opt() helper
> which does the right thing. We could use that more widely.
>=20
> I also wouldn't be surprised if we could leverage one of the
> sub-functions of parse-options, but it might turn into a rabbit hole.
> Converting the whole thing to the usual parse_options() might get
> awkward, since many of the options operate at time-of-parse, not after
> we've seen everything (I suspect many of them don't care either way, but
> you're always risking subtle regressions there).
>=20
> > Or maybe there's some reason we don't want to be as lax as --exec-path
> > with any other option...
>=20
> I can't think of one.
>=20
> -Peff

`--exec-path` does two different things based on whether you pass a "=3D"
or not: either you tell git where its binaries are, or you ask it where
it thinks they're. It's still true for some (most?) of the other options
though.

Patrick

--ZG7GGoy+x7s449us
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9oakACgkQVbJhu7ck
PpSzVA/+MHsQjEf2GBwt/VxEl/qmItFU0lICQcAYxDeiUBZDUcqKnWD0tJqusqXZ
V1RqxYgPItoFvKUPTJMyWmE9oBnd3WbsaIQFlyLO9WWku5EYMKwTx4wHdv84rH/+
yfwFHLik+i9lpkh0xbE9x0t7zdl2YAv/5T7eEuK6+kY24eR+xNfwyXXfh0wjAolf
s6Am5oiZOqT9Pyx/lgGODwKonWXC9tTMzkc/2itNYrtHX0G4EVKf6PCs9fj7LjG6
udTFNnhbQ89pgrnGos1TciTahfKr0C8oQxBB7OqigZ37kaFGD93GvSgZWoDmHj5U
kJE55M+d7KiJH+yfRp+ctOoo7dAoCiKbh1KCXl82UDmz2OCYNc0WPJphmtYV4KGw
OobhPBsEtrztwF8e4XMGXEn28MENiP8L+cgZae2H9hMxkBlOvtD1K/fcg+2mucRw
abK9C3sY+Aw4C31iiSXG2l1xg6bUq8Bx08Q7n8eFDysfaW6xr97gN/SYPhXVxgwb
EzLcgbL+8yC1KGM0rkMmFQzgb3nSgRS1aHyJLX1auJhBUWBYwYB2qIo6h/bq2XlG
LgFiVqAcuMetweWPCP2ZinqtlS2KyiNEivzxnSo0ndNQn0HmR+RBBaiuOwFx1xyc
1T2PrJsLcrYAMUzl5T0nHP7BfEjEJqNp5HwQGq9j+oFWjSeLZ3g=
=kjTR
-----END PGP SIGNATURE-----

--ZG7GGoy+x7s449us--
