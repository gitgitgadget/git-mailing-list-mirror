Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C97AC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6987120784
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 07:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NiYz5upb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zzsfl8/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgDBHJk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:09:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55501 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387447AbgDBHJj (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 2 Apr 2020 03:09:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C57EE5C0293;
        Thu,  2 Apr 2020 03:09:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 02 Apr 2020 03:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=c/r194pnijwD639zp9GRammRLa+
        motWVbhfHPCgM2EY=; b=NiYz5upbxutOmG9vkfQz1Os1LYoKxnzIsTBqjvqU+Ky
        Uat207hHHtWzwUX4AYSd7ivbhcMt1hF278WIK3DM280502+CfGjXTKlXQXtVClWD
        tQnhOfF7YI0B+aSK36KzvsckT3SWZaWYUn8WBmzQjp0fgnekLu8x4mWXs5hkYDF0
        n9J+cgXAFSWb2EID3a3tqLoQ31iKZdJs4K5yj1vhcM6tWeALLP6bFPsv2TFZi+s0
        JDBV5FoklwHisfnsrQJLRsUnK+bhhopKwPH4VAWXMnKFFddRKlgZEssZGSy5CM7+
        crQO+TIEnTpQoOFRhstlxkyfDArqBPuwzNf0TNgsh2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=c/r194
        pnijwD639zp9GRammRLa+motWVbhfHPCgM2EY=; b=zzsfl8/vk180U/MHeQAzuQ
        bIB6nk276R3Bcb5YP6n0RHh7njytAEVlC+V3jYqs9vLxyP6210gK1BHnP3D6wAYE
        cfellz1WAfrC1u3C3S3RuunExh86SZ3rUjaM2ztBXbeAQ+iYFwA9YHPDuqeI/kz0
        Bls9r5Td0Szt/ejhFg2TZlyuF+vDGVZQ+sJoUaF1KtXDzNC863YqX6XvbVunBLgO
        NNVofrEw1Tm8Fdh4O8Z08rvM+Zq8ppJFTxEeyXmMY1MZVyOwbSxMqXgHS5vIpWu6
        iEymebA9YPiAgQOjIX2yJ9AgyDOBAkNh/mZqMh6chrHOjoXgKoSLi+0U5zxa4blg
        ==
X-ME-Sender: <xms:so-FXmPGujtiCPPJztFCRJNB0lWnwODF27IxSrpFy_QSLzZadeqQDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepkeelrdduvd
    drleegrddvkeenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:so-FXgo6qgY7WuADrq8VRJZLyMfQGkduwwH82Whl4N7iuDYpLrm09w>
    <xmx:so-FXn8LIJCJfHfl_T5c8u8UewzAsil2inV5yB59F2zIcBTo34FqQA>
    <xmx:so-FXnpGN7G_zi3M0sKANyYv-fEy1YwVLjT8huLwqKh4-Tm0pSe4DQ>
    <xmx:so-FXvUD8fCN14ae2jGmsfyeIcVCZKDxaFgZDl-0IDsjpd7WuNvWJw>
Received: from vm-mail.pks.im (x590c5e1c.dyn.telefonica.de [89.12.94.28])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3167A306CD98;
        Thu,  2 Apr 2020 03:09:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id cff692a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 2 Apr 2020 07:09:36 +0000 (UTC)
Date:   Thu, 2 Apr 2020 09:09:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 5/9] update-ref: drop unused argument for `parse_refname`
Message-ID: <c96395a14de1f7fd73e04eb035b58486f737b310.1585811013.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585811013.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <cover.1585811013.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `parse_refname` function accepts a `struct strbuf *input` argument
that isn't used at all. As we're about to convert commands to not use a
strbuf anymore but instead an end pointer, let's drop this argument now
to make the converting commit easier to review.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index a6ff88b95b..1bba5ea6c2 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -50,7 +50,7 @@ static const char *parse_arg(const char *next, struct str=
buf *arg)
  * the argument.  Die if C-quoting is malformed or the reference name
  * is invalid.
  */
-static char *parse_refname(struct strbuf *input, const char **next)
+static char *parse_refname(const char **next)
 {
 	struct strbuf ref =3D STRBUF_INIT;
=20
@@ -186,7 +186,7 @@ static const char *parse_cmd_update(struct ref_transact=
ion *transaction,
 	struct object_id new_oid, old_oid;
 	int have_old;
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("update: missing <ref>");
=20
@@ -220,7 +220,7 @@ static const char *parse_cmd_create(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id new_oid;
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("create: missing <ref>");
=20
@@ -253,7 +253,7 @@ static const char *parse_cmd_delete(struct ref_transact=
ion *transaction,
 	struct object_id old_oid;
 	int have_old;
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("delete: missing <ref>");
=20
@@ -288,7 +288,7 @@ static const char *parse_cmd_verify(struct ref_transact=
ion *transaction,
 	char *refname;
 	struct object_id old_oid;
=20
-	refname =3D parse_refname(input, &next);
+	refname =3D parse_refname(&next);
 	if (!refname)
 		die("verify: missing <ref>");
=20
--=20
2.26.0


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6Fj7YACgkQVbJhu7ck
PpSjrg//V2dUu8QRuk/WxCV89SjxJjpCA2UklwSfCJl2nXSPdNif7ColgmrUOxJ4
QpvlkRIrHYVU77+21TnFxD0g9uOdWw71lD/jYfuymDWS1ThawOLflLOp7fh5lvKO
K8kFJlPWcv9PZ93UdElaO7tdaurZwlQDWCrRqlObVgvd8D7wbIgpizsN+f6Ydcr/
rE/rDMXHittsOXAF3fXEyM6/IRnQsNfh/QNNe9P/Q+DHKdJuv4pAZy2RGncYc9JR
iEs2USdTI7ZHpE0MHaIraYSWDoDRt51rX+ADznRNaviDqC+mjJ4LgAtYF3f8QBCN
icOwJ7AO823vOZuymWasmIjz38Y2UzRV32r8Eijx2TInm7xK9RSWOnSpfflDP9MS
5OHLSY1JG7oRqbPTt8mWJBtG2ZVNhgjYMUvnGSmXWXd9uutOH36cW6BH2ghLGcIV
/jTH2TDLrIIF41hQyBVVSpA2dCJ256p96fuONDscsgpx6HKbtwHnQ8EUzyA8yLAN
1iEfK1B/34J5zxJAFNoLwaTa9LWZi4EluK9arP9oNjmBrvFcHyWuzYDlPH0kGKiP
uGC5E4laMIh68bIF0xY3q72pHlDPpCxegd8HrZKIehYgJGLd/pvrtKxqwDm/jdi8
KtVoPx+lPjJh3rLZBSr8FEA/jYnnWdA4Tgv6FT13H8Me3aVd64U=
=rhBc
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
