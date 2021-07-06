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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B15C07E9B
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5E861C23
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 15:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhGFPPf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhGFPPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 11:15:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63687C0613E7
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 06:57:00 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s18so7443281ljg.7
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 06:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yet7gF7ZCkX2TCLHntS1oIOHIsXQVmJlUX2Z+lqB4oY=;
        b=YOZK88zqZ2jeZo+/wYj1Kh64Ta0Qr/GPJEoyWAo8RhOTHdwOyDqXp4gK5zETdyc1qx
         n45q6zPKf8uE4AXye6DZhFoSvH/KG0EQtoAsoYkxi11r++abRUntTTGQVV0wKSZ+uZEO
         JM+eNvCjPB19kiJM7ODSxzzNkkPdxjldiSizEE8NbOX/qPF1eblQE+Vcl+kuAb3xHA/U
         24Xhib3OnoWo8zZDT8FN+YVK8iccCHKZD/9BeaZrg46HOAv3qx90PT5A5Yg/z6BHbJ6U
         VYft3CZFuR5m+10kQsupgF+wAFwk5LiHZryT1GlelzFESxRzBBIplHWF1y8M364+pooq
         1zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yet7gF7ZCkX2TCLHntS1oIOHIsXQVmJlUX2Z+lqB4oY=;
        b=Il7BbWVCYOZYzQz634FZnNrZkas6Do44rr+ROfFhgONA8vlqCBNhjkbtBVtC7fdEK7
         tsolHUmk4AktKcf/7nkvIdm1mRq3G37H78LheVeavuXoYeVKNa5YI2LMiKfnAAlZ4+8J
         in3SNzE/k59KtApShFJ0FWyw7UL3AJ/FyyDgRJs1V1yMP00mjHuQAGd3a8R8zV+DpRMd
         I45tOc+0q6VOeHdiH4Wyne9u63tn6Hv2hD8XFA56Mel1c1zPDgZ0DG4bJtjNp1qC4OGn
         xseYyc1uIZUAfjgmT39dEzpqYswffPX1A/Re5ZY1iuAtk+YMNzfuZQHAgPfPJcuo6Rpi
         XWlg==
X-Gm-Message-State: AOAM532k3ujMa27cAJM5qhTmFymeYADuYB5Q85lfAaMn6VD1HMYOy59a
        mOcDvn5bBZ1O2dmdvP+mbaUttU071hI=
X-Google-Smtp-Source: ABdhPJy+UyzeziOzuoeNHs1KJlOFjFj4Svdu4i4OvEnlCThLPl0M9zp/FXeZWY1cCCPVwH01NLKF5g==
X-Received: by 2002:adf:93c1:: with SMTP id 59mr22049257wrp.312.1625579186573;
        Tue, 06 Jul 2021 06:46:26 -0700 (PDT)
Received: from [192.168.1.240] (118.22.198.146.dyn.plus.net. [146.198.22.118])
        by smtp.gmail.com with ESMTPSA id i2sm2948409wmq.43.2021.07.06.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:46:25 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
References: <xmqq4kdft122.fsf@gitster.g>
 <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d04c71fe-acfb-abe0-b00f-cfa01651dd57@gmail.com>
Date:   Tue, 6 Jul 2021 14:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGF4K4mAXf6X1rTpTmPCfQgwdhv_VUVg2icGk5Dw7Q1yw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/07/2021 06:04, Elijah Newren wrote:
> On Wed, Jun 30, 2021 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * pw/diff-color-moved-fix (2021-06-15) 10 commits
>>   - diff --color-moved: intern strings
>>   - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>>   - diff --color-moved: stop clearing potential moved blocks
>>   - diff --color-moved: shrink potential moved blocks as we go
>>   - diff --color-moved: unify moved block growth functions
>>   - diff --color-moved: call comparison function directly
>>   - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>>   - diff: simplify allow-indentation-change delta calculation
>>   - diff --color-moved: avoid false short line matches and bad zebra coloring
>>   - diff --color-moved=zebra: fix alternate coloring
>>
>>   Long-overdue correctness and performance update to "diff
>>   --color-moved" feature.
>>
>>   Waiting for reviews.
> 
> I read through the first half the patches or so and didn't spot
> anything wrong, though I'm very unfamiliar with this code area and
> don't yet understand much of what's going on; it was more of a spot
> check.  I'll try to get back to it again, but my review probably won't
> be that deep.

Thanks for taking a look, do let me know if I can do anything to make 
reviewing this series easier

Best Wishes

Phillip
