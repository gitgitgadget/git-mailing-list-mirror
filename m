Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766BEC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45C8961166
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbhDOPqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOPqW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 11:46:22 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EACC061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:45:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g17so27926709edm.6
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ei1qYV9G5Yv32yfIaYqyEkLrwBijerdBMdqtNsT1y6A=;
        b=Vlf0m9jLuLCpB7p3Hr7LVtXPaT/lwMT7ECp11b9BG4xbgGS8p6bRYE9keoKIDc3Mo/
         nzjHeU9jWbG2reJmu6TDg56a2vjnYHdpvSYXX1TP2jyjrSju5T+dKJmq+snlSjmVNeZc
         zFIp2OtjQuis4K5R+29VJmYnrpllrFU9VKLjKsW/EuxSK86SRboW5jkQX0KNu7EcfcQp
         n+Z+NA/s0a8/BTAyURVO7FQxci3Y7q8Qky0o0dTACl1codXeRnwqmZZLPJjS2QIF7XHL
         Cy+C2wuggZ8NsRrkiBaqsuNWCV7Du2Zl/yvlRDFhyGIToG61uXLjEJfceFjlnEoQTmJu
         ukrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ei1qYV9G5Yv32yfIaYqyEkLrwBijerdBMdqtNsT1y6A=;
        b=b2tIxrK51jctpskcRRSBwv1EcR/iAq3IkfiTlk3c4/+Mt/dANO01/fqItUypx9D65k
         CgnnRoQbH+YECSHCTr0Wvksm6h5Oxfwrl3MNFTbJgkCcSSNYFy6lHqjms1sGD539XQ+8
         NhKvLHssUVMHqg/35kFBT5kxDB9lw93PX+hmWOCcmx3T3VtYJSAVyszE3N/GulWHOES4
         XSKFFlxpE9chpSYAbcp7NQVoOJw/cdmrWXISOpbsKailqFhnSbdXBUB5akW1k84fSuKo
         pzXdx8ClxAynhelVrp+f3R3PAdpxXRiYF8biPAsissUX699+fHGIyWpTG7b0W7rWUEGc
         ESgA==
X-Gm-Message-State: AOAM533hTvCNuRYSymBC0kk2KSTdiq9lIybfectzpgTNL59y9fQp1/WD
        K84LpJhWLtSVHXQwmR0n7Kw=
X-Google-Smtp-Source: ABdhPJwph3gyRIby04MaETPTFek0quOwWRmh2jdFUVrAWIdVJPZqH+dUvGG0Z+pIMstM5Q0A+uBJDA==
X-Received: by 2002:a05:6402:105a:: with SMTP id e26mr5008019edu.164.1618501557998;
        Thu, 15 Apr 2021 08:45:57 -0700 (PDT)
Received: from C02YX140LVDN.corpad.adbkng.com ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id cn2sm2889802edb.64.2021.04.15.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:45:57 -0700 (PDT)
Date:   Thu, 15 Apr 2021 17:45:54 +0200
From:   Son Luong Ngoc <sluongng@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
References: <YHaIBvl6Mf7ztJB3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I'm not a regular contributor but I have started to subscribe to the
Git's Mailing List recently.  So I thought it might be worth sharing my
personal view on this.

After writting all the below, I do realize that I have written quite a
rant, some of which I think some might consider to be off topic.  For
that, I do want to appologize before hand.

 Tue, Apr 13, 2021 at 11:13:26PM -0700, Jonathan Nieder wrote:
> Hi,
> 
...
> 
> Those four are important in my everyday life.  Questions:
> 
>  1. What pain points in the patch flow for git.git are important to
>     you?

There are several points I want to highlight:

1. Issue about reading the Mailing List:

- Subscribing to Git's Mailing List is not trivial:
  It takes a lot of time to setup the email subscription.  I remember
  having to google through a few documents to get my subscription
  working.

- And even after having subscribed, I was bombarded with a set
  of spam emails that was sent to the mailing list address.  These spams
  range anywhere from absurd to disguising themselves as legitimate
  users trying to contact you about a new shiny tech product.

2. Issue about joining the conversation in the Maling List:

- Setting up email client to reply to the Mailing List was definitely
  not trivial.  It's not trivial to send a reply without subscribing to
  the ML(i.e. using a Header provided from one of the archive).
  The list does not accept HTML emails, which many clients
  use as default format.  Getting the formatting to work for line
  wrapping is also a challenge depends on the client that you use.

- It's a bit intimidating to ask 'trivial questions' about the patch and
  create 'noise' in the ML.

3. Isssue with archive:

- I don't find the ML archive trivial for new comers.  It took me a bit
  of time to realize: 'Oh if I scroll to bottom and find the "Thread 
  overview" then I can navigate a mailing thread a lot easier'.

- The lack of labeling / categorization that I can filter while browsing
  through the archive make the 'browse' experience to be quite
  unpleasant.  Search is one way to do it, but a new comers would not be
  knowledgable enough to craft search query to get the archive view just
  right.  Perhaps a way to provide a curate set of categories would be
  nice.

- Lost track of issues / discussion:
  A quick example would be me searching for Git's zstd support
  recently with 

  > https://lore.kernel.org/git/?q=zstandard 

  and got next to no relevant result.  However if I were to query

  > 'https://lore.kernel.org/git/?q=zstd'

  then a very relevant thread from Peff appeared.  I think this could be
  avoided if the search in ML archive do more than just matching exact
  text.

4. Lack of way to run test suite / CI:

  It would be nice if we can discuss patches while having CI result as
  part of the conversation.  Right now mostly I see that we have to
  manually running benchmarks/tests and share the paste the results.

  But for folks who don't have a dev environment ready at hand (new
  comers, during travel with only phone access), it would be nice to
  have a way to run tests without a dev environment.

  This was mostly solved in the context of works spent on Github's
  Action Workflow.  But if we are discussing about pure patch flow, this
  is a miss.

>  2. What tricks do you use to get by with those existing pain points?

For (1):
- I had to invested a lot of time into setting up a set of Gmail search
  filter.  Move mails with topics that Im interested in into a special
  tag while the rest into archive.  Regularly check if anything
  interesting went to archive by accident.

For (2):
- I had to setup Mutt + Tmux to have a compatible experience sending
  replies like this one.

- All the patches I have submitted were through
  > https://github.com/gitgitgadget/git/pulls
  and it was not directly trivial to get permission to send email from a
  PR.

For (3):
- Spending time reading git blame / git log / commit message helps
  identifying the keywords I need to refine my search result in the ML
  archive.  This requires some commitments and is a barrier to entry for
  new comers.

- Using service like Github Search or SourceGraph helped a lot in term
  of navigating through the commit message / git blame.

For (4):
- I leverage both Github action and a patch that added Gitlab CI to run
  the test suite.

>  3. Do you think patchwork goes in a direction that is likely to help
>     with these?
>
>  4. What other tools would you like to see that could help?

With all that said, I don't know if patchwork will solve the problems
above.  I do understand that the current patch workflow comes with a
certain set of advantages, and adopting another tool will most likely be
a trade-off.

Personally I have been spending more and more time reading through
git.git via Sourcegraph Web UI and I would love for the search feature
to be able to extend to be able to search in the Mailing List from
relevant commit if possible.  I have also tried both Github's Codespace
and Microsoft's DevContainer to setup an opionated IDE with predefined
tasks that help executing the test suite.  I think these tools (or
their competitors such as GitPod) are quite ideal to quickly onboard
new contributors onto a history-rich codebase such as git.git.

Perhaps some configure a set of sane default, including editor extensions
that would handle email config for first time users.

As for code review and issue tracking toolings, I don't think there are
a perfect solution.  Any solutions: Github PR, Gitlab MR, Gerrit,
Phabricator would come with their own set of tradeoffs.  I like the
prospect of PatchWork gona improve the patch workflow though.  Perhaps I
will give it a try.

> 
> Thanks,
> Jonathan

Thanks,
Son Luong.
