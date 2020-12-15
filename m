Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8FC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A0722B47
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 21:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgLOVml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 16:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730604AbgLOVm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 16:42:26 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16951C0613D3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 13:41:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y19so43173709lfa.13
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 13:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=meQRXh+fHv3yFziUEOJKHDiLG2Jiz5XZXLM54HCYTIk=;
        b=cVOb1L3bbpiLgVhVB0UUqmcvVdIN+EKZLbA24cw7L+7e32sEErc7Sw7wWEc5dJbMc5
         Ok1P+OoOZO81En9ErMoB0YOAe1iQsifq9HaXQLnKu05gWMP36sWkqOnnxPo7QAISF7X+
         NTo+tpBJuZ4wV2ETMf6yECBc8I/IzccjGJuMbMfjB3c/TWX7gCVKcTCG/QIinUXUlTut
         MPK7m3TowveOh5DG+GZsdC5TO9GMit96GKdqL99ADbWrDIRGwBVrkdVA7qi8NIJN8FF2
         cj/q/8n8TrfWRSbkjqPTrDzXaxqlXrXq5yJ463TuQFYGfG48kNzAF3hb26BX576cOU0n
         ticA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meQRXh+fHv3yFziUEOJKHDiLG2Jiz5XZXLM54HCYTIk=;
        b=LmbgLj/HKT4cMYrCMmQLqRfSHQwSuLj8/p7RfgnzgsjJr6OQ1o3He7ZNp/3677bJ2I
         Ph81Pu6XvnkO6O7NRswqUWU5QdjEeOijV51XdfCy/6snCD3Ti0uRx+vHdcBciwK6Uv8C
         KqFemFT9YArQbSVsn4OisXHST5pP2OwKiP4B4uWYbKlNby/HVZewfm2XTlGUXxMusfTA
         XxnjTf+9Z2jNh0bIMgEeJ+B/T6fP2g0ow/qDXxcaY4DqacuacX2hYPAK73l+JZywgjtX
         IXp0tWLvKUwzZD60HsLQ/POXYRPLjTPdf+rvFiaL8Gh37fVMPoKf8E5nm9ZM0ldCT8vv
         NfTg==
X-Gm-Message-State: AOAM533HemDgk5yfYN5FRoW+5jF+JPA4lC0Kd2atvM/GFcFQ4np8nrYr
        EdvfYpRRm/vQgeG7bECe9ayXQEuCqQ9MKA==
X-Google-Smtp-Source: ABdhPJzsi9yHhW403PgQ96KjZdzv9NqLvLGuzXFQKz4ssPu2rTCEKSVdWbpal+HTZD3CAfIRPXUI3Q==
X-Received: by 2002:a05:6512:689:: with SMTP id t9mr11881552lfe.78.1608068504267;
        Tue, 15 Dec 2020 13:41:44 -0800 (PST)
Received: from [10.0.0.3] (host-213-5-210-87.wtvk.pl. [213.5.210.87])
        by smtp.googlemail.com with ESMTPSA id m29sm2931773ljb.30.2020.12.15.13.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 13:41:43 -0800 (PST)
Subject: Re: Cleanup tool for old blobs in partial clone
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <6446f471-87ed-9fc4-fd54-61c5cf95a218@gmail.com>
 <CAP8UFD2ibGdznacrC=Sf6pZtzEiGJ7v+2L8PbM3m2PDdSBoYYg@mail.gmail.com>
From:   =?UTF-8?Q?Mi=c5=82osz_Kosobucki?= <mikom3@gmail.com>
Message-ID: <3b90b261-7920-671a-6566-70cd97b8d0e4@gmail.com>
Date:   Tue, 15 Dec 2020 22:41:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2ibGdznacrC=Sf6pZtzEiGJ7v+2L8PbM3m2PDdSBoYYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Christian.

On 13.12.2020 11:10, Christian Couder wrote:
> Hi,
> 
> On Fri, Dec 11, 2020 at 3:07 PM Miłosz Kosobucki <mikom3@gmail.com> wrote:
> 
> I have been playing a bit with partial clone (see
> https://lore.kernel.org/git/CAP8UFD35kk10FpUnPpiAUzTHJbm=SJ-76OTmkTwBstGFe3Zgdw@mail.gmail.com/),
> and I started working on `git repack` and the underlying `git
> pack-objects`, so that `git repack -a -d --filter=...` could work. I
> cannot promise anything about when it will be submitted, merged,
> released, etc.
> 
> Also I have been working on it on the server side though, where it's
> ok to get rid of everything that is stored elsewhere. It might not be
> your case, but on the client side one might want to keep the (large)
> blobs that can be reached directly from the tip of some branches,
> which might require further work.
> 
>> I couldn't find information about it anywhere in the docs. I vaguely
>> remember a mention of something like that possibly being done in the
>> future in partial clone (or maybe promisor remote?) patch mails but I
>> couldn't find it again.
> 
> Best,
> Christian.
> 

Thank you very much for this detailed information, and thanks for all 
the great work you and the git community are doing.

Best,
-- 
Miłosz Kosobucki
