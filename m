Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267DC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC16722AAA
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbhAKIh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:37:57 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:33611 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbhAKIh5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:37:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5EF4F250A;
        Mon, 11 Jan 2021 03:36:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+bL+ktzYc2CG5dLgdv2SNOVUp4C
        h9gQxDS54I+fw9Dc=; b=ov3Oss+qdnGhjzKUWN9wZ3oybA+MhqdDXwJpXv84Mez
        AUt/ERDC8aPQQ+3DIQtA+Vxo/+/suRZ0qVw/37o7TC5sApjKa7aE/TLbi+eiBQjr
        7+NetZ9TCCdck1+n8d8usjJ30k74rgI73Ev8z+/ujGzpjiRCSx7ANVAZZHEj18QD
        3isrK0ctPvF7YHbzZYjZ38hcyICJF8vysgaw602BL5yIcL8kNqaVyvec6/14jItc
        GJeAGAz5Ec1uGplZ5vc9p+RKlWhlE17IZ8JNHj/eURTzqdlvtI+Ksl0zSVv6pLTB
        zIvLASxw4DoGxHQudG2nTCKUW2o5mfeVO0b8//XgloA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+bL+kt
        zYc2CG5dLgdv2SNOVUp4Ch9gQxDS54I+fw9Dc=; b=rww7l/GlLKQbRHhi1xLVql
        ysnfEaau5Cn204hcw79YQxn2qWyMqPC0NRtnNqBuDunWz5SrAK3aFBmbBgwLvflg
        mdYH/DuyOtcZt0aAfCRlZmnAp4umnJFP197GWsKFcsMYZIlZ0W92zYfzjDXHdaZm
        9T7tx0mNV93DIdFYma7UwQd2oxBgQgplsAXjXxwFnnGb6myTN95SAwR6h0smLy6I
        2AAn/q+VVfEuYXF2k7m4D/MBNr6idzxWsaG84DhilRAZkkCGqSxKLM0a63CaCTfp
        AxFVUQ3nG3FkL8GOHrAR0wNfi8voCkI5pkeLe5/fz6Q0NG5kF3TKm9BbcZIsepgQ
        ==
X-ME-Sender: <xms:Hw78X-eBSfbOGCxn2Du4lPGhgakUc7lzigH2jCChB7dVpEe1mhkeFw>
    <xme:Hw78X4P160Jx7ImAV1lDbeZJeJWUcfmc7rDmRSXfeCuKqNYNOaHah0ECz1utvCGt7
    JUs6IiDh8ipJXARYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Hw78X_iSL2NyU3BOAZyRFP3bDbv1LEjATBGr4m_K14eRmdQvT_Ws_Q>
    <xmx:Hw78X7_Pz8pRJlZeQbb2aoKtI0bUFrfn4dPH_iXLItX88WQRK0r7vQ>
    <xmx:Hw78X6vSeHG_okQb-5zTrwXdbpXettKyLfI0GYNQr5ONO9y2ug1K0g>
    <xmx:IA78X8IQx-GXmLUiUZBPXhaHzw1JN-7wx7CQuGkpmk6gvgGVFaNwLQ>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id F2E1024005C;
        Mon, 11 Jan 2021 03:36:46 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7bb514ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:36:46 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:36:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 1/8] git: add `--super-prefix` to usage string
Message-ID: <55fa4d0d11f92c5b3c86c47b91ca5f4ceab2f81a.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PANp/Kb5POoM7YL5"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PANp/Kb5POoM7YL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the `--super-prefix` option was implmented in 74866d7579 (git: make
super-prefix option, 2016-10-07), its existence was only documented in
the manpage but not in the command's own usage string. Given that the
commit message didn't mention that this was done intentionally and given
that it's documented in the manpage, this seems like an oversight.

Add it to the usage string to fix the inconsistency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git.c b/git.c
index a00a0a4d94..5a8ff12f87 100644
--- a/git.c
+++ b/git.c
@@ -29,6 +29,7 @@ const char git_usage_string[] =3D
 	   "           [--exec-path[=3D<path>]] [--html-path] [--man-path] [--inf=
o-path]\n"
 	   "           [-p | --paginate | -P | --no-pager] [--no-replace-objects]=
 [--bare]\n"
 	   "           [--git-dir=3D<path>] [--work-tree=3D<path>] [--namespace=
=3D<name>]\n"
+	   "           [--super-prefix=3D<path>]\n"
 	   "           <command> [<args>]");
=20
 const char git_more_info_string[] =3D
--=20
2.30.0


--PANp/Kb5POoM7YL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DhwACgkQVbJhu7ck
PpRPYA//Wpqvkjz3AROdWb9mP9PRL+angfhiZ2FYoCi59krQs4fnju6+fACAqRKF
lrGdb29N3XyDMjRzUc4J3y35i9HoEY7kqHSq8i8Oow/LwOBY81rYoG9yM4KnD6BW
jz57SwdfpJqkWsWCyYpGG0hgDxCKLWGJpcOvEcjcD++TQHA6oT0FupMILbc6H/B8
okjx+gqIPuQXtFtncGoyKvH/Os23NzZ0LYsh03lKic7DZtbLvlIAwCKMYLJII/O0
fm0udl/ZLHWxYv+8srxAFFETrVBi83ENxgArZqB+iW8+Hs3KJuEw9eTv5sMotDov
9IbHge0XNavm/mcrQr41LoCtKrG/P9Y2tdgMh39DCRz25FijOLLhTcTWk0dM0uUv
IeqnE/alkLTo9z3OnLI2krKdV/RdFQs9Me1MUMyaLO7iXBkslrfA5mASWHLN985S
LG3R74RCh1K6PVPSS1TaN5qc0CgUWzrHLe2Soj5JvRCBwrbW0ApvcrLOekLBMMO7
T6JbpIMgux1buu05Wx4rahqbBOquf1yqXB95EVG0wodCgN0EbSfz7GkgL9Xcj0Nj
PH7rIg+M2hSE8OpI7YiYUD+BxOYL1O6TDcbBepPVL57nfYi6tHgL/XwZVqLklFvB
SmCdWujH5rMuChmH7d0I9Xw+34KGGcQtFFeprHrYjKZIThWUjEw=
=gLa7
-----END PGP SIGNATURE-----

--PANp/Kb5POoM7YL5--
