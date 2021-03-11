Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090DC433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2AF64FB2
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhCKOSe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhCKOSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:18:01 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3881C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:18:01 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id n6-20020a4ac7060000b02901b50acc169fso705277ooq.12
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0U5KVvVum8HbMncJO+DUipd4gvWI/1qJ4eQkz2fb6o=;
        b=svZ4uHmMALdGHqlQZHgJyYNe6TpsJ7gkuiHLdoAEYRK4lC5y3s4aPUsaENf87wMQw0
         axsRD7SRk34ybdlLAF7JOFNycecVdmSaRaJ8zoasSqS0WTt2wdW8p3c52ndsI/YVES2C
         InE7tFqBXsmcdYJwMScmRvk/9tuK523N6XI05tlDcUeY1j5xy0Zw0Y0y358gyovUY8+l
         /bFoaRwx4h3PsJDVeM8r2uZ3FyXrkRrAJGLFF3jaAYuN62aIR7uVvzmyos9yPTRsxsif
         Sul7+PBBiyDxBTRvcHU2cBrJe88mvFHqk1GZB2qwXTOKBKvDGZWfjnNzv4IU3/03O1qv
         kIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0U5KVvVum8HbMncJO+DUipd4gvWI/1qJ4eQkz2fb6o=;
        b=Q0O6xBnjbOkT8EqfBW2aMT86BSR/4bGUrUa9vW3jZTAjFoY48q5nN0PjU38osqxpuB
         qVXEfCILBUQmAAlC817l+al2yph79kgVLfk2Grn3Ji4DIYxD4/gb28QdNKffYvxFV1Yq
         d4kj7hASnA+RHgRX7l3FhiaaDy/UtbXzcuaEu59KZRq7PRnaDCKyaQhoNDV4Yg2Imgii
         AjHBmOjC0qd1H1aOPfjdmHn/A6LcuFL0vK1lmmajS4YqJSCMsKeVdYnsSZt3WxYSnSXC
         WsXZ4vf2Z2JC42CsNR9Hix3odBiHHBZ28B/D1+sF0t5JbtZ+R+Kr+B/3hpEgJZNgyqwQ
         aCNg==
X-Gm-Message-State: AOAM532rfJwA2cTRnMalNm4+oXQb53QYhPHcvvlbD6bvmWqfsqL6tnLV
        9erOlDSA/34jOUifCKx+jQI=
X-Google-Smtp-Source: ABdhPJw+1ZbvaUYNGOhQdjuL6QfZpokpuU+OQvpqnhvEoVcIUsHaJojMRYWaOWRRixawO874hpeSVQ==
X-Received: by 2002:a4a:e058:: with SMTP id v24mr6821715oos.83.1615472280818;
        Thu, 11 Mar 2021 06:18:00 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id q22sm646501otl.56.2021.03.11.06.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:18:00 -0800 (PST)
Subject: Re: [PATCH v2 06/20] t1092: compare sparse-checkout to sparse-index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <eac2db5efc2297cffa9aba227e964bcc952d04ff.1615404665.git.gitgitgadget@gmail.com>
 <CABPp-BG6eSpjHVU5XShi17MOuPku=U388rL1=JXXF88M4ymFHA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1efcb012-53d7-9939-7fa3-ab45cdc1a6fa@gmail.com>
Date:   Thu, 11 Mar 2021 09:17:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG6eSpjHVU5XShi17MOuPku=U388rL1=JXXF88M4ymFHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2021 6:04 PM, Elijah Newren wrote:
> On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Add GIT_TEST_SPARSE_INDEX environment variable to enable the
>> sparse-index by default. This will be intended to use across the entire
>> test suite, except that it will only affect cases where the
>> sparse-checkout feature is enabled.
> 
> This last sentence was a bit awkward to read.  "will be intended to
> use" -> "is intended to be used"?

Fixed locally to:

    Add the GIT_TEST_SPARSE_INDEX environment variable to enable the
    sparse-index by default. This can be enabled across all tests, but that
    will only affect cases where the sparse-checkout feature is enabled.
 
>> +test_sparse_match () {
>> +       run_on_sparse $* &&
> 
> Should this be
>    run_on_sparse "$@"
> in order to allow arguments with spaces?

Sorry I missed this one. It was fixed to the right use in
"sparse-index: convert from full to sparse" so I thought I
had already covered this one when looking at the tip of my
branch.
 
Thanks,
-Stolee
