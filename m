Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1665C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbiBUICy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:02:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346769AbiBUICt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:49 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518466548
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:22 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 198635C01B2;
        Mon, 21 Feb 2022 03:02:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 21 Feb 2022 03:02:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=FW/C05LVjEyRJS4pN+Zduw5lTxDkjGDwjlSKt9
        4cHgg=; b=wCA2Qy1lowEJdl6/epaDPj5Udm8HJnz1kXCkrU97eyvHeHHiA73j0h
        vRoRyrVLgMhwlSdMDATOZ8I/hc9RaOyUW5u4boHoY6DaBdQETOebbaKy8Nfbbny6
        VDrXXOcRKAxE+JRjFmU/WaoZxgUamcrUbgbsjXzwXhukVI7DqIH3FRMPtk8tIlyl
        QpdFxWqGp/FhnVvEs5Mg9trwvDLwCFEbhBzgfhhYSEZ9Ubg7XfvLdXbVaIVF7HXi
        UGYu35ohmHC+8g/U+EZFxX+s+FtGraBjMHJtBW+r9hxBPALbNiESeCNJkl8jobCj
        3aA5BUa2Ume38Ilu9xChKr3u0BJ7Pfag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FW/C05LVjEyRJS4pN
        +Zduw5lTxDkjGDwjlSKt94cHgg=; b=OVUY+RvLPVIjpw+NaL8H/uGCYLtoVpUbK
        RSAnf2erdraYYvYU/4mEgAZtKXw7CrtgCZQEmGb2zUhXfE+SX0XWtxMve/ynipUu
        Nn/4lQ8RbzB6RPKssLLHV42pV2MgaW9+S4erwjHpWFxnH3w3KO+UWmGfxGjBgIfh
        LXBTWJft3LmQzjIpmrcpGwVV4q7gubbJa1vrac771gbH1G0pU1X86QCeexbdSsSt
        F0+ew82HGtNjvLOX/ov0AwnAGpLcflVV3BNNjU06xApW603c6AAAuzTYglw+ePyu
        5zhFULENipS3k/rtOh1yEjOpyDXUDCnxaJpA0AFkCVrdiJsm+XJGA==
X-ME-Sender: <xms:DUcTYjfSEOSnPxs8JKw5vzlhtUaFT3LfHs28rB-zwOy2FErNXOjnsw>
    <xme:DUcTYpMHsfz55bk7ih1OgNJ4276y5Awgy-5-jHDEwYME7KL3MQgdTxGPPELd_qEWT
    9iYlACdEYYq7NLMZQ>
X-ME-Received: <xmr:DUcTYsijEhG54OU4qXjCBir5vbgTwzU6dN8TtN15Zg_X6ldhgb1lLXgVz6qVKzUOHKVDwMNhft9TdXYrX48kXEbS1PHAlqFORGsH4GhS9mAl4nsyQndq9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:DUcTYk_YWLVn8yt9X53ra8RmeBeyvUY4mir4viWtVI_gva3ljtNfVw>
    <xmx:DUcTYvvXQjBw65GrKQRaScaNyoXGwvLd7b8dn1oMqTmr0VsXzmvzsQ>
    <xmx:DUcTYjEUzOBS3ZCLOMTLvEaeUEETMTbIPJQOYDuRKasYOliNC_d_lg>
    <xmx:DkcTYvJulvp4Z07kjehBpsrnz-Z6N4D-0MRXvyLpR-aFK02GpsM-Tw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:20 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 17d9f865 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:19 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:18 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 3/7] fetch: control lifecycle of FETCH_HEAD in a single
 place
Message-ID: <7c36ecbcf4daf1580c7deb9b7536b413dec8618b.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TsJlMQ+ZwULEQ4Mg"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TsJlMQ+ZwULEQ4Mg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are two different locations where we're appending to FETCH_HEAD:
first when storing updated references, and second when backfilling tags.
Both times we open the file, append to it and then commit it into place,
which is essentially duplicate work.

Improve the lifecycle of updating FETCH_HEAD by opening and committing
it once in `do_fetch()`, where we pass the structure down to the code
which wants to append to it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 904ca9f1ca..f8adb40b45 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1084,9 +1084,8 @@ N_("it took %.2f seconds to check forced updates; you=
 can use\n"
=20
 static int store_updated_refs(const char *raw_url, const char *remote_name,
 			      int connectivity_checked, struct ref *ref_map,
-			      struct worktree **worktrees)
+			      struct fetch_head *fetch_head, struct worktree **worktrees)
 {
-	struct fetch_head fetch_head;
 	int url_len, i, rc =3D 0;
 	struct strbuf note =3D STRBUF_INIT, err =3D STRBUF_INIT;
 	struct ref_transaction *transaction =3D NULL;
@@ -1096,10 +1095,6 @@ static int store_updated_refs(const char *raw_url, c=
onst char *remote_name,
 	int want_status;
 	int summary_width =3D transport_summary_width(ref_map);
=20
-	rc =3D open_fetch_head(&fetch_head);
-	if (rc)
-		return -1;
-
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
 	else
@@ -1206,7 +1201,7 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 				strbuf_addf(&note, "'%s' of ", what);
 			}
=20
-			append_fetch_head(&fetch_head, &rm->old_oid,
+			append_fetch_head(fetch_head, &rm->old_oid,
 					  rm->fetch_head_status,
 					  note.buf, url, url_len);
=20
@@ -1246,9 +1241,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 		}
 	}
=20
-	if (!rc)
-		commit_fetch_head(&fetch_head);
-
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
@@ -1268,7 +1260,6 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
 	strbuf_release(&err);
 	ref_transaction_free(transaction);
 	free(url);
-	close_fetch_head(&fetch_head);
 	return rc;
 }
=20
@@ -1309,6 +1300,7 @@ static int check_exist_and_connected(struct ref *ref_=
map)
=20
 static int fetch_and_consume_refs(struct transport *transport,
 				  struct ref *ref_map,
+				  struct fetch_head *fetch_head,
 				  struct worktree **worktrees)
 {
 	int connectivity_checked =3D 1;
@@ -1331,7 +1323,7 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
=20
 	trace2_region_enter("fetch", "consume_refs", the_repository);
 	ret =3D store_updated_refs(transport->url, transport->remote->name,
-				 connectivity_checked, ref_map, worktrees);
+				 connectivity_checked, ref_map, fetch_head, worktrees);
 	trace2_region_leave("fetch", "consume_refs", the_repository);
=20
 out:
@@ -1503,7 +1495,9 @@ static struct transport *prepare_transport(struct rem=
ote *remote, int deepen)
 	return transport;
 }
=20
-static void backfill_tags(struct transport *transport, struct ref *ref_map,
+static void backfill_tags(struct transport *transport,
+			  struct ref *ref_map,
+			  struct fetch_head *fetch_head,
 			  struct worktree **worktrees)
 {
 	int cannot_reuse;
@@ -1525,7 +1519,7 @@ static void backfill_tags(struct transport *transport=
, struct ref *ref_map,
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
-	fetch_and_consume_refs(transport, ref_map, worktrees);
+	fetch_and_consume_refs(transport, ref_map, fetch_head, worktrees);
=20
 	if (gsecondary) {
 		transport_disconnect(gsecondary);
@@ -1544,6 +1538,7 @@ static int do_fetch(struct transport *transport,
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 	int must_list_refs =3D 1;
 	struct worktree **worktrees =3D get_worktrees();
+	struct fetch_head fetch_head =3D { 0 };
=20
 	if (tags =3D=3D TAGS_DEFAULT) {
 		if (transport->remote->fetch_tags =3D=3D 2)
@@ -1601,6 +1596,10 @@ static int do_fetch(struct transport *transport,
 	if (!update_head_ok)
 		check_not_current_branch(ref_map, worktrees);
=20
+	retcode =3D open_fetch_head(&fetch_head);
+	if (retcode)
+		goto cleanup;
+
 	if (tags =3D=3D TAGS_DEFAULT && autotags)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 	if (prune) {
@@ -1619,7 +1618,8 @@ static int do_fetch(struct transport *transport,
 		if (retcode !=3D 0)
 			retcode =3D 1;
 	}
-	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
+
+	if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1633,11 +1633,13 @@ static int do_fetch(struct transport *transport,
=20
 		find_non_local_tags(remote_refs, &tags_ref_map, &tail);
 		if (tags_ref_map)
-			backfill_tags(transport, tags_ref_map, worktrees);
+			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
=20
 		free_refs(tags_ref_map);
 	}
=20
+	commit_fetch_head(&fetch_head);
+
 	if (set_upstream) {
 		struct branch *branch =3D branch_get("HEAD");
 		struct ref *rm;
@@ -1693,6 +1695,7 @@ static int do_fetch(struct transport *transport,
 	}
=20
 cleanup:
+	close_fetch_head(&fetch_head);
 	free_refs(ref_map);
 	free_worktrees(worktrees);
 	return retcode;
--=20
2.35.1


--TsJlMQ+ZwULEQ4Mg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRwkACgkQVbJhu7ck
PpRfyg/9EnsovWatutNObgtOYvGj4oJzDegswpBjmCDFQKWmc2fnqGzpOOvrm/PL
833wziTWiE2GaPOZxgfD0KmLZt4bjfOcy7wrZkO9tdMTpCXRf78slC6sEwz441P3
zae8khF4bpUbHyWcB0BNdzHwIVzxEupIwU5uAAfXn94lUdIMi8Jkklbn8Op9HEfe
hLu5BWjff5qiS1XFZkaJjrXMvbhsIQgMtqVUvV54+PnNjP88Xp1Hfx7glG1K5OHw
Ijm/+wFZtt5pVn0d2josY6lTOAaBDSw5eSwVqJz6xHX264wmZ8hbb3WL/XmQ2XcU
Ntg5T312HW6IJM+cg/x66OpG7q4wBQz77ubpPnpqNFsNNO3ALsjXkNvFZ+WF98DG
t1CkKvac2hS0+/l5sUdDNyZyUiLYm58xZUXNev1APxBLuyvN2fG1aKSEDnQ2CjsN
dYn4ECmp0AYjhfTyY+Vb2l6Ei49C0OaDYEKpEXrOMr+IHaq1Tj57pTpRdxSep8hs
FB8p/9CafQTy3kjUKQI8Wt1NBWY1sgbHJ5l7q6FEG/9lGhFskrQA7R8bR1zyg1PM
i1v2SXoCZcmQrOGWNthoBIgIjuXOGTRIZqVHxevoiRk/gVa01mUG9KvNz1SJJC4q
eUzztbQxZk25rP46bNhpoNlnwKK6FvzJRZR0HfThVa5Xmdr0xp0=
=U9eF
-----END PGP SIGNATURE-----

--TsJlMQ+ZwULEQ4Mg--
