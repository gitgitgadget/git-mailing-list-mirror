Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE45C433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3D5224BD
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbhAKLoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbhAKLoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jan 2021 06:44:06 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E79C061786
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:43:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d14so14222116qkc.13
        for <git@vger.kernel.org>; Mon, 11 Jan 2021 03:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9davMi1givQ0f3hT/gnWd+hDKSFWcKTh4ae1QQxNQGM=;
        b=ikvWelcFd3W5tXp3YobwYq9Xw81xeGwUXGEzj1J9kLuZjSz7655fmAad1UHf5aYfoa
         mWJsd/00izwnxNJgFZk/xNCun7pJgk7Rn0y6C6iDbFXRN16QVkNaC4WRnlUTMA06xIy+
         0fOEQ3yTMAUp/qbHAuH8SEJ2NlANuOjZP8VfEiEAiru0o3g2SYPi3iGsrMid6JKcnmhl
         sOq8f5+7syQRncsDUl76qcD77mxBBWkqQW3YOPbmaxyonmX3zE8u4d7qKdfm1PjqjrgG
         mMuQcJcMM7gc1qHdYkf2njCSDEOEatEY9Wb4DbO+ZKoJT2iympBq/0Lmsw0gDJrLZSSG
         kQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9davMi1givQ0f3hT/gnWd+hDKSFWcKTh4ae1QQxNQGM=;
        b=b/Ex93g4sQlPjpTWY1xtnC7h873CX72dytTIdtTqQlQ8b/BFiy7oWeR2YaGLertsD5
         IMd0Yp2NaaIRe4nsF0anxKrJiCfxBJkQFg4K5cdSeRhqO4G319EgTKaTFVae+V7iLKGy
         7dVBHJ01j4AM5g19cJI7ktcXCNg+Hip4aK09QjiODxRiqwoXhebSIQbcMRkUiCWOn5Ub
         9bwWuQmZAfiK7ih/Ji4t2J9oXsc6Ks4LuHCJyJZOW4rGtcUJ+qRajX1Y/pfXk7wCeloB
         4EJmdd8BYfPtMH4X75aPHK17MPJAplRqCr/73otXveHp4LXAurco/0R7zrQDtkzmrJwD
         naYA==
X-Gm-Message-State: AOAM5334vDkWO4Wm4bmLDyoB7TW49PZUjiZhUydWCRxwJwtcu4lIsT3m
        vva4TM3qBLwYKPLVHVhiHS3LnTyByCU=
X-Google-Smtp-Source: ABdhPJxVdUT+AFH8pG4P+nmjo45qhNaRyrOPw5uy4QZmtxY7bTdcnt5M99V7cIAsdfFICqkqbFx3vA==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr15599624qkv.229.1610365405118;
        Mon, 11 Jan 2021 03:43:25 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id d3sm8431246qka.36.2021.01.11.03.43.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 03:43:24 -0800 (PST)
Subject: Re: [PATCH 05/20] check_object(): convert to new revindex API
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com
References: <cover.1610129796.git.me@ttaylorr.com>
 <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b1a6110a-a097-931f-5710-92a1f59a842b@gmail.com>
Date:   Mon, 11 Jan 2021 06:43:23 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <c47e77a30eb40d9841a60a28b620671860dc2461.1610129796.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2021 1:17 PM, Taylor Blau wrote:
> Replace direct accesses to the revindex with calls to
> 'offset_to_pack_pos()' and 'pack_pos_to_index()'.
> 
> Since this caller already had some error checking (it can jump to the
> 'give_up' label if it encounters an error), we can easily check whether
> or not the provided offset points to an object in the given pack. This
> error checking existed prior to this patch, too, since the caller checks
> whether the return value from 'find_pack_revindex()' was NULL or not.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 4341bc27b4..a193cdaf2f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1813,11 +1813,11 @@ static void check_object(struct object_entry *entry, uint32_t object_index)
>  				goto give_up;
>  			}
>  			if (reuse_delta && !entry->preferred_base) {
> -				struct revindex_entry *revidx;
> -				revidx = find_pack_revindex(p, ofs);
> -				if (!revidx)
> +				uint32_t pos;
> +				if (offset_to_pack_pos(p, ofs, &pos) < 0)

The current implementation does not return a positive value. Only
-1 on error and 0 on success. Is this "< 0" doing anything important?
Seems like it would be easiest to do

	if (offset_to_pack_pos(p, ofs, &pos))

>  					goto give_up;
> -				if (!nth_packed_object_id(&base_ref, p, revidx->nr))
> +				if (!nth_packed_object_id(&base_ref, p,
> +							  pack_pos_to_index(p, pos)))
>  					have_base = 1;
>  			}

Thanks,
-Stolee
