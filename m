Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD7DC48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B6C610A2
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbhFMSVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 14:21:37 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:55997 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhFMSVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 14:21:34 -0400
Received: by mail-wm1-f54.google.com with SMTP id g204so10773820wmf.5
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 11:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZVJKWoeuZgHNbxu38T+wPU0Nz99gqwXrwrr3BDGjz8=;
        b=NP5Tz/3Xoibcjxwgap5sq39OGSOD6fmkdFBqgj9ljctrcK+VkhMvCMrzvDPBHZx2St
         9Y211KdqkXtF2csMvmSLGF5Q5Eoq5+YZ3fh8UmO1Lu2Dzl3PXvBH9Ihz+TM8IjRQMl82
         08yRAqZQYogCb8fgtu8oFJt2bXQctW+AZBH2QkYUdkmTA6UwmStUoqhyw8wF525s5Pmz
         y9SznZOnycETqKmfWlNnUfXcwGyqs1M/E1AFN5dLnFfBVe5Nkhcfwo7RdJOZVXIx3guS
         x80UxvKF9Vp58W8o+yqVfvQgj1/O44w2oGFwqY//XG69YErxTbVlVCEYwbxHQ8gR+UYJ
         ncJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZVJKWoeuZgHNbxu38T+wPU0Nz99gqwXrwrr3BDGjz8=;
        b=GkGLV36cKSbFrsaT4PChZ7YrnxO+aeyMoI/cXYbA3UafziwWXeWRCakzQPM0d/h9dj
         ir5DKilJMouNRlRso5SFJezEMYHdgXPlApJdozZgl+VFV7KSxAQweO8bjH8WJgtP6GB/
         OLYciZwJMHQxQP00NmE1iH0aDQ2W0OB77A0f6lKLAxCDszUrIKR+VQcCcjcIrLFcVmXH
         8YFfNkUFFBfCFcsJKQWuti/CEKFqD8xzeZ+ytMRwWkj9GEuIO7lWh9NlB8fdTEChA6dU
         M1n+BSoGri4wcfLoZKrVtIicjsR8EF7LzwsaiL6R77CYZ9VkCOa3XHqkVSMuHvevMOJ4
         Fj+g==
X-Gm-Message-State: AOAM530j3t0QCCyESTQ97qxDbDVkSwOY6S5taXBv4SZrAeCwLd/y2E5C
        jWki1xqRZxgAIXRQx61jzjw=
X-Google-Smtp-Source: ABdhPJzdALtfmciQJwXF29/7RATd0GL63uFS5Yhf9LpYmArdAx3dDmItLo/bBJOPx84svbar1ciwqg==
X-Received: by 2002:a1c:bc06:: with SMTP id m6mr29110990wmf.74.1623608312366;
        Sun, 13 Jun 2021 11:18:32 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id q4sm13598108wma.32.2021.06.13.11.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jun 2021 11:18:31 -0700 (PDT)
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
 <87bl8928q9.fsf@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3ab4f29e-987a-c7de-0cca-a64c3bf4be47@gmail.com>
Date:   Sun, 13 Jun 2021 19:18:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <87bl8928q9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2021 14:28, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sat, Jun 12 2021, Đoàn Trần Công Danh wrote:
> 
>> +	   { test "x$1" = "x!" && test $# = 1 ; }
>> [...]
>> +	if test "x$1" = "x!"
> 
> We don't use this test idiom in other places, it's OK to just use "$1" =
> "!". I think we're past whatever portability concern made that popular
> in some older shell code in the wild.

Slightly off topic but if anyone is interested in the history of this 
test idiom and why it is no longer needed there is a good article at 
https://www.vidarholen.net/contents/blog/?p=1035

Best Wishes

Phillip


