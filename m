Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15007C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 11:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E697960FD8
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbhHaLGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241296AbhHaLGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 07:06:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E5C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 04:05:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u6so14028459pfi.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SD4i/FaqEY02MVYxm3R0ln4sGW893PWcaf7Ry/D33bo=;
        b=fMIJUknrah5TB0YLRWv5b9bqCaPvOtzRd2IPG3EKTbVn0H7BhRG9ZZo7/VCYxnengw
         8mV5LyrvGJBS/Xvr+b/xmuiEWZlzMceb6RS4Z5fsHQw/5h0dvLcYnYjhyPd5VA6F8knJ
         9Nb/m+8Lg57Dd84IUl1FvtVgb56Q7JRQzbuRBTpU4FHLcMchv1pIKBT6mb9xM/lTekyE
         T6s8FsJHfRH0xyhJhsQy3LdJ/lnXbNmhEhyJKp/yw497BGu/YIBg2jwfx/dD/mWbPr5Q
         lCjJNzzSEHYRvVaydXDS9INpJ2uQcGNjfo0Y4gUHV3OwzL3Te2ehXLwr8IRfOUMoos0a
         Zd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SD4i/FaqEY02MVYxm3R0ln4sGW893PWcaf7Ry/D33bo=;
        b=edJthOm5C9JoWCP5bt/Waok6pWBrJtgdTd0U3axA22huY9643gJMz4Rwblt6HRP/D6
         RgGeDIdf7KcjyL2QynywYjGoG6Z6RCJSgdH/+7I0YkC7x7CryAdcgkULUqj1F0H0XQCF
         dbXsetjEVg+PvMtOGNpaD+by/NQdz45pb5Q73W/rBLYiwAHI/84sfs4/pl+OQ0iIQKxt
         oBoSZt+miB14noTWQz9C3G7VsbSlq1Jl6W9Jtw1RrnUtGXOoCHFBQu8mvwR2Qvy0fbsF
         t6LF8QsUAU+pkj/1fLVbVv4BI6f32H8SGhj7eIHe6ZY7oBwdSiuZZnOZRiW2QMSXbM6O
         pwkQ==
X-Gm-Message-State: AOAM533+PeGfe8UDkjE6KKwVU4ycVUHcJvH1LPfKfM5GBbFxOt4ss3E+
        T/Ey+se8GWv9SKy5FU5DZGU=
X-Google-Smtp-Source: ABdhPJzPxhwzyXmJfp71kauMqryebHWVLgwCockRbGg+surVt2UYT9s1CVA1uKIqXPxd/RFRiDpdAA==
X-Received: by 2002:aa7:9196:0:b0:3f2:a23f:3d70 with SMTP id x22-20020aa79196000000b003f2a23f3d70mr22276244pfa.69.1630407959049;
        Tue, 31 Aug 2021 04:05:59 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-57.three.co.id. [116.206.12.57])
        by smtp.gmail.com with ESMTPSA id 130sm7312004pfy.175.2021.08.31.04.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 04:05:58 -0700 (PDT)
Subject: Re: [PATCH 0/7] Add a new --remerge-diff capability to show & log
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <665c48f7-b597-154f-6ac7-8d0471f14869@gmail.com>
Date:   Tue, 31 Aug 2021 18:05:55 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/08/21 09.26, Elijah Newren via GitGitGadget wrote:
> Here are some patches to add a --remerge-diff capability to show & log,
> which works by comparing merge commits to an automatic remerge (note that
> the automatic remerge tree can contain files with conflict markers).
> 
> Here are some example commits you can try this out on (with git show
> --remerge-diff $COMMIT):
> 
>   * git.git conflicted merge: 07601b5b36
>   * git.git non-conflicted change: bf04590ecd
>   * linux.git conflicted merge: eab3540562fb
>   * linux.git non-conflicted change: 223cea6a4f05
> 
<snip>...
> In regards to the performance point above, the timing for running the
> following command:
> 
> time git log --min-parents=2 --max-parents=2 $DIFF_FLAG | wc -l
> 
> 
> in linux.git (with v5.4 checked out, since my copy of linux is very out of
> date) is as follows:
> 
> DIFF_FLAG=--cc:            71m 31.536s
> DIFF_FLAG=--remerge-diff:  31m  3.170s
> 
> 
> Note that there are 62476 merges in this history. Also, output size is:
> 
> DIFF_FLAG=--cc:            2169111 lines
> DIFF_FLAG=--remerge-diff:  2458020 lines
> 

Which repo did you mean by linux.git? Kernel developers often work 
against Linus' mainline tree [1], while end-users (including myself) 
prefer stable tree (which is mainline + stable release branches and 
tags) [2].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git

-- 
An old man doll... just what I always wanted! - Clara
