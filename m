Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD8C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8758D22BEA
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbhAGCBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAGCBd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 21:01:33 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF678C0612EF
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 18:00:52 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 186so4373040qkj.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 18:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84tZbwJ4gyNVlf5hk3NJPVLW/b6QK1wKjnVI/y9pSRM=;
        b=auA2+JCoy3jLhzPjo2eNbceTRBpN4Ct4oT962z7d/L+qxwLJHAV/yktPWuMNZwJlYT
         yzIUeNboj/3Yt5m98fgT5WAvBu4XSR56s+/gpTam4MzaHvnxl7AWvx6AL+w+vWV0Lqsj
         jIpSrW5RFlv+msmy57whx7yppMzGkJTBYwv0cwY1yKRT8z32Y4bBy7iDUkbYzMHu31rb
         JCzcZpUVBuyecWnQh8Bq+BCA8lCs3NGFldmrdvu0qk7mEFo3JhXWOsiSi/+Mpr0+bt85
         cG0fmm12Z1jMhaK3vqnqC6ieT9Ln9Fp3HkeiwCHt5nPi+UXyenjy1x6jU4SL7vXqSGGM
         YZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84tZbwJ4gyNVlf5hk3NJPVLW/b6QK1wKjnVI/y9pSRM=;
        b=WJ0Rb9XrcMF6UlMpC2CT56hMI8zM7c+Yol2UIfv1Luj06eoh6AfGLR5vdJV7abeYYz
         sz2KGFvwdW7imXxnOYrJW+8cfbCkPF6u+5iCcOMqAamLhyE+oTnGs+0Ql3JrgBfrp6ai
         zqbdZqZ/yNQnOfI42+w9l+pMM8jqzzfav0okqlI20uAMnwFX30XkmEq4OhNXQnoQ9YpZ
         Loz4WSb82179Tyw97ak0fpEuqahd3jdbDuQMMZs9/koqUg+BbU/QIjvX1GuhZmwV8kCM
         p3UHx017Y5t0Q3SGBl/zEnH/eLk8kWu5guc7nLBFzjHkLGpPw4pKnMASyQP2peRz73yk
         erhQ==
X-Gm-Message-State: AOAM531L3pBfoveFfZck6wPNNCiOjFW9ND+Qay3kIWZ6CIlCLJ+HyXTR
        rEmitpxteFmMWM0ZN+ZD2CKYkD38raI=
X-Google-Smtp-Source: ABdhPJze5XD8LX9kjdU6gzusGepQzk00FSwG4yemZBCUKMPtlRHLtJCvMw+mIFtB+/PqaWYXckxeyg==
X-Received: by 2002:a05:620a:2227:: with SMTP id n7mr6970729qkh.153.1609984851991;
        Wed, 06 Jan 2021 18:00:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id n66sm2411618qkn.136.2021.01.06.18.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 18:00:51 -0800 (PST)
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
 <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
 <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
 <xmqqa6tmtrr1.fsf@gitster.c.googlers.com>
 <3be0a434-d29f-a7b5-fb46-bb1fc1649d27@gmail.com>
 <xmqq1rexssqp.fsf@gitster.c.googlers.com>
 <xmqqv9c9pwv0.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <441209e0-2102-b055-867a-1b4747499181@gmail.com>
Date:   Wed, 6 Jan 2021 21:00:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9c9pwv0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 4:40 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>>> I wonder if "false" or "exit 1" would fit the bill.  In any case, a
>>>> comment may help, perhaps?
>>>>
>>>> 	test_expect_success 'do nothing and succeed on empty/missing config' '
>>>> 		# if this runs even once, "false" ensures a failure
>>>> 		git for-each-repo --config=bogus.config -- false
>>>> 	'
>>>
>>> I can add a comment, but keep in mind that this example would run the
>>> subcommand as "git false". This isn't intended as an arbitrary script
>>> runner, but a "please run the same Git command on a list of repos".
>>
>> Ah, that is a good point.
>>
>> The comment needs to explain:
>>
>> 	# the command fails if it attempts to run even once because
>> 	# 'git false' does not exist
>>
>> and at that point, it does not have to be spelled 'false'.  It could
>> be 'no-such-git-subcommand' (and I wonder if that makes the comment
>> unnecessary).
>>
>> That reminds me.  If I have ~/bin/git-false and ~/bin on my $PATH,
>> would this test fail to catch breakage?
> 
> Yes, I think $PATH in the test environment starts from the original
> $PATH and modified only by prepending, so my ~/bin/git-false would
> kick in.  We cannot reliably depend on the absence of a subcommand.
> 
> We can instead use
> 
> 	# the whole thing would fail if for-each-ref iterated even
> 	# once, because 'git help --no-such-option' would fail
> 	git for-each-ref --config=<var> -- help --no-such-option
> 
> and I think that would be much more reliable; if an invocation of
> "git help" inside our test suite fails to refer to the "git help"
> from the version of Git being tested, we already have a serious
> problem.

A very good point. I'll include this in v3.

Thanks,
-Stolee
