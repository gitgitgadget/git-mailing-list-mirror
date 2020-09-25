Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19570C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B20206C1
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 09:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB0XOAiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIYJLh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 05:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYJLh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 05:11:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5168C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 02:11:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so2715724wrw.11
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RizRSfT4b3XnKVvGe8r9W/NPKyx22okMTfaZTI2151c=;
        b=UB0XOAiDoXZkfGRxckzDx9u5fuRtv/T3V4OaLkIfdW8VebWCn5jbBwsc7pXuy3XNre
         BumbbLzAKrHjsiNGOymhgb3R/QWWnIr4zPMq+zcQmzRcbcjV3nDnVHrI24YkrqelcvYv
         +68oVjtLaJpNRlan0erGOeL+3LwhEclCIh6Cq+fBlyR7I/ZmYInbMrA0DJ8ovwKNUWKb
         f9ARg95BD/enk2303S9IUr/cE28CpT3271BxX44HhL7QlbUf4SZQVH2hKFUOHYiZeiUq
         QfPDjpv/MBoXmOrRNI64y5w5MwsWoXknefqeUtk/Ig9ymA1ZAwZJtAwLRpQtSgIEUDJG
         v+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=RizRSfT4b3XnKVvGe8r9W/NPKyx22okMTfaZTI2151c=;
        b=p34+8goZ+zTSsE60c0ePR/6N0luv5rJ3ju+VftPfbkjMJCIIzjZxeR2w76zb4eDe47
         IBYAQs/pKjGGUCzZtCazj8ehq7hUPSQ6fkBNwpy8lTZAZD4sErr1MDxb4jFp+FF2EPEt
         e4gjeSktCbCEfhNnUHbUsbqGO/daToyoTwLsapZ9bRBCOFkdxpigUhNJO5Gf4oodY/st
         ymfcNZYtq5VjNVp41n/J1jTaDU3HzVm8Ymtty5vyem38QiPsKB7xjaqo19JZfBuP2Mv8
         hwO5f12r1UzPZEHBhVuCItKfC+KqR9tN6nmlTLODa3lHg200Ueds0lgb0vMQBQOjrF96
         Skqg==
X-Gm-Message-State: AOAM532zcTiEgY4FUrjmdTASqjupmJ62N2W6BDsnSQpEQNVCtGTdkVla
        qMRcwwoQIwowq56y1Qfmi8Kb+fGfT7A=
X-Google-Smtp-Source: ABdhPJyuWTntHOhCdIq1IhpQU5er3C5+0yyjRo8oM3oAGP0BtaBMhMufiNK+bAgkjGrV5Tk0OnZVmQ==
X-Received: by 2002:adf:f548:: with SMTP id j8mr3551887wrp.114.1601025095297;
        Fri, 25 Sep 2020 02:11:35 -0700 (PDT)
Received: from [192.168.1.240] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.gmail.com with ESMTPSA id r21sm2064169wrc.70.2020.09.25.02.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 02:11:34 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC 0/1] Leading whitespace as a function identification
 heuristic?
To:     Ryan Zoeller <rtzoeller@rtzoeller.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200923215859.102981-1-rtzoeller@rtzoeller.com>
 <xmqqzh5fhduk.fsf@gitster.c.googlers.com>
 <20200924211725.GA3103003@coredump.intra.peff.net>
 <c759b472-c889-ef85-bcf2-6d9cbc588b51@rtzoeller.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <1c03faa0-011c-39c2-acb6-d09a5fcfc818@gmail.com>
Date:   Fri, 25 Sep 2020 10:11:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c759b472-c889-ef85-bcf2-6d9cbc588b51@rtzoeller.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/2020 23:01, Ryan Zoeller wrote:
> On 9/24/20 4:17 PM, Jeff King wrote:
>>
>>
>> If I understand the problem correctly, I don't think a static regex can
>> accomplish this, because you need context from the original line. E.g.,
>> consider something like this:
>>
>>     void foo() {
>> 	void bar() {
>> 		...code 1...
>> 	}
>> 	...code 2...
>>     }
>>

If I've understood correctly when ...code 2... contains changes that are 
themselves indented then we'll pick the wrong function header for example

	void foo() {
		void bar() {
			...code 1...
		}
		for (...) {
			// if this line is changed we pick bar rather
			// than foo because it is the first function
			// header with a smaller indentation than the
			// first changed line.
		}
	}

Unfortunately I suspect code like that is not uncommon and the diff 
would regress with this simple heuristic. It might be possible to 
recalculate the required indentation as we walk backwards up the file 
though, so when we hit the "for" line we reduce the maximum indentation 
allowed for a match and so skip "bar" as a function header.

Best Wishes

Phillip

>> If we change one of the lines of code, then we find the function header
>> by walking backwards up the lines, evaluating a regex for each line. But
>> for "code 2", how do we know to keep walking past bar() and up to foo()?
>> Or more specifically, what is different when evaluating a change from
>> "code 2" that is different than when we would evaluate "code 1"?
>>
>> If the only input to the question of "is this line a function header" is
>> the regex from the config, then changes to either line of code must
>> produce the same answer (either bar() if we allow leading whitespace, or
>> foo() if we do not).
>>
>> So I think Ryan's proposal is to give that search an extra piece of
>> information: the indentation of the original changed line. Which is
>> enough to differentiate the two cases.
> 
> You've explained this better than I could have. Thanks.
> 
>> If I understand the patch correctly, it is always picking the first line
>> where indentation is lessened (and which matches the funcname pattern).
>> That works out of the box with existing funcname patterns, which is
>> nice. Though I wonder if there are cases where the funcname regex could
>> use the information more flexibly (i.e., some marker in the regex that
>> means "match less than this many spaces" or something).
> 
> My original intent was to work with existing funcname expressions
> without modifications. Some of the funcname regexes are rather
> impenetrable at first glance, and not requiring modifications seemed
> like an easy win.
> 
> Especially for funcname patterns specified by a user, I assumed it
> would be easier to set an additional configuration option than
> rewrite an existing regex to handle this complexity.
> 
>> I do agree that this should not be on automatically for all languages.
>> Some file formats may want to show a header that's at the same
>> indentation as the change. Adding a diff.foo.funcnameIndentation config
>> option would be one solution. But requiring the funcname pattern to make
>> explicit use of the information is another (and would allow a format to
>> match some things at one indentation level and some at another; but
>> again, I'm hand-waving a bit on whether this level of flexibility is
>> even useful)
> If the configuration option is implemented correctly (i.e. as an enum
> rather than a binary toggle), I think we could leave the door open for
> a more flexible approach in the future, without needing to answer how
> useful that flexibility is now. I couldn't think of any situations
> requiring this flexibility, but that doesn't mean they don't exist.
> 
> Ryan
> 
