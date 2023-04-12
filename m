Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BCC77B6E
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjDLKXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjDLKW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:22:57 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EC27DB2
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 85EB83200977;
        Wed, 12 Apr 2023 06:22:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 06:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294972; x=1681381372; bh=eq
        SV+lgEORpVzqcRPJ6Glj7EarT1imzXLG3qQ8h96M0=; b=Ug1IzJHGSnYrNB/QSW
        2OvgyS1Oqg4YIV2gmsPGt0jbXkcfQXzbGx8gpwZjUHmR4uXmRRKXUzPaCJpITtc5
        f46tPM99kQNgkdtyrbh+HkCQOM4b0STaBU6u49esZ5qmilT1zIx5aLcSv/TtBwSx
        5LVwixNq5Wk0BoKUqcVZKVOQxg43h5N8POHXi3n9mgE2L8Nysua2Rwau4XOLhNVm
        EAgnX7CZnR2O9jkGVwfUEmEEKLh5oQJkvxaop5Nrty0aviJNQjy81p97NCxkcOgX
        cmjddrzQ2QFZefkwH8MWab3LrYd/NLFC0SNnW6T+Fpf7/4Kk3BoXC9ALRO4Dr3rf
        uTzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294972; x=1681381372; bh=eqSV+lgEORpVz
        qcRPJ6Glj7EarT1imzXLG3qQ8h96M0=; b=FywyGKlr14zwlOdMqumoYyX3EAxwz
        CRPsU8Kqu0SutASOPh5k7gN6969LgJ6bb4CTqz9haU3Oh0s9Wmeskf1mTvyH12CC
        +BoJ/sDLhZ8PY5kPemyKyk8sRrQKdkAcOv6tUXfG/fsxWA0Df6pxBrZsL3zAO5qi
        42CRrm2f9uhR85pfTTOWr2nd80h5dHVH3yFe3ArHF8UOvBSPzNavWE01kRt50mm9
        j1/eQcAvHU7E1mMeDAByZEeVMiTYEhmNa7llr2pDnl9/F6vRSqmMuU5UxguuFmlO
        tV26xkVO3iOx/QaXjaa/P+1fGhtaGfmphM/4gUdEWMcTtl6vVRXpKpODA==
X-ME-Sender: <xms:fIY2ZK3rib_-OLe8uZZYxzFmv2rpq4mRHIu2gLVIJgV6yOTB_M2r5w>
    <xme:fIY2ZNHi6Ahs7zsSh5gZ-ODI9QV1FMx8Irn2O_XpG_RU96-OMMdROqWzcUcyP7OdU
    iNK14T8x0m0U_VC8w>
X-ME-Received: <xmr:fIY2ZC6x_FTcJ1Zea42xP_-Hbt_T18ntsFxD2Pf2rWgJht_tnsS65gkzoaJbWHcITAzT3k6B0xzG9Z8KKsJiR74BwDVSaj2psgQa1VWhaQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:fIY2ZL0wErYv0T-HfrqMnx7rcUhHH-kLLYN-DeyhzBNGgNyyZZuz6w>
    <xmx:fIY2ZNFSCO7BxmAIWdlAngdfLindsWsSa5HP3FV3BR4uSgTjk2LwlQ>
    <xmx:fIY2ZE-lhettFMVnptQ9c55hoQFtbscpe5o03NFWLqEZbn6MJLfuvQ>
    <xmx:fIY2ZCSJgl4qj3oylxdy9U4FZV-ccJFfpC6hy-shPRJHmE9OrjhUnA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:50 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id bb389869 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:29 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 5/8] pack-objects: fix error when same packfile is
 included and excluded
Message-ID: <9b278a4c91a5631d1b7b11bf56ab560c6bb58645.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeFdLA9FevTqsczt"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--EeFdLA9FevTqsczt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing the same packfile both as included and excluded via the
`--stdin-packs` option, then we will return an error because the
excluded packfile cannot be found. This is because we will only set the
`util` pointer for the included packfile list if it was found, so that
we later die when we notice that it's in fact not set for the excluded
packfile list.

Fix this bug by always setting the `util` pointer for both the included
and excluded list entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  8 +++-----
 t/t5331-pack-objects-stdin.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fdf3f440be..522eb4dd31 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3366,11 +3366,9 @@ static void read_packs_list_from_stdin(void)
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *pack_name =3D pack_basename(p);
=20
-		item =3D string_list_lookup(&include_packs, pack_name);
-		if (!item)
-			item =3D string_list_lookup(&exclude_packs, pack_name);
-
-		if (item)
+		if ((item =3D string_list_lookup(&include_packs, pack_name)))
+			item->util =3D p;
+		if ((item =3D string_list_lookup(&exclude_packs, pack_name)))
 			item->util =3D p;
 	}
=20
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index ab34cfc729..f389a78b38 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+packed_objects() {
+	git show-index <"$1" >tmp-object-list &&
+	cut -d' ' -f2 tmp-object-list &&
+	rm tmp-object-list
+ }
+
 test_expect_success 'pack-objects --stdin with duplicate packfile' '
 	test_when_finished "rm -fr repo" &&
=20
@@ -26,4 +32,24 @@ test_expect_success 'pack-objects --stdin with duplicate=
 packfile' '
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with same packfile excluded and =
included' '
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
+			printf "^%s\n" "$(basename .git/objects/pack/pack-*.pack)"
+		) >packfiles &&
+
+		git pack-objects --stdin-packs generated-pack <packfiles &&
+		packed_objects generated-pack-*.idx >packed-objects &&
+		test_must_be_empty packed-objects
+	)
+'
+
 test_done
--=20
2.40.0


--EeFdLA9FevTqsczt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hncACgkQVbJhu7ck
PpTNqg/9HV+Qr1gg2vCgglMiXd/RCBUKVhJ7pam2/tZ/dqsahNg8gLuCcpZJruOQ
bpdxgU+cyTFh+96ZwQWUtdrBKOpkgx2DnRwlHN9kC98IPbwZPfUt3oj4SSVtXAR2
21dbtu6vUafX1GrhvoRNsZ5DRRUUUG4jlYwHjf39FXzdWijUsDQ16rsDEHvY0FsB
/RsK2gnGy2URx8baVSMpMo2D6rMeHu8ARzSQo3aq7RIDwWPif5rrRi+dzfPHMkK9
DliCyklSiDICZl/PDntoX2zjrdFqFiUf4fHSNRjYxSqgNsr08zEY65LeXrpK4yN9
r8SE9jJOYCzTfLTCS+Ce6b1yMe9+h1R8ot+Zj1fZHhpL6oW7lmu+QoXg2Q0Q9k63
wsBb4kBc4J6LjOlUfSYNxoTkkCRjr/UkfAHXU1faoH0bQT+Kxs2uAIbBp94zUgCK
9LWmNOgZoPA492E0rFmapY34pIAKlOqE4deNPESpvzIt+4vXX4FnQw8eTdLAywL0
EwW1InE7ydwu4fJImqsuwav8EZGevBV7w35Nl/qO/IKx66xj7ip53utgcl4fY3+A
EtXZqRJrDURqnJbyFEXjj0MCcmi8y45/jH0g9Oi4kwiFwuRcxtj1lhhwtAaJh21X
50/u1/JX25/Iau6Snt/SNm+QeZVDDZ3BC/5Vd1vvyVLEESK1JxE=
=jIFu
-----END PGP SIGNATURE-----

--EeFdLA9FevTqsczt--
