Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB1C77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjEQLst (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEQLss (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:48:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9779CE67
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:48:46 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9003532008FE
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:48:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 May 2023 07:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1684324123; x=1684410523; bh=5nGH/Lqnt1hqzbrd+xsTdOT9h
        bjAh6XlSjwPsGJ4flI=; b=OI5yfdBqcGwtGTwI1qXp+huKDN+NFQMrsIp5yRZiy
        gGFE5dEs0tAvt/5twNJ3RLOvuF/tB24xmoAKoBIemxKzD9yks7BIzCW07f6Yu6s8
        6cjGPAVkkCg7sEJM8EK8d39JcL4Q2dRpXY8VGlR+56teALvKQHUv/i/ow4hRAeZW
        7NvP1CEe0b/Cd/gIfWNTkR51CxupMFHD+xDXp7ez9ctcZSzMLW4Pjp4RyagIS3lE
        o/m96oPBUP7tfZjahF2QWUhDVnniau1V0VeM4rGh0B24njELQmFD4MG63hxGPXLB
        k70MIsmmK3HU8uH6uJuqU663bzTFZfIIyyociY9VxwA5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684324123; x=1684410523; bh=5nGH/Lqnt1hqzbrd+xsTdOT9hbjAh6XlSjw
        PsGJ4flI=; b=B0d1UjYZYHpzO1dgNqhxWk0sMIBYiprzpGprPs0JWO+bUg2NJm5
        JANea7llq1d1FfEP4gWLg4CMnuvlgJecO3D6iFENKURbw19EmWLvkyoQFIoJNLch
        4Uf8HnjBkUWrtK1qRA2y02XHlx91jqb66hAdLoZiZwR3Fo4+gMSrwbh1xVTv5J6j
        D7Mx5QIh7lsRlsV3JwU1YrPbI9lObUypnpb1to15cIeT+SYGGwDxbiEkPZerfEIZ
        Hht/nhtGzTdVz8rj8Ct5fJEbOkhfL2n1yZIEixYxMOHNEoruUNteZNTj1FG3+Wjx
        Wm47ctybOnRbefURFdlFAW8RZQyclKyEo6w==
X-ME-Sender: <xms:Gr9kZMbB5mJ1WbxTQKrP544G0nI2SxCnxNgeinCXUd_gnwAPyuH1ow>
    <xme:Gr9kZHaB1gy89bNEAJTwWzfsP-o44Gfqb-upAHaOAKC5ctv1YII0863JYGBP3p9I1
    F1sWGL9_UICkF6IsQ>
X-ME-Received: <xmr:Gr9kZG97zdOnJs69O7wDt34aWoSvLwkCiaNM32xeWihTQpT6hINjnOk5zjoacCtvD54yFGItR17kQVYBpBdIpzImA-wrg_E1awrPBzg-H-GEKEmq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Gr9kZGq0mhy9Uwc_TMOZK5m-bjVN7gPpaMGPn75QJNgDGYfz9CE_ZQ>
    <xmx:Gr9kZHrR8aWfm2hXNqLqQaiyz1MdvLXuDIhOLIXUv0zY9r6iEyoviQ>
    <xmx:Gr9kZERpiFMkq5le-urjv5noIpLGhs96ZWkd_g5DqcWVmpv0waRd5g>
    <xmx:G79kZBEt4VGwLcGqmWcqXq53T6Irz5cSHnnBezkiR-OnLB0CIX5imQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:48:42 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 209605b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:17 +0000 (UTC)
Date:   Wed, 17 May 2023 13:48:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 0/9] fetch: smallish cleanups
Message-ID: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XwCk7SVTR8p1dvRd"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--XwCk7SVTR8p1dvRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the dust around machine-parsable fetches has settled a bit, so as
promised this patch series contains a smallish set of cleanups for
git-fetch(1).

- Patch 1/9 drops the unused `DISPLAY_FORMAT_UNKNOWN` enum.

- Patch 2/9 drops a useless `NULL` check as pointed out by Peff.

- The remaining patches convert `git_fetch_config()` to not use global
  state anymore, but instead to parse all config values into the newly
  introduced `fetch_config` structure.

The patches depend on 15ba44f1b4 (Merge branch 'ps/fetch-output-format',
2023-05-15). As this is the last merge before v2.41.0-rc0 I've decided
to thus base this series on top of that tag.

Patrick

Patrick Steinhardt (9):
  fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
  fetch: drop unneeded NULL-check for `remote_ref`
  fetch: pass through `fetch_config` directly
  fetch: use `fetch_config` to store "fetch.prune" value
  fetch: use `fetch_config` to store "fetch.pruneTags" value
  fetch: use `fetch_config` to store "fetch.showForcedUpdates" value
  fetch: use `fetch_config` to store "fetch.recurseSubmodules" value
  fetch: use `fetch_config` to store "fetch.parallel" value
  fetch: use `fetch_config` to store "submodule.fetchJobs" value

 builtin/fetch.c | 147 ++++++++++++++++++++++++++----------------------
 1 file changed, 79 insertions(+), 68 deletions(-)

--=20
2.40.1


--XwCk7SVTR8p1dvRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvxUACgkQVbJhu7ck
PpQaRg//Ux3iQXsm0w613CWgljonEA1PSQfU91Abqiz6e6HuZ/f8fhm7z9H2BV5s
mz1/toZalE7HJrLRk6aD4uLUVuxbIr2Cl3DXlEshhcXVR4kg7+u2tDcsDYqWHohq
WpqEyBRwiuL+bRpLvXq9EGl+Fi9ARe9VmMGSWC5jLdqt+49PYijKghA5ogSLlAn5
lp3/zJGz0OaFm3WvLI9cnleX7f4eYcF4O6auo9+8A/nWioW7aGaCOPJsld5bh+eY
21+FONvbf7U80+KB1t/Ahylzy3F/YUEhUG3Dw5A6Htc6rK6tsrnhZS1hH4JfyLVk
7keG0CWU8aPNNXW5+p3UmFZIm91hpu7hINXPae/dlXimq80d8mX+0ZDcXZXFiAEs
xndMvSqGejvi2ic6VWFczqvQaKmNw+mLb9ZTO30K8hSLn2V/wjp7/iiTj6P2F4CG
5hNTpqmGVzZPPkafdRIzgicISoDvNDTpmsbzuy14y/MnRGLRlIVpCB5q/iw7hJi/
bjLnTif0spOvO9gvSxJsj0Eclg5FsH9O15g6hlhI+MnGWc4qCqj8L8NbfDUFGcea
tbvDW7GN35ZBBl3WdSM+NTyi1qfDZ5jBs66BvRTs1enS9wkE3/mqVnazlUyKMtbZ
sEujNC5wMBuaPOHx25t5aF4mA1rgZqeqTqJkthLs+rLdyTbEW8o=
=92Y2
-----END PGP SIGNATURE-----

--XwCk7SVTR8p1dvRd--
