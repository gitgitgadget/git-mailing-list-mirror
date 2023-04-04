Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA33C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 11:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjDDLJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 07:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjDDLJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 07:09:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B31E1BEF
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 04:08:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CA9645C00D9;
        Tue,  4 Apr 2023 07:08:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 07:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1680606519; x=1680692919; bh=eTwHuLll08TLm8bzePPgxN0iJ
        OZKsoG93hffChpclew=; b=iHN55Ce8m2bOGyQxje6lAjTsGxNSvT8zvs4bl8yuY
        DvwrYWRqMZvbU7R/3S7ThPE53G4xlgyL0lPshlZZFxtEK7VaUQ/ELugDIZxtMEld
        WsJXesqmrpF7d4eSYl/Rnbb+G+tjzFDkosu+aLkgECg8XaJtJNTHbfFCZT0wy6+v
        L6FKCDSy5ZkqbYQz189UZjau73PII55dYDV/VW7zXm68sRUHP8UOOSlJCzKNl8He
        nd9b0QkKmE3w4t5f72sK3mxGLraQsYm4SWCcr8i/829d2OAdBVGH5AgvpFHWB2NG
        qA+n9QWCD1aLq1iNZfrLyFXrPXpr7LmqZcF4dJqbFDO0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680606519; x=1680692919; bh=eTwHuLll08TLm8bzePPgxN0iJOZKsoG93hf
        fChpclew=; b=NHD4ALrEtPEDiiXQsfQaIsXqE8l9Mtmaf/XxJRdYwEK7J243dFW
        a+Hn07VWBBj/et8q6GjZnXTtEN8rIuS4rIiyv1WgY60lAZdFcEc6PrsOMhkFG+uO
        vahcI15Q4Z3mBXMgY7pDPQyDTclRdC5F4uFBsfccahpq7u8oz0tANtbMT2t0/R2E
        YZTy8NVRelhD7A+kN7aow/MagJ0HJyOaswvWpKzGvDEVcacimZ4RprzCjtFTseQg
        3vXb9xN8ZHq37xjFR2WihH7Ixn/9pXEekOd905eSW7AlAGM6m0a8NtmVcXvAfU+S
        p0tRIAt6tZGHcHLcgai0yo/UlfG3n3NReDg==
X-ME-Sender: <xms:NwUsZNP65cJiqtTdK-iwPhNjDwn8RkilNi69CZst7eHmZFE0TmEfgQ>
    <xme:NwUsZP95vxd22rnRVn8AezT-K0muEsATAMcvw_NC15DWXpo8J8kPXPweVnqlVlpq8
    avFrxumQpaUzFym8w>
X-ME-Received: <xmr:NwUsZMRjlrRsmdblDtlU6yBqlbY8SCUtldl0VEMJ-XWLmhR5KRCGLjkIL9QlRLig_XiTu-pE0VaeFG_HQYW3klEGQpAYOy3K4Jz9P0Ss1krGTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NwUsZJv-PTc2vFBU2hD_J89FaptDAT25ahlSdALGXsGwzZaMhqDj4w>
    <xmx:NwUsZFduTJVynMP5V5aB17x8Mp3kN3jYomdmAbzLeS5D6STqWUdHZg>
    <xmx:NwUsZF3Bx-d8nCLZlrN2BgB8ylfFwo8e8rubpe1kjzxyMzoRRDMRew>
    <xmx:NwUsZGpPwG-c-AxzdU-_NFFYmoAFRgqwItMLkFI9MZ7m8txCcKAmuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 07:08:38 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 30d053bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 4 Apr 2023 11:08:30 +0000 (UTC)
Date:   Tue, 4 Apr 2023 13:08:33 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NavH8/O+B90AdEeG"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NavH8/O+B90AdEeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Performing geometric repacking with repositories that have alternate
object directories set up is causing errors in different scenarios.

- Repacking fails when the repository linked to the object
  directory does not have any objects on its own.

  ```
  $ git init shared
  $ git -C shared commit --allow-empty --message something
  $ git clone --shared shared member
  $ git -C member repack --geometric=3D2 --write-midx
  Nothing new to pack.
  warning: unknown preferred pack: 'pack-3e1a94a8dc9bb4defb0d98ce2ebf325312=
d76362.pack'
  error: multi-pack-index died of signal 7
  ```

- Repacking fails when the repository linked to the object
  directory has the exact same packfile as the linked-to object
  directory.

  ```
  $ git init shared
  $ git -C shared commit --allow-empty --message something
  $ git -C shared repack -Ad
  $ cp -r shared member
  $ realpath shared/.git/objects >member/.git/objects/info/alternates
  $ git -C member repack --geometric 2 --write-midx
  fatal: could not find pack 'pack-d404037a861afe456e07a1aefb3655150f1299f0=
=2Epack'
  ```

Both issues have the same underlying root cause, which is that geometric
repacks don't honor whether packfiles are local or not. As a result,
they will try to include packs part of the alternate object directory
and then at a later point fail to locate them as they do not exist in
the object directory of the repository we're about to repack.

Skip over packfiles that aren't local. This will cause geometric repacks
to never include packfiles of its alternates.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            |  6 ++++
 t/t7703-repack-geometric.sh | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 87f73c8923..c6d12fa4bd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -333,6 +333,12 @@ static void init_pack_geometry(struct pack_geometry **=
geometry_p,
 	geometry =3D *geometry_p;
=20
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
+		/*
+		 * We don't want to repack packfiles which are not part of the
+		 * primary object database.
+		 */
+		if (!p->pack_local)
+			continue;
 		if (!pack_kept_objects) {
 			/*
 			 * Any pack that has its pack_keep bit set will appear
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 8821fbd2dd..9f8bc663e4 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -281,4 +281,63 @@ test_expect_success '--geometric with pack.packSizeLim=
it' '
 	)
 '
=20
+packed_objects() {
+	git verify-pack -v "$@" >tmp-object-list &&
+	sed -n -e "s/^\([0-9a-f][0-9a-f]*\).*\(commit\|tree\|blob\|tag\).*/\1/p" =
<tmp-object-list &&
+	rm -f tmp-object-list
+}
+
+test_expect_success '--geometric with no local objects creates no pack' '
+	git init shared &&
+	test_when_finished "rm -fr shared" &&
+	test_commit -C shared "shared" &&
+	git -C shared repack -Ad &&
+
+	# Set up the member repository so that it does not have
+	# any objects on its own.
+	git clone --shared shared member &&
+	test_when_finished "rm -fr member" &&
+
+	git -C member repack --geometric 2 --write-midx &&
+	find member/.git/objects/pack -type f >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success '--geometric does not include shared packfiles' '
+	git init shared &&
+	test_when_finished "rm -fr shared" &&
+	test_commit -C shared "shared" &&
+	git -C shared repack -Ad &&
+
+	git clone --shared shared member &&
+	test_when_finished "rm -fr member" &&
+	git -C member commit --allow-empty --message "not-shared" &&
+	git -C member repack --geometric 2 --write-midx &&
+
+	# We expect the created packfile to only contain the new commit.
+	packed_objects member/.git/objects/pack/pack-*.idx >actual &&
+	git -C member rev-parse HEAD >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--geometric with same packfile in shared repository' '
+	git init shared &&
+	test_when_finished "rm -fr shared" &&
+	test_commit -C shared "shared" &&
+	git -C shared repack -Ad &&
+
+	# Prepare the member repository so that it got the exact same packfile
+	# as the shared repository and set up gitalternates.
+	cp -r shared member &&
+	test_when_finished "rm -fr member" &&
+	test-tool path-utils real_path shared/.git/objects >member/.git/objects/i=
nfo/alternates &&
+	find shared/.git/objects -type f >expect &&
+
+	# After repacking, contents of the member repository should not have
+	# changed.
+	git -C member repack --geometric 2 --write-midx 2>error &&
+	find shared/.git/objects -type f >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.40.0


--NavH8/O+B90AdEeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQsBTAACgkQVbJhu7ck
PpQ9AA/9FOqauifpLJv7dqbhr92m3EAjAdwwHAvrk/JWy0zm3AkqqxAIbdyrX/BQ
zEXmUwIGm7dqe/fCpbofHQ1nAzdyKVOgTKuyf7L7AXTmsLkeKC3Wf7ixBq22zjKp
c115H8G3LiCMTHXemvesHi2g3NK3H88mBAXwKezWnYXnL2YgYJ4Rtgx1bpnmvjtu
knFkNUR6N8B1Kn/CGiGF2zYILrH/adJYgLsmyu4zpnZERltQwTxiVmxBlbdaI39E
xnZZkJn94fmjq6GuDIDnM2ezd64ED50L/q1LSbLLtckXIKt7S5xfRJ02zEN3G9wr
1cPe+tGnbZ59bzHTbsXsNk4vfX2zwj++SIqvMRETItR+xtWRV9gjyPnmgsgPabZQ
QCu6YmuQ3Mf5LahB/wc90Mz8J4P6UrICe3EfSGsv2+aLea1srspyIQ2dAQYIcbXd
gbYBi6J+pj0LwNQXtgC/GV7bFFaLIEMkFZ2sq7Iu2WNrVyrtlIQiKhzZwfzzwpmW
McbVpaJS0ymYmzn43QQPMBp0L9XvJpDqxGAlKQZoUCN/EsTKM0tbaLeC2PT2tP9c
Vrxxyo360hCf/RLYL4asku+66HhokJc+ZnNnKJAOIqsfO1jpa2yvly23LKrG5HqT
zX/OVpz0dKrYmG45sd7kaCYhu1Km59KVXMkR2p6MLgwDVwVB9KI=
=smMq
-----END PGP SIGNATURE-----

--NavH8/O+B90AdEeG--
