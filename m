Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13061C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 13:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjCMNde (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCMNdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 09:33:33 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905481E9FA
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 06:33:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id nv15so8172533qvb.7
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678714410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0PRzeTit2TNqyHF44R9k0ULuNgeQo8znWxIz0FwnEn0=;
        b=dbLRWl4OGNS4xlCrtw96YhOHjmnuSJi4+f0ZmgCULa0mGbga2PPXpp59q5vDfwVk3t
         FIjNaaNwuIpYrTm5CuE/lgeqvzCwk0esLVWQVVv5G2ATGYgVu+6TDoS9EBuPB+sQtLeq
         jn798V8083dZ+56yePQAuOUvB/ZtciQerboZnc21Ta1tiUFH84M7vSwUKEigAS5euf8x
         hYCJSX6Wc9Ojrdha00F31HRW9bxtV1XNE9HbZFykZtM7+eqkL3DJn+iG3DNNewuThn/8
         WMFIzGydG2tUGoBhZwo1zT4JvDIBOT+Eohehxs0EI+keS9vii3IS1+AoLfIyyybnBiRv
         CCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0PRzeTit2TNqyHF44R9k0ULuNgeQo8znWxIz0FwnEn0=;
        b=ZOu1KcUPdG6po0aG1BjKPYwrY46ShpRTZ8F/i2sLdZnS3u/TE1aq4Sh9t0842dcFHm
         opn9bA9itDBtADlv+mNq9sk1LJyAqN38tqQgKRkjbvKVH4QeyRF7iZKuSIpGpGk51cdl
         WTeZWL/oB+Vb/wKxBtnStNBE4liyE/UMzCJEZG5nxibCcdhUEK6b5Z8y0/vvNl+tSLne
         +yapFyMCbfnKOpNPAZgs+OFLN6lTBljAdkuoczuyvKfWrBRJl0FqN43BuWVQFBgN+nob
         ukgEBk8r0r980cMp+nkxAGejLo8PP4wS/9OL16BbtPyvuhqLK24Jv6df1T521M5FdK6j
         qasA==
X-Gm-Message-State: AO0yUKXkU7CcsnwvJUX6x84MGcPxDBKw/itiJEDWZru5yxVfFxZ0lZI5
        Kfa/IKq1Qf5S/HtrmLuiggIB
X-Google-Smtp-Source: AK7set8i04qDMoKdfGUwhcr6GcKI7pdmJaid0xkleSJMooBYXaA0mnv0mDQmUGnGOsIbe3liZiRC9A==
X-Received: by 2002:a05:6214:cca:b0:56e:a35b:9aaf with SMTP id 10-20020a0562140cca00b0056ea35b9aafmr14314118qvx.20.1678714410630;
        Mon, 13 Mar 2023 06:33:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:9059:9f15:6c58:8869? ([2600:1700:e72:80a0:9059:9f15:6c58:8869])
        by smtp.gmail.com with ESMTPSA id 78-20020a370c51000000b00745a55db5a3sm667793qkm.24.2023.03.13.06.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 06:33:30 -0700 (PDT)
Message-ID: <cd61cd39-ba84-49ae-4b36-92c7be043740@github.com>
Date:   Mon, 13 Mar 2023 09:33:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
To:     phillip.wood@dunelm.org.uk,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
 <6badb697-aa74-cc2f-ba43-0bbf54b10973@dunelm.org.uk>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6badb697-aa74-cc2f-ba43-0bbf54b10973@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2023 6:31 AM, Phillip Wood wrote:
> Hi Stolee
> 
> On 10/03/2023 17:20, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> When a user wishes to input a large list of patterns to 'git
>> for-each-ref' (likely a long list of exact refs) there are frequently
>> system limits on the number of command-line arguments.
>>
>> Add a new --stdin option to instead read the patterns from standard
>> input. Add tests that check that any unrecognized arguments are
>> considered an error when --stdin is provided. Also, an empty pattern
>> list is interpreted as the complete ref set.
>>
>> When reading from stdin, we populate the filter.name_patterns array
>> dynamically as opposed to pointing to the 'argv' array directly. This
>> requires a careful cast while freeing the individual strings,
>> conditioned on the --stdin option.
> 
> I think what you've got here is fine, but if you wanted you could simplify it by using an strvec. Something like
> 
>     struct strvec vec = STRVEC_INIT;
> 
>     ...
> 
>     if (from_stdin) {
>         struct strbuf buf = STRBUF_INIT;
> 
>         if (argv[0])
>             die(_("unknown arguments supplied with --stdin"));
> 
>         while (strbuf_getline(&line, stdin) != EOF)
>             strvec_push(&vec, buf.buf);
> 
>         filter.name_patters = vec.v;
>     } else {
>         filter.name_patterns = argv;
>     }
> 
>     ...
> 
>     strvec_clear(&vec);
> 
> gets rid of the manual memory management with ALLOC_GROW() and the need to cast filter.name_patterns when free()ing. It is not immediately obvious from the name but struct strvec keeps the array NULL terminated.

Thanks, Philip. I like your version a lot and will use
it in the next version.

-Stolee
