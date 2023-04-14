Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259DC77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDNGBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNGBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:37 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BE31BC5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id C47465C0055;
        Fri, 14 Apr 2023 02:01:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 02:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452095; x=1681538495; bh=Z6
        gas7mklOq4h2kaGCgvrSBK1EVsYTQRDmUHh0F9geo=; b=Kyev3ODT0oWxCQVQh6
        k/BrqHopxGFhC9B7qK3pWkuxChlcGpsR5myzYjSaiMT/yq55GGjj1UmnrAMZ7SUE
        YuqjzyQi8aia5IrisspcH5zKVWK4i8kywwDsXd7kb9PPjJwaP6lDs+c0Urk68loz
        yqyhgfWc9uekcU8CmAz0Q0nKG/q7PPoxVLUTfEzQdEY2o0QuHLvmc8+m3MD2xS8u
        Z6TgjXRqnAPz3Rb0fmyI01aad6+v6+0lBrp0Uejq+KF/+9aRdqmGf5zcApNfzKkx
        6O/B1hzwP/56Tx6PjFEP7euwPWqq5s8kQfTZg+a+ABe5vx+T+lwkwgEJCR9JIfEt
        EZKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452095; x=1681538495; bh=Z6gas7mklOq4h
        2kaGCgvrSBK1EVsYTQRDmUHh0F9geo=; b=Yaj0k7NhUya+GVamWlVR+U/BVOx0X
        cYp+xCP8s4i40u2Oak162PozTiRzYym5c0Q7aZuHMqCywlHpQIUXC75p45wXsgIn
        zT5I1ENoI2Dw46YYL1Syl/Opky6DvXOqlp9LTSUtckGDv+waAArxMfDqJPmaWvrb
        S1wvxt9jpRPsvILQnF/cLVjKmHVjPI+suBOpDYixFOUnkbVqJoNsuhF6NjfQ1eMU
        0KLCdICGLj+ovvqaLnywY2/gUeJdNHGQuz2WwX8gPVpbr+ppxJ+tpVkQ+MO+F81K
        rfhl6UIY0E6q+QyjOuwNc7aPoml3YR+MGF14prJNvy+/uCtm2i+YxFeow==
X-ME-Sender: <xms:P-w4ZJigbPxzI2NkyaZW8HUWqz_WKXzHW2koxrROPoidSpX7lH0qhw>
    <xme:P-w4ZOAMnzZYbEGA48xz7ehBC_6CmwNqC3UBiEjpVSPTxX4eSSA348ah6sZzi4tR2
    Pe4zjR-GP3H5cwNRA>
X-ME-Received: <xmr:P-w4ZJETKj0_YgRTmaHSIhmdMKkZ17lV7Ib084Wa7w7OwZZI5BsRNnVW59rT9oi1XIe3lvcS-EpBEYQQPMIIK7dQgXU08KBtABWUdQBJBj9ru5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:P-w4ZOQGDuUUgBjRKC9Ayfs_-KW7eM0w1F9XBgDCtDLnvy7IdM-u_w>
    <xmx:P-w4ZGyLnW_nptW2JrEeghqxeM9VoJxZeQI5oX9L3E-r3OnoAYhKjA>
    <xmx:P-w4ZE4BzsHEQfq_tdFALuhRf1GRnyIF_YbN763IAnvWzGYlL4pWBQ>
    <xmx:P-w4ZK8CTHaroZeKlEoa_SYhA4O9IeM4ww1PyDPXcnvpX82VOMYdGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6d662287 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:31 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/10] midx: fix segfault with no packs and invalid
 preferred pack
Message-ID: <a91e795bcb330b1d24c9f30b439552f786a6b4e3.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YPqKsrSM4pV7a6Ok"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YPqKsrSM4pV7a6Ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When asked to write a multi-pack-index the user can specify a preferred
pack that is used as a tie breaker when multiple packs contain the same
objects. When this packfile cannot be found, we just pick the first pack
that is getting tracked by the newly written multi-pack-index as a
fallback.

Picking the fallback can fail in the case where we're asked to write a
multi-pack-index with no packfiles at all: picking the fallback value
will cause a segfault as we blindly index into the array of packfiles,
which would be empty.

Fix this bug by resetting the preferred packfile index to `-1` before
searching for the preferred pack. This fixes the segfault as we already
check for whether the index is `> - 1`. If it is not, we simply don't
pick a preferred packfile at all.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                      |  6 +++---
 t/t5319-multi-pack-index.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 47989f7ea7..67eb617591 100644
--- a/midx.c
+++ b/midx.c
@@ -1328,17 +1328,17 @@ static int write_midx_internal(const char *object_d=
ir,
 	}
=20
 	if (preferred_pack_name) {
-		int found =3D 0;
+		ctx.preferred_pack_idx =3D -1;
+
 		for (i =3D 0; i < ctx.nr; i++) {
 			if (!cmp_idx_or_pack_name(preferred_pack_name,
 						  ctx.info[i].pack_name)) {
 				ctx.preferred_pack_idx =3D i;
-				found =3D 1;
 				break;
 			}
 		}
=20
-		if (!found)
+		if (ctx.preferred_pack_idx =3D=3D -1)
 			warning(_("unknown preferred pack: '%s'"),
 				preferred_pack_name);
 	} else if (ctx.nr &&
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 499d5d4c78..0883c7c6bd 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -183,6 +183,18 @@ test_expect_success 'write midx with --stdin-packs' '
=20
 compare_results_with_midx "mixed mode (one pack + extra)"
=20
+test_expect_success 'write with no objects and preferred pack' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_must_fail git -C empty multi-pack-index write \
+		--stdin-packs --preferred-pack=3Ddoes-not-exist </dev/null 2>err &&
+	cat >expect <<-EOF &&
+	warning: unknown preferred pack: ${SQ}does-not-exist${SQ}
+	error: no pack files to index.
+	EOF
+	test_cmp expect err
+'
+
 test_expect_success 'write progress off for redirected stderr' '
 	git multi-pack-index --object-dir=3D$objdir write 2>err &&
 	test_line_count =3D 0 err
--=20
2.40.0


--YPqKsrSM4pV7a6Ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47DsACgkQVbJhu7ck
PpTIwQ//R16g8hxvNIN+2v4vOAPcCDX3M4bQ/VlSOxgvwNdchhpRgqOz/scME2Jy
1m/0WMBmOZR5iE1SggI6LfiDzPBngXSE8LeH8U+p/l8xPNe6fgyjIYZR1Xs4Cn4x
p0+/sJLImldc8IEcG97LDQBl44kbtSY3piDTmKkyNV0CL3ng0yQpS17xW9zP99h7
0wtTP3W3yo+5hpaHhSL5P8LlJU3aIBpg5k153aWxbsEptBm7Pa8esjyfxRXsO1AX
Qptm2EqLzYWOVQmFnk10CGJ0ugkKKHHgZSL4TLJKE0xL1wgMqmyO1TITRA8NQkcZ
AR67UFpz3q0N0a/z7p8i5ZM7rMlS5uCz2lkwFJ4ijnlDQMsambP0ni+HMwgw9nhL
/3ia1o/yLpKVfJ6nOxZktcX23cyYQRmpSEYW+cvX+HEYn+RnO82Umue5FNN2aLWO
bBDqYi623Lok2/A+HqVv8KymYu0yllylioZT6byBDMvonp+LUldRDITBwEJi5CfA
dNFTjrSLvDQCr6ki3WorH0ZEuYirgNBW5T+Z/yHKH3hjCIAmB5ToPvjxHfZRVZNi
qJYHaltUwLRO/mIvPnC1tmuJmwCLGMIU5P8gKa2HJJoWEduPLRJZdNkwM/8UbTfP
S0mX1pHpjmNCBBfw2rZ7m8fi9zFdfAGYpv6JRY+4udHN9lcr6R4=
=D6dY
-----END PGP SIGNATURE-----

--YPqKsrSM4pV7a6Ok--
