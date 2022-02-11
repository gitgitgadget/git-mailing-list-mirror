Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078C7C4332F
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347794AbiBKHqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:46:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiBKHqu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:50 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BC72E9
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:46:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 03D8D3200EC0
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 11 Feb 2022 02:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=3pchqvptU0rdpDMElNWXPwyxzFSh/vIP9EYDrR
        ucp9w=; b=UNMe3VwWEqTSIY6BUsRAvaYTrMHcx79QT+9QxcYxpNimr0qGliJRRb
        lyFz/hgSPp+X4gjCVdAaegJsg+m0HHA+IywARtrz/uCOXaTamWw83iq/ai3ZjxX6
        6I1xYliIjSsRJ8zLCJNfKkITFmNhm8EwjlRy5+HGFFHYbxIvBjOWZMIr43CGLaqB
        YhXdb8jep6CpAURE6VLHS8ddFcvk39TVOPl+8r2f9NXlz1RmHjH1A9qORH25M9nc
        X/uQbH3Y82ZMefZzUyZdxYW6WrI/TAdwZRu8GDHE4XdJmM2AIPS3txL/U3Uv7/Bh
        WDUP8pIBuy0yE7/+szTxhZxhNf3aMfWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3pchqvptU0rdpDMEl
        NWXPwyxzFSh/vIP9EYDrRucp9w=; b=duclNaRh19nUF4CTQJylh8/cIF7RBIy2l
        vhOINsnE3qfzMk8yqAyMcek+i9ENAt0zwwEws6sWXlLsKv+FqayUznUM+pcuUsra
        fQF28qHvCrSi1Qb1LvPwgUis3RQhdavoqhcw/QZzsOYHdp1HGCZDp1bRugmvlkBX
        hQfGr3BsyKt/DQje8MYHzk/DR3JZBJFUzxBiWj+/Dy1t0w4IJANcvDLtSYyrs2RX
        A9xVp6t0PlVtqjz6HzVGv7V8VF+rZOBN6IxQNZOAk3nUPvoSKTs+MREzcPqkC+sm
        T5Lqa1LNY2NWmdFqevchiraE4D/UkCLbL9fL3y4Oqud5yh3LEKQlQ==
X-ME-Sender: <xms:aBQGYrCRvsEns1wX9O1Z1F9_TzxH0vfC41fBBtIi9BXtbjXVdo1NpQ>
    <xme:aBQGYhhEPuvJVXTYjvqjUxqV4glDktle4pNLoztmr4zvTbAaXW_32QPEAmkVxwA5q
    IK33mGR-N4tHrXRSA>
X-ME-Received: <xmr:aBQGYmnmMKio1-_Ax_e048NwdjzYzYKIWMrzkUydANJj9iE1-HycmFz3l19uHgrey4NYfMCtfgBi5LB0WUvUOXGAwBsbEv1XEoaDqKrgntEm00EYtJkIkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:aBQGYtzcg0fLY0jUXohxUa8af1C6W0uCdLDnqA8YXLbH5XJVlBysQw>
    <xmx:aBQGYgR2porMP7heNrDJnl1SMdhPuXtX35e1QUT5_VO48sVxxiL9Kw>
    <xmx:aBQGYgZ0fltqSKXxgINFgRnDqlGxhTy8YwnBHCyDFnZbiv_7W6hfXw>
    <xmx:aBQGYvPhjS49KLN_Aj1cx6s6XmZkx7o6agLWBx8CHWr6dR1yZb7Ifg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:47 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c04c585b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:46:47 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:46:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] fetch: increase test coverage of fetches
Message-ID: <e133c14f569116156bbd3e0ca4874e8eb54b76b8.1644565025.git.ps@pks.im>
References: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bUUWG9YcHUQUFn1k"
Content-Disposition: inline
In-Reply-To: <cover.1644565025.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bUUWG9YcHUQUFn1k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--atomic` flag is missing test coverage for pruning of deleted
references and backfilling of tags, and of course both aren't covered
correctly by this flag. Furthermore, we don't have tests demonstrating
error cases for backfilling tags.

Add tests to cover those testing gaps.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5503-tagfollow.sh | 85 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5510-fetch.sh     | 33 +++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 195fc64dd4..888305ad4d 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -160,4 +160,89 @@ test_expect_success 'new clone fetch main and tags' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'atomic fetch with failing backfill' '
+	git init clone3 &&
+
+	# We want to test whether a failure when backfilling tags correctly
+	# aborts the complete transaction when `--atomic` is passed: we should
+	# neither create the branch nor should we create the tag when either
+	# one of both fails to update correctly.
+	#
+	# To trigger failure we simply abort when backfilling a tag.
+	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
+		#!/bin/sh
+
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
+	# should not exist. The fact that it does is demonstrates that there is
+	# missing coverage in the `--atomic` flag.
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
+		#!/bin/sh
+
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
index 20f7110ec1..93a0db3c68 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -332,6 +332,39 @@ test_expect_success 'fetch --atomic --append appends t=
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


--bUUWG9YcHUQUFn1k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFGUACgkQVbJhu7ck
PpR1Rw//cVAYAD7ORi/sXuqc8RhZXtL6jPkTQije8LYW/9kfS6rOUTUG9wOfpr0s
UywBy8Kt/oKR83p2OvZgxcHNaGdC7JCrLzZgXBobp+O2JuPYhym1PT32Wfu/CaS5
3gXZj0m9QyClZDD26hCMNl527TvEvmBXSeMnBuadAOeltSXsXFfv3DgWdT5DRjVg
kbd0i0eV8ZbC0zUTOUjvFeUwTEELsxHXz64nrUq53Van1mQdEMw59scVJhZgxToa
D3XrnqM3fwDeawjIC/Va4R6FZo9vi+kYn7mhJxU7spmDdDjeZbEpPt+l8TurF4J7
GYScl8Z8gcgOFHEfKvK36X48xWHBXCE4XLVjBDGSl6IXsytbV/1T4Qv2phH3LQGj
zLMzxsTku3bkjAgTwvgVVCEQEhtnD4AmlOaFA2WPRiX9Qra76mJpMVVaJ8ebyH+6
0mZOpVoG+ZZkeEPykz8cKXeJkudjVaS+imaF/q8UMcHwIHLToKu7tvmLH8QI50Bp
CBbfs0MYxoPNNI1NdOHzAvBl+QFabWd3ZY5fDtY5MSJKeN8qy1cCugryMkj+81Bk
f+FywGXLbUvvcv6WSVIUmrp7LDWmzMHhsq/aCzjC7/haW3tbYUPgvhm0o9Gjx61M
tYP1NFbrOwGWyb6vUw3CZ6/SVX3fy/OsNQu/GfPk3s36mZTyGRQ=
=cHwc
-----END PGP SIGNATURE-----

--bUUWG9YcHUQUFn1k--
