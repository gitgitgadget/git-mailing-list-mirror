Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD197EDE980
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 05:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjINFbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 01:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjINFbq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 01:31:46 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3B8E
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 22:31:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d8109d3a3bbso756383276.2
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 22:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694669502; x=1695274302; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgtM2iEj1JZVmrI/fLCaxNEBlYBycUf6jMhldLUJBjA=;
        b=tuegZYdo9QlKfE9FD67Oz+FuoUKboZTB6b1oYQ13dnyLmjiI4b6FE/5ogTP5Up27K5
         UzqlH1rhhLRfAnlqPPTCyiq7NrTAiz1Id0muRwUXy8Yt8CccLn42nx6b42lg3EM3aptG
         xotYNhf18t8NbcVr39qN6Nl1ioA7vxNs4rftWNDbc6SOuU4GctL4jkip+R/OudbbDM0L
         cZImmnRTnNzT40bgDRz+CUPsHwU0zjBjbXhXJ3Syb2u++N/Brws9TxAckmoEERJnqKBt
         cBib1emtR40louJTOG0wEo30va7t+zPwdx84228CH/zqG2Baq6+cUbMnO2MxmpD1q/bF
         5+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694669502; x=1695274302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgtM2iEj1JZVmrI/fLCaxNEBlYBycUf6jMhldLUJBjA=;
        b=pXW8vT1MgfKfdMiNtj4HGgcGXsFyOk4rmm1WYrJUr4GxCsXqxuWQ/XoncimfIPke8S
         xym2g1K6KN+Ig7+EVzUsQlIy5YqwHjcfhFelYWJ6OrasVlgAcPiZvPXjJmwH28z33+TG
         k7TYpuHKT5rRKVg9BafkaW4KsFEnpvIMLC5Ij/y/ttzMIVP3BOtT5L2tPA2JItfBgmAJ
         jMipuWMQfUoqKvivVEHHV85fH5BOT3g12Lw3e2dJMals0vAjYCj2LyYRxeKEHCG4gtU5
         1axKXNv1kCg4VB8ZX3ehyFoQHEgVxWZqr+s+NTshEa+rtKFvdwXWKJRSWqnN4rOA6SW2
         TCog==
X-Gm-Message-State: AOJu0YzX+khncIoozdZvJfq6Q595pcuhD8KD+a7bmUq0uiJm+2jM96RY
        HvDbBHKRRzOfggsPMxSML8sDCziFZAM=
X-Google-Smtp-Source: AGHT+IF+HdMvVy+OfCTsUigGFreLqWGWXeoaK+uRQzXnCbZ31AjkYz/VwYPZ37BITK6WoL9pGk0uo3NgCm4=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:cb06:0:b0:d7b:9830:c172 with SMTP id
 b6-20020a25cb06000000b00d7b9830c172mr111940ybg.0.1694669501981; Wed, 13 Sep
 2023 22:31:41 -0700 (PDT)
Date:   Wed, 13 Sep 2023 22:31:40 -0700
In-Reply-To: <xmqq5y4dla6p.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com> <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
 <xmqqv8cgvd02.fsf@gitster.g> <owly34zhlcoa.fsf@fine.c.googlers.com> <xmqq5y4dla6p.fsf@gitster.g>
Message-ID: <owlyttrxjp6r.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 4/6] trailer: teach find_patch_start about --no-divider
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Linus Arver <linusa@google.com> writes:
>
>>> The real purpose of this function is to find the end of the log
>>> message, isn't it?
>>
>> Indeed.
>> ...
>> Right! So a better name might be something like
>> "find_trailer_search_boundary" with a comment like
>
> Or "find_end_of_log_message()", which we agreed to be the real
> purpose of this function ;-)

I did this locally, but in doing so realized that we have in trailer.c

    /* Return the position of the end of the trailers. */
    static size_t find_trailer_end(const char *buf, size_t len)
    {
        return len - ignore_non_trailer(buf, len);
    }

and the ignore_non_trailer() comes from commit.c, which says

    /*
    * Inspect the given string and determine the true "end" of the log message, in
    * order to find where to put a new Signed-off-by trailer.  Ignored are
    * trailing comment lines and blank lines.  To support "git commit -s
    * --amend" on an existing commit, we also ignore "Conflicts:".  To
    * support "git commit -v", we truncate at cut lines.
    *
    * Returns the number of bytes from the tail to ignore, to be fed as
    * the second parameter to append_signoff().
    */
    size_t ignore_non_trailer(const char *buf, size_t len)
    {

...and I am not so sure the new "find_end_of_log_message" name for
find_patch_start() is desirable because of the overlap in meaning with
the comment for ignore_non_trailer(). To recap, we have in
trailer_info_get() in trailer.c which (without this patch) has

    if (opts->no_divider)
        patch_start = strlen(str);
    else
        patch_start = find_patch_start(str);

    trailer_end = find_trailer_end(str, patch_start);
    trailer_start = find_trailer_start(str, trailer_end);
                
to find the trailer_end and trailer_start positions in the input. These
positions are the boundaries for parsing for actual trailers (if any).
More precisely, the "patch_start" variable helps us _skip_ the "patch
part" of the input (if any, denoted by "---"). The call to
find_trailer_end() helps us (again) _skip_ any parts that are not part
of the actual log message (per the comment in ignore_non_trailer()). So
as far as trailer_info_get() is concerned, we are just trying to skip
over areas where we shouldn't search/parse for trailers.

The above analysis leads me to some new ideas:

(1) For "find_end_of_log_message()", I think this name should really
    belong to ignore_non_trailer() in commit.c instead of
    find_patch_start() in trailer.c. The existing comment for
    ignore_non_trailer() already says that its job is to determine the
    true end of the log message (and does a lot of the necessary work to
    do this job).

(2) find_patch_start() should be named something like
    "shrink_trailer_search_space" (although this meaning belongs equally
    well to find_trailer_end()), because the point is to reduce the
    search space for parsing trailers.

(3) "find_trailer_end" is not a great function name because on first
    glance it implies that it found the end of trailers, but this is
    only true for the "happy path" of actually finding trailers.

I need to consider all of the above ideas and reroll this patch. Because
the ideas here closely relate to the "trailer_end" and "trailer_start"
variables, I will probably reorder the series so that this patch and the
last patch are closer together.
