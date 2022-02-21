Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3D8C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346747AbiBUICi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:02:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346745AbiBUICh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:37 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E9710B2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 50BF75C01BE;
        Mon, 21 Feb 2022 03:02:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Feb 2022 03:02:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=0uSrj3awEo+Z54YxS2JISWEwlLxTjnaLK5l5em
        X/H0o=; b=tX8MKmrm5CMg8gDThd7XZliCcRHh9m4U0emNtYvJbRlZC5GpeGHvHO
        UHZQw4ppXn0UIG54lvuxxtwQxF8Rn9IvDZOyP5CxfF+yTR9+FaIfr8TkXfjDFYL2
        n5ujePmSIzieuh0cDo4KNfZCGm44W6HeKcA1ZJtJJHOfss/Hsynq4qC0oULCk9T6
        9bj37LVm4JcpU/0maLnufcz71EddpiNZLyzZ69cT5O9HFbLxbc5+GiyxCHMWABLL
        Jz/Zr0sukGQ26Zef3Zf/P2XYcW1UlK93OBlha9DTcMHA/mapNC6Rs5rLPkGJUBOd
        aktP9+bAl6iyGs0MvrOpo/czGm0IFbSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0uSrj3awEo+Z54YxS
        2JISWEwlLxTjnaLK5l5emX/H0o=; b=mxJsfK232fWAhPSpqPzoPnefVl26E+wRX
        CTRc0njUr8BYg2syWwwGRLw1fENK1mF5o4zyThcQdstUjqGz3GXUpE93zwFdfjkH
        T+K1ZxqVOS/kD/V0Bgstz99orysygpY9dmM4gLJ855GdnYcXWJlBm0fpwEk6CAE8
        gti7VzzJ6onJ8pAFccyoLVmRhniJO86XGzOnx7s0+4SNXcv2W5CXjK7ZW8arkkjh
        5qVoO1BAHwMge2+C54vwBov8RSaWccVSNFPg1qPzPtLjLoCxUaz6K/48x5ElLHrA
        1qrKsDVTjUEA7nCWJPVeOV+LPSWv+/6MgoKRP8FmQm4KvvSfoT8/w==
X-ME-Sender: <xms:BUcTYkQBpxmlnOnJl8NG1nnP6I0ih9CgdDu7c5EbsgvmGhRMbb3Hdw>
    <xme:BUcTYhy-5GHL6AkEN5-Jud5by-ZBEZoFo58Ng05_4cLZlZVjO-KanlzG7QoupsUi0
    n9bxsK653BTp8nqBw>
X-ME-Received: <xmr:BUcTYh1yYrJABNbzlGZfXxV4U-O5TE5Fa4_yE2g3uZv8CSvqwtSfAcM4jR2jsATlG_HTIiu7HkyYbt-d8zmQqInQsm8jT1tCtrop7zh2Uh4E6gysyydoBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:BUcTYoAQEAQcIJT78sgYrcuKlKFbEhmQlmbr76lfdxTV7oaCARXmTQ>
    <xmx:BUcTYtjK7ZtfLdCEezPWMTDLg7bZdYyQS5_SFRcBLmmQTWIIKufs5w>
    <xmx:BUcTYkoKhNhFMFwcjgOV4FphMIZb1UZG6nPh0bGoujHspv4I5mKqHQ>
    <xmx:BUcTYiuvw0NUD_zLkDrwgHSLt31Dr8Dv21kfl4yi6E6qbgxss3umCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:11 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9f672f38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:11 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/7] fetch: increase test coverage of fetches
Message-ID: <081174b7a00cf094a7dacd8aba89fb137ea40f66.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
 <cover.1645430423.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v7RaiVsMOCcap2gY"
Content-Disposition: inline
In-Reply-To: <cover.1645430423.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--v7RaiVsMOCcap2gY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When using git-fetch(1) with the `--atomic` flag the expectation is that
either all of the references are updated, or alternatively none are in
case the fetch fails. While we already have tests for this, we do not
have any tests which exercise atomicity either when pruning deleted refs
or when backfilling tags. This gap in test coverage hides that we indeed
don't handle atomicity correctly for both of these cases.

Add test cases which cover these testing gaps to demonstrate the broken
behaviour. Note that tests are not marked as `test_expect_failure`: this
is done to explicitly demonstrate the current known-wrong behaviour, and
they will be fixed up as soon as we fix the underlying bugs.

While at it this commit also adds another test case which demonstrates
that backfilling of tags does not return an error code in case the
backfill fails. This bug will also be fixed by a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5503-tagfollow.sh | 81 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh     | 33 ++++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 195fc64dd4..7dadaafd4b 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -160,4 +160,85 @@ test_expect_success 'new clone fetch main and tags' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'atomic fetch with failing backfill' '
+	git init clone3 &&
+
+	# We want to test whether a failure in `backfill_tags()` correctly
+	# aborts the complete transaction when `--atomic` is passed: we should
+	# neither create the branch nor should we create the tag when either
+	# one of both fails to update correctly.
+	#
+	# To trigger failure we simply abort when backfilling a tag.
+	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
+		while read oldrev newrev reference
+		do
+			if test "$reference" =3D refs/tags/tag1
+			then
+				exit 1
+			fi
+		done
+	EOF
+
+	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/something &&
+
+	# Creation of the tag has failed, so ideally refs/heads/something
+	# should not exist. The fact that it does demonstrates that there is
+	# a bug in the `--atomic` flag.
+	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something)"
+'
+
+test_expect_success 'atomic fetch with backfill should use single transact=
ion' '
+	git init clone4 &&
+
+	# Fetching with the `--atomic` flag should update all references in a
+	# single transaction, including backfilled tags. We thus expect to see
+	# a single reference transaction for the created branch and tags.
+	cat >expected <<-EOF &&
+		prepared
+		$ZERO_OID $B refs/heads/something
+		$ZERO_OID $S refs/tags/tag2
+		committed
+		$ZERO_OID $B refs/heads/something
+		$ZERO_OID $S refs/tags/tag2
+		prepared
+		$ZERO_OID $T refs/tags/tag1
+		committed
+		$ZERO_OID $T refs/tags/tag1
+	EOF
+
+	write_script clone4/.git/hooks/reference-transaction <<-\EOF &&
+		( echo "$*" && cat ) >>actual
+	EOF
+
+	git -C clone4 fetch --atomic .. $B:refs/heads/something &&
+	test_cmp expected clone4/actual
+'
+
+test_expect_success 'backfill failure causes command to fail' '
+	git init clone5 &&
+
+	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
+		while read oldrev newrev reference
+		do
+			if test "\$reference" =3D refs/tags/tag1
+			then
+				# Create a nested tag below the actual tag we
+				# wanted to write, which causes a D/F conflict
+				# later when we want to commit refs/tags/tag1.
+				# We cannot just `exit 1` here given that this
+				# would cause us to die immediately.
+				git update-ref refs/tags/tag1/nested $B
+				exit \$!
+			fi
+		done
+	EOF
+
+	# Even though we fail to create refs/tags/tag1 the below command
+	# unexpectedly succeeds.
+	git -C clone5 fetch .. $B:refs/heads/something &&
+	test $B =3D $(git -C clone5 rev-parse --verify refs/heads/something) &&
+	test $S =3D $(git -C clone5 rev-parse --verify tag2) &&
+	test_must_fail git -C clone5 rev-parse --verify tag1
+'
+
 test_done
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ef0da0a63b..70d51f343b 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -343,6 +343,39 @@ test_expect_success 'fetch --atomic --append appends t=
o FETCH_HEAD' '
 	test_cmp expected atomic/.git/FETCH_HEAD
 '
=20
+test_expect_success 'fetch --atomic --prune executes a single reference tr=
ansaction only' '
+	test_when_finished "rm -rf \"$D\"/atomic" &&
+
+	cd "$D" &&
+	git branch scheduled-for-deletion &&
+	git clone . atomic &&
+	git branch -D scheduled-for-deletion &&
+	git branch new-branch &&
+	head_oid=3D$(git rev-parse HEAD) &&
+
+	# Fetching with the `--atomic` flag should update all references in a
+	# single transaction. It is currently missing coverage of pruned
+	# references though, and as a result those may be committed to disk
+	# even if updating references fails later.
+	cat >expected <<-EOF &&
+		prepared
+		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
+		committed
+		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
+		prepared
+		$ZERO_OID $head_oid refs/remotes/origin/new-branch
+		committed
+		$ZERO_OID $head_oid refs/remotes/origin/new-branch
+	EOF
+
+	write_script atomic/.git/hooks/reference-transaction <<-\EOF &&
+		( echo "$*" && cat ) >>actual
+	EOF
+
+	git -C atomic fetch --atomic --prune origin &&
+	test_cmp expected atomic/actual
+'
+
 test_expect_success '--refmap=3D"" ignores configured refspec' '
 	cd "$TRASH_DIRECTORY" &&
 	git clone "$D" remote-refs &&
--=20
2.35.1


--v7RaiVsMOCcap2gY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRwEACgkQVbJhu7ck
PpQMEQ/9GZdeW6eh/i5YKXGsmfkQLx3Pj+153ASV9bvjrOl63K20OKQqW8CeJOpx
T3cavIlrniw4BowTbvIpUCpXeYSZ5qgeN1bJm9mDkQ5KYMrXCyOcxhiLGGLdYDhW
UgBwZxz8LBKXXyr4Yt5bTbToG67/YEM6JUj5HMfvTWivXnIpbPuh2A3UrKkYl0l5
k2mKpP0CBujgTZT9I67PszhZK9/x/rs/IsABx+QPF5/Jt55QNOcOOg7u4uLFI++c
76liqz5IEvhg6SmNyFm9TU4eQ3vxhs89HWyZ05d78Yu8b++MfxbCdKtnBuqr4QoN
Ujx7h+xF84Y8m3/lEp5gISgRT451FFVhJXzukT6QVPbGidEMH/uu89l8CHzS0fOY
DDfnN35Gw13ipXdyrhwaJJAJ6Od4GfTDqlflCUKl5tcO5w4h5aXCSvxSpM5TFtS6
RPHMnpokQAfPAdKkEKai52+qYaE5x8SkqDDuKbtiR96r7VCvi308IIrGgosOCPjp
AukNmaviL9jxbTRFH++zCgY7E1oUK1ubC04Jgz02JiosikaeOHPNVkMFs6l2kC4H
FWqDPKlMxxw2ZW/thDjoOgN/TgA7uavQZojn9lkm9KJA4NHAgSO6gKvqmOCserud
aPbppn/Qxgqf3QP1JYmy1RL2abX/+hW+ToI2v/0Fd4PgvACtxCc=
=euOs
-----END PGP SIGNATURE-----

--v7RaiVsMOCcap2gY--
