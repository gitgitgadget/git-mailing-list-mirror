Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D177C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465B5613AB
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 13:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbhHXNuM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbhHXNuL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 09:50:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C5DC061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:49:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id y14-20020a0568302a0e00b0051acbdb2869so39389432otu.2
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4wkFy6HD8IfqoXzc3enDSz+Iu0JarDT4eBeNfB5HCfo=;
        b=MJXlNUPMjpt1W/npDBap8x+ffeHdQeiEVD94piYnpCtXC2ksUXJKQ0nyRkcGGLoVT0
         g0serqaj6a6uVOu+WGsbVjTGC4aEWuRSPThVhQfrK282Vhqc3+TUVerJb3ae4QMTYlYZ
         m3mNMnotvGSqx/vYgWp+ofb8uQdr3xthcjKgxrEFQWKkDkAQHqZMx/LaXiK3db7pDF3U
         OKNTAibibyIZvnq+uOMauIRyLMM4xZIYohlShTSSLYg0vuApYRcjFEGGXRDKIlkG6T1I
         HS7b2b4seDvHtzuSEN/iGAeSHw/kV60QADgmH9dttxJdfOy6ZjP+QAcv/rNW+gbeFPfR
         Qd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4wkFy6HD8IfqoXzc3enDSz+Iu0JarDT4eBeNfB5HCfo=;
        b=WutHYt+FfW1i9w4p5otT/xBTnnYu1BcNAHfgQTpZBAij9TIfyp24dGGepIUEKjU8ty
         bjdSzpCb++URe64/+SimnC4P03PLo1hS/Z2LP3Q8V6dFL9gFZYPZm8Ds6EGJCooO4PtU
         +mN7bkiHZ38WgERxlr5kN5IEwsGHZ+IrflXrj6w2YrGX6DoPbR88S8a2vfB8NR9t9jge
         7MjsFJJ3/mG3Ba9THG6Gvso5c0YWwcKomDfDF6PW8dlszaOgXKitRTUh2ncyoTb6uawO
         n8dcqcOU/isFpC/bEkg2vjBBcs05yYGf2nLonpXfU1J1EK19NrsQfqK/Mh/64uLpz+OA
         gkQg==
X-Gm-Message-State: AOAM532UmTmfCF5QTciJMyBWnETS1BeQaHxiM2sdmUXGfd0SG9t7eqhn
        ALAApt/TPgHRe6L1IJTLyW4=
X-Google-Smtp-Source: ABdhPJwqltbj9ruF8qFN7F7sBTYOfFJBEBtCy5Z+gsM0qzALwF5zJf2NB9id2dYVSgYiEPy52BAWhg==
X-Received: by 2002:aca:2b05:: with SMTP id i5mr2887285oik.55.1629812966613;
        Tue, 24 Aug 2021 06:49:26 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id l67sm4558258otl.3.2021.08.24.06.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 06:49:25 -0700 (PDT)
Subject: Re: [PATCH] gitk: new option to hide prefetch refs
To:     Tal Kelrich via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Tal Kelrich <hasturkun@gmail.com>
References: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0004f758-759b-f523-fa3d-dd7759d6eec7@gmail.com>
Date:   Tue, 24 Aug 2021 09:49:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1023.git.1629807526939.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/24/2021 8:18 AM, Tal Kelrich via GitGitGadget wrote:
> From: Tal Kelrich <hasturkun@gmail.com>
> 
> The maintenance 'prefetch' task creates refs that mirror remote refs,
> and in repositories with many branches this can clutter the commit list.
> 
> Add a new option to ignore any prefetch refs, enabled by default.

This seems like a sensible feature to add. Thank you for contributing!
 
>     It might have been better to allow gitk to read log.excludeDecoration
>     (or a gitk specific configured pattern) and use that to ignore refs, but
>     this was simpler for me to implement without knowing Tcl.

I agree, but I also don't know Tcl so can't comment to how hard that
might be. I'm not sure how gitk operates and why it does not automatically
benefit from log.excludeDecoration. Is it computing its own decoration? Is
it using a different Git command that isn't integrated with
log.excludeDecoration, but should be?

I also cannot review that this patch works as advertised. I just wanted to
chime in with support for the idea.

Thanks,
-Stolee
