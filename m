Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D622EC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiHRQvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344965AbiHRQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:51:09 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AB3C6FDC
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:51:07 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r141so1524217iod.4
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=V0JVBFYZDKmbe0YlZb4spHwuqT5iOI8+M3nUDssHcEc=;
        b=bpBLJ7vzNQWo/4WTEXggnThx24vdJ41WXI9p7h0h+FS4b6KyqJwJXMgfX0hF7ZV5y3
         GZpqfiOxQE/ZocK6lRFFwkacxtHVqHmU2UeplJlThjDBGUJQA7RYcmWP4sXluo1TjZOe
         nT0cXF5rhnbUKUI14jFPCLuaOtzPR8aT9AOfyCsT+JWdK21vby1n2QG9RCH7Li9ipaxc
         6WhbUq88ShYesWV8WxWTw9eJBh5cNAG3f4zkLglj5Aywmzg/K2bDnM0SkDekoV7afjhX
         eqOj1WFppnNTRfW9BW7cocIXrY/c3dwmAuetxPGRb91McuL0jwwFZRMa9DFvABf5Duig
         mlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=V0JVBFYZDKmbe0YlZb4spHwuqT5iOI8+M3nUDssHcEc=;
        b=I5NxKMwE2yk+p4102RfmdQAADV3q67u+eXgeLi2AdJ0G9IDeursrrFYqQJLqlhyOOf
         PL/KGkAsOhHr3bivIMvN/Y1QhodKpHX29lcqEPzEhL6sldI4U6AXu6Jl8eXb4AVLUFHp
         wvty0LmmGoNZr93uHhBSWUOhInnmaZ34UylAwdd8Zxo/udvHLwMBuEMngqmlfm9vrlub
         cqe+uUtMWneT/xS3lqVouSL0ZJjHf0U87mmMQz/74zfGeuvsKTyMP2KsvMtoDTeHs8+Y
         z9U8U11iNaok06i5KWLiwaPmcJR7BWb4QryczAtvTpOajepDTkSjr/zk0E61nZgls5Er
         98ow==
X-Gm-Message-State: ACgBeo2Im0lAbNvQhp4sPCJ7CgeH5nDBWmDWpMsrwXD8tUs2ad3M4SN9
        x3YQFH9fwupRLmUI+W2mO1y4
X-Google-Smtp-Source: AA6agR4xtW/aykGKh0J0DskWRezEbD7Dvb3sJmjxmF/2OJ37oTLm/Op6wp8CTobreLKDHlZPn9FSkQ==
X-Received: by 2002:a05:6638:498c:b0:346:885f:efbc with SMTP id cv12-20020a056638498c00b00346885fefbcmr1764623jab.111.1660841466741;
        Thu, 18 Aug 2022 09:51:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6? ([2600:1700:e72:80a0:5d2c:b6ba:5eb7:d0c6])
        by smtp.gmail.com with ESMTPSA id f1-20020a056e020c6100b002dd0ba40abdsm830966ilj.18.2022.08.18.09.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 09:51:06 -0700 (PDT)
Message-ID: <59b3af21-0685-1819-38bc-8afd826bee6f@github.com>
Date:   Thu, 18 Aug 2022 12:51:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an
 argument
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
 <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220818.86ilmp8rzn.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/18/2022 11:50 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Aug 18 2022, Derrick Stolee wrote:
> 
>> On 8/18/2022 2:17 AM, Elijah Newren via GitGitGadget wrote:
>>> +test_expect_success 'rev-list --ancestry-path=F D..M' '
>>> +	test_write_lines E F J L M >expect &&
>>> +	git rev-list --ancestry-path=F --format=%s D..M |
>>> +	sed -e "/^commit /d" |
>>> +	sort >actual &&
>>> +	test_cmp expect actual
>>> +'
>>
>> These tests follow the patterns from other tests in this file, but
>> it also has bad patterns. Specifically, the 'git rev-list' command
>> is fed directly into a pipe. I include a patch below that applies
>> directly on this one to rewrite these tests. If you want, you could
>> rebase to have that test refactor happen before you add your new
>> --ancestry-path=<X> option tests.
> 
> Thanks, I was going to comment on the same, but your solution is much
> better (I was just going to suggest using intermediate files).
> 
>> [...]
>> -test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
>> -	echo M >expect &&
>> -	git rev-list --ancestry-path --format=%s D..M -- M.t |
>> -	sed -e "/^commit /d" >actual &&
>> -	test_cmp expect actual
>> -'
>> +test_ancestry () {
>> +	args=$1
>> +	expected=$2
> 
> Maybe add &&-chaining here (we do it in some cases, but I'm not sure
> when such assignments would ever fail).

These are outside of a test_expect_success, so they are not important.
 
>> +	test_expect_success "rev-list $args" "
>> +		test_write_lines $expected >expect &&
>> +		git rev-list --format=%s $args >raw &&
>> +
>> +		if test -n \"$expected\"
> 
> Aren't you making things harder for yourself here than required by using
> ""-quoting for the body of the test.
> 
> We eval it into existence, so you can use ''-quotes, and then you don't
> need to escape e.g. the "" quotes here for expected, no?

Are "args" and "expected" in-scope if I use single quotes? I don't think
they are unless we export them. I could be wrong.

>> +		then
>> +			sed -e \"/^commit /d\" raw | sort >actual &&
> 
> nit for debuggability (and not correctness), maybe using intermediate
> files here would be nicer? And then perhaps call them "actual" and
> "actual.sorted".

I don't think that level of debuggability is important. We have the
raw file if we want to see what the Git output was.

> 
>> +			test_cmp expect actual || return 1
> 
> No need for a "return 1" here when we're not in a loop. It's redundant,
> and makes the -x output on failure confusing ("why didn't I fail on the
> test_cmp, but on this stray return?...").

Sure. I did this more out of habit, but it makes sense that we don't
need it for an if block.

> ...
> 
>> +		else
>> +			test_must_be_empty raw
> 
> ...which would also allow you to extract much of this if/else at the
> cost of not using test_must_be_empty, i.e. just make the "expected"
> empty unless "$expected" is provided. Just a thought/nit, we could also
> leave this as-is :)

*shrug* either way is fine by me.

> Also does the "compare rev" part of this want test_cmp_rev instead?

I don't know what you mean here. We are not comparing revisions anywhere,
but we are using the commit messages to create an easy comparison for the
output.

Thanks,
-Stolee
