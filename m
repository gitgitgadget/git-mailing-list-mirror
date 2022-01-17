Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC8C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 08:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiAQIMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:12:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56063 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237951AbiAQIMq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 03:12:46 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 821455C00C5;
        Mon, 17 Jan 2022 03:12:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 17 Jan 2022 03:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=63dCw0k3urB/vN7FoEkXXuzEdUC
        J+D7Q45z6b/rF/go=; b=H9HFrRSVfYz2DZ116Pz1B6igQosuGYD4h6/QODD4omW
        QxLZBXonc1c4mkEOyKZznMoXtgMeUG7SIvy7I1mHyxwroUabUWxekAhD7lO1yFns
        9T8OWAPKFRlqaDJ4vxpI/PZXT51POt4u3Yhxglb9QMWpMPiPWQsBdZwssd7RbxaR
        D+7sXM4LotclEYvfTvHt6CKyrfrTqz6A3Hhw5HholaNNEwMc8RjL+Yby6b2rSjxQ
        35z4Of/YWLqHEE82LcPlehzI3bAZpHpMIKwFMQyjctqtkcLaw7Ljr0cYMvacCnPY
        JIKJDOJwL4ssygMo3HcU7DA2BmKGk/+3SlaLg+eDlEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=63dCw0
        k3urB/vN7FoEkXXuzEdUCJ+D7Q45z6b/rF/go=; b=e9V5pCLHGWeVciuH9j+pIW
        rv/XBvkoVA53nEf0gLd2TxuZLRvUxa3X72SL6ObGNb7e+EWbPZRLKgGqNh6ODi+Z
        KLOUmuxo3U8LDEOflQ6jWKdUYC1t/ntCDw8HlnoG0MkKmgJhPX+uE1IC7VyqhdeJ
        DKE4wEI8/FJC9jCXVxLEvLuAMjsALG+FXolSbh15YdHJc5DpO9/SAP9aoqRa8PZy
        0VPcCq5FGNkwKAXTKOlcCq0mJtlNv/BJ72NjgPk2vME35het0IZ+3yoVSqSsljtM
        jkKjIVwT+rnKiEHwaRb5dDa+hnnZNxl1blAsI/MmD2exzszHlyGYsV33gVZvTupg
        ==
X-ME-Sender: <xms:_iTlYY_jalWAMh8XGXcmxJQ4riLqExitEq3Mq11N3nE2SeHa-pj3qw>
    <xme:_iTlYQt6v3gfRGaIEBayMHDW19UwHSk4ceBjmmqdqhl7IObLO5BhIf5wG44zKkXiO
    ZwU0CDpMN_-DAN-Bw>
X-ME-Received: <xmr:_iTlYeAwsXS6X3G_p87myQ8m3-nzU9yxsNKzcqVgkhWqN42ijuWUI81DMgW051J0TJmpvUPVt3WF-KgXJTKW3XaIzOtJ4epU3R6rZkXlxJFX8pfQ7HaHVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:_iTlYYd7vnQwWMgy_TTJUs-wN4o-cGTk3qUerSZ6SjPEsiyizpLgQA>
    <xmx:_iTlYdOmzQa3ZpmSwiIs3g4d5-AP1cXbElXLFi85GjAaYRX64c6Brg>
    <xmx:_iTlYSk23O6Ilu3NPDo3lPAf3dFPW4Udi2RTPFmqnkpo81vVxEXNAQ>
    <xmx:_iTlYSrKotapjlTm1Qv8JWtJqmgdA3h7gKUW8PBp6K2DfgtPD6iHKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 03:12:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d0e13a53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 08:12:45 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:12:44 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
Message-ID: <a8981baef74b4622b5819cddaae80c4356f440c4.1642406989.git.ps@pks.im>
References: <cover.1641556319.git.ps@pks.im>
 <cover.1642406989.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V/VU6KLUv2Bjmh2l"
Content-Disposition: inline
In-Reply-To: <cover.1642406989.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--V/VU6KLUv2Bjmh2l
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


--V/VU6KLUv2Bjmh2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlJPsACgkQVbJhu7ck
PpSP4g//asQQm+XoJEusJht/RrZp/L+U/XtjomQ6h9mp4iwEXnkTRLViA81Ty77q
GSBIyumy7sCocaM3NoI6MslgmUTpx7zW8ML4i0BF+ewY4koKiXpgF8SNp+Z41mUG
m70CdQacua3OYHMMuif5OmwCCzq01a29XHSlc7Hkc20q+QodBfnMP+fNVUTNvtXv
PpYfMRpYsA0h3+23ARPVXxIYj7W9/Loh7uDuiW1volSICM97WEI9xiOy1yfg1k66
4ookB5qUx/AaA5pmaWfA5p9Jp+PHnDaqBR6LpL38dCn/qltKHQQ4hWSOgpkxysFj
WASlVTsorCiJc1MrkBbZ3kTT1nDataRz36qM+/xbOhq+NNR4/DeQ4jJLkmAaakG4
0iJqNffqq89QsV9kOe0NXTc+53Y4GxnJG2hpDivTR4Z52bkrHslekPSoc3O203wP
MU5WrDt8ckHVmxm1CtiDEF8MyUFDkhJtli4+LL5jg2JYzK+iY5qvWl63mBHj/A6A
+FvT5EQ3Q2dorLko9lwNG0s4ykF0HiDBOeIYZP59rga1luXQ5VaS2n/wp3Wf32rZ
Bi1nx9WOQjYY8BR7AefdQn523PDKv3soxYf0mzuSjQRRsOw0wJFrwtCzzw97VfDA
OuDhF1JiNlDk4F418pzDdRD5cZ4FtsB3/PeCqidou8Tkpu8PoUo=
=zh7q
-----END PGP SIGNATURE-----

--V/VU6KLUv2Bjmh2l--
