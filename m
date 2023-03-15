Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5492FC6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCOLYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 07:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjCOLY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 07:24:26 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B21977CA8
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 04:23:33 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F2A235C004F
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Mar 2023 07:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1678879294; x=1678965694; bh=rs
        LgD4lQYu50TfljoI/aQ8tClDDKUb6XUbV8s72yzpM=; b=hXIIFm3tXm/UQpvq2a
        2Ul6h9etuSLoVy30Kw+2VA0bcCcNBDrPixEFJ7B+I0KBq6tmKkY0DeKrIC9j+FE4
        Mu9GqSyv98KIjjBLZlmEa552c6RucC4np8U4DruaT1JVfbWCBsuneibitbGjROFo
        s3mE9f0nIl7m+xRTFf+YUoGbZHMgl9gYwstaLOgt88YBeY0G2VOToe9KJpJ4/lXx
        uYBT9qKxEZDzjJV3fptrWadsJHM2VOyxsCZ55JATZJubDOWjxH2DrwiY6uJO/iJL
        3LgsrVONCJn0tfTlBFLIkuthL82AUH5b/Xgp41W+ldiKWn6Mbx6aiXoUQNHbKlc1
        xTgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678879294; x=1678965694; bh=rsLgD4lQYu50T
        fljoI/aQ8tClDDKUb6XUbV8s72yzpM=; b=HwpqcoxTp9Nvjoq9/PuhM6qwXc7BC
        +CNxjIZ6cjzhDnPKS9CJU6SdRAz2uaXBUL7nekwSAZYPH4x9GvetoI11YeNnUAqq
        DFg0JlaWDr1FsZ159drZ6rmcqBx9Jnhjk9hT7PVhj4d16p421SHWJ2xwQRE3HtUG
        QOGP8m8UptUnSlJiz0YPzzWwxWfympj9Gq/BGQ8lYOk0nY7f8jJQLskOuYqmfVfp
        pXE41M7gBOg8YEaOTWbTHVbgsQ1PPEv5zm8lwzDHTIT5RFn3ztZZ+gAzaEq1OyVv
        tGCaG/qbzFvEglnt3D9zP9ZqrquJSzMlmLyJuyfhX2Q4aIjVfmt/3L5DA==
X-ME-Sender: <xms:PqoRZKNqV7UvG0Ge9VwoIw5uZ19buTBs6AWfyVN0INgnzY9eUaxyqA>
    <xme:PqoRZI_1QLDcbAqBRju5SRRxJfbqUoonS3yXJHKGtVqsr23eoYIgZBgVg_-6wLdQy
    BUBeeuyKxaNQOWI1Q>
X-ME-Received: <xmr:PqoRZBRge8EaAtME_uBhIgIFI3iANwZMmPHf9lHRqLkIiN53J5zLG-p28FbRtf4SWEAEcvDz9vyy0h6-BPWZcBDWko4A1jqjHhOJKgRwHHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:PqoRZKtMLWncxwv-PY8fb4a2UnCu5895STiW85-lfNR2L9o35qf41g>
    <xmx:PqoRZCcLE686yxmORyrXvZHi6RxF0hT9ZFT11BsqMt9FA61Js-2hAw>
    <xmx:PqoRZO1l-0ELtUN9y2eu9tWQMTEqnyDj925iwu_jX5RON1xF36aTZw>
    <xmx:PqoRZEqrUs-q3677CPyZTGqeoHLVnWRy22aHeMHGKBU5TcMKtLpKqQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 15 Mar 2023 07:21:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 5062565a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 15 Mar 2023 11:21:11 +0000 (UTC)
Date:   Wed, 15 Mar 2023 12:21:32 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 7/8] fetch: fix inconsistent summary width for pruned and
 updated refs
Message-ID: <f67f9640a853b605dd1bc4be25e9988c4f059684.1678878623.git.ps@pks.im>
References: <cover.1678878623.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54pWlrA4MA90OHJd"
Content-Disposition: inline
In-Reply-To: <cover.1678878623.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--54pWlrA4MA90OHJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When printing references that are updated during a fetch, we also print
a short summary of what is happening. This summary may either be a word
like "[up to date]" or "[rejected]", or the abbreviated old and new hash
on a reference update.

As the abbreviated hashes may have different lengths in order to be
unique we thus need to precompute the width of the summary's column by
iterating through all the objects. This is done in two locations: once
to compute the width for references that are to be pruned, and once for
all the other references. Consequentially, it can happen that the width
as calculated for these sets of references is different.

This isn't really a huge issue, but it is a bit confusing when reading
through the code. Furthermore, the current way of passing through the
summary width is rather verbose.

Refactor the code to compute the summary width once when initializing
the display state. Like this, the width will be the same and we have to
pass less variables around.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4e18c3902d..31724e9aaf 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -49,6 +49,7 @@ enum {
=20
 struct display_state {
 	int refcol_width;
+	int summary_width;
 	int compact_format;
=20
 	char *url;
@@ -830,6 +831,8 @@ static void display_state_init(struct display_state *di=
splay, struct ref *ref_ma
 		if (display->refcol_width < width)
 			display->refcol_width =3D width;
 	}
+
+	display->summary_width =3D transport_summary_width(ref_map);
 }
=20
 static void display_state_release(struct display_state *display)
@@ -896,8 +899,7 @@ static void print_compact(struct display_state *display=
, struct strbuf *display_
 static void format_display(struct display_state *display,
 			   struct strbuf *display_buffer, char code,
 			   const char *summary, const char *error,
-			   const char *remote, const char *local,
-			   int summary_width)
+			   const char *remote, const char *local)
 {
 	int width;
=20
@@ -909,7 +911,7 @@ static void format_display(struct display_state *displa=
y,
 		display->shown_url =3D 1;
 	}
=20
-	width =3D (summary_width + strlen(summary) - gettext_width(summary));
+	width =3D (display->summary_width + strlen(summary) - gettext_width(summa=
ry));
=20
 	strbuf_addf(display_buffer, " %c %-*s ", code, width, summary);
 	if (!display->compact_format)
@@ -925,7 +927,7 @@ static int update_local_ref(struct ref *ref,
 			    struct ref_transaction *transaction,
 			    struct display_state *display,
 			    const char *remote, const struct ref *remote_ref,
-			    struct strbuf *display_buffer, int summary_width)
+			    struct strbuf *display_buffer)
 {
 	struct commit *current =3D NULL, *updated;
 	int fast_forward =3D 0;
@@ -936,7 +938,7 @@ static int update_local_ref(struct ref *ref,
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
 		if (verbosity > 0)
 			format_display(display, display_buffer, '=3D', _("[up to date]"), NULL,
-				       remote, ref->name, summary_width);
+				       remote, ref->name);
 		return 0;
 	}
=20
@@ -949,7 +951,7 @@ static int update_local_ref(struct ref *ref,
 		 */
 		format_display(display, display_buffer, '!', _("[rejected]"),
 			       _("can't fetch into checked-out branch"),
-			       remote, ref->name, summary_width);
+			       remote, ref->name);
 		return 1;
 	}
=20
@@ -960,12 +962,12 @@ static int update_local_ref(struct ref *ref,
 			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, display_buffer, r ? '!' : 't', _("[tag update]"=
),
 				       r ? _("unable to update local ref") : NULL,
-				       remote, ref->name, summary_width);
+				       remote, ref->name);
 			return r;
 		} else {
 			format_display(display, display_buffer, '!', _("[rejected]"),
 				       _("would clobber existing tag"),
-				       remote, ref->name, summary_width);
+				       remote, ref->name);
 			return 1;
 		}
 	}
@@ -998,7 +1000,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, display_buffer, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name, summary_width);
+			       remote, ref->name);
 		return r;
 	}
=20
@@ -1020,7 +1022,7 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, display_buffer, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
-			       remote, ref->name, summary_width);
+			       remote, ref->name);
 		strbuf_release(&quickref);
 		return r;
 	} else if (force || ref->force) {
@@ -1032,12 +1034,12 @@ static int update_local_ref(struct ref *ref,
 		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, display_buffer, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
-			       remote, ref->name, summary_width);
+			       remote, ref->name);
 		strbuf_release(&quickref);
 		return r;
 	} else {
 		format_display(display, display_buffer, '!', _("[rejected]"), _("non-fas=
t-forward"),
-			       remote, ref->name, summary_width);
+			       remote, ref->name);
 		return 1;
 	}
 }
@@ -1158,10 +1160,6 @@ static int store_updated_refs(struct display_state *=
display,
 	const char *what, *kind;
 	struct ref *rm;
 	int want_status;
-	int summary_width =3D 0;
-
-	if (verbosity >=3D 0)
-		summary_width =3D transport_summary_width(ref_map);
=20
 	if (!connectivity_checked) {
 		struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
@@ -1266,7 +1264,7 @@ static int store_updated_refs(struct display_state *d=
isplay,
 			strbuf_reset(&note);
 			if (ref) {
 				rc |=3D update_local_ref(ref, transaction, display, what,
-						       rm, &note, summary_width);
+						       rm, &note);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
@@ -1277,7 +1275,7 @@ static int store_updated_refs(struct display_state *d=
isplay,
 				format_display(display, &note, '*',
 					       *kind ? kind : "branch", NULL,
 					       *what ? what : "HEAD",
-					       "FETCH_HEAD", summary_width);
+					       "FETCH_HEAD");
 			}
 			if (note.len)
 				fputs(note.buf, stderr);
@@ -1413,13 +1411,10 @@ static int prune_refs(struct display_state *display,
 	}
=20
 	if (verbosity >=3D 0) {
-		int summary_width =3D transport_summary_width(stale_refs);
-
 		for (ref =3D stale_refs; ref; ref =3D ref->next) {
 			struct strbuf sb =3D STRBUF_INIT;
 			format_display(display, &sb, '-', _("[deleted]"), NULL,
-				       _("(none)"), ref->name,
-				       summary_width);
+				       _("(none)"), ref->name);
 			fputs(sb.buf, stderr);
 			strbuf_release(&sb);
 			warn_dangling_symref(stderr, dangling_msg, ref->name);
--=20
2.40.0


--54pWlrA4MA90OHJd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQRqjsACgkQVbJhu7ck
PpT3nA//YHIioWaV20z6cnqDP9sygO45bU9dIPH0vWN3p4ccNkbmGdWfu9DXE0qf
v6pps36vrDdbIKyLj4IPcefDQeD7HbhdVxqoGXW/JiEvTf+EeL/SzfHhngs/wQMe
BDMRqWB4KdY+wq253Sus6eQjk32jzPE7PTUo9WnY65Zq/0Z1mfyx2tbXdGufL4nD
rCsEensUnGnMmtAwwT2t48pg6aLs0RfJwSLgGUv4s97qh8MPRIRhjBfkyk4STaQE
VtkdRQUvcNV76muaPq/rKjGNw8eSnIckMCzHeeQxI1u4q5y9MyH1gzyQPOI/NafE
V0E1WvmWF/KapQFLCyVq/oufr8vcXv/EXRLXUeeYWWF1aXXAwrNc94eQVl1FfYAq
APqpBfOzFa7TAiniKoncwVq97GJ6Vd97CHBbWh0vuTznyFYC6WT1zuLOcCnn5tYD
3v3dU8WB5y4/uGeAlypRsmamDsdsUcduj/b3wKARZlr0RzOAIHnaloMIjy+2iM9L
w45nkuo0Jgg0ibwtcfw7IbVjNWXF5QVf/FJPWsmApy8DhCUnl5CweBPrqu59Rrx7
Xt0A1TwwAugxdqnxt+ttBwJhxAQHQu/NmvBvDkW+dafYybpOpOHhmBT/3DEaLHue
wyCCc/c7fjl+m60Kc7Hpv/cMsmfWKyolmkTAoDia98jxR0X6VgI=
=j4g4
-----END PGP SIGNATURE-----

--54pWlrA4MA90OHJd--
