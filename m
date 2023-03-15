Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41B1C7618A
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCOLY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjCOLY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:24:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7D87B118
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:23:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E32C25C0186
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Mar 2023 07:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879291; x=1678965691; bh=XP
        vnAiaF3R4NYUpa7Ccck9twChDfyqLEWUbsRQo9Onk=; b=JH7CCqt2sff1PriRp0
        ytN9DZ3SEZBbBTkpi013ZKJlLdcnNc9NjMeS2d64BCWBJG0R6QfMGuUayTZlZYsx
        GnG/RuSTAC7tU3c9kwjtehmKnwhLa7ySWF+ZVjDzeye+o3Y2+Bhig4o7UOZ0DtVf
        NABwcu+hQP9H4ZFFpFPNmDk6Zxsr6ko+RlQaScJRqxN4Vtzl3s+kpf230bqxYT+k
        cTFHDE9MSSzlJbcJ1zLa7iZbnYh9492aYpHeIgNI2vz+EWVeIvaEPArMe0/VpVzZ
        WwDYa2JFcbjtJ9P2ogZhkf/k8aPzHO8hF+sicigkfS7wCQsf1nqEC4xaE7DIHYyL
        eHjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879291; x=1678965691; bh=XPvnAiaF3R4NY
        Upa7Ccck9twChDfyqLEWUbsRQo9Onk=; b=DvnfwKAKcqvaUyP6B+3raVnntMn+X
        kz0VbvNC+XqLDSb19P3ykJIj1quMazuL5whKqQPosqvDhHqldOlEu0rk8My5xaiH
        p7/gQQl4EbeADDB0A8K5TngLNkPOK8X2YXfvnGjzInYntEe3jgvlHCFhYG0iOD6f
        On/8ZvPb2g6xtR62lv1s5N4QPQSM+Kyy4anIbqeNi1Vl9ifrfmDUYWA28kGjCrgy
        aa1vi3lTARAAS+M/QM3oR1v7BvHWw/ReE0NNk3/l/rvBtZsAfPRN48S5jCfvLRwr
        TV5S3ntTFjUzy1Yhtnb8aHTOSE8XLEuGei9Y0TIT3uyKTt2ok5+oraHrQ==
X-ME-Sender: <xms:O6oRZKgxP2Gt1oB-SSs70rL7rwlxCbtardWOZpXTPkL1ODK24aYbAA>
    <xme:O6oRZLAwW-2t2f5Cqzzvlom0ea4Oogj5OHWz0jIIxjxd5FR0oMn7H1aIrZqGxzGhK
    1TlaUl8SV4DUGMYow>
X-ME-Received: <xmr:O6oRZCEzMnce2GfAHINtSJCizO-4-G2gUrwZY2jQvHcxgtLWuLC3yVZiu8USlg0BRo9Az0Op3HqQXTL0DW0OJg64Za-w6i5cu8tuRMRwF9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:O6oRZDTXnt9NXz4yxssirpCwQf2qN-pagWu_wkMVxLgmAhbJjhM2aA>
    <xmx:O6oRZHwdLqTNbR_IGwDt3XnWeS15HtXxEjc1lfEtImlPjx9Sphq9mw>
    <xmx:O6oRZB6SVo31vrejWJ_OsHCdSkDjOa7VlwnL2vvpyGXYzM9Ha8c9Dw>
    <xmx:O6oRZIvJMgV4WNeJw1RQB0b_xS8NvPOsymsdbrqe5B2VnFocg-egLw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id bc9f9d2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:21:08 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:28 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 6/8] fetch: deduplicate logic to print remote URL
Message-ID: <2ea3a4e308d2fb89f24d0cd2efc9d3867983a4b0.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ORZj1oPH6BsxhAnE"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ORZj1oPH6BsxhAnE
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

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 96 +++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 55 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6fc2fd0d46..4e18c3902d 100644
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
-static void display_state_init(struct display_state *display, struct ref *=
ref_map)
+static void display_state_init(struct display_state *display, struct ref *=
ref_map,
+			       const char *raw_url)
 {
 	struct ref *rm;
 	const char *format =3D "full";
+	int i;
=20
 	memset(display, 0, sizeof(*display));
=20
+	if (raw_url)
+		display->url =3D transport_anonymize_url(raw_url);
+	else
+		display->url =3D xstrdup("foreign");
+
+	display->url_len =3D strlen(display->url);
+	for (i =3D display->url_len - 1; display->url[i] =3D=3D '/' && 0 <=3D i; =
i--)
+		;
+	display->url_len =3D i + 1;
+	if (4 < i && !strncmp(".git", display->url + i - 3, 4))
+		display->url_len =3D i - 3;
+
 	if (verbosity < 0)
 		return;
=20
@@ -816,6 +832,11 @@ static void display_state_init(struct display_state *d=
isplay, struct ref *ref_ma
 	}
 }
=20
+static void display_state_release(struct display_state *display)
+{
+	free(display->url);
+}
+
 static void print_remote_to_local(struct display_state *display,
 				  struct strbuf *display_buffer,
 				  const char *remote, const char *local)
@@ -883,6 +904,11 @@ static void format_display(struct display_state *displ=
ay,
 	if (verbosity < 0)
 		return;
=20
+	if (!display->shown_url) {
+		strbuf_addf(display_buffer, _("From %.*s\n"), display->url_len, display-=
>url);
+		display->shown_url =3D 1;
+	}
+
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
 	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
@@ -1122,33 +1148,27 @@ N_("it took %.2f seconds to check forced updates; y=
ou can use\n"
    "to avoid this check\n");
=20
 static int store_updated_refs(struct display_state *display,
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
+			rc =3D error(_("%s did not send all necessary objects\n"), display->url=
);
 			goto abort;
 		}
 	}
@@ -1232,13 +1252,6 @@ static int store_updated_refs(struct display_state *=
display,
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
@@ -1248,7 +1261,7 @@ static int store_updated_refs(struct display_state *d=
isplay,
=20
 			append_fetch_head(fetch_head, &rm->old_oid,
 					  rm->fetch_head_status,
-					  note.buf, url, url_len);
+					  note.buf, display->url, display->url_len);
=20
 			strbuf_reset(&note);
 			if (ref) {
@@ -1266,14 +1279,8 @@ static int store_updated_refs(struct display_state *=
display,
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
@@ -1293,7 +1300,6 @@ static int store_updated_refs(struct display_state *d=
isplay,
=20
  abort:
 	strbuf_release(&note);
-	free(url);
 	return rc;
 }
=20
@@ -1365,7 +1371,7 @@ static int fetch_and_consume_refs(struct display_stat=
e *display,
 	}
=20
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret =3D store_updated_refs(display, transport->url, transport->remote->na=
me,
+	ret =3D store_updated_refs(display, transport->remote->name,
 				 connectivity_checked, transaction, ref_map,
 				 fetch_head);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
@@ -1378,30 +1384,15 @@ static int fetch_and_consume_refs(struct display_st=
ate *display,
 static int prune_refs(struct display_state *display,
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
@@ -1426,10 +1417,6 @@ static int prune_refs(struct display_state *display,
=20
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			struct strbuf sb =3D STRBUF_INIT;
-			if (!shown_url) {
-				fprintf(stderr, _("From %.*s\n"), url_len, url);
-				shown_url =3D 1;
-			}
 			format_display(display, &sb, '-', _("[deleted]"), NULL,
 				       _("(none)"), ref->name,
 				       summary_width);
@@ -1441,7 +1428,6 @@ static int prune_refs(struct display_state *display,
=20
 cleanup:
 	strbuf_release(&err);
-	free(url);
 	free_refs(stale_refs);
 	return result;
 }
@@ -1596,7 +1582,7 @@ static int do_fetch(struct transport *transport,
 {
 	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
-	struct display_state display;
+	struct display_state display =3D { 0 };
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
 	const struct ref *remote_refs;
@@ -1678,7 +1664,7 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
-	display_state_init(&display, ref_map);
+	display_state_init(&display, ref_map, transport->url);
=20
 	if (atomic_fetch) {
 		transaction =3D ref_transaction_begin(&err);
@@ -1697,11 +1683,10 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode =3D prune_refs(&display, rs, transaction, ref_map, transport->u=
rl);
+			retcode =3D prune_refs(&display, rs, transaction, ref_map);
 		} else {
 			retcode =3D prune_refs(&display, &transport->remote->fetch,
-					     transaction, ref_map,
-					     transport->url);
+					     transaction, ref_map);
 		}
 		if (retcode !=3D 0)
 			retcode =3D 1;
@@ -1812,6 +1797,7 @@ static int do_fetch(struct transport *transport,
 		error("%s", err.buf);
 	}
=20
+	display_state_release(&display);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
 	free_refs(ref_map);
--=20
2.40.0


--ORZj1oPH6BsxhAnE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqjcACgkQVbJhu7ck
PpTp/g/6AlPNqwWOdyZK6+pQa58lXVnOkOfBaOx8NtmjRXCbMRsWctiaYEw8y+7H
B9eBvKsfp2+EiYoUd9VmW+BfZ/InvYF9lR3xTzgiG2Ix0Ya7Pz/C0hHDSLzsavCX
GcxRC7cp5Gu3c7NHaTYgUATXg4Y4wp4N+0MBACdFpG7VmbEk/VrYGGb6OWcl+KfD
2Py2mXFjV9EPhhICnZNwy4ki8x8CR78zz6Kk2Q8RmcQOFNMC24C3f9QJxZ+e/SKR
7wDwlA7hOl2Mbr4+WmEvp9Orr2rA3mjNVwcdJREeeQmoa0JW60CODgihgdz3uxW7
3SU8tm6EZ/DC4yRSzCJnoE7grPItcRiOkQLRkhCVB6gn3MlkE2kfVTHAEUvNWhQt
+tkm0MPO/AE7IQiW4KtEKVMi/pBJ1gHAzciDQB8c6OUp45aufvUn2GtT2i4cPnKh
tiHxXBpv0gEJkMMm4xGip41wlL9XG46cyFLW9bPrMOUL1DQ8cMgiNUxvgqdztzdF
tHuVYdObsB22WbEGwHP8f8pKa7LTUTuwdQQsvEzOThyxlsgcKy1epTTz6P9c608g
bPwNDGUn8qS+aMqNg1aMNY8RZKGGa1SrcTyYmux6QtLWWOd+fagC34+sjPSt4+E2
CXmtQbY5/34JymZHMnAysPmnUIROIh52kZGwSxwQdRocZQ95p00=
=xaj5
-----END PGP SIGNATURE-----

--ORZj1oPH6BsxhAnE--
