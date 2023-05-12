Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491B4C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbjELHQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjELHPk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:15:40 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714DAE73C
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:13:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1203E5C0531;
        Fri, 12 May 2023 03:13:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 12 May 2023 03:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1683875611; x=1683962011; bh=6j
        g3Z6lQaPW5pxIkCJWOy6ZA8v8VUjU7DSkJ+JIvOW0=; b=o14tF5jpaV7hHpxY9Z
        eVujH3bocqeU+aWB2bAB3kPVZmmDP9897qJZ3i4vJaGBF4hVkIM0yZyzerO1LFUb
        Eh9eQO/GCSoq+flifqFseL+nDgbIVlbUYFi1VqbBrEa1ofgXmiKX3Y7C/GEhabPN
        165GaLQikkyq6slNXGqbA0sG+Y4XZkQ+4ibzPipJg/FsM7NcyWiyBewXvJ8UQ4cs
        CDJDkkrBjKCTlBGhkriHlQN/T0Ii/LPcJpxBKIHu0aozl1RGMgywSThk20t/qSm5
        EBe+QDBI3pc6qBXlo7D+VONsf2VHq9sQOrUtV6+fOuDkArfwLieRl03IcVnbJgi9
        PGgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1683875611; x=1683962011; bh=6jg3Z6lQaPW5p
        xIkCJWOy6ZA8v8VUjU7DSkJ+JIvOW0=; b=HhEfcA8a843iyPjUzjzt9sWfT4/l0
        9bk6P1gk9OJtN4O98aBuQAdczWvZdKICHH3Eey261pTfDruKob40/rgyWjGcI11n
        bbs2sOPWFkg020qOi1xQIJJi53wGrnefx313SWjTWfnnj5Fxs0NLbzaOFJIgjhAa
        +LPANJX5Inla8RRMW2g++Z53IraKjlo11kinMNpTrP5xOoKg7PUlk7TPPeoos6O5
        MS1f64tMOkyc1ZfzFODxvVUHkKTGzfOoUo1+ps3BNES92GmFIVn9XJAqrOtyA4OK
        wglDT1oHCKs9fFf+a2djF0EcMAo4hORhf3z6wdKi0A1Ro7JoXhmaSj/Tg==
X-ME-Sender: <xms:GuddZGYKsuCF78tkeUvsP2c-J4FSS1ti7-6pLLdSpOKaZHpEM5EyUQ>
    <xme:GuddZJYtJPOtdVwSnj_GcD0WwJ-aq9Y45gNLSK-nS6cQKjS_PHdJKjKPS8sEC4Osy
    ObLkDt1WvunPeoMcQ>
X-ME-Received: <xmr:GuddZA-FBBlWArlsazb-AkJhyFWFpje5f9VtvBYmK3vWkH9K7kJY3EuexF24KRKEsuFR9N4CEl6YXutu4g9SIavaosVJzDxPBe7RdpG-i3dPRaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegledguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigf
    fgtefhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:GuddZIqNL6e8A4C9AQ3HXw-1pLCA1OSDyBP7dCd_uAFjr3KQcZXImw>
    <xmx:GuddZBoE5Usfqkw1EKY6Jg_zeP2Zoxz0IPCWKlV-qExfbbbVu8o49w>
    <xmx:GuddZGS3EOeU3vkgIA5JftiR4ILPZoQptHw680VWLOVfKC2DxK1MGQ>
    <xmx:G-ddZASVsbxknO_XO3MipqKRjozFE6CWt3ZkAlfjqw05MIRisjKusw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 03:13:30 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f763859b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 12 May 2023 07:13:14 +0000 (UTC)
Date:   Fri, 12 May 2023 09:13:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: ps/fetch-output-format (was: What's cooking in git.git (May
 2023, #04; Thu, 11))
Message-ID: <ZF3nFaHjOxt4a3ee@ncase>
References: <xmqqo7mqs7rp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ypjfuUE3xnP9chFD"
Content-Disposition: inline
In-Reply-To: <xmqqo7mqs7rp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ypjfuUE3xnP9chFD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 05:39:06PM -0700, Junio C Hamano wrote:
> * ps/fetch-output-format (2023-05-10) 9 commits
>  - fetch: introduce machine-parseable "porcelain" output format
>  - fetch: move option related variables into main function
>  - fetch: lift up parsing of "fetch.output" config variable
>  - fetch: introduce `display_format` enum
>  - fetch: refactor calculation of the display table width
>  - fetch: print left-hand side when fetching HEAD:foo
>  - fetch: add a test to exercise invalid output formats
>  - fetch: split out tests for output format
>  - fetch: fix `--no-recurse-submodules` with multi-remote fetches
>=20
>  "git fetch" learned the "--porcelain" option that emits what it did
>  in a machine-parseable format.
>=20
>  Will merge to 'next'?
>  source: <cover.1683721293.git.ps@pks.im>

=46rom my point of view the series is ready to be merged now, and Glen has
also given his Reviewed-by.

We may add below diff to "fetch: introduce `display_format` enum". No
further changes would be required for any of the other patches as we
always explicitly initialize the value already and don't use the
`UNKNOWN` value anywhere.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 462fc86b99..6583e31e3d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,7 +49,6 @@ enum {
 };
=20
 enum display_format {
-	DISPLAY_FORMAT_UNKNOWN =3D 0,
 	DISPLAY_FORMAT_FULL,
 	DISPLAY_FORMAT_COMPACT,
 	DISPLAY_FORMAT_PORCELAIN,

I'm rather indifferent though and feel like re-sending all patches only
to change this one line of code generates too much noise. But I'm happy
to adjust in order to make your life easier.

Thanks!

Patrick

--ypjfuUE3xnP9chFD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRd5xQACgkQVbJhu7ck
PpSfrQ/9GQL2j4Efq0OhYDHGwbH5jDJwRgRuqHGaqgJ9J4SCo0PghyHX/DwBXwy6
IeDMFvXYi+48t4FJ95WIOCtIu0EB8215glRZkXtJoN8W0A93qty5XBHfOGhLkwQ3
trEHgQqXJpOBI7/y/Q7Qgf6I5X/1zq33qq/2C++y8kkGfIg0jJPEJPlN8En9OCp/
54Nnac8BIRakQkGQB93bAGyXpURZkT4sQOLHttghYfxq5R/14N2tBap6CpJz0ABV
raBrs35EOwxhQcVHGNPR4Pz9oK/sG3N/Rxa5y4KhlAsDROIPusHJtsfCrwUdISN3
yD2iISQuEGhJ3uulkQJ0jaXR54I+UJ5/xMaHdbJgQzrvsQ9M0IGpQqOkm2Cer5qe
GF5b8sr+6woubg+lrQuQ7mI4s13NDufLC6hI06vD81v4gmpV5klivaiwFbveqIuH
/1SahLzey3SJZz0gNilemMJ6WgB95X1Tv43CdCC1s5MQ3YcvhOZEbZELpafFFBXB
X51KkYvRKzCdH6OjJZiujBjSvKNwepUcd7OEL33Zf9Lb01Af/gYLpp0W5QTtu7Sn
4872ba1DpgdtgawMfb1BIooNkQr9BzZDpl2orfZPCVV2ZVnL+CyWC/bouILbJ8UK
dln/C2ClMUB4dZaohmTKQr7lQbTlioRhNh5/xf3b17snTGwTH4I=
=pnZN
-----END PGP SIGNATURE-----

--ypjfuUE3xnP9chFD--
