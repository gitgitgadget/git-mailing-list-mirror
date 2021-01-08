Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE607C433E6
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7782623A02
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAHMMO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 07:12:14 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36195 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbhAHMMN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 07:12:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B279D5C0238;
        Fri,  8 Jan 2021 07:11:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Jan 2021 07:11:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=KPuZpsdDocGIHP6x+EdOrfYQsOD
        zz7wuKr5btbK7lFY=; b=PAOeudB5ffXyWmB5st0hDcESxXW+TLwZiQHEdperINP
        IKpnna9lEoIQRdUgWNQ2xQa4JH39tGGomuqe35LyQZ56t5yONO4YAvXwPLZodam2
        /BWaSSVBMteVuo6gesg5fZNEqrm4/3Y6p0SOFUGaKfpjDUk5fZYq2HpyjYSXV5nO
        8wMRHtBLDSQhA9dRmMSpUy0zJlgrPi4PC6uKCqGSYb2tNTr2mUwRdFXVpFc6ID/4
        +0JxvsthUpZedj/c/dt2xLFZi/PoDH0d/tmup17uF+t8ErNJsCUJaFrD4eaIMJuo
        ZjlwvTNzppWvBLbVvZJceTG8f/fIo2o2K46SE4C/u1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KPuZps
        dDocGIHP6x+EdOrfYQsODzz7wuKr5btbK7lFY=; b=afhxfjUzE3KyduR38KLoKT
        itQeXFLyIgDK03DHfvGER+JGSo8tc3XKt9mkZl8Ek6FnUCM4CxfXgAuSn7708smz
        mc3BIalh5TKY0nwUfu7h6AZaakZySLKjRXu5vmHOmLWdsutea8pBoeRqOtaGQyec
        AUun4iNIfKyizj4BZ44YTd2eQX7NN8wSTsedWay9nPR4fWjgQCH3Vmt/uhrcPreA
        YSS3k9HvRMs/qGVvjAMc32icL0t3LazXGb8WdEiIEWT0iY8HJ0PD8mQCsgfzdqur
        SWpiPEf8MJ6cLdiTrL9oLgHvSOEevM3cmnEBWAkEL+EEIIiEZGtLT9eGLzk6CSNQ
        ==
X-ME-Sender: <xms:7kv4X4WXmFfAw6tq9u33b7kv0xQRS7wu8j05b5V4JYbvISpztZMIkg>
    <xme:7kv4X8kdrLDW6hR2gW7Ucki9VNkvOSuInutnSnDt4XsTCRaHB_0fmFsFy2RL30Gyv
    enWP3ZgNl3Y0dLinQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdegrddvgeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7kv4X8act5Zocegmcf7Pm3g7p-nO4JObXo1IDfk-xH9SryFIfFLSGw>
    <xmx:7kv4X3UQc6IVupCJLrnvvGACqnJzpNBc7k6AEhPlUr9m7Yyldz_E0A>
    <xmx:7kv4Xynk5mmJ3OmJxOuGDp71jmUaHwB52zLeqRUw3DVg5KX_0UbRow>
    <xmx:7kv4X5tM9UKkqodHCH_ls-JetgI8g6ff_qZW1fk2ZAR5r0lG5r3VaQ>
Received: from vm-mail.pks.im (x4db704f5.dyn.telefonica.de [77.183.4.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 11FBD24005B;
        Fri,  8 Jan 2021 07:11:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 630b2592 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Jan 2021 12:11:24 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:11:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 3/4] fetch: allow passing a transaction to `s_update_ref()`
Message-ID: <4162d10fcbb5729dffaaec0651345dd9522a8e05.1610107599.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G2PjH8V5pCdm8Bis"
Content-Disposition: inline
In-Reply-To: <cover.1610107599.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G2PjH8V5pCdm8Bis
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
 builtin/fetch.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 5221a9dbed..654e0bb520 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -583,11 +583,12 @@ static struct ref *get_ref_map(struct remote *remote,
=20
 static int s_update_ref(const char *action,
 			struct ref *ref,
+			struct ref_transaction *transaction,
 			int check_old)
 {
 	char *msg;
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *transaction;
+	struct ref_transaction *our_transaction =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
 	int ret;
=20
@@ -597,10 +598,17 @@ static int s_update_ref(const char *action,
 		rla =3D default_rla.buf;
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
-	transaction =3D ref_transaction_begin(&err);
+	/*
+	 * If no transaction was passed to us, we manage the transaction
+	 * ourselves. Otherwise, we trust the caller to handle the transaction
+	 * lifecycle.
+	 */
 	if (!transaction) {
-		ret =3D STORE_REF_ERROR_OTHER;
-		goto out;
+		transaction =3D our_transaction =3D ref_transaction_begin(&err);
+		if (!transaction) {
+			ret =3D STORE_REF_ERROR_OTHER;
+			goto out;
+		}
 	}
=20
 	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
@@ -611,15 +619,17 @@ static int s_update_ref(const char *action,
 		goto out;
 	}
=20
-	ret =3D ref_transaction_commit(transaction, &err);
-	if (ret) {
-		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CONF=
LICT
-							 : STORE_REF_ERROR_OTHER;
-		goto out;
+	if (our_transaction) {
+		ret =3D ref_transaction_commit(our_transaction, &err);
+		if (ret) {
+			ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CON=
FLICT
+								 : STORE_REF_ERROR_OTHER;
+			goto out;
+		}
 	}
=20
 out:
-	ref_transaction_free(transaction);
+	ref_transaction_free(our_transaction);
 	if (ret)
 		error("%s", err.buf);
 	strbuf_release(&err);
@@ -762,6 +772,7 @@ static void format_display(struct strbuf *display, char=
 code,
 }
=20
 static int update_local_ref(struct ref *ref,
+			    struct ref_transaction *transaction,
 			    const char *remote,
 			    const struct ref *remote_ref,
 			    struct strbuf *display,
@@ -802,7 +813,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
 			int r;
-			r =3D s_update_ref("updating tag", ref, 0);
+			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
@@ -839,7 +850,7 @@ static int update_local_ref(struct ref *ref,
 			what =3D _("[new ref]");
 		}
=20
-		r =3D s_update_ref(msg, ref, 0);
+		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -861,7 +872,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("fast-forward", ref, 1);
+		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -873,7 +884,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("forced-update", ref, 1);
+		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
@@ -1078,8 +1089,8 @@ static int store_updated_refs(const char *raw_url, co=
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


--G2PjH8V5pCdm8Bis
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/4S+oACgkQVbJhu7ck
PpTg9RAAmH4eHNASOprRGvDtXF8dOn6CVxV5OS6scoqBS+P9Cl5VOQOfm2L46gyO
QORULm0qrOSyJg7ltjKkaUSVqkjA8d/mAZJWJFDgvjsC4rnqD1UP7S+vNXMNg2s3
VaFtxYuQiap2ip/X7+Tqmua8nqWUKpqpYaGWHwsU9w702TnzLjRjfITlXl7bsvkS
mFLOkVe8jNwKXdk+ay7bu6QNr+1kDLs9mhgMg3Q6Zen1U4pZTCKHPgmQkL/XvuVs
cR6NPK7Dklz7H6agd2NL2HPO0gISMIM5y6CAWgF09J1yDn0y/wnZfqi8KUqn5Igl
0zlh/2PqXPZbsGdn/9JY5NdPQPrweUIhEhZyxWtqQlFVfXs3el8QBboyttzq+TmB
ANfizD+ZnuMed1FrFviRAwxZZjy3b+E1oo+tlNVpVa8NgT1tSVNe5N8P6T7A05Dy
8X4siM2tbe8izxiwcOApe120KOFnTwj6ZQ6/ByXEQ2woA1U3COiaXm5aUFbO/Noj
EWoLDzD7nFWXgiSfN5b7WH7CI+6e86BfhzYK5JvEysdVYOvbL0T1BKRFlSsZ2wDy
FzvMwygBImYB23mrIfeTziLtE1otIp2+wWALlp6z4+hJmyrlis7qlIbyEwuRyNSh
A/W1NA5wQRfyxSVPpiNjVJYrNtFy8OMrmJ3zTKUlDPagHkFSvq8=
=i0sa
-----END PGP SIGNATURE-----

--G2PjH8V5pCdm8Bis--
