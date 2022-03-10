Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1B1C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 16:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiCJQDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbiCJQDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 11:03:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F7E136856
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:02:48 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j26so8749181wrb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xJ296TdE/B6hfebz2JirhqkYBCfCzqWlf9I9cDOevcE=;
        b=ifbQjmgbzXISjhhFOD5+isPZ7N6RcTvEFZ+cPpsiyY6iLmzaMguFdqKSctQiTpEPHD
         o/r7HEbKyR5erQktmPMNAcHr/KEj5jjeGsUf2/sazLz0cYbgMgZRDfcBePgJCQGGBMBD
         JQXpx3F3lanDgtIOtGjjaz3wQ0ugOtxqiqfHeWunzoQq1swvqdw83PaSnr0ZypxU3Cpq
         q/h95oX02gYF/jqGa+VTDXbJk7V4UdNZmdpPF0ANXjJ4RmZrKJK9l/0l83Zm/ZbzkWJz
         jaHVqpEQGWgocZTkr6UGEOzsDMXoY8VgHTzeWOGJ8GlaCld/g2SdfmaCZdX8mKSfrmus
         psXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xJ296TdE/B6hfebz2JirhqkYBCfCzqWlf9I9cDOevcE=;
        b=sjJInzTD1+EO1uwyBx4Tg3JTgtHe8YHWB6GPwwoRfVdsB+W9cWgA+e0cpsSsztI3sk
         1uWNu0bm1d7JW6WMc74ITx6hQJvEqGJuF+spDcXqRgZhFPNV8tU9u6uAYWpy+qbt4AJU
         54+xlKbcf6HAFaImguu4KEJO1x9sSQc1ybTEbYuZRbYVldZI6shtvnkBYhYQl2HQD/Jc
         ryOIxSdiwkC7tydJNM+AG//gScKY302ZffezS8YJ1NE1QbCNZkskeJuzZwqzvns0FVxC
         FfKAkC+sMCT087T2cjG+E38v2oE7+sLEz41yuKdxUQpV0VJYd6v/HXVj+t2/wDi8sexU
         r/yw==
X-Gm-Message-State: AOAM531L2hce6csuIvJrQ6kIlXUcci8sfr/HYteYhHMnkNvx+SvqeSxd
        8q34Nr4S1T5kHD197TKgkbQ=
X-Google-Smtp-Source: ABdhPJz+FfNlDWc6PfQ+aPRDrsFHCoWgQRi3cV0HXURcuayj9SCuVepB8P5BSFzcovOGLDcm8CTMBQ==
X-Received: by 2002:adf:d1c2:0:b0:1f1:f897:9d1 with SMTP id b2-20020adfd1c2000000b001f1f89709d1mr4081772wrd.84.1646928167323;
        Thu, 10 Mar 2022 08:02:47 -0800 (PST)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id i9-20020adffdc9000000b001f046861795sm4430500wrs.19.2022.03.10.08.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:02:46 -0800 (PST)
Message-ID: <45b98ac0-4d33-ee9a-e7f2-3e8137fa8a1a@gmail.com>
Date:   Thu, 10 Mar 2022 16:02:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] terminal: work around macos poll() bug
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <20220309110325.36917-4-phillip.wood123@gmail.com>
 <220310.86v8wmj5c8.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220310.86v8wmj5c8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 10/03/2022 13:35, Ævar Arnfjörð Bjarmason wrote:
> [...]
>>   
>> +/*
>> + * On macos it is not possible to use poll() with a terminal so use select
>> + * instead.
>> + */
>> +#include <sys/select.h>
> 
> I don't think this breaks anything in practice due to the platforms we
> define HAVE_DEV_TTY and NO_SYS_SELECT_H on, but it does look redundant &
> confusing, and will break if the current users of HAVE_DEV_TTY and
> NO_SYS_SELECT_H change.
> 
> I.e. isn't sys/select.h already pulled in by the relevant include in
> git-compat-util.h? Why is it needed again here?

I didn't realize that git-compat-util.h already included that header, 
I'll remove it.

Thanks

Phillip
