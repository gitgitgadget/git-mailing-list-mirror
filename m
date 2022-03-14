Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF92C433FE
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 07:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiCNHoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbiCNHn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 03:43:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96416B35
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:42:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EDE215C018D;
        Mon, 14 Mar 2022 03:42:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 14 Mar 2022 03:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=yAkzl4a0iFC0HziRoShqgj9TLm2hzfUMKiSgd4
        xW818=; b=DHNDNDOHP1f1Kriak/RQn+xsq16MhN3OcYyTx8jdcSTbX4g838vE1y
        k3oEY3vlv0BQif/fC9cUgDMvul3Ef7wA/psKFQwWh5ypgf99UvDJpXg8CSMyGDqK
        SpLZSiYLtKHX1EhJ6XFLX7XrZSmic+ZPrr9Dc3B8hQJPUBX2F6iFGFI1EeA9umpT
        39oUaOGPpfiY3jDSqgoHZYV25JrsMktqcERZniLD2Dkoc1E0NUz5/2v/WjP4G9Qo
        N4wlFMtd/MWv0OVN09E2UXtqgZrKGaYZpwt9uG2lTRzzgOU0EdvE1fT4DSBiiTap
        2AAlp9Ao2Gwg67fszMHSXSqC6mU979lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yAkzl4a0iFC0HziRo
        Shqgj9TLm2hzfUMKiSgd4xW818=; b=eLOmt4YNsURkD9g6Ff48YCQRRzfhEiOTu
        sXE7dP2LBar9FM6pPNVL+vG0ZByuchqTne8TEbf7iEbAFvV4omXTkaeCe1QZ3ES1
        r9klkdZ9LTeLrweneUCov1ApkYQOOFBPUVytaSOGRoSVzzXRKt9HKbzp/D3n9he9
        jpvqkDsIFPB3hN5USSFoPil1PnErt2Fu5UA2GhxjVgMd77Sfr/mAiO/BKn3lD2w3
        M/0l9u3OWmuGTxtHhTtcs02z+k+30UE7frYe7s1a0NM+6fR6aBFj7+nAsDZg7QZb
        cDIJDR6XmtVAeWDbaSNAIsWbRXlnMUf0wa9ap+OUpD6UODoEVnpzA==
X-ME-Sender: <xms:-PEuYlB7s4_n1AX75yz2WB5P6ar65YDhwBMvgaJPP4UPeDRH4IDQkw>
    <xme:-PEuYjh968XaRslMjBWADU-6UIzQL8jdTF4rVpyGBY8vDhhhu_dGBZLzAyuv_fpFZ
    Q0wJMWJBGjcmjBShA>
X-ME-Received: <xmr:-PEuYgn5xM4dJYczpiMoiV4XCRmSUFoitw1Bl76cWREG6Jo8cwJ4olw3ROox9W1y8boDZZeLvpx3OPY5xW523PYh-MUsoq9ZHfTi6rI22VF8GX-5vhnd_t8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:-PEuYvyKy6hrA91SgodyOl0yyrNbW_41oXA4PeDiBje8ubKg0E7E_Q>
    <xmx:-PEuYqRZHKIsg1cRnBBpqqkc4Lwzb8KIVyDDKYG-1zkv8-34edv0Xw>
    <xmx:-PEuYiYfsto3L6JL7UXomHXGYoGTQf91ARJR2DrBEWA-wXdljhtpYQ>
    <xmx:-PEuYj7Oqrt9WnqysYYaly2Pg7Ht19rRZhNbUcDG2nVSU58u-1pJBw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Mar 2022 03:42:48 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9f784b2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Mar 2022 07:42:48 +0000 (UTC)
Date:   Mon, 14 Mar 2022 08:42:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/2] repack: refactor to avoid double-negation of
 update-server-info
Message-ID: <feaa4615e2dcc3bc644d12bb2dba1ab28d5ecc1c.1647243508.git.ps@pks.im>
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
 <cover.1647243508.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EBt0s1pFl3Q1yiat"
Content-Disposition: inline
In-Reply-To: <cover.1647243508.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EBt0s1pFl3Q1yiat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

By default, git-repack(1) runs `update_server_info()` to generate info
required for the dumb HTTP protocol. This can be disabled via the `-n`
flag, which then sets the `no_update_server_info` flag. Further down the
code this leads to some double-negation logic, which is about to become
more confusing as we're about to add a new config which allows the user
to permanently disable generation of the info.

Refactor the code to avoid the double-negation and add some tests which
verify that the flag continues to work as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c  |  8 ++++----
 t/t7700-repack.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index da1e364a75..f2ac8ad14b 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -620,7 +620,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 	const char *unpack_unreachable =3D NULL;
 	int keep_unreachable =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	int no_update_server_info =3D 0;
+	int run_update_server_info =3D 1;
 	struct pack_objects_args po_args =3D {NULL};
 	int geometric_factor =3D 0;
 	int write_midx =3D 0;
@@ -637,8 +637,8 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 				N_("pass --no-reuse-delta to git-pack-objects")),
 		OPT_BOOL('F', NULL, &po_args.no_reuse_object,
 				N_("pass --no-reuse-object to git-pack-objects")),
-		OPT_BOOL('n', NULL, &no_update_server_info,
-				N_("do not run git-update-server-info")),
+		OPT_NEGBIT('n', NULL, &run_update_server_info,
+				N_("do not run git-update-server-info"), 1),
 		OPT__QUIET(&po_args.quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &po_args.local,
 				N_("pass --local to git-pack-objects")),
@@ -939,7 +939,7 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 			prune_shallow(PRUNE_QUICK);
 	}
=20
-	if (!no_update_server_info)
+	if (run_update_server_info)
 		update_server_info(0);
 	remove_temporary_files();
=20
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 5922fb5bdd..6b387bbdbe 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -381,4 +381,36 @@ test_expect_success TTY '--quiet disables progress' '
 	test_must_be_empty stderr
 '
=20
+test_expect_success 'setup for update-server-info' '
+	git init update-server-info &&
+	test_commit -C update-server-info message
+'
+
+test_server_info_present () {
+	test_path_is_file update-server-info/.git/objects/info/packs &&
+	test_path_is_file update-server-info/.git/info/refs
+}
+
+test_server_info_missing () {
+	test_path_is_missing update-server-info/.git/objects/info/packs &&
+	test_path_is_missing update-server-info/.git/info/refs
+}
+
+test_server_info_cleanup () {
+	rm -f update-server-info/.git/objects/info/packs update-server-info/.git/=
info/refs &&
+	test_server_info_missing
+}
+
+test_expect_success 'updates server info by default' '
+	test_server_info_cleanup &&
+	git -C update-server-info repack &&
+	test_server_info_present
+'
+
+test_expect_success '-n skips updating server info' '
+	test_server_info_cleanup &&
+	git -C update-server-info repack -n &&
+	test_server_info_missing
+'
+
 test_done
--=20
2.35.1


--EBt0s1pFl3Q1yiat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIu8fUACgkQVbJhu7ck
PpRynxAAizjd5nTNdd/LIiaow1aovuYxBOvQ8D67kTnm34mneYY7wfn3x/csXdE2
UFdC7PKjfqqIgQCvfOPgNh35Sd64dwc+kQEj5WxYcJKd8tItqJy+AAmb1ONqR/IS
Iz+RvORMG1t/1T/sKSDJsfaZaUYqeQqxt5TYfiE0AHC40r0/tPHPMFgwYyopUKUT
L2AjF9d5xPbsG6An8rS0HvSb08dmGlhOQ9VbYpb2ZMMY2FXd28xTUsCJZJmrSIqU
yG1BuAiK3DgSfB/IotqxZ577nc08PgWXxQATck/JZh92PpEo/FH2TvaP5hG6+KSQ
+xHXXT/DF+m1az9baaoaqW5qvXpR5bmYdcUkdydR8678ZfMpSZZPi513VSYzR6sO
sPoXljkr+iSGHQZfAbWH3/2JgcV/k9IazOhRvZhzR9/5weAOqbQP0fC+1X2wuUaK
f5u6lPj0guMuK6ydV39sYc/GMfKsvvlqw8iS6niykvPl5AAPV/yy3SszGBgCHeWP
ZZcpHx8Q3qw7jdhrGypoBEXDE6nWQpLnVwz048w7H2eLdup6pC7SGjAhM1QVZkDd
F1rNTQ1lnAGgrduL46ngI84X8Mt9vjmRg6BegzK+wRMZcJc5BZWiwYNyGoCzUC7i
O1Rmlq9c+O0EyVEmuPmABbJrGf/5mmc+kJr4PQIDBQabxVQVZV0=
=ph8U
-----END PGP SIGNATURE-----

--EBt0s1pFl3Q1yiat--
