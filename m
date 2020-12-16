Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB33C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7609423343
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgLPHxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:53:36 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59827 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbgLPHxg (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:53:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EA225C00F5;
        Wed, 16 Dec 2020 02:52:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=l8X5sAsYliYiJqTcndbVaPVaDUG
        Ae7OIaTrD0eQYB4c=; b=aSEwzgd24bQOeDi60qnPGEToeyvn1pngDox/eGpK5/g
        ajAyQVTVGiSsxJ9KtgoHDUBQFqEPthdkzyJVQ3/NcTZBER+JWpTrijYCwSEJxRm9
        wqVslT6glO4FTTYHdOAM/ZLBqG1kRMNEN21iZ32huRNUlOlw8CZnMQ9NYDjZPk3S
        YlLsZNRKV2NtJsQRqD6Dncg3K//mapIqLdkSBujQrrN/q4bTRHVTeEbPII+cixMU
        glGtZs1qtrt5Lj1HMb4UEMF6BsRK9U0LqvdPu085JRTWK4tlin1T2AHHl03Je9dw
        YDwrlvPqGPDUx/9+/CYhQO9X3JU7pardcl3mmFGcQMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=l8X5sA
        sYliYiJqTcndbVaPVaDUGAe7OIaTrD0eQYB4c=; b=m7drmgFpf8q1Au0xss7nii
        ri8GTin5dTiDerUaR2bkvSkTDnP76KCa6rby8jODOqE9puXE7KYAyjc0YxxNlA3M
        JrASVLTqTFrGpsiI7Q+ykClYRBc3HxlTxxcKuJm3wS1QrAP6nrbWZ9JMiHvdMzje
        7hXo2qFtNI4r1nJp9HpFsHPn2HGm3rbmXCdqldSq2iJGgomjb0LxKj9cMqWniVjc
        IwM5474Xb562NpxtB683+kazPA8vSd+gMw71IVVIv5IDxMll1VEYZLJVdgQb6m09
        mted2yDkuRLu0lrDtNHddK8sDuw3CQgdwMXQTz003MLzzIAsBjAS0ywhVRVNNSJQ
        ==
X-ME-Sender: <xms:zbzZX2Fw28-kg_P9As1lM_0lLPLUH5LuU9eqxypSYeCTsD5T3VsTRA>
    <xme:zbzZX3UbyKbQemkhmPHKHinKvZgBkAJBCBWqg61xAQhhBELAspgGITT6_8H8mf8oq
    h5F2Q0a1lVdrhtQNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zbzZXwInG4lDbd_bEbt24hBQlm7D7TbvFvot1ghmVRNj9uEA0OSWZQ>
    <xmx:zbzZXwHUVryCtEbPQlNPkAK1Tzcx59xenTl_3jnm4w-HkcfLt2Mz2w>
    <xmx:zbzZX8XuoL5XEZZxtM0YVFxo5NjT_VA8WGeVrsUeV7ot1zisPgfP6Q>
    <xmx:zbzZXzTdmBI_RVUUAGFxRFHI_7zfunLxYyBy5gjd_RAX-T2_duK3Gw>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6EDB81080063;
        Wed, 16 Dec 2020 02:52:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fed1397d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:52:44 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:52:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 1/8] git: add `--super-prefix` to usage string
Message-ID: <470521e72865d7043fe0f1ce0f3e39a146fa2805.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dDZFPwqBMLisHmh7"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--dDZFPwqBMLisHmh7
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
2.29.2


--dDZFPwqBMLisHmh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvMoACgkQVbJhu7ck
PpTmtg/9Gv+3c7zf03JPdK/M02fJIJ4AkwWyOS2kZLYbLraAknmT86BRDe5jgXMn
PnlNeq0Utofggia3J5Is/XDcDaMr3xYHymP76WRYi766pwrwFX9SLZ+hgUgKRpQu
E9k3FZkctIffzz4ZQFoo7dicuANoYLafG30F8Gv4BdAjv3qkR859aKG2/YuEB++K
LBQiHX3g8fZ3Won9FQ0KaRL5BiCEyKBWl97xKfKS50U/nRgnnoto2qItbZ6eFafm
At3ctiFUURcUfbLbXtYRj3dyxJh5OWkzHzmmtV3c4olxixw91HupRU2TOoKfmrxq
BlJmW86GskmSKU9ioAAEkkqmqtqDCx/bolej72bxW5hnnsu4mmsvEwUCGslYJWFD
UAejBTLEeAKVbYds4d1kTPDIhxOBW0MCkCEwQV6JSeku+UMTjg6xA7C/SoVSp2iU
UsBNTwf0eaAYp1ZqWK/WRXibUAPJlBq9kmmuM5vbcTrZTjvzMRDRUf7vpuC1vcEj
smO7TOzVTRhcKjl/k3W9rcF1pPG/FTQCBTNZV9jaPxMBpkJhhHMTRDSM3dz9geVh
yVkUn5k8F8NNC7Z83J/WZQCDxrZqs6SoEZpwxEfNBXpKA6hFn2O23ZBOKp7VX7BL
PFU3DPAvUc5qEZYL5ThRuPqCspMDQIean7nlw8UmyEqgDObs56g=
=h9Jg
-----END PGP SIGNATURE-----

--dDZFPwqBMLisHmh7--
