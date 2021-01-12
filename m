Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E8C43217
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFAE423109
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbhALM3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:29:22 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37319 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731388AbhALM2p (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:45 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B43861AD9;
        Tue, 12 Jan 2021 07:27:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xvt8LBE2ikZlmdlmQ8cqUHWTAx6
        aK/IG/ywMfLwIyE0=; b=p+YQmLsT1+NCOFAXex/84aByRVJAwE08V4Qk4LZCQzg
        dhpXcvl/mve409aDocsbm3He7EHoO9U9vI5V4XkIrg8XXW1FAkkkJYTlCyZ5it2Z
        rfEd/izVZQYtcoWYY9JCTRVHGPrqDUA+/Tgjfb//QHflI2iyzDZXulIkkb+05sUB
        jKTf9GLMQxRmQENlH5Y8NhTpji2iUvInUZwQ0WJiqO7sn9+2OF5PDuPjS7yundny
        ACrwzgGb2KaAYREAyIaAcBTYwF/PyKobtb4DlkJp+ObpWNw1uQbJqCZLlCivXRz4
        poKQhXv9WLa2oDrZtxuGxgUestKdYmlJRH6eIKSy5yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xvt8LB
        E2ikZlmdlmQ8cqUHWTAx6aK/IG/ywMfLwIyE0=; b=Nn2pJ2Qf7Y+6+QANMI0TEH
        jDVCWmoajSYK6lzEbqjqlwKw1eJ8OuqALq7qk5/Kgz6dLTKV1FjD7oEGupbcrmgW
        Jirhhb8JO/zGK7PC80WPKkS4M90xQ8OKur4yjfVgZ/PeIA6778u25OA6Wy2PPL6d
        pKJ/9Uxb46f6/O5KJabg7PW7i6Jd1iV+CI5hpuss79eXLyTlDAYYXiyTAjHIVVia
        QF4Y104f0O59vr1Ofy0MTbw/EVyzQ/4W6zlK2QBYp611/u1gixZxjgT7RCOjkaPQ
        zsYxHl48OVphZqIDP1iWf06lJ5sy1+9r6Af+ZjiDCQJnGY6mySXVo3eSsx71KMow
        ==
X-ME-Sender: <xms:xpX9X_7YRUAm09gy1KtCOHXZDHoIg_jJiYrpg_u-MzTgIbowGqUClA>
    <xme:xpX9X24D_OjeqtcI_-M4ADUzpSPuu_s8jEIVo2YGSzkwitpHXvFRolBAXfeM8CdqI
    Rzqkma0p33OQ3aoRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepuddunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:xpX9X_3KP5RaghwlBvaVYcCcchtIPvStshWcho2IRjf0iupUPHufPw>
    <xmx:xpX9XyWx6Ze3mnfGrDzBLIuv8MbkZr1GeNM8fPhZ22L_tXT1ogvIPg>
    <xmx:xpX9X66XbskJrxXDCteOmrVNXVighSiU5zHN48Jwhe0kzfHiGUIS2A>
    <xmx:xpX9X3BrghYgTBBlZB1HYjJW7HKi_t9IAYPj509EdSdZ33Mv7IoCgw>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB5D724005D;
        Tue, 12 Jan 2021 07:27:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f866622b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:49 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 4/5] fetch: allow passing a transaction to `s_update_ref()`
Message-ID: <7f820f6f83d67b3f604f234af3ca7e1635bd76b0.1610454262.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610454262.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jY7QlLnGeN1v+fUu"
Content-Disposition: inline
In-Reply-To: <cover.1610454262.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jY7QlLnGeN1v+fUu
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
 builtin/fetch.c | 51 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b24a9e09a4..cada732325 100644
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
@@ -611,19 +619,21 @@ static int s_update_ref(const char *action,
 		goto out;
 	}
=20
-	switch (ref_transaction_commit(transaction, &err)) {
-	case 0:
-		break;
-	case TRANSACTION_NAME_CONFLICT:
-		ret =3D STORE_REF_ERROR_DF_CONFLICT;
-		goto out;
-	default:
-		ret =3D STORE_REF_ERROR_OTHER;
-		goto out;
+	if (our_transaction) {
+		switch (ref_transaction_commit(our_transaction, &err)) {
+		case 0:
+			break;
+		case TRANSACTION_NAME_CONFLICT:
+			ret =3D STORE_REF_ERROR_DF_CONFLICT;
+			goto out;
+		default:
+			ret =3D STORE_REF_ERROR_OTHER;
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
@@ -766,6 +776,7 @@ static void format_display(struct strbuf *display, char=
 code,
 }
=20
 static int update_local_ref(struct ref *ref,
+			    struct ref_transaction *transaction,
 			    const char *remote,
 			    const struct ref *remote_ref,
 			    struct strbuf *display,
@@ -806,7 +817,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
 			int r;
-			r =3D s_update_ref("updating tag", ref, 0);
+			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
@@ -843,7 +854,7 @@ static int update_local_ref(struct ref *ref,
 			what =3D _("[new ref]");
 		}
=20
-		r =3D s_update_ref(msg, ref, 0);
+		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -865,7 +876,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("fast-forward", ref, 1);
+		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -877,7 +888,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("forced-update", ref, 1);
+		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
@@ -1094,8 +1105,8 @@ static int store_updated_refs(const char *raw_url, co=
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


--jY7QlLnGeN1v+fUu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lcMACgkQVbJhu7ck
PpRlWA//cNnBw+r7kQ4332IQ+shuiafieWBRhxS0xV6Pf+PKEy6LhUhHrpgZkxZB
52p56iMxr/5ENCbpruNtDxpCQ3lVW5fVReH/RPz9qTPXR9yruRdwq9vutWr0m56t
hQ5BfncLdc+RbEoOfy79vtjQ1MV9JJAS8vjt1ipNnuHmvkcVoeO1oPvg6ikDTSv1
inUdGPyFJJnpKqy82Mvbkie+6YGH1FifnkIXROdoLe/Or3Ey+tqHpNa0pXq6JjnC
VV1zqpveKSjj15V/EyJDLmMT6Httb5a9srDcwGV9lr+AqVE3g7HnLiP/YZBctSjN
D0MbvvJEt+hxAwdDm9PSNSB+GA3TJbJgtUUFjPRxHmGYOEQrF2mNv8W4A4nOudP1
S3E2OEkL46kS/kaG2zyVpE7KMdQolkrln3hsiPwdfN6qOAPThmP8gTKs2MNiwvGA
ZOcqCZohxCKvVRKdM2dzo6CPfCdvspRnCyZ4BHgf7Nso/aBq6NKk+p2Nh/9GpZwf
aMPR3QajsuphfT6xWKqPFjh9o0/042Y7tmdqQb2jBakbB0frxKU8S1pLHnFoVDWK
4IblhXPBO5d/FJxPFIIF0RR6KUUh5UFbbbnKdIBPb9EytM+as5cpeKMvilQWVajS
K9sF3KUm2cANfWmmh/zKczgqqm5Ufe+kt2103Ujuo2MV9hpgoBs=
=R5sP
-----END PGP SIGNATURE-----

--jY7QlLnGeN1v+fUu--
