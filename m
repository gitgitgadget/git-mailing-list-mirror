Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89039C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiAMGLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:53 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:54423 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbiAMGLv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:51 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 9F5423200E82;
        Thu, 13 Jan 2022 01:11:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jan 2022 01:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=cMTsvQuey6uC/fPqJAElXJpPszk
        uHDlFE0eC1x5E120=; b=faGJKLPyXXAPXuPh/oRuAd3wLYcl9Ac8moOtzZ+ayLC
        VKeTnnDduCVxKIjzk8COu2E8YdG4S7EHk1ILSq+sN0oHfayxpojTxgf+FZCyly2d
        vvbqKOyHD3AEonukOQjS7l5mqqPVir1/g6pVPEMBwf95CfTsbEXITpETQNsFau/Z
        9TX5d4nrHrAlDzO9yqB4TUDaUOhJZhLEaL0QpqUBN7UB9HgyAKSeuxTnVu7q7ilR
        RY45gOFxMCng5WCKQQMTvD0EXUVQXCBnLZNqAKYF0FUau4/UafepG2av+e595Ayx
        SflSNy2/bdLyUHirKlnqUCUZFu4zwx8f9+TKsPNBOEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=cMTsvQ
        uey6uC/fPqJAElXJpPszkuHDlFE0eC1x5E120=; b=QPmSfkl2rowDr/PSeRPwhw
        1CpXWK7+WVEcumiH7qOCzXhmntQYspz30Ds4iiSNGOpSBdqLZISud/D2qbHQgHth
        HcWelHqevNq5mluqHVpxdLe3tMALWeCf14LBOEsz5vnr4Fqf51bAfgeBuM/kIx1/
        pWITuuraG+YpOvaJ19bTABMB1nnZxT2Rf5aXjC2wvmLI4w+zCJfXRdxSTQNmG6g/
        XqTB/0np9xyZ1aGTKoVlOold0yQKM8WRLcLzHOJBvlU2krfI912/5wbrNFZqclCl
        2ntuLYW2/i9dQSfBv2aybnYYaxMHHohR92KEYfYOI/BNyywLdCtfSmZnsrjdJ2yQ
        ==
X-ME-Sender: <xms:psLfYaCNz2_3AclDMOzg4-8okeHieoecDHUt5c-WL_dw1SZgNbv-KQ>
    <xme:psLfYUgpE6zlse9eQh0WjBC47GdYZc9ZWi1kpeKIF9c6PErseXCI-5DYp6Y87VOPD
    LGUGD_8ZjgBGQUxGg>
X-ME-Received: <xmr:psLfYdmb__Az5gqsatz43KWjux4bSo5hej-GDuAyIrLNDgSe0JqsTgQC6eVcuNuqL4RYO-nA5WoW-NL8n9f6SboQK91ZomUzKzPj3U2jqonJ4BlL9Ypj_ET7Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:psLfYYy9yWGRIXrp5Am7Jk_KlFZc0E5ySIMRAZ2NYQ0r_ec_R2OJyw>
    <xmx:psLfYfRAhUQrBnygUA4-DT32UmSbY31JXgYXGBVVaeDlK5hds57FYg>
    <xmx:psLfYTZ87t7fH4s97ya-WeuGAIC85Ng3n2tqljQIi-ksKmfv2RqMPA>
    <xmx:psLfYdOTBzcEevmw6BEkxs9AViDlDLTRrqic-NmwY1b4xZlafm7u_A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:48 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 42170e41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:48 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:46 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 6/6] refs: skip hooks when deleting uncovered packed refs
Message-ID: <279eadc41cda9ceea4c5317d6a4c358c18d50ce9.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0PwS+CZNaMUviVJ1"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0PwS+CZNaMUviVJ1
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
index 3c0f3027fe..9a20cb8fa8 100644
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
@@ -2775,7 +2776,8 @@ static int files_transaction_prepare(struct ref_store=
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
@@ -3046,7 +3048,8 @@ static int files_initial_transaction_commit(struct re=
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


--0PwS+CZNaMUviVJ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwqIACgkQVbJhu7ck
PpRV0RAAh6WAqL/MZU8jTd3ICMMY5/csnDoLb9wQUoxm+J59V03loc0/Twwo58l6
GmA+bGwNpnQ6M3jhsTl7sYui6mVEGPszKQGo9pPmPFWWPk8lh3UPuzdBkFCx50oz
2MT+fE3rvRGf/1sOU+NbLkpCzfPTzh0hj68AGeYQqZm3nnjGLn68RC++qE8u290E
jbYfXxJrIvShzxNE9A1Z2aEsO0nn1oT9VKn76qR7ocmjD1fnSWxVucReTvGXB94+
xgxx1EEepjhaJ2/L621R1mEny3Rl2ljb4A1cOCoHUQGn2MNzpuByxUTsEnmy5rmJ
DUQAT/gMiWyat5eNcqh+oq02XI+XE9BRWFp/zdXileYmJSuSBXHcnKcGZrdnffXN
xwgiKbquCXLjgMHfD4+JJUZnXpzveqhU9Zg+WqZaI/ubBkMGXBUYYmEPR/dSwsl3
z8ZDnOLS4DaDiitHiE6zejZ4DVM71+DdxE88MAj4mNRY8iJr5m64WIbPIAMaJxfQ
mGXOdJLyfUZ9Sv0MwI/BTHic+sG/FWI8z1sB1Syrjdu9mRnWaf0963RjcdgIWPKw
Y+gdYBHZ+S1/9Uhv7VvwQr/G7vQBXkbNwoPrnkUosbQppBpyz9t/rGXjmrTwt7zC
VJRUeVOmAohukstycW5U2X6xRAan4Cajml8Q8bOMAOZbHPiuP5Y=
=t+nZ
-----END PGP SIGNATURE-----

--0PwS+CZNaMUviVJ1--
