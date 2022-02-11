Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3566C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 07:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347789AbiBKHqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 02:46:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiBKHqt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 02:46:49 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FAE2D4
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 23:46:48 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 79E483200AC9
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Feb 2022 02:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; bh=T
        veHNyXcAr9Il534VmfpwwUcorfIAlP1UBvocuWI9WU=; b=g2Du0GzSin/dYbR1K
        8MaV7lhl47wTOAVnFKlvWHl58oiT4UOfPEFpitak1yBbJvu0XocvXBnhIVLKlZqg
        mRkBlXUESC3n0uzBE4nIh1SFLyzcm1y1vMUhL/fJsTDWrnbvg5FmfgDQEMcCFf6L
        juD46pcS/Oh9QfnVB+SzNvtO7xBe6H5DYueQHvuMaARi4NahAzXQM3xiBYFfc81i
        EjjWNbvNlz08nMcFwetS4fPaLHtN7Vv+gLbUawug6oT6yulqR18duP5wr8yS7szS
        SoqT2lrP9U1vW8nhefaMCr2yrG51uMUs3+YJJY/rKqiDBzSEgKqwKTpNLl/N5FMW
        2u6EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=TveHNyXcAr9Il534VmfpwwUcorfIAlP1UBvocuWI9
        WU=; b=Gn7slzPMCdyaVi7icsDPCO0inZaVQ30XaV+eaYEYhnuRcxkqOpVuVkiSr
        z/p31mTEqLBqyY8KGa83N/giGhcLUrvh1wUA2LNenFR/ZPiAZ9/bya2f3MpYQ8Zo
        rg2eizFtbUVyMxI08haycMjEKsobLHKhzB8cIAiuckrW354kwGhwwBU9eJgNTXYs
        wznHMM+AGrRTVjm+qKSfNyFbjYlDmMsoD/q3reue3+uMV/VY+OVVFku2pwoqcMDk
        LCDejYdCwHYsWfsex3FG3PbihNo/bcYrsFrlM39paG0F1XEzXr7FEJFPKGTLAMvp
        vVNVjHUA93Y7dg61qutwUEWXjyAsA==
X-ME-Sender: <xms:ZRQGYsXwTdrS98oMQ9sVywXS0dBvXvDCNnK_-14wPiuILijZr5qfdg>
    <xme:ZRQGYgmeEg3oW3Gl3VfyW5UW9Ot03BSR3l6cnMvOtMXMCK9yWFRgH7vOGR97_bbZu
    lJloaA7pf_gHQN7mw>
X-ME-Received: <xmr:ZRQGYga4lcBThD1IfN60LdIrR0SK076VG4Kx4I3KUChf900lqJxJaepWlvTMd-GiAYc2IggRkKbQbR5S71w24fo0I2457voDj-s7mAa083hTMta4ozwf2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddriedvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ZRQGYrUqgKEuZZCDXmZAI4k4SczR0pK1Y1H0XbO9nDaqqq0uSHhxAg>
    <xmx:ZRQGYmmREHuaHxOTHZ-oiXaISpVEz3vENrNpdhx_jCkk_P00EW_mMw>
    <xmx:ZRQGYgfcZOQSPDGrAlOkAeoJeq78EtGnzadVRgVZ_Ds4vYIw96Q65Q>
    <xmx:ZhQGYgQpnx0wb4UgV-4KjonD6dqYnWoXeuYDqqT42_-kqFAlmENShA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Feb 2022 02:46:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f4ff24ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 11 Feb 2022 07:46:40 +0000 (UTC)
Date:   Fri, 11 Feb 2022 08:46:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/6] fetch: improve atomicity of `--atomic` flag
Message-ID: <cover.1644565025.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TGdtEoOnMVg4Mq/b"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TGdtEoOnMVg4Mq/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in c7b190dabd (fetch: implement support for atomic reference updates,
2021-01-12), I have added a new `--atomic` flag to git-fetch(1) which is
supposed to make it an all-or-nothing operation: either all refs are
updated, or none is. I have recently discovered though that there were
two oversights: neither pruning of refs via `--prune` nor the tag
backfill mechanism are currently covered by this flag, which breaks the
promise.

This patch series extends coverage of the `--atomic` flag to fix my
oversights. It applies on top of ps/avoid-unnecessary-hook-invocation-with-=
packed-refs
merged to v2.35.1 due to a semantic conflict in tests: I use the reftx
hook to verify some things work as expected, and above branch causes us
to not execute the hook for packed-refs anymore.

It is structured as follows:

    - Patch 1 adds multiple tests which demonstrate issues with
      backfilling and the lacking atomicity.

    - Patch 2 and 3 do some preliminary refactorings which set the stage
      for improved atomicity.

    - Patch 4 fixes a bug with backfilling tags: we don't return an
      error code to the user if the backfill fails.

    - Patch 5 and 6 then finally extend the atomicity guarantees.

I'm not yet all that happy with patch 5: it currently has to reach into
the `ref_transaction` struct to be able to filter out any updates which
have already been queued such that we don't accidentally queue the same
tag update twice. I first wanted to get some feedback on this patch
series though, and in case it is agreed that it fixes a real issue I may
introduce a new non-internal API which allows iterating over queued
updates.

Patrick

Patrick Steinhardt (6):
  fetch: increase test coverage of fetches
  fetch: backfill tags before setting upstream
  fetch: control lifecycle of FETCH_HEAD in a single place
  fetch: report errors when backfilling tags fails
  fetch: make `--atomic` flag cover backfilling of tags
  fetch: make `--atomic` flag cover pruning of refs

 builtin/fetch.c      | 190 +++++++++++++++++++++++++++++--------------
 t/t5503-tagfollow.sh |  78 ++++++++++++++++++
 t/t5510-fetch.sh     |  31 +++++++
 3 files changed, 236 insertions(+), 63 deletions(-)

--=20
2.35.1


--TGdtEoOnMVg4Mq/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIGFF4ACgkQVbJhu7ck
PpRyIQ/+I8AkMx8ZljKBvq30lwRhr5iOoK89YwJ3isFdB8bG0zD5PLTE0im2M8zR
tLrWpxrWHBpwp0C8w4hKCFoYyl973zRyNPgEqTvrWP6k+vwgu+8fzRfwQoKwPw9T
ckE7XDHdaJ2z8CsYuMTrngfiZES1GXuEfA5jQV9wrGPmfgBZ3w1vO4yRSPciOTD5
VEDqK4K0+LqiLbi42ThkJ6rNJnzBF8ZFnxWZYoYzH7F0gSjwuaxiBBGQV544htwt
lM63IJiEw6TizSHGfPYEFVyQJ8OP7dM07BD+qSZgP8A8dWrc/axnk1n+KTLAADPX
7t4ZyOe5st0SJcAEpgfciMrneUDyNsPAm1LUE3/C5SDadMV612Ls9wYqDl06Tax3
fk6s3kKRw2cGa5l+1I9dkZASq3l49eUMHlzN6maZ9coWgT5vBqzkCSaF8O3J9eaB
bsOErGAFbKzQjKlku65xeoLZtVkDRCeINI0eFRjDswp9G0AwRSQmaBftP4G3SCU9
rdKD79Lcamrp/BmTgCXpmwt0PZR6SzzS9zsjKLilvfniQq5JQBq1NfmQI9fYVnG6
k3RPdUubUUw9r2X8YBUHSO2U1HqLDJxf6o4pLGQvv6a9k0FZ4vRxsBrEveVRG0/H
q7zBpgo4lePQ6QBDtpfW2SwJa4BIMwDHsezuCJGMgO51gN9gPnU=
=26Rx
-----END PGP SIGNATURE-----

--TGdtEoOnMVg4Mq/b--
