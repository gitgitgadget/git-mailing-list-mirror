Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90606C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EE564EE2
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZQfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZQfU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 11:35:20 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD03C06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:34:37 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id o34so7009571qtd.11
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 08:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cLB05lPMpLhvo/H2AkEjp21vd1JNsPGx5+mlWYZgBrI=;
        b=sqbtc0BA25Y36UNNymUmOD4LuQr6X/AL7ZVDk1R9pobYLZmibQTDDv4M1p2hF1JDjp
         GdCy/NzDa4O0ChCnqJJQeGdQdoyMMO6yq2Yg2/8DQjzFOrrX6FwWXoaBRJNH4Qs4StiZ
         swsUPcxVIBmw3WskbbHV7z5YUcG2RISXGfD54a3ssB6yRUDgsD93W72EhQsOXh3o42Et
         QNvbi+MOuISCccExr2tBMgWIXbNwSjltKkAizCFx9z6EFkNynWZfgpgNhR6QLU0KlJD5
         09PO7piAPFyTXkOB4p2wFsCHPkt2DJcS1F+AMFuV4DX669xVTPx0uWWYOOwUX61lRWfW
         DeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cLB05lPMpLhvo/H2AkEjp21vd1JNsPGx5+mlWYZgBrI=;
        b=N5D3T0cuNKdexictECjd4Pzo1KiG+2x5taYzCh06cygNGw4qm/AnIZ8ILd8MwRMuaN
         eoyiUxr7XScQb4+hFLucRPwNg1wFidMLWLyfMmgHWuDwaxomubaw8t7XHfGrgdF1oxik
         wJ/XyIw0QpyTyJBrcYQeczaITKAGABCtQGT1H0bszAgb5X1AsD2bz1p3rJYtAjpcKDq+
         1QIXfbtAWtNCnkwsDV11lYL2catyYoZKiKwyihNLYxvcaO9HdyxCFqHgENQlmRPlGXaJ
         Er4hkb4zpV+u/ElkKXX9Y5b7NkELjlt1j9aKEve5K6uKkLInT+y9T2koKAbKxmhBSPnW
         GHVw==
X-Gm-Message-State: AOAM533n+NOMCZ9qcKeVvI6zKPxXdd7zWOKtSzkZCTqA1SY1+qkldtWz
        WA/JoqzlpipSKyDa5OlN2eU=
X-Google-Smtp-Source: ABdhPJyNNdAIz7YznAatRt+wtDkZ+urT9S1nWVDinm0sJiWXACsHUdM1002fUiooYKXAqEzhzOJRzg==
X-Received: by 2002:ac8:c46:: with SMTP id l6mr3531098qti.6.1614357276879;
        Fri, 26 Feb 2021 08:34:36 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d21:2da6:2067:31cb? ([2600:1700:e72:80a0:8d21:2da6:2067:31cb])
        by smtp.gmail.com with UTF8SMTPSA id v17sm888029qtq.41.2021.02.26.08.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 08:34:35 -0800 (PST)
Message-ID: <8efa1f5e-b072-abe3-9ad0-c1535d7a8b14@gmail.com>
Date:   Fri, 26 Feb 2021 11:34:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v3 00/10] Optimization batch 8: use file basenames even
 more
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 8:58 PM, Elijah Newren via GitGitGadget wrote:
> This series depends on en/diffcore-rename (a concatenation of what I was
> calling ort-perf-batch-6 and ort-perf-batch-7).
> 
> Changes since v2:
> 
>  * Rearrange the patches in the series to have a top-down ordering rather
>    than bottom-up -- as suggested by Stolee, Ævar, and Junio
>  * Several comments and style improvements suggested by Stolee
>  * Replace xstrfmt() with a few strbuf_add*() calls, as suggested by Stolee
 I like the new layout. The code looks good. The only nit I have is that
some of the old commit messages read awkwardly with the new ordering.
These are not critical, so this version gets my:

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

