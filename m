Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F96C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 13:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjEINCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjEINC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 09:02:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A4955BA
        for <git@vger.kernel.org>; Tue,  9 May 2023 06:02:24 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ED9265C00C5;
        Tue,  9 May 2023 09:02:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 09:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683637343; x=1683723743; bh=C3
        liT5sZ1BX/n7TQ2VvBir3qKdC0DRGWHvt8vfRk8fg=; b=KPWmL14/wQOAIMRa5+
        WDI0hCP52ymuIaCIFtFz/wUg50t5lFc/3v3jM9fr4W8ygwa1oeTRf/onQ3TINpcJ
        4J6OqY8XKxAqyZzNPAVezqJRwamVh+LzSNvA4dSEzz9EaH9LYL1+KUYuWfglpynq
        P8rjG6JlL6V41vKi7fMHbY3xQPB03IQG1f6pO4SfWNMuk6E26oHVXf8FT8g8gN5q
        klMbNnLCdjroulsLF/coltEFXVunkPtiWc6xEmOYQAmapQn7oDLxhI3FsZlkX6AY
        mtsK8pH2LXUiYxH8E+FMYsHOQfyhGXHA8EIjOKxKNihneNjbyo7zY+kougDO65or
        F9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683637343; x=1683723743; bh=C3liT5sZ1BX/n
        7TQ2VvBir3qKdC0DRGWHvt8vfRk8fg=; b=TPrbfjGyRWVKSyGXloWwOa7ULwn4g
        dR3zNDjRvzX+b4Map2t4DYpo6z+vqT0GtgXiA0I4ywDQ8ZsO/+zRjhCLXff4l/4d
        +yTe5f0/gwDpVHCa4QA4WFqo8hmWmkO6wWs7VaiY4LZR9NUzBkJhNgh0SyOyaUjB
        gqlZOc3qQFTzDJlfi2HimDzgm+ZMgX82+q95gVbyHlugbltMIjJf/GHp9irV0Kiz
        DuAlKTgAbVhUvtXJ3W+pMNe2534bbT09kO4AoFmw1+xUpYZWVXGaz4lNe44wOt7t
        gOhXnqubfvGMjRsTqyTl5qiw8633DJim4vGruzOmVh6Pm0v8PUz4zcBWA==
X-ME-Sender: <xms:X0RaZLjlwTl24dMN3ti_Eq57tFQVEfyICDR3uqiGMvu85hoMyG03QQ>
    <xme:X0RaZIA7iGmZwsa88FieiwSu-jKJ3BoPh4nasYbRPtlyem6n7VAFSTJlk1koNNXKI
    w8-dE1_c-h4HP8aXQ>
X-ME-Received: <xmr:X0RaZLGt1iWO7GAmyRTj6b_aaU-8o4xKdKWYEyAhFs6k4-P6GX8_PoX2eQkZ-WB2aeWWe4wZQeU7pjR5RI6awHFVJfmQwVcwYZ4dMMN9wQs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:X0RaZIRmhN5nm3El4Es34BrYoy77iQo3_0G_R6Woa_wS6nnAoBSTyA>
    <xmx:X0RaZIwCbug5RnbDuXtNMJH8AAAtTNNQChIUGY7P6086Q6S7decjSQ>
    <xmx:X0RaZO55Fw8SNvpJcFHwaqJFa5LtW4bJyZ35EfvpZIvReusaGhn9Iw>
    <xmx:X0RaZCt-8Tmb0dYhNQyTlPfgkULSeZ_oZ6KhGtU_9JhTEGuA5f-_6g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 09:02:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9102eb27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 13:02:14 +0000 (UTC)
Date:   Tue, 9 May 2023 15:02:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 5/8] fetch: introduce `display_format` enum
Message-ID: <80ac00b0c4b0fde61a3edf48d996e3a60327a54d.1683636885.git.ps@pks.im>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NTSXfBE8kgrYD0VI"
Content-Disposition: inline
In-Reply-To: <cover.1683636885.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NTSXfBE8kgrYD0VI
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


--NTSXfBE8kgrYD0VI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaRFsACgkQVbJhu7ck
PpQ5VA//aaih+5E8KzkrWdC0KnCDWwFE0HCDSbARMafVpbrKvwFEwFmpJmiHi4ot
YLVqsj+mKyb97NdOQHV2d27F7aRrA+LOyzAMQFwDYSWE1ADEa8OyCToIoC3Fgbqk
e9F46L49cAtEICgYEPPkUY3Q9fR18NPqOl44H0k5nzxBUK7S0wiTLp+iIYhFSL0O
gG6ro2T5n1RS3Titkf0L8rwvoc2KKoBCbqyNNaBkryRh+leGa1/CrntO7tXzfoCO
LHyX6JH0ObKLXqCKlfJhXL9Dz4FTukq4yJGU4TfYetemvmhOSf5Hmbp5OK0qle22
lQuCZCX3M3HzFikGCbANV8UvcK25c+lmncuEq85Fl2nP3ShUW7cSByARBlRx9yjh
Wr47nlzAdZWzJkjNH07RnWx0RsiAJRA/4L4L9jNOPbShUtlIyQQwSumXPzBsKM4v
UlOrwcbQyq2aRZbni+nk/DQ9AuMhiDAbDEDdTJpLcmU4fLZdfU2jjli2dHwVdjdm
JUErMGlVqRMtaUPB2F0uoKZUbt5hX3QxA2stkZ2TASvuuHB/fuEilPFkRX08GAm0
cFDcL3uk2mtIevGR56LVPeEH54fxT+B+YNZPBwHnX7bpGekSe0mGa6EWdkN2bYF9
QTeyVr53UNN1nRQRGk6iFWCB0sh99o0MP5V2aONCUo8KyyVqQEA=
=dVYG
-----END PGP SIGNATURE-----

--NTSXfBE8kgrYD0VI--
