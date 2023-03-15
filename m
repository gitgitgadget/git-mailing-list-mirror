Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292EFC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCOLXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCOLWl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:41 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879198A3B2
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:21:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C95E95C0784
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Mar 2023 07:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879278; x=1678965678; bh=Dr
        wP94HVt92xuGwzIh4v2eR6rzmZKtfbQXWV8jK0wxw=; b=m0pmkmRZqYN/CT+k6J
        bPXMJob0ehnurihXKBAy6bPOogi3D1PyOG7tegYAbXxptMBQfH4LbfUnOk4Yk4B+
        Yl0QwLyF6RsoYkHeOVx5hbFmIMkGYBUktEiBMWlx+TTEITYSNe6FkR4xBU216+W3
        BHwmQfdm9b+MhJCfEriskB8Q/sN72r+3d+zk+yVka/Zqb1kZTNNTl+svzQEt3z/a
        UJNlcxnoEVkgTrpvIdRCYcPPLXOEdLi6UdVUNJnPKnk5I4u/AxLgDP+7s5ubyVdR
        lBeBNfqfA9DeSWO1RUGdaLNjetGtCOPGnVcx8zoGWSlqNpa1em28/cc7H8S/Jlz3
        uufQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879278; x=1678965678; bh=DrwP94HVt92xu
        GwzIh4v2eR6rzmZKtfbQXWV8jK0wxw=; b=VWk7wLlUFWlr9VJK00owW38yfDY2M
        th1QY2W/EVfqR9bLt7A+RFXoxyL+GA0IYC8Rq4PQ8YIZQ4BG3zhvhthqtQtKlodV
        +NUFeUJpFFYvjqCqocUalGGLYeFdJsTCL5WIDyyfGGcXUG8+6W9IpUMseQaptESK
        ZxmNP9pHjYNWtnHPHTQaca/dq2f1GZA5q5So6B7wUjjqoCHE6qnNzinAvf0Vn6Oa
        v3DBwWBeKCGLr1eXGTKRdcje8bb9XT+JbUd0/7sBGZ5S+Ktx90C+5qEuu9UGOPUC
        GplMg3TE7pMkOSr+pFvsevpXnK6cQKj0Ed70yQBKBLHsGcWKcZru+CMmA==
X-ME-Sender: <xms:LqoRZNiFQpD-jkaTbO-FU65gKX-1kc9lgaZ6Xy0gn2RY03em4TBtTA>
    <xme:LqoRZCApqSuzQHW4mZug56o4EvyK4Miv0TpqB8QZU_f6LdHGoihzUD_ryT2uvIHx5
    qepMxCqCb4ZoQh8Ug>
X-ME-Received: <xmr:LqoRZNGa2TLvU_pAsQ4nzCagcyn_YWopzE1tip2-6ISWxuaSYBc0nvv61q1S843qJO_17xZGOaxUX7Q2OLmX7AIS4C3VEFxjLaVJXIVPEFc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LqoRZCQdTmMbieg8UHwSWR2RB-dm6NMFc10uOqqqpSD862ChuN8Nxg>
    <xmx:LqoRZKyE5McE1X2CtvCvIfwVxUPlv5sAu0u-Ay7_IgXp7QeSSl_WJw>
    <xmx:LqoRZI6h9WLlKwIxcWI9JMAOHV6DFGpMEwAK73IzObqFuztYpS1H4w>
    <xmx:LqoRZPtfvfJ1PqDtn9TUU1nmy1Ibe6znv4cdOhnRPCX_VFWTWeATwA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b0196e6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:20:55 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:15 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/8] fetch: move output format into `display_state`
Message-ID: <a4fd935c40575503c4d708bd19c60f5134fb073b.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gnP+Os5yedin6jsO"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gnP+Os5yedin6jsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-fetch(1) command supports printing references either in "full"
or "compact" format depending on the `fetch.ouput` config key. The
format that is to be used is tracked in a global variable.

De-globalize the variable by moving it into the `display_state`
structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3695299177..f9ed9dac32 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,6 +49,7 @@ enum {
=20
 struct display_state {
 	int refcol_width;
+	int compact_format;
 };
=20
 static int fetch_prune_config =3D -1; /* unspecified */
@@ -745,9 +746,7 @@ static int s_update_ref(const char *action,
 	return ret;
 }
=20
-static int compact_format;
-
-static int refcol_width(const struct ref *ref)
+static int refcol_width(const struct ref *ref, int compact_format)
 {
 	int max, rlen, llen, len;
=20
@@ -789,9 +788,9 @@ static void display_state_init(struct display_state *di=
splay, struct ref *ref_ma
=20
 	git_config_get_string_tmp("fetch.output", &format);
 	if (!strcasecmp(format, "full"))
-		compact_format =3D 0;
+		display->compact_format =3D 0;
 	else if (!strcasecmp(format, "compact"))
-		compact_format =3D 1;
+		display->compact_format =3D 1;
 	else
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
@@ -805,7 +804,7 @@ static void display_state_init(struct display_state *di=
splay, struct ref *ref_ma
 		    !strcmp(rm->name, "HEAD"))
 			continue;
=20
-		width =3D refcol_width(rm);
+		width =3D refcol_width(rm, display->compact_format);
=20
 		/*
 		 * Not precise calculation for compact mode because '*' can
@@ -887,7 +886,7 @@ static void format_display(struct display_state *displa=
y,
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
-	if (!compact_format)
+	if (!display->compact_format)
 		print_remote_to_local(display, display_buffer, remote, local);
 	else
 		print_compact(display, display_buffer, remote, local);
--=20
2.40.0


--gnP+Os5yedin6jsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqioACgkQVbJhu7ck
PpTl4Q/9EFxtjzryhpBugvWtfXS6Ky19pKRAAOaR6ITpKYVJnTYbwmP6JZTpqMe4
PrWrVgaxlNgY8tIL1CJqFOBP1Etj6I0GPaFfGaFdp9c2YgbrFzNawpYn+FWGFYly
tUIyI+VtKj/dF8KffW9ysnYW40PZa8Fyrk+GG2MIljIuEeKYgtX6hgbW/xcRDIlg
IEipWOAQYD83tnsBwy3+JWgIFBzgEAcPdgH/JlXZ4GdzmkUrANaePi6JCkqEk2WA
txGbcTZSNgEh2JRKXLnDpn15IyPfwB0kvEL/b76CJpU55p55Ag46ggK4l4Hjg/Bf
ghU6Gd3P9GZZvHCUDNjvE5TJcs+nD6+I4xxHiA/bHMl52NuhDds5ht/pCC6+NLsa
yjt5TraHMjNkXtl4xUJCqPjSNPBJN1p2Rwp8xXarsjPvbgCMUqY+uCDXfaYhh8vG
cVl5HtZg3aU7zGxTcIfAKE29WlYMDZJDfTv+g5nlXPPoIrQcb7p9PKaP38YE+KS7
/W6Hrm+HZ1nfb5R82gOGKWVJ4FfID4KdJHJUG+RFgJ2X8CPGuvtHFgLRGy7N9wMj
1EisGN2v+4MHieZ1q9HTwzk2zZO4z55D5SDgtRAxh3auUDutm/CrjPFXiOTAopp0
vxfqSTyY4tlwYqyRG6PWYMZOZy8OF/8wg/rWO+M+VLSQED+E7uY=
=2+M1
-----END PGP SIGNATURE-----

--gnP+Os5yedin6jsO--
