Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E50C433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AC964E85
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhBIRZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhBIRYo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:24:44 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA5C0613D6
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:24:01 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id k10so15818533otl.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=r/u4VyLfw2rlunMA3CEQSOwbKjr+xHAPSAygF7fY9+Q=;
        b=EaUItA3vRnTjlfk4mcq+6045Zh+dmhIPvWmnqcesXx+FAs7jiOVVVwVxHsfRVbIDvd
         yGuerVzOSccRTCvBtEaQxkrGXsRaxFKMD1TwK2LjH9VLf4lSfmJLhW8h247EbgHpdY2d
         +rux7MbfLvuxC2QLiJ+ySeLg6Jz98Zk6JpXSPXcCGtl8ij9WX+K67Mhkzo6mD/CyvL48
         cEFEp/Jctj+sHmc5h+6pBA5TjInw/rPVxyDBzQB+5wDQgBnbE3ZNER16M5u3z0EDsuhD
         yuROhCPD2fjgS85t9/bM/9ovRFwWvdJuuTy5T3TQC0Mq/h+VF0LzpecojHqTX0CPp8mi
         kv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r/u4VyLfw2rlunMA3CEQSOwbKjr+xHAPSAygF7fY9+Q=;
        b=Q3MMUKcPvr/uL9X9gfwmWOIwd7GTuT5uj1PQ3PK+sjXHMVtaMf6+JzFF3qYpdcyCgk
         8XJE/5g6TXq96VPQuTORg+Tn4LcTDNr0RfxcOVdzf74L4WMl6ND8fZZepBQOokT6YoKt
         MR5bbjdc72BBaE3gxrI/8OOnFja3NMgXO7RqAbCdAOQ0FMlBjo4wlYV9L2vFIPAy+V6z
         7iPAhIS6+lzRMZbPuAiVXb6ELGaRSzbnx7QQccu/wF8j2nnM4jXYwfOOA9xmuL0mXVcm
         3ASxst8i7MVbsMc3VwtjEn9nkgglV2AEeOjwqDDFu3hWbSju4cnYqN7ioagooGCQNbcK
         X/Ew==
X-Gm-Message-State: AOAM530HkxPae4k0gLNPln1B99PI8IH/IrBQAFf1aVkVB20knnZw8+dO
        NnL/8w4QmjP+8xYBzBHONwk=
X-Google-Smtp-Source: ABdhPJwyEpQbR/Hd5TayWq2kwvuXIj5M38T98I6v0d9dVFz+xQrI7f+v+CO0knZwiIonpGe7y6epNw==
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr16662495otl.69.1612891441014;
        Tue, 09 Feb 2021 09:24:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7c18:1f04:a165:5ea0? ([2600:1700:e72:80a0:7c18:1f04:a165:5ea0])
        by smtp.gmail.com with UTF8SMTPSA id m10sm4474721oim.42.2021.02.09.09.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Feb 2021 09:24:00 -0800 (PST)
Message-ID: <50ed919d-99ad-d4e7-6ebd-514f13ec181a@gmail.com>
Date:   Tue, 9 Feb 2021 12:23:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH 16/27] unpack-trees: make sparse aware
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <45cf57c9c40bebb7383b8aab19c82fc4e41d2cd3.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BEjm1NJ8GAn6iKJDvgFYw7mMrR8T66RZtUi6nwgPcXRHQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BEjm1NJ8GAn6iKJDvgFYw7mMrR8T66RZtUi6nwgPcXRHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/1/2021 3:50 PM, Elijah Newren wrote:
> On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> It is important to be careful about the trailing directory separator
>> that exists in the sparse directory entries but not in the subtree
>> paths.
> 
> The comment makes me wonder if leaving the trailing directory
> separator out would be better, as it'd allow direct comparisons.  Of
> course, you have a better idea of what is easier or harder based on
> this decision.  Is there any chance you have a quick list of the
> places that the code was simplified by this decision and a list of
> places like this one that were made slightly harder?

I'm going through all of your comments and making notes about areas
to fix and clean up before starting a new series for full review.

This question of the trailing slash is important, and I will take
particular care about answering it as I rework the series. However,
the questions in this patch poke at the right places...

>> +       /* remove directory separator if a sparse directory entry */
>> +       if (S_ISSPARSEDIR(ce))
>> +               ce_len--;
> 
> Here's where your comment about trailing separator comes in; makes sense.
> 
>>         return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
>>  }
>>
>> @@ -989,6 +999,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
>>         if (cmp)
>>                 return cmp;
>>
>> +       /* If ce is a sparse directory, then allow equality here. */
>> +       if (S_ISSPARSEDIR(ce))
>> +               return 0;
>> +
> 
> This seems surprising to me.  Is there a chance you are comparing
> sparse directory A with sparse directory B and you return with
> equality?  Or sparse_directory A with regular file B?  Do the callers
> still do the right thing?  If your code change here is right, it seems
> like it deserves an extra comment either in the code or the commit
> message.

Sometimes a caller is asking for the first index entry corresponding
to a directory. In these cases, the input could be "A/B/C/". We want
to ensure that a sparse directory entry corresponding exactly to that
directory is correctly matched. If we place "A/B/C" in the index instead,
this search becomes more complicated (I think; I will justify this more
after thinking about it). 

At this point in time, we are just saying "We found the entry with
equal path value!" and not failing with the check in the rest of the
method:

	/*
	 * Even if the beginning compared identically, the ce should
	 * compare as bigger than a directory leading up to it!
	 */
	return ce_namelen(ce) > traverse_path_len(info, tree_entry_len(n));

>> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>> +               if (recurse &&
>> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>>                                              names, info) < 0)
>>                         return -1;
>>                 return mask;
> 
> The unpack_callback() code has some comparison to a cache-tree, but
> I'd assume that you'd need to update cache-tree.c somewhat to take
> advantage of these sparse directory entries.  Am I wrong, and you just
> get cache-tree.c working with sparse directory entries for free?  Or
> is this something coming in a later patch?

In the RFC, I integrate the cache-tree with the sparse-index at the
very end. I will move that integration to be much earlier in the next
submission, so it becomes part of the format discussion.

Thanks,
-Stolee
