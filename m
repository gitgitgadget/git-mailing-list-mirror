Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F8BC7618D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCTMf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTMf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3378FD517
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9F3E05C0131;
        Mon, 20 Mar 2023 08:35:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 20 Mar 2023 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315723; x=1679402123; bh=ze
        Pk+adjeNJUh6bIMny3H9G2s901LOOB0okWYhb+Sgc=; b=nedArSYE4+lb0GEE/T
        imvBNJXS4Rn3bQav9icQsLHFLdAW4O2dlrd0oqXerwX0fHQnOVEB7HUJ7sjao0zn
        557D3vvGj6QYk/PM1+JEFqtCJju4d2jIYelE5bptoau6hnokDYP+AUUH1orQhDCu
        pWf2LvNU6VuFovu1y3mv0YVBlaBr21h7SusmVLHTDdHsSL2bXoT+iAmnuoOhOE8A
        j7pC8ATsKiffaeZouweKybWJ0Zo/fYOP4+afpTzROd2OMZH9p+lKxDpGokNTgqil
        IAezfWD7j3pxMdSM2nYMM8DoE6dYlibWuxIGqqCsVNF3BOTs3wruWiObbE4e8Ddk
        GiYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315723; x=1679402123; bh=zePk+adjeNJUh
        6bIMny3H9G2s901LOOB0okWYhb+Sgc=; b=eySxhxeMLzQwQxZYxduHnd1O197mU
        PVzcWIaHcJAJLHcPgP9sRHDJsR4zw7kaKCigCWSoX1AcM2crny8dw5/K2aJApXGQ
        2/0Sk5kXYEKRYJSLvwfOV+jPpQd8Xzq/6gbN/WsOLleKRLth/YTsoQcj/+NGDXvT
        tEUmGUW0WzdvRqPI7Q7glz3iOBM54VFbyD4oOol2Mo3DGCwqhak8OMgjEf1tr+gp
        6l3DMXIW3G7h9o5Uv0gdGfnBDrxHwcNJxMorKWwzOmeYkYX3Tw7dza/iWJXlXPNK
        ZrE17pQC6gZh5I68Obt/GHZKKDHHoh26KT+pnADfZDD/SUgyYfNcxpVEA==
X-ME-Sender: <xms:C1MYZJ8Bmh2UrwjVJC28G6F2N0HSDDTDH6aOIAcQHgmYATklxQX3tA>
    <xme:C1MYZNumkaAWG5f7_QEoaW59HZphGXcffQ-cCKd5TALWWrdFVGlsN0LRx6Pwg3WkO
    k5i408hT_yP52rJRg>
X-ME-Received: <xmr:C1MYZHAlMe1rhUPTNUwYBXSCq5YF7NsmOhgzg7cxzuFplfH4j6YoSD4g0gDJooPYe15VqN9oLiKOOFfbogiY1vVJOPFnVEtKsq4cFh8liyUtDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:C1MYZNf8sg3A8dVBbeoLgf8l_A0b5EQgf0jOsXBoXIrTO8iCe3UOWQ>
    <xmx:C1MYZOOV1mitC_2wjRBhz5lACzDSkyMPUNYOxCQoyPpbAYVf7khV5g>
    <xmx:C1MYZPlfMvYFQU_g2e_WBmB-GEhEMv9JM2w7DHWWjGy9GZdzW-WUBQ>
    <xmx:C1MYZA0shh45_aMjgsrHxdKH1L1dJbUS6A-ttXVKuUiOenQh_xx7Ag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:22 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a45c5f95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:34:49 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:20 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 1/6] fetch: move reference width calculation into
 `display_state`
Message-ID: <ce2c4b61aee26461b4edb934ceccf57daa62b056.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="co2zgglAhv7kKVks"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--co2zgglAhv7kKVks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to print references in proper columns we need to calculate the
width of the reference column before starting to print the references.
This is done with the help of a global variable `refcol_width`.

Refactor the code to instead use a new structure `display_state` that
contains the computed width and plumb it through the stack as required.
This is only the first step towards de-globalizing the state required to
print references.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 111 ++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 46 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a09606b472..391959ad3d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -47,6 +47,10 @@ enum {
 	TAGS_SET =3D 2
 };
=20
+struct display_state {
+	int refcol_width;
+};
+
 static int fetch_prune_config =3D -1; /* unspecified */
 static int fetch_show_forced_updates =3D 1;
 static uint64_t forced_updates_ms =3D 0;
@@ -741,16 +745,15 @@ static int s_update_ref(const char *action,
 	return ret;
 }
=20
-static int refcol_width =3D 10;
 static int compact_format;
=20
-static void adjust_refcol_width(const struct ref *ref)
+static int refcol_width(const struct ref *ref)
 {
 	int max, rlen, llen, len;
=20
 	/* uptodate lines are only shown on high verbosity level */
 	if (verbosity <=3D 0 && oideq(&ref->peer_ref->old_oid, &ref->old_oid))
-		return;
+		return 0;
=20
 	max    =3D term_columns();
 	rlen   =3D utf8_strwidth(prettify_refname(ref->name));
@@ -769,22 +772,18 @@ static void adjust_refcol_width(const struct ref *ref)
 	}
 	len =3D 21 /* flag and summary */ + rlen + 4 /* -> */ + llen;
 	if (len >=3D max)
-		return;
+		return 0;
=20
-	/*
-	 * Not precise calculation for compact mode because '*' can
-	 * appear on the left hand side of '->' and shrink the column
-	 * back.
-	 */
-	if (refcol_width < rlen)
-		refcol_width =3D rlen;
+	return rlen;
 }
=20
-static void prepare_format_display(struct ref *ref_map)
+static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map)
 {
 	struct ref *rm;
 	const char *format =3D "full";
=20
+	memset(display_state, 0, sizeof(*display_state));
+
 	if (verbosity < 0)
 		return;
=20
@@ -797,20 +796,32 @@ static void prepare_format_display(struct ref *ref_ma=
p)
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
=20
+	display_state->refcol_width =3D 10;
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
+		int width;
+
 		if (rm->status =3D=3D REF_STATUS_REJECT_SHALLOW ||
 		    !rm->peer_ref ||
 		    !strcmp(rm->name, "HEAD"))
 			continue;
=20
-		adjust_refcol_width(rm);
+		width =3D refcol_width(rm);
+
+		/*
+		 * Not precise calculation for compact mode because '*' can
+		 * appear on the left hand side of '->' and shrink the column
+		 * back.
+		 */
+		if (display_state->refcol_width < width)
+			display_state->refcol_width =3D width;
 	}
 }
=20
-static void print_remote_to_local(struct strbuf *display,
+static void print_remote_to_local(struct display_state *display_state,
+				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
 {
-	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+	strbuf_addf(display_buffer, "%-*s -> %s", display_state->refcol_width, re=
mote, local);
 }
=20
 static int find_and_replace(struct strbuf *haystack,
@@ -840,14 +851,14 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct strbuf *display,
+static void print_compact(struct display_state *display_state, struct strb=
uf *display_buffer,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
 	struct strbuf l =3D STRBUF_INIT;
=20
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display, "%-*s -> *", refcol_width, remote);
+		strbuf_addf(display_buffer, "%-*s -> *", display_state->refcol_width, re=
mote);
 		return;
 	}
=20
@@ -856,13 +867,14 @@ static void print_compact(struct strbuf *display,
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display, r.buf, l.buf);
+	print_remote_to_local(display_state, display_buffer, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct strbuf *display, char code,
+static void format_display(struct display_state *display_state,
+			   struct strbuf *display_buffer, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local,
 			   int summary_width)
@@ -874,17 +886,18 @@ static void format_display(struct strbuf *display, ch=
ar code,
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
-	strbuf_addf(display, "%c %-*s ", code, width, summary);
+	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
 	if (!compact_format)
-		print_remote_to_local(display, remote, local);
+		print_remote_to_local(display_state, display_buffer, remote, local);
 	else
-		print_compact(display, remote, local);
+		print_compact(display_state, display_buffer, remote, local);
 	if (error)
-		strbuf_addf(display, "  (%s)", error);
+		strbuf_addf(display_buffer, "  (%s)", error);
 }
=20
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
+			    struct display_state *display_state,
 			    const char *remote, const struct ref *remote_ref,
 			    struct strbuf *display, int summary_width)
 {
@@ -897,7 +910,7 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display, '=3D', _("[up to date]"), NULL,
+			format_display(display_state, display, '=3D', _("[up to date]"), NULL,
 				       remote, pretty_ref, summary_width);
 		return 0;
 	}
@@ -909,7 +922,7 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display, '!', _("[rejected]"),
+		format_display(display_state, display, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
 			       remote, pretty_ref, summary_width);
 		return 1;
@@ -920,12 +933,13 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display, r ? '!' : 't', _("[tag update]"),
+			format_display(display_state, display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
 			return r;
 		} else {
-			format_display(display, '!', _("[rejected]"), _("would clobber existing=
 tag"),
+			format_display(display_state, display, '!', _("[rejected]"),
+				       _("would clobber existing tag"),
 				       remote, pretty_ref, summary_width);
 			return 1;
 		}
@@ -957,7 +971,7 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display, r ? '!' : '*', what,
+		format_display(display_state, display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		return r;
@@ -979,7 +993,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display, r ? '!' : ' ', quickref.buf,
+		format_display(display_state, display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
@@ -991,13 +1005,13 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display, r ? '!' : '+', quickref.buf,
+		format_display(display_state, display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
+		format_display(display_state, display, '!', _("[rejected]"), _("non-fast=
-forward"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
@@ -1108,7 +1122,8 @@ N_("it took %.2f seconds to check forced updates; you=
 can use\n"
    "'--no-show-forced-updates' or run 'git config fetch.showForcedUpdates =
false'\n"
    "to avoid this check\n");
=20
-static int store_updated_refs(const char *raw_url, const char *remote_name,
+static int store_updated_refs(struct display_state *display_state,
+			      const char *raw_url, const char *remote_name,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head)
@@ -1139,8 +1154,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 		}
 	}
=20
-	prepare_format_display(ref_map);
-
 	/*
 	 * We do a pass for each fetch_head_status type in their enum order, so
 	 * merged entries are written before not-for-merge. That lets readers
@@ -1240,7 +1253,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, transaction, what,
+				rc |=3D update_local_ref(ref, transaction, display_state, what,
 						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1249,7 +1262,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				format_display(&note, '*',
+				format_display(display_state, &note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
@@ -1328,7 +1341,8 @@ static int check_exist_and_connected(struct ref *ref_=
map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
=20
-static int fetch_and_consume_refs(struct transport *transport,
+static int fetch_and_consume_refs(struct display_state *display_state,
+				  struct transport *transport,
 				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head)
@@ -1352,7 +1366,7 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
 	}
=20
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret =3D store_updated_refs(transport->url, transport->remote->name,
+	ret =3D store_updated_refs(display_state, transport->url, transport->remo=
te->name,
 				 connectivity_checked, transaction, ref_map,
 				 fetch_head);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
@@ -1362,7 +1376,8 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
 	return ret;
 }
=20
-static int prune_refs(struct refspec *rs,
+static int prune_refs(struct display_state *display_state,
+		      struct refspec *rs,
 		      struct ref_transaction *transaction,
 		      struct ref *ref_map,
 		      const char *raw_url)
@@ -1416,7 +1431,7 @@ static int prune_refs(struct refspec *rs,
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url =3D 1;
 			}
-			format_display(&sb, '-', _("[deleted]"), NULL,
+			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), prettify_refname(ref->name),
 				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
@@ -1542,7 +1557,8 @@ static struct transport *prepare_transport(struct rem=
ote *remote, int deepen)
 	return transport;
 }
=20
-static int backfill_tags(struct transport *transport,
+static int backfill_tags(struct display_state *display_state,
+			 struct transport *transport,
 			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head)
@@ -1566,7 +1582,7 @@ static int backfill_tags(struct transport *transport,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	retcode =3D fetch_and_consume_refs(transport, transaction, ref_map, fetch=
_head);
+	retcode =3D fetch_and_consume_refs(display_state, transport, transaction,=
 ref_map, fetch_head);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1581,6 +1597,7 @@ static int do_fetch(struct transport *transport,
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
+	struct display_state display_state;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
 	const struct ref *remote_refs;
@@ -1662,6 +1679,8 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
+	display_state_init(&display_state, ref_map);
+
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
 		if (!transaction) {
@@ -1679,9 +1698,9 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode =3D prune_refs(rs, transaction, ref_map, transport->url);
+			retcode =3D prune_refs(&display_state, rs, transaction, ref_map, transp=
ort->url);
 		} else {
-			retcode =3D prune_refs(&transport->remote->fetch,
+			retcode =3D prune_refs(&display_state, &transport->remote->fetch,
 					     transaction, ref_map,
 					     transport->url);
 		}
@@ -1689,7 +1708,7 @@ static int do_fetch(struct transport *transport,
 			retcode =3D 1;
 	}
=20
-	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head))=
 {
+	if (fetch_and_consume_refs(&display_state, transport, transaction, ref_ma=
p, &fetch_head)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1711,7 +1730,7 @@ static int do_fetch(struct transport *transport,
 			 * when `--atomic` is passed: in that case we'll abort
 			 * the transaction and don't commit anything.
 			 */
-			if (backfill_tags(transport, transaction, tags_ref_map,
+			if (backfill_tags(&display_state, transport, transaction, tags_ref_map,
 					  &fetch_head))
 				retcode =3D 1;
 		}
--=20
2.40.0


--co2zgglAhv7kKVks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUwcACgkQVbJhu7ck
PpR1cg/+PCWxwOYzo1VTdczyDFpCZlWswaV6f/ZF1KNXKv0dt1v/iYB6MllXnmXM
9IYSwInwrU0v+7jVxX7bIO8TjnE6Vhom8BDNPZPK9BbmbDY/ZycnUmIvYaFeaEEY
qUWDREMzkNRXWTiheW3uitUY2KeHSmPerIC9rTnAkvwm+M5Rmun7crl+ruujrQLt
Sn5F7TPsCVCTt7vLoqPrFV6CC56zPKVYU3Zty+0IavCefl/P25cVdjVrCd70vot6
5XXWRlWprImzbLXnPHUUHbDGZI1FNZpP083Isyuzmz3Q6VHrjYfzadIfosQACKRK
1b72I+7c5RXTyI58jxt1OLPCfP52Z4EQ4qQvDDHkv5EEU8E5RIs5t3jSB4qufKyW
/ewJA+tqKq33TXESJNgr8b5z/1eLkESxd7/ooUvr1//iiirwaCQRnoqnRAysr2sq
0GnqhslQSKPJqh/l8bi/FOqga7NDfghXyrg9Con51vI58Tt+YkLoRpFHux34N88w
kK4cPsrmHwrpmDEHmW7gr4GeJSsU44dnt7LHA3fJLP2HUpziNpQD0cS4+JixuIHC
EIeZLh2SA1LhjSKUHQABVETt1wqg4gZyEwS8oGDY5QxWLOVKo09obnShK7hmYGa7
McKqUIKYd2S51IB33smwobOBg+wco8hDYO4glmP3ERftC42G6+k=
=6o3K
-----END PGP SIGNATURE-----

--co2zgglAhv7kKVks--
