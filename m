Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A864BC433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8171E61166
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 12:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhIUM4e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbhIUM4d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 08:56:33 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8986C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:55:04 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c20so8424794qtb.2
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XbeXEN3NiDQ3OsDgEdC1j75aud9qIQ1K5jMnlaXcRJk=;
        b=Y2IA7wWpRpARcObCfGt9WqYEaxSAD74Y9KZBdG3wQjhdWePl0X+jdZQP0Zxan4tqrB
         hE2IC5p1vK0CDurKIPLVfB3v3NirFv9/vNZXY1pO1a6k3748DCCP6Wcg4SDar9JOR6gU
         Xyk99OAhFoKR9i1LbZc7pwJUQrDOsiaIFAFKeMHAy42A/sq8W+8og1TTfQyZ8OBivHkk
         WaAcwvr3xPXB0Pm6BZhJ+uNdWggucx2+dtPIC0kUmoHTKDAcyiiY2nh0/53Ar3YfE3ps
         FHpN08DqJu/jVAUtdws9HUZpi4/9gvpivAYw1Scf/KcVN5/ef8vzpVXycVPqjQ3lWYOE
         j8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XbeXEN3NiDQ3OsDgEdC1j75aud9qIQ1K5jMnlaXcRJk=;
        b=fpf4+/EA4Bc89YxhphH229TwQwcNogsIjus2C9JgZntATkRDE/8NiN5Mqsj95pGzZ1
         gMKYFlbPvJ8nmAydMaqiZ5sf5hEcPeBjHERhaqH6t4mD9Hx8hv09s7L6+euQ9O+lcuCQ
         emIm5buUm9KVE1SL3u6FKR6BGnmPmMWaOEmPgYPJ9S2m/Gg7Fhtqv+HhRutiS6rAQC4T
         VZPl/OdJ3UvPdu4xye2xlet9d11RCr7BbwOwwRcABDb6PrL9RBSBrrSVaNnuKvL+dhhg
         DQq+jG7NK0p3d5tT8Q27S4NHbKM+mavKCkH4fQ7VGDeZzbDmVBLyFC6oA5i0eaoNznLh
         x8vw==
X-Gm-Message-State: AOAM530KZu5bH2ZZUhp77xHPjIXEv6rf6laiXaymwXNIjWDIE7oPNmTx
        S7TlUZRx3UVSFKmv4LESjVA8RGFQvkRtew==
X-Google-Smtp-Source: ABdhPJyViwXmRDaHHvS0DtQd5PWA7Oi65SGLa9ZOoyvvlQUsuBAAyngA9uY30XfI4FwqxK5uwOswHg==
X-Received: by 2002:a05:622a:48d:: with SMTP id p13mr28518802qtx.282.1632228903612;
        Tue, 21 Sep 2021 05:55:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ace4:98aa:c023:6ae9? ([2600:1700:e72:80a0:ace4:98aa:c023:6ae9])
        by smtp.gmail.com with ESMTPSA id v5sm1339435qkh.17.2021.09.21.05.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 05:55:03 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
Date:   Tue, 21 Sep 2021 08:55:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUj7GN/qWhw67jyk@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2021 5:20 PM, Taylor Blau wrote:
> On Mon, Sep 20, 2021 at 04:56:47PM -0400, Derrick Stolee wrote:
>>>> I double-checked this to see how to fix this, and the 'list' subcommand
>>>> already notices that the patterns are not in cone mode and reverts its
>>>> behavior to writing all of the sparse-checkout file to stdout. It also
>>>> writes warnings over stderr before that.
>>>>
>>>> There might not be anything pressing to do here.
>>>
>>> Hmm. I think we'd probably want the same behavior for init and any other
>>> commands which could potentially overwrite the contents of the
>>> sparse-checkout file.
>>
>> Could you elaborate on what you mean by "the same behavior"?
>>
>> Do you mean that "git sparse-checkout add X" should act as if cone mode
>> is not enabled if the existing patterns are not cone-mode patterns?
>>
>> What exactly do you mean about "init" changing behavior here?
> 
> No, I was referring to your suggestion from [1] to add a warning from
> "git sparse-checkout init --cone" when there are existing patterns which
> are not in cone-mode.

This warning is part of the sparse-checkout pattern parsing logic, so
it happens whenever the patterns are loaded, including the "list"
subcommand (among other commands, not just the sparse-checkout builtin).

>>> Those may already call list routines internally, in which case I agree
>>> that this is already taken care of. But if not, then I think we should
>>> match list's behavior in the new locations, too.
>>
>> "list" interprets the 'struct pattern_list' in two different ways,
>> depending on the use_cone_patterns member. They are static methods in
>> the builtin code, not used by anything else.
> 
> Ah, bummer. I was hoping that they'd be used internally by init so that
> it would automatically emit a warning in the case where a user's
> existing patterns are not in cone mode.
> 
> Apologies for any confusion.

Thanks for clearing it up!

-Stolee
