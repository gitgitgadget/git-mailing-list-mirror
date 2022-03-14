Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2363C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiCNHoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236795AbiCNHoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 03:44:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED2F12
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:42:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E11165C017C;
        Mon, 14 Mar 2022 03:42:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 14 Mar 2022 03:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=kKRznbqlFAHQRc/CUQPCts4nlnjomHEvpDJ4NH
        NFOVQ=; b=eG+QyxG9lk2ZwjzoGsJ5KF24vIHsVHr/y9hKOZ1JIjCVUsZp7y8q8Q
        ZMoaXf64q8M6wmjC9i2ldMS7IwIOsPka39CZpvAJOMcSyxZDk0VsXy8Gg3CA9U4l
        pVjqBbBsVOR+FJuh7Otl9oPHNFLrd+arEFe9kXyC8RaxopdM5QM9O+Uc8s5E7sSA
        LSzVA2JXEIGhv1FZFLzfDpuvdhwduQEW8dXGCvnLPnMAo4QJOsiBYWK6GRD/8fj4
        yAudgPsoXb2GAtZ2ddGWOqUbKImAFgtzjJVlgpxBmbeTZ7Dr1N8WLFlrbJGmgb21
        640jziEtbqoMvtZqNbeNn6RFbYJ9huVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kKRznbqlFAHQRc/CU
        QPCts4nlnjomHEvpDJ4NHNFOVQ=; b=XCfaFWpE/qwF3QAmhKd19iwVM7SBKX+yN
        xIXwYoQbVNhP8Bmk+vzFqA1V+EJJzM87Ka9ZXhqkFAUZ/wXq8mso/6sF+vndME1s
        Jjen9kugZIszHFxiSk88eb+efmzRHlU/I5LdyOOxrtoxrFUCPYb4y7FjWQjn1XlJ
        EsPUxL//rEOw4P1B9tSL5wEVVrZ4+BpHmFfF3jyAJiO0C3xvKArGFVW+WHi8dPut
        d/DBr4bW7bOnNZ8HXOWc+3fB1leuL65ODYflUVY4l+0qktB1PKE98Jk3LysAW6qB
        ewidKviv/WGiXdD69YsOS6xjU6eG9ARlFs0McEu+tMMInZrWNgwlQ==
X-ME-Sender: <xms:_fEuYp0m9aP5Sl7rKtchC4qP3_0LDjnnPUeYiEXMZ4pufVCfNbGgZw>
    <xme:_fEuYgGbxBaVKcI5Kok-J-ByCR0GjihxleIa6HRmBPULKbZo45DHu3iniS6NuTgwV
    5Tn2i6SETDtqrGJuA>
X-ME-Received: <xmr:_fEuYp49RQ_W8cnRgeLBWSl-MK2WHqH3Nsl9Rp3RyR5-SS4CTE5quHNANKyUfVlsup2csqyAqPLkQ25jTKYScQR6ht2bOqXQ14lCFEeZ-v0tCWjcoHslb8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:_fEuYm2cYszaVvL2v8Tm9iusrpFyxZVr7_DA1H0G7YEZXHEMSo49Ng>
    <xmx:_fEuYsFMRpUXjy_Ug_Adbhe8UYFURbyAtoUSeHZF2kVDmJ7gI24h7A>
    <xmx:_fEuYn-wtljSGOPyhrU9LZAfw-O9LagU_hYWGQ7XZk2DpA6kCU3zyA>
    <xmx:_fEuYnMwVSu6qXlDB1eA8ZpkqRnsHE-ccIS8dxaRS1ToVBGlwxz2gA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Mar 2022 03:42:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9d78b34c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Mar 2022 07:42:52 +0000 (UTC)
Date:   Mon, 14 Mar 2022 08:42:51 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/2] repack: add config to skip updating server info
Message-ID: <f8639116d2d384a6d285c75830c52d8a8230ae6b.1647243509.git.ps@pks.im>
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
 <cover.1647243508.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TQ8HnRnTS6LSW51e"
Content-Disposition: inline
In-Reply-To: <cover.1647243508.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TQ8HnRnTS6LSW51e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

By default, git-repack(1) will update server info that is required by
the dumb HTTP transport. This can be skipped by passing the `-n` flag,
but what we're noticably missing is a config option to permanently
disable updating this information.

Add a new option "repack.updateServerInfo" which can be used to disable
the logic. Most hosting providers have turned off the dumb HTTP protocol
anyway, and on the client-side it woudln't typically be useful either.
Giving a persistent way to disable this feature thus makes quite some
sense to avoid wasting compute cycles and storage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/repack.txt |  5 +++++
 builtin/repack.c                |  6 +++++-
 t/t7700-repack.sh               | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/repack.txt b/Documentation/config/repack.=
txt
index 9c413e177e..41ac6953c8 100644
--- a/Documentation/config/repack.txt
+++ b/Documentation/config/repack.txt
@@ -25,3 +25,8 @@ repack.writeBitmaps::
 	space and extra time spent on the initial repack.  This has
 	no effect if multiple packfiles are created.
 	Defaults to true on bare repos, false otherwise.
+
+repack.updateServerInfo::
+	If set to false, linkgit:git-repack[1] will not run
+	linkgit:git-update-server-info[1]. Defaults to true. Can be overridden
+	when true by the `-n` option of linkgit:git-repack[1].
diff --git a/builtin/repack.c b/builtin/repack.c
index f2ac8ad14b..d1a563d5b6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -22,6 +22,7 @@ static int delta_base_offset =3D 1;
 static int pack_kept_objects =3D -1;
 static int write_bitmaps =3D -1;
 static int use_delta_islands;
+static int run_update_server_info =3D 1;
 static char *packdir, *packtmp_name, *packtmp;
=20
 static const char *const git_repack_usage[] =3D {
@@ -54,6 +55,10 @@ static int repack_config(const char *var, const char *va=
lue, void *cb)
 		use_delta_islands =3D git_config_bool(var, value);
 		return 0;
 	}
+	if (strcmp(var, "repack.updateserverinfo") =3D=3D 0) {
+		run_update_server_info =3D git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value, cb);
 }
=20
@@ -620,7 +625,6 @@ int cmd_repack(int argc, const char **argv, const char =
*prefix)
 	const char *unpack_unreachable =3D NULL;
 	int keep_unreachable =3D 0;
 	struct string_list keep_pack_list =3D STRING_LIST_INIT_NODUP;
-	int run_update_server_info =3D 1;
 	struct pack_objects_args po_args =3D {NULL};
 	int geometric_factor =3D 0;
 	int write_midx =3D 0;
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 6b387bbdbe..770d143204 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -413,4 +413,22 @@ test_expect_success '-n skips updating server info' '
 	test_server_info_missing
 '
=20
+test_expect_success 'repack.updateServerInfo=3Dtrue updates server info' '
+	test_server_info_cleanup &&
+	git -C update-server-info -c repack.updateServerInfo=3Dtrue repack &&
+	test_server_info_present
+'
+
+test_expect_success 'repack.updateServerInfo=3Dfalse skips updating server=
 info' '
+	test_server_info_cleanup &&
+	git -C update-server-info -c repack.updateServerInfo=3Dfalse repack &&
+	test_server_info_missing
+'
+
+test_expect_success '-n overrides repack.updateServerInfo=3Dtrue' '
+	test_server_info_cleanup &&
+	git -C update-server-info -c repack.updateServerInfo=3Dtrue repack -n &&
+	test_server_info_missing
+'
+
 test_done
--=20
2.35.1


--TQ8HnRnTS6LSW51e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIu8foACgkQVbJhu7ck
PpTyXg/7Bk00inw9ZrI4qzuMP3b82IGjI/Qz9enu241T9qq4WpwX7BSzIeouedPi
28d4SSxklgghbrhJtf3kjsbRSJKQbDZiy9bgbhfA26BCcL3EWRKzHKF1oL+VsJ76
UkW3oclKMT4OZjVz4oXqrvPoEzJDubKyFHeRq5bLpM8fW/ISYc3YQq5r2V5o9khU
TUTfmex10hUUIqYrh+OITxZftoqJiBLhNxy1CMJhaRybTMOj8EvRPAIZnToS40Ne
YYiftjsgsJSuWsHRRpURlOz856R1riSw3WAmS/NlfjAVn45nFBTlbM0R+zuY1Exe
Vb8dLPSswuTWk3HsezstFiN47eQtD77QXg5f9TYJhe4pg6aSDlZ7yQQduKi9R89i
9hyFVzGTPyyWvJwqOZ1B0nz/VDWomp7ZnJ9FHh9kjlLTLsjHW6mJfKxgMSuHk6xJ
N6l24friyS7+kkQr+k8uwp3S/QOgucYNDWYzbGQH1DA30S/HSOq3Aj6/e96locHg
YxnwryffaUYd+zBK4OaPytis8mFvi5UzpvbExeYtcXGuC7ESkIX0ogNEsMo6V4gl
rGVSEIE1hc/CPgddRWx9N8i2TKTNFpvUzMBE5O1EHGn5Z/PITJYefqWm5a1E3vbQ
VkOMW+qjXffqcYDFzc3Nchgh3PuzP7K3oWDEGaoua5sLm9SYA98=
=/Qc9
-----END PGP SIGNATURE-----

--TQ8HnRnTS6LSW51e--
