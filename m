Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548AFC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiCWNl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244369AbiCWNl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 09:41:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3267D030
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:39:56 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-dda559a410so1704124fac.3
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 06:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Csg4PcuHnmF7opT+8mWZQzv32XW9MMg5C5rl7Il+Id0=;
        b=QAJhAaeZ3TbOCfWVXztsDTHUVyGuq0CeqgNkkXIWU7e2mXG7zofsVmgQvbqfJN3Fq8
         HSGMlceDhfIu3KoIr1HTNfd9yDiDGPl8AJ436i7ajMO4mLFxy0whyFfy0mAMlwviD6xY
         T6JdIsuzuFm8ae3C8hBUqrYWd8ztguB2lHyLmiAarBr4JGa7h0wb/cbTZmVCTh0h1YIj
         Z2xoS5PEhgcNEYuzRLvxc1m1LOsNeTJ5e3du0m3VgXncgj1B3u8Aat64aFVeAbexAj40
         xOM67Ou198c3Bs0kZSHAx8j+Hch4UZUA+Yxdnq5pqCx/UcVbgDZKhZJFdX5i1h4Xq+nc
         u9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Csg4PcuHnmF7opT+8mWZQzv32XW9MMg5C5rl7Il+Id0=;
        b=svkX50uDAxCgirqv3et297DhisF0/OCqNU/+z5Ln5NtDOGawOkuxzP8L9Z4o7G793j
         TckTRmFyPKKhu5fWqQpddfyOBArI26GW+iKYdVdKiCjV0rVvg2nVTRkXw+GOuinADg/P
         ccSq+7TQragPp0BsFPTHORFqo9ZimFL/Scl1guLWzvxogNL0QFR5J6ltaPKXmLOVhgfm
         Q7d00jDyIBOm3mBpSMwmVti4FuZR7BR8QLoGdlJIgucwi8ni+mTU5USYczepzWI50cZv
         guU/S7d+g4RclDe8dyHysN7WL8Xv6/7c4rDNOOoDISX+FdAThjP9UhmFm5az01R4nSQB
         D9VQ==
X-Gm-Message-State: AOAM530vQklfzNIQxSbRfK8G9kdoq3zlfaPQqGonGZTDd+H7cdlLQgMt
        Djhmshy5T49I5cv93VBTk8Ql
X-Google-Smtp-Source: ABdhPJwaiwXG79YFktC6cSPMjXDR2NkK/kxlRmd6cxLcXnK2z6ZJErStDEZR802y4dOGglQ66gtKGA==
X-Received: by 2002:a05:6870:5708:b0:db:2ef8:f220 with SMTP id k8-20020a056870570800b000db2ef8f220mr4201546oap.198.1648042796183;
        Wed, 23 Mar 2022 06:39:56 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id s65-20020acac244000000b002ef4ee8c800sm5210483oif.13.2022.03.23.06.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:39:55 -0700 (PDT)
Message-ID: <d0f5f912-c566-fc1d-b0b3-41669e34210a@github.com>
Date:   Wed, 23 Mar 2022 09:39:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 4/5] bundle: move capabilities to end of 'verify'
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
References: <pull.1186.git.1647970119.gitgitgadget@gmail.com>
 <1b2130426bd7bd6c0bf5c56be2bf66a4d81f0b27.1647970119.git.gitgitgadget@gmail.com>
 <29e64add-59ca-df77-a717-58c09c686336@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <29e64add-59ca-df77-a717-58c09c686336@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2022 3:08 AM, Bagas Sanjaya wrote:
> On 23/03/22 00.28, Derrick Stolee via GitGitGadget wrote:
> 
>> -    Information about additional capabilities, such as "object filter",
>> -    is printed. See "Capabilities" in link:technical/bundle-format.html
>> -    for more information. Finally, 'git bundle' prints a list of
>> -    missing commits, if any. The exit code is zero for success, but
>> -    will be nonzero if the bundle file is invalid.
>> +    Then, 'git bundle' prints a list of missing commits, if any.
>> +    Finally, information about additional capabilities, such as "object
>> +    filter", is printed. See "Capabilities" in link:technical/bundle-format.html
>> +    for more information. The exit code is zero for success, but will
>> +    be nonzero if the bundle file is invalid.
> 
> That means, nonzero exit code for corrupted bundle files, right?

Yes. That last sentence is unchanged from the earlier version
(modulo line wrapping).

Thanks,
-Stolee
