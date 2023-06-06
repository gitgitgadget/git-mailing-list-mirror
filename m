Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8332C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234017AbjFFFTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjFFFTj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2082A1BB
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 565F132009B1;
        Tue,  6 Jun 2023 01:19:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 01:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028776; x=1686115176; bh=k9
        5WaMVskBhrjniFlDSdZMCJDGDtd9dyoGz6P7+Qw40=; b=zXYcVWcZP+3NA122eH
        iRDTS9swfPyYkTvJ6yfEHfFmw6tfeNw3/3+Kdblxu+5XcWatwHsDl0qFCqsYm+/+
        Kj2IbDFMUqWVxFh+pqnqr1ut8vndMnCRDEo1hwjoBv+/PY+1j0T8v2RyTz4W0pAP
        yvutVK+xm7Zdvl8dA9O2KMHEKP6TgBP/V0ikR4mO+0CYDXP4s/Hp1Eqd0eUWTzEn
        Fbs1AzENnsy0BETfE3RTc20XyqgMVB7Ro/fZvTie3LJeT5ZFHlllxILCfuUQz8jM
        ugWxH8t8PcRvdJFOPt4mBHF64nEUjmRviSviuZ6bvddfRfB0HG0jd5qUpQVge1Na
        WH8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028776; x=1686115176; bh=k95WaMVskBhrj
        niFlDSdZMCJDGDtd9dyoGz6P7+Qw40=; b=XMTTwd94KO7QNjsnzCVZ1Hg9csccw
        4ZucNR83fBQivIZn+4PZmtl8ivkK1PtONfyOSBK9qd705tMKY2r3uWmFbuFen1fI
        c3mG4sBPIRURoN2VwCvcx/xWTJJthRwnG+HSpisrgs9CHEuZICUPN8l+W2mvpPqb
        I3AAxN8ENcvh2GhmsaU0VeE3auvNGhS9QZ9ogQbOkaiGJ7yZ9QW9TIvqEEJwKKbQ
        GLks1acgoi6HIyIc7QMOEY6fe6nIMcitOG+1cj8gdk/TXCU7Ha8KmJav9qidyqyE
        eYsSMy+fDOKz49H+Ip3BPK/+E8UpvgL34l/oVLXa33xq6OwKJ6saEebcA==
X-ME-Sender: <xms:6MF-ZAYdCMZ5zEgJiIMmL85bXL3h_tHHxlM4X70L97Om809KT4Zq4w>
    <xme:6MF-ZLbbBdmdh_SLenuUoAqg-tHwUikm_WMajFWMbgmHd3l-HB50Bg5luCa1hmTi1
    OGJ9a7d2BFD_INvhA>
X-ME-Received: <xmr:6MF-ZK9oDAIYHQjFzkL1mzq1bQ0nLec6kE9zddouhpJV0MhsU7PcRXq-AZrARSUmQkwZlp3IWRzNuzOd26nAa5fhQ3WXhfH4XnCWfWRsYQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:6MF-ZKo4jY37XYlddumwogxQkNyUZ6Md3dy6xBDaTABWWn9ExOIBbw>
    <xmx:6MF-ZLqgBQswgweMT3VdRtG4aNEKr7n_u8WjD0aoLR3Xq34WYb1zpg>
    <xmx:6MF-ZIQnK7g1Bs3o4g438s2wjS1mM88Kc3jVpmPV68i0lEuTLiFV-g>
    <xmx:6MF-ZKV51yKtFUVU39tW8gixFFck-TVuVkEWteL7DQgKxM2wyyq3iw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:35 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c96fb15e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:31 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] t1006: modernize test style to use `test_cmp`
Message-ID: <251fc2a387067bb6d575cfa39f088d4474844a59.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
 <cover.1686028409.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jiOys5LssF5QeXau"
Content-Disposition: inline
In-Reply-To: <cover.1686028409.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jiOys5LssF5QeXau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The tests for git-cat-file(1) are quite old and haven't ever been
updated since they were introduced. They thus tend to use old idioms
that have since grown outdated. Most importantly, many of the tests use
`test $A =3D $B` to compare expected and actual output. This has the
downside that it is impossible to tell what exactly is different between
both versions in case the test fails.

Refactor the tests to instead use `test_cmp`. While more verbose, it
both tends to be more readable and will result in a nice diff in case
states don't match.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1006-cat-file.sh | 70 ++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index f139d56fb4..7b985cfded 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -296,9 +296,11 @@ tag_size=3D$(strlen "$tag_content")
=20
 run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content"
=20
-test_expect_success \
-    "Reach a blob from a tag pointing to it" \
-    "test '$hello_content' =3D \"\$(git cat-file blob $tag_sha1)\""
+test_expect_success "Reach a blob from a tag pointing to it" '
+	echo_without_newline "$hello_content" >expect &&
+	git cat-file blob $tag_sha1 >actual &&
+	test_cmp expect actual
+'
=20
 for batch in batch batch-check batch-command
 do
@@ -334,30 +336,47 @@ do
 done
=20
 test_expect_success "--batch-check for a non-existent named object" '
-    test "foobar42 missing
-foobar84 missing" =3D \
-    "$( ( echo foobar42 && echo_without_newline foobar84 ) | git cat-file =
--batch-check)"
+	cat >expect <<-EOF &&
+	foobar42 missing
+	foobar84 missing
+	EOF
+
+	printf "foobar42\nfoobar84" >in &&
+	git cat-file --batch-check <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success "--batch-check for a non-existent hash" '
-    test "0000000000000000000000000000000000000042 missing
-0000000000000000000000000000000000000084 missing" =3D \
-    "$( ( echo 0000000000000000000000000000000000000042 &&
-	 echo_without_newline 0000000000000000000000000000000000000084 ) |
-       git cat-file --batch-check)"
+	cat >expect <<-EOF &&
+	0000000000000000000000000000000000000042 missing
+	0000000000000000000000000000000000000084 missing
+	EOF
+
+	printf "0000000000000000000000000000000000000042\n00000000000000000000000=
00000000000000084" >in &&
+	git cat-file --batch-check <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success "--batch for an existent and a non-existent hash" '
-    test "$tag_sha1 tag $tag_size
-$tag_content
-0000000000000000000000000000000000000000 missing" =3D \
-    "$( ( echo $tag_sha1 &&
-	 echo_without_newline 0000000000000000000000000000000000000000 ) |
-       git cat-file --batch)"
+	cat >expect <<-EOF &&
+	$tag_sha1 tag $tag_size
+	$tag_content
+	0000000000000000000000000000000000000000 missing
+	EOF
+
+	printf "$tag_sha1\n0000000000000000000000000000000000000000" >in &&
+	git cat-file --batch <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success "--batch-check for an empty line" '
-    test " missing" =3D "$(echo | git cat-file --batch-check)"
+	cat >expect <<-EOF &&
+	 missing
+	EOF
+
+	echo >in &&
+	git cat-file --batch-check <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success 'empty --batch-check notices missing object' '
@@ -384,7 +403,8 @@ deadbeef missing
=20
 test_expect_success '--batch with multiple sha1s gives correct format' '
 	echo "$batch_output" >expect &&
-	echo_without_newline "$batch_input" | git cat-file --batch >actual &&
+	echo_without_newline "$batch_input" >in &&
+	git cat-file --batch <in >actual &&
 	test_cmp expect actual
 '
=20
@@ -411,13 +431,17 @@ deadbeef missing
  missing"
=20
 test_expect_success "--batch-check with multiple sha1s gives correct forma=
t" '
-    test "$batch_check_output" =3D \
-    "$(echo_without_newline "$batch_check_input" | git cat-file --batch-ch=
eck)"
+	echo "$batch_check_output" >expect &&
+	echo_without_newline "$batch_check_input" >in &&
+	git cat-file --batch-check <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success "--batch-check, -z with multiple sha1s gives correct f=
ormat" '
-    echo_without_newline_nul "$batch_check_input" >in &&
-    test "$batch_check_output" =3D "$(git cat-file --batch-check -z <in)"
+	echo "$batch_check_output" >expect &&
+	echo_without_newline_nul "$batch_check_input" >in &&
+	git cat-file --batch-check -z <in >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
--=20
2.41.0


--jiOys5LssF5QeXau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+weQACgkQVbJhu7ck
PpRh/xAAlxI0hvxEN3bxLCUzX2I76VIbWS2OkZGPD0Nf+jinpJ2zr1dxjmJ9r6Qw
IzRVrBoURGwSZYycw+1EloSccEBNAhQtE+49LE/PuEgqnDYhDYTeVopmxLpyIbWR
wCwAnFAb+zScWP9lKo9oI+k9BPhirLI/+yig+waQWVq6aGXODsw8xicPdPUKBTkL
1RqKOwN7RBc4g2oifVpoBXRjSPPdMKqOEgb7fHK5Yn/aWJ3elwUfLryC82NjAn4x
kqUd2ZU3dDUbvEzhvHZedRjKyjHya6iNV3m6LgA16fgBTvkH2KHsqv+LcnSa9myk
3YKp1gbZ4Zjg8eqsT520LA9ITHTdxYeaUJmh8mJ1SqkYbdCrGzf5oWhP2wP04TCd
JOZcW3gJu5zGsg/Ud38mSyoR5XLRlT6neacPabqmDyTm1H1wtHy0VQb6fv+ds5hH
hlKSXtcLgPkhj8hLebVkLgOWUrs1R6TgaMIeh25ahE/GClHoBSILMAwdrXJDOUaH
BIpI2sHdj74IvqzPkMNqk4cjCTuRpkJ4Bc8dMOqNDNItRuWwO1fVuIXUsiGySUsW
zjbWbrNiAYB35Y+LuiOeXaQ8IMYi/JZl3CIa8VOk7agQQn4tmNCKemFsoktNwJi/
OTRaVJBJxIOklnfJuLEQbxhC/viXc4Q33BqEwPeyDcBnqVNgISA=
=vky2
-----END PGP SIGNATURE-----

--jiOys5LssF5QeXau--
