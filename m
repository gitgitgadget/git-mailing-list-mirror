Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C331F404
	for <e@80x24.org>; Fri,  6 Apr 2018 05:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDFFRy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 01:17:54 -0400
Received: from mail-pl0-f53.google.com ([209.85.160.53]:34561 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeDFFRx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 01:17:53 -0400
Received: by mail-pl0-f53.google.com with SMTP id z5-v6so3844621pln.1
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 22:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5RTY7AHkukt6b4nGPWmjqJt6a5c4G45Zsls8VVVUAAg=;
        b=RXec8gIYBazD58aAGThkvmBHNeikUvbRJDU/NK7LJ8tGV4DIMOzMjmL/DuKHKe2tRo
         i6KzTCkWiAH9I/mJTeBTLhlcyWwquXoIOudN2zTDtjS41HjSQpiYU85BKBhrwg3VZNpb
         691bLB0OtXkh2kDmuHBVq7u6L7tWtlG4oRnB9bb0H0kEfq5nigETqRiJhV8djyQbiWCp
         i8OYmwZSw4Kww1c/+lAr2MGcTijifJF6j5F8ep3DuAZMXOTuChDvHJTdB+LkDykWF6u9
         S3fJRugxYz1xdTwR7apHmFa3QdIkrUdL5oBadQnF6xvdIiGiQBwyn8KEmchZoyf4KgKa
         FkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5RTY7AHkukt6b4nGPWmjqJt6a5c4G45Zsls8VVVUAAg=;
        b=m6IRPx5o+OS4XIc20KAxuAGr570+ECMGm4A0D5SZ9V0disjT36YN3ji716sKCmAzHb
         p77chUkeVwSfxYPl5UjR/51yIX/BNH5AvDhAkQ4SEF21KpxmXuuWR79R85HTeBLyXS5H
         HYxwLPuxS0ktcGyEr7NeS5eo50PdA+oYBe5vXWwP7rA+4HHb8qleWXk1vp2YcybI18+z
         4XKyhk5RwJt0LL1LDqaI1xRUZ3YxkJdampV54sE0PzVMI6RZBcuX3bbJ8jEmll3s+A1g
         B3pgF98L0To4TNkZ5vj/A/rLgdtT6cy642YTy0yePoihIIZicUKa0Ykx5aNFLbIqsqyH
         3O2Q==
X-Gm-Message-State: AElRT7ERy6uV5YGjxgwjfwxR2UVFWgD5PAjzgxsEfYKvWuuQmvRE24K1
        vpqEUJ8o9rZ09GRI2sJ5HTMFyw==
X-Google-Smtp-Source: AIpwx48gR0wl8A2LvzKS8XKT0e+Z0h9asG5ipaNC8GuOjCPnGeulsKLTcw3aOlTZaEGlzkd7bByPXQ==
X-Received: by 2002:a17:902:7785:: with SMTP id o5-v6mr24025148pll.356.1522991872626;
        Thu, 05 Apr 2018 22:17:52 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id n74sm21413907pfi.21.2018.04.05.22.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 22:17:51 -0700 (PDT)
Date:   Thu, 5 Apr 2018 22:17:50 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406051750.GA53143@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1522893363.git.me@ttaylorr.com>
 <20180405020040.GC8879@syl.local>
 <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSr744Y293qvgLG8jLHdNsGypkHU6QUQ-AcOyk=-JAbDw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 05, 2018 at 06:29:18PM -0400, Eric Sunshine wrote:
> On Wed, Apr 4, 2018 at 10:00 PM, Taylor Blau <me@ttaylorr.com> wrote:
> > [...]
> > In this patch, we prefer `--type=[int|bool|bool-or-int|...]` over
> > `--int`, `--bool`, and etc. This allows the aforementioned upcoming
> > patch to support querying a color value with a default via `--type=color
> > --default=....`
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
> > +A type specifier may be given as an argument to `--type` to make 'git config'
>
> In [1], you said that the argument to --type is required, so use of
> "may be given" here is ambiguous; it makes it sound as if the argument
> is optional. Perhaps rewrite something like:
>
>     The --type option requests `git config` to ...

Thanks; I agree that this is much clearer.

> Not necessarily worth a re-roll, though. (But if you do need to
> re-roll for some reason, it might make sense to combine this series
> with the --default series to make it slightly easier to review them
> together -- since the one depends upon the other -- and probably ease
> the burden on Junio slightly.)

I am re-rolling for some of the additional feedback, and have included
the above changes in it. That being the case, I think that I would like
to hold off on merging the two together, since they are separate topics
and should be merged as-such.

If this list feels differently, however, I can happily merge the two.

> > diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> > @@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
> > +test_expect_success '--no-type unsets type specifiers' '
> > +       echo "10" > expect &&
> > +       git config --type=bool --no-type core.number >actual &&
> > +       test_cmp expect actual
> > +'
>
> What does --no-type mean and why is it being tested? If this is an
> explicitly supported user-facing option, should it be documented? If
> it's not meant to be user-facing, then why are we enforcing its
> presence and behavior via a test?

I think that --no-type should be documented. It means "unset any
previously set --type=<type> or --<type>". For example, "git config
--type=bool --no-type core.var" is a synonym of "git config core.var".

This option is useful for callers that would like to overwrite scripts
that impose a specific type specifier. (For example, my mail script
invokes "git format-patch --thread $@", but I can disable threading if I
run my script with "--no-thread".)

Thanks,
Taylor
