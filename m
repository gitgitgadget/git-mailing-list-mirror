Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4F6C433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BEAE224D3
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbhAKLGd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:06:33 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:57601 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728163AbhAKLGd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:06:33 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 99E03293C;
        Mon, 11 Jan 2021 06:05:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 06:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=g1kSffOjjABCuFSiOFmFnSY9Rrk
        E1mNRZ0ja7Yxb17Q=; b=IQ+Xox7+lqMtCOLdDPKU21a+X+IZFrXuOH5RbSI9ju1
        85z5+a86Mris/H4oqqmrXwNl91EsxG2VQ6bp+wvQUhjQfqnEXH7hE7GpPGo6vS7s
        VPVuTVxsOTHSjiWP+ahFGGO3SPgkVouBT7Pi8kAujD/p4tgyO2ikBUmzmNcXWLwn
        pqRd60MHcwYxqazukbPh/Nyu2r2vJSL9rW7M70gELw4sKlpU5RcuaOgis+acy1dJ
        rWLd4t1Z9Kp6pugPfwk3AlUeFPCzKldQaFex5j7yGIAUkzbE069EnVJLs8jypVUA
        U4zABccOIWCN/L7Os0AfxXklAxFxcEVAYTQDPlu6c5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=g1kSff
        OjjABCuFSiOFmFnSY9RrkE1mNRZ0ja7Yxb17Q=; b=oJhM39z2Z9VduYQJFp1E6T
        WtSmOOQj1hvLPAD7cVFO1wCz+rVfdMychIB/iQOxgsID2UWd2WkFkv5whpaefi/p
        PcnuW4/Sj0h1mK9t76VOFoeMObM7DMOXwC6NmJZWMH7RhAVqPFRqK2Ejv2TgpXWU
        DJqXtYRYWrZJLQrX7fX0XJw8VogfuKHD40pI0mBrY7ZzcSgruGbGx6+zgw2aqNoO
        ZpDh4ccqzi/GzcQ6igHr4ZoRPGwoAcGluZYVBdzF7TcAaYAquNxG6/AujCw30eCo
        6kjswEENhxO6ibNgF99z2k6eZZp0FIJRFXM4ONPSYb617NBroqhqXuYPNSA0VUYQ
        ==
X-ME-Sender: <xms:9zD8X7Q2g6YQYCZkzb0qTrjv-my8KspDlmGTLEKdL0mhiWquA3AoYw>
    <xme:9zD8X8we6pai9ha5qY3X_2bZuiTvg4T7Ae1O3iX-lNY1IxLSN9DYRbXQVlvNkOI5A
    WJR1uFO5p6BdO_clw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9zD8Xw29ytwW4MWoxlu4klMN9LSxUsRDGHUHcyVqR2j4fy3nPk13LA>
    <xmx:9zD8X7CYC_uSEvXImmaK0ub58rw4jcoHYn6eQ5A4yC3jz5lmxWQTZA>
    <xmx:9zD8X0jnoe0NmRHQrZDPg5JzySqZoIYLH6w16w0uhVLK70uOvR-LEw>
    <xmx:9zD8X8KOu-95_ZC0200qhPx__KsLHemE4DrqnAJQr1gslOONx-IljA>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C06E108005B;
        Mon, 11 Jan 2021 06:05:26 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id df2ba514 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:26 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:25 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 3/5] fetch: refactor `s_update_ref` to use common exit path
Message-ID: <c411f30e09ccaf11efce35a8d2a46675e1828849.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVIOCiO6pePpoRq4"
Content-Disposition: inline
In-Reply-To: <cover.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aVIOCiO6pePpoRq4
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
index 1252f37493..991771f8eb 100644
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


--aVIOCiO6pePpoRq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MPQACgkQVbJhu7ck
PpRqYg/9EA/P54CMJ8+v7UwQS8c1hL9CyWRVYsNS0SegX9zEVxENj7f9A0oO2KHS
xpSraAIQE1wyZs1gmfOiz5AJBlAQJjKl/akSXMOiPDQNngYk40uwan5MzqK/Y0bD
SR7JTL2fA242ZPkWlo9KCNsy9FwFv0bhfGb2+70nuamc+0HSFQfx1PCs7+7hAxjN
QyrCO3yd3Jj91hB+OYe+AWtndWHI715iNTd6crjH11We/C1nxWBrCZ87AUWOzUjQ
0Bo5BQB2gTXyzX3lHE3t5ztf0PJ96PhIxPJtFusxJ8vhCY2nL9L8XFfBGAkrRuCy
cLOSt+4/oMMgsmDerz5JyRKN+rZNW/lcp3HIGhPh7U8+GEDcKGZr3y7DQtybYNoW
e2N2rJwj4bANcd7PVW8JJTPNNgYa4QLB3M6m2/qG6ynf5hkLjYOMCGp2nG3VG0kp
2wGx4l3mIZQeSTWgYgAXqhSSBeYHLoTxvFsW0Z5xCOzbqlPLT2ZxrfTsZJwJaO2I
PdY0bi2nMmFT5/+UWbGGihzafUJDLs9DRHVYIt0R0cVjEAAl07En3x5DUHEOFej5
VqMqDJvVhRk9eNE/4MVAtYdLkmxippm+xXLB2dWezEFLe0ta8Ndrm+XhiRVzDJp1
LHq0HHyq8tL00n/tiJMy+CDDg/zN/qmHrhAmfmTeTYJX/oLkvf4=
=vFWm
-----END PGP SIGNATURE-----

--aVIOCiO6pePpoRq4--
