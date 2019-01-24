Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CF6A1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfAXRe0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 12:34:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36710 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXRe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 12:34:26 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so7559184qtn.3
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 09:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Hh+xXFQjDAMlxRRzFaS49blVQRrofkSHLRJhK4cuuUQ=;
        b=d/m1VDp9HlTUmFoeIOpnJLgHyL2TZV8IZwgihyGHo/3CzMqgL03r7QgbSOdcYWgI8/
         CNSyPLzGQ6EZn+iPoIPDri3q6BLMdamyCRoqMmf6opZNEEwHPWF+NhijduzUiUbODYkT
         bKEUuzA3VV0UlCwZoN3FdhQEWPW7puvFYlkhIxdv57REI99RVsuG+7OMfXhClauWgEeY
         TuHYAnWMeNkHDq7zaF42kAmpuj9Z8JS/RzTlh1OCDOy6Jt5t1aSCZB2BTGoGdxYCNcBg
         L5ScWnlteWqdy6FTh84BaNLI8b/vtU8fn02hZljjKkJzLxtLXq1+EZ9oRk+XmlOc0+os
         bd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Hh+xXFQjDAMlxRRzFaS49blVQRrofkSHLRJhK4cuuUQ=;
        b=PABYzx4EguT4FiU/pt3zd3uuf6yDe/V44ihZN08u6/cHQezEkmwmqNWKOl5m1D8ikE
         g2QY8l6WL8MNbTibcw0aLWGz1Lhmvh8AYdDozL08xZqyHQri0Rv/2diTc1EERkDcJuDT
         DTyWnLCvn91nTWI+CssT5rjqWhTcUOIrwmdlaqWwd2SoJqSTljWzGTXRz1vUhXzN31tC
         spstQognOY4FDVtxeNmLUHd+PUhqFtIiibwxF5DWcYyhZ78BPhugTXHQAu6A499euLj2
         8U+k/9+axBwYPvlz5bTZiChT8L07r4FJtFtilheQ46/QA73Ioo9SYgeUFNYdVreD0doX
         Y/+w==
X-Gm-Message-State: AJcUukdybJt6KtEdA23C374yRDVYdhz+UZ+2rz2RkI1grbnW4eeh4AwE
        wmpHQfRvtJkdM3CokJMuf/8=
X-Google-Smtp-Source: ALg8bN508aCpXL06OQSLMm7ijrodGFpra7qv2ddGASfYQ1DG2037LHqZE0JDkTafHdA53OpPtb3VIA==
X-Received: by 2002:ac8:2368:: with SMTP id b37mr7622288qtb.203.1548351264964;
        Thu, 24 Jan 2019 09:34:24 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:0:8946:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id d58sm75682805qtb.84.2019.01.24.09.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 09:34:24 -0800 (PST)
Subject: Re: [PATCH v3 5/9] midx: refactor permutation logic and pack sorting
To:     Jonathan Tan <jonathantanmy@google.com>, gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com
References: <a0d4cc6cb3fbca0de732dfd34cbec4d765b55228.1547047269.git.gitgitgadget@gmail.com>
 <20190123210054.118647-1-jonathantanmy@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <14fe05d0-75e5-0975-d490-550539dbb34a@gmail.com>
Date:   Thu, 24 Jan 2019 12:34:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190123210054.118647-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/23/2019 4:00 PM, Jonathan Tan wrote:
> Indeed, the sorting of pack_info is moved to after get_sorted_entries().
> Also, pack_perm[old number] = new number, as expected.

Thanks for chiming in with all the detail on the use of 'perm'. This is 
the most confusing part of this code path.

> I think a comment explaining why the perm is needed would be helpful -
> something explaining that the entries were generated using the old pack
> numbers, so we need this mapping to be able to write them using the new
> numbers.

I can put this comment in the struct definition. Is that the right place 
for it?


> As part of this review, I did attempt to make everything use the sorted
> pack_info order, but failed. I got as far as making get_sorted_entries()
> always use start_pack=0 and skip the pack_infos that didn't have the p
> pointer (to match the existing behavior of get_sorted_entries() that
> only operates on new pack_infos being added by add_pack_to_midx), but it
> still didn't work, and I didn't investigate further.

In the previous version, I tried to use 'perm' and the arrays as they 
existed previously, but that led to the bug in that version. Hopefully 
the new code is easier to read and understand. The delta may actually be 
hard to clearly see that it does the same work, but reading the code 
after it is applied looks clearer (to me).

Thanks,
-Stolee
