Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDD2C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C9F6023F
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbhJ0UK4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbhJ0UKz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:10:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D7CC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:08:29 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id h20so3607865qko.13
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BGuoS55bHrM9HrXgnKR/w5U6pXb7ldT9by+IidsCKj4=;
        b=maRX61XglkB/H24rbpiwJECd2+jrdmnQ/LJjrecjx7flEW7jVogBO9lCOL8qYrrVRx
         1SPQxHKqne8ix5R39SuueGTASUhCTZZGRF25lMS9LiL9XHg2QuMJf4XsHHw2DwvqEO2r
         vqLbv7ueJNgxXOLa/1y2l2RFDlfyagMniVtM4it4phqjTV1O/wWYvSSfOzIRq8ev17I4
         sr4VpqigVPkLRb8Ve83CXKv8OzgASGiUZ1IufZurlcdKWjy7t2mPsvPg6E1Y0Ma6yO/U
         jHqts6UqGIMfLVi9v2wzY1mP9wUI9E+ioXarHL+Kh6WvYP56Y6iv9HApRP5diSyLN4sF
         m4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BGuoS55bHrM9HrXgnKR/w5U6pXb7ldT9by+IidsCKj4=;
        b=W6oKiTgXmdJ7/rNAAgKx4ZyI15FJt0P+gyyp3nzTXjLeb3Qvm7OfGCNxahBbuOjZTC
         AuKpgT/VNo0/BQjKPd8+Orl5ZLvpGFBu7HOwzuUzoJWzeS68sci/hFu5RynD96XlyVp7
         OASnqReS0PU8cMHKn/fgHLHyw9DFWFqf5bNmrzjkrUU9ePkUaYkjLjcKyo4ShIK4NjpW
         drAoBYRmX+gMT8QpcMHMGIZRXwb/bXmKDnk6jBrNys4bbUysKRv6TZH01zh16KFTV2Cx
         ZAcfFQ7zpftNWPFEZ3mipLJqSGubSpnJQgxUybadpti7yiXw7M9pvo7MYCYq5XoYHIw9
         cYAg==
X-Gm-Message-State: AOAM530MiiBEucQe60f3dcZ/csnEeVSu6n5mwEFWc3p+82C6OrTQi67U
        ZRLr0W7QXcPIiEF09EReiWk=
X-Google-Smtp-Source: ABdhPJwTqXhUSHjpXr1cFPs3rhuXirrZQqjrW424FVWZu2t7IOjIKuD2bnobB+5/rn6Yfv63XDudQg==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr5849119qkl.97.1635365308473;
        Wed, 27 Oct 2021 13:08:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e44a:53c8:a196:8752? ([2600:1700:e72:80a0:e44a:53c8:a196:8752])
        by smtp.gmail.com with ESMTPSA id r12sm671639qkp.11.2021.10.27.13.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 13:08:28 -0700 (PDT)
Message-ID: <e1c6fe43-ebd1-7c6f-c5b6-c528fb4e6774@gmail.com>
Date:   Wed, 27 Oct 2021 16:08:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 0/3] sparse-index: expand/collapse based on
 'index.sparse'
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
 <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2021 2:20 PM, Victoria Dye via GitGitGadget wrote:

> Changes since V2
> ================
> 
>  * Rename can_convert_to_sparse to is_sparse_index_allowed to more
>    accurately reflect what the function returns.
>  * Remove index-iterating checks from is_sparse_index_allowed, leaving only
>    inexpensive checks on config settings & sparse checkout patterns. Checks
>    are still part of convert_to_sparse to ensure it behaves exactly as it
>    did before this series.
>  * Restructure ensure_correct_sparsity for better readability.
>  * Fix test_env variable scope.

I took a full read through this version, taking special look at the
changes since v2. I think this version is good to go!

Thanks,
-Stolee
