Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E24671F597
	for <e@80x24.org>; Mon, 30 Jul 2018 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbeG3X2W (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 19:28:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35467 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbeG3X2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 19:28:22 -0400
Received: by mail-yw0-f193.google.com with SMTP id t18-v6so4977964ywg.2
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 14:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gODqPRoMDlxFD1KgshVijWEDMo4+NC49r6CjHi9cWvo=;
        b=bZ0Sw0UNqOqnGDwV99HZfBws2R4BMxTo2bZbG9BHfWrirZ4nxr+pr0zGDSApK3wXGN
         6cQclfx8moZ3CC83MdInDD1mcxCaR1De15d8jtgZfGTttUx2ngMHbxETqIQbztMWINjQ
         zqLtDRcaCaYs97O+zaqjXDKoZAp69B/gy2YQ2d4m8V3Rsti7y5j28+B+qyhIV7ECCZn/
         tDA3bkoDp/yZ1ek8QAPv3Ssl8wj8XqV1XMYXMo17mdI4xGeZXAbWApFq/D+l8zdyCSP8
         AZCgqTVtbbLVeNJbg5SyCsoGOM7wZQBegd22EJy7tCohk401bkxkQm8L2tv5SCUqrxQW
         AA/Q==
X-Gm-Message-State: AOUpUlF5bZHtbE3dUBRObgA429gVxDKRBH9i4C0Bu9UkL0n2x7dijYYT
        55X9DykTJ1faePYQ5L6HuQgyGNBRrHnOnU9s5LWzyA==
X-Google-Smtp-Source: AAOMgpdXLwFBowN4oloGpxQL/Owz00v6i7FFh7OTYSJ6kEK5pqdUjf2ZXNZSS0UvSNGfnNcredrwABQwjU5exgdhRaI=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr9642735ywc.70.1532987483964;
 Mon, 30 Jul 2018 14:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
 <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet>
 <20180730212606.GL9955@hank.intra.tgummerer.com>
In-Reply-To: <20180730212606.GL9955@hank.intra.tgummerer.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 30 Jul 2018 17:51:12 -0400
Message-ID: <CAPig+cSeAUWFCBEbk0m7_gmATAaVDg-fi42kq49DuGm3g0L4=Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 5:26 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 07/30, Johannes Schindelin wrote:
> > On Sun, 29 Jul 2018, Thomas Gummerer wrote:
> > > There's one more thing that I noticed here:
> > >
> > >     git range-diff --no-patches
> > >     fatal: single arg format requires a symmetric range
> > >
> > I immediately thought of testing for a leading `-` of the remaining
> > argument, but I could imagine that somebody enterprisey uses
> >
> >       git range-diff -- -my-first-attempt...-my-second-attempt
> >
> > and I do not really want to complexify the code... Ideas?
>
> Good point.  I can't really come up with a good option right now
> either.  It's not too bad, as users just typed the command, so it
> should be easy enough to see from the previous line what went wrong.

I think you can attain the desired behavior by making a final
parse_options() call with empty 'options' list after the call to
diff_setup_done(). It's pretty much a one-line fix, but can probably
be done as an incremental change rather than rerolling.
