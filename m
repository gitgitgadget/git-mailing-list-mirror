Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2DC6FD18
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 12:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjDSMc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 08:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjDSMcC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 08:32:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2ED3A91
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 05:31:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E2C2932005BC;
        Wed, 19 Apr 2023 08:31:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 19 Apr 2023 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681907501; x=1681993901; bh=mm
        6PKNyyYoj2jYr078aPB49Fz5/wmNwiE9w3CDe8spM=; b=YkMpRc8/zlJcPYpBxO
        ONthXhNEa7RuNPU51GLwnv1Cn1zMW7q3FnHlQj7PM6//GjE6ezkQrrZas0KYOPQj
        xffgS3rnLyHrpaYKntB574yC0z2OxPwh4MNG5FuxDN7zDFm8IgG/ZbsBp6ABPUqm
        n7g82iN9Rdc3fbmYv1i1wxXCaZHvrow+UtvWmnIZLzGi6yrJO+DCNku9n1Ii8/ij
        jh2Tyjq32WgS64GczcEaNO7hj+1w/+Mc66lUIpkhV+g1HHafVz26CKpifxroU3S5
        2J5Zj+o3buhMxnotKo6APWQLm3HP26sBOEAhdfqvaG+9qYIj/XFXzqkv0jPnY93j
        IEZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681907501; x=1681993901; bh=mm6PKNyyYoj2j
        Yr078aPB49Fz5/wmNwiE9w3CDe8spM=; b=Wzdf2BF20ANT7TDw0rDTnZxfCz48N
        5g5cxjj5pY32t0BgJNUezAYdZ6swiwGl1xa/QQ/8w/JIR5Hl0ONbW4Cxgk0dIeDM
        j+CsmlBVnkAphITMO1rs3TXrzyKghg3PFH5Nr9g+7gGhuVH4OcLYCgo4enRwzJSS
        qkMWVPac4i9MiYyKlsvH9VwOQG/hgJmDJVkKLniWwbOVHrmItsfUdp6YdAXotPvI
        G4b5ncqHhgZrIZmVNZIpFXSFXbh9ZpNGVVoqmhrDpMgKOreMy4cG0KsNYOWqI125
        2NiUdFmDExOTrf0cIBr7BI3LSD82OO09GY54tU+eeJqggkFj+BIfNrfBw==
X-ME-Sender: <xms:Ld8_ZAwo8TwC9e8M8pFN-dJLf6oxhzJvtLom34EXDrc-Ll-jSB8v3g>
    <xme:Ld8_ZETxrjcQhVS2JvjqoQiRyBNOrwYqVpQS7hmL7HBQnZiT6BL3-PwEj-kESBa9V
    HoTaeg6_Ya560kKww>
X-ME-Received: <xmr:Ld8_ZCUqUDxwQl4JGbNH0a8ZdKCQqltDcJdHeafMe-r29WAv4jjbdUw7P29UYlLBl6d4sCHz9i-waxBxi2YFR2EkKVz4hKHZx4ZXIorCQmODPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedttddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Ld8_ZOib_uhS9TpkvfxYmuJn-H5iW-c7MJRtheECtr9NlG9VGbqTNg>
    <xmx:Ld8_ZCCWnhqDqW7Sj9feziXPiQ-UyGmIytjuZs2g6mYOhsCOoAggEg>
    <xmx:Ld8_ZPJHzXZHczCdByCsCI__HbvqxkPq7UUK6HUdzFlWKmDGQHoSog>
    <xmx:Ld8_ZNqGKMukBz1iGAn7bH_fZQqpeQ67_o5uYIMmlXflLyucVa08wQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Apr 2023 08:31:40 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f7fd668e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 19 Apr 2023 12:31:28 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:31:39 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 4/8] fetch: introduce `display_format` enum
Message-ID: <8571363be1943ed12dd5295593509bae92194933.1681906948.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0o47oBVQXDUw35fC"
Content-Disposition: inline
In-Reply-To: <cover.1681906948.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0o47oBVQXDUw35fC
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
 builtin/fetch.c | 101 ++++++++++++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7c64f0c562..e03fcd1b2f 100644
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
@@ -784,7 +790,6 @@ static int refcol_width(const struct ref *ref, int comp=
act_format)
 static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map,
 			       const char *raw_url)
 {
-	struct ref *rm;
 	const char *format =3D "full";
 	int i;
=20
@@ -809,31 +814,42 @@ static void display_state_init(struct display_state *=
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
-	display_state->refcol_width =3D 10;
-	for (rm =3D ref_map; rm; rm =3D rm->next) {
-		int width;
+	switch (display_state->format) {
+	case DISPLAY_FORMAT_FULL:
+	case DISPLAY_FORMAT_COMPACT: {
+		struct ref *rm;
=20
-		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
-		    !rm->peer_ref ||
-		    !strcmp(rm->name, "HEAD"))
-			continue;
+		display_state->refcol_width =3D 10;
+		for (rm =3D ref_map; rm; rm =3D rm->next) {
+			int width;
=20
-		width =3D refcol_width(rm, display_state->compact_format);
+			if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
+			    !rm->peer_ref ||
+			    !strcmp(rm->name, "HEAD"))
+				continue;
=20
-		/*
-		 * Not precise calculation for compact mode because '*' can
-		 * appear on the left hand side of '->' and shrink the column
-		 * back.
-		 */
-		if (display_state->refcol_width < width)
-			display_state->refcol_width =3D width;
+			width =3D refcol_width(rm, display_state->format =3D=3D DISPLAY_FORMAT_=
COMPACT);
+
+			/*
+			 * Not precise calculation for compact mode because '*' can
+			 * appear on the left hand side of '->' and shrink the column
+			 * back.
+			 */
+			if (display_state->refcol_width < width)
+				display_state->refcol_width =3D width;
+		}
+
+		break;
+	}
+	default:
+		BUG("unexpected display foramt %d", display_state->format);
 	}
 }
=20
@@ -904,30 +920,41 @@ static void display_ref_update(struct display_state *=
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
2.40.0


--0o47oBVQXDUw35fC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ/3yoACgkQVbJhu7ck
PpTKTBAArICo1SleDrnFk5lrGW+LnTOKINKQrHA7CFr2SF8DpXaTFpsgTRZoTr/x
s+/qrNYKt/IgvK+jmsT14GV41FWDw/7CgSc2q0t4rGJhWbvo6GIUlMxZjLQEDFaa
W2xZk1rJVJ8NStD0/7XuRsQ1G4qt1D4EBsSu7HDO//iOoXHd4i4Y0azSRRLnf+1y
gFwAJzXuxN/nDID33xNUy9y/Hvl8wIZ7YfVJw9Na/YAtyyY/G/WWAgzepcbSp3Uf
84OctHRU35rrNbfepKGmxj+ThLH2Ai+kg2f2RW2YYwAGY62izAjOUFWQpoySBZjO
j92f12jPWMIk3uQ3YN5mtphPjb9Y5dyho5bE88l0X5NsJu0WzIHt/+DD8Iv9iMhg
heGNb8QUQSpsg3DiHe8WxZyoLVAj9xUzylRsKVE7Ug+xV5ojql3/R4NqFtKR7m1v
XcDMWb9emee0rdO+rcZAKWUPYKpIwFHshBWqYkaiyYGzFKYG4heEQoszKMwLC5I1
t+ZDX+ODYtcf+Cl7lVLHyqunr8WoZXJGTaGEPbxfiSe09I62essKAvFS7VzZdbmU
448GHe8OskvEsvlesz1H3R0bDTylsC1wzHimbKjXB4La3gGW+Z+OunVhGU4NYH6m
u1G/+ZzHIG7oC4ItvczE4QgcyaiJB7A53jfIcF6ahuAB4Ne0ICs=
=LT47
-----END PGP SIGNATURE-----

--0o47oBVQXDUw35fC--
