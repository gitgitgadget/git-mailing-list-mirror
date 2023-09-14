Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107FEE0213
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 02:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjINCTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 22:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjINCTH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 22:19:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D99CA
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 19:19:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-597f461adc5so6856667b3.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 19:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694657942; x=1695262742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZRGJ/YsrX3V6b/Seso24LD/93uW6oawXuja4oB6JfM=;
        b=2qkN1DrHwrz+XCw6Y+6l//8OjH7VmCqX06tz0ohlT9N1p/g1/J7xQa001/b18yDPad
         tUbPLrHBFScRXvvjaUS2kanI2UA84S3n5VXzJmSMp7bRPTcbf42U9QBJiy/y32QW2Bvy
         BP6KDQ036/p1rw7/zLiqiAlu3B2EeoGt9mrTJ+Y2HITYInGJwI/ZwWREkL+1tAs0KMh8
         M1u4oWKYUmfNGx8FC87lonf/lkOcVTDhlHSvdCmDSm/AEBK9nQ5Uz7aLlVfdOXLg1zk/
         St71Gy42udhMApKsalru69ZHmQ63JBto+Ak+N/H5umoPqNOdZ0nDK7r4102v4syUE5Sy
         072w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694657942; x=1695262742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZRGJ/YsrX3V6b/Seso24LD/93uW6oawXuja4oB6JfM=;
        b=K8kpQ24qsXK48aiFitffVvnnK/+EDwSXBzl/2YBdoJwhY6lhjOmUQGuLYh2BVG5mNt
         BKZc/VXTgUyR0pWm7TZG3dZ3WxWO0213KE65QJaaJ5bvVJOFP8duxvR2E0XMrSs82S0C
         6iDRsEE6ygNTt6BRmqswBES+l/pdURQswKrq6uE66X7iAIfSF8cpu6/SV/7zplS7pmiN
         U7q8PFmuaP2lTPFpqAXeLsgWLWvBMUCNHpIcTa8WCEUXECy/9KX9G3L+dXyw+qxAE6Q+
         7FL+xZuhgfr4wLnIa+5Vk0ZmtBcVGO0aIaG+kJ/rRVWwFWldG23jEllX2Irmf6V6IfAL
         KNCA==
X-Gm-Message-State: AOJu0YzyvMEdsyVhquP9gfhkeZSdxUbCCx++l8husr6new7XwpTyVYa9
        7XmVFiAd0NavfZ9kGUJ7691s4Nif+5g=
X-Google-Smtp-Source: AGHT+IFAYIbIl82R0AHTs5dy7QK7S6moT8ncNSuEJ2kd9RZc1AkP6Ifxs6sjkQ1x/hfmJtkFgExqObidLl4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:e0c4:0:b0:d7b:a1ad:3e57 with SMTP id
 x187-20020a25e0c4000000b00d7ba1ad3e57mr96861ybg.4.1694657942344; Wed, 13 Sep
 2023 19:19:02 -0700 (PDT)
Date:   Wed, 13 Sep 2023 19:19:01 -0700
In-Reply-To: <xmqqv8cgvd02.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
 <xmqqv8cgvd02.fsf@gitster.g>
Message-ID: <owly34zhlcoa.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 4/6] trailer: teach find_patch_start about --no-divider
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Linus Arver <linusa@google.com>
>>
>> Currently, find_patch_start only finds the start of the patch part of
>> the input (by looking at the "---" divider) for cases where the
>> "--no-divider" flag has not been provided. If the user provides this
>> flag, we do not rely on find_patch_start at all and just call strlen()
>> directly on the input.
>>
>> Instead, make find_patch_start aware of "--no-divider" and make it
>> handle that case as well. This means we no longer need to call strlen at
>> all and can just rely on the existing code in find_patch_start. By
>> forcing callers to consider this important option, we avoid the kind of
>> mistake described in be3d654343 (commit: pass --no-divider to
>> interpret-trailers, 2023-06-17).
>
> OK.  The code pays attention to "---" so making it stop doing so
> when the "--no-*" option is given will make the function responsible
> for finding the beginning of the patch.
>
> I wonder if we should rename this function while we are at it,
> though.  When "--no-divider" is given, the expected use case is
> *not* to have a patch at all, and it is dubious that a function
> whose name is find_patch_start() can possibly do anything useful.

IOW, saying as the caller of this function, "find the patch start in
this input I'm giving you, but also FYI the input has no patch in it"
sounds wrong. Agreed.

> The real purpose of this function is to find the end of the log
> message, isn't it?

Indeed.

> And the caller uses the end of the log message
> it found and gives it to find_trailer_start() and find_trailer_end()
> as the upper boundary of the search for the trailer block.

Right! So a better name might be something like
"find_trailer_search_boundary" with a comment like

    Find the point at which we should stop searching for trailers (to
    parse them). This is either the end of the input string (obviously),
    or the point when we see "---" indicating the start of the "patch
    part".

Will update.
