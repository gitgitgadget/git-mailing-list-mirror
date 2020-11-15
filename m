Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72970C2D0E4
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3092242E
	for <git@archiver.kernel.org>; Sun, 15 Nov 2020 21:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKOVmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Nov 2020 16:42:53 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:37484 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgKOVmw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Nov 2020 16:42:52 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4CZ5KK4DPrz5tlB;
        Sun, 15 Nov 2020 22:42:45 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 3351B3A2;
        Sun, 15 Nov 2020 22:42:44 +0100 (CET)
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
 <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com>
 <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <79313c8c-c927-78d4-bb1d-024f9feb553c@kdbg.org>
Date:   Sun, 15 Nov 2020 22:42:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHd-oW7X3fEM8PDFWQVc4kG_vfkY4LbvADzJfQrocjyaAr28TQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.11.20 um 21:12 schrieb Matheus Tavares Bernardino:
> Thank you both for the comments. I'll try to send v2 soon.
> 
> On Fri, Nov 13, 2020 at 10:47 AM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 11/12/2020 6:54 PM, Elijah Newren wrote:
>>>
>>> Do we also want to include a testcase where the user specifies a
>>> directory and part of that directory is within the sparsity paths and
>>> part is out?  E.g.  'git sparse-checkout set /sub/dir && git rm -r
>>> sub' ?
>>
>> That is definitely an interesting case.
> 
> I've added the test [1], but it's failing on Windows and I'm not quite
> sure why. The trash dir artifact shows that `git sparse-checkout set
> /sub/dir` produced the following path on the sparse-checkout file:
> "D:/a/git/git/git-sdk-64-minimal/sub/dir".

If 'git sparse-checkout' is run from a bash command line, I would not be 
surprised if the absolute path is munched in the way that you observe, 
provided that D:/a/git/git/git-sdk-64-minimal is where your MinGW 
subsystem is located. I that the case?

> If I change the setup cmd to `git sparse-checkout set sub/dir` (i.e.
> without the root slash), it works as expected. Could this be a bug, or
> am I missing something?

Not a bug, unless tell us that D:/a/git/git/git-sdk-64-minimal is a 
completely random path in your system or does not even exist.

-- Hannes
