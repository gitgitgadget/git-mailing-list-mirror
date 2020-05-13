Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA02C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D785205ED
	for <git@archiver.kernel.org>; Wed, 13 May 2020 19:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtWniCwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387907AbgEMT6A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 15:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733135AbgEMT6A (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 15:58:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6EC061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:58:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id 59so516495qva.13
        for <git@vger.kernel.org>; Wed, 13 May 2020 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sxbMndxFZThByosgbFHYDuDZAkCwsBH31gx/lvjHWrw=;
        b=YtWniCwofVM90YOKRiKgx/VkNPu7XlbuKvztjDfEYfeoKcyf58Q8iseNF1FP70p5PQ
         f29SgV1LssOImWGtHFQ9zkyidXlakIO5OznrZ09EkOAuvSgMZWABkWl0ImsdFTXh7MBz
         ayh+Z6elRnAOhEvk1LKssyqg8sl+sZ3BkzQOZoSrD+ck5HR849zfhgKBBouhTMARaBFP
         cLczw9Y8OrhYicMRUcRcYHug9OCnhD6+VZIgmRktc9+8j90ccdhNAgwtpZJaBQnOTEkM
         cH7vFLo1z5LgPdp7rGiZyHIye0P9Hnbb9C7Y5nINnYkCg+PytwWuLp9V4hN4WQ0tTMal
         5aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sxbMndxFZThByosgbFHYDuDZAkCwsBH31gx/lvjHWrw=;
        b=UuqDjRsOn8MJk6vKET/BR+winG97QDo7q/BjQnCJ7qiN/y1RBrv0zdcQFGxRxamwYL
         rogFVXaITucvO3aAwqT0keHCcaTKSHrhqEFwuVt2h6OXCvGJn3US/aXQtsk08XCN3wRN
         OdB0GC39LoAJ63OF5fA/L0BjznPSWEba+P6Y9fmhEQ01p3he11cwmltYoiZh8v5UPIoD
         nlGjFU/G0efbHl+INFkTD3FJsRjpGH8/0c8XW6++ymo3oKBrJgKEyHB65Mnt+NaADNl1
         +HI4XVE2HCoobLsrd7FwMqOEcZdmAzwALs9oYnCjqLZls9wLZPajy9lAH9WUw3m/hKZJ
         tcOA==
X-Gm-Message-State: AOAM532APAkTm7Y7GDxiUK2Tb1J/2neBO37EWrf0LEF/ltno//Sp9bmw
        42G0M0YyO3gpAm/fQvm+9/lEdmTxpAYbniF+ry4=
X-Google-Smtp-Source: ABdhPJzhh4Li2SA+LDgassWesIKPfkhwyAmnVnz3KaBOvk29R/Z8UQZ8ZF8hfDOgo1BhE0H6QnzFo8TFb9CADq5TzpE=
X-Received: by 2002:a0c:a692:: with SMTP id t18mr1363983qva.56.1589399879545;
 Wed, 13 May 2020 12:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <b0a321a714a766962456e2a9e8dd7d2be349e34d.1589302255.git.gitgitgadget@gmail.com>
 <xmqqk11gc1d5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk11gc1d5.fsf@gitster.c.googlers.com>
From:   Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Date:   Thu, 14 May 2020 01:27:50 +0530
Message-ID: <CAKiG+9Uc8Kc1F3wN7AoLkBR8Uk1up5sZXpgUperhQO6NVmBRxw@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] cmake: parse the makefile for the sources.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 2:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Sibi Siddharthan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >
> > The CMake script parses the Makefile for:
> > SCRIPT_SH
> > SCRIPT_PERL
> > TEST_BUILTINS_OBJS
> > LIB_OBJS
> > BUILTIN_OBJS
> > XDIFF_OBJS
> > VCSSVN_OBJS
> >
> > By doing this we avoid duplication of text between the Makefile and
> > the CMake script.
>
> Thanks, this makes perfect sense, but it probably should have been
> done from the very beginning, without copying the huge list manually
> in the step [01/11].
>
> How robust is the "parser"?  Do we need to leave an instruction to
> Makefile writers to conform to certain style to help CMake users as
> an additional comment in the Makefile, or is any reasonable textual
> drift still accepted?
>

The parser just uses a regex capture like this "SCRIPT_SH += (.*)".
If the current source/script definition in the Makefile is continued
things will be fine.

On a side note, why are we using SCRIPT_SH and SCRIPT_LIB separately?
Can't we combine them into one? If we can then I can also add it to
the list above.

Thank You,
Sibi Siddharthan
