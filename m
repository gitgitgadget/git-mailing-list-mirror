Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2378CC0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 09:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbjHKJ4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHKJ4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 05:56:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5632419E
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 02:56:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe2d218eedso16857185e9.0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691747803; x=1692352603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1gfkg6fzBreU7m1xgaLINzSgSgCzYBA0gwUkn+ftM88=;
        b=jnp5bVuLe4a6jvLjT8btGhRJLJKJxV+DTC10rpGFRk/CFWS+Q6I77PxIUtnShdzcoM
         ZyKYLNrpR5GnAuV/0pg6JHwKSKPYhr3ujMb9ztUY3tlO2fNCNx+lNkZgmIDHtl9yaeIx
         Rdb1jrdMWnM9B7m3MuWH12ETeBHKXUAALpwGWUqwW9NoBAA6pB2jNLRJnbHW0sOPz0Le
         z5TT80NIdZaYQhN1TfDOZqsHTWjWMaZUQBJ8Ac3bMU36IDH9T4a8Nuoes9g5NvvOXztc
         piP/NCC5yLZls7rJWETGB+YLk0+2OvEMUZ3OFz1mPjAQDNGHsnL/lvCEF8XFQd5SJOBH
         XzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691747803; x=1692352603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gfkg6fzBreU7m1xgaLINzSgSgCzYBA0gwUkn+ftM88=;
        b=GYCbqKNOn4OVNx6t6CzbmyYA4Lt5eUcXXJ/3IZ2E2lGKUZIT5MK324uc3Xl5femmal
         LiP8+iFkO2Ut3661ZQfI0q7MPJxSif8U4/rf/BSXMXiiESTM2L+mgsWK60k3NrTf9i3Y
         4BKx9qWfmeV41eUpZ7qQ+0nBFBgM0VoW5YghkBHLtEvGqWjpB+qbSAX4crutuZ0X/6yQ
         K9Cn5V6rXFt2AMzTiqD7OPRmczNW3j7wnNRqGjnz+Udczv3d+I53UxvfaHy6yBG+93FH
         v4CIRiD7nZZovsKtK+MUNbSZUbXj7mJr9S2QPBsllNVoP9VTQ7plsAfc2wVHHopcb3yK
         LQQA==
X-Gm-Message-State: AOJu0YwpF8WPjCjWfu3Hz6rKPXRNBFVNc8zXNqvzEb5wVVUPo9x/mTuY
        CZwK16dgRBcSfRTf/IGJTGw=
X-Google-Smtp-Source: AGHT+IEUJfhJR9/+Va+aRcx6K14l3KosvzmsS5bULPpAUSFiw3DIsxe5g+/htKN8d7RJLx+APXnJsA==
X-Received: by 2002:a05:600c:215a:b0:3fe:4900:dba8 with SMTP id v26-20020a05600c215a00b003fe4900dba8mr1185731wml.9.1691747802509;
        Fri, 11 Aug 2023 02:56:42 -0700 (PDT)
Received: from [192.168.1.116] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id z15-20020a05600c114f00b003fe2bea77ccsm4735402wmz.5.2023.08.11.02.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 02:56:42 -0700 (PDT)
Message-ID: <2d9e9b59-bf78-8470-0731-3cd7fe15a727@gmail.com>
Date:   Fri, 11 Aug 2023 10:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] t4053: avoid race when killing background processes
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1571.git.1691677993195.gitgitgadget@gmail.com>
 <xmqqedkassng.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqedkassng.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2023 18:40, Junio C Hamano wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
 >
> While I can see that "kill" in the when-finished handler may or may
> not find the backgrounded process by the time it is run, and
> ignoring its exit status (hence keeping test_when_finished happy)
> would be a reasonable thing to do.  I can understand if this patch
> is to fix a different symptom, namely, when-finished handler
> sometimes fails and makes the test fail.
> 
> But I am not sure how this causes the test to "hang", 


This is only a fix for the test failure that Peff saw when running with 
--stress.

> which
> presumably is a symptom that somebody is trying to read from
> a pipe that nobody is making progress to write into?

That or a process blocking when tying to open a fifo seems the mostly 
likely cause but I can't see where that is happening. As you say this 
patch does not obviously change anything that would be causing the test 
to hang.

Best Wishes

Phillip

>  We will
> send a signal either way to the writers, and the only difference is
> that we ignore the exit code.
> 
> Granted, when-finished handlers are concatenated with "&&-", and one
> "kill"s failure will cause the other "kill" not to run, so we may
> send a signal to only one but not to the other, but that should all
> happen after "diff --no-index" returns, so it still does not explain
> the "hang".
> 
> Puzzled...

>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1571%2Fphillipwood%2Fdiff-no-index-pipes-fixes-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1571/phillipwood/diff-no-index-pipes-fixes-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1571
>>
>>   t/t4053-diff-no-index.sh | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
>> index a28b9ff2434..1fb7d334620 100755
>> --- a/t/t4053-diff-no-index.sh
>> +++ b/t/t4053-diff-no-index.sh
>> @@ -248,11 +248,11 @@ test_expect_success PIPE,SYMLINKS 'diff --no-index reads from pipes' '
>>   	{
>>   		(test_write_lines a b c >old) &
>>   	} &&
>> -	test_when_finished "! kill $!" &&
>> +	test_when_finished "kill $! || :" &&
>>   	{
>>   		(test_write_lines a x c >new) &
>>   	} &&
>> -	test_when_finished "! kill $!" &&
>> +	test_when_finished "kill $! || :" &&
>>   
>>   	cat >expect <<-EOF &&
>>   	diff --git a/old b/new-link
>>
>> base-commit: a82fb66fed250e16d3010c75404503bea3f0ab61
