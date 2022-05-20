Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB64C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 18:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352391AbiETSBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 14:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348038AbiETSBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 14:01:33 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738EB9D04E
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:01:30 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id i74so2798980ioa.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0Sizldm/PMeTzKg2dB2zUonn+YtNRyV+4saK3Iu32hg=;
        b=YfOd/XpvP2fFH2CY7EKrnMfHrOlXWTuJwHZhXD8Bkg+wlMmdgkTFi2y2pFk7voAUym
         QY1FsGaybbEaETqH+F3EYXmPVokQ1pWTGy2HF71ni1ARZycDrlGwi3yV+7r4Y3GAotZI
         eRNj07oUq4HzvWkkR27u75HbeQ+w7qGtC9YqZZVH6kQhC0SHUskEIXirPrgVJiLorVnf
         h0HSSBriH21og7rj55fdGg/GhqvGpsYoW/+co6oXBRJwzh9YFm8b+HT+xxnu45xm0cqs
         wREJYPVAgNFfepy2IsyYRJOCj7pO7UsaicZn+JzrJjQghpAi4dXWVS3m3AlJOC1Dsm19
         rRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0Sizldm/PMeTzKg2dB2zUonn+YtNRyV+4saK3Iu32hg=;
        b=uTW7ty1Zm2T2bdGMnw0BvAchpv+7XRRhme+tny6e3ez8Zvv55w8bUwM3vCnWIZlO+c
         cXIn32bbqkYpMWXWk+W0f1OWCXvF66cY03FqI3aes9RoR8Kqs0vTALHMZOuaS55EoRX2
         9OPx1PIvtX/C/luCjMrzuR/yyg2GoEGZSHmPhNWXaacVwIi/MNypnPmo2W7c6nWkZ8gH
         EL5cObYWI/09e41FihQNY1eMSAMo9WtIp5BwEkZuK4TOWLjLQNZXKGy10Z7UxPqamhDG
         QqqSQbSVTiez3FfF+bjFnzhA/SA7kxra8Cy0oQJrFn9+d/bPWLSefIR2CGjuG8e3yPec
         Q5tw==
X-Gm-Message-State: AOAM531F7qtTRj1gmbctaH3JIoJtzlrOt8S7u7AU1NIOw0bKUyQhfyuc
        rIYsk/Rp773ULwdF9iPL0RLo
X-Google-Smtp-Source: ABdhPJysSgAJKbigcyGZHOn3My29HoJgLSLDrRdr3LYIUd3INlU7TfMHS5/NmHIXEGDHwTdaaEM1xw==
X-Received: by 2002:a05:6638:15c9:b0:32d:b26d:a01e with SMTP id i9-20020a05663815c900b0032db26da01emr6253508jat.11.1653069689776;
        Fri, 20 May 2022 11:01:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34b9:84ab:204:3752? ([2600:1700:e72:80a0:34b9:84ab:204:3752])
        by smtp.gmail.com with ESMTPSA id l9-20020a026a09000000b0032ba5cbae2esm832612jac.144.2022.05.20.11.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 11:01:29 -0700 (PDT)
Message-ID: <3d4cb244-2e55-0337-90f8-a380ed836465@github.com>
Date:   Fri, 20 May 2022 14:01:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 03/10] sparse-index: create expand_to_pattern_list()
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <d15338573e570aebe239dacdd8c2aba275ff61b9.1652982758.git.gitgitgadget@gmail.com>
 <xmqqsfp5mhcw.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfp5mhcw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/19/2022 3:50 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> list is NULL as that does the same as ensure_full_index(). In fact,
>> ensure_full_index() is converted to a shim over
>> expand_to_pattern_list().
> 
> Sounds like a natural evolution of the API that used to be
> all-or-none to expand-only-those-that-match.
> 
> The old one had a sensible name to tell us that it is about the
> in-core index (and "full index" implied it was about sparse-index
> feature because what state other than "full" the index can be---some
> are shrunk into tree entries, which by definition is the
> sparse-index feature).  Contrasted to that, the name of the new one
> is horrible.  It does not even have index anywhere in the name.
> 
> I wonder expand_index() would work?

Makes sense. Good suggestion.
 
>> -	trace2_region_enter("index", "ensure_full_index", istate->repo);
>> +	/*
>> +	 * A NULL pattern set indicates we are expanding a full index, so
>> +	 * we use a special region name that indicates the full expansion.
>> +	 * This is used by test cases, but also helps to differentiate the
>> +	 * two cases.
>> +	 */
> 
> Except that we lost the distinction for non-cone mode, which I am
> not sure matters, but I suspect we do not have to, if we do not want
> to.  Nobody used "pl" up to this point, so resetting it to NULL can
> be done much later.  In later phases of this series, we add another
> case where we can lose pl even if we are not using cone mode, so
> this distinction may start to matter later.  I dunno.
> 
> I'd invent a separate "const char *tr2_region_label" variable and
> set it at the beginning, regardless of where we clobber pl and why,
> and use that label variable for trace2 calls, if I were doing this
> patch.  That feels much simpler and cleaner.

Good idea.

Thanks,
-Stolee
