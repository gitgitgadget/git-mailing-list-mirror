Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1D0C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDFD20936
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fa0gSpBC";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxMnwdN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgKMIMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:12:44 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35197 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIMo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:12:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 19A815C00C2;
        Fri, 13 Nov 2020 03:12:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/RTGC2nzdT8Y06MDQ7nbnLBvZk/
        EdapKQv5H3q+115M=; b=fa0gSpBCJWdKFcEkjySx/9fS4oOgsnPwXMfILfNzAz5
        V/coANMsEL19Rj+92agIPyOr57gnSRsWPp5UP7m751Rlu8w19cUt3BHpfTZ1/tTJ
        XHipitw+LEk22YqWRP33G/CdVaxc+RevPr9+YwY69d+ts8SX61cSUmuGvCZONB/1
        N5vgHjSADF+BmxG9YPTmV3GcIAKbU8EzgsJ1BuUxXnt0VFxvHhRBOj5p2EmjH+sB
        HcP20ETUX0agjui5F1J0g2Q015pjFqsE+wJ9Sp7fwG3GSThlM4IYpva6agiIBJES
        YbzDVYRltEidSROdpNyTcX7daYRK6CtAXemnxKE7Wug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/RTGC2
        nzdT8Y06MDQ7nbnLBvZk/EdapKQv5H3q+115M=; b=KxMnwdN6madTgN6Adin0Zh
        FO1uU5CKK/uwBOvHaqXuFqR287y2D7bl1yiEbtYaXQqYFA+dNSqZBcYb90UDacsb
        8whrLtsZEfA4TUPQ3fAOk379+5+wRzX0mUarLa7mNX5Wm4qmzl057Gep0QKEGqcn
        CEY1J35o185TEcKgmHsJcbgftv12g5zdt0ka4b5ADeyU6SMqc8LPuqCFF/cr4Pdo
        OLdksZhY6gmybxMNS8hXzyiMPYkrW3Y+q9qpItOzRN9yxDVnBepKhrvebvh32jYi
        iycp0wS+Os0218MQbXkz7+PICenwU/1Ef9wLbF2yEas3qA6WiqQsufzgH+jfkXFQ
        ==
X-ME-Sender: <xms:-z-uX6jX5oF_6xjollPbvt6qev2JQH6iCQY2geowK2pUQUQY6fC_5w>
    <xme:-z-uX7De4HuRMRpKxxuDWjJJ3VEMFarmxNZS0GOFA8G6C06h3SVnaIDtuN2vhihML
    4bycJ5hTtlQVSZetw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:-z-uXyFJcaia7Bj1REee8GvI6ZZK-SJhxzrebeWpu_VFIiDHYhRXiQ>
    <xmx:-z-uXzQ1P825ZlXTjMmBM648jCdIookHVCeY6ujUkrgDOeI7X5_WCw>
    <xmx:-z-uX3wj6o2t7MAifZZugzFlDOYpuFZ6IRghqVnXEz7zhZ2okK4jzg>
    <xmx:-z-uXwozDM-X2aYf-26SP2jx8AcQfznTRx7yy-8wwvlvPI_tcJTq1w>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A07F3064AA6;
        Fri, 13 Nov 2020 03:12:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e14f75c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:12:40 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:12:41 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 3/4] p1400: use `git-update-ref --stdin` to test multiple
 transactions
Message-ID: <4778a60832185971a92b708d533cd03ac2af4973.1605254957.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pbb7GJr1QkvC+V0p"
Content-Disposition: inline
In-Reply-To: <cover.1605254957.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Pbb7GJr1QkvC+V0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In commit 0a0fbbe3ff (refs: remove lookup cache for
reference-transaction hook, 2020-08-25), a new benchmark was added to
p1400 which has the intention to exercise creation of multiple
transactions in a single process. As git-update-ref wasn't yet able to
create multiple transactions with a single run we instead used git-push.
As its non-atomic version creates a transaction per reference update,
this was the best approximation we could make at that point in time.

Now that `git-update-ref --stdin` supports creation of multiple
transactions, let's convert the benchmark to use that instead. It has
less overhead and it's also a lot clearer what the actual intention is.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/perf/p1400-update-ref.sh | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/t/perf/p1400-update-ref.sh b/t/perf/p1400-update-ref.sh
index ce5ac3ed85..dda8a74866 100755
--- a/t/perf/p1400-update-ref.sh
+++ b/t/perf/p1400-update-ref.sh
@@ -7,13 +7,14 @@ test_description=3D"Tests performance of update-ref"
 test_perf_fresh_repo
=20
 test_expect_success "setup" '
-	git init --bare target-repo.git &&
 	test_commit PRE &&
 	test_commit POST &&
-	printf "create refs/heads/%d PRE\n" $(test_seq 1000) >create &&
-	printf "update refs/heads/%d POST PRE\n" $(test_seq 1000) >update &&
-	printf "delete refs/heads/%d POST\n" $(test_seq 1000) >delete &&
-	git update-ref --stdin <create
+	for i in $(test_seq 5000)
+	do
+		printf "start\ncreate refs/heads/%d PRE\ncommit\n" $i &&
+		printf "start\nupdate refs/heads/%d POST PRE\ncommit\n" $i &&
+		printf "start\ndelete refs/heads/%d POST\ncommit\n" $i
+	done >instructions
 '
=20
 test_perf "update-ref" '
@@ -26,14 +27,7 @@ test_perf "update-ref" '
 '
=20
 test_perf "update-ref --stdin" '
-	git update-ref --stdin <update &&
-	git update-ref --stdin <delete &&
-	git update-ref --stdin <create
-'
-
-test_perf "nonatomic push" '
-	git push ./target-repo.git $(test_seq 1000) &&
-	git push --delete ./target-repo.git $(test_seq 1000)
+	git update-ref --stdin <instructions >/dev/null
 '
=20
 test_done
--=20
2.29.2


--Pbb7GJr1QkvC+V0p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uP/gACgkQVbJhu7ck
PpT8MA/7Bn3lkVUpD9juZyPEZd0u9nu+89+dgVJntWKbJA0HuXGvoDbb8Z5ExPBc
Q3Jz8NG1e+m7Ku4+ger5bI8mKmTBZW+Rc+YsR/8rxELoDeN+yTTvgmRN8M0kA3u6
44aGUxspet8dyjwshuoNzu2ToddUN6KJmOg9gqS9ed9J/OEm+t3Y+nW2bVJkAXE8
nOifeUIdB6eTF/OxGNpbef1WIOCfv7cp8S5pS9uuCSkqrqU1Qlhr6ym5jUtqf76D
dLK9gjnMIHXjenvX3GRfnKNUdUJEWvbbCQXo1rAtHDaFV9sxUaTTGP0i1wxqalp6
mJsMRszRauk3yp1OaIhkso6IadT6o38hevGyIbyyzDrtTQPJ3xeC0yprDfN7m58t
5F3hSYbSPVDdoAj2T4+vYq+hLyfhBIVwmlNm361Ew+cX5KNBanMaOJBo/B5YVTgq
Pjn9ZavBAO2x205SMUkrLWJsPEx4jGY+H6q6wA9BMKrgeRpeqeVXbQz0fAlcCCoj
eUufvxc9wb3UCjPcQSE9seH5KLmSHSl+EBgtOlI7i47OKgdPYzk9zKnXR1eI+Flm
oX9EonVU8HQ31ImL5Yjj+YEzNPY5+gSfS8zpzMctT8KQICpxpNcUajNql6ECGG6G
7EYTv04PK+3bkIm+N2HxnnzUM7L+9TUD6+9jHwjdn6BxIkEhYCI=
=dLdN
-----END PGP SIGNATURE-----

--Pbb7GJr1QkvC+V0p--
