Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861DC1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfBFLyv (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:54:51 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:39066 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfBFLyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:54:51 -0500
Received: by mail-wr1-f41.google.com with SMTP id t27so7210290wra.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 03:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WgLMOumfOT+hmvr4wb3hV7UmRlBmgYcBjaT8sIS1VTM=;
        b=TrmqFz9tXVso5QdwcE94TcD3Sa4qcegT+nGneDqhh2yBIa5c1awJUglyihZ4tXmULb
         EtU1RxUW21uRnplYu6t/swFt4CJuGFPE3TBkWZb2ohNMeRxNg1DrIWMtnoRuMxSbKBss
         kPxRISvOZ9XBMXYPN+DqD2481eojxLn//FAy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WgLMOumfOT+hmvr4wb3hV7UmRlBmgYcBjaT8sIS1VTM=;
        b=mqT6GiFM0b1JESawJ7Lj0RFpnOH8r6REJUQEcMWcf+vlgNoTs0t4TEoFWRmJIfY0Gr
         AbpVUMo+M+wYfioDvJYE0blf2zET81wZpOc7Jl1IkUVxO7HfF8yTCB3COM82+Oii0RHJ
         gXvwadIC3e2ae+dC+74LUMI3Lgto65nIuo2c/GRj5VCG/oIhWPTLty1XIIbxpdFAJMGj
         mSZKB0cUhaoiWRhXLTYDbAdIBlPvy+fQlViDRMMdcHr40Sd19URMcOC5icIeXniMTvUD
         P37dYmuHYy0Zc80+oiP62+0RYZ86l/6QU6yPO9tKWL/kYW0wstSyIVlTZN4gu53MUH5D
         l+Vw==
X-Gm-Message-State: AHQUAubLW1T3JSIOs1O0PxHchzoduj1CHV5DkHXgZePH/kQZqCLzRS0u
        finKqaL71KI+VQdUvQlr+iSmYSMzVC79vF8G/Jl2rA==
X-Google-Smtp-Source: AHgI3IZ7hewt6DS6YGfGiovjGPZvKrlKtY+7Edki3LftoGkp8NPjigSW4ZSBuoW3Zw4EYKM6yZeC8FtW43eaESqXj0o=
X-Received: by 2002:a5d:6803:: with SMTP id w3mr7844357wru.272.1549454089011;
 Wed, 06 Feb 2019 03:54:49 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.QRO.7.76.6.1902061004110.41@tvgsbejvaqbjf.bet> <20190206111111.GK10587@szeder.dev>
In-Reply-To: <20190206111111.GK10587@szeder.dev>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 6 Feb 2019 11:54:38 +0000
Message-ID: <CAE5ih7_s+GZo10DMkhbkfoRPGovHZZo8q3qBaPKq8_uDdxrX0Q@mail.gmail.com>
Subject: Re: Weird (seemingly flakey) p4 breakage in t9833
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 6 Feb 2019 at 11:11, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
>
> On Wed, Feb 06, 2019 at 11:33:21AM +0100, Johannes Schindelin wrote:
> > Hi Luke,
> >
> > in a private Azure Pipeline (sorry...) I noticed an intermittent proble=
m
> > in the p4 tests on osx-gcc.
> >
> > I would point you to a public log, but the Azure Pipelines support *jus=
t*
> > made it to next, so I *just* set up a public one targeting anything els=
e
> > than my `vsts-ci` branch, at
> > https://dev.azure.com/gitgitgadget/git/_build/index?definitionId=3D6. A=
nd
> > those builds do not show that problem, so it must be a flakey test.
> >
> > But maybe you can spot anything familiar from the log?

I think you're right - it's 'git operation with expired ticket'.

I wonder if we could make a faked-up Perforce client which returned
the correct error data - then it wouldn't need to wait at all.

Or we could just remove it (or make it optional based on an
environment variable).

Let me know which you think is best and I'll put together a patch.

Luke
