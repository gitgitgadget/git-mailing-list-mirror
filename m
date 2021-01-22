Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A88C433E0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F46023AC0
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 22:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbhAVWqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbhAVTmq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 14:42:46 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571EC061794
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:42:06 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 9so7272886oiq.3
        for <git@vger.kernel.org>; Fri, 22 Jan 2021 11:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ODOufgo/JNr0pFhtuDFLMYQQkpzuJA267cYct30kwds=;
        b=iCkmN9HC5nEbHYXSWg5DglavMtU5TlccVjfGoU2BKvXiTn+Lh3612ilUbPnsFdwN9x
         aW+nDv/1EEg1hpj3NwBnsdIFgRL06PUfe/RJU7cFIsqC8v86RiWlWrMg4+LrU1jomjFm
         WixB6JEUvVGZYa4d391BWCOiA1HMum3mKIIorQ8je97b/MKUUK8SKI6J0oKp6dQpQO8L
         jy2i08IUp7SYB231f2nEWLhqpZ1SDgoocM5ZBuHGWgOeTYGuEvYs1HsBvvF35WPADPaV
         WGjd+g1vTy1HtqBu9OGQNUQZguNpUh78eybetGnpx2t9thtWIBfa1JFceO/FwNOqNrRs
         nHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODOufgo/JNr0pFhtuDFLMYQQkpzuJA267cYct30kwds=;
        b=LZj5XamkKhjrf47BH0Fy4c3c6VF2MCKC1x12x+1lO6mWFsMLuSHhsfmb4Gae5L8avp
         bNPm0nD+nntA3ac0fg/dtg5hKOGsGJEoJD6EeN1EzWQ77NRnk5wi4X/gmDmtev7wqQ2h
         uowWVefHv8C7MEwlMiweFjnL6EQZtZMaMIItqtdbh3F+JzAUEqGrbsj/za7XqEbM2GyW
         yOM/KEnkvU1U3RgxJnD9MAE1hX8mPUHkgTGB8SIHJ0F4qqLsotTvI4SUsZpEgYrpgQc5
         XHQatpriec/T2asm1HFGesUfP9N+QCNOwMDAj6ZKYN5arKnITk8aQW/9Lap0YdmPoNym
         rATg==
X-Gm-Message-State: AOAM530l9AF5KgCbV7BPj76suvFA2H9LJ7baHbvM6fbj8y2mt4zytVph
        l3LhzrV6rG6+JVdEfOwKmF/Nidrud4mGH9Uz/tvQ/HKWAMQ=
X-Google-Smtp-Source: ABdhPJyCpEqrhjU3BK4aVMV1xAEjMe+5qNUfMg5h/p4QjvruRD9cS65nRLWzSZyt6WZoxnwII3FS9NPiiGAaj8tRt4w=
X-Received: by 2002:aca:db03:: with SMTP id s3mr4403840oig.48.1611344526205;
 Fri, 22 Jan 2021 11:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20210108092345.2178-1-charvi077@gmail.com> <20210119074102.21598-4-charvi077@gmail.com>
 <xmqqmtx3dq83.fsf@gitster.c.googlers.com> <CAPSFM5cxTrvAq6j3yhzidWdr8P8-sYmd1-9tmsK4iXMKrC7TNA@mail.gmail.com>
 <CAP8UFD3PRaiCiSfSMaX0FDrEcOz2xv3992meum7qnKve1rK6nw@mail.gmail.com> <xmqqwnw6au1d.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwnw6au1d.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sat, 23 Jan 2021 01:11:54 +0530
Message-ID: <CAPSFM5fUnVz7wuMJCULDGOWCzk=cxamqmXFYuCkF0m9rWTYELQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] rebase -i: comment out squash!/fixup! subjects
 from squash message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Jan 2021 at 02:26, Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> Oops, I think Phillip and Christian also pointed in the last revision
> >> to look for alternatives to make it easy. I mistook that point and
> >> forgot to look at it.
> >
> > Yes, please take a look at find_commit_subject() in "commit.c".
>
> Yeah, it uses pretty.c::skip_blank_lines(), which is easy to use.
> so something like a loop that calls skip_blank_lines() to see if it
> returns a differnt result (which means the argument we fed it was at
> the beginning of a blank line, which is what this helper wants to
> return), and otherwise we advance by one line with strchrnul() and
> retry, perhaps.
>
>     while (*body) {
>         char *next = skip_blank_lines(body);
>         if (next != body)
>             break; /* found a blank line */
>         body = strchrnul(body, '\n');
>         if (*body)
>             body++;
>     }
>     /* body has the answer */

Thanks for all the pointers. I took time in looking into it, but now I got more
cleared its actually looks for all the spaces in complete line which
is considered
as a blank line and above function explains it more clearly. I will
update the "subject
length" function as the above way and send in the next revision.

Thanks and Regards,
Charvi
