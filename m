Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35A1EE0203
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 01:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjINBVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 21:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjINBVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 21:21:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1301724
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 18:21:21 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-26f49625bffso386804a91.1
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694654481; x=1695259281; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8nEDPxA1XHMWKhe0hwpi/tPJEhMUYHDx7lnDO3e/TCA=;
        b=CL1KwQ95Ob2wD1ACX4z327h11HtdZ+f+DsbwFgHyaxhD7Um74ZVrjSPb1rKiS2E1lX
         s5Jh3+WLCLegASItHU2OyUspCjShK1h4axsbtOdZSkI3nOYwvDrHSJXcW74Owf0BZu5A
         LEgE4GAy39SZqh1uoRwLHJbftABGfCXYtuu8qnmolOFd34Xg+Yc06f2AIdHnKFIIOpID
         Da2dnYqwu3yZOhXd5Qvvt76yL7JHSGIqY20XrUxO5pAs/BSloTZLRSIEPyIvF5OrpO1s
         MvTk2r8dLB1gKMXwzMq5G9sQ8YJBe/1wGRFFX8lzNUlFkCFf7YJo284uGbLfuBtnAYY4
         OuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694654481; x=1695259281;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8nEDPxA1XHMWKhe0hwpi/tPJEhMUYHDx7lnDO3e/TCA=;
        b=mLKx8Jmau8rxNbPlCXkg057ZNzoj3Zld4FgtHDD6LmIUGU7D9iV0wtfMP+jS169ArL
         1Mqzp1O2aKE+JqVbjWAwxfrk7PYWX1Am52cyfPWpMVFxFYzAfwcT9jQauDvNs0A7z1LK
         VDjtEnC0C30yhyZ6W/u83kLYZh/mJEWk26Xu1BZr8qkoESa2lpAp8cRagx9a+UYK8tc0
         iL12GM3GXtmWHhC7MfrxXS9fS2EHf5POTDUD9UYHUxSHvbuhkDpDoun3DbZ8Q/+jYWfI
         ysjymCzkcznW07CZgHxg0ER3hK+kuFRahwQtvlx5EvLUNvGZJEjU1cU2EAYUainoG6m6
         yR2A==
X-Gm-Message-State: AOJu0YyOPUtuCXifUCQf8O40exU7lSOwJKVeWz4qx++Wxbza08WYbWkK
        QoZaCka1CGZeDE4JyObpokNAtddFgAo=
X-Google-Smtp-Source: AGHT+IE/iV9zEVPBA8gu+46Qf+CJCZ5lEimaKTDenI8EqLlW0g+Zpl59YMcvck5QM97BiM8RyHwZmjSzP/U=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:90b:110a:b0:268:2de3:e6b2 with SMTP id
 gi10-20020a17090b110a00b002682de3e6b2mr102305pjb.5.1694654480941; Wed, 13 Sep
 2023 18:21:20 -0700 (PDT)
Date:   Wed, 13 Sep 2023 18:21:19 -0700
In-Reply-To: <xmqqmsxsv8ik.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <0463066ebe0889b72b6a1f6c344f2de127458391.1694240177.git.gitgitgadget@gmail.com>
 <xmqqmsxsv8ik.fsf@gitster.g>
Message-ID: <owly5y4dlfcg.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 6/6] trailer: use offsets for trailer_start/trailer_end
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
>> Previously these fields in the trailer_info struct were of type "const
>> char *" and pointed to positions in the input string directly (to the
>> start and end positions of the trailer block).
>>
>> Use offsets to make the intended usage less ambiguous. We only need to
>> reference the input string in format_trailer_info(), so update that
>> function to take a pointer to the input.
>
> Hmm, I am not sure if this is an improvement.  If the underlying
> buffer can be reallocated (to grow), the approach to use the offsets
> certainly is easier to deal with, as they will stay valid even after
> such a reallocation.  But you lose the obvious sentinel value NULL
> that can mean something special

True.

> and have to make the readers aware
> of the local convention you happened to have picked with a comment
> like ...
>
>> Signed-off-by: Linus Arver <linusa@google.com>
>> ---
>>  trailer.c | 17 ++++++++---------
>>  trailer.h |  7 +++----
>>  2 files changed, 11 insertions(+), 13 deletions(-)
>> ...
>>  	/*
>> -	 * Pointers to the start and end of the trailer block found. If there
>> -	 * is no trailer block found, these 2 pointers point to the end of the
>> -	 * input string.
>> +	 * Offsets to the trailer block start and end positions in the input
>> +	 * string. If no trailer block is found, these are set to 0.
>>  	 */
>
> ... this, simply because there is no obvious sentinel value for an
> unsigned integral type; even if you count MAX_ULONG and its friends,
> they are not as obvious as NULL for pointer types.

I agree that there is no trustworthy sentinel value for an unsigned
integral type.

On the other hand, we never used NULL as a sentinel value before even
when they were const char pointers --- the current comment for these
fields which say ...

    If there is no trailer block found, these 2 pointers point to the end of the
    input string.

... sounds somewhat arbitrary to me (and I don't think we care about
this property in trailer.c, and AFAICS it's also not something that
consumers should be aware of). Consumers of the trailer_info struct
could also just see if "info->trailer_nr > 0" to check whether any
trailers were found, although if we're merging Patch 1 [1] of this
series the consumers will not have easy access any more to any of the
trailer_info fields, and they should instead be using a public-facing
function that does the "were trailers found" check.

> So, I dunno.

If the "we don't use NULL sentinel values currently anyway" argument is
convincing enough, I'm happy to add this to the commit message on a
reroll. But I'm also OK with dropping this patch. Thoughts?

[1] https://lore.kernel.org/git/pull.1563.git.1691211879.gitgitgadget@gmail.com/T/#m8f1b5f1eb346331658c8c7b3e057a4ee31223664
