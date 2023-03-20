Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49AFC6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 12:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjCTMf4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjCTMfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 08:35:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B4EC7E
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 05:35:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1B5B75C0131;
        Mon, 20 Mar 2023 08:35:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Mar 2023 08:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679315739; x=1679402139; bh=Xk
        vtuEbi8/79oCRjxPo+Uf9KGO+92MC1P1zYUnQeGLg=; b=dxpci67aOkgxyJldGa
        MZbm03utOgzEaNG85w3lgGRB1+ct6MFD7YsadfaNj9nnNkPxYF2Gf7yWL6KoqaV7
        RnX8Hx3djYCYtzSGdhNGJWoimoRdMnrK85FAeIHnHEIgMKoHzMC6azow3yVfBVHS
        6GNmdaStcGUzl1RGkvdy9+o13nKsL9u6Lq7yxAJMtRMWU/oVNxd4jPnGQTkYL5ia
        +o8+GXADzG37ByaCP3+WLAYDn5cHvKIK/w/UE6uGqj7ZTHDG06AUCpXz5ZVAinzp
        2rXxkodT59j9zIcOEO2otnpXU1GaX0Mjx/7xjBPs9ECG0vVqGXloV/q8i1RZTQgp
        SOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679315739; x=1679402139; bh=XkvtuEbi8/79o
        CRjxPo+Uf9KGO+92MC1P1zYUnQeGLg=; b=XfTKdrGX2RV+sdCuXrfAPfln2tkbh
        g1/M0Yr6PTz4MwXkwWesoY3+1LABE1x0Q71JPbacBndJRDVp1A4omz+AlDa+7OQR
        vv0fUE4eNyj953fBATKJxRYIMmGz2Zw7MsZk4u+Pzud9tGDmVsEZTTSLqLeW4V93
        +uJN3JDoc2vEHoeR+yd6iizy0mj3qt/BXGN1RgLvaJ4aXRCG3qhIDv+eMjs3KVaH
        vJaYEepj+ZVwBptD/STxOqZ3+iXQ/DzDB7y6uD/Oj4kHdwAImMFwRGzAbzMiXBOd
        bYpkc5AJQbYxg9dTXuhYt8vbqh2KmUGqxIyIZ06P02KUxK+t1Aptg2iUQ==
X-ME-Sender: <xms:GlMYZHC67buk_CTdL1EgUBj-aKkdaVKnfeY925O2J9NsXIOsXhNq-Q>
    <xme:GlMYZNgd7-A3jtHFrL6T5KF-Y77Yko72kGE4tKhy5Cjq74wn5qMxDMmWOSe0S52z8
    nBylLi4VovCA3o75Q>
X-ME-Received: <xmr:GlMYZCkdIGWCu1AyOAd6ytHJKhQttRY6BGQakr1fTpGHKhHVhHguGrxH1aYPAaxB8a4SFQhFIucfasS3idtyjHqgG8KmLOpAsnnIRUMU67NWNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:GlMYZJysjp10tKCM3fHcAI9KP5KyRaQPKbCShyxSMLaa21DdXQ6_Xw>
    <xmx:GlMYZMRq5-iA2Z3jKTYkAVc6LLOPLAJRtgFVcyYWnWjXvHcYc7LKFg>
    <xmx:GlMYZMYpC_o9ZZaOR1Ws3PDRLlp6NuRc8QxNG22I71-oikPgtif8JQ>
    <xmx:G1MYZHIvfN54pvojGZzYcjCXcBNdwZbx345yG_rv6CwprvhuUdE53A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 08:35:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a5b0691d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 20 Mar 2023 12:35:05 +0000 (UTC)
Date:   Mon, 20 Mar 2023 13:35:36 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH v2 5/6] fetch: centralize logic to print remote URL
Message-ID: <98b799af713b2ff22cc79531d5057fda64ddfb2a.1679315383.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
 <cover.1679315383.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+IDDPqnXtS68qkZj"
Content-Disposition: inline
In-Reply-To: <cover.1679315383.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+IDDPqnXtS68qkZj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching from a remote, we not only print the actual references
that have changed, but will also print the URL from which we have
fetched them to standard output. The logic to handle this is duplicated
across two different callsites with some non-trivial logic to compute
the anonymized URL. Furthermore, we're using global state to track
whether we have already shown the URL to the user or not.

Refactor the code by moving it into `format_display()`. Like this, we
can convert the global variable into a member of `display_state`. And
second, we can deduplicate the logic to compute the anonymized URL.

This also works as expected when fetching from multiple remotes, for
example via a group of remotes, as we do this by forking a standalone
git-fetch(1) process per remote that is to be fetched.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 99 ++++++++++++++++++++++---------------------------
 1 file changed, 44 insertions(+), 55 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a66428dfd8..1e3599cb74 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -50,6 +50,9 @@ enum {
 struct display_state {
 	int refcol_width;
 	int compact_format;
+
+	char *url;
+	int url_len, shown_url;
 };
=20
 static int fetch_prune_config =3D -1; /* unspecified */
@@ -84,7 +87,6 @@ static const char *submodule_prefix =3D "";
 static int recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_cli =3D RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default =3D RECURSE_SUBMODULES_ON_DEMAND;
-static int shown_url =3D 0;
 static struct refspec refmap =3D REFSPEC_INIT_FETCH;
 static struct list_objects_filter_options filter_options =3D LIST_OBJECTS_=
FILTER_INIT;
 static struct string_list server_options =3D STRING_LIST_INIT_DUP;
@@ -776,13 +778,27 @@ static int refcol_width(const struct ref *ref, int co=
mpact_format)
 	return rlen;
 }
=20
-static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map)
+static void display_state_init(struct display_state *display_state, struct=
 ref *ref_map,
+			       const char *raw_url)
 {
 	struct ref *rm;
 	const char *format =3D "full";
+	int i;
=20
 	memset(display_state, 0, sizeof(*display_state));
=20
+	if (raw_url)
+		display_state->url =3D transport_anonymize_url(raw_url);
+	else
+		display_state->url =3D xstrdup("foreign");
+
+	display_state->url_len =3D strlen(display_state->url);
+	for (i =3D display_state->url_len - 1; display_state->url[i] =3D=3D '/' &=
& 0 <=3D i; i--)
+		;
+	display_state->url_len =3D i + 1;
+	if (4 < i && !strncmp(".git", display_state->url + i - 3, 4))
+		display_state->url_len =3D i - 3;
+
 	if (verbosity < 0)
 		return;
=20
@@ -816,6 +832,11 @@ static void display_state_init(struct display_state *d=
isplay_state, struct ref *
 	}
 }
=20
+static void display_state_release(struct display_state *display_state)
+{
+	free(display_state->url);
+}
+
 static void print_remote_to_local(struct display_state *display_state,
 				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
@@ -883,6 +904,12 @@ static void format_display(struct display_state *displ=
ay_state,
 	if (verbosity < 0)
 		return;
=20
+	if (!display_state->shown_url) {
+		strbuf_addf(display_buffer, _("From %.*s\n"),
+			    display_state->url_len, display_state->url);
+		display_state->shown_url =3D 1;
+	}
+
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
@@ -1122,33 +1149,28 @@ N_("it took %.2f seconds to check forced updates; y=
ou can use\n"
    "to avoid this check\n");
=20
 static int store_updated_refs(struct display_state *display_state,
-			      const char *raw_url, const char *remote_name,
+			      const char *remote_name,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head)
 {
-	int url_len, i, rc =3D 0;
+	int rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
-	char *url;
 	int want_status;
 	int summary_width =3D 0;
=20
 	if (verbosity >=3D 0)
 		summary_width =3D transport_summary_width(ref_map);
=20
-	if (raw_url)
-		url =3D transport_anonymize_url(raw_url);
-	else
-		url =3D xstrdup("foreign");
-
 	if (!connectivity_checked) {
 		struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
=20
 		rm =3D ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
-			rc =3D error(_("%s did not send all necessary objects\n"), url);
+			rc =3D error(_("%s did not send all necessary objects\n"),
+				   display_state->url);
 			goto abort;
 		}
 	}
@@ -1232,13 +1254,6 @@ static int store_updated_refs(struct display_state *=
display_state,
 				what =3D rm->name;
 			}
=20
-			url_len =3D strlen(url);
-			for (i =3D url_len - 1; url[i] =3D=3D '/' && 0 <=3D i; i--)
-				;
-			url_len =3D i + 1;
-			if (4 < i && !strncmp(".git", url + i - 3, 4))
-				url_len =3D i - 3;
-
 			strbuf_reset(&note);
 			if (*what) {
 				if (*kind)
@@ -1248,7 +1263,8 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
=20
 			append_fetch_head(fetch_head, &rm->old_oid,
 					  rm->fetch_head_status,
-					  note.buf, url, url_len);
+					  note.buf, display_state->url,
+					  display_state->url_len);
=20
 			strbuf_reset(&note);
 			if (ref) {
@@ -1266,14 +1282,8 @@ static int store_updated_refs(struct display_state *=
display_state,
 					       *what ? what : "HEAD",
 					       "FETCH_HEAD", summary_width);
 			}
-			if (note.len) {
-				if (!shown_url) {
-					fprintf(stderr, _("From %.*s\n"),
-							url_len, url);
-					shown_url =3D 1;
-				}
+			if (note.len)
 				fputs(note.buf, stderr);
-			}
 		}
 	}
=20
@@ -1293,7 +1303,6 @@ static int store_updated_refs(struct display_state *d=
isplay_state,
=20
  abort:
 	strbuf_release(&note);
-	free(url);
 	return rc;
 }
=20
@@ -1365,7 +1374,7 @@ static int fetch_and_consume_refs(struct display_stat=
e *display_state,
 	}
=20
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret =3D store_updated_refs(display_state, transport->url, transport->remo=
te->name,
+	ret =3D store_updated_refs(display_state, transport->remote->name,
 				 connectivity_checked, transaction, ref_map,
 				 fetch_head);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
@@ -1378,30 +1387,15 @@ static int fetch_and_consume_refs(struct display_st=
ate *display_state,
 static int prune_refs(struct display_state *display_state,
 		      struct refspec *rs,
 		      struct ref_transaction *transaction,
-		      struct ref *ref_map,
-		      const char *raw_url)
+		      struct ref *ref_map)
 {
-	int url_len, i, result =3D 0;
+	int result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(rs, ref_map);
 	struct strbuf err =3D STRBUF_INIT;
-	char *url;
 	const char *dangling_msg =3D dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
=20
-	if (raw_url)
-		url =3D transport_anonymize_url(raw_url);
-	else
-		url =3D xstrdup("foreign");
-
-	url_len =3D strlen(url);
-	for (i =3D url_len - 1; url[i] =3D=3D '/' && 0 <=3D i; i--)
-		;
-
-	url_len =3D i + 1;
-	if (4 < i && !strncmp(".git", url + i - 3, 4))
-		url_len =3D i - 3;
-
 	if (!dry_run) {
 		if (transaction) {
 			for (ref =3D stale_refs; ref; ref =3D ref->next) {
@@ -1426,10 +1420,6 @@ static int prune_refs(struct display_state *display_=
state,
=20
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			struct strbuf sb =3D STRBUF_INIT;
-			if (!shown_url) {
-				fprintf(stderr, _("From %.*s\n"), url_len, url);
-				shown_url =3D 1;
-			}
 			format_display(display_state, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), ref->name,
 				       summary_width);
@@ -1441,7 +1431,6 @@ static int prune_refs(struct display_state *display_s=
tate,
=20
 cleanup:
 	strbuf_release(&err);
-	free(url);
 	free_refs(stale_refs);
 	return result;
 }
@@ -1596,7 +1585,7 @@ static int do_fetch(struct transport *transport,
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
-	struct display_state display_state;
+	struct display_state display_state =3D { 0 };
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
 	const struct ref *remote_refs;
@@ -1678,7 +1667,7 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
-	display_state_init(&display_state, ref_map);
+	display_state_init(&display_state, ref_map, transport->url);
=20
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
@@ -1697,11 +1686,10 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode =3D prune_refs(&display_state, rs, transaction, ref_map, transp=
ort->url);
+			retcode =3D prune_refs(&display_state, rs, transaction, ref_map);
 		} else {
 			retcode =3D prune_refs(&display_state, &transport->remote->fetch,
-					     transaction, ref_map,
-					     transport->url);
+					     transaction, ref_map);
 		}
 		if (retcode !=3D 0)
 			retcode =3D 1;
@@ -1812,6 +1800,7 @@ static int do_fetch(struct transport *transport,
 		error("%s", err.buf);
 	}
=20
+	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
 	free_refs(ref_map);
--=20
2.40.0


--+IDDPqnXtS68qkZj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQYUxcACgkQVbJhu7ck
PpSowhAAngE4YB5tVxxr/acc3+u1E3DBk3ywsAHLUzSVjC91Fu2mhKZJvzO8NeUm
2vQ0iyPjZJhxr0eS6l7MC27NQUttRphwCDSyfr187LEmLcIdAyBvH0ptzim5lm8J
bqT4mi+1n5IkPNqmfXcA2+sZsC9dSmMDtoDrE7cmWNcuHZHRkCyvSp7ZH8jtITL+
U2dmWyD1W5RP689xhsCNLjPobf6RO5wInmoJ7jYDv3OxCdHqfFjFGselVc48UyzZ
bqOTR19d+3oWNF3W9XWw8hDmbKmERFz/2SXMYQql/JWcq5WLYQGTjk6ptQmmW4UA
/7tAusWLKoJtWCl9deXER/iDPVXVDZGUK7N+cUoCehPKWAhz3g6FErisbAaxz1JI
dsJpP5hsI2Ki07DYd3rzezBOaIcuuPr+qiZOkviUSa/bW1TxFwCSRt2TRpzqGbvE
aQnzphzk1bzR5WLaTF0aUu37s92sa3TzNkfMq89WYR05UUmODTQ4TH++7O+b8ta5
1AgOztyCQ/2zUugVAqkLQQmzP2wiE52LnlpIJVJOpX7XBbaQivEuUleNaBsRcFsM
p7widez9oTE9We92grF3tnTKcoywAQj7GTx7ItUa43zOKRAZvJ93XGHajha3iBgC
NGeDslArCxdTk08wuj5CnYfExRxvpUlQBIPQoo2/ctVKEX8Hf04=
=Gpdg
-----END PGP SIGNATURE-----

--+IDDPqnXtS68qkZj--
