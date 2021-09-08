Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8764C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C993F6056C
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 11:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351557AbhIHLpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 07:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351560AbhIHLpi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 07:45:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DD5C0613CF
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 04:44:30 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u4so1229224qvb.6
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 04:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wiNVEn6bY0ygoqDH0oifU+OqbDLpn0nKnUl7zG2qMlg=;
        b=lHRuBXaKlUMVTfQvUcz+sRHfbYTbUQi8uNdbzIn/zB7L1w1T1nvxgm6r77crxO1UVP
         4MvOerXxqOj/zjmXbQH+sADfz6iQ+nNzz0wLrqcsLwYhK/SVKJ7JV71Ph0G5EOiMFxl6
         DRBF04oZesSxASM2GAcVKVYR+v7S7+Mcz5a2oxGdnh5+BJoqVXUk+neLLsRQjXFGdFaf
         lNl/xNJDEOfw9kwbOjxIYsTRbHVRVQbbaKkcYL/19zwLOUzgedVOgdOBHsX63jyjIzLN
         TUjcu7Z2HXxrul+sY48HPUrw7ID7d1hRQHwQ5gpyyQ3gAVGaxBqZvrnIf4KZ15leHmEo
         2iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wiNVEn6bY0ygoqDH0oifU+OqbDLpn0nKnUl7zG2qMlg=;
        b=mJ2MQWKGGInfg0N8kwPC2skZG/+N6v+O4CqWDSTTmE7LZREZtfWr2Rj0NPPSQNiHTN
         S/7h/e7UoO70j7UBNq/SYKy1XLi51LTIZ8mW/owMdKlY/b99hrkgEXUo2lTcvorDhBa+
         HsSf0/PCcFRoQnETXyBySVUc/n9Fd1Z4yoAcPw5Y9BPxRguTtwDzOFfCNM9AtBzue/Qc
         otk9JaKbauADbZaiI+FjPdp8Fh9pw5y40rVZJXze+Ou8FqttqZy32pxQVc3OBfOMI2Ne
         nSmsmmPbVSIXyBfmZtlmfxCj4kjYj3YvRhkNJR6w098WcBxxEvdNkuy4Bmf07+OblzcA
         0tAw==
X-Gm-Message-State: AOAM531FOqA7mywEEgoGbMW8xgXcU0wbuQjU4g1TBky4uMxe+mLnAtrR
        aujnsiCoRW3IE9RNVsGzKnQ=
X-Google-Smtp-Source: ABdhPJyVrCk2GPD2jmfwXN9VefpuUg0wKlPXkGFxaxL4ud5zROP914IVfpXK4XiBlb/2PuTUgPyTLA==
X-Received: by 2002:a05:6214:504:: with SMTP id v4mr3382538qvw.49.1631101469697;
        Wed, 08 Sep 2021 04:44:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id e5sm1364806qts.0.2021.09.08.04.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 04:44:29 -0700 (PDT)
Subject: Re: [PATCH v10 0/3] maintenance: add support for systemd timers on
 Linux
From:   Derrick Stolee <stolee@gmail.com>
To:     =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20210827210255.12565-1-lenaic@lhuard.fr>
 <20210904205500.13074-1-lenaic@lhuard.fr>
 <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com>
Message-ID: <4c0c1fd4-f3f4-5e3a-abd2-0350c18b18b7@gmail.com>
Date:   Wed, 8 Sep 2021 07:44:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <28e0f22a-e9be-bb18-df0f-4d95cb6d5145@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2021 12:48 PM, Derrick Stolee wrote:
> On 9/4/2021 4:54 PM, Lénaïc Huard wrote:
>> Hello,
>>
>> Please find hereafter my updated patchset to add support for systemd
>> timers on Linux for the `git maintenance start` command.
>>
>> The only changes compared to the previous version are fixes for the
>> two typos in a comment that Ramsay Jones pointed out [1]
>>
>> [1] https://lore.kernel.org/git/51246c10-fe0b-b8e5-cdc3-54bdc6c8054e@ramsayjones.plus.com/
> 
> The changes in the most recent two versions look good to me.

I recently tested the 'seen' branch for an unrelated reason, but found
that the t7900-maintenance.sh test failed for me. It was during test 34,
'start and stop Linux/systemd maintenance' with the following issue:

  + systemd-analyze verify systemd/user/git-maintenance@.service
  Failed to create /user.slice/user-1000.slice/session-44.scope/init.scope control group: Permission denied
  Failed to initialize manager: Permission denied

Now, this test has the prereq SYSTEMD_ANALYZE, but for some reason this
later command fails for permission issues. I'm running Ubuntu, if that
helps.

Thanks,
-Stolee
