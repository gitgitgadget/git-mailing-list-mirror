Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF3EC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 22:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197096108F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 22:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhJDWbp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 18:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234175AbhJDWbo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 18:31:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83443C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 15:29:55 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so5845003ooh.7
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YHd7NnN8Gb7KEXCgNX/VgwZd5nued2xBQcOdFDHk4Fk=;
        b=j/e14wfihgL0cutdFzMM3xlvIqXWi/fFJXze/abLR2cEGsrF0greoBrmiUhKhpJxzi
         5pekVZW9+Mm1N6wI6qACgvnrzZFzwlKsj9fgF1kjsL3kqA/CV4L4hzMNvZoeBpgSsvYE
         IO1pUUlOg/Oghb/BXUQ/K5lfeFicXXnirm5j3YwRdFDxiaLQ0PHi1yZfwb2v3lgZikZH
         UoUz3vLoZx+4kCY61JdIZ3KZDdXfCr4FarhJvf/3dNi/Aj6GngvISBuKn3SK5rFy7XQs
         N+gD2o7XrBYbjT55IFNCoYtq5tvXI2Ra2a573+ldLeTRm72A2IyUX5r3mFJ2JAdXcR1u
         Ao7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YHd7NnN8Gb7KEXCgNX/VgwZd5nued2xBQcOdFDHk4Fk=;
        b=Xz8aJ+OYphMlS2/H2tq0W51lWN0AGRCWO1OkZEUaYTxqIMjkuBUU/SU8ocKv+MsGEY
         IGA8GBcSUYn5E5QH0GAWLq+RXZvchDVa0J91f6z8A6jgxoIx/oMh5mAORyI77AXMzqSf
         xobAG0btjxSihIXp5KNnC/iNMjBgBUzLgkuy8GQeA3n5lPz7x+cwc9NwTfLNIiD1AZzc
         gx5VKJwTngREWyhYNHqp3t57rVAnf0avNYiVRVG8+6JBE1ERwJelakB0pV24TAE2pY+R
         3XoxAg59cUasYb7aX5+ylP/BKJlpcYcl1ail4hSrWB5rs8ggk1xqAwvcR7uqzzfU6nWt
         qoCg==
X-Gm-Message-State: AOAM531U6Jd2XdxcHg/RPkj4Sg9aX6/vv+kcAvsycEmbxfWSDxknam83
        rc7jqW3uqFA8SLjKASrQ8PY=
X-Google-Smtp-Source: ABdhPJyirb7KsVpM8zhUKk04uar0iK9gQ4eoOW0dAdPHo/BVOO7tx+D8ZX8DrfWGDn3y0riM/TWQhw==
X-Received: by 2002:a4a:3ecd:: with SMTP id t196mr10859795oot.69.1633386594743;
        Mon, 04 Oct 2021 15:29:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:edd8:e35:f4b:1ff3? ([2600:1700:e72:80a0:edd8:e35:f4b:1ff3])
        by smtp.gmail.com with ESMTPSA id j23sm2972094oih.30.2021.10.04.15.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 15:29:54 -0700 (PDT)
Message-ID: <a075091c-d0d4-db5d-fa21-c9d6c90c343e@gmail.com>
Date:   Mon, 4 Oct 2021 18:29:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
 <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de> <xmqqk0iydns7.fsf@gitster.g>
 <1d26a9f3-dcb5-408a-581e-40411e6a2179@web.de>
 <6df361a5-8e15-63a7-dbb8-77405c6edf0e@gmail.com> <xmqqzgrov7g2.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqzgrov7g2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/4/2021 4:52 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> And yes, I believe that make_cache_entry() and add_index_entry_with_check()
>> are the only places that need this internal version. If we find others,
>> then we can add them as necessary. The tests in t1092 are getting rather
>> robust, although they don't do much for this test case:
>>> +test_expect_success 'stash -u ignores sub-repository' '
>>> +	test_when_finished "rm -rf sub-repo" &&
>>> +	git init sub-repo &&
>>> +	git stash -u
>>> +'
>>
>> Seems like a good test to have, anyway.
>>
>> I look forward to seeing this as a full patch.
> 
> Just one thing I want to pick your brains for ;-)
> 
> I said this earlier ...
> 
>>>> "git update-index" should never allow to create a "tree" kind of
>>>> cache entry (making it sparse again should be the task of systems
>>>> internal, and should not be done by end-user feeding a pre-shrunk
>>>> "tree" kind of entry to record a sparsely populated state, if I
>>>> understand correctly), so its call to verify_path(), if it ends with
>>>> a directory separator, should say "that's not a good path".
> 
> ... without knowing what you had in mind when you did the "tree kind
> of entry in the index".  Are we on the same page, or do we think it
> might be beneficial to give end-users a long-enough rope
> to hang themselves, aka get into the lower details of
> implementation?
> 
> One _could_ imagine that allowing
> 
>  $ git update-index --cacheinfo 40000,609869396314577e5a,t/
> 
> given by the end user to drop all entries under t/* and replace them
> with a single sparse-dir-entry might be a good way to allow
> scripters the same power as the C-code to take advantage of the
> sparse checkout feature.  It needs to be paired with some mechanism
> to allow sparse-dir-entry observed by the end users with a plumbing,
> e.g. even though ls-files unconditionally calls ensure_full_index(),

I think this is an interesting capability, but I'm not sure I see
a use case that is worth the footgun, especially with the accidents
that can happen when working with submodules.

I think we can happily extend to include this functionality in the
future. Having an error condition now that we relax in the future is
the good kind of behavior change.

>  $ git ls-files --show-sparse
> 
> may show the sparse-dir-entry by bypassing the call.

I have something in the works for this, but I'm letting others send
their sparse-index work first. I have not forgotten your request for
such a feature!

Thanks,
-Stolee
