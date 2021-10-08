Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EBAC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A48D60FDC
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 22:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbhJHWNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:13:42 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:13628 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243591AbhJHWNl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 18:13:41 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 4HR2Tr20ZSz5tlC;
        Sat,  9 Oct 2021 00:11:44 +0200 (CEST)
Subject: Re: [PATCH v2 0/5] Fun with cpp word regex
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Sixt via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
 <pull.1054.v2.git.1633720197.gitgitgadget@gmail.com>
 <87r1cvmg0c.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <25363715-dc39-1f18-a937-f715b106f529@kdbg.org>
Date:   Sat, 9 Oct 2021 00:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <87r1cvmg0c.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.21 um 22:07 schrieb Ævar Arnfjörð Bjarmason:
>  * I wonder if it isn't time to split up "cpp" into a "c" driver,
>    e.g. git.git's .gitattributes has "cpp" for *.[ch] files, but as C++
>    adds more syntax sugar.
> 
>    So e.g. if you use "<=>" after this series we'll tokenize it
>    differently in *.c files, but it's a C++-only operator, on the other
>    hand probably nobody cares that much...

Yes, it is that: <=> won't appear in a correct C file (outside of
comments), so no-one will care. As far as tokenization is concerned, C
is a subset of C++. I don't think we need to separate the drivers.

>  * I found myself back-porting some of your tests (manually mostly),
>    maybe you disagree, but in cases like 123'123, <=> etc. I'd find it
>    easier to follow if we first added the test data, and then the
>    changed behavior.
> 
>    Because after all, we're going to change how we highlight existing
>    data, so testing for that would be informative.

Good point. I'll work a bit more on that.

>  * This pre-dates your much improved tests, but these test files could
>    really use some test comments, as in:
> 
>    /* Now that we're going to understand the "'" character somehow, will any of this change? */
>    /* We haven't written code like this since the 1960's ... */
>    /* Run & free */
> 
>    I.e. we don't just highlight code the compiler likes to eat, but also
>    comments. So particularly for smaller tokens that also occur in
>    natural language like "'" and "&" are we getting expected results?

Comments are free text. Anything can happen. There is no such thing as
"correct tokenization" in comments. Not interested.

Thank you for the review.
-- Hannes
