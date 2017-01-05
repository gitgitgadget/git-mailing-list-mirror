Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED5EC205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 15:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161720AbdAEPtK (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 10:49:10 -0500
Received: from spork.scientician.org ([66.228.35.160]:43970 "EHLO
        spork.scientician.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034257AbdAEPtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 10:49:08 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jan 2017 10:49:08 EST
X-Submitted: to spork.scientician.org (Postfix) with ESMTPSA id 06C1348BE2
X-Submitted: to mail.scientician.org (Postfix) with ESMTPSA id 236FA20026
From:   Richard Hansen <hansenr@google.com>
Subject: Re: [PATCH 2/4] t7610: make tests more independent and debuggable
To:     Stefan Beller <sbeller@google.com>
References: <20170104005042.51530-1-hansenr@google.com>
 <20170104005042.51530-3-hansenr@google.com>
 <CAGZ79kb9UvV6AaRLBP5OzyRtTTXarRZRZDMd_1k5n9CrgbVr5A@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>, Johannes Sixt <j6t@kdbg.org>
Message-ID: <3f0222d0-fc61-ac41-3b1d-7f506fcb1f61@scientician.org>
Date:   Thu, 5 Jan 2017 10:41:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAGZ79kb9UvV6AaRLBP5OzyRtTTXarRZRZDMd_1k5n9CrgbVr5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-04 15:27, Stefan Beller wrote:
> On Tue, Jan 3, 2017 at 4:50 PM, Richard Hansen <hansenr@google.com> wrote:
>> If a test fails it might leave the repository in a strange state.  Add
>> 'git reset --hard' at the beginning of each test to increase the odds
>> of passing when an earlier test fails.
>
> So each test is cleaning up the previous test, which *may* confuse
> a reader ("how is the reset --hard relevant for this test? Oooh it's
> just a cleanup").
>
> We could put it another way by having each test itself make clean
> up after itself via
>
>   test_when_finished "git reset --hard" &&
>   ..
>
> at the beginning of each test.
> This would produce the same order of operations, i.e. a
> reset run between each test, but semantically tells the reader
> that the reset is part of the current test cleaning up after itself,
> as "reset" is operation for this particular test to cleanup.
> Does that make sense?

I like that idea; thanks for the suggestion.  I'll cook up a reroll.

>>
>> Also use test-specific branches to avoid interfering with later tests
>> and to make the tests easier to debug.
>
> That sounds great!
> Though in the code I only spot one occurrence for
>
> +       git checkout -b test$test_count branch1 &&
>
> so maybe that could be part of the first patch in the series?

There are two; the other is buried in the change for the 'mergetool on 
file in parent dir' test.

Thanks for the review,
Richard


>
> Thanks,
> Stefan

