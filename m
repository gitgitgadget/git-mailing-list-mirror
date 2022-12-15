Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA35C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 12:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLOMzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 07:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLOMzj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 07:55:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96B510A7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:55:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u12so2909935wrr.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYKJqYgerNshpTPQ4iA6tbQ8Kg6wil2iWI1jVUQpfCM=;
        b=Lp4C49YZBhsGSsQ74RXkTQ0o0+3Ynim2fR1IezXlL6fpKSiriefH5AJtjBsYTepsIn
         G+DE5FdQ/l+8333Wh7X7F7IkZm2+XiqnR2hp9YJJE9r7z2A8HhfVhIzE2Wop5XMjoO18
         7NfGIIVqPTwD7LTb+S0k5zX+jailE02jy+z/USkpoo+jbD/V/EoreKDht0h+PSwq46iH
         /uqnrKYBSVWHdNThx2HufESHTDExpOXzc9cFHvoXOTve/eZ88rPqmWbPrTVjWgrq3ZF9
         PAt16oDqlCHk6dHb7fvR2X7wJk7YqkQglxOpktqKsZc3OrAoTYVhWAEdYtnwp4vF26o+
         wy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYKJqYgerNshpTPQ4iA6tbQ8Kg6wil2iWI1jVUQpfCM=;
        b=VlIRSBkuxjspmtjK7hTL6N0GtVHLrj3n/FSdFtXYFLOxf0lW8QseEYVPTEeI+1052r
         uj6iy4f/cTXyAZxZMVipcd2gMCcFfrXRlA0PfC0YgLjU4YHkDdozgOTTH+3BcnwKNU+/
         X83nOblb0AD/41ZWZ4PWsYAYJiIZDPBmUqYIgNmd9WUvx+hmRT7DS7rAw4ncY/PEzLOC
         XzgDDi4WFVAg35kjOMhYlUMKIkGiDMEla7/4uunKw/U2XEuhGvgqMAL2kCMC83R4YyGT
         AHuL/vjMuUgOIKPtLdl/kVWDZF4ISLKb3NDs7qeCn2DYgo+zamCKg8+LNPo23XV721ww
         D+gA==
X-Gm-Message-State: ANoB5pnzueQDM+liB/vslY7DzwuNL5byU61ESrb++PmYqieBEfZwM+KA
        NGf5TuADkkcTKfh1jLIfbSr8qm6Pm7Y=
X-Google-Smtp-Source: AA0mqf6zU0tLEZUN4SAKbq/KP7U7szmRI2s4pHdqmIS8jQlnji04l7EHZsEDphWi2NxXg7JoT6k/6g==
X-Received: by 2002:a5d:4890:0:b0:241:fa43:d985 with SMTP id g16-20020a5d4890000000b00241fa43d985mr22372617wrq.12.1671108936311;
        Thu, 15 Dec 2022 04:55:36 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id g4-20020a5d5544000000b0023677e1157fsm6004917wrw.56.2022.12.15.04.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:55:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <c9c2c979-82b3-8be1-1edb-343661cf4b32@dunelm.org.uk>
Date:   Thu, 15 Dec 2022 12:55:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: ag/merge-strategies-in-c (was: What's cooking in git.git (Dec
 2022, #05; Wed, 14))
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <xmqqiliewbje.fsf@gitster.g>
 <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
In-Reply-To: <221215.865yed3tzv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/12/2022 09:14, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 14 2022, Junio C Hamano wrote:
> 
>> * ag/merge-strategies-in-c (2022-08-10) 14 commits
>>   . sequencer: use the "octopus" strategy without forking
>>   . sequencer: use the "resolve" strategy without forking
>>   . merge: use the "octopus" strategy without forking
>>   . merge: use the "resolve" strategy without forking
>>   . merge-octopus: rewrite in C
>>   . merge-recursive: move better_branch_name() to merge.c
>>   . merge-resolve: rewrite in C
>>   . merge-one-file: rewrite in C
>>   . update-index: move add_cacheinfo() to read-cache.c
>>   . merge-index: add a new way to invoke `git-merge-one-file'
>>   . merge-index: drop the index
>>   . merge-index: libify merge_one_path() and merge_all()
>>   . t6060: add tests for removed files
>>   . t6060: modify multiple files to expose a possible issue with merge-index
>>
>>   An attempt to rewrite remaining merge strategies from shell to C.
>>
>>   Tired of waiting for too long.
>>   source: <20220809185429.20098-1-alban.gruin@gmail.com>
> 
> I submitted a v9 of this during Taylor's maintainership, but it fell
> between the cracks. I've submitted a rebased-on-master v10 now (there
> were some conflicts):
> https://lore.kernel.org/git/cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com/
> 
> It's just the "prep" patches, the real meaty part is converting the
> merge drivers, which will come after. Some of the performance numbers
> for those are really impressive...

I think splitting this in two is a good idea as there were only a couple 
of outstanding issues with the first half of Alban's V8. When you posted 
V9 I looked at the range-diff hoping to see a couple of localized 
changes addressing those issues. Instead it looks like you've rewritten 
most of the patches that people have already spent a considerable time 
reviewing. I don't think it is a good use of reviewers' time to 
essentially start reviewing again from scratch.

Best Wishes

Phillip
