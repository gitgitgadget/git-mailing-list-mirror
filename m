Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E6C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AE061179
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 14:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhKBO77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 10:59:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:55105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235028AbhKBO7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 10:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635865023;
        bh=c/U9BU+LC/f+WD1vsAAvco7qcRU4lmGKqs5k15t9/G4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZLOdeNfzF9FMB8ospA/qDrmiFcK8iqen9xBB4yBsguSiR80lA8kBq1Y4b+7+kblYY
         CquPuA3rF5+cMMqulD6rml/yc5j6SRV2+3mkOvSdWyU8qgAjTmWwPRHd4lnVZENC8G
         2QFVck6IC46kP454ILoTAor4/ZmGgoWkVM/Gyt4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.29]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1mmrAD2Nus-00544L; Tue, 02
 Nov 2021 15:57:03 +0100
Date:   Tue, 2 Nov 2021 15:57:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v3 4/8] t1051: introduce a smudge filter test for extremely
 large files
In-Reply-To: <xmqqo877h1x5.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111021556480.56@tvgsbejvaqbjf.bet>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com> <ce9dfaac9f8693890aa402161b38292b31d3690c.1635515959.git.gitgitgadget@gmail.com> <xmqqo877h1x5.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:F5p3aNJSffLNCm98zBUZzwp0Sg5u/XsLub6Versw+DiGaOdIdOB
 8PHM0Jk0qvICooyZHQiKcE3avjRqHdQmSMU8Uk5p5cyGGLEDXJawcgFlBu281lH7cfxvDA8
 EZg1BcORNDCouhfMOZqs2aVC8zji8mM6oBNGYWG7cuk2wZW1+KTMD9qGMb+rmJ6sz0e4JOe
 j6Cg+PXcg+49tPtvFrMkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3AdKSkLhI28=:40Dje+02FuPyK4UD+tUCte
 eELlzYaY+5OdBr/9EAVCWjCpFzuJJbqCeQtz76GrbiFA7R18Y4eG0dbB+6fdSDh3EvxOJiwj8
 tE9kbewRRKA/tFg4/FDTTcjYS7WqWTgDyDWzOnyvd8Qcf9/v7Fhe45kJSrkGqEFYL0dVWWFvv
 XG0BVx6QyYUJLuNaITSVcQ25aw7ZQRA6SbjdKUM43Ye3qey+/3d9+R0gzIR0dfi2DuFNX3fbe
 LlcSqhl3CiCLaoEDqjL7hvsn7H+9YSu+RLbISnC0BA4lhmq3lnvrzKKPkDO18mhmYm3gG1hkw
 GiEhUDiuilJ5FW40Lw054UeLlDNfdsiwC/MCr7IkSG+BNqJrwnvPer3mZWLiG9OtzFo30AY+Z
 OfZkdwB2GQbSFtIt+llrC4n6//oq4oMQfWrlLYDHv22lqzkmlDCKyqkfm3LWT1UtCC+H/yGyc
 oSBuRhYiiPAbXVX0LVQWabqDxFREBKOu5R15woyh1+oip+y9lcOKI9BCQtrAsknb+t7sRJyg0
 o2nZXV37bxkC8P9SVfBeUoXeRktRx6NZ1S50L+uSKtG12Pv/+szytCZU2wmEA0OqO8iJ1dc9m
 y4PCBC4/zVd3yLPDYFwdGxCsnocfOiEugvVAzSUNc+QHYW7XtCpAfXo2ES+ogpEBnHejimStD
 Upc4dJYwKd7RqKNYE+59hAr9QVeTON6HIipwVBjD8PaY3prCBpYAVJ38zPcyAASonl8oN1xLs
 +LrNYw75PPZXrCRyWTT8tAjvoniuwrhVqKxjMOXqD+2ieCNfqCV6Jrsad55HgJAvPA4Y4v0hl
 Fz3HBLT/20ujdOVlQ85t2tTb3Y8DORhZ1vIy2kDUbLZaKgCTToNyDDdI8tKBm8ICyLiqgrGQB
 LydFP/kMq11tRPWrVV7r1cvQlJEJlZjO6HYCbiuxJHMNQRX7hjXwwu0pOV7hbC4gfc1/IjkDs
 JTnyKBBoNwPoCr8KxdxLDCBqEqZ1894aso1q8obTi+nBgDz1d5FrMDq6d8MMZvjhHMZMsxeV6
 G7YswAHg8XAMS7Xl5VrS5ztKD6YFWOxm1D2Kre55J4URqvq+M0w/c59LHvWpxgSOB7ybHzwSQ
 w1JSTd9uoBM0uA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 29 Oct 2021, Junio C Hamano wrote:

> "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Matt Cooper <vtbassmatt@gmail.com>
> >
> > The filter system allows for alterations to file contents when they're
> > added to the database or workdir. ("Smudge" when moving to the workdir=
;
> > "clean" when moving to the database.) This is used natively to handle =
CRLF
> > to LF conversions. It's also employed by Git-LFS to replace large file=
s
> > from the workdir with small tracking files in the repo and vice versa.
>
> Not a huge deal, but make it a habit to spell "working tree" not "workdi=
r",
> as someday you'd write end-user facing documentation in our tree ;-).
>
> > Git pulls the entire smudged file into memory.
>
> Giving "for what" would be helpful to readers.
>
>     Git reads the entire smudged file into memory to convert it into
>     a "clean" form to be used in-core.

I changed both.

Ciao,
Dscho
