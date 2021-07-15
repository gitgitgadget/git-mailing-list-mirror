Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F2C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 12:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8824F613BB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 12:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhGONCQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:02:16 -0400
Received: from mout.gmx.net ([212.227.17.20]:58019 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhGONCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626353957;
        bh=u0vhdczrwRoBGZqaLs/dCwogQ7IKAPGZIiGeBbvl7cc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=L81wBOwZl/ujKddejThF2rrcQL6YdJVWIHPRatzLF4VIxalqqS/QktxZum8/aVhlR
         kQsX8YPXc2tA8h8ti0iwCWjLeCvY8x1GdYsN3emmWwVuMqj6is0qHrM8EROTth6gl2
         aggSogmZkJ9fE3EnJMAF2rcq35OKlAkD34G4DPQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRMi-1lgxmz1yhQ-00TlJY; Thu, 15
 Jul 2021 14:59:17 +0200
Date:   Thu, 15 Jul 2021 14:59:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH 2/2] ci(check-whitespace): restrict to the intended
 commits
In-Reply-To: <xmqqwnpsttx0.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2107151458320.59@tvgsbejvaqbjf.bet>
References: <pull.995.git.1626300577.gitgitgadget@gmail.com> <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com> <xmqqwnpsttx0.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fjb7FjUaxTnMq+nlCqS/Q6FbLD6jr5JexD2HJd8iZvGuxUURqtp
 uArVzVOOiB2REzo2yipCRKEZFD99r2nn56w2NAdkb+1l2fRt/+6eyF/62BYARlLYklLkoyG
 oOKXPiFsu823ZLn/NAh+vWOpXCHLjC/mOmkhh1YWC3ktgB4ZrsOOOEk8NCHts46Gd/efIgp
 EWS6pfAwA3xr/B20PE5vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bh31+PV/4D4=:7OU0TaksBgdoICJpSTfGhO
 12A/hYxE+q7CyBl2Oz7k65EGAIvC2vh+nTk8o9/lBxssSLHmpJ77v+1dmGAbk3gXeFMsu69Q8
 ivmRE5hRBi/I3POL76y81y0/6039IumON29iA1w05gw5Y3x77yrefDG9yrb7hpCUNhgxF1+5F
 XphYt5h8NVAarGhJ239y0UylX10kLmMpUImo2eKriI5py+oXRpoPV3st5m8GPCHkOZ/gHjFIL
 YpDZt5yFljtXzxeVndA/gRUnqRuFak+SJEVecF0AyIMEh0NiDxMcYz+NHAJKas46JaX/+UziG
 8knpjiqgXBCxXIDZRCzyIYdUVIvYoDScEP24lPfQdar3oioQ8tSsO4bE0b+Hlp2twBFjQKODV
 CKkHZmXtiXAEQkFwjKUGbwKttt+XZiarf2aIecU3kheRFx4B420Mq7gmuMawUXQZ+m4SBcW/5
 LxnHy3ssn4BrGaTBbGoOQkyo/YqAdApAyUxWskpqq6Y3mhMmIsuEL1aDhGJfwFJ2kqzZRuQne
 Y1P8vpnoHQiN+m1v0ERxejatpXh6BSPh32nsGl1H54o7ZTcQtWGagjov9Zu0INHOdOi9x76BJ
 JeApd+RpIUwPyq6N+To11trnXdVTsmybXGyxb9dwFZ+XGWmhfoDIlDTb1LPQtdib/8vn8da69
 U7Ykq3LNmE96J0ymmTj6bYkJxTrZHKr9h94gLMcD3DftLUFmVwFRryWAXVvG4flVFRqf6PScX
 RHELtmVJECcqg80Hp1kWIk8lcAdXAsa5dyPvPw/97k4BYOjfYvhZ5iLYRtcy9hf8U+Z+zP6hL
 sa2n5s5h/1wY5JfTrtT3yIzL/fsPRenYj1TYRkTNuSrviYQT901AWCQ8bKaNbjJsT6BPHaYJX
 pdp/iQJDHaLWGQ/vjyqj6qptQrguXffKQxlYX55rQx/OiaUhmlEMP3eL7kHh6Az547Bt3MDsP
 rTvSA4JPtTnEg7O4ZF4utwHdcGFZ3ngW02oDWVLS8XiD4oa4A75gtTeFCOUqSwAAP1VpLqikZ
 9FwiqQmWweOtqhFV5DyTs2LC7M6SN1MT9THQl2fd5eq9jFq7yMxYJ4naPLTxCOO9UCCObMTh4
 OiYW9Ic0/WzjHPecM0slsJsqpJBJ4LbkOg3D4kXXXXxgeToCBOMfOXsMw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 14 Jul 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Unfortunately, this means that we no longer can rely on a shallow clon=
e:
> > There is no way of knowing just how many commits the upstream branch
> > advanced after the commit from which the PR branch branched off. So
> > let's just go with a full clone instead, and be safe rather than sorry
> > (if we have "too shallow" a situation, a commit range `@{u}..` may ver=
y
> > well include a shallow commit itself, and the output of `git show
> > --check <shallow>` is _not_ pretty).
>
> Makes sense.
>
> As long as you have pull-request base, I suspect that you could
> shallow clone the base and incrementally fetch the rest to update,
> perhaps?

Fetching into shallow clones is very expensive on the server. I want to
avoid that whenever possible.

> But I do not know if it is worth doing so for a small project like ours.

And then there's that.

Ciao,
Dscho
