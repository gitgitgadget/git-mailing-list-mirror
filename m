Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E12C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjCOLXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCOLWg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:22:36 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047F8A3AB
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:21:26 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E71845C05D8
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 Mar 2023 07:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879269; x=1678965669; bh=J6
        JEfwfQlD1Sv2N84/WHoZeQK1SuJLNyWxKR7V2tuy8=; b=Ce9AWAcHCh6pFdQrtB
        NqgCmhazCiSc7g9vM0BDMDGM1ZggbrTBXPQQSDyZGZXUGgdQifHQGvskCzXO6ckh
        8S4w9e0LJK+kur1/j/RSpbgHGdrhwIr4UXePdEbR7Yn/F+OKyLnk1/gdS3uJ8/il
        /aEdfOfTG+o2p8eMD2rsuVZNFbKlKkMgmcZlyaTJsjs2FX7Mrr+RlGSHsMhSAjCV
        dgYW/wlU1Oc8sMNqplboSEtXmQJixyvIzcTUlfcbFHpPWISozRcpIHdi3jFrJlL2
        rDkRjfhwSnGYgxp+OaU2LXlIz4io2PDjf3eyudpsSvL98wVazMabuwYq3c5qi70q
        G+Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879269; x=1678965669; bh=J6JEfwfQlD1Sv
        2N84/WHoZeQK1SuJLNyWxKR7V2tuy8=; b=m3BIpj7YHklpqqx78lzuc/sWqtB4N
        4yFaiWrmLVGRb6ynOl5zhFl07g/IBPXTF/FxlRPDvBpuHPA7ayfQThVnOR7e/bd6
        K+tPYBAVJ8Fcsk1LloMaDvZiUvVoCrxaNIyvEMYIivI/mJdQ3oDBet41iAzlu4Y6
        YcD/XJc/L4YEPMBu8AeOM0WYk/Q3enluR6GflawsjwuoudUExnKKFFi9FvxdOJMI
        5KwKfdHAOb7Zb4/AEIt3tgzGp84Nmb71F8XiyqQX/rkgHduOCaI7Mve38PGj60xp
        6kMRDOD78Ylh2f5becgX5VldV0IGr7A1DYkwcOMPFeSMyqBwEnoysp7cg==
X-ME-Sender: <xms:JaoRZMtRA6kIoCuhtk8CABx_bx69BLa0xUDoDUf1DbymV6CwrCUD0Q>
    <xme:JaoRZJdRAKsnwarA-1F0rsTJHBTsWTKCF3k3flNmQBfxnlCC-CrYWbZKacJ9tHhYS
    7UGb2Tkdwupn8VZjw>
X-ME-Received: <xmr:JaoRZHy_BDk9VVc0nWfLlFJW2pCj1PDkWxRiLtzrleA35qIiM7fDWYVgTIssPD_deflbvUkVUIwT5r2WYgN_fxqgmuwU6jCJ5BJ0RR2z2bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JaoRZPNbQt5kgE50zQ39yFgt3t2puF5NuO6Y6Zg2djlBjTIeCgHo9w>
    <xmx:JaoRZM88JfuHI_vPtVSDNCOPeDY2kAg8FgnKqlPhLpptU9ByzRBhIA>
    <xmx:JaoRZHV6N3XO47DEZxzEmXEnnsg0oBWNvLG_CC_SlE9VvdYcfLkqIQ>
    <xmx:JaoRZFKATkGOYzbh5JPrJ-SnvtrSL36AtY25pfjBQe_OMl8avZ979g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:09 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 4ffd166a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:20:45 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:05 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/8] fetch: rename `display` buffer to avoid name conflict
Message-ID: <692206f7ff81132c47405a3120b0e0cb2d79ad90.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MXTe/bmRknUAwbcW"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MXTe/bmRknUAwbcW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rename the `display` buffer parameter we use to print reference updates
to standard error to `display_buffer`. This is done in order to avoid a
name conflict with the new `display_state` structure we're about to
introduce.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a09606b472..087e5cd6f4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -807,10 +807,10 @@ static void prepare_format_display(struct ref *ref_ma=
p)
 	}
 }
=20
-static void print_remote_to_local(struct strbuf *display,
+static void print_remote_to_local(struct strbuf *display_buffer,
 				  const char *remote, const char *local)
 {
-	strbuf_addf(display, "%-*s -> %s", refcol_width, remote, local);
+	strbuf_addf(display_buffer, "%-*s -> %s", refcol_width, remote, local);
 }
=20
 static int find_and_replace(struct strbuf *haystack,
@@ -840,14 +840,14 @@ static int find_and_replace(struct strbuf *haystack,
 	return 1;
 }
=20
-static void print_compact(struct strbuf *display,
+static void print_compact(struct strbuf *display_buffer,
 			  const char *remote, const char *local)
 {
 	struct strbuf r =3D STRBUF_INIT;
 	struct strbuf l =3D STRBUF_INIT;
=20
 	if (!strcmp(remote, local)) {
-		strbuf_addf(display, "%-*s -> *", refcol_width, remote);
+		strbuf_addf(display_buffer, "%-*s -> *", refcol_width, remote);
 		return;
 	}
=20
@@ -856,13 +856,13 @@ static void print_compact(struct strbuf *display,
=20
 	if (!find_and_replace(&r, local, "*"))
 		find_and_replace(&l, remote, "*");
-	print_remote_to_local(display, r.buf, l.buf);
+	print_remote_to_local(display_buffer, r.buf, l.buf);
=20
 	strbuf_release(&r);
 	strbuf_release(&l);
 }
=20
-static void format_display(struct strbuf *display, char code,
+static void format_display(struct strbuf *display_buffer, char code,
 			   const char *summary, const char *error,
 			   const char *remote, const char *local,
 			   int summary_width)
@@ -874,19 +874,19 @@ static void format_display(struct strbuf *display, ch=
ar code,
=20
 	width =3D (summary_width + strlen(summary) - gettext_width(summary));
=20
-	strbuf_addf(display, "%c %-*s ", code, width, summary);
+	strbuf_addf(display_buffer, "%c %-*s ", code, width, summary);
 	if (!compact_format)
-		print_remote_to_local(display, remote, local);
+		print_remote_to_local(display_buffer, remote, local);
 	else
-		print_compact(display, remote, local);
+		print_compact(display_buffer, remote, local);
 	if (error)
-		strbuf_addf(display, "  (%s)", error);
+		strbuf_addf(display_buffer, "  (%s)", error);
 }
=20
 static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    const char *remote, const struct ref *remote_ref,
-			    struct strbuf *display, int summary_width)
+			    struct strbuf *display_buffer, int summary_width)
 {
 	struct commit *current =3D NULL, *updated;
 	const char *pretty_ref =3D prettify_refname(ref->name);
@@ -897,7 +897,7 @@ static int update_local_ref(struct ref *ref,
=20
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
-			format_display(display, '=3D', _("[up to date]"), NULL,
+			format_display(display_buffer, '=3D', _("[up to date]"), NULL,
 				       remote, pretty_ref, summary_width);
 		return 0;
 	}
@@ -909,7 +909,7 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		format_display(display, '!', _("[rejected]"),
+		format_display(display_buffer, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
 			       remote, pretty_ref, summary_width);
 		return 1;
@@ -920,12 +920,12 @@ static int update_local_ref(struct ref *ref,
 		if (force || ref->force) {
 			int r;
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
-			format_display(display, r ? '!' : 't', _("[tag update]"),
+			format_display(display_buffer, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
 			return r;
 		} else {
-			format_display(display, '!', _("[rejected]"), _("would clobber existing=
 tag"),
+			format_display(display_buffer, '!', _("[rejected]"), _("would clobber e=
xisting tag"),
 				       remote, pretty_ref, summary_width);
 			return 1;
 		}
@@ -957,7 +957,7 @@ static int update_local_ref(struct ref *ref,
 		}
=20
 		r =3D s_update_ref(msg, ref, transaction, 0);
-		format_display(display, r ? '!' : '*', what,
+		format_display(display_buffer, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		return r;
@@ -979,7 +979,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
-		format_display(display, r ? '!' : ' ', quickref.buf,
+		format_display(display_buffer, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
@@ -991,13 +991,13 @@ static int update_local_ref(struct ref *ref,
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
-		format_display(display, r ? '!' : '+', quickref.buf,
+		format_display(display_buffer, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
 		strbuf_release(&quickref);
 		return r;
 	} else {
-		format_display(display, '!', _("[rejected]"), _("non-fast-forward"),
+		format_display(display_buffer, '!', _("[rejected]"), _("non-fast-forward=
"),
 			       remote, pretty_ref, summary_width);
 		return 1;
 	}
--=20
2.40.0


--MXTe/bmRknUAwbcW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqiAACgkQVbJhu7ck
PpQdsg//SkPDtAFOxrkPqGuhQNboi0U20hS2GwHPn/7VlMZrL31NTph2VysOjMS+
33uSfDwQe00ZqQj2tLNuFNo3mk5O4OkI8wm0x1fxbVgWghNjxp2gOk1og/3ckU1Z
LxPh6jRzyNSO9nMAzUhoH6WrWymqU1wgeLyQbZ61RCO/BAIwo9EFMr5AGt8PXi+H
cW3QTgUOGTilKz6Ufq5NdgYUMLmg4AxfEb+w834850iSpJzItPQSCcs56iDZvvQE
+BAqlInxGFLDNku2sEHUYmTnxwMG9V/iIgD2mAcQp99GUPdsw0XkHtY3IjMdRgxw
pGv1tFAd50DFtZ4rq29g5W3wZEdknchkGjHv6/WM2ayltxV1gXWl2jDxEMIKuhJU
vI3RdwIrDTeSUsm7uSBD6kIlyHcY+N+R11loDJ8XkYKlwsNwYE8npoGiGEoMA9Ia
3ZaGypeUZy5lkGJ9P30Mi2G3ir+kJ5fBqrD4GT44eDCimb9qPucRwuVcvqLdlr2r
R5BD720lSC+HdswJJUmM+ftHbyLKhNdQYcu+q3oeA1irVsOfpkfxLzEabX74ozKa
ViBRRKhwwtXhRdPFLONH3GuN2xnTJrHN32vnQSKOurzZKk56vKw3WKDqnKx0cR2c
/pFPesKv2OX8sxYlWRhYMWtufCYKwTdTUm/Z4czAPyLzUvx2b6U=
=cuIT
-----END PGP SIGNATURE-----

--MXTe/bmRknUAwbcW--
