Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EC9C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347806AbiBKHrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:47:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347824AbiBKHrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:47:09 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA71BC66
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:47:06 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 27E5F3201D51
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Feb 2022 02:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=mzDk2LKbDo8qWlA48RMH2GinqgKG6ZmmrEO8Ph
        ANrSg=; b=x1MDlNOMb4zSUesBUVDkBu0s8I0xzyCQ5rEPZTEugj1AVNNtt7AULX
        9HlrnFYj3WR6WJaS8x5mbTVqFgk58dRW72W6pa8RMP6onlau/pJmHt5+qFfvrBF2
        VB75HROvOgL0oiftAhKrcs5a40VehiR/c5MGDsKJnybLR43N9xNyXM4wJk/WRuAz
        grNKkDg+y6kjgYxCSHL62rTtLzAECLJxSeIB/MEsYLckP5mcIH6O+94OJ6Hlymal
        WmUmbEpiGBxhOd62Dah2GA3cgm/4r3lBSjukrRBeP4ssjgMCdupbqNHOHGogFXBf
        YYSafyN1Fuw+BvYOmSYmtERTERsRd24A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mzDk2LKbDo8qWlA48
        RMH2GinqgKG6ZmmrEO8PhANrSg=; b=jPT7Ve/sOXN5QlqKU5iImjEdbBjZtZ8WN
        NOFRNX6azDlPva/BbvRohqjh8GXWzxPi4NIvP/33j4p2Qg0hmZgrT3EbvDcNj5i3
        5E0gjor+Pmw07J+Mq2lyEL4C1ilN9zAuPxGHLMqpCAMKr84MW2MND7NXq+A14bhv
        Tk8+KXMR4vrouJ9GqPfhVhYeZEF5zdwqDytDP84QxjaBTG2fmGH3y0OiV3ebFyiF
        Zq45y3ibcCNT/GhBay8SIpgfm//ouSs0PU214Z2CHstcwy8OpM5JZ3WANtKj3dIB
        RXoLDTZihEbZD4eth/ODiA4+k1s1eSIpnGkVbQVIcO0/sr2kmlCVg==
X-ME-Sender: <xms:eRQGYiLN8ZTANTI9ooUAMEgZttQgzC7sYIJTVFIDmehsAf62_KHFww>
    <xme:eRQGYqL_jogSMq2yW-6hjBUjvun9l5RNZOg7OciTz_GZAwMZQ4H6Uk_jeEuZukPMc
    WLzUTp3_udKbhKPHg>
X-ME-Received: <xmr:eRQGYiu8RrskOxTzoyCQWMZJ5re4UOHwYSzZy7SjglzVCyowgv8b3gIr4qo1J__fyw1F_oWG4ABxXe8F5b9gIlF0BMuuaynZffnbWDu_1ZONRqmm35ysWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eRQGYnYstFB5IvcOTqCUviEQ4uPDvOi0WlzNiuwqf0ModqgupfLgYQ>
    <xmx:eRQGYpa2tMnZMIDiuSuWj-ckxVtvC5uMUfOjMzySsMdE5r8Mxoif8A>
    <xmx:eRQGYjAeKyUbcvqnQDuZGX8FSFnpzOqE8IN1I0Jl6AwVv1J5c84DrA>
    <xmx:eRQGYr3EYmtdJt5lFnd0ygnFR5ivAFK7ZRc0_2WN0PRYKkR3xyvLsw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:05 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7ff528f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:47:04 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:47:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] fetch: make `--atomic` flag cover backfilling of tags
Message-ID: <55dbe19a1a4d05d84c81356af1a3f04b65f8aa7b.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+Px9BdxXaPfzNhjB"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--+Px9BdxXaPfzNhjB
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
which we have already been updated with our local references. But when
we use a single transaction for both local references and backfilling
then it may happen that we try to queue the same reference update twice
to the transaction, which consequentially triggers a bug. We thus have
to skip over any tags which have already been queued. Unfortunately,
this requires us to reach into internals of the reference transaction to
access queued updates, but there is no non-internal interface right now
which would allow us to access this information.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c      | 89 ++++++++++++++++++++++++++++++--------------
 t/t5503-tagfollow.sh | 11 ++----
 2 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1eda0b68ff..348e64cf2c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -4,7 +4,7 @@
 #include "cache.h"
 #include "config.h"
 #include "repository.h"
-#include "refs.h"
+#include "refs/refs-internal.h"
 #include "refspec.h"
 #include "object-store.h"
 #include "oidset.h"
@@ -350,6 +350,7 @@ static void clear_item(struct refname_hash_entry *item)
 }
=20
 static void find_non_local_tags(const struct ref *refs,
+				struct ref_transaction *transaction,
 				struct ref **head,
 				struct ref ***tail)
 {
@@ -361,12 +362,28 @@ static void find_non_local_tags(const struct ref *ref=
s,
 	const struct ref *ref;
 	struct refname_hash_entry *item =3D NULL;
 	const int quick_flags =3D OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJE=
CT;
+	int i;
=20
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
 	create_fetch_oidset(head, &fetch_oids);
=20
 	for_each_ref(add_one_refname, &existing_refs);
+
+	/*
+	 * If we already have a transaction, then we need to filter out all
+	 * tags which have already been queued up.
+	 */
+	for (i =3D 0; transaction && i < transaction->nr; i++) {
+		if (!starts_with(transaction->updates[i]->refname, "refs/tags/") ||
+		    !(transaction->updates[i]->flags & REF_HAVE_NEW))
+			continue;
+		(void) refname_hash_add(&existing_refs,
+					transaction->updates[i]->refname,
+					&transaction->updates[i]->new_oid);
+	}
+
+
 	for (ref =3D refs; ref; ref =3D ref->next) {
 		if (!starts_with(ref->name, "refs/tags/"))
 			continue;
@@ -600,7 +617,7 @@ static struct ref *get_ref_map(struct remote *remote,
 		/* also fetch all tags */
 		get_fetch_map(remote_refs, tag_refspec, &tail, 0);
 	else if (tags =3D=3D TAGS_DEFAULT && *autotags)
-		find_non_local_tags(remote_refs, &ref_map, &tail);
+		find_non_local_tags(remote_refs, NULL, &ref_map, &tail);
=20
 	/* Now append any refs to be updated opportunistically: */
 	*tail =3D orefs;
@@ -1083,12 +1100,12 @@ N_("it took %.2f seconds to check forced updates; y=
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
@@ -1110,14 +1127,6 @@ static int store_updated_refs(const char *raw_url, c=
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
@@ -1233,14 +1242,6 @@ static int store_updated_refs(const char *raw_url, c=
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
@@ -1258,7 +1259,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
  abort:
 	strbuf_release(&note);
 	strbuf_release(&err);
-	ref_transaction_free(transaction);
 	free(url);
 	return rc;
 }
@@ -1299,6 +1299,7 @@ static int check_exist_and_connected(struct ref *ref_=
map)
 }
=20
 static int fetch_and_consume_refs(struct transport *transport,
+				  struct ref_transaction *transaction,
 				  struct ref *ref_map,
 				  struct fetch_head *fetch_head,
 				  struct worktree **worktrees)
@@ -1323,7 +1324,8 @@ static int fetch_and_consume_refs(struct transport *t=
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
@@ -1496,6 +1498,7 @@ static struct transport *prepare_transport(struct rem=
ote *remote, int deepen)
 }
=20
 static int backfill_tags(struct transport *transport,
+			 struct ref_transaction *transaction,
 			 struct ref *ref_map,
 			 struct fetch_head *fetch_head,
 			 struct worktree **worktrees)
@@ -1519,7 +1522,7 @@ static int backfill_tags(struct transport *transport,
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
@@ -1532,6 +1535,7 @@ static int backfill_tags(struct transport *transport,
 static int do_fetch(struct transport *transport,
 		    struct refspec *rs)
 {
+	struct ref_transaction *transaction =3D NULL;
 	struct ref *ref_map =3D NULL;
 	int autotags =3D (transport->remote->fetch_tags =3D=3D 1);
 	int retcode =3D 0;
@@ -1541,6 +1545,7 @@ static int do_fetch(struct transport *transport,
 	int must_list_refs =3D 1;
 	struct worktree **worktrees =3D get_worktrees();
 	struct fetch_head fetch_head =3D { 0 };
+	struct strbuf err =3D STRBUF_INIT;
=20
 	if (tags =3D=3D TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags =3D=3D 2)
@@ -1602,6 +1607,14 @@ static int do_fetch(struct transport *transport,
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
@@ -1619,7 +1632,7 @@ static int do_fetch(struct transport *transport,
 		}
 	}
=20
-	if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)) {
+	if (fetch_and_consume_refs(transport, transaction, ref_map, &fetch_head, =
worktrees)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1629,7 +1642,7 @@ static int do_fetch(struct transport *transport,
 	if (tags =3D=3D TAGS_DEFAULT && autotags) {
 		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
=20
-		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
+		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
 		if (tags_ref_map) {
 			/*
 			 * If backfilling tags succeeds we used to not return
@@ -1638,15 +1651,31 @@ static int do_fetch(struct transport *transport,
 			 * state of the repository. We now notify the user of
 			 * any such errors, but we continue to make sure that
 			 * FETCH_HEAD and the upstream branch are configured as
-			 * expected.
+			 * expected. The exception though is when `--atomic`
+			 * is passed: in that case we'll abort the transaction
+			 * and don't commit anything.
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
@@ -1704,7 +1733,13 @@ static int do_fetch(struct transport *transport,
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
index 549f908b90..4a8e63aa16 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -182,11 +182,8 @@ test_expect_success 'atomic fetch with failing backfil=
l' '
 	EOF
=20
 	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
-
-	# Creation of the tag has failed, so ideally refs/heads/something
-	# should not exist. The fact that it does is demonstrates that there is
-	# missing coverage in the `--atomic` flag.
-	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something)"
+	test_must_fail git -C clone3 rev-parse --verify refs/heads/something &&
+	test_must_fail git -C clone3 rev-parse --verify refs/tags/tag2
 '
=20
 test_expect_success 'atomic fetch with backfill should use single transact=
ion' '
@@ -199,12 +196,10 @@ test_expect_success 'atomic fetch with backfill shoul=
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


--+Px9BdxXaPfzNhjB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFHYACgkQVbJhu7ck
PpQyLQ//dLrBSWh4Ac9nyA+kjO0tWBexke/CLFgZsKnX8H3OVlv9Fee4YuNcJMzQ
dW4NIjevTZnJMnO7U5xYAOCs9aU2afrdHDl6Rfhn0zsyvtQBjzJs3AtegrWUwz/w
JLZt0NfHwhO9D9oZvE6CNxXKJ0qGR1MgLX9OquNtKZxKzmyHyXMNkd24y2hENHlM
8C8oMJYhaFPpw9rM2YaAXMz/cjFaPBxxwxp3gtr8rBmkhfkkkjV6nwWOJ5eSERVl
Mj/qymAt+PYwhxWzS/mJH4egS44VjpHg00xY4P4x17abCpP8uAMrq4uSGghtFDa2
D0+YvkdXkBjg97j+gjeMIzSKVAz2VN0x5B7+UETF7Dj+hVt29nKM+gco4CvDYnMb
0A6jsQInbBYC52V/2UFX4M//Fc97iojznNc1My6aeMdaeKBznQQYDsFCfqoYl3cc
n8aatSmZNWE6rKMHK8mbFyfGVoa4zmlJcdQrA83KGSe2TsoWZeHwg1Byub2lDWUf
HzeT5cjI210jeoIW+nMYXlMbBuacWRZHrf5SB5IxbZbMFP3Xaf40JGmsvB7t8+Qs
EOP8AGQkMVCsVPzW/K4WxI7C4J7S4lsCvOQmPBfZL0Ie/vOocPpnNc586fBLdo24
9aB5civLpNtYs12JmmMAB8MqC+/U9wR9Wf2EWeQA+URC9N46SGs=
=ifmQ
-----END PGP SIGNATURE-----

--+Px9BdxXaPfzNhjB--
