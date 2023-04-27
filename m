Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF42C77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 11:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbjD0LNh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243660AbjD0LN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 07:13:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9601A55A7
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 04:13:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DDEB5C020D;
        Thu, 27 Apr 2023 07:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 27 Apr 2023 07:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682594004; x=1682680404; bh=vC
        VEl1KkpKG0GXeFBBIhQGMaTh7+rZP/uELoIa6WyCY=; b=AOwWufHtv6+As2+A9j
        5s1QiUtN1ZMv3fK/rzZVslPRhT5EISvnpdefu0WbkN8X3dmJ+i6gFdb03Z7XF1MY
        48/AtMPWmiX6b6SjGtJvMwgcWv6luKlKCS5hOyXvqp4SPnO631URY7p6ZkPzOc9w
        CEltJWlAmOKRaEANQGAY8VnZVHYU0Jv76GV4XoTPwJfmdVNgSi53N8QXC3F/IQ7Q
        Jp9UtmvkWQBZ/OL6GYI8hxUgVe2hWhjA0fSID/pC2WLytqycNvr96WOuitfkl117
        7xwrrHP+k4/SL2oKA1H7SoYR09ufnAUDhjXox5+TFKC7Rw1tyCvyK6ns0zvvZiSJ
        3qww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682594004; x=1682680404; bh=vCVEl1KkpKG0G
        XeFBBIhQGMaTh7+rZP/uELoIa6WyCY=; b=O/LVO1u0NFbSdiJoek/XmnKCvJzXH
        DXZxLeol8kuH4nhfpNIJUFAcOBlwOt8ThKOrOnOdQnA1yhzlHKmnPOPr7OoPIplM
        Wojqd4qYJh0+ETBdh441qy78rhcYA7SN/EykyullxpltocvgML5HVhQjKoYBwqAV
        jCV6HcodGePvw6RJLWnL4tZcrDr1cSFx111xCXJuvOzhLVvNXirAwME12qOafiSy
        yqfwgfzblmrne2VOGZ0VsP2s+SETBjkRONAPh30RIgMwvyT/BqDJFic5dLcB2TFG
        VO9vXqtfidYMFDJg0JT8vp1UEh5Y3eHmHTO2zSYmPcdCybjvxERqoHzhg==
X-ME-Sender: <xms:01hKZLQrj2oaBe6YEQOfsD8IHAGXp7kyQIwRuZekzMRw5dY2hHBZEw>
    <xme:01hKZMxvH6pFBajpw9uiZlLbRXo5JwTpHwQcrb9vTLsYM0Y0J0otOpTaY-CtI3uOc
    NIoLYmKvGVFOTp-nw>
X-ME-Received: <xmr:01hKZA06RJ3ZtSo6MrAyD7y5Qp3EZKcJy2Pcry0CYhHmLU_0fZdmqsqryXhcw9l_1tLUx_NRVtSib1ZoX6eTdaGkm3XY4uZW69MABOtHUrCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:01hKZLDRE1F1OS8GixJhptyQuePCaAbnIY0gAiRb0SXhbbaa2xAOCg>
    <xmx:01hKZEgsWH4q3eizM0Tav2rurc_1Ug8B8nrNhVeln7QFvOO8Xp7ylA>
    <xmx:01hKZPommsY-JYK_xUcKa_UdwntKQ9GQD9No3WfveduVgEZ3iFG5yg>
    <xmx:1FhKZMcbFOxjyBL6J_4gtGwNN2LGhpbGHp4xXTIUYRJ_4hvdnGKSVw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 07:13:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9b900bd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 27 Apr 2023 11:12:53 +0000 (UTC)
Date:   Thu, 27 Apr 2023 13:13:20 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v2 4/8] fetch: introduce `display_format` enum
Message-ID: <b545bf8bb944b3f3f74300f77de6101ec6ab393a.1682593865.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="noJobqyskFCNUtYD"
Content-Disposition: inline
In-Reply-To: <cover.1682593865.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--noJobqyskFCNUtYD
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
2.40.1


--noJobqyskFCNUtYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRKWM8ACgkQVbJhu7ck
PpQD8w/9F3jbcZ02v0N9r5f4hljVF8Mu+mmrxWWir5p/NKzSFApEf+mhsnydBV4o
U7A5bMzg7eTtZg/FyUAzQG3JVLG31frkErfM3cul1LtW21qtWEzeJQwJvjb+u/7l
HvJnj6qWgDLp+ooQgIUCv+TMOXPTbxhG4kamXShvx5+S6wvaeWmfuFrS5f8OkO97
Opg3kxRNmB8Htk0Qyd0CB6+20wEuPn59S7w9DJh3frHkBZaD3I/l9aJL0lj5WaCt
mYUC7NIZUZW0Q6/xBXPgE5pLctzji2Mm82+hxINzcsXAnaSC6+HWjJMNZ6dlbIBw
PaEPLtxrfKi+4LTDt4QWHKQNreXTk0qbMvmn1r88K+vTQxeFpYys/NrrTJDcDTQ1
pgBLvagGJEltQ1GAYn/cVeSf7grJQaROUsCu6bcTPXC6qgpUqzRSphgztOUm4Z2J
1HyqLa1+3kiefDb4tXivF3G1HFPxCFVl0r1aSN0Isc7G4OI82Mhh7S+nGIaqh3XX
W0IlEy4yj3OmbAW92YKJwyi9ltNxgxVvOQ6tHOFdgfwp1H7BuvU7ur0D0kx2F1lR
orL4vbBTE3xA9dB6CHo7Y70Ny6nJBOiChT2IUT8S/ss42RgkVm1Odp9ucevGcAJc
dL/f1E1GrMA/V98U5/KB+7/I6fr1acQn5M38QA9yfC91xU245FM=
=27Xv
-----END PGP SIGNATURE-----

--noJobqyskFCNUtYD--
