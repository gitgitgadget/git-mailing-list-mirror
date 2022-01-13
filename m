Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A15C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiAMGLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:11:43 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51389 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbiAMGLm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Jan 2022 01:11:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9349A3200E5F;
        Thu, 13 Jan 2022 01:11:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jan 2022 01:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kofozq5wgu1I+yJI9Q4D7hrB/Tu
        dQavTXiH8/SvSvRs=; b=mha58rKbjPwhO4Xvb2JR0fLdOMIbL7tXciDoNkxTMCm
        UiUZ5qf31UUnXHP8e6Zfm778i4zQzeTVb6L03CjnZZorSteqbekK+3HREpK758A8
        sHzAwGuvhfX3/HEXVuK0c1eNWTC3Vpp7e4yuHNigdqAJis+qL0S5mQ0nw4pbLVTc
        NUoZfnyst16g0LuGirZ5No3kLMhUzkUgrfJYPN2w23qQNMylZ8XpiR0zAFidB/0b
        jVcrSrE8AZq6GFvGfeZ+j48Ei+yyzz/0YMNXIZwFYD/3NuLEuSdK2jCT/m26O/Jc
        SlS/87gIKaFbGemvzwNZsT6BMijpOEpw9oGmUNxQ9Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=kofozq
        5wgu1I+yJI9Q4D7hrB/TudQavTXiH8/SvSvRs=; b=nJZQJzzpiO1tCZhTfZ8sgO
        bsXat8MSelgrwcH+nO58zAqWh4Bb81160VcbtK1zj9m/X9B8TfkyRQv9Cso2jEzK
        /nJ3VReG/Nt0npZcdyMY9MuPOjuek0KTjrH0Tn5NreBTnv54Q458bT6RxYkhtGdI
        +gUS+h7opOQPkrOCnCXLi9Z9fe1vEOIJ1+18egxBG0tYLc2qJR1GZ1L1Tivz6KmQ
        FSAe2s1W6d4hmH68kAahol3zmF0K4MwAWzqO7e/5sO5eDxNgCkL5sHcwwFKxjmTU
        U2eI8oi7nQ6YKtnmyPmnvVUF5niR5qePq/7Ixp74xF6AgbwYR3kpcw9tg2zThxtA
        ==
X-ME-Sender: <xms:ncLfYRxqRB9Rj-WV1XtVZjpc-h13e4T7vzzQa4oUzNyQKw-iujkMjg>
    <xme:ncLfYRRyPCmfwBQN3bNur4mqT81yosKzbApYkFLoMsnQIi2mw-pMe6t8uKX30DBNi
    AQ6AvWnIOj8nFF3yg>
X-ME-Received: <xmr:ncLfYbXiClf4szjvjV5Y3HmNJps4aZqIyazaCL1fC0raEG3vn-_YS5Z6uEuuDSZOgqK_8tZCu81FJYHtKpxFJBCoEnggNT8xOB22lyNuZ9rvaX3tjbB_ztg_XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrtddvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:ncLfYTiREBGqlwJkR-wRpwz7A9_KIfB7c1SbhgHdrO9roTOA5e64hg>
    <xmx:ncLfYTDpadKxSJeGONW_rFbPgZeZzbJb7g7N2rVHWjUUlLpv9mKstA>
    <xmx:ncLfYcIFwNcmyAjmSM_5vhE4zrwhBpt0rkk6xNoPxy2ycpVX1pk0oA>
    <xmx:ncLfYe_j4oiEwH_oZS-LsXykOmLCPKL_eU6g5Sfv51AEew9_xMM6lQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jan 2022 01:11:39 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id bee9e227 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Jan 2022 06:11:39 +0000 (UTC)
Date:   Thu, 13 Jan 2022 07:11:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v3 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
Message-ID: <662a6e624420d405d9459cec196e79280bf238a7.1642054003.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642054003.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uO6kKpWA0ItetuAC"
Content-Disposition: inline
In-Reply-To: <cover.1642054003.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uO6kKpWA0ItetuAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add tests which demonstate that we're executing the
reference-transaction hook too often in some cases, which thus leaks
implementation details about the reference store's implementation
itself. Behaviour will be fixed in follow-up commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1416-ref-transaction-hooks.sh | 64 ++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hoo=
ks.sh
index 6c941027a8..0567fbdf0b 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -136,4 +136,68 @@ test_expect_success 'interleaving hook calls succeed' '
 	test_cmp expect target-repo.git/actual
 '
=20
+test_expect_success 'hook does not get called on packing refs' '
+	# Pack references first such that we are in a known state.
+	git pack-refs --all &&
+
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		echo "$@" >>actual
+		cat >>actual
+	EOF
+	rm -f actual &&
+
+	git update-ref refs/heads/unpacked-ref $POST_OID &&
+	git pack-refs --all &&
+
+	# We only expect a single hook invocation, which is the call to
+	# git-update-ref(1). But currently, packing refs will also trigger the
+	# hook.
+	cat >expect <<-EOF &&
+		prepared
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		committed
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		prepared
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		committed
+		$ZERO_OID $POST_OID refs/heads/unpacked-ref
+		prepared
+		$POST_OID $ZERO_OID refs/heads/unpacked-ref
+		committed
+		$POST_OID $ZERO_OID refs/heads/unpacked-ref
+	EOF
+
+	test_cmp expect actual
+'
+
+test_expect_success 'deleting packed ref calls hook once' '
+	# Create a reference and pack it.
+	git update-ref refs/heads/to-be-deleted $POST_OID &&
+	git pack-refs --all &&
+
+	write_script .git/hooks/reference-transaction <<-\EOF &&
+		echo "$@" >>actual
+		cat >>actual
+	EOF
+	rm -f actual &&
+
+	git update-ref -d refs/heads/to-be-deleted $POST_OID &&
+
+	# We only expect a single hook invocation, which is the logical
+	# deletion. But currently, we see two interleaving transactions, once
+	# for deleting the loose refs and once for deleting the packed ref.
+	cat >expect <<-EOF &&
+		prepared
+		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
+		prepared
+		$POST_OID $ZERO_OID refs/heads/to-be-deleted
+		committed
+		$ZERO_OID $ZERO_OID refs/heads/to-be-deleted
+		committed
+		$POST_OID $ZERO_OID refs/heads/to-be-deleted
+	EOF
+
+	test_cmp expect actual
+'
+
 test_done
--=20
2.34.1


--uO6kKpWA0ItetuAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHfwpkACgkQVbJhu7ck
PpR3/A//RlN72CAqN8PpvJi6XhSuZKC/gJeXXQRLcIc1cpxQkKXX7Rn8K4pUpbCD
aWTgtNjaDca/EkcpvPGAqrFUv+LkKbZvay55HxCzPo8U+bAwpSamD28o+lXXF+Sq
sc1HG3f6z6KG8D3vcirj6vDL5bTQntLvwUD4ODHyw2MR0I5tuuOBnGw1dgJ1geK2
LWWFck8FzH5HVzghukMINfhu2q/9SInqi960Z/7eZBCD3yZc8UH7Bn0zm8PRgAx+
pyxk0HZ+URTc4w9TH8z82rJcDyLT9ZOXEor8GqIoDIrCvVbtbLBIT7nO7o6wg6vN
lyJ1Z0ID45uapjjAZ0C4066XQJ0f42wfS1BLK9AfAe0Gxdg/H5FE5FHgPpK9u30D
LX/Pj/uyQvzt3OQH6WP+4zLLOsTRIn/zFp6T121OIZhA/FmGgzzhiaELAdoL1ZDp
wRtxzmBaxYsyjpvDB+l/0yq3hjiGuP6Ke1O4Qq4xBO1vALL1ZG0xCelHjoNy643q
ZjdaD1pPAVL6EA9CAJ0lJK+OSZBHYXt4tozYuvlLrxnUEsrQTWkSfLlaenmB//NQ
pz2B0Opox9Lo2t1Ayh8b7nmks6DQIewkhMCJKsLyKbmSimPm47U3UQzkgPXTM7oL
smBeqG7vNDfIUB/OlhL13/FFTW+AGKKEDZKaXsuxiZVzlDqeOgM=
=s3xk
-----END PGP SIGNATURE-----

--uO6kKpWA0ItetuAC--
