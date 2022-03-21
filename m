Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED720C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 19:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352407AbiCUTEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352410AbiCUTEc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 15:04:32 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F1140E7
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:03:06 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id h196so12379605qke.12
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hvfYYkdeUQCrn1XFzvHlRNNma/94okv+hu+Alf2xGhk=;
        b=GoW31l5+sztqeLGV1ws8zsB3uINuSAc/3gbgaRjadJppPLXYthlAD14eZf16DumMby
         7nvqAkNO4HJ7wATsjhSuGnzY5Je2GeNiQ4MHGTIdE015otU7MyHHJj7QeBI92HyP4etb
         OP/I3rKY9iLHdGCO77WtJ1Ipc2LIbbGAocO7Nroa6rJ7ri9vk8Aguy2ckZmdr4fByg/M
         w3zeLBt1Hb3nNSIj7D7vfAnzCH+uYi8KTPu2UCsyXDHUBcjzC6pWE7jYdXrLUjSiq8xg
         7xz8omXBUy4nQj4jSVbBehYRG49N2diwf25m5tmwsW7OEVX2N1zB+Afa4LVc+8/jg/Fk
         ixJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hvfYYkdeUQCrn1XFzvHlRNNma/94okv+hu+Alf2xGhk=;
        b=c7qS1nNIUHQjb64nz14racu2CA5RAIfF4IGGI7woxk0fsqbrZeJv+rr28zOAlPsBdS
         ANnqDJiCJ03TuS2z2C5fvqkqv+2hVO8D5V3A0CXElyvqN7HIS6XWrJsBK4jUMh7ztB9y
         s4FI1f6Il57QeKESoA9VC6W+fxtOncFnpu/7yIorb1w4Z8tGMB2Gc62HjK2T5pYD9Dhn
         EeenpXkOUd5jEFf3xeiRRzmpefP4eFDEWHTAW9gP+GYKinD3Bzx2NHw0lOvyWIyRaHGI
         5RQWE9UO9HupjOa99T/sls8NF0Y8v9i69mu4qsYRZPJZat0Pl3nti/kTveHkADSTAX1E
         w2PA==
X-Gm-Message-State: AOAM530qu/j4h0yLVa7Dl5aL/FDwTxgwbT9J7A88PG3D2Av2Fzhx5M9b
        /w7QPAc0RllxrwFlAMnqrQzH
X-Google-Smtp-Source: ABdhPJyBEkeFAenD5gTHWL56uaJCIihL1qRp8CfFYzdxcLEc1z77wyGemHZQCOluYYclLoFH+//hzA==
X-Received: by 2002:a05:620a:24d6:b0:67d:b85b:3f5 with SMTP id m22-20020a05620a24d600b0067db85b03f5mr13619332qkn.692.1647889385529;
        Mon, 21 Mar 2022 12:03:05 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j18-20020ac85c52000000b002e1b9897ae7sm12085211qtj.10.2022.03.21.12.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:03:05 -0700 (PDT)
Message-ID: <df403c7b-5152-492a-96b5-575ccc1520de@github.com>
Date:   Mon, 21 Mar 2022 15:03:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] unpack-trees: increment cache_bottom for sparse
 directories
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, Victoria Dye <vdye@github.com>
References: <pull.1179.git.1647461522.gitgitgadget@gmail.com>
 <pull.1179.v2.git.1647532536.gitgitgadget@gmail.com>
 <cf8dc50c300a08f54d0cf69c82d4d979922a8143.1647532536.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cf8dc50c300a08f54d0cf69c82d4d979922a8143.1647532536.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2022 11:55 AM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Correct tracking of the 'cache_bottom' for cases where sparse directories
> are present in the index.

Thank you for the detailed background (that I cut from my reply).

> CORRECTING CACHE_BOTTOM
> -----------------------
> The problems observed in 't1092' come from 'cache_bottom' lagging behind in
> cases where the cache tree-based advancement doesn't occur. To solve this,
> then, the fix in 17a1bb570b is "reversed"; rather than skipping
> 'cache_bottom' advancement in 'mark_ce_used()', we skip the directory
> contents-based advancement for sparse directories. Now, every index entry
> can be accounted for in 'cache_bottom':

I have sufficient background to be confident that you are doing the
right thing here!

> -test_expect_failure 'add outside sparse cone' '
> +test_expect_success 'add outside sparse cone' '

> -test_expect_failure 'status/add: outside sparse cone' '
> +test_expect_success 'status/add: outside sparse cone' '

> -test_expect_failure 'reset with pathspecs inside sparse definition' '
> +test_expect_success 'reset with pathspecs inside sparse definition' '

Love to see it.

>  			if (matches) {
> -				o->cache_bottom += matches;
> +				/*
> +				 * Only increment the cache_bottom if the
> +				 * directory isn't a sparse directory index
> +				 * entry (if it is, it was already incremented)
> +				 * in 'mark_ce_used()'
> +				 */
> +				if (!src[0] || !S_ISSPARSEDIR(src[0]->ce_mode))
> +					o->cache_bottom += matches;
>  				return mask;

Looks great.

Thanks,
-Stolee
