Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A846BC433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 934CB610FF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 21:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhIHV64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 17:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhIHV64 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 17:58:56 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A53DC061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 14:57:48 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so4909935otg.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V3F7/dHxSQLdzhL+SKBVYF8VCevl3N6ile/oQleLLpw=;
        b=QNCaPWE83Zi4tp786NSxi6Yi/CpZGStL9sOdqvpT74wYW8exNa1VbPM0OArl/VJ9oC
         ToiVmQB1PvI9OfTcWGJvdDWttYGqshSBzwfqtAd7s6S5NJOQdgdDJZhWly0qzjdK0Hw4
         OWekcC0RHfN0mBI8yHqgwgVpdjjjjH8RhIEBtShJl1qTOsVa57BtkaiY+4suto0JpHiF
         ZwHphCZKFrX550XmPvqgu0hb0N9ijuDEbU8t2/TiLcL6m0yvTvPm61roJpKvGiuIOqwK
         NcPKNk5DKlqRPXQu0VJrSlNbCiLUN9ux9ma+WCV6my0xXFMVdSAxMGkD1d/kIRFME/a4
         u7UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3F7/dHxSQLdzhL+SKBVYF8VCevl3N6ile/oQleLLpw=;
        b=LgG5lLNJUGhXGSRR79Dx7QkHCC2JqI+oK40Slz+XGrB0vNRCCeXzoZX34jQor/p7o4
         CdvyaULurasy26quXxyG2r9LDJtrPcRBEjZ0XIPuxHncVzMfAlfbZIwY/D7wMeYUVvh9
         99qicBLkDFgFHQHuKviItWuwQiSXFrpoVcAf6hkDs+uLgemNLZAg3NTZQUW2aWbtCWSY
         nFg8EzjMbWOww9nvss1cwp8jHzFxYD3CbwlvDbzdsWMVPGqcgn9ySYiKQzj3V8kOP+mS
         1cwJB+jEU3vzQil0MrYL+mZEzxBu3DpNn1yEvFi2b/KEW13fBt27qxXSsRhgi0a56Njl
         vPoQ==
X-Gm-Message-State: AOAM533sDBNQ4Pvw2JGZpBcCYOH3mQlrTb6GSyDp8puDJLfZh/iZTb3R
        JrdEHM2D8ozxpU2G8C0MaIRCmOaCZrK1Bg==
X-Google-Smtp-Source: ABdhPJx7MPsZ+V0/WhRlOKnEQ4j1CP3TD1ZaN14SJAIukLslSUd5fEd10dsRRTDDF5ikvasyjxrRbg==
X-Received: by 2002:a05:6830:2108:: with SMTP id i8mr273538otc.336.1631138267287;
        Wed, 08 Sep 2021 14:57:47 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79fe:8f64:ef46:a881? ([2600:1700:e72:80a0:79fe:8f64:ef46:a881])
        by smtp.gmail.com with ESMTPSA id z7sm78764oti.65.2021.09.08.14.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 14:57:46 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2021, #02; Wed, 8)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
References: <xmqqsfyf5b74.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d6721839-114a-3309-25aa-1926fa198bf7@gmail.com>
Date:   Wed, 8 Sep 2021 17:57:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/8/2021 11:38 AM, Junio C Hamano wrote:> * ds/sparse-index-ignored-files (2021-09-07) 10 commits
>  - sparse-checkout: clear tracked sparse dirs
>  - sparse-index: add SPARSE_INDEX_MEMORY_ONLY flag
>  - attr: be careful about sparse directories
>  - sparse-checkout: create helper methods
>  - sparse-index: use WRITE_TREE_MISSING_OK
>  - sparse-index: silently return when cache tree fails
>  - unpack-trees: fix nested sparse-dir search
>  - sparse-index: silently return when not using cone-mode patterns
>  - t7519: rewrite sparse index test
>  - Merge branch 'ds/add-with-sparse-index' into ds/sparse-index-ignored-files
>  (this branch is used by sg/test-split-index-fix.)
> 
>  In cone mode, the sparse-index codepath learned to remove ignored
>  files (like build artifacts) outside the sparse cone, allowing the
>  entire directory outside the sparse cone to be removed, which is
>  especially useful when the sparse patterns change.
> 
>  Will merge to 'next'?

I think this one is ready to go. Elijah chimed in on the latest
version, too.

This also means that perhaps we could start tracking the sparse
index integrations with merge, rebase, cherry-pick, and revert [1]?
This series has also had quite a bit of review, but the latest
version has not had an ack. 

[1] https://lore.kernel.org/git/pull.1019.v3.git.1631100241.gitgitgadget@gmail.com

I also plan to send a new version of the --sparse RFC [2], which
is based on [1]. I don't want to get too far ahead of what the
community has capacity to review.

[2] https://lore.kernel.org/git/pull.1018.git.1629842085.gitgitgadget@gmail.com/

Thanks,
-Stolee
