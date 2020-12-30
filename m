Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D9C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C57320867
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgL3Bgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 20:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3Bgj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 20:36:39 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB453C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:35:58 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id x23so3399992oop.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 17:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HRIEcndob7m1NvyPmWhpHRcHKC16EJI+zwKdJ9+2iqU=;
        b=n9xM+izuBCRXpc1NFvv38zrjXo6SgTvpv20hsHHhHtD8HlMxZkCmDA8RrB4dEASUFV
         GTDwyl1+oEZ8G8rZt9aFJqmIva7AAJ+Lq11RNioBeQAtGgKUOp1A/0hlt4+fawXLCTdc
         ugejCKGmUxa9mz0z3aJT0ts3O3OvM03ufbwPCWmEURhf8RQXEKH/lzZq21QIAlrlP15+
         R9o+0qOaCwINliG06Rf2vg9KZ6ih+90bfb2rd2hR6j98rJa3kmAEJn4HVf2RFw8EZOLz
         r1I3coManfKjWXbGMslXtLQmH+CBJuxBuC0u3LMX7z53MhnHHhMRJDmBKbITRmI+xUUZ
         JBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HRIEcndob7m1NvyPmWhpHRcHKC16EJI+zwKdJ9+2iqU=;
        b=RBTZ9vNFucL6/mg3m4SZ+L3QAxLrNxfxSn7zkUHdWhj6kVbWAz0fTFzRCVbjLED5S9
         2zGwqyZgttlQcKIWDccKs0kJ6NVP5E8nRBZz65Te+GXgoyzBC3SdoNaSRpi1uGFAkGL6
         /1zum5S+ja6ZyEb+ikNBnsfhgaySVEgC3A/v7pt+pxr8S4DmCRfRoQnfgu6QItupvxRT
         VrKtlv1LaPH9qrNMre08Xc0gge/S8OUBxfa34TIWqZ5Xo6t2pxzcFJDhxFs54Udiclsf
         txtXIjrJknoKhBlmMxDpdEXTaoxVIQXa3i4Buo9z0V8BAy8CesPmxiA2oARNx7VsQQmF
         4AZQ==
X-Gm-Message-State: AOAM532CVR9peJ0Ccm54jSc76/foZ77p6BWPjVff9B+Dv6131wMbdvvj
        e7UTeBuEdubcs36KLzaKSXVKr4dJGdE=
X-Google-Smtp-Source: ABdhPJyI/kCjjGW9HAThxRs/N0JXvYAt01HlT8kBMOh6CSESPMYkZzSnRUtFPUngn3CmEjBiRGRYBg==
X-Received: by 2002:a4a:e606:: with SMTP id f6mr26986124oot.4.1609292158048;
        Tue, 29 Dec 2020 17:35:58 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id 94sm10452999otw.41.2020.12.29.17.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 17:35:57 -0800 (PST)
Subject: Re: [PATCH v5 01/11] commit-graph: fix regression when computing
 Bloom filters
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
 <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1694688e-0253-9d67-1982-8ce483183162@gmail.com>
Date:   Tue, 29 Dec 2020 20:35:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <c4e817abf7dbcd6c99da404507ea940305c521b6.1609154168.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 6:15 AM, Abhishek Kumar via GitGitGadget wrote:
> From: Abhishek Kumar <abhishekkumar8222@gmail.com>
> 
> Before computing Bloom fitlers, the commit-graph machinery uses

s/fitlers/filters/

> commit_gen_cmp to sort commits by generation order for improved diff
> performance. 3d11275505 (commit-graph: examine commits by generation
> number, 2020-03-30) claims that this sort can reduce the time spent to
> compute Bloom filters by nearly half.
> 
> But since c49c82aa4c (commit: move members graph_pos, generation to a
> slab, 2020-06-17), this optimization is broken, since asking for a
> 'commit_graph_generation()' directly returns GENERATION_NUMBER_INFINITY
> while writing.
> 
> Not all hope is lost, though: 'commit_graph_generation()' falls back to
> comparing commits by their date when they have equal generation number,
> and so since c49c82aa4c is purely a date comparision function. This

s/comparision/comparison/

> heuristic is good enough that we don't seem to loose appreciable
> performance while computing Bloom filters. Applying this patch (compared
> with v2.29.1) speeds up computing Bloom filters by around ~4
> seconds.

Using "~4 seconds" here is odd since there is no baseline. Which
repository did you use?

Previous discussion used relative terms. Something like "speeds up by
a factor of 1.25" or something might be interesting.

> So, avoid the useless 'commit_graph_generation()' while writing by
> instead accessing the slab directly. This returns the newly-computed
> generation numbers, and allows us to avoid the heuristic by directly
> comparing generation numbers.

This introduces some timing restrictions to the ability for this
comparison function. It would be dangerous if someone extracted
the method for another purpose. A comment above these lines could
warn future developers from making that mistake, but they would
probably use the comparison functions in commit.c instead.

> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  commit-graph.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/commit-graph.c b/commit-graph.c
> index 06f8dc1d896..caf823295f4 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -144,8 +144,8 @@ static int commit_gen_cmp(const void *va, const void *vb)
>  	const struct commit *a = *(const struct commit **)va;
>  	const struct commit *b = *(const struct commit **)vb;
>  
> -	uint32_t generation_a = commit_graph_generation(a);
> -	uint32_t generation_b = commit_graph_generation(b);
> +	uint32_t generation_a = commit_graph_data_at(a)->generation;
> +	uint32_t generation_b = commit_graph_data_at(b)->generation;
>  	/* lower generation commits first */
>  	if (generation_a < generation_b)
>  		return -1;
> 

