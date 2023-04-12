Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F3C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjDLKWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjDLKWf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55045468A
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9DA72320097C;
        Wed, 12 Apr 2023 06:22:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Apr 2023 06:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294953; x=1681381353; bh=oK
        VGzBgMvNQKTZ5YseAh1ty/zITjSM/stHtl2RVz82w=; b=jSndG+twxPXE7rnm1F
        LQYuEEvMKSS2O4WzgbrRg9xUfSUjNiE2FMLlvqtLJ9pBcIUozNiwYI4qyM4AyGZE
        E68cn3PKsCIcfuYiG/D3ZVdIV86efkMK1wTPmBkxDCTXKjnIJVPe0ZytFI4Qoznb
        bEzrYQWmoMrfGYDMBEB0QHExVZXHU/uXPNS2BcnSmFuEMI1ie9c4RzDbpd+rWMQH
        ZADiUJ3m/xSiFwZDqj35grz2UAQYzOOaHCaHh1v3iw+HhDKlcag9VGYMNi+h+U7T
        uZP/7rFCF2EQBEchHHvuSbA43NPZFvk3DEQJx5lCzf5dcPBIyolD15KIOPTv7POj
        ksrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294953; x=1681381353; bh=oKVGzBgMvNQKT
        Z5YseAh1ty/zITjSM/stHtl2RVz82w=; b=AYTOaIEJCFxjyXEVf9oJZ97VX9Q7y
        r/N3eVJgrVBWXYp2z70Efrfo1J42QDCWAWgiU1+V1h0SoPb5c38KHY/1fcMZy3/Z
        kZLe7wCcKKHFBztXP4FQheyhIP6+VKNaQiJTPjFJ4wttIqB8Fft7jGiUV+HTXwGM
        7Cidu99EKcvj1ndX45mUCUGxL/NQWyh7J3aWjLP1I/0XCYAKeBHK0F6Ii3ptWuOJ
        bbNCz5t85Q60ZgDozlWraQ6+/puiGfQ/dMZw4QowhS3HE8INIiM+aFDg7E1VyQTR
        +6K5KGH0odBJf7bxzaz3T+IrrsnguXJ/5dijtoup9W9vLximRH9KsMl+Q==
X-ME-Sender: <xms:aYY2ZC4SfV6EfpsN4fryLLeXamV5gV1GXIR4Gyx55j1bGFUIzd7I4A>
    <xme:aYY2ZL4t9If1t0gseha7XLAVZNG4EHj5xVjc4I9gSEruSFdIf5-qMODmGbDpEDiFe
    _cqfr6XkFUcCPFc0Q>
X-ME-Received: <xmr:aYY2ZBeGmCqPN00tfXYmbvFM1WhGPwiOz_oJkq3lcm-50GdsO8xw9s7V0rrpIMBHWfkeLgC0n3TaahCwYsKeHbtCHSGRDWAFsq_C7c5anIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:aYY2ZPItgf8iaTfvkcqzQ_aGa408kmapl4Qmorqy5nNEVBAydzloHQ>
    <xmx:aYY2ZGLAo0yltFCzsBjsyazKR59gZojOLYkxAEeskGXmLeT7MQwHUQ>
    <xmx:aYY2ZAySz5dSP4CKiE2QvhDsD-ej_U-A2IiksOho50A2omO5NZEJaA>
    <xmx:aYY2ZNW3jf5OKSwDeBkoML8Yh7eMgrghAACUY5eTEgYP6Iq0kT9yTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:32 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a39c99c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:08 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 0/8] repack: fix geometric repacking with gitalternates
Message-ID: <cover.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H1qTQe22meEW5Klc"
Content-Disposition: inline
In-Reply-To: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H1qTQe22meEW5Klc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch to fix geometric repacking with
repositories that are connected to an alternate object database.
Following the discussion with Taylor and Derrick this series goes into
much more detail than the first version and fixes a bunch of issues all
related to geometric repacking.

Patrick

Patrick Steinhardt (8):
  midx: fix segfault with no packs and invalid preferred pack
  repack: fix trying to use preferred pack in alternates
  repack: fix generating multi-pack-index with only non-local packs
  pack-objects: fix error when packing same pack twice
  pack-objects: fix error when same packfile is included and excluded
  pack-objects: extend test coverage of `--stdin-packs` with alternates
  repack: honor `-l` when calculating pack geometry
  repack: disable writing bitmaps when doing a local geometric repack

 builtin/pack-objects.c        |  10 +-
 builtin/repack.c              |  65 +++++++++++--
 midx.c                        |   6 ++
 t/t5319-multi-pack-index.sh   |  11 +++
 t/t5331-pack-objects-stdin.sh | 103 +++++++++++++++++++++
 t/t7703-repack-geometric.sh   | 166 ++++++++++++++++++++++++++++++++++
 6 files changed, 349 insertions(+), 12 deletions(-)
 create mode 100755 t/t5331-pack-objects-stdin.sh

--=20
2.40.0


--H1qTQe22meEW5Klc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hmIACgkQVbJhu7ck
PpSlHg//e5SpoOPY3iQ5VsgA8aNmUU1CyCrCk4IZE6n/sNC/09bEuQDujQ87SkLK
BntfET3IiR+vMhaeNiB9EaSV0LXgbo0INQammR5r/fbjDPpMxBw9M3umwBw/y9vp
BfN398DwEMgwAsgAnQGuSbD/OTVmVS/hlHUNtWsQ5aOjYcJ//xzAUVCURaZolREO
ZAjvN+tNkCBw1S8fqhLMdgJYBIqyPujWV+ru8MZchIKz8k6ZRVEOMu/AGmY5pLVl
DmljYM4l3N8SnfTGhsa6smHuIqgVRXDSKMBV1vD1PB6KE0Rrkb6edaG3aipOOI49
tZTXjdyPrTTIlZkqIhzP0bEwHMwXXXP3wZM1NYiMtsu0qkyC5J0dJketq73eApiZ
QIHVlBXXa00VHG+Sq9dOPU8/Z4rHkD6YEi5+LDMvnOXqb5rSp7NSPnksidJ6EyYA
zGBRdL1mPKIw7GLwdXIYopRtwswfbGEO0LwdYjMYC+0GfhydDbGT7VHayiBehO0h
hwBS/m8SykFNVGhKQqgpDNQFhiGSv3W5IFN7x+GVr/nSnEB9CZHLHKoOuXIQL8Xu
T8vsGrbmUBo4Bjww+l6+9wcBbWCBueCGuor1NdVgtvteHo78DMxA2h7Y12O1u8QE
hhdwqqfbr2sGA+d3+34ScukoyarG0XetYQR8F9MvBSXhIQpnraQ=
=qzUz
-----END PGP SIGNATURE-----

--H1qTQe22meEW5Klc--
