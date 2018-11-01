Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C52BD1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 06:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeKAPxy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 11:53:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39650 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbeKAPxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 11:53:54 -0400
Received: by mail-vs1-f68.google.com with SMTP id h78so10543255vsi.6
        for <git@vger.kernel.org>; Wed, 31 Oct 2018 23:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKcGFG9ZKz6MvvRrNiHeTFywxIKnBSBy/gT71egGG74=;
        b=L4/mYjAVGb3Gyhjf5/IzQBMYzkzIU/crHJAu2mhOnEASCdIv03RkJlmPRylAc1ulGC
         uPXSRi7/esFO086iuTpEb0Xg1RCRuhGM4tlJXGevnsEMSstyZNyqROFFb2lbdw5sIfoV
         RMeiL/5ddoA1D0iH0W6liX0b9t3evWQVXduYv5W4HmcAzKNuxF3hT0XUO+3IxeOol0Qb
         vck403PJSzkLQUhbWhEeOsXtC2LSPd6CCYvu8noCfkYzRHUWvR9tg4gIuOlDrHGXDVEz
         kxgBsAagPq7E0aXnTKN2M8Wi+dGgH/BZYpgsLFfXDAvbzl2tysrw/ldQmADxgXVFcVkI
         1PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKcGFG9ZKz6MvvRrNiHeTFywxIKnBSBy/gT71egGG74=;
        b=EydHTz01ddbyLawCqSiZWjAK/H6HedDFLFFkzCqXmyrTQjN4HIK9vDOesHOz00Lulh
         2dCgMwXpb/5H+Rgd1vVGPuKWq8qXrcPitRk8oOn3QwWBcqhd2einYUsMKyQpq2zQYTK7
         ehN15iCo1JCmr6NYcuDA+A71b7ELhuX9uDS4jl0ye0nS08SwkcC+yNjfrXPkhgPJTI2v
         GGXVuNlSUwpAO6W33qaAPrcLMaH20/S7/TRQivr3EyBxT+aXhKWRIY5FvYlRcZi0sB8S
         UVVbBvLzyrCaCgLuJI13EtLGrTeRNEao/nLUqnDRScLFq+udvwZ3HnCqCHd2VEwRABUz
         V/hg==
X-Gm-Message-State: AGRZ1gIkxtmaPJBc5xMQqFh5UHp2vOf0jkeuJPehDgJ/pfdFjL0RGdBJ
        KUU/K6DIPLbjSptZGkjAajnzR9boWsVypohleKHZvw==
X-Google-Smtp-Source: AJdET5da7L7xiGcIEsfst4/ffI+HR3j64wWZ0mqgHC36Mk1mQc/XJK7KWYxjNbAnse3SXHbUJUePlbMeTaquRI4KsaM=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr2831025vsm.116.1541055132933;
 Wed, 31 Oct 2018 23:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
 <20181031120505.237235-1-dstolee@microsoft.com>
In-Reply-To: <20181031120505.237235-1-dstolee@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 Oct 2018 23:52:01 -0700
Message-ID: <CABPp-BHHG9K0869=4CYkqjN6rwLCzRBiF_Z94KFevSo3_FvYAw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 5:05 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/31/2018 2:04 AM, Elijah Newren wrote:
> > On Tue, Oct 30, 2018 at 7:16 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> As reported earlier [1], the add_missing_tags() method in remote.c has
> >> quadratic performance. Some of that performance is curbed due to the
> >> generation-number cutoff in in_merge_bases_many(). However, that fix doesn't
> >> help users without a commit-graph, and it can still be painful if that
> >> cutoff is sufficiently low compared to the tags we are using for
> >> reachability testing.
> >>
> >> Add a new method in commit-reach.c called get_reachable_subset() which does
> >> a many-to-many reachability test. Starting at the 'from' commits, walk until
> >> the generation is below the smallest generation in the 'to' commits, or all
> >> 'to' commits have been discovered. This performs only one commit walk for
> >> the entire add_missing_tags() method, giving linear performance in the worst
> >> case.
> >>
> >> Tests are added in t6600-test-reach.sh to ensure get_reachable_subset()
> >> works independently of its application in add_missing_tags().
> >
> > On the original repo where the topic was brought up, with commit-graph
> > NOT turned on and using origin/master, I see:
> >
> > $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> > To /home/newren/repo-mirror
> >  * [new branch]       test5 -> test5
> >
> > real 1m20.081s
> > user 1m19.688s
> > sys 0m0.292s
> >
> > Merging this series in, I now get:
> >
> > $ time git push --dry-run --follow-tags /home/newren/repo-mirror
> > To /home/newren/repo-mirror
> >  * [new branch]       test5 -> test5
> >
> > real 0m2.857s
> > user 0m2.580s
> > sys 0m0.328s
> >
> > which provides a very nice speedup.
> >
> > Oddly enough, if I _also_ do the following:
> > $ git config core.commitgraph true
> > $ git config gc.writecommitgraph true
> > $ git gc
> >
> > then my timing actually slows down just slightly:
> > $ time git push --follow-tags --dry-run /home/newren/repo-mirror
> > To /home/newren/repo-mirror
> >  * [new branch]          test5 -> test5
> >
> > real 0m3.027s
> > user 0m2.696s
> > sys 0m0.400s
>
> So you say that the commit-graph is off in the 2.8s case, but not here
> in the 3.1s case? I would expect _at minimum_ that the cost of parsing
> commits would have a speedup in the commit-graph case.  There may be
> something else going on here, since you are timing a `push` event that
> is doing more than the current walk.
>
> > (run-to-run variation seems pretty consistent, < .1s variation, so
> > this difference is just enough to notice.)  I wouldn't be that
> > surprised if that means there's some really old tags with very small
> > generation numbers, meaning it's not gaining anything in this special
> > case from the commit-graph, but it does pay the cost of loading the
> > commit-graph.
>
> While you have this test environment, do you mind applying the diff
> below and re-running the tests? It will output a count for how many
> commits are walked by the algorithm. This should help us determine if
> this is another case where generation numbers are worse than commit-date,
> or if there is something else going on. Thanks!

I can do that, but wouldn't you want a similar patch for the old
get_merge_bases_many() in order to compare?  Does an absolute number
help by itself?
It's going to have to be tomorrow, though; not enough time tonight.
