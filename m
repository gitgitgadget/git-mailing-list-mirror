Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80070C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 14:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjDMOOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDMOOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 10:14:01 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D153359D
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 07:14:00 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5702B5C00D2;
        Thu, 13 Apr 2023 10:13:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Apr 2023 10:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681395236; x=1681481636; bh=Ez
        l+GYSOrESTIp+uZELXCOk115UmgKyI3lHPCu3v7AU=; b=pvsUCr8kdSwqYpu5D+
        lfN1AnmJsdcar4t82Ly2+/JtyIDSg/Ocx3QlyDgcBeuhYQ7ssKkKC5qOn1wmmZ9j
        DHNNWsmwAM09c+yC1Tbux5qF00RrYX+aaqkVjeiivrTxp81zqjTekvb7nw+Al1aD
        CTDQZxTQOcvJeWWgq3fTeusHyvikEypDCc5aTJEyCkjDAlmciQMQRFj8yF8Q7pB+
        ks6exd7EagV2JxezIzROaBu8eWm5gdx3gxw69W1KTNpCMVeYlPcdNvArboCJd2VU
        L6pslGN3TX376HVWSGAgyFd8zW24PMLHmr7IYa+i0FXHtlkhBnFh2XrTMtjE0hAG
        muOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681395236; x=1681481636; bh=Ezl+GYSOrESTI
        p+uZELXCOk115UmgKyI3lHPCu3v7AU=; b=IhQcFevvPJ8r1dKcjhADVp4Gaslzi
        1JL5lwmGJSJPiBruBVUK80/BSJa+5VeKSo9KVLHwrIVF9HVprc3Np+TZESekF4VL
        3ASlCu4bU2m8bgHKvYITJt5Oc3zNsW1FZ57Ly5PsZFnx36oNKA7dkOzJ38V/pGST
        7pVSpQgwcjL8M4BcflgQNzSMMeJy8Ouuib7j1lyZ/W62CAhCYqb3htQWOpfgQq6N
        YE/gFxKZQylRrzGJK7MnUtuDJ8z2iX6DXUPDsY5gFTpmndhKOpjcR8lYoytByfPI
        /pxwrxENDJiufyqCidrcT4Yk4J8zbFWxgEQRRIzwd3yqw8G5b3Xoj2Ytw==
X-ME-Sender: <xms:Iw44ZLilSn6tGP0clwJv9seM0kz5cnIq4qALSi5sI2_P9GgqXmbLOw>
    <xme:Iw44ZID7QXSQpMb_B113QsJ-DEOPziknJGM5duikFjcBEmc9aREP8HXFE99pItq6H
    _5UEa1yMoPmQUWxhw>
X-ME-Received: <xmr:Iw44ZLFtbZnc05dirSvYg7J6c5gFh3m9xbGJyvrGNQsLxO7aTbfED574d1pvZje_VAKJxOQxBnLbi-klOzEFivpP8PZX-fl-xfbFSVih9__aip8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Iw44ZIQmNIZFM0z4rM4jRfY7GU0ss7xK2SELMtKRvOzXc5PNjp1yKA>
    <xmx:Iw44ZIzCwjTqmUv2R23E0zrItd_-Htmr9l4DzZptyvqfS-ugM6cp_g>
    <xmx:Iw44ZO45rbOkLzouDtdG6Gm444oVeZPJH6PsK1XJfDhRG1tb9x94Kw>
    <xmx:JA44ZE-vXdc9nVtfECC13hsKX4eYUWrNgic_CHgkvbLT8YTPrTmhOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 10:13:54 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 62490cda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 14:13:28 +0000 (UTC)
Date:   Thu, 13 Apr 2023 16:13:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 09/10] repack: honor `-l` when calculating pack
 geometry
Message-ID: <ZDgOHdxv5lbf49g6@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
 <285695deafa5a4a49f774dc484782dd8e4fd4997.1681384405.git.ps@pks.im>
 <52079b9b-a55c-e7d1-930e-38105dd8a85b@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HdqdIQGyQDWmqo74"
Content-Disposition: inline
In-Reply-To: <52079b9b-a55c-e7d1-930e-38105dd8a85b@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HdqdIQGyQDWmqo74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 09:59:02AM -0400, Derrick Stolee wrote:
> On 4/13/2023 7:16 AM, Patrick Steinhardt wrote:
> > When the user passes `-l` to git-repack(1), then they essentially ask us
> > to only repack objects part of the local object database while ignoring
> > any packfiles part of an alternate object database. And we in fact honor
> > this bit when doing a geometric repack as the resulting packfile will
> > only ever contain local objects.
>=20
> > +	# Verify that our assumptions actually hold: both generated packfiles
> > +	# should have three objects and should be non-equal.
> > +	packed_objects shared/.git/objects/pack/pack-*.idx >packed-objects &&
> > +	test_line_count =3D 3 packed-objects &&
> > +	packed_objects member/.git/objects/pack/pack-*.idx >packed-objetcs &&
>=20
> Typo: s/packed-objetcs/packed-objects/
>=20
> > +	test_line_count =3D 3 packed-objects &&
> > +	test "$(basename member/.git/objects/pack/pack-*.pack)" !=3D "$(basen=
ame shared/.git/objects/pack/pack-*.pack)" &&
>=20
> nit: could we do this where we store the output of the previous two
> commands into different files and then use "! test_cmp"?
>=20
> 	packed_objects shared/.git/objects/pack/pack-*.idx >shared-objects &&
> 	packed_objects member/.git/objects/pack/pack-*.idx >member-objects &&
> 	test_line_count =3D 3 shared-objects &&
> 	test_line_count =3D 3 member-objects &&
> 	! test_cmp shared-objects member-objects &&

Yeah, this is definitely easier to read.

Patrick

--HdqdIQGyQDWmqo74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ4DhwACgkQVbJhu7ck
PpQYYA//SCO9YySXwTGz5awiSeZREHB1d6dsu8LNZUqp7vbqAqHdMpD18Zr8HEL2
MWNyubAPK5VEI0FAzkhgmwCbL+7oqNTM4Mouak7gxCZkD29dEfTyY33tWZUcXFdE
DUTE7cEfMDl81reBknkDr/kw6g3yywdVPSCMIW3qMn4wplNaBvM6YOGxKBhCm3nu
PNXAUUjX6zQ4hbgSEsweC7bnuBRyydlz1ocADOSjaHrtLXX3ocHEcdPZQeRWmeJY
/NbIXetP30ePPsaYU1ruyGpHouZpOM1mdlL/2H3uGlQLQGSFyM763GVuQptq+ptL
FXqgZxrKmO80YUXEjJKjbgy6ZeAFS/2nvQ4eYhctwX9PO2F/6ABgmjfeC3JAgHDR
v33yN/1wGtffoV0I2nn6VD4MB6xEaBSpwbfVMcHIjpn87Nd4a3szUeSW10dPYm3r
EBL6QsjYVqjRZkdhcgN0La/zBgGpKmvfXg2Fmr6RlyfFW59zhtSTnWnU6nlMJg5U
axEV8xu+pPeWGUoVXOGUed0dzA4aa9ZUdLxC7itIMPkhwGpo+azkW3EUFsM3lavP
5La25Birr60FCinmcIdte+6XP+uJpPjPqin8K1dOqJ81KyrA1jHv4uALZh/UX8dz
jgc0kZ6k0lDSVybPmx0mNQfX/0uz/1t+wx/aKrfNUCtV47wDzWk=
=iIhm
-----END PGP SIGNATURE-----

--HdqdIQGyQDWmqo74--
