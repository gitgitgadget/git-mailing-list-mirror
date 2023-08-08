Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC888C04A6A
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbjHHS42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbjHHS4G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 14:56:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1D165079
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 10:15:00 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bd092cba5dso43473a34.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691514900; x=1692119700;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNW4ZM9zHslRXke0t9jCkf3ROqWpweRZJ3YXCC/bjpY=;
        b=j2UJSwUR3Wb61yyGjyX/aHxCpnDD1n8+Ah4PAuEYmLDgSDMs/YtQR6V9mxYObMzFqx
         MErxIkEv42HHrju4v8aAM86Lb0KLADOdLzuCa3abxZzXKxbzyycOq9stWJYI+/lpkUbc
         WRwKtxp4O0cBsUZ9B4/UT6KoRsy+aXkKBdZIY0bgkBUw8EoVeTPbuNQDIUuwvmLTji7W
         GfXXoXr+DBXLbhLGj8OMZ4W6xgd5EtOmW2baDCA9tEDnIUdOpLRGxzyo9Ob0dI54felH
         HDXKPbW52xN3WFQbvznFeFY2iC+fiA6xaPQh6t2zoaSy2zlbmurRH+6R+pQ3YKnu01Y7
         tCFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514900; x=1692119700;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNW4ZM9zHslRXke0t9jCkf3ROqWpweRZJ3YXCC/bjpY=;
        b=LQlq4WjESFgTfX9P+EwGYhN6022Br1y3sPM+4tKo0GejD3UZRkGum3BDieukBmgpBi
         mrelKIoecCujE2Qhwp8gKHKddEUF7QWC7Ii7bI7KbqFJnWKjtMh9PMHeV+mYhj8rXcuM
         j1UhnWUDex48eUYp1S4qbXTIAgVSP737fJethBubhimMgN0A3orqL6Jql3Lmq1JsNLVt
         giR9baHwLSwNuZZNgkdpvRp6DVYRRF8UrWQu4IO+KtOzpUN5fgOJx0s4YziNqAec6aHL
         JqXh+uRnDh5leMjnWQIvKgyv1zaBfiriCcpwXzcyAaivmUHV/IH4tBYg5DAfLY5WcHPo
         vRNQ==
X-Gm-Message-State: AOJu0YzEX2ntvZugOLeOTYgbBfHl6Vz41+Znk8UMUUk8qOkoTG6hxOw5
        rlDOJjPAVpdRvADDn4fWY/DQ
X-Google-Smtp-Source: AGHT+IGeuN92YsLHs4jHmWbERB8VVWBZ3rytQ00Ul8ZBmQ3KVSgmeSNu6vzixyvAloFKwavyGDkeiw==
X-Received: by 2002:a9d:785a:0:b0:6b7:3df3:bea6 with SMTP id c26-20020a9d785a000000b006b73df3bea6mr313345otm.14.1691514899943;
        Tue, 08 Aug 2023 10:14:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1d2:c14b:5536:5192? ([2600:1700:e72:80a0:f1d2:c14b:5536:5192])
        by smtp.gmail.com with ESMTPSA id s2-20020a9d7582000000b006b9b0a08fdasm6064003otk.59.2023.08.08.10.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 10:14:59 -0700 (PDT)
Message-ID: <2e9b32a8-8905-4a1f-a75b-ca747ae95b96@github.com>
Date:   Tue, 8 Aug 2023 13:14:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <3e254d61-b74a-f419-1a03-dbc557a9fe86@gmail.com>
 <d247ce48-e2ba-4915-8d96-1fa2f693909d@github.com>
In-Reply-To: <d247ce48-e2ba-4915-8d96-1fa2f693909d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/8/2023 1:06 PM, Derrick Stolee wrote:
> On 8/8/2023 8:08 AM, Phillip Wood wrote:
>> On 07/08/2023 19:51, Derrick Stolee via GitGitGadget wrote:

>>> +    char *local_timer_name = xstrfmt("git-maintenance@%s.timer", frequency);
>>
>> The "@" in the name signifies that it is a template unit which it isn't anymore so I think we want to change this to "git-maintenance-%s.timer"
> 
> I'll also take your SYSTEMD_UNIT_FORMAT macro suggestion to simplify things.

As I was checking things, it turns out that we _should_ keep the '@' symbol
if only to make sure that our new schedule overwrites the old schedule.

The alternative is that we manually try to delete the old schedule, but that
feels like an inefficient way to do it, leaving some cruft around long-term.

For completeness, here is what I did to check:

$ systemctl --user list-timers
NEXT                        LEFT        LAST                        PASSED       UNIT                         ACTIVATES                     
Tue 2023-08-08 13:13:00 EDT 6s left     n/a                         n/a          git-maintenance-hourly.timer git-maintenance-hourly.service
Tue 2023-08-08 13:50:00 EDT 37min left  Tue 2023-08-08 12:50:10 EDT 22min ago    git-maintenance@hourly.timer git-maintenance@hourly.service
Wed 2023-08-09 00:13:00 EDT 11h left    n/a                         n/a          git-maintenance-daily.timer  git-maintenance-daily.service
Wed 2023-08-09 00:50:00 EDT 11h left    Tue 2023-08-08 09:35:31 EDT 3h 37min ago git-maintenance@daily.timer  git-maintenance@daily.service
Mon 2023-08-14 00:13:00 EDT 5 days left n/a                         n/a          git-maintenance-weekly.timer git-maintenance-weekly.service
Mon 2023-08-14 00:50:00 EDT 5 days left Mon 2023-08-07 10:28:10 EDT 1 day 2h ago git-maintenance@weekly.timer git-maintenance@weekly.service

Do you have an alternative idea how to handle that?

Thanks,
-Stolee
