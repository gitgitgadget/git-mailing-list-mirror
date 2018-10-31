Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B365E1F453
	for <e@80x24.org>; Wed, 31 Oct 2018 06:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJaPBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:01:32 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36569 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaPBb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:01:31 -0400
Received: by mail-vs1-f65.google.com with SMTP id v205so6679810vsc.3
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39FRC7n2rQW5WqfflzltNIOHDxSw/P7O2dg/gicOAzI=;
        b=Sog8Q+gpH//uPipTyh7rxUNUwINYMBKi0DiBak13OwaOH2Mo0F1FPRzjWh5itxEfp7
         4wNMhjrl708ZtRlUwZRtbai8kCcDibEzBJzpC2WdGAEN55YdAiPnAZtrG3JNl1FPdtrT
         hrEABNsscCzL/xIKaZUHrFC1K+x3NGUyTI/EEZw9ijfNaK7RSdNF7FjAOnErOOvAROpG
         3HEp1RKgb5kuCCG1J5YsKHK+P3O8ly1s/xJ6p/jUm66YYfvoGdGeesImkdkXJ75gj1mA
         dDzw7SOIOWrQkkbdWBknMWT0KbBU9ziaQap40JOuUErtjKE18nmoHzfoiJMaBf8XqgC6
         rlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39FRC7n2rQW5WqfflzltNIOHDxSw/P7O2dg/gicOAzI=;
        b=d/LlNgbFSFAUeZxCYuCPRO5ntK8BfTqOmMJT1hreJmWxQwwP+u2HnW2mTVq5E7R5YR
         fFCEDgQVOo2UlGdtKfPYl9RCxSxDeeHqWrRutpXVBwg4UDLUGtbTVlohmf2akeIV818q
         Ftyu/BfYVVgQ0JuOR0lbLe9fVWfdYWDeI2SSPiKnXRFhZjDYz1s2oz28mEYZiyJtXBQm
         1KrBh3qwaa5OKuxrOFo1x60a083Lw2Pujm13n6/Uquqn9UQsOlMX3jfZTLvY4o+Sqhlx
         6YvNSThPODL8Vx3VyI5Eni1TisJPvQqd5PpGuvleYNogFrX0lIvkI3ilo95D7Zs7+6Fv
         llQQ==
X-Gm-Message-State: AGRZ1gIhgBSWGnFtY2UvTSZ05PVWOgJ2YSFpteqN1n1IeUrNFqBrW0iA
        NepkpTGpJVbncRtOhTobUEPdxDo3/36O8V5xMz8=
X-Google-Smtp-Source: AJdET5c31m9ju+oQ2K7Z/zhX0YTABVHzUU9JFzRBUxmFUH79P7uaP7oasJAKFNmv4x+/QSL/auEvhESEpQckJa/Xyhs=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr755744vsm.116.1540965890646;
 Tue, 30 Oct 2018 23:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.60.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.60.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 30 Oct 2018 23:04:39 -0700
Message-ID: <CABPp-BFzwphzaMjCWrNxU2V+YeYvRiBOzSV--b13wa7r16dvMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Make add_missing_tags() linear
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 7:16 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> As reported earlier [1], the add_missing_tags() method in remote.c has
> quadratic performance. Some of that performance is curbed due to the
> generation-number cutoff in in_merge_bases_many(). However, that fix doesn't
> help users without a commit-graph, and it can still be painful if that
> cutoff is sufficiently low compared to the tags we are using for
> reachability testing.
>
> Add a new method in commit-reach.c called get_reachable_subset() which does
> a many-to-many reachability test. Starting at the 'from' commits, walk until
> the generation is below the smallest generation in the 'to' commits, or all
> 'to' commits have been discovered. This performs only one commit walk for
> the entire add_missing_tags() method, giving linear performance in the worst
> case.
>
> Tests are added in t6600-test-reach.sh to ensure get_reachable_subset()
> works independently of its application in add_missing_tags().

On the original repo where the topic was brought up, with commit-graph
NOT turned on and using origin/master, I see:

$ time git push --dry-run --follow-tags /home/newren/repo-mirror
To /home/newren/repo-mirror
 * [new branch]              test5 -> test5

real 1m20.081s
user 1m19.688s
sys 0m0.292s

Merging this series in, I now get:

$ time git push --dry-run --follow-tags /home/newren/repo-mirror
To /home/newren/repo-mirror
 * [new branch]              test5 -> test5

real 0m2.857s
user 0m2.580s
sys 0m0.328s

which provides a very nice speedup.

Oddly enough, if I _also_ do the following:
$ git config core.commitgraph true
$ git config gc.writecommitgraph true
$ git gc

then my timing actually slows down just slightly:
$ time git push --follow-tags --dry-run /home/newren/repo-mirror
To /home/newren/repo-mirror
 * [new branch]              test5 -> test5

real 0m3.027s
user 0m2.696s
sys 0m0.400s

(run-to-run variation seems pretty consistent, < .1s variation, so
this difference is just enough to notice.)  I wouldn't be that
surprised if that means there's some really old tags with very small
generation numbers, meaning it's not gaining anything in this special
case from the commit-graph, but it does pay the cost of loading the
commit-graph.


Anyway, looks good in my testing.  Thanks much for working on this!
