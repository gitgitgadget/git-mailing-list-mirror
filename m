Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFF4C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjECLfP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjECLfB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:35:01 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FF6193
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:34:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 868C35C0099;
        Wed,  3 May 2023 07:34:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 03 May 2023 07:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113679; x=1683200079; bh=u3
        UK++3VwJNO1Wvev+fFLvilEnwZtJBIorU3L3tQOKM=; b=OtYaAP8Dvwkg4oYupo
        mYNiNEvCzeB39+3prA03iPAdHZQGa4cTrmY55zG9zx3167H5ZkEjAC3vo12uLTsm
        sgtK9uymbWamE31kTrpWq8bkEMl+JaUWaRK/71KG8MVaRhFpwJI9Q0XMit9eMRGa
        sh01U8eqZI6CAqXROhJm4UZKyARa8XCbp7kvEQmH7u9K6/i09AQ1UalvISUCVZUV
        2hG6uFHJsNMKeQR8wfymbhKq9KyOxVVP3TbuhgAwX7m6RIgPUGDqUnfYbCyGUTXj
        Gq2Je2GV5tc4DZ5Fpj9fzWJDIWROrQ+8kkWi7i4W/Q+qpDP67ixw3VIPT/9dy2s6
        myKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113679; x=1683200079; bh=u3UK++3VwJNO1
        Wvev+fFLvilEnwZtJBIorU3L3tQOKM=; b=Ha9KpwfG2T2UaSt5aCrzldxf1xwl3
        YlkExRwb1S+M/ScxdIgqX9qV+7XdHQCRYG+CsiE5P9nF+dJ57sgDCOqEFpPo/5X+
        dNsFXOXIj/ezbhmd0URkl8UmoX8D7ERfK2KAmK3pKEQX+yn6Ue2m/nVtUxz7IvVZ
        rtYi18oahUHZz1y9zuzuOrUhjKYvJ2K3Ngb8I+CncjcWVI7/LOF+PQVo4sK1KL7d
        pfYYY5IXfKJV6w7tVqgZ25BkT2a6IxrxL3TaJ1tnHzzBBC812WnwyvZG8uD3+T7i
        vIyW4Ep65DTiSvDTkpNOPHPjeJjQWFUSXYgvCs0q0cW1eHSdE5EVgQXWA==
X-ME-Sender: <xms:z0ZSZFDprqPWAgqz9KPVermVV6zTLOxyzKh01iVSfKqvoDCPg9hKFg>
    <xme:z0ZSZDhTzZTUi1s3hKGpk-c_bhJoPn7qhUBy_ts9tDzOV9FjTpY8yozkZzLzeodw6
    pNxLZe6PUQjz41oVA>
X-ME-Received: <xmr:z0ZSZAkXMROcn7ABNHbOKwB7ebPs8DeT6zgq0WwKq2UIMVkOnH8QnzksFN8ens7goK_n5E2VslsrZeB4oQya0H-iZ5A4p4w0IP993tb4nWAd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:z0ZSZPxQyJWmLNrq3IvppdSjtm0o0sjEDgsv_DlRZ5Q1tf499OMifA>
    <xmx:z0ZSZKSnoCsL2XF9Gm0WfdICw6aoG-S74QYEgVBVvcUQcMvkQfja8w>
    <xmx:z0ZSZCZVGy6IS3doz4j5lLok6cKYM0g7FYJKLVQioq5wHCvi02HbXw>
    <xmx:z0ZSZAMoF2koHV9sC-SsN8jGUkea1BBek1KW-G-WFyzfIlavd8C8Qg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:34:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e6613dae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:33:57 +0000 (UTC)
Date:   Wed, 3 May 2023 13:34:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 5/8] fetch: introduce `display_format` enum
Message-ID: <acc0f7f520972b6935bfbc2d7aaf45501155f4ef.1683113177.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hv7FIIXp5yLRMA18"
Content-Disposition: inline
In-Reply-To: <cover.1683113177.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Hv7FIIXp5yLRMA18
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
index 6aecf549e8..9e7e45344d 100644
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
+		BUG("unexpected display format %d", display_state->format);
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
2.40.1


--Hv7FIIXp5yLRMA18
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRssACgkQVbJhu7ck
PpTReQ/8DGCX3dJSr6nT/xqBFX8Akm+ooYqBbCZ623d3Q5BAX9UTCZSwEWeksjKK
+Q9wpWUNJSmfh9TU+61mVcRiyQ5+OT1EhUxDpk91yKcUfz9trELxAzWewU+B4Oh6
QidDexZWCSd354Ko82FygN4oMgm3MfxDMeBE0FYUxulIoV+RpkF/dEny2kszAm3G
GdMONPv+FdpYomuFkYNlYIFwWeCt7QVV27IDwOGJmcxiCdLg8BZp4mnlcWbTnpQf
yhVgZH1EE9PUVWARe3ScXZAQNX9XwaF6QeAMcuc+LcN7Gprt3iDZnES2pgKpkT8f
fwHq7XOxYQocuEX6YrSVkhvc7KlB0/jqVAMe84/ZKeBBzAiH9mDN/9gVCyT022v4
jbFo1GRK29iZzjGV5jRzCa1qCwEvAk0S7QTMTet070gA6T8Uu+zGe+5Fe10a5FK/
RTQMQAcT8e6ap+puzGg6zhXoc7m4cv1HCZn/Zn6r0AsuEuUnuJDxjlez/2qcSB9j
m6vDudyN/ghWaDayReuIGEkoCVupUqtNuFWcgky1ZN70aUH1wuRMIqKvnrD1Cmz2
SQxxY5eLruex7Ok3t95Zc6dreag4JNUgfNiAcHHnpLj4fkLUyVHyUBnJ7Of45fEU
Zv7iAFUxl/LC07jctWianVioW2+Np3T3H8uVhseXgNctr2TDpEk=
=yn07
-----END PGP SIGNATURE-----

--Hv7FIIXp5yLRMA18--
