Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A625AC433E6
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5768764EE7
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 15:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhBZP4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 10:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhBZP4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 10:56:40 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBB3C061574
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:55:59 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id a13so10208247oid.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 07:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ezYtGjYSQRQzjJ/gOkjmJYp1TeoZciEgivAEYuWiCdo=;
        b=drGg+OeNadQ/H1K9urdkSKg1GwYU94t8V36JrsQo6OXJnWFakuXUiqMhF0aib/UHnI
         zAuns1YGOvhMUqbmb05tjZZeVqcA2LHbDf+Qqd7wbMRz1YdleAYnFfkiAr3CVbtrgrjt
         lheWJ3tvVnFpm/9+95ttd4DLIHRhr9g9PvLccR0gQBkZDdeq4fhsf+NuP6PoERF3cgtS
         E1NvyfEMCK10aCTE+1MtBEFU/Ctet70DE2Hw6pLRZmBB3hJE65asP/aHwwKdNF748E5M
         Mnx2D/2LRhJNRD6pQ9pFTXXo44lCCs7r5k6lhydUfMMzP2XKW7p5lJPJFzCZcmfZsMcC
         dXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ezYtGjYSQRQzjJ/gOkjmJYp1TeoZciEgivAEYuWiCdo=;
        b=so2z0T0fphVI1JTZQ0BNeEBJ0Hp7Qvc3rCdiaL6jGf3tsx5XSZRDVNplbrvcB5gnsp
         9RSI4G3IRnGdVwhVUVsC9xCniLGE/f+dT87ZwFp5k+9cliiLChNmLnM0MtEsghJGuGVv
         vt3jjfTp+IOdLbZeiwju14myb+Vj3bN+OJraUpf3u/oQQkcWUwmW7D0mR17xFJbzi3V+
         iM95Bfqt2rHlYwGCxre3htQQ3ACKYVpLdEz9cBo4L28zzFYZDEk2wnUDGLSGHQpUvZxg
         MeCOD/aToI85V0TEwHUIIHloGsOWWbz7IMlHdk9pVg5enlG2431zNLjQgY+K+DvpguiC
         if/w==
X-Gm-Message-State: AOAM532gar7HtypGRSiFE5S6AqgkZ0TXfP9XqsHV3+biZt8HmsRilqI/
        lH564fTwK23xoitK5h/N3AhUiRXrMuVKWA==
X-Google-Smtp-Source: ABdhPJzzt13OWrT238JePKnUQWgjmI6vHDo4WnrIS1lfNi4kHesht5PZSHC4c0eZKLiAaUjcGJ1GLA==
X-Received: by 2002:a05:6808:687:: with SMTP id k7mr2435240oig.82.1614354959125;
        Fri, 26 Feb 2021 07:55:59 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:8d21:2da6:2067:31cb? ([2600:1700:e72:80a0:8d21:2da6:2067:31cb])
        by smtp.gmail.com with UTF8SMTPSA id g18sm1875766otq.33.2021.02.26.07.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 07:55:58 -0800 (PST)
Message-ID: <7cdfa81a-d088-f91d-c78d-6f1d957ec8b2@gmail.com>
Date:   Fri, 26 Feb 2021 10:55:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: [PATCH v3 04/10] Move computation of dir_rename_count from
 merge-ort to diffcore-rename
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.844.v2.git.1614123848.gitgitgadget@gmail.com>
 <pull.844.v3.git.1614304699.gitgitgadget@gmail.com>
 <9b9d5b207b034ec4181020e0bf3ac46561f55b28.1614304700.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <9b9d5b207b034ec4181020e0bf3ac46561f55b28.1614304700.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/25/2021 8:58 PM, Elijah Newren via GitGitGadget wrote:
> +	for (i = 0; i < rename_dst_nr; ++i) {
> +		/* File not part of directory rename counts if not a rename */
> +		if (!rename_dst[i].is_rename)
> +			continue;
> +
...
> -		/* File not part of directory rename if it wasn't renamed */
> -		if (pair->status != 'R')
> -			continue;
> -
Thanks for updating to include this check!

-Stolee
