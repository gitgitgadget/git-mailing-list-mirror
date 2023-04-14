Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96110C77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDNGCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDNGB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:01:56 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F18761BE
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:49 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id DC03D5C0081;
        Fri, 14 Apr 2023 02:01:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 02:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452108; x=1681538508; bh=HZ
        SrvKU2K+aJHCucXDqM96bX+efoAp6BOLlWb3URG8M=; b=lo6HisiTZJ7Bj2KqlS
        pHqCdAju8YME1iF2wXqQnelrDEbqBogiqxgPISxMOXHYGKQwGr99rfHVqvwUQAP9
        ZVybfaNKt3eLYURtmh5zaRdk0sNUjUgltzH8Odjcddzp3fl2H9Im1w/HBBaKNB2D
        4i/4Ct8HbkKM2xskNUCIsmdE8QEK9r9CXpDDbXmMgS41qBHEiQIityDFhU9zilxE
        EDYcwFT6FfhmL1ZWVotKtrS9yCmoInAuCplE608Ybp8cEz51NJOU0pAgLcif4tty
        hB0SlQByfS5pX+pIyRjM+ttASXUgsGVW+H7gswKD62pVU1yZMFi9qxqvlSI4YnTK
        LK6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452108; x=1681538508; bh=HZSrvKU2K+aJH
        CucXDqM96bX+efoAp6BOLlWb3URG8M=; b=GvnoZYoDuDT/MQJ5QFk8Ig+ziwneu
        CfrzSvFvLgZJN882PG9huAut6W4LW3kdOLSQbD4VBKsqtZLFUgT6/xkioEuCHYEr
        K1d/6HYTb/EEtNYmw/fHRWBqkijm5XxDg834BotN8yqyRQW6rn6RH2EgpoTMvIeB
        OrFSrIgLHbyJXfxSHAW9AIq+Fc5YBT8f+XWAHoNUJ9USAf4eMJhUzuu7E/lm+eiB
        NT8XKOjsdNTJztM/H7/RHpevLIhDMo2Nbuqa5Dd6xizO8Z636aeFudxxuaCiP3Xv
        sOHoZ5jYqbOMYcop8rvRlp31EOoi/0wTyv4SidSe5jcG1A+PF11oGjruA==
X-ME-Sender: <xms:TOw4ZLeELWiTDu9orZe37GG7AtJ3j_YKiztS-e7enye-JsrQnvGpCw>
    <xme:TOw4ZBMISJNBh-mRD4_GUcUAKt_m7bcBc5VVxyHA7fRhfqgcO4VRk01cf6b1AxhTL
    UlD1W4fJS3Lw3vH3Q>
X-ME-Received: <xmr:TOw4ZEja0E-DPM2y5WarAQjqwgg-b_M4UCl-StX-xKdgk2qD7XwId8OeDjdiEbrZ9CDwHDrAvz1em1szDTjsWQ71WAim-AGg6QPQwgiHfKIr_IY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TOw4ZM8MTY_zrchn4djVVpwajMcA1nkeuAu4EA6-7KVvr2RYYzVtRg>
    <xmx:TOw4ZHsyaMoyRCxWzgsMMi4VhFgCndA_6zX4SYFHmPKwNxfpdaILqw>
    <xmx:TOw4ZLGcAoCtnLq8d7RH1nYzvwaLlyRHFLwvGF0P8x0s7Aa_TnNYBw>
    <xmx:TOw4ZHKH5Zl8Olrl1NJ6O_askSUNX7htrySKWfJ26R8d4QUzPauhCA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:47 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 6259c33a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:45 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/10] pack-objects: split out `--stdin-packs` tests into
 separate file
Message-ID: <bdd11864c220a66120704462a41d16935735d0b0.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SMj8aLmcb0q0axj/"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SMj8aLmcb0q0axj/
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


--SMj8aLmcb0q0axj/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47EgACgkQVbJhu7ck
PpSN4RAArPi5dfi2NcwBtfNUOBVvyI7lgnw1ymNn8r8kibVkIvotHMIYNxtQz7VL
tojR8FJNga/fkkAYyrc36FpExd7YR8OPDeFzwhwHBr01VtWPzv2YlTmxQ4iaaz4E
vzBw2h4VZFAIeKQHne4Tq0JX1pa7kX8LIIqt0P9Ki9bQ6tux/KGt1hZn0B5uNtuP
6wOmqPw/Dt9+nHg9Tm/ioTlbWvfOPxUylai/VNZCmxMfepvkSMdtNrZnLK/7h5FN
7voiCYN5JEt343G24U1e14VeyejpciHdn3zSy4nyPVol/Qv2gnqmA3bl8gp3HmJB
pqFiriY7s655xwZCx3bXt4zmFgft5Yg0BATU7l8c/igaLhEpTTvXNWPA3o2b194t
w7kWM9sms0X8p6j6acWB1iTfbNhLjQvXCuBIrEhqVWb7QPX69ui6YL9slze6y7QY
vu4s5LGJskgooaNfM5Yu0/inkH2SwyYscmT8XvJ0NY05Bpfc6K1Ajfx6Caq2wh8p
8ZH+ELRzJQ7BnQMahp1G7EWfcUsL+PTyYSGmXU2ZrFZa0QJiVfrTpbMgoiFQnrL7
lfW3J/tXpGPrTuzNp9FhwX0Jj0EYFnfxpsbN0n9//Mob9ZUYowpC7Z3AOC55p4q8
HM20tsvTrP0uiKVbf4dWyJqjm9PxND199XuyVS9XOSEYRKlvqFo=
=/9aQ
-----END PGP SIGNATURE-----

--SMj8aLmcb0q0axj/--
