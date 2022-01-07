Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB442C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbiAGL4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:56:07 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55639 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238255AbiAGL4A (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 06:56:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CC13C5C01AE;
        Fri,  7 Jan 2022 06:55:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 07 Jan 2022 06:55:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=wo7blteufdf9DqiMliUrzUo3hoE
        ygOBQvEVIwcbd/T4=; b=kRgK83VoMjlZ8z8c241Z4Bbb943AhqE6VXNvP23q+Zc
        +D9s8GeyKi/UQNXDM5ftPOeg4QPnGB9h1K+SRQ5JrntSZQFQdna4ah2sGxouHBI3
        ZWZawlonJ6YblUKHAUY0RQ+8rlkZdpz2erbtQAkI9M8kDcJOvpX0tvRT+xOLOo1+
        ViJR3AnD/17i7klNtBC2/zDzJOSmbG7ESTK91YDaNUWEcX02XXpDu/ZU6qIprshA
        a2WaouYgDEKaSFZGWd2j8aK0uEbs0tjP2GCgY7B+TdDzLRqwfxiCfyj0PgVaXCLy
        v2Um0RtPPwUz7bTqb2bwjI06iIBpGuaKcIGldToahQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wo7blt
        eufdf9DqiMliUrzUo3hoEygOBQvEVIwcbd/T4=; b=igL6DQ3HmPCpSfFhI3TT9m
        G2W21J+umKYwDhZB4J3NdDWjCuiwUizsUTW6yevAEFtOusRMxsQy0BytbfeNnY76
        aUjieGr7Xr/uK9BKpC4UIszzAmLLOH8Ygt+zJ761Z5CQw/HwIVGiz0qoLp3rbANU
        fSlagZ8K2iaeOMfVJKmC9oRSsJlvdkBjWOeduE868lm5Ztde5o5CO0nWvK3+YBSw
        k/KevkX0jHFgpBsN2UA5rqI7MK1y98TKq4unND+7Kczbimh5YeUy4o4+h2TZJuOS
        aIOjcGNjhHCKLmga3e+T2YYWWTC5ANv77JRx4Rn5zM+ynHBWAR3VuEjDU8mtHPcA
        ==
X-ME-Sender: <xms:TyrYYWo8l0zIsHn9__Kltxg-EfUABK8zPbwK9kHWC9sJvOZ91jqXyg>
    <xme:TyrYYUoRWmJc35Fp_yRqA7_HwXAlc3VtkPYNru3O2TvvTb0Q_2_SJddfYYSNktEav
    NkVbC7MImGDg3JEOw>
X-ME-Received: <xmr:TyrYYbMwet_N0IWiTsyMAcpJ_-wzREdygCZY0jcWJ_61lflmoTYhozdUYwLZDBcmOX-0rV2ZelwSLtk1pdRtvvqdBr0BxUq_YUNuB3mEx-sBylaUClHyIwo2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudegvddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:TyrYYV76rlINGTOreEluAl0ei2Ja69iOgwOty_TU2OcN1YxcrL6Lkg>
    <xmx:TyrYYV7SXPgxdgw414vUGL5eGRLIc6Vv19f22xRdVHcdZA1s96YyfA>
    <xmx:TyrYYViiFBiIJC1C4nN7pMbHcxpVgsfv3qgmC_IDwQ98Wnm8frm5ZQ>
    <xmx:TyrYYVGNADHqmRwQUws60_j4rxcCZiQJZ4E39jslP5b9zP9VgHFVzg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jan 2022 06:55:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e1c27597 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Jan 2022 11:55:57 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:55:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH v2 6/6] refs: skip hooks when deleting uncovered packed refs
Message-ID: <0fbf68dbf434986aa971961e20598675b2194d51.1641556319.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
 <cover.1641556319.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sV7rOx+NkdoNslKe"
Content-Disposition: inline
In-Reply-To: <cover.1641556319.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sV7rOx+NkdoNslKe
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


--sV7rOx+NkdoNslKe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYKjUACgkQVbJhu7ck
PpT3vw/9G875Z5jRCKY2ttuBwTwaFKP0XrFf3anDgjMtUdO1ia3gdGSdZOG1oNuE
DIZv53pU9vwzzD4QnXh7Vfd+FPrjh9aztwYzDn0dVkTtcxC9ivtSG8zT3InsStpn
g2j/SK4BMPCkWDZ0ZHqcuFxBVDtz5BAyrQvbXaYzWJ68ojV0kTGMkOCaS0K+W0qN
0KJjzK+Ah1kPMldFTp2on8C7XxIwKqCzl6/An1vO9/H/kk/b5/435EL5mZcHb/h0
+FRMpgVMXzzg5hrC0TaEQ0mBpMj0tr0kirQ7mgwPl6rQtvy1bYgmvuknA2NEF6Gz
jivZ0Sqd+yDoYzUbFp/PdUaMvpVCBt1CM3HeeiZf9OptKiyMTaVfvUg3WXrp6Y8J
sMm2pzyb3Weucol7RQwiePJ2OcOAkmDw21wyJaEERJofPft5Gmf4sS2DOiuFZm2W
pvw9qvEG94KbmhI/eP2QHlea4zfgf4QwSs+ZoH4vFhPYcL4TbOOtLk9H6HgpZim0
Pn7K2qFWdZIFkI+7+WPPlgIDVph8gIbN6P8p9gNxtKjIn3MiRzYO21kpsBKaO972
ZbOc2/4ugf8VnZVR7wstlbho67LikCQ393DROkb5oYdmx089/ziu4TCmec184Ez0
xGZaLQyWFOANzL5llrWfGAQ7ZEyLWLnDtUszG00DyWJIS8RkpGk=
=JSPv
-----END PGP SIGNATURE-----

--sV7rOx+NkdoNslKe--
