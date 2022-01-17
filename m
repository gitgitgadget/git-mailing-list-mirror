Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiAQIMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:40 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35877 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbiAQIMj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:39 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B595A5C00C4;
        Mon, 17 Jan 2022 03:12:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Jan 2022 03:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=jaQeOC/BM7/i7Uns5br8pxMJkP7
        Aq3qnxFd6LP+EOF8=; b=BgYjEdviIsZohLntQYcqvAz8YFDZXTVX0bepLTWCUrj
        wPfu2FRJUCXylGB5QtvhiX7SPIhlsAT5sAJkjigkZrbIMKhWHl+TiJdAR9XB9nyz
        eQLHa8SSAV6ZQek14xwA3ahSeAZg05CAOAVk2dJbgmx2jLzQuxAnQsC4pYvCg67i
        ih+Dj3HHvPrquVtdp4d1fQLNwu4f+p9H98+d26DdoKWQMAB1HKhMGORt1ESSXnkb
        zaaUbePhefwSUAmG8N0cpsYRSsB3M4SX0IBH36zPfYgE9MrpOW1aiE/sPW9Ea6fy
        V215AvuoO8BYNLPoEzilR0XCcDwDPwiMHTo07mP2rag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jaQeOC
        /BM7/i7Uns5br8pxMJkP7Aq3qnxFd6LP+EOF8=; b=lOM0Z3+mYAj9kruN5BZolB
        vKdKvbgDKSs7ACgh3RkDUonJlVdXXEL6SyaU3snMLfrwPuAzqfaqWRdnRKQOyhF+
        FYwgsfKrR2VZX/HVDwKzS5riuQpZEVSpACbfikaE59hnvXmuE35wW0tgfMC6dWAY
        rQXIFQRnGcBDDxSu8YpSRXrae0QpTmpQo/cGug+iiV0UBqcDpMjecfAIkhLSgBIE
        uMPx9llFQKRqT/Q5noSe+dUsi7ptGFHtOm7BuuBUsJMAIFTkKYz4XtdXE174tmK3
        OPM1dO9tnhhimMwy7srCLF9SPAp76DxS1bggkGs4mI28izMFZZgPavuhYmdJUJNA
        ==
X-ME-Sender: <xms:9iTlYe56MhHKBETS1CW_2MvtNDNQBoCSJn9W6Eke93bViJqdjPS5tw>
    <xme:9iTlYX5HTqw9NUJ2iFLwkujpA9Ps9LkDLnQHVqL2oM6kL1whQX4ar_92rOfEaaVlj
    dBe-3vH6hh8tTdXLQ>
X-ME-Received: <xmr:9iTlYdf8F9X9Mgd2H_5iOKCurluifUcXyDmQGvzCIhZVGHNDrphwXWE7Mt_vJ_U25gwsYhTDNzNY5PhCpPaNQVGpRRZpenbGc5gqEtuZuvmHDd_fuAFK3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9iTlYbI9dxVlfPJDT0jqyj9_j6eXV5XYJRf3vCPNJvHCMslUc1t5tA>
    <xmx:9iTlYSL1jr3GA2LQwqBZBKnManw2FfUPFaoPf_rFTZusJpEENcspBQ>
    <xmx:9iTlYcyHWR79NNnttc2mlxwDQyzr3hU2EJA4Koavuhz4qOi99OkNFA>
    <xmx:9iTlYXGEEHaK-1-ZA7DSs-cisYed_8_Z31jlWPBiRudFXgTQwzp8Pw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:37 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 76c96d95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:36 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:35 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 2/6] refs: allow passing flags when beginning transactions
Message-ID: <d4ac24c8b8ab8020f7af1c646041b4413b56ec9e.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="30b3LTHy2+Lyx0ur"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--30b3LTHy2+Lyx0ur
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
index 459f18dbc1..4d4f0c2099 100644
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
@@ -2774,7 +2774,7 @@ static int files_transaction_prepare(struct ref_store=
 *ref_store,
 			 */
 			if (!packed_transaction) {
 				packed_transaction =3D ref_store_transaction_begin(
-						refs->packed_ref_store, err);
+						refs->packed_ref_store, 0, err);
 				if (!packed_transaction) {
 					ret =3D TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3045,7 +3045,7 @@ static int files_initial_transaction_commit(struct re=
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
index c964dd1617..0b45598e18 100644
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


--30b3LTHy2+Lyx0ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJPIACgkQVbJhu7ck
PpTLFxAAonkvgdPU4e/Cx/wGHKdSFrc6M4icgg0uAkWwbzAlBenmyk7zmzhvifcy
pkfC2w1y4+PpvLdnTCCAkeqZ9J0ln4p5tVCcumD770MXoPSqygAnzNhimLHY5/ik
RRLRIqFampnYLZpq1PR7CfLDOS9Q65h3i2ffpfYiZ43l7bADUxvia/WI2c89kIEJ
ym+AHv0z5bpJEqRsePE7jcfk0Y+7I59+gPJQTYu+n9B7UXWBndGrOZ9eRI8JSuH8
9NDdYoO4lckFdfCwOWNLaGygcIAzQdONuwQPmLzDf/gWitVwhKQOijxeKMh/MIK0
vHt3oGKxIbyNx3r5cV9AMqU0pAQO/rSI/RmjDLBVbFIYKupGcLp+n7peLhSV8JVe
WSxGLY7db1K+6bqfISpLG17BsNnmevX0OlTrKRrhbnQx3Xx0l+Xi6lP6nn86ZMt2
cZ5n+Y1p17IcLJ1e08CA6eTy4301sX3sa8cIhbLWpB4WjsDMmzU9K7xa5vjHxFWI
029Ajm8l1a/1qd7FzOrHyXiDHV+jNxrxaspvQyx28RnCCptYXeyOBgqlrKWbF2e+
rqoZho1nvtEPd63wYwTc03PNGzRJBsF+lp72CQeHZUxA6+FwmFkgJ4Xm9aZtUniP
PuT6ye17eEf1Ru8MOIKQddpUEXhvhUQFB/8mdKhl5FqvpJGO6Q4=
=Emsz
-----END PGP SIGNATURE-----

--30b3LTHy2+Lyx0ur--
