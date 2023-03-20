Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E646C7618A
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjCTMgE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjCTMft (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B5628219
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6C0515C0131;
        Mon, 20 Mar 2023 08:35:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Mar 2023 08:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315743; x=1679402143; bh=GJ
        G8A1NozrmjANtZ3xGP4FDklDMDoebYbjSVqwexazM=; b=CMQWTc+IA7aodqCmB7
        2A5mkP2i3QZ3yhKJzqrYP5y/xERrI87s8P6tILaeqAF2eTmhuJSOacGoAMSG6tZi
        yYiJDzWJU4jQ7d0WvnMqsz3WKNGo/fJfxdmWHud1QB0h5qZMqL+vYcH4AHqkYBBo
        2m5xg7Ca6wgGdGUz07OXeSFjTYb5N9rqZpqIFhrIQK8vvk3gMTJTEU1+8h0BiHna
        ilHE4RSP54UtbKXigZhvs2G28yuvbWdUkSAk5nrujtcNdJ1DGX0DlZF5fHWODY+T
        69yFY7JIn79/vSkhJgBHnAM8fnxDSCAfXt1nVXHx/o8APZQevKr8s+tLlbNMmBFA
        LXsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315743; x=1679402143; bh=GJG8A1NozrmjA
        NtZ3xGP4FDklDMDoebYbjSVqwexazM=; b=hG6IC+fxMeg4X4R1L3g8mDpT2JO6F
        tCQV9+rYzLy5R/xMMt3FEsB8PbNMQw3m1GcohknnBMvhv10KKZLlZGxF8HhgVjYH
        modPzIBa/f28SMTH1pzssvDHCzsqSdtlhV6zhVP+x0dII+Aj7ShTp2P81Q+Z5caW
        NmBCKD+ZUHxPlXQEXOQnJFV+m9nzheMqv9QMd8iTxd4eM9ebUR46QmghgxO1wuAy
        yL/EPh7kP4VcDioflWgLPUa/Gu5CXCxIGQTklyPtnTJDpyRi3R0fYcGlysc/bnEF
        ewcdUElvbDRLRF2pz3oA/DmrjvGTtXOs7h3Ay0ptYqGlSIghy2IETIlSg==
X-ME-Sender: <xms:H1MYZLY6d15WK8WEZGX8JTVEto96FBCijeAwwcCST8cGelTI_XWVWQ>
    <xme:H1MYZKafQZN8SCGWPYOHzltGOAwLx1fz9kUby6gBTAoqZvKCYQWJtB4wogqxf52FL
    9DEuX3ioyPwtI48yA>
X-ME-Received: <xmr:H1MYZN91yMC9az5u5LyySUkoGwWro4RlcmJz_nM1qNqxlxuMBnW1tpVeQewKMFlooAI9rN050tDm4LwhHuZZ3prOq2rrLK0dkpS7OjudHmXMfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:H1MYZBr2t38mxRtkpnG4_nAfg_Isskla-DlBrEJprIgdgUDXwzlmkg>
    <xmx:H1MYZGrpqlDTOxEHa1M_haOmEN3XVZ7kIRmJ0M1wCpv-Slyb6PTu-g>
    <xmx:H1MYZHQ6GYFa4nOqvgEa6nfytMpB-S-EFOZbe9kdH-Zf02-K3AGtlA>
    <xmx:H1MYZLDqqYt3ZDqVgnuPtDacaEfMnSgq_QjR9YQ2heJ8KmqhuH7R8g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:42 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ab484e99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:35:09 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 6/6] fetch: centralize printing of reference updates
Message-ID: <fe7e2e85eb37cd4068b5160721663c21a16a8138.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EzbFRVa4u8UiwsaE"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EzbFRVa4u8UiwsaE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to print updated references during a fetch, the two different
call sites that do this will first call `format_display()` followed by a
call to `fputs()`. This is needlessly roundabout now that we have the
`display_state` structure that encapsulates all of the printing logic
for references.

Move displaying the reference updates into `format_display()` and rename
it to `display_ref_update()` to better match its new purpose, which
finalizes the conversion to make both the formatting and printing logic
of reference updates self-contained. This will make it easier to add new
output formats and printing to a different file descriptor than stderr.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 108 ++++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1e3599cb74..c202c18fb4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,6 +48,8 @@ enum {
 };
=20
 struct display_state {
+	struct strbuf buf;
+
 	int refcol_width;
 	int compact_format;
=20
@@ -787,6 +789,8 @@ static void display_state_init(struct display_state *di=
splay_state, struct ref *
=20
 	memset(display_state, 0, sizeof(*display_state));
=20
+	strbuf_init(&display_state->buf, 0);
+
 	if (raw_url)
 		display_state->url =3D transport_anonymize_url(raw_url);
 	else
@@ -834,14 +838,15 @@ static void display_state_init(struct display_state *=
display_state, struct ref *
=20
 static void display_state_release(struct display_state *display_state)
 {
+	strbuf_release(&display_state->buf);
 	free(display_state->url);
 }
=20
 static void print_remote_to_local(struct display_state *display_state,
-				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
 {
-	strbuf_addf(display_buffer, "%-*s -> %s", display_state->refcol_width, re=
mote, local);
+	strbuf_addf(&display_state->buf, "%-*s -> %s",
+		    display_state->refcol_width, remote, local);
 }
=20
 static int find_and_replace(struct strbuf *haystack,
@@ -871,14 +876,14 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct display_state *display_state, struct strb=
uf *display_buffer,
+static void print_compact(struct display_state *display_state,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
 	struct strbuf l =3D STRBUF_INIT;
=20
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display_buffer, "%-*s -> *", display_state->refcol_width, re=
mote);
+		strbuf_addf(&display_state->buf, "%-*s -> *", display_state->refcol_widt=
h, remote);
 		return;
 	}
=20
@@ -887,46 +892,49 @@ static void print_compact(struct display_state *displ=
ay_state, struct strbuf *di
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display_state, display_buffer, r.buf, l.buf);
+	print_remote_to_local(display_state, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct display_state *display_state,
-			   struct strbuf *display_buffer, char code,
-			   const char *summary, const char *error,
-			   const char *remote, const char *local,
-			   int summary_width)
+static void display_ref_update(struct display_state *display_state, char c=
ode,
+			       const char *summary, const char *error,
+			       const char *remote, const char *local,
+			       int summary_width)
 {
 	int width;
=20
 	if (verbosity < 0)
 		return;
=20
+	strbuf_reset(&display_state->buf);
+
 	if (!display_state->shown_url) {
-		strbuf_addf(display_buffer, _("From %.*s\n"),
+		strbuf_addf(&display_state->buf, _("From %.*s\n"),
 			    display_state->url_len, display_state->url);
 		display_state->shown_url =3D 1;
 	}
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
-	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
+	strbuf_addf(&display_state->buf, " %c %-*s ", code, width, summary);
 	if (!display_state->compact_format)
-		print_remote_to_local(display_state, display_buffer, remote, prettify_re=
fname(local));
+		print_remote_to_local(display_state, remote, prettify_refname(local));
 	else
-		print_compact(display_state, display_buffer, remote, prettify_refname(lo=
cal));
+		print_compact(display_state, remote, prettify_refname(local));
 	if (error)
-		strbuf_addf(display_buffer, "  (%s)", error);
-	strbuf_addch(display_buffer, '\n');
+		strbuf_addf(&display_state->buf, "  (%s)", error);
+	strbuf_addch(&display_state->buf, '\n');
+
+	fputs(display_state->buf.buf, stderr);
 }
=20
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display_state,
 			    const char *remote, const struct ref *remote_ref,
-			    struct strbuf *display, int summary_width)
+			    int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
 	int fast_forward =3D 0;
@@ -936,8 +944,8 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display_state, display, '=3D', _("[up to date]"), NULL,
-				       remote, ref->name, summary_width);
+			display_ref_update(display_state, '=3D', _("[up to date]"), NULL,
+					   remote, ref->name, summary_width);
 		return 0;
 	}
=20
@@ -948,9 +956,9 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display_state, display, '!', _("[rejected]"),
-			       _("can't fetch into checked-out branch"),
-			       remote, ref->name, summary_width);
+		display_ref_update(display_state, '!', _("[rejected]"),
+				   _("can't fetch into checked-out branch"),
+				   remote, ref->name, summary_width);
 		return 1;
 	}
=20
@@ -959,14 +967,14 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display_state, display, r ? '!' : 't', _("[tag update]"),
-				       r ? _("unable to update local ref") : NULL,
-				       remote, ref->name, summary_width);
+			display_ref_update(display_state, r ? '!' : 't', _("[tag update]"),
+					   r ? _("unable to update local ref") : NULL,
+					   remote, ref->name, summary_width);
 			return r;
 		} else {
-			format_display(display_state, display, '!', _("[rejected]"),
-				       _("would clobber existing tag"),
-				       remote, ref->name, summary_width);
+			display_ref_update(display_state, '!', _("[rejected]"),
+					   _("would clobber existing tag"),
+					   remote, ref->name, summary_width);
 			return 1;
 		}
 	}
@@ -997,9 +1005,9 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display_state, display, r ? '!' : '*', what,
-			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name, summary_width);
+		display_ref_update(display_state, r ? '!' : '*', what,
+				   r ? _("unable to update local ref") : NULL,
+				   remote, ref->name, summary_width);
 		return r;
 	}
=20
@@ -1019,9 +1027,9 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display_state, display, r ? '!' : ' ', quickref.buf,
-			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name, summary_width);
+		display_ref_update(display_state, r ? '!' : ' ', quickref.buf,
+				   r ? _("unable to update local ref") : NULL,
+				   remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1031,14 +1039,14 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display_state, display, r ? '!' : '+', quickref.buf,
-			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, ref->name, summary_width);
+		display_ref_update(display_state, r ? '!' : '+', quickref.buf,
+				   r ? _("unable to update local ref") : _("forced update"),
+				   remote, ref->name, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display_state, display, '!', _("[rejected]"), _("non-fast=
-forward"),
-			       remote, ref->name, summary_width);
+		display_ref_update(display_state, '!', _("[rejected]"), _("non-fast-forw=
ard"),
+				   remote, ref->name, summary_width);
 		return 1;
 	}
 }
@@ -1266,10 +1274,9 @@ static int store_updated_refs(struct display_state *=
display_state,
 					  note.buf, display_state->url,
 					  display_state->url_len);
=20
-			strbuf_reset(&note);
 			if (ref) {
 				rc |=3D update_local_ref(ref, transaction, display_state, what,
-						       rm, &note, summary_width);
+						       rm, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1277,13 +1284,11 @@ static int store_updated_refs(struct display_state =
*display_state,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				format_display(display_state, &note, '*',
-					       *kind ? kind : "branch", NULL,
-					       *what ? what : "HEAD",
-					       "FETCH_HEAD", summary_width);
+				display_ref_update(display_state, '*',
+						   *kind ? kind : "branch", NULL,
+						   *what ? what : "HEAD",
+						   "FETCH_HEAD", summary_width);
 			}
-			if (note.len)
-				fputs(note.buf, stderr);
 		}
 	}
=20
@@ -1419,12 +1424,9 @@ static int prune_refs(struct display_state *display_=
state,
 		int summary_width =3D transport_summary_width(stale_refs);
=20
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
-			struct strbuf sb =3D STRBUF_INIT;
-			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), ref->name,
-				       summary_width);
-			fputs(sb.buf, stderr);
-			strbuf_release(&sb);
+			display_ref_update(display_state, '-', _("[deleted]"), NULL,
+					   _("(none)"), ref->name,
+					   summary_width);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
 		}
 	}
--=20
2.40.0


--EzbFRVa4u8UiwsaE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUxsACgkQVbJhu7ck
PpT8fg/8C9sfxCMX0Dz+Whpx920VAYSYj+XCPUkvBKur4l/dEcIHWZtdIrBtumeV
YvVCVF2WyJG2TO3J0xCW5onK5xZUqvI7MN4iLeP78yutI0J/nLY1XBgRWevehAZp
rVOF6oeB+xCbHVtjVhXi8cnhhDNdPnnGcqU7V1Edu+ny8pDxrXoT/+PZGQEhothM
XPA9KKLJAhT5bfoe9bL5T1xT/epUd3hozv8lPXD8YOmGKXnSlP5n4AfUKM4Gu2Vo
f6DrJTXLCo9B3ZLuUSFCb3aYxq2lpmUTJe/lsaMHXBXLhA1DtBF/WctN66PlMCSS
hq0Gm/a5k+bZEbc6fcZxq1OsX+s/gvNpni0AiF4h3XOWpjBSN6ElfshpQxWn1xrE
pghQGX7uy134tjUlS7eYFF6fvnyE0V8nz4RLGuMSN9mA56+/+U3WRkuNBkIzSNVJ
9wwFB24S/vAa5q+n7jLtCOy90bxcS/bEXhz7OQMfN7QDyu/ziyjzNdmGav5tNmxE
Irp/ERQ80+GFBu3IR7dKo13W7CFyVuEQLEtzLqMgg0PYFCgb4e2KTdrr9J1IuXV8
03wyMRc87A7Dpm45hX+/NE3EeWI6yM0FGYBGfTbgdP4YILrvgPHTnPtHZjHKdsYT
63Sz3aeQ2SaJoEeWO90N3hbFF2gpv1sO6cTsTItuWALl0D4oc/o=
=x1QO
-----END PGP SIGNATURE-----

--EzbFRVa4u8UiwsaE--
