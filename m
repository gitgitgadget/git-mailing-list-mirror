Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D951C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A552221FC
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgLBSXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728475AbgLBSXK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 13:23:10 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D014AC0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 10:22:29 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id f16so2501931otl.11
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 10:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OdXKP2AtiMeynwnoVqGjhC+IAL6zLxtALpnoZNGl71s=;
        b=jUh1q4yMz+hcll1L6Wf3OtWeQTUbKnOHU8qduNwJqVbsdzeZ53g7gxfZRfRVF4JHqG
         4pU4aG3Eiurc0zHStSg6ucqP8lDh0swDqBjiR0TK63XfikiZKp7jKb/evBv2ghCRjJsj
         PxInhlTC1Gs0Wk0BOXrz6p4E98bnU96qXN2ZmqTU8QU9B9TnpvEubluZ6Il+exxXLRsj
         sWJTC+oraTWR82yNLpcQyOpzTdE6294rvGmR/fmzb3z/VRObciUCFHOylQtVyFiCfdMq
         C9WDukoBWsOJY4aHtKU+YGEKDG9jQtOyqwPKK16Seq5vcOmtD7+z7n7GeIVrwOa3xtgx
         Agkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OdXKP2AtiMeynwnoVqGjhC+IAL6zLxtALpnoZNGl71s=;
        b=Ze/oPQwUi3i1TlAIS1Mqjo/b22vn745qWJueuV0zaX3L/fl7faY4olI3gMWj8ZUK41
         8ZO4ipfMq0JuyOdi8nZxNim6R1LImU6lDULgjaY3SQljN6uhdNB/CAyxvpXAUaQazlbo
         SRlj8ydh8EUWMnm4xmbc8tE+SRM+2vjMKsLH4VjZhAAK5OcFVcEF+VIwY5HpeJJBy0Gn
         DQafmbGI5yQ835WOGtJduxUYwHJKNNtrEqgFCkVUwmFZSJt2m00PoR+wTudRwAk7ych1
         5m4ybkJ1HNufywO1t+RQLy7UDhh+1ROSK9z+gBgopYOKfNQDJyLDgS6RbUGKRV2psBSI
         wYsg==
X-Gm-Message-State: AOAM532nMdXWrOfmcQXwm2oashMNe+Y6w1gA2aDz4MMTZT/QAYAj0LnY
        QiwvnwGn0ZFMddxNfd0vjOw=
X-Google-Smtp-Source: ABdhPJy7AhYPq8zmwDb4gkagVCQe3sCY8YvJeA/icnDKcSzftyQmNEakZH4EdGN2yqfKEUbSDbfsEg==
X-Received: by 2002:a9d:64c4:: with SMTP id n4mr272683otl.234.1606933349127;
        Wed, 02 Dec 2020 10:22:29 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i6sm556137oik.36.2020.12.02.10.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:22:28 -0800 (PST)
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
To:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com
References: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
 <20201202080808.3482917-1-jonathantanmy@google.com>
 <X8fCViBtnDek6oAI@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
Date:   Wed, 2 Dec 2020 13:22:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8fCViBtnDek6oAI@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/2020 11:35 AM, Taylor Blau wrote:
> On Wed, Dec 02, 2020 at 12:08:08AM -0800, Jonathan Tan wrote:
>>> +			c_ent->maximal = 1;
>>> +			p = NULL;
>>
>> Here, we're setting maximal without also setting a bit in this commit's
>> commit_mask. This is fine because we're not propagating this commit's
>> commit_mask to any parents (we're not continuing the walk from this
>> commit), but it seems like a code smell. Suggested fix is below.
>>
>>> +		}
>>> +
>>>  		if (c_ent->maximal) {
>>>  			num_maximal++;
>>>  			ALLOC_GROW(bb->commits, bb->commits_nr + 1, bb->commits_alloc);
>>>  			bb->commits[bb->commits_nr++] = commit;
>>>  		}
>>
>> As far as I can tell, this means that this commit occupies a bit
>> position in the commit mask that it doesn't need. Could this go into a
>> separate list instead, to be appended to bb->commits at the very end?

I don't see any value in having a second list here. That only makes
things more complicated.

>> We could even skip the whole maximal stuff (for commits with existing
>> bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
>> we're going to append to bb->commits at the very end". That has the
>> advantage of not having to redefine "maximal".
> 
> Hmm. I'd trust Stolee's opinion over mine here, so I'll be curious what
> he has to say.

It would be equivalent to add it to the list and then continuing the
loop instead of piggy-backing on the if (c_ent->maximal) block, followed
by a trivial loop over the (nullified) parents.

>>>
>>> +		if (!c_ent->commit_mask)
>>> +			continue;
>>
>> I think this should be moved as far up as possible (right after
>> the call to bb_data_at()) and commented, something like:
>>
>>   If there is no commit_mask, there is no reason to iterate over this
>>   commit; it is not selected (if it were, it would not have a blank
>>   commit mask) and all its children have existing bitmaps (see the
>>   comment starting with "This commit has an existing bitmap" below), so
>>   it does not contribute anything to the final bitmap file or its
>>   descendants.
> 
> Good suggestion, thanks.

Yeah, makes sense to me.

Thanks,
-Stolee
