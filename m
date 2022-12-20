Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E04C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 14:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiLTOxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 09:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbiLTOwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 09:52:22 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF941CB3A
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 06:52:19 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 7B63F3200970
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 09:52:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 20 Dec 2022 09:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1671547939; x=1671634339; bh=M7MtAOQyCuZUw3L5kaml/n3882+j9+YHjlx
        WKeYRyIc=; b=NT9bn5r8A+nOYDWjBzwhUvWZBQVkAxq2SrJVTaO+XC1T7nX6TrW
        6Ik0aS89GPRUWmIn0cbixfHggtYMNvmoyCgnSiQmedYU67jqdYUqFb1NrgNmt4Xh
        Pm0vWk4hlArZJCfKboD9Y6TwJYJyAj30S2JgZjZMbtcR61SvSEGX4oAk0GLQRxMA
        6Ib+VTHLn6l2yjyEWn3R3tuYV+hmAiqwgCXK7s/skhzNLTsxNUCtCqacwqgpGzRT
        WAjCzlD4Sp4vnqZQWlafNes05I78wYr1zByvWuVXpmc8NtZI7qKWh0cYihHd5xbg
        Fu/zk1EI1P2wKAODgf+k3TSPN0zKglgXB+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671547939; x=
        1671634339; bh=M7MtAOQyCuZUw3L5kaml/n3882+j9+YHjlxWKeYRyIc=; b=s
        mgV49ax0CK4bSn79D5Bygmc8/Iq6Gok3eUoRasW2pBivXiM1MECOqoZ+gKot84yj
        dSGDsY6a26TbaTG+kVvt0F2wDNfdjwcNXwuEXJTo9+aPdanvDLBcDqqjzJ2RuIAY
        yUX+Hr0JgiiTXjYlRfvBlH6udZW0kTMobpIe0H/WRCIr6vxtdVwNPRBnU/vvUEb9
        /gN4cHDbUfsdYPIjEaVZZMyBoDzavazaR/O8deAcHUo1bDBXpmNoamo+jLuYXU6a
        z8sinmXsy4f/GgX/hZCK4N3ltSaSZnbrffaA9E+82sXbBOpIej9GvR9+q40VKlP8
        +1oJXApMLwouAEsJjkk2A==
X-ME-Sender: <xms:IsyhY0-lrwU9FXOrwL_IQ2st4Wvx6Ji0T0enQXdK0nemvOQDaaInZw>
    <xme:IsyhY8t4GGmG5oqN1B_jelIMtfKvmU0APSMzilzTlQwuY8RxHUEjI1L0IX6YXqV9a
    K5RPml1TGRjhogAug>
X-ME-Received: <xmr:IsyhY6AodhiYoe4SAy8uq-Xh44FXPH1gkD1pPp7uJq1NfaWkKTVILf5MgUiUDxg3lAdzWFS3uenKO4T7NijMpcpcimJA5Gtl0iaLLiZaOi_J>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfggtggusehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeejieefvdeuleffgfejudffvdeghfeigfejgfdvvd
    efudevffefveffhffgkeeiffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:IsyhY0d4MgukI0N7IQlIHXZPuAn1-ksyoBFb0bTJIlW3EPkYgDetNA>
    <xmx:IsyhY5PERMy5oOqIr1zWk30ytlCeh4oKn3nzaTQ3-KxG9YhEW4HJbQ>
    <xmx:IsyhY-lgTvSfkvW7bxGBISxa6FYrtF8T6XQcmLXNv-d8OIpDJRKo1w>
    <xmx:I8yhYwbaSLn_Pf-qaDrV7bcz6NBBJkq1XTyJ-OHHX_VoBlYhuBCJ6Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Dec 2022 09:52:18 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id afae5957 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Tue, 20 Dec 2022 14:52:04 +0000 (UTC)
Date:   Tue, 20 Dec 2022 15:52:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] refs: fix corruption by not correctly syncing packed-refs to
 disk
Message-ID: <8c8ecf8e3718cbca049ee7a283edd7b7887e464e.1671547905.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4zGrj3ZALZt/Tzuu"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4zGrj3ZALZt/Tzuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At GitLab we have recently received a report where a repository was left
with a corrupted `packed-refs` file after the node hard-crashed even
though `core.fsync=3Dreference` was set. This is something that in theory
should not happen if we correctly did the atomic-rename dance to:

    1. Write the data into a temporary file.

    2. Synchronize the temporary file to disk.

    3. Rename the temporary file into place.

So if we crash in the middle of writing the `packed-refs` file we should
only ever see either the old or the new state of the file.

And while we do the dance when writing the `packed-refs` file, there is
indeed one gotcha: we use a `FILE *` stream to write the temporary file,
but don't flush it before synchronizing it to disk. As a consequence any
data that is still buffered will not get synchronized and a crash of the
machine may cause corruption.

Fix this bug by flushing the file stream before we fsync.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index c1c71d183e..6f5a0709fb 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1263,7 +1263,8 @@ static int write_with_updates(struct packed_ref_store=
 *refs,
 		goto error;
 	}
=20
-	if (fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->temp=
file)) ||
+	if (fflush(out) ||
+	    fsync_component(FSYNC_COMPONENT_REFERENCE, get_tempfile_fd(refs->temp=
file)) ||
 	    close_tempfile_gently(refs->tempfile)) {
 		strbuf_addf(err, "error closing file %s: %s",
 			    get_tempfile_path(refs->tempfile),
--=20
2.39.0


--4zGrj3ZALZt/Tzuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmOhzB0ACgkQVbJhu7ck
PpSVow/+NdQz97M7/Z45Tp+k7sVZgHgbN5AOSFnD7hS6OBi4qHiTGgKuWX5778o9
nSaNPzyhAyrHuKkMu4avEjXJlbfPrRcKlUMO5zhpeT0xnrxccg6I28/NJNory8BD
sxN7z7OaH0sXQ233D/t+HaaXmulXY791m62LHxjFfcHnsQrU3kfU+FG3v0wqjI0M
PVgBxHoMA+bZlhagC9vBjQgT9Vn17I6GaJq1mZEQaOnyTTRo08OZocwGgut+C+3X
WE98lrBYhF0cY3YFM94nzrM54XcU33Awbyjt2zevqlYmLJ1aLouujx2NovFNeOgT
7G5QdGIaNc7TMT3e19hTMhILV2Rat2gpuFJ4r8ixqCA3fchIty8BBK//nPWciLfV
gFQ9g/lZkWSWq/QOSj99m/3s77+knZxaeC+0ds3SWdoNqCp7mvFFanul6yTNQPh0
hP3vFb5BCDxxq7SsGNnNPGe0rtb/lhwzaAY2EZfpBWUA/jzXQ4+8WQ9tBb9HO3KK
j8Kwk3F/j40++IOmNs5tI2/R11mUTFeNf40LRehDQALxLCoWsPNRJXz0jLvZA//g
utd0zCaME0Hsz5rTFK604IY1AEaaQoMRrjChEa6v9rXFJUlr81SQqk+nPuuVXjox
1uX4hxUPdMWxl/oeNxU1aW3nwXNGFPMXaG1wnxiK9qRIE4SPXEQ=
=rqX2
-----END PGP SIGNATURE-----

--4zGrj3ZALZt/Tzuu--
