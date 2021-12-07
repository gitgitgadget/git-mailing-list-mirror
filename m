Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83460C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhLGLA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:29 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58283 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbhLGLA2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:28 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 8605C5C019E;
        Tue,  7 Dec 2021 05:56:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 07 Dec 2021 05:56:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=okJ2Nn9XAaNmRwqOFXZiX+YiI1E
        otfryC/lDqgAC8Zc=; b=WZn1tKowUngYxHsJrWU/fWHpoTSbKvQqkMdQ/WowTqr
        9wKBxutB23YF1+hHPWISOlfDixVOoXdVp4DAv6pF1FSG68Y/V/1BRgpVH0zwOLvR
        jlT6e7GlACqBJ7V+GVKK43KmPeGM5RTdmzmGHbyoRD+p1izfkHrvSPJrNSvs/MIL
        sZmU+ETzljTGJB5brFKYSE1SwHaIHcW+3CTlM4ajKw8SdrRaAHyqrSV0okDW0FXY
        esF8UxzBHfLl4jIjLPdzXvqTiY5bP2WPx8wgjGxdYVQEkm1pouLMCghpLstOQ+4/
        4d6j44lRDtbIWSpFnYPbIITcMxODydl7Eo/dzpbnDqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=okJ2Nn
        9XAaNmRwqOFXZiX+YiI1EotfryC/lDqgAC8Zc=; b=VkJUy7J6bO3kgHPpclj48Y
        ahsPdz+0yW6ohyWt3fteiskCF0EItb0Q5hperWvuk4qC2lYQhtqT501OAg3r+Ece
        TwkkcirX6cAzlizuPs+VfY4ghEs04cxBe8P951YiHNPZoUdWZYblr2VmyqKOphad
        yV11gDaMsfWCsk8uL8guf8Y7+2GvfsC2PpJG98RiZYE0aU6uwgkEn6rZlnu2Gga5
        CZqt+ec/XWStKEjJRn/FekBRsboqkxItczS1nKBsbbgmfDspYXzeLxW/UVbxepud
        qHLcrUTl/KmLDxo2+WfSUnxPUokWlKA9S/DdkHOIARxfagrULoc0IVJ8iiU/dBKg
        ==
X-ME-Sender: <xms:-j2vYdjIbmsnbKCMHSpS-DIOCuR3yP5_E6MzkOdwgBefI5rC7tW5MQ>
    <xme:-j2vYSCwswX11C7uPP6TRj14p1xJ_6Ht3CTySrRWTQ1GAp4T-Ci0rzes8mkPDPVDV
    dnGbgzZrtiIJNx8RQ>
X-ME-Received: <xmr:-j2vYdEVn_KzSUweB6JccLPGUpf54qVyGxGozSgsl9dCkRn1eTgwzYrRzRW71QK5-rKC2GW2fh6MF8laIZ8u0t9SZsV-RqjxzkXtmdkI0tzWEbqwBBvtYvk->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:-j2vYSR85dpcAMU4CnxtifVDmtMhB6PBJ9O9RzA2eV1ElRbqXhtrlA>
    <xmx:-j2vYaz3sUbcMRWaimjiX9ZBo_zwMWUzFZv6exLURLOB_zIbjAL_YA>
    <xmx:-j2vYY6Ywfmk6GExUYEIdMcIMOhLd1lwCcasNiPMGgnzAPI73W4qhw>
    <xmx:-j2vYV_OawJnV3-Hs3ToExgjaPI4uDnORtEKb7pItIA6rnf-S4xdCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:57 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4d304524 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:36 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:56:17 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 6/6] refs: skip hooks when deleting uncovered packed refs
Message-ID: <04d65ff7991f880920a1fcaab3e4450fad0f15de.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gf1Y6oVonu+cmDRs"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--gf1Y6oVonu+cmDRs
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
backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c             | 9 ++++++---
 t/t1416-ref-transaction-hooks.sh | 7 +------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index f2bc72f81b..0a2b5ea5da 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1262,7 +1262,8 @@ static int files_delete_refs(struct ref_store *ref_st=
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
@@ -2769,7 +2770,8 @@ static int files_transaction_prepare(struct ref_store=
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
@@ -3040,7 +3042,8 @@ static int files_initial_transaction_commit(struct re=
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


--gf1Y6oVonu+cmDRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPdAACgkQVbJhu7ck
PpTRlA//R7jZQuM7CL+RDpWYB0hJaqF+MPmTZzTZKzShBrVSX/WFkuNHZY0EKC8Z
LX8sFOxCiX0yN3KydR1F0AtnYOqnBTiJ2F7BmXPrHpCqfiZuyIf4ACe4x8w/IoHH
I1w8HW+511D4DAeWeUB2M/Zb8jZteypx8iKAxeWoa7V2er4U7aHYA7m43h/yqZTK
Vxa9ccetV3oBdRORxbdWqZKiHUUaJdvLSwGm6Q7KnMCXhmcQlt944jkgJtvSUWFv
RKPNswg+0a+myjxsBn8MHGJBCeGt1uAvaQW1qf8ymXWiydFpRa6hMBziQwiD8sXU
9VNoAHPmfHuswdtnK8HcCdLpPQGAz1czcaQo5dOI1KjV+ZsECbjOB2ZK5mWrzgAu
ntbCfw6iXaxfYHFs0w+iHBoi5Y4cmA/4XnYYTyDl+UFCNkjNVbF7ZySDNw2GWmYS
Q45pZvobh1rqIgzgjvC/vVZJwmW9g9D449vIJbyXN/gqzpTWNt0CmK4/wWqAr13e
CqrkOqShwvKrmxrafuugWWzYjTOGuduNfV2pQKnUa/ebRebF25JSqS/0qEyuHtsj
tBrDoNTZsIaTJzfbjbWpEuo76X3HuycvVTxfihd8fk/05sRgaseLyrmqUTD+jH8F
4CHIzFT9MSIlh68O6l/0MDa/Vkrm4C5RVFwfWTjPW7G839xGSWU=
=oEkS
-----END PGP SIGNATURE-----

--gf1Y6oVonu+cmDRs--
