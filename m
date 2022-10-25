Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D554C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiJYKDc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiJYKDA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 06:03:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3448EDBBCB
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:55:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so7104438wrs.10
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 02:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eu3nFRBuq2qzFKGiA31mMNdH7U37WBlyoF0eKz8QDGw=;
        b=queTDyUulXQilXDogOja68brBXWnR4cZW7RtjneqcMkHNAjC+KB8619+F4ibCzOYnA
         Nfpcgozc+zkyHyhT7FTx7wl2F0NuFLZr6ND31YpkEnlXGJgCghnZRm0qVZvY/4Mj6SJz
         Er6I+1zUlj4MH7ygXff9GhmzkzdXTNnJ2rwUPWAXhXUr/r6qn2Y6oDqSiy6HIJxTPUYF
         Uzciqv7T/QFG2g0RMkTNj52EykelENmscz5cl9hjYWoAZWNmcDJM9aBfOkP+xUQ9RjRL
         IDfNFsZLJQu+EL+H7jWKk5QVxQ7Xd+j0PrOjopUb+9oVrnHJVHapNo81+n8XXnD2LSUA
         UnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu3nFRBuq2qzFKGiA31mMNdH7U37WBlyoF0eKz8QDGw=;
        b=mr8PVvaDXC2GruK+6T2ST8UPTHdW+NrADKFtV4EyydaSkkS5bsVBRYWfdZAc+7gWSB
         aYRIWl4CcCI4f57dGjRlMcIFNGqPFdI2fAFar0Mr+ZMkc8HyhmMWjtPoovNT120aYTt8
         WuMyUuFQJaeHOMd4qhmQqZONBvxyUb7QbkLMfcoSKlvxoeOa0tDD9I272R+TU0ithA0n
         TnBvRLkCR0q+8oAvjVxOrzf/Jr+y/1vdatl5dWgaFEnCjQyvZ5S2Mu0zV9LlnYDJhwWw
         5KgQN0g6YtSgY8Z1xOV0LgkVIlD7aJtYGbyKnsDiCGgqRTAJBiFXYCQj94skqEhNHTiU
         arvw==
X-Gm-Message-State: ACrzQf2GGBUcTHOkYbt/uiFt3YuTSamGXjsdDXT7/rrqeYrsb9h2ZKaQ
        km21IBA3JZWn2wsBjfXEGQI=
X-Google-Smtp-Source: AMsMyM72rTI6C36jSAu/Dh5nATnLuR4R3xDfN1lN7Tcx9YFc2jWSHPgKQjdU2WWS15oHkQanw2zWoQ==
X-Received: by 2002:a05:6000:184d:b0:22f:4ef4:47a7 with SMTP id c13-20020a056000184d00b0022f4ef447a7mr24515754wri.563.1666691740116;
        Tue, 25 Oct 2022 02:55:40 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6283000000b0023677e1157fsm2041799wru.56.2022.10.25.02.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 02:55:39 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <69b91e29-af50-81db-8173-8b42a76ae1fb@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 10:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
 <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
In-Reply-To: <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On 21/10/2022 21:17, Jeff King wrote:
> On Fri, Oct 21, 2022 at 01:45:13PM +0000, Phillip Wood via GitGitGadget wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> If the input to strtoimax() or strtoumax() does not contain any digits
>> then they return zero and set `end` to point to the start of the input
>> string.  git_parse_[un]signed() do not check `end` and so fail to return
>> an error and instead return a value of zero if the input string is a
>> valid units factor without any digits (e.g "k").
> 
> This one is easier to test than the last. Just:
> 
>    git config --int --default='m' some.key

Thanks for posting that, I'd forgotten about the --int flag for git config.

Best Wishes

Phillip

> works. And even playing devil's advocate, I can't think of a case where
> anybody would rely on the current behavior.
> 
> -Peff
