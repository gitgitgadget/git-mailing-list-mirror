Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2C0C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhLGLAK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:38513 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhLGLAI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:08 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D9685C007D;
        Tue,  7 Dec 2021 05:56:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 Dec 2021 05:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=p27TI6q/J8UTCjCcVJFgyTbdw1g
        RjdzhXN0sOWIFGnk=; b=iGWxrcjlW2Cvz1M7/G9HSezM2ZOpZpojyvvVaxXtmK2
        t8eg4Lo+A9umNX7yt+XjaeYP1JFpxSivsmmIXZaDus3z2DGkzYIlvfGwuUrMPjPT
        JdsKMHy45oK1gWL7Pe3x55ri8TsBJA/bFDmcTH0IR/EwxFqsILTlfOBqiBDKzu0h
        fRVIAhY2MYQnWTmUTcC7uDfE1VsTDpgsAsYMyiVRd/RcA4Q0brrKfNFLPtOTDyBn
        oiOQL6HkwoOiat3AIy6jhaf7EWyFXri359Y5dTbsZ5FlI8pTZSgCSodcpVUz0JuE
        VKCaxn9sbuZKCewLZG9FEKwp+K1do/0CfMZIpeS13+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p27TI6
        q/J8UTCjCcVJFgyTbdw1gRjdzhXN0sOWIFGnk=; b=KyRJlNA6Y2gGfi/MXmITFi
        ZdGLcg0+C1gb7V6GjaUxZjkhHL6AkLKJMi/kCAxv5em3feKH3dpbfAfny42piZoW
        svpqKgwccoGWe/J3DWYq0rcKDyXCnJG3PIA53z5eieFizLSOnRadO+Yeo67nasWZ
        1XptzTD63hMn00swl6IPdPqDlpfkHSpWvdvVzykeLTJuHUtPk25gNRFYTWFQRK4u
        2iT8MDLwBRQOO7VT5DlIR83y09T1hKDq+OpD+sTTS7gjpMNnBeOgUG2mHR5zMMjW
        VZ723GHMU2mwSK06roY/2/uXCCaSjwZncB1Y4qYN3sFyR+ImRh/fXNBAceUj2SGA
        ==
X-ME-Sender: <xms:5T2vYe50ijWuWjGdLXsA5H8OzI3pXQCXg0wnCHz23QArmxjuugffJg>
    <xme:5T2vYX65X6gx6sWbDsSYNyhMaQb6uzK71gKZHYnj0XOYRjN6s-fFw2Q7I_kV7el59
    a4kHWcR9o0rRqCkpg>
X-ME-Received: <xmr:5T2vYdeG8eySvC0tVYvrOAzyunrg1QW68FB8N1HKUs9SZKVXNASSbkGN0LU2N0MxvrYCCqWSu8ohi5fUo4acz8XWYNJ6GGStj4jwN0cSYzMRaRz_1JnMogR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:5T2vYbL_EudKIYmFP1Csp638xbloGwKbcUUBIStdkVpFRL-SYixpgQ>
    <xmx:5T2vYSKPLMUT9xT1VyKXd6HaL2rZsOJgvA6NfLoheshyPSNzRVdLqQ>
    <xmx:5T2vYcwZ0OxkM4bp7X9teogdOw8pu44qfO9OB802-Nrh2LL4-p6E6Q>
    <xmx:5j2vYZWeWaIPVq6ywoPKycwmLBsNbAVP9TNBGfiWrJn1hdX9Bc2fhA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:36 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3f932028 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:15 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:55:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 1/6] refs: open-code deletion of packed refs
Message-ID: <282c104b9ddbfa7579bd18fba0e64c6b6cc566b7.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oofxajmLqvF0xRTV"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oofxajmLqvF0xRTV
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
index 4b14f30d48..453adc38ea 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1250,6 +1250,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 {
 	struct files_ref_store *refs =3D
 		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
+	struct ref_transaction *transaction =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
 	int i, result =3D 0;
=20
@@ -1259,10 +1260,14 @@ static int files_delete_refs(struct ref_store *ref_=
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
@@ -1289,6 +1294,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 	else
 		error(_("could not delete references: %s"), err.buf);
=20
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return -1;
 }
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 9da932a540..cb19b5291e 100644
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


--oofxajmLqvF0xRTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPbsACgkQVbJhu7ck
PpRDLg//XxCLkPVkc4xOYiqTI6Z1+gh9VYq8rLAhjwut8B/6BA/e7jfRxQNa5UgB
cTTC8Lcf7gcGuKeqa9OtWYztr4eWR0FEOcTkq/mFR2prvA2G1s0ysRLiMDbjC3Wu
7Ebg5XDVkwY0rFJtoMG1pHbq00t6e2qrEcFFSvhj43luTIsrG1r8SlDBUmgRr0d+
xXA8hxY9+mLIYwaTquaScqt+6SmO4n7pI+7xuXlrtlbUy57hAoZYMidthog5xB8n
6e94wCPX+5LWa8NhR5YrMdIRCYbvkUktcGD6eXT/VIOGxMC9LzMPSMSFEjUuhY38
5pesgV4nsroc0KPjWmM4WL1CNDMnTymVQpb6vkH3tk7v2HgLmeBLjfgaHJjk4DNk
9JMmKWaxrCq3Q1IJRmCJfI/sHbJpJFjL059KQ81VbwlaCWBcd8B9A2fJL7N7bCXB
N4Uo0CKAGYyaOAcnYN6mlKlPQGDqDJ9HBU0fmxOwGk0OyDE8a/NUEdwETgzzclkd
m3+GcQEMEx05fyanrzsTwqldS7JPVo1jNt/pXqMssupuXQt6IuW1JqUPxX+6IRzz
er4uiQ1EruOe/15IYIEjlverA6xuknCEMqYcqnZLGKBF32+JFNxX7EQqWlzeqnQI
bBWIHTMG6zEWj09mkVqm45QJvpMrzP+tkcGJc6vtDaQEfet2FZk=
=KSeP
-----END PGP SIGNATURE-----

--oofxajmLqvF0xRTV--
