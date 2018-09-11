Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33061F404
	for <e@80x24.org>; Tue, 11 Sep 2018 19:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeILAZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 20:25:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeILAZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 20:25:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id w11-v6so27227613wrc.5
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 12:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZWdQ/FMXjytaUbu7N7Q0rKJS0e4nVbwZSZq5uMfUt1c=;
        b=IWYLfqUyUvAxtR2TANpuD1Qb9hcO1eqFQuMR+darTYbECzozsIFt9IYH4PFILGrZ9L
         2qz2fQYQ8pIkBgo9+pbiVgOmbF3rAeYtZb8m2H9QkGB9Rj0hA5CbiuEinsmBmE4q6koa
         jtPXbNuHGET/KyF2zMKx15qrHFOn5zCi2eRHY0wUcnVtYMh/xikE7tmECqF3mjo3f0xq
         lTNlZNEMsyjb8WODS3QEE5QC2naHxbXY939JGo2vFl8jIwiUQU/zgiLVB99gmyX0RBA3
         dGEeNj9SaDG3qxF6Zqu9TyhY5hbYCm3P6TIKZFIL/+ndfPLxzsZJ3BTiaIlz3n41EG13
         5X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZWdQ/FMXjytaUbu7N7Q0rKJS0e4nVbwZSZq5uMfUt1c=;
        b=a8aQIX0XEU8Do16URF0Re9PMHlozIrCUzwspmgpQKHs2fkOUrjZ2VSM5CozcA8c441
         WPdafH2YV1wPnIvfOwattY8ZpDthYzHsrYDd4Oks3LBF6YuM/Qn75Od8jge+QcyPaxA2
         wSRNDBvCVeE3Lqkb3eUUl0dI1Sc+YacMio1V30wEj1jU4vc9w3qHK3Y915LS5QXP5vFY
         7CAjKlES9zTII78Gzc1G4UpJCLUI+R+0pugZVG84oqrEHIlXE2deBOLpP9wjyYlgB/+M
         +qhbUULT2fd33Tiz/z1Xb7jB5jQTl/DZvhTFErk+Dwtvzb4q9NB9OPqvbxHUtfz7WqP0
         spQQ==
X-Gm-Message-State: APzg51Czo9glFsrMjsCYS7RDnEgn8kLMUSNPBKC6vZa/ccEZ+gsGtZWz
        SQyUYZOmkSknZVNcpES7p4E=
X-Google-Smtp-Source: ANB0VdYXMC8bGuHy2JoZztudLt4S3238f4wMqWqlaJKQp7o7n6qIuCQPj1TwINmLSeZDbTwy+CCbcw==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr15001600wrt.18.1536693899608;
        Tue, 11 Sep 2018 12:24:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y12-v6sm13435018wrq.33.2018.09.11.12.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:24:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] diff: fix --color-moved-ws=allow-indentation-change
References: <20180904135258.31300-1-phillip.wood@talktalk.net>
        <CAGZ79kaBBzG6-QKruCeybN_do735h9tAXHZ7Rjx_YXeh85ax6A@mail.gmail.com>
        <b78b467c-6cae-2e2e-533c-48a4552539f5@talktalk.net>
        <5cff63d6-d9ec-d28f-d34a-e610ac19dbcb@talktalk.net>
        <CAGZ79kb53jNAJagQ+nG0hoJiozKkR6Aw=oRLZj5xvjFY5Hx=Sg@mail.gmail.com>
        <xmqqftyfq4qw.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kacqst9PVCzit_XpKYTHDC7VaKG_7OGoZyd3CtUxw74Cg@mail.gmail.com>
Date:   Tue, 11 Sep 2018 12:24:58 -0700
In-Reply-To: <CAGZ79kacqst9PVCzit_XpKYTHDC7VaKG_7OGoZyd3CtUxw74Cg@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Sep 2018 11:40:12 -0700")
Message-ID: <xmqq5zzbq1kl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Sep 11, 2018 at 11:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> >>  [...] So this should be sufficient.
>> >
>> > Yup.
>> > Thanks for keeping track of this patch, as I lost track of it.
>> >
>> > thanks,
>> > Stefan
>>
>> So does the above exchange mean that
>> <20180904135258.31300-1-phillip.wood@talktalk.net> is ready to go
>> with your Acked-by?
>
> Acked-by: Stefan Beller <sbeller@google.com

Thanks.

> I thought this was implicit, would you be interested in a more formal
> communication for this, c.f.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n513
> sections 12 and 13.

It wasn't like I was explicitly asking for an ack because that
section tells us to do so in this case.  Rather, I didn't follow the
state of this patch, for which the original author of the recent
feature ended up saying "I lost track of it".

If a reviewer and/or an acker anticipates that I, who by definition
needs to know the final state of more topics than any single
individual contributor does, may not remember the state of each
individual topic, and tries to be a bit more explicit, our
communication may sometimes end up being extra redundant, but some
other times, doing so would reduce the need for one extra roundtrip.

If I need a clarification, I'll ask anyway, just like I did in this
case, so I do not think it is all that necessary to be rigidly
"formal", especially among list regulars.  Just a simple common
sense courtesy to try reducing each other's workload and memory
burden is probably sufficient.

Thanks.
