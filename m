Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD37C77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjDNGCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjDNGCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:02:12 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7445C65BD
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:02:08 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B7FE25C0179;
        Fri, 14 Apr 2023 02:02:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 02:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452127; x=1681538527; bh=Bm
        x36fJRGUnegte2/YvBlD6T3QKscf5COmH9MVoFd+Q=; b=i/sdER3AwxEFMsWAs/
        3Pj6Ogwig/UUGIW9CGHNRgPcJojWy0Lu0B9b3rfDvQplch7aLV6cpV8mIF3sLFMo
        BsQOaduAwyuFTtsW19FbKZ7hAwNlk3L6vqI3uHTgny9SrdEpgNJxlLbQ7ZtwrPxS
        vDBDzKjePtV/ssM5YU9InPiU2CIcE55TVMMlhT5I4T8gYjfaiOf0E8l72JtGZTkf
        kQNFnnp4bW+d4DS+QsLZu6S+GXyMeUulTfpyxaXFfJHLB9c400v8SOIFpIlrK0Kn
        AGpVHhEOM/6osSFIwi2pq37oTtRcfz+BQDjCuZiyD7DI4xigBgkVcv/RJKg/4UtX
        kM6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452127; x=1681538527; bh=Bmx36fJRGUneg
        te2/YvBlD6T3QKscf5COmH9MVoFd+Q=; b=FVcOAUaoT+jQAYvVgvrIkyWgdSqUm
        7qf/VaWYo5x3eh5YeEpwekuHcpY3zDPUpyWtqBgGzbSJ3ONZQNdyTovpcNLQukB1
        uzk0HNySpme2zLtBLXtlZX4TNL1dNPHad33Thky/Y2NEaYC9RndJC8WSz3z02P22
        oJEsQWKDLv+XXg997xgtePJO7R6aBmvN771gxEXfBcnFhnMcdU4YMd9tGtYj3wGt
        IzBbmgrOXHAII3TyihDllPCjZVeEInB1GlQpsa03DCDXaDzk1LVW/scor2OihmZJ
        uIVYDV4h9kSYm8dyNc6wtcSSUkb/p1f5r5fZo3B6NXIn/9gflmPeMHYDw==
X-ME-Sender: <xms:X-w4ZKiXPapOQErqOwsTv3Qv7_zQTVrDwTwGIzEsi11XkthB69JDnQ>
    <xme:X-w4ZLCeUJk7PCWlRI46vI2MXJpjAYYY24AR6sogV_3wNLVRI6MIhlkeO91h9UNzr
    dAsRiC6Fm94IERa0g>
X-ME-Received: <xmr:X-w4ZCEJhpe0QCDU2vseerbOOGvS6ENsINqgC6R1WOQ_a0etU8PbEdmIECKTS00ScpMt7KaEJcSSLNR6Y719ceDLOzgvH37_zooErMiDwSWZo9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:X-w4ZDT1lD3lBcjiMv2HVF9xJN7hHLW-4W-PoXjXvss-7kh-he3VBQ>
    <xmx:X-w4ZHzj7GwoiWKMDDs9SvIoDgGPUE6tHUC59IW-nOliLN-uxe473w>
    <xmx:X-w4ZB7gdPRGA2RLPDKDpTpH3XimUkiPndZbYCce630EzfqbtV8UnA>
    <xmx:X-w4ZH_rQQYk2Jdyqx3XGjdPLdsZ7ZAazKktEmPPBHQqgYmnd1jTBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:02:06 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5d7a0082 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:02:03 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:02:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/10] t/helper: allow chmtime to print verbosely without
 modifying mtime
Message-ID: <548ac777a9dd317c1def68a9b5569bbf889b20fe.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2cYelH4iOMDS8Nm"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--s2cYelH4iOMDS8Nm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `test-tool chmtime` helper allows us to both read and modify the
modification time of files. But while it is possible to only read the
mtimes of a file via `--get`, it is not possible to read the mtimes
and report them together with their respective file paths via the
`--verbose` flag without also modifying the mtime at the same time.

Fix this so that it is possible to call `test-tool chmtime --verbose
<files>...` without modifying any mtimes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-chmtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index dc28890a18..0e5538833a 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -94,7 +94,7 @@ int cmd__chmtime(int argc, const char **argv)
 	if (timespec_arg(argv[i], &set_time, &set_eq)) {
 		++i;
 	} else {
-		if (get =3D=3D 0) {
+		if (get =3D=3D 0 && verbose =3D=3D 0) {
 			fprintf(stderr, "Not a base-10 integer: %s\n", argv[i] + 1);
 			goto usage;
 		}
--=20
2.40.0


--s2cYelH4iOMDS8Nm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47FsACgkQVbJhu7ck
PpQpqQ/+Ov/b0Qzl0O/hJ0ezH5ZITk0vshKgmF45pe0FRwx04fbl++KgYDO0gI+K
zGv3LDdGM4keMwz81AX8e6aCCFhVFTFqQia9p0kVc7pY4ZEjjPeQNE0EuZguUfXb
UDw8brTcLNV8wJHag5Cf1AT3p7XOGEIuCt7hhW5qjA7/BmM2Tz35UA16qMWRY0rb
XxPdKboy20xEtwQb+R2ZcYEGcU0GwF9oMgI3M/4ZM4VtU4xM222lVGfKfGRB36S/
VNckw4LVDBus4IoahwDR6Aq/y0icNcBMKTyP91iSQl2Y95m4krqlq1BesWej1Moj
KgX74WCIvWNu792bDcr3asbjt7y1Adn+3KvLK3ZBpWZUkiA54yIxwl/OYpg8WlT7
FX4W8kC0RtVdF/T55e184ffYTY97YU6yPXTQY+LuiNvtqrc4tTCc8refcYz2hxrp
iq+2zSdvQlOOlaReApjPX9UYPvcEbccFfF7487Uzqq/5HtG+9B8K/ejOE6zuHq7R
R84JV+3exEhwpTmlo9q8vywQpqRO78FFKCiOOaF+znrpPoCKVY8eZ/bbA8gAN9pn
dVWWKaZHEqi5Bk3rkH3mPoF1/1XtWxBskKA4aqy7R9B2WgjXqD7Of25Mo+VVDW31
YkoXolSkJjurr0zL8Mm2uRxFtLtzeLwj+OPhJhtiKlXXB6EyJZo=
=OUZt
-----END PGP SIGNATURE-----

--s2cYelH4iOMDS8Nm--
