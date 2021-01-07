Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56263C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258DC22B45
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 13:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbhAGNwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 08:52:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38075 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728537AbhAGNwd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 08:52:33 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B37575C0170
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 08:51:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm3; bh=dNLt0OW6KpyDsY6e8Tf2jmr5Zy1BhGqtQpoAyJN6
        0hU=; b=YD9Guk3+x7E0pqkKBLa16c+Zw5DbrgcfEhP+MZ1E16OXRmm6nTmK+aaj
        5X2Gw6sQOaA2I+qSxC1OQu5DKHj3DGBCUfqkgAxx4MugD+XuUf2VAw6TH86URddl
        LgGGOS8iOZmWtZsg/R7OtGVeq0qcf+u8J/IIuUivxh5iGnKpkOC9TH6UbQskjYMg
        +EpYOAoEgV2zut6wYI4bnR2leoOOrT4D4SPW73Bv05WXQY7gB3tHynMw/oGGVZxx
        FjU/xCxUfeaY1bymGfbEtYaFyU9tpsXh039RwqhpuyxhgOPJUjOWI9/AzdO5CLhs
        jMaRm6Gh2UB0Zf023+kpO0tBGhICTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dNLt0O
        W6KpyDsY6e8Tf2jmr5Zy1BhGqtQpoAyJN60hU=; b=LkG6ImHHpIAl2IX9y37BG8
        GoHEld9gS57nsFid6fU0ZyoM/FaPeitJXuD4vEO455UDvB1WO4LWY5ZGU1y44bF5
        TelaHMwwI4aJz+NboZMCBwk+9cE/tmnrdaFKanMCT/kPfZUGIF7TNg9IPKiucQRy
        VsLfC3IKyvBDRIascuJMDQxA2AC4UiCQP51RC+koCVqd2f3npKy+m8CcRclsSvBM
        pFiGY10RLCFLnw0//4e7dSDxlZ/BwvziSsSAajrAhaBrK3Hntr9vtgn9NmLqCSjF
        xA6pQ1uLFrsCmsthHDJnY/QbauHp7R91AA9osy2SKB4e1g36zSLtkydMzMS8s7Qg
        ==
X-ME-Sender: <xms:7RH3X2a7G1vqYgZ7WqPWQ951bfD3ARdvko_b1liT22rmvYWgWSIaMw>
    <xme:7RH3X5aKKjOjdMwYAqRAtAQ8JjelGSdJ_WUX7GYvfkLRCX8S4R6N89OrDi9jYlOX_
    xagVaWpH4GMHH6Rww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegvddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrdefgedrvdefvdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:7RH3Xw8eSM870Vblc3d5LoOMp6RyI65X_MHpchxPk02AkuiX21kgLw>
    <xmx:7RH3X4qybQlvkYkWbhOwsuJDJGBVLBKRIE_SEbZ1fdX96AgJKG7qNA>
    <xmx:7RH3XxrFmBE3WaI_k05tQtdusNUvN980MAulIwX-hxKdvq5_YdRCbQ>
    <xmx:7RH3X-3sBfS0D1uG2cl2j8lKZwA57jSn5ys4oWe-a3EM4yoxhLx0zg>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 329A0108005C
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:51:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d5e6043f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 7 Jan 2021 13:51:40 +0000 (UTC)
Date:   Thu, 7 Jan 2021 14:51:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] fetch: allow passing a transaction to `s_update_ref()`
Message-ID: <e627e729e5cd14c94dcf819f4f87b1412b9a9e9b.1610027375.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4QfiVWCgRHMQhH0"
Content-Disposition: inline
In-Reply-To: <cover.1610027375.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v4QfiVWCgRHMQhH0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The handling of ref updates is completely handled by `s_update_ref()`,
which will manage the complete lifecycle of the reference transaction.
This is fine right now given that git-fetch(1) does not support atomic
fetches, so each reference gets its own transaction. It is quite
inflexible though, as `s_update_ref()` only knows about a single
reference update at a time, so it doesn't allow us to alter the
strategy.

This commit prepares `s_update_ref()` and its only caller
`update_local_ref()` to allow passing an external transaction. If none
is given, then the existing behaviour is triggered which creates a new
transaction and directly commits it. Otherwise, if the caller provides a
transaction, then we only queue the update but don't commit it. This
optionally allows the caller to manage when a transaction will be
committed.

Given that `update_local_ref()` is always called with a `NULL`
transaction for now, no change in behaviour is expected from this
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ecf8537605..020a977bc7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -583,13 +583,14 @@ static struct ref *get_ref_map(struct remote *remote,
=20
 static int s_update_ref(const char *action,
 			struct ref *ref,
+			struct ref_transaction *transaction,
 			int check_old)
 {
 	char *msg;
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *transaction;
+	struct ref_transaction *transaction_to_free =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
-	int ret, df_conflict =3D 0;
+	int ret, df_conflict =3D 0, commit =3D 0;
=20
 	if (dry_run)
 		return 0;
@@ -597,26 +598,38 @@ static int s_update_ref(const char *action,
 		rla =3D default_rla.buf;
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
-	transaction =3D ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name,
+	/*
+	 * If no transaction was passed to us, we manage the transaction
+	 * ourselves. Otherwise, we trust the caller to handle the transaction
+	 * lifecycle.
+	 */
+	if (!transaction) {
+		transaction =3D transaction_to_free =3D ref_transaction_begin(&err);
+		if (!transaction)
+			goto fail;
+		commit =3D 1;
+	}
+
+	if (ref_transaction_update(transaction, ref->name,
 				   &ref->new_oid,
 				   check_old ? &ref->old_oid : NULL,
 				   0, msg, &err))
 		goto fail;
=20
-	ret =3D ref_transaction_commit(transaction, &err);
-	if (ret) {
-		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
-		goto fail;
+	if (commit) {
+		ret =3D ref_transaction_commit(transaction, &err);
+		if (ret) {
+			df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
+			goto fail;
+		}
 	}
=20
-	ref_transaction_free(transaction);
+	ref_transaction_free(transaction_to_free);
 	strbuf_release(&err);
 	free(msg);
 	return 0;
 fail:
-	ref_transaction_free(transaction);
+	ref_transaction_free(transaction_to_free);
 	error("%s", err.buf);
 	strbuf_release(&err);
 	free(msg);
@@ -759,6 +772,7 @@ static void format_display(struct strbuf *display, char=
 code,
 }
=20
 static int update_local_ref(struct ref *ref,
+			    struct ref_transaction *transaction,
 			    const char *remote,
 			    const struct ref *remote_ref,
 			    struct strbuf *display,
@@ -799,7 +813,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
 			int r;
-			r =3D s_update_ref("updating tag", ref, 0);
+			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
@@ -836,7 +850,7 @@ static int update_local_ref(struct ref *ref,
 			what =3D _("[new ref]");
 		}
=20
-		r =3D s_update_ref(msg, ref, 0);
+		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -858,7 +872,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("fast-forward", ref, 1);
+		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -870,7 +884,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("forced-update", ref, 1);
+		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
@@ -1034,8 +1048,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, what, rm, &note,
-						       summary_width);
+				rc |=3D update_local_ref(ref, NULL, what,
+						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
--=20
2.30.0


--v4QfiVWCgRHMQhH0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/3EeoACgkQVbJhu7ck
PpTKsBAAnjy1euLfWmcedI/afPUSz65ZQyybEjgxY+ZL5s8rRp1H5/O7OAhW0v9T
9UYtxm0OZdQu3Hqc2FTHdRnUdQj//hbOF/JUMTI6TFjw6uWD5lzHbKiLd9n1PT2K
ZbwSSVGqFsT6/JMLwkzZRLANJZ1SsaH1faG9frjPjacHhsT4GMEck6Zh8kvSh4PB
Srd+hSpsqhlgEVnNEadyKDraMUegXm2XmQd8trmH027OyXM+aQo89w8NFd0UIUvh
mLdZ3GDf0v6BagzEyjefzIAh2KlrqF2CUracrG4EFuTRdBoZ4hluF9VUZCJEH5xu
WMimNzJz3vnQk901q+zmOvShD3reaRt24hg/Zb/wFHqeC5BUF9rplb+5zMcRf55J
VdF+KFbVmCQ1Aj9lm+fzg9Qr6ID+5cmlaZ8KvRwPF448BIE/O3fUyUt3KKv4M3p5
spwa7cOdNT8cmBcPveAZmekjSDXMzPc1hHyhPFgJHnp6cQxlzz297ksrWNVjF9Qe
ZP8ehpopxOKxnjZSg8SEGFvtdC+AfvW/XNBzFhTezP23AGH0S+k7Jr8+EyDZk+js
ycCWUniKHGopD7cr/+sQc1BqGpLjKeX6YtD5EIUs7Mz0p4evdpAzPXYAhbhIBQa8
XkOnZ3K4q+MF1omiM1se+mcdq8YX7IS364iv/Zi/fq23oPKg7J4=
=/81d
-----END PGP SIGNATURE-----

--v4QfiVWCgRHMQhH0--
