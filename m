Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDA1C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1401C610E6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhFJO5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 10:57:40 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:42920 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhFJO5k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 10:57:40 -0400
Received: by mail-wr1-f52.google.com with SMTP id c5so2655218wrq.9
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iyjxbnV/SrElcXxbEScj/Olk1dhfBzQYpAQKq8jYmfY=;
        b=KRiRgGWDNzFhzBkU6H/E0JeXxb+EWngdH+SE0i7wWM7NLyjkHZKR6ucmZ7RD1gbCzs
         JVyRKvUQVxiyKO0/LhavqRnFR4NwZjpSlmLZx+6YabbWRjuWLk3/EezB3OTPmly6A+RA
         1IE+NgLl/K8lKDIAXyU0nLMHBtukkXLMRUCtrzKsGMwZE5pb0kyEtiXsVXmgOdgmeV5G
         BI00tRFWW6WglykOaTa2IwZSwz72+tDcqdvSy0xUE1aLTfohBqhUxx2FzKuxRp+hbhxP
         yrjJ92h5Tzt5pijPpl3qEtS8h0zDRYMN04z3kgcoYJOmWbmAMRWI6Ag2QR5Nr+ZG9uGd
         oviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iyjxbnV/SrElcXxbEScj/Olk1dhfBzQYpAQKq8jYmfY=;
        b=BZxGA7LQDADgM3Uo0cHgZ+fdej9ck6llYO6z4kySdXi2XUh3ppFQCvmQEbV44RPlZQ
         e3QshW9j+DQIKoT5plr0suwDEZnWTR/QvX+8Xa9mFWuxqwqRl4Rb9AKn/UbZmstOkvoD
         K+/GL5tguLOrA8ZHgTxrzC+fyv/YwNAQ3Dr8KU4+nmeITpCQl4zWZCEnGyCbJ5q1/1KV
         X8HIDMN7B4tMrrO2PCpf4hNAJI6/Um/UbyigybjCRx5hEa4nKWZIFtN7FXI1OSv/Vx0S
         0V3raZttPC8wQ2EaN3GUw+vEZ9e26plyKVyNXobyFGjOyxLDzm6AFwOY9ScLdSnXGev3
         kDZw==
X-Gm-Message-State: AOAM532Bs+tSAi+ZyvG5uWqFkTfLOGZtayrSCkeJ33DqeDxjGoRSSLyJ
        j5CaMW7UowFhbR2vNrA5GZ8=
X-Google-Smtp-Source: ABdhPJygwrhqVfWA7IXAMEwWh6ZSD1cA0SP5BEo8lOKKotvCH9TFYCBIheFkfb4Bd6jz8kRtKhnJGQ==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr6026135wrq.132.1623336883312;
        Thu, 10 Jun 2021 07:54:43 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id u15sm8488805wmq.1.2021.06.10.07.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 07:54:42 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/7] test: add merge style config test
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <b2436790-bbf0-2623-5e29-a6f6b4959974@gmail.com>
 <60c2130178831_b25b1208f5@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a819dd7d-e690-baa7-b6c8-2b1fabe51522@gmail.com>
Date:   Thu, 10 Jun 2021 15:54:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60c2130178831_b25b1208f5@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 14:26, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 09/06/2021 20:28, Felipe Contreras wrote:
>>> We want to test different combinations of merge.conflictstyle, and a new
>>> file is the best place to do that.
>>
>> I'm not sure what this particular tests adds over the existing ones in
>> t6427-diff3-conflict-markers.sh.
> 
> That file is for diff3 conflict markers. The tests in this file are not.
> 
>> The commit message does not explain why a new file is better than
>> adding this test to that file.
> 
> Because there's no file that is testing for this.
> 
>> There are already diff3 tests for checkout
> 
> This file is not doing diff3 tests.
> 
> 
> As stated above, it's testing different *combinations* of
> merge.conflictstyle, diff3 is only *one* of the possibilities, another
> possibility is:
> 
>    git -c merge.conflictstyle=diff3 checkout -m --conflict=merge
> 
> That is *not* a diff3 test.

I think that is an artificial distinction, it is testing the behavior of 
checkout when merge.conflictStyle=diff3 just like the other tests, it 
just happens to be checking that the config option can be combined with 
a command line option.

Best Wishes

Phillip

>>> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
>>> new file mode 100755
> 
>>> +test_expect_success 'merge' '
>>> +	test_create_repo merge &&
>>> +	(
>>> +		cd merge &&
>>> +
>>> +		fill 1 2 3 >content &&
>>> +		git add content &&
>>> +		git commit -m base &&
>>> +
>>> +		git checkout -b r &&
>>> +		echo six >>content &&
>>> +		git commit -a -m right &&
>>> +
>>> +		git checkout master &&
>>> +		echo 7 >>content &&
>>> +		git commit -a -m left &&
>>> +
>>> +		test_must_fail git merge r &&
>>> +		! grep -E "\|+" content &&
>>
>> ! grep "|"  would be simpler and just as effective.
> 
> But that would fail if there's a "command1 | command2".
> 
>> This is quite a weak
>> test, something like "^|||||| " would be a stronger test for conflict
>> markers
> 
> But that doesn't work in all the tests.
> 
> Cheers.
> 
