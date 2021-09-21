Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C95C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDE660E08
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhIUNIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhIUNIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:08:30 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3FC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:07:02 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id a9so5516548qvf.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJUreX4sM0sShX95+nbIkeyNwVYn6pqvho34y3jWrwI=;
        b=Hm74q5Emtkb5OHtJ/NZA50L0H/GBY2IM91NC0YLrbNN0rKBULOitE2Ills3v9iVm3r
         /y5D88GscPg09w9d03Ykn56K+dT32mgTsdRTKXlwRG3AGT9DbwOYi3u8Syoy73aSWF7Y
         5qpgODvUQkSHsu7nLatuAVSIiLfXJjM3Au5TjnzcYxCBa6KuVYLTDycBTjofXM8jQstP
         nZHBIiJJf5+Pjh/V+71FKGlj+FfIUAaR3cXs0pbaaQdn8J/Ii8GuYO0lBBhlt7hxqQ3q
         KWKWK6yCnF5nKpd/qakcUyYPXMY9THUuAVzPIyt6qVJPOpu5s4VzcETgFfIBy4b5HSL0
         T8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJUreX4sM0sShX95+nbIkeyNwVYn6pqvho34y3jWrwI=;
        b=AhnqMvwsnGbBvU2F2ucn7O2EZoZowkq6WqxVK/y3LzLHhSncl9nh2cWYqjasu80n1P
         Obn9U33BV+bkmxLvH/5SiQqJYgnm5wtFEaE59gPyi0OmwbIiQUce0T44nyUF/YApVAI5
         c7JdFTNWTeCTA3D9prS9Gc3RqI7L0Jgvl8zLN6Sv0zIcA6M/rW22Sz4oTON6/NMOoohx
         u5zK1GwYT8BqdkmhZi+VnfkIkNcXQlv0IWZOkHx6EAGtf+adXQTGIbx//vXdc6HAe5dY
         D5Pj0q2z8o61KrSY8tHk4zajpmjZyEoPBHOnhF30kLMwpL0uVG7ggEFrNIEwFUrWSL31
         wSRA==
X-Gm-Message-State: AOAM530vJisJybZYkjZZdbcic+oK70nC9XcnPjd9mxjTqndsYqxzi/1N
        mikIs4nQK/40ZcAl0QEX9Wk=
X-Google-Smtp-Source: ABdhPJzpbKPS7dTr/k7EHTP8U+16SXWY8pIvwYXbwvOBsO+bISgpGEooDcz2mEq0/a1pGWP8xKFzxw==
X-Received: by 2002:ad4:4947:: with SMTP id o7mr20625122qvy.6.1632229621284;
        Tue, 21 Sep 2021 06:07:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ace4:98aa:c023:6ae9? ([2600:1700:e72:80a0:ace4:98aa:c023:6ae9])
        by smtp.gmail.com with ESMTPSA id q192sm13724256qka.93.2021.09.21.06.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 06:07:00 -0700 (PDT)
Subject: Re: [PATCH 1/3] sparse-checkout: fix OOM error with mixed patterns
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, calbabreaker@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1043.git.1632160658.gitgitgadget@gmail.com>
 <d90937b9ac9aaa6170f56d18ddb7a327b2af27d6.1632160658.git.gitgitgadget@gmail.com>
 <YUjRziaIoVtJWGsS@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6d565e1d-a31f-7cf0-9c10-a01a87fead41@gmail.com>
Date:   Tue, 21 Sep 2021 09:06:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUjRziaIoVtJWGsS@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 2:24 PM, Taylor Blau wrote:
> On Mon, Sep 20, 2021 at 05:57:36PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> Add a test to t1091-sparse-checkout-builtin.sh that would result in an
>> infinite loop and out-of-memory error before this change. The issue
>> relies on having non-cone-mode patterns while trying to modify the
>> patterns in cone-mode.
>>
>> The fix is simple, allowing us to break from the loop when the input
>> path does not contain a slash, as the "dir" pattern we added does not.
>>
>> This is only a fix to the critical out-of-memory error. A better
>> response to such a strange state will follow in a later change.
>>
>> Reported-by: Calbabreaker <calbabreaker@gmail.com>
>> Helped-by: Taylor Blau <me@ttaylorr.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  builtin/sparse-checkout.c          | 2 +-
>>  t/t1091-sparse-checkout-builtin.sh | 8 ++++++++
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
>> index 8ba9f13787b..b45fd97a98b 100644
>> --- a/builtin/sparse-checkout.c
>> +++ b/builtin/sparse-checkout.c
>> @@ -389,7 +389,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
>>  		char *oldpattern = e->pattern;
>>  		size_t newlen;
>>
>> -		if (slash == e->pattern)
>> +		if (!slash || slash == e->pattern)
>>  			break;
> 
> If we are preparing to make it so that we do not blindly copy patterns
> from a sparse checkout without cone mode enabled, then wouldn't this new
> case be a BUG()?
> 
> Of course, users could still tweak the contents of their sparse-checkout
> file as they wish, but I'd expect that we'd catch those cases, too
> (i.e., by validating the contents of the existing sparse-checkout before
> calling this function).

If I was more confident that we were catching absolutely every possible
case of non-cone mode patterns in our parsing logic, then I suppose a BUG()
could apply here. At minimum, at this point in time (before fixing the gap
in parsing in patch 3) the test below would not even work with test_must_fail,
since the exit code would be unexpected.
 
>> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
>> index 38fc8340f5c..a429d2cc671 100755
>> --- a/t/t1091-sparse-checkout-builtin.sh
>> +++ b/t/t1091-sparse-checkout-builtin.sh
>> @@ -103,6 +103,14 @@ test_expect_success 'clone --sparse' '
>>  	check_files clone a
>>  '
>>
>> +test_expect_success 'switching to cone mode with non-cone mode patterns' '
>> +	git init bad-patterns &&
>> +	git -C bad-patterns sparse-checkout init &&
>> +	git -C bad-patterns sparse-checkout add dir &&
>> +	git -C bad-patterns config core.sparseCheckoutCone true &&
> 
> Makes sense that we'd want to update the config rather than call "init
> --cone" here, since a subsequent patch would change the thing that this
> is testing (from "doesn't OOM in the above-described situation" to
> "clears the existing contents of your sparse-checkout").
>
>> +	git -C bad-patterns sparse-checkout add dir
>> +'
>> +
> 
> In other series I've suggested a cosmetic change to move all of these to
> a sub-shell that begins with "cd bad-patterns &&", but obviously that is
> a relatively unimportant suggestion.

The only defense I have for not using a subshell and 'cd' is that later
I can use an "expect" file in my current directory without it being "in"
the repository. It doesn't really matter for this example, but it has in
the past, causing me to do this by habit. A tab is smaller than the string
" -C bad-patterns", so it's probably worth changing.

Thanks,
-Stolee
