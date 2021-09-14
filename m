Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1422C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 966706112D
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 13:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhINNev (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhINNet (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 09:34:49 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCFDC061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:33:32 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso18427485otu.0
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aboB+JOIG91AurB/qO9XdwuGqlnTRMwCGUw9KtsLpVA=;
        b=QaY0LYlS3hMHfE1LPHYzSiwsuQ107vDUM/+F/IHskxOar/w5HVmdE+pZKvfhSVDJQc
         XHeJ3j5E8mI5icq0JjtZHnxnQxkgBWJzuWK1d2Iu1zn42VX0q4K7MAgu7P2fhumiF9uC
         g5pfyhlZbM4j0Ex2SRq4K7nyKP/YAr5r1zvBV9h2pMy2+Arj93Y7QhaUYW5fyeXMpbvJ
         Jl01UJQONMhVImtc0JAFwcsIF5KwukUjdQ5OoSN7Nj6Kl1XkzJd3WhrCp3X6KN2CFw3Q
         DVHRZvvXQtadW2vfRBpVcH13XRDrcCn82EBYKy+vxXmi8NezMl4nA4FB8i55d0UiCs6S
         lINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aboB+JOIG91AurB/qO9XdwuGqlnTRMwCGUw9KtsLpVA=;
        b=1CUbM6YCL2UE6PG+OdKJTrbgbtRUgLhu03kwkFEEfLNYrn0t1LQo5A4ehPF46nb+iq
         liJFChinOCt2BvFgU1z6VZz5CdG4pDDh5mTj+OAcz6nfLRiMKjfUCtxGN7kf4hZ2PqLr
         MHuyRnZEAPrlsdw+DebiNXwD11bYiOPYRjPbqfRLvRtHojOPPV2IYYwcZOkKLudkwEcd
         ScMHsMkid209jxrjIld8hDKGXu0U1WbqUBFqYWPG0SiChM6FN5bCBGi2YlRR2mO3JcPu
         0Qwvc57RW67k0MEzS6BlGkHPWAI3lKP+84C74c/moTzl8sTUF6EW6JY6QTgYOD++R+Qe
         HHkQ==
X-Gm-Message-State: AOAM532WEN/AK27DqWGTSSGZXBMMrfxljcbIOoBfRNRj4EehDdyDcMOc
        fyA8L6Q6Wi1Iaz2/7s6LlUOhxwotAINGxQ==
X-Google-Smtp-Source: ABdhPJyvbMVDRYRbGEgmQIb20pijT07UF8kog+zMEWr8kOaBbXnIXRtWn4s1pQAge4pWwhZbaq5zQg==
X-Received: by 2002:a9d:458a:: with SMTP id x10mr14843450ote.267.1631626411028;
        Tue, 14 Sep 2021 06:33:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:69b3:ffa7:def5:d604? ([2600:1700:e72:80a0:69b3:ffa7:def5:d604])
        by smtp.gmail.com with ESMTPSA id t9sm2447764oie.20.2021.09.14.06.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 06:33:30 -0700 (PDT)
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqtuinc3tx.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <88bb51c3-b5ab-77df-f9fb-b9252c2b0fa6@gmail.com>
Date:   Tue, 14 Sep 2021 09:33:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuinc3tx.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2021 10:02 PM, Junio C Hamano wrote:
...
> * ds/add-rm-with-sparse-index (2021-09-12) 14 commits
>  - advice: update message to suggest '--sparse'
>  - mv: refuse to move sparse paths
>  - rm: skip sparse paths with missing SKIP_WORKTREE
>  - rm: add --sparse option
>  - add: update --renormalize to skip sparse paths
>  - add: update --chmod to skip sparse paths
>  - add: implement the --sparse option
>  - add: skip tracked paths outside sparse-checkout cone
>  - add: fail when adding an untracked sparse file
>  - dir: fix pattern matching on dirs
>  - dir: select directories correctly
>  - dir: extract directory-matching logic
>  - t1092: behavior for adding sparse files
>  - t3705: test that 'sparse_entry' is unstaged
>  (this branch uses ds/mergies-with-sparse-index and ds/sparse-index-ignored-files.)
> 
>  "git add", "git mv", and "git rm" have been adjusted to work better
>  with the sparse index.

These changes apply more generally to the entire sparse-checkout
feature. I can understand thinking it is only related to the
sparse index because the tests follow the sparse index patterns.
Those tests make sure that both full and sparse indexes are tested
and have the same behavior.

Perhaps this would be a good summary?

  "git add", "git mv", and "git rm" have been adjusted to avoid
  updating paths outside of the sparse-checkout definition unless
  the user specifies a "--sparse" option.

Thanks,
-Stolee
