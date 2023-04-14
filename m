Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F3CC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjDNGBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDNGBo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:44 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC711BC5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2235F5C0179;
        Fri, 14 Apr 2023 02:01:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Apr 2023 02:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452103; x=1681538503; bh=Lp
        lASqBXbPXzIq+ChGcwjmSZx55x8WuQhd8MyjINFfg=; b=Pu5f/N/1yfttYcrx1h
        nYaAPSao6y07JQ5XAblOA4YDZkAN1tjwRMKO76bDMkMemifa6rNfr6NONt4Col0v
        HQd40EmP7kqghuoxkDlZ7GiWTMBhwt3TaGIDAMr5A0s6o1e2K5+mwW5+m9Wz6fqz
        nxV5jVhPLL99e3/oSnEOpBuhJvOJM12oqQNDP6+fdQkTmEFwxcxmnPFN3TTcujGu
        tdW0h40CedbCRsS7jkOnoOeKkKnpum4DKDaBY+7Do+5d61+fQ9J6ckBwH5HfYMpX
        ljLRuyMI3cwU17vKPaZy0nQ3aigb28+HLFvh9cOMJ5DQhA7Yjfos1Z4biVTmgBRl
        Xcew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452103; x=1681538503; bh=LplASqBXbPXzI
        q+ChGcwjmSZx55x8WuQhd8MyjINFfg=; b=NZzP6SsrPUjQ/uO0tSqh8Z6YGIz3U
        wq3+qLih2CWF9KvSo8GM/KsbIYVe/Q/8nlbz8k55mxgH2TcG9X9/5xIKUXG6bm9b
        w+dzVaNy6lUDgR/ieQfYiwE3IWphCHJk/D0U59EhEcTeHHLlLZFaAggwcjc8YG5k
        GEBgdhMeTtj0rrieZASdpFX0FKSB1FLk+JImCdVh6vy7hmryCXE76HThgBU+OObr
        emg2IfjCw3cUdXlqb/h6XaKdfAnOTz0gXGPkr+mfXqA14qvJ0PIcAJXeDwLhR6JF
        aTNRJV91ZbP9/MKkGkqSIE6O9jTRt9C7tfMcEHXMJOsE9ElwbAqZBNX8Q==
X-ME-Sender: <xms:Ruw4ZAzLUoP0GftO2FRcBIvGb81kUCufUnKooa4NovpYxEQHri4U5g>
    <xme:Ruw4ZERYsysko4TDSTZ70qIoLhzPRoFw4bI8fCzin-CC3qI-J4zY8B5qRtGd5-a-r
    oz8xnXnbXRAH_trrg>
X-ME-Received: <xmr:Ruw4ZCUFugoMuMK_I2O7rHY8eXPhleTtPksoje_eE2VjhP9pFoXpZpy_GAjdP_XKZUVzqXs8DgJpTbLtIBO1GTx_QubnmFFy2H0f58PQfS-wDiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:R-w4ZOja0soQoR71gHgGtFHYBSl465FrP4Lg8MfXQEw-wQIkzzPKVA>
    <xmx:R-w4ZCBplwZf0SUr-XL_je39Et0NMlp6JsKbqW2OnXXr73X9OBgVAg>
    <xmx:R-w4ZPIeUQG3hRUnDqDgmGxn8APz_tFTSlmyqE4yCQlwtfuUJG5bSA>
    <xmx:R-w4ZNOwTzrnk8Kl9zM9fWkDJMIH-id28pf2uRk5UN3msXA8xemGVg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:41 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9cefcdf2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:39 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:40 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 03/10] repack: fix generating multi-pack-index with only
 non-local packs
Message-ID: <975ee38fc49d3a814c17bbe9f5b68f02511783aa.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msqgAEEJL2k8G6Lf"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--msqgAEEJL2k8G6Lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing the multi-pack-index with geometric repacking we will add
all packfiles to the index that are part of the geometric sequence. This
can potentially also include packfiles borrowed from an alternate object
directory. But given that a multi-pack-index can only ever include packs
that are part of the main object database this does not make much sense
whatsoever.

In the edge case where all packfiles are contained in the alternate
object database and the local repository has none itself this bug can
cause us to invoke git-multi-pack-index(1) with only non-local packfiles
that it ultimately cannot find. This causes it to return an error and
thus causes the geometric repack to fail.

Fix the code to skip non-local packfiles.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 11 +++++++++++
 t/t7703-repack-geometric.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 687419776d..80fc860613 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -572,6 +572,17 @@ static void midx_included_packs(struct string_list *in=
clude,
 		for (i =3D geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p =3D geometry->pack[i];
=20
+			/*
+			 * The multi-pack index never refers to packfiles part
+			 * of an alternate object database, so we skip these.
+			 * While git-multi-pack-index(1) would silently ignore
+			 * them anyway, this allows us to skip executing the
+			 * command completely when we have only non-local
+			 * packfiles.
+			 */
+			if (!p->pack_local)
+				continue;
+
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 4abc7d4c55..9dd002437f 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -313,4 +313,27 @@ test_expect_success '--geometric --write-midx with pac=
kfiles in main and alterna
 	test_cmp expect actual
 '
=20
+test_expect_success '--geometric --with-midx with no local objects' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a repository with a single packfile that acts as alternate
+	# object database.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+
+	# Create a second repository linked to the first one and perform a
+	# geometric repack on it.
+	git clone --shared shared member &&
+	git -C member repack --geometric 2 --write-midx 2>err &&
+	test_must_be_empty err &&
+
+	# Assert that we wrote neither a new packfile nor a multi-pack-index.
+	# We should not have a packfile because the single packfile in the
+	# alternate object database does not invalidate the geometric sequence.
+	# And we should not have a multi-pack-index because these only index
+	# local packfiles, and there are none.
+	test_dir_is_empty member/$packdir
+'
+
 test_done
--=20
2.40.0


--msqgAEEJL2k8G6Lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47EMACgkQVbJhu7ck
PpTKPw//ZfIpuoP7z7YXvcQARh5aH0VwcVrSEsBVbvKNb/Irv+HySACA+i8QErz/
KbxCXGU7AbX3U1Qo8s9a8iYqK/xKSISOpcAn2HuJbXMt509qcZHHuuQkDUl7vkWn
5jMTA29ES2PAX71hb1JeLNhgWkSZcoFGlGUUi29CvfpqoKMmySbJrv4+3mMRFpuV
zhC70ROuAuivyPP1RyJeRtE/gegilGricraj+Q47UJhLNYISvkVxfprdKCjKube4
Xh+dbwo8djxXTYKeG3im2CAwEgWNgRnRkETAVCjmfBZgw5VL1BEMm16rUG0kIeqQ
2m9LLVz92EbIl+SwKgV6EkJ+k3F0On5QfGQeKN5U7FclpbLm7f32AMOR6YQ6PN2Z
ba/etwgKPRLGeMuIIZJEGhTtNMhJmJRH/0VeAzashrVwv4EGVRgDgXJvML+d9qlv
LqdSkjoU8umQJd0W3WiTSJ6hdfvO+8mazPXDJ6TSTC0nfnOI0AsLFrKWmkmDrLWE
oZBMC4zAjCijrWTf6NwUBvwkTAwmNKMnAUrVj4S2jWjPLPd0EHfFiRJE4FxJ630Q
94Mb3ZyE62HcSWYhhyvG6KOGgWUzP9O2g6uusjzHfkLu7tgC5CDvMOQNG5lzOldL
I8Gsza97+TwnPT6D498jzF7HEoQLRXFfyKI0/Ol0/oDgzzK4r2g=
=9yxA
-----END PGP SIGNATURE-----

--msqgAEEJL2k8G6Lf--
