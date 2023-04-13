Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE8C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDMLQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjDMLQh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:37 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDE39EE5
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 326A85C00F7;
        Thu, 13 Apr 2023 07:16:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 Apr 2023 07:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384583; x=1681470983; bh=Yo
        q3Ol0C/r5DInKrvIhJCc4iy6qTwlwOhLMm28kwb68=; b=GUTGs2XcZjR4KNEyGX
        28o4wm7mYpnKOvNRe15++493BT2EbY3avOWG5zjkon2afYCVhVaoXWsHVvpfiWO1
        J0ynB3l/KXY0IAr3hrjgxSAQS4gXMj40UTHz5KXSh87+BH769IVTF4ya7wWuLvTc
        iaQiGXdZVeS95D7fn2nMEsiOLrXrfClVvAcPoI7hRp5gzl2rSXKaXSkVUEQUpeag
        dXFX8J4KClYYuGw8OX2Ivag5vT8pkgfpV2UN3E8+Gke/nbYUXTs/SAsBilEXKfAS
        LBqTqlq4YwkkSi/7z2gSswpQQ1FLqt1b0LnHCmZ3QcAJ6mmU3/tJrvaCeH5HMNjy
        CHBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384583; x=1681470983; bh=Yoq3Ol0C/r5DI
        nKrvIhJCc4iy6qTwlwOhLMm28kwb68=; b=WUpTiQx7oX1smVLyq4nGOGBKIVQBw
        wLKPXbTMLCsi6O8LjsHIXz3s3Urp20+TNCchSE7dcSaVuWQPWI8qNRupjWS6/RI4
        ZKQgPlJvGx8squbf3KkwWVjelZSs0NRcgyj6TnpVyIwiM40H/jElrrXpIWasrIpb
        kv4gsku4LzzQgtXZMItdrOnPR5mVtdGZ+ebwWscx0bhiScF5YUAAYz/Aie6s30o8
        jRRu0MlFlILyq9w6yH+y10XrZ6IiRhutmNtLcbjkeTaGhdQnoOYQ8n9zYhqkq8Ut
        O379ut2aNqvX6L42TjFehZnEeI/5qJNei5sjst2jJL9pzYWb7toN0ORYw==
X-ME-Sender: <xms:h-Q3ZCc_PsATrKIlfG6Df9buk50Tw6OvAl5S1yiLyRtlGXThLK5uEA>
    <xme:h-Q3ZMMJKBnIlaHIfKFSFtd-H4LxHIsnuv20ae8iOoHHllb3Gsy8JmW4cR__Hkmsr
    QHqMFtC0dq1-ScOtw>
X-ME-Received: <xmr:h-Q3ZDiy9b9-071bsQUP3DUrWLOYndlC7c_zZ68cZdt3Mi1tqQQNQuTcZDU0VLgv6JRnzC2uzYYWx0pJzaumxSSneYid5OJD5IE6_V0GFogmhZU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:h-Q3ZP-dPprVK0lRlOMei4iy5-3syBqjqIWsyKdTYeLAlN3t5o091w>
    <xmx:h-Q3ZOsj9PNXzM93XMnofD4jbRSK7BJpIzT5JioHinG3ht93fhF1OA>
    <xmx:h-Q3ZGEJw57-qCCDss4LHnozTs-8DppXXM3iGuXie5iyK-OX3i7Efg>
    <xmx:h-Q3ZH6jiffS3cRotfP22FtetUAkmHLUCb2QMLOJ4xGXRL06MotNhQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:21 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3c0b2771 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:15:58 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:19 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 04/10] pack-objects: split out `--stdin-packs` tests into
 separate file
Message-ID: <8d47d753dc03979bd515f473a591906ba03c0c2b.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1AkIszyILeUugda0"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1AkIszyILeUugda0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test suite for git-pack-objects(1) is quite huge, and we're about to
add more tests that relate to the `--stdin-packs` option. Split out all
tests related to this option into a standalone file so that it becomes
easier to test the feature in isolation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5300-pack-object.sh        | 135 -------------------------------
 t/t5331-pack-objects-stdin.sh | 145 ++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+), 135 deletions(-)
 create mode 100755 t/t5331-pack-objects-stdin.sh

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index f8a0f309e2..d2ce236d61 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -589,141 +589,6 @@ test_expect_success 'prefetch objects' '
 	test_line_count =3D 1 donelines
 '
=20
-test_expect_success 'setup for --stdin-packs tests' '
-	git init stdin-packs &&
-	(
-		cd stdin-packs &&
-
-		test_commit A &&
-		test_commit B &&
-		test_commit C &&
-
-		for id in A B C
-		do
-			git pack-objects .git/objects/pack/pack-$id \
-				--incremental --revs <<-EOF || exit 1
-			refs/tags/$id
-			EOF
-		done &&
-
-		ls -la .git/objects/pack
-	)
-'
-
-test_expect_success '--stdin-packs with excluded packs' '
-	(
-		cd stdin-packs &&
-
-		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
-		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
-		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
-
-		git pack-objects test --stdin-packs <<-EOF &&
-		$PACK_A
-		^$PACK_B
-		$PACK_C
-		EOF
-
-		(
-			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
-			git show-index <$(ls .git/objects/pack/pack-C-*.idx)
-		) >expect.raw &&
-		git show-index <$(ls test-*.idx) >actual.raw &&
-
-		cut -d" " -f2 <expect.raw | sort >expect &&
-		cut -d" " -f2 <actual.raw | sort >actual &&
-		test_cmp expect actual
-	)
-'
-
-test_expect_success '--stdin-packs is incompatible with --filter' '
-	(
-		cd stdin-packs &&
-		test_must_fail git pack-objects --stdin-packs --stdout \
-			--filter=3Dblob:none </dev/null 2>err &&
-		test_i18ngrep "cannot use --filter with --stdin-packs" err
-	)
-'
-
-test_expect_success '--stdin-packs is incompatible with --revs' '
-	(
-		cd stdin-packs &&
-		test_must_fail git pack-objects --stdin-packs --revs out \
-			</dev/null 2>err &&
-		test_i18ngrep "cannot use internal rev list with --stdin-packs" err
-	)
-'
-
-test_expect_success '--stdin-packs with loose objects' '
-	(
-		cd stdin-packs &&
-
-		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
-		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
-		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
-
-		test_commit D && # loose
-
-		git pack-objects test2 --stdin-packs --unpacked <<-EOF &&
-		$PACK_A
-		^$PACK_B
-		$PACK_C
-		EOF
-
-		(
-			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
-			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
-			git rev-list --objects --no-object-names \
-				refs/tags/C..refs/tags/D
-
-		) >expect.raw &&
-		ls -la . &&
-		git show-index <$(ls test2-*.idx) >actual.raw &&
-
-		cut -d" " -f2 <expect.raw | sort >expect &&
-		cut -d" " -f2 <actual.raw | sort >actual &&
-		test_cmp expect actual
-	)
-'
-
-test_expect_success '--stdin-packs with broken links' '
-	(
-		cd stdin-packs &&
-
-		# make an unreachable object with a bogus parent
-		git cat-file -p HEAD >commit &&
-		sed "s/$(git rev-parse HEAD^)/$(test_oid zero)/" <commit |
-		git hash-object -w -t commit --stdin >in &&
-
-		git pack-objects .git/objects/pack/pack-D <in &&
-
-		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
-		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
-		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
-		PACK_D=3D"$(basename .git/objects/pack/pack-D-*.pack)" &&
-
-		git pack-objects test3 --stdin-packs --unpacked <<-EOF &&
-		$PACK_A
-		^$PACK_B
-		$PACK_C
-		$PACK_D
-		EOF
-
-		(
-			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
-			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
-			git show-index <$(ls .git/objects/pack/pack-D-*.idx) &&
-			git rev-list --objects --no-object-names \
-				refs/tags/C..refs/tags/D
-		) >expect.raw &&
-		git show-index <$(ls test3-*.idx) >actual.raw &&
-
-		cut -d" " -f2 <expect.raw | sort >expect &&
-		cut -d" " -f2 <actual.raw | sort >actual &&
-		test_cmp expect actual
-	)
-'
-
 test_expect_success 'negative window clamps to 0' '
 	git pack-objects --progress --window=3D-1 neg-window <obj-list 2>stderr &&
 	check_deltas stderr =3D 0
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
new file mode 100755
index 0000000000..d5eece5899
--- /dev/null
+++ b/t/t5331-pack-objects-stdin.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description=3D'pack-objects --stdin'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+test_expect_success 'setup for --stdin-packs tests' '
+	git init stdin-packs &&
+	(
+		cd stdin-packs &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		for id in A B C
+		do
+			git pack-objects .git/objects/pack/pack-$id \
+				--incremental --revs <<-EOF || exit 1
+			refs/tags/$id
+			EOF
+		done &&
+
+		ls -la .git/objects/pack
+	)
+'
+
+test_expect_success '--stdin-packs with excluded packs' '
+	(
+		cd stdin-packs &&
+
+		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
+
+		git pack-objects test --stdin-packs <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx)
+		) >expect.raw &&
+		git show-index <$(ls test-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs is incompatible with --filter' '
+	(
+		cd stdin-packs &&
+		test_must_fail git pack-objects --stdin-packs --stdout \
+			--filter=3Dblob:none </dev/null 2>err &&
+		test_i18ngrep "cannot use --filter with --stdin-packs" err
+	)
+'
+
+test_expect_success '--stdin-packs is incompatible with --revs' '
+	(
+		cd stdin-packs &&
+		test_must_fail git pack-objects --stdin-packs --revs out \
+			</dev/null 2>err &&
+		test_i18ngrep "cannot use internal rev list with --stdin-packs" err
+	)
+'
+
+test_expect_success '--stdin-packs with loose objects' '
+	(
+		cd stdin-packs &&
+
+		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
+
+		test_commit D && # loose
+
+		git pack-objects test2 --stdin-packs --unpacked <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
+			git rev-list --objects --no-object-names \
+				refs/tags/C..refs/tags/D
+
+		) >expect.raw &&
+		ls -la . &&
+		git show-index <$(ls test2-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs with broken links' '
+	(
+		cd stdin-packs &&
+
+		# make an unreachable object with a bogus parent
+		git cat-file -p HEAD >commit &&
+		sed "s/$(git rev-parse HEAD^)/$(test_oid zero)/" <commit |
+		git hash-object -w -t commit --stdin >in &&
+
+		git pack-objects .git/objects/pack/pack-D <in &&
+
+		PACK_A=3D"$(basename .git/objects/pack/pack-A-*.pack)" &&
+		PACK_B=3D"$(basename .git/objects/pack/pack-B-*.pack)" &&
+		PACK_C=3D"$(basename .git/objects/pack/pack-C-*.pack)" &&
+		PACK_D=3D"$(basename .git/objects/pack/pack-D-*.pack)" &&
+
+		git pack-objects test3 --stdin-packs --unpacked <<-EOF &&
+		$PACK_A
+		^$PACK_B
+		$PACK_C
+		$PACK_D
+		EOF
+
+		(
+			git show-index <$(ls .git/objects/pack/pack-A-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-C-*.idx) &&
+			git show-index <$(ls .git/objects/pack/pack-D-*.idx) &&
+			git rev-list --objects --no-object-names \
+				refs/tags/C..refs/tags/D
+		) >expect.raw &&
+		git show-index <$(ls test3-*.idx) >actual.raw &&
+
+		cut -d" " -f2 <expect.raw | sort >expect &&
+		cut -d" " -f2 <actual.raw | sort >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done
--=20
2.40.0


--1AkIszyILeUugda0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35IIACgkQVbJhu7ck
PpT2ng//TCsVJZ3QJIJlJpN6/ODZR26XZQBIR/EaioInxGJWaKNpwBoQ4vE0M/TD
OtFs5fDmMKcXAa91yTdbei3uPKaiMde4dylVY42hvOlYXdNH7HLH7Hgk1S38rSgn
MRMBdrVw+DWNVO3pSXYqFKX6Od/1NAWNkjiNTdezqKUUUj8q/7bqBzCbaYvib2Ct
YOHT/5146fa4CwhwvJIYZPaWNQ6Xl/5214PhXTsKVaBPi72KSDgPzzXtKKZBefyx
Gt6L8GDspfNuyALLVSVYAqWkg3dRUCOdgvq87F9XY8fN5UU/Zs4o2eLRhwiWFGoY
9t2+wqA/xuwOKA1XTbZFxs3mhsqyrgiPFfeWeC4TOTsivtaDsvlJAThLGdqiprBM
7XnhZaIHYnjpg+eZr7kE3X3+QQVeGx/fca3My2RafhG3NDJ5KJk/b/UmzJl7DqAh
l+kPlak1Ch1OTOQjDKy9Zn+9HVCOF9eld0IdkuEHHQhth6oR1JssMUSeaX33Po5o
OoXTeW4LEARUY2Y3b9T4/dKCMo5SpYDoNW2WRhXLbCDP+xvfxKzITj6fd1xAKvk6
2lhe9SdwNgdX/Ygj4ewqhSNPDXB2DcsLA4pdJ93e0T5HnHvA535i3iLmjjoqlFXg
hP7s/SOsRlq6iVjKlkEkNgHy/+ky4ARDbvC3HvdfjIJJKDhBhMw=
=NW+W
-----END PGP SIGNATURE-----

--1AkIszyILeUugda0--
