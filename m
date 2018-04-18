Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B42661F404
	for <e@80x24.org>; Wed, 18 Apr 2018 00:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753139AbeDRAjk (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 20:39:40 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46764 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbeDRAjj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 20:39:39 -0400
Received: by mail-wr0-f170.google.com with SMTP id d1-v6so61115wrj.13
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 17:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JrzfnpVIG1inP9EQB5AsfZrd4yiBhIvTc5+tGVkP13M=;
        b=j3P0XXKiuwqZTMImlharzWu1quf7Rwm8T8WPui8GFgZqRWJs5sJvz4irqHSKafZdig
         EdQOjrEUIkbsjszXU4mRlpCYbMsUrDxixmhxTopb9GDCAD2ihDT42t3HtPa+4bDPfDVc
         2EpyZgAjGLNlgLLCpFwRy8z8gjqXbTGM4hVp/0l5Qb7U7rheGc0DwYnw4ULFfd6fF2CF
         A9FI8pYb6r957JFzVdKorZFsiyjRQ7TcsOJw4fA7gervOwe8pEGIkT2MTWiVmdsC/zsS
         UgITYMPqWUhkFIFSHsHu/aJMtR8JYxtQVVm8YF67R8d3TcwH5M62m/qr3ascaBuA+xAY
         f8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JrzfnpVIG1inP9EQB5AsfZrd4yiBhIvTc5+tGVkP13M=;
        b=UWQ+L5L4pq2WbXrK2ZHIcFe0c3k9R1r4BXqYXLGzDujakaSmYGsHoZ0qc0tfIH90Ge
         ict9GqGxisO6oOkNezrFHjtByVLRNiZN5KjiWJ809+epROanNiR3OLdacBlkD6hQy/0t
         WArlWYTy+rvuLMFXZ46BNMsXTBJ27gVDRDP6k4VeUrFeJI78rFm2M6tu1/7/d/aajEcz
         eTR0AxwrzdsZQFwZKIXgOraD+my3L0WJ3VAbpbR8iIgeVjpwVLPRtlvScreVJ5GD2c7z
         oxRjsH/teMSaeQMpaoaaNfAma+NahNbpDJCXiGSxO2uAEcM5lEC7Lw3NADGCDLd/2se9
         qW3Q==
X-Gm-Message-State: ALQs6tAT53+S27KK0UeOhb/92fKBBjwS0dnlS0gYG9floF64STjqPi+q
        UikU/GiSDV+JcDWaiKHc9AI=
X-Google-Smtp-Source: AIpwx48MUsac6zF+5fdX8x48/NH/6zmro+M1lA9CVXr5o8Y7vW2R6KflyzfdFcMKpcnXllSE1jia1A==
X-Received: by 10.28.107.76 with SMTP id g73mr201967wmc.65.1524011978202;
        Tue, 17 Apr 2018 17:39:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y42-v6sm114453wry.21.2018.04.17.17.39.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Apr 2018 17:39:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] builtin/blame: highlight recently changed lines
References: <CAGZ79kYjV6Wpzymx1phL7EC3BxdWr5gitCOdE6=fJFFnz4zYiA@mail.gmail.com>
        <20180417213049.118995-1-sbeller@google.com>
        <20180417213049.118995-2-sbeller@google.com>
        <CAPig+cR6Mx7sUSk6J0DULPVAunhZ4kUZLhWg_9ydgttKPSrD1g@mail.gmail.com>
Date:   Wed, 18 Apr 2018 09:39:37 +0900
In-Reply-To: <CAPig+cR6Mx7sUSk6J0DULPVAunhZ4kUZLhWg_9ydgttKPSrD1g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 17 Apr 2018 17:54:55 -0400")
Message-ID: <xmqqvacpjqk6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Apr 17, 2018 at 5:30 PM, Stefan Beller <sbeller@google.com> wrote:
>> Choose a different color for dates and imitate a 'temperature cool down'
>> depending upon age.
>>
>> Originally I had planned to have the temperature cooldown dependent on
>> the age of the project or file for example, as that might scale better,
>> but that can be added on top of this commit, e.g. instead of giving a
>> date, you could imagine giving a percentage that would be the linearly
>> interpolated between now and the beginning of the file.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> # Conflicts:
>> #       builtin/blame.c
>
> Meh.

Sloppy.

Will edit it out.

Thanks.
