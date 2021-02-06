Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984FC433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 20:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3032B64E35
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 20:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBFUgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 15:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFUgF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 15:36:05 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FBC06174A
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 12:35:24 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so15916289lfb.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 12:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD+X/Ke9HW5PRGZEiM+y/zy5wU7BmG6OMsn9TYhFBCg=;
        b=KHVdneLamk3jEO7SqjLA9V7x24mF8Omgk6rztx2s7WJYUMkC4tkbjpV7Alc0kQIu69
         QebYKeZltbe6KGjT+TpVJunRVQrdc53rDmquPx4wkbzqJ28u4EdygHmOLXYWaMFSq1w+
         XS1L9yuaZK+DZHCvnC5sHYwXsNIfMNqKrrvimOPzc9kZNFncHWw0tqtjyZebvbns6eeY
         raCj9LFItTQvgCgr6qsER7fzalcOTZOV+3LjwIy8AzdLxi1tIaZ0E/j9+O2AFbzZWNyh
         eVByfS99Jt0b5YKREjDvnNaqxtNBPsDchbqm6V82WK7v5TeCK/5FtGEIaX5TAQRBIiWm
         aomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD+X/Ke9HW5PRGZEiM+y/zy5wU7BmG6OMsn9TYhFBCg=;
        b=GZtRXXSn0U0YwGIfK9mWQxyeFFjck5MDXvmPtE9ow62VzM7Z8Ry/DFI4yN3kI/ZkiY
         JlNKcZSXSVW/1yc+f01oHHMSXtFUxTgsCbkkkt5/0rAWC60Y38bUUxi73EKF9Jdsg+RF
         d0m6KgrUdLWOQJnbIK6Zv4QoFhIa8KynMNz76yVDnwE1hG2lwjk5W5aCB6N5nlYn7dT7
         2bJiceq63PhTcbO/h7bBErQltbhKqUYDswI1qDLJTllYS1smITrocCHChfDo8dRrY+cN
         AHy0CgzXQBfiyGOCVnx2JBSBSZmNoEO0Su4F0YMsr17O1RJ0WqmkIUqX1pySKQ09Niz3
         ZYBw==
X-Gm-Message-State: AOAM5301YRE0Kf8PytznM7unnYDFsu1LV2zp0Rrbk41dOVjDwpreQi41
        vmVyTgW8f3N+IlMO2R+I07LQLjSQpDQNXLN7+2U=
X-Google-Smtp-Source: ABdhPJwFAV+dnHG+86KLAzgF23iS0s4X39+ywzXtjZxnbPIeb8jX5HA+inxAsIkLakUsSbAUCMGaUOym/ApJjzW4Zhc=
X-Received: by 2002:a05:6512:398a:: with SMTP id j10mr5880642lfu.167.1612643722689;
 Sat, 06 Feb 2021 12:35:22 -0800 (PST)
MIME-Version: 1.0
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com> <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
 <xmqq8s834c4s.fsf@gitster.c.googlers.com> <CAPx1GvcNTkXo-6rdaRc4YNGAq8AoCtwT86AEUT+A6c22erVW0g@mail.gmail.com>
 <xmqqwnvmz1pv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnvmz1pv.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sat, 6 Feb 2021 12:35:10 -0800
Message-ID: <CAPx1Gvfc9ryYSLJkfej+ryZdbtOtT==EDXpFeSZCBC6=RV6U4w@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        szeder.dev@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 5, 2021 at 12:41 PM Junio C Hamano <gitster@pobox.com> wrote:
> Chris Torek <chris.torek@gmail.com> writes:
> > There are (still) systems with 32-bit size_t (but 64-bit
> > off_t / file sizes), so ... probably not.  Is size_t ever more than
> > 64 bits these days?
>
> Sorry, you lost me.  I do not see how it would help to perform the
> multiplication in uint64_t, when you suspect that size_t is too
> small, if the final destination of the result of the multiplication
> is a function argument of type size_t?

No, you and Derrick Stolee are right, I wasn't looking out far enough
here (to the actual function).

(I was wondering though if there are systems where the valid range
for size_t could exceed that for off_t.  Are there still systems
using 32-bit off_t?  Sometimes I think there are too many abstracted
types running around here -- how do we know which sizes are big
enough?  There is always uintmax_t, though, and for unsigned
types, ((T)-1) gets you the maximum possible value.)

Chris
