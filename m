Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB04FC7618A
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCOLXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCOLWj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907841A96E
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:21:29 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AA6ED5C0224
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 07:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879276; x=1678965676; bh=nF
        XsECpUkoUCIfw7229JEsCv1aZDprreD+Zw95Gfd8c=; b=iMt9bdmNNQyfCJ9o1z
        dissj7pge+TW5UhD3rH0F01FfEnaoy9WEOBgBm3yn7FE27trAf/x19ZsFpu3nWgH
        qx0NeMjxHAK9/gIlaJWSgvTs1B9amKcPlzXWpNP0tU2nXC7KBXPKWH1OSQIdE84t
        nx2Wm9h4/39LeuZD907fhaDkY/QqFqGWBx6pxQmqIs1tMt5TNZ+qqC8nFr24ZaFe
        Vde4XzTsEtufAxCcc8qo3Hrkfkh3uSaPb3+Z9EcfnmQW6FO5+6fxIFplcTJ2UGaV
        KoMYGIyEdgYQEznUzU7D6E6aTE458bGL0KqvcHcYBMkfasOfTH3cDCEsDQaRePLQ
        gfKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879276; x=1678965676; bh=nFXsECpUkoUCI
        fw7229JEsCv1aZDprreD+Zw95Gfd8c=; b=OPxCjP/x/6UxQROco1QW4fSt9qeXa
        a1MOuedzQCBVDpjaIWeuJ4LTQTaH7tVbswaEsI6AJoYmb4X18ZdfGVlWhbejLFoD
        kf5Vdy4PZuzWNop1/l1PhY5Tl6kcIL2xCcG7omWA2yqoQ6PWw7ecfxgSIyH5udwn
        VF3HnD7AMjzPDipnXX6clvtrw7JK9ow7AVVZzZ7lJhLK8iQ1IxlagBw+sbLuMS6N
        qCSmzR9NO9Qc+nWA0679erqki0dMs/aPYDTAWhH/GopkrwBQ8/TycKStHyksrHA7
        JvN5oMBjYI3cTNdFBYkhVBLr/Y61vA3vPY3SfWYpBHm5Dpv5KiVP1as3w==
X-ME-Sender: <xms:LKoRZP9Al1RHZtseeh9mRH_mAD0MP708Jkgp2uFz8rqEYwBJ7ubY4g>
    <xme:LKoRZLvi1T3u_NA0BwUzMAOHcu08oJUyu-vKFfig85pwgyKyXnsGluQWrL__ZyHRK
    3L30MBhOxdn9ukyag>
X-ME-Received: <xmr:LKoRZNDjiaP7Ous2PYAVwUxvf4Q8PwdlQ1UFhtHk8JD5O3DsxtYj4s1IkPRJhUqTR9jrMmqK3Wockx2EUlTa31cV2tXPwYhbv7g9V0IzkDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LKoRZLdLBi0j9Sw6C17b2WuZutmohuMoyAjaG0db57SDLQMzOZkAwQ>
    <xmx:LKoRZENrrI74o6HQ-CUuZ8Dn3Qf80uhtFDNnWpTZdgfhjOxKqRgVjw>
    <xmx:LKoRZNl5ciTPNSw7RvtOF8rmAUaCR0s3cDnskFkrMUnKQBganaGPIw>
    <xmx:LKoRZPaRLyqYvwFBf5WeLLQWog-YxnyiE0qC7Ct7lHZ4jxt3xVWCJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:15 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5d0ea463 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:20:49 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/8] fetch: move reference width calculation into
 `display_state`
Message-ID: <aa792b12a468263d05e8615d4b3691ed8fe823ff.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1w8HgoJB9TXOj2qG"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1w8HgoJB9TXOj2qG
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
 builtin/fetch.c | 107 ++++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 44 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 087e5cd6f4..3695299177 100644
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
+static void display_state_init(struct display_state *display, struct ref *=
ref_map)
 {
 	struct ref *rm;
 	const char *format =3D "full";
=20
+	memset(display, 0, sizeof(*display));
+
 	if (verbosity < 0)
 		return;
=20
@@ -797,20 +796,32 @@ static void prepare_format_display(struct ref *ref_ma=
p)
 		die(_("invalid value for '%s': '%s'"),
 		    "fetch.output", format);
=20
+	display->refcol_width =3D 10;
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
+		if (display->refcol_width < width)
+			display->refcol_width =3D width;
 	}
 }
=20
-static void print_remote_to_local(struct strbuf *display_buffer,
+static void print_remote_to_local(struct display_state *display,
+				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
 {
-	strbuf_addf(display_buffer, "%-*s -> %s", refcol_width, remote, local);
+	strbuf_addf(display_buffer, "%-*s -> %s", display->refcol_width, remote, =
local);
 }
=20
 static int find_and_replace(struct strbuf *haystack,
@@ -840,14 +851,14 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct strbuf *display_buffer,
+static void print_compact(struct display_state *display, struct strbuf *di=
splay_buffer,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
 	struct strbuf l =3D STRBUF_INIT;
=20
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display_buffer, "%-*s -> *", refcol_width, remote);
+		strbuf_addf(display_buffer, "%-*s -> *", display->refcol_width, remote);
 		return;
 	}
=20
@@ -856,13 +867,14 @@ static void print_compact(struct strbuf *display_buff=
er,
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display_buffer, r.buf, l.buf);
+	print_remote_to_local(display, display_buffer, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct strbuf *display_buffer, char code,
+static void format_display(struct display_state *display,
+			   struct strbuf *display_buffer, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local,
 			   int summary_width)
@@ -876,15 +888,16 @@ static void format_display(struct strbuf *display_buf=
fer, char code,
=20
 	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
 	if (!compact_format)
-		print_remote_to_local(display_buffer, remote, local);
+		print_remote_to_local(display, display_buffer, remote, local);
 	else
-		print_compact(display_buffer, remote, local);
+		print_compact(display, display_buffer, remote, local);
 	if (error)
 		strbuf_addf(display_buffer, "  (%s)", error);
 }
=20
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
+			    struct display_state *display,
 			    const char *remote, const struct ref *remote_ref,
 			    struct strbuf *display_buffer, int summary_width)
 {
@@ -897,7 +910,7 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display_buffer, '=3D', _("[up to date]"), NULL,
+			format_display(display, display_buffer, '=3D', _("[up to date]"), NULL,
 				       remote, pretty_ref, summary_width);
 		return 0;
 	}
@@ -909,7 +922,7 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display_buffer, '!', _("[rejected]"),
+		format_display(display, display_buffer, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
 			       remote, pretty_ref, summary_width);
 		return 1;
@@ -920,12 +933,13 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display_buffer, r ? '!' : 't', _("[tag update]"),
+			format_display(display, display_buffer, r ? '!' : 't', _("[tag update]"=
),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
 			return r;
 		} else {
-			format_display(display_buffer, '!', _("[rejected]"), _("would clobber e=
xisting tag"),
+			format_display(display, display_buffer, '!', _("[rejected]"),
+				       _("would clobber existing tag"),
 				       remote, pretty_ref, summary_width);
 			return 1;
 		}
@@ -957,7 +971,7 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display_buffer, r ? '!' : '*', what,
+		format_display(display, display_buffer, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		return r;
@@ -979,7 +993,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display_buffer, r ? '!' : ' ', quickref.buf,
+		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
@@ -991,13 +1005,13 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display_buffer, r ? '!' : '+', quickref.buf,
+		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display_buffer, '!', _("[rejected]"), _("non-fast-forward=
"),
+		format_display(display, display_buffer, '!', _("[rejected]"), _("non-fas=
t-forward"),
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
+static int store_updated_refs(struct display_state *display,
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
+				rc |=3D update_local_ref(ref, transaction, display, what,
 						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
@@ -1249,7 +1262,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 				 * would be written to FETCH_HEAD, if --dry-run
 				 * is set).
 				 */
-				format_display(&note, '*',
+				format_display(display, &note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
@@ -1328,7 +1341,8 @@ static int check_exist_and_connected(struct ref *ref_=
map)
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
=20
-static int fetch_and_consume_refs(struct transport *transport,
+static int fetch_and_consume_refs(struct display_state *display,
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
+	ret =3D store_updated_refs(display, transport->url, transport->remote->na=
me,
 				 connectivity_checked, transaction, ref_map,
 				 fetch_head);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
@@ -1362,7 +1376,8 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
 	return ret;
 }
=20
-static int prune_refs(struct refspec *rs,
+static int prune_refs(struct display_state *display,
+		      struct refspec *rs,
 		      struct ref_transaction *transaction,
 		      struct ref *ref_map,
 		      const char *raw_url)
@@ -1416,7 +1431,7 @@ static int prune_refs(struct refspec *rs,
 				fprintf(stderr, _("From %.*s\n"), url_len, url);
 				shown_url =3D 1;
 			}
-			format_display(&sb, '-', _("[deleted]"), NULL,
+			format_display(display, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), prettify_refname(ref->name),
 				       summary_width);
 			fprintf(stderr, " %s\n",sb.buf);
@@ -1542,7 +1557,8 @@ static struct transport *prepare_transport(struct rem=
ote *remote, int deepen)
 	return transport;
 }
=20
-static int backfill_tags(struct transport *transport,
+static int backfill_tags(struct display_state *display,
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
+	retcode =3D fetch_and_consume_refs(display, transport, transaction, ref_m=
ap, fetch_head);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1581,6 +1597,7 @@ static int do_fetch(struct transport *transport,
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
+	struct display_state display;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
 	const struct ref *remote_refs;
@@ -1662,6 +1679,8 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
+	display_state_init(&display, ref_map);
+
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
 		if (!transaction) {
@@ -1679,9 +1698,9 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode =3D prune_refs(rs, transaction, ref_map, transport->url);
+			retcode =3D prune_refs(&display, rs, transaction, ref_map, transport->u=
rl);
 		} else {
-			retcode =3D prune_refs(&transport->remote->fetch,
+			retcode =3D prune_refs(&display, &transport->remote->fetch,
 					     transaction, ref_map,
 					     transport->url);
 		}
@@ -1689,7 +1708,7 @@ static int do_fetch(struct transport *transport,
 			retcode =3D 1;
 	}
=20
-	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head))=
 {
+	if (fetch_and_consume_refs(&display, transport, transaction, ref_map, &fe=
tch_head)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1711,7 +1730,7 @@ static int do_fetch(struct transport *transport,
 			 * when `--atomic` is passed: in that case we'll abort
 			 * the transaction and don't commit anything.
 			 */
-			if (backfill_tags(transport, transaction, tags_ref_map,
+			if (backfill_tags(&display, transport, transaction, tags_ref_map,
 					  &fetch_head))
 				retcode =3D 1;
 		}
--=20
2.40.0


--1w8HgoJB9TXOj2qG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqiUACgkQVbJhu7ck
PpRsHg//QY64HdNRIrpHT0NSQBwqGnHM2elsbBTijDIqwKlYQldnndJVSyy1rNYI
YGp417qe37kkQsL/l8cdICdAc05ulXBZKLijfHYtaIUAgdQ0FGotzrIouNZoFHaw
oDsaDt0xkRABoRtENtGzx0m3xPpPO1E3aj7RuUD+tcsxI7/mClp/R5RK8MveQvSH
KVvDhGsh23GiUU61nIDUZHJS5Hy0v8phEwfJM7bQ7wNFQTo2Iw3uF6T5VIXnHNvW
JRnoJRmSC29VcGvvf49jz2QS1PY09GOyFmn2e83zFtKl/gNAShrWzNG+LbvulOZ/
ysM1j8bcjdjZiZBJTNcqkZzpsaVHr15V7M3o0Qs9VfLGAhZHoQxwuVQCx4ASVCQz
paQGrd7AkT9JQheqCzEEWR2io33XmH3yrsH+C46nYnZdr7eF1qFSjgVDcsTYt+AH
tOP6rfhf1cPNSCPh7Hm5xYWdprRZK9djkji/szY98QM6Fz39X2lowQfVO8I3BzcZ
zoA6E1TEoNr/sqkn5O6ClKupGf0VHezXeNL9iPcAL5AekMK8OcR63H75kSxzI4hd
mLLrn/7yiOq+TZdo8M2IJ5UM0dDfAC4HjoM6oRP5vkbI/OVo6cOg/xjPomE3wKOG
daejGkCESCBAy1oN8N85swLBZAn21Z1mN5xLv3vYLiFibNdm6OI=
=38gr
-----END PGP SIGNATURE-----

--1w8HgoJB9TXOj2qG--
