Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67725ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 21:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiH3VDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 17:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiH3VDS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 17:03:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2DC7C76C
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 14:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661893387;
        bh=5uELBRmLOwt4vbbO47DemAFcNqyMNbYfsdVlKgwyv2w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kc/+xuH6SanyqUhwB0xXP+68SSeaHrGgJsJc6je20gqYs4bWJRn7VcW2icWjdcYF8
         dIIfiRa+6kuFoF6IteTa0zJgaZlR3J2DNiin7+4OUIdpDZBx0MfU1q+Eav4r+jjWqq
         r3Ou2SnywUerPEW6aGQMPxh7u+KZ7X+F2q4VAUng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1oyt6K2pO3-00dYny; Tue, 30
 Aug 2022 23:03:07 +0200
Date:   Tue, 30 Aug 2022 23:03:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/3] t3701: test the built-in `add -i` regardless of
 NO_PERL
In-Reply-To: <Yw5c+8kaTRtJ52fk@coredump.intra.peff.net>
Message-ID: <rsrn5988-37n4-7q45-s1o9-6n40rropp120@tzk.qr>
References: <pull.1340.git.1661867664.gitgitgadget@gmail.com> <54d25d991b09219f6992dc3e8c102ce1ccef6313.1661867664.git.gitgitgadget@gmail.com> <Yw5c+8kaTRtJ52fk@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LBbI6W8osV/UunLrkY1oQb4qqyiB6n6KUGXAzODbJfJOXmzIxsi
 e5VH00QDa34SP1/vkkVFOCxhc1TmdNQjsPUMl4YKRI/2A5KN0KHOyTHrSdKzJfONRKT/oDe
 aGEFoaaj4Iyfdoz5wudAQJ8Epr+Q0spiw0mW93Osp81fRCEAF+ws7ogfvxjIwr171l2Eqna
 y4yv1kgD7CjcoZajcgJWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UkVnj2KM1ns=:uKxGAwUNCPMQfcl6HDmEaG
 EnYeaZ/GTbdzxgF/1HfsE9Js2duDASdjgYxK5i9D/5bYYAUbCNjt8lfvOzroVfCS/ThPW7xgP
 H5OWXXU7SSQEWFj9ALwiw/LZ7k8dDExjef4mcr8hAD84MTC2NYR1uFUeGfRrcaNRFt27nSOvH
 T1TOURigAdK7dlOgyv/H89VeZE8rXA5VcQjguIQjnA1U7V8arQkzKyhroB9Mn2IjKbjqof/0O
 Xt7Wy+1gaTJ46N9kuiubtUeqPQU9xT3RjghXJN7VpcoZofGFdftV00eLX3wpIQ9iJ+HON/Wzr
 CZY4sneS8WkuF+FYstu1RhTEBdkgeIL2DldqvB1lksXrwWx60H0wBTVEBNpFVHu20pl1CwWg6
 E8sF/1DVTSUJzVTcdUdcJK1Q6PGCUPoRo2A/vak+3w6G5RgtFPr1nT1DxC4BA7Or82ezsP8yh
 jYZ1AII5eE18H1quvV1heGiuKbExIHlDn8RzH9Jma7at+1+P8Z9d+vIV7BPIs/2RONGSn4ldm
 zgk+48M7I8uIqQ05Gsc7Fi4zFoJY1xp0PKyhaPNFfoIf6D3bjPDPv8jmiqnkkguQB/CIuyDt5
 gzGOgxTa8mm/4vFtHP9dH6MWk883yUi54AxL6Wir+z83sFENXQeySxIytJC3y/LA44pJHnbAb
 YryMXFDWThdxu23vuCLr+oHo7Qlm/zIDbyWDFb+FCc2Op0s8x+htPYBVOW9CAGXtiHNJigQ+j
 rdQlwmEebyDSBJHvY6K1TDCflQAX1e7RRPgn7cDky+eRoDwgDppeFkNXjO0SAtqxMlzBeQ5Fr
 g09c8mkjlV7HWAqyZSi2edfTgaqj1R6xfoUA1ct+w7TXp4AwSoUsmPhAZ5amvDLgnqeaWdvdR
 c/OmGmVg8SrBaEvRaTnoUv+0ic0PxXNJfcYeFp5X6lOqPl9LWHxCvu9yAbGXazc7V2NVJ6VTd
 1i6Q7j7VdJMO9Pl/kJF1N71pwX0Sk3rkDz/3UznIycy/pHoTQjGKMxEpR4C4CBPZGyLqJuq0S
 E4RwqHlxe0Q28UCUmi0drh9Dm0687BSCcri5OcmH8zzqGCf8FNc3w8upKIcHXrFIbn0Xo8YMP
 T00XBYy8AKr4PNmjg1htYOvCVLXwO6pYsce4SPLaHsny1nNaBhRijj1OkWIA//T2bhU0GM3zn
 i1YWL7fffQ1M4jvBlsKDBMNPxR
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 30 Aug 2022, Jeff King wrote:

> On Tue, Aug 30, 2022 at 01:54:23PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The built-in `git add --interactive` does not require Perl, therefore =
we
> > can safely run these tests even when building with `NO_PERL=3DLetsDoTh=
at`.
>
> Make sense. The patch is small enough that it is certainly worth doing
> in the meantime, but is it time to start thinking about dropping the
> perl implementation (and hence this prereq) entirely?

A couple of months ago, I would have said the same (and you seemed to
suggest something similar in [*1*], too), but since we flipped the default
to the built-in version in 0527ccb1b55 (add -i: default to the built-in
implementation, 2021-11-30), we discovered the need for several fixes:

- pw/add-p-hunk-split-fix
- js/add-i-delete
- js/add-p-diff-parsing-fix

Therefore I consider it premature to drop `git-add--interactive.perl` just
yet.

Ciao,
Dscho

Footnote *1*:
https://lore.kernel.org/git/YaaP%2Fg74KA63MCmx@coredump.intra.peff.net/
