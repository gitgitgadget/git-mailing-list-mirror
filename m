Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D0C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D31364E07
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 19:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhCPTfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 15:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhCPTfW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 15:35:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E06C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:35:22 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x10so36508255qkm.8
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ElayqXyB7OtWN8F1hw0GLOxloUXi9fCyPYddz4PGWZo=;
        b=L/HAhKfby8jHSUMsx1XHMTRRk0sPpy749S/d4dyuXrsyBlRkC7mwjj19mI/r2SZcN9
         nGwuRTVoWWDcNuJZDgO8rYhRUu4qAHQmkbztRuQPjASvqIisFSpJDGp6Tbekbao66v3x
         7oFh7JfI82nIyI7n/yJvuPXCpGGtBrnmVk8mbrSORiSRRPeJgDOE2EiD6CmcBDtIHiOo
         IqTGVfR+1OAfPr/XEPj8OJDpDMBroDEigW8JGU5zROTVGimCWaD3OetjLTmg+pnYo4V1
         bPbG6dLEVXXWhA+0YmuGxSQm1RHu36fpYUj1I9WnziuBUT8atvJEELI8joiakBT5lru7
         924w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ElayqXyB7OtWN8F1hw0GLOxloUXi9fCyPYddz4PGWZo=;
        b=bEvVEzzhL3ZSgQp+VvSAXLKDA+2OyG7S9amZD+3L7DbNstz6EBxWJ21vdnmS0hX4fY
         e9LtizqnbEOQox049XXbPNXeYhrdpVMWBRqF/U9M15QU1vxOMGBsZW6ZhrZ2l51Rj6X3
         iPAIKn2XsZ/1fVjXdqvV67we293L7ePegK1xODUhwkS7mz3F6wJooeTsfiKWZpteH9VM
         6c0SwSUEoWfRl0plY2iUhkaPIMlIo0eP6eBA0xtHD+t8yDDytV/54yPfLWxRQp7DMPKF
         r9N2ORpuavAX1QoBHPH9dJhUt82Z+DZZ25jeEekutmGFKH13jT79U7R1eL2f1tikzRW3
         w9Uw==
X-Gm-Message-State: AOAM532NiLHkGHrPatLY3A8oYw/udHLP+UKkZidL7dqfdBI8uss6LjZk
        1dDkV0R5FkNcj/yEYWrxNvc=
X-Google-Smtp-Source: ABdhPJwn0By16H4N6GsIAWir8rIW8qtodxdvLyXDJIQnfvNVlIIl05RKRxGWDuRX/0p5yb4wT7NrOg==
X-Received: by 2002:a37:9c51:: with SMTP id f78mr694810qke.228.1615923321410;
        Tue, 16 Mar 2021 12:35:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:fcd1:da21:8108:69bc? ([2600:1700:e72:80a0:fcd1:da21:8108:69bc])
        by smtp.gmail.com with ESMTPSA id w78sm15866873qkb.11.2021.03.16.12.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 12:35:20 -0700 (PDT)
Subject: Re: [PATCH v4 00/22] fsck: API improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-1-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b561cdc4-7dad-d923-5403-40f898c577e0@gmail.com>
Date:   Tue, 16 Mar 2021 15:35:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210316161738.30254-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/16/2021 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
> A re-send of a rebased v3, which I sent at:
> http://lore.kernel.org/git/20210306110439.27694-1-avarab@gmail.com as
> seen in the range-diff there are no changes since v3. I'm just sending
> this as a post-release bump of this, per
> https://lore.kernel.org/git/xmqqy2etczqi.fsf@gitster.g/
> 
> Ævar Arnfjörð Bjarmason (22):
>   fsck.h: update FSCK_OPTIONS_* for object_name
>   fsck.h: use designed initializers for FSCK_OPTIONS_{DEFAULT,STRICT}
>   fsck.h: reduce duplication between FSCK_OPTIONS_{DEFAULT,STRICT}
>   fsck.h: add a FSCK_OPTIONS_COMMON_ERROR_FUNC macro
>   fsck.h: indent arguments to of fsck_set_msg_type
>   fsck.h: use "enum object_type" instead of "int"
>   fsck.c: rename variables in fsck_set_msg_type() for less confusion
>   fsck.c: move definition of msg_id into append_msg_id()
>   fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
>   fsck.c: refactor fsck_msg_type() to limit scope of "int msg_type"
>   fsck.h: move FSCK_{FATAL,INFO,ERROR,WARN,IGNORE} into an enum
>   fsck.h: re-order and re-assign "enum fsck_msg_type"
>   fsck.c: call parse_msg_type() early in fsck_set_msg_type()
>   fsck.c: undefine temporary STR macro after use
>   fsck.c: give "FOREACH_MSG_ID" a more specific name
>   fsck.[ch]: move FOREACH_FSCK_MSG_ID & fsck_msg_id from *.c to *.h
>   fsck.c: pass along the fsck_msg_id in the fsck_error callback
>   fsck.c: add an fsck_set_msg_type() API that takes enums
>   fsck.c: move gitmodules_{found,done} into fsck_options
>   fetch-pack: don't needlessly copy fsck_options
>   fetch-pack: use file-scope static struct for fsck_options
>   fetch-pack: use new fsck API to printing dangling submodules

This series is carefully organized and motivated. It was quite
easy to read.

My complaints were minor. One was that patches 1-4 seemed to be
unnecessarily granular. I'm not sure that having four patches
like that will be more helpful for inspecting the history in
the future. But, I don't care enough to say this should be
re-rolled.

Finally, the last issue is that fsck-cb.c is loosely justified
with only one method inside. If you have plans in the near
future to add similar methods there, then I think that is fine.
Otherwise, it would be simpler to avoid the extra file and
code move.

Thanks,
-Stolee
