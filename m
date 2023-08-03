Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850B9C001DF
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 13:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbjHCNSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHCNSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 09:18:15 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6CF1BFA
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 06:18:14 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-583b0637c04so14300977b3.1
        for <git@vger.kernel.org>; Thu, 03 Aug 2023 06:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1691068693; x=1691673493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akZb1otjuvzs/hrbn4gj6cUdNLej6JwiyxjLcn2hmag=;
        b=FJ86pFumvJksatGhB1SdJ5Y95jZtuOYYn9mPFfo8GtLV7xx7mWrBK1//BZUol/Gnpt
         H241pgWmq3x8SDJvWJFk5Aw287qfBfnqI13tqpU+9njJQ674AGfJ7B3TvI+RQCFUnwOe
         rnHzEWA1rwr6Hy1Ly7ZCDmm7QnRnJ/CYGgQL3rwsO02sVM3ApypFKD0vHEZY2Pl6enek
         STnrG143vxIz+eLZ0N/iOsO6qG1frK+HYNmoPS22M8TzZqB2YLoDWY8TzxIccp2oN8CO
         jsdt+ggUARyMU6Fwa80C4ir2ojF70JuSFI3CfwPTYAw4Hc1fHD3v3UMnrUPMx5bpuHSG
         c/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068693; x=1691673493;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akZb1otjuvzs/hrbn4gj6cUdNLej6JwiyxjLcn2hmag=;
        b=kLSPIK8xrUS0nL7frhVirwcAPMtGC7bLI0nnoZeD5OPJ4EuxlFLIg1pu9UmNgIwnrN
         vXlb8Dshk1GLf55XxJXuhkswFOAedBzIaWWmXLXvb9/NfOeVf9RMI+NgfUji3vNfG/2G
         LzEihjX0+3HAK7/lbwXnIiSNRJVYDNq5uBcX1LqxlqFumKq8z1Na12def8BlNw5mipAJ
         BAFOFgBy90H+4CpQO3Z9YxQClV70DK1DvbP09k7KGO/Uu9EdQif91+hIhrmS6ULwA85b
         EsbRuXp0oNtwQGUiruttnVRvx3ptDtas27qwJZ148qZhH04IVcHfsqSAakgUCrP4TL9q
         5uKg==
X-Gm-Message-State: ABy/qLYmp5gH9t4UT9qfNRaN3f53TwYpBseR80DouwoMPWF2zM+FJaOh
        qMwj8F1JeAWxP8A+9cE/f6li
X-Google-Smtp-Source: APBJJlHMGsZTd6PCsnnrpTl3RpgYJP1vzSXOXsZReA6Qd2gusX08kK2fDKS7r8sJ5it587kbn7YAIg==
X-Received: by 2002:a0d:cc01:0:b0:56c:f547:e058 with SMTP id o1-20020a0dcc01000000b0056cf547e058mr20683942ywd.18.1691068693745;
        Thu, 03 Aug 2023 06:18:13 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7c75:79bc:8182:2a64? ([2600:1700:e72:80a0:7c75:79bc:8182:2a64])
        by smtp.gmail.com with ESMTPSA id o10-20020a81de4a000000b0057a0e5b18e0sm5194967ywl.142.2023.08.03.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 06:18:13 -0700 (PDT)
Message-ID: <491c237b-de23-52b0-c034-d4d358372864@github.com>
Date:   Thu, 3 Aug 2023 09:18:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <ZMKvsObx+uaKA8zF@nand.local>
 <20230727205308.401364-1-jonathantanmy@google.com>
 <ZMlKMmAs3wKULAOd@nand.local> <ZMruSSAGQWS8crvi@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZMruSSAGQWS8crvi@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/2/2023 8:01 PM, Taylor Blau wrote:
> On Tue, Aug 01, 2023 at 02:08:50PM -0400, Taylor Blau wrote:

>> That's a good point. I think in general I'd expect Git to avoid
>> recomputing Bloom filters where that work can be avoided, if the work in
>> order to detect whether or not we need to recompute a filter is cheap
>> enough to carry out.
> 
> I spent some time implementing this (patches are available in the branch
> 'tb/path-filter-fix-upgrade' from my fork). Handling incompatible Bloom
> filter versions is kind of tricky, but do-able without having to
> implement too much on top of what's already there.
> 
> But I don't think that it's enough to say that we can reuse a commit's
> Bloom filter iff that commit's tree has no paths with characters >=
> 0x80. Suppose we have such a tree, whose Bloom filter we believe to be
> reusable. If its first parent *does* have such a path, then that path
> would appear as a deletion relative to its first parent. So that path
> *would* be in the filter, meaning that it isn't reusable.
> 
> So I think the revised condition is something like: a commit's Bloom
> filter is reusable when there are no paths with characters >= 0x80 in
> a tree-diff against its first parent. I think that ensuring that there
> are no such paths in both a commit's root tree, as well as its first
> parent's root tree is equivalent, since that removes the possibility of
> such a path showing up in its tree-diff.

This condition is exactly "we computed the diff to know which paths were
input to the filter" which is as difficult as recomputing the Bloom filter
from scratch. I don't think there is much room to gain a performance
improvement here.
 
Thanks,
-Stolee
