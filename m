Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A601F597
	for <e@80x24.org>; Fri,  3 Aug 2018 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeHCRr4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 13:47:56 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:40988 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeHCRr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 13:47:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id j5-v6so5830852wrr.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t5KLup7RelqPN+HTKteVTQDnsbwz0JivSmSsu3+PTWM=;
        b=hckJFBYJcIPNa2u1zW7Lnx1ImORcQV/0hcqf4AjRRkYrK22ht2VW5nBjQdAQW4ytgh
         WvdlEkOKYiyPdsG74ePEW87ZQ8V4RYt2a/m5WhovBEEQYj3jJJoYgulRzbGQdvHfub/Y
         Qmbr2jczEwnGFX9n569n62iIHD9uUCfe3E+KDNaXCfkHaAkTQpzrOKlpKAZx0rNqYpxW
         KznD8vr3GzsK6RTMI6uFjCoksyThHF8mueYNsAy5d8GPxMV6vIdMzJeq3SDDDjGHU715
         cVGmwoVsUabydpFiM1dwFQJxG/vbItU1c6cObOEp8sUSABRz8kpGPujoMikRT/ECgg3X
         0M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t5KLup7RelqPN+HTKteVTQDnsbwz0JivSmSsu3+PTWM=;
        b=k8zOPF3OIRDZVFB/An0Mn02Rzdw3OuibT/RH2YVKc/mABjHsfrj2+l6ZG4QzRhT4Tk
         p5r54CEPa6P87snEhEkvDsTXFQ2YbszHTB8BZZha7NcNEercVB/mPDi6TOCCs22F4bT3
         oHjro7OBBj5DqBxPbi5YpXB+h04Ur5xr7Gau/H6nbY/0QdDe2ufZVOLqsHPtGFeNCg9I
         bG5wf4r7aPokoGFzaNSDM7b35RUWI9te1tK6OOrjmi3wZZKm5hF6rp9dUA8N+RKRzorX
         VIKLI1r5zXhzXMv49eqYKrlreDUaGWyFBAB9j1krgJSktb8iiEzxOVhEQX5+23WUsVGA
         kUuA==
X-Gm-Message-State: AOUpUlGfUojecMy4AOrquJ597bFpgDWlinHXHEt+I/m6405bVeUFPy3P
        IC70VkCygO8YEbkfxEwR2M0=
X-Google-Smtp-Source: AAOMgpeWfC2KMQa09HtPyaI5DTe2vpwwHVahe+UdLLZTP38mCda9oPrnt2N4zRidm99P8DPdTK20CQ==
X-Received: by 2002:adf:8895:: with SMTP id f21-v6mr2993712wrf.250.1533311461904;
        Fri, 03 Aug 2018 08:51:01 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g17-v6sm5514981wmh.19.2018.08.03.08.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 08:51:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        peff <peff@google.com>
Subject: Re: [PATCH 2/3] config: fix case sensitive subsection names on writing
References: <xmqq7elbe8po.fsf@gitster-ct.c.googlers.com>
        <20180801193413.146994-1-sbeller@google.com>
        <20180801193413.146994-3-sbeller@google.com>
        <xmqqva8t4s63.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbeUHVQmfTFkoGEM617iVa_3mCsLjpYGoEebqxNKAM_xA@mail.gmail.com>
Date:   Fri, 03 Aug 2018 08:51:00 -0700
In-Reply-To: <CAGZ79kbeUHVQmfTFkoGEM617iVa_3mCsLjpYGoEebqxNKAM_xA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 2 Aug 2018 17:30:10 -0700")
Message-ID: <xmqqy3dnzbx7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> And *technically* the two level is old style, so I figured it's ok.

If we call the bit not after the recentness of the style but after
what it is about, e.g. "is the section name as a whole (including
its possible subsection part) case insensitive?", then yes, a
two-level name can be treated exactly the same way as the old style
names with a subsection.  Perhaps we should do that rename to save
us from future confusion.

>> > -                     !strncasecmp(cf->var.buf, store->key, store->baselen);
>> > +                     !cmpfn(cf->var.buf, store->key, store->baselen);
>>
>> OK.  Section names should still be case insensitive (only the case
>> sensitivity of subsection names is special), but presumably that's
>> already normalized by the caller so we do not have to worry when we
>> use strncmp()?  Can we add a test to demonstrate that it works
>> correctly?
>
> That was already demonstrated (but not tested) in
> https://public-inbox.org/git/20180730230443.74416-4-sbeller@google.com/

Yeah, I also manually tried when I was playing with the old-style
names to see how well it works.  We would want to make sure this
won't get broken in the future, still.

Thanks.
