Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAEBC4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7042160EBB
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 14:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbhHDO4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhHDO4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 10:56:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E97C0613D5
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 07:56:23 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e186so737627iof.12
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qg+DEZmVy/hZ/sMIEv/4gHDIZCGTOACFslETUF4B/9k=;
        b=dA5LFJDPexfXHnSMY3bYR9W5GpuTrGvqM2PNaT3xWkOasyyJOGWJC8bdKtGUYCJZvM
         Z15HkK3TBvV2xU5O1AR5QqMNxtkicaCKXO2xgjSazefJqv+ws+1j8PG6squiJKv3+Lyr
         oo5flQu0WyS+IeOE2G79xxjfc5bi26jE7cqEEnOO9wDM4ATiqqj6sIxsTq6x33sC+4GA
         ZExeilUSrbsGpzDiAFyRM9rbBwelQpnoO+KZ7+W62BkqtApIpjhz8tXLfaWO+fi9NoMH
         5VppFbDHIzWwsnkgIpKifOyzp/jY1WdJpGS5nAMKe/A4odtZOAe8EfXieFvg6J4Di8D1
         VOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qg+DEZmVy/hZ/sMIEv/4gHDIZCGTOACFslETUF4B/9k=;
        b=WIJs93KQREw9KGhEw2DDnj6pG48Sn4rP0javKqqj2kRlHkm3IcvIKjGtte1Nb5EobX
         JixSX+dVu51fQfFNd0GnjYHY+5wtVxTxFh0atwqedl64ACnzuVB40fKLjMo0xvwxxpta
         86FA6KzRACsiOB1JNWeKpv1Iu0Iwia6YXvyn+j8zkDeSRY9jLVaKLGA5uEAIhHhFH8/G
         Oi5gs865VR9dx4I1Ip65zo1jfJX+CXbukaP8xYPhabD+N0FFKt5kf48QAN1ALEWjbex6
         cgN56N6zSgc5zVmlNkV2leCjzenxcOVAGxIVnev+IYMVQB9XlwruTjGWes5i7Wjf8xff
         FvHg==
X-Gm-Message-State: AOAM533C5MdK7TdMsm8rSlz9MQVT9e3GoBgzqce6LHbp+eIyUW1Eo5mK
        bcGl3mXu9WoE63wJrtyU+QM=
X-Google-Smtp-Source: ABdhPJzuKbeHmvbFpdsRq8a2zRq5pP6JN3jHLsgndWC3sW2mGB3MmSoinbJLUuOIWmVOIWux2+YAng==
X-Received: by 2002:a05:6638:214d:: with SMTP id z13mr19911071jaj.113.1628088982593;
        Wed, 04 Aug 2021 07:56:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3da5:bc29:43f3:f85c? ([2600:1700:e72:80a0:3da5:bc29:43f3:f85c])
        by smtp.gmail.com with ESMTPSA id q7sm1756077iow.12.2021.08.04.07.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 07:56:21 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] Documentation updates: merge-strategies
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com>
 <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
 <xmqqk0l1rb57.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2e1cbb1-3e6b-bb4f-1e13-b1652dd50ec7@gmail.com>
Date:   Wed, 4 Aug 2021 10:56:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0l1rb57.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2021 2:12 AM, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Changes since v1:
>>
>>  * Multiple tweaks suggested by Eric, Dscho, and Junio
>>  * Removed patch 7 explaining no-renames since that probably belongs in git
>>    diff --no-renames instead, and this series is about merge-strategies.
>>  * Inserted a new patch 8 that strikes some misleading or at least
>>    no-longer-important text from git-rebase.txt (due changes back in late
>>    2006).
> 
> Looking good.
> Will queue, together with the "switch" patches on top.

Chiming in to say I like this version, too.

Thanks!
-Stolee
