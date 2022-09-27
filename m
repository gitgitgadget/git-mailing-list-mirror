Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAFBC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 11:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbiI0Lyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiI0Lyl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 07:54:41 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2BC49B5F
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:54:40 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id v1so4979589ilq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f1u4YzoKeqG8aa/07UisA+2KvRYUxyTz0cDZ3A+AjsE=;
        b=BsTvhyVpCuRelm75a7K9T11ECiTvAtU57dD1VrHOln0uWvnNhQTOuRLOYQZeg6+WSI
         /Sj+ZVP5ycxhupxPwDmahB8AiKM668EkAUDNBM8bvpZIz58/4elxZM+g4Eo/kYf3SHKC
         5pjqagzbleCea+G+3upSdK33d2vH7nqXq+HyWmS8u/+BcWl7mTPQCK5ucXuFCGBx1xHc
         qok1I0kHRsc0yHES5GhLAz5ri1fkAfsEcQfrd0uVLu+rwd2E4dDs+9tIW34xtOdVuvho
         z/idaARQzMMy+AbTXwhQJaz/bt/z11kWZcsVwkT8EGYG1lNTa2Nx6Mc1hFWrAJMxuLMs
         ykdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f1u4YzoKeqG8aa/07UisA+2KvRYUxyTz0cDZ3A+AjsE=;
        b=Yh3IfKpER8MO1RohLa7Qm77y7AKDX25LDHbcel24UvjTbB7kEU4QmbCyYpRDaho9LF
         b1NVP2eqU8Ms00WxSjeFYZmHrh7ZNbnm439mJpu8w9eyDwvkWEmn9+sY98IH+2uMvS2y
         SrAtwSAU+fC879YG546NJ6CCo77F/VoExUOuHwcVn1kqPjR71BjbzH1ChcjsyDHLxxwC
         6Lq7PWF746RBnFwEC2ceANx9fzL+gxHF8qG0jZce8tPUzvhJz+4slg08Iti1wD8GTkNH
         u3ODE3mWvakt6ZjVCvUsQUK4qHwNkPjXfEygwIWneUbZY7Dngkf5dZk8i0iuMUPMiBSi
         1wXw==
X-Gm-Message-State: ACrzQf0bfp4uU7EXZrGQLf1dQSPvzqQCKIx6Q8s0PPwACtst3zYOEJws
        6mDS38/dk3vWYoT3tqoasOlb
X-Google-Smtp-Source: AMsMyM6xS7N7TfjWJsigy7jGyhpitw1SXNveUH8XtSu4e7ueyyI5dnZ1QPPIxBXgaXZPJdkQ8RcxFg==
X-Received: by 2002:a05:6e02:1c8d:b0:2f8:a6a4:9b12 with SMTP id w13-20020a056e021c8d00b002f8a6a49b12mr2631246ill.179.1664279679800;
        Tue, 27 Sep 2022 04:54:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:6d75:31c0:4041:5d27? ([2600:1700:e72:80a0:6d75:31c0:4041:5d27])
        by smtp.gmail.com with ESMTPSA id m10-20020a02a14a000000b00346a98b0a76sm527109jah.77.2022.09.27.04.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 04:54:39 -0700 (PDT)
Message-ID: <63aa68fb-c215-a79f-e3c6-1c1a489220e2@github.com>
Date:   Tue, 27 Sep 2022 07:54:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
 <xmqqa66lby1w.fsf@gitster.g>
 <b1e6f118-046c-42f8-01a8-2543e792685a@github.com>
In-Reply-To: <b1e6f118-046c-42f8-01a8-2543e792685a@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 7:38 AM, Derrick Stolee wrote:
> On 9/26/2022 5:55 PM, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> @@ -1538,11 +1546,23 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
>>>  		usage_with_options(builtin_maintenance_unregister_usage,
>>>  				   options);
>>>  
>>> -	config_unset.git_cmd = 1;
>>> -	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
>>> -		     "--fixed-value", "maintenance.repo", maintpath, NULL);
>>> +	for_each_string_list_item(item, list) {
>>> +		if (!strcmp(maintpath, item->string)) {
>>> +			found = 1;
>>> +			break;
>>> +		}
>>> +	}
>>
>> Just out of curiosity, I ran this in a fresh repository and got a
>> segfault.
> 
> Yikes! Thanks for catching. I think there was another instance in
> the 'register' code that I caught by tests, but I appreciate you
> catching this one.
> 
>>  An attached patch obviously fixes it, but I am wondering
>> if a better "fix" is to teach for_each_string_list_item() that it is
>> perfectly reasonable to see a NULL passed to it as the list, which
>> is a mere special case that the caller has a string list with 0
>> items on it.
>>
>> Thoughts?
> 
> I agree that for_each_string_list_item() could handle NULL lists
> better, especially because it looks like a method and hides some
> details. Plus, wrapping the for-ish loop with an if statement is
> particularly ugly.
...
> I'll get a patch put together that changes the behavior of
> for_each_string_list_item() and adds the missing 'unregister' test
> so we can avoid this problem.

Of course, there is a reason why we don't check for NULL here,
and it's because -Werror=address complains when we use a non-pointer
value in the macro:

string-list.h:146:28: error: the address of ‘friendly_ref_names’ will always evaluate as ‘true’ [-Werror=address]
  146 |         for (item = (list) ? (list)->items : NULL;      \
      |

I tried searching for a way to suppress this error in a particular
case like this (perhaps using something like an attribute?), but I
couldn't find anything.

Thanks,
-Stolee
