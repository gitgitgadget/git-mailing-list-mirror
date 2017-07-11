Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED1FB2035B
	for <e@80x24.org>; Tue, 11 Jul 2017 22:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932475AbdGKW16 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 18:27:58 -0400
Received: from mail.eclipso.de ([217.69.254.104]:53648 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756130AbdGKW15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 18:27:57 -0400
Received: from [127.0.0.1] (185.170.42.4 [185.170.42.4])
        by mail.eclipso.de with ESMTPS id 5A6646EB
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 00:27:55 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
Subject: Re: "groups of files" in Git?
To:     git@vger.kernel.org
References: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Cc:     Nikolay Shustov <nikolay.shustov@gmail.com>
From:   astian <astian@eclipso.at>
Message-ID: <0793138e-5971-d8f6-b25e-215ed5028dae@eclipso.at>
Date:   Tue, 11 Jul 2017 22:27:00 +0000
MIME-Version: 1.0
In-Reply-To: <CAEcERAz3vYekvJ8SM1FfdAVsP3LMVqA1O3yoJVThvg-0fPtVCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikolay Shustov wrote:
> With Perforce, I can have multiple changelists opened, that group the
> changed files as needed.
>
> With Git I cannot seem to finding the possibility to figure out how to
> achieve the same result. And the problem is that putting change sets
> on different Git branches (or workdirs, or whatever Git offers that
> makes the changes to be NOT in the same source tree) is not a viable
> option from me as I would have to re-build code as I re-integrate the
> changes between the branches (or whatever changes separation Git
> feature is used).
> Build takes time and resources and considering that I have to do it on
> multiple platforms (I do cross-platform development) it really
> denominates the option of not having multiple changes in the same code
> tree.
>
> Am I ignorant about some Git feature/way of using Git that would help?
> Is it worth considering adding to Git a feature like "group of files"
> that would offer some virtutal grouping of the locally changed files
> in the checked-out branch?

I never used Perforce and I'm not even sure I understand your problem,
but I thought I'd mention something that nobody else seems to have yet
(unless I missed it):

First, one thing that seems obvious to me from your description is that
these "parallel features" you work on are obviously interdependent,
therefore I would rather consider the whole thing as a single feature.
Therefore, it makes sense to me to work in a single "topic branch".

This doesn't preclude one from separating the changes in logically
sensible pieces.  Indeed this is par for the course in Git and people do
it all the time by dividing the bulk of changes into a carefully chosen
series of commits.

I think the most common way of doing this is to simply work on the whole
thing and once you're happy with it you use "git rebase --interative" in
order to "prettify" your history.

But, and here comes the part I think nobody mentioned yet, if your
feature work is considerably large or spans a considerably long time it
may be undesirable to postpone all that work until the very end (perhaps
by then you already forgot important information, or perhaps too many
changes have accumulated so reviewing them all becomes significantly
less efficient).  In that case, one solution is to use a "patch
management system" which will let you do that work incrementally (going
back and forth as needed).

If you know mercurial, this is "hg mq".  I don't think Git has any such
system built-in, but I know there are at least these external tools that
integrate with Git:
https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools#Patch-management_Interface_layers

Feel free to ignore this if I totally misunderstood your use case.

Cheers.


