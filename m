Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47331C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1F564FEA
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 23:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBEXCl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 18:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhBEMc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 07:32:29 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B369C061786
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 04:31:49 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id y72so1561198ooa.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jr51do2ux8KIR7jO0dkefkyuSQKHSooq5wMQfge5tx0=;
        b=QKEtasVkcAkWW0BCTFRETrzoQNTCY6gk9H7njHYRX3o4TIyDdpaVu0nYvvm8ufgwtB
         dLU3ge0Chvh+qR7deDazuQDFktvES7OeZjAchjmNOg9RMuzbouEHEmKSgT1SrmnL3hPr
         ONeDBVfLz3+f49xz4ey1tNfn/sv9H6hLdhld4mwubl9Z+mqLpxN9Wg/rGLt4oaoaePtB
         6iOqEfpOrf1QN/LzM6ntOnIpzy1zNUWsaX27DwJvBQhbX8IqNPxSLxH0ALYyQboDHWdP
         aosOPvrMaDYqDac9mfBq5ppjpx3HbaVVfEZ6+faKl4i3tqerVZesIcb+5lRgO3VuSQCJ
         rbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jr51do2ux8KIR7jO0dkefkyuSQKHSooq5wMQfge5tx0=;
        b=MJMvQjnMlnAZAtkFk0B5Q3ixn/nohv3ZmXAQur0fEouQYe3QxGKsKofDREV6Xj5UjZ
         b6Xn39U/pL9R6lVvt+cUVRRUlehQPUHDr20S1A9MgHZUpytglzoy2rbRjoj1ZmvkB11X
         2FzXIDtPwMo41UZ5q5KIr+gxbfqZX+WHgjKdeo4Bne0wF0qaPuUIjQDYWwAyHjLho5dB
         +CIYU+SCvc6jr74sma1ZrKopNwSPrZWp8Kqdsszw/0laik353TKqklW7hjBhRpnyxLnJ
         kTbK0owLeT4QL9Z1u5+HnJPX2ZXVjIMM4KgS/XCfSJNmGYuLjJ0mgKJL8EUWHEu6pB8i
         yW7w==
X-Gm-Message-State: AOAM533VNnsrhJ9SO8A5mepDyqq5SFcOpqi9nH0maehBPeB2F/XdFeoh
        hSyw1P732u0cUuevs3+nc/cR9bQIHFFmhQ==
X-Google-Smtp-Source: ABdhPJzmqZ/MTtgl1Bqnv6qxq7YJSDj/i7tWklDV2HoxV8XtdH66qQ9GLBaSqUDHmvvHuf0xzGDbuw==
X-Received: by 2002:a4a:d112:: with SMTP id k18mr3279674oor.48.1612528308859;
        Fri, 05 Feb 2021 04:31:48 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:4dc9:c09:30f7:a417? ([2600:1700:e72:80a0:4dc9:c09:30f7:a417])
        by smtp.gmail.com with UTF8SMTPSA id l3sm1870111ooa.12.2021.02.05.04.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 04:31:48 -0800 (PST)
Message-ID: <0b851243-e4c0-856e-05c3-eb670739cf6b@gmail.com>
Date:   Fri, 5 Feb 2021 07:31:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 16/17] chunk-format: restore duplicate chunk checks
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, l.s.r@web.de,
        szeder.dev@gmail.com, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com>
 <669eeec707ab92a3e5983ad12baddc2c15012d43.1611759716.git.gitgitgadget@gmail.com>
 <xmqq4kir4bw7.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4kir4bw7.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2021 7:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>  	const void *start;
>> +	unsigned found:1;
> 
> This defines a .found member ...
>> ... and no new code touches it.
> 
> The way duplicate is found is by having a inner loop that checks the
> IDs of chunks we've seen so far (quadratic, but presumably that
> would not matter as long as we'd be dealing with just half a dozen
> chunk types).
> 
> Is the .found bit used for something else and needs to be added in a
> different step?

Nope. It is just noise that I should have caught and deleted.

Thanks,
-Stolee

