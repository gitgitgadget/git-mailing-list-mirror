Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3E22078A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 19:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAtElvt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZTEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgHZTEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 15:04:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AE2C061574
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 12:04:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so3131226qkd.6
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 12:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7TnAT6GqQbU+0jOCYPa5rn8xR0W6hzP+VN/gXhQhmI=;
        b=MAtElvt9OJyZoaAMy1HHeapoDSSGA8YEfN5CPS4HwoXjgZMACxswY7fKsQUa3ydb8+
         aPWzikBk+vcDieBNRqbaWf09puuVkDMTXs7kXMWZ0kGz0wXo8Hhb5QlgYCnpkmr/Zak+
         eWTYqnaWxooV4RpNKdXmaVhOggTDlt4tVkQ7PadmXeG1g3aYSM6Wuk34cWSUhLjwCDtP
         qrEU7+mzS5EWc9HRXaPCRuowIrBYzWhbjM4Z+viAZdsDRzX6idkRk4aX7G3H0be0NxtH
         DSY5xoIsm6IT1I/fxA3V8d0YVlRc1Dqdse92lJSn3hPtqEtWxQvd51g5PNtHW5z2UVGO
         zgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7TnAT6GqQbU+0jOCYPa5rn8xR0W6hzP+VN/gXhQhmI=;
        b=dF6SKtBJGMUDvoMBXwRhsjlvnEvBq7FSbvabXJ0AGaKgBC5rTJlUEHjrmATQ4jH1Lk
         u944Jue+NdzO5tztI2XVCmewLTQdcAc02vR+2eL0SsLLgePvHP2yup1e4ilBBr0nGTkz
         8JSBIEG0PmWMV1CTqG5odylz9spnacGGfj3BIE98rQ2+awHUmXsBm0SyuTEYdAP+l28A
         S0UCF/27HWyg3qGbqsK4QJoezR5Homwu0XA+oNan5hC5RzZoaS5UEm4v5EeRMLIXnHI2
         0KjFJgKvV0MFN8P8nWUTdWmiOfy4EBGU6NjdbxwO2KneKstmxffrGJqObFxSuQnOLI3U
         nkkw==
X-Gm-Message-State: AOAM5306QwRngL2ezL603MRajMskilFldLyIQTHzH+5Jjm7pCtXKA+W9
        n2sgMjgueQUGzYrKRhaVPyI=
X-Google-Smtp-Source: ABdhPJxpafjOUXcZMCZ3a8ZndOc6ed93WEYgUgnKv/N7NfWFGgZiO/cnCxL3oC2jHz+lzIitwvsy3Q==
X-Received: by 2002:a37:b247:: with SMTP id b68mr1327364qkf.90.1598468673806;
        Wed, 26 Aug 2020 12:04:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id j31sm1585055qta.6.2020.08.26.12.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 12:04:32 -0700 (PDT)
Subject: Re: [PATCH] clone: add remote.cloneDefault config option
To:     Junio C Hamano <gitster@pobox.com>,
        Sean Barag via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Barag <sean@barag.org>
References: <pull.710.git.1598456751674.gitgitgadget@gmail.com>
 <xmqqlfi1utwi.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eeebff99-d585-5575-009e-83bfef5294e3@gmail.com>
Date:   Wed, 26 Aug 2020 15:04:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfi1utwi.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/26/2020 2:46 PM, Junio C Hamano wrote:
> "Sean Barag via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> This commit implements
>> `remote.cloneDefault` as a parallel to `remote.pushDefault`,
>> with prioritized name resolution:
> 
> I highly doubt that .cloneDefault is a good name.  After reading
> only the title of the patch e-mail, i.e. when the only available
> information on the change available to me was the name of the
> configuration variable and the fact that it pertains to the command
> "git clone", I thought it is to specify a URL, from which "git
> clone" without the URL would clone from that single repository.
> 
> And the name will cause the same misunderstanding to normal users,
> not just to reviewers of your patch, after this change hits a future
> Git release.
> 
> Taking a parallel from init.defaultBranchName, I would probably call
> it clone.defaultUpstreamName if I were writing this feature.

I was thinking "clone.defaultRemoteName" makes it clear we are naming
the remote for the provided <url> in the command. Having

	clone.defaultUpstreamName = upstream

may look a bit confusing, while

	clone.defaultRemoteName = upstream

makes it a bit clearer that we will set

	remote.upstream.url = <url>

>> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
>> index e69427f881..8aac67b385 100755
>> --- a/t/t5606-clone-options.sh
>> +++ b/t/t5606-clone-options.sh
>> @@ -19,6 +19,20 @@ test_expect_success 'clone -o' '
>>  
>>  '
>>  
>> +test_expect_success 'clone respects remote.cloneDefault' '
>> +
>> +	git -c remote.cloneDefault=bar clone parent clone-config &&
>> +	(cd clone-config && git rev-parse --verify refs/remotes/bar/master)
>> +
>> +'
>> +
>> +test_expect_success 'clone chooses correct remote name' '
>> +
>> +	git -c remote.cloneDefault=bar clone -o foo parent clone-o-and-config &&
>> +	(cd clone-o-and-config && git rev-parse --verify refs/remotes/foo/master)
>> +
>> +'
> 
> These two are "showing off my shiny new toy" tests, which are
> needed, but we also need negative tests where the shiny new toy does
> not kick in when it should not.  For example
> 
> 	git -c remote.cloneDefault="bad.../...name" clone parent
> 
> should fail, no?

This is an important suggestion.

Thanks,
-Stolee

