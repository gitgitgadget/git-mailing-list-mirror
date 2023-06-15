Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA54EB64DD
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 14:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbjFOOkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345107AbjFOOkC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 10:40:02 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FCB1A2
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 07:40:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 08F095C0116;
        Thu, 15 Jun 2023 10:40:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Jun 2023 10:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686840001; x=1686926401; bh=d7
        8QWvegh4rSoqDR/eNvU/g8w1IjNHkbWTQKxUluZ6o=; b=kWuoKIE23hnhmnRHe/
        tzxcoNV7GiYtKDRZ5hjEth7hiEyg2DslwFT5P5ZEyxEE3On1dPP7igNJ/XD+lbr5
        77GXRohkZDZRJFtBvX4N6FvjyC3SwlcFeDHHiWyiiWBPmRIsn8yT4stBQtvn4vQt
        6f78wQb+CxUqV7CP6YoIzV5HSFn7/AuQnM3DgusjfiQR6gevSzuDxP6FMaIOy90k
        QQrGxJsPWmo4w7MXiJRaODlv29p8sKAuscB/j+1XRilMRUv/Z9JAYAxPeDLIcgzd
        rpw+2ALs/2xStA80YQUNikCltsz8i1L2KBeWdxNaPqmF5mFVwab0tJ1XsWJ6OSBL
        imhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686840001; x=1686926401; bh=d78QWvegh4rSo
        qDR/eNvU/g8w1IjNHkbWTQKxUluZ6o=; b=QQutm4p3VUch5hH8EnlQ4B4kuLGsn
        l23srif5fSuUZW//qsAT8mnKTPATB27lamHLC05bQdSbcsEXH4R+7yrXVQxEQgy7
        r/3zxo4XEoMvbFSNcriC1IK20s4TeIKPNqMK3CNotB6NN9lng1jLd0F+OtfYb//E
        NOfpMyXhkVIdJ7fv4HmxcLaOsbAU1G+OxtUjbMii7wjsoCYDBhJj4Wb+S0wB2n+w
        XuHlOpLlBXx2QB/aYHI/CsODU3bN05Py2Axh62HqeDD11+u4V07AVRfnLxbA0bUG
        CaMnMy24jDmbrrwfPmthjzbWKOTIaXnup9z+CYYPL0jrDgpZ0k6Gt9iKQ==
X-ME-Sender: <xms:wCKLZODuvpj-infjP50vIs1UnBR6t9d6-s6AXKZzVUprt9UyRkqV3w>
    <xme:wCKLZIgRX1Jl8Z9OH39WLW-vBL1bqJfQyhb8dIpfhoDNiN5wlfq-ebLuelByEfqAZ
    4yHbOz1zznBprhBwg>
X-ME-Received: <xmr:wCKLZBn_-ozXWv-QEqEnCCebYMKA0u9eH5Kz8adgu1mTXapXTY23WCujWaA0meRc6clKNkkAdnc59jiYgQsiliZ0vInhVzaux1K4h-oONFqrvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wCKLZMx__qUopvxflq05vtyUuFvmhSSSMpgODwx5tmDP0qt_QA0CWw>
    <xmx:wCKLZDR2gUgq4WMSDLHRfoyl-WmioLFsbxjcaF1WDxwYbdmtZS6hJQ>
    <xmx:wCKLZHaoKMA2-e06BjcbR3LZgL7cxv4JzV6cfRnxPBnhM3-SEndFJw>
    <xmx:wSKLZE6GtZ7taiDKA-bSHcIqSoN3CDEA1gctsquKmuDz3xAd9JrhvA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:39:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f6881167 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Jun 2023 14:39:47 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:39:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] revision: reorder `read_revisions_from_stdin()`
Message-ID: <6cd4f79482276eae333bab8cebd114fa913659e6.1686839572.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
 <cover.1686839572.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6a7n67lcrstneqn"
Content-Disposition: inline
In-Reply-To: <cover.1686839572.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w6a7n67lcrstneqn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reorder `read_revisions_from_stdin()` so that we can start using
`handle_revision_pseudo_opt()` without a forward declaration in a
subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 66 +++++++++++++++++++++++++++---------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/revision.c b/revision.c
index b33cc1d106..cc22ccd76e 100644
--- a/revision.c
+++ b/revision.c
@@ -2195,39 +2195,6 @@ static void read_pathspec_from_stdin(struct strbuf *=
sb,
 		strvec_push(prune, sb->buf);
 }
=20
-static void read_revisions_from_stdin(struct rev_info *revs,
-				      struct strvec *prune)
-{
-	struct strbuf sb;
-	int seen_dashdash =3D 0;
-	int save_warning;
-
-	save_warning =3D warn_on_object_refname_ambiguity;
-	warn_on_object_refname_ambiguity =3D 0;
-
-	strbuf_init(&sb, 1000);
-	while (strbuf_getline(&sb, stdin) !=3D EOF) {
-		int len =3D sb.len;
-		if (!len)
-			break;
-		if (sb.buf[0] =3D=3D '-') {
-			if (len =3D=3D 2 && sb.buf[1] =3D=3D '-') {
-				seen_dashdash =3D 1;
-				break;
-			}
-			die("options not supported in --stdin mode");
-		}
-		if (handle_revision_arg(sb.buf, revs, 0,
-					REVARG_CANNOT_BE_FILENAME))
-			die("bad revision '%s'", sb.buf);
-	}
-	if (seen_dashdash)
-		read_pathspec_from_stdin(&sb, prune);
-
-	strbuf_release(&sb);
-	warn_on_object_refname_ambiguity =3D save_warning;
-}
-
 static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat=
_token what)
 {
 	append_grep_pattern(&revs->grep_filter, ptn, "command line", 0, what);
@@ -2816,6 +2783,39 @@ static int handle_revision_pseudo_opt(struct rev_inf=
o *revs,
 	return 1;
 }
=20
+static void read_revisions_from_stdin(struct rev_info *revs,
+				      struct strvec *prune)
+{
+	struct strbuf sb;
+	int seen_dashdash =3D 0;
+	int save_warning;
+
+	save_warning =3D warn_on_object_refname_ambiguity;
+	warn_on_object_refname_ambiguity =3D 0;
+
+	strbuf_init(&sb, 1000);
+	while (strbuf_getline(&sb, stdin) !=3D EOF) {
+		int len =3D sb.len;
+		if (!len)
+			break;
+		if (sb.buf[0] =3D=3D '-') {
+			if (len =3D=3D 2 && sb.buf[1] =3D=3D '-') {
+				seen_dashdash =3D 1;
+				break;
+			}
+			die("options not supported in --stdin mode");
+		}
+		if (handle_revision_arg(sb.buf, revs, 0,
+					REVARG_CANNOT_BE_FILENAME))
+			die("bad revision '%s'", sb.buf);
+	}
+	if (seen_dashdash)
+		read_pathspec_from_stdin(&sb, prune);
+
+	strbuf_release(&sb);
+	warn_on_object_refname_ambiguity =3D save_warning;
+}
+
 static void NORETURN diagnose_missing_default(const char *def)
 {
 	int flags;
--=20
2.41.0


--w6a7n67lcrstneqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSLIrYACgkQVbJhu7ck
PpRRnQ/8ClcHZcV64nDBrPqk8/q9Ka8bsq/CzO28GkSONjhk8AjyPxdNYO8UpIfB
hdTP/wXyOTNI7PBaZGY6czZdTD4jJ1ZWkq4jcQllkqF9GwAQclVGCIZE/p8ZLdwL
HxnbLy94KbTzzPGUJLilAO9WR8DdB2hNsACJtporYfQ69ZOecQVycfBE2HZaBBZB
Rnba88M9nXUQvVblXNGPK+iZAcGK2A01lrdsZYes613pK5WyLcn/S/264KxGRLmp
v/tWNEz1nUt4JIwOILZwzgTg2pcQS131icALzYaFQZbAMzgtC/tRKyUO/g5TXkOv
SKbPLIwcvcy8MUQ09cRH9X9dcnPZLGTdhPX74Mt1vhrSWrMkPyybF+GEI8/vSdep
viY43oW7/RiIybBMkYyT4UALsjbkJaMNHZxhG+3hk2q9Y20Yj90S3AMhGFKL917H
b8gJtj0fWN1Q8P55Sc4dyFGTqkFl0R4qQwqwHtZoxHpYmyrgYebfcfWbtrelm8Gy
iQKOy7MLovCY7KikcyQLvxGCDJ2ftkrPld16/EDEefFKcDKeFw+I/pcgizAP1je7
rP8YLhDPjl77mRAc1akugeCU9tTZ1zHYKixl1s+kPUe32IYR/YUAXAb68vQpJCwp
yRLZOVEmZMJXcAlLXeo06I4JdHYDCYkGVjkevyVZwzRY4SBZDUo=
=GRqg
-----END PGP SIGNATURE-----

--w6a7n67lcrstneqn--
