Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA25C433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47A68610FA
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349645AbhICPZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:25:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:53281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239585AbhICPZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630682658;
        bh=6FDh8B7tFEFlC2nJ0AtLdZTTw0C6qr3+jm7dYmdqWmc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c61VzavFMQse0JxTR8Yxy9vKME031kbrehNdbRgk3KbonCe144WsYjjjhGojRkowP
         5UpQpIHCM2iwzSUUsR4FqD3Trub7vQQ/qhAMOYzjg5WRDi4/wk1/WHVV+XQ+sn1Goj
         6YyeIObbPscxca+5tKQe2yyTI6ODSQ6S1TJkIXvs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1mQauY2A1Q-00Uq8j; Fri, 03
 Sep 2021 17:24:18 +0200
Date:   Fri, 3 Sep 2021 17:24:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 14/15] scalar: implement the `version` command
In-Reply-To: <CAPig+cQAGxRrLUcPZtZqGEJ9RggRsDt0WJK+dgWmXtfCnZihOQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109031724160.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <73d08c0c8948340f6c08c1689b40900062db5b4a.1630359290.git.gitgitgadget@gmail.com> <CAPig+cQAGxRrLUcPZtZqGEJ9RggRsDt0WJK+dgWmXtfCnZihOQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DaFU593xu7fUFZRrEJNlPaBcbBuUiCLWFbhelDdDUpA+0+OI6iN
 NWOjs8lyI5dhVblVcrhCCfixxaUCVDmqM4px199vCCSFlBDvE5CYtUBBRsDOCk5PFoAIZ/V
 BAOI3owoeUPy+G4kX7n2dSvMxuha7aPR80Mj+BU2d33cLor+aFSjHOVhzioJn214P1ZSQOS
 2EWa7AfdiYmzITZBVfyGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:umfg/hI5hzE=:uDvfJHn2wy1EzAhXdUBTHd
 T6fS5v1miOXGpR3fa1FdOxSnHt5v20+vbXxDr1Rfv9fO70elu3OTGjHM1avsj2oPstXokaP9P
 J3k16b3dkb50s4mVZJOQx9/gahLZf72TgJf6+lPK+45wVOMJmSAwfbz1ZhzKfwkURcox66t+2
 ozLGaRVh/9Q5872IoAczKoj96NxykwBpgA8gjxnX0hDl5MZAa9L65gDEjYk7IHkvQZMnABsW+
 GHyIPgMxqxGqtLMGHJpHSxIzL/MWF3g8ji0Jcdw7FIxD5Dkr3qaAemkffsh+S2/z03hDtZ94K
 IWA1vDnxM5jigjlwq4MOgrhlrpb0pjRlH3Cb4NXZ5zNA6aj2UNlhudhHvCi+vMqvx16wOhEya
 TySE0WnTiRMf7601IRtOD9yLI4JQFCWk9NC2wikihHxTsF4Q1NgaknzsftHoRR/VsuJ03hYRH
 0SSeSCqMeBTo61vMD70+pip1qMliRaESe9QgGQtM8FaTW6rsUASaTxtU5nTiiu8IpciBGsPe1
 C6So8LuStuBUMRnMbs1liEKqVVWYedUYC7ADhYi8xaiYXfP/oUvQ+xHMZjqvIkakz8Um7B/im
 nlLQQqpqtwS50bozvLfVBLJD9MBMEkjnqngTmrMY2a86zHAQQSkY5oertB3aJGZCq+xNk+GdA
 MgUuu/Ax53hI8OY42kUw0Lowvq3xl0BNP2IEVs/Lnnr/nUwDbmK/b3X5PpMPtCvSOnqfGafhO
 40TdVKcdeTUhZGfSrBWU+P1HkxkG2fM2YCr4wkIOzub26quMk2QrvH04uWqrx+Me7KuKD/MOe
 rD7w8UCUVe2juNUqmalWCGab/OE39iDqFhiM5HjACQAaUrM75TOAM6LM92+TfUZ4+ts8fD0p2
 2hExEPMZAgr9FF8vC0XLneu1mm6jmMlkz0QJNf/ULDw3nYOXOp6lboGC7yFhpgD+sLafPcq4R
 WkGryEirqPPXTqZZ4SNd/9hjxCRXAM2609fGWzjdSYuqnda1f339ModOQsdhL9GNJP16hujUA
 fZvbffOKrVPB6fcfh8j8Hj+us7jU3R2lv3VbT4gF4ixnZ1JjGpX9EZGfzUAdV9TvASfKBVCUw
 58VBWqWevs9MDgDK/hzZK/ouq4AzrrM+t3W7GxAhV09vgaU9iQChjarqQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Tue, 31 Aug 2021, Eric Sunshine wrote:

> On Mon, Aug 30, 2021 at 5:35 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > The .NET version of Scalar has a `version` command. This was necessary
> > because it was versioned independently of Git.
> >
> > Since Scalar is now tightly coupled with Git, it does not make sense f=
or
> > them to show different versions. Therefore, it shows the same output a=
s
> > `git versions`. For backwards-compatibility with the .NET version,
>
> s/versions/version/

Thank you!
Dscho

>
> > `scalar version` prints to `stderr`, though (`git version` prints to
> > `stdout` instead).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
