Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831B5C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiBKHrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:47:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347800AbiBKHq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:59 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F3391
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:46:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0C80D3200F9C
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Feb 2022 02:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=EQ+h+gq3to00bmLvIrqCks1dTpPTIaRTpqNxJt
        rRZcg=; b=q9psSltl5oIt4OFPOSakmU+lNKluLPk65eqit+brOStvLwJ2nPEBAh
        tmotu5cf/FsvOne8zOLX264NiR3ySb8156TB0GYoe4KgxQ8bds/jeO2l5EJeCWWW
        XgMQ3mkUSViAC8H1xCC00vMqjBBMyWW2R+Z2tvYpc0oChRu2ElgqgT16TmXM15Xr
        hF+Y1lOei9aK7KxdaiwtXQUc4B0sTbT3sO+MEbyqlvRF/oE0CIZoWtIJTrQqx7ER
        414SWW392EUeH4kbu4Hed7DnszuxZ3RxnrFyTYP3gZ3HgXDonIN2VFyzuZ85ZbLK
        tUpLiAl5crO6/R9ZpaSmSPZetKKThGjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EQ+h+gq3to00bmLvI
        rqCks1dTpPTIaRTpqNxJtrRZcg=; b=cqUd2ANslNkIu5FtcRdAm3ej2rQTx5Qm3
        Fe5QyM70LNuapvtEEUDY/0Jp5beb7XeTG1Q4hfBeHVGYE2PKXlEM/7ODebvl1iZJ
        7EHX5Y3RslFUz5s/Fos8QTJS6bJ+U/hNnJG3yLsn4kdQvmAKHS2EPNozsrwco23j
        djN7l8MZgjpNYPNimzy7K/WjpNcYEl89ZbkNfGW8jsTSCJrbb2hNOcAMbHDqgDMx
        vpsq/jy2/PZFBA155jc0HZ94nyZV7O7MIkx+U5lgaIRO5Pf9o7+dLnIuxHqHJJri
        twyw7IlXHOLOoMRIdRtlTctyBXpcvqgiCsRcvrL3EoYR6ipVDztqg==
X-ME-Sender: <xms:cRQGYrgRcrSUEIiOrxgfsSCibvUA3UzglKWZ8ZJ91XIhW4li0BsLsg>
    <xme:cRQGYoD3En6Gq2In-r-A0HcgnwMAzvHc1lkz4hOs2rXenHWuLpXV8i9GiRnrskz5h
    w1HEqn1hs7hNIsgvw>
X-ME-Received: <xmr:cRQGYrG50Nm6nOhHJB7D_h0qa1lx8cvmIhDkhNLNgK9ZQHhkJr3VQTm8dwrQak1t9HZe9nBHq1pVynVHm4QwUNzr-WkUOY2W50_2p04fnIFX7d4NfHDRJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cRQGYoSCwzYqUCkt_H4Y9gSJa--y7K8N-wWy0w7NpICPdOn9q-ZGYQ>
    <xmx:cRQGYozudP4TqhqIVKiJew4n3Bpk_6djS00f0ckYKUa2lxrx2LWw0A>
    <xmx:cRQGYu71ETjlNS55AN-6NUHNt8-WkK6nMdJnIOuBDeSz2Sm9ZMPxrw>
    <xmx:cRQGYluabr18xgQtVL8AFci1OFQSGx70SHr_qeo8N_F1tOTyM93F9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:56 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 72e7ab0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:46:56 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:46:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] fetch: control lifecycle of FETCH_HEAD in a single place
Message-ID: <4059d5034bd9137ffca4929ed5bd8b7ce75ea09c.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlb7SfDc39I5t8vB"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xlb7SfDc39I5t8vB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are two different locations where we're appending to FETCH_HEAD:
first when storing updated references, and second when backfilling tags.
Both times we open the file, append to it and then commit it into place,
which is essentially duplicate work.

Improve the lifecycle of updating FETCH_HEAD by opening and committing
it once in `do_fetch()`, where we pass the structure down to code which
wants to append to it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9c7e4f12cd..627847e2f8 100644
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
@@ -1617,7 +1616,8 @@ static int do_fetch(struct transport *transport,
 				   transport->url);
 		}
 	}
-	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
+
+	if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktrees)) {
 		retcode =3D 1;
 		goto cleanup;
 	}
@@ -1629,11 +1629,13 @@ static int do_fetch(struct transport *transport,
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
@@ -1689,6 +1691,7 @@ static int do_fetch(struct transport *transport,
 	}
=20
 cleanup:
+	close_fetch_head(&fetch_head);
 	free_refs(ref_map);
 	free_worktrees(worktrees);
 	return retcode;
--=20
2.35.1


--xlb7SfDc39I5t8vB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFG4ACgkQVbJhu7ck
PpR3Bg/+MmjhFLH0kfPWlEyDKaTwp9PfRulVjjAqZetRbrG9tonS7NzsCre2d0kq
1OAA+U6Bh1rWseUmQ46jalXaTQmnlTsTq+a3ZUaQyBUZpQU0LpZCGMe3zpjquQtn
njczksL/Bupj+lNjSKV8Wo2tD/VplWYi1T7h/CDHNwWRv5uj2Iio2VatEwYSaY5l
tQ4gWT2A2ojmnZ9atpYrL25rx7wZmG07iHzoqigDH+C5AtuViz6VPrwKkOW0QuSg
/sK6vseSS4/p9fyFbtSoEdpxWc1JtTcodURzRN1ZM4WD4ckYh3AiyJ1p6/b5iqZM
UzAJD5G4mrvWM0/FU+7vYevIKJNBI/SWRqhiXDS200dYG1UH4bLMKZlE1KbidpFU
+iXrQx+6P8qF8pRTtTedWEhfgo551yf2z5GJhP0AcmuArnu3Uj/jQ1fSnxss0e6x
XXh7BapWqzeNQEHjZBaQhbN44OlwRCz7zMnFlncLQyMuto+2ZcrkqywLurXWbXAZ
4NG/ZKZlqhGc2lisunhCtvd1n7MpfxjHCfPfGVT4rhuR9/yIAWEkGujds7ZIxUCV
fdoe8xJ/g6UorzjVlNyqCqxmIId3nzOOn7O38nVpuECO7KBV1kvpENe6PUI5fvnW
zfmy20h8WSJxm/en+EgzuZRenQeBMoZMg9Sg57aJLhA2Jkn9D54=
=yQA5
-----END PGP SIGNATURE-----

--xlb7SfDc39I5t8vB--
