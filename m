Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9732C77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjFBNCn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBNCl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:02:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BB11A5
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:02:39 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D72685C00D0;
        Fri,  2 Jun 2023 09:02:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 02 Jun 2023 09:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685710958; x=1685797358; bh=wi
        tQNPkEpk9lsExNDP5sXcR+Em8YDwNKWjK0s5ycZHw=; b=kgaaXK9ex7O+La3O7i
        Ddz8bBRA1GzrELm0bl0trobWW0BWcFg4VrH+qkxUca0vAui1VHu+fmxHPdYGkPXz
        pGavBUE0feYLRZP81kXV4ExMbR0XP1BgjXxYTMGOkc9EcDyTjwngWxx/1xPMH5N3
        7WL3Qv9qcztrtOkPb55dtY+3XLe9T/Uyc8GqSv4aFu8mZ9rmYVOf9u9JGowoiKZA
        9esDLNY2FVdZRMMnPNG0NsTE6yGEcP7KWRkbVKxO47AiAuxL81CWGJbpyUd63Qca
        a/evkZN5omlNrS4xC8yh1OdBIEhhjlCIjGJvZB8PV1i8fPf0438QNTD8vDs5s/Z3
        1ZsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685710958; x=1685797358; bh=witQNPkEpk9ls
        ExNDP5sXcR+Em8YDwNKWjK0s5ycZHw=; b=pfevERob8uy9jdubFtE0LGWp7MiwH
        +B6tkA+kkOCzH/8JdZr7QsjL33Wbv4V3uZDF20Z5kBZvdJJfIS6Wec60lACJrdvV
        LwUunVUpX6ksixab8CokdfU86wOzPLw1PA+JiRU4JwHJ9r//4RW1hyKvCK2LQthX
        ad9n7C9VNU3VsEM+dfou77SDLvdztcEdWufQxPbp4wSFw5f3mTHJgizE39lgOSlV
        c9NAZ5+rzQHGLaUloTzqLTW8dEpGbkHl6ffpANqmZZsho7mi+9IZuuDg0tL6f4zu
        n8kgK7c6el0PIApiPUMAx1ggGmOwCsGZGlNIhLBdU6kG6bLRJ7uKvcJSg==
X-ME-Sender: <xms:buh5ZLvNXlTcB9Xqgm7gh-6zluXCHp2KrkIGo3v2XW1HRp8GMgMr5g>
    <xme:buh5ZMe2jTOExlnD-2r27mv25iQW0ju_89f0GwuuRM5AkNw0efOYPNaBaXtQrxb5X
    mWQzJHCEfkHl7-GeA>
X-ME-Received: <xmr:buh5ZOz0YU5bsJGlPb8fkgNxlF5WAf6uJcPHvs3sk8I85vuVH-SEKIf9QRu5xuf2ylBssKzCflztoUhLruQQFqMXZGZIJiBN9AZnznfimdgtNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:buh5ZKO8NBh7KeCm6JP6wbIe5bnDZ2pcAfYVkPxRSfpo-bBRXOp3eQ>
    <xmx:buh5ZL-HdiyIS7gXsP9duS2ypWUVgSFZbKp94prrlDFlRr4lpJxBGg>
    <xmx:buh5ZKUCaLN9LhiDDcwrGiqIBGrzAdkhqts31Mv4NLg1AT0FRMdmSA>
    <xmx:buh5ZOY3jnywX6eTs2hi-s4rwNszmLigExqm6ZrJ2JyDTQt54ReKXw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 09:02:37 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 2b69fca8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jun 2023 13:01:41 +0000 (UTC)
Date:   Fri, 2 Jun 2023 15:02:34 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] t1006: modernize test style to use `test_cmp`
Message-ID: <251fc2a387067bb6d575cfa39f088d4474844a59.1685710884.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nu0rI1QBS3SFp7d7"
Content-Disposition: inline
In-Reply-To: <cover.1685710884.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nu0rI1QBS3SFp7d7
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
2.40.1


--nu0rI1QBS3SFp7d7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR56GkACgkQVbJhu7ck
PpTK5g//X1bRaa/YAl+2ad5Ii17ms4l/jCC88Xu9Ho6BxXGn+eNWeRjfKD/HKYOX
Abjo2rftPN0tBYipGgv3Kk6RAAQbUqvpt7qxu1KZXIECB0GHeEDj+B4tac9VGxGd
ShC0S1KWEXNE1OLlTeh+/GC/Iz1BWrartHq334IJEp0O1x/BnjqmFm2REROteDQn
am+MIcSzzXir2XQO2DtQ0pIVleU5iMd3Qa8JfsT3+BhuvG/xgxU+MWu4kA5iDaNC
vrZhEAdFtrWwkLMP/WP7Cq8H3edM88/skfx8pvrOa8U+P2Ef1CgRTbA5KEI3TB3X
NzV7pELfLi24nG+SJ/Ou0/CNmX30fWQI4pCMwcGkUY2hc2MmqhtyloaGMCx6jXw4
Qz3NxhKdN5kxyDfUtc+PZNgNak0yaf8QeLpSYQz5uJcDbozT4+W4D0LuIE6EpCyF
m0I2MhQszuRuMa0Ry5LTwtm/zlzEETxnam3tL2wYW9Ps7sS4EXP+AzjCIoJFWrRU
UNW3bLBY4JsoHiJTgiuRTbhaskTku4auTF9cFbJ/ikX1aiHCH8cNoaMO2GxYBoXh
c3IIPnMtTN84wm5iDKA+ZvpBs9B4+gil68LNN6O9eenGqGb+TxcAvUnzJJGT8zb0
N+0FIF4JBH8TeKQQ7P1CY6cYX9vy4z4Cr7sSbEafCf1OJW62wHQ=
=0M/2
-----END PGP SIGNATURE-----

--nu0rI1QBS3SFp7d7--
