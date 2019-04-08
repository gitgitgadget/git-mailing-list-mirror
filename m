Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C1E20248
	for <e@80x24.org>; Mon,  8 Apr 2019 09:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDHJsg (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 05:48:36 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42575 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfDHJsg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 05:48:36 -0400
Received: by mail-qk1-f194.google.com with SMTP id b74so7520389qkg.9
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4rGtKn/T8kBq2dLpEwFaTycxJudsDf1qoSvHrYqV0E=;
        b=oWXlFmNBx+zS6I5wXUxtMw6YnWa75Err5OZK/UPrSB5oabqSLnrQ0XCQ45HLUBweld
         EHC1gdyBcKt0GeoSz9CGP8Q+2dXJlV9g6tAekdeH3kkYdJuoN6YZFhwexT6/JRYWSs80
         6TCvicHPpitiDwV02I+D/mARhgxQPwK4BXt9T4J6zrrzb1/f248ue8R33aE9q4l4j0X7
         ilDnoF3HSUwUxe8tKwRjaEzyPIOXFcWricMfXku2gRHa5jQE5YO0pFL6JKppNsf64lio
         N+jhW71BRYnMQ04YzYIIxMJDOG5eeZEfTxU2ffWFgE9yX+vKc5EHa+gZufOVhbNmQTyH
         kQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4rGtKn/T8kBq2dLpEwFaTycxJudsDf1qoSvHrYqV0E=;
        b=XoJvP08A/jCxwlg39o8fpYC0+blcDpVqsU/Bl+v61pnZUUyJEXeYLbx8jRcz6dz9Ji
         DX2h/kqj/63gx3EA55XrHFI8lcBG7enqn2BGonHMbm9YQOXAF4Q1gXbh0XV50y3RN5Xp
         TPv9nghO7IoqIXclq2Mvb4Lvwq1/NQrH9gL946GwXgf237sMY67U58qL9L+YWLxodObt
         2Xbs49aIfWkRKRTBb03ONTuBHnDoJCmO8QaKCYN1Z4yJhrGzhpjcB+iGYFUXIs3L7Bht
         6EE4j/KaFC7kfwzM7kpTSgIS6dO3DBdm/YkmwMBopvIMv3qqMadYvKBMBRALI9son+tL
         q0GA==
X-Gm-Message-State: APjAAAUVN7Wi/e93IgEO4zSPN5feVtl9Igr81VYjOS67AmOmdVEAqzZi
        vvP75oaCuHEMMOP1r3uPmh1J1Ov1/34ZCxL0+f0=
X-Google-Smtp-Source: APXvYqzUJo3Y29RDXi9TC5x1crWI2bkwKIm2OD2p7r4j7BRKgLek52fYlR/hjh24Z9/DR2OlCb9anNGRZf+YPZ0xBGk=
X-Received: by 2002:ae9:eb0b:: with SMTP id b11mr21597917qkg.214.1554716915193;
 Mon, 08 Apr 2019 02:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190407214635.12984-1-michael@platin.gs> <8736mtqy9n.fsf@fencepost.gnu.org>
In-Reply-To: <8736mtqy9n.fsf@fencepost.gnu.org>
From:   Michael Platings <michael@platin.gs>
Date:   Mon, 8 Apr 2019 11:48:23 +0200
Message-ID: <CAJDYR9TXL_9JpWvNv9ahK1aYV4isduHhvzvobCJ16q7LWhPRcA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] RFC blame: use a fingerprint heuristic to match
 ignored lines
To:     David Kastrup <dak@gnu.org>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,
You also get an out-of-memory error with the patch Barret posted at
the start of this thread.
I'm sorry you interpreted my message as declaring it somebody else's
problem, that definitely wasn't my intent. I merely ran out of time to
investigate further and I figure Barret is going to be interested in
this issue and would prefer that I let him know sooner rather than
later.
-Michael
(resending in plain text, sorry for the spam again)

On Sun, 7 Apr 2019 at 23:52, David Kastrup <dak@gnu.org> wrote:
>
> michael@platin.gs writes:
>
> > From: Michael Platings <michael@platin.gs>
> >
> > Hi Barret,
> > This is the updated fuzzy matching algorithm, sorry for the delay. It does
> > highlight a bug in the calculation for the number of lines ("int nr_parent_lines
> >  = e->num_lines - delta;") - if you apply the patch, build it, then try to
> > ./git blame --ignore-rev <the patch commit ID> blame.c then you'll get a segfault
> > because nr_parent_lines is a negative number. I haven't had time to investigate further
> > but I have confirmed that the bug is not due to my patch.
>
> If you segfault with the patch and don't segfault with the patch, there
> is not much of a point in declaring this "somebody else's problem", is
> there?  It has to be fixed anyway in order to make the patch get in.
>
> Or am I fundamentally misunderstanding something here?
>
> --
> David Kastrup
