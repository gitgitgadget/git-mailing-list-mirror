Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28EB51F516
	for <e@80x24.org>; Fri, 29 Jun 2018 19:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935930AbeF2ThH (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 15:37:07 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:43294 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933435AbeF2ThG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 15:37:06 -0400
Received: by mail-wr0-f173.google.com with SMTP id c5-v6so9825587wrs.10
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 12:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kn5LhSuOjPrBdmqOUIFcdVLAtmNC+gSN0l+iCR3IC3g=;
        b=vIczlmxEjzhOPmDyRnEue0EPkcGqY0zkAuZgsZZIJG3CHldlJ0KUT5nXR0ikzVGq3X
         Io8+GUpFQOGNSG9gYAAv465GyqkaH0ALpVnokd4azHt6wTrmNsomHKmYMxoYDjcrHhpC
         YUtA2Qs1oiyloCZ58oZi1NNSgpABAimlIclZWMNrstCnZWOZ4F0h+rgJS0DG0hz+FK3o
         KDoGvlm27Okg0hNgEo5a9yztgzgJ18TGxRMZJTwOF/bsX0jwDn4RL9VXJw6EjQV+wfJM
         EL2O3DXa/apokad4jJKTRJcxnSqFaAqFPsU3QJXPJ+Bgzgj4meAXe2B828Qv8eQOG6qf
         pBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kn5LhSuOjPrBdmqOUIFcdVLAtmNC+gSN0l+iCR3IC3g=;
        b=T/fXBPkMpvDJaXAzdHw8kuWIQl4szZwVl2RUnTq5cdr4gSpWpDbh8kdiTuF9zAV+kj
         BXyu23X0Mz1hnFoUTF8vkMdh1KUCaHphBnNOjpBGMKapzBokIsAHifz5c3a2ijCEzOpn
         W4P95jbww5T3PiBf4ABZP7Hror24cqw0zK3pM1FU1jPlH8a6FHcr8TRCgbTrFKmy1Fl9
         8rUFvdGozByrKhLhf/cU/avbaS1ApOyjx0k2wod2h8LMe6eyEvQ5OQI293urtHvt53Q8
         M9MNJBhv10AC6xEA0zVkV8nLI/O20Pjk+lqrW3DRTPRY6milvq37j0khcoY1Jw2nmK8w
         5Opg==
X-Gm-Message-State: APt69E3bX+0I26GlsEjUxvWkGveuh++MDfNgU1b8ddq66nDCoStv/7yj
        rDomcYSgYOquP1SIVef7hWI=
X-Google-Smtp-Source: AAOMgpczaMqedl2iPb8VVH/lT+RI5pfJJVF5PLCamnMM90FN1s/MoTPCaKH4qHIwt5bcuMr+inomVw==
X-Received: by 2002:adf:edca:: with SMTP id v10-v6mr1863223wro.264.1530301024886;
        Fri, 29 Jun 2018 12:37:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s124-v6sm2528281wmf.47.2018.06.29.12.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 12:37:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
References: <20180629012222.167426-1-sbeller@google.com>
        <xmqq8t6xv5kb.fsf@gitster-ct.c.googlers.com>
        <xmqq4lhlv5a8.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kb=W5_3FB6qSinPpcPzRgAe-qkuOCkXTjs6RLqUTjoboA@mail.gmail.com>
Date:   Fri, 29 Jun 2018 12:37:03 -0700
In-Reply-To: <CAGZ79kb=W5_3FB6qSinPpcPzRgAe-qkuOCkXTjs6RLqUTjoboA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 29 Jun 2018 11:34:48 -0700")
Message-ID: <xmqqvaa1tme8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jun 29, 2018 at 11:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > One technique these (not just this) recent efforts seem to be
>> > forgetting is to introduce "new" names that take a_repo and then
>> > make the existing one a thin wrapper that calls the new one with
>> > &the_repo as the argument.
>
> So you'd rather want to see it less invasive done similar to
> NO_THE_INDEX_COMPATIBILITY_MACROS ? Someone (jrnieder?)
> called that a failed experiment, as now we need to carry that baggage
> for quite some time and never cleaned up the started migration;
> only recently Duy started to kill off the_index, which would finish
> that migration?

I do not think it was a failed experiment at all.  In fact, most of
our code is still happy with the single in-core instance of
the_index, and I think it is a mistake to trying to use the variant
that take an istate instance as parameter just for the sake of it.

IOW, if there is a good concrete reason why it helps to teach the
set of functions involved in a callchain to operate on an in-core
instance of the index_state, passing an istate through the callchain
is a very welcome change.  If you do not do so, and then just
replace $foo_cache(...) with $foo_index(&the_index, ...), that is an
irritating and useless code churn that harms other topics in flight.

