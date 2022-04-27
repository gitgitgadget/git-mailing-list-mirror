Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECF6C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbiD0RZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiD0RZY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:25:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2F46142
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:22:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so3471629wrb.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=981qQSl7bCJ7q95jr0AdZhANKdumu4t4IUPkAgbYTr8=;
        b=m5fVnB+taTqBiwUHY78t8ngLkNIOAHJY0lYeRaZEgIaT5UhHSuSWPOi5G5IupMzN50
         7rlQ5IVQh16VLGAXNiw9iJdnOqe+ExZ2WWEJ6wrFBc3O9u6cgku1LfC9lJv+wfMgV1ZI
         p8Xk1Sc2BKYAau6TLXggEBmEYIA3Zr7beaXMsbGxW1ZwLrLXLtLn3WV1GVAstq19cCI5
         0YRUGV3H+voX9o9UhtSYTf2Rp1PYgHE200hOAYI+j007R9GBkHMiLW3xh6EIc1NtVuDr
         6JOd6t3M4sbNfhtw8bVTkaZi5pXhXatEb/fFcNI+u/UjREvKRDRZ2iVJaAarZGd2wY0/
         sRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=981qQSl7bCJ7q95jr0AdZhANKdumu4t4IUPkAgbYTr8=;
        b=XLQw/EL8loShgJp7cYn3rK7avPNNbRtDPVMyQHrMDOcItlleh4rI63N02b2rh6z5OM
         SKAG9dUDGIhA0lN6/YfwDNnfe75yw2iMYye/6EZJ1o14DiKHaNhLPz8FxjDhn1bisPzX
         N+x7hj7KS6Y+wXljZRRS885Yodc1JiUbPKoV94XS821iV7O7PyGlXZsCbfJ9vv2LYDIC
         U5rc+jVeXa5SeYxxJqF5ja25OvazqNviHfjjkAOYgpFvWGzdu9Ecm7u7uzQHlsxj6E0r
         icGOWQUyz1WmPvMJOqDhEFIHW0t69RtZSFF4WU/wxye36OmsRr0HMpZcOpypoZb+w269
         B5uA==
X-Gm-Message-State: AOAM532FstVRJOzl0D+2r7AqZ1lb/4uZ1jAtBChiB12xpKC9wkLM/MmG
        6ED5gFbagCw/o/rmr5k4H8w=
X-Google-Smtp-Source: ABdhPJzvLa+8xg9+bE+mJarh5QKJJYhVV0O2x7P1tjQdSKHiLERRvLl015G6IsICkn3zVChbJ9wYdg==
X-Received: by 2002:a5d:6d81:0:b0:20a:88cf:c004 with SMTP id l1-20020a5d6d81000000b0020a88cfc004mr23102242wrs.41.1651080124592;
        Wed, 27 Apr 2022 10:22:04 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm14350291wrf.80.2022.04.27.10.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 10:22:04 -0700 (PDT)
Message-ID: <ed2cdc8f-1908-a095-ddf1-660ef8b5a90b@gmail.com>
Date:   Wed, 27 Apr 2022 18:22:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
 <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <xmqqczh2o5xg.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqczh2o5xg.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 17:19, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
>>> The standard is silent on what happens to error when the value is out of
>>> range.
> 
> Actually the standard is is very clear what happens to endptr (no,
> don't call it "error", that is not the point of the parameter).
 >
>      A pointer to the final string shall be stored in the object
>      pointed to by endptr, provided that endptr is not a null
>      pointer.
> 
> where "final string" has a precise definition much earlier:
> 
>      First, they decompose the input string into three parts:
> 
>      1. An initial, possibly empty, sequence of white-space
>         characters (as specified by isspace())
> 
>      2. A subject sequence interpreted as an integer represented in
>         some radix determined by the value of base
> 
>      3. A final string of one or more unrecognized characters,
>         including the terminating null byte of the input string.
> 
>      Then they shall attempt to convert the subject sequence to an
>      integer, and return the result.
> 
> So, leading whitespace is stripped, then "subject sequence" that is
> the sequence of digits (with optional +/- sign) to be turned into a
> long is recognised, and what remains is the "final string".  endptr
> is made to point at that "final string", and it does not matter what
> kind of value the interpretation of "subject sequence" yields.

Oh I think I misunderstood when I read the standard this morning. Just 
to check I do understand now, in the case of overflow entptr points to 
the final string (i.e. to the character following the last digit) even 
though the "subject sequence" cannot be successfully converted?

Thanks

Phillip
