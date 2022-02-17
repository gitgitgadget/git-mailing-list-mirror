Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E480C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiBQNEp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:04:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbiBQNEm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:42 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF462AA3B9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:28 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7B7EA32009C3;
        Thu, 17 Feb 2022 08:04:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 17 Feb 2022 08:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=r8qcQX699VAEksUUmt0wxPRM5rf1BTkJqer3Vz
        aV/Xk=; b=UsJ5JENNRqB3oThvcPecZ4uYvoKU3w6cwwB08wCjmk/6w2AbDTbuXO
        H3LqCgJXdlsAb2QFhhHy9ifH53Ked2quCH71tJ3eMGRzomp5Rv0PRxabOeWtx8fB
        7/WVvtyHwgMGFLfI+0N+j0fAgFPbe4H3g+QrGQUpg+sqHfXWFrvqIKpgaNQsY1Lc
        8srV0bHZdmpa7MrjdmeZtVkMmt3Ey7HBaBS8/cmblby5gV0F/RkNK7pCPg9WQdWv
        xTpn3mDagtQDMR8cRLbh/PDrITGyVAFuDmyYtRHZzboZ+/mm40aaczMbVvm6LR2F
        xqGBeS8RV+azK0/B20bPXOy1JQtVrE9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=r8qcQX699VAEksUUm
        t0wxPRM5rf1BTkJqer3VzaV/Xk=; b=A/l3oYNZQBkx4WqvMlJs9cPAnzNDctAOe
        ZgVJiB0uILXTL2P7M2mgX5xM4YgYasBqNxW+OK5L2rZrK9+y/2ift/rSOhjO3wad
        AE1QHJMikOz7XcRIkgyhVEVHat/vCf+ic3cvSvxvH/BKD+6dcurLE4/qe32HhqeA
        ENAc/D6C04yx6VsjaIUhn1afQB2IOhFjOgFi6PZ+MSJlmUuU43aExVDVuXIW/KKl
        1lFmHaLHOoJW+JbcHQo18fg2lnhXC3jC/unJKhXuBZn6vXjEy1tAnyJRy0DS7LLL
        vzfYQEkdQ39FV1+fRLZn6Ytvb4Iu/3BDUeMMGbSiS1qXIsYU2cwFw==
X-ME-Sender: <xms:2kcOYq9wybmqGBdEkKewU3vYUmEFRj3S1WdhFmpPx4I_QOtMLSF-hA>
    <xme:2kcOYqtQTAHdMAu-BONGemD9IyrSe_KMP02SQh48h56qhc9i4BMJCpRfD2JsE-U3j
    pMMhNMg768T6HCTpg>
X-ME-Received: <xmr:2kcOYgBT_LxUZKs9DkNyO5lprRZj4xsPuC5fxmZjfVZoiwbG4VuR4YWcmHf8SC2yf6gqO3G22W8Ri7y7nOlw1Uql-r-pMNQ6THa1dPF9I7X5Xym8fQ8m_PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:2kcOYifD5PIIo6JXOpdoQ0n_3BlEGTAzknXdNsQpWSTvi7JV6Cu0tg>
    <xmx:2kcOYvPl8-giSb3_HHov_EXIVzsXXyk8xI9QRFF6KUkvmoWoAJt0kA>
    <xmx:2kcOYsnWW4fnyP8xHFS3Tq9w30i8Ilz1I7ia-tqPkhL_sg27H-iRcw>
    <xmx:20cOYoaeLGmLjAU6cRtLnon1SCJOte6F1-AwGqYiPycDz9xLvZRxcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2d9b6163 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:25 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:24 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 3/7] fetch: control lifecycle of FETCH_HEAD in a single
 place
Message-ID: <0b9d04622d095f97246ae2603e2cb5312a68def3.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FRLQ+f+2NpPuVYo0"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FRLQ+f+2NpPuVYo0
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


--FRLQ+f+2NpPuVYo0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR9cACgkQVbJhu7ck
PpTIrRAAoBrxR5Y7SoJ5fkLfs1z+5DF1SvxWt2HZYstDKjoCQ+ZdAWLUKXQU34SM
J2Mqo1s2n6CNljK1rewpScELfejgKkqBHKs6m0IuzmAyq73ofdh2mhkbVOinTtZ1
2dr1TOEwVwMCZCqGIAAobYTAG2hNolTmNT28DQxARwVb5dtGJ/OqszgimkrorlXw
P+4dcmfpygN1m1pgLtluZPCLlasrINGb10itciAHl+9vxzoIqTp0QzWjrwwy1wNv
X1eyp/UjJVqs9sDRoxBri5Y+Re80kXz8C1dWnPTtOuc0avcCkBmnw2ld6zE7AhAu
jhksuXZvUGc7MbzOw6BeSuSPcab3NUztoYqZ/ydqV6xvLhtpSe1ntoCfHdaTIEtK
kmRLta0QMmnQf9MJ/zlN0cQlENPgb5xxI34EbkRZofVijq3I3XSRNd2BMv+JfAD+
UeCBBI7E51lDF2xtaUsdVu1KCv/3/jvuFQzkslJxsgxguKUv2u0BEPStBa7ozxJm
iNqjcLbOiCtqladYvSSejSn0QZEhsd4dqBbddhr0Oru+dEHMjjqL9okF3PDdEXkI
5f9DNxiasLTFDgBuApam9Ep+D8lJqCxB8aSgW0opIwlQmU8RGBuVvOPjq/pfh1d7
LSCCk6IdtjqfCA9pZ8bPuVKnDl6ve1EWUsW9n73qNz8fq7/OkVI=
=yb43
-----END PGP SIGNATURE-----

--FRLQ+f+2NpPuVYo0--
