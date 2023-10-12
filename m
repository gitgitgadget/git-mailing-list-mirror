Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE68CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbjJLRVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 13:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379590AbjJLRV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 13:21:27 -0400
X-Greylist: delayed 2391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 10:21:25 PDT
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E8B8
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 10:21:24 -0700 (PDT)
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4S5wQ274Lsz5tvj
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 18:41:30 +0200 (CEST)
Received: from [192.168.0.106] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4S5wPy1tZhz5tlC;
        Thu, 12 Oct 2023 18:41:26 +0200 (CEST)
Message-ID: <22688989-1b51-4989-b92d-5a5891ec9265@kdbg.org>
Date:   Thu, 12 Oct 2023 18:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to combine multiple commit diffs?
To:     ZheNing Hu <adlternative@gmail.com>
References: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
Content-Language: en-US
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <CAOLTT8RzcENBx9NKffHReVKJAho89TCO7W2SPBX8sb2tEU84Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[For general support questions, please address only the mailing list.
It's not necessary to bother the maintainer personally. Though, I'll not
remove him from Cc, yet, as to comply with this ML's etiquette.]

Am 12.10.23 um 14:00 schrieb ZheNing Hu:
> Hi everyone,
> 
> Our company wants to design a "small-batch" code review feature.
> Simply put, this "small-batch" means being able to treat multiple
> related commits within a MergeRequest as an independent "small" code
> review.
> 
> Let me give you an example: We have five commits: A1, B, A2, C, A3.
> Among them, A1, A2, and A3 are multiple commits for the same feature.
> So when the user selects these commits, the page will return a
> "combine diff" that combines them together.
> 
> A1       B A2 A3 C
> *--------*----*-----*-------* (branch)
>  \ A1'        \ A2'  \ A3'
>   *------------*------*------- (small branch code review)
> 
> This may seem similar to cherry-picking a few commits from a pile of
> commits, but in fact, we do not expect to actually perform
> cherry-picking.
> 
> Do you have any suggestions on how we can merge a few commits together
> and display the diff? The only reference we have is the non-open
> source platform, JetBrains Space CodeReview, they support selecting
> multiple commits for CodeReview. [1], .


Take a step back. Then ask: What are the consequences of the review?
What if the result is: the feature is perfect, we want it merged,
however, we cannot, because we do not want commit B. What if the result
is the opposite? You need B, but you can't merge it because the feature
is not ready, yet?

You are looking for a technical workaround for a non-optimal workflow.
If A1,A2,A3 are a feature on their own, they, and only they, should be
in their own feature branch.

So, I would say, the best solution is to reorder the commits in a better
manageable order. You do know about git rebase --interactive, don't you?

-- Hannes

