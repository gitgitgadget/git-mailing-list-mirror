Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA195C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 15:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2B960FD7
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243113AbhJHPto (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhJHPtm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 11:49:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B19C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 08:47:47 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id m26so9930391qtn.1
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RNf+1XlbYkfq2VTvg1gdEJ+54adzIy42/2w8t81C4VY=;
        b=NJe03Y6KgQrxACdotFzV49wKK292xkwZeM8Tw2gerhOKQK3Fy/Iy15f1TcmIFqnhyW
         Sqm9B9WVVeNTvOWnPr/rIEDFKi55YxpT1heQaH0XBvGiiIfp8O+vWQILr+GRnJQ1WcWI
         fcY3JRUtWKsGdyXN1W1+jbOJwLGXvpWcoacOc8eOtMbObfTg/MrIdjGP0kJFET/bAv8i
         ZrTWrRMTnE5kW2oeTs1XvC2dZ9WJ1iYZ+CoiSOIs6Zh5PrzYFxQA0plmgQOdlbiGEc+V
         7mPVQtpGwGt38FjaDoHy0poyYVqRh0TmHIhayeYnRqZx00tpWNExKFdIoW6WpevF6S4H
         gVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RNf+1XlbYkfq2VTvg1gdEJ+54adzIy42/2w8t81C4VY=;
        b=fXQrjHXRyrOEVxRsQJ8zd5qKyzVo7RhnuONkuv/Qb7ys3cIVDOFcq0Wc43UwKveSzA
         QjhuVJoSGZ3dZkTaMfr1tBzIRTVXUN2wq2+cBGcVfq0TULHJ1eunMOOdRoDRiD0yh7i0
         3gmzzGKtxRCu1y2CisfSUm1dWvCyi0lfehvLfvBO4ycH5gTBrqbMGF8O2cPxA3fwlDAz
         BE1b0THZe+FlnV8hG9eU9LmJFcv9dBm48QNJBFlz+7FH5UUJwLU5PbWj85tC3OOJTnd1
         Kz1ENUPoBX6AY69i1vZ6AkLXWGcXSY7wC4LxaBfNiU+0WyyWBIxInVWetGhYA2k3zt8q
         /XHg==
X-Gm-Message-State: AOAM530rYsm2LumBbCMCIs18EirKUstMFaJuRxIpMmQgLbSMq+qTd8hq
        PAO/EtHVr1PQbngXulRZRlW2
X-Google-Smtp-Source: ABdhPJzZWQUVkzd5pTpvDv63g2HQrbsuGkvkt9bzBnvr8QDakydgjkS2/rWPo7oEqLvacNVWU+KF9Q==
X-Received: by 2002:a05:622a:1712:: with SMTP id h18mr12548929qtk.389.1633708066467;
        Fri, 08 Oct 2021 08:47:46 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id o5sm2268538qkl.50.2021.10.08.08.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 08:47:46 -0700 (PDT)
Message-ID: <72f4df1e-54ef-6bdb-ef71-1f115e92c9a5@github.com>
Date:   Fri, 8 Oct 2021 11:47:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v3 3/8] update-index: add --force-full-index option for
 expand/collapse test
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
 <014a408ea5d9894197c60f8d712749ea3cc39c9d.1633641339.git.gitgitgadget@gmail.com>
 <xmqq35pcm6m9.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqq35pcm6m9.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	/*
>> +	 * If --force-full-index is set, the command should skip manually
>> +	 * setting `command_requires_full_index`.
>> +	 */
> 
> Hmph, doesn't that feel unnaturally backwards, though?
> 
> The settings.command_requires_full_index bit forces read-cache to
> call ensure_full_index() immediately after the in-core index is read
> from the disk.  If we are forcing operating on the full index, I'd
> imagine that we'd be making sure that ensure_full_index() to be
> called.
> 

I tried coming up with a user-facing name that wasn't too focused on the
internal implementation, but it ends up being misleading. The intention was
to have this be a variation of `git update-index` that uses the default
setting for `command_requires_full_index` but then proceeds to read and
write the index as `update-index` normally would. Something like
`--use-default-index-sparsity` might have been more accurate?

> I do not see anything in the code that ensures active_cache_changed
> to be flipped on.  So the new test that says
> 
>     git -C sparse-index -c core.fsmonitor="" update-index --force-full-index
> 
> may not call ensure_full_index(), but because nothing marks
> the_index as changed, I think we won't call write_locked_index() at
> the end of cmd_update_index().  IOW, what we have in the test patch
> may be an expensive noop, no?
> 

In the test's use-case, `active_cache_changed` ends up set to
`CACHE_TREE_CHANGED`, which forces writing the index. It is still
effectively a no-op, but it serves the needs of the test.

In any case, Elijah suggested using a `test-tool` subcommand for this
purpose [1], which I think is more appropriate overall. Something like
`test-tool read-write-cache` can be implemented to make no mention of
`command_requires_full_index` (therefore using its default value) and force
a basic read & write of the index. It also eliminates the issue of having a
user-facing name at all, and can easily be removed once all sparse index
integrations are done.

[1] https://lore.kernel.org/git/CABPp-BF+bEUcyE0N79uRCkpCayJx_NMqOpnMSHHrpJM5a9hAWw@mail.gmail.com/
