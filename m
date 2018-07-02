Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16ECA1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 19:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753359AbeGBTHd (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 15:07:33 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38208 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752842AbeGBTHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 15:07:32 -0400
Received: by mail-yw0-f196.google.com with SMTP id r3-v6so366975ywc.5
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=14zD5gLPQ2J8Hn9cl6oXhNilloVSUpBSVXFv/W1beZ0=;
        b=Tr19WqNOD1Bi+jZBtOOWd4RPCpBpNp/MOqHu2RZlcgajJRd0+sGcyTKtyizJ4deWMM
         cxrCfYdE1mwE0pevyzHj8w19hHJS8kVQKKYw7zqSkTMgnZJbbQdCZr93N5hAIFdzc8ye
         TmzNyGPVCBUN1iyYN6stp8CmcxOaOHRYf0b6Yi+BLQgzltBPNfYjmkdNXKiE9K9GFQYs
         t1bYHbi5j+xwQGu5ijflI33FFvKct/HGgPFMKabXyJOn3UrQatfW3cQXgAy8OOaZYDZq
         Dck5MjHF//rW1eVU5VgWW+y0aCU8JseH4Ytw3Ay2vyLx+xKli6SxZg0OrzpYKZKFLTQ5
         UiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=14zD5gLPQ2J8Hn9cl6oXhNilloVSUpBSVXFv/W1beZ0=;
        b=s/9LlAiAXQal5vlyoWmnz4RhAaPAodWHmYFzYnhgCMIGqIrTm6ApBt4fqXJPgl7byA
         XE3fxQvf3smr7zb5TCw5cAQv4DpVDIzlvCSWWfKZvPoOTZdeDhfgn7kaOyhkPVNswEaF
         Zxt6wHXb7aNeQqk2bBb4iV4nyTWgpjT0K0qbyDcgjko/dUQyao+k5R4cvRE/EAxIc46o
         KoXjRvt1H6z3t9uNv0WAJP6NQ8RrBo3Ds5Rzzs0BebRNzP2YjvqG2e5EL+7/5OoHbzzG
         hO204X4NXjJmnTnJQBVK92pxm6dTqu9OuGWZMuwZvfFJdpv3MndphIxQpkQUlIOWxWOd
         5N3Q==
X-Gm-Message-State: APt69E2eOap/JTni33TDbENMafHk8xGM1APUCsDw7pb0IaYyj48cm/Z6
        rz2D5IDg2L1bdcZ9Bl2umzC8Jpl5b9iwLuO4XHy40A==
X-Google-Smtp-Source: AAOMgpeYbbg2vH2gKyadZJxIuuPWCMz5THy2ppHl9SWfOaxkLnLxwb2mWeVZutTLMVfXmguzi7BH3wEb9KQYKWyvGDM=
X-Received: by 2002:a81:c743:: with SMTP id i3-v6mr67914ywl.421.1530557957292;
 Mon, 02 Jul 2018 11:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180622015725.219575-1-sbeller@google.com> <20180629001958.85143-1-sbeller@google.com>
 <20180629001958.85143-10-sbeller@google.com> <20180702173614.GD246956@google.com>
In-Reply-To: <20180702173614.GD246956@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 11:59:06 -0700
Message-ID: <CAGZ79kasAqE+=7ciVrdjoRdu0UFjVBr8Ma502nw+3hZL=ebXYQ@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] diff.c: add white space mode to move detection
 that allows indent changes
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 10:36 AM Brandon Williams <bmwill@google.com> wrote:
>
> On 06/28, Stefan Beller wrote:
> > The option of --color-moved has proven to be useful as observed on the
> > mailing list. However when refactoring sometimes the indentation changes,
> > for example when partitioning a functions into smaller helper functions
> > the code usually mostly moved around except for a decrease in indentation.
> >
> > To just review the moved code ignoring the change in indentation, a mode
> > to ignore spaces in the move detection as implemented in a previous patch
> > would be enough.  However the whole move coloring as motivated in commit
> > 2e2d5ac (diff.c: color moved lines differently, 2017-06-30), brought
> > up the notion of the reviewer being able to trust the move of a "block".
> >
> > As there are languages such as python, which depend on proper relative
> > indentation for the control flow of the program, ignoring any white space
> > change in a block would not uphold the promises of 2e2d5ac that allows
> > reviewers to pay less attention to the inside of a block, as inside
> > the reviewer wants to assume the same program flow.
> >
> > This new mode of white space ignorance will take this into account and will
> > only allow the same white space changes per line in each block. This patch
> > even allows only for the same change at the beginning of the lines.
> >
> > As this is a white space mode, it is made exclusive to other white space
> > modes in the move detection.
> >
> > This patch brings some challenges, related to the detection of blocks.
> > We need a white net the catch the possible moved lines, but then need to
>
> s/white/wide/

oops. will fix.

>
> > +
> > +/**
> > + * The struct ws_delta holds white space differences between moved lines, i.e.
> > + * between '+' and '-' lines that have been detected to be a move.
> > + * The string contains the difference in leading white spaces, before the
> > + * rest of the line is compared using the white space config for move
> > + * coloring. The current_longer indicates if the first string in the
> > + * comparision is longer than the second.
> > + */
> > +struct ws_delta {
> > +     char *string;
> > +     unsigned int current_longer : 1;
> >  };
> > +#define WS_DELTA_INIT { NULL, 0 }
> > +
> > +static int compute_ws_delta(const struct emitted_diff_symbol *a,
> > +                          const struct emitted_diff_symbol *b,
> > +                          struct ws_delta *out)
> > +{
> > +     const struct emitted_diff_symbol *longer =  a->len > b->len ? a : b;
> > +     const struct emitted_diff_symbol *shorter = a->len > b->len ? b : a;
> > +     int d = longer->len - shorter->len;
> > +
> > +     out->string = xmemdupz(longer->line, d);
> > +     out->current_longer = (a == longer);
> > +
> > +     return !strncmp(longer->line + d, shorter->line, shorter->len);
> > +}
>
> I'm having a harder time understanding this block.  This is used to fill
> a ws_delta struct by calculating the whitespace delta between two lines.

yes.

> If that is the case then why doesn't this function verify that the first
> 'd' characters in the longer line are indeed whitespace?

This was done implicitly before as compute_ws_delta is called only
on two lines that are "equal with XDF_IGNORE_WHITESPACE".

> Also, maybe
> this is just because I'm not as familiar with the move detection code,
> but how would the whitespace detection handle a line being moved from
> being indented with tabs to spaces or vice versa?  Is this something
> already handled and not an issue?

The ws_delta stores the string (of whitespaces) that the 'shorter string'
needs to be prefixed with to create the 'longer string.
(I chose 'shorter' and 'longer' as any of them can be '+' or '-' lines)

Then later when we compare the strings (the current line in
consideration and strings that we put in hashmaps that we
know are moved lines) in cmp_in_block_with_wsd,
we (should) take this white space delta into account.

I just realize that there we do not check for the tab/space replacement
as there we would need to compare the ws_delta string to the beginning
of the 'longer' string there.

I'll add a test for the space/tab replacement as well.

Thanks,
Stefan
