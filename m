Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02129C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiKGMRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbiKGMRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:17 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4659104
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:16 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 873F43200991;
        Mon,  7 Nov 2022 07:16:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 07 Nov 2022 07:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823385; x=1667909785; bh=U5gtTwCrje
        GWP8KzQyOFSOFPlp6g+M22QPMxkjJbWRY=; b=p/+WK2EiARANBvtabE2grawhiJ
        62NzHC6zHVK7nnq9cQMHzmqDumsG9v1qTnsUHJbsqfe5NKylawXxQHIEn1ZvtRk+
        1eKgdUudmpPunR9p69uMxcxanzISJUL+xIaopWG83PURAQp5EPhTJXdzKiWF13Hi
        dGNlIOljhXvUCCN2ffD0JD/JXYiYpc9bdLH5tIoMCLNUSoSFy+1yUt63srMiLPN5
        SK+rkaY4PKNi99vJYT88LK5iCy4kj/P9/nDsZxdd/2B0q0exgJoanLLa2F5UtMT9
        ZeLTUYmNKH1LtfR90ZMC3YNAWaltvV6UFvTN8GFLECOj16agds93aTZBLK2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823385; x=1667909785; bh=U5gtTwCrjeGWP8KzQyOFSOFPlp6g
        +M22QPMxkjJbWRY=; b=dd36c7z57+koVC5eUhPtFMk82Q0lKM6m99mkCxJDgYRJ
        b1Kly7zcMoRGOF+P/7Pn1s4ATwLzSmP0Dt7VwqQCptO7K/UJy187liMk4hrS0bmN
        6zq3T9FS2C7JRGGWptmRS7Owrnyggkm1m9a3ggkeJPByeqI6uYdr7vqhv1P4rH6C
        +oCj7Tr5HSrB94jEnKsNcnH85dlgwSI8rq2pnGH5gb5PGqo68JfjLTI4M8NCaNU5
        9zapYYnrAXHc93H0Oz6AllWHXdIYqPvvEJqzrFvtP6j0h5zG1V0uVdywt9eZnbXz
        3szakQjGeomktEr/FhWmd1ZWXS22I/wBmVLNHYdoHw==
X-ME-Sender: <xms:GPdoY7CEq93ksDBBMBU781sQvnNt0VzwiGSBEqbRfgy1rCkJuRP2Fw>
    <xme:GPdoYxi7c7VWt1W3UrmEbKOn2DBAAlhVA-oFHsUg9VsefN-TYodGk2RORSVdAy3dy
    PR3oJg_74MHKGXyeg>
X-ME-Received: <xmr:GPdoY2mR3n3c0BS5nrdh7QJA0Aq4LOT9-cdyVxWnchk8VT5Zt839SsZve2Vn4fkP_WnPONiBBnmeJasLDaXaGiaFEySbWhzP7GAA5hh_Dgrq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GPdoY9yrF-50J0wy0AjKDvrlS4nQ60cr-X9N9lybALDJEQNFQd7m6Q>
    <xmx:GPdoYwSZjxcRgOnF8szYw2znmtjqjW6pZb8WxTZ5Vt4c84eRDl56dQ>
    <xmx:GPdoYwZbNBRiUv7Pb5f9b9McM_-p_3wJi_ChyCE2_knUWXuSxRKYGw>
    <xmx:GfdoY2fbzuaUQC9bvAFnvyIPOO4GAsRlYyXBza_DE2l5fx67j-6Yqg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:23 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 63522c7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:17 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:19 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/6] receive-pack: only use visible refs for connectivity
 check
Message-ID: <cover.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GKYrYMkBGl9dpXWM"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GKYrYMkBGl9dpXWM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that tries to improve
performance of the connectivity check by only considering preexisting
refs as uninteresting that could actually have been advertised to the
client.

In v2 of this series, we introduced a new option `--visible-refs=3D` that
mostly acted as if `--all` was given, but its output was restricted to
only visible refs. As Peff rightly points out though, this is less
flexible than it needs to be. This new version instead introduces a new
option `--exclude-hidden=3D` that can be combined with `--all`, `--glob`,
`--branches` and so on to provide a more flexible interface.

The patch series is structured as following:

    - Patch 1-3 refactor multiple different parts of refs.c and
      revision.c so that they are more readily reusable.

    - Patch 4-5 implement `--exclude-hidden=3D` for git-rev-list(1) and
      git-rev-parse(1).

    - Patch 6 starts using that option in the connectivity check.

Patrick


Patrick Steinhardt (6):
  refs: get rid of global list of hidden refs
  revision: move together exclusion-related functions
  revision: introduce struct to handle exclusions
  revision: add new parameter to exclude hidden refs
  revparse: add `--exclude-hidden=3D` option
  receive-pack: only use visible refs for connectivity check

 Documentation/git-rev-parse.txt    |   7 ++
 Documentation/rev-list-options.txt |   7 ++
 builtin/receive-pack.c             |  10 +-
 builtin/rev-list.c                 |   1 +
 builtin/rev-parse.c                |  12 ++-
 connected.c                        |   3 +
 connected.h                        |   7 ++
 ls-refs.c                          |  13 ++-
 refs.c                             |  14 +--
 refs.h                             |   5 +-
 revision.c                         | 118 +++++++++++++--------
 revision.h                         |  29 ++++--
 t/t6018-rev-list-glob.sh           |   8 ++
 t/t6021-rev-list-exclude-hidden.sh | 159 +++++++++++++++++++++++++++++
 upload-pack.c                      |  30 +++---
 15 files changed, 341 insertions(+), 82 deletions(-)
 create mode 100755 t/t6021-rev-list-exclude-hidden.sh

--=20
2.38.1


--GKYrYMkBGl9dpXWM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9xIACgkQVbJhu7ck
PpSwXA/9E3Tww4NkDlhFAp0IsnWZ3AZPJ/1Z5QigTzITuFu97cZdLlSYkTSwbPZA
z7lNa4p5xIo1jVYNJcTcw9I85ct0UjoymSvj4t1nVBdSIPUWFpylNyrKm2ivnFqa
OWS2clCiLz84T7a3xNeWm7m9MSHauZ2BLdULT1cTAz93fF0FLZoKEKLnFaZODWIa
ZZlXzDZ2R3Vshu7PHSHkPHQR5EbtBBQxRknThoB1QSEySRUjzx8kNguPBMV0mJGj
PMCyoKIIqskyuG/wC7YCscGQ3wr7WonHhAW3cNfZrr7V/d5r6NWxz6lHzOxgEgk8
WzVcwPf3fnL082s5KshtkqbAmbNhRivorTd0T0pDF5l9VFr7vFV/QfwTsF81qfqp
sxjUqK+Vvd30N/oHR6Vr05IkSeMzw24gHTsDtMbB7kwOsDLJwNHbJz+W5GVOU2I8
n8X6MasY3Pmb/QR0VSM7VXRQorOKzC1/nWYJzvA2ELy8A3QeNgGXJX83FTQtcaAT
/UBQlrRo6HwvNhoU4jEB1v0RnPpi7sLcslFXBWGLIONBrFsezW8S6vBt3J0Dcdag
V7sewjVdqTj0SVAluTm1hke3HUQTZ0Jlr6y98GuQlU4yc0NHqujkWB4NOpsFZXEB
nTsFkI8x+JwR8m3kMzbdw6kcOqfy8qLKf8yZ30sqCzFj+7pUXzs=
=+eQD
-----END PGP SIGNATURE-----

--GKYrYMkBGl9dpXWM--
