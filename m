Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49210C433FE
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiAGLzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:55:39 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49265 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347281AbiAGLzi (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 08A0E5C01E6;
        Fri,  7 Jan 2022 06:55:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Jan 2022 06:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+WmQbF4QqrjzToRFOnO1Q3XdA77
        UKEfZydhn4DhF+0Q=; b=YKQM3bCS5bzLC2tQR6g3/NGrks/WuzSAbykApORTHXl
        W7PjktbTQdqf8AyV5k7XVbJUEDx93fy4m0PyG55nheHMyDXTDb75MfrKiMYzowRz
        fqIZ4vzuTcpxmpYRd2O9yP/jqNdiXXfArM2PDRR1eX4hCGhfKi/9L1CuHLgoPK0N
        ubGW90tKcZObyQpqZNf4si5b/eJ4PJKNi9bwlxx202Lge+UiO/kZGC0I7wOYEM43
        2Fcu4D4PrQTGXoklSPcaVJIl/Dz48r3gczhC/T+4enNYBSstHe/JQv+qVGu5vDAN
        YsQU2tmlL9na7+So1N1tufv1cg9H3Kd0oHrtfkf9sEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+WmQbF
        4QqrjzToRFOnO1Q3XdA77UKEfZydhn4DhF+0Q=; b=DbIVIw0Y2tsVM/X+KdbOHA
        vsxbN5Oz9MVKUzmIvTounC8vo5poECryfk34pG2qDcDaco8U525HGto/GfzWB6SI
        9Xu6xFLM5qu3b8UCv4WfT/ab6MWbOOC/q5WpJ89S5j6kxpBS6jFJWX8y3N5wPAPE
        uHqeZ/X1UI1GIx/TvLeWeIsgl5OBMhTy2vnU/ThwSNi6MZfJ0DnAO9TXy0Zu76P+
        6IJZfrAvkg43xoAAzR31pQUXL70CDL3htk/NnV9yZI8/25qGl+T4PsW8uA4BPfLm
        7y7fT5G91bgBUoUYz2q0VtFen7qaN7FaFPVGPhL75iUWP6wHTT0XQopYw103YzSA
        ==
X-ME-Sender: <xms:OSrYYSDtTxg7LuuW48WBJlbOiiJxM09fl0Ut0v9h1uJ732DuJJZcZQ>
    <xme:OSrYYcjSiMoiwkd-k_OZ-ewavSiSC3CZXfoBagpGqzmUUE5McHB0feZL0UCSK-ys5
    JGjRQ1LRrLFMcV31g>
X-ME-Received: <xmr:OSrYYVnHYeFrT9_VMSnBcSPMeRp3uXo6Bz4_EHBPNIOckqLWVP4ay-ALWdcuKaIy6lKXu5nrnm5bNF5ZfWhOXPS56Tako2EG9onaM2Yj6-P0oDIApd8gujP5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:OSrYYQxDqwjZOIsXVhQpeduQ2jz3VLjj4f9M0LKDmjqXz9Tm_qN4Tw>
    <xmx:OSrYYXQYfAJ4uqsHm-bpNFrdvr7vuJjNsOLL7R3ZAlXcrD1lNfhwbw>
    <xmx:OSrYYbY9pTApjmM4KrlpRa2yvLhBQtcFrGFxcKq-BbkXaMIIbgFwXg>
    <xmx:OirYYSdAvrahQ-pNy1PiLcjx4BUmztTBqw5Ux2zNlcwL4MkotehvXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 720946b5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:36 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 1/6] refs: open-code deletion of packed refs
Message-ID: <0739f085b266e65b423ccc14f70cc00c88744459.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TDNBHitpRyhzUpBy"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TDNBHitpRyhzUpBy
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
Like this, we can easily create the transactionion in the files backend
and thus exert more control over it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c  | 12 +++++++++---
 refs/packed-backend.c | 28 +++++++++++++++++++++-------
 refs/packed-backend.h |  6 ++++++
 3 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 90b671025a..5795e54020 100644
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
@@ -1288,6 +1293,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 	else
 		error(_("could not delete references: %s"), err.buf);
=20
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 67152c664e..e97d67f932 100644
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
@@ -1544,6 +1539,27 @@ static int packed_delete_refs(struct ref_store *ref_=
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
+	struct packed_ref_store *refs =3D
+		packed_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct strbuf err =3D STRBUF_INIT;
+	struct string_list_item *item;
+	int ret;
+
+	(void)(refs); /* We need the check above, but don't use the variable */
+
 	for_each_string_list_item(item, refnames) {
 		if (ref_transaction_delete(transaction, item->string, NULL,
 					   flags, msg, &err)) {
@@ -1554,7 +1570,6 @@ static int packed_delete_refs(struct ref_store *ref_s=
tore, const char *msg,
 	}
=20
 	ret =3D ref_transaction_commit(transaction, &err);
-
 	if (ret) {
 		if (refnames->nr =3D=3D 1)
 			error(_("could not delete reference %s: %s"),
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
index f61a73ec25..5e0dd7d08e 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -27,6 +27,12 @@ int packed_refs_lock(struct ref_store *ref_store, int fl=
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


--TDNBHitpRyhzUpBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKiAACgkQVbJhu7ck
PpQulQ/6AhC1gTBXSVrB0oTQiBAaw9CynM0vrPB12natzt4XRDQhjVmcZQ+W243E
J/aOCaKcDO/B443THAQ6MNpHSpARmBJMq9cDcixJbqNI9LCPDR1xWTwgbhEvbYqF
dFyZSehVvTtt8ozBkO/yEJGjC83bq5/eiylP+Zow1Qy1mshIQ6M1zBOmwAwroUva
mvv2rhzSdwo9gUVoRjmKTy41xUvBeSyoaqdcOqzDojbZ4Uj8hD2nrR3u/JUKrqao
pjZ3RWGlstik+U6FvF0ZoNkQQh8FzO3Ho+vvWmG++pK+C4JURAw8QXu7cPstw9hM
dVj2692QucF/QUjQTz3hjBaaWExNn4YYk0DD99AXCicesYO0YI5oMdfk9uzIQmTq
oNDovXzr2/wXgzC1pV0VYQl4+lLRjn0mD7Bmxr5Ya/iEs1skJZAcanEXKloCegZL
s1yestX8BUTs8nYZTFS061tJ0N2EKhf/hQS73mbWq7VzZ96ee+WwKpUBVGuL+pTd
8YbEs5NicX0t1aUz5DExRpumRxEARgjPwASL8QWeAX3jfS2rIiQ3vY42yXnN/lPf
tDo7XvMHJk3Bj6TDLuOwTkTNtLPdvVPlaP7MQGupdy5jru7XZashPU5+ucg/oEUQ
i1M46ungoj9F35vSiwQuzQqBG+azZCUlKzX7PtddPY/twoi4pr4=
=Xsxu
-----END PGP SIGNATURE-----

--TDNBHitpRyhzUpBy--
