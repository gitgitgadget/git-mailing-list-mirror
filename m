Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE5CC4363E
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD53D6135A
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 18:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbhDASJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhDASEp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 14:04:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD06BC08EAC2
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 06:32:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso2052371ott.13
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t9Vvj8L3bVa6+vF10GK0wnGHz4AcGXNHubmS3Y8silI=;
        b=B0yoYm0HRWJK3JT0OHe2kQLKkE6CFFhL2wF3TexBl1yIzypeURgyf9Wi3aROzQjsgx
         /9OVSk+kbjDtFg520UI8zf6PDvoJOTdTMEJM17ovp4FQXt41kHAyi3/c5C6SoWp1EJfx
         rBwBn6pGHrjkcBKqKt8gQLZBXdrcmTioman7qtbS97Ad8qXKqfjg2a9uuP1JPZqNcRAx
         qgn6AHga40QlI3yugU8WoAZZsXN4I+/x9wPWQqMwhY4V5GwRWPQVvL/ZLSHrndcc5Pc5
         jpraqOBOkoO6reTBMk7JxWp0F5xb41qBF0iS8Fd/n2wMSWZzrDZkKqzAtu0vnV4pLNCt
         BIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t9Vvj8L3bVa6+vF10GK0wnGHz4AcGXNHubmS3Y8silI=;
        b=grkUcdgyib3Cg3r9N9iJ+eYL/Z0PHuOJ9Aee9s2USg5XC0zDa1D/QH+kIfNGguJgDx
         J6/FRCPoN+nvgqKzE0ps4ACC+Ls6LkE9bxSMP+nP8T27E2wka7AYO66MbmtbytY/Ru4a
         Qs21t1Hifld0IwqzQCS/DYfgkQ0BCLtZ86DlKQAqsZuPjBR3b1P6YSzAyxCaaDxUe8mV
         5dNxFdPF+3BbwW43xBC1C47UecQTaNnwflYZP6s5IC2hNdoiM0TaTQl4AcPfwz7loQLX
         W/HuViYBejiupemMuUT3QHlYDIIm2Q/PanlFwZU/0YG7USbQ27CUvJFZy5WaFaGKdBPF
         8dyA==
X-Gm-Message-State: AOAM533iv2AGPia/T7YnW/3OKl6HDZR6CFIBsEoPan5Y8reUYHETHZMc
        gpchWkDlbtb8OElfZ9o3Svk=
X-Google-Smtp-Source: ABdhPJyeQL3Lx/piUWFa7FPEJwypctVdLNk0FvE764CeRRv86nsfhRxnmL82DA+7P0xu1sxPmoAyYg==
X-Received: by 2002:a9d:d45:: with SMTP id 63mr6945819oti.238.1617283928000;
        Thu, 01 Apr 2021 06:32:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:1cff:cd17:c59a:654? ([2600:1700:e72:80a0:1cff:cd17:c59a:654])
        by smtp.gmail.com with ESMTPSA id s4sm1048451oic.3.2021.04.01.06.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 06:32:07 -0700 (PDT)
Subject: Re: [PATCH v2 00/25] Sparse Index: API protections
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
 <xmqqv99632lh.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9137b585-0184-3bc2-0d65-5e04a3469e92@gmail.com>
Date:   Thu, 1 Apr 2021 09:32:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqv99632lh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2021 3:07 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Here is the second patch series submission coming out of the sparse-index
>> RFC [1].
> 
> Queued.  There were a few conflicts with new codepaths and I've
> touched up a few of them (Alban's merge-strategies-in-c moves some
> code that needs to dehydrate the sparse index entries from
> builtin/merge-index.c to a new file, Elijah's ort has "const"
> pointer to the istate that you need to be writable), but there may
> be more that I missed.  Please check the tip of 'seen' when it gets
> pushed out.

Thank you for dealing with these complicated merges. I promise
that the series after this one are much more focused in their
code footprint. Thus, they should be easier to merge with
ongoing topics.

I validated your merge by rebasing the rest of my current work
in this area onto 'seen'. The tests for 'git status' and 'git
add' with sparse-indexes adds to the confidence of the merge.

I did see a small conflict with mt/add-rm-in-sparse-checkout
in one of my future patches because of an adjacent edit. I'll
be sure to base my next submission on a merge with that topic.

Thanks,
-Stolee
