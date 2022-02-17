Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCFC433FE
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240641AbiBQNEh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:04:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiBQNEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:35 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A82AA3B9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:21 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B6BB23201DDC;
        Thu, 17 Feb 2022 08:04:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Feb 2022 08:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=sw2cR2H/8Pt8Fhj7CzRoX18HQtQgRVvb1FqLUJ
        3zCyM=; b=S32iC8N0FTQBC1Z5CZrIKEiG3WVDKxHvte5hUHD0pcJCFKHc3h5blu
        gAtiOKMOCKl+SqNlVkeOFmm4RMk9i/QJva/ohwZSjRZm/5B2sMZw4RkdBCwtAoHY
        /Pt/YNTeVvnQd/qyENHxamt1ORHtCpFnJ+4d4Kmf3AsrnSj96y9Dy5bBa08JNk1V
        b2+dXRWFIlAxHEsQpEUsx/bY6tPOvv3yeol7C52jRkerUCnB9ibV0RyvwSBYwfQ5
        +fEx72r4xO+aDmVh2J0ASXfZe+6zJmp8gTeoZMnMmmMqo1Q6mrmsbdYTtvuOlBeP
        yPHm2s1E/i5vlUDv6dGk7DXhfJpQM5uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sw2cR2H/8Pt8Fhj7C
        zRoX18HQtQgRVvb1FqLUJ3zCyM=; b=EoLPZyfnd9rn1pKRqabUy7RJvJnXgcqSP
        L6x/+CfyXpYmcfDK3JHe0nihijyQQD1GcH4xd1m3gpQqqKzb625TvTyNqTsNGVNb
        sT+EuXz/Hs62MlJ6YwZtZ54FKjOcJj0pPEkXjwVradcpvSpoctYEh4kCHQ0qVhSL
        55W6/6fUk9ZfXj1TbIRFqlCxISKpa7Y3B8LudD/qf8rbAme60TFkV6kvOMHQfxO+
        KCsheBH7HQNtyhsNlymrgu3URPSFrJ+tqzGajD5exdWoxr19oM+RBb+e39NuHue9
        nD03Iv2dHEy2/re8iexdTgTNPwnNHHDrSoKuQ/nfhWto0JnIa9faQ==
X-ME-Sender: <xms:00cOYnxQ3TKKPfl4AODdGoJ0lzexGFVWLjkRNTZBgTRD4Aykh1Hs1g>
    <xme:00cOYvTI0IB8_2-a8TfwZuPeKPUGk5vFsOnNv-6nFeukIeCJFuqe_aaXHvKqXjNfu
    E6F1fcOALMkikw_9Q>
X-ME-Received: <xmr:00cOYhUgwT3ABiA2aEKO3Ai5ffo8CNGS5BvSq9xpZ3x8tYwecp_YJnlqyVZkVjsDdp64h-o6J2poJjsY_zNqY43f8zRY4kejeU2Y2UP63RSXrO5oA50KRNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:00cOYhjzTNyNB5UMYsiH8QmTAtJNUUjp7LGbJHaJMuIxFCJWdx04qQ>
    <xmx:00cOYpDVjhXFE040HhOmY6Vk5GALFUsmWeIQE-7EnA5C9M_L_mCqOA>
    <xmx:00cOYqLqVsOGLrAKHmS6zLeDkx-ulfCnd8SMqdxAa3-nSLY1xvZUNA>
    <xmx:00cOYsMEqYiwZawhR9PMg5LCupU8KAZp6Ah05P5HuWxPGMA0-lERXQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:18 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4405b10e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:17 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/7] fetch: increase test coverage of fetches
Message-ID: <b4ca3f1f3baacde2aea7bae4f583f68c211a557a.1645102965.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="X6kBdmhR7o198X3t"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--X6kBdmhR7o198X3t
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
index 195fc64dd4..6ffe2a5719 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -160,4 +160,85 @@ test_expect_success 'new clone fetch main and tags' '
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


--X6kBdmhR7o198X3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR88ACgkQVbJhu7ck
PpSQbg/9EsrV/qYwB9fe7DEQVqoF7UuJqRSDJMe5wjA5ANMxYpAe38g4257QgcoN
pCLI+7VOlhon//a4751WIvJudTP0puXHPmcT7liUaONfrnOcMsbmZjk/GaYsbYNC
4THxTe1Lub4Jz98d4IW6UO+n6KOba4afUnnxo4d3dmyTn0gFvVBBljFH3r0zP9Hk
mmsAUTSXckGEvzS6aAe6W1UJwdiPu1LsWTBfBXPKdVPrzqk8tKtLdGeIRU3RwwRT
iAQy3RkmlhwWJuv1fj8devLeQ2E5D6r7x7qnu6AtIAHAd42eym0vVArVEd7MRBLq
TNOKEosSCbseypOj8adv7tVaakR9nFrEhindI0HALsAkraPo7Pq4DNFIbV4grNne
w3iDwh7vx0n2TVRvvGmc2pCm15RDVMsrvsAjjRPfcZ0hpcsj2+D18n30r3Lp0+81
3k04f98OqU2ni9pHHtmAi90QG61JTCRDp+A9AjQiZ1au9NxrGpLle/I63koklpFf
/fkBur2AtO20a1GEwizhXY7rRkaHmc3A2xrmQB5MooE0vytIb2NCskDlxP/CByE1
u7zf+GmIRmFK1dvau2hQL1vP3Sy6dueUfhkC1TRlLdcXq+qpPoh/OZ87i2BO2c5L
WdbNRQoIvxXh6zoWrY7C6CoYam3YgxiEA5dNxtoiDNU8Lm0IXo0=
=TttN
-----END PGP SIGNATURE-----

--X6kBdmhR7o198X3t--
