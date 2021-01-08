Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BB8C433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FB4235DD
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 07:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbhAHHsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 02:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAHHsL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 02:48:11 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8089EC0612F5
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 23:47:30 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw4so13212417ejb.12
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 23:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:user-agent:from:to:cc:subject:message-id:in-reply-to
         :date:mime-version;
        bh=/6mbBVxeuQ3affl6CqYpBoxyDDeQ7EE6PV0ZO/d2s0U=;
        b=ExmRhLbykbSuAgwS9xwQJjyw2VLzwxKdDCCkstYkgpUXkYr75KyQUSP6rHH+dPS6G9
         D5/32Nr268J01ud9aGiNhmUfnT/PQO/1Sfi5O1rn3nR/pXaddcJZNkOGkm9geetqLV3g
         re4GoT+TwmktGd0+KdZweANk9s792Mej7ZJa6YwVVG1BJ+t9eFY0ehy8QFOjP/o5cTu4
         2Pw+AKZo+gBeZ30g/jlioilI9B/FnBOn+E1tRRMDL+ofONTceBeRBXRQmx1uh/061d5U
         1a/UuXcVLWEWWTDnMWdwUQkwAH8hRekLQlWC/dvzpStMf6A3kB66TkLkohbJJx2LCRnG
         mgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :message-id:in-reply-to:date:mime-version;
        bh=/6mbBVxeuQ3affl6CqYpBoxyDDeQ7EE6PV0ZO/d2s0U=;
        b=gS866TMfbo7j7tbZ6kKmBKjVpZ3PEdrwbr8LzvRsiH4aVnf4yLq7vGxfp+N6Vu74Cb
         SMCzAMPoF/ns0HkeoVwjfvVlSPsiM3sTyMJILSgw0ccYu4iq3VPKRAUY1+ItBcibcymG
         ZqNKcgO8CoE9x8/OBAnvrLdebBHKddWB6++IM7EtjbJMUDL4mx00X0sIyAmx6VijHoog
         J1+x+Sn/xTNrWXz++zSbJx6vLW2VSoh1Vye+I6gSzaJPfMxWSRjwFEEp9EwIgo4NZ4AE
         3oRGV6TNv1bU3OZgrx+AOCo5qadGgYTxnVzPUUfylJTRiPp25x83MsNULXv1E5DUnVur
         88Hg==
X-Gm-Message-State: AOAM533CYy0zX56+OG94O8PsBnTsroqgg+oMJr1jY9x08UwtfWTE9D6g
        YTdR9EoV/1a10eknHAu9uaWgZ7gEZW/NBg==
X-Google-Smtp-Source: ABdhPJzbkL9xqEGP34MPdZHQXJ35sCCXUkZeD9PEnBZAniN2fiieAWeMnzjnQi3wSUYaIu3y5BwOBw==
X-Received: by 2002:a17:906:1d0f:: with SMTP id n15mr1785927ejh.26.1610092049320;
        Thu, 07 Jan 2021 23:47:29 -0800 (PST)
Received: from cpm12071.local ([212.86.35.64])
        by smtp.gmail.com with ESMTPSA id ga11sm3299442ejb.34.2021.01.07.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 23:47:28 -0800 (PST)
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
 <20210104162128.95281-6-rafaeloliveira.cs@gmail.com>
 <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] worktree: `list` escape lock reason in --porcelain
Message-ID: <gohp6k5z48klyu.fsf@gmail.com>
In-reply-to: <428d16e8-fdb8-a587-6a0b-39c6c50eba99@gmail.com>
Date:   Fri, 08 Jan 2021 08:47:27 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Phillip,

Thank you for reviewing the patch and the suggestions.

Phillip Wood writes:

> On 04/01/2021 16:21, Rafael Silva wrote:
>> "git worktree list" porcelain format shows one attribute per line, each
>> attribute is listed with a label and value separated by a single space.
>> If any worktree is locked, a "locked" attribute is listed followed by the
>> reason, if available, otherwise only "locked" is shown.
>> In case the lock reason contains newline characters (i.e: LF or
>> CRLF)
>> this will cause the format to break as each line should correspond to
>> one attribute. This leads to unwanted behavior, specially as the
>> porcelain is intended to be machine-readable. To address this shortcoming
>> let's teach "git worktree list" to escape any newline character before
>> outputting the locked reason for porcelain format.
>
> As the porcelain output format cannot handle worktree paths that
> contain newlines either I think it would be better to add a `-z` flag
> which uses NUL termination as we have for many other commands (diff,
> ls-files etc). This would fix the problem forever without having to
> worry about quoting each time a new field is added.
>

This is a good point and it seems to be good addition for the porcelain format.

Perhaps it make more sense to apply as separate patch though, something
that Eric Sunshine also mentioned on this message reply.

> If you really need to quote the lock reason then please use one of the
> path quoting routines (probably quote_c_style() or
> write_name_quoted()) in quote.c rather than rolling your own - the
> code below gives the same output for a string that contains the two
> characters `\` followed by `n` as it does for the single character
> `\n`. People are (hopefully) used to dequoting our path quoting and
> there are routines out there to do it (we have one git Git.pm) using a
> function in quote.c will allow them to use those routines here.
>
> Best Wishes
>
> Phillip
>

That's great, thank you for pointing this out to me. I will definitely
change this into the next revision by dropping the function written from
scratch on this patch and reuse one of the existing functions.

For what is worth, I just added the function because I didn't know about
the existing ones. So, there is no reason to add the new function.

-- 
Thanks
Rafael
