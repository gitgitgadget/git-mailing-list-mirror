Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDDC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACAB9610CB
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 05:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhDCFPc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 01:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDCFPb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 01:15:31 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8840C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 22:15:29 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z3so4377935ioc.8
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 22:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1y64/tt8ObSX9SrzxGdeTwnzfhOv6n/ihdjm7q5/Clo=;
        b=S6y1ZmWP4ElrvrFLi31sKv2z2c/3oWTO4jW12d9BrzP+BMZsHO1d5V/Dw803u8rqPS
         KyZRO2WWm+KNlQ0xowsqHgATqd6qQtusla3dygQuh9SlAdahK23K7pB2ZEzh8L2PpBjB
         +GO7bRRz4CAfi0eWKjtsem9vc1On3o43pAF8+SPqyWlX8Iqyk/eGO7fX0zOLYeXfP8cU
         lyxb8yWPnYNSrj6XYuHL19qh2euuqoKgtGQZM/dih5VxC3qMschaH1LT+BD0xxgGYl3u
         krcp8sjp0xes9teGGDHbBa0639QJlBsXj+UvE2f7a12xoaLP4q772cg7b22toTcDsKCz
         c4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1y64/tt8ObSX9SrzxGdeTwnzfhOv6n/ihdjm7q5/Clo=;
        b=OEAgHH3B3OuK+EUDlf5KjOOFAzRRBdLY1SK3FB+QgCCEwKR8E00GUF7ZdblPMHW3j8
         gRvFbgSD3hs0EuFLz7ndnIpLgL0DH4cpAct5WLUxh/rxXRR6ytP6wEeGPFnWM3ZowEJc
         JPz/KWfgMu/6OO7Ucobzp7uPxaQb3Kb+htrF39xUUdcRaEwNybepzbzdSIaHdaoRfUv9
         1UbXteGu5TyWLd4gGsl3TGy4s8vNPx2pPa2vLPHLkcexs6RRlfqy3E0Eooq8/f67yePH
         TkCBZYDBkfbzPex3elxsXrvrcp7zK4+G6iyDEx6VhMoNPPTglL+9G4gRT98BGNwc1483
         F8KA==
X-Gm-Message-State: AOAM530Uf7cMp+mIdxYjKm05P0csIqD1uDnttvfDYlVl5+byLauJKwTw
        tal5VqRuJiZcAgAq5qNOPuzX2wiaHMqieb9gbE5QTp176I043xTL
X-Google-Smtp-Source: ABdhPJw+V/eGq/2RpIbfV3WxFJq/HZLgiBRRIQvMWZLEvSqWzGuNF5BjWLABo5NIriMNu+v55k2lyVGdCnra2Rc4B3s=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr13476743iom.68.1617426929269;
 Fri, 02 Apr 2021 22:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqq35w82qvu.fsf@gitster.g>
 <CAOLTT8TaUkfdOhD4+P=VVxuy3dPCaf4KNC8+1hBQnxSjpvO4HQ@mail.gmail.com> <xmqqtuoo0z1l.fsf@gitster.g>
In-Reply-To: <xmqqtuoo0z1l.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 3 Apr 2021 13:15:17 +0800
Message-ID: <CAOLTT8Q8J-5xuEfdx5VKyB1WrGjwngdiyPeUEuD8QMnFfSE5mA@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=883=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=8812:31=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Little bug, Change it like this will work:
> >
> >         } else if (conf->command) {
> >                 strbuf_addstr(&cmd, conf->command);
> > -               strvec_push(&cp.args, cmd.buf);
> >                 if (arg)
> >                         strbuf_replace(&cmd, TRAILER_ARG_STRING, arg);
> > +               strvec_push(&cp.args, cmd.buf);
> >         }
>
> It means the coverage of the test included in this patch was not
> sufficient, right?
>

Indeed, I might have to think what tests need to be added to the ".cmd".

> I queued this separately from the "commit --trailer" topic in
> tonight's pushout, but it may make sense to queue this step
> immediately on top of the "commit --trailer" patch.
>

Maybe I can rebase this "trailer .cmd" to "master" which already have
include "commit --trailer" later, this will cover "commit --trailer" tests.

> In any case, I suspect we would not hear from Christian right away
> due to timezone differences, so perhaps let this v6 simmer on the
> list, and then hopefully update the documentation part with his
> input.
>

Yes, it's worth waiting patiently,

> Thanks.

Thanks.
