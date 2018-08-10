Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE451F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeHKAD0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:03:26 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38568 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeHKADZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:03:25 -0400
Received: by mail-yw1-f47.google.com with SMTP id r3-v6so9649623ywc.5
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WhpPZqRnLQlD+yRmfICpSfXr2EQqJYsmdQYBK8h0Mew=;
        b=g/08M6roDmSE5zRho3sd6Si6yDWFbRXxAhdX9xm2qm2FOGZaWkYOHOldzynd6WDMNz
         qOqLHtb2z2xryk5sS8TjNL6tx/QhrKv95sNKqku3lW/hFE4W1MMFayQsLv8qRPk3lx6L
         4YtGRyYOA9xvd82Jdt79hp8/VUsYbJoU47Syc2/kzBWKmCXBuU2/8W2WcZlPainx9Eg/
         Ryzd8TAS1cJVJ0t3VI4ahYAeibShfD3wubp2L2FeyUAWuIvhMmOUQKIXtARM/feSjCSl
         Lj2zvs/OgxewsGQvRRbakqM2rkA9BSM+yPZSm1Ma2zB7ECNTWUUedPT8UpdT/iCsS0Va
         hgcA==
X-Gm-Message-State: AOUpUlE9biU9QnWUv+nDEzRoNiN6Hbu7KIysFNL2h8Vlt0InnnvGvgjk
        kDtLgfV12AtxXmQVFuR5E+9dB4Yk1ksR4UvHZRQ=
X-Google-Smtp-Source: AA+uWPzQR9N3Yb0x4NdJ0lhJStr96dxx9iRh991SmxKe/HU/iccjybDuqeKU83ia3gxvwBku1NPpGSPGhDWSLp7OjWQ=
X-Received: by 2002:a0d:e253:: with SMTP id l80-v6mr4506827ywe.131.1533936708986;
 Fri, 10 Aug 2018 14:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com>
 <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
 <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet>
 <20180730212606.GL9955@hank.intra.tgummerer.com> <CAPig+cSeAUWFCBEbk0m7_gmATAaVDg-fi42kq49DuGm3g0L4=Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808102308140.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808102308140.71@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Aug 2018 17:31:37 -0400
Message-ID: <CAPig+cQ9DcFPosPcjo6MbF_sF9DXuZQ_gZe5jxyx0vbH932sdA@mail.gmail.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between patches
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 10, 2018 at 5:12 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 30 Jul 2018, Eric Sunshine wrote:
> > I think you can attain the desired behavior by making a final
> > parse_options() call with empty 'options' list after the call to
> > diff_setup_done(). It's pretty much a one-line fix, but can probably
> > be done as an incremental change rather than rerolling.
>
> But then we would have to keep `--` in the first, and not in the second
> parse_options() call, right? We would also have to handle that `--`
> properly in the loop that calls diff_opt_parse(), I think.
> A bit more involved than just a one-line fix, but I guess I'll give it a
> try.

It's something that could easily wait until after this series lands.
After all, it's just a slightly confusing error message, not some
fundamental problem.

As for '--', I'll have to go back and look at the code. I thought I
had thought it all through at the time I made the suggestion, but my
brain needs a refresh by now.
