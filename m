Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FC5C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiAMGLr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:47 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:60007 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbiAMGLq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:46 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1D1793200495;
        Thu, 13 Jan 2022 01:11:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Jan 2022 01:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=F5DeawsKhb8Q5J+fCd9Nx94Yg8+
        RIlXG/EsPuSrtfVk=; b=lLQ/yqkfKbmcNfrzLUm2tz4hHI0pUova8mZvEBBybtY
        2zsIAx/w8+1unnUlB9cuz1HAF6f/qeLor/zYax6y3WbMIMbK+n8NmWVa7LcZd3tq
        0tEd2VrZNOnOMrdw5WG3cN/HxBfoZOxn6IHP/WbzyCZvzlXTjfhCxlBejb25KuY/
        RFI2VcjkbcHxtTj/b5gnB9q8gHAbzGxu1Dv2Ynw3xJYQBh5y6Hlaa6KVxYKWOPy+
        DuBs2OFoomZX+g/ZY+sSYf63k4xc+/CJZXOPYwPQOKvZ8etHkRALiZqeXdnBAKzg
        Icc6py/foXhHfn+cBH2hRWAdiqJ2e9a6jZjSXbqCMqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=F5Deaw
        sKhb8Q5J+fCd9Nx94Yg8+RIlXG/EsPuSrtfVk=; b=UOOFKazSmljQ7KffV8Z8s8
        fF3YdbVSeOQwb2G6+VaPNg3ipROOE6ubVP0At2qoyO/MH84Y3RFbKRgKQ1HBOH4+
        NEc8GvHKa/Vct1KjmKfyLBKmRPuwdm/ZzVYM4VLbDwzLBercvHvtFUnsNBf/Fiq5
        Hr23ydJi0xnN7JKSMiJXvJoj7c0tAd/hkf7MPV1K6REv+8UGc6Fzhthy6mEc2+Ww
        lps0AHusHWA8ZDbjAluQccBPljU9nL06DrMsAlM8NsvJN9pFYO4e6PCKFz+MsPym
        sZpxIGVitGL7SDLzFQmbRWdOzP7gLlEqDIAwuN4WoaHaHS4P0JrcB/B6Fzi633aQ
        ==
X-ME-Sender: <xms:ocLfYfb1JVOlR8pKySCsu4sKskMWG4FBSOfgX8eKx0YzYizkAfcaPQ>
    <xme:ocLfYebZ4txSiKtWtbJnh56_FywHt4eJeuNhnTTD3Iz0nUsF4s5vzR7e32XMaM0Fj
    tUr_MvX06E2Gjgn8g>
X-ME-Received: <xmr:ocLfYR_DwyeSGKRKZvmY7fOav2TQlIgtZDznevSnjoriQavS_W7vpLSkii7e2-0w_QMfS4f0u1otR8K-4ggYVrgweQV5wU4cmuLQqKKZro8lxXH4Uf_BhuQDBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:ocLfYVpaH9d61feYhgggwu9t57bCCL_3ULqAAlqtcNWkzG707xxPhQ>
    <xmx:ocLfYaoYwlZ9rxc_pDsYiCkBOQkCpwuokFDv0Rh_gGkhm1dgroDnvQ>
    <xmx:ocLfYbTYa_yAMLkX8sRn22zwWQkgT7D5Ei7VcggJ04zHGBQglEwSOA>
    <xmx:ocLfYTn4y_nvkSO2TOVKVPXaUaYnU8hZiJ63CWXykU66HGj-h8fptQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ac3dfee4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:43 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 5/6] refs: do not execute reference-transaction hook on
 packing refs
Message-ID: <d83f309b9c988d7cad9524ac56c0b4c81e2d863f.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q1yVc1KGm/xHOX3A"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Q1yVc1KGm/xHOX3A
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


--Q1yVc1KGm/xHOX3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwp0ACgkQVbJhu7ck
PpS2fQ/9ENZgDUUz9ghiHXFEe7ZW7Rnjesf4ZcRWDJkvIbztQy/ASOsbqshT/C21
A6ChN0ROAF/CK7ypRpegDulP4pfgBqrbN9gvNSjMuXaW3BEXl4KHM3DBv+MHySha
nNme8cynAkwCmQBtBu3YPGBRpTwKcck/Gsg0+bAvzFQOmObFzv6/F2O49Tp/DYPu
HK/KtDCRc2YfdN3CZi+8nW19W9ZnmS+KEUDWL/6UJElqtUhTSckHaAPH7UeQUEdP
gLN8Ini/uPY44Uoc0tGS3C+gobHWZVMTlot/eyXg5gtAduMRsRy++GKG/egH+Y+b
/iQ0Hogu4Jfhl257jbTFQ0fvPWRZt9Ocmg3z//b1mMLgVgxEFZxzqmy75yUz5Ghp
QgQ2lPtF8P1/717F1nvBMPLUG9rGHlEs7BCkqcD2vvRXyeVObXXgHL4LZ2q/1WbN
5YcDt2kYPEpJi614YjLPWzmfZR06ShCanhWYtq6uX9tV2yRGZYlBMexXFYc+TbmE
3duU2IqokeIm2aYhETvXiwVSkg2vMK8qfCRrdPnCRH1hY3weTeb4V61NJfnefjKY
VlmidnXMW8MGMT0jtKFw4IRVWuAFPcIvp5TfvrGKJm4H9Qu9VStN2QwjloB/gHJK
PfQ1NpalhBWvydG6EXW92g2iiEwNs97sB5Wt6QGENEaAKo/lieg=
=DNua
-----END PGP SIGNATURE-----

--Q1yVc1KGm/xHOX3A--
