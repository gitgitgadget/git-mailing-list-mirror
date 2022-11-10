Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651BC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiKJR0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 12:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiKJR0d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 12:26:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFCA167FD
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:26:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h24so1303832qta.9
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 09:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrD5iwhJGEppOoBdRdJYPnr9s5/xYj4YLWtrDBnz+BQ=;
        b=bJEEg553yoz3ua+TP7QPCU5TTMzUwvpm4GCXbCrr3SuhZ0QvgYMK8uIL7CsAPiBNn1
         6mYpOjuPs+KVUrxUqaxFI/IVu2R1Q04n2ZhiSS6o4pUaJnYIbyzNK0ca64UnpnjRB0Fp
         XoUB/AEu8MquD7kb+1hLvUyRONmbtmH0WcuBrD5Y2fu+KLoy1bFeSqplZWe5QmtdDnD/
         MIJxee+qj67xSIvCFqbvk+no8ivWxMpE5oAw4ZchvYuhk97QgUEqKKGBKHBQuWLwnxFv
         blDaJnLn3SHazVD3Jky2EKDaEMmWTA4Ya0FcmE9pdqrWKr1mehs9yOr8rgQq8lF6RD6b
         mm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrD5iwhJGEppOoBdRdJYPnr9s5/xYj4YLWtrDBnz+BQ=;
        b=Z+wX2HKGa4LmE+tfxplnbnqYw0YJdxYVxkbdIqsXUEw3+1XsVPmIosadNXnKXtZnmn
         IdZ5Dye0gsRuxK+6M+NxJf9Htw12u1AnB24MtiHIRTLioBFjdsL9cbwkFGjqjhSJaAuz
         HTxSfWkimc1WIo84dS3t9FcIluGMbTU1x/EGyPNZKFTwvUxLZgtv22vU5Dcn8cfsg1I1
         4NCQN4UX+d4GmWJ1SPoFN5t1567bMTYgbxySr53WnUi1zx1oK/Pc7NsPfkV/dMaxEygF
         p+/NnE1TAg+y+nnLJMXVwwtz1Uz6q96o/W/qF2QM563TFtVPguvpSIJFk5UDDziMasPx
         f8RA==
X-Gm-Message-State: ACrzQf3ITjF87jg24KY87O19qLrkMaJvTV40rpDgK7rCITUkbV6+rpOO
        Af275vClTAWrBdQAnzVhMlsh
X-Google-Smtp-Source: AMsMyM7RJuGdu9OTyEpR8eGTaAixWSdMrgRwT5MoGDDT5lfO65HWfJI4rqVUFlEgIe3uw6gh+I36UA==
X-Received: by 2002:ac8:4a16:0:b0:3a5:1f7a:61f3 with SMTP id x22-20020ac84a16000000b003a51f7a61f3mr1510261qtq.65.1668101191825;
        Thu, 10 Nov 2022 09:26:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf? ([2600:1700:e72:80a0:8dc6:f062:5d1c:cdbf])
        by smtp.gmail.com with ESMTPSA id w13-20020a05620a444d00b006cbc00db595sm13360825qkp.23.2022.11.10.09.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 09:26:31 -0800 (PST)
Message-ID: <52f94376-bd05-9470-3804-4fcbc5751d18@github.com>
Date:   Thu, 10 Nov 2022 12:26:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/5] Skip 'cache_tree_update()' when
 'prime_cache_tree()' is called immediate after
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        jonathantanmy@google.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
 <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/2022 8:57 PM, Victoria Dye via GitGitGadget wrote:
> Changes since V1
> ================
> 
>  * Rewrote 'p0090' to more accurately and reliably test 'prime_cache_tree()'
>    vs. 'cache_tree_update()'.
>    * Moved iterative cache tree update out of C and into the shell tests (to
>      avoid potential runtime optimizations)
>    * Added a "control" test to document how much of the execution time is
>      startup overhead
>    * Added tests demonstrating performance in partially-invalid cache trees.
>  * Fixed the use of 'prime_cache_tree()' in 'test-tool cache-tree', changing
>    it from using the tree at HEAD to the current cache tree.

I did a re-read of this series and it looks good to me.

Thanks for doing this investigation!
-Stolee
