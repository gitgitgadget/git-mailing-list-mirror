Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89C3C77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbjEJMer (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbjEJMe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:34:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7677F7AB9
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:34:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 817B2320039A;
        Wed, 10 May 2023 08:34:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 10 May 2023 08:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722067; x=1683808467; bh=Vp
        z5Y4bjPeocNmWGjzLdVoplGoy421Oxi8GJP9YHdtc=; b=Tr9UCV1e8oPtR0Qw1Q
        lWD5i/Ga3U3Ah9T6VCL5tVgZ26RJRvDaxlOPXB9HE4T9GLzwmD4hoXIg3LwJUWQd
        F1/XeZN280pbqj3PtMGytrMOnOXc0PqC4b7uI25jqjV8lbT7Apizk38Whr/oQcIz
        ig4EjCCIYnT4h1PrpKb5/scPy6cf+Ik8mhTpigjYyLchluCLQ5/Z2USQJW1RzLWG
        fiX9f1/2wA3TPL477Xen6sgt+LSxpU8ycnHuJOQJyBG8wxL9EDNAiG470id4vk3f
        sz86Gt/a8zEkL/PJXsJ3YTG/OOLAOTI2EQa8iVnJOucACGyFrCQDMr4ut15HB0pd
        VDWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722067; x=1683808467; bh=Vpz5Y4bjPeocN
        mWGjzLdVoplGoy421Oxi8GJP9YHdtc=; b=FFphgwf+x5134niOExcEQBBa+Mows
        Cus+g7wSq6SY1x3fsgJC/uigkufYTC8VSdVs4ApilGd5s63OQiNTC+3bs4fACrAX
        ht7Uy6klW2SM7SmNlZfz5XwY2Fqy+9FP4xpucuDdsrgJUc4KTS6idUVyNGxP15hp
        6eAA/G4fKAMICFObJaFNxHvO3IPl8JzZ4RgAWkXRBuGFElM44/8DFXeWUMadstIH
        oLRKUyRnDonLvj91O85/KSG/z7dJTPsl20DU+iXjLsSahyTzRS5Vp4HtlWudbb9C
        XpgJ1rvva8sKZwqDpzCmeh/oxbVHUaWSJDrC6UgH1buPMAt4L4TZHdr+Q==
X-ME-Sender: <xms:Uo9bZJWFa-LK4UTdLNAmrGdwemiVz0rKk5byoaftS6egbUHGDcXUog>
    <xme:Uo9bZJnaHaWK73-Uy3GihXQoVMqC1M_v-FuMJlpxKnct7pirddxrOJvOKwcwD12ft
    IuPXMMqa6z2UpXnig>
X-ME-Received: <xmr:Uo9bZFbhh0oUCkPw2B33m7gLqu1T6gv9PRy2x3oCT5Yq-i_RAKSMeq8jLdC0OQg-yuOB_tJn2nlmcE9jv3iMWAzMjg_2vYBajXaHdFdghu0d>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:U49bZMWheWTkOwZXDPeyDbZsraggGUfpQlHCa4yfz5J_Zp_wYZKgBA>
    <xmx:U49bZDmjAENkGGDN_4Ew9uOs_clZ5ihleKD_jEAsUUoYGEMJ2nUCKQ>
    <xmx:U49bZJdRXYF15LGw2LXufEeCy7MpBNMeGhNfzscKNAky9aurbd7noA>
    <xmx:U49bZMBw6p1lu0x3_ue7kcUC-mB8aovQ1X54CqLvh2H7KbuZpSIGKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:34:25 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d9d52796 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:34:16 +0000 (UTC)
Date:   Wed, 10 May 2023 14:34:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v5 6/9] fetch: introduce `display_format` enum
Message-ID: <3cac552f5ff85f84f986de02bbafa7e4ea0be848.1683721293.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683721293.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="81c38m7huWAkEwJ0"
Content-Disposition: inline
In-Reply-To: <cover.1683721293.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--81c38m7huWAkEwJ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently have two different display formats in git-fetch(1) with the
"full" and "compact" formats. This is tracked with a boolean value that
simply denotes whether the display format is supposed to be compacted
or not. This works reasonably well while there are only two formats, but
we're about to introduce another format that will make this a bit more
awkward to use.

Introduce a `enum display_format` that is more readily extensible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 69 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 007eb3693d..4c58ee503a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,11 +48,17 @@ enum {
 	TAGS_SET =3D 2
 };
=20
+enum display_format {
+	DISPLAY_FORMAT_UNKNOWN =3D 0,
+	DISPLAY_FORMAT_FULL,
+	DISPLAY_FORMAT_COMPACT,
+};
+
 struct display_state {
 	struct strbuf buf;
=20
 	int refcol_width;
-	int compact_format;
+	enum display_format format;
=20
 	char *url;
 	int url_len, shown_url;
@@ -820,14 +826,22 @@ static void display_state_init(struct display_state *=
display_state, struct ref *
=20
 	git_config_get_string_tmp("fetch.output", &format);
 	if (!strcasecmp(format, "full"))
-		display_state->compact_format =3D 0;
+		display_state->format =3D DISPLAY_FORMAT_FULL;
 	else if (!strcasecmp(format, "compact"))
-		display_state->compact_format =3D 1;
+		display_state->format =3D DISPLAY_FORMAT_COMPACT;
 	else
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
=20
-	display_state->refcol_width =3D refcol_width(ref_map, display_state->comp=
act_format);
+	switch (display_state->format) {
+	case DISPLAY_FORMAT_FULL:
+	case DISPLAY_FORMAT_COMPACT:
+		display_state->refcol_width =3D refcol_width(ref_map,
+							   display_state->format =3D=3D DISPLAY_FORMAT_COMPACT);
+		break;
+	default:
+		BUG("unexpected display format %d", display_state->format);
+	}
 }
=20
 static void display_state_release(struct display_state *display_state)
@@ -897,30 +911,41 @@ static void display_ref_update(struct display_state *=
display_state, char code,
 			       const char *remote, const char *local,
 			       int summary_width)
 {
-	int width;
-
 	if (verbosity < 0)
 		return;
=20
 	strbuf_reset(&display_state->buf);
=20
-	if (!display_state->shown_url) {
-		strbuf_addf(&display_state->buf, _("From %.*s\n"),
-			    display_state->url_len, display_state->url);
-		display_state->shown_url =3D 1;
+	switch (display_state->format) {
+	case DISPLAY_FORMAT_FULL:
+	case DISPLAY_FORMAT_COMPACT: {
+		int width;
+
+		if (!display_state->shown_url) {
+			strbuf_addf(&display_state->buf, _("From %.*s\n"),
+				    display_state->url_len, display_state->url);
+			display_state->shown_url =3D 1;
+		}
+
+		width =3D (summary_width + strlen(summary) - gettext_width(summary));
+		remote =3D prettify_refname(remote);
+		local =3D prettify_refname(local);
+
+		strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
+
+		if (display_state->format !=3D DISPLAY_FORMAT_COMPACT)
+			print_remote_to_local(display_state, remote, local);
+		else
+			print_compact(display_state, remote, local);
+
+		if (error)
+			strbuf_addf(&display_state->buf, "  (%s)", error);
+
+		break;
 	}
-
-	width =3D (summary_width + strlen(summary) - gettext_width(summary));
-	remote =3D prettify_refname(remote);
-	local =3D prettify_refname(local);
-
-	strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
-	if (!display_state->compact_format)
-		print_remote_to_local(display_state, remote, local);
-	else
-		print_compact(display_state, remote, local);
-	if (error)
-		strbuf_addf(&display_state->buf, "  (%s)", error);
+	default:
+		BUG("unexpected display format %d", display_state->format);
+	};
 	strbuf_addch(&display_state->buf, '\n');
=20
 	fputs(display_state->buf.buf, stderr);
--=20
2.40.1


--81c38m7huWAkEwJ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj08ACgkQVbJhu7ck
PpQUcw/9Ho9DQmyw3d/TvrZRqTGqYnCk5OBEC1/ceR6aRtcM00KPJVsw4RuQ10nc
5t23tBRKBwCr6Rj634+46eGuU6GVLE/W+SmNNEjgz/T+ygzpYUiiiJGfyL2pH4QM
RE0BkYBSVDE5go7aW2nRK+bRVJLD8T7LSvrxCeu5f0FnYB3yu1WCyBTOrHz1W/pH
o++Eaxtl5fKLnbZUQ0CUHPAGWeI+eUx4+JS0a/yilB/2BfmbsoeYU3B+c92mMQY2
sBpRzr0hNyS96za34YhGCQlfuAU5uJEUYI2ATU3YUQMZDjBykn/c8wRekGSAraOb
KRACvijelmhGsjbKZxzsRko5corGrc3XziqbSz4xx036IzI/b/6I5XDry1cvA7+k
K3InPXr+wCrJo6JpSSFIcxIhxwcsjbX0x6+STbsClCpo1ZDv0Xtr4KL2wYHQWVDM
Nbu1wsoWXcAxwK/Uv1Sh2ZgGprj5PXvgjzmJNetWo8GKaHD3qciGY/aMUU4hGph3
gpBfKpFaRqgNHoYvm7xSF7zMl6Zzm1X2DkmoSA0K+CGkNnQxIgcNx1PD0TMBpnaw
mmgpz17thrTr3RKWQi+Lf3MTanRrGQ7wAUABSF/D/l04bgoUiaEokpS2SwvYxm8r
y9BLQcCafNOYGLJDGiGjXgIpvtLKpW52YKGK8hgedez2d91tnG0=
=wHjT
-----END PGP SIGNATURE-----

--81c38m7huWAkEwJ0--
