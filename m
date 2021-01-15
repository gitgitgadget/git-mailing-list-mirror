Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA980C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 11:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0FC62371F
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbhAOLhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 06:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbhAOLhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 06:37:16 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C6BC0613C1
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 03:36:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 143so11253688qke.10
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 03:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pdBMm8sSxQuCNrVgn9MAalm3t8kt6eoPfY+KwG4eM5Y=;
        b=qEkRKoZBxxxzZg0bVwxsv2dxVf2Cysw/n7ySCYTlqJXyswZa3PkGLIe778jLo3qLVM
         L/2se65CV1yIkYyp0M8/IgRpRwuHWamfOJfcUYnBAqGKKQPkXDQ2FY7BuJDrewlMEnJ0
         LXI5dmrPu8v9UeGEvmSbOHEdRurAh/Swq9sUR+4BxyPFiOmpXZ0bxUTjiOHeIk7Aa5Nh
         ilzbmHs9dyuV/fbhQ2kOOzq32j6HBrxFvhYuVxe+9EkkWzWf72PJGJVLfwcR723a/7MV
         T7X7Fhu27ar0VBp6V3sN7XbzJFoL0fixoJKTWyIqkViabEJ3+iqTEu6NtrfJUzxDMUYs
         /wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pdBMm8sSxQuCNrVgn9MAalm3t8kt6eoPfY+KwG4eM5Y=;
        b=quNjAPJTbbE6mCWCvQ4SV0/1qHNGG8kr1ixYNjk//TUrVDt3dc+GzTSLedRtb618f5
         ftaJRKyZWUwHX98xV49ipfAGBBR4uW+d9tAvSl8+iwsY+zbnu2NA8IeTa43v+fiG7kp4
         VUc+0qPRR5X/anLWjU9tr0WCY4Q3gQW+wgia6pwjHAk35gLgv2oqLwRsUcpLqXo9iS8V
         5ap72Wtg1huT5IDq3w4t5acyA+zwiZr0FW+VUfJO1YVdxJsrFgEddLnWhgGrSrOc8oDf
         HglRNXjgmfXBgpFhUfY2a7/1vXThJA6c1Qrj9uMTBpMbRe1jv3JsWe4piYl0gxBRye/+
         I7Hg==
X-Gm-Message-State: AOAM533Ox365hHBjVq2xf6CVH0rD9e+tcRD0E4pOf1z343KkhaqDJgUO
        b2wrLnr1HN5yDIklqvbb5SdOshqZF8w=
X-Google-Smtp-Source: ABdhPJx5eNMQdGyem+azfSTWUTs1eaAr/uBH9fVgw1VrYSGz+3odkutz0pgUa788ApX8ymiNEdoVOQ==
X-Received: by 2002:a37:a155:: with SMTP id k82mr11626567qke.290.1610710595116;
        Fri, 15 Jan 2021 03:36:35 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:45b:efdb:7894:c039? ([2600:1700:e72:80a0:45b:efdb:7894:c039])
        by smtp.gmail.com with UTF8SMTPSA id i41sm4656799qtc.33.2021.01.15.03.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 03:36:34 -0800 (PST)
Subject: Re: What's cooking in git.git (Jan 2021, #02; Fri, 8)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <xmqqk0sni68g.fsf@gitster.c.googlers.com>
 <YADOf41CcaRuToD7@google.com>
 <15237c6c-98eb-0d1f-e6d5-2dda91c0ce09@gmail.com>
 <xmqqr1mmu2nx.fsf@gitster.c.googlers.com>
 <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <49a151f1-a04c-703b-cf18-90cc503b0c80@gmail.com>
Date:   Fri, 15 Jan 2021 06:36:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqmtxau2kj.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2021 1:38 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Here is how eventual merge of the topic into 'master' would resolve
>> conflicts.  The straight merge chain from master..seen would have
>> such a merge with the resolution shown below, but 'next' already has
>> a mismerge, so I'll be applying a single-parent commit to fix the
>> mismerge directly on 'next' (which I'll send in a separate message).
> 
> And this is the 'next' mismerge fix.
> 
> ----- >8 ----- >8 ----- >8 ----- >8 ----- >8 -----
> Subject: [PATCH] Fix mismerge of ds/maintenance-part-4 topic
> 
> At 1f98c859 (Merge branch 'ds/maintenance-part-4' into next, 2021-01-08)
> the ds/maintenance-part-4 topic, which had an incorrect invocation
> of internal "git config" when $(pwd) had ERE special characters, was
> merged into the mainline that added "--fixed-value" feature to the
> "git config" command to address this exact issue, and also changed
> how test-tool stubbed out crontab calls.
> 
> The semantic conflicts for the latter have been fully resolved at
> that commit, but four places that "git config" was invoked to look
> for entries with the same value as "$(pwd)" were not adjusted to use
> the "--fixed-value".  They should have been.

Thanks for dealing with this fallout. Sorry for the mixup.

> Helped-by: Emily Shaffer <emilyshaffer@google.com>

Would it be appropriate to convert this to a Co-authored-by?

Thanks,
-Stolee
