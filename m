Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D6C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1D320758
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aZ/Rmc2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgLAOUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:20:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:49829 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgLAOUe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 09:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606832335;
        bh=JGiJy8qYk0ke/Hv6euGz4W3ErHA5BYH8/A0sGtTtEVI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZ/Rmc2oSGLGFjJvXvGVarBqY+JbJAEd4UP+QfxvQpZxRmvh07hjbHTTkNKG2/9Xh
         HY45N3UUPEEoO3jVzZOF2gsSk+akP2+pEQu6rzXPDmQiK2GJQJoAKef3eBYTjHoHjo
         gs4qifZ97SSpk4V31RJgtCy5hDA0QXaTDd7t+KNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([213.196.213.207]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1jzxxO3lDE-00xbON; Tue, 01
 Dec 2020 15:18:54 +0100
Date:   Tue, 1 Dec 2020 15:18:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] Minimal patches to let reftable pass the CI builds
In-Reply-To: <CAFQ2z_M8N-9pCh=+rQvGoOJNYAxnMo1upJPEgsqMT9VxP5X=YA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2012011518200.54@tvgsbejvaqbjf.bet>
References: <pull.801.git.1606545878.gitgitgadget@gmail.com> <CAFQ2z_M8N-9pCh=+rQvGoOJNYAxnMo1upJPEgsqMT9VxP5X=YA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FVJSRo9MBpkLFOokAS3uMoUKhkV/N6gwILfHJyRPtCMBfWLbLJt
 TWeMI/no9wqFpQFh5NQ3DxWmyFziOHYTkUAgmaKZ3PGyBSQr/1EWx5XVJ7oQGh6rhQhoPba
 zMPf9VnC4oTgAdQExhCuBbLkjSnaLAVTKAucCagTj1w2NyVp1S1XyHXTK8bKdkSf7T55+tr
 D/I9/X68+4R8+oDdRGMCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5oGbWvTfLvw=:NeMYVJsLHEEl5sO591jSXx
 k9zveDjpsddnfminOnK0qvXgH/LWYjRVFtLH9LCy9ESO97onWcr7r5f6eT6i9dqOAIKm1Cmp1
 EcDwY6Qg7wOf3jfd88JACAOnNLQRd2RBbBFpK6WLOMTQ6SLoQlhibxCXkiGfeeG5eztEwbr0h
 rLMFLtO00PnWmOERnUWtWbhVWs17VgWP4dD3jkpZJQUDW/oakCrYzxCu09e7hjRij2F+32pDh
 aqavWPQazPMUARbq59gVoJMxkLvJxl6TnWlwKv/9n/SgRd0sF/PdTZvgl1RKPqV9ztmqwEA6l
 9j8rCpPdguUI3KU9diA2cOQP3m3Tgkx4ZB9hjX3vk3sKJoNU8il0p235Sljhnw+V//f57io1V
 NtvLN+hfVDhVl5AoJiQOx++WmRD/kvTVDxqIihpKNB3AEEtUY2I1DsRQZgvTOi59zpvOal1ru
 gm5scQPMzflj0Ph4EPhx5llzgmEkhZFv/3xYgrkqcgvKZ551hexgqh85UUBvj3XrNWLuVR4qA
 qfj6GF16TPN1l9R7RTNvSRCNZ49JSpIyuus1A1iSXi8ZObnGL/bpiralFpxrJliYvMJmE8vDr
 bOMfXQXqB8pSIClfnvSYAKYrN4rv8Xfvkg6NS8uGyWqRPl8QtPjqjhnoM6tOfNxQdAs+ncpUG
 tPConSN0AOR6d5vzI1FkiE4wRflxKA92xmD2HdHcVwAfgNhrdxiRHDfxtG7G/syv/7GdPHCv8
 MIFzAT5Fg5bUC5o4kcquqy1G8TC4fRI+Dh5MQBKMT2VSbft9KbvhnXiVTfoTq1QZxxBRHrKWu
 6XKR4Uo5Spa7GEXn8FatbuuVSPqUJv/SPPvum6rfEwAxmGJd6JuP/+xkXaCXsgoQdJAU7zaLm
 J0e+RVWHXdKDysHamZNl0Qr59ZCA2Pf5Z/WD6I7Kc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Mon, 30 Nov 2020, Han-Wen Nienhuys wrote:

> On Sat, Nov 28, 2020 at 7:44 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > These patches fix the PR build failures at
> > https://github.com/git/git/pull/847/checks?check_run_id=3D1460683728, =
and are
> > designed to be squashed into the 16 patches of the libreftable v3 patc=
h
> > series as submitted at
> > https://lore.kernel.org/git/pull.847.v3.git.git.1606419752.gitgitgadge=
t@gmail.com/
> > .
> >
> > A smaller form of the first patch was offered on the mailing list on M=
ay
> > 4th:
> > https://lore.kernel.org/git/ff60fde10919b6b8c54ecb8f38b710fac37624e3.1=
588599086.git.gitgitgadget@gmail.com/
> > . The next three patches were presented to the mailing list on October=
 2nd:
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021555290.50@tvgsbej=
vaqbjf.bet/
> > , and
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2010021557570.50@tvgsbej=
vaqbjf.bet/
> > . Some of the patches required slight adjustments to accommodate for c=
ontext
> > changes.
> >
> > Going forward, I would like to avoid the impression that it is the
> > responsibility of the Git for Windows maintainer to keep the CI build
> > passing on Windows. I am happy to assist in case it is unclear how to =
fix
> > certain issues. I am not happy having to implement and test those fixe=
s
> > myself. How can we ensure this doesn't happen in the future?
>
> Thanks for the build system fix. I think it's OK to leave it to me to
> solve the logic problems in the C code that you found.
>
> Would you mind if I massaged these contributions directly back into
> github.com/google/reftable?

Whatever works best for you.

> Google has a corporate CLA from Microsoft, it's OK to accept this from
> you. For better or worse, this is still where I'm developing reftable,
> until it has landed in git-core.

Ciao,
Dscho
