Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847F9C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiJYMfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiJYMfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:35:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB3315CB00
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:35:13 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h203so10157832iof.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+2VMG3T5nx4oiZMOh4q7dBDVYCZzfhovhwrq9Xb+YE=;
        b=UWgF8+9TQxMq9DEhhfXQfEdm6h/iJ8gU5dL1SKbMm67q/EsHf7nS2gJ1M/jshWEpS1
         QTJ6CejhaXc0pmG4qsJ3VPbKqln2uvW8jim9qlNnGlhbbmyM4AugOMrtTm8uZSeKZ6oQ
         nkSn+aFmW8n9IVjUVwV6tmUAkQdwRkZt6/uA/K9ZndBSvij+b+ATX/GWw3r8wczOwUc7
         QNKFIs254wz05jyg+QRB1UxsYdbhq+8XPRhqYpTga5lHakGRmfr1gz1ene5cNJLdCFzj
         wDrABQyJ4dON2YZ0QLcGRzeWyXguTaE+bMMmbv+1DrqbZD0g0vdn3SSQ80bXmATu7wWv
         yFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+2VMG3T5nx4oiZMOh4q7dBDVYCZzfhovhwrq9Xb+YE=;
        b=Z4nE6AHnrCuRKA56ysUM2zIejgDTx3F2CGFzEyHjTJmhxBSgyuNHI61tlUtP/aNxRM
         tZItyucWD9E9fuIjYgAOPZHISA7RJjzaCFecCIqcZd7PQiFw7w0oS4HTNHQMylkqyUgs
         peD/NPdW+gFnqstcMvQD8ABkgHXZNJZvfoF5V+ijj2r+4H06GSjsyyL+02tLsauOHNaH
         QijfBu6DCS1oo17hlUbmdYauepIlkxtS4o7JuTuhdT23mdKfuzBFf4FOJkWF9t4i0W8s
         GFCrgP7zOgCep6i2x70mKWtQW7DP5/Or3E4aslTLFgsRN7LWUEobTt0g+13dj4xh3AZP
         rGPQ==
X-Gm-Message-State: ACrzQf0swOW4Fi///xkfIOvssDUTjYQqFpPnhQGykDGV6rT65lgbYYTa
        cGPqzLAQ/KwmeBOdUMvjGlt9
X-Google-Smtp-Source: AMsMyM5X2iV4SNOQw/Zmj9DwRSWEmNIKUrLJh18rAIs0YabEyR+7vjq3TXzyzrtF1huBwgrQdEKiOw==
X-Received: by 2002:a5e:c815:0:b0:6bb:dd42:ad4e with SMTP id y21-20020a5ec815000000b006bbdd42ad4emr22190255iol.215.1666701312714;
        Tue, 25 Oct 2022 05:35:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:880d:bbf9:8364:e715? ([2600:1700:e72:80a0:880d:bbf9:8364:e715])
        by smtp.gmail.com with ESMTPSA id e90-20020a028663000000b00363fe31cf55sm880328jai.40.2022.10.25.05.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:35:12 -0700 (PDT)
Message-ID: <a7b0b896-7b2b-a263-dd71-8b7b929707b4@github.com>
Date:   Tue, 25 Oct 2022 08:35:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/8] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
 <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
 <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666618868.git.gitgitgadget@gmail.com>
 <xmqqeduxrmjs.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqeduxrmjs.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2022 4:31 PM, Junio C Hamano wrote:
> As I do not see a cover letter for this series, here is the summary
> of the change since the previous round that has been in 'seen'.
> 
> I didn't see anything questionable in these.
> 
> Thanks, will queue.

The cover letter appears on my end, but I'm on the CC list.

Jeff: be sure to CC Junio by adding him to the CC list on your
PR description for anything you want to have considered for
queuing.

Thanks,
-Stolee

