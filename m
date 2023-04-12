Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D129C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDLKW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDLKWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EE87A9B
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 40C2D3200979;
        Wed, 12 Apr 2023 06:22:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 12 Apr 2023 06:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294967; x=1681381367; bh=WW
        xzsL+aogjS+iPsHi7EjPHY6gJwOSprOj5oHJjX0tA=; b=YDUWb7GhNTdlUxldhJ
        XR6m9jKtDYZhTvOd/rP8yOb8+Wm1UWfcmTPmAyJtrRznD67hACtVlOT8v+ZxI7Ue
        sy6vOgtmTkQNUi1VtBI9inJeWFGwIFK0FEiRG3hGvs19+khRNlVKBV5iTEMYEUF+
        B0h0l8pDI1Oreun4tp9yoIIcvUX3fKwZaOklOW8LnemdP0bp4WRxRM+iYzsVKHD7
        GCxiDUdErgU3oruJmueMD7l1yQFkvz6036zmMeZJ1rJKieFDbejZJqGip7gO3GYs
        pEZFbCWbhoOJCKl8Jy/1RLL45pF8Y320ZkT9tcdYKQM6SYmZnwlVRwSqf2MgtY2t
        BbHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294967; x=1681381367; bh=WWxzsL+aogjS+
        iPsHi7EjPHY6gJwOSprOj5oHJjX0tA=; b=SWEq7ww1ud4GSItsWebbM+Sirg4ND
        jezfrea+/zegSgNmi1HKvDDM4xCgeeIdxcQlDKUdVcuQcwVcdK2FAPBFqy5dRTL0
        F8kVp7VbVh1bT2MbwmK6op8iRm3V9EDtGXeg49ANoccs6DdaxGKWg/0WPEKRFpde
        KY9ajTZoZBBr6x0soV4ea2lE/D2Sa3MSG9Hurb9miMKe45TtGSFGt+1nLPE87z6Q
        ZeLKd5fwdehBQxlm0V2/QTrsmmjtv/PgskUisGZYWy3+M2blaZ0aLiJZMhaFFNzl
        WBx8fAFgApy46wC/SIbgo8vQTkDHRbmgmGJPzK1PbFWB/dMpblhCOSmFQ==
X-ME-Sender: <xms:d4Y2ZDH7C4wW59v5anNwxZGvA_No_51YAyqWxQIVGjqxmH6tExI4uQ>
    <xme:d4Y2ZAUW6rufRSTVhyZxLKdrvDv0xVDzQLgqoFicU4XTmWKd9vZW3yiMSEfXxRdny
    sZMO1hGItnlxE9sww>
X-ME-Received: <xmr:d4Y2ZFI2cOyQa0YGclxYrSmxHEdkt0TH6m77JS_l63QsaP30omX_nqcb6RB6_j0aTKg_iW7vQ6gjzsdxGV2uokxdladVPUWOukHsG9cdzWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:d4Y2ZBE5EPF4z4C3VApyNn-JyAzoE97X-iFfPPz_FrUpZ32F263LBw>
    <xmx:d4Y2ZJVWHc0nUoM_91deDrZ5_7sC-THtNPtZ3JDjoBiFW2XRHiugIA>
    <xmx:d4Y2ZMNXijmAJpXjjOG2-1VxAdQZuyVII6y267vk-14_ER0YBkOR8A>
    <xmx:d4Y2ZGjB4nRy6IdZHrP0WrmJuU_89kYqVb9bnR7IxysMpYrbKYt9Kg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:46 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b78cfa58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:25 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 4/8] pack-objects: fix error when packing same pack twice
Message-ID: <e7d30fd22c65b33defb944bd043a56d0c525f875.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y0ZVHOLJiAVeFlZq"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Y0ZVHOLJiAVeFlZq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passed the same packfile twice via `--stdin-packs` we return an
error that the packfile supposedly was not found. This is because when
reading packs into the list of included or excluded packfiles, we will
happily re-add packfiles even if they are part of the lists already. And
while the list can now contain duplicates, we will only set the `util`
pointer of the first list entry to the `packed_git` structure. We notice
that at a later point when checking that all list entries have their
`util` pointer set and die with an error.

While this is kind of a nonsensical request, this scenario can be hit
when doing geometric repacks. When a repository is connected to an
alternate object directory and both have the exact same packfile then
both would get added to the geometric sequence. And when we then decide
to perform the repack, we will invoke git-pack-objects(1) with the same
packfile twice.

Fix this bug by removing any duplicates from both the included and
excluded packs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  2 ++
 t/t5331-pack-objects-stdin.sh | 29 +++++++++++++++++++++++++++++
 t/t7703-repack-geometric.sh   | 25 +++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100755 t/t5331-pack-objects-stdin.sh

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77d88f85b0..fdf3f440be 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3359,7 +3359,9 @@ static void read_packs_list_from_stdin(void)
 	}
=20
 	string_list_sort(&include_packs);
+	string_list_remove_duplicates(&include_packs, 0);
 	string_list_sort(&exclude_packs);
+	string_list_remove_duplicates(&exclude_packs, 0);
=20
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *pack_name =3D pack_basename(p);
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
new file mode 100755
index 0000000000..ab34cfc729
--- /dev/null
+++ b/t/t5331-pack-objects-stdin.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description=3D'pack-objects --stdin'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
+. ./test-lib.sh
+
+test_expect_success 'pack-objects --stdin with duplicate packfile' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		test_commit "commit" &&
+		git repack -ad &&
+
+		(
+			basename .git/objects/pack/pack-*.pack &&
+			basename .git/objects/pack/pack-*.pack
+		) >packfiles &&
+
+		git pack-objects --stdin-packs generated-pack <packfiles &&
+		test_cmp generated-pack-*.pack .git/objects/pack/pack-*.pack
+	)
+'
+
+test_done
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9e95350cbf..0a2f2bd46c 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -336,4 +336,29 @@ test_expect_success '--geometric --with-midx with no l=
ocal objects' '
 	test_must_be_empty actual
 '
=20
+test_expect_success '--geometric with same pack in main and alternate ODB'=
 '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a repository with a single packfile that acts as alternate
+	# object database.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+
+	# We create the member repository as an exact copy so that it has the
+	# same packfile.
+	cp -r shared member &&
+	test-tool path-utils real_path shared/.git/objects >member/.git/objects/i=
nfo/alternates &&
+	find shared/.git/objects -type f >expected-files &&
+
+	# Verify that we can repack objects as expected without observing any
+	# error. Having the same packfile in both ODBs used to cause an error
+	# in git-pack-objects(1).
+	git -C member repack --geometric 2 2>err &&
+	test_must_be_empty err &&
+	# Nothing should have changed.
+	find shared/.git/objects -type f >actual-files &&
+	test_cmp expected-files actual-files
+'
+
 test_done
--=20
2.40.0


--Y0ZVHOLJiAVeFlZq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hnMACgkQVbJhu7ck
PpReABAAgi7fJ6gW66dnlDnSvjI9SDOeEdaHPL9nR4ae9VBp3NcD8mRQcY4EjMkr
rHpWGe89/TflkAiJ0DiJfVki3Fvz5aGIZg93ZEZJY8ngv2sA76+jzmf5Wnd7PMo7
H1ufdkK0nRFqpSI06Ql+P2ixrcsmvBnRfuQe6tsB3pZV1YIQZgseo4r1OTskHII5
FNx66PZ6qNCFDWA2GFk07zORjdmPnORbe1/Rir/IvWHlZIaA0SDUV5Q5qbFcADwG
nEAzG9hl1/PxDFogIi+Y4loKNhbEE2YdAywJI9xcMV9nXmDLunOXFeEesV0EiZhM
+K1e8aaf3Yd5p0bER5CJiJd0wZWTU/1cM7rE3FxE4UqXsYDIlA0w28Ug1fchrL4r
zIBlK6G5+vRNFMbq5TvOYzwFbxOMsIOrBYAPSGnH2yBBfyS19NBrp6c6bKWiKuOv
stb0b/B2bdW7dULQdQlJclMXjf3e2tg8pVQxLDcSsHOwIF7wKJIcLb2jnwioGBOu
kV/LlqpILl7L57YM92VqZiAyGrYKRXsvwUUlgZGPWp12BXNZzEsB0uiiAapZbjYP
MN/45BRR/M2KnZ7qkMpF2GScFRGabphmxBsoZoPY90KMRvZVbmMBDBCEiHUB48NA
HbAuhKY2mB2vo1LT4qar+RClM+xknze8w70/lqyY34ssT3371vM=
=NE79
-----END PGP SIGNATURE-----

--Y0ZVHOLJiAVeFlZq--
