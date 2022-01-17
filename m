Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA88C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbiAQIM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:56 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40621 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237970AbiAQIM4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:56 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9EB355C012F;
        Mon, 17 Jan 2022 03:12:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Jan 2022 03:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5L59ZEYboVBPWID//vXwT1PEYG4
        VnruvwNAyldgUBaM=; b=Uxg4OGZdVDkkTXJ0tAiDtHbPo3WGvGTpFK/6SU/YwTE
        5d4eehkxdYVm3axrscJAIrlCSrbf2iyWe8KA6DHpxgcIiCTCJ4JkjbfHrzV0I7gC
        wYKS8C6Xrx5+fBeBRK6F5fsN/9xD9rnCcDdhTVXpLOoqyjEbggHgMJw9NMPkvZuU
        uK+x42K8kAQtVzlg8HZysNBQmtvTblX6h9nLnH3O6AWiHwEIvCEVXdMKqvbDvIBv
        DejT9OheOqSPdYVT+++YAIjobIEBDS1eU8HYEdM6zrsFjMUoSwtlOnLgU7iNTYDZ
        r30p6dZOpqp/MLP+a8m6Ob0Qx4IhnW5qCSpN17n1mqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=5L59ZE
        YboVBPWID//vXwT1PEYG4VnruvwNAyldgUBaM=; b=cOU4AvJEpb6PKFKEfTQwKO
        FMs1z1vTmOHCAIxRjYWG1RPPSmTa/+q83vQoYpRIZmSZ7KIajED8phlYCYRJ+IkQ
        /J3TfiL2G/KNXmS78bTjL5UhYzzgEfde0C6IPi4i1K7H9XugDFNaHowmm5faP741
        Tu6hbXrxMBhPIz8Zy74h4rlyYSCYCr9i9qWr41JoWxqnDnFjQ/3OQOLOA6EpvcxZ
        HpfWjyELqw/NpJG2SRYm9LC6ljnYA8MNbzrF+qs201o0itTwAySHs4Aj3de+IcsC
        SQL1nBgwKH9vqk0IESIwCfmXRcbYAZP4/xZH0XuW1sMVYHktn+k5gLT3V7t4cU0Q
        ==
X-ME-Sender: <xms:ByXlYYlSX2v0eRhd4pIXtXrE5f55LBWY8qTH4SYLdKHydGP7ioA4xg>
    <xme:ByXlYX1W_4cIduh_Yeut3n65dYAmWwuNn6R020BvRjKgtwQXe8hrs4nO4VbBeZqBi
    3FDdDICMQen3yfAyg>
X-ME-Received: <xmr:ByXlYWp5CGjBBeU6DTlk8Qpnt4Ov2es_mYubErNf4dr6O3vddI2hLdKQ6ny1TSy4pC6LLJvdMzMoxNa87bJby6H8FrYZAGVqTfvao7uUatI_6nRx7spg7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:ByXlYUlaTAcwLKi5JzPG5EP1ddUq3rlpWn4CKxHizMf0KXW8ddZKtg>
    <xmx:ByXlYW3LL3orVlHgh-oDRdG3rDfTVbeAeuEemr6b9bpP3TCqaqXFZg>
    <xmx:ByXlYbsngIbQtn0WpQSKLtsNtt1Nla98rUxLVew1qBNufTJL9p8gLg>
    <xmx:ByXlYZTMd2NTRrTsJUEX_Yvzp0WUOR07NuBx5Yb5Luhr82oUNTA57g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:54 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id bb0e01c6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:54 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 6/6] refs: skip hooks when deleting uncovered packed refs
Message-ID: <d6c7d765aff13df449d61f0f6efbeb66fe86006d.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="od4U//xy+qYMoQyr"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--od4U//xy+qYMoQyr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When deleting refs from the loose-files refs backend, then we need to be
careful to also delete the same ref from the packed refs backend, if it
exists. If we don't, then deleting the loose ref would "uncover" the
packed ref. We thus always have to queue up deletions of refs for both
the loose and the packed refs backend. This is done in two separate
transactions, where the end result is that the reference-transaction
hook is executed twice for the deleted refs.

This behaviour is quite misleading: it's exposing implementation details
of how the files backend works to the user, in contrast to the logical
updates that we'd really want to expose via the hook. Worse yet, whether
the hook gets executed once or twice depends on how well-packed the
repository is: if the ref only exists as a loose ref, then we execute it
once, otherwise if it is also packed then we execute it twice.

Fix this behaviour and don't execute the reference-transaction hook at
all when refs in the packed-refs backend if it's driven by the files
backend. This works as expected even in case the refs to be deleted only
exist in the packed-refs backend because the loose-backend always queues
refs in its own transaction even if they don't exist such that they can
be locked for concurrent creation. And it also does the right thing in
case neither of the backends has the ref because that would cause the
transaction to fail completely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c             | 9 ++++++---
 t/t1416-ref-transaction-hooks.sh | 7 +------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 565929210a..844918cbd8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1261,7 +1261,8 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
 		goto error;
=20
-	transaction =3D ref_store_transaction_begin(refs->packed_ref_store, 0, &e=
rr);
+	transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
+						  REF_TRANSACTION_SKIP_HOOK, &err);
 	if (!transaction)
 		goto error;
=20
@@ -2776,7 +2777,8 @@ static int files_transaction_prepare(struct ref_store=
 *ref_store,
 			 */
 			if (!packed_transaction) {
 				packed_transaction =3D ref_store_transaction_begin(
-						refs->packed_ref_store, 0, err);
+						refs->packed_ref_store,
+						REF_TRANSACTION_SKIP_HOOK, err);
 				if (!packed_transaction) {
 					ret =3D TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -3047,7 +3049,8 @@ static int files_initial_transaction_commit(struct re=
f_store *ref_store,
 				 &affected_refnames))
 		BUG("initial ref transaction called with existing refs");
=20
-	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_store=
, 0, err);
+	packed_transaction =3D ref_store_transaction_begin(refs->packed_ref_store,
+							 REF_TRANSACTION_SKIP_HOOK, err);
 	if (!packed_transaction) {
 		ret =3D TRANSACTION_GENERIC_ERROR;
 		goto cleanup;
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index f9d3d5213f..4e1e84a91f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -175,16 +175,11 @@ test_expect_success 'deleting packed ref calls hook o=
nce' '
 	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
=20
 	# We only expect a single hook invocation, which is the logical
-	# deletion. But currently, we see two interleaving transactions, once
-	# for deleting the loose refs and once for deleting the packed ref.
+	# deletion.
 	cat >expect <<-EOF &&
-		prepared
-		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
 		prepared
 		$POST_OID $ZERO_OID refs/heads/to-be-deleted
 		committed
-		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
-		committed
 		$POST_OID $ZERO_OID refs/heads/to-be-deleted
 	EOF
=20
--=20
2.34.1


--od4U//xy+qYMoQyr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJQQACgkQVbJhu7ck
PpShpA//ci1V65CHTg5HPxV/kTAVvS65B2GHJ3Qxg980ixTw0UtcHj7oRZNrS0RC
ty3w+LrN+ghtKkW6trP971egXyTVZsHCZDb17INIUteDGFIX6x3T5a0Q26Zf8c9F
ntkYsYUowZZgyPYFyB6nyZuyqv0uCuWMeUxrDSh5n6RXIYOm55yPh7vb+pDaN+9/
/KV0st+HBaeoG8cqXq77LiotskHjH5hc6rpjnYTwAW5e8DNxSihu/e4/s6zmXztn
+bieZXlBx2Q825ol6a3ML7oYAzA5feOXSRJmn9+vyq91Ds9dypX1rTIw62eRhtU6
M8uGFYDkf0s1sy6Dh+cR+CUGyBaxHEysugfOVKjrr87a9SRQRNm39gEeNBR/Awoj
FEGq7hSi6uHkDDCvb9U4w49ShOQj5EHChjTaDDkSzV8N4yT5zRPsCsIkETEO5Ygd
2Sl4J+6BjQptarbwRmfomTZbQMyt2x3cAB9bEc/L4952j7ztIIlJl5PTDx2u4tTo
tXuq/y9GieSeSZcye8sCUPVQS5SUSIN5aDLvbNsv4Y77Sr2Yq1Zc19PxG5UCqIwu
WcJR40r6Rs1t8dWNKGCvdgUqvYuZWjwxx7oGKPTFtAXbccmbG7QzQvPn8EmLUUA+
vZiDiOH2foxPBcdi9Ch7GQ7FAzhtEWg6CkuRDZwVO4/OuikTIr8=
=BFj3
-----END PGP SIGNATURE-----

--od4U//xy+qYMoQyr--
