Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97120C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 18:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjCXSGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbjCXSF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 14:05:59 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C3723D91
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:04:07 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-536af432ee5so48085857b3.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679681046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2na2+n0izRa93r+f8GfA5dIvwi1DHslinPQjw92j6Q=;
        b=ZWWSaea9hl+HqHIDKUk9AxgLdqnVlwY6xV2AknAxQKrzW7pEvUeEpsTOavHrlKNeRV
         mQDs298YTD4aoxfn3hd+lCjOO7XBr1VqFxSGOl1M19uYuptBAQlm/iInfpV3z3IN7x/6
         bclMJ0I17U/WlMiBTLgIJEK4OvOOSxyZjWAtYe/lOgnN5YJc/3lEwD0WJRvVUa0cwFIz
         6Tv9BFw1QAfiA+U2+yHGT3ZdH5v4GQW/8VxCcMJlef1LPvUDlm7UQDkXGVJXKdYieAuG
         Hvx3ooJVdgynvcBvWCam+Ap/zLYtHSrDkL8WwehA8CdheWeDhAtIZbDur/b4WsnW6VYr
         xl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679681046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G2na2+n0izRa93r+f8GfA5dIvwi1DHslinPQjw92j6Q=;
        b=bah/w4owWU9hDeUvtKbTHeRZ2ln8JQwK82FJ39GoRYQqhpHW/f3GHTMsjQR0j3qfg1
         27myG4BqE8bDR9Vmoiw4uv5DWtma9U/ZXYhrXNSTkhribQAQG+apNgObbk5Py6q/zggA
         QKs1aRmTX/RBa+D3VuRpzG/yrqEwAC0HaSkOZg4YUm9UwNKT0Mj+VWrDSK4AMka7CxTd
         V6AnXYnkQfCSiPBTE1cFrnpI73VsldiuGuxYuTMumnPCjVxehvo4TVUZcdXrDM066yhZ
         Q70gCGbMkgYZdjo3lrnnP58ZZv5lR6uQovNmgbqJ8U6A+XHVtsxZZ0E21r6j5erHIr6v
         HqUA==
X-Gm-Message-State: AAQBX9eYnCcMXsI+jI9l59Be6ouOtrPdAI4Dry+2NSSpjZMm5GB5cFdE
        u0n3r+yrOx9KbCqwUGP+jYzJ
X-Google-Smtp-Source: AKy350ZzpQqNvS9vCQBD1ri8NfzgbC1E7LguDPDZRCKarTtutJhXcofq8zZByy5cv27Iiy71UyFtoA==
X-Received: by 2002:a0d:d505:0:b0:541:7193:e136 with SMTP id x5-20020a0dd505000000b005417193e136mr3053509ywd.23.1679681046144;
        Fri, 24 Mar 2023 11:04:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id d123-20020a0ddb81000000b00545a08184e4sm542046ywe.116.2023.03.24.11.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 11:04:05 -0700 (PDT)
Message-ID: <61ae4ad5-4d4d-933c-a2cb-e7e2cd734401@github.com>
Date:   Fri, 24 Mar 2023 14:04:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4/6] pack-bitmap.c: factor out manual `map_pos`
 manipulation
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover.1679342296.git.me@ttaylorr.com>
 <0decf13869df6216914044a560d94968126836f4.1679342296.git.me@ttaylorr.com>
 <20230321175612.GF3119834@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230321175612.GF3119834@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2023 1:56 PM, Jeff King wrote:
> On Mon, Mar 20, 2023 at 04:02:49PM -0400, Taylor Blau wrote:
> 
>> The pack-bitmap internals use a combination of a `map` and `map_pos`
>> variable to keep a pointer to a memory mapped region of the `.bitmap`
>> file, as well as the position within that file, respectively.
>>
>> Reads within the memory mapped region are meant to mimic file reads,
>> where each read adjusts the offset of the file descriptor accordingly.
>> This functionality is implemented by adjusting the `map_pos` variable
>> after each read.
>>
>> Factor out a function similar to seek() which adjusts the `map_pos`
>> variable for us. Since the bitmap code only needs to adjust relative to
>> the beginning of the file as well as the current position, we do not
>> need to support any "whence" values outside of SEEK_SET and SEEK_CUR.
> 
> I like the idea of centralizing the bounds checks here.
> 
> I do think copying lseek() is a little awkward, though. As you note, we
> only care about SEEK_SET and SEEK_CUR, and we have to BUG() on anything
> else. Which means we have a run-time check, rather than a compile time
> check. If we had two functions like:
> 
>   void bitmap_index_seek_to(struct bitmap_index *bitmap_git, size_t pos)
>   {
> 	bitmap_git->map_pos = pos;
> 	if (bitmap_git->map_pos >= bitmap_git->map_size)
> 	   ...etc...
>   }
> 
>   void bitmap_index_incr(struct bitmap_index *bitmap_git, size_t offset)
>   {
> 	bitmap_index_seek_to(bitmap_git, st_add(bitmap_git->map_pos, offset));
>   }
> 
> then the compiler can see all cases directly. I dunno how much it
> matters.

Whenever the compiler can help us, I'm usually in favor.

In this case, I'd call them bitmap_index_seek() and bitmap_index_increment(),
which should be clear enough.

The other alternative would be to use an enum instead of an arbitrary int.
The compiler can warn to some extent, but it's not as helpful as a method
name distinction.

>> +	if (bitmap_git->map_pos >= bitmap_git->map_size)
>> +		BUG("bitmap position exceeds size (%"PRIuMAX" >= %"PRIuMAX")",
>> +		    (uintmax_t)bitmap_git->map_pos,
>> +		    (uintmax_t)bitmap_git->map_size);
> 
> This uses ">=", which is good, because it is valid to walk the pointer
> to one past the end of the map, which is effectively EOF. But as above,
> in that condition the callers should be checking for this EOF state
> before reading the bytes.

In other words, it would be too easy for a strange data shape to trigger
this BUG() statement, which should be reserved for the most-extreme cases
of developer mistake. Things like "this is an unacceptable 'whence' value"
or "this should never be NULL" make sense, but this is too likely to be
hit due to a runtime error.

Would it make sense to return an 'int' instead of the size_t of map_pos?
That way we could return in error if this is exceeded, and then all
callers can respond "oh wait, that move would exceed the file size, so
I should fail in my own way..."?

Thanks,
-Stolee
