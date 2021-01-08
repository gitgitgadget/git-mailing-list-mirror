Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0496C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D49207D0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 12:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhAHMMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 07:12:13 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33113 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726834AbhAHMMN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Jan 2021 07:12:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DA5ED5C0083;
        Fri,  8 Jan 2021 07:11:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 08 Jan 2021 07:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=MERm5Pex5uNJhDINfcHPyWzCYE7
        Ebm6+LGkKWOUMIGY=; b=KENSKi1FZYz4LnufQqXsM+Ko6f84OCYZFeNyjphZD1n
        EDYeA2Ou/xfRnsgHMFXpRphz9SZka+zVHb/znE90SUGFKYiGwTDJazytYopZWl2N
        UvHEjn9Mr2KChOhjol228pdxjq5+CDdWoirMs5lg5YgFg3pxnMgC70z7zz9pgaVT
        xsmCCHg+jLMjMxSqEuFGiyyM1ehZWTfj+sfccb6m+PhF1KsVpc+q/CkJrwyBCrHC
        GHMWV8DT3b4ugv6D0htwhlUwe/L6gcekycmBRhorHiAuA6xFP2UKPa4M6vC/ktwd
        B/XAfV3wNich49Jqx2/DqMauVbv/tAJhqmPGWB9SDfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MERm5P
        ex5uNJhDINfcHPyWzCYE7Ebm6+LGkKWOUMIGY=; b=rqxsbjOxLFKYL9jUk5MSYN
        hydW0px8mRCz4D/EQuZ1jYJclfQfsZ6ons9kmik3eD6BF/hkq2XpHfiLFzxr3A1U
        cuSLfrZwE/6HOaHrxKiHMRCoucDpXSfPjpFo7FBjsTlHJkrhyo55GuiUcI7mEWaa
        4LEi6JZn2J8D8z1kL7snq0cPEIGdu6WOjCIULOy8dMJ3lJ6vSRc9T+aBxaNBTr5F
        2CH+MARpBxEfIKM51mQFEX9KgH3427HWMIV8wbOJQo1xF4zpYHPDlqOBPw5vP7Bn
        a8QDxaLf1Jdh+Xl0OsiJcHu4p2EBKBjkgoKMudBcIZErhhAfj4eomxIYlaBBf7KA
        ==
X-ME-Sender: <xms:6Uv4X6nYumpojhO-Fvw2frw3l62qa1rVB3TwsI1RCa2Hzeq3Bdb-ig>
    <xme:6Uv4XxyXdwLBi9-jHO2IoX2vzzNKDV9ZYbYmqAfSiQoGJjezyvSpIOrNeMyP42OZT
    7GZdDGRZpDxspSDFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddukeefrdegrddvgeehnecuvehluhhsthgvrhfuihiivgepudenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:6Uv4X1h0o7VpFwazPAqesj023tvpDOjDzhilQtWcPgn-LQAodeKQVw>
    <xmx:6Uv4X2WG6oM2SxFa3K87v8ktXH69G91I77wF37JtZsuiB16BeeP-ow>
    <xmx:6Uv4X30AtWniqorf5e4y9gkWopS6t2-lRsnkumbMGkYfed2mvp3ZLQ>
    <xmx:6Uv4XwXocOFH0IgwEzs-0ll1zS3XE3BuvOVBtgkbHU9hqN6slMzaaw>
Received: from vm-mail.pks.im (x4db704f5.dyn.telefonica.de [77.183.4.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5413724005D;
        Fri,  8 Jan 2021 07:11:21 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1b604566 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Jan 2021 12:11:20 +0000 (UTC)
Date:   Fri, 8 Jan 2021 13:11:19 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 2/4] fetch: refactor `s_update_ref` to use common exit path
Message-ID: <718a8bf5d7a0ed92c3004991a42419279ff38253.1610107599.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610107599.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cv8FRGlFeSmsoF/8"
Content-Disposition: inline
In-Reply-To: <cover.1610107599.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cv8FRGlFeSmsoF/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The cleanup code in `s_update_ref()` is currently duplicated for both
succesful and erroneous exit paths. This commit refactors the function
to have a shared exit path for both cases to remove the duplication.

Suggested-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 557ec130db..5221a9dbed 100644
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
@@ -598,30 +598,33 @@ static int s_update_ref(const char *action,
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
 	transaction =3D ref_transaction_begin(&err);
-	if (!transaction ||
-	    ref_transaction_update(transaction, ref->name,
-				   &ref->new_oid,
-				   check_old ? &ref->old_oid : NULL,
-				   0, msg, &err))
-		goto fail;
+	if (!transaction) {
+		ret =3D STORE_REF_ERROR_OTHER;
+		goto out;
+	}
+
+	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
+				     check_old ? &ref->old_oid : NULL,
+				     0, msg, &err);
+	if (ret) {
+		ret =3D STORE_REF_ERROR_OTHER;
+		goto out;
+	}
=20
 	ret =3D ref_transaction_commit(transaction, &err);
 	if (ret) {
-		df_conflict =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT);
-		goto fail;
+		ret =3D (ret =3D=3D TRANSACTION_NAME_CONFLICT) ? STORE_REF_ERROR_DF_CONF=
LICT
+							 : STORE_REF_ERROR_OTHER;
+		goto out;
 	}
=20
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


--cv8FRGlFeSmsoF/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/4S+YACgkQVbJhu7ck
PpRBTRAArQsCUbQIu+s98GUGl/ZyW6dmBE1qoYTAEcpOcCH+wjyj4ooGDt0pgMA/
FR1fTrSvz8thtOXdCU3u4ytvwVcK06efn1MFpQELaFqnSwRB/X6ARfmG2qOY1XJs
L9+oiOkhhTb17adJM3aSTLOQjYhvtanlqoz9/3fsdM72T5E/7Ndp6uUBofJB6GXv
Bf6t9FiLmfvx7GbF96f4fmufybLZY0tsH41PjuIKPROq0sBLIllS8ZobI6wZ5GLy
WXJ2Z+jJSlrXbp3D6rFcMQ+qICsIrwOZmy4tEGODe/uZvMxwGDTJfxQ1euhcLTro
1UrWuaHMmMcU+I5jLSu2jUccSlVwMvzxnyC4yNcQ7E5WoyPvApWoUnJ5Ap4GNVXS
qUfT/cI7LCllHteqolrT+kJnN5x52v0c65E2ojTKiN0WRQx1pFfEg9URthJ+DI9p
B5i8zYUcsN7WZw2eztyhUMsnErNnlKvKRKW2gbAqVKjYvJJXwyA2wChWTUp7u6G1
XsIc6oIH1nmC1MfiRyc7Sk9NktbHN/IlZN4g0laRruB4zTYnehc41OZ38wRuiKZr
bGI76DNjZMc5gbV6m6s4+kA+I21ouZssS5/bGZJ8ZUCmaXQY5MgzJ7/LJD3c7xaG
BM0fVEU7goN2itIhTMf+wjiEfn/MEwjmJqIQdVHmWE6FRN+2CS8=
=DKlW
-----END PGP SIGNATURE-----

--cv8FRGlFeSmsoF/8--
