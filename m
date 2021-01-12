Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E16C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFAF22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbhALM2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:37 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38257 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729974AbhALM2g (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1EE11188E;
        Tue, 12 Jan 2021 07:27:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=PPxRwlRSNFxWOyT5xVTOoHtXfcT
        rDuxHBXlpu4cNUlk=; b=b5iqmYf43cYLLFH1jdKfEIosbKqQ3m27KzDLVRAxR9O
        l06fdAmUD7n7TpsjTFXQVreeq22wdZn+j27JxeHw7NkNjk7UWjYwODj8xtM2LJoj
        ZEJciG/HXiLKo0sdY9/O188W6WvtJWy7gUh2S/7mA3gC8Qt9++aluIANKlOScvbg
        T6tdaOkHTRwq3hi0IUglXmNBSciVghU05+vOI++T6xJGvqWRsGDDqGaTtMZflnL8
        STSyEVtb6/ror8v2eZFm85yuMYOSCIpI2u9dGPT4om2UBx75uTsVegMVK66QmQNP
        XQfjYO4CLcPlbHMFb/WSLGOUkiXIjc2zto5W7n03HSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=PPxRwl
        RSNFxWOyT5xVTOoHtXfcTrDuxHBXlpu4cNUlk=; b=UNl85p6EoSQ1QJq6dJnYqc
        lz2k53po0bBWSXAkjteEhDlSYcyZx/aIN+tPSCr0lKIl1sBtaxap+s9yGglQCPLw
        Jioa8xHb0FiQm+QslLwfLe7v7gHra3mb/CeqpVyR7anoxJrkWqo/4LzPTrcmaGIj
        g+igejNIcNEgFeo+M/F2ASj51yILZMBwLexSj8GnAwXTM7V2a1uLj2HctOjWZxy4
        jLJKdtuNB8KR3OmFNiLAQgYr4IlRL6S4+kmFrCkd0g9D//YCqKzPYBV70WYgGmYd
        Nv7mx6X92M0V2/uslfigMM9G6e4owqHv7RjvDaLmJdPTuUCfWFNzrf5N+9ioXn5g
        ==
X-ME-Sender: <xms:wpX9X2MEw0Zbmmya9RLfd1q3N6SKRppc7NxiHbAlHYH9qzIhoYS5Lg>
    <xme:wpX9X0_sM4RM6ZngH1QELy6N7iSTE5qS1LPkC6opDGmFW_kSi4Mj6i5jxEvlftWks
    NwjOHGyMokqvNTQpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepuddunecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wpX9X9TvnkKGCBbt3DlEk2N4FR2YtwVkdPWlXSer-mu2Yx6hYRB0RQ>
    <xmx:wpX9X2sBeF3_IAp93x5E1hYpJ9Zr9KUiZ6X5LNdkZwHN6MSbL-1cAw>
    <xmx:wpX9X-eARvKRjQ3XwBfu75orOe8T3smePLKJIxUTPqeDPqZEHZdShg>
    <xmx:wpX9X2mzYsvL74ot1WFG0sS460o9nmeJuL9Sg_Qg8CdU82KkN5jiOQ>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12409240057;
        Tue, 12 Jan 2021 07:27:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1d16b35f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:45 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 3/5] fetch: refactor `s_update_ref` to use common exit path
Message-ID: <ba6908aa8c2cae55e589a278f8d6114a16bf3840.1610454262.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610454262.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LNZWPxvmWP+Ov3Wf"
Content-Disposition: inline
In-Reply-To: <cover.1610454262.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LNZWPxvmWP+Ov3Wf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The cleanup code in `s_update_ref()` is currently duplicated for both
succesful and erroneous exit paths. This commit refactors the function
to have a shared exit path for both cases to remove the duplication.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 47 +++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e317e828cd..b24a9e09a4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -589,7 +589,7 @@ static int s_update_ref(const char *action,
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
 	struct ref_transaction *transaction;
 	struct strbuf err =3D STRBUF_INIT;
-	int ret, df_conflict =3D 0;
+	int ret;
=20
 	if (dry_run)
 		return 0;
@@ -598,30 +598,37 @@ static int s_update_ref(const char *action,
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
 	transaction =3D ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name,
-				   &ref->new_oid,
-				   check_old ? &ref->old_oid : NULL,
-				   0, msg, &err))
-		goto fail;
-
-	ret =3D ref_transaction_commit(transaction, &err);
-	if (ret) {
-		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
-		goto fail;
+	if (!transaction) {
+		ret =3D STORE_REF_ERROR_OTHER;
+		goto out;
 	}
=20
+	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
+				     check_old ? &ref->old_oid : NULL,
+				     0, msg, &err);
+	if (ret) {
+		ret =3D STORE_REF_ERROR_OTHER;
+		goto out;
+	}
+
+	switch (ref_transaction_commit(transaction, &err)) {
+	case 0:
+		break;
+	case TRANSACTION_NAME_CONFLICT:
+		ret =3D STORE_REF_ERROR_DF_CONFLICT;
+		goto out;
+	default:
+		ret =3D STORE_REF_ERROR_OTHER;
+		goto out;
+	}
+
+out:
 	ref_transaction_free(transaction);
+	if (ret)
+		error("%s", err.buf);
 	strbuf_release(&err);
 	free(msg);
-	return 0;
-fail:
-	ref_transaction_free(transaction);
-	error("%s", err.buf);
-	strbuf_release(&err);
-	free(msg);
-	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
-			   : STORE_REF_ERROR_OTHER;
+	return ret;
 }
=20
 static int refcol_width =3D 10;
--=20
2.30.0


--LNZWPxvmWP+Ov3Wf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lb4ACgkQVbJhu7ck
PpSw8g/+O8CIekIL6StNLs+i1Rh9UbZgNq5hiWAg5AH2VcbWcKZk8X2nI0/32ZF5
VM5zJTXxRBNIlj9fjqyORxdWS3xox/+IjlU8UfuQbEU8YdJCOAOdDSL3i6LiaFan
VwxZOKLbs99AJU/gx+FZcSbC1/jNek8/tPPxlcd8ruPsTygdV7e2gyjU2frmO42C
m5Zw+14IRiozcIU1DQmNQUIuI2/0g9ZHq0naHBRksINHcbVzHPfqSTakmhfZ2B/S
f8GcuRKGk4hykzuGsqCpbQw8t1rW9cVG1tj2hrX4RRDpjLws0FVAWp9u1gfpVuTm
Y82nd9emVpzGQReV56YeG4g5rM4RH3LJ1yHw8ggvdw67MDiEYVZBj1u7ddOU+k0k
ur4nTXyI3j3VsBK1DrvyiFV9PYeV+A1hjR8XvBwtzw9HyQfQXg81blUwH/8HyY5C
zuG7GJvb5mlM4MXHPjYwMBBK9jMmiwfVe+RAKvUhK1i9sunwOjbbG/A6HFjD9hHJ
p1WHVp99nC4/yjrU+mg773gr6JuU+74NxNBH/3iQvDD0T+fuE6bGvXgUhWBnoswf
7tbQ0Qn6WCHXHMjlvo2Jt5C2vsugoV+LAXyd5o0iHPpY0lYKQeUXZWB5pQmVnD2m
9UxExAnndiBq2vrm4xgIUktG/JZKaI7yKGXPgbu7LvxryupqTrQ=
=sdHX
-----END PGP SIGNATURE-----

--LNZWPxvmWP+Ov3Wf--
