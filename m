Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE7BC433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiBQNFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:05:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240676AbiBQNE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:59 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC162A8D0C
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5A45932009C3;
        Thu, 17 Feb 2022 08:04:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 17 Feb 2022 08:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=CehujH3LGUxACdfQLngKf7oaoCl5aoQEe2AYPf
        eRDtc=; b=VO3LwRq+F3TgKcwHdNo1vzAcINdt/v6RZrNN9bCcqETgwokDCc1agP
        b4fKPKI2m/UnBy0sBc7jwP/V4znLa1BKbyXIflbPVTzKr86Bg6NYqhDIBhFBNz1t
        1kye5n25qt87toRUTetLk1rNk5yRhcP36u6me24BBb9/9P0N/4BrELNSl+c0F0LN
        XyVvrSNSs6c9eyPMxrB3x9SXhw4gZgJLs0CpvEyYMfzimWoiWkd9HBBBLwzhLZVE
        nwmqHeSwaH2XLD5WpCNgFRKrdOj6FhDweBhAupBuToF/7C6yhnGB5J5wSoJ40kbU
        k3IhNrUABHF869bEHRs3ISex0f9CpCBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CehujH3LGUxACdfQL
        ngKf7oaoCl5aoQEe2AYPfeRDtc=; b=aUC5mEIEmiB4aJz/531/iLCbmSrbd37KN
        J+X2Jh5VC9arSDXd3ps42b3RMQnW63iyI4YaCH7qYO9DQpIy5r4DMg5S2uaCruwI
        QI7IMX7KN4USYkK4FFFbS9E2HbRtetMDcA1yx5viynv8SepKsXhJL029lS9CvTSz
        0eUsuyFeKAbODjctAmB5NFVZVKQeVbwrawpts+FZuDMRlzWOaTXYpDeBIlzzHSMx
        zszy8O6dupaTJoYAx5g9SqvWmCkFtcpQK240Rvw1j94jlczzDKo6FBsE6d/sITea
        UUyaqaE9X9F/fjKSb8CZFY+Rfmn9+pur+5Pd/WyqQyWAhxYTJNnnw==
X-ME-Sender: <xms:60cOYgB3oG5CpfSuL6DVSXjv3T4pfX83-k3Zmx0_70UCCEYp_5PGqA>
    <xme:60cOYijHMkEB48zrIbi10QJ9LOJB8q1GtqnJ59Qiwlx77hZSPoYsf2wRRQAS7eAlY
    onFx9YOR9VqvFXqdA>
X-ME-Received: <xmr:60cOYjkUzaHSY9xe3j61NOWcZaSXmkDnmTANRhD7LIm2I5afLFbutBsFFEH2OcHhKQId5hcHj5Tnrsv5QpCsfUDxQKvXCOm2XvN4XyoxclOd3mJSk2zR_zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:60cOYmw-7Ht3ehnr54YFSVfVA4HxzeDMz-Mhh2yfm46LhbX-sj7emg>
    <xmx:60cOYlRgf3NmIY9ckIu9rbkflG5CyVfjSbSlyeyftIgenlF_cYzeSw>
    <xmx:60cOYhYYHsROHcotN5OjdG4h3tgBWgX4PjeuH1dt9rgtDcKTT5fBsw>
    <xmx:60cOYgekLtXwC2sGjVgukWu5pLFVRyPX5QKLSBXCHyKmiVsYZ4WrSw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e8fb18c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:42 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:41 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 7/7] fetch: make `--atomic` flag cover pruning of refs
Message-ID: <2ad16530e5df1119a7c17d3a382b420187c93c63.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5yUnp+rxqvSATt5"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y5yUnp+rxqvSATt5
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


--Y5yUnp+rxqvSATt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR+gACgkQVbJhu7ck
PpQIHA//XWI/xeY05OE2Ip3O0TOCl1z84+qejr/Zo2y3juGIeNRV1hb0DgXEajIE
/kFjq/HzspSNTNoXqZUa2/3FCw//XetKgYRSTjbKoi6aGkZC3P43tuw8m/Q+jvHq
XN6HmRo3bzVosQToonNUDkDDEwUtrXBzbl/kx2c3YmClANAO3w3vvcIB0dAAAoy3
Bn6Dj1OOtLOpr92WqjqEhMPvoc0PvHrvQhUAJq3diconWL9Zoz1ilV1KFGrUdtf5
2+lkVojvdJsBi19e4AFqQ/6VuDhBVlUvDydjDFPwFqjFWXjCEuwXhTl2HVYSAmTp
Zt7s8eUP1BNl6Yf3qSSETCn8/qio+p6iM8KLBGhbJWrSG36l+Jy9RVPBEkSd0JiA
r9loq2lMs2PKOcS6jLG+fAuDXAPcHj7PWvg6aI1c2fwi2ANGYeTDGi/xffPT2MBD
kEl0ZRR0SqXg80UtxSxvFHfGcbmBZoS1Nmpj6mY6blowgyz2svHYWb58AgbqRDb+
KW05P0zu+weUvEiggLtLGBRBH4AVHFKZKOo+Rtc0ds1kEKYX+aZkqhmhqnAiyFh0
xX10p/1Rx54E3w0Wnw5cQEZfEQ7gztlsaQQoSZNSaLBHDGkcJejArqm0rlXhzNzk
TkvuZJn3HpRYz6gvXRH4xsXJatJswa4gLkyJsUYjnj0F9kPX954=
=4Uku
-----END PGP SIGNATURE-----

--Y5yUnp+rxqvSATt5--
