Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D37EC433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4789923B7E
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgLILxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:53:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:36529 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731058AbgLILxT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:53:19 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 85E804D5;
        Wed,  9 Dec 2020 06:52:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=csfIBRPQWULb67+S1B/a52GHJJm
        q6D1zepenPkiue+s=; b=K3fPPj0ZDaAh7i9kZhWWxihKIB2Ygc2zu8hu1K2CItt
        ECgn8qFZYvtYrQTTOR9tcFRPNS1VhL26nLSR7NJF3HF15pfEPRScSULSL29WU1RI
        pxLBY0xSiPHJFF3MRLrHrL6qLdLi9EU8si6RrbSFeSlaRtmpbxgJ6R2ovsiw9Mfp
        SuyDqNLjkEvPcquciTxMqgE8FF8iusNt5bi/vHUgekNINrvcCiZtHh7LGf5vF7l7
        /gGWBcY8XiTjsKsDRDFwndSu2ugpzNooU06NX3GqoKpO9V5+VJyhrft6/Y9+mWRN
        AzMD3GzZlDMdfacco2DXl/YiUMzyVXDbh7HCkGjYVmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=csfIBR
        PQWULb67+S1B/a52GHJJmq6D1zepenPkiue+s=; b=Npxuozp18eLwrxSDMLy1CU
        366cam5VH+s7sEMnshktCI+XQbt58lMj46c2ffNQCvfbrzbV+cW+SjSZnQHTrcMs
        aESCksuUNVOEvVaHT2zOnoVH25854GuI9/6gPQH4FDwieQtQltlBlB8DbqVdTY5g
        SyzOTTwtbduvhLdtNUJSLjI8zuBHd1I+O0qeIk9v7l/JVaLwtJwcMoWi6yjMpIe6
        8+9x8BTzSo4L1LZ7lGSxf1LL6stBmirZfX6V1Ec6HudO8JXzAmk0XDPbRCD7QvfP
        9Zol/TgJd5eoVHe5Ez67pwit1RWGkS8kJ3IJy1NuDVdp+9bwLZ/0ffMFjPjl+KrQ
        ==
X-ME-Sender: <xms:eLrQXy8-u4-RQ2kgwTpUMeC3OKZUVuGP5EzqR7lhDoPuI7-HUmsy-Q>
    <xme:eLrQXyvQ4cmhzr4Sdo3HRG7TQRAKIqgVGIbYvMesZWv26UHuwz27eIieG_8Hyguue
    XWZQ2F5_2DabQrX0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eLrQX4CcMP-m_JTicPhhwIsD9e0zwKnBYGmWgCoUCXtmfFX0xUMd3A>
    <xmx:eLrQX6cOMd9pYbNcRxFLhI_4cjfLxUjFbOAh5-ve3oKlVo2_v8VdAg>
    <xmx:eLrQX3MLRau4MeMMYp9ytYtNBuhxBaXP_1XFq_ujitAq9oaZbWc7Ew>
    <xmx:eLrQXwpUKAXTBRgmjdyMwnjiSsL_2YdXllT8tGzt65nCVWOGWYbrQA>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FB261080066;
        Wed,  9 Dec 2020 06:52:23 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 91982045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:22 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:21 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 1/6] git: add `--super-prefix` to usage string
Message-ID: <20ed9aff3be43e2c86d45c1a0255ea287ed1198d.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1wiDNLlRECTcihcj"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1wiDNLlRECTcihcj
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


--1wiDNLlRECTcihcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/QunQACgkQVbJhu7ck
PpQWQxAAogHc/U5kPY3VDNcuNDmjAh1BChrkmfktWvAoOeXOs0PYb95uBptHLgN1
aYZ8yMKXVNs7s8e47HVhrSzCdgJnyxTcNdYqMC6wdF5N0OKlErpLCvSJ1S80xCqR
b/wbSYBLGLPvVGlbxYdVNbBVm1li8TxY3GnrOmFnrggFVLnFifjWlrn9tYSxAF6E
2LGv7mhENVO6dloR06rc/8yfI7gzJuvKH5QlHxQuxuf0UF2rUw23QtYKCVPKhTEY
Jsjm/LJ15lpIVzHzXws9XQlzn8OBpkcGx6yOTas9iBz/sIXhBusqBb7+9h+dUCWM
ME7l8dJWCoeguo8ZTb6GUkuLZD/Yq6mzjpky5yTnJwdgZ8Mvs/GZUeUidtVsi5hs
gsLZHFIZzFSxHtTUDIG4tEO3Kn84+8ptbTkOPP5WqU2xwirqfesduBAY0VICQnBZ
x2jU4CdNKqEsNaic4Z+NgcSbp1KtdE2ZF0rOV/K+jUlMKhHHOJ71lI3bciIp10TA
+8zHykgmE8B/fTC/ZdpGyXQctzWHSX4DzQFPU4KK8anDyvKj82Q63WnVI5+F7lGC
lZSxYuOTbur5MtxQZvKhW5tlRrQ+13rl0z9FrMhmJ4RsVcmvHgr0FyeUSfJWEkX4
R2qiYLQXXtE3UPar5IqIz2c9eVe4kJAXnxsVxVphR1e+9EUNWgM=
=BGzj
-----END PGP SIGNATURE-----

--1wiDNLlRECTcihcj--
