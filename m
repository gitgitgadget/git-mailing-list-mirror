Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C578B1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 14:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfGAOjJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 10:39:09 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37802 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfGAOjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 10:39:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id u141so48000ywe.4
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 07:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+J8kcg0lalf3+TWEa9Mxa05i9+4Qxqq3U0Fi1cCtmCE=;
        b=sFAjHgo41E23rZRoDy7JLRiJ7bbsMLK3I4YkfAoolpvebmOeDg/8puhU81YswNVL/r
         JcaFtduhGzDudMXLWIoGH4wdGxVF75YhhXkDukUpZYvUF/mQg/PdGmo8NF4xrtrAC3UA
         0Vxv0Lujy58LsL+29/q3NLdN3mwqAaKhGYbD1zU2DN26yR3WI8W7mc/2HXXfymt5nDf8
         m/o+Ee1krdhBoIQOtswgi9rJGMlc6ieT6f/Uopwq398jSIxbKBofptM7cgnZQJtqRUQA
         ilCao7p2I+1gJBz9f12g7lesxRj6+PBhE1EvTngEzMTmpGqRk80HKpe8yO1613eMvxJL
         fsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+J8kcg0lalf3+TWEa9Mxa05i9+4Qxqq3U0Fi1cCtmCE=;
        b=M/Hmb8AeHGzlJKVBe78gvUZSJq4/Eb6IOPa/wfN1YV7QUhZ73LCRXjaJPqJ3o8M7KO
         XiiqpQC2hNC5msVwqUSYKMVdUnhVKCfO0egdOvX4NFthFAnCY2YCll4IMK99/Ez/QS80
         c2fbdEDs2o1ZJhk/jK6wJ2qFe2h9csuFY1x2eAJdslLQZa2imMdyRmrLbOpEJRhAZisK
         UU3AFyd2ENQBiRVnTmWVwSRr4vb2yLFqVZMCPyWnOZIHxbgfmGOaX/pvCySKbGis1e+v
         qeEXEa31uCbIPZq9zWPkFjRG5aljsGG/Mk5TKiS2Is3lRHnBWSVSykZ6kecdbq1/8Ne3
         xoSw==
X-Gm-Message-State: APjAAAVDtkUoOgIMMfrE2ORbAYdgY9znEnMMogtniRuCu5K6V1uikemx
        WMl1IqNGywcf1D5TeNsXH49ciQ==
X-Google-Smtp-Source: APXvYqxwr/AAChrp7Y1258Hw1a/7pLCCV805/SdDQOarpsLuRgrfhce1vvi6x5dW1sSpB4aM2zAo5A==
X-Received: by 2002:a81:a1cb:: with SMTP id y194mr15831447ywg.104.1561991948537;
        Mon, 01 Jul 2019 07:39:08 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:6841:343f:64f7:7ef1])
        by smtp.gmail.com with ESMTPSA id p185sm2502415ywb.92.2019.07.01.07.39.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:39:07 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:39:02 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] ref-filter.c: find disjoint pattern prefixes
Message-ID: <20190701143759.GA38109@TaylorsMBP5715.attlocal.net>
References: <cover.1561588479.git.me@ttaylorr.com>
 <e41db267f7b7086126e9fd3fd5b1a02e38c8c077.1561588479.git.me@ttaylorr.com>
 <CA+P7+xqQv4UZMy7fEHnGHejU6nvhVKgkSruXdmW-akqUG1TLKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xqQv4UZMy7fEHnGHejU6nvhVKgkSruXdmW-akqUG1TLKA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Wed, Jun 26, 2019 at 05:37:42PM -0700, Jacob Keller wrote:
> [ ... ]
>
> > Instead, we want to partition the patterns into disjoint sets, where we
> > know that no ref will be matched by any two patterns in different sets.
> > In the above, these are:
> >
> >   - {'refs/heads/a/*', 'refs/heads/a/b/c'}, and
> >   - {'refs/tags/v1.0.0'}
>
> Is this disjoint set calculation already existing, or did you have to
> add it in this patch?

Both the disjoint set calculation and the prefixing procedure are new in
this patch. But, we're never actually computing this disjoint set
explicitly, rather, we build it up implicitly while computing what will
become the longest prefixes of each subset.

> >   4. Otherwise, recurse on step (3) with the slice of the list
> >      corresponding to our current prefix (i.e., the subset of patterns
> >      that have our prefix as a literal string prefix.)
> >
> > This algorithm is 'O(kn + n log(n))', where 'k' is max(len(pattern)) for
> > each pattern in the list, and 'n' is len(patterns).
> >
>
> ok, so if we can assume that k is some relatively small constant
> number (since the maximum pattern length isn't likely to grow without
> bounds), this is O(n*log(n)) on the number of patterns, so we don't
> even approach n^2 even when we are given a large number of patterns.
> Nice!
>
> > By discovering this set of interesting patterns, we reduce the runtime
> > of multi-pattern 'git for-each-ref' (and other ref traversals) from
> > O(N) to O(n log(N)), where 'N' is the total number of packed references.
>
> So here, n is the number of patterns still? This seems like a pretty
> significant gane when we have a large number of packed references.

Yes, 'n' is the number of patterns given. For e.g., the invocation

  $ git for-each-ref 'refs/heads/*' 'refs/tags/*'

has 'n = 2', and 'N' is unknown. The asymptotics here are really
comparing the case where we previously didn't make any effort to compute
good queries, and resorted to a linear scan of all packed references,
compared to now where we have at most one query per pattern, resulting
in a logarithmic-time scan of .git/packed-refs.

> >
> > Running 'git for-each-ref refs/tags/a refs/tags/b' on a repository with
> > 10,000,000 refs in 'refs/tags/huge-N', my best-of-five times drop from:
> >
> >   real    0m5.805s
> >   user    0m5.188s
> >   sys     0m0.468s
> >
> > to:
> >
> >   real    0m0.001s
> >   user    0m0.000s
> >   sys     0m0.000s
> >
>
> That's a pretty significant decrease!

Yes, it's quite good here, but it's designed to be that way ;-). Like I
note below, the real world speed-ups aren't quite as remarkable, but
it's not uncommon for us at GitHub to have a repository of the above
shape in terms of the number of references.

So, it's an increase almost no matter where you are, but it works
especially well for us.

> > On linux.git, the times to dig out two of the latest -rc tags drops from
> > 0.002s to 0.001s, so the change on repositories with fewer tags is much
> > less noticeable.
> >
>
> This explains why it might not have been done before.. many
> repositories wouldn't benefit much.
>
> That said, the patch description doesn't make it seem very
> complicated. I did run out of time reading the message, so I'll have
> to follow up reviewing the actual change below later. I think the
> description of the goal and solution is sound though.

Thanks for the initial review :-).

Thanks,
Taylor
