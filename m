Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D4DC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 22:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243396AbiDUWlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 18:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiDUWlk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 18:41:40 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9C443F0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 15:38:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CF8E73204D38;
        Thu, 21 Apr 2022 18:38:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 21 Apr 2022 18:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650580725; x=1650667125; bh=3gC772DHnn
        BrRr+Qn8qID/sJLUcwXpgwNdKx8UlOewk=; b=oCzO+7E9YLGaMs2XBJq3xRS4kn
        gHosMJeKZeQ0H+Lq4vAB2LymJZETbV5TS0N9deMAwi6fV31Xd8nYwRRSXj3q6hpT
        zv+kleWdxyvDOgPHiRBRukDM5yWWFM7qk6gC6/SpMjdeGDiK/TA+dgPsFk0dpbPx
        qae1pZIK6GGnPPAmPA1XqD386g57ljNv84rzzpkbIpZS5Adt1a17yBOoU27920+R
        KvT3DRrEqo8YQ2ZSpYTR8aj+h+5IuuMZ3LCPWsUlJAUzJ/CAonMTDL+2XVwwNQrn
        28qMtrjf1lv7L1a11PkqdHkJDjZfIgXk/hh9+ywFANJNVI+XEhYeLgtIriYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650580725; x=
        1650667125; bh=3gC772DHnnBrRr+Qn8qID/sJLUcwXpgwNdKx8UlOewk=; b=s
        v1pTxTSpmqDjrLC0ad8CYh1I6Dario6s7NBAF95KbDi+a0wAn1LUbOPty3EBYgaL
        /HNw38mLW11nvllwy1yptj1qjoAu1AEG+N74EWppevp9AYR7Eu0NExezX6M2K5/y
        Et3Gl0sfZqK8pcx2ZCrQ0JXT0E5hzVQtGeBBkZKRJXtS7ByoMWrFdfz8aMEDInn5
        jQ++lkXttjzcF++B47JiVConpPaIyp2Cw9EuI4ZRuFN6rpBT0w965/MLB62uPkn1
        PohIGAX3c15ceEvLLhHAXwNFzkM0BazZUypjzEPcpNo9D3beDGdTK9hiyChAlRjc
        jm6whdwJPRvThf3RmIowA==
X-ME-Sender: <xms:9dxhYrKgAXmZBx_M7NC3hmJXBN7cXR5Oi_NX2dXq0rKYGR_GlUx3Zw>
    <xme:9dxhYvJzH8QMaRcr5LmxmknJcgHvJ67H7-R10TqGYrvjvisHars23hbBzfeVMRp7i
    jQ1fE08kCz4tRW6dA>
X-ME-Received: <xmr:9dxhYjsiCHpapnrC4hEkwMlR3gEuCH65SLkHeI7PWVp9L6l52EPl1vQ9PdxrA00B1MdhnElL8Bx8MuWtaLGCbG2oysJ78VE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdefgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihesrghlhihsshgrrdhi
    sheqnecuggftrfgrthhtvghrnhepvdegieefffekjefhvdfhtdffleetheejleeuhefhvd
    duieeuueegueejgfdttedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepqhihlhhishhssegvvhgvrdhqhihlihhsshdrnhgvth
X-ME-Proxy: <xmx:9dxhYkYBf0H2VofIBtHsbZYgNV7vi8CJHBJ0d4dDS-K7iEsd2T5pww>
    <xmx:9dxhYiYzBBv_diSGOVfR9NhH0YRjO5mxZubrE_SdJXy84I7INZ5RGw>
    <xmx:9dxhYoCHrOJX8vb3cFlowcVkBhK2fzg014Vsaz083fIYCkhftRPQcg>
    <xmx:9dxhYrArI4iEaVmNrzuLJeZT3QoMvsjgCzXYRQsaaKBV5RR8EV6zCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 18:38:45 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 947122FC; Thu, 21 Apr 2022 22:38:43 +0000 (UTC)
Date:   Thu, 21 Apr 2022 22:38:43 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Failures in t9001-send-email
Message-ID: <20220421223843.6z3y4bnrbu76erhk@eve>
References: <20220421194832.lshqkl3bogy2f2hy@eve>
 <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vbuzgq63zigj7jrk"
Content-Disposition: inline
In-Reply-To: <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vbuzgq63zigj7jrk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> I think a patch to do that would be worth having/reviewing (hint
> hint!). As always the real work is updating docs, running the tests
> etc., digging up ML discussions to see if there's been any past
> arguments for/against it etc.
>
> In this case the code change itself should be trivial (I honestly didn't
> look this time, but really, it's a config default...). So this seems
> like a perfect task for someone not too familiar with Git's codebase,
> but still interested in contributing :)

I thought I'd have a go at a patch, but I wasn't able to get the tests
running:

    prove ./t9001-send-email.sh
    ./t9001-send-email.sh .. Dubious, test returned 1 (wstat 256, 0x100)
    Failed 15/188 subtests
      (less 1 skipped subtest: 172 okay)

    Test Summary Report
    -------------------
    ./t9001-send-email.sh (Wstat: 256 Tests: 188 Failed: 15)
      Failed tests:  27, 51, 78-84, 123, 147-150, 185
      Non-zero exit status: 1
    Files=1, Tests=188, 17 wallclock secs ( 0.06 usr  0.01 sys + 11.66 cusr  5.37 csys = 17.10 CPU)
    Result: FAIL

I had a look at the tests to try to guess what was wrong, but I didn't
come up with anything.  Any ideas?  When I run make test, every other
test is fine, it's just the send-email tests that are problematic.

(My git source tree is v2.36.0.)

--vbuzgq63zigj7jrk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmJh3O0ACgkQ+dvtSFmy
ccCUYRAAqYjNPptiG+4pNhinmerrcZckHIlz/KCxO5NywX9NZoaG5rj13yaye5Db
55cBVaB+GjlrfFna+hYgyncXjp5/8E6wAH1tVD6xN7/WnR82uTVW/a765gsrgPZG
Rn7X/XAlU7VwCbIpgGcT8EizN1+H+3SX0qeBOClydGnjNiOpvPBtRp8eEfKaCP/6
H/q5U/6xUad8UD0GuHwvSorfAFHrQW0opo5N87yNcHGLLUi28Nv6FFy3FmEx5iEl
M4+xN+MVnaqD09DfdcPJ5TDtAGIpsphhOgHTfQwhFdGsm88LBWJ9QJKsWJo5pY3c
7WLKaWK0dPst4mY9DFqQu5WYsnG4WPlKX8Gnft6g/CiqtVEGy9Ut1746+wIFa5bs
8j+/ntJbjubLbuvuKoVzJwoN9t/eZxXMfHdVhFJ4ScczlQKquDH6ROkIlG7cXs7q
qTRjOQVA9KOlDdD/smL9NcZZ58SWG1MXa9oW3QsFyvKj3vrkeu6L5IlaKuyQdXNS
nRC9DFyT7T7dWT56Xuf2mgpCC3kftC3OWqOq7O6+sqSouyXFm8W3kw0F+Qofcz/h
bnyggyNUWUFrPnJplqhEDq4vHudccwmNoAv51+GVY5++7Ixq11jHyeRCyy1D/1lJ
tpGK++kInj68Fet7Uf99DaO/qPu/bboBw24k/QRchYb7hAk5fr8=
=4S1F
-----END PGP SIGNATURE-----

--vbuzgq63zigj7jrk--
