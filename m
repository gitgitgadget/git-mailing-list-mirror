Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F8EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 12:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbjFNMSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbjFNMSl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 08:18:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AF41BF3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 05:18:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C56C5C01A7
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 14 Jun 2023 08:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686745116; x=1686831516; bh=0m
        7M7izwh+xfDm0R1yxpUYx/mCbjjrxCb8RuNRfDSv0=; b=iXS1ArWMlBC+kvaTpr
        J30aFybiXcy+rcXo7fu7YHQLKaPw7HL3AaBQ68QFodyOWE5j5b4hHDTCZSjyxqxu
        t2CjjocBV7qS9CS8vz35XwWU89w6mNMxMN+3xHoUkyOV3jQghM/4KAFV3VH19F2p
        djNqlKTX1O37TGAech89GyVbsrAskdNVxLxZ/RQ7nFrddKeAr4sKuxfc9TirbZco
        REqmryfa0edCgZ8iC4W+wxteErcy2F9YglcEV/U2ETM8DZZ6rrYOfvzC2stLiwzh
        UsXjdcHHwfvY9jHBmzabVYcbnLYez+eQEGpO29/tHBEmA03TURYf0cX+FBz5ktV7
        nGIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686745116; x=1686831516; bh=0m7M7izwh+xfD
        m0R1yxpUYx/mCbjjrxCb8RuNRfDSv0=; b=NshYcGczVLLgO6v4kUqqnOqjowjS5
        aPX+sUaAPCMUK27VcOYqup8xKlr3ea1nU0Yad/+irqxSmZmD9q+6e04hzxZb2ims
        qwiDz+5r3nQt69f5/JiwS309GuYhche5sCEP8fe//R/xObJOItzI2ZDDUYqV47Nr
        BC3oYVDEHhV07aRktmnfYcmZmKjIvpD1w5Ao0HhAL2LXXD2nDlxhES+fCVhEop4R
        UAJRhdO8vbl6DO0kEqxK00fGY5B0WMWqOr1YvQTRUkYDk2vRt/8wEJjJvPVDqsLD
        zzmWl9f0vGEJmH6qh5FO1MiYIqWOm+cUF7wFdpo+2uh3DjYW2KEGFnMrg==
X-ME-Sender: <xms:G7CJZPyDZoaJaVruNW2b__a48ndK1hpUy2A36Xx7wsyo5eowHEOVjA>
    <xme:G7CJZHS2gNCI8B3kimEHUERx8Z7LWsMx791L9lTGwQYV822tn82PcBhYemty-XHti
    1tQergQnFy5hOeYYw>
X-ME-Received: <xmr:G7CJZJU_Ci0YcCcPUG4H1oOPc_XNaMEiAcjrFgDlIsCShmWfBkwBu3N_zTnPFd0obKarTrM9ZXBn-yWcKPkIh2-XhB9nRvyfl_A6v2wJKUQa8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:G7CJZJhcvHpdCai3UsNWV1WerpPeOHQUaVIwVF76YR0RiSzC2ORaMw>
    <xmx:G7CJZBDBx-WxSEvpHASKLuiOVM6TpYNzSCGzgUFERj9S_5rd4egq7A>
    <xmx:G7CJZCIwKKnU253jhwfm4EychM4spTEylku-eHbp6cI4PxBEQutoAA>
    <xmx:HLCJZM_DcaxKFKqWOJKe0CNxKWHyfHkNB2REc5chsBkaeJFfw9vHSA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 955a1162 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 14 Jun 2023 12:18:31 +0000 (UTC)
Date:   Wed, 14 Jun 2023 14:18:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/3] revision: reorder `read_revisions_from_stdin()`
Message-ID: <6cd4f79482276eae333bab8cebd114fa913659e6.1686744685.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="45qttytnejnfeqk4"
Content-Disposition: inline
In-Reply-To: <cover.1686744685.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--45qttytnejnfeqk4
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


--45qttytnejnfeqk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSJsBcACgkQVbJhu7ck
PpQ84A/+OrvR1yvhsg6c39P5QB9qihzZ1JdhxQNJ1DO/vZ/6AYUaYbN+R9Z21F2F
rcYIRbXsKvcHwaFM5o73JSUbMccP/HeCJnpojnH3W6dFSppVY6ldvVf38YHzxCkx
FlbIZiAQ0oyL7mUSW5MGTlufzH7bEvgZEAEneU2sEokU3SU1REBIDgJQJi91gwfP
tck8lPWC4DBmanYWNFgJX2ORyQFHSuDMkYb9FrKQC954lulHyGE8KSNaanMaY/hA
TSujWlQhBiDIK0ILBhLoUvoyDd+olS+2XP3Tk0Zh9uPmVFG9r+gXIeTMJ3CVXjk/
Sll+cNjvowTPSBb+dKjZZ4JgVugiRquxCMxrfAbBbBaWwzCbtWgPuRHr1rL2rtjP
kCrl1p2tfA8xPFthL7B/Jv3TMe6hYd3WeInuaswMun8FGttdB+GtUM7GFUHi0dqd
fkc0xln992JjbWIDrMd2BkenL8odKBnNQ0Ya1cuKzt8xlMPXVRM1eREgWMg7FYfA
22z8Z7N7qYgHf4QY7+V7vIR4Hssj5LL0E3aWcddkkxB8+m5MI51bSWKdmw5ZbgM8
c8KCNzs//MTMZYvkjiGADJX3NJjlhgP+VM141wFPuCLaog1xAS3pSUGZQ5VqEx9X
ZkXWTYHJvmLPckxk5Yl5eEPP3dyae3IjOULXb9saF0xdj6mrpL0=
=MYpu
-----END PGP SIGNATURE-----

--45qttytnejnfeqk4--
