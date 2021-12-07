Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F31C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbhLGLAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:13 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36701 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229903AbhLGLAM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:12 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DA1E5C01AA;
        Tue,  7 Dec 2021 05:56:42 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Dec 2021 05:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=JN53XZrnaxgabDmZVd4rxXohVUX
        r0gQyUeN2eH4kgac=; b=k01gloU+Xrh1mi08/foVAiQDutfcxdNDBXUfDHNfk3S
        hfraNzgZq/mVnjp9vqYH4Ci//u5AJ0ldsH18wgJecAPv/riEH34MdDEzMnzQAOq/
        5kXvHHHBs8uuvFE98r4PafGRNdLBfhShmUvVq4eW6YZ3xiAeiEKd87IaD7QREBOq
        ojYiYjV/opE1plMiLeNGpgajDEdF98dnsJuXhtzwJv9DIns4XlATlLlec04hvZPs
        J5m5zyYN6DwjX+13Y23s4FRtfNZBVe1OW5ihQnK4H63P5PdHvfvECCX4/rqhhD9Q
        se4OSnvMzfGVn7WOE6D5g/o4Ei5TB74U127rCgzU2gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=JN53XZ
        rnaxgabDmZVd4rxXohVUXr0gQyUeN2eH4kgac=; b=dVK/ncr9e/fM8pGN2om3p3
        GB036k0dWSViJYHtA5DvJVcM6GTu32NZ7xq7GLj8RP5y6vT8KcJEaO5p599xUmZs
        pHmKl1obw3TuqJyqXNRrShFMZQ2nRWrvypxnJcuvI1bSQay6CdHbV7SROOzhC5sc
        EBVn07AgTyLQnRFpDSF7rel+02NQlmh5MCxkCah3eMxkE80lIXO58d7bxKL9Tw4F
        diDI83KF6JgDfjbbi0SuhlnEv2bAy4M3S3t+aND7SCUQxRz/CCNL3Ee+stjkj2W5
        woLOGWdL89GWlD8HLOfKeDKkXOJG2vhpWGjSjW5TcUw6AR0HmQl0LKKQYRlY+l/Q
        ==
X-ME-Sender: <xms:6j2vYS0U2PV5c69vTXuabBWqjPGxfzH_jV4hi001bAf5c9typQ9HOw>
    <xme:6j2vYVEhk7auTJzznQ-LOAVeblJlyPXpiItFvE3nljxDnYFR7BMI8lRnb-JpWE0Vk
    8mwJjLDqfOU3mSddg>
X-ME-Received: <xmr:6j2vYa5NoNgW4u5brdAIiNI5I-X4g1p0ZIRkRZjbsf7Qx7LMVQ_Px3ggmYVyG7LTeLQxlDNovlCPqO38Hk6zrPUIXDWMPxSZcC7tuLMKl-4ALq5e4xWPeb_N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:6j2vYT3TVgfqSJG-Tdq-R7zPD3fw6YKaflJDQ_BsSY1CDVVQg4HEhA>
    <xmx:6j2vYVGDQAAljNYA5qe-TgGW_M6xkrmRNmUpVX6OXSpB8GmeHTin7w>
    <xmx:6j2vYc9LBd-dd4Jy6jqYu8xcosYkGLcKRRqVyyhGvhOU4E-DPDRRrA>
    <xmx:6j2vYaRJYCDRdpjApNKTfGZE4z1zA0szj7nAHdSLN3n3VMmOyweffQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:41 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2b349db0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:19 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:56:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 2/6] refs: allow passing flags when beginning transactions
Message-ID: <f722ec5406d246f6b68237f8d8321c1a7a67109b.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bFEwUBIHmhsQSQnH"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bFEwUBIHmhsQSQnH
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
index 996ac27164..1c8a0c01f1 100644
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
@@ -1148,7 +1150,7 @@ int refs_update_ref(struct ref_store *refs, const cha=
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
index 45c34e99e3..e3d3b7aa14 100644
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
@@ -551,6 +551,7 @@ enum action_on_err {
  * be freed by calling ref_transaction_free().
  */
 struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
+						    unsigned int flags,
 						    struct strbuf *err);
 struct ref_transaction *ref_transaction_begin(struct strbuf *err);
=20
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 453adc38ea..95583dcd00 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1122,7 +1122,7 @@ static void prune_ref(struct files_ref_store *refs, s=
truct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
=20
-	transaction =3D ref_store_transaction_begin(&refs->base, &err);
+	transaction =3D ref_store_transaction_begin(&refs->base, 0, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1193,7 +1193,7 @@ static int files_pack_refs(struct ref_store *ref_stor=
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
@@ -1260,7 +1260,7 @@ static int files_delete_refs(struct ref_store *ref_st=
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
@@ -2767,7 +2767,7 @@ static int files_transaction_prepare(struct ref_store=
 *ref_store,
 			 */
 			if (!packed_transaction) {
 				packed_transaction =3D ref_store_transaction_begin(
-						refs->packed_ref_store, err);
+						refs->packed_ref_store, 0, err);
 				if (!packed_transaction) {
 					ret =3D TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3038,7 +3038,7 @@ static int files_initial_transaction_commit(struct re=
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
index cb19b5291e..ac4d92460e 100644
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
index fb2c58ce3b..5bec9014ac 100644
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
index b4135a78c9..78122e0f0c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3599,7 +3599,7 @@ static int do_label(struct repository *r, const char =
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


--bFEwUBIHmhsQSQnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPb8ACgkQVbJhu7ck
PpTjBw/6Akd6JDJCFZhVka8JM0fjFBtsQ5hjf08D0CoKysCybFJCwoU0DADIEdZr
2/C23cGOr6HyEzmSlVZ5oqOHpt9gq2yem2b5pQ96a3PONUrxLkQQQAZp9Q6CF05h
ZJiRPQBpgC4ePXm/IbNYlZL1qXtEJhAWqqIKcYd8WE0w+IC+fCGbf9QCxAl5iGOZ
oBYywHkry5Jqu6rwCM4T7yvQjQ5b5p8hRvXzJ/roKtvjsdE4Wgp5QCAGqwzIiCIM
+WbIDirGhSE6/bhjcsPBmom3/GSpmT2KWP/G19cUxuU9wEmZxy76PBJ3Sfioh+Fi
ys+hEkDff4Sfb8takMx2rAC0CmMIRZbfLE0ZlKrSuEBHFvkpeoo/FBNjeaYEOQ9k
lKOfufmskmgLexnM0Ro4O2UxWdhsim54OuSK9eLav/LjzBcRPSHabrFfkwqQoxU4
zTbwtFeeuofjXsvhhP/ix1OHKboBOFw5r0BFTuMWW/BbYnFsXLrJ2mcu62WADWUr
k200nZskAUu4XZkzB2QGyQ77UFJxsPLJCodvGxQMFiVxPbKQPo9EdctpSinZNBMQ
Qi+Sd2XvER0d1auKUhbJzioLhmp0uwEzBcqM5pQ5jTVlZoIjR5OjP7BoitW/SbGj
NBpACR0Sa/UcPMPRVUrkC9Jq37pHtTAXfSxlbKRuqH581g5m95Q=
=FIz5
-----END PGP SIGNATURE-----

--bFEwUBIHmhsQSQnH--
