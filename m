Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B191C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3835F64EAF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 20:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBPUgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 15:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBPUgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 15:36:47 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CB9C061574
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 12:36:06 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id e4so10142952ote.5
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 12:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WdMmksA6Z0KTKpay7MwLl2cOWKdsksHBevZ24orlVro=;
        b=Bm9I74fjBDfd/+7nE7XNR5lUC6O6qGkN0Kjfg2P11vlsjsx7EJRYfz0QscMs2RaLqx
         sPLaF9RIEF18aB1ptPyLy/qn/7oCDC/sWgXq55ty6mEcVPeBsB/H3XmHYrMRg5ocXKSL
         ierdUXP6fIB0FyiKJeKgBYLML41zYdnZu3tZ1AMnfuDAzT7e0om+DLX4T4crdXl0uWPE
         INiGEcNH1IkaKLEALcc3vHgw7RzGp3VVKqLjfE1FbO1UiEbo/CJIackP8MT3ZMDZ5ko6
         hxbCbhdBwTQmS2uhcK7LAg9ghSFs9OCt9MhBs+/9fWuz6QcXFmXAwkTWDeRnEz0QuxU0
         bixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WdMmksA6Z0KTKpay7MwLl2cOWKdsksHBevZ24orlVro=;
        b=nhr5qv21YrrFTLqntPpzl49h1C0dGf/3ghpZEYQ+PBugxt7fIyZSQqUkOLb+eoFXA3
         f1HJwiuRpSHyPvZgVu6PkJo2gz/8j9lLVG+pM8nNu8dsXDf7sCdUA4HcC4w0cbPe6pPs
         sI+xK8IHEYpibiwnReOKxXBXCGaRJNpM55ytbYn5W40U+8TZFTLthvSGniYoSx4NYLbw
         lit5fe1bWFOWncRmvuirFN3VsaMl5Kg/4PwtvuFK//ogG/9sOlzqqEtYPDFCQPcY9I+M
         t/X5sEggDJnC0YUhv6FJ0RLkOn8OhvHryqjybFvhM5yHz6biVIhg8HoEsmHHIgzceVEP
         9oyQ==
X-Gm-Message-State: AOAM5331UjS4iMAp7V+gAnF+IAyPTb5RI1V8nGUvETODxR5EyAXv1mou
        x5uP6XaCvTUSQIhr5teu07I=
X-Google-Smtp-Source: ABdhPJzPGW9cEVZ6vkR5hqRh2tzfl/t6ZSM2xsyhVX8UnEkkDDpFvDiA1dfgHHNkizUGvAGmOpxxLg==
X-Received: by 2002:a9d:6650:: with SMTP id q16mr14731785otm.57.1613507766284;
        Tue, 16 Feb 2021 12:36:06 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:bccc:aed3:3481:8d68? ([2600:1700:e72:80a0:bccc:aed3:3481:8d68])
        by smtp.gmail.com with UTF8SMTPSA id o83sm4129158ooo.37.2021.02.16.12.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 12:36:05 -0800 (PST)
Message-ID: <22378ce3-6845-1cd9-996a-8bdc3a8b65d7@gmail.com>
Date:   Tue, 16 Feb 2021 15:36:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH] t/perf: handle worktrees as test repos
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net>
 <YCwoOMo7obrNOGYX@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <YCwoOMo7obrNOGYX@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/16/2021 3:16 PM, Jeff King wrote:
> On Tue, Feb 16, 2021 at 03:12:45PM -0500, Jeff King wrote:
> 
>> Having written that, it occurs to me that an even simpler solution is to
>> just always use the commondir as the source of the scratch repo. It does
>> not produce the same outcome, but the point is generally just to find a
>> suitable starting point for a repository. Grabbing the main repo instead
>> of one of its worktrees is probably OK for most tests.
> 
> The patch there is delightfully simple:

I do like this simplicity.
 
> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
> index e385c6896f..7018256cd4 100644
> --- a/t/perf/perf-lib.sh
> +++ b/t/perf/perf-lib.sh
> @@ -75,7 +75,7 @@ test_perf_create_repo_from () {
>  	BUG "not 2 parameters to test-create-repo"
>  	repo="$1"
>  	source="$2"
> -	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-dir)"
> +	source_git="$("$MODERN_GIT" -C "$source" rev-parse --git-common-dir)"
>  	objects_dir="$("$MODERN_GIT" -C "$source" rev-parse --git-path objects)"
>  	mkdir -p "$repo/.git"
>  	(
> 
> but I do wonder if somebody would find it confusing.

It would be confusing, especially if one let the "main" worktree
languish far behind another worktree. Rather, one case that applies
mostly to me and my team is when we work on git-for-windows/git or
microsoft/git in a worktree off of git/git. I think it would be
appropriate to use either, as the differences at HEAD are not so
significant to matter. But, any deviation from the HEAD of the
current worktree might be confusing when trying to reproduce some
surprising behavior.

Thanks,
-Stolee
