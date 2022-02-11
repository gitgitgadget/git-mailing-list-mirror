Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D082C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347828AbiBKHrR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:47:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347818AbiBKHrN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:47:13 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2AE1030
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:47:11 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 90BBE3201D9C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 02:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=fuknSbXO2Wlk9QT2QghdEuK/Gx+r/4ovwXlqPs
        29LlQ=; b=jVsfv+XSLPg1/or2jX/05wl610q2OZ3ByTgqgj+T17rKio4Y2vWZnT
        mfwiXIzp3eBzTiDQEWbMHbYnJhYaWCXvkrKtAcVIS3HIMVfQkydNbWKBhrbsgcuZ
        0tlu0U5H64ZjWPT5SrXXSnUsCTivsjg4TXLQyVzZkOt35DQFr9hz/i2SSmhR09tR
        K4N9NISrfqG15qE+h4SNga6YTS7oXeaDlL1kkoZuoiXvjqeEeNXPeLYEPr1A73gm
        fkDkq9sFtvyAr9eDxhtLQlRmoMwWiEBupsIERTiuDEOmbuat+mHrNGdB/8H0A+XM
        kH2VHEfNMOuKTrsd9sWrNkK4Uwdv6lLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=fuknSbXO2Wlk9QT2Q
        ghdEuK/Gx+r/4ovwXlqPs29LlQ=; b=B6ZyybBWE6SlBcxF1DegmllYZ3E8hVCeG
        lRyqO65ifE64qYTheHZ9HmEYtC1btNRhCIa5++IqejCjotSp7nn7zL6OfWfQdrJk
        1al5AhQ7nI0SWfWSUVeHbwwNuH8VgR5eNoFUR/WwRgj2ZUS3Rdf/kNzZ6kkpme6N
        9xGysPORn9DGp0/AimvETNxeAXDRlcTRntO+i1QyJicbhW/2rt1cZo9SpfNdCZRT
        cUFmKtX/KToMGznLKwW3cO0q/eCiicZ7jXutOOqLuzj8eAS6LtQY+QnhlhSm7f2u
        Eibu5j/8yrd/cc5N3lw8fjXvrB8nHRXkXNg0A+URJSrw5m0HNwl8A==
X-ME-Sender: <xms:fhQGYkvU_M4wB0e1RnGsx6JMgfXyG8KCzhP46sRnSyiw2ws2Zn_Ovw>
    <xme:fhQGYhfie09h5yKaOWrY9_Y13vPH4H2rNtme7ScCzoGJA8fMRZ-vq9jyb2GdE_bG8
    rumkEw1fJgQ34yv6w>
X-ME-Received: <xmr:fhQGYvxFdHtBujjmIZtsyV55GvfaZu8pLLAiqIFrIAc4VtEkBJ-5_KycpzyN_Z4KkwgkznQQFX_TCq35JRxlkhQPWxZsIgWWioPPa4gFESuKrJzrTmyC4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephefgjeeuveejteduhefgffefffdvjeefje
    eivdekfffgkeeugfehveetueefleeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fhQGYnOglViDPK8Gv2LyZYP-I0rU9e5Dpdtyiye8Zn_jE8MWlt-DdQ>
    <xmx:fhQGYk9nJAbVPYMmCD02sJxVvp6pcJ1V086Y6avwqx9BwdQqB7nrww>
    <xmx:fhQGYvWSC5K7wIgOnJSOCLMtUOG4ZvXs4bIc5MrRhkJdCd0CN7SA9Q>
    <xmx:fhQGYtKge5aIGygOunB9WN_XBskSnUz8-U5skFeSQkbUZz6mciABng>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:47:09 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3b77fc54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:47:09 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:47:07 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
Message-ID: <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tCezb071PfnZs6HN"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--tCezb071PfnZs6HN
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
 t/t5510-fetch.sh |  4 +---
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 348e64cf2c..75e791a4b4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1333,11 +1333,14 @@ static int fetch_and_consume_refs(struct transport =
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
@@ -1358,13 +1361,22 @@ static int prune_refs(struct refspec *rs, struct re=
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
@@ -1383,6 +1395,8 @@ static int prune_refs(struct refspec *rs, struct ref =
*ref_map,
 		}
 	}
=20
+cleanup:
+	strbuf_release(&err);
 	free(url);
 	free_refs(stale_refs);
 	return result;
@@ -1624,10 +1638,10 @@ static int do_fetch(struct transport *transport,
 		 * don't care whether --tags was specified.
 		 */
 		if (rs->nr) {
-			prune_refs(rs, ref_map, transport->url);
+			prune_refs(rs, transaction, ref_map, transport->url);
 		} else {
 			prune_refs(&transport->remote->fetch,
-				   ref_map,
+				   transaction, ref_map,
 				   transport->url);
 		}
 	}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 93a0db3c68..afa6bf9f7d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -349,11 +349,9 @@ test_expect_success 'fetch --atomic --prune executes a=
 single reference transact
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


--tCezb071PfnZs6HN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFHsACgkQVbJhu7ck
PpSMDg/+KB+ufFDZmN+NXWRA+vRVHkH1ojIDLpaqQOLX9x/nlLyKQYeVcoB3Xsa6
bzdpNQec6DlG0O8nZtudgi01qZlar0aBJoVjqljjm8iUfKhNeVWkHAB7ifrX0y1a
pLUj7Z8kISxiblGwPopvgo0FW0N+tQA0AgifSuJabzup2ZB4Pafu/to0bCpJRPNK
KLMWi/mmQI3P2296nt5kuOsiUOPFbVb3i3PV3mJE/DCJxjXZKDo6T8b9KA0DANhO
C16LNNu6ADx2lhx+bJ3yYlO1W22wH5JHgQiCqDHnZJyUK8XdPFkbU6qWvW7O3QTE
xBTlxufaRQlYP8aYBNH/bV1cSsnMD7Trsa6ou2a8MlZhQSjVWQFK/8F76JZev7Qr
xEezkwjJlBDxQUn9tAHLYZcNVm54wGvvt50Ziuqd/6BlbaWRv1Hf0PHoNvb0j4sp
7eEeOdVC6MJ4jVHjMwFrnsceRolfva+v2EgOoNOttW26rAHFs1fpL22x4cNOJLgM
1+kVtX3vsmqgyTzVKPAqaNWROxArggQyApIXteEZGZXkOBrugWIGDBgsIPP49tle
Dh+ymb4T9LfsBF0L/hO0pflr0bSUWeijWUQANATglnOQnnxVwVTNT/M7BINisM5T
K8sB0REQn1sg31djvlgN1bpqOasZlL2elLZ/KSJJk+0a1p6vxq8=
=yzuQ
-----END PGP SIGNATURE-----

--tCezb071PfnZs6HN--
