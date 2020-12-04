Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D1C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F2922AAB
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 17:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgLDR1A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgLDR1A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 12:27:00 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5CC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 09:26:19 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id i13so1553476oou.11
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 09:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e+lHJGsqMEZEQVnGn4pN92oKVBiIYxHyHwQhUyMqBb8=;
        b=FfPXl34Cm4uC/6PZ+EoEUsjJ+81ZYDED2R1LT9Bv4MB8TVcdPQuANPcXTFMnc7rByA
         duz8F/V3Li7S65OlllXUDwnOxcwwas3ORgyaYqIaCJT3il1j8t3mdlq97aznSeWMjnEr
         WG8FuDce/Fd/VoUuGlYrag5IyIodc0MZvZuVJFBsTq2IxhneEeCuyrDP5AaeGdTRvg9j
         cpoHhO7oDjWrR/ocdAPRV6kJCC5sSLf2QkNjxyfPY1T7Oht+DrNY6wTc/mouC0eWMzT9
         ZEIGb1oE2JyUg26kOujkNcSHQQ91jg5lvqH0jnbSlQFHdGGMC/Mkg3OY7/2yWdevu6VU
         FUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e+lHJGsqMEZEQVnGn4pN92oKVBiIYxHyHwQhUyMqBb8=;
        b=WG58z2gDWW/6d1D3lqKKGScVkDL6Ks0av5HBIVj0iSi29IgaVX4xR/ivrEhWxAuWre
         nvBe9E+hQIIFQq3whmRgQMprovsVMsbVySbHICXSOnw84z+h31WAJlvIzUdJpCLQgBxj
         MJDI7IMZVbFGalxPsuM6YrKhvNUpILDvbZnjmDo15qKVImu2WYDzPG5Jn6PTyGB8bQQ+
         3t1/lq7AEF2oUQm1HuoT2FzACQ2gT5WeF0X0tDZiMg7fP4RC346c6IGRvTEV/86A2Xs2
         FNsnv4eiZsaXrXLudFeGnYsoLO2KZzGzFnIOQLTdHLnF/I7Rg507zLlLtWVrPEgxFvkQ
         3Mtw==
X-Gm-Message-State: AOAM533MVcqwfkujmH9AR2RcP02QWTXsuFX6WgngJf1QCjPcLXINFi9w
        0dPEhsGx+/MMI22ct1Hye1Q=
X-Google-Smtp-Source: ABdhPJzu+S9ch5tesyBfCNqx+N6U6EBORgsm22kPM8/7bTl2NxlsDfkDI/DnUEOyZjMSsFq8PHKCFA==
X-Received: by 2002:a4a:7055:: with SMTP id b21mr4355252oof.66.1607102779272;
        Fri, 04 Dec 2020 09:26:19 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id u10sm748600otj.31.2020.12.04.09.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:26:18 -0800 (PST)
Subject: Re: [PATCH 0/7] merge-ort: some groundwork for further implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <pull.803.git.1607011187.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2ea0aab8-934f-3eaa-e3d0-9ae35a278748@gmail.com>
Date:   Fri, 4 Dec 2020 12:26:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <pull.803.git.1607011187.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2020 10:59 AM, Elijah Newren via GitGitGadget wrote:
> This series is based on en/merge-ort-impl. This series sets up three future
> patch series (to add recursive merges, three-way content merging, and rename
> detection) for the merge-ort implementation, and allows the future series to
> be submitted, reviewed, and merged in any order. Since those three things
> actually do have some minor dependencies between them, this preparatory
> series is needed to make a few small changes to set things up to allow them
> to be submitted independently. 
> 
> The first six patches are trivial. They should be easy to review, and as a
> bonus you get to find how I mess up even the trivial stuff. ;-) The final
> patch is more substantive and represents one of the big changes between
> merge-recursive and merge-ort -- namely, how notice/warning/conflict
> messages are reported to the user (I possibly should have included it in
> merge-ort-impl, but that series seemed so long already...).
> 
> Elijah Newren (7):
>   merge-ort: add a few includes
>   merge-ort: add a clear_internal_opts helper
>   merge-ort: add a path_conflict field to merge_options_internal
>   merge-ort: add a paths_to_free field to merge_options_internal
>   merge-ort: add function grouping comments
>   merge-ort: add die-not-implemented stub handle_content_merge()
>     function
>   merge-ort: add modify/delete handling and delayed output processing

Coming back to say that I finished reading PATCH 7 and this series
looks good overall. Tough to be confident in it when the implementation
isn't connected to tests, but the patches do a good job of describing
the isolated changes. If there _are_ problems, it will be easy to
identify the reasoning behind the code using log/blame.

Thanks,
-Stolee
