Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5D2C4332F
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347344AbiAGL40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:56:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36349 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347348AbiAGLzz (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:55:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A430B5C01DB;
        Fri,  7 Jan 2022 06:55:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jan 2022 06:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hYuVRQWpBXu/fJ/BaysZLoGR65F
        P4nHh7PiAxlN8eso=; b=Q8LCWGU07PFo8qj9fcZOFvG3Zt4EX06Y6oaRJHPVWTp
        bp/iHv63i9rPtd2FYptn2EPXGyY6ntWe2RcRjXHxqDAxLY5vDNkgrkXW6z34ZQBr
        f8yJ+XUinJHyk2fc7lpXxojcc97s3RuFI34N4o6bD6pLno1VLWWdDoHXPGXXpTf0
        gCJc93QKxV49JiCQUKE3IivQqL5+eGegYBT9cwck4j0QQKjgLXtf7zaW1wqFr3s5
        XulZgpjB0a48uDbObDtmVbOHU6N84B5gfwcVHUIm4tNeGW6/BsJ8lNg3UzyXUOjA
        lJwoPXiH45V4TEsk4zuvN58NRCzash4H5BocEzrpIXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hYuVRQ
        WpBXu/fJ/BaysZLoGR65FP4nHh7PiAxlN8eso=; b=gCAjGMq/8wwuV6NygnVMLf
        XYOLeuYzoGZ+0/A0GTVrf3M9uoey9GtvWe/U6zUb/XxPTkcErpqpUqrPCFUQY1RU
        CDBJwYhQ4dmv5CE8tE3o3d280LGuLnOf0DPTDm4fJC6Flo5wMtdnCMFrpUyyy3am
        6rBLom1l+Kyyg2AeHclcGGYPTjUioM/KQ8+4QjkEnd96bdBUxfuwPyr5V+LRCK4N
        jYRvltCrtqEqcGFQIiCacU800zerD0JIV+8hdJakm756obFJzYucTOtLwLVo/8Y0
        50kL8+dJEi3U7Zx7H7ZZ6ZnLuSWfpWX0At5+C61iePrUw0E5Kf6yh2O9sRClesag
        ==
X-ME-Sender: <xms:SirYYeKMy1ELb-moZK2GukxctO4I2eI41URekpAXPW0TiqAt2MD8ow>
    <xme:SirYYWIkjNixRge81RhIXC7JlGX6JBeMGCarty3Mve4V7_EopCYwKnBB9RaPz5x7m
    Y8qhKBnqWO_4pSlpg>
X-ME-Received: <xmr:SirYYevhE5pTvEGV-wkxCOiJz-59N6vVIIZdY7skiEXJcOlUIdk5GK46AvAVwPSTDYgjbof3EzNkCtSWZznGMzoby7x3ZEuoTO7j42ESHHxav-TZ8BUNHMbx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:SirYYTa_98o-s7fLbVGLQ2_tAcAtXF8G7-CNdDWuALxg9uroqlcfIg>
    <xmx:SirYYVayUlcY7Y3mOT9ESmL0WAfvgIAHziLAgRkkFJdhHR9IUXSjlg>
    <xmx:SirYYfDOnfbWKPl6rs2T9YwsKMo6WV2Bju8D9lP2yxT5eFSGdmCgcQ>
    <xmx:SirYYUl0pYuhXPmuOHyGLL97n1J97mObXajDdgXWVnQ5Ffq3M6jurQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:53 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 695847a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:53 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 5/6] refs: do not execute reference-transaction hook on
 packing refs
Message-ID: <1539e9711f8697bcbbc90b602c69c7f268ad7c37.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oesNj1Myabnp2JiZ"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oesNj1Myabnp2JiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reference-transaction hook is supposed to track logical changes to
references, but it currently also gets executed when packing refs in a
repository. This is unexpected and ultimately not all that useful:
packing refs is not supposed to result in any user-visible change to the
refs' state, and it ultimately is an implementation detail of how refs
stores work.

Fix this excessive execution of the hook when packing refs.

Reported-by: Waleed Khan <me@waleedkhan.name>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c             |  6 ++++--
 t/t1416-ref-transaction-hooks.sh | 11 +----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ecf88cee04..3c0f3027fe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1121,7 +1121,8 @@ static void prune_ref(struct files_ref_store *refs, s=
truct ref_to_prune *r)
 	if (check_refname_format(r->name, 0))
 		return;
=20
-	transaction =3D ref_store_transaction_begin(&refs->base, 0, &err);
+	transaction =3D ref_store_transaction_begin(&refs->base,
+						  REF_TRANSACTION_SKIP_HOOK, &err);
 	if (!transaction)
 		goto cleanup;
 	ref_transaction_add_update(
@@ -1192,7 +1193,8 @@ static int files_pack_refs(struct ref_store *ref_stor=
e, unsigned int flags)
 	struct strbuf err =3D STRBUF_INIT;
 	struct ref_transaction *transaction;
=20
-	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0, &e=
rr);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
+						  REF_TRANSACTION_SKIP_HOOK, &err);
 	if (!transaction)
 		return -1;
=20
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index 0567fbdf0b..f9d3d5213f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -150,21 +150,12 @@ test_expect_success 'hook does not get called on pack=
ing refs' '
 	git pack-refs --all &&
=20
 	# We only expect a single hook invocation, which is the call to
-	# git-update-ref(1). But currently, packing refs will also trigger the
-	# hook.
+	# git-update-ref(1).
 	cat >expect <<-EOF &&
 		prepared
 		$ZERO_OID $POST_OID refs/heads/unpacked-ref
 		committed
 		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		prepared
-		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		committed
-		$ZERO_OID $POST_OID refs/heads/unpacked-ref
-		prepared
-		$POST_OID $ZERO_OID refs/heads/unpacked-ref
-		committed
-		$POST_OID $ZERO_OID refs/heads/unpacked-ref
 	EOF
=20
 	test_cmp expect actual
--=20
2.34.1


--oesNj1Myabnp2JiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKjEACgkQVbJhu7ck
PpQwEQ//YXH+9EmudLq2J43RU/xvApWTsMHpX1dy9gRvvKBPY84AcKhGfj/P38uk
DHIqwCM9UHvfhZysviMgBgrL1jrZt1BYhqU84gdXRERc7qMdu8hE3gBg2zqAje/8
k2ClN1YoloH5sf8fDDFCnUlnZNuQyTQmpReXLfkRenVFm1+1uIweBXf/lhvY3ilq
vNNkfKuPW589T5XVH/4cbHDJz58hrOD+13xYNMwurSL960r7ZJ/NqeOqQ8yxKA4i
5caOTWA5RsSpzfA7zbkaxRRpKJugLYMG3vuTNWoaDAADa7RvLBeSOFtWKoBfoE0z
oGAKZkNRSonniiJcVC5Pz090hXlqYCpfFapBcx8iiw06kqWODPRDjNF9mtFBowyq
Q+AP63180EQNWz+PqKYg3/VJqZjZiE2CXsuHobhl5zWGb6ZrstDi4xVtg1/Mn1cM
/YCN01bWauptxHc1AV6Kv4qUP1nmbEebv/JoPVjC4z87D6bMru+nBLuoIidFr2a7
atse6CB/RyGNkP8963RQ70HxQQLCFoTV/vPuS1wUmny8cB05sJxMRlLh9mI4VGvT
WW0r+8BwW1jk8Er0rS1I70mrSLlDt1GKVTmOLxBEthDzyQboQkBPMMpvluEm0Lvv
CxgQjmYgev6PYcmP1ovLieS6MWHSfq4dXpwrLXLLhksxprE57QU=
=XDUh
-----END PGP SIGNATURE-----

--oesNj1Myabnp2JiZ--
