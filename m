Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6748EC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5168A610E5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349659AbhICPWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:22:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:53209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349645AbhICPWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:22:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630682463;
        bh=Qk+Frsjr+1oD/T0UnIrY6ZkUkh5QofDUIJrqQld1VU8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OpYcujo8Yu2MsgJ/wG4djOWGYXKRFzUuv9JHvQ/+Qqj/YmthmJp0R8fDQThIwbeC6
         COKbyTIFK1VS6hPg1B+lFGc1vTvjO3qY6VTJO+JQftJ2YksB4+51AdNFWCCKR4JxSO
         P5zNm8gdtUHKPJMuJvhNzQj9WY8jaEUR1M5DbbK8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1mY1UO0G4t-00UeWn; Fri, 03
 Sep 2021 17:21:03 +0200
Date:   Fri, 3 Sep 2021 17:21:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
In-Reply-To: <CAPig+cSy=mps-b3HWZSC7WcMaYV_H71BVRK5b0cSy2fA0ogJ7w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109031720420.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com> <87a6kyxbo1.fsf@evledraar.gmail.com> <CAPig+cSy=mps-b3HWZSC7WcMaYV_H71BVRK5b0cSy2fA0ogJ7w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-74038682-1630682474=:55"
X-Provags-ID: V03:K1:8zpMJWiIoPBvvIuSjC29lGqZGPoqlOZcngp46iqLxdjgNWoy+DM
 ntyxkYklzbBwz/TOxoQnl+HcbgaaWZ51kSKbOczoHkU03SIHsTChhDkqByverQHyJKtTdQE
 n6i6kfbAqyU3Bgc+lj4iuoU64qjn/z6SMEkt9o+7nei7UXvoz6EpR2+CKc9tRzK4lmIy73P
 gfKelDQwWxkbZlcFy+noA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+lsy+H12EzY=:OeWuEUA4JvuJMlpg1L4QWI
 +7wK6tT9zKOSOZJaKMzxCZzqNPwugcaPaadWoAweMcA+4AD+A+xn6FIxVjylFQPFZPh/qAs0+
 hRgR6pJFS64RgV05NaB7gPBkgGs1Yw5EpZo8V48KhtczOh3eFfHxjBWoJsapBDreO+QxhsKzq
 qlP9A70mdOirOHTflkgKqWUCuPANeCa+/jphuliDrEt+Flcn6MWpyPFnmr63W41xHogLC/nMZ
 Hw98SmUXDTefvt+wHM3v4FKkuUGw8ZBZCPlVCHtfFdoimkVvoK94lb3LhhYiUSDPGagCj3+iv
 da1plyCNdhnEeldb+jvJLPGoUoYiuj28ZtKoeZpKGJUCpyzN/9aiWeWDXjozGdTjnBzurnEDY
 OeAJ16K8XhsJausL3WlSKdmWF6Kzb9+aB57DkqnA/3pSAQuUr+2RctlClzWik9fwO7YQsoX8r
 pVIKSEUEJuuB9ehwOyJZmaqNUXbZeQ5ZFo6D7ZHlJAZ4roN+nonJgi++wSHNeMyWomN0OV3+V
 DYzEuIdASXVxEuHbA27sQ+Vsf+Q9dE/2sjpbjUf7avLcRw5HImLhLGbq1mVYi1AEoiA2bcqdE
 6UMx2VS5qUnOHZtmoivW6HW6rWZLOFQypz5eLeDjEgLeq0Egv2J9sWCmoxstNXS312sEoQkj6
 V5PT2jMreZPRV32Pltql3RcUjnNxFAMnNrXq914vu3oUwNBeusIAGnGeD6m3Q3Y5HlP08/S5x
 3jdoZ36lnCijOqphVMz/B6AipKY095baSZEt0BqTUJnjcfHpqEmcXMGzHERhTsa6UHXmv8aeu
 4KpcGy5mjgpj6lXLdmjWV9cKavq54soByor3ks00oa63ib2YT7vXvsFRFO+54COgboZxappwB
 XRSU7e+oMGPMk2Y9OxMEwjgbxA82X5dXiKfPTEug+HVZ2x3fYRyQMXerPeVPG2qPT/wkFrotV
 AmLDZL9u3eFheA+7T3e/9LF91/9XAuPq8K53KfyRPLw7rHK+mqF6lwcZudSc3D1C5FyW34m1i
 +NB+1R7iXUdhjdewEfPGsutvklHhg4FfZwBda+xCbx2NRJRt9nZ5OprcHOToX7R0vCnD7qtX/
 SOjIyBmjAmoegVNReS8BrlPhq05bYLcxh04xbjZ8RO6kvfHZdIa+ZDf3A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-74038682-1630682474=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Eric,

On Tue, 31 Aug 2021, Eric Sunshine wrote:

> On Tue, Aug 31, 2021 at 8:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:
> > > Note: We intentionally use a slightly wasteful `set_config()` functi=
on
> > > (which does not reuse a single `strbuf`, for example, though perform=
ance
> > > _really_ does not matter here) for convenience and readability.
> >
> > FWIW I think the commit message could do without this, that part of th=
e
> > code is obviously not performance sensitive at all. But maybe an
> > explicit note helps anyway...
>
> FWIW, I also found this distracting; it takes the reader's attention
> away from more important aspects of the patch. (But it alone is not
> worth a re-roll; it was just a minor hiccup.)

Since I reworked the remote default branch parsing anyway, I removed this
paragraph from the commit message.

Ciao,
Dscho

--8323328-74038682-1630682474=:55--
