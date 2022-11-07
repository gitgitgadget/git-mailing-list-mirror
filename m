Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F773C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 12:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiKGMRb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 07:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKGMRV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 07:17:21 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8E426FD
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 04:17:20 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7D24F3200201;
        Mon,  7 Nov 2022 07:16:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 07 Nov 2022 07:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667823391; x=1667909791; bh=KV0NaAJoqK
        +AmAFuducucextndXPUIkpx8Aluo6mGwU=; b=U7pHRgYmpZ4Tj4B0sNTcK5vP4w
        SDlJ/y1iUVkHmT/AkVDzxz2nldgZIF74BPaeZleuPIVHUZXJKAH1w7Z5K9hMG5Bm
        u5wb2OLEmTRJtFfCuI34RnvQbvD8/+VX9PIOltiKdLreQ/na/AYu6YjU/nbR4N7Z
        rikFg7TIZ/ELzxl4rYKlsElVaz7In5KKNGR1j8bVnVcU2CRG1CMtsdgzQDNHAEF8
        oQO7jxUj8m4vaQfVtVzBOOkHwIMtWnl0CcdpOOSTXaeephG2fsIQ5zDK4tXySw42
        MNgVkFHj7nk5N280aRfINFPJH9UVBi4v8TADkTcEOz0eD+jcHovyzmdRqwgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667823391; x=1667909791; bh=KV0NaAJoqK+AmAFuducucextndXP
        UIkpx8Aluo6mGwU=; b=t9zjs2D+yVWBEulhKG34Q7E9UDwmm0jOwkxUx/u6WBnp
        t2JhfZTvWrk9mftur2dfroTBhP32D7ijgWU0es6+1rpqtlw+v0rlEg4fOpIMPVpG
        VU4/0PLPGYwuDJlhFX6bQKEoJlIx+OVuScYjXAE1MLpVoNTJ9tLcZQjq9KJeB7gT
        T88YjlzpA7hdUTVoqRPT79hkHQ66llRb5OwdYUaEWsbVMsp+o4PvBflme+zo/WQ7
        HV+YGo7Tt4dwKboasPr14E/2vaSjgfWPRj4Oi5vyIObr/MB7/udyLJY8pJ/NCv9b
        gBfGJ/TlnSpJ0bnDeqUTOuzGSfm/aSveNcwtUM6WSw==
X-ME-Sender: <xms:HvdoYwR1l3lWrLY3uUGbggof5ibiSW_FLCTFVim6F4ZaSvh70aXJ1A>
    <xme:HvdoY9yGRHgF8Vbhs012TQmrDLVj9TM65LeZHHwJWyk9gxYdI-MDVPTn9hebo5V9_
    b6exMHLqCPq6RHMUA>
X-ME-Received: <xmr:HvdoY91rh9jn45Ry6oRfNg-5Lt6SJnHs5PJ_N7ciTHHEg3Nx6aeZpMyHW7aV1l1f7C3IiLy7vYf0dI8Khx3MigpSynTLz3NzQGbW7_nV_5DL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HvdoY0DnMDfsNelIAsv46X0UaqhVXB95siZaXwRbLFy15rQ2ghHANA>
    <xmx:HvdoY5i62VrpnSWKcXxBixmrIuZ-pukIZxC5ulpr7Lij0zDOi9t5Rg>
    <xmx:HvdoYwqfX6H7T5vtxlzGvFg3LbVGnd4gq-rLebwZhqNQ0H1ID5sAgw>
    <xmx:H_doY-sbNUnQGKl8hd4ahsaIBG6_K5K3Dg2eV7jGoC_0_axXzqxdeg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Nov 2022 07:16:29 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 18cea5e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 7 Nov 2022 12:16:26 +0000 (UTC)
Date:   Mon, 7 Nov 2022 13:16:27 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 2/6] revision: move together exclusion-related functions
Message-ID: <a6dcc99ca9526d6a05d5d5aa1e6a8ff14af991da.1667823042.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667823042.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YsSE2cgnWnAG9r4s"
Content-Disposition: inline
In-Reply-To: <cover.1667823042.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YsSE2cgnWnAG9r4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move together the definitions of functions that handle exclusions of
refs so that related functionality sits in a single place, only.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/revision.c b/revision.c
index 0760e78936..be755670e2 100644
--- a/revision.c
+++ b/revision.c
@@ -1517,14 +1517,6 @@ static void add_rev_cmdline_list(struct rev_info *re=
vs,
 	}
 }
=20
-struct all_refs_cb {
-	int all_flags;
-	int warned_bad_reflog;
-	struct rev_info *all_revs;
-	const char *name_for_errormsg;
-	struct worktree *wt;
-};
-
 int ref_excluded(struct string_list *ref_excludes, const char *path)
 {
 	struct string_list_item *item;
@@ -1538,6 +1530,32 @@ int ref_excluded(struct string_list *ref_excludes, c=
onst char *path)
 	return 0;
 }
=20
+void clear_ref_exclusion(struct string_list **ref_excludes_p)
+{
+	if (*ref_excludes_p) {
+		string_list_clear(*ref_excludes_p, 0);
+		free(*ref_excludes_p);
+	}
+	*ref_excludes_p =3D NULL;
+}
+
+void add_ref_exclusion(struct string_list **ref_excludes_p, const char *ex=
clude)
+{
+	if (!*ref_excludes_p) {
+		CALLOC_ARRAY(*ref_excludes_p, 1);
+		(*ref_excludes_p)->strdup_strings =3D 1;
+	}
+	string_list_append(*ref_excludes_p, exclude);
+}
+
+struct all_refs_cb {
+	int all_flags;
+	int warned_bad_reflog;
+	struct rev_info *all_revs;
+	const char *name_for_errormsg;
+	struct worktree *wt;
+};
+
 static int handle_one_ref(const char *path, const struct object_id *oid,
 			  int flag UNUSED,
 			  void *cb_data)
@@ -1563,24 +1581,6 @@ static void init_all_refs_cb(struct all_refs_cb *cb,=
 struct rev_info *revs,
 	cb->wt =3D NULL;
 }
=20
-void clear_ref_exclusion(struct string_list **ref_excludes_p)
-{
-	if (*ref_excludes_p) {
-		string_list_clear(*ref_excludes_p, 0);
-		free(*ref_excludes_p);
-	}
-	*ref_excludes_p =3D NULL;
-}
-
-void add_ref_exclusion(struct string_list **ref_excludes_p, const char *ex=
clude)
-{
-	if (!*ref_excludes_p) {
-		CALLOC_ARRAY(*ref_excludes_p, 1);
-		(*ref_excludes_p)->strdup_strings =3D 1;
-	}
-	string_list_append(*ref_excludes_p, exclude);
-}
-
 static void handle_refs(struct ref_store *refs,
 			struct rev_info *revs, unsigned flags,
 			int (*for_each)(struct ref_store *, each_ref_fn, void *))
--=20
2.38.1


--YsSE2cgnWnAG9r4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNo9xoACgkQVbJhu7ck
PpRctw//a9fT3QXy4rJsrxkIXBbEtSIWEuk3jVHLMxqH2lWs+fy2fRwjZMskf8zU
EOi6VIYWRPdl7qsBlYH/NppikTJCrU6lGDZLx/76Frd1WXB9u5I02hFI4DKbZpvC
NLyjVkp60EQyGnDDMP9elV0/PELsaKpRMFdGFPh4fzh4eBeMCtMMvC7E54tGM7rt
efelmabCQLgubVOq9RkvqoJmUNoWfAntZJKJbVMmu7nsL8taEFUJwmV18pX3pxkT
t+St+my33USTfUPSXOj6SrP+FivugHGWSXGjmT3COLvTDi8QqJhjF5Um5hgwKdwF
7sonZQxGbHjqrVhJZMD23CMX83gASWWLlSEW0G9febBcyiyO4XroZKFu21QW+HDW
ZMdj5vQ15rjZ6Xk4HRezB25Yy8PbOGcBHMjIsOXgbILiWCLunbgZkUXuwUl57cyl
R4UZLAAIlV3kA76ketod43jIhjFarqoIaL/dFfrSi6bTjSolwUB8TF49paQG/WBG
Jdy4vn1JvuimQo9WyGM28usI99u3b0eI2/t762zUhuJQvXNW70O0W6XHtQAPJCqz
uoVIAd+zuCnD8EQdbtcMoIa7ZYu8Wf2Chf+tRT7ILwNEYawyngiYixEInAvE1wYl
UYyzVdhVWqnpMknkSJe9B2ocBvp+Iy3jUI5i2xj0OHz1CWNU4/k=
=vUlW
-----END PGP SIGNATURE-----

--YsSE2cgnWnAG9r4s--
