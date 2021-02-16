Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F98AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4163864DDA
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 11:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhBPLxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhBPLu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:50:56 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B28C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:50:15 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id h17so7022322oih.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xdnOqUCJWy5iz3D8U7VBhdUpTq4ACSp2uMiVULCgaKw=;
        b=edCSkvGxk7qXlEweL54geuFOu2Fmrn2e6t8xjbuDIXXaDHctuny4Y2+cM18Y5yatW/
         ZnyHsllyPk+B+7r8X/txQd4TUTlgee9KjY8CjLJzIs/7Zw3nk+sXFPWDuqFcdd19X4/q
         GGr6MHr9ysybHrV9aoa5vNH9JU53G0xXzsUy+OGLSfOYVyZUKL9p1QyKLHXKINk8HDUw
         wSuC5XaDOW8fZ6wsstFv2UToS13z498piyHfy+elh0/Xz1oRwn9ScH6wG3tSoMrGwts3
         aJEKQADKzVlubQZ7Rp/RurYzjG7EvciQsJj00IDfSniDaFdWMPmXIzcIHhSvsejpv3FQ
         W6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xdnOqUCJWy5iz3D8U7VBhdUpTq4ACSp2uMiVULCgaKw=;
        b=Lcxq/rqxD1y4GW5oRsRYV5bzMh9ZjKtvtk7B6WBy7YKdpXMvET4MHlGFllWOp4ioiS
         CdNjTFkgjej/J1aeC6C5qShAoLGoR3rKFQBXtES//KsDRJqv/wBttIngIFr1SB835u2u
         eCHc2MCqnF2WJhpLZwAbnAA+26HoyOGLH4kzuJDbDgrQqLjeuOsoAAhJIXsUaGmP8xrt
         7Wf/xQo8Ijpia6OMRYHclTyJ/f+OZs112ANU7TbABy+ig0yhw8HgKgXXRqRagq/j8YrH
         jYU1ZrbHxG++oJFX2iou7K/5tQOSekRupCwKKu1pskSimOSII0zJVwis9MTpx3K5mLMI
         ndSg==
X-Gm-Message-State: AOAM532GCN3VVXqJDhMc8+VkGXKkmH1yaDfCgFULjDJ56DmZ09j1Msna
        nLKdG11TdpdyV9DeJ4dbs+8=
X-Google-Smtp-Source: ABdhPJwi13i2uobn1Fa2Fc8k7/RRbiAL8JjjREtTgoFi+WRWsYxxEWPEH7sjxrkpy9oUwxbkLIf+Fw==
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr2303206oiw.161.1613476215025;
        Tue, 16 Feb 2021 03:50:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id 4sm3835otp.4.2021.02.16.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 03:50:14 -0800 (PST)
Message-ID: <29d29633-ccbb-e534-24bc-c8b16c7df38d@gmail.com>
Date:   Tue, 16 Feb 2021 06:50:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v2 0/4] midx: split out sub-commands
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, dstolee@microsoft.com,
        szeder.dev@gmail.com, gitster@pobox.com
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <cover.1613422804.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <cover.1613422804.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/15/2021 4:01 PM, Taylor Blau wrote:
> Here's a few patches that we could add to the beginning of this series,
> or queue up separately.
> 
> I think that these are all fairly straightforward, but it would be good
> to have Ævar take a look and make sure I'm not doing anything wrong
> here.
> 
> I'll plan to send a v2 of the reverse index series in a few days with
> these four new patches at the beginning.

Thanks, both, for cleaning up a mess I made as a new contributor. These
patches have been enlightening and definitely move the code into a
cleaner and more extensible direction. Thanks!

-Stolee
