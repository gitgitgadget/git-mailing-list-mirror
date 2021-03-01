Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652E3C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9E64E38
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 07:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCAHLQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 02:11:16 -0500
Received: from [93.83.142.38] ([93.83.142.38]:46880 "EHLO localhost"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232376AbhCAHLE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 02:11:04 -0500
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by localhost (Postfix) with ESMTP id 26D7033877;
        Mon,  1 Mar 2021 08:10:16 +0100 (CET)
Subject: Re: [PATCH v3 00/35] 20210215154427.32693-1-avarab@gmail.com
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
 <20210224195129.4004-1-avarab@gmail.com>
 <c2e90134-35bb-24b2-a334-7c6abdd6dc6f@kdbg.org>
 <3519e86e-d9eb-a9e0-ed28-72d32271d2bf@kdbg.org>
 <875z2ckwfl.fsf@evledraar.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <b9a0406d-a913-767c-fbec-be57246bd4e4@kdbg.org>
Date:   Mon, 1 Mar 2021 08:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <875z2ckwfl.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.21 um 17:07 schrieb Ævar Arnfjörð Bjarmason:
> On Sun, Feb 28 2021, Johannes Sixt wrote:
>> But I do not see the need for the framework provided by the new
>> test_diff_funcname. At the end of the series, it is only used by Perl
>> and custom driver tests. (I discount the new ADA and Ruby tests as they
>> can easily migrated to the simple test scheme.) But then the Perl tests
>> do not do anything special, either. The multi-line pattern test is just
>> a nice add-on but not strictly needed. In the end, the Perl test is just
>> as straight-forward as all others.
> 
> The benefit now is:
> 
>  1. Unlike the new plain-text "all test cases for a language driver" in
>     the same file mechanism you can have test descriptions. The
>     "description" in the golang one is just for show, you won't get
>     anything informative from test-lib.sh when your test fails.
> 
>  2. I think having #1 beats not having test descriptions at all, or
>      having to shove a description like the Ruby:
> 
>     "picks first "class/module/def" before changed context"
> 
>     into something that would make all the FS's we have to support
>     happy.

I missed that the descriptions are gone now that many test cases are
shoved into a single file when the simple framework is used. That is
indeed a disadvantage. But please keep in mind that code is more often
read than written. *If* we have to grow a new framework, then it must
not suffer from unreadability.

> 
>  3. A test in the new perl.sh one sets config. I think in both that case
>     and custom.sh it's more readable to carry such config setting with
>     the test, rather than at a distance in the main setup of t4018-*.sh.

As I said, the config in perl.sh is only used for a multi-line pattern
test. That is dispensable as there is already a similar test with custom
patterns. And the tests for custom patterns can be moved to the main
test file entirely.

> That being said I'd like to improve the syntax a bit, in particular
> instead of having a wrapper for test_expect_success I think it makes
> sense just to have the test call test_expect_success, and then provide a
> couple of helper functions.

That sounds like an improvement.

-- Hannes
