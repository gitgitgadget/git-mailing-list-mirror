Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE36CC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F4F224BD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbhAKLyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbhAKLxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 06:53:06 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB8C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:52:26 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d203so19873618oia.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4r378JHHo58t9RGr4f2hOlf46uRyUSCwOwOl+SvJnI8=;
        b=Lm7Rx3kfK/afPQmCeS8cz3ydDmlDEBFvrYNCVcsGltHdr/j0Hn8p2nTsr79QYHlcdt
         HN3PzHUbQChAcENMc1Z7iCbF1fFylFAzZYOnrt5SPZ0JxakAF1SE3WJEcc7fy2UZDuOF
         sb5T096ZmkKMdIGRxjzn+ksJlnOQ0N151D551pEWIVb8Ur9/WvU79/AKnrhyodLVCmKi
         zbTMZOitnwgETFpT2FOj8s8q8u6eVxjqMRKeQH0mc4LbNPciKHgKjyQHsOdEnSG9BP84
         ekpJjjdkOPBB7BkFU9u4PtNvImvZDlZFc2dKdD4m9bx5NHfvEHLTA7uMpCozJ6gtl9V9
         V3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4r378JHHo58t9RGr4f2hOlf46uRyUSCwOwOl+SvJnI8=;
        b=uijJbwXwBoTUxNRZQguzcTchAPlvHqO/99hv3ePRZUNE0p5qk5pzZCLatUP25rUmHW
         qg4FYLMmUPwO13Th3FxLgJkLV0mKPtZanmhIf+JJWjiUXPBp619+YXOuQeOTG1rOiBt9
         NQlQ1TUFBYPfNfv7paNxncHBhWy9Ug4C7cZWfVcrGya0mYqPzWHBFf1FzJVexVMSRrwx
         kKTwnWYbVZVu63STBHTdrWw67o0Qn5EsX77c4IIh4o7MBBxrv/rJLgXuzEPUfZ/oSxtP
         U4PaBvy1lTvNwL7/2Bquo8ni+fMlMaE4G9puICV2Wjan6Joikiomr+9msnEiuvuZ9tBj
         ig3w==
X-Gm-Message-State: AOAM532vzZ2k/aFhj6k0MXtpudySF0u7+m+xq+bv5F792H5iiUgrXW+b
        UUybqCWxDbrBPvW33mUcZkRGWYgXI30=
X-Google-Smtp-Source: ABdhPJzsay32EcNHqSKBfit71sRmeXWB3HwBaqT9/aP2xesKlNNtyBe1pb3E9D8MQchPHE+2zIKBKw==
X-Received: by 2002:aca:4b0d:: with SMTP id y13mr9628741oia.7.1610365945795;
        Mon, 11 Jan 2021 03:52:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id r25sm3570199otp.23.2021.01.11.03.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:52:25 -0800 (PST)
Subject: Re: [PATCH 16/20] builtin/gc.c: guess the size of the revindex
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <87cd1b2c-7a28-da77-4ae4-99ffbbdfda72@gmail.com>
Date:   Mon, 11 Jan 2021 06:52:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <7c17db7a7df8b524f13969efd1cb5e6e95de5a2d.1610129796.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:17 PM, Taylor Blau wrote:
> 'estimate_repack_memory()' takes into account the amount of memory
> required to load the reverse index in memory by multiplying the assumed
> number of objects by the size of the 'revindex_entry' struct.
> 
> Prepare for hiding the definition of 'struct revindex_entry' by removing
> a 'sizeof()' of that type from outside of pack-revindex.c. Instead,
> guess that one off_t and one uint32_t are required per object. Strictly
> speaking, this is a worse guess than asking for 'sizeof(struct
> revindex_entry)' directly, since the true size of this struct is 16
> bytes with padding on the end of the struct in order to align the offset
> field.

This is so far the only not-completely-obvious change.
 
> But, this is an approximation anyway, and it does remove a use of the
> 'struct revindex_entry' from outside of pack-revindex internals.

And this might be enough justification for it, but...

> -	heap += sizeof(struct revindex_entry) * nr_objects;
> +	heap += (sizeof(off_t) + sizeof(uint32_t)) * nr_objects;
...outside of the estimation change, will this need another change
when the rev-index is mmap'd? Should this instead be an API call,
such as estimate_rev_index_memory(nr_objects)? That would
centralize the estimate to be next to the code that currently
interacts with 'struct revindex_entry' and will later interact with
the mmap region.

Thanks,
-Stolee
