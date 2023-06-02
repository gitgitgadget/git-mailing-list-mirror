Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E604C7EE2C
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbjFBNCj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbjFBNCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:02:38 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993771A8
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:02:35 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0215B5C010C;
        Fri,  2 Jun 2023 09:02:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 02 Jun 2023 09:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685710954; x=1685797354; bh=Lv
        DySHOaOYRtODWhOADAcFFWRZ5TricVu+nCWn71HlU=; b=RhUf/LrJX/Pk06mmfD
        R/rwltdy4tbH8wpFDhl6OoIzcPLV1UocOp9I6tEaZ6pSRnhAEnUtUGtZsQ5h7D6w
        TcTt1243XQuoBj3LDQEVubfSzxs/LT5l07RWVxiwhRRCK+bUhIobUzw1Fbj6ZOPw
        FSS/WoOQa2EsPDR6Ld0fiC0707UeotKhbkV0ffw78PaM8IbR8uVvxfUn78Hn1RNW
        irrj5B+li5FcTrGiQcL8Fohm9MXLIQfXRkeUTJZZZBNsGsEmHjbCY46STwCAKp2t
        /x5TeJJV39zxZmwKkqksNFs+ovzXGCr97w02A98tOkiLWD2KWVXHhKbY4cBVttzW
        3GUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685710954; x=1685797354; bh=LvDySHOaOYRtO
        DWhOADAcFFWRZ5TricVu+nCWn71HlU=; b=aIhbvcbMtXXVnPuE2xbe1tp4qtfFM
        iokHaIGi1yc/3qUiuDPt+Z+jtqim3qhFyCOCD1gF68ygPH9p42/lBTrdeuMjD0ik
        BdYOgA9pGRd4+pXahl+Ip2BrkTspk23jwnd8qHrWvyXCfbC1G4ROCaWZP2xd6QFu
        rDjCARIQM5FmiYcSvK2qCrGUSTbRhz9nxyd8nV/x3LxvvzjxrIqeE8CsSw+qtWlu
        Nl+tusR646dEeDXOjuyMl0/BpQac4Wf7aQyNTfUo2Yj3CLCzvl2U4n7jiMRSWbHd
        okGguc5ESJL9RXoYz+tLhaHJen+sg/IJE6KRp6SboIEvbB078fACAJvOg==
X-ME-Sender: <xms:auh5ZDPQj9rIFSos3mOwiQM4INIpKjf5qTWih-OyOPmTOTNom3UXPA>
    <xme:auh5ZN-TQ7Vw9cnRNeo2V1AuJsVoBSs4GQ84w0T3bZ4JrXDPzGaUEXRS5N6D4thGg
    LpmfndwrBT4al3pnQ>
X-ME-Received: <xmr:auh5ZCSolI8clihqTyjLk1YOJnmcE09nbtdrtoTh6kO9mjhqp6XdjlxHVuOuE-SI0kjyFBE2nu4nbHyEqVOeHD-mPG7-IRYu-_UimVk08g1cGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:auh5ZHtbby8ISAux1Cqt5QM2NaMi9iAD_du4DbOYhdTusIq1Qg8pgw>
    <xmx:auh5ZLc5QnrMASHqMziQonSFdB0gYeNxVHdIQZG4g6kvU9WMXIwMCQ>
    <xmx:auh5ZD2Zp_UC-q2-VcnoE-Rhz5bOWhShdRXYxLOqLv76-Ro7oFbMyw>
    <xmx:auh5ZH4JQbEaUZW-ju6PcjaxxNcbM6-YuT2tTHpU2kpLD-DrIL4zZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 09:02:32 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d8cbbbf8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jun 2023 13:01:37 +0000 (UTC)
Date:   Fri, 2 Jun 2023 15:02:30 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] t1006: don't strip timestamps from expected results
Message-ID: <5c8b4a1d70b170e3426cdd537edc0c076115be0a.1685710884.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5LJwdUG0gipdqlXE"
Content-Disposition: inline
In-Reply-To: <cover.1685710884.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5LJwdUG0gipdqlXE
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
2.40.1


--5LJwdUG0gipdqlXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR56GUACgkQVbJhu7ck
PpSFcg//QftJHNIgZXiER5EbDZ7WMsRwStd22aN4Woq6w71CDVOdKKEYS+lXcvbG
Kla4qid77yi/eio+RSo41loQkeHtcckcosnulJq0JfvN5P0KUxKbrb0o+EerIyUG
AiV2KjsL35Cwsaf+EWdqDZWNif1e4UQhkwNftXJizhxSUUEnimkZPN5Rt3tf0bJO
ekgv1TuHO0L6GJRTPEz+catkWrF5bEfG5ClA+fiDDBCalFVZ0LZSlSHutGZgDp5b
RwNPn00mW4u3h8kxQ1UgLuYSL3fLHZfUPhjfVG8RbbiJ6lcIftGPonaNYmtoxCCU
c4hKxoz8n/8Kl8nTunD9Ocd3reQSh/e7pw2gTb/eto11NyONyQwW83OIeBs/TVdB
xvC9gaiRQwPxqm1jy131u7IITbrnWmw2ybgTtvqzuTlS9h31yofIojBafUcMPowG
Ma1pBbj7fOdazk86Z/H4KgT81FzQJFfhjOg75TdZLmAjtmON11GM2kH6Pr55lLp+
uZgZ94EgCFrSpYl919+DFI7/Tkiujfxi3CYPZ+9pfmbY5Ny7jn7dBQ2yAxjdNiN6
nFqyt4XSO9ljN/BqOhWxRXejiIicP+4SEcGhSksh3A77hFaHszh2vxXlG7wLSdni
U1Z42ai26p9FRrMCcD727OX1aCYuS9kgu5icf65jcGq1x0OYpGI=
=7phF
-----END PGP SIGNATURE-----

--5LJwdUG0gipdqlXE--
