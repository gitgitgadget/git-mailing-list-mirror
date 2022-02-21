Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06971C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346800AbiBUIDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:03:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346759AbiBUIDC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:03:02 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D9DF60
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:38 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 88D245C01D4;
        Mon, 21 Feb 2022 03:02:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 03:02:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=vIdFLBXkjRHlNdEuueg7QRVf25qE15sZNoNmEu
        btm24=; b=JprSvqSS71V92/03CimIwq6jzvfAsjRlEoRITvtOOfBIvzZVaOId4T
        RhL8jq3mcodBrY+2lCwTW0s74mh6gywJthsysJlfQhT/a5lCqfHr6nFAsRmwcmKP
        uDCSmrO/bsoYHkog8HbDr4M86gOPLbQJA7YU4cK9iXhTF4aRDE+ZWC+WB6I1YXVi
        /uuR2mibq6XrDyFq7fbflnOlV+99/RWzeUIhbaWgZpR4TsBvmYdRJ/ditRNylpPk
        2Rob9nULBCYxLx1z7gDHtG1QUI9v9Ew4PYXUGJysQeW+es9oC7E/pzpQYDcLKvzb
        iE77UxyjKitnZkD/YlAYmW0YAqcGGorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vIdFLBXkjRHlNdEuu
        eg7QRVf25qE15sZNoNmEubtm24=; b=evE35QmKhKQlhV2OnWrp6hm2YLNjc/T4c
        64RSFUIgQPVCOkg0wQiYfP9pRpKqI604HTpK+ngCE4emeyi3s9l+8TxbHGapTAkf
        ndHtHR0DoxxE29BueXFDaQcvQQ6dESs2HQZhFG7b2LmLSnmX+AImTc/lqNvGCgWo
        x/HkfdBYCTJTU0Suxd/5XOK/LY3Fl6/5IiQ+Zd9qLkHrmfC6rgCvuXuKJGG1Re5l
        8Vh7ScoCQKkWhbncjLHrE3es2PxqyUSfCxeP49ngCbDKc9qzpWFmn1nD8GiHzwWC
        /T5Q19K/MGiX/zKEP8ISR4QH1HniXst5f5Yy8FEiv+uH7WkcakBfw==
X-ME-Sender: <xms:HUcTYn3ITyN-2XM7mZWi1jSOD7fODb4HDvm12FI7CSrPgIkJRcDV4Q>
    <xme:HUcTYmHHSjiF9--bWKkUk-DO90wEdz_wCGBGxqjdbcotde6kFxnqvSnqLFjhTUDqU
    J7fMyaDu3crMCJqRQ>
X-ME-Received: <xmr:HUcTYn5ixAns5nCeV2FmXegHriHtGCrrQjrt_KOiLLXw46hrfNsvoyBfAAAawX_hANEmS2_-n9Uytfa7vxHlY5p5yb1eIzgyPXr1gL1oz8QvKwFF8hgr5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HUcTYs2PJu7kz0U9BskWEyOK_QQu4FyCvZqaNUi4tDCm_VUH4jo_7Q>
    <xmx:HUcTYqEs3Z5W13tmFnje9u8ZOm8E7HJJnOkXAp-J_c2qY8ZcBxsaww>
    <xmx:HUcTYt9Cl510BEuj7I-ZPp3cAxWvTBvEqteSRMEfvlMopYnOgB4JEw>
    <xmx:HUcTYmCF61P1EQ7Ph2ylXx7FQpKJKog-VOyOgm0zmwP-BAXQmReTrw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a22c868a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:36 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/7] fetch: make `--atomic` flag cover pruning of refs
Message-ID: <7292de826bd871bc12d7541f56c9a10b782c705d.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iKRimgko/RmoMPVg"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--iKRimgko/RmoMPVg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching with the `--prune` flag we will delete any local
references matching the fetch refspec which have disappeared on the
remote. This step is not currently covered by the `--atomic` flag: we
delete branches even though updating of local references has failed,
which means that the fetch is not an all-or-nothing operation.

Fix this bug by passing in the global transaction into `prune_refs()`:
if one is given, then we'll only queue up deletions and not commit them
right away.

This change also improves performance when pruning many branches in a
repository with a big packed-refs file: every references is pruned in
its own transaction, which means that we potentially have to rewrite
the packed-refs files for every single reference we're about to prune.

The following benchmark demonstrates this: it performs a pruning fetch
=66rom a repository with a single reference into a repository with 100k
references, which causes us to prune all but one reference. This is of
course a very artificial setup, but serves to demonstrate the impact of
only having to write the packed-refs file once:

    Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
      Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User: 0.8=
58 s, System: 1.508 s]
      Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 runs

    Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
      Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User: 0.7=
15 s, System: 0.641 s]
      Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 runs

    Summary
      'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
        1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic +ref=
s/*:refs/* (HEAD~)'

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c  | 30 ++++++++++++++++++++++--------
 t/t5510-fetch.sh |  8 ++------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 67af842091..9a2b5c03a4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1338,11 +1338,14 @@ static int fetch_and_consume_refs(struct transport =
*transport,
 	return ret;
 }
=20
-static int prune_refs(struct refspec *rs, struct ref *ref_map,
+static int prune_refs(struct refspec *rs,
+		      struct ref_transaction *transaction,
+		      struct ref *ref_map,
 		      const char *raw_url)
 {
 	int url_len, i, result =3D 0;
 	struct ref *ref, *stale_refs =3D get_stale_heads(rs, ref_map);
+	struct strbuf err =3D STRBUF_INIT;
 	char *url;
 	int summary_width =3D transport_summary_width(stale_refs);
 	const char *dangling_msg =3D dry_run
@@ -1363,13 +1366,22 @@ static int prune_refs(struct refspec *rs, struct re=
f *ref_map,
 		url_len =3D i - 3;
=20
 	if (!dry_run) {
-		struct string_list refnames =3D STRING_LIST_INIT_NODUP;
+		if (transaction) {
+			for (ref =3D stale_refs; ref; ref =3D ref->next) {
+				result =3D ref_transaction_delete(transaction, ref->name, NULL, 0,
+								"fetch: prune", &err);
+				if (result)
+					goto cleanup;
+			}
+		} else {
+			struct string_list refnames =3D STRING_LIST_INIT_NODUP;
=20
-		for (ref =3D stale_refs; ref; ref =3D ref->next)
-			string_list_append(&refnames, ref->name);
+			for (ref =3D stale_refs; ref; ref =3D ref->next)
+				string_list_append(&refnames, ref->name);
=20
-		result =3D delete_refs("fetch: prune", &refnames, 0);
-		string_list_clear(&refnames, 0);
+			result =3D delete_refs("fetch: prune", &refnames, 0);
+			string_list_clear(&refnames, 0);
+		}
 	}
=20
 	if (verbosity >=3D 0) {
@@ -1388,6 +1400,8 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 		}
 	}
=20
+cleanup:
+	strbuf_release(&err);
 	free(url);
 	free_refs(stale_refs);
 	return result;
@@ -1629,10 +1643,10 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			retcode =3D prune_refs(rs, ref_map, transport->url);
+			retcode =3D prune_refs(rs, transaction, ref_map, transport->url);
 		} else {
 			retcode =3D prune_refs(&transport->remote->fetch,
-					     ref_map,
+					     transaction, ref_map,
 					     transport->url);
 		}
 		if (retcode !=3D 0)
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 70d51f343b..48e14e2dab 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -354,17 +354,13 @@ test_expect_success 'fetch --atomic --prune executes =
a single reference transact
 	head_oid=3D$(git rev-parse HEAD) &&
=20
 	# Fetching with the `--atomic` flag should update all references in a
-	# single transaction. It is currently missing coverage of pruned
-	# references though, and as a result those may be committed to disk
-	# even if updating references fails later.
+	# single transaction.
 	cat >expected <<-EOF &&
 		prepared
 		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
-		committed
-		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
-		prepared
 		$ZERO_OID $head_oid refs/remotes/origin/new-branch
 		committed
+		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
 		$ZERO_OID $head_oid refs/remotes/origin/new-branch
 	EOF
=20
--=20
2.35.1


--iKRimgko/RmoMPVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRxoACgkQVbJhu7ck
PpS6bBAAmc4+V6me5yH7hK8B+Frw7+066PCcZ10jC0tqTPNgzkIkfuJKANGdVPqO
25w44xXUyp6Hxq4oXkco0ks65tD0/TbZW1g6oPKiAA/CusKi9CIvaeQeWOpzA/gv
PqK6eMLHdnB+5+pWkeACjdsWkq3/72B3AObAcXtSWodSBn387V9JBcMde+woE04E
L+hDlg2HSQqREjnlmOh7s/pkTZQstOT64Qs7H+K1TDDitPn7VjSLd0zBHHpyN/6j
WMQ0ahjpyZC38X53yMjsfuqAs3bAEk87wv3N6bQPJKvaxmNUowb/JHF3l4LC6aM0
oByeiMeQaLHpMs4z+ktiGc8BCZs8072YEwHHINSPZEnI8E5Im0q04naBJroYAuii
88q5taMZed9ggKYmYuU0BA4LEseh0urHsnABqLzLwRLLzIjcTWtFYkZiG+MGyhxD
1cgiNoLK5ns5X86s+8zP2wPiXnPxX8xfsB8ZuqDR8GXEqVqyDjiHwFjjJsURbYXW
cxDBZB6u2+Qp2+z3TCcTzoGH15C0r/B6kLo6RTXM38lGEI8LEg8VCkHC/EXquo83
FnkNT3CEvBjVEKmfsXjEIx7miu5AvXcS7X8Bw1XOVp5V342W1t4o3l9fVnjNIVDB
+sQYDB43Q2i5TJVR+LU8RaxTrunFIJhlriYiRD/qxBfZ3NomeLs=
=LDr2
-----END PGP SIGNATURE-----

--iKRimgko/RmoMPVg--
