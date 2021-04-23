Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201FC433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C49613D7
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbhDWTt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhDWTt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:49:28 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF2EC06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:48:51 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id 1so37280655qtb.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Aj3qyus4YKBXDkhwq/Wrw9qHzgp1rCELV0noQM78nzQ=;
        b=uLVm/Qgxp7s04H5TvcLtE0rxuktYnV3x87P3OzOVIiV/yuUd1yUD9MnYQiisEA/KDX
         Gh/zGYDhGtxsF6+0Fyjd0AY5EdT/D1+1nQONlCVe4uw7u9G7TXSOzttI7BHy/bo2SrEM
         76kbAoPVsL+JRRocGZWGkhBD3vZfz2tvADZ/Wp4+j4Q4MAwZauz9s7JWhQ0CfX7IsaXA
         uzaNtikq7+fnZFhR7McC4TNM+k8/9cDl4k69+8vfBCAXoAT7TCWkD00Np+3q/BmgcaaV
         JthSxj1IX/EEnfKS6zS93LTIS438gIU4X5f9BLydSfje6DxGBEEo4EtkBFbFUcnX7Hbx
         Ph2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Aj3qyus4YKBXDkhwq/Wrw9qHzgp1rCELV0noQM78nzQ=;
        b=MuyyysW2h8JdgiVlABvCPaxaJTN8Sbh05U+SsmBUjrKmO900F7486QekisqzftMZ4f
         WonAj9KJMHJr2ealbp93EaU2mdeZfSYXeGthuTwNm8HlRGz+2Pv32PlwCnki56b4KWxx
         +991RYHumrvKT9adTi54yB7ny+VxoAh64bbaiJkzSaNb+sl5d74d1C1U4hSEPzS1IRAP
         uUY8ujKL6kNMhVU749GROEMa5Zd0rKYRcuACf/iu6jT9mbPImrX1J6f4hFXQ52rsjcSa
         qpIrKLYCV6cvmRLxYsnGzTlMgbNG6nzrMB8h+KnhZSrFEPj7N0kUJlCwv57fs/uVTCVL
         p2Vg==
X-Gm-Message-State: AOAM530DtlqT6x2wfJkCncU3UC76rSRM3tOi2BBJyE5RmOEOTsbL1eUl
        zfGv5FG4k4cNFr2NkHHB3v8=
X-Google-Smtp-Source: ABdhPJw98pEA3DbGoPYy3IUVx+gg+/vDjOtEhsW7HEK7KLNuMCrVaK8rOoAxIr6S0Sbtk72g6ORoww==
X-Received: by 2002:a05:622a:48b:: with SMTP id p11mr5477669qtx.84.1619207330194;
        Fri, 23 Apr 2021 12:48:50 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3de1:cfe2:170e:4cb9? ([2600:1700:e72:80a0:3de1:cfe2:170e:4cb9])
        by smtp.gmail.com with ESMTPSA id v11sm4901343qtx.79.2021.04.23.12.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 12:48:49 -0700 (PDT)
Subject: Re: [PATCH 6/7] parallel-checkout: add tests related to
 .gitattributes
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     christian.couder@gmail.com, git@jeffhostetler.com
References: <cover.1619104091.git.matheus.bernardino@usp.br>
 <3a0845fdbb0481ead96b15be472df636bcf73aee.1619104091.git.matheus.bernardino@usp.br>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4ded5b1e-5936-8a45-ea4b-ebe8bce27a0b@gmail.com>
Date:   Fri, 23 Apr 2021 15:48:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <3a0845fdbb0481ead96b15be472df636bcf73aee.1619104091.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/22/2021 11:17 AM, Matheus Tavares wrote:
> Add tests to confirm that the `struct conv_attrs` data is correctly
> passed from the main process to the workers, and that they can properly
> convert the blobs before writing them to the working tree.
> 
> Also check that parallel-ineligible entries, such as regular files that
> require external filters, are correctly smudge and written when
> parallel-checkout is enabled.
> 
> Note: to avoid repeating code, some helper functions are extracted from
> t0028 into a common lib file.

nit: this movement of helper functions could be its own patch to reduce
cognitive load when already reading a very detailed set of tests.

> diff --git a/t/t2082-parallel-checkout-attributes.sh b/t/t2082-parallel-checkout-attributes.sh
> new file mode 100755
> index 0000000000..2525457961
> --- /dev/null
> +++ b/t/t2082-parallel-checkout-attributes.sh
> @@ -0,0 +1,194 @@
> +#!/bin/sh
> +
> +test_description='parallel-checkout: attributes
> +
> +Verify that parallel-checkout correctly creates files that require
> +conversions, as specified in .gitattributes. The main point here is
> +to check that the conv_attr data is correctly sent to the workers
> +and that it contains sufficient information to smudge files
> +properly (without access to the index or attribute stack).
> +'

The tests themselves are quite dense, but definitely appear to be
doing valuable cases to cover an important feature of parallel
checkout. Each one is so different from the other that I can't
find ways to reorganize them for better readability.

Thanks,
-Stolee
 
