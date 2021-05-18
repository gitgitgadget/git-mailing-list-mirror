Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A428C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0F061185
	for <git@archiver.kernel.org>; Tue, 18 May 2021 13:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbhERN65 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 09:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243387AbhERN64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 09:58:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1373C061573
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:57:38 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so8666232otc.12
        for <git@vger.kernel.org>; Tue, 18 May 2021 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vtiFCCJv3FcDbfNhMS0BJotz2eAwJwPO9K/IN5bCLVo=;
        b=dGMrSosxQFm1kbBSGLJMav0nKimnxZPbZ0RPYehg8qUiBk/B2II8lkhApapJeSUo7f
         KmR5Skhp6+p3kTDply8gePFJLlgJ2NOkSjKJxuMtjm7CxTFEx7h2eRpVUHL3SyTqNZam
         gu7qxghYs6v8GmZamK1TEsaxCj0W5WW4NXMIIDnGbDX9VWjfWzRGtB4SLSnLk8EHymiP
         5/LU4S8KZG4YHbG83d6kmmYciBavd9zKbnI9155iioxqwZECcxwotBCSBDF3PB1iZW2R
         7/o1oNdZRMAkGCKWAdI47n1POdszrHs9urqnNjg8nMqPNKW/Fqkzi8xAjeWmq89NiRBm
         aJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vtiFCCJv3FcDbfNhMS0BJotz2eAwJwPO9K/IN5bCLVo=;
        b=BYzotBHMAXcQi1z9IWKP1y7yF8SA9uXT+Z9gyDOfOqkV+XombfHuTWRLWWuvjB4BH3
         XZ2y1ze250GihPlqtcCnFqvrq2Oc5FBJq2Yrqk6jGDpqb6skCW3iJof19ExP3P7dLngM
         M/8hjxn49fPdawzih3wCMqpvd1irpGAi/gpLDHUR4JS4WFjOYO3LpIhXlJcg7lNHsyFe
         rGTWEHpgz9QT6gsFKtrqIv3bRMnXeGuggQiXQyt66CAHGPrWgo4w2i/S5eIE6Jyh7Mus
         N2np8aSorNnlLTZcjCeDisBUoDS+uq8V2CUd0Qx7QfmR+CgIau+Oz8LSn4VyekEgeHpv
         ikHg==
X-Gm-Message-State: AOAM533qC3rjh1SUsCNHuHwI7krOgkWp7GcYEMEm9CC6rzZFd8JIgXkc
        XFV2wF0ZOUxwMY3fZuJHBb8=
X-Google-Smtp-Source: ABdhPJxWXPjurGYZlKkrZWnj8M3YtFILaYUy5po4i29k3dDJH7ihgZyhYtsjk9RlxEcOxPzg11CKcA==
X-Received: by 2002:a05:6830:1db6:: with SMTP id z22mr4449442oti.312.1621346258162;
        Tue, 18 May 2021 06:57:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bcf4:c194:74a1:9906? ([2600:1700:e72:80a0:bcf4:c194:74a1:9906])
        by smtp.gmail.com with ESMTPSA id n5sm3814588otq.69.2021.05.18.06.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 06:57:37 -0700 (PDT)
Subject: Re: [PATCH v2 06/13] merge-ort: add data structures for in-memory
 caching of rename detection
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.859.git.1616621553.gitgitgadget@gmail.com>
 <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
 <2a9e73de2beef5f51ad76fe1d9aaaed926a5fce8.1620094339.git.gitgitgadget@gmail.com>
 <b9bb5b44-47ce-8198-c546-8f07d03ef863@gmail.com>
 <CABPp-BFOSBVP-9A6BQegpaPRA+iU=ZQCiJYrTEkq0H9b+xRjEQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3a8972eb-ab3d-6470-33f5-553c06bf99ef@gmail.com>
Date:   Tue, 18 May 2021 09:57:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CABPp-BFOSBVP-9A6BQegpaPRA+iU=ZQCiJYrTEkq0H9b+xRjEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/17/2021 11:55 PM, Elijah Newren wrote:
>>         /*
>>          * cached_irrelevant: Caching of rename_sources that aren't relevant.
>>          *
>>          * cached_pairs records both renames and deletes.  Sometimes we
>>          * do not know if a path is a rename or a delete because we pass
>>          * RELEVANT_LOCATION to diffcore_rename_extended() which might
>>          * describe a path as "irrelevant" instead of as a "rename" or "delete".
>>          *  We need to cache such paths too, but separately from cached_pairs.
>>          */
>>
>> Does this make sense? diffcore_rename_extended() might need an update
>> to match this extra, explicit state.
> Hmm, let's flesh out the description a bit and try to be more
> explicit.  How about:
> 
>     /*
>      * cached_irrelevant: Caching of rename_sources that aren't relevant.
>      *
>      * If we try to detect a rename for a source path and succeed, it's
>      * part of a rename.  If we try to detect a rename for a source path
>      * and fail, then it's a delete.  If we do not try to detect a rename
>      * for a path, then we don't know if it's a rename or a delete.  If
>      * merge-ort doesn't think the path is relevant, then we just won't
>      * cache anything for that path.  But there's a slight problem in
>      * that merge-ort can think a path is RELEVANT_LOCATION, but due to
>      * commit 9bd342137e ("diffcore-rename: determine which
>      * relevant_sources are no longer relevant", 2021-03-13),
>      * diffcore-rename can downgrade the path to RELEVANT_NO_MORE.  To
>      * avoid excessive calls to diffcore_rename_extended() we still need
>      * to cache such paths, though we cannot record them as either
>      * renames or deletes.  So we cache them here as a "turned out to be
>      * irrelevant *for this commit*" as they are often also irrelevant
>      * for subsequent commits, though we will have to do some extra
>      * checking to see whether such paths become relevant for rename
>      * detection when cherry-picking/rebasing subsequent commits.
>      */

This is more informative, thanks.
-Stolee
