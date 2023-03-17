Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7B2C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 18:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCQSoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 14:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCQSoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 14:44:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF339CF5
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 11:44:15 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v17-20020a9d6051000000b0069a413e9cf6so3376127otj.3
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 11:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679078655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qs7lPfPRebShMRCDwMCbLly9YYiQytuC9FGn7SAW9NM=;
        b=iBSWpuh0xnNPWgwVkXOhRUrCpLdoBwJd4hA633bJ1qkF9QH3x1Qb0nNlAI8gavGYvv
         Cotkfak5ssPrtv7o+b/wcCE4sBltQMciVeSnPBV1THYYatNmidVJ4zVnogyr+JRQfciO
         kgrQyxJWilbZr5X5aq7zpzTPDoQmk5+nqyZrRUfF41tVrjgSiM9NKobR+0EJe4zCT656
         Dp5tm8BRCVKXWVVHtUQtL+FHe3dD9/Bo8DhhsUpTgR2CKPDeb6bPJDyN92KWs7kHzKGh
         Lhh2Z7OF2ClwkkKXQeDxQKUtWb6E00W9zr2N8coqAcxVjnmlCgc+kNdhsmijGukOhvyB
         eTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679078655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs7lPfPRebShMRCDwMCbLly9YYiQytuC9FGn7SAW9NM=;
        b=WtRpoLarLKv88u/XRjT5/F8Ff/b5hp0nOaL5+bKQ0k16cXybKkoYM+mdTH7P+mmYkw
         iOn7AVqhQnHgUrmdi41Z3ujRO9ikGyIxkkp3UV8lSeh7qR5nlsQevJM0zJoAsbYBJEdE
         u/IJzMlJg90hkeKLKLGSM/aE9MmdXACJVc3/F8oO7qWf+1YK/KhAbKn9Qk3vjGD+giwR
         l+INiLz9ENKfUzyrUofuRs+aJIaNnXO/kOJxCnqrY9kNAo9eMybE6ewGQ32Ybg8Ju/2D
         x549HQt10PFVqmVRMK628syFJZUhQYQ2PKqvsMt3+afcx4wrabczlVQyEz/1Zm2Qs39l
         BvJA==
X-Gm-Message-State: AO0yUKVq3Tnbsv3wEwFGJbIq3y+8qgYchuH3UwMhOtl9U1dti/+3eAla
        M4WsWr3HPbPBVTEvlfiP3ZZ9
X-Google-Smtp-Source: AK7set/4Ey9SF4KfIAPFxcc9tyD8GkvSIDoNgm7zbUNuiwBmWyht2wotyY8B1YD2aCjlLz+FscBy8w==
X-Received: by 2002:a9d:798c:0:b0:693:d998:f50c with SMTP id h12-20020a9d798c000000b00693d998f50cmr309360otm.5.1679078654998;
        Fri, 17 Mar 2023 11:44:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b55b:7e6b:71e6:ade7? ([2600:1700:e72:80a0:b55b:7e6b:71e6:ade7])
        by smtp.gmail.com with ESMTPSA id a31-20020a4a98a2000000b005251f71250dsm1022256ooj.37.2023.03.17.11.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:44:14 -0700 (PDT)
Message-ID: <9bd7943c-a8a3-5022-bd7e-f95be8dc2ab5@github.com>
Date:   Fri, 17 Mar 2023 14:44:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 6/8] commit-reach: implement ahead_behind() logic
Content-Language: en-US
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230315232835.173584-1-jonathantanmy@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230315232835.173584-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 7:28 PM, Jonathan Tan wrote:
> First of all, thanks to Taylor and Stolee for this algorithm and code
> - it is straightforwardly written and looks correct to me. I have some
> commit message and code comment suggestions that if taken, would have
> helped me on my first reading, but these are subjective so feel free
> to ignore them if you think they would add unnecessary detail (I did
> understand the algorithm in the end, after all).

I appreciate your comments here. I've done some reworking of the
message based on what you say here, as well as the verbal feedback from
review club.

>> +void ahead_behind(struct repository *r,
>> +		  struct commit **commits, size_t commits_nr,
>> +		  struct ahead_behind_count *counts, size_t counts_nr)
>> +{
>> +	struct prio_queue queue = { .compare = compare_commits_by_gen_then_commit_date };
>> +	size_t width = (commits_nr + BITS_IN_EWORD - 1) / BITS_IN_EWORD;
> 
> As we discussed in our Review Club, DIV_ROUND_UP can be used for this.

Got it!

>> +			if (bitmap_popcount(bitmap_p) == commits_nr)
>> +				p->item->object.flags |= STALE;
> 
> Might be worth adding a comment above the STALE line: this parent commit
> and all its ancestors can be reached by every commit in the commits
> list and thus can never be "ahead" or "behind" in any pair; mark this
> STALE so that, as an optimization, we can stop iteration if only STALE
> commits remain (since further iteration would never change any "ahead"
> or "behind" value).

This is a helpful thing to point out, so a comment is appropriate.

Overall, maybe algorithms like this should have more inline comments
than we typically expect in the Git codebase. We want to make sure that
these things are readable in the future, hopefully without digging too
far in the history to find the lengthy commit message about it.

I'll delay sending v4 until giving a little time to hear back on this
point. My default is to not add the comments, but I'd be happy to, if
we think this is an appropriate time to deviate from the standard.

Thanks,
-Stolee
