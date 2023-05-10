Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC8C77B7D
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjEJMeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237060AbjEJMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:26 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB108A4E
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C672D3200915;
        Wed, 10 May 2023 08:34:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 May 2023 08:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722063; x=1683808463; bh=Dx
        CeDltvomwgZbHYs52cwbIp5g1uLJ+5uTUy9mNg5Vw=; b=ibHrgPYKGLj9odPaY7
        HGiJNSLbdnKJBKR10dre5H6sGQzcmowp6vN3P3tFF7IafR1OY9PVqmUDpqLPAC7q
        TK8grpO4j/2yi3aTjXOY9CJN8KNrJlVoe8wWYL858ehE9TcTcKt7oaHcbKsRIRSH
        R1plLsVOn4pqSgbmVGOEvrTcWz9cUaOQW9nIw4VpnvXZKjAbD8eeb0GzEIaaAq1p
        fjv+v4b1TbF/OG+yqgAcT2ecAStxn7/vykZ7SqD7pEsdXjs6yH5bRMj+tU8jNUJ5
        Bw6X8/Ya75rJbdy983cX9yoCaT734U24TIIwM5yNazHQp7haJa3BzfKUljouTe3S
        D/zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722063; x=1683808463; bh=DxCeDltvomwgZ
        bHYs52cwbIp5g1uLJ+5uTUy9mNg5Vw=; b=Pvz/CZbKR190wcOcBAcl0v7ABuhOY
        UulI1ls9DAjIVg9SCKzyXBzmfx+CdTibTtAmzXuL4TEfk7bb6+fibK0l5S/+RpCt
        M3k2/kNL97Nbb/HE5L2He0/3z6wg32ivi/sHQsln0vVdYA+i414/yvh6ZwJ2nhdn
        D04x9OrrImFcXU8mIODryP2qXuTFAl5GTbPOLWTxWFsPurc8CgRaB2EN468eqnHd
        qQe3k4y4fTuFGxIp1aE/z2vNBZxVL78ggBdmYLGlvJr36l4tMd27AXb0sht9y+6G
        tbrDKfwsMAhp8h5hQMHqqNt7T6nipvzZWP58YRahuJNQWKSiZnbYhSZ2Q==
X-ME-Sender: <xms:To9bZEoWxG1wFkUvikYPA7YOSJY3KWH3i_XW7-6bzy78mR6IC9JxwA>
    <xme:To9bZKoVsuh1jmXcvNa2ttytzQ7qjSgh69bP0pUE-RuXjXMB8YTpEVGLGzLxm0yYl
    loNKEznOKnxO8ymoA>
X-ME-Received: <xmr:To9bZJNNYm8Ds1aOII55w70YvVol1pQcmqMl_-j_zcvX9vu0fzoGS8YrayPz98efKhfHcSPxMDQn3_7ivUxJzXAJ5e1lQZrFDV9S1AnkvVGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:T49bZL6F9AD1SSPVaUfE14x1fxbsjA0JfxXJ3jABtUYeG2YHc90wRQ>
    <xmx:T49bZD5qsWPanREGE0U2yd3sbNeXrZE4BtsCI_afyBnZ8n3rhksLrg>
    <xmx:T49bZLiMDA4fOqav5Caslf1bzbiLLIu-WpoouYKKkhCTsbmUDaiJ_g>
    <xmx:T49bZG24AikkPvPqqtaN9NAsmagN6uU1LEDsCoh1PcFrcD6ftQfa0A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:21 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 0f359f38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:12 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:20 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 5/9] fetch: refactor calculation of the display table width
Message-ID: <bb1a591c2f46b78eb26eb72ec677c65d10cb714c.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EZ6GLDROn14ARSJH"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EZ6GLDROn14ARSJH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When displaying reference updates, we try to print the references in a
neat table. As the table's width is determined its contents we thus need
to precalculate the overall width before we can start printing updated
references.

The calculation is driven by `display_state_init()`, which invokes
`refcol_width()` for every reference that is to be printed. This split
is somewhat confusing. For one, we filter references that shall be
attributed to the overall width in both places. And second, we
needlessly recalculate the maximum line length based on the terminal
columns and display format for every reference.

Refactor the code so that the complete width calculations are neatly
contained in `refcol_width()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 81 ++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 44 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6aecf549e8..007eb3693d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -751,40 +751,51 @@ static int s_update_ref(const char *action,
 	return ret;
 }
=20
-static int refcol_width(const struct ref *ref, int compact_format)
+static int refcol_width(const struct ref *ref_map, int compact_format)
 {
-	int max, rlen, llen, len;
+	const struct ref *ref;
+	int max, width =3D 10;
=20
-	/* uptodate lines are only shown on high verbosity level */
-	if (verbosity <=3D 0 && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
-		return 0;
-
-	max    =3D term_columns();
-	rlen   =3D utf8_strwidth(prettify_refname(ref->name));
-
-	llen   =3D utf8_strwidth(prettify_refname(ref->peer_ref->name));
-
-	/*
-	 * rough estimation to see if the output line is too long and
-	 * should not be counted (we can't do precise calculation
-	 * anyway because we don't know if the error explanation part
-	 * will be printed in update_local_ref)
-	 */
-	if (compact_format) {
-		llen =3D 0;
+	max =3D term_columns();
+	if (compact_format)
 		max =3D max * 2 / 3;
-	}
-	len =3D 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
-	if (len >=3D max)
-		return 0;
=20
-	return rlen;
+	for (ref =3D ref_map; ref; ref =3D ref->next) {
+		int rlen, llen =3D 0, len;
+
+		if (ref->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
+		    !ref->peer_ref ||
+		    !strcmp(ref->name, "HEAD"))
+			continue;
+
+		/* uptodate lines are only shown on high verbosity level */
+		if (verbosity <=3D 0 && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
+			continue;
+
+		rlen =3D utf8_strwidth(prettify_refname(ref->name));
+		if (!compact_format)
+			llen =3D utf8_strwidth(prettify_refname(ref->peer_ref->name));
+
+		/*
+		 * rough estimation to see if the output line is too long and
+		 * should not be counted (we can't do precise calculation
+		 * anyway because we don't know if the error explanation part
+		 * will be printed in update_local_ref)
+		 */
+		len =3D 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
+		if (len >=3D max)
+			continue;
+
+		if (width < rlen)
+			width =3D rlen;
+	}
+
+	return width;
 }
=20
 static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map,
 			       const char *raw_url)
 {
-	struct ref *rm;
 	const char *format =3D "full";
 	int i;
=20
@@ -816,25 +827,7 @@ static void display_state_init(struct display_state *d=
isplay_state, struct ref *
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
=20
-	display_state->refcol_width =3D 10;
-	for (rm =3D ref_map; rm; rm =3D rm->next) {
-		int width;
-
-		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
-		    !rm->peer_ref ||
-		    !strcmp(rm->name, "HEAD"))
-			continue;
-
-		width =3D refcol_width(rm, display_state->compact_format);
-
-		/*
-		 * Not precise calculation for compact mode because '*' can
-		 * appear on the left hand side of '->' and shrink the column
-		 * back.
-		 */
-		if (display_state->refcol_width < width)
-			display_state->refcol_width =3D width;
-	}
+	display_state->refcol_width =3D refcol_width(ref_map, display_state->comp=
act_format);
 }
=20
 static void display_state_release(struct display_state *display_state)
--=20
2.40.1


--EZ6GLDROn14ARSJH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj0sACgkQVbJhu7ck
PpSF0g//QrgEBootgrXU7eU0pzKIJwp92z4UjRF7RBIvxW4GV/3yyY6jJm5e8n6C
X8P9A6qZHnBYhSftvAumMVhgwUzxNaH5GJq4Wf30JfFqsEaWYrebpZ9ntaK4OPpr
6UNp0zuLR4CQbEhnvd9vgL/kFpePvOlQUJ9X1qhZQTOHcc2tZPB5rcPVq3Nw3Gf1
skeYv5LDRY0ApxDrj1qU19OKETE92RFR9DGAdSO7yKABS2BIZ/hzmKXxiQzynaYT
27jpaxSDwKHTluiuUyt2lNTzmVHMJ5aiZl/DIFsYFZXoSJO9+Y4CYZlpUd3Njej6
nh7wE8wnfAvLRbb6qmSud4VZKUuzl1ZPMKCEhgaHtz3iRePKNWkY+O1bTWcgvJgY
JnVIl07FUcff+f2dSQe58rpw76I2ddqGOxdfE1KN2bp2wsnAoAyydQlE+3y2+ylI
EFTqBfoB+m65gKxzS6TPhQFjQyZZBnHa4FoGfYfMTgmFR1EU7PD1yQsn3VsJSCdY
eSg+EBCJKxtBfN+5Vp1lHvs02aIR4Cm+7CMOGZD1NsyLIUFso09LomxwSadDvTry
i5OzAlWTKxHelgbnW8XGTgRtzFzYGtrph+yR6S7hqj5lJoNUVRRmUSedlUmBJxQt
IyaJ1ed0s7fv0o7kSwkS315Q2XYjVApKpB2QsPzAbArq3HxrBzo=
=MsmL
-----END PGP SIGNATURE-----

--EZ6GLDROn14ARSJH--
