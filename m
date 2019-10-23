Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 199BC1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391618AbfJWMuD (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 08:50:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37283 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390892AbfJWMuD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 08:50:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id u184so19618553qkd.4
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFpQu86MSqRszRMqnwBjcIIDalicbMkQwWZjnF7tcOI=;
        b=CxDbgtcYZWljd2dnUFf5Iuzjs17ouM7Qi//cLHOae0iVeAJTLsNJqbzbCzL6s7pscY
         V5hmTZz8MQdRG/lQxRYANSDRQbdSdNnIHP1C9DIwDsuwjUG32IkUvycEUkalHGdL1jar
         TpAB4QCslgZ2MkQPJIUS++dpkKUrjPMxBLS6aYGWKp8rnB2j538LkJZN/WtNXddHKoTu
         UEZZvG8tLcX3q0GKw1t3bjplU2kM2FN+xMwwA4MmTuvOFYXasbLaiqWenjlOfyYHikN/
         wZzYnCGQW+Fu3P2R3f9OtY/l5G30ohfNpZi8Fx8NWwMZugMATliWO2l2kSKcSFywMsGX
         SS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFpQu86MSqRszRMqnwBjcIIDalicbMkQwWZjnF7tcOI=;
        b=iG5t4Ki64zRo5SP2q2cuxvTfI3SBsx6nTtcinpsDXZ9fGas6kvuTcagzSs9pmEBDvN
         5yyA/SQN1z6lh+QeomtLK9kL4w7cxQVhcFKihWJH9xxQRV7w2Us+wM3SbVC6xo6oWie5
         tD/aNFCRrkE1SfZ6lrRGoboxe/uy33zc27OZ4RnMjlEtye/i60YqqlgXNrh0Qc7IIvvr
         ME+ApzjKRUO2uXWPITDqr0GgGqbarzMzO9xhSvtLEaXvxniIbKHilY/KM4r67U6qstxH
         PIX1owGN2gObCu++RHGT9b+rxamr6ZL+4Jk0nU1dFH3Lo10pU1TF0S6l65LY/ZWejGVc
         C42w==
X-Gm-Message-State: APjAAAUUFPvEgZzGGjudRq8pmY7zCFuAbSvik78UT70MC+beWcP/wWIf
        lvu7MlyekyDYenVkMxX9pQc=
X-Google-Smtp-Source: APXvYqy32aG/Wcn3hw8VKH+dC5Ib4bNpowikhnlQMRHgKthvO7cDyMU4PHWe7Yl1J3a0dx4OdUz6Mg==
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr7703758qkc.76.1571835002016;
        Wed, 23 Oct 2019 05:50:02 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd19:92e0:6c87:b219? ([2001:4898:a800:1010:6e4f:92e0:6c87:b219])
        by smtp.gmail.com with ESMTPSA id x125sm14289699qkc.24.2019.10.23.05.50.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 05:50:01 -0700 (PDT)
Subject: Re: [PATCH v5 13/17] read-tree: show progress by default
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        szeder.dev@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a229e1ee0cb96c5f8c2c5d430641c386bc082a2d.1571666187.git.gitgitgadget@gmail.com>
 <3de0f590-c75c-2470-232f-73a07876df88@gmail.com>
 <857e23df-c447-7297-df74-3546424386d9@gmail.com>
 <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <07f6288a-21c3-bd61-ef74-fea129d12c76@gmail.com>
Date:   Wed, 23 Oct 2019 08:50:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <xmqqimogi0kq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/22/2019 11:48 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> I'm slightly wary of changing the output of plumbing commands
>>> like this. If a script wants progress output it can already get
>>> it by passing --verbose. With this change a script that does not
>>> want that output now has to pass --no-verbose.
>>
>> If a script is calling this, then won't stderr not be a terminal window, and
>> isatty(2) return 0?
> 
> Unless the script tries to capture the error output and react
> differently depending on the error message from the plumbing (which
> is not localized), iow most of the time, standard error stream is
> left unredirected and likely to be connected to the terminal if the
> script is driven from a terminal command line.
> 
>> Or, if the script is run with stderr passing through to
>> a terminal, then the user would see progress while running the script, which
>> seems like a side-effect but not one that will cause a broken script.
> 
> It will show unwanted output to the end users, no?  That is the
> complaint about having to pass --no-verbose, if I understand
> correctly, if the script does not want to show the progress output.

I'm happy to have attempted the change and start this discussion. It
sounds like this one patch could be ejected to no loss to the full
series.

Thanks,
-Stolee
