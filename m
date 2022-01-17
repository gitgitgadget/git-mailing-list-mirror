Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B606C433EF
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiAQIMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:53 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54393 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237957AbiAQIMw (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:52 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 30CC55C00C5;
        Mon, 17 Jan 2022 03:12:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Jan 2022 03:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=lcle+/jERTgceEHA6Sc9ld1ZNgN
        n7xqFnJkM5ZyQbKY=; b=HO+tCjGxMlPtpIgUMQy5hpt99S3rAsAjBsY02O/KkkR
        qCEEZMIvXXNWUn3ZU77bWGDTXILOMi9Yu1iJNleVx3tIoQVp/zTRkWf+rqUmpU45
        XJC4ju3Plgoi2wDpJ+VGc9vmwvdPliEII0swRM8+UYkp6NRX3WNf4V8NoRMjtrFt
        a/RmeG64XAAKlb6JQL95h6OzIolPtVJig2CQ35OPp0cKJH9Q96QLxuJ/dVfRHOkt
        iVwmGvxH8OIvobAm/SLDzbA68nXl3hG3NiCiR3uYLYIIrXZeIg/pY/riICHM9kt9
        tgZABKKsyuYVWYC1B/0nQSAmq5RKeaSA9maMGEBiNUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=lcle+/
        jERTgceEHA6Sc9ld1ZNgNn7xqFnJkM5ZyQbKY=; b=EmATkszqNo4G7dry+AFjjk
        82Pi8OMpnY18gZBfHi5XAk6wLQ3cTI/AdSzEgt1Yx1zprNL9cw3GwgzWqvcVXugM
        Y6VYr5X8WpjKpgNzEs2XN5iLJrYwrlqlLIMk4g/p3w00IMoM+pfG6I+mvch/SBVb
        PIT9rtOuWpNsK64Dq3XTsXzPlCuDxz+8oAITSGyroKFtnqpsFEa9a7I+mYRCuNfD
        +1NxERikT154Q1YcemqP7nsoqesLvuyVf60MlsqdA2qPAwZyWOhAmWlEBClywpnI
        UWHaGFTSyga1TLnlcIG6sCQ81OJtqu6lVtvzXUlL7zdOOt6Yncq6G88zA43hlTgw
        ==
X-ME-Sender: <xms:AiXlYUIH1KAhe-C9E_jAaDekOTh10TYVmAhGTWwmJ7mLZdmxHtNx3w>
    <xme:AiXlYUJ_mi0Ad957R9XLFwqdNpc_-qkpc7uBT5TE_npbvLZidv4BYjmPBEPfUdBVj
    wzaQBX8_PJ3cCbLxQ>
X-ME-Received: <xmr:AiXlYUvTVb2RPZa8cEIWczkD1ke177RK_ybYsDRpam1H8FUHISKUic3Ww3KW0SAnxNneQ_rzNyyMtlpoVMUkhB8x7Sy2b2sEgvvhygJCKQ3FXGD9eU8pAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:AiXlYRbFZ9HN4xVO0wdyy8JCSIbOpbyOeyFb--2NmvtU59hzQrmZeQ>
    <xmx:AiXlYbZyzGREBuik7t_FyE3LqnazTzsiyk0xiCa-0pnGzWPZflVIMg>
    <xmx:AiXlYdD3yq59IoVqsW6pDHLnUUwk8LIqVuTmvbDwfyjKW1YfI8owHQ>
    <xmx:AiXlYaXQhHHlSnLE9DE-UIoh8vquIah46tg9BbV-XJGH3aTkAE7p2w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 746ac70c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:49 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 5/6] refs: do not execute reference-transaction hook on
 packing refs
Message-ID: <23c344854e499d25721502405763d185ac2ae2ea.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZOuKpSVkYdw+ArHQ"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZOuKpSVkYdw+ArHQ
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
index 4d4f0c2099..565929210a 100644
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


--ZOuKpSVkYdw+ArHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJP8ACgkQVbJhu7ck
PpR2pg//XBBf4jNVKiQ0lNBWz68ZN/HDitNVlGfiHbgA1u8W+AqFGI9XJGd78A24
XzIUFZaCwkuET+yzwWX+qWGOUtrGfu+w1s074YslNunHiQm+TkPQQkYa+bwzVTl8
k/S8e8avCEaxWU2H6Fbu7rNMrmiqaFpuP9F5pzKENpgWjknf12MbuosT3XjV8F+H
OcJhdpIGDTcDfiAgvQnZfWOoSX5JVLs5LfKCeEM9tDNA62nd9wXQRr07gXN85HcC
DKJENfMcjJ/t/PDXvgFJE0e+7/VdbBU/tvPsJjNFyLxNCaSaSo1B40WtK/IB2e9G
kW3D/Y/+ZAvi/C+fbvnc78+jKzins4HS2gi4i6oFlhxr/sqMlvzo6RO3z5odiHWT
jJ1HCgkKO3MAeefdHk82YbHCzTXN7NmTXpwLvXBHdjeMbHbxBv/k6/fga4A79CF6
qvdRg6GY234bxpowlUYDmLUm82H+PqYcC9wiokCplg+YMvjEP7GRln+nWX6xU/bl
9zV7Lukysd2PUMw8sPU9qtR6l3VKyJ+hNwIumIp3W5AfOZkjJsKQEb6/iYkCxy/0
KMLRELYsnL+f63Jzg0D/gPLlEY3/8VLPG0TUnvJUsCtU2RdP0Kh3qScQJP/e5L33
W5uEGOhUrdg+pUSQN7EyjD8O5JDwi9kKADJIY7eh5UpJlA1ry+Y=
=8x9l
-----END PGP SIGNATURE-----

--ZOuKpSVkYdw+ArHQ--
