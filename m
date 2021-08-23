Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7388C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADAF6126A
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbhHWNOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 09:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbhHWNOo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 09:14:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C5C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:14:02 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id m21so19008160qkm.13
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=io/GTDu4C1mkSAHP0/diWc08XZkrh5CTS49lVIkbo7g=;
        b=ohNkORfLOqZAXmCkLIZNOtILc0PjpL/k/23vc42Pop9SJzFM7BMnNlpaTfz/9xONgK
         DLIMd4FIRTSLndma5lBi+L3eMdKOtURPXp9xNX4oIUSBsQ3f40453Caxlni4uAdS6N3Y
         fhjFfhzFMt9Ru9PFKEbCyn3PxuVBra8ih3gvAB6HGt0+zTCDOJt9htfEp2VR1IVnUo9K
         x0FupGoEQWvSH6rqhnPnHlzOQPw7RPrsAO5cGC9yheB8NAHSRhtLYX8aCueBqJzzgsag
         q1UiG1YUiL3PlL/G3Kit3yfQjkEGXDWbqavw8Mva+u5Q9ZlSsRQ5yVGOPTyo/p1UrJLE
         udlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=io/GTDu4C1mkSAHP0/diWc08XZkrh5CTS49lVIkbo7g=;
        b=jJ74Skv7nX6AoVTRthQTNcrWFUHkWpSFgCJ/w+grb4R+csZNWoWYdhtFlmXR/lc+iB
         j9pjdEjUJjfjBfUJ5PeBuw8L6FwlmVTLBQ1OEnuStPonsUC6URzesZ9Ej+lve4a/UDdm
         7k5bcczNG+5Yv7t8TORy6jW7l8GIMJLNB8UUMPvjh2AYq2tttpdjyBByL6nXtOwEHKM/
         mLaI+lSYw0MJbLYoeaXYEp6yskth2CL8AoA4Gnk003e5ulzP2yJrIAzahHo99lfuWAwX
         fPFf0eodC5TO+Ho+3wYmu1D6IAw4q+obSKSqeodRDyDTFuC59KW3kv737Dp1u8bUsob3
         tkAA==
X-Gm-Message-State: AOAM530IP/bKA3oRUUxahd7H+PEG0SEVU3fU/o5qSTHF/lJ5Aa82PqPA
        4gDGY+iItEt03RHHWPKZqrk=
X-Google-Smtp-Source: ABdhPJwTrbmnE6+3P1wCfNNXRGQiT66IN2qgDeiVt4QCNE0jUMnQ/VH6rmDy53h6KTuJjgE0GuXmHQ==
X-Received: by 2002:a05:620a:c92:: with SMTP id q18mr20487740qki.331.1629724441370;
        Mon, 23 Aug 2021 06:14:01 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:48bd:24c0:4055:3255? ([2600:1700:e72:80a0:48bd:24c0:4055:3255])
        by smtp.gmail.com with ESMTPSA id c67sm8394125qke.113.2021.08.23.06.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 06:14:00 -0700 (PDT)
Subject: Re: [PATCH] sparse-index: copy dir_hash in ensure_full_index()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5c0f41fb-e8d2-0aa5-66a3-6a61a98e8381@gmail.com>
Date:   Mon, 23 Aug 2021 09:13:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1017.git.1629136135286.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/16/2021 1:48 PM, Derrick Stolee via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Copy the 'index_state->dir_hash' back to the real istate after expanding
> a sparse index.
> 
> A crash was observed in 'git status' during some hashmap lookups with
> corrupted hashmap entries.  During an index expansion, new cache-entries
> are added to the 'index_state->name_hash' and the 'dir_hash' in a
> temporary 'index_state' variable 'full'.  However, only the 'name_hash'
> hashmap from this temp variable was copied back into the real 'istate'
> variable.  The original copy of the 'dir_hash' was incorrectly
> preserved.  If the table in the 'full->dir_hash' hashmap were realloced,
> the stale version (in 'istate') would be corrupted.
> 
> The test suite does not operate on index sizes sufficiently large to
> trigger this reallocation, so they do not cover this behavior.
> Increasing the test suite to cover such scale is fragile and likely
> wasteful.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>     sparse-index: copy dir_hash in ensure_full_index()
>     
>     This fix is an issue we discovered in our first experimental release of
>     the sparse index in the microsoft/git fork. We fixed it in the latest
>     experimental release [1] and then I almost forgot about it until we
>     started rebasing sparse-index work on top of the 2.33.0 release
>     candidates.
>     
>     [1] https://github.com/microsoft/git/releases/tag/v2.32.0.vfs.0.102.exp
>     
>     This is a change that can be taken anywhere since 4300f8 (sparse-index:
>     implement ensure_full_index(), 2021-03-30), but this version is based on
>     v2.33.0-rc2.

I sent this patch on the day of v2.33.0, so I'm not surprised that it
got lost in the shuffle. Could someone please take a look?

It also has not been picked up for the What's Cooking email.

Thanks,
-Stolee
