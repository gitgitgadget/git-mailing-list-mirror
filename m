Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 129521F597
	for <e@80x24.org>; Mon, 23 Jul 2018 19:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbeGWVBr (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:01:47 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40659 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbeGWVBr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:01:47 -0400
Received: by mail-yw0-f194.google.com with SMTP id z143-v6so681885ywa.7
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 12:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/gmHWWFc2sWpW/GjZdLwnmvFf7y8K+/n3QIF7zSK1g=;
        b=FyTgMd8/pNyUAlwNpEDVJ4WcbEvgA1Rsan2NfqmnyiybEfRFsg53iD7k85+3qlWTB8
         TwcHn8X1EVgCGAZeQzmogM6jksCf46w/LmV9tVl1FlmAKHOlq0tJk9oFjzGcHF6n22my
         mBPvUOpK+JYIUVZfhUz2dNCVJmHYvEYOby8AtR1RJoLJbBC0w6GLuDHUUZNzn+s5EH7O
         F3CMpv1GIlGGCxk5ME08iCxwyJJ7d/H4ythT0Bb+kLVWxw5R73m9ctZ7wP0y39JYMGaS
         FL1ZG/zyWTaKGKroQ2aXxiaIdjxc+IGrUU1ytRYFLYg3Bw22nb8anJtGWMlsjMmwLfRN
         XgXw==
X-Gm-Message-State: AOUpUlHwRS8SueqrrC+pxaqlQRKy6jqcCzda4csiwCW40mO24iTujk1T
        yXb+xu2pMCaYsI4EagAINbbK3fArHoC57gQKqGc=
X-Google-Smtp-Source: AAOMgpeHxhXevMhL0wDVTsYwy2U1mVLY2Z6TUkYlsKVuFzTiK2mZnVyeKpKqa/iiSpcR9ewYOK0QH7d2o8MCtWOf/Z0=
X-Received: by 2002:a0d:c105:: with SMTP id c5-v6mr7437083ywd.131.1532375940882;
 Mon, 23 Jul 2018 12:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-11-sunshine@sunshineco.com> <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
In-Reply-To: <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 15:58:49 -0400
Message-ID: <CAPig+cT_7eDyY6xGev4=dwpJnKufpMevO-+hGnXVt4ec0xhEiA@mail.gmail.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff
 in cover letter
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 12:28 PM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> > index f8a061794d..e7f404be3d 100644
> > --- a/Documentation/git-format-patch.txt
> > +++ b/Documentation/git-format-patch.txt
> > @@ -24,6 +24,7 @@ SYNOPSIS
> >                    [--to=<email>] [--cc=<email>]
> >                    [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
> >                    [--interdiff=<previous>]
> > +                  [--range-diff=<previous>]
>
> I wonder if people will use both --interdiff=<rev> and
> --range-diff=<rev> often enough to justify a shortcut
> "--all-kinds-of-diff=<rev>" so that we don't have to type <previous>
> twice. But I guess we don't have to worry about this right now.

My original thought was that --interdiff and --range-diff would be
mutually exclusive, however, I quickly realized that some people might
like to use both options together since each format has its strengths
and weaknesses. (I've used both types of diffs together when preparing
rerolls of my own series and found that, together, they provided a
better picture of the reroll than either would have alone.)

Based upon experience on this mailing list, I'd guess that most people
would use only one or the other, though that doesn't speak for other
projects. And, as you note, it's something that can be added later if
warranted (plus, this series is already long and I'd like to avoid
making it longer for something like this whose value is only
speculative).
