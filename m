Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80453C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjCOLZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCOLY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:24:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DB7B121
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:23:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F204E5C00AD
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 07:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879298; x=1678965698; bh=Tk
        QXTX4CoCCv1laJoxPvaMwE6l5S3WUf2QheEKMVHw4=; b=0FlB9qiNhCQqQp8oYz
        5zw87pJBK98sUCR0JRFl+DxJlpMTs9smar/wTk8JZkr5saegjoKMj9F1Dl1l7RgZ
        MMOeutHFzc6RnHPqqPwoFcwN/BuzyaNU6RGFR9EWJU1cG9gID0hsVa46V3wnXAYt
        gBw6tRIxGF3uUtt+cp9D+mSNLbhbBKDJl5gcEsQYgfSCPqTX3sobavq9zBXo3DF+
        sNgZaIqKceouDx4lq1lT6H6UenBJ6xJgbNQVD06KqwhNGIuo9UsEze09fHlr+8ry
        RL6jpd5Una8GGfPc3rjElOs1k2gcFRwPZq7d/tZUkgjrUhTI1a0gdexnuyf6xXpq
        9ddg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879298; x=1678965698; bh=TkQXTX4CoCCv1
        laJoxPvaMwE6l5S3WUf2QheEKMVHw4=; b=rfTw5BJyWjCmUPvuZvZO2UGpD+fMb
        f8n1J2iwW66qVa3/Stvv2wlSBpygC1pIlCZ9/Djjm7J7HWVTfL8LXywQf2ij7gb1
        11RFCwaZr5kubQp+spUn+ejgakMf3pWKkJCJcD6O6acorNl0Wwv3/6R9osEQHpOO
        XuaSGgkrF6aUS5AAA7RaJ+RxQoM/1T20/gHtR5em4AwVP8697WGFhA4Uil4+62MO
        tILiiCLSn9t+Namku6Beviq/PYZX0DH4Q+7YNYILnpYMIiR2DHFDavkBTDOBGOQm
        J0SkJMv3Xv9g/wzlydGQzVQFTD/NpPgVD83m89poy1jgVYKTT000w30sg==
X-ME-Sender: <xms:QqoRZPE12MGktraxc6fyySJW0XHSMRneo8C-RWNVuoqQFdZ4fWrG_A>
    <xme:QqoRZMWZp8ldJbjs3Kr1f6eHI8uUZ64T_cRR_miInV3iNZN1upsDXo7UShqZDtfnK
    Ghkat8QgOp42Hnoig>
X-ME-Received: <xmr:QqoRZBLPf__z-6L4qkUXvolqwGKd1Th2-ZsAlyv-7iUGtIYal5b0GBHmcsAzxOBNed86qmItardjj0IyLseZtulJfAS4gIw9Fs9FJXmdlJU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:QqoRZNHC8GJo0aYnDlOcMduJ6FAQuWyYo7Oe53oc1Ephp62yLXpoiQ>
    <xmx:QqoRZFV9eoLNKE-7TTaQpKOOuZZa46XA4I_J9wi8EE39alZWVEylNQ>
    <xmx:QqoRZINXBFwpElzyaMqfKYQB6FyIUEZprTcU9pG5fvqwhZRu3tx2VQ>
    <xmx:QqoRZEBgWRsfv4o-oZEffslsXIA1sQI7A1sUhUf5GL4TOUa5E6fYPw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:38 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1109bc82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:21:15 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 8/8] fetch: centralize printing of reference updates
Message-ID: <966730171106703cc378351f16f8b47d3ecb5a2c.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EV4LXTDrmjnwx12V"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EV4LXTDrmjnwx12V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to print updated references during a fetch, the two different
call sites that do this will first call `format_display()` followed by a
call to `fputs()`. This is needlessly roundabout now that we have the
`display_state` structure that encapsulates all of the printing logic
for references.

Move displaying the reference updates into `format_display()` and rename
it to `display_ref_update()` to better match its new purpose. We have
now centralized the logic to print reference updates into a single
function, which enables us to more readily introduce new formats that
may even be printing to a different file descriptor than `stderr`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 105 ++++++++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 31724e9aaf..6e864f8457 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,6 +48,8 @@ enum {
 };
=20
 struct display_state {
+	struct strbuf buf;
+
 	int refcol_width;
 	int summary_width;
 	int compact_format;
@@ -788,6 +790,8 @@ static void display_state_init(struct display_state *di=
splay, struct ref *ref_ma
=20
 	memset(display, 0, sizeof(*display));
=20
+	strbuf_init(&display->buf, 0);
+
 	if (raw_url)
 		display->url =3D transport_anonymize_url(raw_url);
 	else
@@ -837,14 +841,14 @@ static void display_state_init(struct display_state *=
display, struct ref *ref_ma
=20
 static void display_state_release(struct display_state *display)
 {
+	strbuf_release(&display->buf);
 	free(display->url);
 }
=20
 static void print_remote_to_local(struct display_state *display,
-				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
 {
-	strbuf_addf(display_buffer, "%-*s -> %s", display->refcol_width, remote, =
local);
+	strbuf_addf(&display->buf, "%-*s -> %s", display->refcol_width, remote, l=
ocal);
 }
=20
 static int find_and_replace(struct strbuf *haystack,
@@ -874,14 +878,14 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct display_state *display, struct strbuf *di=
splay_buffer,
+static void print_compact(struct display_state *display,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
 	struct strbuf l =3D STRBUF_INIT;
=20
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display_buffer, "%-*s -> *", display->refcol_width, remote);
+		strbuf_addf(&display->buf, "%-*s -> *", display->refcol_width, remote);
 		return;
 	}
=20
@@ -890,44 +894,46 @@ static void print_compact(struct display_state *displ=
ay, struct strbuf *display_
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display, display_buffer, r.buf, l.buf);
+	print_remote_to_local(display, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct display_state *display,
-			   struct strbuf *display_buffer, char code,
-			   const char *summary, const char *error,
-			   const char *remote, const char *local)
+static void display_ref_update(struct display_state *display, char code,
+			       const char *summary, const char *error,
+			       const char *remote, const char *local)
 {
 	int width;
=20
 	if (verbosity < 0)
 		return;
=20
+	strbuf_reset(&display->buf);
+
 	if (!display->shown_url) {
-		strbuf_addf(display_buffer, _("From %.*s\n"), display->url_len, display-=
>url);
+		strbuf_addf(&display->buf, _("From %.*s\n"), display->url_len, display->=
url);
 		display->shown_url =3D 1;
 	}
=20
 	width =3D (display->summary_width + strlen(summary) - gettext_width(summa=
ry));
=20
-	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
+	strbuf_addf(&display->buf, " %c %-*s ", code, width, summary);
 	if (!display->compact_format)
-		print_remote_to_local(display, display_buffer, remote, prettify_refname(=
local));
+		print_remote_to_local(display, remote, prettify_refname(local));
 	else
-		print_compact(display, display_buffer, remote, prettify_refname(local));
+		print_compact(display, remote, prettify_refname(local));
 	if (error)
-		strbuf_addf(display_buffer, "  (%s)", error);
-	strbuf_addch(display_buffer, '\n');
+		strbuf_addf(&display->buf, "  (%s)", error);
+	strbuf_addch(&display->buf, '\n');
+
+	fputs(display->buf.buf, stderr);
 }
=20
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display,
-			    const char *remote, const struct ref *remote_ref,
-			    struct strbuf *display_buffer)
+			    const char *remote, const struct ref *remote_ref)
 {
 	struct commit *current =3D NULL, *updated;
 	int fast_forward =3D 0;
@@ -937,8 +943,8 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display, display_buffer, '=3D', _("[up to date]"), NULL,
-				       remote, ref->name);
+			display_ref_update(display, '=3D', _("[up to date]"), NULL,
+					   remote, ref->name);
 		return 0;
 	}
=20
@@ -949,9 +955,9 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display, display_buffer, '!', _("[rejected]"),
-			       _("can't fetch into checked-out branch"),
-			       remote, ref->name);
+		display_ref_update(display, '!', _("[rejected]"),
+				   _("can't fetch into checked-out branch"),
+				   remote, ref->name);
 		return 1;
 	}
=20
@@ -960,14 +966,14 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display, display_buffer, r ? '!' : 't', _("[tag update]"=
),
-				       r ? _("unable to update local ref") : NULL,
-				       remote, ref->name);
+			display_ref_update(display, r ? '!' : 't', _("[tag update]"),
+					   r ? _("unable to update local ref") : NULL,
+					   remote, ref->name);
 			return r;
 		} else {
-			format_display(display, display_buffer, '!', _("[rejected]"),
-				       _("would clobber existing tag"),
-				       remote, ref->name);
+			display_ref_update(display, '!', _("[rejected]"),
+					   _("would clobber existing tag"),
+					   remote, ref->name);
 			return 1;
 		}
 	}
@@ -998,9 +1004,9 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display, display_buffer, r ? '!' : '*', what,
-			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name);
+		display_ref_update(display, r ? '!' : '*', what,
+				   r ? _("unable to update local ref") : NULL,
+				   remote, ref->name);
 		return r;
 	}
=20
@@ -1020,9 +1026,9 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
-			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name);
+		display_ref_update(display, r ? '!' : ' ', quickref.buf,
+				   r ? _("unable to update local ref") : NULL,
+				   remote, ref->name);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1032,14 +1038,14 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
-			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, ref->name);
+		display_ref_update(display, r ? '!' : '+', quickref.buf,
+				   r ? _("unable to update local ref") : _("forced update"),
+				   remote, ref->name);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display, display_buffer, '!', _("[rejected]"), _("non-fas=
t-forward"),
-			       remote, ref->name);
+		display_ref_update(display, '!', _("[rejected]"), _("non-fast-forward"),
+				   remote, ref->name);
 		return 1;
 	}
 }
@@ -1261,10 +1267,8 @@ static int store_updated_refs(struct display_state *=
display,
 					  rm->fetch_head_status,
 					  note.buf, display->url, display->url_len);
=20
-			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, transaction, display, what,
-						       rm, &note);
+				rc |=3D update_local_ref(ref, transaction, display, what, rm);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1272,13 +1276,11 @@ static int store_updated_refs(struct display_state =
*display,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				format_display(display, &note, '*',
-					       *kind ? kind : "branch", NULL,
-					       *what ? what : "HEAD",
-					       "FETCH_HEAD");
+				display_ref_update(display, '*',
+						   *kind ? kind : "branch", NULL,
+						   *what ? what : "HEAD",
+						   "FETCH_HEAD");
 			}
-			if (note.len)
-				fputs(note.buf, stderr);
 		}
 	}
=20
@@ -1412,11 +1414,8 @@ static int prune_refs(struct display_state *display,
=20
 	if (verbosity >=3D 0) {
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
-			struct strbuf sb =3D STRBUF_INIT;
-			format_display(display, &sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), ref->name);
-			fputs(sb.buf, stderr);
-			strbuf_release(&sb);
+			display_ref_update(display, '-', _("[deleted]"), NULL,
+					   _("(none)"), ref->name);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
--=20
2.40.0


--EV4LXTDrmjnwx12V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqj8ACgkQVbJhu7ck
PpR+NBAAosEdbvF77NCGkY84PWHVaMRxy49+NdDesLrXIJPDYHxF/EQ40ZemMQp6
O9V8LQwB1BFFviRoir8RSw5FdjfvAhAFkA8e0oxkKt76O1x4q9dIrlxdighO1stA
Pj9zpHX0V4tltwdjk71txDyzFI4E8FvoMG2vP7dAOcBlfM0dFX+Aha60t8lQccJ1
/4McCBCl11j5peXf1rUPJ/yBXsn9tvPc+UpFbxLZYuM2Z3NPR10zcYGApdJI6pLF
M5oETqtfBDH6TJUjG2an3JOhRcFeUUuWc9XckszISuVyaqOa5GJoEg7u2HAEuqMo
CmDjieWxf28dOFDyKALJ8SJ1qHHE6oYwIj1EdL+fk9hXxM3fMh7oAC7OiPWYC1z/
jT7Iqbe9pjplbe8RhUONcw20BO04aRLw1JOFy6f+ioyy/mEp+f08IYNlCSW6tW8U
D+z325X9fNDZGcK2NyiQ+mJD5Hyxo9No+ZG2cy51otg7+h6UrEh4AwNr8bnS2VsS
JuBZSzFRO4YN6H0ckyOECPVlsNUzkYkZvPtdB+tmRLeOwfwUSrjOGpqPyPR7ykhQ
QBdZP864KjhGlnPvD1Jj/Xc+73wTNPJ69KTMGlcaX1NhsTtZXdntZkngEtjqHn1e
L4xQTV6eMGATlBLQOOvpVgFoyWWbHbu9pNXQoOieAR+XlZiIIA4=
=is8d
-----END PGP SIGNATURE-----

--EV4LXTDrmjnwx12V--
