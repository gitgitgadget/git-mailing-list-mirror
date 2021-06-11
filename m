Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4967AC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A90260FEB
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhFKJWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 05:22:12 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36407 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhFKJWL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 05:22:11 -0400
Received: by mail-wr1-f43.google.com with SMTP id e11so5288482wrg.3
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 02:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cfe+VfiXCO7GPixa4EJMat0NABHLVQ13rPk82EWD67M=;
        b=A/zuVun8SJGhIUubmQte2l++z4Fq4esh9191Q4BG72Fw3PUgY3Cvi7BfISV6OLEpGo
         9wXaw+59NJ2H+Dnb3ZFHiItYce3PjJoospAD3Ed3TDFC9axAFDQhpvGmrWjc/i9+767M
         c0SD3I62l0XlcNcbhQNj4y+ArasUj+nCowxcaCueFG7Eta+Cz8GgMmhsP39pDOzviT3R
         bDNMo8PS3Qa3ksB+8Dcp0oV3x64+is03S8TLoLIWeEEvAR+Z+OSFJxSTjwfgGcw0Vkhx
         JjAsB9V/IEfPFIlFpMz5WtAD0nr1WjyN7sfR/Vg7I/ITPr6RTpRzDqTjraCWMn/ZV/s5
         3T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cfe+VfiXCO7GPixa4EJMat0NABHLVQ13rPk82EWD67M=;
        b=cOiJ8BdllFiceITkoYRnq+t5GDUlmjwg+cP3D49scNIhYShGNhkqxBkZfExko5LUCp
         /+aOH3p265Oleoh/1tv9LF8GRJJDr24ATgmFTPddHt5aoWvOLBeXO/uxh/fUL0biP9gU
         pAX/zFa63D3HyvHNGSWY8D8H3UQn/6SvLbFJx8h3OLukeZqcUtWanXJQS3y2WID+n+3g
         M2pPJF6xtQonT+Jd5Fv50/ejQ5vkxlN881wIY8S9LGQlWI9S1CF25M8/Rflhw7VGX8zp
         dHg7T2veXBclEgb/zAPEJJ9o8WavvY9PsptvZ39XmZHjvgq6lfojjE3Gt5ADyf7bFhFv
         aiEA==
X-Gm-Message-State: AOAM53046co7fpJcj8dr3paXyU0/xgi8vmL++irWbSSyMMLXiNW9THea
        v35izzkmXr+De6K7txtqSYY=
X-Google-Smtp-Source: ABdhPJzg9Y5Kbm6LnHDiTnjOpTLpeupzLbg+3AeAM11G3qmjFaAwco/tzy6yuj44Hy34WCP9n+mZXw==
X-Received: by 2002:a5d:6e92:: with SMTP id k18mr2954293wrz.94.1623403153119;
        Fri, 11 Jun 2021 02:19:13 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id o18sm6387203wrx.59.2021.06.11.02.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:19:12 -0700 (PDT)
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
 <bef8e373-20d8-3545-ba43-00108b2e77df@gmail.com>
 <60c2420a2dd73_b25b1208f1@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <0975b12c-82e1-344c-e09f-37f568c10514@gmail.com>
Date:   Fri, 11 Jun 2021 10:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60c2420a2dd73_b25b1208f1@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 17:47, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 10/06/2021 14:26, Felipe Contreras wrote:
>>> Phillip Wood wrote:
>>>> On 09/06/2021 20:28, Felipe Contreras wrote:
>>>>> We want to test different combinations of merge.conflictstyle, and a new
>>>>> file is the best place to do that.
>>>> [...]
>>>>> diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
>>>>> new file mode 100755
>>>
>>>>> +test_expect_success 'merge' '
>>>>> +	test_create_repo merge &&
>>>>> +	(
>>>>> +		cd merge &&
>>>>> +
>>>>> +		fill 1 2 3 >content &&
>>>>> +		git add content &&
>>>>> +		git commit -m base &&
>>>>> +
>>>>> +		git checkout -b r &&
>>>>> +		echo six >>content &&
>>>>> +		git commit -a -m right &&
>>>>> +
>>>>> +		git checkout master &&
>>>>> +		echo 7 >>content &&
>>>>> +		git commit -a -m left &&
>>>>> +
>>>>> +		test_must_fail git merge r &&
>>>>> +		! grep -E "\|+" content &&
>>>>
>>>> ! grep "|"  would be simpler and just as effective.
>>>
>>> But that would fail if there's a "command1 | command2".
>>
>> I don't understand. What are you expecting content to contain?
> 
> Not a sequence of |.
> 
>> Why doesn't "\|+" fail in that case?
> 
> It would, perhaps "\|\|+" would be better, or maybe "\|{2,}".

The point of my original comment was that you do not need an ERE - 'grep 
"||"' matches the same set of lines as 'grep -E "\|\|+"'. As it is 
testing for conflict markers anchoring the pattern to the beginning of a 
line would probably be a good idea.

Best Wishes

Phillip

>>>> This is quite a weak
>>>> test, something like "^|||||| " would be a stronger test for conflict
>>>> markers
>>>
>>> But that doesn't work in all the tests.
>>
>> So test for what you actually expect, you don't need to have the same
>> check in all the tests if the expected output is different.
> 
> I don't need to, but it makes the tests simpler, and as you pointed out
> in another comment: more tests are needed.
> 
> Perhaps once we know exactly what we want to test, and how to fix the
> current issues it would make sense to revisit these.
> 
