Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFCC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 10:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhLGLAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 06:00:21 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:33845 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235472AbhLGLAU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 06:00:20 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 56BA55C019E;
        Tue,  7 Dec 2021 05:56:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 07 Dec 2021 05:56:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vI3cdpdBRlTNX2hgcUA6QBY2yq/
        C09JPb3RsMRjj9qs=; b=e155owaqlP/jo+HdDolaaJ/Oyw9iBs1FZN23uby2qq8
        ueg+bi7EcPBYYZJ1pbcBtu0Oid8KBteoTi7PnhZj210Jplz4UR4QlxpYnia3Sp73
        ffOvdvXjnEy5hEBpKEc5Eo5lm1AjOcvrtogmbQ2tvE72JsQii45gYEXM0enEtm3a
        tJWAxs1mGCebF8BrzZDyUrdB502TLRtz3PsOVvbT5ggsmLj3pT29qfRTS+Q/poPn
        VAGSwHkcHInHYa/yNPfjfjGK2Ok431ebp1ZjGektmEU/B8+s1+f553hSSZm03DmK
        tDczOsDSJCSxTOv0aTASdxELZPlQtd9SwscgQxjeyjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=vI3cdp
        dBRlTNX2hgcUA6QBY2yq/C09JPb3RsMRjj9qs=; b=Sg/X4ZeJMqTtqP6cvJv6kW
        XeV2w46aWS9VEZJX0QAYn8ZYb7MaHcETYsW95Rov6D0Bqcg0d8GNE4Nb+21/qEp/
        6EEWCUhRmR1dqcm8g7XMeTA8kiMVCz8Wg9h6R7fkCwRERNqHzj3RMD7bFn3t7Gmq
        8LRz4+za3AiUJuELAYk6p6CSEMe4sh71CVlFfCjs8L2RcCdxZQVJzTSvb4z5gsey
        TfFR2Wda1A8PtK9toWOg+YF0+rNFLw9mGNFYXVwHYcW144wKDqjDRTIqBCqgCjr1
        7bw1ytojIFxJ+rycf3cmRUVQ9D3fAdgMpbYlc8JclMy/fqSHZi/81GpwQTjo0RIQ
        ==
X-ME-Sender: <xms:8j2vYSW2Q5vnG3VRRat-i7scIOXrOdtslvcENovkkQwlnEa9A-CiNA>
    <xme:8j2vYennizmw7TjvJK7fMZ4av5mh1hEfWs2_ekEdm6dVKT7Yw2GWUt_949NWSTgFx
    XTU5I-l_mnLFh_ZaQ>
X-ME-Received: <xmr:8j2vYWZsGQM_NgRvWHABE_tlgiUmrSXT2tUdkK4EDU9_PgdQ8XBE2xiTCRaZ3hzg2qLRWx3MsLc-UXPAqKwbZfBqIFtN1a-4qQdTwQ7qn6fVvaCjKrDk8UOT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeehgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:8j2vYZU3ItATmaU4B7zJoIxt-Lmn1HT9D-DtmOwwQykCK6hoa0bReg>
    <xmx:8j2vYclMIQz0BbpXv33sS15Pjr9i7KIWZNSIVhntIpvmaLernxrQmg>
    <xmx:8j2vYefjXK1FltG4MHIfGd_BkGN4iG9_t5xTuXbiZILqJF_2W5IsXA>
    <xmx:8j2vYRzK0-sq7cmWhj3bLLy811y_zlt4fReAAMAszbTmZEY49iWFjQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 05:56:49 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 584b0f8a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 12:26:27 +0000 (UTC)
Date:   Tue, 7 Dec 2021 11:56:09 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>
Subject: [PATCH 4/6] refs: demonstrate excessive execution of the
 reference-transaction hook
Message-ID: <972ba1bc34974cb5a93c9863fa86fbc471ee6606.1638874287.git.ps@pks.im>
References: <cover.1638874287.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8pZ3K0uABhJrEJjR"
Content-Disposition: inline
In-Reply-To: <cover.1638874287.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8pZ3K0uABhJrEJjR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add tests which demonstate which demonstrates that we're executing the
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


--8pZ3K0uABhJrEJjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvPcgACgkQVbJhu7ck
PpTaoxAAgTe+rXx6flStj1dXo+pzKjTkxhKx9Wz9/Rayyk5J/Qb0CA28wyJK0uWR
nnvKE3Zvl9nKJo2XrCsS8bs9REuuByA+9lx4jtzX5a9kIdobbRcxomtvS2X7/yXL
hB86jPHwMmX4bCOPBC/wpQHzK13SuP3gife9psixJZwcT1gYPhd4W+TxvcdqRduX
8IDSWPbQ4blsZLCnbrZKV4sgNMv7e0bxPHmr6Pm397h9oBY3D7/uPk+nDu5aG9MY
zdg9uLlyrEjVgu7infe6Q/MgGARmlaTCSVw8GoLq885hrscE32HqiG+aZvMEHrx1
ayOEx8gK8qqlIJodg8CzN4YZzM0ViLbLfXm95ftWZJngNMyZNWOBOCVtx+ex6GMX
0fhjYgNJjB/Ae9iHTLS9T+057QTbhhV4fE2LemKnJciUqQVXyg/CpEN6KS9cW5NV
v/zX2Yg5KzLF4Uv/9SKMa5cM3yOyoRZJ+W9/AfXloChVoe+Mi98LPl4r99Q1xc1x
s9s2YhgLjn2vB7EV10H6SOCMz0kDqE/g3EYoJCoJ5NksRWXPnmOpGXLbbGz7MH6B
YUjt9DMO/ou7liqS5DpdBJRa8p/e4eCRGKU7IB7Mm2csuguXKrGqH6hpgEYMN7/9
+2Xxg6IU02+sBtROCIzHoHA9DW0F46KkjXk4unoUOcgUg2EXCxM=
=4jnt
-----END PGP SIGNATURE-----

--8pZ3K0uABhJrEJjR--
