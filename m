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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D78C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEBA610E6
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 14:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFJPBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:01:43 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:40551 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhFJPBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:01:42 -0400
Received: by mail-wr1-f43.google.com with SMTP id y7so2674064wrh.7
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Mvr9Kyzb53GDSXlxuuaEYNszOBEfM8KJPEDfmHjDslE=;
        b=uZUtnm7PRkM4qUCzBTEsjatoMT+L5pyV9G0w5LzpmRUaqYYKk/GD5oxdR+UwPMOw7P
         /STrp92JA0SElj5aRsEcB1DiEM3ORZkU6CwM/aDeR33xaLyIxve3utc+tzTm+JiumKs+
         cO5zXp/zzl/yuEASMnyOYAsMCJP0JBtLrwZtTbZ7YbEFhgk0UN3Pb73iDgyF9I+eGi+y
         TjppqxNhNVB5KuHNc3JdV8PdzW724MZAQKZL9a/PY/zJAq20ED4XDEAFT9iXwQi/nv7V
         6L3qwFuFbH6CXNl5p5ARe2P9zIPh6eHzfSB2f8zOxOAI4MoifSLHvK+W2foX/Np8zPkp
         Q7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Mvr9Kyzb53GDSXlxuuaEYNszOBEfM8KJPEDfmHjDslE=;
        b=nU0HUFEpfYWvtjcfeyoJKhtENGM4cCGgxRMu9GsXog7Tu8HPcnJwu5C0YCWY8yAXDc
         HMj4e96Vkbhj77Xi2kHozBJITGRJo/JV7k3UoWAiO1967K58g75t8QA3YX4bjyKV/HUC
         61jrO84wRTUAKCYGubldCmIvOoTagwqY/EJwiH68NmLS8rimxFhwLQtWKWqbfGlAZA+G
         z+6PwUJVacFW2PJejgYoUybjfaKgUB8DfMA9ZjylZeVR+RgeKgeLPRmNj9xQ4QHTmIUl
         qJiqQ/Vfr3mr+Jr0D4DAJkra7EwiRzuhLfzKnPFD9PKpf6Gss5eZxStN8NK/8bWMotKB
         Zzdw==
X-Gm-Message-State: AOAM531yfDJHzhMPiB4rTGYvuHJNnOYkYZ27nqUkdRxPyLE4uM6NtcSr
        IfJQS5VN4/mm41Ly6VpWLck=
X-Google-Smtp-Source: ABdhPJzTXxso5gp3TRgFvinsyhP11qoF/RjywywmzDoTuri3evo4ypxj3cggxpVYKggClLPLaMqVig==
X-Received: by 2002:adf:ab49:: with SMTP id r9mr5991802wrc.237.1623337113265;
        Thu, 10 Jun 2021 07:58:33 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id o5sm3947762wrw.65.2021.06.10.07.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 07:58:32 -0700 (PDT)
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
Message-ID: <bef8e373-20d8-3545-ba43-00108b2e77df@gmail.com>
Date:   Thu, 10 Jun 2021 15:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <60c2130178831_b25b1208f5@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2021 14:26, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 09/06/2021 20:28, Felipe Contreras wrote:
>>> We want to test different combinations of merge.conflictstyle, and a new
>>> file is the best place to do that.
>>[...]
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

I don't understand. What are you expecting content to contain? Why 
doesn't "\|+" fail in that case?

>> This is quite a weak
>> test, something like "^|||||| " would be a stronger test for conflict
>> markers
> 
> But that doesn't work in all the tests.

So test for what you actually expect, you don't need to have the same 
check in all the tests if the expected output is different.

Best Wishes

Phillip

> Cheers.
> 
