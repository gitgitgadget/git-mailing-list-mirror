Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF51C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbiAMGLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:32 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:42805 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231146AbiAMGLb (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:31 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CBC123200E79;
        Thu, 13 Jan 2022 01:11:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jan 2022 01:11:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/tbmGBFn9LyM697FNS6tZ7nY6Fh
        nATn/YbbF2Hf996g=; b=MQ86xKvEsP9lCACkJXcDPjfwe6KWN+MYd/EnZMQvctJ
        xxg/ZI7rZEfzknLzdUYGJtHg8ZYB7kiSDFaQqT/vWf8QAB6B87nrcw28LPcKcVEK
        W87YA5GptNpXn71zCHahA42xZtL3oeVIs5cVAj11pAjdLVG0h251Ka5CGmLnGlnO
        8fz2viLlSg5Jv2CdSKBcEgaEhdzdpgr16rWvopmrCMwdkDhNi5WMve076pgja9Ys
        QyxgDjDq64jMWH7CK+Xgh3+xmAk3C4ZPQ+9YzBED7OD2rCZw9qlXsFld5W0KX+sY
        riyWQIxv60CtQlPDmW0qzv4DNwieqt9K6R9PpljJFTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/tbmGB
        Fn9LyM697FNS6tZ7nY6FhnATn/YbbF2Hf996g=; b=CrHgZ+cXGFlbSLZC9VBvfN
        1qunzPkGKHcv42OEddg2eSIUT05oCX35Frpu1qruU0tvLMS1zLCdobt0ISnGMeq6
        qxerqVlfQEQxA4RnyuvuDfEyTmqMA3C54l/vvoPgjoVVCAUFOJnhf+oaWXfRKwuB
        Nos0k87RWjPoFDK3s2rSc06jKaufSSnck3gHr7ZWX1Ow7AmlAHtvwhEDUgGxvUA+
        GRb5SD72BkJGZ85HdZAkKzQRCKOJLscTZvM5uAn4+vCgHXMu08x+dkBSjnyw3LQX
        J3FNPVUKJqcJ5RJENOvYscUh2eHRiucqb6GvIe3xlL+z4FibFoX8OUbSmucM3BPg
        ==
X-ME-Sender: <xms:kcLfYd2AMD8_S-Ap_yv4XzsSC6zbI9InGBy3t2s1ORziIFUjA8fG-g>
    <xme:kcLfYUGIHzVkwPm7EGwCzXVYue9CSncI34j_pO64RMD-tVMR3bmpBqq16QvfVjpHX
    S21LTXcN0CavktP5w>
X-ME-Received: <xmr:kcLfYd7BI-SHxb2KL4N5A8lJBCiv3zKT9Cv34V1X0noqwd_OEo2gTNZVYFc07XTv5RdYiIb6gMaA3bn9lkPWKbTVoSA6KAbX9ZtadAwQXC5liRl_nYAXgcjueQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:kcLfYa1r8sQu9_pQqhZCFP6suLDxf6-x28HTSMiaKHAJK46_WuW_Mw>
    <xmx:kcLfYQELtS3NnDbaqXDh4FmfOqoRFeCJAopAMRcwFj77qIlWlOuN1w>
    <xmx:kcLfYb8xy6G22qlHuDJ68WZ8DzQniyUKFL-y8PBDOUuAly-e6gpfhg>
    <xmx:kcLfYcjq7oheStoMpIoAZagb3WB-zY2IvZ8KJKYpmFuXkq25NaaLiQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:28 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9f04d703 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:27 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:25 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 1/6] refs: extract packed_refs_delete_refs() to allow
 control of transaction
Message-ID: <abbc28822b8fde78976422c775afa83bef76ca6c.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UEj6dH4Ac8g0tO4o"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UEj6dH4Ac8g0tO4o
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
 refs/files-backend.c  | 12 +++++++++---
 refs/packed-backend.c | 28 +++++++++++++++++++++-------
 refs/packed-backend.h |  7 +++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

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


--UEj6dH4Ac8g0tO4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwo0ACgkQVbJhu7ck
PpSSJBAAiDCuX7vuz7+QLlkNBIk+M0RXbax82f7uaYVEw1pjFmGvL1+aWW3fhqRz
oF3JFRetPMuZSlU5hdBYZr/xf56E3VvMeX8tv7fU3pEF/T5f71QoB+u8xYCTlIcw
gqyBvIfKMMpyHQbs7Q9DUVgH/afsUk/kSO9NQy5182dGtzURZBvAmR0xEtrFpp2W
o0TkZZMWLaLT4/Ep4a3OAX0BT769MtMnqLRchSM+HBMMLGRGjjr8/3MIvCTyyhFu
78jd7hsnq5qchl64y3G1f2kmVXDfx3LXzHsY2uP/XOBiWKoIiA9oqEGQpgyAN9gd
RJ5l4KyBp58Khwm6cQ2wSae5EeqtEN2bleH8oGmYrZftlF5QD/NWI56X7iHHXMps
Sl1z/Cfusz2nXERwmgqNrf/kspZqj1TIG7fd9EOWmcwQUIToJytJnFItEeX/aAkG
lqM5/ye6zwmRr0H8OP4U4vmz+ESl/lMrKN5a8AIWIJJ4pyqzFaVPrQJsULLroIa4
dXA/4MGcJIsu02aiWxB8d5A8X0Jcpqdhap9/74mvrbnx7tckWOd3w+7a9IGyIOCR
TVeUl5oDH9lGKfq2Qj+i09bTdIOVh5qxVHQ0ZlR/EdPFhCxZgmJuvYUVXQWK1KEC
xyjTi4bXQDXxqWOVoj3XGVbG1KfP+cHmeqYiXXPF/lTosNQRS48=
=IyQF
-----END PGP SIGNATURE-----

--UEj6dH4Ac8g0tO4o--
