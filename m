Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED2DECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 19:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiHaT6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 15:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiHaT6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 15:58:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56FEEF1B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 12:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661975868;
        bh=IUyCK/7oDQnQYevLwVj/F/SUIpgIjvb75C/2HVcgZk4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K4kQpMDk0O/C4feKl4xDC/4AGwYAeaoIBnFQjsWgbnpTdUfR6iqgbNbXa587/FePP
         jrm0nzkv2J1lXyckM8qZjZbVavtfEJBEBzdbLsbR+Ww7gn67N23Yhh//IXUb7JpHcN
         g/DgEiup1huiBhk7pfCCvPPHooeJ22K8j9QRIm+g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1p6NMU0ZT0-00eLvW; Wed, 31
 Aug 2022 21:57:48 +0200
Date:   Wed, 31 Aug 2022 21:57:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/5] t3701: redefine what is "bogus" output of a diff
 filter
In-Reply-To: <Yw+Cm+0EuqIZvY66@coredump.intra.peff.net>
Message-ID: <r3nsqo6s-5531-r8rn-0434-315q4r0r88q9@tzk.qr>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com> <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com> <a01fa5d25e4a94dd8ece5e328f853c000a2ad0f9.1661785916.git.gitgitgadget@gmail.com> <9261de42-3287-6ccb-6cf5-21c0a8ee1f17@gmail.com>
 <xmqq7d2pifby.fsf@gitster.g> <742b42af-a298-219d-a35f-1fa8ba985aed@gmail.com> <Yw9/81QFPsSjDUTM@coredump.intra.peff.net> <Yw+Cm+0EuqIZvY66@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fLoAfeuDJAKJ+ebyQFTdXHG/u2J3g7zCnrIqUe9IQ6f99jqWJod
 iM54AsNO/iBpFRekGiUS4i+AN07EbqRaX8ARsecagJjlWrzGVayYa2OEMDA+Ia0w5wHl2OI
 n1KmuzQ3PI+FuStFTPN4B2lbqDjya3j16xPpPwR9bJwxcrP9+gNyTbEsTQggrbzLjASsIem
 5eOWCiNWZcAlcGAr6rlMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KUUs7Cj7QQs=:yZbVlxKPquS2q7jsZqCBUG
 ID9vej/pxuGzuI5fY8dJ0TPmRAceW1rmMro0MoSYDlVTXx+Dbm2yjfuzx9vmNyiHbIXU9nPuM
 hnIx+nxmBFPRibc6E/QqLj0/2H2tkyM1/rkFX3BpV4Ln9S0WzFle+5wj17iC0JiXUsTzLeafN
 bfpDORSmy+L3fZQVM/MJdsG8vSZf/iN1LY8/krfMf5238rhY507RkBZCRBDKrj1DflBf8PTd6
 V8MQxQBUtD7wbJHwEzj+Hxh1ur+HnICrsbrJoq5XiuqB0C0+8wd9zj5kDAxAnMnWNqcbFb1zW
 QZR3v0/6h33OMgUlFHFK8AUoLtPeCBpColuVRXtO/1PZ0xQCmd/n8IV1SJCfFhVLmB3BFd/oE
 1B2SDoTaRQXuO8y0DdIgGPDUgxb3UOeaJBumi18aIteV45kECFA7bWrP39MTcIE1oif8uQT/O
 osgJNXjcQ9Cym8m5d5jTBNaxnmsQwpu7LNgLsHjtt/4SShR7JVMTooECVtNYcI7V3ovJfoX7p
 o0NfhlRdExEvub+1y+d1kqG06BETOTxUg9mMCPwf3AbdHugLR6a6cIBNaMDvNSdA7ul2dpzVq
 fYHPnr5ZiPjzu1Stkrlok5yabIl3PL2MRRRDB5C9JtRLcf0tUXHY6t8SKQ6Mh3YAZA71cUbst
 cZbGCrKiWSAuhobumWRu02kuDAei8bBYsqyeDgDP6THT0+I4DFfJIPVnsn7bTvRIVnCWaBqJx
 vEWu9RWMv3umlMxIVOX4Jky7RNYfF34oSp6jwUIaj6Tf4BtZA3B3faFNq9RlG6+OITdVW5AMV
 HnbWr2/QRXzT+6qnUXpRWyUVAuWiFfDH+qWgfiWCx2tDQOxqB9pwkbT/aTSY0RWfMJuWfWkKl
 sXK6e04h4Eg4ZlA26NnDdigGM0kkMffc94EfTR3sNwfHYkdjrtIvvz+jYime0iOB+b0Jg6zu3
 Uw/YB98OlZr4qLtTovpvLe0f0+fY4VK+z1e8X4fNWrctGmYaNLeVotn+1QTwkOGlNHFVhazPJ
 m3Po5DU7+GZRu66G2RzJNOIFiqiUgdMxm9qKrCrbOQwNtZO+ySJ0s2laYSk1a7adJbaPCR/Dt
 3giPQFYJ4YSXr9fUORcWaTLmG3CMF1jx+IJy3mDLrDOaEhIg+x0VpQbqmKQcLG7/APTdClUbf
 fBBsLuv4APRLhd3cGwrhwBZrSm
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 31 Aug 2022, Jeff King wrote:

> On Wed, Aug 31, 2022 at 11:36:19AM -0400, Jeff King wrote:
>
> > > I'm struggling to understand the need for this change from the expla=
nation
> > > in the commit message as it seems to me  to assume the line being de=
leted is
> > > the hunk header when in fact it is deleting the diff header.
> >
> > FWIW, as the author of the original test, I'm also confused about why =
it
> > needs to be changed. The filter I wrote in the original test was just
> > "echo too-short". It was switched to "sed 1d" because the original did
> > not read the input at all, which racily caused Git to see SIGPIPE:
> >
> >   https://lore.kernel.org/git/20200113170417.GK32750@szeder.dev/
> >
> > Switching to "exit 0" would bring that problem back. But I think "sed =
q"
> > potentially does, too, because sed will quit without reading all of th=
e
> > input. We really do want something like "sed 1d" that changes the numb=
er
> > of lines, but ensures that the filter reads to EOF.
>
> By the way, the test change is needed for it to pass with the change in
> patch 2, where we become more lenient about parsing the hunk header.
> That implies to me that the builtin version's check for one-to-one line
> correspondence is broken, but we didn't notice.

And that's exactly the case. It was an off-by-one bug ;-)

> In the perl version, that test fails because it triggers the
> mismatched-output check:
>
>   $ GIT_TEST_ADD_I_USE_BUILTIN=3Dfalse ./t3701-add-interactive.sh --verb=
ose-only=3D56
>   [...]
>   fatal: mismatched output from interactive.diffFilter
>   hint: Your filter must maintain a one-to-one correspondence
>   hint: between its input and output lines.
>   ok 56 - detect bogus diffFilter output
>
> but the builtin version complains about the hunk header:
>
>   $ GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue ./t3701-add-interactive.sh --verbo=
se-only=3D56
>   [...]
>   error: could not parse colored hunk header '?[31m-10?[m'
>   ok 56 - detect bogus diffFilter output
>
> Once patch 2 is applied, we stop complaining there, and we _should_
> complain that the number of lines isn't the same. But we don't:
>
>   $ GIT_TEST_ADD_I_USE_BUILTIN=3Dtrue ./t3701-add-interactive.sh --verbo=
se-only=3D56
>   test_must_fail: command succeeded: git add -p
>   not ok 56 - detect bogus diffFilter output

Yes, that matches my analysis, and I already pushed a new iteration before
even noticing your mail, only waiting for the CI run to finish before I
submit it.

Ciao,
Dscho
