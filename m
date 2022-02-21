Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD81C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbiBUIDZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:03:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbiBUIC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B846BF68
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:34 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 39B5E5C01D3;
        Mon, 21 Feb 2022 03:02:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Feb 2022 03:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ltrQOEAjHBnuzB5KSZycMd3b1CIDLJokhztcNt
        6z1Do=; b=NNzmuTaMn1HxWlvNvM2UjgR5Koyrd99X+lYtvE3JMC2v3iNl7O0S/F
        y+SPDppVKNWC60/vCdhOAQwXNizVLEyRs5t/427KiIJRBiIVGsemslHCcWJsbDrJ
        J3Jupb04YbW9lwDnW6IObkY7IKi76xgu6ZbgbVTq5hDQVRwKKeIP/v151I3E4VzQ
        2wnYGu3IdUSRBAASKhcMZxvLsyl7Dh4LPyCWssWJfeyk4wqK+METgLEPpPyLrhX5
        IBeQEuh2Pj7uODq2ISOltwPuKdmh/Z71ZjW6mxXzNGhwXrenHiDnHUzG/WLh/t61
        AyzM4lQIsG0SrpXB0JEG6pICPP/UN40g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ltrQOEAjHBnuzB5KS
        ZycMd3b1CIDLJokhztcNt6z1Do=; b=DeGL9y6//INH/So2pBlNj8jCSxQPVqTVQ
        TvqASJ/gkOyC4zu+xfpbIwV4wK4F7WfDUlBKOll6kU570OC0zBFT4jftegtJX4pz
        OGK+Pk7/8Goo437l/RBZlVPkBZMKeylVRkOHL5rq2mlrkBLm+Ht2+xg5/vF9ml5j
        4z6Kt/F7S6wSBpBAVhXcemYD9T9B1YSQ6VHwyUHHlHa860f+/bWo8g+x1xrGepra
        tlekyitNA/B/X8JtIWlMrkDZGQzdH4TDmJWI2WcL2t0Z5jW80VrmQMYGfgzcVNvc
        pQKeqWiySDmZUDoySpXOBNHECDyfA/nst9btuoITAaIHpZuOMTiGw==
X-ME-Sender: <xms:GkcTYvlW3ajT9hP2AyJCMejPvmuh8Gfd5zqpC-nzec8_2-P46xjv3Q>
    <xme:GkcTYi3a4yXZUHHf-xVttyy1u1Cl3YyVo6tm9xv0ARYT6zzUj0UykYuPmL16f5hP6
    YJyuLoiAJNdQU95YQ>
X-ME-Received: <xmr:GkcTYlqr5PaF1oCilv0_U7jy_7sOHkWW2iZqpMW9q15h2IOOudNVigzmHOgEueaTSs3AY7e3QO2s8IFFcBl-C2o6Ztk8htCoCuX_vu6u4TyDeGs4XuvAoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GkcTYnk9K9mjEGD-xN9pokoo1jAfADX5q5hHVJU6F1iphvjTuu3bkA>
    <xmx:GkcTYt2mcyZplC5vwY6JpqcTamYJmanLqlTrFsa1O9ynJ9CY9rSdNQ>
    <xmx:GkcTYms2y0G5hsmX1-LfkKE1ZteNt9lxOwREowqgrfGui1r8qPCIjA>
    <xmx:GkcTYmzeHeq-Huo5SujMPWPVQ02do-Tm4FWXDQjxFxkC-pc4LXmCyw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 28d82717 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:32 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/7] fetch: make `--atomic` flag cover backfilling of tags
Message-ID: <2f98e34c8461f09f7c56c5ec106a2c0be3f396ab.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jThT0HQlQBZlgQdU"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jThT0HQlQBZlgQdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching references from a remote we by default also fetch all tags
which point into the history we have fetched. This is a separate step
performed after updating local references because it requires us to walk
over the history on the client-side to determine whether the remote has
announced any tags which point to one of the fetched commits.

This backfilling of tags isn't covered by the `--atomic` flag: right
now, it only applies to the step where we update our local references.
This is an oversight at the time the flag was introduced: its purpose is
to either update all references or none, but right now we happily update
local references even in the case where backfilling failed.

Fix this by pulling up creation of the reference transaction such that
we can pass the same transaction to both the code which updates local
references and to the code which backfills tags. This allows us to only
commit the transaction in case both actions succeed.

Note that we also have to start passing the transaction into
`find_non_local_tags()`: this function is responsible for finding all
tags which we need to backfill. Right now, it will happily return tags
which have already been updated with our local references. But when we
use a single transaction for both local references and backfilling then
it may happen that we try to queue the same reference update twice to
the transaction, which consequently triggers a bug. We thus have to skip
over any tags which have already been queued.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c      | 92 +++++++++++++++++++++++++++++++-------------
 t/t5503-tagfollow.sh | 11 ++----
 2 files changed, 69 insertions(+), 34 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d304314f16..67af842091 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -349,7 +349,19 @@ static void clear_item(struct refname_hash_entry *item)
 	item->ignore =3D 1;
 }
=20
+
+static void add_already_queued_tags(const char *refname,
+				    const struct object_id *old_oid,
+				    const struct object_id *new_oid,
+				    void *cb_data)
+{
+	struct hashmap *queued_tags =3D cb_data;
+	if (starts_with(refname, "refs/tags/") && new_oid)
+		(void) refname_hash_add(queued_tags, refname, new_oid);
+}
+
 static void find_non_local_tags(const struct ref *refs,
+				struct ref_transaction *transaction,
 				struct ref **head,
 				struct ref ***tail)
 {
@@ -367,6 +379,16 @@ static void find_non_local_tags(const struct ref *refs,
 	create_fetch_oidset(head, &fetch_oids);
=20
 	for_each_ref(add_one_refname, &existing_refs);
+
+	/*
+	 * If we already have a transaction, then we need to filter out all
+	 * tags which have already been queued up.
+	 */
+	if (transaction)
+		ref_transaction_for_each_queued_update(transaction,
+						       add_already_queued_tags,
+						       &existing_refs);
+
 	for (ref =3D refs; ref; ref =3D ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -600,7 +622,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	else if (tags =3D=3D TAGS_DEFAULT && *autotags)
-		find_non_local_tags(remote_refs, &ref_map, &tail);
+		find_non_local_tags(remote_refs, NULL, &ref_map, &tail);
=20
 	/* Now append any refs to be updated opportunistically: */
 	*tail =3D orefs;
@@ -1083,12 +1105,12 @@ N_("it took %.2f seconds to check forced updates; y=
ou can use\n"
    "to avoid this check\n");
=20
 static int store_updated_refs(const char *raw_url, const char *remote_name,
-			      int connectivity_checked, struct ref *ref_map,
+			      int connectivity_checked,
+			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head, struct worktree **worktrees)
 {
 	int url_len, i, rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
-	struct ref_transaction *transaction =3D NULL;
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
@@ -1110,14 +1132,6 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 		}
 	}
=20
-	if (atomic_fetch) {
-		transaction =3D ref_transaction_begin(&err);
-		if (!transaction) {
-			error("%s", err.buf);
-			goto abort;
-		}
-	}
-
 	prepare_format_display(ref_map);
=20
 	/*
@@ -1233,14 +1247,6 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 		}
 	}
=20
-	if (!rc && transaction) {
-		rc =3D ref_transaction_commit(transaction, &err);
-		if (rc) {
-			error("%s", err.buf);
-			goto abort;
-		}
-	}
-
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
@@ -1258,7 +1264,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
  abort:
 	strbuf_release(&note);
 	strbuf_release(&err);
-	ref_transaction_free(transaction);
 	free(url);
 	return rc;
 }
@@ -1299,6 +1304,7 @@ static int check_exist_and_connected(struct ref *ref_=
map)
 }
=20
 static int fetch_and_consume_refs(struct transport *transport,
+				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head,
 				  struct worktree **worktrees)
@@ -1323,7 +1329,8 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
=20
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url, transport->remote->name,
-				 connectivity_checked, ref_map, fetch_head, worktrees);
+				 connectivity_checked, transaction, ref_map,
+				 fetch_head, worktrees);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
=20
 out:
@@ -1496,6 +1503,7 @@ static struct transport *prepare_transport(struct rem=
ote *remote, int deepen)
 }
=20
 static int backfill_tags(struct transport *transport,
+			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
 			 struct worktree **worktrees)
@@ -1519,7 +1527,7 @@ static int backfill_tags(struct transport *transport,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	retcode =3D fetch_and_consume_refs(transport, ref_map, fetch_head, worktr=
ees);
+	retcode =3D fetch_and_consume_refs(transport, transaction, ref_map, fetch=
_head, worktrees);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1532,6 +1540,7 @@ static int backfill_tags(struct transport *transport,
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
+	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
@@ -1541,6 +1550,7 @@ static int do_fetch(struct transport *transport,
 	int must_list_refs =3D 1;
 	struct worktree **worktrees =3D get_worktrees();
 	struct fetch_head fetch_head =3D { 0 };
+	struct strbuf err =3D STRBUF_INIT;
=20
 	if (tags =3D=3D TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags =3D=3D 2)
@@ -1602,6 +1612,14 @@ static int do_fetch(struct transport *transport,
 	if (retcode)
 		goto cleanup;
=20
+	if (atomic_fetch) {
+		transaction =3D ref_transaction_begin(&err);
+		if (!transaction) {
+			retcode =3D error("%s", err.buf);
+			goto cleanup;
+		}
+	}
+
 	if (tags =3D=3D TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1621,7 +1639,7 @@ static int do_fetch(struct transport *transport,
 			retcode =3D 1;
 	}
=20
-	if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)) {
+	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head, =
worktrees)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1633,21 +1651,37 @@ static int do_fetch(struct transport *transport,
 	if (tags =3D=3D TAGS_DEFAULT && autotags) {
 		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
=20
-		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
+		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
 		if (tags_ref_map) {
 			/*
 			 * If backfilling of tags fails then we want to tell
 			 * the user so, but we have to continue regardless to
 			 * populate upstream information of the references we
-			 * have already fetched above.
+			 * have already fetched above. The exception though is
+			 * when `--atomic` is passed: in that case we'll abort
+			 * the transaction and don't commit anything.
 			 */
-			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
+			if (backfill_tags(transport, transaction, tags_ref_map,
+					  &fetch_head, worktrees))
 				retcode =3D 1;
 		}
=20
 		free_refs(tags_ref_map);
 	}
=20
+	if (transaction) {
+		if (retcode)
+			goto cleanup;
+
+		retcode =3D ref_transaction_commit(transaction, &err);
+		if (retcode) {
+			error("%s", err.buf);
+			ref_transaction_free(transaction);
+			transaction =3D NULL;
+			goto cleanup;
+		}
+	}
+
 	commit_fetch_head(&fetch_head);
=20
 	if (set_upstream) {
@@ -1705,7 +1739,13 @@ static int do_fetch(struct transport *transport,
 	}
=20
 cleanup:
+	if (retcode && transaction) {
+		ref_transaction_abort(transaction, &err);
+		error("%s", err.buf);
+	}
+
 	close_fetch_head(&fetch_head);
+	strbuf_release(&err);
 	free_refs(ref_map);
 	free_worktrees(worktrees);
 	return retcode;
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 27a1dfa3c0..fe23cad4ce 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -180,11 +180,8 @@ test_expect_success 'atomic fetch with failing backfil=
l' '
 	EOF
=20
 	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
-
-	# Creation of the tag has failed, so ideally refs/heads/something
-	# should not exist. The fact that it does demonstrates that there is
-	# a bug in the `--atomic` flag.
-	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something)"
+	test_must_fail git -C clone3 rev-parse --verify refs/heads/something &&
+	test_must_fail git -C clone3 rev-parse --verify refs/tags/tag2
 '
=20
 test_expect_success 'atomic fetch with backfill should use single transact=
ion' '
@@ -197,12 +194,10 @@ test_expect_success 'atomic fetch with backfill shoul=
d use single transaction' '
 		prepared
 		$ZERO_OID $B refs/heads/something
 		$ZERO_OID $S refs/tags/tag2
+		$ZERO_OID $T refs/tags/tag1
 		committed
 		$ZERO_OID $B refs/heads/something
 		$ZERO_OID $S refs/tags/tag2
-		prepared
-		$ZERO_OID $T refs/tags/tag1
-		committed
 		$ZERO_OID $T refs/tags/tag1
 	EOF
=20
--=20
2.35.1


--jThT0HQlQBZlgQdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRxYACgkQVbJhu7ck
PpR6UBAAqWIHdthfIHOD0dQhGpOYmeOCM0AqC+mgzG4QXJD/pHNe4TaNWo3bg3VG
OrYwJX6DH1FEGrqerNK6nw2BVioNxRyyVBBN1mAXndcp257UVbFoRhYZeWJQ9WlJ
PPXlomH1WJZlKLt+Ig6U/4BmSp4rfphH5MThXv+WXNem7JRjeSiGgzlIJoxjQLPH
y3cs0cIOX96m8Zw3nTo29CNGKBpytLQVhf99I6ESt2vRzuCAYCF38rXl5y9wStg1
NLZJrm2jTZ1JRWlx58IOUf8WkOQxT//ysGMd4JSQqQC6NJ7WLP82ImA2EZb2K1CI
d0B8Gs+bBkUC7x/45X2FQgT7dMgc7A+WeqKf5LSQDWJ2FpaeYcjp+sz2aiTHE169
Toe2E2zp7KyoJSLeJtNYCHiORieShTuDfDxKPXW6DnIGcMNN3eb4RCh0LpSta9MF
UN1j4DdTyXxhw9BVE7R/RTnW3yHz5MZzbEoWEq9Ol1S+TtEbEC40iIkCNOvrPFIk
HW9gkDdU0lJ1Ni9HQwn3D1lB4nb6dWKjW0TAccMMagF3DYsNKOc7cJDHFYgfSW+P
ILWhrEsb7FSCHb/rTs7okIGSY1GIdl7P9E0tCGxTdCXZWDpCdJE0CW4PlBlTz2nd
9H35DPTFSg7rLrrNKJsbnXp1fUJ/ACvmO0TWVgHoHk8apC4POp0=
=I5aY
-----END PGP SIGNATURE-----

--jThT0HQlQBZlgQdU--
