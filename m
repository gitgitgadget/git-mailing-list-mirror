Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52C9C43217
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 12:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiDRMkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiDRMiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 08:38:10 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD07240BF
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:28:44 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id a5so10798627qvx.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=N9L/hrweZkiPAHi8Y0DUO1QPVm7JW/s2iW2qlHR0Mls=;
        b=Esoh04nPxZC+e8eyMfh2zrPx5uFimm0WLDmFyonj2N/GrSvc02fnIV2fIElw0qh8yN
         jsgiD66LdpHUio7rsOSOUJbDsJiz+W5rbQMBpEGaMCCr3YwO/pi9KvTMYeCGQQzO+CKv
         viP6ZEEbiZdd5vX70qAk5+My5KvLcR7inNgwLs2J6or6Sr7gznjnDHHkonOG0PyWXZD3
         vohaEZBEydlsglHBRXK+qr5HPoX0wzr8d6XDyjMhqY+msviy5oquu1z58LSp+UlRs2Jm
         P9NkfT4qlMGEfg/e91Z3YCjnHHhsqKjVz0ppuwyJ9ROSh52wOGCsbox3vPMWRU9lMms2
         bYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N9L/hrweZkiPAHi8Y0DUO1QPVm7JW/s2iW2qlHR0Mls=;
        b=qzdZET4qYIFpKaYBqz8hvDwQenSYntQhLbhSMaGxfkLKslvrq52LFbik/QZEtgDoZb
         TSSt7dOC4vD0ODcfcG3QpikoYLD/T6XZYGnfGei/iDtPvyj6tYf+Lb5KvgEj6HnvZbGB
         in2bTMGcK8e3F83/5IZgqka9MTAMH/z6RpEWS4adnqb4je6Q2DZSa/HcrFNWwNtprF9k
         Xrwh6wTreRp9sBWRXdy7UyYTTpC6fZa47+exkwz6O449RjpIDGCkiR0WjHNS2H2vjjoI
         ytr5NuHWyc4JUdzQM2/nK16CKFKvv04PNhXeTP6RgDJFdOqx+C077FL11jvNYgENJsUD
         aylg==
X-Gm-Message-State: AOAM531p/8rLwt47iOOva5duk5u8E/XewXppqvBo2IeAUXvP4sO3Y5Ci
        esZP8KWJOgc4tbEjqU3HsLLe
X-Google-Smtp-Source: ABdhPJx/PqIXuG3Xm0mRsR3r8zLJVLpcrS2RrKhCiORlcj9heiVaLMCgRRzK0bZR7nyxfw18Rm4vuQ==
X-Received: by 2002:a0c:f005:0:b0:446:19e8:b290 with SMTP id z5-20020a0cf005000000b0044619e8b290mr8342826qvk.66.1650284923446;
        Mon, 18 Apr 2022 05:28:43 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v65-20020a376144000000b0069e7842f2f5sm3274883qkb.52.2022.04.18.05.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 05:28:43 -0700 (PDT)
Message-ID: <4c999e1f-e6bb-72e0-a27d-e072ce9487f8@github.com>
Date:   Mon, 18 Apr 2022 08:28:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/4] show: integrate with the sparse index
Content-Language: en-US
To:     Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        shaoxuan.yuan02@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
 <27ab853a9b4f0a50880c92dd8949d6fe9b7f00ba.1649349442.git.gitgitgadget@gmail.com>
 <Ylhs3t9nFS/IeO2Y@google.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Ylhs3t9nFS/IeO2Y@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/14/2022 2:50 PM, Josh Steadmon wrote:
> On 2022.04.07 16:37, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>

>>  	# Asking "git show" for directories in the index
>> -	# does not work as implemented. The error message is
>> -	# different for a full checkout and a sparse checkout
>> -	# when the directory is outside of the cone.
>> +	# changes depending on the existence of a sparse index.
> 
> The wording here seems awkward after these changes are applied. Without
> other context, it makes it sound to me like the command(s) used to show
> a directory change depending on the existence of a sparse index, rather
> than the fact that the behavior of `git show` changes.

I can see that.

>> +	# The output of "git show" includes the way we referenced the
>> +	# objects, so strip that out.
>> +	test_line_count = 4 actual &&
>> +	tail -n 2 actual >actual-trunc &&
>> +	tail -n 2 expect >expect-trunc &&
>> +	test_cmp expect-trunc actual-trunc
>>  '
> 
> It's not specific to this commit, but in general I think the series of
> changes to this test would be easier to follow if we used hard-coded
> strings to compare against, rather than matching parts of files against
> each other. It makes it more clear to the reader exactly which behavior
> is changing, and can make it more obvious why certain output is
> undesirable. However, it would make the test more brittle to future
> changes.

The tests here are designed with this approach in mind: demonstrate
success by comparing to existing behavior. We don't want to be
coupled to the exact behavior of these commands, but we _do_ want to
demonstrate that the sparse-checkout or sparse-index features do not
change from the full-checkout behavior (unless we are demonstrating an
expected difference).

In particular, using comparisons like this are also robust against
changes in the test repository data shape, which has been necessary to
update as bugs are found.

Thanks,
-Stolee
