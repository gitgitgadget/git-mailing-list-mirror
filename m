Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007FAC433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C619D61039
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 19:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhJQTgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJQTgN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 15:36:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB3C06161C
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 12:34:03 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t16so13547726qto.5
        for <git@vger.kernel.org>; Sun, 17 Oct 2021 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=qL55lqilnR65AFD/Ti9d+OJ3gODBLqmOErEkZOWHFYI=;
        b=nma8vqq27N7sg46hXn95bZ+naOyrL1uM+T3MF4z0AB9NqHViTXl3bWyvtaPnEeraUm
         CRwut8ZamyU441Qr7lhL7C2fGx8mqHCYEFTMsWtkwRqIgTxfczLwwik/okXNQB8x/iBu
         8ueO3G46q/wFKAdz99T0Pi50R1zPCSAr4QKD4Gy8FRLtbS4cRz2v75Oe+rqNS4b4Ckc9
         z+P9wX8Jdv54W+Jd9EYT4uJyIImeTIyiBBE6zLnxApBYBmOmNfRpl0AX2MZ3mJlumvBt
         kt6GicLyqkdGbTM+VG4Rf4by+6GJu9jGjrX8d+p2X+2J0TSuZpDX+3TqOQQp2a0IWbWI
         eYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qL55lqilnR65AFD/Ti9d+OJ3gODBLqmOErEkZOWHFYI=;
        b=sAGXoEHOLbsWP5RrH7jW1EvwKLEzw4+vyXnO4uTnKQYh2xsFAgIgOdUeqFuQ/l6PqL
         TaUG/uNLnqA6ccoOVOaQHMLvh9nufBPh+nzuJkhwPL/d0vvBrxN196DwkbABZcfIArus
         34LmnwWVtXSzregYWHTmMGhtB+tYFE0a943mXHm4EORMdOm9JvUEu4CxmFlVcfqIdjk9
         iWqmdsWJvrTjFkHKcFBRWlrQHOvgA16kJWCS7vKE9bslUvNxvXPADG52HThQiJaI0/l1
         Q5XWrQOGBP4FWottmhvGuMV99K7HlN9O2w+HJl0/m0BPUCWZbf69J+fTRr1eQV6n4z+B
         tbXw==
X-Gm-Message-State: AOAM532ZowAkJcqEBLfyqrWreGgpqt4grK+gZR7LQBKIgIo2jz6lFe8C
        Kb0bfYLxNEonC4Ur7i8Nx3Q=
X-Google-Smtp-Source: ABdhPJx4pCrQbPRb3PDXRAF4WACTDKemARS9+dg1kB0up98SXf1qSM76gZfBE23EbXpBVwAeU9AcxA==
X-Received: by 2002:ac8:5747:: with SMTP id 7mr25787238qtx.11.1634499241834;
        Sun, 17 Oct 2021 12:34:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90b3:b602:b30:17a8? ([2600:1700:e72:80a0:90b3:b602:b30:17a8])
        by smtp.gmail.com with ESMTPSA id r186sm5559441qkf.128.2021.10.17.12.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 12:34:01 -0700 (PDT)
Message-ID: <8c148f7d-f175-7dc5-51a0-eef48aa98c3d@gmail.com>
Date:   Sun, 17 Oct 2021 15:33:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
 <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
 <xmqqh7di3qfu.fsf@gitster.g> <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
 <xmqq5ytw19ck.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5ytw19ck.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/17/2021 1:58 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> I think you are slightly mistaken here: If index.sparse=true, then a
>> full index will be converted to one on write, but not immediately upon
>> read. This means that subsequent commands will read a sparse index, and
>> they will either benefit from that or not depending on whether they are
>> integrated with the sparse index or not.
>>
>> The new behavior here is that if index.sparse=false, then we convert
>> a sparse index to a full one upon read, avoiding any chance that a
>> Git command is operating on a sparse index in-memory.
> 
> And if index.sparse=true, then we convert a full on-disk index to a
> sparse one in-core upon reading, right?  My comment was solely on
> that side of the picture, not on the "index.sparse is set to false
> so we automatically expand" case.
> 
>> The simplest summary I can say is here:
>>
>> * If index.sparse=false, then a sparse index will be converted to
>>   full upon read.
>>
>> * If index.sparse=true, then a full index will be converted to sparse
>>   on write.
> 
> Oh, I see, so yes I was very much misunderstanding what you guys are
> trying to do.  I somehow thought that sparse-to-full and
> full-to-sparse conversions (1) already happen on the write codepath,
> and (2) this patch makes them both happen also on the read codepath.
> 
> IOW:
> 
>     * If index.sparse=false, a sparse index will be written as full,
>       and if it is true, a non-sparse index will be written as
>       sparse, even before these patches.

This statement is true.

>     * In addition, with these patches, if index.sparse=false, a
>       sparse index will be expaned to full upon reading, and if it
>       is true, a non-sparse index will be shrunk to sparse upon
>       reading

This is only half true. If "index.sparse=false", then a sparse
index will be expanded to full upon reading. If "index.sparse=true"
then nothing special will happen to an index on reading.
> What your summary above is saying is very much different.

Yes, these are different things. It also gets around the concern that
"if we have a non-integrated command, then index.sparse=true would
convert a full index to a sparse one, only to be expanded again".
That doesn't happen if we only convert from full to sparse on write.

Thanks,
-Stolee
