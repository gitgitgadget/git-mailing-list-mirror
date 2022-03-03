Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDCC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 07:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiCCHUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 02:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiCCHUy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 02:20:54 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C35E164D17
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 23:20:10 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 79E425C0262;
        Thu,  3 Mar 2022 02:20:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 03 Mar 2022 02:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; bh=t
        Gb8uIh5ym/N2EwHMGHV1RiBBiT7L4txzrb4BtEnX+A=; b=GXXegrr4InyVePhpv
        ER9oK+jLfRIHYy2uhaavRZ4+5RpcnvSjnt7Ob+nxSTbOIXF45Y+3z487kv2r+dNN
        VI7c6jbOaFhMXIJGa6u2War4LY9Wvldo2/7xdpkL3jeg53/DH5eNJhesiVG4CNyd
        LI1hmMSyX6a0f2T3mOovifJoIy32yPt7TobdyfDminch/+b87Fie/sHQi4jLYehL
        MSYsbr6vo+me+6bO+YWf90uhUTLG8hpw4D1sIMx8wjH63W/j2bcLfyO7+ees/Osr
        dmcVPjybOchh/PRM/6Lu9jlkkWxo5X2UNBZfudwNxUqlzHoxXKBb2q+FJU4ZVB59
        2ED7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=tGb8uIh5ym/N2EwHMGHV1RiBBiT7L4txzrb4BtEnX
        +A=; b=R028UVL5xnV2U5uuNcbapaHZfENcSZq6S19vW2yVph6hBCQU1qXUYRR9P
        Hs71miWMR3otKGqeO7I566GY84QG2CZJI7WLXWhj9eFda0LJ6moxTY0AElXSvW1x
        p2b2MCp5vcOj4vNytYkPGo4g6qut9yI+2mmPkXtPY1onUNJ06kAL4cMHRo6So6j0
        IlXfovl39YNUa3l/nzI8LoGHytgrQc25pr1/vRXeY/IHv9E3cvhGmlo8G8qgVQqo
        2cNJFd+53LgkSORAWHB9fEn3m9oMXkI12eGNfVeG9kPUAoU+UYZ51FDGiz7jNQsj
        dIeTUCJjOeuI/kqyF3wf51b8UIf6w==
X-ME-Sender: <xms:KWwgYs41JAFMrcjyxZIwzff2vOeC_4Buv6vyIdow0vz0Exl4ztzf6Q>
    <xme:KWwgYt4YoIoNdt7pEDb4MMtgZaFp0WbRbcgNb2P5NpI00juvKIaBlfy--mVn8guGP
    MCCsrD0VL8d7ekivA>
X-ME-Received: <xmr:KWwgYrdiikSbL21FXD1HOQ-sdrKsNM9_VgNOLw9EBqcJDvOyFJB3wMfrCs4Hxo2ACUYeZ-rP0Mk4588vm-9sOmR2ElxwAVb5eL-2D30dZyDw6nlhsmDo-MugoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddthedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgf
    dvvdefudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KWwgYhLeM3vvD0IGRvcTvXxpe2Tn2cVCEftpw3KQ65RFuaEVM_nwdw>
    <xmx:KWwgYgJ-dZ_5_KEb-cboQK8_Tg3tOqKkopS0wyBAANjfPosVWrOVfw>
    <xmx:KWwgYiwP-9qHupo5BgrIDosl1rw4VY-5h5EMVCyit98HYZ8s2vfDww>
    <xmx:KWwgYqx_5t7GPRyCVmtN5e8mAlakLS_kQPA78fwFr08V5fITxj6G7Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Mar 2022 02:20:08 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ec446b99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 3 Mar 2022 07:20:06 +0000 (UTC)
Date:   Thu, 3 Mar 2022 08:20:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t5503: simplify setup of test which exercises failure of
 backfill
Message-ID: <cc7de043de67bb8243c764ef6764b07170b01929.1646291929.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="04hQiCK+P2JmJPB4"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--04hQiCK+P2JmJPB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the testcase to exercise backfilling of tags for fetches we evoke a
failure of the backfilling mechanism by creating a reference that later
on causes a D/F conflict. Because the assumption was that git-fetch(1)
would notice the D/F conflict early on this conflicting reference was
created via the reference-transaction hook just when we were about to
write the backfilled tag. As it turns out though this is not the case,
and the fetch fails in the same way when we create the conflicting ref
up front.

Simplify the test setup creating the reference up front, which allows us
to get rid of the hook script.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

This simplifies the test setup of t5503 as discussed in [1]. The patch
applies on top of Junio's ps/fetch-atomic (583bc41923 (fetch: make
`--atomic` flag cover pruning of refs, 2022-02-17)).

Patrick

 t/t5503-tagfollow.sh | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index e72fdc2534..a3c01014b7 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -212,21 +212,11 @@ test_expect_success 'atomic fetch with backfill shoul=
d use single transaction' '
 test_expect_success 'backfill failure causes command to fail' '
 	git init clone5 &&
=20
-	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
-		while read oldrev newrev reference
-		do
-			if test "\$reference" =3D refs/tags/tag1
-			then
-				# Create a nested tag below the actual tag we
-				# wanted to write, which causes a D/F conflict
-				# later when we want to commit refs/tags/tag1.
-				# We cannot just `exit 1` here given that this
-				# would cause us to die immediately.
-				git update-ref refs/tags/tag1/nested $B
-				exit \$!
-			fi
-		done
-	EOF
+	# Create a tag that is nested below the tag we are about to fetch via
+	# the backfill mechanism. This causes a D/F conflict when backfilling
+	# and should thus cause the command to fail.
+	empty_blob=3D$(git -C clone5 hash-object -w --stdin </dev/null) &&
+	git -C clone5 update-ref refs/tags/tag1/nested $empty_blob &&
=20
 	test_must_fail git -C clone5 fetch .. $B:refs/heads/something &&
 	test $B =3D $(git -C clone5 rev-parse --verify refs/heads/something) &&
--=20
2.35.1


--04hQiCK+P2JmJPB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIgbCQACgkQVbJhu7ck
PpR/BBAAjmtf9txpWbNePxAF3EHzuYr/nmO3xIu+gThjhqPUb3YpBPApA7IVEXuB
pxKX0hKMik0j4feDr+Vf7tJacQLD7Iuw1L2dQ83MtbL+kyn25wJYg+8BlYT3j1Kv
Nqpvpn9/f6z/jTFu0JTDQzOwQFlxrlhtRLc7pos0RCjJTIFsmWpsxLZ6AUbgboYD
1KWQ3DizjfDFDfbidS4ScZUwDSrA4Ajyu1wb75rYNxTMfSd/unhzrrNpNY2eQfNk
ebF47bFGWIgMdI/PeHt9S4R0Zbx8khpLHe8lbFtMwDYdyH+0yhEzHcIp3J7PQHk9
aK+XgHULsDNd6U0wtDPSGH/QMsgt59M7yVqdnLRtaYymNG43koYfxAMfaqTBm8JP
ZDAB9c7cuFICfhzR8dn8wLUjsekRj93IOAk740I6+lZN920DSyOePPq1r6FI4gDR
HWCSOYydQCM+pwINMVU/RrQlElPOG8Sdtd2j72GiNpkIy06135+wlOz24T02JKDL
0H8ix6YhfBfaBLyF2sVUJmmclIdrBEtQbg/U9VmzDr6/tQPNqm8QAd5sRVB8MZtF
8Vghz3TqiAl+RwPzo3lW3zz16FOpamlnet0bxrAw/zTnaD+uHVFZ0mXHop/505Hz
Qf2C8PL4W5v426WRrRfkes05b3QIw9+lrL99O679Gym9C+MOSow=
=Khh5
-----END PGP SIGNATURE-----

--04hQiCK+P2JmJPB4--
