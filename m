Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C02C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 14:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiCNOGw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbiCNOGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 10:06:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967486557
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:05:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so12128145wmj.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=FXtyYnhaaTiGqry4qP/UpgojfJ7AnA/K5XE2B1ChCzE=;
        b=Ov8DjrLKxVq42Jnq2f1cVk53xc3cWT9GIOjyYtIGEpivkFiFYowCNK9WngB5n3fP9f
         Rq6UpJXTNvYOPRspZv0Jm5LnnrN4wW/u6yrIZtCO7r2UX4oZ4f7RjdK7HtHx7ZFw5uk2
         104DE+6K4c4+Tx9rzoDL+vO1FbzC76v/cSXAzaMhC+DdJHJ4VZHVJbmw0SJ7eaLFICdg
         jkL5d7GGDd24IKdU/uW43K2EAxXB6wLtF2/sMcJxjZWpKJ9VWSCfQhppln35fVcdSsIE
         +quIpcZ/UzM5GRWP+3tTMLC88s2mc+/tCl7wgC4JFgHZsSpQSHYfCG42BLRweppKMAa9
         NdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=FXtyYnhaaTiGqry4qP/UpgojfJ7AnA/K5XE2B1ChCzE=;
        b=01rXggppFqPSMGkAWV5ev8cCFHcy07SLcTdXmPb9Gof8171F3Tv7Blle7QswqgmN/P
         at5kdig0x7BYatWPMXLHqNp9ipmZ/VGv5yVyxlAcENTSgrQMribzozGcq0dgMtnIRvIM
         OMbNpFsD3fTtchlNnG+Bd+UPZZeDL4xAVNvUIoWFTq2aroCohqgbK2hTATa4c0zDtW2f
         QxcbYl8ojsnHfV3zh4g59qQqKmHHzeinf/v4k5l3giqpFrP2Kldbo15WsguzOa/rWD4k
         Lb1FUyE2E+izG+OtXMvveiXVHjVDJCFENTIod0r0TqP9D3ncLKt56y9DkLe25riU54EF
         Ky0A==
X-Gm-Message-State: AOAM5327ORYVQ1y3d7by+8mmRNqlQFA2wx7hEGxQgpl5OPpfXhSF9qjF
        5F/sKN+1Qa7Qob7a0/zyR1LQHGUt9KaZMQ==
X-Google-Smtp-Source: ABdhPJzUZcKl6g92B6Fh3fQCCD1tInSM0w6Q3gtwa1MLGBZ+N5dRVRyQVK/GL7InAEhekPOhzvVeGQ==
X-Received: by 2002:a1c:f315:0:b0:381:1f6d:6ca6 with SMTP id q21-20020a1cf315000000b003811f6d6ca6mr25781137wmq.25.1647266736080;
        Mon, 14 Mar 2022 07:05:36 -0700 (PDT)
Received: from [192.168.1.201] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.googlemail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm19051177wmj.5.2022.03.14.07.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 07:05:35 -0700 (PDT)
Message-ID: <d5151784-3218-ab85-8226-f3d941f649b2@gmail.com>
Date:   Mon, 14 Mar 2022 14:05:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: set REF_HEAD_DETACH in
 checkout_up_to_date()
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
References: <pull.1226.git.git.1646975144178.gitgitgadget@gmail.com>
 <pull.1226.v2.git.git.1647019492.gitgitgadget@gmail.com>
 <0e3c73375c18a470fd5357b09acefeaf5ca4017f.1647019492.git.gitgitgadget@gmail.com>
 <xmqq7d8ywaf0.fsf@gitster.g> <b35edfb8-9b48-d5b3-8d77-cb61a22f85ef@gmail.com>
In-Reply-To: <b35edfb8-9b48-d5b3-8d77-cb61a22f85ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2022 10:54, Phillip Wood wrote:
> On 13/03/2022 07:58, Junio C Hamano wrote:
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> diff --git a/reset.c b/reset.c
>>> index e3383a93343..f8e32fcc240 100644
>>> --- a/reset.c
>>> +++ b/reset.c
>>> @@ -101,6 +101,9 @@ int reset_head(struct repository *r, const struct 
>>> reset_head_opts *opts)
>>>       if (opts->branch_msg && !opts->branch)
>>>           BUG("branch reflog message given without a branch");
>>> +    if (switch_to_branch && opts->flags & RESET_HEAD_DETACH)
>>
>> It's just style thing but it probably is easier to read to have
>> an extra () around the bitwise-&.
>>
>>> +        BUG("attempting to detach HEAD when branch is given");
>>
>> I wonder if there is a valid use case NOT to use RESET_HEAD_DETACH
>> when switch_to_branch == NULL.  If there isn't, it could be that
>> we can get rid of RESET_HEAD_DETACH bit and base this decision
>> solely on switch_to_branch'es NULLness.
> 
> "rebase --skip" and "rebase --autostash" are two such uses I think

Those don't update any refs though so are not helpful examples. Possibly 
when we fast-forward because HEAD is an ancestor of 'onto' is a 
potential case but at the moment I think we detach HEAD when checking 
out 'onto' and then update and checkout the branch if there is one (I've 
been thinking about fixing that so we only detach HEAD if we're going to 
rebase).

Best Wishes

Phillip

> Best Wishes
> 
> Phillip

