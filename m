Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF9C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiAMGLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:34 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42065 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231387AbiAMGLe (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:34 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9D5873200E90;
        Thu, 13 Jan 2022 01:11:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jan 2022 01:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Wl1QU2ihakAb6bVq8OoyDdMWH4Q
        PDjjov+GZfVqFL1s=; b=F0XZlrul1O8YKwhR1iQayVgSuhbJqit/G3KYhFGbMhz
        JX11W045XDwCn2lT+cOyhq/k0sw4FziDAf1VO9HRx5nJx11t+qV17yQOKLRlTTAq
        6PUYf8OE8idECNMm9u6cXsP81BzEA2x0CjfqLnjDObtQg58mTU17x1+AeoIDA1C4
        igJQ6mYf79NmurQxERhQhTh6ZkR69Ff8J5WJCaiX7p748IbHVSpU9WciCfnpw7tK
        MdQ9KgmgAGkQHoi5ju1aWd/rr0QUeZ0hnEgFTkjH9158MPDMEmlR15CqrhrcbOhH
        6CDO49sO1vWvLL4uFCNfn3hOuIWDVyztTUpJeQ69D2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Wl1QU2
        ihakAb6bVq8OoyDdMWH4QPDjjov+GZfVqFL1s=; b=hmr7POkOCMjfMZVpanv9nD
        z2ADvdfi4kWgziPGKHOnNk901LzUlZXGhao5tZQyyK0iJmaJ0SkWQPg6UvOlYSpc
        HwZAS4sUgXwR4dcI5BbiW2/Uj+i9bBw7ROgYeoCKSAchLmNg/uxuJxpqtUYW1wRQ
        7tfwMUI+8n/yBzqCha87QwWql9X5I94CMns1K7o6I6DfdWL6EYOTVy0Ksk7XFXub
        JPERQYHArIL2r+UFiMHwpBT0Dc38/Lz9oA+J/txcpYXsFWgu8JNUqgPs6PgpFIL/
        amX4jL/BqP7wouiSCD2/cRSOWNP6AlutgPMtILSgWVX8yLe2xOI5fw3dsM0bq4ug
        ==
X-ME-Sender: <xms:lMLfYQ1ivDN_8USZwkxQwO6uZPjETOLzJkA16ZE56e0gkvaV0sQeGA>
    <xme:lMLfYbGJPzkKppg1VT_aJJWOAnXlzlVpVuBUjqOv9lWwh9pSwB8mS9ZCrvinGiGVK
    mkynPSr3kx9G6JH-A>
X-ME-Received: <xmr:lMLfYY7-TtqMd20YbUtowe4AaWrdPDJhs6VV2c0Hk1KiQCEHpX1XUmehGiXG5DwmtyWV5jXwRU0ohmc0lF2HJe_-y2Fcxj0NPtPb3MJuwNO6tsIZNWauA3wucQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:lMLfYZ1iIQBzKrRfAr8ZOjuKH11OGUrHMmiXsY5a8n-pud1GZ6BnbA>
    <xmx:lMLfYTHPz1fOn0tv8WfUqkggeINxduhSz4tZYVBDhkJ-17B0A1D-IA>
    <xmx:lMLfYS_asxdSMac57OA3UXr6KJFhynD_Cp4JhP7Cs7MlEoPW-9Myjg>
    <xmx:lcLfYXiIBI8xcSZe5DuM_1YauNMoKMG30flJ3QWoFla74rIbYW9QjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:31 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9769831f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:31 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:29 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 2/6] refs: allow passing flags when beginning transactions
Message-ID: <9dd172a75794729512d1868d80f54a3e962b82df.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cwzy4lPfYRrNzrKP"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Cwzy4lPfYRrNzrKP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not currently have any flags when creating reference transactions,
but we'll add one to disable execution of the reference transaction hook
in some cases.

Allow passing flags to `ref_store_transaction_begin()` to prepare for
this change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                |  8 +++++---
 refs.h                |  3 ++-
 refs/files-backend.c  | 10 +++++-----
 refs/packed-backend.c |  2 +-
 refs/refs-internal.h  |  1 +
 sequencer.c           |  2 +-
 6 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 4da4996c4d..7415864b62 100644
--- a/refs.c
+++ b/refs.c
@@ -800,7 +800,7 @@ int refs_delete_ref(struct ref_store *refs, const char =
*msg,
 	struct ref_transaction *transaction;
 	struct strbuf err =3D STRBUF_INIT;
=20
-	transaction =3D ref_store_transaction_begin(refs, &err);
+	transaction =3D ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_oid,
 				   flags, msg, &err) ||
@@ -1005,6 +1005,7 @@ int read_ref_at(struct ref_store *refs, const char *r=
efname,
 }
=20
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    unsigned int flags,
 						    struct strbuf *err)
 {
 	struct ref_transaction *tr;
@@ -1012,12 +1013,13 @@ struct ref_transaction *ref_store_transaction_begin=
(struct ref_store *refs,
=20
 	CALLOC_ARRAY(tr, 1);
 	tr->ref_store =3D refs;
+	tr->flags =3D flags;
 	return tr;
 }
=20
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
-	return ref_store_transaction_begin(get_main_ref_store(the_repository), er=
r);
+	return ref_store_transaction_begin(get_main_ref_store(the_repository), 0,=
 err);
 }
=20
 void ref_transaction_free(struct ref_transaction *transaction)
@@ -1156,7 +1158,7 @@ int refs_update_ref(struct ref_store *refs, const cha=
r *msg,
 	struct strbuf err =3D STRBUF_INIT;
 	int ret =3D 0;
=20
-	t =3D ref_store_transaction_begin(refs, &err);
+	t =3D ref_store_transaction_begin(refs, 0, &err);
 	if (!t ||
 	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
 				   &err) ||
diff --git a/refs.h b/refs.h
index 92360e55a2..31f7bf9642 100644
--- a/refs.h
+++ b/refs.h
@@ -231,7 +231,7 @@ char *repo_default_branch_name(struct repository *r, in=
t quiet);
  *         struct strbuf err =3D STRBUF_INIT;
  *         int ret =3D 0;
  *
- *         transaction =3D ref_store_transaction_begin(refs, &err);
+ *         transaction =3D ref_store_transaction_begin(refs, 0, &err);
  *         if (!transaction ||
  *             ref_transaction_update(...) ||
  *             ref_transaction_create(...) ||
@@ -573,6 +573,7 @@ enum action_on_err {
  * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    unsigned int flags,
 						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5795e54020..ecf88cee04 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1121,7 +1121,7 @@ static void prune_ref(struct files_ref_store *refs, s=
truct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
=20
-	transaction =3D ref_store_transaction_begin(&refs->base, &err);
+	transaction =3D ref_store_transaction_begin(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1192,7 +1192,7 @@ static int files_pack_refs(struct ref_store *ref_stor=
e, unsigned int flags)
 	struct strbuf err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
=20
-	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, &err);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0, &e=
rr);
 	if (!transaction)
 		return -1;
=20
@@ -1259,7 +1259,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
 		goto error;
=20
-	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, &err);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0, &e=
rr);
 	if (!transaction)
 		goto error;
=20
@@ -2773,7 +2773,7 @@ static int files_transaction_prepare(struct ref_store=
 *ref_store,
 			 */
 			if (!packed_transaction) {
 				packed_transaction =3D ref_store_transaction_begin(
-						refs->packed_ref_store, err);
+						refs->packed_ref_store, 0, err);
 				if (!packed_transaction) {
 					ret =3D TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3044,7 +3044,7 @@ static int files_initial_transaction_commit(struct re=
f_store *ref_store,
 				 &affected_refnames))
 		BUG("initial ref transaction called with existing refs");
=20
-	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_store=
, err);
+	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_store=
, 0, err);
 	if (!packed_transaction) {
 		ret =3D TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e97d67f932..cfebcd0b46 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1535,7 +1535,7 @@ static int packed_delete_refs(struct ref_store *ref_s=
tore, const char *msg,
 	 * updates into a single transaction.
 	 */
=20
-	transaction =3D ref_store_transaction_begin(ref_store, &err);
+	transaction =3D ref_store_transaction_begin(ref_store, 0, &err);
 	if (!transaction)
 		return -1;
=20
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 46a839539e..a0af63f162 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -213,6 +213,7 @@ struct ref_transaction {
 	size_t nr;
 	enum ref_transaction_state state;
 	void *backend_data;
+	unsigned int flags;
 };
=20
 /*
diff --git a/sequencer.c b/sequencer.c
index 6abd72160c..61edd39d7a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3588,7 +3588,7 @@ static int do_label(struct repository *r, const char =
*name, int len)
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
 	strbuf_addf(&msg, "rebase (label) '%.*s'", len, name);
=20
-	transaction =3D ref_store_transaction_begin(refs, &err);
+	transaction =3D ref_store_transaction_begin(refs, 0, &err);
 	if (!transaction) {
 		error("%s", err.buf);
 		ret =3D -1;
--=20
2.34.1


--Cwzy4lPfYRrNzrKP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwpEACgkQVbJhu7ck
PpReBw/+LnU3d2DmXdD6EDwjc81hwN9oa6QLqDLOGDHvA1srrGourn5+trPubIZ8
SKVpXaBDoqbsfZVKkuo41MJNosgGYMtvgpyQg8z3VR5tMPjNUHDtyRyy9DLY7D2D
8v38Yiwfyt4VDFM+XWHFFOruraNj69gJZDJ6f7ag3QKsg6i00bKDcLVwUVA1q3rK
85AjrqK+RmMMKxu+4tN97Y/8Nj4RKPwGpjBbj4aGSoFobXo//omN91Rbibax24H1
BJzzUjeyOBIlc+7vBRlnEeHvUF9eAt+Sopy9B0hTemFrdp2J+2aiMw+zh15iJh6b
mTUzHxt1Iroey+7sCB0Kst3w0YmlQ4Cok7O3Xe53AiZT4PsYiAe8TK/VN9W8LBli
weYUww5ZGlF/fGnn91lROSiQUxyv0xIZPdTKJaSGKWs//pQsDhyR0Be+okqW/5If
lm6RKJt31yTtFd8gwjiQwPsEYGlcRPBbTzJlLKqTByICRCk66sniU0lCS/wlxs3O
ugYZam+r5DaJ+HIb6op2pHFx/1rZlVvGh7lI0iy+JZomnydzck6BGqYTzGsuFVGe
8O1P7WCxXBdmYyD6Qwzf3u3wldx4YlH8eEBTwscKpEFw52DNViUG1lNMlSy6DSFv
kEwiCKYsoXAwXkyGvAf1i/tUNtR5xG3NtT7bE+XH6yVTRfiJMjg=
=V4Na
-----END PGP SIGNATURE-----

--Cwzy4lPfYRrNzrKP--
