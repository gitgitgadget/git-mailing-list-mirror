Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA8AC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjFFFTk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFFFTg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:36 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEA123
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:34 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A78393200AEC;
        Tue,  6 Jun 2023 01:19:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 06 Jun 2023 01:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028773; x=1686115173; bh=bM
        rPXm5DM+rxk5IeZ05/hKLcor+ZSYlqMv6RjbZo91Y=; b=ch7XFgmQWCJTJQd14F
        xKkq8z9ug2Y4MWTuzI22BysvsVHKjQbdWAskdsvuQaLLdt2VpueWNSSyihtUPZqg
        pL/RpfBtiIm3PrrXec/GQvZrrqvSRvb9XfDEnXuYjqDF1AS4W69/iwFMgTKW2CN3
        v5vmB7dPPykVsCBEs75FwfCH+ycRJE7dCQ946vcCJKos10HSZc+xbKIPjPCc74rb
        T/qbrEJa53NErLrKaW640cbV1ine5cVY9hSP7m7M8tcSlxGoyVAeXiG9OCaFzhMt
        q9Ctxq9kL9Bjfy2EaUEdzuu/P67C/dwoZ7ymmJezx+PGqV+wbUDlWasmISeVLAXE
        n4JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028773; x=1686115173; bh=bMrPXm5DM+rxk
        5IeZ05/hKLcor+ZSYlqMv6RjbZo91Y=; b=znu8GwA3lK/WnEW+MUOwodGYnpYWe
        iabuuM8MwHd6usQHOJMxWjYi9j+aKEdfCT+wePwMxQvcKPKZ15CA8s7jTQ1K7LIm
        zcSSAoENhW8BOwHbw5UyGWD9uKOjyKNxnbil3QgQ7iWWpCAewsDTDaeJdDGJODEq
        KuUJ5h6wUFxbCFwgBvsel+87eFLX3LH1atdJJla5usFVVUnqRtVUH6r9L0HM1WOJ
        BAWJx3o2HRpkylTW6OoxM2m0eC8y/ZzM6YUd5SLfMI9IlbmYLYPMV5b6qIPgyyfH
        /xnJ5MhflBGT9bd/9a6df5kxzXMPk+u8XQM/uoHPmLfe3oFk7BiFTd5Hg==
X-ME-Sender: <xms:5cF-ZNipmAKYAOYTxO7UgXiKJBlXRJlUcwS9gz7A6f-Sf2a_16ZhdA>
    <xme:5cF-ZCB9rm5mydzf1RcTwJAXSX3x2Qh147Oyn8vAzDrlFtbmLVmXyDsZqAE4kj3n7
    TTDOqkQzxz5xT8wAw>
X-ME-Received: <xmr:5cF-ZNFelvVkxwO7fFdlq7cUGMFmrOMk3ZlJbk1TjEG1TagtlfJGTx9wJfZv4Ul2xCHkhI-qZBqT9RJuYxxo4hMa8Z7GDnpob2_ho-SyIUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:5cF-ZCSRxZX6Ju_X4RSgK1vgpHo9Dl-8752JeDtpQRc2qyYHfbgMMA>
    <xmx:5cF-ZKzo-Iaa08UL_BiIXvmpSw3L7KwDZ290bfS006CFSmk7UqjLvA>
    <xmx:5cF-ZI41fEBKouPpGN2g6r3rjGXoKztGaRo0DqYFXu8dFTVEvpljyg>
    <xmx:5cF-ZO9-dErUMUzGzm5DcR5jVqqIT_3sq9lY9JTACZZPuWl9hZEoJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:31 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 73960995 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:27 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:29 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/5] t1006: don't strip timestamps from expected results
Message-ID: <5c8b4a1d70b170e3426cdd537edc0c076115be0a.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
 <cover.1686028409.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xQhVsU1oRZliu330"
Content-Disposition: inline
In-Reply-To: <cover.1686028409.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xQhVsU1oRZliu330
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1006 we have a bunch of tests that verify the output format of the
git-cat-file(1) command. But while part of the output for some tests
would include commit timestamps, we don't verify those but instead strip
them before comparing expected with actual results. This is done by the
function `maybe_remove_timestamp`, which goes all the way back to the
ancient commit b335d3f121 (Add tests for git cat-file, 2008-04-23).

Our tests had been in a different shape back then. Most importantly we
didn't yet have the infrastructure to create objects with deterministic
timestamps. Nowadays we do though, and thus there is no reason anymore
to strip the timestamps.

Refactor the tests to not strip the timestamp anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1006-cat-file.sh | 68 +++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8eac74b59c..f139d56fb4 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -109,26 +109,12 @@ strlen () {
     echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
 }
=20
-maybe_remove_timestamp () {
-	if test -z "$2"; then
-		echo_without_newline "$1"
-	else
-		echo_without_newline "$(printf '%s\n' "$1" | remove_timestamp)"
-	fi
-}
-
-remove_timestamp () {
-	sed -e 's/ [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$//'
-}
-
-
 run_tests () {
     type=3D$1
     sha1=3D$2
     size=3D$3
     content=3D$4
     pretty_content=3D$5
-    no_ts=3D$6
=20
     batch_output=3D"$sha1 $type $size
 $content"
@@ -163,21 +149,21 @@ $content"
=20
     test -z "$content" ||
     test_expect_success "Content of $type is correct" '
-	maybe_remove_timestamp "$content" $no_ts >expect &&
-	maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_ts >actual &&
+	echo_without_newline "$content" >expect &&
+	git cat-file $type $sha1 >actual &&
 	test_cmp expect actual
     '
=20
     test_expect_success "Pretty content of $type is correct" '
-	maybe_remove_timestamp "$pretty_content" $no_ts >expect &&
-	maybe_remove_timestamp "$(git cat-file -p $sha1)" $no_ts >actual &&
+	echo_without_newline "$pretty_content" >expect &&
+	git cat-file -p $sha1 >actual &&
 	test_cmp expect actual
     '
=20
     test -z "$content" ||
     test_expect_success "--batch output of $type is correct" '
-	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
-	maybe_remove_timestamp "$(echo $sha1 | git cat-file --batch)" $no_ts >act=
ual &&
+	echo "$batch_output" >expect &&
+	echo $sha1 | git cat-file --batch >actual &&
 	test_cmp expect actual
     '
=20
@@ -191,9 +177,8 @@ $content"
     do
 	test -z "$content" ||
 		test_expect_success "--batch-command $opt output of $type content is cor=
rect" '
-		maybe_remove_timestamp "$batch_output" $no_ts >expect &&
-		maybe_remove_timestamp "$(test_write_lines "contents $sha1" |
-		git cat-file --batch-command $opt)" $no_ts >actual &&
+		echo "$batch_output" >expect &&
+		test_write_lines "contents $sha1" | git cat-file --batch-command $opt >a=
ctual &&
 		test_cmp expect actual
 	'
=20
@@ -228,10 +213,9 @@ $content"
     test_expect_success "--batch without type ($type)" '
 	{
 		echo "$size" &&
-		maybe_remove_timestamp "$content" $no_ts
+		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch=3D"%(objectsize)" >actual.full &&
-	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
+	echo $sha1 | git cat-file --batch=3D"%(objectsize)" >actual &&
 	test_cmp expect actual
     '
=20
@@ -239,10 +223,9 @@ $content"
     test_expect_success "--batch without size ($type)" '
 	{
 		echo "$type" &&
-		maybe_remove_timestamp "$content" $no_ts
+		echo "$content"
 	} >expect &&
-	echo $sha1 | git cat-file --batch=3D"%(objecttype)" >actual.full &&
-	maybe_remove_timestamp "$(cat actual.full)" $no_ts >actual &&
+	echo $sha1 | git cat-file --batch=3D"%(objecttype)" >actual &&
 	test_cmp expect actual
     '
 }
@@ -284,7 +267,7 @@ test_expect_success '--batch-check without %(rest) cons=
iders whole line' '
=20
 tree_sha1=3D$(git write-tree)
 tree_size=3D$(($(test_oid rawsz) + 13))
-tree_pretty_content=3D"100644 blob $hello_sha1	hello"
+tree_pretty_content=3D"100644 blob $hello_sha1	hello${LF}"
=20
 run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
=20
@@ -292,12 +275,12 @@ commit_message=3D"Initial commit"
 commit_sha1=3D$(echo_without_newline "$commit_message" | git commit-tree $=
tree_sha1)
 commit_size=3D$(($(test_oid hexsz) + 137))
 commit_content=3D"tree $tree_sha1
-author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0 +0000
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0 +0000
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> $GIT_AUTHOR_DATE
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
=20
 $commit_message"
=20
-run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_co=
ntent" 1
+run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_co=
ntent"
=20
 tag_header_without_timestamp=3D"object $hello_sha1
 type blob
@@ -311,7 +294,7 @@ $tag_description"
 tag_sha1=3D$(echo_without_newline "$tag_content" | git hash-object -t tag =
--stdin -w)
 tag_size=3D$(strlen "$tag_content")
=20
-run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content" 1
+run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_content"
=20
 test_expect_success \
     "Reach a blob from a tag pointing to it" \
@@ -400,13 +383,16 @@ deadbeef missing
  missing"
=20
 test_expect_success '--batch with multiple sha1s gives correct format' '
-	test "$(maybe_remove_timestamp "$batch_output" 1)" =3D "$(maybe_remove_ti=
mestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
+	echo "$batch_output" >expect &&
+	echo_without_newline "$batch_input" | git cat-file --batch >actual &&
+	test_cmp expect actual
 '
=20
 test_expect_success '--batch, -z with multiple sha1s gives correct format'=
 '
 	echo_without_newline_nul "$batch_input" >in &&
-	test "$(maybe_remove_timestamp "$batch_output" 1)" =3D \
-	"$(maybe_remove_timestamp "$(git cat-file --batch -z <in)" 1)"
+	echo "$batch_output" >expect &&
+	git cat-file --batch -z <in >actual &&
+	test_cmp expect actual
 '
=20
 batch_check_input=3D"$hello_sha1
@@ -480,7 +466,7 @@ contents deadbeef
 flush"
=20
 test_expect_success '--batch-command with multiple command calls gives cor=
rect format' '
-	remove_timestamp >expect <<-EOF &&
+	cat >expect <<-EOF &&
 	$hello_sha1 blob $hello_size
 	$hello_content
 	$commit_sha1 commit $commit_size
@@ -491,15 +477,13 @@ test_expect_success '--batch-command with multiple co=
mmand calls gives correct f
 	EOF
=20
 	echo "$batch_command_multiple_contents" >in &&
-	git cat-file --batch-command --buffer <in >actual_raw &&
+	git cat-file --batch-command --buffer <in >actual &&
=20
-	remove_timestamp <actual_raw >actual &&
 	test_cmp expect actual &&
=20
 	echo "$batch_command_multiple_contents" | tr "\n" "\0" >in &&
-	git cat-file --batch-command --buffer -z <in >actual_raw &&
+	git cat-file --batch-command --buffer -z <in >actual &&
=20
-	remove_timestamp <actual_raw >actual &&
 	test_cmp expect actual
 '
=20
--=20
2.41.0


--xQhVsU1oRZliu330
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+weAACgkQVbJhu7ck
PpRLbg/+Oe4iZu3QjK7ivHqbT/t56jB5nlmCXFqqi7fyqWNCp7YadavHsggCRhIw
aeYKvtO0FQEijqOyZhSE11OMRJMzHpcrIgr6sa5n5EmJy+MatVfn/7vHEZrhyP9g
ww0PJpPXMjlsuUaumxA4koU1vRa8MRkDDsaCOKxuyDaa0kIpFjjs/ndf3vDCHrwZ
RBdmEbww2//xOjmbdOWfdt6m+9x2TLdWrE8AJ1QeRJuhseR39iIkR921ZN3z34ra
FWoiROZ3qy6Lze1VxelJji64B52S/H0wM1IdtYMfBGGoyeDB0xOaclqWLBn1yjAE
Y7Lnthwgpeb38CI2xps2ObWlP6n0zJWS74wxDj9lyEsV+gFEP12QM+IKh30Hq+Fe
FWZPITEE1KExauEafjuWZr6Y4T2h6LafguHsB954QfGJ85RjC+1UCdFrdlQ7gWWR
emGD537mdxEmmXo4X9t/4Zoo0KaaLn9yz76KGUOvcfFu6Y+gmZD/ISeN50bKfuS2
FMKFJa16xEfDgQkV+nBv6x7zsTZ5UcW5I8fyEcB6szdI0ef02M4AST8tLu9Zk/1L
mCbPtsNxH446nvlaqDgN+32oSXurbysn6MYfEGjlHRqtmOfH5XAEdNI6+cscIhmg
uDFUjuqWzEk1ZRyHSGEg1x5lQPYmblpBJexcOej6rxU3bBhN8Bw=
=TX3m
-----END PGP SIGNATURE-----

--xQhVsU1oRZliu330--
