Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E2BC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE12F22D01
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbhAGCJj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbhAGCJj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 21:09:39 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF2FC0612EF
        for <git@vger.kernel.org>; Wed,  6 Jan 2021 18:08:58 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x13so4930162oto.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 18:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KLCzbqR6wOn+RbD4NOqqyF8I9KX36PCeCdvhnVOat/k=;
        b=JFBY9dbXIp2hKE9ofhrx/tKCJhL4Rmd9JVS6Q3JIfc1SL3I3jUxIxKxoeB4HRwVzzc
         sID7TaVN9FgwVCB659H1KGYFF69tymIkJYGZm/EmChxGMlCSegeA9E5kOTMZbLtL4v0O
         vb1k/MWNlJTpBeDgB726B5ThwfwWlyN+Yfchd/7kfaOQ2aHpzjxjv72cMRBJfBB14xbM
         TUVqlEfIFsFJswyXBkGzyUYlk1TOLwn8Np/O59ubMoDfzL3rZk8McDG0aIq0/6l2dIhU
         iudNYrevol+VDDyjIZv5L4M7NdibyShaGsDR0H8hQEZpkdHX6uCEaFjYtEefcAoyaJrA
         RelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KLCzbqR6wOn+RbD4NOqqyF8I9KX36PCeCdvhnVOat/k=;
        b=kETCU/Dz5j5/iupia8CCBjA7x/a/B4RJ0DwT9uwWmN6E8EaOx0GkT4K7oKFGeyK6M0
         pJvDgmsMHMq/kL/qYnxuNkkHcnRY6AYiWsZu6BeHrdto/zanZIwbY8U6D0jld9R7oP9d
         Yar1nLS+jlALzBIuhk8TrG0fKnQIWKCTR51RPXqjEbziU4adPIcejINrQl7ElRVnWnFY
         jf6C+oUEAENeeDV63UCSFFMjd6xDcwQat7BsqXIOHeHuIpbATVHj6hpwIWhNIwVzXNUp
         Lrk4Bmt4796/WSuXhcPTULGehW1shCggepKLNANEgfBz5mQHBOhktBcLvNlu2wvYmhLU
         zjyw==
X-Gm-Message-State: AOAM530jACBmHqcWpUAhNUVQ0KDTVg/bq0EUvQJQPlHy5qket0Ki4x3Q
        GD8tjkTWHdR1lmxyAWMe68A=
X-Google-Smtp-Source: ABdhPJxfHQ2BC5Ip1VBuq+BbAWNXtv5LIQ3IEaF3vebvNVMJss2q//DLZK0+I271PLtLB4YHd9rnPw==
X-Received: by 2002:a9d:57c8:: with SMTP id q8mr5186001oti.168.1609985338028;
        Wed, 06 Jan 2021 18:08:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t2sm887364otj.47.2021.01.06.18.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 18:08:57 -0800 (PST)
Subject: Re: [PATCH 0/5] avoid peeking into `struct lock_file`
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
 <a401a6a7-fc15-9f26-2345-651964cf7b5d@gmail.com>
 <xmqq5z4as2j9.fsf@gitster.c.googlers.com>
 <xmqqim89pu9k.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8ae92e79-ef13-3faf-2fc2-d4b107e73c36@gmail.com>
Date:   Wed, 6 Jan 2021 21:08:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqqim89pu9k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 5:36 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> On 1/5/2021 2:23 PM, Martin Ågren wrote:
>>>> I made a comment in [1] about how we could avoid peeking into a `struct
>>>> lock_file` and instead use a helper function that we happen to have at
>>>> our disposal. I then grepped around a bit and found that we're pretty
>>>> good at avoiding such peeking at the moment, but that we could do
>>>> a bit better.
>>>>
>>>> Here's a series to avoid such `lk.tempfile.foo` in favor of
>>>> `get_lock_file_foo(&lk)`.
>>>>
>>>> [1] https://lore.kernel.org/git/CAN0heSrOKr--GenbowHP+iwkijbg5pCeJLq+wz6NXCXTsfcvGg@mail.gmail.com/
>>>
>>> Thanks for being diligent and keeping the code clean.
>>>
>>> This series is good-to-go.
>>>
>>> Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
>>
>> Thanks, both.
> 
> I liked what I saw.  The code after these patches got certainly
> clearer.
> 
> But it was not quite clear what I was *NOT* seeing in these patches.
> 
> IOW, how extensive is the coverage of these patches?  If we renamed
> the .tempfile field to, say, .tmpfile in "struct lock_file" in
> "lockfile.h", for example, would "lockfile.[ch]" be the *only* files
> that need to be adjusted to make the code compile again?  The same
> question for various fields in "struct tempfile".
 
There was a note in patch 5 about how do_write_index() takes a
tempfile instead of a lockfile, because sometimes the index is
written without a lock.

I can't say that this is otherwise comprehensive. Definitely a
step in the right direction.

I think the only way to enforce this is to make 'struct lock_file'
anonymous in lockfile.h and actually defined in lockfile.c, assuming
that's possible. It seems like external callers would only be able
to declare a pointer to one, but without access to sizeof(struct
lock_file) these callers would be severely limited.

Thanks,
-Stolee
