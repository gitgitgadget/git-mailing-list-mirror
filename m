Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A163C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461E46144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbhDUOEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243187AbhDUOEh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:04:37 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04BEC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:04:03 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so9237029ool.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w78Z8FFMlbbNwnz7PujrXEbRgILnmr8MrEjMXs04btQ=;
        b=AIKNkqY2nLeRXEWyIzYTfFRG7kfr+zkmw0/RT436Z6LhRMlG5w1TKtXAHkzF+o5po3
         b1tJBWhmTciwlQSkP8S+hSSuFZLld/jNAh6iEby6uIDawcWIE6qV4dP4HQFTTb35E3R8
         GPjayEuf3HX/I9VfNjhbqUvg6GkCFejw1xrUurgipFGO1xEtAr3OjYdJL3epCVNkO+bi
         cE2Pkc9JyZwjsXLuNTM41XrZMvBZE1duq2LsGZLYbBWg2r+cALm/2Wn41hmfetfSPFLK
         vGIYjSGZy9K5Ol8FvgrRWwLA1pmgmnTkbN70SuYTPB3yMG6yFQC+eMOCfr5hZD+vW94P
         gMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w78Z8FFMlbbNwnz7PujrXEbRgILnmr8MrEjMXs04btQ=;
        b=prea7432lgCBt6kuvlqbq8PbH1nksDIn5J6u2JwJohp2Bto4HWh7rbLLeq6AlIL00l
         Ic1vBCW9+lLtCF6DnaUd9bW3qvAUhxPzBC3tVnH+CLz33ekQnGURvvSNUYusS7baxd1p
         buzKWP3GT2TTXjqqaG4Z2DByMqf5/AgMpiiLh8TtHmsD4GRKf8108gCbPe3aqS42Vyp6
         xGNxNfsRpuZOcOtqdlNKSEElhxFlk/2I4ZtQrzZbbW+T+k6vVxl4H2fEcAzEMPkRZVPy
         qDOnvhGm/rdota1jE4vgahg/E8o9tmXHxqYyrrKaxcWIVb8jzVT7aa9HZ/s9wMlwhz6A
         SZBQ==
X-Gm-Message-State: AOAM5308Ar8IMYxRW3k83mLXdGKMyCWxBDeFxH47bcmax9LKZT3HekLy
        uStRa1LegIHk15LGqNp8i8E=
X-Google-Smtp-Source: ABdhPJzs/aH6YaT37igOfnXr9WRlLg8b7CcJkkxYiI8wN8/PASzVEyj3BWYU5dKxlanZvdwJtw5gAg==
X-Received: by 2002:a4a:1104:: with SMTP id 4mr21009985ooc.57.1619013842656;
        Wed, 21 Apr 2021 07:04:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:e10e:eea5:8b82:2147? ([2600:1700:e72:80a0:e10e:eea5:8b82:2147])
        by smtp.gmail.com with ESMTPSA id s26sm523784otd.75.2021.04.21.07.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 07:04:02 -0700 (PDT)
Subject: Re: [PATCH 06/10] dir: use expand_to_path() for sparse directories
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <434306541613cbd0b9bb4ebb3102d97e3df9eb94.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BE2qzvFwp0Gg_o+Sd5oC2itpkLNuhvEv1qWTvbCGUKWhQ@mail.gmail.com>
 <CABPp-BHLTKWW_j53P9=mwGpmAiuBUcUvRp2Oaim8T+SB46+h+g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c120e61f-7eed-78f5-c3ac-ae4c1d9f7c14@gmail.com>
Date:   Wed, 21 Apr 2021 10:03:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BHLTKWW_j53P9=mwGpmAiuBUcUvRp2Oaim8T+SB46+h+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/20/2021 8:53 PM, Elijah Newren wrote:
> One more thing:
> 
> On Tue, Apr 20, 2021 at 5:52 PM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> Test                                  HEAD~1            HEAD
>>> ------------------------------------------------------------------------------
>>> 2000.4: git status (sparse-index-v3)  1.50(1.43+0.10)   0.04(0.04+0.03) -97.3%
>>> 2000.5: git status (sparse-index-v4)  1.50(1.43+0.10)   0.04(0.03+0.04) -97.3%
>>
>> Um, I'm confused.  In the previous patch you claimed the following speedups:
>>
>> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  0.04(0.05+0.04) -98.4%
>> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  0.05(0.04+0.07) -98.0%
>>
>> I don't understand why the "Before" for this patch claims 1.50 as the
>> initial speed, if the "After" for the last patch was 0.04.  Should the
>> previous commit message have instead claimed:
>>
>> 2000.4: git status (sparse-index-v3)  2.43(2.33+0.14)  1.50(1.43+0.10) -38.3%
>> 2000.5: git status (sparse-index-v4)  2.44(2.35+0.13)  1.50(1.43+0.10) -38.5%
...
>> Oh!  So, the previous patch was testing without enumerating untracked
>> files (because it did those slowly), whereas this one enumerates
>> untracked files and is still able to achieve the same performance?
>> This wasn't very clear from the commit message.  Maybe I'm just bad at
>> reading, but perhaps the commit message could be tweaked slightly to
>> make this more clear?
> 
> Why is the subject of this commit "dir: use expand_to_path() ..." if
> it only touches t1092-sparse-checkout-compatibility.sh?
 
You are right to be confused. This is another patch that simplified due
to refactors in the protections branch. This should just be squashed into
the previous.

For context: an earlier version inserted ensure_full_index() before
every call to index_name_pos() and then this patch swapped that for
a call to expand_to_path(). The change in the protections branch was
to have index_name_pos() call expand_to_path() itself, preventing the
need for these ensure_full_index() calls.

Thanks,
-Stolee
