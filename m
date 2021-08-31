Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FB9C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FFD60FE8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 01:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhHaBEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 21:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhHaBEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 21:04:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70206C061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:03:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c206so11105519ybb.12
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 18:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a5k/9aq1gbKp0voc0097da4wZRfbFZ42YLJRaxcPsTA=;
        b=mG/TezFxr33Of1RQoIRVtERZuicj+0v9QdWCLsDzOPDSH69fFgoO3AEEVpCn2j2N0z
         Mt3bWbNFZdPkxE/U5pzhn6kqAYnuaZBZw52Z1VK5KC4VsHZ7nJU74Xfu0QZdiYnz+Ngt
         FdqXu6udtmkhboqIfuwWcc4ylFENgMl+0Wt++YXhwoeky/OFQtSL+N51xDy9NMFAzz3s
         OJbGTe9pa2RBdutrfPNht3YgclQBqvQhtZlrfvztXXA4kmbo9MTmLlxDwEYdyTxSdGjb
         unlxP7+2qjT9TRWoGdt0lt48XXCzNdB+/0Md1hrr6n9AQezQk6EQMg3NOnQrqOBp+PEh
         rNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a5k/9aq1gbKp0voc0097da4wZRfbFZ42YLJRaxcPsTA=;
        b=evyOBaHZY1Ku8ekuYz2gY2IYk9pqZynSJUT8A2r8ttfJX9EJFXgn0gsmIeN0qKbZYS
         TM/xi+oTY+3L+OzDNaexEQEOoDmbFhESnqtxYQia9N2unYcbZ4UZerDtyEHDiwcUoHCr
         jZH075UlrOun/Is4pHH4pCkVwkpPrwzxYEztefzwxudhuhH6vFtAuAtxPIaKYbz2Bc6X
         RvFOTuYVBS0ylsZSxRdgQCs7+KMktv4aNavDYBJ2EDAYQb59be49HUI+ljhAQGxfJUz7
         yoXFG35KeVN/wOfw989U7XOuEFPvZqMnm+3qk/nDvsUL17x52NuLbQEq9sp7eI60nPXy
         1+lA==
X-Gm-Message-State: AOAM533DzaxfsZ3W1nl/oGOlFCT7ko3vfuQDwR6cx3Ppx336ZuMJLia9
        ODBsiua+qU/VfZZNFRmfELAPJUGrxc2Q1fQmPtU=
X-Google-Smtp-Source: ABdhPJw5sp4MvsWZrJnD5exeDolZpnbzLinchVvytD1nn0D6XRiV1QiP1/pbdMk48hSvwXc1AM6c02DmrUtpJypQe/M=
X-Received: by 2002:a25:bdc5:: with SMTP id g5mr26790007ybk.403.1630371820420;
 Mon, 30 Aug 2021 18:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210822161325.22038-1-worldhello.net@gmail.com>
 <xmqqsfyzq1wq.fsf@gitster.g> <nycvar.QRO.7.76.6.2108241126190.55@tvgsbejvaqbjf.bet>
 <3020682.V8qLCztWNM@cayenne>
In-Reply-To: <3020682.V8qLCztWNM@cayenne>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 31 Aug 2021 09:03:28 +0800
Message-ID: <CANYiYbGwOqm=BLVd-7zFD+5W0_jGaz2yCN0HoQHYnr7wLQSd+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] ci: new github-action for git-l10n code review
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <hello@brighterdan.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 4:49 AM Jean-No=C3=ABl AVILA <jn.avila@free.fr> wro=
te:
>
> Le mardi 24 ao=C3=BBt 2021, 11:27:44 CEST Johannes Schindelin a =C3=A9cri=
t :
> >
> > The biggest problem is that there are forks of `git-l10n/git-po` that
> > accept PRs in their own right. That is what I tried to address by using
> > just the repository name, without the org/user prefix.
> >
> > Ciao,
> > Dscho
> >
>
> Well, I'm in this case, plus my repo is a fork of git/git.
>
> Would it not possible to formally require the presence of a "dumb" secret=
 to run this rule?
>

It is not supported to use secrets/env in if condition. See this post:

    https://github.community/t/jobs-job-id-if-does-not-work-with-env-secret=
s/16928

In patch v3, will check both repo name and branch names. See:

    https://lore.kernel.org/git/20210827071320.14183-1-worldhello.net@gmail=
.com/

--
Jiang Xin
