Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BEC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbiBUICg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 03:02:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbiBUICe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 03:02:34 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B6010B2
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 00:02:10 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D2A485C01BF;
        Mon, 21 Feb 2022 03:02:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 21 Feb 2022 03:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=L5sf1+E2guc0MvxSxr4t6Zp5fqGHAjXfebxyEO
        ljLk4=; b=DId0Sjqx9TScR19B3KNIc0lb8sOrGjiPnoyq0xJGrPNjpFrSsz6svk
        GGiOshAdRSrkuY2frwbh9gu2EyyB+7cnJLm7MK80GmEXW6KtFswS7Toq11/yYx6z
        kKtX2lfYExHDkp1s1YmChrgrpg6UZFoNa7ljAWXakZHhdcQFWEbSZrLoyQ+sx8aR
        gl65R3mpQ0zJDQoUbsxefVa4y5rj8c6l8i3nrO6vDVZxEFAVdlLXTUiQsBMItBGB
        mQJe7jeME8bAeBmeaEJTh6fAGyK/exfBaWwyqUW+jiPKV84pTSHEDDXMr0XioxEV
        fLalxI/vh1hS1idsQOxkoBp/0haTHjqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=L5sf1+E2guc0MvxSx
        r4t6Zp5fqGHAjXfebxyEOljLk4=; b=dxkAkLtd+Rf+i2nzi71VvrALGfgg8jhaX
        zmrKT94HZW8FDjGOveRRAr/vRwxg1yPcgTD37TWZPbVL7QJXO+Bo5pdWj1YR9Wgo
        wHJPPQpv02LUCgXUm/YfOE2PZ3WqkGTkx7WdF0WRRWOhsUCoNyT0Aah9Xp/CAc4o
        IX8BOK+dOuxSCr6+pRaIASPe4OVcNIV/6t1FmdFXDedcG89JCS3v1drujLasMYmD
        U3dletypB/DBpzNYEukaC0CoiRbu8scCCSIPiV0WOd8k55bcrUlkqA9f8XY8ewcM
        QV7ZOGnPxH95U4VLBO7KQiLVn8NCa8a/nV3eEGxgdQz1XRUD5hydg==
X-ME-Sender: <xms:AUcTYnOQimt64jaftwos4oFMI9cv-k83pRgoBAjCMJy8eBUbp_XF5w>
    <xme:AUcTYh_vwHOySvWOfDGesXGYX_aGT9LJhkDl50xwjwGKtJAJt45Q_9myqNjCDJVpF
    naVlwHrhlpVb1OnQA>
X-ME-Received: <xmr:AUcTYmQC8OmnVavjFastgrpm_iiWQfio1oOTH00Rk3W5vAFid4DGVv5FmhMzxjZWYETiCH1IJXlbo35DSuLEG6b73zkdJE-FakIrMXvOFsIATBg49-e4gA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeehgdduuddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:AUcTYrtIam4cB3sBxZYImootjxV5OcAtVpI7d1jAjPjCE52GLNkgaA>
    <xmx:AUcTYve9QPMc-lGhPQgbrBHqyv-vhZrEKkhuke2VH4EJCT4N1VYqqw>
    <xmx:AUcTYn1o14_TIqa-MzxIVZ841jJeAt_kC6DC8aMWvUiuejfcHiMOLw>
    <xmx:AUcTYr6AY_dSiVx3rVlgPPaRxGOlMAVkVGN_yanqz2xum6IbEyYQ-w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Feb 2022 03:02:08 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6d21c55b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 21 Feb 2022 08:02:07 +0000 (UTC)
Date:   Mon, 21 Feb 2022 09:02:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/7] fetch: improve atomicity of `--atomic` flag
Message-ID: <cover.1645430423.git.ps@pks.im>
References: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4xHWIhFoQNTz0miQ"
Content-Disposition: inline
In-Reply-To: <cover.1645102965.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4xHWIhFoQNTz0miQ
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

This is the third version of this patch series fixing these issues. The
only change compared to v2 is a clarification in a comment to better
point out which type of backfilling is being tested.

Patrick

Patrick Steinhardt (7):
  fetch: increase test coverage of fetches
  fetch: backfill tags before setting upstream
  fetch: control lifecycle of FETCH_HEAD in a single place
  fetch: report errors when backfilling tags fails
  refs: add interface to iterate over queued transactional updates
  fetch: make `--atomic` flag cover backfilling of tags
  fetch: make `--atomic` flag cover pruning of refs

 builtin/fetch.c      | 192 +++++++++++++++++++++++++++++--------------
 refs.c               |  16 ++++
 refs.h               |  14 ++++
 t/t5503-tagfollow.sh |  74 +++++++++++++++++
 t/t5510-fetch.sh     |  29 +++++++
 5 files changed, 263 insertions(+), 62 deletions(-)

Range-diff against v2:
1:  b4ca3f1f3b ! 1:  081174b7a0 fetch: increase test coverage of fetches
    @@ t/t5503-tagfollow.sh: test_expect_success 'new clone fetch main and =
tags' '
     +test_expect_success 'atomic fetch with failing backfill' '
     +	git init clone3 &&
     +
    -+	# We want to test whether a failure when backfilling tags correctly
    ++	# We want to test whether a failure in `backfill_tags()` correctly
     +	# aborts the complete transaction when `--atomic` is passed: we shou=
ld
     +	# neither create the branch nor should we create the tag when either
     +	# one of both fails to update correctly.
2:  b0a067bbc1 =3D 2:  9867e76ac7 fetch: backfill tags before setting upstr=
eam
3:  0b9d04622d =3D 3:  7c36ecbcf4 fetch: control lifecycle of FETCH_HEAD in=
 a single place
4:  bc1e396ae0 =3D 4:  a7e005dd48 fetch: report errors when backfilling tag=
s fails
5:  fac2e3555a =3D 5:  0316d770e9 refs: add interface to iterate over queue=
d transactional updates
6:  331ee40e57 =3D 6:  2f98e34c84 fetch: make `--atomic` flag cover backfil=
ling of tags
7:  2ad16530e5 =3D 7:  7292de826b fetch: make `--atomic` flag cover pruning=
 of refs
--=20
2.35.1


--4xHWIhFoQNTz0miQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmITRv0ACgkQVbJhu7ck
PpThHxAAhSx5FHZlSum4q5gbSEpJ/8H56MO8lW2EO3cb9Jf3XcrIewy++FJe3q+N
mOHQiDi/ivrzAWAVgslEddR1Mo/TaWrP7Y9lcBPqrEWr+bIJtw7bqcHciT3sejLP
XidOd7Fg8hMM1GPHUDDf8h3rpaFfmvZasiTePCZ6HGxiroquHfOM+yf20ZXwH5g4
8Vhsf6E8Ahi7co1jdY5c5xOxwLKAsXKubqx5Aqmw0AsXZkxnAcdXQggxag5Mp5Cb
tL14h2W0uOEajjGkucg3scfsNdIiR54rd5R4p74kK9+LvdfaapOhQOaYaWrH9BGH
3vuIz63602tpdVpPqaFSdFn4Gkev+VAOD735oVWF1Zi23e8Ivn5PCocwcgV9lg5t
n0j2ykIW50FIEzEHQr286LHj9KZ25ih1hR/vbBcY6CSvRRKfD0Zm9IGqXkvMyMNV
SlwApEm38ak53DY5Ea+WsMN87ogpXs2G9yba97nAW2PltZ9rVDA6m4oFFjLKk3GO
N3HPRDza+caqOt8xwUgD8lbs4cSdJjQ3Sc0ZwsTjgEmbn3LaU2yYM4PxpsgohMIY
fr7+YmzPhh7czLbUR5gxLIO0o7Cgm56caOTcJpENAZ/fmoaNNZ9JrgNfbicSE800
U3x1K7Tk5PSiP1tyPIkz0Hsq9gOWbU6myfO8BlQAgMJh2du/7uw=
=voWv
-----END PGP SIGNATURE-----

--4xHWIhFoQNTz0miQ--
