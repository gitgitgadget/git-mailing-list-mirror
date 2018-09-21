Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3565F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbeIUVpA (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:45:00 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52173 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbeIUVo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:44:59 -0400
Received: by mail-wm1-f46.google.com with SMTP id y2-v6so3598366wma.1
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1NmCszPxVjD3DkDIdGrEQLm8QVDNXiKqumoCHPMHvmY=;
        b=irEN5NQ8PS32REst+HQDzTAN/9aTdZjnGisA4pXwD9KXQ7GX0h+3XJENhfGv5foL9J
         V9jkloAnIBZFYaxL1HIT+5lp507gsZ7vX9+otgd0ELpVo/MNkoj6jM/5aTgvsKyQ/J+a
         nM/VqQpc4d1/6B4msr9hVin3a3Q4HZiueRI0XMmLPHWgDv56i0XBlFDLsVklL71Wq/rh
         l+53sXO/77WxnLXtIVhA5zXCD/KkkZ8R1V+fHrumKuCTP2X/aq5DZqBzWFg48CQ7IkCX
         wK8/bvAtVjRYsPZ42riLohpgAkV6lxl90TgDLqan7fBACgUPwYIiU+9BWC3DXhU1XLb5
         Q5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1NmCszPxVjD3DkDIdGrEQLm8QVDNXiKqumoCHPMHvmY=;
        b=B9aJRRNsky0bMNsfrK03zz9xOflhwtUaj1vyRWNNl9mnCcEhTVgUtoGpRG/DkyXosq
         lwTFxz1sG/ZK3erag5gOqwEQg7tpHr1M7QXXkq8INfLumI7xY3Co0Lse3KE3GKosL62Q
         /Vqm/a5KsTOobJne3qnwjjKoWgRjnKqHdhatyOy0ZsS7UVLwkkjdM/jUIG4DZ43Iuqhh
         SjQViL6JrAr2Y5zQgpgrepVkAgfdIH510Cpld8ztBFQWasBGMdQUbp9bJsMkbP/23iIb
         p1PEgGjopq4ex767xLrY5gPfI1eWx46VFApFo12ckCjCc/Q/POstzFEaAb9ZRTSS6Ilo
         w3lQ==
X-Gm-Message-State: ABuFfoh64+kuOU8pLP2MMD6ISYr7EVmWmlWEFjnezAXmdFfi0b482fxJ
        J01iueGwmgtwCvZEh59Mrxk=
X-Google-Smtp-Source: ANB0VdZSque94T2zXibhDV4LzG9TkoFsXJEjp8tNAQacZcJKGhmeK55G5oaey1I6Uk9CxsSLWRVg1A==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr7755461wmc.81.1537545327550;
        Fri, 21 Sep 2018 08:55:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v16-v6sm35368745wrw.12.2018.09.21.08.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 08:55:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Segfault in master due to 4fbcca4eff
References: <xmqqin2zxw55.fsf@gitster-ct.c.googlers.com>
        <87pnx6kjn8.fsf@evledraar.gmail.com>
        <62a46e49-e539-cbb8-4aaf-6f9b5ae6be57@gmail.com>
        <87o9cqkj6p.fsf@evledraar.gmail.com>
        <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com>
Date:   Fri, 21 Sep 2018 08:55:26 -0700
In-Reply-To: <5e7e6519-21c1-daff-65a5-7d2ca5e1dbd4@gmail.com> (Derrick
        Stolee's message of "Fri, 21 Sep 2018 10:53:30 -0400")
Message-ID: <xmqqefdmyhe9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 9/21/2018 10:40 AM, Ævar Arnfjörð Bjarmason wrote:
>> On Fri, Sep 21 2018, Derrick Stolee wrote:
>>
>>>
>>> This error was reported by Peff [1] and fixed in [2], but as stated
>>> [3] I was waiting for more review before sending a v3. I'll send that
>>> v3 shortly, responding to the feedback so far.
>>>
>>> -Stolee
>>>
>>> [1]
>>> https://public-inbox.org/git/0bf9103c-9377-506b-7ad7-e5273d8e94fc@gmail.com/T/#u
>>>
>>> [2] https://public-inbox.org/git/pull.39.git.gitgitgadget@gmail.com/
>>>
>>> [3]
>>> https://public-inbox.org/git/8d6061de-1654-577c-40c6-211dbd03aa36@gmail.com/
>> Thanks and sorry for the duplicate report. I can confirm that applying
>> the v2 of that fixes the segfault for the test case I posted.
>
> Thanks for the report! You are a good dogfooder.

Thanks, both of you ;-).  I was aware of the issue and proposed fix
but forgot about it when merging things down to 'master'.  Sorry
about that.
