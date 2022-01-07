Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C9FC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiAGLzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:55:43 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38807 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347305AbiAGLzm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 307655C011B;
        Fri,  7 Jan 2022 06:55:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jan 2022 06:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=k8U+D3SfF8xYySMJiSl/oJ4vS7q
        +pKrxmDJUO4hgZAE=; b=LFDMoTKomLZyuYK5K11+J99IfvvWrevHecciYQzwXVf
        E0mw7WWyp6XyS+U/BjdVWJqsQW+h34o7O8VeunlsUwEQ2YMixFgBOw0/4HOHrV9a
        NIwrl0f31dLhedOTipJhVbYCjV4KHwhp/SokDdvpwRXJQKOf2B08UBZxVZXho/ry
        4fH/zxD6wylHyYHQouvyS9DR3MYUSiAeyuJ2n5yNJKCCFr8uYCokhcb+dsg05q7N
        hWp25XPKWw23T20VNq3SdEqjAKA8jxWlwzMaJ1C7GZR2ogjILEHdw+F00WjdGrFC
        IUwlYV4jy+/QKG9GMpN/i+CVVCv9eQ7OUWjmUiUtndA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=k8U+D3
        SfF8xYySMJiSl/oJ4vS7q+pKrxmDJUO4hgZAE=; b=E6wkvX7HglEpPehu/fq6iI
        24puf7deh/nMefTIiz0/P0xisMOKxzevYeFa22c9d+iea03mXC++gLtY0wrQTqgX
        uM1ckOUsuO/wHCnfvsy5cgCkgt8sA7aD4bBySTvAztEkPo6PTvJOz0n0l0i0+LAj
        KEcFsWRmT3VQhYuiTPRv7AHapHQPY+KFrBKT+GtrEtMs6RvXoJnUZhVnIU5Lg9k8
        LWHd6tSdf5P2g/LefKzAdzXI5mgwTk1S5dhQpoR2Lh6xInnibFb1GrWMDTZpYZdA
        ZsqyU7CH3NnNv/fNRYgpBYKwlklhcUcku8ez0WMx1SAN3z8AJJpy6ZPDa0IFERxQ
        ==
X-ME-Sender: <xms:PirYYcs25Xyy9NeBtYIh13lGkehTYSnBcvUj2J8zfnVNrMllOF47ng>
    <xme:PirYYZfS7PGic_P43WInC0NNtWdPUUWi21sjVp7oINHrzercPoa0-Ys1eaSjC4tNT
    HU6ZxDFhYMZ7rmfag>
X-ME-Received: <xmr:PirYYXysndN8LCUASj9WqAREcyWIagMBU_qNt2GtdZxDcntrjWyXdW0nzERmEJzEZykH4ddYR0wG-kH-W11XH37QD123qEm0XBNFlHFzpJsnEuVRNzyDNmpb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:PirYYfNETZLlRutHeiQ9S7P3S5tAwfpFeIxR7El16CjUoeQg6NMaaw>
    <xmx:PirYYc9xID3UyIoU60wNQ8_1WVZEQjWRDJLTapIU7swWt_i5EqHplA>
    <xmx:PirYYXULyxpDLozHQ120JiIJaCxryiBPDT_TDysVLxpklm7y3GlOFQ>
    <xmx:PirYYeJJlMhHQrtpgd7seTwmaU43KkFFGolWgdfw1BTHsC0VzFt2Ig>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0c15441c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:40 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:17 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 2/6] refs: allow passing flags when beginning transactions
Message-ID: <629be01d50be53c51273286febb9d4a890c968a5.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VjtT/mvHHVvyqjlC"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--VjtT/mvHHVvyqjlC
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


--VjtT/mvHHVvyqjlC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKiQACgkQVbJhu7ck
PpSSjA//Qu2/8XlRFetbSZnh/nLNPz63PN/GnPmLEZqxQjLp18K8wGwV3kNp51vq
JFAr0phsOElDK+iqCtUwKlwKx5vKpjDmVv0azhVt/uSkEntKi3dz7imtW4JSeYeX
YSMvFkXXLkWIMd6Izp1QHPcc83s5dkBFVWcDjosYUkCbqW7szbILKZoUopkRyaIF
SwZB80E4WEExo5Mp9asWGPKEsy5J4f7Mm2wqFHjxkWDkq3bdvIHbi7gQGpCyuaM+
nD6uqma2usRS1kIChcEgKrA3iN1rgVnhBePBYK9ZFGA97LfdL/MTCz2OcQulMzoQ
eZfdkTsgn+hQy2WvTyzZtFTNqx9qryuM7SWGodehF4Qmr5dosEIyz/o1iaj8J83m
tFi6oKnQZyA4oGsLcZX4lZEwv7uqEYE8ab1OxcVXhdoY64E8zKyvgSlHHwsYskc8
9cUITjutCC0Pj6zwT1etENUaiLnA/PK/jnei8UatIB/Hnk7OQmkrhL02wEuljfJy
vArsaH5sNt9JCCiJqQ+TCnlaelJP4CUExajhyvr3EvGYE9aw3vJsj5/CMkUIx9i7
/82bwRc4x6SPYp14UNA7p1m3xHOCGnGzfs3zvt9AH1qDENx2TPNUl8ZZqbgo7KLg
OPQO++gQcIyayBuI1T4WqS6Gj7Z0HrYoZjSYlLcBNj+YqeQeIvs=
=djt8
-----END PGP SIGNATURE-----

--VjtT/mvHHVvyqjlC--
