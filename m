Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0583CC433DB
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C953020663
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 21:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWVGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 16:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbhAWVGd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 16:06:33 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F28C061786
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:05:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id u20so257821qku.7
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEI5m6Pxa/fJQRD9+9XsI0Qbvm419LwKoQjFJJ+TPWo=;
        b=M+u4RQzVTz4XrK32nHRY+HtbaqliGiuX3+zODruX8ibLuLGR2T0sY9T0AzlOi+PozO
         bwaDDMc0R3PvMj+SrtMkdARdZfUcXd/0YyhnP9+PF7Ep1utiTc8I25LieDrskbkSKQ1Y
         bv6LxGiOQk7sCLWTCiM3pDMKZ84PDhb9nLba8J0fp12coBbOZcvinCY8rD2RjQGz+Sfr
         SGTkpwB3xeaDaGeJdxDwfpflUIwkVTAdyQPg74eR+luaPEy4PZRglWniLIiownt6Z1P/
         CulgIprRfVFVj8TX1zeWyOBsyQWjlwqvSWsHi8xh0VVxDqmHRkLUOM2fX5jdVvCAfh5Z
         YzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEI5m6Pxa/fJQRD9+9XsI0Qbvm419LwKoQjFJJ+TPWo=;
        b=Nr/pRqZvwlqHcekZKYsWREKf1S4bR8krwPfcZ1dRS2qT8DkrxksUxSU4h0ScKyGqzw
         Pb1N1UmjQWlY+WsElVK5yqTfq+6tq5IEU0pft7B7N9OGiVpr0+78noO0y/PdGtjo7nS/
         /PlSZpu/+IWbW3orluAKekWiI2Eg8Ym+HaGr0oQ6Qoe5gYseKWyvdpzgssobah/g1k92
         HEiV5vd9VnOav2pDfegLpv+IgHCHEOEaZ5QvJzAgfBFktmDIKjsc9sux43xSXjPOBtfr
         7pwmWnmjTMPtr/PlKEpAaIMwIToAmFslwHIvEKk2ilywFPK/xc3fvtUELt9WUeYbcG6v
         54Vw==
X-Gm-Message-State: AOAM533/o6ACSLLgmwnAY0JhZXEwCVsJAIVzKmv8cZUvoirBCcSzl9ml
        KOJWageXenFUDXzfWXW9H1fChXZ5OnT3dA==
X-Google-Smtp-Source: ABdhPJwGEa5h9MuKOadxbFFqAkejVuXWcwrfhwRu/YXL/QWkOz/qh9IUKLBCJsPU7NqSWzR5xmS16w==
X-Received: by 2002:a05:620a:1ea:: with SMTP id x10mr10654127qkn.90.1611435951873;
        Sat, 23 Jan 2021 13:05:51 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:98e8:103:e6ee:9536? ([2600:1700:e72:80a0:98e8:103:e6ee:9536])
        by smtp.gmail.com with UTF8SMTPSA id e1sm9145482qkd.135.2021.01.23.13.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Jan 2021 13:05:51 -0800 (PST)
Subject: Re: [PATCH v3 0/9] More index cleanups
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.839.v2.git.1611320639.gitgitgadget@gmail.com>
 <pull.839.v3.git.1611431899.gitgitgadget@gmail.com>
 <CABPp-BHFiXLOS4Vbm156+JxZw=t2P_Fzf8E3p4u0iwCv28_Rdw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b4a4df78-fb36-5a27-7ec0-79d752de73ae@gmail.com>
Date:   Sat, 23 Jan 2021 16:05:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHFiXLOS4Vbm156+JxZw=t2P_Fzf8E3p4u0iwCv28_Rdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2021 3:29 PM, Elijah Newren wrote:
> On Sat, Jan 23, 2021 at 11:58 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This is based on ds/cache-tree-basics.
...
>>      -+ grep -e "\"region_enter\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
>>      ++ grep -e '"region_enter".*"category":"'"$1"'","label":"'"$2"\" "$3"
>>       + exitcode=$?
>>       +
>>      -+ if test $exitcode != $expect_exit
>>      ++ if test $exitcode != $expect_exit = 1]
> 
> I don't understand this change.  Is it even valid code?  What does it mean?
> 
>>       + then
>>       +         return 1
>>       + fi
>>       +
>>      -+ grep -e "\"region_leave\".*\"category\":\"$1\",\"label\":\"$2\"" "$3"
>>      ++ grep -e '"region_leave".*"category":"'"$1"'","label":"'"$2"\" "$3"
>>       + exitcode=$?
>>       +
>>      -+ if test $exitcode != $expect_exit
>>      ++ if test $exitcode != $expect_exit = 1]
> 
> Same comment

Wow. I am sorry this snuck in. It's an artifact of what I was trying [1]
in response to Junio's comments, but then did not completely undo. I'm
surprised this ran without error. Will fix.

[1] https://lore.kernel.org/git/8406512b-3d9f-e899-24fd-8a09c4af3569@gmail.com/
