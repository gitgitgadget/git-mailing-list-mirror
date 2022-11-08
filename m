Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACE2C43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 10:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiKHKEV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 05:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiKHKDt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 05:03:49 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44B2EE37
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 02:03:47 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 15D0D5C004E;
        Tue,  8 Nov 2022 05:03:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 08 Nov 2022 05:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1667901827; x=1667988227; bh=MfWHNTQvab
        13DOt9cL/Ji73gT0H1+wBgpeNrG1eeZiU=; b=Bvy74rRoR4TCMSHj0X1+jR+sup
        /jb/s2uvJQLjZ5w3VIurlpbPawtmjdxUunqLiOECANSLOx08zoxNqi77warddTuU
        NdQ4npXS5WkroxdP2B5+eNDE6KS7B0ExQZezGlWhLNkcFRE3i7cxdAvhx4nfLwAz
        FtIrKX3xyBGsUOB+UOXvSE/LNajnL7pKSwMbNU0crd/0hq6SL4NQzkhSu4lqMRN4
        SCyoGqex3y0/bCJO6W8YeI30rpEvsULB6vwiT+h+DHotpfo6vC8HZ2FPJ7orI7JC
        BnCQw9Nbx8Sz/t2ha5Ca07rpOAMS/3YpXG4SyWylE8uMrWPT+lSr9r74b5oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1667901827; x=1667988227; bh=MfWHNTQvab13DOt9cL/Ji73gT0H1
        +wBgpeNrG1eeZiU=; b=uyhJqXLJmyOpV+Ltm8/J1hdKOPe+Q9z9izR+qdzXpcWo
        xxcx5vb8P1ia3iaWMfMZM9Ywz2/z2aEpxxwOF+JPXGxG+tDybQMNWzgV3sUa3Sbw
        WIKL7oJdXPSLD8NwKxUMCH3szyo12/dzAjTgZ+rHd1Rpx/Q8j8kUrCPn6SZXzPDO
        0Q7aIWqaEZsh3bjCB1xOQEzmg0qAUo5jOZgMDQOwOl85n7+5nVlfuhFkRdzi2zBG
        J6+oftCreg3qjb0I9nmsOs8K9U47FSCzkuQ1xTWL7Ek9SroTwQN/QpECxLfDlQNh
        nVycqialzrp+VZ7aYmueGIdsPgnHUpNLt3qIaZRzSQ==
X-ME-Sender: <xms:gilqY9A0LeoIS0boFiqNyhJwGIhYTbXSUMF-rOSBBGQF71rYJMi7ng>
    <xme:gilqY7h4aKq4B2faHVb2KgQd2kAuiIWLBLw9BsrNQ3xQ0NBhRFFYrrx4xtH7KXDYp
    OQ-6wCYh4s1TmXO2Q>
X-ME-Received: <xmr:gilqY4kO8TuP9xKcLS_64ofNBPwwZpGW-exQbPCJBY6nOM52wYOSeZCOM6AKQ6J-cMIKLngebmGk27mjb9aox6hHYXAMcqSnC3FuA89ZwOcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfedtgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gilqY3yy4ZFoWm3DsG26bYdSoRCh5xW_YrEeOZYe2C_DE1F0lyS2aw>
    <xmx:gilqYyQrCDL-QOSFc-vnfx05kNAECZhuklX_HAvjOdqn1oXnAMGweA>
    <xmx:gilqY6ZSUyI9-XLT7wbieMbSWXqOeynBcqlIdrxpzuhYrSAKYbsOwg>
    <xmx:gylqYwcnuR4Fv5bOV3XoqwJDPBI7U9rmPWKqWZ4pGDsXb90DURsAHg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Nov 2022 05:03:45 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 94ff17ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 10:03:40 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:03:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v4 2/6] revision: move together exclusion-related functions
Message-ID: <b4f21d0a80101306bde350365c8fc452715fac1b.1667901510.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OaLEbJeTa82b1zV4"
Content-Disposition: inline
In-Reply-To: <cover.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OaLEbJeTa82b1zV4
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


--OaLEbJeTa82b1zV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNqKX4ACgkQVbJhu7ck
PpQ0yg//eNimofQEG9uS0VDK7bTzJRMVKOAcnZfUrM6onCZxn6EW6s3LPPiAQXQb
rn5vSwsTxEfFkAY1HfDv03Ep/C060IETQugx/qJx5CvRsQ4LqdVp6lZIrVKvLefX
3DGP3T4tgp/ggU6koacytlhu6K/Avml1LBpC9qpEz6B+8KXoAxRkNpD1r/b6NkWt
/6Ivaxw/R+GdEDDOf5qBm/ve3p9B5uBi6Z4ZBb8W41QV1tpsguPwW44qy7HwRPIm
qiuTAfMR+50UbVgF6JBn8xFFu/ljcI765rmwkiQ+CGO6L4wfqMg2OsHlL1HuxG0T
33hgNJuPU6p8H4j0lL2zBzggRUJCBdekBq4m+4P8sfoIlNc/YL4PnUKdHUL+jzq9
nxjsg5YHgeMoBmmWSBLd5ytBav9/D7rmgcc+w9VEI2PgZn4J1kT2n7nkxiashjm0
G6sveXIatTVZx6b+vMNUmHYs1FXVJTfhDotv+eJKlA+a2D0tVX+jNc4BQtepKQvz
TKSWzeJkR3dttwb/FL3V2dnezSE8Kep5oKW4DXvDtzR9+XpqXedbnLbgdj7pA7oe
qmuenufGP+pFAWU8wrRSA8v8q1zz+/yPo4HhSw0vUiSYcbqzPWTHScqshcObuFKg
CspgmFczciedrQG4Y5Yy+gFUMVVG+F0PAn5Oxq/1hpPm0UYSwbc=
=Xfrk
-----END PGP SIGNATURE-----

--OaLEbJeTa82b1zV4--
