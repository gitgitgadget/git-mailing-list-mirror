Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3C81F45F
	for <e@80x24.org>; Tue,  7 May 2019 20:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEGUGX (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 16:06:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEGUGX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 16:06:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so8714768wro.10
        for <git@vger.kernel.org>; Tue, 07 May 2019 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nIF+Gfm+aFv4w9R2z6SbQcgJz58wax4HQ+R7cqByx3w=;
        b=XzOJznShWUh+4JEGwDilUnn//8VsPg1vIzqr4RoO1ntsLGQYmSpJJu75OT8cVIVFeW
         FtrIOo/Q+gTLOsH0a5ej1P28RpCDbwTaU4m5A/7IZ8CJm6p9+gdkdLThQbv9tZCYAslJ
         7Djxkj5PFcs3IF/8j6rQ9sgpS2fy6TOXfHvX9Rtezj/Vy8IDl3cxDVqYQTSALLWNACA7
         5/f8kRJpdNAWXTBV+sX8ngSWVeOtIHJP8hPzQQFgzfKAwU5Z8kQO5+1r01X/9fdWdr+o
         tWAOin5nEANXCS/8l3FqvjrH/6RuPkzJcSFtL3E74PfVFWRlBsp4iwnUxHPqQsUCCp/q
         h0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nIF+Gfm+aFv4w9R2z6SbQcgJz58wax4HQ+R7cqByx3w=;
        b=AZlFo4oSqcgkR+zqRsXpEV2qIB6GUFYxLKpFRMJLCPRcenSR/mgWx/W5kq8emupY0X
         D/IA7cbPdNOw0eYtvspUP0xCzW6meLhs+U3/AckM1IIE18sE/LAIvSJT3tQ1qxpo3ka0
         qz0xIuh3JGxcyaogMNno5KD+6U8T76r/NL2kXl7sxoVJawPiGq0YJUiNfAbIF8D9vgY5
         Bh6wJvzbegx7JTFUuInO8uoMoXH5KT3cBerqEQrwZsJoOtTq545PLWa6cscx1LNvbz7P
         dMsxYIKNdzDNlDxbN8aHMjU/RUX2oJm/VaIbKsClmz3tBD6tN+Y5BBkj1Str9dKugg/p
         tfSA==
X-Gm-Message-State: APjAAAUfkC4AmBF86mJGJQ/AoBKaI0UVoJIl4TbpSLlBAmZ0dZFrhdqa
        T1rMGQzHeQ9TfM2MiqPsPC0=
X-Google-Smtp-Source: APXvYqyLAbS4p6PzglyVUQ4guUPPG0MEaslcmdum3Oa6W84lqDG1qvELuDEZcYacX/Mb/ZIZoD2R5g==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr6969303wrj.185.1557259581564;
        Tue, 07 May 2019 13:06:21 -0700 (PDT)
Received: from [192.168.2.240] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.gmail.com with ESMTPSA id s3sm29073527wre.97.2019.05.07.13.06.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:06:20 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase --abort: cleanup refs/rewritten
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190426103212.8097-1-phillip.wood123@gmail.com>
 <20190507151530.GO14763@szeder.dev>
 <xmqqpnoujlj4.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d4d1dc5c-14ec-f354-4dac-d17faf533865@gmail.com>
Date:   Tue, 7 May 2019 21:06:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqpnoujlj4.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/05/2019 17:07, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> This patch and the topic 'pw/rebase-abort-clean-rewritten' can't be
>> compiled on its own, because it starts using 'struct replay_opts'
>> here, which is defined in 'sequencer.h', but 'builtin/rebase.c'
>> doesn't include that header yet.  (Though 'pu' already builds fine,
>> because commit 0609b741a4 (rebase -i: combine rebase--interactive.c
>> with rebase.c, 2019-04-17) in the parallel topic
>> 'pw/rebase-i-internal' adds the necessary #include.)
> 
> Thanks; that's entirely my fault.  I needed to find a good fork
> point and failed to do so.  FTR, when there are too many topics
> I need to queue on a given day, I may not have time to compile
> check individual topic branches before merging them to the
> integration branches, testing the integration branches and pushing
> them out.  That was what happened here.
> 
>> So, to keep future bisects from potentially tipping over the compiler
>> error, this patch should either #include "sequencer.h", or be applied
>> on top of 'pw/rebase-i-internal'.
> 
> I suspect that the latter was how the patch originally was
> developed.

Yes that's right, there is a note on the original patch [1] explaining 
why - you cannot just add '#include "sequencer.h"' as there are function 
name conflicts between a static function in builtin/rebase.c and a 
global function in sequencer.c which are fixed in pw/rebase-i-internal

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/xmqqpnoujlj4.fsf@gitster-ct.c.googlers.com/T/#mb431b81731798388e12f3852747c560f8ce7c6ec

