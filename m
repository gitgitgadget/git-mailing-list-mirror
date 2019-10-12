Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7264F1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 16:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfJLQWd (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 12:22:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:47927 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbfJLQWd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 12:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570897345;
        bh=ddHha/0sepI27CIxlZp+qfHW8+ysvIFGCla8UKWEyV8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZHt3nKDZ2o+P3qfvfp/ZHk7biFWv8ikZ4JZJa2+QYZda9mGUzChIrd8J/xHuyCZUi
         6lLW1EVLWs2NN1pGj76nmCHGTn3wy6Fr1Zsn8tNjwHVfFsf7be/KY5XDy26JkEwBpP
         ajDZjYMXE23+706t7CRlXgnxOMrNKR4qMX+6mPYY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1hnH8H2QoO-00cj7p; Sat, 12
 Oct 2019 18:22:25 +0200
Date:   Sat, 12 Oct 2019 18:22:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     James Coglan <jcoglan@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/11] graph: automatically track visible width of
 `strbuf`
In-Reply-To: <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910121817180.46@tvgsbejvaqbjf.bet>
References: <pull.383.git.gitgitgadget@gmail.com> <4bc0a0596164212aa9d29d6dd0d7a0d8ab1b9dd0.1570724021.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910102303330.46@tvgsbejvaqbjf.bet> <20191010230550.GA42541@generichostname> <xmqq7e5cjbwj.fsf@gitster-ct.c.googlers.com>
 <20191011050111.GA94866@generichostname> <nycvar.QRO.7.76.6.1910111800220.46@tvgsbejvaqbjf.bet> <79463ee5-a171-53a8-4903-84a825c4e8d8@gmail.com> <xmqqo8ymg64c.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t2jSq4ZiNOWW49CIUVeCdChbnSXcSx4CuNtQqsw4gsKMZouL6/Y
 owv/8sknnyu6bznq3/sImmP+XYBr4zUIkG1zMJ3kTghtRyLZXp0r9s48EHoMoOtL6Ygc72y
 XYRYCeklMvkr+IW4B8ItYbN6lQ7wiop9Sue4hoItvyOwmbRtqvXaN7k1b3OcEFm15DXIEX7
 uLOyrD0X+BiN/JWLCmArg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x9+Rpbmrb54=:duMtQuZ/pjj/usYWqz8jj6
 em3uJDVPhRy3Zq8ZnmMAddUldAKJgB7BnQgwWf4rAM9qVJrk9yqDN2T7cCizuXar1BOQLAXL4
 3DxTouEADS2UB3pmz2qYiQk2wH9Hlbe/f7q8akaQcK5N5LqqE+THnzClw4Q0TyB7ZlRdY1xMb
 fUyjYoZYh7aXv/JqbxTh6e2aBQvfPBbXTdMA7Xucl/4cxm5+KSigpZnN1mBlBLOaquKttfdgT
 18u50xbIZ0TVT9QEYyr1tFB9+UDJUXVsuLkdpCrtRS6QrnnOdr5WFzgPb8544PuMzB6+TtgSI
 d07Z6RVFAHuzdduBx4USBSFZ23Q/XlxgGCspQG0zvyskmswTXWnsN+qa3kPanX5Bt/8ENUUAv
 5vcZHxUaMbxcBTrHmRhEZm7yqDkeyXaFaijpx5obZkWQPxc+UTPzKjKmQtVxGSgrhkLvwCJhG
 0zpWxuLe3R8k1hqnLe3DRCcsXP+xj2qnYDPwtqwKOs1wWx4JDriOCMzmFJBWiQ0xjmQ5nXkZs
 FcAKSY5grN5699cJlRMyedC47dpMxgmFn8s4PVU/B+QZ52pH7dV3kmYeHdwhMT6HYWvbFHaM4
 6XkI1P5VaLa6rKwZLR8qH8y+qwA/xIy+RH/792HGGXlpWkBLh53l7Mog3B8qSaQT3s2BLWPjD
 SwUw6laM80XMVbbi/0SeYcUrLxdN7iA+Mx1jYBgiMZLLoq2DYSZPz3PnN8arONPf0+OcC5D3+
 6VqUxkdCKROxtCCljoiCWvFq/523PDnRS7P79sr29xaw2Q4HknX8PZhaV70IVy3PzRehP7v8i
 7YcPPBihx0i3YP5RqoCxlt8mu2D3EZpjFsb0h0EaJttgynoGrhvyyq4FJyatnEfGox21Y75MG
 /xW6IFb/N+I6DZZDw1rAxly0rJvNWuuAqX6wpaiMgTPIizL3GbyDmI7UWNGyWE/8VJjQkM0E1
 WStuTD5L0TlMdBk4nsVmggMXEsgemmGxVHFG1bS0GaFbzVlMUxDyBZCmQ2MoBY9dSsIDiiW9U
 M74pRPD8Rcd3IbOn3OMyFgqKh8/fpBPj5ATAhE6I/4iFosCba9r8gQQcoGVEJZKwOvv8+Gtct
 u1rT+bNFD5ZE8/Ni9ftuspQh5F2mqSLjTqJYklCSrqzX06FEPmAyjUPH7Pm7wkgckG5FrPzve
 s9TJqkYPl2cM5r7NDFQm5QcOv402O5zghPZISy/Y6fed+34m17L7Q0UGnqRvXi9xabhXC/sI8
 QlliuBQpkHIGuagmwtBCeZO6PnIxU50CnI/TkgXyIFg9YOTE6kjwQC5K+FG8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just realized that I completely failed to offer my enthusiasm not only
for the idea of this patch series and the resulting graphs, but also at
the really high quality of the contribution. Thanks, James, for working
on this!

And now just quickly...

On Sat, 12 Oct 2019, Junio C Hamano wrote:

> James Coglan <jcoglan@gmail.com> writes:
>
> > - We only need to consider the width of a small set of characters:
> > { | / \ _ - . * }. We don't need to worry about Unicode, and the
> > simple character counting in graph.c was working fine.
>
> I have to warn you that we saw attempts to step outside these ASCII
> graphics and use Unicode characters for prettier output in the past.
> If you can do so without too much complexity, I'd suggest you try
> not to close the door to those people who follow your footsteps to
> further improve the system by pursuing the avenue further.

That is a very valid point, I think. There are really pretty Unicode
characters out there that I could totally see in a nice commit graph.

At that stage, we would have to use `int utf8_strnwidth(const char
*string, int len, int skip_ansi)` anyway (because of the `skip_ansi`
that saves us _a lot_ of work). In this case, I doubt that it makes
sense to keep a running tally of the width. It would be faster, or at
least similarly fast, to just run `utf8_strnwidth()` on the final string
that we want to measure.

Ciao,
Dscho
