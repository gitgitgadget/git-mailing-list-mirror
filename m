Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2AEC433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 18:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343541AbiFMSpp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbiFMSpN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 14:45:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DAF18361
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:15:05 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x75so4218752qkb.12
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 08:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=36hMiWASLjlOzXag0pUAtRv7nJEDn3C571AXx8Rsoww=;
        b=I+xzQyDAboQWDDjhLjFshdH4hQ1lv0zRdmc5rbSJUWnLKtyfJxDrqfM4qmd50RNXMR
         Pvb75+lCL3sfC2CvhztICH9WMCVf0GN9G9QzBdt4uMn4B32dp2uxsdbhiFxbrgdLoAJ3
         TXrmSu02CpBGsS33hwRXkihU6X5I6CTPZS2bvxZcscV87+FK/rUK/oXdCGXd5CgeQgiu
         qRifCCIx85cvMIlH2kGEVWVYcg4OacGaNGU5ruUzboyuKzKG0eRzDz0IttAuJIFb+fEd
         2Jn11JHFBew01QD8P1iQ0CcqFWPO9HrUX+kf8hFNyrR/GEeGHSa9haD6uYwy9yBw5nhx
         J+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=36hMiWASLjlOzXag0pUAtRv7nJEDn3C571AXx8Rsoww=;
        b=NVi+ghmHcZAI6t3Cf71fK/lqLnefdcZahQla8Je+rS4vljZ0djodq5zYDwUZNECxf5
         YF6P57lNRDhqpepGFm8VxiTMLUWJ3cn+VUx5K3f6QvYnMsS6zMeu10YL4g7LXhIb2D8O
         vYxTUOfkfIiQBNiM4V6SwyGPrZl4uxvMdueHc6bRqRz0SWy4CtqjE1d6P8BarSdTj/w9
         Kc8U4QG6WIk5bUQkOIqcc+hGiF5fQ/o69GxrIRfnkzHF/b11vgu0mR8dNzN02IdRfIfv
         x1mC+uvoCI/fEMslzVGzhfpqiu4fqi1WEHJeanVQm2uZHDPW7+gUcnjBoT3ZzRwi3QXI
         LgQA==
X-Gm-Message-State: AOAM530udl3RGON5gFhs3GQkuqDm53UEtY1uX6hWIE5vNi3A5XUBWSv2
        0Irp3XyAf44ECAUCN1kl5dMzYAdC053K
X-Google-Smtp-Source: ABdhPJx56yHcE2XYboPI/zskX/LVr9qKEmMubwjLr/5ClJaHwqbheSvlnSrZqwaOAYUK+hexJ3YeOg==
X-Received: by 2002:a05:620a:4311:b0:67e:8a0f:4cd5 with SMTP id u17-20020a05620a431100b0067e8a0f4cd5mr329139qko.363.1655133304260;
        Mon, 13 Jun 2022 08:15:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:170:45d1:1083:f688? ([2600:1700:e72:80a0:170:45d1:1083:f688])
        by smtp.gmail.com with ESMTPSA id d135-20020a37688d000000b006a6b0be0cfesm6453492qkc.10.2022.06.13.08.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 08:15:03 -0700 (PDT)
Message-ID: <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
Date:   Mon, 13 Jun 2022 11:15:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfskdieqz.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqfskdieqz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/9/2022 7:44 PM, Junio C Hamano wrote:

> +	struct string_list *resolve_undo = istate->resolve_undo;
> +
> +	if (!resolve_undo)
> +		return 0;
> +
> +	for_each_string_list_item(item, resolve_undo) {

I see this is necessary since for_each_string_list_item() does
not handle NULL lists. After attempting to allow it to handle
NULL lists, I see that the compiler complains about the cases
where it would _never_ be NULL, so that change appears to be
impossible.
 
The patch looks good. I liked the comments for the three phases
of the test.

Thanks,
-Stolee
