Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E652035F
	for <e@80x24.org>; Fri, 28 Oct 2016 23:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756104AbcJ1X7V (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 19:59:21 -0400
Received: from avasout03.plus.net ([84.93.230.244]:32866 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbcJ1X7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 19:59:20 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id 1BzF1u0030zhorE01BzGwT; Sat, 29 Oct 2016 00:59:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=1XWaLZrsAAAA:8 a=57H4Vk3GRzZw8jfBPdYA:9
 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22 a=nJcEw6yWrPvoIXZ49MH8:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCHv2 00/36] Revamp the attr subsystem!
To:     Stefan Beller <sbeller@google.com>, gitster@pobox.com
References: <20161028185502.8789-1-sbeller@google.com>
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <588e34f9-015f-82e1-019b-c83571801e7d@ramsayjones.plus.com>
Date:   Sat, 29 Oct 2016 00:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 28/10/16 19:54, Stefan Beller wrote:
> previous discussion at https://public-inbox.org/git/20161022233225.8883-1-sbeller@google.com
> 
> This implements the discarded series':
> jc/attr
> jc/attr-more
> sb/pathspec-label
> sb/submodule-default-paths
> 
> This includes
> * The fixes for windows
> * Junios latest suggestion to use git_attr_check_initv instead of
>   alloc/append.
> 
> * I implemented the thread safe attr API in patch 27 (attr: convert to new threadsafe API)
> * patch 28 (attr: keep attr stack for each check) makes it actually possible
>   to run in a multithreaded environment.
> * I added a test for the multithreaded when it is introduced in patch 32
>   (pathspec: allow querying for attributes) as well as a test to disallow
>   multiple "attr"s in a pathspec.

By the end of this series, 'git_attr_counted()' and 'git_attr()' are
both file local symbols and can be marked with static. (I gave up the
search for which actual patch should change the symbols to static).

Also, 'git_attr()' ends up with a single caller, so maybe inline that
call?

I was about to have a moan about PTHREAD_MUTEX_INITIALIZER, since it
causes sparse to issue some warnings, but I see that you have decided
not to use it. So, phew! ;-)

ATB,
Ramsay Jones

