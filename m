Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E15FA1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfHPWIx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:08:53 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42742 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbfHPWIw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:08:52 -0400
Received: by mail-vk1-f195.google.com with SMTP id 130so1387650vkn.9
        for <git@vger.kernel.org>; Fri, 16 Aug 2019 15:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9pw+q+Zm35QjUaSE6qpC4jou26xHJ4SK9LoHiOJ1HI=;
        b=ogMi7C/aWroQzVCDTRJoM0nBG2MVtVivTYC2/5cCoOUnCCFCvj7+mkAKlyMTIX/iRr
         F0mp9CtBsg+WUwxVEZSScLWo3/Euum9fOZF6YGZv5Ve3dlVsE+WuVSRN3rfkW/ORsnMG
         f9/wFwGt1mgYXCkz7Dw1GHjSRGW7GmxONKBh+sqZTfeaFcKeX3B+IYnXMM9vhoc4spBu
         vUpQ7oUXj9IK4sgrckr4ESlhj2KKjsuct51VqnCk7l2LuIQz9C/YIuSSFS7CYv6abrSd
         fBZ0OaFmpbL8s5mkmnObvE5q4V8Qkv6AcLSc0qoqREubU3SbrjM+bbT23tHjV5ms/mAY
         sN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9pw+q+Zm35QjUaSE6qpC4jou26xHJ4SK9LoHiOJ1HI=;
        b=cFs/DFm9Ooxc4Tfa4U8KQ2vXP5C3Tph+aTCvo6/ByDUhdbGBoSP14iQJImKwLLKO/E
         m/3AfXIfaZEbzhylMfS7z4V9UM1+7M6VXppFWceRR234BWYTtXsBgxrnrA2qUBvZ78OY
         hOIcERAjxTgnP1Vvj4azq91hZuEb5nGo3Ebgo9rJlqtKM+OkePy8wDiv4BFbKCua/n8D
         +WSwjielpqT0eF2IPE/coTiSlIja2bTW1hpho5g5ehprcrAqn43N+N7GBQfbc8Uzngc2
         3yooj/A8krp55QmuR/rw9YVSGskBDKOb0e2OEGHnm/28Da+oOg7J4+raPQeqb4q7g2UA
         6stg==
X-Gm-Message-State: APjAAAUbf+DqZ+gwx9pDcE8GhulI+h3hLbAj1HyUulCYufdButqnaj5D
        cWeZrRWlQHxJpzx7j39wqQ/47cCDASJZMLbaG3M=
X-Google-Smtp-Source: APXvYqynVy5GkYj6WOoaojNk/rlQfTWaDTn5OumVozF/7nqBN6FA4z+SujKyEDwkRI7CkS7CqtVyxFqfLJjXrEBjBFw=
X-Received: by 2002:ac5:c901:: with SMTP id t1mr4680175vkl.27.1565993331672;
 Fri, 16 Aug 2019 15:08:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190726155258.28561-1-newren@gmail.com> <20190815214053.16594-1-newren@gmail.com>
 <20190815214053.16594-24-newren@gmail.com> <xmqqd0h428ig.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0h428ig.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:08:40 -0700
Message-ID: <CABPp-BFE+EX9HtAqN7CeBNHDTObGVw6nT8=+xxAASPJPXAq2=g@mail.gmail.com>
Subject: Re: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 16, 2019 at 12:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > There are lots of options that callers can set, yet most have a limited
> > range of valid values, some options are meant for output (e.g.
> > opt->obuf, which is expected to start empty), and callers are expected
> > to not set opt->priv.  Add several sanity checks to ensure callers
> > provide sane values.
> > ...
>
> The change to the struct does not seem to have much with the above
> rationale.

If the only possible values are 0 and 1, I can either add assertions
to check that at run time, or make the compiler check it for us by
confining its value to a single bit.  A compile-time check seems more
robust...

> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index 978847e672..d201ee80fb 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -27,7 +27,7 @@ struct merge_options {
> >       } detect_directory_renames;
> >       int rename_limit;
> >       int rename_score;
> > -     int show_rename_progress;
> > +     int show_rename_progress : 1;
>
> And a one-bit wide bitfield that is signed is always an iffy idea.

...assuming of course I don't mess it up like this, not noticing that
it's an int that needs to be changed to an unsigned.  I'll fix this
up.

But the fact that you flagged the struct change -- would you prefer
some commit message explanation of how it's related, or was it more
the case that you felt it was a different kind of change and wanted it
split out into a separate patch?  I'm suspecting the former but am not
quite sure.
