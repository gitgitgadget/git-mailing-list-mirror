Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC92C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiAQIMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55251 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbiAQIMe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:34 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5202F5C012F;
        Mon, 17 Jan 2022 03:12:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 03:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=JOcWTm0r7D/whALFjlcpQVap6tG
        /EDNmROIwTOlhCFY=; b=O9hVULzvxqt/xFKSFIvKGYRQDZiACzqGg4CqNAieMfm
        EbUsU8qG0ENlDOWBUl55Wk8uPfoqjoOevKgxvGKn39R7MAy6czChFpCba+QfCsP5
        JxE+21eeC1UOjmY+WM6r2mnTIS7d9Tg66Dmc7rbZtSyfp+P7aoGokXNC9XJ0uT/6
        I/foHTyTEIf2PwoYHP8iaTrqypkjVcBIUQWpM2ayhsfBLrDq3uk4cnk+NcScHr8p
        2876hXzscIykSaH4PUBNRFWh35k6VxfQdjmhmb1icCwjBHseGg+yGEYdSJitiElU
        /JYwl4rgIwoHfjPP/YQs05vlX0XlX3MFvlA6R8tnb9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JOcWTm
        0r7D/whALFjlcpQVap6tG/EDNmROIwTOlhCFY=; b=l8S+YR2V5XRkZJFdmLtsAM
        CKjmorZ5s4jJ/qd51bQVaWZvyuTsd5fJ0NxHrNtVIn9Nii1vgesGm7eDQchdnk3/
        sDckn7MPczZxZZS9tgIMma7zK7TNjBfmVAsHs0/GpUGwoCGmgxoTajVHTfpmcv3D
        2IH90CzWNRnfwTgaBytokk468IJPfopci2WsE+Kr7rQCBTSXnR2ChgGdKD6T/Dqn
        p8xAMULsaSfvhwmVXHTsaVw2cdvuGASztHAkWt7BA0UvFkyIVX79/uUbJsypRw/R
        DyKyANGqeu9WVFdpTmQE+rT2edMoh852qz9jKvcn7x51QbsGFlemo/kqdVndRJOA
        ==
X-ME-Sender: <xms:8iTlYZu_1qG3BLG3ZqG30Q1NLRlVQZlf1bda7_ignDQCu-mqsQ7NjQ>
    <xme:8iTlYSfzbi37AshZ1MUMPHHEzJFdHOKHkAn4POMchjVchFlFC3x1DAtYlenh6uKc5
    cZvZVpS_VKsNqb1Cw>
X-ME-Received: <xmr:8iTlYczpBvglPEFKc8ZAyE5gi35C4luPD7DI18ED-s4IeW2DG64CDbtEcmQOinyZNFAoVdicl9HhgLwtHccJ7bMNXjCL4ewDpeH6bRwJI1-b2xtEnsleuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:8iTlYQNA8oVcWARvFCnVvODjFzcaAppcsJlyCRRuNv7d8lm4VtbUZQ>
    <xmx:8iTlYZ-3r4aRMCTYPcBP5EiZUS6WwlJnSzvvH1_DAl9TBFtzwmiMTQ>
    <xmx:8iTlYQWlROH_IrtvYxLwQR6wc8N8Se9Y4hLvG5JNQo5pEaZT0WbQZw>
    <xmx:8iTlYVbv6rO58oDgRKT3Lj6oUQpFGV7Hccb7ye3UhDNHQeiwAuxFEQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 71306157 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:32 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 1/6] refs: extract packed_refs_delete_refs() to allow
 control of transaction
Message-ID: <14775046e1fb73a65b2198e72e72428b16d3e65c.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TE0qwjcsAEfKPP3e"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TE0qwjcsAEfKPP3e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When deleting loose refs, then we also have to delete the refs in the
packed backend. This is done by calling `refs_delete_refs()`, which
then uses the packed-backend's logic to delete refs. This doesn't allow
us to exercise any control over the reference transaction which is being
created in the packed backend, which is required in a subsequent commit.

Extract a new function `packed_refs_delete_refs()`, which hosts most of
the logic to delete refs except for creating the transaction itself.
Like this, we can easily create the transaction in the files backend
and thus exert more control over it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c  | 13 ++++++++++---
 refs/packed-backend.c | 26 ++++++++++++++++++++------
 refs/packed-backend.h |  7 +++++++
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 90b671025a..459f18dbc1 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1249,6 +1249,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct ref_transaction *transaction =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
 	int i, result =3D 0;
=20
@@ -1258,10 +1259,14 @@ static int files_delete_refs(struct ref_store *ref_=
store, const char *msg,
 	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
 		goto error;
=20
-	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
-		packed_refs_unlock(refs->packed_ref_store);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, &err);
+	if (!transaction)
+		goto error;
+
+	result =3D packed_refs_delete_refs(refs->packed_ref_store,
+					 transaction, msg, refnames, flags);
+	if (result)
 		goto error;
-	}
=20
 	packed_refs_unlock(refs->packed_ref_store);
=20
@@ -1272,6 +1277,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 			result |=3D error(_("could not remove reference %s"), refname);
 	}
=20
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return result;
=20
@@ -1288,6 +1294,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 	else
 		error(_("could not delete references: %s"), err.buf);
=20
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 67152c664e..c964dd1617 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1522,15 +1522,10 @@ static int packed_initial_transaction_commit(struct=
 ref_store *ref_store,
 static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
 			     struct string_list *refnames, unsigned int flags)
 {
-	struct packed_ref_store *refs =3D
-		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
 	struct strbuf err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
-	struct string_list_item *item;
 	int ret;
=20
-	(void)refs; /* We need the check above, but don't use the variable */
-
 	if (!refnames->nr)
 		return 0;
=20
@@ -1544,6 +1539,26 @@ static int packed_delete_refs(struct ref_store *ref_=
store, const char *msg,
 	if (!transaction)
 		return -1;
=20
+	ret =3D packed_refs_delete_refs(ref_store, transaction,
+				      msg, refnames, flags);
+
+	ref_transaction_free(transaction);
+	return ret;
+}
+
+int packed_refs_delete_refs(struct ref_store *ref_store,
+			    struct ref_transaction *transaction,
+			    const char *msg,
+			    struct string_list *refnames,
+			    unsigned int flags)
+{
+	struct strbuf err =3D STRBUF_INIT;
+	struct string_list_item *item;
+	int ret;
+
+	/* Assert that the ref store refers to a packed backend. */
+	packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+
 	for_each_string_list_item(item, refnames) {
 		if (ref_transaction_delete(transaction, item->string, NULL,
 					   flags, msg, &err)) {
@@ -1563,7 +1578,6 @@ static int packed_delete_refs(struct ref_store *ref_s=
tore, const char *msg,
 			error(_("could not delete references: %s"), err.buf);
 	}
=20
-	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return ret;
 }
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index f61a73ec25..a2cca5d9a3 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -3,6 +3,7 @@
=20
 struct repository;
 struct ref_transaction;
+struct string_list;
=20
 /*
  * Support for storing references in a `packed-refs` file.
@@ -27,6 +28,12 @@ int packed_refs_lock(struct ref_store *ref_store, int fl=
ags, struct strbuf *err)
 void packed_refs_unlock(struct ref_store *ref_store);
 int packed_refs_is_locked(struct ref_store *ref_store);
=20
+int packed_refs_delete_refs(struct ref_store *ref_store,
+			    struct ref_transaction *transaction,
+			    const char *msg,
+			    struct string_list *refnames,
+			    unsigned int flags);
+
 /*
  * Return true if `transaction` really needs to be carried out against
  * the specified packed_ref_store, or false if it can be skipped
--=20
2.34.1


--TE0qwjcsAEfKPP3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJO4ACgkQVbJhu7ck
PpSDwg/+KRK0woYfzUyADedQVyCXIucz9gExRhzsfg/ymJRVdzputHQWT7JJao+G
iHzGbPF+8cw7TRuyACGJXgaMb0Pf00M/KjdgadFyMlbye7xAraZkFclNEIw7hAhv
cU1e2f1WuTMUTDsJWCe88eki9/1A+3jLKScxW6Pppi1Qsw0wxaq4IiIAyfjCppKW
QSXio00BPUW56gRvj7dCkfoFm3SDA1N8m4/kvMznQoZR/39ashy2KbjWYA25dpWr
E+oQ5GAO5fhGa66Z52kijMHSqnOLmRrHn3RgZ45vy1E29g5tZV/w9gGN2u87btgb
k5cssEcVkI83A4Ex7Q3/vWaX+EGRUs1zRgRP7iDkLfPDzMm0RI4kI2A+yr+jFZWD
W7S0knH3bOAtxkWzOohli4Yg6BkgdX9RwSvtALeTGBErRwV+33dDWhbk/hxH62jZ
mVcdT+qMqFC5QPv8rVLa6lXHoyz1NXlIQ31nqGzXL3OeLpUhNT2klj1/hPn685kc
pIojQIA48mGjK00ssV1QfF9M6+rvzBAqEvhraFgc/YSMSfGMsdiykNWkZNpccMHV
+gE1CnnLlHpDdxQaLAmgKorLfzLScbxc+m3YOq9ve8fRfoPSHnJ8RcECoUX640bS
3ji+edVNdeRIXLochJ2TX4xV3WEPNUXsIOc+5Lv2Jv8VdowvEQw=
=XFkO
-----END PGP SIGNATURE-----

--TE0qwjcsAEfKPP3e--
