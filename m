Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D835C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 10:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjBPKaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjBPKaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 05:30:16 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD4521F7
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 02:29:58 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A635E5C023F
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 05:29:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 16 Feb 2023 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1676543396; x=1676629796; bh=W2fc7Kl87R187HOWz9kCdbeZbQFLYjRG2jw
        Pg435crM=; b=VweVTBNQCJK1NNNft8FW5U0Zb4Fzo/LAhfXtsVYwTjx2+xK013v
        6KP6VP110wcRqVPmgKfFy3Y82ATKA+BdZ2ilOnMSDgVmMSptR+FzxKNDuyxaae40
        2fTv8cVQ/AxithoNaS9KMZoxaVKch7WAG/DCLhQbsReH5MuFYHTN4kCSrmG0rvAz
        KAOTnyssEr+k554DKUJM+aLOuUHgVZop+8W5ADsMv/iCJ7C6vHfHAXBNL9Ch3nSj
        FTwNTEolKjyO+Rz+BGSGi8tA90L60p/zRk9pj/MIBHzd3MU4lU/4ZnBQMCyBGj3A
        YgvUvWRdlW7uhYBPPeozrCLWhlIHox/c/Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676543396; x=
        1676629796; bh=W2fc7Kl87R187HOWz9kCdbeZbQFLYjRG2jwPg435crM=; b=T
        xrkMXQibCnGzllR4CXSz9kPYrkKLNXJ+B9YVFY0gN47dhCiMOAP9ZzP0zpDVIDsb
        e7JPmRDIVRd0f19E5vJHI0gxl80tieimwOIN6aVSZpjoV8ecKBCuCQ7VzWA+4wkM
        /pdmvnkbvPO49eeTElztjaD48Te1LMTfg6FyoIUnoYBqjtiIoYRW0IXcAhOVhW0C
        y7Xr0ngNPDVmGXlXrnCTEPcUczCgfC/6KE5rX3J1p9UgRE1O0ZbeIj/WkVzZD9E0
        XDEMO0Pl97Tk+ywwdoSVsuVVzUFX3bN4sOoS3UjB99GHpn+PbY9/3EtbKZSWE2kk
        j7YXxjJxRnwTO5k1gKxsQ==
X-ME-Sender: <xms:pAXuY_HSmtw4_j7664IlMMturKy-owc1uWFuYQ-eLnLr7Pn9Elb1UQ>
    <xme:pAXuY8VyksMFL_z_nZL0hRNlHICsgZnOj63OeNSjbBMXWhMmDJ3TRO4DYlOAdfyyA
    PtZojb1sbAkzF4YqA>
X-ME-Received: <xmr:pAXuYxI0dHOkwAenI3Msx9L1HzGkn4EKuhCqg7v5aPE1UukoW_b8ZouaD1jY6uk02U6uoiW-DgeuFzalbWAWHsLzWraBhbqQupBLy5n508nS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeijedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pAXuY9HDvXD_DicH3ifrRqTZ8iE38r-iCd7PkL0qULf1l6Cmpgjnmw>
    <xmx:pAXuY1XqqX172lADN5Hl5aChdRYG5CJNrPrsTqFZxu6SilnGp89TYw>
    <xmx:pAXuY4PAI2czkYGjhdJO3jEGoqTCitJDHgIzWCBtYgXjoO1nVZoNpA>
    <xmx:pAXuY0BZZoyH_d6LuL1ve2lxeHq3Tp7zsSS7jqb-UkLYnetInsP4Fg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Feb 2023 05:29:55 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f881798b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 16 Feb 2023 10:29:32 +0000 (UTC)
Date:   Thu, 16 Feb 2023 11:29:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] delta-islands: fix segfault when freeing island marks
Message-ID: <61e490595b80b34c55fd640e093e021ff6fa9591.1676542973.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRdN/+pAeCWLrKYS"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wRdN/+pAeCWLrKYS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 647982bb71 (delta-islands: free island_marks and bitmaps, 2023-02-03)
we have introduced logic to free `island_marks` in order to reduce heap
memory usage in git-pack-objects(1). This commit is causing segfaults in
the case where this Git command does not load delta islands at all, e.g.
when reading object IDs from standard input. One such crash can be hit
when using repacking multi-pack-indices with delta islands enabled.

The root cause of this bug is that we unconditionally dereference the
`island_marks` variable even in the case where it is a `NULL` pointer,
which is fixed by making it conditional. Note that we still leave the
logic in place to set the pointer to `-1` to detect use-after-free bugs
even when there are no loaded island marks at all.
---

An easy way to reproduce the segfault is:

    $ git pack-objects .git/objects/pack/pack --delta-islands </dev/null

I didn't add a test for git-pack-objects(1) directly though, mostly
because I didn't find any location to put it. I'm happy to do so though
in case we want that.

 delta-islands.c             | 12 +++++++-----
 t/t5319-multi-pack-index.sh | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/delta-islands.c b/delta-islands.c
index 8b234cb85b..afdec0a878 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -517,11 +517,13 @@ void free_island_marks(void)
 {
 	struct island_bitmap *bitmap;
=20
-	kh_foreach_value(island_marks, bitmap, {
-		if (!--bitmap->refcount)
-			free(bitmap);
-	});
-	kh_destroy_oid_map(island_marks);
+	if (island_marks) {
+		kh_foreach_value(island_marks, bitmap, {
+			if (!--bitmap->refcount)
+				free(bitmap);
+		});
+		kh_destroy_oid_map(island_marks);
+	}
=20
 	/* detect use-after-free with a an address which is never valid: */
 	island_marks =3D (void *)-1;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index b5f9b10922..499d5d4c78 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1015,4 +1015,20 @@ test_expect_success 'complains when run outside of a=
 repository' '
 	grep "not a git repository" err
 '
=20
+test_expect_success 'repack with delta islands' '
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit first &&
+		git repack &&
+		test_commit second &&
+		git repack &&
+
+		git multi-pack-index write &&
+		git -c repack.useDeltaIslands=3Dtrue multi-pack-index repack
+	)
+'
+
 test_done
--=20
2.39.2


--wRdN/+pAeCWLrKYS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmPuBZsACgkQVbJhu7ck
PpSq3g//agFpsB68ayzh7KqFbwwz7ycsriy7f/jEHR4PIYuGzrGef3DKfXNyr0ue
ssHaWyXj6/7buF6uwTVq2gr878pTFvKNRLuoOZXHk0mEqTcQ14hEpxc8ursCHJ28
+qx54i7HkC405nqSytyOtSF4JaBrkNeOlXs8gd8F/UbWOhtrnh+fbqTDxMJMI/f9
uwIdsYIbL7BXSInSEnLyO+4RR8+gcteoTcMB0FhlN4hE7DTekcYGDbqH0Aq9PG+j
3cUGu4fzk4rS9BZ/crGAtBK8PR0WOyWF0KE+QSiBUzmFwKQrNTRR8cmbYUjQy1qO
GDu92h8YFoqxPYmb7dmaDKbpkwtlqL9iRFWpMW9eCtOQboz16iOI1JZrXqlOHdEg
zGKEQ235wVwJoUdWi/bMYJuIhIAYZOMxg1NhsFz1ZLN+OMcQae8WR3SnOLvuueEM
cay/jec+PphqMkz7PoxZ6ftQuG8rmAkes4nlfTLk6a/CszQFvp5pc7PZXB1fEZtb
kw2nMe7O60jHmxxFRJ4nkUPkGleZyNtvIO+3iqI5b4JRludxU9jdkJpJyjDkBxsw
3x8L18TNVfmJKBiLwSfm0PjsoTQJoKRwLz3rD/dF3AsbSa+wYaKbwP34qU97/yOR
th+XfUSJYwruQCHY3kznxOxyyyuZMCPuPeH2YDWbRrTAi3cGZJ0=
=grqm
-----END PGP SIGNATURE-----

--wRdN/+pAeCWLrKYS--
